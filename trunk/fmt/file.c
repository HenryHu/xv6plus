5450 #include "types.h"
5451 #include "defs.h"
5452 #include "param.h"
5453 #include "file.h"
5454 #include "spinlock.h"
5455 #include "dev.h"
5456 
5457 struct devsw devsw[NDEV];
5458 struct spinlock file_table_lock;
5459 struct file file[NFILE];
5460 
5461 void
5462 fileinit(void)
5463 {
5464   initlock(&file_table_lock, "file_table");
5465 }
5466 
5467 // Allocate a file structure.
5468 struct file*
5469 filealloc(void)
5470 {
5471   int i;
5472 
5473   acquire(&file_table_lock);
5474   for(i = 0; i < NFILE; i++){
5475     if(file[i].type == FD_CLOSED){
5476       file[i].type = FD_NONE;
5477       file[i].ref = 1;
5478       release(&file_table_lock);
5479       return file + i;
5480     }
5481   }
5482   release(&file_table_lock);
5483   return 0;
5484 }
5485 
5486 // Increment ref count for file f.
5487 struct file*
5488 filedup(struct file *f)
5489 {
5490   acquire(&file_table_lock);
5491   if(f->ref < 1 || f->type == FD_CLOSED)
5492     panic("filedup");
5493   f->ref++;
5494   release(&file_table_lock);
5495   return f;
5496 }
5497 
5498 
5499 
5500 // Close file f.  (Decrement ref count, close when reaches 0.)
5501 void
5502 fileclose(struct file *f)
5503 {
5504   struct file ff;
5505 
5506   acquire(&file_table_lock);
5507   if(f->ref < 1 || f->type == FD_CLOSED)
5508   {
5509       cprintf("ref: %d type: %d\n", f->ref, f->type);
5510       panic("fileclose: file closed");
5511   }
5512   if(--f->ref > 0){
5513     release(&file_table_lock);
5514     return;
5515   }
5516   ff = *f;
5517   f->ref = 0;
5518   f->type = FD_CLOSED;
5519   release(&file_table_lock);
5520 
5521   if(ff.type == FD_PIPE)
5522     pipeclose(ff.pipe, ff.writable);
5523   else if(ff.type == FD_INODE)
5524     iput(ff.ip);
5525   else
5526   {
5527       cprintf("type: %d\n");
5528       panic("fileclose: file type error");
5529   }
5530 }
5531 
5532 // Get metadata about file f.
5533 int
5534 filestat(struct file *f, struct stat *st)
5535 {
5536   if(f->type == FD_INODE){
5537     ilock(f->ip);
5538     stati(f->ip, st);
5539     iunlock(f->ip);
5540     return 0;
5541   }
5542   return -1;
5543 }
5544 
5545 
5546 
5547 
5548 
5549 
5550 // Read from file f.  Addr is kernel address.
5551 int
5552 fileread(struct file *f, char *addr, int n)
5553 {
5554   int r;
5555 
5556   if(f->readable == 0)
5557     return -1;
5558   if(f->type == FD_PIPE)
5559     return piperead(f->pipe, addr, n);
5560   if(f->type == FD_INODE){
5561     ilock(f->ip);
5562     if((r = readi(f->ip, addr, f->off, n)) > 0)
5563       f->off += r;
5564     iunlock(f->ip);
5565     return r;
5566   }
5567   panic("fileread");
5568 }
5569 
5570 // Write to file f.  Addr is kernel address.
5571 int
5572 filewrite(struct file *f, char *addr, int n)
5573 {
5574   int r;
5575 
5576   if(f->writable == 0)
5577     return -1;
5578   if(f->type == FD_PIPE)
5579     return pipewrite(f->pipe, addr, n);
5580   if(f->type == FD_INODE){
5581     ilock(f->ip);
5582     if((r = writei(f->ip, addr, f->off, n)) > 0)
5583       f->off += r;
5584     iunlock(f->ip);
5585     return r;
5586   }
5587   panic("filewrite");
5588 }
5589 
5590 
5591 
5592 
5593 
5594 
5595 
5596 
5597 
5598 
5599 
