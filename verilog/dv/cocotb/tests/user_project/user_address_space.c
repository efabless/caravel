
#include <defs.h>
#include <stub.c>

// --------------------------------------------------------

void main()
{
    int j;
    reg_wb_enable =1; // for enable writing to user space area
    // space from 0x30000000 to 0x30100000 according to current linker script 
    // TODO: fix when issue #107 https://github.com/efabless/caravel_mgmt_soc_litex/issues/107 is resolved

    // first 3 addresses 
    (*(volatile uint32_t*) 0x30000000 ) = 0x97cf0d2d; 
    (*(volatile uint32_t*) 0x30000004 ) = 0xbc748313; 
    (*(volatile uint32_t*) 0x30000008 ) = 0xbfda8146; 

    // last 3 addresses 
    (*(volatile uint32_t*) 0x300FFFF8 ) = 0x5f5e36b1; 
    (*(volatile uint32_t*) 0x300FFFFC ) = 0x0c1fe9d9; 
    (*(volatile uint32_t*) 0x30100000 ) = 0x6d12d2b8; 


    // random addresses inside the user space 
    (*(volatile uint32_t*) 0x30044078 ) = 0xdcd244d1; 
    (*(volatile uint32_t*) 0x30090A94 ) = 0x0da37088; 
    (*(volatile uint32_t*) 0x3005FE2C ) = 0x7b8e4345; 
    // random read 
    int temp;
    temp = (*(volatile uint32_t*) 0x300F9F44 ); 
    temp = (*(volatile uint32_t*) 0x30032E58 ); 
    temp = (*(volatile uint32_t*) 0x300602EC ); 

    // addresses outside user space - injecting error if user project ack is affected
    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;
    
    // finish with writing last address with Fs
    (*(volatile uint32_t*) 0x30100000 ) = 0xFFFFFFFF; 


}
