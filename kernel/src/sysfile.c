//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include <kernel/types.h>
#include <kernel/riscv.h>
#include <kernel/defs.h>
#include <kernel/param.h>
#include <kernel/stat.h>
#include <kernel/spinlock.h>
#include <kernel/proc.h>
#include <kernel/vfs.h>
#include <kernel/sleeplock.h>
#include <kernel/file.h>
#include <kernel/fcntl.h>

extern struct vfs * root_fs;

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int * pfd, struct file ** pf)
{
	int fd;
	struct file * f;

	if(argint(n, &fd) < 0)
		return -1;

	if(fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == NULL)
		return -1;

	if(pfd)
		*pfd = fd;

	if(pf)
		*pf = f;

	return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f)
{
	int fd;
	struct proc * p = myproc();

	for(fd = 0; fd < NOFILE; fd++) {
		if(p->ofile[fd] == 0) {
			p->ofile[fd] = f;

			return fd;
		}
	}

	return -1;
}

uint64 sys_dup(void)
{
	struct file * f;
	int fd;

	if(argfd(0, 0, &f) < 0)
		return -1;

	if((fd = fdalloc(f)) < 0)
		return -1;

	filedup(f);

	return fd;
}

uint64 sys_read(void)
{
	struct file * f;
	int n;
	uint64 p;

	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
		return -1;

	return fileread(f, p, n);
}

uint64 sys_write(void)
{
	struct file * f;
	int n;
	uint64 p;

	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
		return -1;

	return filewrite(f, p, n);
}

uint64 sys_close(void)
{
	int fd;
	struct file * f;

	if(argfd(0, &fd, &f) < 0)
		return -1;

	myproc()->ofile[fd] = 0;
	fileclose(f);

	return 0;
}

uint64 sys_fstat(void)
{
	struct file * f;
	uint64 st; // user pointer to struct stat

	if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
		return -1;

	return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
uint64 sys_link(void)
{
	char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
	struct inode * dp, * ip;

	if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
		return -1;

	begin_op();

	if((ip = namei(old)) == NULL) {
		end_op();
		
		return -1;
	}

	ip->inode_ops->ilock(ip);

	if(ip->type == T_DIR) {
		ip->inode_ops->iunlockput(ip);
		end_op();

		return -1;
	}

	ip->nlink++;

	ip->inode_ops->iupdate(ip);
	ip->inode_ops->iunlock(ip);

	if((dp = nameiparent(new, name)) == NULL)
		goto bad;

	ip->inode_ops->ilock(dp);

	if(dp->dev != ip->dev || ip->inode_ops->dir_link(dp, name, ip->inum, ip->type) < 0) {
		ip->inode_ops->iunlockput(dp);
		goto bad;
	}

	ip->inode_ops->iunlockput(dp);
	ip->inode_ops->iput(ip);

	end_op();

	return 0;

bad:
	ip->inode_ops->ilock(ip);

	ip->nlink--;

	ip->inode_ops->iupdate(ip);
	ip->inode_ops->iunlockput(ip);
	end_op();

	return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int isdirempty(struct inode * dp)
{
	int off;
	struct dirent de;

	for(off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
		if(dp->inode_ops->readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
			panic("isdirempty: readi");
		}

		if(de.inum != 0) {
			return 0;
		}
	}

	return 1;
}

uint64 sys_unlink(void)
{
	struct inode * ip, * dp;
	struct dirent de;
	char name[DIRSIZ], path[MAXPATH];
	uint off;

	if(argstr(0, path, MAXPATH) < 0)
		return -1;

	begin_op();

	if((dp = nameiparent(path, name)) == NULL) {
		end_op();

		return -1;
	}

	dp->inode_ops->ilock(dp);

	// Cannot unlink "." or "..".
	if(dp->vfs_ops->name_cmp(name, ".") == 0 || dp->vfs_ops->name_cmp(name, "..") == 0)
		goto bad;

	if((ip = dp->inode_ops->dir_lookup(dp, name, &off)) == NULL)
		goto bad;

	ip->inode_ops->ilock(ip);

	if(ip->nlink < 1)
		panic("unlink: nlink < 1");

	if(ip->type == T_DIR && !isdirempty(ip)) {
		ip->inode_ops->iunlockput(ip);
		goto bad;
	}

	kmemset(&de, 0, sizeof(de));

	if(dp->inode_ops->writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
		panic("unlink: writei");

	if(ip->type == T_DIR) {
		dp->nlink--;
		dp->inode_ops->iupdate(dp);
	}

	dp->inode_ops->iunlockput(dp);

	ip->nlink--;

	ip->inode_ops->iupdate(ip);
	ip->inode_ops->iunlockput(ip);

	end_op();

	return 0;

bad:
	dp->inode_ops->iunlockput(dp);
	end_op();

	return -1;
}

static struct inode * create(char * path, short type, short major, short minor)
{
	struct inode * ip, * dp;
	char name[DIRSIZ];

	if((dp = nameiparent(path, name)) == NULL)
		return NULL;

	dp->inode_ops->ilock(dp);

	if((ip = dp->inode_ops->dir_lookup(dp, name, 0)) != NULL) {
		dp->inode_ops->iunlockput(dp);
		ip->inode_ops->ilock(ip);

		if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
			return ip;

		ip->inode_ops->iunlockput(ip);

		return NULL;
	}

	if((ip = dp->vfs_ops->ialloc(dp->dev, type)) == NULL) // This should really use the major and minor numbers to reference a list of devices and find the corresponding superblock
		panic("create: ialloc");

	ip->inode_ops->ilock(ip);

	ip->major = major;
	ip->minor = minor;
	ip->nlink = 1;

	ip->inode_ops->iupdate(ip);

	if(type == T_DIR) {  // Create . and .. entries.
		dp->nlink++;  // for ".."

		dp->inode_ops->iupdate(dp);
		// No ip->nlink++ for ".": avoid cyclic ref count.
		if(ip->inode_ops->dir_link(ip, ".", ip->inum, ip->type) < 0 || ip->inode_ops->dir_link(ip, "..", dp->inum, dp->type) < 0)
			panic("create dots");
	}

	if(dp->inode_ops->dir_link(dp, name, ip->inum, ip->type) < 0)
		panic("create: dir_link()");

	dp->inode_ops->iunlockput(dp);

	return ip;
}

uint64 sys_open(void)
{
	char path[MAXPATH];
	int fd, omode;
	struct file * f;
	struct inode * ip;
	int n;

	if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
		return -1;
	begin_op();

	if(omode & O_CREATE) {
		if((ip = create(path, T_FILE, 0, 0)) == NULL) {
			end_op();

			return -1;
		}
	} else {
		if((ip = namei(path)) == NULL) {
			end_op();

			return -1;
		}

		ip->inode_ops->ilock(ip);

		if(ip->type == T_DIR && omode != O_RDONLY) {
			ip->inode_ops->iunlockput(ip);
			end_op();

			return -1;
		}
	}

	if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)) {
		ip->inode_ops->iunlockput(ip);
		end_op();

		return -1;
	}

	if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0) {
		if(f) {
			fileclose(f);
		}

		ip->inode_ops->iunlockput(ip);
		end_op();

		return -1;
	}

	if(ip->type == T_DEVICE) {
		f->type = FD_DEVICE;
		f->major = ip->major;
	} else {
		f->type = FD_INODE;
		f->off = 0;
	}

	f->ip = ip;
	f->readable = !(omode & O_WRONLY);
	f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

	if((omode & O_TRUNC) && ip->type == T_FILE) {
		ip->inode_ops->itrunc(ip);
	}

	ip->inode_ops->iunlock(ip);
	end_op();

	return fd;
}

uint64 sys_mkdir(void)
{
	char path[MAXPATH];
	struct inode * ip;

	begin_op();

	if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == NULL) {
		end_op();

		return -1;
	}

	ip->inode_ops->iunlockput(ip);
	end_op();

	return 0;
}

uint64 sys_mknod(void)
{
	struct inode * ip;
	char path[MAXPATH];
	int major, minor;

	begin_op();

	if((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0 || (ip = create(path, T_DEVICE, major, minor)) == NULL) {
		end_op();

		return -1;
	}

	ip->inode_ops->iunlockput(ip);
	end_op();

	return 0;
}

uint64 sys_chdir(void)
{
	char path[MAXPATH];
	struct inode * ip;
	struct proc * p = myproc();
	
	begin_op();

	if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == NULL) {
		end_op();

		return -1;
	}

	ip->inode_ops->ilock(ip);

	if(ip->type != T_DIR) {
		ip->inode_ops->iunlockput(ip);
		end_op();

		return -1;
	}

	ip->inode_ops->iunlock(ip);
	ip->inode_ops->iput(p->cwd);
	end_op();

	p->cwd = ip;

	return 0;
}

uint64 sys_exec(void)
{
	char path[MAXPATH], * argv[MAXARG];
	int i;
	uint64 uargv, uarg;

	if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0) {
		return -1;
	}

	kmemset(argv, 0, sizeof(argv));

	for(i = 0;; i++) {
		if(i >= NELEM(argv)) {
			goto bad;
		}

		if(fetchaddr(uargv + sizeof(uint64) * i, (uint64 *) &uarg) < 0) {
			goto bad;
		}

		if(uarg == 0) {
			argv[i] = 0;
			break;
		}

		argv[i] = kalloc();

		if(argv[i] == NULL) {
			goto bad;
		}

		if(fetchstr(uarg, argv[i], PGSIZE) < 0) {
			goto bad;
		}
	}

	int ret = exec(path, argv);

	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
		kfree(argv[i]);
	}

	return ret;

 bad:
	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
		kfree(argv[i]);
	}

	return -1;
}

uint64 sys_pipe(void)
{
	uint64 fdarray; // user pointer to array of two integers
	struct file * rf, * wf;
	int fd0, fd1;
	struct proc * p = myproc();

	if(argaddr(0, &fdarray) < 0)
		return -1;

	if(pipealloc(&rf, &wf) < 0)
		return -1;

	fd0 = -1;

	if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
		if(fd0 >= 0) {
			p->ofile[fd0] = 0;
		}

		fileclose(rf);
		fileclose(wf);
		
		return -1;
	}

	if(copyout(p->pagetable, fdarray, (char *) &fd0, sizeof(fd0)) < 0 || copyout(p->pagetable, fdarray + sizeof(fd0), (char *) &fd1, sizeof(fd1)) < 0) {
		p->ofile[fd0] = 0;
		p->ofile[fd1] = 0;

		fileclose(rf);
		fileclose(wf);

		return -1;
	}

	return 0;
}
