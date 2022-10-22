
#include <defs.h>
#include <stub.c>

void main(){
    unsigned int i, j, k;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;
    reg_hkspi_disable = 1;

    // Configure LA probes [63:32] and [127:96] as inputs to the cpu 
	// Configure LA probes [31:0] and [63:32] as outputs from the cpu
    reg_la0_oenb = reg_la0_iena = 0xFFFFFFFF;    // [31:0]
	reg_la1_oenb = reg_la1_iena = 0x00000000;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0xFFFFFFFF;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0x00000000;    // [127:96]

    reg_la0_data = 0xAAAAAAAA;
    reg_la2_data = 0xAAAAAAAA;

    reg_debug_2 = reg_la1_data_in;
    if (reg_la1_data_in != 0xAAAAAAAA)
        reg_debug_1 = 0x1E;
    else 
        reg_debug_1 = 0x1B;
    reg_debug_2 = reg_la3_data_in;
    if (reg_la3_data_in != 0xAAAAAAAA)
        reg_debug_1 = 0x2E;
    else 
        reg_debug_1 = 0x2B;    

    reg_la0_data = 0x55555555;
    reg_la2_data = 0x55555555;

    reg_debug_2 = reg_la1_data_in;
    if (reg_la1_data_in != 0x55555555)
        reg_debug_1 = 0x3E;
    else 
        reg_debug_1 = 0x3B;
 
    reg_debug_2 = reg_la3_data_in;
    if (reg_la3_data_in != 0x55555555)
        reg_debug_1 = 0x4E;
    else 
        reg_debug_1 = 0x4B;    

    // Configure LA probes [31:0] and [63:32] as inputs to the cpu 
	// Configure LA probes [63:32] and [127:96] as outputs from the cpu
    reg_la0_oenb = reg_la0_iena = 0x00000000;    // [31:0]
	reg_la1_oenb = reg_la1_iena = 0xFFFFFFFF;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0x00000000;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0xFFFFFFFF;    // [127:96]

    reg_la1_data = 0xAAAAAAAA;
    reg_la3_data = 0xAAAAAAAA;

    reg_debug_2 = reg_la0_data_in;
    if (reg_la0_data_in != 0xAAAAAAAA)
        reg_debug_1 = 0x5E;
    else 
        reg_debug_1 = 0x5B;

    reg_debug_2 = reg_la2_data_in;
    if (reg_la2_data_in != 0xAAAAAAAA)
        reg_debug_1 = 0x6E;
    else 
        reg_debug_1 = 0x6B;    

    reg_la1_data = 0x55555555;
    reg_la3_data = 0x55555555;

    reg_debug_2 = reg_la0_data_in;
    if (reg_la0_data_in != 0x55555555)
        reg_debug_1 = 0x7E;
    else 
        reg_debug_1 = 0x7B;
 
    reg_debug_2 = reg_la2_data_in;
    if (reg_la2_data_in != 0x55555555)
        reg_debug_1 = 0x8E;
    else 
        reg_debug_1 = 0x8B;    

    // Configure LA probes [31:0] and [63:32] as inputs to the cpu 
	// Configure LA probes [63:32] and [127:96] as disabled input and output
    reg_la0_oenb = reg_la0_iena = 0x00000000;    // [31:0]
	reg_la1_oenb = reg_la1_iena = 0xFFFFFFFF;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0x00000000;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0xFFFFFFFF;    // [127:96]

    reg_la1_iena = reg_la3_iena = 0x00000000; // disable input for la1 and la3

    reg_la1_data = 0xAAAAAAAA;
    reg_la3_data = 0xAAAAAAAA;

    reg_debug_2 = reg_la0_data_in;
    if (reg_la0_data == 0xAAAAAAAA)
        reg_debug_1 = 0x9E;
    else 
        reg_debug_1 = 0x9B;
 
    reg_debug_2 = reg_la2_data_in;
    if (reg_la2_data == 0xAAAAAAAA)
        reg_debug_1 = 0xaE;
    else 
        reg_debug_1 = 0xaB;    

    reg_debug_2 = 0xFF;
    
    print("adding a very very long delay because cpu produces X's when code finish and this break the simulation");
}
