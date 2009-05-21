1850 #ifndef XV6_ASSERT_H_
1851 #define XV6_ASSERT_H_
1852 
1853 #define assert(expr) \
1854     ((expr) ? (void)0 : __assert(__func__, __FILE__, \
1855         __LINE__, #expr))
1856 
1857 void __assert(const char *, const char *, int, const char *);
1858 
1859 #endif // XV6_ASSERT_H_
1860 
1861 
1862 
1863 
1864 
1865 
1866 
1867 
1868 
1869 
1870 
1871 
1872 
1873 
1874 
1875 
1876 
1877 
1878 
1879 
1880 
1881 
1882 
1883 
1884 
1885 
1886 
1887 
1888 
1889 
1890 
1891 
1892 
1893 
1894 
1895 
1896 
1897 
1898 
1899 
