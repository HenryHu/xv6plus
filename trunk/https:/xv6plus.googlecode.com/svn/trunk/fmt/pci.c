8750 #include "types.h"
8751 #include "x86.h"
8752 #include "defs.h"
8753 #include "pci.h"
8754 #include "pcireg.h"
8755 #include "assert.h"
8756 #include "e100.h"
8757 
8758 // Flag to do "lspci" at bootup
8759 static int pci_show_devs = 1;
8760 static int pci_show_addrs = 1;
8761 
8762 // PCI "configuration mechanism one"
8763 static uint32_t pci_conf1_addr_ioport = 0x0cf8;
8764 static uint32_t pci_conf1_data_ioport = 0x0cfc;
8765 
8766 // Forward declarations
8767 static int pci_bridge_attach(struct pci_func *pcif);
8768 static int pci_bridge_pci_attach(struct pci_func *pcif);
8769 static int pci_display_attach(struct pci_func *pcif);
8770 static int pci_net_ether_attach(struct pci_func *pcif);
8771 
8772 // PCI driver table
8773 struct pci_driver {
8774     uint32_t key1, key2;
8775     int (*attachfn) (struct pci_func *pcif);
8776 };
8777 
8778 #define PCI_SUBCLASS_ANY 0xffff
8779 
8780 struct pci_driver pci_attach_class[] = {
8781     { PCI_CLASS_BRIDGE, PCI_SUBCLASS_ANY, &pci_bridge_attach },
8782     { PCI_CLASS_BRIDGE, PCI_SUBCLASS_BRIDGE_PCI, &pci_bridge_pci_attach },
8783     { PCI_CLASS_DISPLAY, PCI_SUBCLASS_ANY, &pci_display_attach },
8784     { PCI_CLASS_NETWORK, PCI_SUBCLASS_NETWORK_ETHERNET,
8785         &pci_net_ether_attach },
8786     { 0, 0, 0 },
8787 };
8788 
8789 struct pci_driver pci_attach_vendor[] = {
8790     { PCI_VENDOR_INTEL, PCI_PRODUCT_E100, &ether_e100_attach },
8791     { 0, 0, 0 },
8792 };
8793 
8794 
8795 
8796 
8797 
8798 
8799 
8800 static void
8801 pci_conf1_set_addr(uint32_t bus,
8802 		   uint32_t dev,
8803 		   uint32_t func,
8804 		   uint32_t offset)
8805 {
8806     assert(bus < 256);
8807     assert(dev < 32);
8808     assert(func < 8);
8809     assert(offset < 256);
8810     assert((offset & 0x3) == 0);
8811 
8812     uint32_t v = (1 << 31) |		// config-space
8813 		 (bus << 16) | (dev << 11) | (func << 8) | (offset);
8814     outl(pci_conf1_addr_ioport, v);
8815 }
8816 
8817 static uint32_t
8818 pci_conf_read(struct pci_func *f, uint32_t off)
8819 {
8820     pci_conf1_set_addr(f->bus->busno, f->dev, f->func, off);
8821     return inl(pci_conf1_data_ioport);
8822 }
8823 
8824 static void
8825 pci_conf_write(struct pci_func *f, uint32_t off, uint32_t v)
8826 {
8827     pci_conf1_set_addr(f->bus->busno, f->dev, f->func, off);
8828     outl(pci_conf1_data_ioport, v);
8829 }
8830 
8831 static int __attribute__((warn_unused_result))
8832 pci_attach_match(uint32_t key1, uint32_t key2,
8833 		 struct pci_driver *list, struct pci_func *pcif)
8834 {
8835     uint32_t i;
8836 
8837     for (i = 0; list[i].attachfn; i++) {
8838 	if (list[i].key1 == key1 )
8839         if ((list[i].key2 == key2) || (list[i].key2 == 0xffff)) {
8840 	        int r = list[i].attachfn(pcif);
8841 	        if (r > 0)
8842 		        return r;
8843 	        if (r < 0)
8844 		///cprintf("pci_attach_match: attaching %x.%x (%p): %s\n",
8845 		//	key1, key2, list[i].attachfn, e2s(r));
8846 		        cprintf("pci_attach_match: attaching %x.%x (%p): SOME ERROR\n",
8847 			        key1, key2, list[i].attachfn);
8848 	    }
8849     }
8850     return 0;
8851 }
8852 
8853 static int
8854 pci_attach(struct pci_func *f)
8855 {
8856     return
8857 	pci_attach_match(PCI_CLASS(f->dev_class), PCI_SUBCLASS(f->dev_class),
8858 			 &pci_attach_class[0], f) ||
8859 	pci_attach_match(PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
8860 			 &pci_attach_vendor[0], f);
8861 }
8862 
8863 static int
8864 pci_scan_bus(struct pci_bus *bus)
8865 {
8866     int totaldev = 0;
8867     struct pci_func df;
8868     memset(&df, 0, sizeof(df));
8869     df.bus = bus;
8870 
8871     for (df.dev = 0; df.dev < 32; df.dev++) {
8872 	uint32_t bhlc = pci_conf_read(&df, PCI_BHLC_REG);
8873 	if (PCI_HDRTYPE_TYPE(bhlc) > 1)	    // Unsupported or no device
8874 	    continue;
8875 
8876 	totaldev++;
8877 
8878 	struct pci_func f = df;
8879 	for (f.func = 0; f.func < (PCI_HDRTYPE_MULTIFN(bhlc) ? 8 : 1);
8880 			 f.func++) {
8881 	    struct pci_func af = f;
8882 
8883 	    af.dev_id = pci_conf_read(&f, PCI_ID_REG);
8884 	    if (PCI_VENDOR(af.dev_id) == 0xffff)
8885 		continue;
8886 
8887 	    uint32_t intr = pci_conf_read(&af, PCI_INTERRUPT_REG);
8888 	    af.irq_line = PCI_INTERRUPT_LINE(intr);
8889 
8890 	    af.dev_class = pci_conf_read(&af, PCI_CLASS_REG);
8891 	    if (pci_show_devs)
8892 		cprintf("PCI: %02x:%02x.%d: %04x:%04x: class %x.%x irq %d\n",
8893 			af.bus->busno, af.dev, af.func,
8894 			PCI_VENDOR(af.dev_id), PCI_PRODUCT(af.dev_id),
8895 			PCI_CLASS(af.dev_class), PCI_SUBCLASS(af.dev_class),
8896 			af.irq_line);
8897 
8898 
8899 
8900 	    pci_attach(&af);
8901 	}
8902     }
8903 
8904     return totaldev;
8905 }
8906 
8907 static int
8908 pci_net_ether_attach(struct pci_func *pcif)
8909 {
8910     cprintf("PCI: %02x:%02x.%d: Network (ethernet) %04x:%04x\n",
8911 		pcif->bus->busno, pcif->dev, pcif->func,
8912         PCI_VENDOR(pcif->dev_id), PCI_PRODUCT(pcif->dev_id));
8913     return 0;
8914 }
8915 
8916 static int
8917 pci_bridge_attach(struct pci_func *pcif)
8918 {
8919     cprintf("PCI: %02x:%02x.%d: Bridge %04x:%04x\n",
8920 		pcif->bus->busno, pcif->dev, pcif->func,
8921         PCI_VENDOR(pcif->dev_id), PCI_PRODUCT(pcif->dev_id));
8922     return 0;
8923 }
8924 
8925 static int
8926 pci_bridge_pci_attach(struct pci_func *pcif)
8927 {
8928     uint32_t ioreg  = pci_conf_read(pcif, PCI_BRIDGE_STATIO_REG);
8929     uint32_t busreg = pci_conf_read(pcif, PCI_BRIDGE_BUS_REG);
8930 
8931     if (PCI_BRIDGE_IO_32BITS(ioreg)) {
8932 	cprintf("PCI: %02x:%02x.%d: 32-bit bridge IO not supported.\n",
8933 		pcif->bus->busno, pcif->dev, pcif->func);
8934 	return 0;
8935     }
8936 
8937     struct pci_bus nbus;
8938     memset(&nbus, 0, sizeof(nbus));
8939     nbus.parent_bridge = pcif;
8940     nbus.busno = (busreg >> PCI_BRIDGE_BUS_SECONDARY_SHIFT) & 0xff;
8941 
8942     if (pci_show_devs)
8943 	cprintf("PCI: %02x:%02x.%d: bridge to PCI bus %d--%d\n",
8944 		pcif->bus->busno, pcif->dev, pcif->func,
8945 		nbus.busno,
8946 		(busreg >> PCI_BRIDGE_BUS_SUBORDINATE_SHIFT) & 0xff);
8947 
8948 
8949 
8950     pci_scan_bus(&nbus);
8951     return 1;
8952 }
8953 
8954 static int
8955 pci_display_attach(struct pci_func *pcif)
8956 {
8957     cprintf("PCI: %02x:%02x.%d: Display %04x:%04x\n",
8958 		pcif->bus->busno, pcif->dev, pcif->func,
8959         PCI_VENDOR(pcif->dev_id), PCI_PRODUCT(pcif->dev_id));
8960     return 0;
8961 }
8962 
8963 // External PCI subsystem interface
8964 
8965 void
8966 pci_func_enable(struct pci_func *f)
8967 {
8968     pci_conf_write(f, PCI_COMMAND_STATUS_REG,
8969 		   PCI_COMMAND_IO_ENABLE |
8970 		   PCI_COMMAND_MEM_ENABLE |
8971 		   PCI_COMMAND_MASTER_ENABLE);
8972 
8973     uint32_t bar_width;
8974     uint32_t bar;
8975     for (bar = PCI_MAPREG_START; bar < PCI_MAPREG_END;
8976 	 bar += bar_width)
8977     {
8978 	uint32_t oldv = pci_conf_read(f, bar);
8979 
8980 	bar_width = 4;
8981 	pci_conf_write(f, bar, 0xffffffff);
8982 	uint32_t rv = pci_conf_read(f, bar);
8983 
8984 	if (rv == 0)
8985 	    continue;
8986 
8987 	int regnum = PCI_MAPREG_NUM(bar);
8988 	uint32_t base, size;
8989 	if (PCI_MAPREG_TYPE(rv) == PCI_MAPREG_TYPE_MEM) {
8990 	    if (PCI_MAPREG_MEM_TYPE(rv) == PCI_MAPREG_MEM_TYPE_64BIT)
8991 		bar_width = 8;
8992 
8993 	    size = PCI_MAPREG_MEM_SIZE(rv);
8994 	    base = PCI_MAPREG_MEM_ADDR(oldv);
8995 	    if (pci_show_addrs)
8996 		cprintf("  mem region %d: %d bytes at 0x%x\n",
8997 			regnum, size, base);
8998 	} else {
8999 	    size = PCI_MAPREG_IO_SIZE(rv);
9000 	    base = PCI_MAPREG_IO_ADDR(oldv);
9001 	    if (pci_show_addrs)
9002 		cprintf("  io region %d: %d bytes at 0x%x\n",
9003 			regnum, size, base);
9004 	}
9005 
9006 	pci_conf_write(f, bar, oldv);
9007 	f->reg_base[regnum] = base;
9008 	f->reg_size[regnum] = size;
9009 
9010 	cprintf("  -> reg_base[%d] = %08x\n", regnum, base);
9011 	cprintf("  -> reg_size[%d] = %08x\n", regnum, size);
9012 
9013 	if (size && !base)
9014 	    cprintf("PCI device %02x:%02x.%d (%04x:%04x) may be misconfigured: "
9015 		    "region %d: base 0x%x, size %d\n",
9016 		    f->bus->busno, f->dev, f->func,
9017 		    PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
9018 		    regnum, base, size);
9019     }
9020 }
9021 
9022 int ether_receive(void *buffer, int len)
9023 {
9024     if (len == 0)
9025         return 0;
9026     int ret;
9027     ret = e100_receive(buffer, len);
9028     if (ret > 0)
9029         return ret;
9030     return -2;
9031 }
9032 
9033 int ether_send(void *buffer, int len)
9034 {
9035     if (len == 0)
9036         return 0;
9037     int ret;
9038     ret = e100_send(buffer, len);
9039     if (ret > 0)
9040         return ret;
9041     return -2;
9042 }
9043 
9044 
9045 
9046 
9047 
9048 
9049 
9050 int
9051 pci_init(void)
9052 {
9053     static struct pci_bus root_bus;
9054     memset(&root_bus, 0, sizeof(root_bus));
9055 
9056     return pci_scan_bus(&root_bus);
9057 }
9058 
9059 
9060 
9061 
9062 
9063 
9064 
9065 
9066 
9067 
9068 
9069 
9070 
9071 
9072 
9073 
9074 
9075 
9076 
9077 
9078 
9079 
9080 
9081 
9082 
9083 
9084 
9085 
9086 
9087 
9088 
9089 
9090 
9091 
9092 
9093 
9094 
9095 
9096 
9097 
9098 
9099 
