// File system implementation.  Five layers:
//   + Blocks: allocator for raw disk blocks.
//   + Log: crash recovery for multi-step updates.
//   + Files: inode allocator, reading, writing, metadata.
//   + Directories: inode with special contents (list of other inodes!)
//   + Names: paths like /usr/rtm/xv6/fs.c for convenient naming.
//
// This file contains the low-level file system manipulation
// routines.  The (higher-level) system call implementations
// are in sysfile.c.

#include <kernel/types.h>
#include <kernel/riscv.h>
#include <kernel/defs.h>
#include <kernel/param.h>
#include <kernel/stat.h>
#include <kernel/spinlock.h>
#include <kernel/proc.h>
#include <kernel/sleeplock.h>
#include <kernel/vfs.h>
#include <kernel/buf.h>
#include <kernel/file.h>
#include <kernel/xv6fs.h>
#include <kernel/ext2.h>

#define ARRAY_LEN(x) (sizeof(x) / sizeof(*(x)))

extern struct vfs_operations xv6_vfs_ops;
extern struct inode_operations xv6_inode_ops;

extern struct vfs_operations ext2_vfs_ops;
extern struct inode_operations ext2_inode_ops;

struct vfs * root_fs;
struct itable itable;

struct vfs vfs_list[] = {
	{
		.name = "xv6fs",
		.vfs_ops = &xv6_vfs_ops,
		.inode_ops = &xv6_inode_ops
	},
	{
		.name = "ext2",
		.vfs_ops = &ext2_vfs_ops,
		.inode_ops = &ext2_inode_ops
	},
};

// there should be one superblock per disk device, but we run with
// only one device
struct superblock sb; 

/* Attempt to read the superblock from the root device */
void root_init(int dev)
{
	int fs_type;
	struct superblock superblock;

	for(uint i = 0; i < ARRAY_LEN(vfs_list); i++) {
		if((fs_type = vfs_list[i].vfs_ops->read_super(dev, &superblock)) != -1) {
			switch(fs_type) {
				case XV6_MAGIC:
					root_fs = kalloc(); /* Allocate a 4KB block for the root_fs */
					kmemmove(root_fs, &vfs_list[0], sizeof(struct vfs));
					kmemmove(&root_fs->superblock, &superblock, sizeof(struct superblock));
					initlog(dev);
					
					kprintf("Loaded valid Xv6 file system as root device!\n");
					return;
				case EXT2_MAGIC:
					kprintf("Superblock matched EXT2!\n");
					panic("EXT2 not yet implemented!");
				default:
					panic("No implementation available for initialising FS type!");
			}
		}
	}

	panic("Unknown file system type!");
}

// Inodes.
//
// An inode describes a single unnamed file.
// The inode disk structure holds metadata: the file's type,
// its size, the number of links referring to it, and the
// list of blocks holding the file's content.
//
// The inodes are laid out sequentially on disk at
// sb.startinode. Each inode has a number, indicating its
// position on the disk.
//
// The kernel keeps a table of in-use inodes in memory
// to provide a place for synchronizing access
// to inodes used by multiple processes. The in-memory
// inodes include book-keeping information that is
// not stored on disk: ip->ref and ip->valid.
//
// An inode and its in-memory representation go through a
// sequence of states before they can be used by the
// rest of the file system code.
//
// * Allocation: an inode is allocated if its type (on disk)
//   is non-zero. ialloc() allocates, and iput() frees if
//   the reference and link counts have fallen to zero.
//
// * Referencing in table: an entry in the inode table
//   is free if ip->ref is zero. Otherwise ip->ref tracks
//   the number of in-memory pointers to the entry (open
//   files and current directories). iget() finds or
//   creates a table entry and increments its ref; iput()
//   decrements ref.
//
// * Valid: the information (type, size, &c) in an inode
//   table entry is only correct when ip->valid is 1.
//   ilock() reads the inode from
//   the disk and sets ip->valid, while iput() clears
//   ip->valid if ip->ref has fallen to zero.
//
// * Locked: file system code may only examine and modify
//   the information in an inode and its content if it
//   has first locked the inode.
//
// Thus a typical sequence is:
//   ip = iget(dev, inum)
//   ilock(ip)
//   ... examine and modify ip->xxx ...
//   iunlock(ip)
//   iput(ip)
//
// ilock() is separate from iget() so that system calls can
// get a long-term reference to an inode (as for an open file)
// and only lock it for short periods (e.g., in read()).
// The separation also helps avoid deadlock and races during
// pathname lookup. iget() increments ip->ref so that the inode
// stays in the table and pointers to it remain valid.
//
// Many internal file system functions expect the caller to
// have locked the inodes involved; this lets callers create
// multi-step atomic operations.
//
// The itable.lock spin-lock protects the allocation of itable
// entries. Since ip->ref indicates whether an entry is free,
// and ip->dev and ip->inum indicate which i-node an entry
// holds, one must hold itable.lock while using any of those fields.
//
// An ip->lock sleep-lock protects all ip-> fields other than ref,
// dev, and inum.  One must hold ip->lock in order to
// read or write that inode's ip->valid, ip->size, ip->type, &c.

void iinit()
{
	int i = 0;
	
	initlock(&itable.lock, "itable");
	for(i = 0; i < NINODE; i++) {
		initsleeplock(&itable.inode[i].lock, "inode");
	}
}

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.


// Paths

// Copy the next path element from path into name.
// Return a pointer to the element following the copied one.
// The returned path has no leading slashes,
// so the caller can check *path=='\0' to see if the name is the last one.
// If no name to remove, return 0.
//
// Examples:
//   skipelem("a/bb/c", name) = "bb/c", setting name = "a"
//   skipelem("///a//bb", name) = "bb", setting name = "a"
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char * skipelem(char * path, char * name)
{
	char *s;
	int len;

	while(*path == '/')
		path++;

	if(*path == 0)
		return 0;

	s = path;

	while(*path != '/' && *path != 0)
		path++;

	len = path - s;

	if(len >= DIRSIZ) {
		kmemmove(name, s, DIRSIZ);
	} else {
		kmemmove(name, s, len);
		name[len] = 0;
	}

	while(*path == '/')
		path++;

	return path;
}

struct inode * iget(uint dev, uint inum)
{
	struct inode * ip, * empty;

	acquire(&itable.lock);

	// Is the inode already in the table?
	empty = 0;

	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
		if(ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
			ip->ref++;
			release(&itable.lock);
			return ip;
		}

		if(empty == 0 && ip->ref == 0)    // Remember empty slot.
			empty = ip;
	}

	// Recycle an inode entry.
	if(empty == 0)
		panic("iget(): no inodes");

	ip = empty;
	ip->dev = dev;
	ip->inum = inum;
	ip->ref = 1;
	ip->valid = 0;
	release(&itable.lock);

	return ip;
}

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode * namex(char * path, int nameiparent, char * name)
{
	struct inode * ip, * next;

	if(*path == '/') {
		ip = iget(ROOTDEV, ROOTINO);
	} else {
		ip = root_fs->inode_ops->idup(myproc()->cwd); /* This needs to be generalised somehow to support multiple file systems simultaneously in the future */
	}

	while((path = skipelem(path, name)) != 0) {
		if(!ip->inode_ops) {
			if(root_fs) {
				ip->inode_ops = root_fs->inode_ops;
			} else {
				kprintf("Possibly fatal: inode_ops needed but no root_fs available\n");
				//panic("inode_ops needed and root_fs not initialised!\n");
			}
		}

		ip->inode_ops->ilock(ip);

		if(ip->type != T_DIR) {
			ip->inode_ops->iunlockput(ip);
			return 0;
		}

		if(nameiparent && *path == '\0') {
			// Stop one level early.
			ip->inode_ops->iunlock(ip);
			return ip;
		}

		if((next = ip->inode_ops->dir_lookup(ip, name, 0)) == 0) {
			ip->inode_ops->iunlockput(ip);
			return 0;
		}

		next->inode_ops = ip->inode_ops;
		ip->inode_ops->iunlockput(ip);
		ip = next;
	}

	if(nameiparent) {
		ip->inode_ops->iput(ip);
		return 0;
	}

	//kprintf("namex() ip: %p\n", ip);
	//kprintf("namex() ip->inode_ops: %p\n", ip->inode_ops);

	return ip;
}

struct inode * namei(char *path)
{
	char name[DIRSIZ];
	return namex(path, 0, name);
}

struct inode * nameiparent(char *path, char *name)
{
	return namex(path, 1, name);
}
