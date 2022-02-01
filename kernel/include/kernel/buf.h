#ifndef _BUF_H
#define _BUF_H

#include <kernel/defs.h>
#include <kernel/types.h>
#include <kernel/sleeplock.h>

struct buf {
	int valid;   // has data been read from disk?
	int disk;    // does disk "own" buf?
	uint dev;	/* Logical device number */
	uint blockno; /* Block number within device file system */
	struct sleeplock lock;
	uint refcnt; 
	struct buf *prev; // LRU cache list
	struct buf *next;
	uchar data[BSIZE];
};

#endif