#include <defs.h>
#include <stub.c>
#include "../bitbang/bitbang_functions.c"

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;
    reg_hkspi_disable = 1;
    reg_mprj_io_37 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_36 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_35 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_34 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_33 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_32 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_31 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_30 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_29 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_28 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_27 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_26 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_25 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_24 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_23 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_22 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_21 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_20 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_19 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_18 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_17 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_16 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_15 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_14 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_13 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_12 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_11 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_10 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_9  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_8  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_7  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_6  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_5  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_4  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_3  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_2  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_1  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_0  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
    reg_mprj_io_0  = GPIO_MODE_USER_STD_INPUT_PULLDOWN;

    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_debug_1 = 0XAA; // configuration done 
    print("adding a very very long delay because cpu produces X's when code finish and this break the simulation");

    while (true);
}
