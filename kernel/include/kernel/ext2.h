#ifndef _EXT2_H
#define _EXT2_H

#define EXT2_MAGIC				0xEF53
#define EXT2_BLOCK_SIZE			1024
#define EXT2_BLOCK_SIZE_SHIFT	1024
#define EXT2_VERSION_ONE		0
#define EXT2_VERSION_TWO		1

#define EXT2_SUPERBLOCK_BLOCK		1
#define EXT2_INODE_SIZE				256
#define EXT2_FIRST_INODE			11
#define EXT2_MAX_BLOCK_GROUP_COUNT	40
#define EXT2_ROOT_INODE				2

#define EXT2_DIR_BLOCK_COUNT	12
#define EXT2_IND_BLOCK			EXT2_DIR_BLOCK_COUNT /* Offset of singly independent block pointer */
#define EXT2_DIND_BLOCK			(EXT2_IND_BLOCK + 1) /* Offset of doubly independent block pointer */
#define EXT2_TIND_BLOCK			(EXT2_DIND_BLOCK + 1) /* Offset of triply independent block pointer */
#define EXT2_N_BLOCK_COUNT		(EXT2_TIND_BLOCK + 1) /* Total number of block pointers */

#define EXT2_DIR_PAD					4
#define EXT2_DIR_ROUND					(EXT2_DIR_PAD - 1)
#define EXT2_DIR_REC_LEN(dir_name_len)	(((dir_name_len) + 8 + EXT2_DIR_ROUND) & ~EXT2_DIR_ROUND)
#define EXT2_MAX_REC_LEN				((1 << 16) - 1)

/* Inode types */

#define EXT2_FIFO		0x1000
#define EXT2_CHAR_DEV	0x2000
#define EXT2_DIR		0x4000
#define EXT2_BLOCK_DEV	0x6000
#define EXT2_FILE		0x8000
#define EXT2_SYM_LINK	0xA000
#define EXT2_SOCKET		0xC000

/* Inode permissions */

#define EXT2_OTHER_EXEC		0x001
#define EXT2_OTHER_WRITE	0x002
#define EXT2_OTHER_READ		0x004
#define EXT2_GROUP_EXEC		0x008
#define EXT2_GROUP_WRITE	0x010
#define EXT2_GROUP_READ		0x020
#define EXT2_USER_EXEC		0x040
#define EXT2_USER_WRITE		0x080
#define EXT2_USER_READ		0x100
#define EXT2_STICKY_BIT		0x200
#define EXT2_SET_GID		0x400
#define EXT2_SET_UID		0x800

/* Directory entry type indicators */

#define EXT2_DIR_UNKNOWN	0
#define EXT2_DIR_REGULAR	1
#define EXT2_DIR_DIR		2
#define EXT2_DIR_CHAR_DEV	3
#define EXT2_DIR_BLOCK_DEV	4
#define EXT2_DIR_FIFO		5
#define EXT2_DIR_SOCKET		6
#define EXT2_DIR_SYM_LINK	7

/* Macros for determining the mode of an inode */

#define EXT2_IS_LINK(m)			(((m) & 0xF000) == EXT2_IFLNK)
#define EXT2_IS_DIR(m)			(((m) & 0xF000) == EXT2_DIR)
#define EXT2_IS_CHAR_DEV(m)     (((m) & 0xF000) == EXT2_CHAR_DEV)
#define EXT2_IS_BLOCK_DEV(m)	(((m) & 0xF000) == EXT2_BLOCK_DEV)
#define EXT2_IS_FIFO(m)			(((m) & 0xF000) == EXT2_FIFO)
#define EXT2_IS_SOCK(m)			(((m) & 0xF000) == EXT2_SOCKET)
#define EXT2_IS_FILE(m)			(((m) & 0xF000) == EXT2_FILE)

/* Macros for determining the permissions of an inode */

/* ext2 structures as they exist on disk */

struct ext2_superblock {
	unsigned int inode_count; /* Inode count */
	unsigned int block_count; /* Block count */
	unsigned int superuser_block_count; 
	unsigned int unalloc_block_count;
	unsigned int unalloc_inode_count;
	unsigned int superblock_block;
	unsigned int block_size;	/* Block size as power of 2. i.e. Take 1024 << super.block_size to get size in bytes */
	unsigned int log_frag_size; 
	unsigned int blocks_per_block_group;
	unsigned int fragments_per_block_group;
	unsigned int inodes_per_block_group;
	unsigned int last_mount_time;
	unsigned int last_write_time;
	unsigned short mounts_since_const_check;
	unsigned short maximal_mount_count;
	unsigned short magic_number;
	unsigned short fs_state;
	unsigned short error_detected;
	unsigned short minor_version;
	unsigned int last_const_check_time;
	unsigned int last_forced_const_check_time;
	unsigned int os_creation_id;
	unsigned int major_version;
	unsigned short reserved_blocks_uid;
	unsigned short reserved_blocks_gid;
	unsigned int first_inode;
	unsigned short inode_size;
	unsigned short block_group_number;
	unsigned int feature_compatible;
	unsigned int feature_incompatible;
	unsigned int feature_read_only_compatible;
	unsigned char uuid[16];
	unsigned char volume_name[16];
	unsigned char last_mounted[64];
	unsigned int algorithm_usage_bitmap;
	unsigned char prealloc_blocks;
	unsigned char prealloc_dir_blocks;
	unsigned short padding1;
	unsigned char journal_uuid[16];
	unsigned int journal_inum;
	unsigned int journal_dev;
	unsigned int last_orphan;
	unsigned int hash_seed[4];
	unsigned char def_hash_version;	
	unsigned char reserved_char_pad;
	unsigned short reserved_word_pad;
	unsigned int default_mount_opts;
	unsigned int first_meta_bg;
	unsigned int reserved[190];
};

struct ext2_inode {
	unsigned short mode;
	unsigned short uid;
	unsigned int size;
	unsigned int last_access_time;
	unsigned int creation_time;
	unsigned int last_modification_time;
	unsigned int deletion_time;
	unsigned short gid;
	unsigned short hard_link_count;
	unsigned int sector_count;
	unsigned int flags;
	unsigned int os_reserved_1;
	unsigned int blocks[EXT2_N_BLOCK_COUNT];
	unsigned int generation;
	unsigned int reserved[2];
	unsigned int block_fragment;
	unsigned int os_reserved_2[3];
};

struct ext2_group_descriptor {
	unsigned int block_bitmap;
	unsigned int inode_bitmap;
	unsigned int inode_table;
	unsigned short free_blocks_count;
	unsigned short free_inodes_count;
	unsigned short used_dirs_count;
	unsigned short padding;
	unsigned int reserved[3];
};

/* ext2 structures as they are represented in memory */

struct ext2_superblock_mem {
	unsigned long inodes_per_block;
	unsigned long blocks_per_block_group;
	unsigned long inodes_per_block_group;
	unsigned long inode_table_blocks_per_group;
	unsigned long group_descriptor_count;
	unsigned long group_descriptors_per_block;
	unsigned long group_count;
	unsigned long overhead_last;
	unsigned long block_count;
	struct buf * super_buffer;
	struct ext2_superblock * disk_super;
	struct buf * group_descriptors[EXT2_MAX_BLOCK_GROUP_COUNT];
	unsigned short padding;
	int address_per_block_bits;
	int descriptors_per_block_bits;
	int inode_size;
	int first_inode;
	unsigned long dir_count;
	unsigned char * debts;
	int flags;
	unsigned int block_size_bits;
};

struct ext2_inode_mem {
	struct ext2_inode inode;
};

struct ext2_dir_entry {
	unsigned int inode;
	unsigned short record_length;
	unsigned char name_length;
	unsigned char file_type;
	char name[];
};

#endif