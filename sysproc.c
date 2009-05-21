#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "lwip/include/lwip/sockets.h"

int
sys_fork(void)
{
  struct proc *np;

  if((np = copyproc(cp)) == 0)
    return -1;
  np->state = RUNNABLE;
  return np->pid;
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return cp->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  if((addr = growproc(n)) < 0)
    return -1;
  setupsegs(cp);
  return addr;
}

int
sys_sleep(void)
{
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(cp->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

int
sys_upmsec(void)
{
    return millitime();
}

int 
sys_accept(void)
{
    int s;
    struct sockaddr *addr;
    socklen_t *addrlen;
    if((argint(0, &s)<0) || 
            (argptr(1, &addr, sizeof(struct sockaddr))<0) ||
            (argptr(2, &addrlen, sizeof(socklen_t))<0))
        return -1;
    return lwip_accept(s, addr, addrlen);
}

int 
sys_bind(void)
{
    int s;
    struct sockaddr *name;
    socklen_t *namelen;
    if((argint(0, &s)<0) || 
            (argptr(1, &name, sizeof(struct sockaddr))<0) ||
            (argptr(2, &namelen, sizeof(socklen_t))<0))
        return -1;
    return lwip_bind(s, name, namelen);
}

int 
sys_shutdown(void)
{
    int s;
    int how;
    if ((argint(0, &s)<0) || (argint(1, &how) < 0))
        return -1;
    return lwip_shutdown(s, how);
}

int 
sys_getsockopt(void)
{
    int s;
    int level;
    int optname;
    void *optval;
    socklen_t *optlen;
    if ((argint(0, &s)<0) ||
        (argint(1, &level)<0) ||
        (argint(2, &optname)<0) ||
        (argptr(4, &optlen, sizeof(socklen_t))<0) ||
        (argptr(3, &optval, 0)<0))
        return -1;
    return lwip_getsockopt(s, level, optname, optval, optlen);
}

int sys_setsockopt(void)
{
    int s;
    int level;
    int optname;
    void *optval;
    socklen_t *optlen;
    if ((argint(0, &s)<0) ||
        (argint(1, &level)<0) ||
        (argint(2, &optname)<0) ||
        (argptr(4, &optlen, sizeof(socklen_t))<0) ||
        (argptr(3, &optval, *optlen)<0))
        return -1;
    return lwip_setsockopt(s, level, optname, optval, optlen);
}

int sys_sockclose(void)
{
    int s;
    if (argint(0, &s) <0)
        return -1;
    return lwip_close(s);
}

int sys_connect(void)
{
    int s;
    struct sockaddr *name;
    socklen_t *namelen;
    if((argint(0, &s)<0) || 
            (argptr(1, &name, sizeof(struct sockaddr))<0) ||
            (argptr(2, &namelen, sizeof(socklen_t))<0))
        return -1;
    return lwip_connect(s, name, namelen);
}

int sys_listen(void)
{
    int s;
    int backlog;
    if ((argint(0, &s)<0) ||
        (argint(1, &backlog)<0))
        return -1;
    return lwip_listen(s, backlog);
}

int sys_recv(void)
{
    int s;
    void *mem;
    int len;
    unsigned int flags;
    if ((argint(0, &s)<0) ||
        (argint(2, &len)<0) ||
        (argptr(1, &mem, len)<0) ||
        (argint(3, &flags)<0))
        return -1;
    return lwip_recv(s, mem, len, flags);
}

int sys_recvfrom(void)
{
    int s;
    void *mem;
    int len;
    unsigned int flags;
    struct sockaddr *from;
    socklen_t *fromlen;
    if ((argint(0, &s)<0) ||
        (argint(2, &len)<0) ||
        (argptr(1, &mem, len)<0) ||
        (argint(3, &flags)<0) ||
        (argptr(4, &from, 0)<0) ||
        (argptr(5, &fromlen, sizeof(socklen_t))<0))
        return -1;
    return lwip_recvfrom(s, mem, len, flags, from, fromlen);
}

int sys_send(void)
{
    int s;
    void *dataptr;
    int size;
    unsigned int flags;
    if ((argint(0, &s)<0) ||
        (argint(2, &size)<0) ||
        (argptr(1, &dataptr, size)<0) ||
        (argint(3, &flags)<0))
        return -1;
    return lwip_send(s, dataptr, size, flags);
}

int sys_sendto(void)
{
    int s;
    void *dataptr;
    int size;
    unsigned int flags;
    struct sockaddr *to;
    socklen_t *tolen;
    if ((argint(0, &s)<0) ||
        (argint(2, &size)<0) ||
        (argptr(1, &dataptr, size)<0) ||
        (argint(3, &flags)<0) ||
        (argptr(5, &tolen, sizeof(socklen_t))<0) ||
        (argptr(4, &to, *tolen)<0))
        return -1;
    return lwip_send(s, dataptr, size, flags);
}

int sys_socket(void)
{
    int domain;
    int type;
    int protocol;
    if ((argint(0, &domain)<0) ||
        (argint(1, &type)<0) ||
        (argint(2, &protocol)<0))
        return -1;
    return lwip_socket(domain, type, protocol);
}

int
sys_getpeername(void)
{
    int s;
    struct sockaddr *name;
    socklen_t *namelen;
    if((argint(0, &s)<0) || 
            (argptr(1, &name, sizeof(struct sockaddr))<0) ||
            (argptr(2, &namelen, sizeof(socklen_t))<0))
        return -1;
    return lwip_getpeername(s, name, namelen);
}

int
sys_getsockname(void)
{
    int s;
    struct sockaddr *name;
    socklen_t *namelen;
    if((argint(0, &s)<0) || 
            (argptr(1, &name, sizeof(struct sockaddr))<0) ||
            (argptr(2, &namelen, sizeof(socklen_t))<0))
        return -1;
    return lwip_getsockname(s, name, namelen);
}

