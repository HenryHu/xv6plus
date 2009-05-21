4350 // Simple PIO-based (non-DMA) IDE driver code.
4351 
4352 #include "types.h"
4353 #include "defs.h"
4354 #include "param.h"
4355 #include "mmu.h"
4356 #include "proc.h"
4357 #include "x86.h"
4358 #include "traps.h"
4359 #include "spinlock.h"
4360 #include "buf.h"
4361 #include "picirq.h"
4362 
4363 #define IDE_BSY       0x80
4364 #define IDE_DRDY      0x40
4365 #define IDE_DF        0x20
4366 #define IDE_ERR       0x01
4367 
4368 #define IDE_CMD_READ  0x20
4369 #define IDE_CMD_WRITE 0x30
4370 
4371 // ide_queue points to the buf now being read/written to the disk.
4372 // ide_queue->qnext points to the next buf to be processed.
4373 // You must hold ide_lock while manipulating queue.
4374 
4375 static struct spinlock ide_lock;
4376 static struct buf *ide_queue;
4377 
4378 static int disk_1_present;
4379 static void ide_start_request();
4380 
4381 // Wait for IDE disk to become ready.
4382 static int
4383 ide_wait_ready(int check_error)
4384 {
4385   int r;
4386 
4387   while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
4388     ;
4389   if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
4390     return -1;
4391   return 0;
4392 }
4393 
4394 void
4395 dummy_ide_intr(struct trapframe *tf)
4396 {
4397 }
4398 
4399 
4400 void
4401 ide_init(void)
4402 {
4403   int i;
4404 
4405   initlock(&ide_lock, "ide");
4406   pic_enable(IRQ_IDE);
4407   ioapic_enable(IRQ_IDE, ncpu - 1);
4408   ide_wait_ready(0);
4409   reg_irq_handler(IRQ_IDE_2, dummy_ide_intr);
4410 
4411   // Check if disk 1 is present
4412   outb(0x1f6, 0xe0 | (1<<4));
4413   for(i=0; i<1000; i++){
4414     if(inb(0x1f7) != 0){
4415       disk_1_present = 1;
4416       break;
4417     }
4418   }
4419 
4420   // Switch back to disk 0.
4421   outb(0x1f6, 0xe0 | (0<<4));
4422   outb(0x3f6, 0);  // generate interrupt
4423 }
4424 
4425 // Start the request for b.  Caller must hold ide_lock.
4426 static void
4427 ide_start_request(struct buf *b)
4428 {
4429 //    cprintf("XXX ide_start_request\n");
4430   if(b == 0)
4431     panic("ide_start_request");
4432 
4433   ide_wait_ready(0);
4434   outb(0x1f2, 1);  // number of sectors
4435   outb(0x1f3, b->sector & 0xff);
4436   outb(0x1f4, (b->sector >> 8) & 0xff);
4437   outb(0x1f5, (b->sector >> 16) & 0xff);
4438   outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
4439   if(b->flags & B_DIRTY){
4440     outb(0x1f7, IDE_CMD_WRITE);
4441     outsl(0x1f0, b->data, 512/4);
4442   } else {
4443     outb(0x1f7, IDE_CMD_READ);
4444   }
4445 }
4446 
4447 
4448 
4449 
4450 // Interrupt handler.
4451 void
4452 ide_intr(void)
4453 {
4454   struct buf *b;
4455 
4456   acquire(&ide_lock);
4457   if((b = ide_queue) == 0){
4458     release(&ide_lock);
4459     return;
4460   }
4461 
4462   // Read data if needed.
4463   if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
4464     insl(0x1f0, b->data, 512/4);
4465 
4466   // Wake process waiting for this buf.
4467   b->flags |= B_VALID;
4468   b->flags &= ~B_DIRTY;
4469   wakeup(b);
4470 
4471   // Start disk on next buf in queue.
4472   if((ide_queue = b->qnext) != 0)
4473     ide_start_request(ide_queue);
4474 
4475   release(&ide_lock);
4476 }
4477 
4478 // Sync buf with disk.
4479 // If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
4480 // Else if B_VALID is not set, read buf from disk, set B_VALID.
4481 void
4482 ide_rw(struct buf *b)
4483 {
4484   struct buf **pp;
4485 
4486   if(!(b->flags & B_BUSY))
4487     panic("ide_rw: buf not busy");
4488   if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
4489     panic("ide_rw: nothing to do");
4490   if(b->dev != 0 && !disk_1_present)
4491     panic("ide disk 1 not present");
4492 
4493   acquire(&ide_lock);
4494 
4495   // Append b to ide_queue.
4496   b->qnext = 0;
4497   for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
4498     ;
4499   *pp = b;
4500   // Start disk if necessary.
4501   if(ide_queue == b)
4502     ide_start_request(b);
4503 
4504   // Wait for request to finish.
4505   // Assuming will not sleep too long: ignore cp->killed.
4506   while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
4507   {
4508     sleep(b, &ide_lock);
4509   }
4510 //  cprintf("XXX ide_rw: finished\n");
4511 
4512   release(&ide_lock);
4513 }
4514 
4515 
4516 
4517 
4518 
4519 
4520 
4521 
4522 
4523 
4524 
4525 
4526 
4527 
4528 
4529 
4530 
4531 
4532 
4533 
4534 
4535 
4536 
4537 
4538 
4539 
4540 
4541 
4542 
4543 
4544 
4545 
4546 
4547 
4548 
4549 
