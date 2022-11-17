#include <defs.h>
#include <stub.c>

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_mprj_io_0  = 0xAAA;
    reg_mprj_io_1  = 0x1555;
    reg_mprj_io_2  = 0xAAA;
    reg_mprj_io_3  = 0x1555;
    reg_mprj_io_4  = 0xAAA;
    reg_mprj_io_5  = 0x1555;
    reg_mprj_io_6  = 0xAAA;
    reg_mprj_io_7  = 0x1555;
    reg_mprj_io_8  = 0xAAA;
    reg_mprj_io_9  = 0x1555;
    reg_mprj_io_10 = 0xAAA;
    reg_mprj_io_11 = 0x1555;
    reg_mprj_io_12 = 0xAAA;
    reg_mprj_io_13 = 0x1555;
    reg_mprj_io_14 = 0xAAA;
    reg_mprj_io_15 = 0x1555;
    reg_mprj_io_16 = 0xAAA;
    reg_mprj_io_17 = 0x1555;
    reg_mprj_io_18 = 0xAAA;


    reg_mprj_io_37 = 0xAAA;
    reg_mprj_io_36 = 0x1555;
    reg_mprj_io_35 = 0xAAA;
    reg_mprj_io_34 = 0x1555;
    reg_mprj_io_33 = 0xAAA;
    reg_mprj_io_32 = 0x1555;
    reg_mprj_io_31 = 0xAAA;
    reg_mprj_io_30 = 0x1555;
    reg_mprj_io_29 = 0xAAA;
    reg_mprj_io_28 = 0x1555;
    reg_mprj_io_27 = 0xAAA;
    reg_mprj_io_26 = 0x1555;
    reg_mprj_io_25 = 0xAAA;
    reg_mprj_io_24 = 0x1555;
    reg_mprj_io_23 = 0xAAA;
    reg_mprj_io_22 = 0x1555;
    reg_mprj_io_21 = 0xAAA;
    reg_mprj_io_20 = 0x1555;
    reg_mprj_io_19 = 0xAAA;

    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);
    reg_debug_1 = 0x0; // delay asserted
    reg_debug_1 = 0x0; // delay asserted 
    reg_debug_1 = 0xFF; // finish configuration  
}

