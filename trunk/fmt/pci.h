7950 #ifndef XV6_PCI_H_
7951 #define XV6_PCI_H_
7952 
7953 #include "types.h"
7954 
7955 // PCI subsystem interface
7956 enum { pci_res_bus, pci_res_mem, pci_res_io, pci_res_max };
7957 
7958 struct pci_bus;
7959 
7960 struct pci_func {
7961     struct pci_bus *bus;	// Primary bus for bridges
7962 
7963     uint32_t dev;
7964     uint32_t func;
7965 
7966     uint32_t dev_id;
7967     uint32_t dev_class;
7968 
7969     uint32_t reg_base[6];
7970     uint32_t reg_size[6];
7971     uint8_t irq_line;
7972 };
7973 
7974 struct pci_bus {
7975     struct pci_func *parent_bridge;
7976     uint32_t busno;
7977 };
7978 
7979 int pci_init(void);
7980 void pci_func_enable(struct pci_func *f);
7981 
7982 int ether_send(void *buffer, int len);
7983 int ether_receive(void *buffer, int len);
7984 
7985 #endif
7986 
7987 
7988 
7989 
7990 
7991 
7992 
7993 
7994 
7995 
7996 
7997 
7998 
7999 
