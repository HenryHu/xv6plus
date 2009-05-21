10100 #include "syscall.h"
10101 #include "traps.h"
10102 
10103 #define STUB(name) \
10104   .globl name; \
10105   name: \
10106     movl $SYS_ ## name, %eax; \
10107     int $T_SYSCALL; \
10108     ret
10109 
10110 STUB(fork)
10111 STUB(exit)
10112 STUB(wait)
10113 STUB(pipe)
10114 STUB(read)
10115 STUB(write)
10116 STUB(close)
10117 STUB(kill)
10118 STUB(exec)
10119 STUB(open)
10120 STUB(mknod)
10121 STUB(unlink)
10122 STUB(fstat)
10123 STUB(link)
10124 STUB(mkdir)
10125 STUB(chdir)
10126 STUB(dup)
10127 STUB(getpid)
10128 STUB(sbrk)
10129 STUB(sleep)
10130 STUB(upmsec)
10131 STUB(socket)
10132 STUB(bind)
10133 STUB(listen)
10134 STUB(accept)
10135 STUB(recv)
10136 STUB(recvfrom)
10137 STUB(send)
10138 STUB(sendto)
10139 STUB(shutdown)
10140 STUB(getsockopt)
10141 STUB(setsockopt)
10142 STUB(sockclose)
10143 STUB(connect)
10144 STUB(getpeername)
10145 STUB(getsockname)
10146 
10147 
10148 
10149 
