1500 // Mutual exclusion spin locks.
1501 
1502 #include "types.h"
1503 #include "defs.h"
1504 #include "param.h"
1505 #include "x86.h"
1506 #include "mmu.h"
1507 #include "proc.h"
1508 #include "spinlock.h"
1509 
1510 extern int use_console_lock;
1511 
1512 void
1513 initlock(struct spinlock *lock, char *name)
1514 {
1515   lock->name = name;
1516   lock->locked = 0;
1517   lock->cpu = 0xffffffff;
1518 }
1519 
1520 int int_enabled;
1521 // Acquire the lock.
1522 // Loops (spins) until the lock is acquired.
1523 // Holding a lock for a long time may cause
1524 // other CPUs to waste time spinning to acquire it.
1525 void
1526 acquire(struct spinlock *lock)
1527 {
1528   if(holding(lock))
1529   {
1530     cprintf("lock already acquired by:\n");
1531     int i;
1532     for (i=0; i<10; i++)
1533     {
1534         if ((lock->pcs[i] == 0) || (lock->pcs[i] == 0xffffffff))
1535             break;
1536         cprintf("0x%08x ", lock->pcs[i]);
1537     }
1538     cprintf("\n");
1539     panic("acquire");
1540   }
1541 
1542 //  if(cpus[cpu()].nlock == 0)
1543 //  {
1544 //    int_enabled = 0;
1545     cli();
1546 //    cprintf("!D");
1547 // }
1548   cpus[cpu()].nlock++;
1549   cpus[cpu()].locks[cpus[cpu()].nlock] = lock;
1550   while(cmpxchg(0, 1, &lock->locked) == 1)
1551     ;
1552 
1553   // Serialize instructions: now that lock is acquired, make sure
1554   // we wait for all pending writes from other processors.
1555   cpuid(0, 0, 0, 0, 0);  // memory barrier (see Ch 7, IA-32 manual vol 3)
1556 
1557   // Record info about lock acquisition for debugging.
1558   // The +10 is only so that we can tell the difference
1559   // between forgetting to initialize lock->cpu
1560   // and holding a lock on cpu 0.
1561   lock->cpu = cpu() + 10;
1562   getcallerpcs(&lock, lock->pcs);
1563 }
1564 
1565 // Release the lock.
1566 void
1567 release(struct spinlock *lock)
1568 {
1569   if(!holding(lock))
1570     panic("release");
1571 
1572   lock->pcs[0] = 0;
1573   lock->cpu = 0xffffffff;
1574 
1575   // Serialize instructions: before unlocking the lock, make sure
1576   // to flush any pending memory writes from this processor.
1577   cpuid(0, 0, 0, 0, 0);  // memory barrier (see Ch 7, IA-32 manual vol 3)
1578 
1579   if (int_enabled)
1580       panic("release when interrupts enabled");
1581   lock->locked = 0;
1582   if(--cpus[cpu()].nlock == 0)
1583   {
1584 //      int_enabled = 1;
1585     sti();
1586  //   cprintf("!E");
1587   }
1588 }
1589 
1590 
1591 
1592 
1593 
1594 
1595 
1596 
1597 
1598 
1599 
1600 // Record the current call stack in pcs[] by following the %ebp chain.
1601 void
1602 getcallerpcs(void *v, uint pcs[])
1603 {
1604   uint *ebp;
1605   int i;
1606 
1607   ebp = (uint*)v - 2;
1608   for(i = 0; i < 10; i++){
1609     if(ebp == 0 || ebp == (uint*)0xffffffff)
1610       break;
1611     pcs[i] = ebp[1];     // saved %eip
1612     ebp = (uint*)ebp[0]; // saved %ebp
1613   }
1614   for(; i < 10; i++)
1615     pcs[i] = 0;
1616 }
1617 
1618 // Check whether this cpu is holding the lock.
1619 int
1620 holding(struct spinlock *lock)
1621 {
1622   return lock->locked && lock->cpu == cpu() + 10;
1623 }
1624 
1625 
1626 
1627 
1628 
1629 
1630 
1631 
1632 
1633 
1634 
1635 
1636 
1637 
1638 
1639 
1640 
1641 
1642 
1643 
1644 
1645 
1646 
1647 
1648 
1649 
