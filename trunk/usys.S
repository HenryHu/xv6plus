#include "syscall.h"
#include "traps.h"

#define STUB(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

STUB(fork)
STUB(exit)
STUB(wait)
STUB(pipe)
STUB(read)
STUB(write)
STUB(close)
STUB(kill)
STUB(exec)
STUB(open)
STUB(mknod)
STUB(unlink)
STUB(fstat)
STUB(link)
STUB(mkdir)
STUB(chdir)
STUB(dup)
STUB(getpid)
STUB(sbrk)
STUB(sleep)
STUB(upmsec)
STUB(socket)
STUB(bind)
STUB(listen)
STUB(accept)
STUB(recv)
STUB(recvfrom)
STUB(send)
STUB(sendto)
STUB(shutdown)
STUB(getsockopt)
STUB(setsockopt)
STUB(sockclose)
STUB(connect)
STUB(getpeername)
STUB(getsockname)

