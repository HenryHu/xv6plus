OBJS = \
	bio.o\
	console.o\
	exec.o\
	file.o\
	fs.o\
	ide.o\
	ioapic.o\
	kalloc.o\
	kbd.o\
	lapic.o\
	main.o\
	mp.o\
	picirq.o\
	pipe.o\
	proc.o\
	spinlock.o\
	string.o\
	swtch.o\
	syscall.o\
	sysfile.o\
	sysproc.o\
	timer.o\
	trapasm.o\
	trap.o\
	vectors.o\
	pci.o\
	assert.o \
	sem.o \
	thread.o \
	${DRIVER_OBJS} \
	${LWIP_OBJS} \
	${LWIP_ARCH_OBJS} \

DRIVER_OBJS = \
			  e100.o

LWIP_OBJS = \
            lwip/netif/etharp.o\
            lwip/netif/ethernetif.o\
            lwip/netif/loopif.o\
            lwip/core/ipv4/ip_addr.o\
            lwip/core/ipv4/icmp.o\
            lwip/core/ipv4/ip.o\
            lwip/core/ipv4/ip_frag.o\
            lwip/core/inet.o\
            lwip/core/mem.o\
            lwip/core/memp.o\
            lwip/core/netif.o\
            lwip/core/pbuf.o\
            lwip/core/raw.o\
            lwip/core/stats.o\
            lwip/core/sys.o\
            lwip/core/tcp.o\
            lwip/core/tcp_out.o\
            lwip/core/tcp_in.o\
            lwip/core/udp.o\
            lwip/core/dhcp.o\
            lwip/api/api_lib.o\
            lwip/api/api_msg.o\
            lwip/api/err.o\
            lwip/api/sockets.o\
            lwip/api/tcpip.o\
#            lwip/core/ipv6/ip6_addr.o\
#            lwip/core/ipv6/icmp6.o\
#            lwip/core/ipv6/ip6.o\
#            lwip/core/inet6.o\
#			lwip/netif/ppp/auth.o\
#			lwip/netif/ppp/chap.o\
#            lwip/netif/ppp/chpms.o\
#            lwip/netif/ppp/fsm.o\
#            lwip/netif/ppp/ipcp.o\
#            lwip/netif/ppp/lcp.o\
#            lwip/netif/ppp/magic.o\
#            lwip/netif/ppp/md5.o\
#            lwip/netif/ppp/pap.o\
#            lwip/netif/ppp/ppp.o\
#            lwip/netif/ppp/randm.o\
#            lwip/netif/ppp/vj.o\
#            lwip/netif/slipif.o\

LWIP_ARCH_OBJS = \
			lwip/xv6/arch/sys_arch.o \

LWIP_INC = -Ilwip/include -Ilwip/xv6 -Ilwip/include/ipv4

# Cross-compiling (e.g., on Mac OS X)
# TOOLPREFIX = i386-jos-elf-

# Using native tools (e.g., on X86 Linux)
TOOLPREFIX = 

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
CFLAGS = -fno-builtin -O0 -Wall -MMD -ggdb ${LWIP_INC}
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)

xv6.img: bootblock kernel fs.img
	dd if=/dev/zero of=xv6.img count=10000
	dd if=bootblock of=xv6.img conv=notrunc
	dd if=kernel of=xv6.img seek=1 conv=notrunc

bootblock: bootasm.S bootmain.c
	$(CC) -O -nostdinc -I. -c bootmain.c
	$(CC) -nostdinc -I. -c bootasm.S
	$(LD) -N -e start -Ttext 0x7C00 -o bootblock.o bootasm.o bootmain.o
	$(OBJDUMP) -S bootblock.o > bootblock.asm
	$(OBJCOPY) -S -O binary bootblock.o bootblock
	./sign.pl bootblock

bootother: bootother.S
	$(CC) -nostdinc -I. -c bootother.S
	$(LD) -N -e start -Ttext 0x7000 -o bootother.out bootother.o
	$(OBJCOPY) -S -O binary bootother.out bootother
	$(OBJDUMP) -S bootother.o > bootother.asm

initcode: initcode.S
	$(CC) -nostdinc -I. -c initcode.S
	$(LD) -N -e start -Ttext 0 -o initcode.out initcode.o
	$(OBJCOPY) -S -O binary initcode.out initcode
	$(OBJDUMP) -S initcode.o > initcode.asm

kernel: $(OBJS) bootother initcode
	$(LD) -Ttext 0x100000 -e main -o kernel $(OBJS) -b binary initcode bootother
	$(OBJDUMP) -S kernel > kernel.asm
	$(OBJDUMP) -t kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > kernel.sym

tags: $(OBJS) bootother.S _init
	etags *.S *.c

vectors.S: vectors.pl
	perl vectors.pl > vectors.S

ULIB = ulib.o usys.o printf.o umalloc.o lwip/core/inet.o

_%: %.o $(ULIB)
	$(LD) -N -e main -Ttext 0 -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

_forktest: forktest.o $(ULIB)
	# forktest has less library code linked in - needs to be small
	# in order to be able to max out the proc table.
	$(LD) -N -e main -Ttext 0 -o _forktest forktest.o ulib.o usys.o
	$(OBJDUMP) -S _forktest > forktest.asm

mkfs: mkfs.c fs.h
	gcc -Wall -o mkfs mkfs.c

UPROGS=\
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
	_usertests\
	_wc\
	_zombie\
	_tcpecho \
	_httpd \
#	_uptime \

fs.img: mkfs README $(UPROGS)
	./mkfs fs.img README $(UPROGS)

DFILES = $(shell find . -name '*.d')
-include ${DFILES}

clean: 
	rm -f *.tex *.dvi *.idx *.aux *.log *.ind *.ilg \
	*.o *.d *.asm *.sym vectors.S parport.out \
	bootblock kernel xv6.img fs.img mkfs \
	$(UPROGS) \
	${LWIP_OBJS} \

# make a printout
FILES = $(shell grep -v '^\#' runoff.list)
PRINT = runoff.list $(FILES)

xv6.pdf: $(PRINT)
	./runoff

print: xv6.pdf

# run in emulators

bochs : fs.img xv6.img
	if [ ! -e .bochsrc ]; then ln -s dot-bochsrc .bochsrc; fi
	bochs -q

ctags:
	exctags --recurse *.c *.h lwip/
	sed -i.bak -E -e 's/::__anon[[:digit:]]*//g' tags
	rm tags.bak

qemu: ctags fs.img xv6.img
	sudo qemu -monitor stdio -drive file=fs.img,if=ide,index=1,media=disk,cache=writethrough,format=raw,serial=12345678 -hda xv6.img -net nic,model=i82559er -boot c -smp 1 -net tap,script=/usr/local/etc/qemu-ifup,downscript=/usr/local/etc/qemu-ifdown -s 
#	qemu -hdb fs.img xv6.img -S

qemud: ctags fs.img xv6.img
	sudo qemu -monitor stdio -drive file=fs.img,if=ide,index=1,media=disk,cache=writethrough,format=raw,serial=12345678 -hda xv6.img -net nic,model=i82559er -boot c -smp 1 -net tap,script=/usr/local/etc/qemu-ifup,downscript=/usr/local/etc/qemu-ifdown -s -S
