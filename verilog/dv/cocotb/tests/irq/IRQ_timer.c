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

#include <csr.h>
#include <soc.h>
#include <irq_vex.h>
#include <uart.h>

#include <defs.h>


extern uint16_t flag;

void main(){
    uint16_t data;
    int i;
    

    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    irq_setmask(0);
	irq_setie(1);


	irq_setmask(irq_getmask() | (1 << TIMER0_INTERRUPT));
    reg_debug_2 = 0xAA; //wait for timer to send irq

    flag = 0;
    /* Configure timer for a single-shot countdown */
	reg_timer0_config = 0;
	reg_timer0_data = 30;
    reg_timer0_irq_en = 1;
    reg_timer0_config = 1;

    // Loop, waiting for the interrupt to change reg_mprj_datah
    bool is_pass = false;
    int timeout = 40; 

    for (int i = 0; i < timeout; i++){
        if (flag == 1){
            reg_debug_1 = 0x1B; //test pass irq sent at timer0
            is_pass = true;
            break;
        }
    }
    if (!is_pass){
        reg_debug_1 = 0x1E; // timeout
    }
    flag = 0;
     // test interrupt doesn't happened when timer isnt used
    reg_debug_2 = 0xBB;
    reg_timer0_config = 0; // disable counter
    flag = 0;
    // Loop, waiting for the interrupt to change reg_mprj_datah
    is_pass = false;

    for (int i = 0; i < timeout; i++){
        if (flag == 1){
            reg_debug_1 = 0x2E; //test fail interrupt isn't suppose to happened
            is_pass = true;
            break;
        }
    }
    if (!is_pass){
        reg_debug_1 = 0x2B; // test pass
    }

    // test finish 
    reg_debug_2 = 0xFF;

}

