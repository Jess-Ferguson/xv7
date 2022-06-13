#ifndef XV6_FIND_BITS_H_
#define XV6_FIND_BITS_H_

unsigned int find_next_zero_bit(const unsigned int *addr, unsigned int size, unsigned int offset);

#define BITS_PER_INT 32

#define BITOP_WORD(nr) ((nr) / BITS_PER_INT)

static inline unsigned int find_first_zero_bit(unsigned int word)
{
	for(int bit = 0; bit < 8 * sizeof(word); bit++) {
		if(~(word & (1 << bit))) {
			return bit;
		}
	}
}

#endif
