3400 #include "types.h"
3401 #include "defs.h"
3402 #include "param.h"
3403 #include "mmu.h"
3404 #include "proc.h"
3405 #include "x86.h"
3406 #include "syscall.h"
3407 
3408 // User code makes a system call with INT T_SYSCALL.
3409 // System call number in %eax.
3410 // Arguments on the stack, from the user call to the C
3411 // library system call function. The saved user %esp points
3412 // to a saved program counter, and then the first argument.
3413 
3414 // Fetch the int at addr from process p.
3415 int
3416 fetchint(struct proc *p, uint addr, int *ip)
3417 {
3418   if(addr >= p->sz || addr+4 > p->sz)
3419     return -1;
3420   *ip = *(int*)(p->mem + addr);
3421   return 0;
3422 }
3423 
3424 // Fetch the nul-terminated string at addr from process p.
3425 // Doesn't actually copy the string - just sets *pp to point at it.
3426 // Returns length of string, not including nul.
3427 int
3428 fetchstr(struct proc *p, uint addr, char **pp)
3429 {
3430   char *s, *ep;
3431 
3432   if(addr >= p->sz)
3433     return -1;
3434   *pp = p->mem + addr;
3435   ep = p->mem + p->sz;
3436   for(s = *pp; s < ep; s++)
3437     if(*s == 0)
3438       return s - *pp;
3439   return -1;
3440 }
3441 
3442 // Fetch the nth 32-bit system call argument.
3443 int
3444 argint(int n, int *ip)
3445 {
3446   return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
3447 }
3448 
3449 
3450 // Fetch the nth word-sized system call argument as a pointer
3451 // to a block of memory of size n bytes.  Check that the pointer
3452 // lies within the process address space.
3453 int
3454 argptr(int n, char **pp, int size)
3455 {
3456   int i;
3457 
3458   if(argint(n, &i) < 0)
3459     return -1;
3460   if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
3461     return -1;
3462   *pp = cp->mem + i;
3463   return 0;
3464 }
3465 
3466 // Fetch the nth word-sized system call argument as a string pointer.
3467 // Check that the pointer is valid and the string is nul-terminated.
3468 // (There is no shared writable memory, so the string can't change
3469 // between this check and being used by the kernel.)
3470 int
3471 argstr(int n, char **pp)
3472 {
3473   int addr;
3474   if(argint(n, &addr) < 0)
3475     return -1;
3476   return fetchstr(cp, addr, pp);
3477 }
3478 
3479 extern int sys_chdir(void);
3480 extern int sys_close(void);
3481 extern int sys_dup(void);
3482 extern int sys_exec(void);
3483 extern int sys_exit(void);
3484 extern int sys_fork(void);
3485 extern int sys_fstat(void);
3486 extern int sys_getpid(void);
3487 extern int sys_kill(void);
3488 extern int sys_link(void);
3489 extern int sys_mkdir(void);
3490 extern int sys_mknod(void);
3491 extern int sys_open(void);
3492 extern int sys_pipe(void);
3493 extern int sys_read(void);
3494 extern int sys_sbrk(void);
3495 extern int sys_sleep(void);
3496 extern int sys_unlink(void);
3497 extern int sys_wait(void);
3498 extern int sys_write(void);
3499 extern int sys_upmsec(void);
3500 // BSD sockets
3501 extern int sys_accept(void);
3502 extern int sys_bind(void);
3503 extern int sys_shutdown(void);
3504 extern int sys_getsockopt(void);
3505 extern int sys_setsockopt(void);
3506 extern int sys_sockclose(void);
3507 extern int sys_connect(void);
3508 extern int sys_listen(void);
3509 extern int sys_recv(void);
3510 extern int sys_recvfrom(void);
3511 extern int sys_send(void);
3512 extern int sys_sendto(void);
3513 extern int sys_socket(void);
3514 extern int sys_getpeername (void);
3515 extern int sys_getsockname (void);
3516 //int lwip_read(int s, void *mem, int len);
3517 //int lwip_write(int s, void *dataptr, int size);
3518 //int lwip_select(int maxfdp1, fd_set *readset, fd_set *writeset, fd_set *exceptset,
3519 //                struct timeval *timeout);
3520 //extern int sys_sockioctl(void);
3521 
3522 static int (*syscalls[])(void) = {
3523 [SYS_chdir]   sys_chdir,
3524 [SYS_close]   sys_close,
3525 [SYS_dup]     sys_dup,
3526 [SYS_exec]    sys_exec,
3527 [SYS_exit]    sys_exit,
3528 [SYS_fork]    sys_fork,
3529 [SYS_fstat]   sys_fstat,
3530 [SYS_getpid]  sys_getpid,
3531 [SYS_kill]    sys_kill,
3532 [SYS_link]    sys_link,
3533 [SYS_mkdir]   sys_mkdir,
3534 [SYS_mknod]   sys_mknod,
3535 [SYS_open]    sys_open,
3536 [SYS_pipe]    sys_pipe,
3537 [SYS_read]    sys_read,
3538 [SYS_sbrk]    sys_sbrk,
3539 [SYS_sleep]   sys_sleep,
3540 [SYS_unlink]  sys_unlink,
3541 [SYS_wait]    sys_wait,
3542 [SYS_write]   sys_write,
3543 [SYS_upmsec]  sys_upmsec,
3544 // BSD socket
3545 [SYS_socket]  sys_socket,
3546 [SYS_bind]    sys_bind,
3547 [SYS_listen]  sys_listen,
3548 [SYS_accept]  sys_accept,
3549 [SYS_recv]    sys_recv,
3550 [SYS_recvfrom] sys_recvfrom,
3551 [SYS_send]    sys_send,
3552 [SYS_sendto]  sys_sendto,
3553 [SYS_shutdown] sys_shutdown,
3554 [SYS_getsockopt] sys_getsockopt,
3555 [SYS_setsockopt] sys_setsockopt,
3556 [SYS_sockclose] sys_sockclose,
3557 [SYS_connect] sys_connect,
3558 [SYS_getpeername] sys_getpeername,
3559 [SYS_getsockname] sys_getsockname,
3560 };
3561 
3562 void
3563 syscall(void)
3564 {
3565   int num;
3566 
3567   num = cp->tf->eax;
3568   if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
3569     cp->tf->eax = syscalls[num]();
3570   else {
3571     cprintf("%d %s: unknown sys call %d\n",
3572             cp->pid, cp->name, num);
3573     cp->tf->eax = -1;
3574   }
3575 }
3576 
3577 
3578 
3579 
3580 
3581 
3582 
3583 
3584 
3585 
3586 
3587 
3588 
3589 
3590 
3591 
3592 
3593 
3594 
3595 
3596 
3597 
3598 
3599 
