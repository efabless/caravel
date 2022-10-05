#include <defs.h>
#include <stub.c>
#include "../bitbang/bitbang_functions.c"

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_29 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_28 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_27 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_26 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_25 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_24 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_23 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_22 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_21 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_20 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_19 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_18 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_17 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_16 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_13 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_12 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_11 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_10 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_9  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_8  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_7  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_6  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_5  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_4  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_3  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_2  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_1  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_0  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
    reg_mprj_io_0  = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_debug_1 = 0XAA; // configuration done 

    // while (true){
    // reg_debug_2 = reg_mprj_datal;

    // }
    reg_debug_1 = 0XB1; //  wait environment to send 0x0 to reg_mprj_datal
    while (reg_mprj_datal != 0x0);
    reg_debug_2 = reg_mprj_datal;
    reg_debug_1 = 0XB2; //  wait environment to send 0xzzzzzzzz to reg_mprj_datal
    while (reg_mprj_datal != 0xFFFFFFFF);
    reg_debug_2 = reg_mprj_datal;
    reg_debug_1 = 0XB3; //  wait environment to send 0xzzzz0000 to reg_mprj_datal
    while (reg_mprj_datal != 0xFFFF0000);
    reg_debug_2 = reg_mprj_datal;
    
    reg_debug_1 = 0XB5; //  wait environment to send 0x0 to reg_mprj_datah
    while (reg_mprj_datah != 0x0);
    reg_debug_2 = reg_mprj_datah;
    reg_debug_1 = 0XB6; //  wait environment to send 0xzz to reg_mprj_datah
    while (reg_mprj_datah != 0x3F);
    reg_debug_2 = reg_mprj_datah;
    reg_debug_1 = 0XB7; //  wait environment to send 0xz0 to reg_mprj_datah
    while (reg_mprj_datah != 0x30);
    reg_debug_2 = reg_mprj_datah;

    reg_debug_1 = 0xFF;
}
