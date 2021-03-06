#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"
#include "picirq.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 0, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
    return;
  }

  // Increment nlock to make sure interrupts stay off
  // during interrupt handler.  Decrement before returning.
  cpus[cpu()].nlock++;

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapic_eoi();
    break;
/*  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
    lapic_eoi();
    break;*/
  case IRQ_OFFSET + IRQ_SPURIOUS:
    cprintf("spurious interrupt from cpu %d eip %x\n", cpu(), tf->eip);
    lapic_eoi();
    break;
    
  default:
//    if (tf->trapno <= 30)
//    {
    if ((tf->trapno >= IRQ_OFFSET) && (tf->trapno <= IRQ_MAX))
        if (irq_handler[tf->trapno - IRQ_OFFSET])
        {
//            cprintf("IRQ %d goes to handler\n", tf->trapno);
            irq_handler[tf->trapno - IRQ_OFFSET](tf);
            lapic_eoi();
            break;
        }
    if(cp == 0){
      // Otherwise it's our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
//      panic("trap");
    }
    else
    {
        // Assume process divided by zero or dereferenced null, etc.
        cprintf("pid %d %s: trap %d err %d"
                "on cpu %d eip %x -- kill proc\n",
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
        cp->killed = 1;
    }
//    }
  }
  cpus[cpu()].nlock--;

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
}
