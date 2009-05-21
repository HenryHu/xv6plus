1650 #ifndef XV6_SEM_H_
1651 #define XV6_SEM_H_
1652 
1653 struct sem;
1654 typedef struct sem sem_t;
1655 
1656 int sem_init(sem_t *sem, unsigned int value);
1657 int sem_destroy(sem_t *sem);
1658 void sem_post(sem_t *sem);
1659 void sem_wait(sem_t *sem);
1660 int sem_timedwait(sem_t *sem, int timo);
1661 int sem_trywait(sem_t *sem);
1662 int sem_value(sem_t *sem);
1663 int sem_size();
1664 
1665 #endif // XV6_SEM_H_
1666 
1667 
1668 
1669 
1670 
1671 
1672 
1673 
1674 
1675 
1676 
1677 
1678 
1679 
1680 
1681 
1682 
1683 
1684 
1685 
1686 
1687 
1688 
1689 
1690 
1691 
1692 
1693 
1694 
1695 
1696 
1697 
1698 
1699 
