6950 #ifndef XV6_PICIRQ_H_
6951 #define XV6_PICIRQ_H_
6952 #include "x86.h"
6953 
6954 typedef void (*irq_handler_t)(struct trapframe *);
6955 extern irq_handler_t irq_handler[];
6956 void reg_irq_handler(int irq_num, irq_handler_t handler);
6957 #define IRQ_MAX         256
6958 
6959 #endif // XV6_PICIRQ_H_
6960 
6961 
6962 
6963 
6964 
6965 
6966 
6967 
6968 
6969 
6970 
6971 
6972 
6973 
6974 
6975 
6976 
6977 
6978 
6979 
6980 
6981 
6982 
6983 
6984 
6985 
6986 
6987 
6988 
6989 
6990 
6991 
6992 
6993 
6994 
6995 
6996 
6997 
6998 
6999 
