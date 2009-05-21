4700 // File system implementation.  Four layers:
4701 //   + Blocks: allocator for raw disk blocks.
4702 //   + Files: inode allocator, reading, writing, metadata.
4703 //   + Directories: inode with special contents (list of other inodes!)
4704 //   + Names: paths like /usr/rtm/xv6/fs.c for convenient naming.
4705 //
4706 // Disk layout is: superblock, inodes, block in-use bitmap, data blocks.
4707 //
4708 // This file contains the low-level file system manipulation
4709 // routines.  The (higher-level) system call implementations
4710 // are in sysfile.c.
4711 
4712 #include "types.h"
4713 #include "defs.h"
4714 #include "param.h"
4715 #include "stat.h"
4716 #include "mmu.h"
4717 #include "proc.h"
4718 #include "spinlock.h"
4719 #include "buf.h"
4720 #include "fs.h"
4721 #include "fsvar.h"
4722 #include "dev.h"
4723 
4724 #define min(a, b) ((a) < (b) ? (a) : (b))
4725 static void itrunc(struct inode*);
4726 
4727 // Read the super block.
4728 static void
4729 readsb(int dev, struct superblock *sb)
4730 {
4731   struct buf *bp;
4732 
4733 //  cprintf("XXX %s\n",__func__);
4734   bp = bread(dev, 1);
4735   memmove(sb, bp->data, sizeof(*sb));
4736   brelse(bp);
4737 }
4738 
4739 
4740 
4741 
4742 
4743 
4744 
4745 
4746 
4747 
4748 
4749 
4750 // Zero a block.
4751 static void
4752 bzero(int dev, int bno)
4753 {
4754   struct buf *bp;
4755 
4756 //  cprintf("XXX %s\n",__func__);
4757   bp = bread(dev, bno);
4758   memset(bp->data, 0, BSIZE);
4759   bwrite(bp);
4760   brelse(bp);
4761 }
4762 
4763 // Blocks.
4764 
4765 // Allocate a disk block.
4766 static uint
4767 balloc(uint dev)
4768 {
4769   int b, bi, m;
4770   struct buf *bp;
4771   struct superblock sb;
4772 
4773 //  cprintf("XXX %s\n",__func__);
4774   bp = 0;
4775   readsb(dev, &sb);
4776   for(b = 0; b < sb.size; b += BPB){
4777     bp = bread(dev, BBLOCK(b, sb.ninodes));
4778     for(bi = 0; bi < BPB; bi++){
4779       m = 1 << (bi % 8);
4780       if((bp->data[bi/8] & m) == 0){  // Is block free?
4781         bp->data[bi/8] |= m;  // Mark block in use on disk.
4782         bwrite(bp);
4783         brelse(bp);
4784         return b + bi;
4785       }
4786     }
4787     brelse(bp);
4788   }
4789   panic("balloc: out of blocks");
4790 }
4791 
4792 
4793 
4794 
4795 
4796 
4797 
4798 
4799 
4800 // Free a disk block.
4801 static void
4802 bfree(int dev, uint b)
4803 {
4804   struct buf *bp;
4805   struct superblock sb;
4806   int bi, m;
4807 
4808   bzero(dev, b);
4809 
4810 //  cprintf("XXX %s\n",__func__);
4811   readsb(dev, &sb);
4812   bp = bread(dev, BBLOCK(b, sb.ninodes));
4813   bi = b % BPB;
4814   m = 1 << (bi % 8);
4815   if((bp->data[bi/8] & m) == 0)
4816     panic("freeing free block");
4817   bp->data[bi/8] &= ~m;  // Mark block free on disk.
4818   bwrite(bp);
4819   brelse(bp);
4820 }
4821 
4822 // Inodes.
4823 //
4824 // An inode is a single, unnamed file in the file system.
4825 // The inode disk structure holds metadata (the type, device numbers,
4826 // and data size) along with a list of blocks where the associated
4827 // data can be found.
4828 //
4829 // The inodes are laid out sequentially on disk immediately after
4830 // the superblock.  The kernel keeps a cache of the in-use
4831 // on-disk structures to provide a place for synchronizing access
4832 // to inodes shared between multiple processes.
4833 //
4834 // ip->ref counts the number of pointer references to this cached
4835 // inode; references are typically kept in struct file and in cp->cwd.
4836 // When ip->ref falls to zero, the inode is no longer cached.
4837 // It is an error to use an inode without holding a reference to it.
4838 //
4839 // Processes are only allowed to read and write inode
4840 // metadata and contents when holding the inode's lock,
4841 // represented by the I_BUSY flag in the in-memory copy.
4842 // Because inode locks are held during disk accesses,
4843 // they are implemented using a flag rather than with
4844 // spin locks.  Callers are responsible for locking
4845 // inodes before passing them to routines in this file; leaving
4846 // this responsibility with the caller makes it possible for them
4847 // to create arbitrarily-sized atomic operations.
4848 //
4849 // To give maximum control over locking to the callers,
4850 // the routines in this file that return inode pointers
4851 // return pointers to *unlocked* inodes.  It is the callers'
4852 // responsibility to lock them before using them.  A non-zero
4853 // ip->ref keeps these unlocked inodes in the cache.
4854 
4855 struct {
4856   struct spinlock lock;
4857   struct inode inode[NINODE];
4858 } icache;
4859 
4860 void
4861 iinit(void)
4862 {
4863   initlock(&icache.lock, "icache.lock");
4864 }
4865 
4866 // Find the inode with number inum on device dev
4867 // and return the in-memory copy.
4868 static struct inode*
4869 iget(uint dev, uint inum)
4870 {
4871   struct inode *ip, *empty;
4872 
4873   acquire(&icache.lock);
4874 
4875   // Try for cached inode.
4876   empty = 0;
4877   for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
4878     if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
4879       ip->ref++;
4880       release(&icache.lock);
4881 //      cprintf("XXX iget: found in cache\n");
4882       return ip;
4883     }
4884     if(empty == 0 && ip->ref == 0)    // Remember empty slot.
4885       empty = ip;
4886   }
4887 
4888   // Allocate fresh inode.
4889   if(empty == 0)
4890     panic("iget: no inodes");
4891 
4892 //  cprintf("XXX iget: allocating new\n");
4893   ip = empty;
4894   ip->dev = dev;
4895   ip->inum = inum;
4896   ip->ref = 1;
4897   ip->flags = 0;
4898   release(&icache.lock);
4899 
4900   return ip;
4901 }
4902 
4903 // Increment reference count for ip.
4904 // Returns ip to enable ip = idup(ip1) idiom.
4905 struct inode*
4906 idup(struct inode *ip)
4907 {
4908   acquire(&icache.lock);
4909   ip->ref++;
4910   release(&icache.lock);
4911   return ip;
4912 }
4913 
4914 // Lock the given inode.
4915 void
4916 ilock(struct inode *ip)
4917 {
4918   struct buf *bp;
4919   struct dinode *dip;
4920 
4921   if(ip == 0 || ip->ref < 1)
4922     panic("ilock");
4923 
4924   acquire(&icache.lock);
4925   while(ip->flags & I_BUSY)
4926     sleep(ip, &icache.lock);
4927   ip->flags |= I_BUSY;
4928   release(&icache.lock);
4929 
4930   if(!(ip->flags & I_VALID)){
4931     bp = bread(ip->dev, IBLOCK(ip->inum));
4932 //  cprintf("XXX %s:after bread \n",__func__);
4933     dip = (struct dinode*)bp->data + ip->inum%IPB;
4934     ip->type = dip->type;
4935     ip->major = dip->major;
4936     ip->minor = dip->minor;
4937     ip->nlink = dip->nlink;
4938     ip->size = dip->size;
4939     memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
4940     brelse(bp);
4941     ip->flags |= I_VALID;
4942     if(ip->type == 0)
4943       panic("ilock: no type");
4944   }
4945 }
4946 
4947 
4948 
4949 
4950 // Unlock the given inode.
4951 void
4952 iunlock(struct inode *ip)
4953 {
4954   if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
4955     panic("iunlock");
4956 
4957   acquire(&icache.lock);
4958   ip->flags &= ~I_BUSY;
4959   wakeup(ip);
4960   release(&icache.lock);
4961 }
4962 
4963 // Caller holds reference to unlocked ip.  Drop reference.
4964 void
4965 iput(struct inode *ip)
4966 {
4967   acquire(&icache.lock);
4968   if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
4969     // inode is no longer used: truncate and free inode.
4970     if(ip->flags & I_BUSY)
4971       panic("iput busy");
4972     ip->flags |= I_BUSY;
4973     release(&icache.lock);
4974     itrunc(ip);
4975     ip->type = 0;
4976     iupdate(ip);
4977     acquire(&icache.lock);
4978     ip->flags &= ~I_BUSY;
4979     wakeup(ip);
4980   }
4981   ip->ref--;
4982   release(&icache.lock);
4983 }
4984 
4985 // Common idiom: unlock, then put.
4986 void
4987 iunlockput(struct inode *ip)
4988 {
4989   iunlock(ip);
4990   iput(ip);
4991 }
4992 
4993 
4994 
4995 
4996 
4997 
4998 
4999 
5000 // Allocate a new inode with the given type on device dev.
5001 struct inode*
5002 ialloc(uint dev, short type)
5003 {
5004   int inum;
5005   struct buf *bp;
5006   struct dinode *dip;
5007   struct superblock sb;
5008 
5009 //  cprintf("XXX %s\n",__func__);
5010   readsb(dev, &sb);
5011   for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
5012     bp = bread(dev, IBLOCK(inum));
5013     dip = (struct dinode*)bp->data + inum%IPB;
5014     if(dip->type == 0){  // a free inode
5015       memset(dip, 0, sizeof(*dip));
5016       dip->type = type;
5017       bwrite(bp);   // mark it allocated on the disk
5018       brelse(bp);
5019       return iget(dev, inum);
5020     }
5021     brelse(bp);
5022   }
5023   panic("ialloc: no inodes");
5024 }
5025 
5026 // Copy inode, which has changed, from memory to disk.
5027 void
5028 iupdate(struct inode *ip)
5029 {
5030   struct buf *bp;
5031   struct dinode *dip;
5032 
5033   bp = bread(ip->dev, IBLOCK(ip->inum));
5034   dip = (struct dinode*)bp->data + ip->inum%IPB;
5035   dip->type = ip->type;
5036   dip->major = ip->major;
5037   dip->minor = ip->minor;
5038   dip->nlink = ip->nlink;
5039   dip->size = ip->size;
5040   memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
5041   bwrite(bp);
5042   brelse(bp);
5043 }
5044 
5045 
5046 
5047 
5048 
5049 
5050 // Inode contents
5051 //
5052 // The contents (data) associated with each inode is stored
5053 // in a sequence of blocks on the disk.  The first NDIRECT blocks
5054 // are listed in ip->addrs[].  The next NINDIRECT blocks are
5055 // listed in the block ip->addrs[INDIRECT].
5056 
5057 // Return the disk block address of the nth block in inode ip.
5058 // If there is no such block, alloc controls whether one is allocated.
5059 static uint
5060 bmap(struct inode *ip, uint bn, int alloc)
5061 {
5062   uint addr, *a;
5063   struct buf *bp;
5064 
5065   if(bn < NDIRECT){
5066     if((addr = ip->addrs[bn]) == 0){
5067       if(!alloc)
5068         return -1;
5069       ip->addrs[bn] = addr = balloc(ip->dev);
5070     }
5071     return addr;
5072   }
5073   bn -= NDIRECT;
5074 
5075   if(bn < NINDIRECT){
5076     // Load indirect block, allocating if necessary.
5077     if((addr = ip->addrs[INDIRECT]) == 0){
5078       if(!alloc)
5079         return -1;
5080       ip->addrs[INDIRECT] = addr = balloc(ip->dev);
5081     }
5082     bp = bread(ip->dev, addr);
5083     a = (uint*)bp->data;
5084 
5085     if((addr = a[bn]) == 0){
5086       if(!alloc){
5087         brelse(bp);
5088         return -1;
5089       }
5090       a[bn] = addr = balloc(ip->dev);
5091       bwrite(bp);
5092     }
5093     brelse(bp);
5094     return addr;
5095   }
5096 
5097   panic("bmap: out of range");
5098 }
5099 
5100 // Truncate inode (discard contents).
5101 static void
5102 itrunc(struct inode *ip)
5103 {
5104   int i, j;
5105   struct buf *bp;
5106   uint *a;
5107 
5108   for(i = 0; i < NDIRECT; i++){
5109     if(ip->addrs[i]){
5110       bfree(ip->dev, ip->addrs[i]);
5111       ip->addrs[i] = 0;
5112     }
5113   }
5114 
5115   if(ip->addrs[INDIRECT]){
5116     bp = bread(ip->dev, ip->addrs[INDIRECT]);
5117     a = (uint*)bp->data;
5118     for(j = 0; j < NINDIRECT; j++){
5119       if(a[j])
5120         bfree(ip->dev, a[j]);
5121     }
5122     brelse(bp);
5123     ip->addrs[INDIRECT] = 0;
5124   }
5125 
5126   ip->size = 0;
5127   iupdate(ip);
5128 }
5129 
5130 // Copy stat information from inode.
5131 void
5132 stati(struct inode *ip, struct stat *st)
5133 {
5134   st->dev = ip->dev;
5135   st->ino = ip->inum;
5136   st->type = ip->type;
5137   st->nlink = ip->nlink;
5138   st->size = ip->size;
5139 }
5140 
5141 
5142 
5143 
5144 
5145 
5146 
5147 
5148 
5149 
5150 // Read data from inode.
5151 int
5152 readi(struct inode *ip, char *dst, uint off, uint n)
5153 {
5154   uint tot, m;
5155   struct buf *bp;
5156 
5157 //  cprintf("XXX readi %d.%d\n", ip->dev, ip->inum);
5158   if(ip->type == T_DEV){
5159     if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
5160       return -1;
5161     return devsw[ip->major].read(ip, dst, n);
5162   }
5163 
5164   if(off > ip->size || off + n < off)
5165     return -1;
5166   if(off + n > ip->size)
5167     n = ip->size - off;
5168 
5169   for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
5170     bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
5171     m = min(n - tot, BSIZE - off%BSIZE);
5172     memmove(dst, bp->data + off%BSIZE, m);
5173     brelse(bp);
5174   }
5175   return n;
5176 }
5177 
5178 // Write data to inode.
5179 int
5180 writei(struct inode *ip, char *src, uint off, uint n)
5181 {
5182   uint tot, m;
5183   struct buf *bp;
5184 
5185   if(ip->type == T_DEV){
5186     if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
5187       return -1;
5188     return devsw[ip->major].write(ip, src, n);
5189   }
5190 
5191   if(off + n < off)
5192     return -1;
5193   if(off + n > MAXFILE*BSIZE)
5194     n = MAXFILE*BSIZE - off;
5195 
5196 
5197 
5198 
5199 
5200   for(tot=0; tot<n; tot+=m, off+=m, src+=m){
5201     bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
5202     m = min(n - tot, BSIZE - off%BSIZE);
5203     memmove(bp->data + off%BSIZE, src, m);
5204     bwrite(bp);
5205     brelse(bp);
5206   }
5207 
5208   if(n > 0 && off > ip->size){
5209     ip->size = off;
5210     iupdate(ip);
5211   }
5212   return n;
5213 }
5214 
5215 // Directories
5216 
5217 int
5218 namecmp(const char *s, const char *t)
5219 {
5220   return strncmp(s, t, DIRSIZ);
5221 }
5222 
5223 // Look for a directory entry in a directory.
5224 // If found, set *poff to byte offset of entry.
5225 // Caller must have already locked dp.
5226 struct inode*
5227 dirlookup(struct inode *dp, char *name, uint *poff)
5228 {
5229   uint off, inum;
5230   struct buf *bp;
5231   struct dirent *de;
5232 
5233   if(dp->type != T_DIR)
5234     panic("dirlookup not DIR");
5235 
5236   for(off = 0; off < dp->size; off += BSIZE){
5237     bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
5238     for(de = (struct dirent*)bp->data;
5239         de < (struct dirent*)(bp->data + BSIZE);
5240         de++){
5241       if(de->inum == 0)
5242         continue;
5243       if(namecmp(name, de->name) == 0){
5244         // entry matches path element
5245         if(poff)
5246           *poff = off + (uchar*)de - bp->data;
5247         inum = de->inum;
5248         brelse(bp);
5249         return iget(dp->dev, inum);
5250       }
5251     }
5252     brelse(bp);
5253   }
5254   return 0;
5255 }
5256 
5257 // Write a new directory entry (name, ino) into the directory dp.
5258 int
5259 dirlink(struct inode *dp, char *name, uint ino)
5260 {
5261   int off;
5262   struct dirent de;
5263   struct inode *ip;
5264 
5265   // Check that name is not present.
5266   if((ip = dirlookup(dp, name, 0)) != 0){
5267     iput(ip);
5268     return -1;
5269   }
5270 
5271   // Look for an empty dirent.
5272   for(off = 0; off < dp->size; off += sizeof(de)){
5273     if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
5274       panic("dirlink read");
5275     if(de.inum == 0)
5276       break;
5277   }
5278 
5279   strncpy(de.name, name, DIRSIZ);
5280   de.inum = ino;
5281   if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
5282     panic("dirlink");
5283 
5284   return 0;
5285 }
5286 
5287 
5288 
5289 
5290 
5291 
5292 
5293 
5294 
5295 
5296 
5297 
5298 
5299 
5300 // Paths
5301 
5302 // Copy the next path element from path into name.
5303 // Return a pointer to the element following the copied one.
5304 // The returned path has no leading slashes,
5305 // so the caller can check *path=='\0' to see if the name is the last one.
5306 // If no name to remove, return 0.
5307 //
5308 // Examples:
5309 //   skipelem("a/bb/c", name) = "bb/c", setting name = "a"
5310 //   skipelem("///a//bb", name) = "bb", setting name = "a"
5311 //   skipelem("", name) = skipelem("////", name) = 0
5312 //
5313 static char*
5314 skipelem(char *path, char *name)
5315 {
5316   char *s;
5317   int len;
5318 
5319   while(*path == '/')
5320     path++;
5321   if(*path == 0)
5322     return 0;
5323   s = path;
5324   while(*path != '/' && *path != 0)
5325     path++;
5326   len = path - s;
5327   if(len >= DIRSIZ)
5328     memmove(name, s, DIRSIZ);
5329   else {
5330     memmove(name, s, len);
5331     name[len] = 0;
5332   }
5333   while(*path == '/')
5334     path++;
5335   return path;
5336 }
5337 
5338 
5339 
5340 
5341 
5342 
5343 
5344 
5345 
5346 
5347 
5348 
5349 
5350 // Look up and return the inode for a path name.
5351 // If parent != 0, return the inode for the parent and copy the final
5352 // path element into name, which must have room for DIRSIZ bytes.
5353 static struct inode*
5354 _namei(char *path, int parent, char *name)
5355 {
5356   struct inode *ip, *next;
5357 
5358 //  cprintf("XXX _namei %s\n", path);
5359   if(*path == '/')
5360     ip = iget(ROOTDEV, 1);
5361   else
5362     ip = idup(cp->cwd);
5363 
5364   while((path = skipelem(path, name)) != 0){
5365 //    cprintf("XXX ready to ilock\n");
5366     ilock(ip);
5367 //    cprintf("XXX here %d\n", ip->type);
5368     if(ip->type != T_DIR){
5369       iunlockput(ip);
5370       return 0;
5371     }
5372     if(parent && *path == '\0'){
5373       // Stop one level early.
5374       iunlock(ip);
5375       return ip;
5376     }
5377     if((next = dirlookup(ip, name, 0)) == 0){
5378       iunlockput(ip);
5379       return 0;
5380     }
5381     iunlockput(ip);
5382     ip = next;
5383   }
5384   if(parent){
5385     iput(ip);
5386     return 0;
5387   }
5388   return ip;
5389 }
5390 
5391 struct inode*
5392 namei(char *path)
5393 {
5394   char name[DIRSIZ];
5395   return _namei(path, 0, name);
5396 }
5397 
5398 
5399 
5400 struct inode*
5401 nameiparent(char *path, char *name)
5402 {
5403   return _namei(path, 1, name);
5404 }
5405 
5406 
5407 
5408 
5409 
5410 
5411 
5412 
5413 
5414 
5415 
5416 
5417 
5418 
5419 
5420 
5421 
5422 
5423 
5424 
5425 
5426 
5427 
5428 
5429 
5430 
5431 
5432 
5433 
5434 
5435 
5436 
5437 
5438 
5439 
5440 
5441 
5442 
5443 
5444 
5445 
5446 
5447 
5448 
5449 
