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
	void (*cleanup)(struct inode * ip);
	void (*ilock)(struct inode * ip);
	void (*iput)(struct inode * ip);
	void (*iunlock)(struct inode * ip);
	void (*iunlockput)(struct inode * ip);
	struct inode * (*idup)(struct inode *ip);
	void (*stati)(struct inode * ip, struct stat * st);
	int (*readi)(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
	int (*writei)(struct inode * ip, int user_src, uint64 src, uint off, uint n);
	int (*dir_link)(struct inode * dp, char * name, uint inum);
	int (*unlink)(struct inode * dp, uint off);
	int (*is_dir_empty)(struct inode * dp);
};

#define NDIRECT 12
#define NINDIRECT (BSIZE / sizeof(uint))
#define MAXFILE (NDIRECT + NINDIRECT)

// in-memory copy of an inode
struct inode {
	uint dev;                     // Minor Device number
	uint inum;                    // Inode number
	int ref;                      // Reference count
	int flags;                    // I_BUSY, I_VALID
	struct inode_operations * inode_ops; // The specific inode operations
	struct sleeplock lock; // protects everything below here
	union {
		struct xv6_inode xv6_inode;
	};               // File System specific informations

	int valid;
	short type;           // File type
	short major;          // Major device number (T_DEV only)
	short minor;          // Minor device number (T_DEV only)
	short nlink;          // Number of links to inode in file system
	uint size;            // Size of file (bytes)
	uint addrs[NDIRECT+1];
};

struct vfs_operations {
	int (*initialise_fs)(void);
	int (*mount)(struct inode * fs_root_inode, struct inode * target_inode); /* Mount fs_root_inode to target_inode */ 
	int (*unmount)(struct inode * fs_root_inode);
	struct inode * (*iget)(uint dev, uint inum);
	struct inode * (*get_root)(int minor, int major);
	int (*read_super)(int dev, struct superblock * super); /* Attempt to read the super block, return -1 on failure */
	struct inode * (*ialloc)(uint dev, short type);
	void (*ifree)(struct inode *);
	uint (*balloc)(uint dev);
	void (*bzero)(int dev, int block_num);
	void (*bfree)(int dev, uint block_num);
	void (*brelease)(struct buf * buffer);
	void (*bwrite)(struct buf * buffer);
	struct buf * (*bread)(uint dev, uint block_num);
	int (*name_cmp)(const char * source, const char * target);
};

struct superblock {
	short device;						/* Device number associated with the superblock */
	uint block_size;					/* Size of each block */
	struct vfs_operations * vfs_ops;	/* Function pointers containing superblock operations for this fs */ 
	uint magic;        					/* File system magic number */
	uint flags;
	uint size; 	        				/* Size of file system image (blocks) */
	union {
		struct xv6_superblock xv6_superblock;
		struct ext2_superblock ext2_superblock;
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