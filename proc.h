#include "spinlock.h"
#include "param.h"
#include "mmu.h"
// Segments in proc->gdt
#define SEG_KCODE 1  // kernel code
#define SEG_KDATA 2  // kernel data+stack
#define SEG_UCODE 3
#define SEG_UDATA 4
#define SEG_TSS   5  // this process's task state
#define NSEGS     6

// Saved registers for kernel context switches.
// Don't need to save all the %fs etc. segment registers,
// because they are constant across kernel contexts.
// Save all the regular registers so we don't need to care
// which are caller save, but not the return register %eax.
// (Not saving %eax just simplifies the switching code.)
// The layout of context must match code in swtch.S.
struct context {
  int eip;
  int esp;
  int ebx;
  int ecx;
  int edx;
  int esi;
  int edi;
  int ebp;
};

enum proc_state { UNUSED, EMBRYO, SLEEPING, RUNNABLE, 
    RUNNING, ZOMBIE, MSLEEPING};

// Per-process state
struct proc {
  char *mem;                // Start of process memory (kernel address)
  uint sz;                  // Size of process memory (bytes)
  char *kstack;             // Bottom of kernel stack for this process
  enum proc_state state;    // Process state
  int pid;                  // Process ID
  struct proc *parent;      // Parent process
  void *chan;               // If non-zero, sleeping on chan
  int killed;               // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;        // Current directory
  struct context context;   // Switch here to run process
  struct trapframe *tf;     // Trap frame for current interrupt
  char name[32];            // Process name (debugging)
  struct thread *thr;
};

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap

// Arrange that cp point to the struct proc that this
// CPU is currently running.  Such preprocessor 
// subterfuge can be confusing, but saves a lot of typing.
extern struct proc *curproc[NCPU];  // Current (running) process per CPU
#define cp (curproc[cpu()])  // Current process on this CPU


#define MPSTACK 4096

// Per-CPU state
struct cpu {
  uchar apicid;               // Local APIC ID
  struct context context;     // Switch here to enter scheduler
  struct taskstate ts;        // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];  // x86 global descriptor table
  char mpstack[MPSTACK];      // Per-CPU startup stack
  volatile int booted;        // Has the CPU started?
  int nlock;                  // Number of locks currently held
#define MAX_LOCKS   10
  struct spinlock *locks[MAX_LOCKS];
};

extern struct cpu cpus[NCPU];
extern int ncpu;
extern struct spinlock proc_table_lock;
