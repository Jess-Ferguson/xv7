#include <kernel/buf.h>
#include <kernel/defs.h>
#include <kernel/ext2.h>
#include <kernel/vfs.h>
#include <kernel/types.h>
#include <kernel/sleeplock.h>
#include <kernel/stat.h>

extern struct superblock sb;
extern struct itable itable;

/* VFS Operations */

int ext2_initialise_fs();
int ext2_mount(struct inode * fs_root_inode, struct inode * target_inode);
int ext2_unmount(struct inode * fs_root_inode);
struct inode * ext2_get_root(int minor, int major);
struct inode * ext2_iget(uint dev, uint inum);
int ext2_read_super(int dev, struct superblock * super);
struct inode * ext2_ialloc(uint dev, short type);
void ext2_ifree(struct inode * index_node);
uint ext2_balloc(uint dev);
void ext2_bzero(int dev, int block_num);
void ext2_bfree(int dev, uint block_num);
void ext2_brelease(struct buf * buffer);
void ext2_bwrite(struct buf * buffer);
struct buf * ext2_bread(uint dev, uint block_num);
int ext2_name_cmp(const char * source, const char * dest);

/* Inode Operations */

struct inode * ext2_dir_lookup(struct inode * dp, char * name, uint * off);
void ext2_iupdate(struct inode * ip);
void ext2_itrunc(struct inode * ip);
void ext2_cleanup(struct inode * ip);
uint ext2_bmap(struct inode * ip, uint bn);
void ext2_ilock(struct inode * ip);
void ext2_iunlock(struct inode * ip);
struct inode * ext2_idup(struct inode * ip);
void ext2_iput(struct inode * ip);
void ext2_iunlockput(struct inode * ip);
void ext2_stati(struct inode * ip, struct stat * st);
int ext2_readi(struct inode * ip, int user_dst, uint64 dst, uint off, uint n);
int ext2_writei(struct inode * ip, int user_src, uint64 src, uint off, uint n);
int ext2_dir_link(struct inode * dp, char * name, uint inum);
int ext2_unlink(struct inode * dp, uint off);
int ext2_is_dir_empty(struct inode * dp);

struct vfs_operations ext2_vfs_ops = {
	.initialise_fs = &ext2_initialise_fs,
	.mount = &ext2_mount,
	.unmount = &ext2_unmount,
	.get_root = &ext2_get_root,
	.iget = &ext2_iget,
	.read_super = &ext2_read_super,
	.ialloc = &ext2_ialloc,
	.ifree = &ext2_ifree,
	.balloc = &ext2_balloc,
	.bzero = &ext2_bzero,
	.bfree = &ext2_bfree,
	.brelease = &brelease,
	.bwrite = &bwrite,
	.bread = &bread,
	.name_cmp = &ext2_name_cmp,
};

struct inode_operations ext2_inode_ops = {
	.dir_lookup = &ext2_dir_lookup,
	.iupdate = &ext2_iupdate,
	.itrunc = &ext2_itrunc,
	.cleanup = &ext2_cleanup,
	.bmap = &ext2_bmap,
	.iput = &ext2_iput,
	.ilock = &ext2_ilock,
	.iunlock = &ext2_iunlock,
	.iunlockput = &ext2_iunlockput,
	.idup = &ext2_idup,
	.stati = &ext2_stati,
	.readi = &ext2_readi,
	.writei = &ext2_writei,
	.dir_link = &ext2_dir_link,
	.unlink = &ext2_unlink,
	.is_dir_empty = &ext2_is_dir_empty,
};

/* ext2 vfs operations */

int ext2_initialise_fs()
{
	panic("ext2_initialise_fs() not implemented!");
}

int ext2_mount(struct inode * fs_root_inode, struct inode * target_inode)
{
	panic("ext2_mount() not implemented!");
}

int ext2_unmount(struct inode * fs_root_inode)
{
	panic("ext2_unmount() not implemented!");
}

struct inode * ext2_get_root(int minor, int major)
{
	panic("ext2_get_root() not implemented!");
}

int ext2_read_super(int dev, struct superblock * super)
{
	struct buf * buffer;

	buffer = ext2_vfs_ops.bread(dev, 1);

	if(((struct ext2_superblock *) buffer->data)->magic_number != EXT2_MAGIC) {
		ext2_vfs_ops.brelease(buffer);

		return -1;
	}

	kmemmove(&(super->ext2_superblock), buffer->data, sizeof(struct ext2_superblock));

	super->magic = EXT2_MAGIC;
	super->block_size = EXT2_BLOCK_SIZE;
	super->device = dev;
	super->size = super->ext2_superblock.block_count;
	super->vfs_ops = &ext2_vfs_ops;

	ext2_vfs_ops.brelease(buffer);

	return EXT2_MAGIC;
}

struct inode * ext2_ialloc(uint dev, short type)
{
	panic("ext2_ialloc() not implemented!");
}

struct inode * ext2_iget(uint dev, uint inum)
{
	panic("ext2_iget() not implemented!");
}

void ext2_ifree(struct inode * index_node)
{
	panic("ext2_ifree() not implemented!");
}

uint ext2_balloc(uint dev)
{
	panic("ext2_balloc() not implemented!");
}

void ext2_bzero(int dev, int block_num)
{
	panic("ext2_bzero() not implemented!");
}

void ext2_bfree(int dev, uint block_num)
{
	panic("ext2_bfree() not implemented!");
}

void ext2_brelease(struct buf * buffer)
{
	panic("ext2_brelease() not implemented!");
}

void ext2_bwrite(struct buf * buffer)
{
	panic("ext2_bwrite() not implemented!");
}

struct buf * ext2_bread(uint dev, uint block_num)
{
	panic("ext2_bread() not implemented!");
}

int ext2_name_cmp(const char * source, const char * target)
{
	panic("ext2_name_cmp() not implemented!");
}

/* ext2 inode operations */

struct inode* ext2_dir_lookup(struct inode * dp, char * name, uint * off)
{
	panic("ext2_dir_lookup() not implemented!");
}

void ext2_iupdate(struct inode * ip)
{
	panic("ext2_iupdate() not implemented!");
}

void ext2_itrunc(struct inode * ip)
{
	panic("ext2_itrunc() not implemented!");
}

void ext2_cleanup(struct inode * ip)
{
	panic("ext2_cleanup() not implemented!");
}

uint ext2_bmap(struct inode * ip, uint bn)
{
	panic("ext2_bmap() not implemented!");
}

void ext2_ilock(struct inode * ip)
{
	panic("ext2_ilock() not implemented!");
}

void ext2_iunlock(struct inode * ip)
{
	panic("ext2_iunlock() not implemented!");
}

void ext2_stati(struct inode * ip, struct stat * st)
{
	panic("ext2_stati() not implemented!");
}

int ext2_readi(struct inode * ip, int user_dst, uint64 dst, uint off, uint n)
{
	panic("ext2_readi() not implemented!");
}

int ext2_writei(struct inode * ip, int user_src, uint64 src, uint off, uint n)
{
	panic("ext2_writei() not implemented!");
}

int ext2_dir_link(struct inode * dp, char * name, uint inum)
{
	panic("ext2_dir_link() not implemented!");
}

int ext2_unlink(struct inode * dp, uint off)
{
	panic("ext2_unlink() not implemented!");
}

int ext2_is_dir_empty(struct inode *dp)
{
	panic("ext2_is_dir_empty() not implemented!");
}

struct inode * ext2_idup(struct inode * ip)
{
	panic("ext2_idup() not implemented!");
}

void ext2_iput(struct inode * ip)
{
	panic("ext2_iput() not implemented!");
}

void ext2_iunlockput(struct inode * ip)
{
	panic("ext2_iunlockput() not implemented!");
}