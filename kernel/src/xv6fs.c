#include <kernel/buf.h>
#include <kernel/defs.h>
#include <kernel/xv6fs.h>
#include <kernel/vfs.h>
#include <kernel/types.h>
#include <kernel/sleeplock.h>
#include <kernel/stat.h>

extern struct superblock sb;
extern struct itable itable;

/* VFS Operations */

int xv6_initialise_fs();
int xv6_mount(struct inode * fs_root_inode, struct inode * target_inode);
int xv6_unmount(struct inode * fs_root_inode);
struct inode * xv6_get_root(int minor, int major);
struct inode * xv6_iget(uint dev, uint inum);
int xv6_read_super(int dev, struct superblock * super);
struct inode * xv6_ialloc(uint dev, short type);
void xv6_ifree(struct inode * index_node);
uint xv6_balloc(uint dev);
void xv6_bzero(int dev, int block_num);
void xv6_bfree(int dev, uint block_num);
int xv6_name_cmp(const char * source, const char * dest);

/* Inode Operations */

struct inode * xv6_dir_lookup(struct inode * dp, char * name, uint * off);
void xv6_iupdate(struct inode * ip);
void xv6_itrunc(struct inode * ip);
void xv6_cleanup(struct inode * ip);
uint xv6_bmap(struct inode * ip, uint bn);
void xv6_ilock(struct inode * ip);
void xv6_iunlock(struct inode * ip);
struct inode * xv6_idup(struct inode * ip);
void xv6_iput(struct inode * ip);
void xv6_iunlockput(struct inode * ip);
void xv6_stati(struct inode * ip, struct stat * st);
int xv6_readi(struct inode * ip, int user_dst, uint64 dst, uint off, uint n);
int xv6_writei(struct inode * ip, int user_src, uint64 src, uint off, uint n);
int xv6_dir_link(struct inode * dp, char * name, uint inum);
int xv6_unlink(struct inode * dp, uint off);
int xv6_is_dir_empty(struct inode * dp);

struct vfs_operations xv6_vfs_ops = {
	.initialise_fs = &xv6_initialise_fs,
	.mount = &xv6_mount,
	.unmount = &xv6_unmount,
	.get_root = &xv6_get_root,
	.iget = &xv6_iget,
	.read_super = &xv6_read_super,
	.ialloc = &xv6_ialloc,
	.ifree = &xv6_ifree,
	.balloc = &xv6_balloc,
	.bzero = &xv6_bzero,
	.bfree = &xv6_bfree,
	.brelease = &brelease,
	.bwrite = &bwrite,
	.bread = &bread,
	.name_cmp = &xv6_name_cmp
};

struct inode_operations xv6_inode_ops = {
	.dir_lookup = &xv6_dir_lookup,
	.iupdate = &xv6_iupdate,
	.itrunc = &xv6_itrunc,
	.cleanup = &xv6_cleanup,
	.bmap = &xv6_bmap,
	.iput = &xv6_iput,
	.ilock = &xv6_ilock,
	.iunlock = &xv6_iunlock,
	.iunlockput = &xv6_iunlockput,
	.idup = &xv6_idup,
	.stati = &xv6_stati,
	.readi = &xv6_readi,
	.writei = &xv6_writei,
	.dir_link = &xv6_dir_link,
	.unlink = &xv6_unlink,
	.is_dir_empty = &xv6_is_dir_empty,
};

/* xv6 vfs operations */

int xv6_initialise_fs()
{
	panic("xv6_initialise_fs() not implemented!");
}

int xv6_mount(struct inode * fs_root_inode, struct inode * target_inode)
{
	panic("xv6_mount() not implemented!");
}

int xv6_unmount(struct inode * fs_root_inode)
{
	panic("xv6_unmount() not implemented!");
}

struct inode * xv6_get_root(int minor, int major)
{
	panic("xv6_get_root() not implemented!");
}

int xv6_read_super(int dev, struct superblock * superblock)
{
	struct buf * buffer;

	buffer = xv6_vfs_ops.bread(dev, 1);

	if(((struct xv6_superblock *) buffer->data)->magic != XV6_MAGIC) {
		xv6_vfs_ops.brelease(buffer);

		return -1;
	}

	kmemmove(&(superblock->xv6_superblock), buffer->data, sizeof(struct xv6_superblock));

	superblock->magic = XV6_MAGIC;
	superblock->block_size = XV6_BLOCK_SIZE;
	superblock->device = dev;
	superblock->size = superblock->xv6_superblock.size;
	superblock->vfs_ops = &xv6_vfs_ops;

	kmemmove(&sb, superblock, sizeof(struct superblock));
	kmemmove(&(sb.xv6_superblock), &superblock->xv6_superblock, sizeof(struct xv6_superblock));

	xv6_vfs_ops.brelease(buffer);

	return XV6_MAGIC;
}

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.

struct inode * xv6_iget(uint dev, uint inum)
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
		panic("xv6_iget(): no inodes");

	ip = empty;
	ip->dev = dev;
	ip->inum = inum;
	ip->ref = 1;
	ip->valid = 0;
	ip->inode_ops = &xv6_inode_ops;
	
	release(&itable.lock);

	return ip;
}

// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.

struct inode * xv6_ialloc(uint dev, short type)
{
	int inum;
	struct buf * bp;
	struct xv6_dinode * dip;

	for(inum = 1; inum < sb.xv6_superblock.ninodes; inum++) {
		bp = xv6_vfs_ops.bread(dev, XV6_IBLOCK(inum, sb));
		dip = (struct xv6_dinode *)bp->data + inum % XV6_IPB;

		if(dip->type == 0) {	// a free inode
			kmemset(dip, 0, sizeof(*dip));

			dip->type = type;

			log_write(bp);	 // mark it allocated on the disk
			xv6_vfs_ops.brelease(bp);

			return xv6_vfs_ops.iget(dev, inum);
		}

		xv6_vfs_ops.brelease(bp);
	}

	panic("ialloc: no inodes");
}

struct inode * xv6_idup(struct inode * ip)
{
	acquire(&itable.lock);
	ip->ref++;
	release(&itable.lock);
	return ip;
}

void xv6_ifree(struct inode * index_node)
{
	panic("xv6_ifree() not implemented!");
}

uint xv6_balloc(uint dev)
{
	int b, bi, m;
	struct buf * bp;

	bp = 0;
	for(b = 0; b < sb.size; b += XV6_BPB) {
		bp = xv6_vfs_ops.bread(dev, XV6_BBLOCK(b, sb));
		for(bi = 0; bi < XV6_BPB && b + bi < sb.size; bi++) {
			m = 1 << (bi % 8);
			if((bp->data[bi / 8] & m) == 0) {  // Is block free?
				bp->data[bi / 8] |= m;  // Mark block in use.

				log_write(bp);
				xv6_vfs_ops.brelease(bp);
				xv6_vfs_ops.bzero(dev, b + bi);

				return b + bi;
			}
		}

		xv6_vfs_ops.brelease(bp);
	}

	panic("balloc: out of blocks");
}

void xv6_bzero(int dev, int block_num)
{
	struct buf * bp;

	bp = xv6_vfs_ops.bread(dev, block_num);
	kmemset(bp->data, 0, XV6_BLOCK_SIZE);

	log_write(bp);
	xv6_vfs_ops.brelease(bp);
}

void xv6_bfree(int dev, uint block_num)
{
	struct buf * bp;
	int bi, m;

	bp = xv6_vfs_ops.bread(dev, XV6_BBLOCK(block_num, sb));
	bi = block_num % XV6_BPB;
	m = 1 << (bi % 8);

	if((bp->data[bi / 8] & m) == 0)
		panic("freeing free block");
	
	bp->data[bi / 8] &= ~m;

	log_write(bp);
	xv6_vfs_ops.brelease(bp);
}

int xv6_name_cmp(const char * source, const char * dest)
{
	return kstrncmp(source, dest, DIRSIZ);
}

/* xv6 inode operations */

// Look for a directory entry in a directory.
// If found, set * poff to byte offset of entry.

struct inode * xv6_dir_lookup(struct inode * dp, char * name, uint * poff)
{
	uint off, inum;
	struct dirent de;

	if(dp->type != T_DIR) {
		panic("xv6_dir_lookup not DIR");
	}

	for(off = 0; off < dp->size; off += sizeof(de)) {
		if(xv6_inode_ops.readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
			panic("xv6_dir_lookup read");
		}

		if(de.inum == 0) {
			continue;
		}

		if(xv6_vfs_ops.name_cmp(name, de.name) == 0) {
			// entry matches path element
			if(poff)
				*poff = off;

			inum = de.inum;

			return xv6_vfs_ops.iget(dp->dev, inum);
		}
	}

	return 0;
}

// Copy a modified in-memory inode to disk.
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.

void xv6_iupdate(struct inode *ip)
{
	struct buf * bp;
	struct xv6_dinode * dip;

	bp = xv6_vfs_ops.bread(ip->dev, XV6_IBLOCK(ip->inum, sb));
	dip = (struct xv6_dinode *)bp->data + ip->inum % XV6_IPB;
	dip->type = ip->type;
	dip->major = ip->major;
	dip->minor = ip->minor;
	dip->nlink = ip->nlink;
	dip->size = ip->size;

	kmemmove(dip->addrs, ip->addrs, sizeof(ip->addrs));

	log_write(bp);
	xv6_vfs_ops.brelease(bp);
}

// Truncate inode (discard contents).
// Caller must hold ip->lock.

void xv6_itrunc(struct inode * ip)
{
	int i, j;
	struct buf *bp;
	uint *a;

	for(i = 0; i < NDIRECT; i++) {
		if(ip->addrs[i]) {
			xv6_vfs_ops.bfree(ip->dev, ip->addrs[i]);
			ip->addrs[i] = 0;
		}
	}

	if(ip->addrs[NDIRECT]) {
		bp = xv6_vfs_ops.bread(ip->dev, ip->addrs[NDIRECT]);
		a = (uint*)bp->data;

		for(j = 0; j < NINDIRECT; j++) {
			if(a[j])
				xv6_vfs_ops.bfree(ip->dev, a[j]);
		}

		xv6_vfs_ops.brelease(bp);
		xv6_vfs_ops.bfree(ip->dev, ip->addrs[NDIRECT]);
		ip->addrs[NDIRECT] = 0;
	}

	ip->size = 0;
	xv6_inode_ops.iupdate(ip);
}

void xv6_cleanup(struct inode *ip)
{
	panic("xv6_cleanup() not implemented!");
}

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.

uint xv6_bmap(struct inode * ip, uint bn)
{
	uint addr, * a;
	struct buf * bp;

	if(bn < NDIRECT) {
		if((addr = ip->addrs[bn]) == 0) {
			ip->addrs[bn] = addr = xv6_vfs_ops.balloc(ip->dev);
		}

		return addr;
	}

	bn -= NDIRECT;

	if(bn < NINDIRECT) {
		// Load indirect block, allocating if necessary.
		if((addr = ip->addrs[NDIRECT]) == 0) {
			ip->addrs[NDIRECT] = addr = xv6_vfs_ops.balloc(ip->dev);
		}

		bp = xv6_vfs_ops.bread(ip->dev, addr);
		a = (uint *)bp->data;

		if((addr = a[bn]) == 0) {
			a[bn] = addr = xv6_vfs_ops.balloc(ip->dev);

			log_write(bp);
		}

		xv6_vfs_ops.brelease(bp);

		return addr;
	}

	panic("bmap: out of range");
}

// Drop a reference to an in-memory inode.
// If that was the last reference, the inode table entry can
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void xv6_iput(struct inode * ip)
{
	acquire(&itable.lock);

	if(ip->ref == 1 && ip->valid && ip->nlink == 0) {
		// inode has no links and no other references: truncate and free.

		// ip->ref == 1 means no other process can have ip locked,
		// so this acquiresleep() won't block (or deadlock).
		acquiresleep(&ip->lock);
		release(&itable.lock);

		xv6_inode_ops.itrunc(ip);
		ip->type = 0;
		xv6_inode_ops.iupdate(ip);
		ip->valid = 0;

		releasesleep(&ip->lock);

		acquire(&itable.lock);
	}

	ip->ref--;
	release(&itable.lock);
}

// Lock the given inode.
// Reads the inode from disk if necessary.

void xv6_ilock(struct inode * ip)
{
	struct buf * bp;
	struct xv6_dinode * dip;

	if(ip == 0 || ip->ref < 1) {
		panic("xv6_ilock()");
	}

	acquiresleep(&ip->lock);

	if(ip->valid == 0) {
		bp = xv6_vfs_ops.bread(ip->dev, XV6_IBLOCK(ip->inum, sb));
		dip = (struct xv6_dinode *) bp->data + ip->inum % XV6_IPB;
		ip->type = dip->type;
		ip->major = dip->major;
		ip->minor = dip->minor;
		ip->nlink = dip->nlink;
		ip->size = dip->size;

		kmemmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
		xv6_vfs_ops.brelease(bp);

		ip->valid = 1;

		if(ip->type == 0) {
			panic("xv6_ilock(): no type");
		}
	}
}

// Unlock the given inode.
void xv6_iunlock(struct inode * ip)
{
	if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
		panic("xv6_iunlock()");

	releasesleep(&ip->lock);
}


void xv6_iunlockput(struct inode * ip)
{
	xv6_inode_ops.iunlock(ip);
	xv6_inode_ops.iput(ip);
}

// Inode content
//
// The content (data) associated with each inode is stored
// in blocks on the disk. The first NDIRECT block numbers
// are listed in ip->addrs[].  The next NINDIRECT blocks are
// listed in block ip->addrs[NDIRECT].

// Copy stat information from inode.
// Caller must hold ip->lock.

void xv6_stati(struct inode * ip, struct stat * st)
{
	st->dev = ip->dev;
	st->ino = ip->inum;
	st->type = ip->type;
	st->nlink = ip->nlink;
	st->size = ip->size;
}

// Read data from inode.
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.

int xv6_readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
	uint tot, m;
	struct buf * bp;

	if(off > ip->size || off + n < off)
		return 0;
	if(off + n > ip->size)
		n = ip->size - off;

	for(tot = 0; tot < n; tot += m, off += m, dst += m) {
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / XV6_BLOCK_SIZE));
		m = min(n - tot, XV6_BLOCK_SIZE - off % XV6_BLOCK_SIZE);

		if(either_copyout(user_dst, dst, bp->data + (off % XV6_BLOCK_SIZE), m) == -1) {
			xv6_vfs_ops.brelease(bp);
			tot = -1;
			break;
		}

		xv6_vfs_ops.brelease(bp);
	}
	
	return tot;
}

// Write data to inode.
// Caller must hold ip->lock.
// If user_src==1, then src is a user virtual address;
// otherwise, src is a kernel address.
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.

int xv6_writei(struct inode * ip, int user_src, uint64 src, uint off, uint n)
{
	uint tot, m;
	struct buf * bp;

	if(off > ip->size || off + n < off)
		return -1;
	if(off + n > MAXFILE * XV6_BLOCK_SIZE)
		return -1;

	for(tot = 0; tot < n; tot += m, off += m, src += m) {
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / XV6_BLOCK_SIZE));
		m = min(n - tot, XV6_BLOCK_SIZE - off % XV6_BLOCK_SIZE);

		if(either_copyin(bp->data + (off % XV6_BLOCK_SIZE), user_src, src, m) == -1) {
			xv6_vfs_ops.brelease(bp);
			break;
		}

		log_write(bp);
		xv6_vfs_ops.brelease(bp);
	}

	if(off > ip->size)
		ip->size = off;

	// write the i-node back to disk even if the size didn't change
	// because the loop above might have called bmap() and added a new
	// block to ip->addrs[].
	xv6_inode_ops.iupdate(ip);

	return tot;
}

// Write a new directory entry (name, inum) into the directory dp.

int xv6_dir_link(struct inode * dp, char * name, uint inum)
{
	int off;
	struct dirent de;
	struct inode * ip;

	// Check that name is not present.
	if((ip = xv6_inode_ops.dir_lookup(dp, name, 0)) != 0) {
		xv6_inode_ops.iput(ip);
		return -1;
	}

	// Look for an empty dirent.
	for(off = 0; off < dp->size; off += sizeof(de)) {
		if(xv6_inode_ops.readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
			panic("xv6_dir_link() readi()");
		}

		if(de.inum == 0) {
			break;
		}
	}

	kstrncpy(de.name, name, DIRSIZ);
	de.inum = inum;

	if(xv6_inode_ops.writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
		panic("xv6_dir_link() writei()");
	}

	return 0;
}

int xv6_unlink(struct inode *dp, uint off)
{
	panic("xv6_unlink() not implemented!");
}

int xv6_is_dir_empty(struct inode *dp)
{
	panic("xv6_is_dir_empty() not implemented!");
}
