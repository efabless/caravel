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

/*
Testing timer interrupts 
Enable interrupt for timer0 and configure it as countdown 1 shot wait for interrupt
*/


void main(){
    uint32_t value;
    uint32_t old_value;

    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    /* Configure timer for a single-shot countdown */
	reg_timer0_config = 0; // disable
	reg_timer0_data = 0xF3000;
    reg_timer0_config = 1; // enable

    // Loop, waiting for the interrupt to change reg_mprj_datah
    // test path if counter value stop updated after reach 0 and also the value is always decrementing
    reg_timer0_update = 1; // update reg_timer0_value with new counter value
    old_value = reg_timer0_value;
    // value us decrementing until it reachs zero
    while (1) {
        reg_timer0_update = 1; // update reg_timer0_value with new counter value
        value = reg_timer0_value;
        if (value < old_value && value != 0){
            reg_debug_1 = 0x1B; // value decrease
        }
        else if (value == 0){
            reg_debug_1 = 0x2B; // value reach 0
            break;
        }else{
            reg_debug_1 = 0x1F; // value updated incorrectly
        }
	    old_value = value;
    }
    // check 10 times that value don't change from 0
	for (int i = 0; i < 10; i++);
        reg_timer0_update = 1; // update reg_timer0_value with new counter value

    if (reg_timer0_value == 0){
        reg_debug_1 = 0x3B; //timer updated correctly
    }else{
        reg_debug_1 = 0x2F; //timer updated incorrectly
    }
    reg_debug_2 = 0xFF; // finish test
}

