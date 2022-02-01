#ifndef _EXT2_H
#define _EXT2_H

#define EXT2_BLOCK_SIZE 1024
#define EXT2_MAGIC 0xEF53

struct ext2_superblock {
	uint32 inode_count;
	uint32 block_count;
	uint32 superuser_block_count;
	uint32 unalloc_block_count;
	uint32 unalloc_inode_count;
	uint32 superblock_block;
	uint32 block_size;
	uint32 s_log_block_size;  /* Block size */
	uint32 s_log_frag_size;  /* Fragment size */
	uint32 fragment_count;
	uint32 inodes_per_block;
	uint32 last_mount_time;
	uint32 last_write_time;
	uint16 mounts_since_const_check;
	uint16 maximal_mount_count;
	uint16 magic_number;
	uint16 fs_state;
	uint16 error_detected;
	uint16 minor_version;
	uint32 last_const_check_time;
	uint32 last_forced_const_check_time;
	uint32 os_creation_id;
	uint32 major_version;
	uint16 reserved_blocks_uid;
	uint16 reserved_blocks_gid;
};

#endif