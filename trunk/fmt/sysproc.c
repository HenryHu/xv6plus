3600 #include "types.h"
3601 #include "defs.h"
3602 #include "param.h"
3603 #include "mmu.h"
3604 #include "proc.h"
3605 #include "lwip/include/lwip/sockets.h"
3606 
3607 int
3608 sys_fork(void)
3609 {
3610   struct proc *np;
3611 
3612   if((np = copyproc(cp)) == 0)
3613     return -1;
3614   np->state = RUNNABLE;
3615   return np->pid;
3616 }
3617 
3618 int
3619 sys_exit(void)
3620 {
3621   exit();
3622   return 0;  // not reached
3623 }
3624 
3625 int
3626 sys_wait(void)
3627 {
3628   return wait();
3629 }
3630 
3631 int
3632 sys_kill(void)
3633 {
3634   int pid;
3635 
3636   if(argint(0, &pid) < 0)
3637     return -1;
3638   return kill(pid);
3639 }
3640 
3641 int
3642 sys_getpid(void)
3643 {
3644   return cp->pid;
3645 }
3646 
3647 
3648 
3649 
3650 int
3651 sys_sbrk(void)
3652 {
3653   int addr;
3654   int n;
3655 
3656   if(argint(0, &n) < 0)
3657     return -1;
3658   if((addr = growproc(n)) < 0)
3659     return -1;
3660   setupsegs(cp);
3661   return addr;
3662 }
3663 
3664 int
3665 sys_sleep(void)
3666 {
3667   int n, ticks0;
3668 
3669   if(argint(0, &n) < 0)
3670     return -1;
3671   acquire(&tickslock);
3672   ticks0 = ticks;
3673   while(ticks - ticks0 < n){
3674     if(cp->killed){
3675       release(&tickslock);
3676       return -1;
3677     }
3678     sleep(&ticks, &tickslock);
3679   }
3680   release(&tickslock);
3681   return 0;
3682 }
3683 
3684 int
3685 sys_upmsec(void)
3686 {
3687     return millitime();
3688 }
3689 
3690 
3691 
3692 
3693 
3694 
3695 
3696 
3697 
3698 
3699 
3700 int
3701 sys_accept(void)
3702 {
3703     int s;
3704     struct sockaddr *addr;
3705     socklen_t *addrlen;
3706     if((argint(0, &s)<0) ||
3707             (argptr(1, &addr, sizeof(struct sockaddr))<0) ||
3708             (argptr(2, &addrlen, sizeof(socklen_t))<0))
3709         return -1;
3710     return lwip_accept(s, addr, addrlen);
3711 }
3712 
3713 int
3714 sys_bind(void)
3715 {
3716     int s;
3717     struct sockaddr *name;
3718     socklen_t *namelen;
3719     if((argint(0, &s)<0) ||
3720             (argptr(1, &name, sizeof(struct sockaddr))<0) ||
3721             (argptr(2, &namelen, sizeof(socklen_t))<0))
3722         return -1;
3723     return lwip_bind(s, name, namelen);
3724 }
3725 
3726 int
3727 sys_shutdown(void)
3728 {
3729     int s;
3730     int how;
3731     if ((argint(0, &s)<0) || (argint(1, &how) < 0))
3732         return -1;
3733     return lwip_shutdown(s, how);
3734 }
3735 
3736 
3737 
3738 
3739 
3740 
3741 
3742 
3743 
3744 
3745 
3746 
3747 
3748 
3749 
3750 int
3751 sys_getsockopt(void)
3752 {
3753     int s;
3754     int level;
3755     int optname;
3756     void *optval;
3757     socklen_t *optlen;
3758     if ((argint(0, &s)<0) ||
3759         (argint(1, &level)<0) ||
3760         (argint(2, &optname)<0) ||
3761         (argptr(4, &optlen, sizeof(socklen_t))<0) ||
3762         (argptr(3, &optval, 0)<0))
3763         return -1;
3764     return lwip_getsockopt(s, level, optname, optval, optlen);
3765 }
3766 
3767 int sys_setsockopt(void)
3768 {
3769     int s;
3770     int level;
3771     int optname;
3772     void *optval;
3773     socklen_t *optlen;
3774     if ((argint(0, &s)<0) ||
3775         (argint(1, &level)<0) ||
3776         (argint(2, &optname)<0) ||
3777         (argptr(4, &optlen, sizeof(socklen_t))<0) ||
3778         (argptr(3, &optval, *optlen)<0))
3779         return -1;
3780     return lwip_setsockopt(s, level, optname, optval, optlen);
3781 }
3782 
3783 int sys_sockclose(void)
3784 {
3785     int s;
3786     if (argint(0, &s) <0)
3787         return -1;
3788     return lwip_close(s);
3789 }
3790 
3791 
3792 
3793 
3794 
3795 
3796 
3797 
3798 
3799 
3800 int sys_connect(void)
3801 {
3802     int s;
3803     struct sockaddr *name;
3804     socklen_t *namelen;
3805     if((argint(0, &s)<0) ||
3806             (argptr(1, &name, sizeof(struct sockaddr))<0) ||
3807             (argptr(2, &namelen, sizeof(socklen_t))<0))
3808         return -1;
3809     return lwip_connect(s, name, namelen);
3810 }
3811 
3812 int sys_listen(void)
3813 {
3814     int s;
3815     int backlog;
3816     if ((argint(0, &s)<0) ||
3817         (argint(1, &backlog)<0))
3818         return -1;
3819     return lwip_listen(s, backlog);
3820 }
3821 
3822 int sys_recv(void)
3823 {
3824     int s;
3825     void *mem;
3826     int len;
3827     unsigned int flags;
3828     if ((argint(0, &s)<0) ||
3829         (argint(2, &len)<0) ||
3830         (argptr(1, &mem, len)<0) ||
3831         (argint(3, &flags)<0))
3832         return -1;
3833     return lwip_recv(s, mem, len, flags);
3834 }
3835 
3836 
3837 
3838 
3839 
3840 
3841 
3842 
3843 
3844 
3845 
3846 
3847 
3848 
3849 
3850 int sys_recvfrom(void)
3851 {
3852     int s;
3853     void *mem;
3854     int len;
3855     unsigned int flags;
3856     struct sockaddr *from;
3857     socklen_t *fromlen;
3858     if ((argint(0, &s)<0) ||
3859         (argint(2, &len)<0) ||
3860         (argptr(1, &mem, len)<0) ||
3861         (argint(3, &flags)<0) ||
3862         (argptr(4, &from, 0)<0) ||
3863         (argptr(5, &fromlen, sizeof(socklen_t))<0))
3864         return -1;
3865     return lwip_recvfrom(s, mem, len, flags, from, fromlen);
3866 }
3867 
3868 int sys_send(void)
3869 {
3870     int s;
3871     void *dataptr;
3872     int size;
3873     unsigned int flags;
3874     if ((argint(0, &s)<0) ||
3875         (argint(2, &size)<0) ||
3876         (argptr(1, &dataptr, size)<0) ||
3877         (argint(3, &flags)<0))
3878         return -1;
3879     return lwip_send(s, dataptr, size, flags);
3880 }
3881 
3882 int sys_sendto(void)
3883 {
3884     int s;
3885     void *dataptr;
3886     int size;
3887     unsigned int flags;
3888     struct sockaddr *to;
3889     socklen_t *tolen;
3890     if ((argint(0, &s)<0) ||
3891         (argint(2, &size)<0) ||
3892         (argptr(1, &dataptr, size)<0) ||
3893         (argint(3, &flags)<0) ||
3894         (argptr(5, &tolen, sizeof(socklen_t))<0) ||
3895         (argptr(4, &to, *tolen)<0))
3896         return -1;
3897     return lwip_send(s, dataptr, size, flags);
3898 }
3899 
3900 int sys_socket(void)
3901 {
3902     int domain;
3903     int type;
3904     int protocol;
3905     if ((argint(0, &domain)<0) ||
3906         (argint(1, &type)<0) ||
3907         (argint(2, &protocol)<0))
3908         return -1;
3909     return lwip_socket(domain, type, protocol);
3910 }
3911 
3912 int
3913 sys_getpeername(void)
3914 {
3915     int s;
3916     struct sockaddr *name;
3917     socklen_t *namelen;
3918     if((argint(0, &s)<0) ||
3919             (argptr(1, &name, sizeof(struct sockaddr))<0) ||
3920             (argptr(2, &namelen, sizeof(socklen_t))<0))
3921         return -1;
3922     return lwip_getpeername(s, name, namelen);
3923 }
3924 
3925 int
3926 sys_getsockname(void)
3927 {
3928     int s;
3929     struct sockaddr *name;
3930     socklen_t *namelen;
3931     if((argint(0, &s)<0) ||
3932             (argptr(1, &name, sizeof(struct sockaddr))<0) ||
3933             (argptr(2, &namelen, sizeof(socklen_t))<0))
3934         return -1;
3935     return lwip_getsockname(s, name, namelen);
3936 }
3937 
3938 
3939 
3940 
3941 
3942 
3943 
3944 
3945 
3946 
3947 
3948 
3949 
