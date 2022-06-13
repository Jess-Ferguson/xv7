#include <kernel/find_bits.h>
#include <kernel/defs.h>

unsigned int find_next_zero_bit(const unsigned int *addr, unsigned int size, unsigned int offset)
{
	const unsigned int *p = addr + BITOP_WORD(offset);
	unsigned int result = offset & ~(BITS_PER_INT-1);
	unsigned int tmp;

	if(offset >= size) {
		return size;
	}

	size -= result;
	offset %= BITS_PER_INT;
	
	if(offset) {
		tmp = *(p++);
		tmp |= ~0U >> (BITS_PER_INT - offset);
		if(size < BITS_PER_INT) {
			goto found_first;
		}

		if(~tmp) {
			goto found_middle;
		}

		size -= BITS_PER_INT;
		result += BITS_PER_INT;
	}
	
	while(size & ~(BITS_PER_INT-1)) {
		if(~(tmp = *(p++))) {
			goto found_middle;
		}
		
		result += BITS_PER_INT;
		size -= BITS_PER_INT;
	}
	
	if(!size) {
		return result;
	}

	tmp = *p;

found_first:
	tmp |= ~0U << size;
	
	if (tmp == ~0U)/* Are any bits zero? */
		return result + size;	 /* Nope. */
found_middle:
	return result + find_first_zero_bit(tmp);
}