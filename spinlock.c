// Mutual exclusion spin locks.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  lock->locked = 0;
  lock->cpu = 0xffffffff;
}

int int_enabled;
// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  if(holding(lock))
  {
    cprintf("lock already acquired by:\n");
    int i;
    for (i=0; i<10; i++)
    {
        if ((lock->pcs[i] == 0) || (lock->pcs[i] == 0xffffffff))
            break;
        cprintf("0x%08x ", lock->pcs[i]);
    }
    cprintf("\n");
    panic("acquire");
  }

//  if(cpus[cpu()].nlock == 0)
//  {
//    int_enabled = 0;
    cli();
//    cprintf("!D");
// }
  cpus[cpu()].nlock++;
  cpus[cpu()].locks[cpus[cpu()].nlock] = lock;

  while(cmpxchg(0, 1, &lock->locked) == 1)
    ;

  // Serialize instructions: now that lock is acquired, make sure 
  // we wait for all pending writes from other processors.
  cpuid(0, 0, 0, 0, 0);  // memory barrier (see Ch 7, IA-32 manual vol 3)
  
  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  getcallerpcs(&lock, lock->pcs);
}

// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");

  lock->pcs[0] = 0;
  lock->cpu = 0xffffffff;
  
  // Serialize instructions: before unlocking the lock, make sure
  // to flush any pending memory writes from this processor.
  cpuid(0, 0, 0, 0, 0);  // memory barrier (see Ch 7, IA-32 manual vol 3)

  if (int_enabled)
      panic("release when interrupts enabled");
  lock->locked = 0;
  if(--cpus[cpu()].nlock == 0)
  {
//      int_enabled = 1;
    sti();
 //   cprintf("!E");
  }
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
}

