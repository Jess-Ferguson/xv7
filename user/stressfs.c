// Demonstrate that moving the "acquire" in iderw after the loop that
// appends to the idequeue results in a race.

// For this to work, you should also add a spin within iderw's
// idequeue traversal loop.  Adding the following demonstrated a panic
// after about 5 runs of stressfs in QEMU on a 2.1GHz CPU:
//    for (i = 0; i < 40000; i++)
//      asm volatile("");

#include <kernel/types.h>
#include <kernel/stat.h>
#include <kernel/vfs.h>
#include <kernel/fcntl.h>

#include "user/user.h"

int
main(int argc, char *argv[])
{
	int fd, i;
	char path[] = "stressfs0";
	char data[512];

	printf("stressfs starting\n");
	memset(data, 'a', sizeof(data));

	for(i = 0; i < 4; i++) {
		if(fork() > 0) {
			break;
		}
	}

	path[8] += i;

	printf("%d: Opening file %s\n", i, path);

	fd = open(path, O_CREATE | O_RDWR);

	printf("%d: Writing data\n", i);

	for(i = 0; i < 20; i++) {
		//printf("%d: Writing %d to %d\n", i, i, fd);
		write(fd, data, sizeof(data));
	}

	close(fd);
	printf("%d: read\n", i);

	fd = open(path, O_RDONLY);

	for (i = 0; i < 20; i++) {
		read(fd, data, sizeof(data));
	}

	close(fd);
	wait(0);
	exit(0);
}
