KERNEL_DIR := kernel
USER_DIR := user
KERNEL_OBJ_DIR := $(KERNEL_DIR)/obj
KERNEL_SRC_DIR := $(KERNEL_DIR)/src
KERNEL_INCLUDE_DIR := $(KERNEL_DIR)/include
XV6_FS_TOOL_DIR := mkxv6fs

_KERNEL_OBJS := \
	start.o \
	console.o \
	printf.o \
	uart.o \
	kalloc.o \
	spinlock.o \
	string.o \
	main.o \
	vm.o \
	proc.o \
	trap.o \
	syscall.o \
	sysproc.o \
	bio.o \
	vfs.o \
	log.o \
	sleeplock.o \
	file.o \
	pipe.o \
	exec.o \
	sysfile.o \
	plic.o \
	virtio_disk.o \
	xv6fs.o \
	ext2.o \
	find_bits.o

_KERNEL_ASM_OBJS := \
	entry.o \
	kernelvec.o \
	swtch.o \
	trampoline.o \

_KERNEL_DEPS := \
	buf.h \
	date.h \
	defs.h \
	elf.h \
	ext2.h \
	fcntl.h \
	file.h \
	find_bits.h \
	memlayout.h \
	param.h \
	proc.h \
	riscv.h \
	sleeplock.h \
	spinlock.h \
	stat.h \
	syscall.h \
	types.h \
	vfs.h \
	virtio.h \

KERNEL_OBJS = $(patsubst %,$(KERNEL_OBJ_DIR)/%,$(_KERNEL_OBJS))
KERNEL_ASM_OBJS = $(patsubst %,$(KERNEL_OBJ_DIR)/%,$(_KERNEL_ASM_OBJS))
KERNEL_DEPS = $(patsubst %,$(KERNEL_INCLUDE_DIR)/%,$(_KERNEL_DEPS))

# riscv64-unknown-elf- or riscv64-linux-gnu-
# perhaps in /opt/riscv/bin
#TOOLPREFIX = 

# Try to infer the correct TOOLPREFIX if not set
ifndef TOOLPREFIX
TOOLPREFIX := $(shell if riscv64-unknown-elf-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-unknown-elf-'; \
	elif riscv64-linux-gnu-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-linux-gnu-'; \
	elif riscv64-unknown-linux-gnu-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-unknown-linux-gnu-'; \
	else echo "***" 1>&2; \
	echo "*** Error: Couldn't find a riscv64 version of GCC/binutils." 1>&2; \
	echo "*** To turn off this error, run 'gmake TOOLPREFIX= ...'." 1>&2; \
	echo "***" 1>&2; exit 1; fi)
endif

QEMU = qemu-system-riscv64

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

CFLAGS = -O -fno-omit-frame-pointer -ggdb -Wall -Wextra -Wpedantic
CFLAGS += -MD -g
CFLAGS += -mcmodel=medany
CFLAGS += -ffreestanding -fno-common -nostdlib -mno-relax
CFLAGS += -I. -isystem$(KERNEL_INCLUDE_DIR)/
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)

# Disable PIE when possible (for Ubuntu 16.10 toolchain)
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]no-pie'),)
CFLAGS += -fno-pie -no-pie
endif
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]nopie'),)
CFLAGS += -fno-pie -nopie
endif

LDFLAGS = -z max-page-size=4096

$(KERNEL_DIR)/kernel: $(KERNEL_ASM_OBJS) $(KERNEL_OBJS) $(KERNEL_SRC_DIR)/kernel.ld $(USER_DIR)/initcode
	$(LD) $(LDFLAGS) -T $(KERNEL_SRC_DIR)/kernel.ld -o $(KERNEL_DIR)/kernel $(KERNEL_ASM_OBJS) $(KERNEL_OBJS)
	$(OBJDUMP) -S $(KERNEL_DIR)/kernel > $(KERNEL_DIR)/kernel.asm
	$(OBJDUMP) -t $(KERNEL_DIR)/kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(KERNEL_DIR)/kernel.sym

$(USER_DIR)/initcode: $(USER_DIR)/initcode.S
	@echo [CC] $(CC) -c -o $@ $< $(CFLAGS)
	$(CC) $(CFLAGS) -march=rv64g -nostdinc -I. -isystem$(KERNEL_INCLUDE_DIR) -c $(USER_DIR)/initcode.S -o $(USER_DIR)/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o $(USER_DIR)/initcode.out $(USER_DIR)/initcode.o
	$(OBJCOPY) -S -O binary $(USER_DIR)/initcode.out $(USER_DIR)/initcode
	$(OBJDUMP) -S $(USER_DIR)/initcode.o > $(USER_DIR)/initcode.asm

$(KERNEL_OBJ_DIR)/%.o: $(KERNEL_SRC_DIR)/%.S
	@echo [CC] $(CC) -c -o $@ $< $(CFLAGS)
	@$(CC) -c -o $@ $< $(CFLAGS)

$(KERNEL_OBJ_DIR)/%.o: $(KERNEL_SRC_DIR)/%.c
	@echo [CC] $(CC) -c -o $@ $< $(CFLAGS)
	@$(CC) -c -o $@ $< $(CFLAGS)

tags: $(OBJS) _init
	etags *.S *.c

ULIB = $(USER_DIR)/ulib.o $(USER_DIR)/usys.o $(USER_DIR)/printf.o $(USER_DIR)/umalloc.o

_%: %.o $(ULIB)
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

$(USER_DIR)/usys.S : $(USER_DIR)/usys.pl
	perl $(USER_DIR)/usys.pl > $(USER_DIR)/usys.S

$(USER_DIR)/usys.o : $(USER_DIR)/usys.S
	$(CC) $(CFLAGS) -c -o $(USER_DIR)/usys.o $(USER_DIR)/usys.S

$(USER_DIR)/_forktest: $(USER_DIR)/forktest.o $(ULIB)
	# forktest has less library code linked in - needs to be small
	# in order to be able to max out the proc table.
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $(USER_DIR)/_forktest $(USER_DIR)/forktest.o $(USER_DIR)/ulib.o $(USER_DIR)/usys.o
	$(OBJDUMP) -S $(USER_DIR)/_forktest > $(USER_DIR)/forktest.asm

mkxv6fs: $(XV6_FS_TOOL_DIR)/mkxv6fs.c
	gcc -Werror -Wall -I/usr/include -I. -I$(KERNEL_INCLUDE_DIR) -o $(XV6_FS_TOOL_DIR)/$@ $^

# Prevent deletion of intermediate files, e.g. cat.o, after first build, so
# that disk image changes after first build are persistent until clean.	More
# details:
# http://www.gnu.org/software/make/manual/html_node/Chained-Rules.html
.PRECIOUS: %.o

_UPROGS=\
	_cat\
	_echo\
	_forktest\
	_grep\
	_init\
	_kill\
	_ln\
	_ls\
	_mkdir\
	_rm\
	_sh\
	_stressfs\
	_usertests\
	_grind\
	_wc\
	_zombie\

UPROGS = $(patsubst %,$(USER_DIR)/%,$(_UPROGS))

-include $(KERNEL_DIR)/$(OBJ_DIR)/*.d user/*.d

clean: 
	rm -f *.tex *.dvi *.idx *.aux *.log *.ind *.ilg \
	*/*.o */*.d */*.asm */*.sym \
	*/*/*.o */*/*.d */*/*.asm */*/*.sym \
	$(USER_DIR)/initcode $(USER_DIR)/initcode.out $(KERNEL_DIR)/kernel \
	 .gdbinit $(USER_DIR)/usys.S $(UPROGS) fs.img

# try to generate a unique GDB port
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
# QEMU's gdb stub command line changed in 0.11
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)
ifndef CPUS
CPUS := 3
endif

QEMUOPTS = -machine virt -bios none -kernel $(KERNEL_DIR)/kernel -m 128M -smp $(CPUS) -nographic
QEMUOPTS += -drive file=fs.img,if=none,format=raw,id=x0
QEMUOPTS += -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0

xv6fs: mkxv6fs README $(UPROGS)
	$(XV6_FS_TOOL_DIR)/mkxv6fs fs.img README $(UPROGS)

ext2fs: README $(UPROGS)
	mv $(UPROGS) mnt/
	rename 's/_//;' mnt/*
	sudo mke2fs -b 1024 -d mnt fs.img 2500
	sudo chown $(shell whoami) fs.img

ext2: ext2fs $(KERNEL_DIR)/kernel
	$(QEMU) $(QEMUOPTS)

xv6: xv6fs $(KERNEL_DIR)/kernel 
	$(QEMU) $(QEMUOPTS)

.gdbinit: .gdbinit.tmpl-riscv
	sed "s/:1234/:$(GDBPORT)/" < $^ > $@

ext2-gdb: ext2fs .gdbinit
	@echo "*** Now run 'gdb' in another window." 1>&2
	$(QEMU) $(QEMUOPTS) -S $(QEMUGDB)

xv6-gdb: xv6fs .gdbinit
	@echo "*** Now run 'gdb' in another window." 1>&2
	$(QEMU) $(QEMUOPTS) -S $(QEMUGDB)
