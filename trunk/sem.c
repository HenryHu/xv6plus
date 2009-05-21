#include "assert.h"
#include "types.h"
#include "spinlock.h"
#include "defs.h"
#include "sem.h"

struct sem {
    struct spinlock lock;
    int val;
    int waiters;
};

int sem_init(sem_t *sem, unsigned int value)
{
    assert(value >= 0);
    initlock(&sem->lock, "sem lock");
    sem->val = value;
    sem->waiters = 0;
    return 0;
}

int sem_destroy(sem_t *sem)
{
    assert(sem->waiters == 0);
    return 0;
}

void sem_post(sem_t *sem)
{
    acquire(&sem->lock);
    sem->val++;
    if ((sem->waiters) && (sem->val > 0))
    {
        wakeup_one(sem); // XXX maybe wakeup?
    }
    release(&sem->lock);
}

void sem_wait(sem_t *sem)
{
    acquire(&sem->lock);
    while (sem->val == 0)
    {
        sem->waiters++;
        sleep(sem, &sem->lock);
        sem->waiters--;
    }
    sem->val--;
    release(&sem->lock);
}

int sem_timedwait(sem_t *sem, int timo)
{
    int ret;

    acquire(&sem->lock);
    for (ret = 0; sem->val == 0 && ret == 0;)
    {
        sem->waiters++;
        ret = msleep_spin(sem, &sem->lock, timo);
        sem->waiters--;
    }
    if (sem->val > 0)
    {
        sem->val--;
        ret = 0;
    }
    release(&sem->lock);

    return ret;
}

int sem_trywait(sem_t *sem)
{
    int ret;

    acquire(&sem->lock);
    if (sem->val > 0)
    {
        sem->val--;
        ret = 1;
    } else {
        ret = 0;
    }
    release(&sem->lock);
    return ret;
}

int sem_value(sem_t *sem)
{
    int ret;

    acquire(&sem->lock);
    ret = sem->val;
    release(&sem->lock);
    return ret;
}

int sem_size()
{
    return sizeof(struct sem);
}
