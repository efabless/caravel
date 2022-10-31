#include <defs.h>
#include <stub.c>

// Empty C code

void main()
{
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_1  = 0x1;
    reg_debug_1  = 0x2;
    reg_debug_1  = 0x3;
    reg_debug_1  = 0x4;
    reg_debug_1  = 0x5;
    while(reg_debug_2 == 0x0);
    reg_hkspi_reset = 1;
   
}
