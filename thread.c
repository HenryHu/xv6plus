#include "types.h"
#include "defs.h"
#include "thread.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"

void thread_wrap(void (* thread)(void *arg), void *arg);

extern struct proc *initproc;

kproc_t kproc_start(void (* proc)(void *arg), 
        void *arg, int prio, void *data, char *name)
{
    kproc_t thr = (kproc_t)kmalloc(sizeof(struct thread));
    if (!thr)
        return NULL;
    thr->p = allocproc();
    struct proc *np = thr->p;
    if (!np)
        return NULL;
    if((np->kstack = kmalloc(KSTACKSIZE)) == 0){
      np->state = UNUSED;
      return NULL;
    }
    np->thr = thr;
    np->parent = initproc;
    np->sz = 0;
    np->chan = 0;
    np->killed = 0;
    thr->data = data;
    memset(&np->context, 0, sizeof(np->context));
    thr->timeouts.next = 0;
    if (name == 0)
        safestrcpy(np->name,"[kernel thread]",sizeof(np->name));
    else
        safestrcpy(np->name, name, sizeof(np->name));
    np->context.eip = (uint)thread_wrap;
    np->context.esp = (uint)np->kstack + KSTACKSIZE - 1;
    *(void**)(np->context.esp+8) = arg;
    *(void**)(np->context.esp+4) = proc;
    *(void**)(np->context.esp) = exit;
    np->cwd = namei("/");
    np->state = RUNNABLE;
    return thr;
}

void kproc_free(kproc_t thread)
{
    struct proc *p = thread->p;
    p->thr = 0;
    kmfree(thread, sizeof(struct thread));
}

void thread_wrap(void (* thread)(void *arg), void *arg)
{
    release(&proc_table_lock);
    thread(arg);
}


