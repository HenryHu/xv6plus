1950 #include "spinlock.h"
1951 #include "param.h"
1952 #include "mmu.h"
1953 // Segments in proc->gdt
1954 #define SEG_KCODE 1  // kernel code
1955 #define SEG_KDATA 2  // kernel data+stack
1956 #define SEG_UCODE 3
1957 #define SEG_UDATA 4
1958 #define SEG_TSS   5  // this process's task state
1959 #define NSEGS     6
1960 
1961 // Saved registers for kernel context switches.
1962 // Don't need to save all the %fs etc. segment registers,
1963 // because they are constant across kernel contexts.
1964 // Save all the regular registers so we don't need to care
1965 // which are caller save, but not the return register %eax.
1966 // (Not saving %eax just simplifies the switching code.)
1967 // The layout of context must match code in swtch.S.
1968 struct context {
1969   int eip;
1970   int esp;
1971   int ebx;
1972   int ecx;
1973   int edx;
1974   int esi;
1975   int edi;
1976   int ebp;
1977 };
1978 
1979 enum proc_state { UNUSED, EMBRYO, SLEEPING, RUNNABLE,
1980     RUNNING, ZOMBIE, MSLEEPING};
1981 
1982 // Per-process state
1983 struct proc {
1984   char *mem;                // Start of process memory (kernel address)
1985   uint sz;                  // Size of process memory (bytes)
1986   char *kstack;             // Bottom of kernel stack for this process
1987   enum proc_state state;    // Process state
1988   int pid;                  // Process ID
1989   struct proc *parent;      // Parent process
1990   void *chan;               // If non-zero, sleeping on chan
1991   int killed;               // If non-zero, have been killed
1992   struct file *ofile[NOFILE];  // Open files
1993   struct inode *cwd;        // Current directory
1994   struct context context;   // Switch here to run process
1995   struct trapframe *tf;     // Trap frame for current interrupt
1996   char name[32];            // Process name (debugging)
1997   struct thread *thr;
1998 };
1999 
2000 // Process memory is laid out contiguously, low addresses first:
2001 //   text
2002 //   original data and bss
2003 //   fixed-size stack
2004 //   expandable heap
2005 
2006 // Arrange that cp point to the struct proc that this
2007 // CPU is currently running.  Such preprocessor
2008 // subterfuge can be confusing, but saves a lot of typing.
2009 extern struct proc *curproc[NCPU];  // Current (running) process per CPU
2010 #define cp (curproc[cpu()])  // Current process on this CPU
2011 
2012 
2013 #define MPSTACK 4096
2014 
2015 // Per-CPU state
2016 struct cpu {
2017   uchar apicid;               // Local APIC ID
2018   struct context context;     // Switch here to enter scheduler
2019   struct taskstate ts;        // Used by x86 to find stack for interrupt
2020   struct segdesc gdt[NSEGS];  // x86 global descriptor table
2021   char mpstack[MPSTACK];      // Per-CPU startup stack
2022   volatile int booted;        // Has the CPU started?
2023   int nlock;                  // Number of locks currently held
2024 #define MAX_LOCKS   10
2025   struct spinlock *locks[MAX_LOCKS];
2026 };
2027 
2028 extern struct cpu cpus[NCPU];
2029 extern int ncpu;
2030 extern struct spinlock proc_table_lock;
2031 
2032 
2033 
2034 
2035 
2036 
2037 
2038 
2039 
2040 
2041 
2042 
2043 
2044 
2045 
2046 
2047 
2048 
2049 
