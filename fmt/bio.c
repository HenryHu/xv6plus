4550 // Buffer cache.
4551 //
4552 // The buffer cache is a linked list of buf structures holding
4553 // cached copies of disk block contents.  Caching disk blocks
4554 // in memory reduces the number of disk reads and also provides
4555 // a synchronization point for disk blocks used by multiple processes.
4556 //
4557 // Interface:
4558 // * To get a buffer for a particular disk block, call bread.
4559 // * After changing buffer data, call bwrite to flush it to disk.
4560 // * When done with the buffer, call brelse.
4561 // * Do not use the buffer after calling brelse.
4562 // * Only one process at a time can use a buffer,
4563 //     so do not keep them longer than necessary.
4564 //
4565 // The implementation uses three state flags internally:
4566 // * B_BUSY: the block has been returned from bread
4567 //     and has not been passed back to brelse.
4568 // * B_VALID: the buffer data has been initialized
4569 //     with the associated disk block contents.
4570 // * B_DIRTY: the buffer data has been modified
4571 //     and needs to be written to disk.
4572 
4573 #include "types.h"
4574 #include "defs.h"
4575 #include "param.h"
4576 #include "spinlock.h"
4577 #include "buf.h"
4578 
4579 struct buf buf[NBUF];
4580 struct spinlock buf_table_lock;
4581 
4582 // Linked list of all buffers, through prev/next.
4583 // bufhead->next is most recently used.
4584 // bufhead->tail is least recently used.
4585 struct buf bufhead;
4586 
4587 void
4588 binit(void)
4589 {
4590   struct buf *b;
4591 
4592   initlock(&buf_table_lock, "buf_table");
4593 
4594   // Create linked list of buffers
4595   bufhead.prev = &bufhead;
4596   bufhead.next = &bufhead;
4597   for(b = buf; b < buf+NBUF; b++){
4598     b->next = bufhead.next;
4599     b->prev = &bufhead;
4600     bufhead.next->prev = b;
4601     bufhead.next = b;
4602   }
4603 }
4604 
4605 // Look through buffer cache for sector on device dev.
4606 // If not found, allocate fresh block.
4607 // In either case, return locked buffer.
4608 static struct buf*
4609 bget(uint dev, uint sector)
4610 {
4611   struct buf *b;
4612 
4613   acquire(&buf_table_lock);
4614 
4615  loop:
4616   // Try for cached block.
4617   for(b = bufhead.next; b != &bufhead; b = b->next){
4618     if((b->flags & (B_BUSY|B_VALID)) &&
4619        b->dev == dev && b->sector == sector){
4620       if(b->flags & B_BUSY){
4621         sleep(buf, &buf_table_lock);
4622         goto loop;
4623       }
4624       b->flags |= B_BUSY;
4625       release(&buf_table_lock);
4626       return b;
4627     }
4628   }
4629 
4630   // Allocate fresh block.
4631   for(b = bufhead.prev; b != &bufhead; b = b->prev){
4632     if((b->flags & B_BUSY) == 0){
4633       b->flags = B_BUSY;
4634       b->dev = dev;
4635       b->sector = sector;
4636       release(&buf_table_lock);
4637       return b;
4638     }
4639   }
4640   panic("bget: no buffers");
4641 }
4642 
4643 
4644 
4645 
4646 
4647 
4648 
4649 
4650 // Return a B_BUSY buf with the contents of the indicated disk sector.
4651 struct buf*
4652 bread(uint dev, uint sector)
4653 {
4654   struct buf *b;
4655 
4656   b = bget(dev, sector);
4657   if(!(b->flags & B_VALID))
4658     ide_rw(b);
4659   return b;
4660 }
4661 
4662 // Write buf's contents to disk.  Must be locked.
4663 void
4664 bwrite(struct buf *b)
4665 {
4666   if((b->flags & B_BUSY) == 0)
4667     panic("bwrite");
4668   b->flags |= B_DIRTY;
4669   ide_rw(b);
4670 }
4671 
4672 // Release the buffer buf.
4673 void
4674 brelse(struct buf *b)
4675 {
4676   if((b->flags & B_BUSY) == 0)
4677     panic("brelse");
4678 
4679   acquire(&buf_table_lock);
4680 
4681   b->next->prev = b->prev;
4682   b->prev->next = b->next;
4683   b->next = bufhead.next;
4684   b->prev = &bufhead;
4685   bufhead.next->prev = b;
4686   bufhead.next = b;
4687 
4688   b->flags &= ~B_BUSY;
4689   wakeup(buf);
4690 
4691   release(&buf_table_lock);
4692 }
4693 
4694 
4695 
4696 
4697 
4698 
4699 
