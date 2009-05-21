#ifndef XV6_SEM_H_
#define XV6_SEM_H_

struct sem;
typedef struct sem sem_t;

int sem_init(sem_t *sem, unsigned int value);
int sem_destroy(sem_t *sem);
void sem_post(sem_t *sem);
void sem_wait(sem_t *sem);
int sem_timedwait(sem_t *sem, int timo);
int sem_trywait(sem_t *sem);
int sem_value(sem_t *sem);
int sem_size();

#endif // XV6_SEM_H_
