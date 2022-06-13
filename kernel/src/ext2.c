#include <kernel/buf.h>
#include <kernel/defs.h>
#include <kernel/ext2.h>
#include <kernel/vfs.h>
#include <kernel/types.h>
#include <kernel/sleeplock.h>
#include <kernel/stat.h>
#include <kernel/proc.h>
#include <kernel/find_bits.h>
#include <kernel/file.h>

#define in_range(b, first, len)((b) >= (first) && (b) <= (first) + (len) - 1)

extern struct vfs * root_fs;
extern struct itable itable;

typedef struct {
	unsigned int * p;
	unsigned int key;
	struct buf * buffer;
} Indirect;

static struct {
	struct spinlock lock;
	struct ext2_inode_mem inodes[NINODE];
	unsigned int reserved[NINODE];
} ext2_active_inodes;

/* VFS Operations */

struct inode * ext2_get_root(unsigned int dev);
struct inode * ext2_iget(unsigned int dev, unsigned int inum);
int ext2_read_super(int dev, struct superblock * super);
struct inode * ext2_ialloc(unsigned int dev, short type);
unsigned int ext2_balloc(unsigned int dev);
void ext2_bzero(int dev, unsigned int block_num);
void ext2_bfree(int dev, unsigned int block_num);
void ext2_bwrite(struct buf * buffer);
struct buf * ext2_bread(unsigned int dev, unsigned int block_num);
int ext2_name_cmp(const char * source, const char * dest);

/* Inode Operations */

struct inode * ext2_dir_lookup(struct inode * dp, char * name, unsigned int * off);
void ext2_iupdate(struct inode * ip);
void ext2_itrunc(struct inode * ip);
unsigned int ext2_bmap(struct inode * ip, unsigned int block_num);
void ext2_ilock(struct inode * ip);
void ext2_iunlock(struct inode * ip);
struct inode * ext2_idup(struct inode * ip);
void ext2_iput(struct inode * ip);
void ext2_iunlockput(struct inode * ip);
void ext2_stati(struct inode * ip, struct stat * st);
int ext2_readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
int ext2_writei(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
int ext2_dir_link(struct inode * dp, char * name, unsigned int inum, unsigned int type);

struct vfs_operations ext2_vfs_ops = {
	.get_root = &ext2_get_root,
	.read_super = &ext2_read_super,
	.ialloc = &ext2_ialloc,
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
};

/* ext2 vfs operations */

struct inode * ext2_get_root(unsigned int dev)
{
	//kprintf("ext2_get_root(%d)\n", dev);
	return ext2_iget(dev, EXT2_ROOT_INODE);
}

static inline int test_root(int a, int b)
{
	int num = b;

	while(a > num)
		num *= b;

	return (num == a);
}

static int ext2_group_sparse(int group)
{
	if(group <= 1)
		return 1;

	return (test_root(group, 3) || test_root(group, 5) || test_root(group, 7));
}

static inline void add_chain(Indirect * p, struct buf * buffer, unsigned int * v)
{
	p->key = *(p->p = v);
	p->buffer = buffer;
}

static inline int verify_chain(Indirect * from, Indirect * to)
{
	for(;from <= to && from->key == *from->p; from++)
		;

	return from > to;
}

static void group_adjust_blocks(struct ext2_group_descriptor * descriptor, struct buf * buffer, int count)
{
	if(count) {
		descriptor->free_blocks_count = descriptor->free_blocks_count + count;
		ext2_vfs_ops.bwrite(buffer);
	}
}

static void ext2_update_branch(struct inode * inode, unsigned int block_num, Indirect *chain)
{
	//kprintf("ext2_update_branch(%p, %d, %p)\n", inode, block_num, chain);
	int pointers = root_fs->superblock.block_size / sizeof(unsigned int);
	int pointers_bits = root_fs->superblock.ext2_in_mem_super.address_per_block_bits;

	const long direct_blocks = EXT2_DIR_BLOCK_COUNT, indirect_blocks = pointers, double_blocks = (1 << (pointers_bits * 2));

	if(block_num < direct_blocks) {
		if(inode->ext2_inode->inode.blocks[block_num] == 0) {
			inode->ext2_inode->inode.blocks[block_num] = chain[0].key;
		}
	} else if((block_num -= direct_blocks) < indirect_blocks) {
		if(inode->ext2_inode->inode.blocks[EXT2_IND_BLOCK] == 0) {
			inode->ext2_inode->inode.blocks[EXT2_IND_BLOCK] = chain[0].key;
		}
	} else if((block_num -= indirect_blocks) < double_blocks) {
		if(inode->ext2_inode->inode.blocks[EXT2_DIND_BLOCK] == 0) {
			inode->ext2_inode->inode.blocks[EXT2_DIND_BLOCK] = chain[0].key;
		}
	} else if(((block_num -= double_blocks) >> (pointers_bits * 2)) < pointers) {
		if(inode->ext2_inode->inode.blocks[EXT2_TIND_BLOCK] == 0) {
			inode->ext2_inode->inode.blocks[EXT2_TIND_BLOCK] = chain[0].key;
		}
	} else {
		panic("ext2_update_branch(): Block out of bounds");
	}

	return;
}

static Indirect * ext2_get_branch(struct inode * inode, int depth, int * offsets, Indirect chain[4])
{
	//kprintf("ext2_get_branch(%p, %d, %d, %p)\n", inode, depth, *offsets, chain);
	Indirect * p = chain;
	struct buf * buffer;

	add_chain(chain, 0, inode->ext2_inode->inode.blocks + *offsets);

	if(!p->key) {
		goto no_block;
	}

	while(--depth) {
		buffer = ext2_vfs_ops.bread(inode->dev, p->key);
		
		if(!buffer) {
			panic("ext2_get_branch(): Could not read buffer");
		}
		
		if(!verify_chain(chain, p)) {
			panic("ext2_get_branch(): Invalid chain");
		}
		
		add_chain(++p, buffer, (unsigned int *)buffer->data + *++offsets);
		
		if(!p->key) {
			goto no_block;
		}
	}

	return 0;

no_block:
	return p;
}

static int ext2_block_to_path(struct inode * inode, long inode_block, int offsets[4], int * boundary)
{
	//kprintf("ext2_block_to_path(%p %d, %d, %d %d %d %d, %p)\n", inode, inode->inum, inode_block, offsets[0], offsets[1], offsets[2], offsets[3], boundary);
	int pointers = root_fs->superblock.block_size / sizeof(unsigned int);
	int pointers_bits = root_fs->superblock.ext2_in_mem_super.address_per_block_bits;

	const long direct_blocks = EXT2_DIR_BLOCK_COUNT, indirect_blocks = pointers, double_blocks = (1 << (pointers_bits * 2));
	int n = 0;
	int final = 0;

	if(inode_block < 0) {
		panic("ext2_block_to_path(): Invalid block number");
	} else if(inode_block < direct_blocks) {
		offsets[n++] = inode_block;
		final = direct_blocks;
	} else if((inode_block -= direct_blocks) < indirect_blocks) {
		offsets[n++] = EXT2_IND_BLOCK;
		offsets[n++] = inode_block;
		final = pointers;
	} else if((inode_block -= indirect_blocks) < double_blocks) {
		offsets[n++] = EXT2_DIND_BLOCK;
		offsets[n++] = inode_block >> pointers_bits;
		offsets[n++] = inode_block & (pointers - 1);
		final = pointers;
	} else if(((inode_block -= double_blocks) >> (pointers_bits * 2)) < pointers) {
		offsets[n++] = EXT2_TIND_BLOCK;
		offsets[n++] = inode_block >> (pointers_bits * 2);
		offsets[n++] = (inode_block >> pointers_bits) & (pointers - 1);
		offsets[n++] = inode_block & (pointers - 1);
		final = pointers;
	} else {
		panic("ext2_block_to_path(): Block out of bounds");
	}

	if(boundary) {
		*boundary = final - 1 - (inode_block & (pointers - 1));
	}

	return n;
}

static inline unsigned long ext2_group_first_block_num(unsigned long group_num)
{
	return group_num * root_fs->superblock.ext2_in_mem_super.blocks_per_block_group + root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
}

static unsigned long bitmap_search_next_usable_block(unsigned int start, struct buf * buffer, unsigned long maxblocks)
{
	//kprintf("bitmap_search_next_usable_block(%d, %p, %d)\n", start, buffer, maxblocks);
	unsigned int next;

	next = find_next_zero_bit((unsigned int *)buffer->data, maxblocks, start);

	if(next >= maxblocks) {
		return -1;
	}

	return next;
}

static unsigned long find_next_usable_block(int start, struct buf * buffer, int max_blocks)
{
	//kprintf("find_next_usable_block()\n");
	unsigned long here, next;
	char *p, *r;

	if(start > 0) {
		unsigned long end_goal = (start + 63) & ~63;

		if(end_goal > max_blocks) {
			end_goal = max_blocks;
		}

		here = find_next_zero_bit((unsigned int *)buffer->data, end_goal, start);

		if(here < end_goal) {
			return here;
		}
	}

	here = start;

	if(here < 0) {
		here = 0;
	}

	p = ((char *)buffer->data) + (here >> 3);
	r = kmemscan(p, 0, ((max_blocks + 7) >> 3) - (here >> 3));
	next = (r - ((char *)buffer->data)) << 3;

	if(next < max_blocks && next >= here) {
		return next;
	}

	here = bitmap_search_next_usable_block(here, buffer, max_blocks);

	return here;
}

static int ext2_try_to_allocate(int group, struct buf * bitmap_buffer, unsigned long goal_group, unsigned long *count)
{
	//kprintf("ext2_try_to_allocate(%d, %p, %d, %p)\n", group, bitmap_buffer, goal_group, count);
	unsigned long start, end;
	unsigned long num = 0;

	if(goal_group > 0) {
		start = goal_group;
	} else {
		start = 0;
	}

	end = root_fs->superblock.ext2_in_mem_super.blocks_per_block_group;

repeat:
	if(goal_group < 0) {
		goal_group = find_next_usable_block(start, bitmap_buffer, end);

		if(goal_group < 0)
			goto fail_access;

		for(int i = 0; i < 7 && goal_group > start && !test_bit(goal_group - 1, (unsigned long *)bitmap_buffer->data); i++, goal_group--)
			;
	}

	start = goal_group;

	if(test_and_set_bit(goal_group, (unsigned long *)bitmap_buffer->data)) {
		start++;
		goal_group++;

		if(start >= end)
			goto fail_access;

		goto repeat;
	}

	for(num++, goal_group++; num < *count && goal_group < end && !test_and_set_bit(goal_group, (unsigned long *) bitmap_buffer->data); num++, goal_group++)
		;

	*count = num;

	return goal_group - num;

fail_access:

	*count = num;

	return -1;
}

static struct ext2_group_descriptor * ext2_get_group_descriptor(unsigned int block_group, struct buf ** buffer)
{
	//kprintf("ext2_get_group_descriptor(%d, %p)\n", block_group, buffer);
	unsigned long group_descriptor;
	unsigned long offset;
	struct ext2_group_descriptor * descriptor;

	if(block_group >= root_fs->superblock.ext2_in_mem_super.group_count) {
		panic("ext2_get_group_descriptor(): Block group too large");
	}

	group_descriptor = block_group >> root_fs->superblock.ext2_in_mem_super.descriptors_per_block_bits;
	offset = block_group & (root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block - 1);

	if(!root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]) {
		panic("ext2_get_group_descriptor(): Group descriptor not loaded");
	}

	descriptor = (struct ext2_group_descriptor *) root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]->data;

	if(buffer) {
		*buffer = root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor];
	}

	return descriptor + offset;
}

static struct buf * read_block_bitmap(unsigned int block_group)
{
	//kprintf("read_block_bitmap(%d)\n", block_group);
	struct ext2_group_descriptor * descriptor;
	struct buf * buffer;

	descriptor = ext2_get_group_descriptor(block_group, 0);

	if(!descriptor)
		return 0;

	buffer = ext2_vfs_ops.bread(root_fs->superblock.device, descriptor->block_bitmap);
	
	if(!buffer)
		return 0;

	return buffer;
}

static unsigned ext2_last_byte(struct inode * inode, unsigned long page_num)
{
	unsigned int last_byte = inode->size;

	last_byte -= page_num * root_fs->superblock.block_size;

	if(last_byte > root_fs->superblock.block_size)
		last_byte = root_fs->superblock.block_size;

	return last_byte;
}

static int ext2_blocks_to_allocate(Indirect * branch, int k, unsigned long blocks, int blocks_to_boundary)
{
	//kprintf("ext2_blocks_to_allocate(%p, %d, %d, %d)\n", branch, k, blocks, blocks_to_boundary);
	unsigned long count = 0;

	if(k > 0) {
		if(blocks < blocks_to_boundary + 1) {
			count += blocks;
		} else {
			count += blocks_to_boundary + 1;
		}

		return count;
	}
	
	for(count++; count < blocks && count <= blocks_to_boundary && *(branch[0].p + count) == 0; count++)
		;

	return count;
}

unsigned long ext2_new_blocks(struct inode * inode, unsigned long goal, unsigned long * count, int * errp)
{
	//kprintf("ext2_new_blocks(%p, %d, %p, %p)\n", inode, goal, count, errp);
	struct buf * bitmap_buffer = 0;
	struct buf * descriptor_buffer;
	int group_num;
	int group_target_block;
	int group_allocated_block;
	unsigned long return_block;
	int free_blocks;
	struct ext2_group_descriptor * descriptor;
	unsigned long ngroups;
	unsigned long num = *count;

	*errp = -1;

	if(goal < root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block || goal >= root_fs->superblock.ext2_in_mem_super.disk_super->block_count) {
		goal = root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
	}

	group_num = (goal - root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block) / root_fs->superblock.ext2_in_mem_super.blocks_per_block_group;

retry_alloc:
	descriptor = ext2_get_group_descriptor(group_num, &descriptor_buffer);

	if(!descriptor) {
		goto io_error;
	}

	free_blocks = descriptor->free_blocks_count;

	if(free_blocks > 0) {
		group_target_block = ((goal - root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block) % root_fs->superblock.ext2_in_mem_super.blocks_per_block_group);
		bitmap_buffer = read_block_bitmap(group_num);
		
		if(!bitmap_buffer) {
			goto io_error;
		}

		group_allocated_block = ext2_try_to_allocate(group_num, bitmap_buffer, group_target_block, &num);
		
		if(group_allocated_block >= 0)
			goto allocated;
	}

	ngroups = root_fs->superblock.ext2_in_mem_super.group_count;

	for(int block_group_index = 0; block_group_index < ngroups; block_group_index++) {
		group_num++;
		
		if(group_num >= ngroups) {
			group_num = 0;
		}

		descriptor = ext2_get_group_descriptor(group_num, &descriptor_buffer);
		
		if(!descriptor) {
			goto io_error;
		}

		free_blocks = descriptor->free_blocks_count;

		if(!free_blocks) {
			continue;
		}

		ext2_vfs_ops.brelease(bitmap_buffer);
		bitmap_buffer = read_block_bitmap(group_num);

		if(!bitmap_buffer) {
			goto io_error;
		}

		group_allocated_block = ext2_try_to_allocate(group_num, bitmap_buffer, -1, &num);

		if(group_allocated_block >= 0) {
			goto allocated;
		}
	}

	goto out;

allocated:
	return_block = group_allocated_block + ext2_group_first_block_num(group_num);

	if(in_range(descriptor->block_bitmap, return_block, num) || in_range(descriptor->inode_bitmap, return_block, num) || in_range(return_block, descriptor->inode_table, root_fs->superblock.ext2_in_mem_super.inode_table_blocks_per_group) || in_range(return_block + num - 1, descriptor->inode_table, root_fs->superblock.ext2_in_mem_super.inode_table_blocks_per_group)) {
		goto retry_alloc;
	}

	if(return_block + num - 1 >= root_fs->superblock.ext2_in_mem_super.disk_super->block_count) {
		panic("ext2_new_blocks(): Invalid block number");
	}

	group_adjust_blocks(descriptor, descriptor_buffer, -num);

	ext2_vfs_ops.bwrite(bitmap_buffer);

	*errp = 0;

	ext2_vfs_ops.brelease(bitmap_buffer);

	return return_block;

io_error:
	*errp = -2;

out:
	ext2_vfs_ops.brelease(bitmap_buffer);
	
	return 0;
}

static int ext2_allocate_blocks(struct inode * inode, unsigned long goal, int indirect_blocks, int blocks, unsigned long new_blocks[4], int *err)
{
	//kprintf("ext2_allocate_blocks(%p, %d, %d, %d, %d %d %d %d, %p)\n", inode, goal, indirect_blocks, blocks, new_blocks[0], new_blocks[1], new_blocks[2], new_blocks[3], err);
	int target = blocks + indirect_blocks;
	int index = 0;
	int ret = 0;
	unsigned long count = 0;
	unsigned long current_block = 0;

	for(;;) {
		count = target;
		current_block = ext2_new_blocks(inode, goal, &count, err);
		
		if(*err) {
			goto failed_out;
		}

		target -= count;
		
		while(index < indirect_blocks && count) {
			new_blocks[index++] = current_block++;
			count--;
		}

		if(count > 0) {
			break;
		}
	}

	new_blocks[index] = current_block;
	ret = count;
	*err = 0;
	
	return ret;

failed_out:
	panic("ext2_allocate_blocks(): Failed to get new blocks");

	return ret;
}

static int ext2_allocate_branch(struct inode * inode, int indirect_blocks, int * blocks, int goal, int * offsets, Indirect * branch)
{
	//kprintf("ext2_allocate_branch(%p, %d, %p, %d, %p, %p)\n", inode, indirect_blocks, blocks, goal, offsets, branch);
	int blocksize = root_fs->superblock.block_size;
	int err = 0;
	struct buf * buffer;
	int num;
	unsigned long new_blocks[4] = { 0 };
	unsigned long current_block;

	num = ext2_allocate_blocks(inode, goal, indirect_blocks, *blocks, new_blocks, &err);
	
	if(err)
		return err;

	branch[0].key = new_blocks[0];

	for(int n = 1; n <= indirect_blocks; n++) {
		buffer = ext2_vfs_ops.bread(inode->dev, new_blocks[n - 1]);

		if(!buffer)
			goto failed;

		branch[n].buffer = buffer;

		kmemset(buffer->data, 0, blocksize);
		
		branch[n].p = (unsigned int *) buffer->data + offsets[n];
		branch[n].key = new_blocks[n];
		*branch[n].p = branch[n].key;

		if(n == indirect_blocks) {
			current_block = new_blocks[n];

			for(int i = 1; i < num; i++) {
				*(branch[n].p + i) = ++current_block;
			}
		}

		ext2_vfs_ops.bwrite(buffer);
	}

	*blocks = num;
	
	return err;

failed:
	panic("ext2_allocate_branch(): Failed to allocate block branch");
	
	return err;
}

static inline unsigned int blocksize_bits(unsigned int size)
{
	unsigned int bits = 8;

	do {
		bits++;
		size >>= 1;
	} while(size > 256);

	return bits;
}

static unsigned long ext2_find_near(struct inode * inode, Indirect * ind)
{
	//kprintf("ext2_find_near(%p, %p)\n", inode, ind);
	unsigned int * start = ind->buffer ? (unsigned int *) ind->buffer->data : inode->ext2_inode->inode.blocks;
	unsigned int * p;
	unsigned long block_group_start;
	unsigned long colour;
	int block_group;

	for(p = ind->p - 1; p >= start; p--) {
		if(*p) {
			//kprintf("p: %d\n", *p);
			return *p;
		}
	}

	if(ind->buffer) {
		//kprintf("ind->buffer->blockno: %d\n", ind->buffer->blockno);
		return ind->buffer->blockno;
	}

	block_group = (inode->inum - 1) / root_fs->superblock.ext2_in_mem_super.inodes_per_block_group;
	block_group_start = block_group * root_fs->superblock.ext2_in_mem_super.blocks_per_block_group + root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
	colour = (myproc()->pid % 16) * (root_fs->superblock.ext2_in_mem_super.blocks_per_block_group / 16);

	//kprintf("block_group: %d\nblock_group_start: %d\ncolour: %d\n", block_group, block_group_start, colour);

	return block_group_start + colour;
}

static struct ext2_inode * ext2_get_inode(unsigned int inode_num, struct buf ** buffer)
{
	//kprintf("ext2_get_inode(%d, %p)\n", inode_num, buffer);
	struct buf * buffer_p;
	unsigned long block_group;
	unsigned long block;
	struct ext2_group_descriptor * group_descriptor_p;
	struct ext2_inode * raw_inode;
	unsigned long group_descriptor;
	unsigned long descriptor_index;
	unsigned long offset;

	if((inode_num != EXT2_ROOT_INODE && inode_num < root_fs->superblock.ext2_in_mem_super.disk_super->first_inode) || inode_num > root_fs->superblock.ext2_in_mem_super.disk_super->inode_count) {
		panic("ext2_get_inode(): Invalid inode number");
	}

	block_group = (inode_num - 1) / root_fs->superblock.ext2_in_mem_super.inodes_per_block_group; /* Determine the block group the inode is in */

	if(block_group > root_fs->superblock.ext2_in_mem_super.group_count) {
		panic("ext2_get_inode(): Block group out of range");
	}

	group_descriptor = block_group / root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block; /* Determine group descriptor of the block group */
	descriptor_index = block_group % root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block; /* Determine the index of the group descriptor inside the group descriptor offset */
	buffer_p = root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]; /* Load the pointer to the buffer for the group descriptor into a variable */
	group_descriptor_p = (struct ext2_group_descriptor *) buffer_p->data; /* Cast the contents of the group descriptor into another variable */

	if(!group_descriptor_p) /* If the group descriptor pointer is NULL then something's gone very wrong and the kernel dies */
		panic("ext2_get_inode(): Invalid group descriptor");

	offset = ((inode_num - 1) % root_fs->superblock.ext2_in_mem_super.inodes_per_block_group) * EXT2_INODE_SIZE;
	block = group_descriptor_p[descriptor_index].inode_table + (offset >> 10);

	if(!(buffer_p = ext2_vfs_ops.bread(root_fs->superblock.device, block)))
		panic("ext2_get_inode(): Could not read inode block");

	offset &= (EXT2_BLOCK_SIZE - 1);
	raw_inode = ((struct ext2_inode *) (buffer_p->data + offset));
	
	if(buffer)
		*buffer = buffer_p;

	return raw_inode;
}

int ext2_read_super(int dev, struct superblock * super)
{
	//kprintf("ext2_read_super()\n");
	struct buf * buffer;
	unsigned long group_descriptor_block_count;
	struct ext2_superblock * ext2_disk_super;

	buffer = ext2_vfs_ops.bread(dev, EXT2_SUPERBLOCK_BLOCK);

	if(((struct ext2_superblock *) buffer->data)->magic_number != EXT2_MAGIC) {
		ext2_vfs_ops.brelease(buffer);

		return -1;
	}

	initlock(&ext2_active_inodes.lock, "ext2_inode_pool");

	ext2_disk_super = kalloc();
	kmemmove(ext2_disk_super, buffer->data, sizeof(struct ext2_superblock)); /* Read the disk super block into memory */
	ext2_vfs_ops.brelease(buffer);

	/* Set up the generic aspects of the super block */

	super->magic = EXT2_MAGIC;
	super->block_size = EXT2_BLOCK_SIZE_SHIFT << ext2_disk_super->block_size;
	super->device = dev;
	super->size = ext2_disk_super->block_count;
	super->vfs_ops = &ext2_vfs_ops;

	if(super->block_size != EXT2_BLOCK_SIZE)
		panic("ext2_read_super(): System only supports 1024 byte blocks for ext2!");

	/* Set up the ext2 in-memory superblock */

	super->ext2_in_mem_super.disk_super = ext2_disk_super;
	super->ext2_in_mem_super.super_buffer = buffer;

	//if(super->ext2_in_mem_super.disk_super->major_version != EXT2_VERSION_ONE)
	//	panic("System only supports ext2 version 1!");

	super->ext2_in_mem_super.inode_size = EXT2_INODE_SIZE;
	super->ext2_in_mem_super.first_inode = EXT2_FIRST_INODE;
	super->ext2_in_mem_super.blocks_per_block_group = super->ext2_in_mem_super.disk_super->blocks_per_block_group;
	super->ext2_in_mem_super.inodes_per_block_group = super->ext2_in_mem_super.disk_super->inodes_per_block_group;
	super->ext2_in_mem_super.inodes_per_block = super->block_size / super->ext2_in_mem_super.inode_size;
	super->ext2_in_mem_super.inode_table_blocks_per_group = ext2_disk_super->inodes_per_block_group / super->ext2_in_mem_super.inodes_per_block;
	super->ext2_in_mem_super.group_descriptors_per_block = super->block_size / sizeof(struct ext2_group_descriptor);
	super->ext2_in_mem_super.address_per_block_bits = ilog2(super->block_size / sizeof(unsigned int));
	super->ext2_in_mem_super.descriptors_per_block_bits = ilog2(super->ext2_in_mem_super.group_descriptors_per_block);
	super->ext2_in_mem_super.block_size_bits = blocksize_bits(super->block_size);

	if(super->ext2_in_mem_super.blocks_per_block_group > super->block_size * 8)
		panic("ext2_read_super(): Too many inodes per block!");

	super->ext2_in_mem_super.group_count = ((super->ext2_in_mem_super.disk_super->block_count - super->ext2_in_mem_super.disk_super->superblock_block - 1) / super->ext2_in_mem_super.blocks_per_block_group) + 1;
	group_descriptor_block_count = (super->ext2_in_mem_super.group_count + super->ext2_in_mem_super.group_descriptors_per_block - 1) / super->ext2_in_mem_super.group_descriptors_per_block;

	if(group_descriptor_block_count > EXT2_MAX_BLOCK_GROUP_COUNT)
		panic("ext2_read_super(): Not enough memory to for group_descriptor! Consider increasing the maximum group size");

	for(int i = 0; i < group_descriptor_block_count; i++) {
		super->ext2_in_mem_super.group_descriptors[i] = ext2_vfs_ops.bread(dev, i + 2);
		
		if(!super->ext2_in_mem_super.group_descriptors[i])
			panic("ext2_read_super(): Could not read ext2 group descriptor!");
	}

	super->ext2_in_mem_super.group_descriptor_count = group_descriptor_block_count;

	return EXT2_MAGIC;
}

static struct buf * read_inode_bitmap(unsigned long block_group)
{
	//kprintf("read_block_bitmap(%d)\n", block_group);
	struct ext2_group_descriptor * descriptor;
	struct buf * buffer = 0;

	descriptor = ext2_get_group_descriptor(block_group, 0); 

	if(!descriptor)
		panic("read_inode_bitmap(): Failed to get group descriptor");

	buffer = ext2_vfs_ops.bread(root_fs->superblock.device, descriptor->inode_bitmap);
	
	if(!buffer)
		panic("read_inode_bitmap(): Failed to read inode bitmap");

	return buffer;
}

struct inode * ext2_ialloc(unsigned int dev, short type)
{
	//kprintf("ext2_ialloc(%d, %d)\n", dev, type);

	int i, group;
	unsigned int inode_num;
	struct buf *bitmap_buffer = 0;
	struct buf *bh2;
	struct buf *ibh;
	struct ext2_group_descriptor * group_descriptor_p;
	struct ext2_inode * raw_inode;

	group = 0;

	for(i = 0; i < root_fs->superblock.ext2_in_mem_super.group_count; i++) {
		group_descriptor_p = ext2_get_group_descriptor(group, &bh2);

		if(bitmap_buffer) {
			ext2_vfs_ops.brelease(bitmap_buffer);
		}

		bitmap_buffer = read_inode_bitmap(group);
		inode_num = 0;

repeat_in_this_group:
		inode_num = find_next_zero_bit((unsigned int *)bitmap_buffer->data, root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group, inode_num);

		if(inode_num >= root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group) {
			if(++group == root_fs->superblock.ext2_in_mem_super.group_count) {
				group = 0;
			}

			continue;
		}

		if(test_and_set_bit(inode_num, (unsigned long *)bitmap_buffer->data)) {
			if(++inode_num >= root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group) {
				if(++group == root_fs->superblock.ext2_in_mem_super.group_count) {
					group = 0;
				}

				continue;
			}
			goto repeat_in_this_group;
		}
		goto got;
	}

	panic("ext2_ialloc(): No space for inode");

got:
	ext2_vfs_ops.bwrite(bitmap_buffer); /* Might be broken */
	ext2_vfs_ops.brelease(bitmap_buffer);

	inode_num += group * root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group + 1;

	if (inode_num < EXT2_FIRST_INODE || inode_num > root_fs->superblock.ext2_in_mem_super.disk_super->inode_count) {
		panic("ext2_ialloc(): Inode number out of range");
	}

	group_descriptor_p->free_inodes_count--;

	ext2_vfs_ops.bwrite(bh2);
	raw_inode = ext2_get_inode(inode_num, &ibh);

	kmemset(raw_inode, 0, EXT2_INODE_SIZE);

	if(type == T_DIR) {
		raw_inode->mode = EXT2_DIR;
	} else if(type == T_FILE) {
		raw_inode->mode = EXT2_FILE;
	} else if(type == T_DEVICE) {
		raw_inode->mode = EXT2_CHAR_DEV;
	} else {
		panic("ext2_ialloc(): Invalid inode mode");
	}

	ext2_vfs_ops.bwrite(ibh);
	ext2_vfs_ops.brelease(ibh);

	return ext2_iget(dev, inode_num);
}

struct inode * ext2_iget(unsigned int dev, unsigned int inum)
{
	//kprintf("ext2_iget(%d, %d)\n", dev, inum);
	struct inode * ip, * empty;
	struct ext2_inode * raw_inode;
	struct ext2_inode_mem * active_inode;
	struct buf * buffer;

	/* Get inode from the generic inode table */

	acquire(&itable.lock);

	empty = 0;

	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
		if(ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
			ip->ref++;
			release(&itable.lock);

			return ip;
		}

		if(empty == 0 && ip->ref == 0) {
			empty = ip;
		}
	}

	if(empty == 0) {
		panic("ext2_iget(): Inode table full!");
	}

	/* Populate generic inode data */

	ip = empty;
	ip->dev = dev;
	ip->inum = inum;
	ip->ref = 1;
	ip->flags = 0;
	ip->inode_ops = &ext2_inode_ops;
	ip->vfs_ops = &ext2_vfs_ops;

	release(&itable.lock);

	/* Get inode from ext2 inode table. This could be done with dynamic allocation but that will be wasteful since kalloc() gives 4kb blocks at a time and I cannot be bothered to make it better */

	acquire(&ext2_active_inodes.lock);

	for(int i = 0; i < NINODE; i++) {
		if(ext2_active_inodes.reserved[i] == 0x0) {
			ext2_active_inodes.reserved[i] |= 0x1;
			active_inode = &ext2_active_inodes.inodes[i];
			break;
		}
	}

	release(&ext2_active_inodes.lock);

	if(active_inode == 0) {
		panic("ext2_iget(): No ext2 inodes available!");
	}

	raw_inode = ext2_get_inode(ip->inum, &buffer);
	kmemmove(&active_inode->inode, raw_inode, sizeof(*raw_inode));
	ip->ext2_inode = active_inode;

	ext2_vfs_ops.brelease(buffer);

	if(EXT2_IS_DIR(active_inode->inode.mode)) {
		ip->type = T_DIR;
	} else if(EXT2_IS_FILE(active_inode->inode.mode)) {
		ip->type = T_FILE;
	} else if(EXT2_IS_CHAR_DEV(active_inode->inode.mode) || EXT2_IS_BLOCK_DEV(active_inode->inode.mode)) {
		ip->type = T_DEVICE;
	} else {
		panic("ext2_iget(): Invalid file mode");
	}

	ip->nlink = active_inode->inode.hard_link_count;
	ip->size = active_inode->inode.size;

	return ip;
}


unsigned int ext2_balloc(unsigned int dev)
{
	panic("ext2_balloc() not implemented!");
}

void ext2_bzero(int dev, unsigned int block_num)
{
	panic("ext2_bzero() not implemented!");
}

void ext2_bfree(int dev, unsigned int block_num)
{
	panic("ext2_bfree() not implemented!");
}

int ext2_name_cmp(const char * source, const char * target)
{
	panic("ext2_name_cmp() not implemented!");
}

/* ext2 inode operations */

struct inode * ext2_dir_lookup(struct inode * dp, char * name, unsigned int * poffset)
{
	//kprintf("ext2_dir_lookup(%p %d, %s, %p)\n", dp, dp->inum, name, poffset);
	unsigned int inum, cur_block;
	int name_length = kstrlen(name);
	struct ext2_dir_entry * directory_entry;
	struct buf * buffer_p;
	
	for(unsigned int offset = 0; offset < dp->size;) {
		cur_block = offset / root_fs->superblock.block_size;
		unsigned int bmap = ext2_inode_ops.bmap(dp, cur_block);

		buffer_p = ext2_vfs_ops.bread(dp->dev, bmap);
		directory_entry = (struct ext2_dir_entry *) (buffer_p->data + (offset % root_fs->superblock.block_size));

		if(directory_entry->inode == 0 || directory_entry->name_length != name_length) {
			offset += directory_entry->record_length;
			ext2_vfs_ops.brelease(buffer_p);

			continue;
		}

		if(kstrncmp(name, directory_entry->name, directory_entry->name_length) == 0) {
			if(poffset) {
				*poffset = offset;
			}

			inum = directory_entry->inode;
			ext2_vfs_ops.brelease(buffer_p);

			return ext2_iget(dp->dev, inum);
		}

		offset += directory_entry->record_length;
		ext2_vfs_ops.brelease(buffer_p);
	}

	return NULL;
}

void ext2_iupdate(struct inode * ip)
{
	struct buf * buffer;
	struct ext2_inode * raw_inode;

	raw_inode = ext2_get_inode(ip->inum, &buffer);

	raw_inode->mode = ip->ext2_inode->inode.mode;
	raw_inode->sector_count = ip->ext2_inode->inode.sector_count;
	raw_inode->hard_link_count = ip->ext2_inode->inode.hard_link_count;

	kmemmove(raw_inode->blocks, ip->ext2_inode->inode.blocks, sizeof(ip->ext2_inode->inode.blocks));

	raw_inode->size = ip->size;

	ext2_vfs_ops.bwrite(buffer);
	ext2_vfs_ops.brelease(buffer);
}

void ext2_itrunc(struct inode * ip)
{
	panic("itrunc() not implemented!");
}

void ext2_cleanup(struct inode * ip)
{
	panic("ext2_cleanup() not implemented!");
}

unsigned int ext2_bmap(struct inode * ip, unsigned int block_num)
{
	int depth;
	int offsets[4] = { 0 };
	int indirect_blocks;
	int blocks_to_boundary;
	int count;
	unsigned int block_no;
	unsigned long goal;
	unsigned long max_blocks;
	Indirect chain[4];
	Indirect * partial;

	depth = ext2_block_to_path(ip, block_num, offsets, &blocks_to_boundary);

	if(depth == 0) {
		panic("ext2_bmap(): Bad depth value");
	}

	if(!(partial = ext2_get_branch(ip, depth, offsets, chain))) {
		goto got_it;
	}

	max_blocks = root_fs->superblock.block_size >> root_fs->superblock.ext2_in_mem_super.block_size_bits;
	goal = ext2_find_near(ip, partial);
	indirect_blocks = (chain + depth) - partial - 1;
	count = ext2_blocks_to_allocate(partial, indirect_blocks, max_blocks, blocks_to_boundary);

	if(ext2_allocate_branch(ip, indirect_blocks, &count, goal, offsets + (partial - chain), partial) < 0) {
		panic("ext2_bmap(): Failed to allocate branch");
	}

got_it:
	block_no = chain[depth - 1].key;

	ext2_update_branch(ip, block_num, chain);

	partial = chain + depth - 1;

	while(partial > chain) {
		ext2_vfs_ops.brelease(partial->buffer);
		partial--;
	}

	return block_no;
}

void ext2_ilock(struct inode * ip)
{
	struct buf * buffer_p;
	struct ext2_inode * raw_inode;

	if(ip == NULL || ip->ref < 1) {
		panic("ext2_ilock(): Bad inode");
	}

	acquire(&itable.lock);

	while(ip->flags & I_BUSY)
		_sleep(ip, &itable.lock);

	ip->flags |= I_BUSY;

	release(&itable.lock);

	if(!(ip->flags & I_VALID)) {
		raw_inode = ext2_get_inode(ip->inum, &buffer_p);

		if(EXT2_IS_DIR(raw_inode->mode)) {
			ip->type = T_DIR;
		} else if(EXT2_IS_FILE(raw_inode->mode)) {
			ip->type = T_FILE;
		} else if(EXT2_IS_CHAR_DEV(raw_inode->mode) || EXT2_IS_BLOCK_DEV(raw_inode->mode)) {
			ip->type = T_DEVICE;
		} else {
			panic("ext2_ilock(): Invalid file mode");
		}

		ip->nlink = raw_inode->hard_link_count;
		ip->size = raw_inode->size;

		kmemmove(&ip->ext2_inode->inode, raw_inode, sizeof(raw_inode));

		ext2_vfs_ops.brelease(buffer_p);

		ip->flags |= I_VALID;

		if(ip->type == 0) {
			panic("ext2_ilock(): Invalid type");
		}
	}
}

void ext2_iunlock(struct inode * ip)
{
	if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
		panic("ext2_iunlock(): Inode busy or invalid");

	acquire(&itable.lock);
	ip->flags &= ~I_BUSY;

	release(&itable.lock);
}

void ext2_stati(struct inode * ip, struct stat * st)
{
	st->dev = ip->dev;
	st->ino = ip->inum;
	st->type = ip->type;
	st->nlink = ip->nlink;
	st->size = ip->size;
}

int ext2_readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
	unsigned int tot, m;
	struct buf * buffer_p;

	if(off > ip->size || off + n < off) {
		return -1;
	}

	if(off + n > ip->size) {
		n = ip->size - off;
	}

	for(tot = 0; tot < n; tot += m, off += m, dst += m) {
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / BSIZE));
		m = min(n - tot, BSIZE - off % BSIZE);

		if(either_copyout(user_dst, dst, buffer_p->data + (off % BSIZE), m) == -1) {
			ext2_vfs_ops.brelease(buffer_p);
			tot = -1;
			break;
    	}

		ext2_vfs_ops.brelease(buffer_p);
	}

	return tot;
}

int ext2_writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
	uint tot, m;
	struct buf * buffer_p;

	if(ip->type == T_DEVICE) {
		if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
			return -1;

		return devsw[ip->major].write(1, src, n);
	}

	if(off > ip->size || off + n < off)
		return -1;

	for(tot = 0; tot < n; tot += m, off += m, src += m) {
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / EXT2_BLOCK_SIZE));
		m = min(n - tot, EXT2_BLOCK_SIZE - off % EXT2_BLOCK_SIZE);
		kmemmove(buffer_p->data + off % EXT2_BLOCK_SIZE, src, m);
		ext2_vfs_ops.bwrite(buffer_p);
		ext2_vfs_ops.brelease(buffer_p);
	}

	if(n > 0 && off > ip->size){
		ip->size = off;
		ext2_inode_ops.iupdate(ip);
	}

	return n;
}

int ext2_dir_link(struct inode * dp, char * name, unsigned int inum, unsigned int type)
{
	int prev_name_length = kstrlen(name);
	struct buf * buffer_p;
	unsigned short prev_record_length = EXT2_DIR_REC_LEN(prev_name_length);
	unsigned short record_length, name_length;
	char * dir_end;
	struct ext2_dir_entry * directory_entry;
	int n;
	int num_blocks = (dp->size + EXT2_BLOCK_SIZE - 1) / EXT2_BLOCK_SIZE;

	if(ext2_dir_lookup(dp, name, 0)) {
		return -1;
	}

	for(n = 0; n <= num_blocks; n++) {
		buffer_p = ext2_vfs_ops.bread(dp->dev, ext2_inode_ops.bmap(dp, n));
		directory_entry = (struct ext2_dir_entry *) buffer_p->data;
		dir_end = (char *) buffer_p->data + ext2_last_byte(dp, n);

		while((char *)directory_entry <= (char *) buffer_p->data + EXT2_BLOCK_SIZE - prev_record_length) {
			if((char *)directory_entry == dir_end) {
				name_length = 0;
				record_length = EXT2_BLOCK_SIZE;
				directory_entry->record_length = EXT2_BLOCK_SIZE;
				directory_entry->inode = 0;
				goto got_it;
			}

			if(directory_entry->record_length == 0) {
				return -1;
			}

			name_length = EXT2_DIR_REC_LEN(directory_entry->name_length);
			record_length = directory_entry->record_length;

			if(!directory_entry->inode && record_length >= prev_record_length) {
				goto got_it;
			}

			if(record_length >= name_length + prev_record_length) {
				goto got_it;
			}

			directory_entry = (struct ext2_dir_entry *) ((char *) directory_entry + record_length);
		}

		ext2_vfs_ops.brelease(buffer_p);
	}

	return -1;

got_it:
	if(directory_entry->inode) {
		struct ext2_dir_entry * temp = (struct ext2_dir_entry *) ((char *) directory_entry + name_length);
		temp->record_length = record_length - name_length;
		directory_entry->record_length = name_length;
		directory_entry = temp;
	}

	directory_entry->name_length = prev_name_length;
	kstrncpy(directory_entry->name, name, prev_name_length);
	directory_entry->inode = inum;

	if(type == T_DIR) {
		directory_entry->file_type = EXT2_DIR_DIR;
	} else if(type == T_FILE) {
		directory_entry->file_type = EXT2_DIR_REGULAR;
	} else if(type == T_DEVICE) {
		directory_entry->file_type = EXT2_DIR_CHAR_DEV;
	} else {
		panic("ext2_dir_link(): Invalid inode mode");
	}

	ext2_vfs_ops.bwrite(buffer_p);
	ext2_vfs_ops.brelease(buffer_p);

	if ((n + 1) * EXT2_BLOCK_SIZE > dp->size) {
		dp->size += record_length;
		ext2_inode_ops.iupdate(dp);
	}

	return 0;
}

struct inode * ext2_idup(struct inode * ip)
{
	acquire(&itable.lock);
	ip->ref++;
	release(&itable.lock);
	return ip;
}

void ext2_iput(struct inode * ip)
{
	acquire(&itable.lock);

	if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
		if(ip->flags & I_BUSY) {
			panic("ext2_iput(): Inode busy");
		}

		ip->flags |= I_BUSY;
		release(&itable.lock);

		ext2_inode_ops.itrunc(ip);
		ip->type = 0;
		ext2_inode_ops.iupdate(ip);

		for(int i = 0; i < NINODE; i++) {
			if(ip->ext2_inode == &ext2_active_inodes.inodes[i]) {
				ext2_active_inodes.reserved[i] = INODE_FREE;
				ip->ext2_inode = NULL;
				break;
			}
		}

		acquire(&itable.lock);

		ip->flags = 0;
	}

	ip->ref--;
	release(&itable.lock);
}

void ext2_iunlockput(struct inode * ip)
{
	ext2_inode_ops.iunlock(ip);
	ext2_inode_ops.iput(ip);
}