3200 #include "types.h"
3201 #include "defs.h"
3202 #include "param.h"
3203 #include "mmu.h"
3204 #include "proc.h"
3205 #include "x86.h"
3206 #include "traps.h"
3207 #include "spinlock.h"
3208 #include "picirq.h"
3209 
3210 // Interrupt descriptor table (shared by all CPUs).
3211 struct gatedesc idt[256];
3212 extern uint vectors[];  // in vectors.S: array of 256 entry pointers
3213 struct spinlock tickslock;
3214 int ticks;
3215 
3216 void
3217 tvinit(void)
3218 {
3219   int i;
3220 
3221   for(i = 0; i < 256; i++)
3222     SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
3223   SETGATE(idt[T_SYSCALL], 0, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
3224 
3225   initlock(&tickslock, "time");
3226 }
3227 
3228 void
3229 idtinit(void)
3230 {
3231   lidt(idt, sizeof(idt));
3232 }
3233 
3234 void
3235 trap(struct trapframe *tf)
3236 {
3237   if(tf->trapno == T_SYSCALL){
3238     if(cp->killed)
3239       exit();
3240     cp->tf = tf;
3241     syscall();
3242     if(cp->killed)
3243       exit();
3244     return;
3245   }
3246 
3247   // Increment nlock to make sure interrupts stay off
3248   // during interrupt handler.  Decrement before returning.
3249   cpus[cpu()].nlock++;
3250   switch(tf->trapno){
3251   case IRQ_OFFSET + IRQ_TIMER:
3252     if(cpu() == 0){
3253       acquire(&tickslock);
3254       ticks++;
3255       wakeup(&ticks);
3256       release(&tickslock);
3257     }
3258     lapic_eoi();
3259     break;
3260   case IRQ_OFFSET + IRQ_IDE:
3261     ide_intr();
3262     lapic_eoi();
3263     break;
3264   case IRQ_OFFSET + IRQ_KBD:
3265     kbd_intr();
3266     lapic_eoi();
3267     break;
3268   case IRQ_OFFSET + IRQ_SPURIOUS:
3269     cprintf("spurious interrupt from cpu %d eip %x\n", cpu(), tf->eip);
3270     lapic_eoi();
3271     break;
3272 
3273   default:
3274 //    if (tf->trapno <= 30)
3275 //    {
3276     if ((tf->trapno >= IRQ_OFFSET) && (tf->trapno <= IRQ_MAX))
3277         if (irq_handler[tf->trapno - IRQ_OFFSET])
3278         {
3279 //            cprintf("IRQ %d goes to handler\n", tf->trapno);
3280             irq_handler[tf->trapno - IRQ_OFFSET](tf);
3281             lapic_eoi();
3282             break;
3283         }
3284     if(cp == 0){
3285       // Otherwise it's our mistake.
3286       cprintf("unexpected trap %d from cpu %d eip %x\n",
3287               tf->trapno, cpu(), tf->eip);
3288 //      panic("trap");
3289     }
3290     else
3291     {
3292         // Assume process divided by zero or dereferenced null, etc.
3293         cprintf("pid %d %s: trap %d err %d"
3294                 "on cpu %d eip %x -- kill proc\n",
3295             cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
3296         cp->killed = 1;
3297     }
3298 //    }
3299   }
3300   cpus[cpu()].nlock--;
3301 
3302   // Force process exit if it has been killed and is in user space.
3303   // (If it is still executing in the kernel, let it keep running
3304   // until it gets to the regular system call return.)
3305   if(cp && cp->killed && (tf->cs&3) == DPL_USER)
3306     exit();
3307 
3308   // Force process to give up CPU on clock tick.
3309   // If interrupts were on while locks held, would need to check nlock.
3310   if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
3311     yield();
3312 }
3313 
3314 
3315 
3316 
3317 
3318 
3319 
3320 
3321 
3322 
3323 
3324 
3325 
3326 
3327 
3328 
3329 
3330 
3331 
3332 
3333 
3334 
3335 
3336 
3337 
3338 
3339 
3340 
3341 
3342 
3343 
3344 
3345 
3346 
3347 
3348 
3349 
