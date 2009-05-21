5600 #include "types.h"
5601 #include "defs.h"
5602 #include "param.h"
5603 #include "stat.h"
5604 #include "mmu.h"
5605 #include "proc.h"
5606 #include "fs.h"
5607 #include "fsvar.h"
5608 #include "file.h"
5609 #include "fcntl.h"
5610 
5611 // Fetch the nth word-sized system call argument as a file descriptor
5612 // and return both the descriptor and the corresponding struct file.
5613 static int
5614 argfd(int n, int *pfd, struct file **pf)
5615 {
5616   int fd;
5617   struct file *f;
5618 
5619   if(argint(n, &fd) < 0)
5620     return -1;
5621   if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
5622     return -1;
5623   if(pfd)
5624     *pfd = fd;
5625   if(pf)
5626     *pf = f;
5627   return 0;
5628 }
5629 
5630 // Allocate a file descriptor for the given file.
5631 // Takes over file reference from caller on success.
5632 static int
5633 fdalloc(struct file *f)
5634 {
5635   int fd;
5636 
5637   for(fd = 0; fd < NOFILE; fd++){
5638     if(cp->ofile[fd] == 0){
5639       cp->ofile[fd] = f;
5640       return fd;
5641     }
5642   }
5643   return -1;
5644 }
5645 
5646 
5647 
5648 
5649 
5650 int
5651 sys_read(void)
5652 {
5653   struct file *f;
5654   int n;
5655   char *cp;
5656 
5657   if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &cp, n) < 0)
5658     return -1;
5659   return fileread(f, cp, n);
5660 }
5661 
5662 int
5663 sys_write(void)
5664 {
5665   struct file *f;
5666   int n;
5667   char *cp;
5668 
5669   if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &cp, n) < 0)
5670     return -1;
5671   return filewrite(f, cp, n);
5672 }
5673 
5674 int
5675 sys_dup(void)
5676 {
5677   struct file *f;
5678   int fd;
5679 
5680   if(argfd(0, 0, &f) < 0)
5681     return -1;
5682   if((fd=fdalloc(f)) < 0)
5683     return -1;
5684   filedup(f);
5685   return fd;
5686 }
5687 
5688 int
5689 sys_close(void)
5690 {
5691   int fd;
5692   struct file *f;
5693 
5694   if(argfd(0, &fd, &f) < 0)
5695     return -1;
5696   cp->ofile[fd] = 0;
5697   fileclose(f);
5698   return 0;
5699 }
5700 int
5701 sys_fstat(void)
5702 {
5703   struct file *f;
5704   struct stat *st;
5705 
5706   if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
5707     return -1;
5708   return filestat(f, st);
5709 }
5710 
5711 // Create the path new as a link to the same inode as old.
5712 int
5713 sys_link(void)
5714 {
5715   char name[DIRSIZ], *new, *old;
5716   struct inode *dp, *ip;
5717 
5718   if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
5719     return -1;
5720   if((ip = namei(old)) == 0)
5721     return -1;
5722   ilock(ip);
5723   if(ip->type == T_DIR){
5724     iunlockput(ip);
5725     return -1;
5726   }
5727   ip->nlink++;
5728   iupdate(ip);
5729   iunlock(ip);
5730 
5731   if((dp = nameiparent(new, name)) == 0)
5732     goto  bad;
5733   ilock(dp);
5734   if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
5735     goto bad;
5736   iunlockput(dp);
5737   iput(ip);
5738   return 0;
5739 
5740 bad:
5741   if(dp)
5742     iunlockput(dp);
5743   ilock(ip);
5744   ip->nlink--;
5745   iupdate(ip);
5746   iunlockput(ip);
5747   return -1;
5748 }
5749 
5750 // Is the directory dp empty except for "." and ".." ?
5751 static int
5752 isdirempty(struct inode *dp)
5753 {
5754   int off;
5755   struct dirent de;
5756 
5757   for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
5758     if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
5759       panic("isdirempty: readi");
5760     if(de.inum != 0)
5761       return 0;
5762   }
5763   return 1;
5764 }
5765 
5766 int
5767 sys_unlink(void)
5768 {
5769   struct inode *ip, *dp;
5770   struct dirent de;
5771   char name[DIRSIZ], *path;
5772   uint off;
5773 
5774   if(argstr(0, &path) < 0)
5775     return -1;
5776   if((dp = nameiparent(path, name)) == 0)
5777     return -1;
5778   ilock(dp);
5779 
5780   // Cannot unlink "." or "..".
5781   if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
5782     iunlockput(dp);
5783     return -1;
5784   }
5785 
5786   if((ip = dirlookup(dp, name, &off)) == 0){
5787     iunlockput(dp);
5788     return -1;
5789   }
5790   ilock(ip);
5791 
5792   if(ip->nlink < 1)
5793     panic("unlink: nlink < 1");
5794   if(ip->type == T_DIR && !isdirempty(ip)){
5795     iunlockput(ip);
5796     iunlockput(dp);
5797     return -1;
5798   }
5799 
5800   memset(&de, 0, sizeof(de));
5801   if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
5802     panic("unlink: writei");
5803   iunlockput(dp);
5804 
5805   ip->nlink--;
5806   iupdate(ip);
5807   iunlockput(ip);
5808   return 0;
5809 }
5810 
5811 static struct inode*
5812 create(char *path, int canexist, short type, short major, short minor)
5813 {
5814   uint off;
5815   struct inode *ip, *dp;
5816   char name[DIRSIZ];
5817 
5818   if((dp = nameiparent(path, name)) == 0)
5819     return 0;
5820   ilock(dp);
5821 
5822   if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
5823     iunlockput(dp);
5824     ilock(ip);
5825     if(ip->type != type || ip->major != major || ip->minor != minor){
5826       iunlockput(ip);
5827       return 0;
5828     }
5829     return ip;
5830   }
5831 
5832   if((ip = ialloc(dp->dev, type)) == 0){
5833     iunlockput(dp);
5834     return 0;
5835   }
5836   ilock(ip);
5837   ip->major = major;
5838   ip->minor = minor;
5839   ip->nlink = 1;
5840   iupdate(ip);
5841 
5842   if(dirlink(dp, name, ip->inum) < 0){
5843     ip->nlink = 0;
5844     iunlockput(ip);
5845     iunlockput(dp);
5846     return 0;
5847   }
5848 
5849 
5850   if(type == T_DIR){  // Create . and .. entries.
5851     dp->nlink++;  // for ".."
5852     iupdate(dp);
5853     // No ip->nlink++ for ".": avoid cyclic ref count.
5854     if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
5855       panic("create dots");
5856   }
5857   iunlockput(dp);
5858   return ip;
5859 }
5860 
5861 int
5862 sys_open(void)
5863 {
5864   char *path;
5865   int fd, omode;
5866   struct file *f;
5867   struct inode *ip;
5868 
5869   if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
5870     return -1;
5871 
5872   if(omode & O_CREATE){
5873     if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
5874       return -1;
5875   } else {
5876     if((ip = namei(path)) == 0)
5877       return -1;
5878     ilock(ip);
5879     if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
5880       iunlockput(ip);
5881       return -1;
5882     }
5883   }
5884 
5885   if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
5886     if(f)
5887       fileclose(f);
5888     iunlockput(ip);
5889     return -1;
5890   }
5891   iunlock(ip);
5892 
5893   f->type = FD_INODE;
5894   f->ip = ip;
5895   f->off = 0;
5896   f->readable = !(omode & O_WRONLY);
5897   f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
5898 
5899 
5900   return fd;
5901 }
5902 
5903 int
5904 sys_mknod(void)
5905 {
5906   struct inode *ip;
5907   char *path;
5908   int len;
5909   int major, minor;
5910 
5911   if((len=argstr(0, &path)) < 0 ||
5912      argint(1, &major) < 0 ||
5913      argint(2, &minor) < 0 ||
5914      (ip = create(path, 0, T_DEV, major, minor)) == 0)
5915     return -1;
5916   iunlockput(ip);
5917   return 0;
5918 }
5919 
5920 int
5921 sys_mkdir(void)
5922 {
5923   char *path;
5924   struct inode *ip;
5925 
5926   if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
5927     return -1;
5928   iunlockput(ip);
5929   return 0;
5930 }
5931 
5932 int
5933 sys_chdir(void)
5934 {
5935   char *path;
5936   struct inode *ip;
5937 
5938   if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
5939     return -1;
5940   ilock(ip);
5941   if(ip->type != T_DIR){
5942     iunlockput(ip);
5943     return -1;
5944   }
5945   iunlock(ip);
5946   iput(cp->cwd);
5947   cp->cwd = ip;
5948   return 0;
5949 }
5950 int
5951 sys_exec(void)
5952 {
5953   char *path, *argv[20];
5954   int i;
5955   uint uargv, uarg;
5956 
5957   if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
5958     return -1;
5959   memset(argv, 0, sizeof(argv));
5960   for(i=0;; i++){
5961     if(i >= NELEM(argv))
5962       return -1;
5963     if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
5964       return -1;
5965     if(uarg == 0){
5966       argv[i] = 0;
5967       break;
5968     }
5969     if(fetchstr(cp, uarg, &argv[i]) < 0)
5970       return -1;
5971   }
5972   return exec(path, argv);
5973 }
5974 
5975 int
5976 sys_pipe(void)
5977 {
5978   int *fd;
5979   struct file *rf, *wf;
5980   int fd0, fd1;
5981 
5982   if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
5983     return -1;
5984   if(pipealloc(&rf, &wf) < 0)
5985     return -1;
5986   fd0 = -1;
5987   if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
5988     if(fd0 >= 0)
5989       cp->ofile[fd0] = 0;
5990     fileclose(rf);
5991     fileclose(wf);
5992     return -1;
5993   }
5994   fd[0] = fd0;
5995   fd[1] = fd1;
5996   return 0;
5997 }
5998 
5999 
