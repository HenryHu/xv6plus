9100 #ifndef XV6_E100_H_
9101 #define XV6_E100_H_
9102 #include "pci.h"
9103 
9104 int ether_e100_attach(struct pci_func *pcif);
9105 int e100_send(void *buffer, uint32_t len);
9106 int e100_receive(void *buffer, uint32_t len);
9107 
9108 #define PCI_VENDOR_INTEL    0x8086
9109 #define PCI_PRODUCT_E100    0x1209
9110 
9111 #define E100_MAX_DEVS       10
9112 
9113 #define E100_IOPORT_SIZE    64
9114 #define E100_CU_RING_SIZE   32
9115 #define E100_RU_RING_SIZE   32
9116 #define E100_CB_SIZE       2048
9117 #define E100_RFD_SIZE      2048
9118 
9119 // Control / Status Register
9120 #define SCB_STATUS          0x0 // Status
9121 #define SCB_COMMAND         0x2 // Command
9122 #define SCB_GENPTR          0x4 // General Pointer
9123 #define SCB_PORT            0x8 // PORT
9124 #define SCB_EEPROM_CTL      0xE // EEPROM Control
9125 #define SCB_MDI_CTL         0x10    // MDI Control
9126 #define SCB_RX_COUNT        0x14    // RX DMA Byte Count
9127 #define SCB_FLOW_CTL        0x19    // Flow Control
9128 #define SCB_PMDR            0x21    // PMDR
9129 #define SCB_GEN_CTL         0x1C    // General Control
9130 #define SCB_GEN_STATUS      0x1D    // General Status
9131 #define SCB_FUNC_EVT        0x30    // Function Event
9132 #define SCB_FUN_MASK        0x34    // Function Event Mask
9133 #define SCB_FUNC_STATE      0x38    // Function Present State
9134 #define SCB_FORCE_EVT       0x3C    // Force Event
9135 
9136 // CU Command
9137 #define CUC_NOP             0x0
9138 #define CUC_START           0x1
9139 #define CUC_RESUME          0x2
9140 #define CUC_LOAD_DC_ADDR    0x4
9141 #define CUC_DUMP            0x5
9142 #define CUC_LOAD_BASE       0x6
9143 #define CUC_DUMP_RESET      0x7
9144 #define CUC_STAT_RESUME     0xA
9145 
9146 
9147 
9148 
9149 
9150 // RU Command
9151 #define RUC_NOP             0x0
9152 #define RUC_START           0x1
9153 #define RUC_RESUME          0x2
9154 #define RUC_RCV_DMA         0x3
9155 #define RUC_ABORT           0x4
9156 #define RUC_LOAD_HDS        0x5
9157 #define RUC_LOAD_BASE       0x6
9158 
9159 // PORT Function
9160 #define PORT_SOFT_RESET     0
9161 #define PORT_SELF_TEST      1
9162 #define PORT_SElECT_TEST    2
9163 #define PORT_DUMP           3
9164 #define PORT_DUMP_WAKE      7
9165 
9166 // Operation Codes
9167 #define OP_NOP              0
9168 #define OP_ADDR_SETUP       1
9169 #define OP_CONFIG           2
9170 #define OP_MUL_ADDR_SETUP   3
9171 #define OP_TRANSMIT         4
9172 #define OP_LOAD_MC          5
9173 #define OP_DUMP             6
9174 #define OP_DIAG             7
9175 
9176 // CU Status
9177 #define CUS_IDLE            0
9178 #define CUS_SUSPENDED       1
9179 #define CUS_LPQ             2
9180 #define CUS_HQP             3
9181 
9182 struct scb_status_word {
9183     char zero : 2;
9184     char rus  : 4;
9185     char cus  : 2;
9186     // STAT / ACK
9187     char fcp  : 1;
9188     char rsv  : 1;
9189     char swi  : 1;
9190     char mdi  : 1;
9191     char rnr  : 1;
9192     char cna  : 1;
9193     char fr   : 1;
9194     char cx   : 1;
9195 };
9196 
9197 
9198 
9199 
9200 typedef union scb_status_word_tag {
9201     uint16_t word;
9202     struct scb_status_word status;
9203 } scb_status_word;
9204 
9205 struct scb_command_word {
9206     char ru_command : 3;
9207     char res : 1;
9208     char cu_command : 4;
9209     // Interrupt Masks
9210     char m : 1;
9211     char si : 1;
9212     char fcp_mask : 1;
9213     char er_mask : 1;
9214     char rnr_mask : 1;
9215     char cna_mask : 1;
9216     char fr_mask : 1;
9217     char cx_mask : 1;
9218 };
9219 
9220 typedef union scb_command_word_tag {
9221     uint16_t word;
9222     struct scb_command_word cmd;
9223 } scb_command_word;
9224 
9225 typedef struct command_block_tag {
9226     volatile union {
9227         uint16_t status_word;
9228         struct {
9229             short stat :    13;
9230             char ok :       1;    // No Error
9231             char x :        1;
9232             char c :        1;     // Completed
9233         };
9234     };
9235     union {
9236         uint16_t cmd_word;
9237         struct {
9238             char cmd :  3;
9239             short res : 10;
9240             char i :    1;     // Interrupt after finish
9241             char s :    1;     // Suspend after complete
9242             char el :   1;    // Last one
9243         };
9244     };
9245     struct command_block_tag * link;
9246 } command_block;
9247 
9248 
9249 
9250 typedef struct op_transmit_cmd_cmd_tag {
9251     union {
9252         uint16_t word;
9253         struct {
9254             char cmd    : 3;
9255             char sf     : 1;
9256             char nc     : 1;
9257             char res    : 3;
9258             char cid    : 5;
9259             char i      : 1;
9260             char s      : 1;
9261             char el     : 1;
9262         };
9263     };
9264 } op_transmit_cmd_cmd;
9265 
9266 typedef struct op_transmit_cmd {
9267     command_block base_cmd;
9268     uint32_t tbd_addr;
9269     struct {
9270         int byte_count :14;
9271         char res :      1;
9272         char eof :      1;
9273         uint8_t trans_thres;
9274         uint8_t tbd_num;
9275     };
9276 } op_transmit_cmd;
9277 
9278 typedef struct rf_desc {
9279     volatile command_block head;
9280     uint32_t res;
9281     volatile struct {
9282         uint16_t count :    14;
9283         char f :            1;
9284         char eof :          1;
9285         uint16_t size :     14;
9286         char res2 :         2;
9287     };
9288 } rf_desc;
9289 
9290 typedef struct rf_status {
9291     char tco :      1;
9292     char ia :       1;
9293     char nomatch :  1;
9294     char res :      1;
9295     char rcv_err :  1;
9296     char type :     1;
9297     char res2 :     1;
9298     char tooshort : 1;
9299     char dma_err :  1;
9300     char no_buf :   1;
9301     char align_err :1;
9302     char crc_err :  1;
9303     char res3 :     1;
9304 } rf_status;
9305 
9306 #define TBD_DATA_LIMIT  1600
9307 
9308 
9309 #endif	// XV6_E100_H_
9310 
9311 
9312 
9313 
9314 
9315 
9316 
9317 
9318 
9319 
9320 
9321 
9322 
9323 
9324 
9325 
9326 
9327 
9328 
9329 
9330 
9331 
9332 
9333 
9334 
9335 
9336 
9337 
9338 
9339 
9340 
9341 
9342 
9343 
9344 
9345 
9346 
9347 
9348 
9349 
