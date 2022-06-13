#ifndef _TYPES_H
#define _TYPES_H

typedef unsigned int	 uint;
typedef unsigned short ushort;
typedef unsigned char	uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int	uint32;
typedef unsigned long uint64;

typedef uint64 pde_t;

#include <kernel/defs.h>

static inline int find_last_set_bit(int x)
{
	for(int bit = 31; bit > 0; bit--) {
		if(x & (1 << bit)) {
			return bit + 1;
		}
	}

	return 0;
}

static inline __attribute__((const)) int ilog2(uint32 n)
{
	return find_last_set_bit(n) - 1;
}

static inline int test_bit(long nr, volatile const unsigned long * addr)
{
	return (*addr & (1 << nr)) >> nr;
}

static inline int test_and_set_bit(long nr, volatile unsigned long * addr)
{
	unsigned long ret = test_bit(nr, addr);

	*addr |= (1 << nr);

	return ret;
}

static inline int test_and_clear_bit(long nr, volatile unsigned long * addr)
{
	unsigned long ret = test_bit(nr, addr);

	*addr &= ~(1 << nr);

	return ret;
}

#endif