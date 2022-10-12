#include <defs.h>
#include <stub.c>
// --------------------------------------------------------

void main(){
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0xBB;

    while (reg_debug_1 != 0xAA);
    reg_hkspi_disable = 0;
    // reg_hkspi_pll_ena =0;
    reg_debug_1 =0xBB;
    print("adding a very very long delay because cpu produces X's when code finish and this break the simulation");
}