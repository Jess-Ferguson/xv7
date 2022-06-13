// On-disk file system format.
// Both the kernel and user programs use this header file.

#ifndef _VFS_H
#define _VFS_H

#include <kernel/param.h>
#include <kernel/sleeplock.h>
#include <kernel/xv6fs.h>
#include <kernel/ext2.h>

#define NDIRECT 12
#define NINDIRECT (BSIZE / sizeof(uint))
#define MAXFILE (NDIRECT + NINDIRECT)

// On-disk inode structure
struct dinode {
	short type;           // File type
	short major;          // Major device number (T_DEVICE only)
	short minor;          // Minor device number (T_DEVICE only)
	short nlink;          // Number of links to inode in file system
	uint size;            // Size of file (bytes)
	uint addrs[NDIRECT+1];   // Data block addresses
};

#define major(dev)  ((dev) >> 16 & 0xFFFF)
#define minor(dev)  ((dev) & 0xFFFF)
#define mkdev(m,n)  ((uint)((m)<<16| (n)))

struct inode_operations {
	struct inode * (*dir_lookup)(struct inode * dp, char * name, uint * off);
	void (*iupdate)(struct inode * ip);
	void (*itrunc)(struct inode * ip);
	uint (*bmap)(struct inode * ip, uint bn);
	void (*ilock)(struct inode * ip);
	void (*iput)(struct inode * ip);
	void (*iunlock)(struct inode * ip);
	void (*iunlockput)(struct inode * ip);
	struct inode * (*idup)(struct inode *ip);
	void (*stati)(struct inode * ip, struct stat * st);
	int (*readi)(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
	int (*writei)(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
	int (*dir_link)(struct inode * dp, char * name, uint inum, uint type);
};

#define NDIRECT 12
#define NINDIRECT (BSIZE / sizeof(uint))
#define MAXFILE (NDIRECT + NINDIRECT)

#define INODE_FREE 0
#define INODE_RESERVED 1

#define I_BUSY 0x1
#define I_VALID 0x2

/* In-memory filesystem-agnostic inode structure */

struct inode {
	uint dev;
	uint inum;
	int ref;
	int flags;
	/* Set of function pointers specifying inode operations */
	struct inode_operations * inode_ops;
	/* Set of function pointers specifying file system operations */
	struct vfs_operations * vfs_ops; 
	/* Set of different possible file system inodes */
	union {
		struct xv6_inode * xv6_inode; /* This should be modified to also use a pointer */
		struct ext2_inode_mem * ext2_inode;
	}; 
	short type;
	short major;
	short minor;
	short nlink;
	uint size;
};

 /* Attempt to read the super block, return -1 on failure */

struct vfs_operations {
	struct inode * (*get_root)(unsigned int dev);
	int (*read_super)(int dev, struct superblock * super);
	struct inode * (*ialloc)(uint dev, short type);
	uint (*balloc)(uint dev);
	void (*bzero)(int dev, uint block_num);
	void (*bfree)(int dev, uint block_num);
	void (*brelease)(struct buf * buffer);
	void (*bwrite)(struct buf * buffer);
	struct buf * (*bread)(uint dev, uint block_num);
	int (*name_cmp)(const char * source, const char * target);
};

struct superblock {
	short device;						/* Device number associated with the superblock */
	uint block_size;					/* Size of each block */
	struct vfs_operations * vfs_ops;	/* Function pointers containing superblock operations for this filesystem */
	uint magic;        					/* File system magic number */
	uint size; 	        				/* Size of file system image (blocks) */
	union {
		struct xv6_superblock xv6_superblock;
		struct ext2_superblock_mem ext2_in_mem_super;
	};									
};

struct vfs {
	const char * name;
	struct vfs_operations * vfs_ops;
	struct inode_operations * inode_ops;
	struct superblock superblock;
};

struct itable {
	struct spinlock lock;
	struct inode inode[NINODE];
};

// Directory is a file containing a sequence of dirent structures.
#define DIRSIZ 14

#define min(a, b) ((a) < (b) ? (a) : (b))

struct dirent {
	ushort inum;
	char name[DIRSIZ];
};

#endif