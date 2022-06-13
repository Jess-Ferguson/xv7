#ifndef _XV6FS_H
#define _XV6FS_H

#include <kernel/defs.h>
#include <kernel/sleeplock.h>

#define ROOTINO  1   // root i-number
#define XV6_BLOCK_SIZE 1024  // block size

// Disk layout:
// [ boot block | super block | log | inode blocks |
//                                          free bit map | data blocks]
//
// mkfs computes the super block and builds an initial file system. The
// super block describes the disk layout:
struct xv6_superblock {
	uint magic;
	uint size;			// Size of file system image (blocks)
	uint nblocks;		// Number of data blocks
	uint ninodes;		// Number of inodes.
	uint nlog;			// Number of log blocks
	uint logstart;		// Block number of first log block
	uint inodestart;	// Block number of first inode block
	uint bmapstart;		// Block number of first free map block
};

#define XV6_MAGIC 0x10203040

#define NDIRECT 12
#define NINDIRECT (BSIZE / sizeof(uint))
#define MAXFILE (NDIRECT + NINDIRECT)

// On-disk inode structure
struct xv6_dinode {
	short type;					// File type
	short major;				// Major device number (T_DEVICE only)
	short minor;				// Minor device number (T_DEVICE only)
	short nlink;				// Number of links to inode in file system
	uint size;					// Size of file (bytes)
	uint addrs[NDIRECT + 1];	// Data block addresses
};

// in-memory copy of an xv6 inode
struct xv6_inode {
	uint dev;				// Device number
	uint inum;				// Inode number
	int ref;				// Reference count
	struct sleeplock lock;	// protects everything below here
	short type;				// copy of disk inode
	short major;
	short minor;
	short nlink;
	uint size;
	uint addrs[NDIRECT+1];
};

// Inodes per block.
#define XV6_IPB           (XV6_BLOCK_SIZE / sizeof(struct xv6_dinode))

// Block containing inode i
#define XV6_IBLOCK(i, sb)     ((i) / XV6_IPB + sb.xv6_superblock.inodestart)

// Bitmap bits per block
#define XV6_BPB           (XV6_BLOCK_SIZE * 8)

// Block of free map containing bit for block b
#define XV6_BBLOCK(b, sb) ((b) / XV6_BPB + sb.xv6_superblock.bmapstart)

// Directory is a file containing a sequence of dirent structures.
#define XV6_DIRSIZ 14

#endif