#include <defs.h>

#define BYTE_SIZE 800
#define SHORT_SIZE BYTE_SIZE/2
#define INT_SIZE BYTE_SIZE/4
void main()
{
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    unsigned int *dff_start_address =  (unsigned int *) 0x00000000;
    unsigned int dff_size =  0x400/4;

    for (unsigned int i = 0; i < dff_size; i++){
      unsigned int data = (i + 7)*13;
      *(dff_start_address+i) = data; 
    }
    bool is_fail = false;
    for (unsigned int i = 0; i < dff_size; i++){
        unsigned int data = (i + 7)*13;
        if (data != *(dff_start_address+i)){
            reg_debug_2 = i;
            reg_debug_1 = 0x1E; 
            is_fail = true;
            break;
        }
    }

    if (!is_fail)
        reg_debug_1 = 0x1B;


    // test finish 
    reg_debug_1 = 0xFF;
}