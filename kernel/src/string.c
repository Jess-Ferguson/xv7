#include <kernel/types.h>

void*
kmemset(void *dst, int c, uint n)
{
	char *cdst = (char *) dst;
	int i;
	for(i = 0; i < n; i++){
		cdst[i] = c;
	}
	return dst;
}

int
kmemcmp(const void *v1, const void *v2, uint n)
{
	const uchar *s1, *s2;

	s1 = v1;
	s2 = v2;
	while(n-- > 0){
		if(*s1 != *s2)
			return *s1 - *s2;
		s1++, s2++;
	}

	return 0;
}

void*
kmemmove(void *dst, const void *src, uint n)
{
	const char *s;
	char *d;

	if(n == 0)
		return dst;
	
	s = src;
	d = dst;
	if(s < d && s + n > d){
		s += n;
		d += n;
		while(n-- > 0)
			*--d = *--s;
	} else
		while(n-- > 0)
			*d++ = *s++;

	return dst;
}

// memcpy exists to placate GCC.	Use memmove.
void*
kmemcpy(void *dst, const void *src, uint n)
{
	return kmemmove(dst, src, n);
}

int
kstrncmp(const char *p, const char *q, uint n)
{
	while(n > 0 && *p && *p == *q)
		n--, p++, q++;
	if(n == 0)
		return 0;
	return (uchar)*p - (uchar)*q;
}

char*
kstrncpy(char *s, const char *t, int n)
{
	char *os;

	os = s;
	while(n-- > 0 && (*s++ = *t++) != 0)
		;
	while(n-- > 0)
		*s++ = 0;
	return os;
}

// Like strncpy but guaranteed to NUL-terminate.
char*
ksafestrcpy(char *s, const char *t, int n)
{
	char *os;

	os = s;
	if(n <= 0)
		return os;
	while(--n > 0 && (*s++ = *t++) != 0)
		;
	*s = 0;
	return os;
}

int
kstrlen(const char *s)
{
	int n;

	for(n = 0; s[n]; n++)
		;
	return n;
}

void * kmemscan(void * addr, int c, int size)
{
	unsigned char *p = addr;

	while(size) {
		if(*p == c)
			return (void *)p;

		p++;
		size--;
	}

	return (void *)p;
}