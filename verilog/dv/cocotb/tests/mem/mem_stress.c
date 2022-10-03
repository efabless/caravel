#include <defs.h>

/*
   @ start of test 
      send packet with size = 1
   @ pass bytes  
      send packet with size = 2
   @ pass int  
      send packet with size = 3
   @ pass short  
      send packet with size = 4
   @ error reading 
      send packet with size = 9
   @ test finish 
      send packet with size = 7
      send packet with size = 7
      send packet with size = 7
   
*/
#define BYTE_SIZE 800
#define SHORT_SIZE BYTE_SIZE/2
#define INT_SIZE BYTE_SIZE/4
void main()
{
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;
    unsigned char dff_bytes[BYTE_SIZE]; 
    unsigned short *dff_shorts=(unsigned short *) dff_bytes;
    unsigned int *dff_ints=(unsigned int *) dff_bytes;
    unsigned char magic = 0x79;
    unsigned int magic_int = 0x79797979;
    unsigned short magic_short = 0x7979;
    unsigned char magic1;
    unsigned int magic1_int;
    unsigned short magic1_short;
    int i;
    magic1 = magic;
    for ( i=0; i<BYTE_SIZE; i++){
        dff_bytes[i] = (magic1*3+5)|magic;
        magic1 += 11;
    }
    magic1 = magic;
    bool is_fail = false;
    for ( i=0; i<BYTE_SIZE; i++){
        unsigned char t = (magic1*3+5)|magic;
        if (t != dff_bytes[i]){
            reg_debug_1 = 0x1E; // fail reading bytes expected value
            is_fail = true;
            break;
        }
        magic1 += 11;
    }  
    if (!is_fail)
        reg_debug_1 = 0x1B; // pass reading bytes expected value

    is_fail = false;
    // int
    magic1_int = magic_int;
    for ( i=0; i<INT_SIZE; i++){
        dff_ints[i] = (magic1_int*3+5)|magic_int;
        magic1_int += 11;
    }
    magic1_int = magic_int;

    for ( i=0; i<INT_SIZE; i++){
        unsigned int t = (magic1_int*3+5)|magic_int;
        if (t != dff_ints[i]){
            reg_debug_1 = 0x2E; // fail reading ints expected value
            is_fail = true;
            break;
        }
        magic1_int += 11;
    }   
    if (!is_fail)
        reg_debug_1 = 0x2B; // pass reading ints expected value

    is_fail = false;

    // short
    magic1_short = magic_short;
    for ( i=0; i<SHORT_SIZE; i++){
        dff_shorts[i] = (magic1_short*3+5)|magic_short;
        magic1_short += 11;
    }
    magic1_short = magic_short;

    for ( i=0; i<SHORT_SIZE; i++){
        unsigned short t = (magic1_short*3+5)|magic_short;
        if (t != dff_shorts[i]){
            reg_debug_1 = 0x3E; // fail reading shorts expected value
            is_fail = true;
            break;
        }
        magic1_short += 11;
    }
    if (!is_fail)
        reg_debug_1 = 0x3B; // pass reading ints expected value

    // test finish 
    reg_debug_2 = 0xFF;
}