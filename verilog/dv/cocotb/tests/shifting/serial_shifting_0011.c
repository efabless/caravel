#include <defs.h>
#include <stub.c>

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_mprj_io_0  = 0x1999;
    reg_mprj_io_1  = 0x1333;
    reg_mprj_io_2  = 0x666;
    reg_mprj_io_3  = 0xCCC;
    reg_mprj_io_4  = 0x1999;
    reg_mprj_io_5  = 0x1333;
    reg_mprj_io_6  = 0x666;
    reg_mprj_io_7  = 0xCCC;
    reg_mprj_io_8  = 0x1999;
    reg_mprj_io_9  = 0x1333;
    reg_mprj_io_10 = 0x666;
    reg_mprj_io_11 = 0xCCC;
    reg_mprj_io_12 = 0x1999;
    reg_mprj_io_13 = 0x1333;
    reg_mprj_io_14 = 0x666;
    reg_mprj_io_15 = 0xCCC;
    reg_mprj_io_16 = 0x1999;
    reg_mprj_io_17 = 0x1333;
    reg_mprj_io_18 = 0x666;


    reg_mprj_io_37 = 0x1999;
    reg_mprj_io_36 = 0x1333;
    reg_mprj_io_35 = 0x666;
    reg_mprj_io_34 = 0xCCC;
    reg_mprj_io_33 = 0x1999;
    reg_mprj_io_32 = 0x1333;
    reg_mprj_io_31 = 0x666;
    reg_mprj_io_30 = 0xCCC;
    reg_mprj_io_29 = 0x1999;
    reg_mprj_io_28 = 0x1333;
    reg_mprj_io_27 = 0x666;
    reg_mprj_io_26 = 0xCCC;
    reg_mprj_io_25 = 0x1999;
    reg_mprj_io_24 = 0x1333;
    reg_mprj_io_23 = 0x666;
    reg_mprj_io_22 = 0xCCC;
    reg_mprj_io_21 = 0x1999;
    reg_mprj_io_20 = 0x1333;
    reg_mprj_io_19 = 0x666;

    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);
    reg_debug_1 = 0x0; // delay asserted
    reg_debug_1 = 0x0; // delay asserted 
    reg_debug_1 = 0x0; // delay asserted 
    reg_debug_1 = 0xFF; // finish configuration  
}

