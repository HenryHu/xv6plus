2950 #include "types.h"
2951 #include "defs.h"
2952 #include "thread.h"
2953 #include "param.h"
2954 #include "mmu.h"
2955 #include "proc.h"
2956 
2957 void thread_wrap(void (* thread)(void *arg), void *arg);
2958 
2959 extern struct proc *initproc;
2960 
2961 kproc_t kproc_start(void (* proc)(void *arg),
2962         void *arg, int prio, void *data, char *name)
2963 {
2964     kproc_t thr = (kproc_t)kmalloc(sizeof(struct thread));
2965     if (!thr)
2966         return NULL;
2967     thr->p = allocproc();
2968     struct proc *np = thr->p;
2969     if (!np)
2970         return NULL;
2971     if((np->kstack = kmalloc(KSTACKSIZE)) == 0){
2972       np->state = UNUSED;
2973       return NULL;
2974     }
2975     np->thr = thr;
2976     np->parent = initproc;
2977     np->sz = 0;
2978     np->chan = 0;
2979     np->killed = 0;
2980     thr->data = data;
2981     memset(&np->context, 0, sizeof(np->context));
2982     thr->timeouts.next = 0;
2983     if (name == 0)
2984         safestrcpy(np->name,"[kernel thread]",sizeof(np->name));
2985     else
2986         safestrcpy(np->name, name, sizeof(np->name));
2987     np->context.eip = (uint)thread_wrap;
2988     np->context.esp = (uint)np->kstack + KSTACKSIZE - 1;
2989     *(void**)(np->context.esp+8) = arg;
2990     *(void**)(np->context.esp+4) = proc;
2991     *(void**)(np->context.esp) = exit;
2992     np->cwd = namei("/");
2993     np->state = RUNNABLE;
2994     return thr;
2995 }
2996 
2997 
2998 
2999 
3000 void kproc_free(kproc_t thread)
3001 {
3002     struct proc *p = thread->p;
3003     p->thr = 0;
3004     kmfree(thread, sizeof(struct thread));
3005 }
3006 
3007 void thread_wrap(void (* thread)(void *arg), void *arg)
3008 {
3009     release(&proc_table_lock);
3010     thread(arg);
3011 }
3012 
3013 
3014 
3015 
3016 
3017 
3018 
3019 
3020 
3021 
3022 
3023 
3024 
3025 
3026 
3027 
3028 
3029 
3030 
3031 
3032 
3033 
3034 
3035 
3036 
3037 
3038 
3039 
3040 
3041 
3042 
3043 
3044 
3045 
3046 
3047 
3048 
3049 
