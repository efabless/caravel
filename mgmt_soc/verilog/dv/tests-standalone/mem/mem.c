/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

#include <defs.h>
#include <stdint.h>

// --------------------------------------------------------

/*
	Memory Test
	It uses GPIO to flag the success or failure of the test
*/

#define COUNT 5

// DFFRAM
//unsigned int ints[10];
//unsigned short shorts[10];
//unsigned char bytes[10];
unsigned long *ints    = (unsigned long *)  0x00000100;
unsigned short *shorts = (unsigned short *) 0x00000200;
unsigned char *bytes   = (unsigned char *)  0x00000300;
unsigned long *ints_rd = (unsigned long *)  0x00000300;

void main()
{
    int i, v;

    // DFFRAM_1
    unsigned long *dff1_ints    = (unsigned long *)  0x00000400;
    unsigned short *dff1_shorts = (unsigned short *) 0x00000480;
    unsigned char *dff1_bytes   = (unsigned char *)  0x00000500;
    unsigned long *dff1_ints_rd = (unsigned long *)  0x00000500;

    // start test
    reg_la0_oenb = 0;
    reg_la0_data = 0xA0400000;

    // Test Word R/W
    for (i=0; i<COUNT; i++) {
	     *(dff1_ints+i) = i*5000 + 10000;
	     *(ints+i) = i*5000 + 10000;
     }

    for (i=0; i<COUNT; i++) {
        v = i*5000+10000;
        if ( v != *(ints+i) || v != *(dff1_ints+i) )
            reg_la0_data = 0xAB400000;
    }

    reg_la0_data = 0xAB410000;

    // Test Half Word R/W
    reg_la0_data = 0xA0200000;
    for (i=0; i<COUNT; i++) {
	    *(dff1_shorts+i) = i*500 + 100;
	    *(shorts+i) = i*500 + 100;
    }

    for(i=0; i<COUNT; i++) {
        v = i*500+100;
        if(v != *(shorts+i) || v != *(dff1_shorts+i))
            reg_la0_data = 0xAB200000;
    }

    reg_la0_data = 0xAB210000;

    // Test byte R/W
    reg_la0_data = 0xA0100000;
    for(i=0; i<COUNT; i++) {
        *(dff1_bytes+i) = i*5 + 10;
        *(bytes+i) = i*5 + 10;
    }

    for(i=0; i<COUNT; i++) {
        v = i*5+10;
        if(v != *(bytes+i) && v != *(dff1_bytes+i))
            reg_la0_data = 0xAB100000;
    }

    reg_la0_data = 0xAB110000;

    // --------------------------------

    // Test byte W and word R
    reg_la0_data = 0xA0500000;
    for(i=0; i<COUNT*4; i++) {
        *(dff1_bytes+i) = 1 << i % 4;
        *(bytes+i) = 1 << i % 4;
    }

    for(i=0; i<COUNT; i++) {
        v = 0x08040201;
        if(v != *(ints_rd+i) && v != *(dff1_ints_rd+i)) {
            reg_la0_data = 0xAB500000;
        }
    }

    reg_la0_data = 0xAB510000;

}