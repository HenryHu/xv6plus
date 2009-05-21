1700 #include "assert.h"
1701 #include "types.h"
1702 #include "spinlock.h"
1703 #include "defs.h"
1704 #include "sem.h"
1705 
1706 struct sem {
1707     struct spinlock lock;
1708     int val;
1709     int waiters;
1710 };
1711 
1712 int sem_init(sem_t *sem, unsigned int value)
1713 {
1714     assert(value >= 0);
1715     initlock(&sem->lock, "sem lock");
1716     sem->val = value;
1717     sem->waiters = 0;
1718     return 0;
1719 }
1720 
1721 int sem_destroy(sem_t *sem)
1722 {
1723     assert(sem->waiters == 0);
1724     return 0;
1725 }
1726 
1727 void sem_post(sem_t *sem)
1728 {
1729     acquire(&sem->lock);
1730     sem->val++;
1731     if ((sem->waiters) && (sem->val > 0))
1732     {
1733         wakeup_one(sem); // XXX maybe wakeup?
1734     }
1735     release(&sem->lock);
1736 }
1737 
1738 void sem_wait(sem_t *sem)
1739 {
1740     acquire(&sem->lock);
1741     while (sem->val == 0)
1742     {
1743         sem->waiters++;
1744         sleep(sem, &sem->lock);
1745         sem->waiters--;
1746     }
1747     sem->val--;
1748     release(&sem->lock);
1749 }
1750 int sem_timedwait(sem_t *sem, int timo)
1751 {
1752     int ret;
1753 
1754     acquire(&sem->lock);
1755     for (ret = 0; sem->val == 0 && ret == 0;)
1756     {
1757         sem->waiters++;
1758         ret = msleep_spin(sem, &sem->lock, timo);
1759         sem->waiters--;
1760     }
1761     if (sem->val > 0)
1762     {
1763         sem->val--;
1764         ret = 0;
1765     }
1766     release(&sem->lock);
1767 
1768     return ret;
1769 }
1770 
1771 int sem_trywait(sem_t *sem)
1772 {
1773     int ret;
1774 
1775     acquire(&sem->lock);
1776     if (sem->val > 0)
1777     {
1778         sem->val--;
1779         ret = 1;
1780     } else {
1781         ret = 0;
1782     }
1783     release(&sem->lock);
1784     return ret;
1785 }
1786 
1787 int sem_value(sem_t *sem)
1788 {
1789     int ret;
1790 
1791     acquire(&sem->lock);
1792     ret = sem->val;
1793     release(&sem->lock);
1794     return ret;
1795 }
1796 
1797 
1798 
1799 
1800 int sem_size()
1801 {
1802     return sizeof(struct sem);
1803 }
1804 
1805 
1806 
1807 
1808 
1809 
1810 
1811 
1812 
1813 
1814 
1815 
1816 
1817 
1818 
1819 
1820 
1821 
1822 
1823 
1824 
1825 
1826 
1827 
1828 
1829 
1830 
1831 
1832 
1833 
1834 
1835 
1836 
1837 
1838 
1839 
1840 
1841 
1842 
1843 
1844 
1845 
1846 
1847 
1848 
1849 
