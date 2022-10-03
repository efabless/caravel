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

/*
Testing timer interrupts 
Enable interrupt for IRQ external pin mprj_io[7] -> should be drived to 1 by the environment
**NOTE** housekeeping SPI should used to update register irq_1_inputsrc to 1 see verilog code

    @wait for environment to make mprj[7] high
        send packet size = 1

    @received interrupt correctly  test pass
        send packet size = 5

    @ timeout                       test fail
        send packet size = 9

    @ end test 
        send packet size = 3
        send packet size = 3
        send packet size = 3

*/

extern uint16_t flag;

void main(){
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    // setting bit 7 as input 
    reg_mprj_io_7 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;

    // automatic bitbang approach
    if(1){
        reg_mprj_xfer = 1;
        while (reg_mprj_xfer == 1);
    }
    irq_setmask(0);
	irq_setie(1);
	irq_setmask(irq_getmask() | (1 << USER_IRQ_4_INTERRUPT));
    reg_user4_irq_en =1;

    // test interrrupt happen when mprj[7] is asserted
    reg_debug_2 = 0xAA; //wait for environment to make mprj[7] high 
    flag = 0;
    // Loop, waiting for the interrupt to change reg_mprj_datah
    bool is_pass = false;
    int timeout = 40; 

    for (int i = 0; i < timeout; i++){
        if (flag == 1){
            reg_debug_1 = 0x1B; //test pass irq sent at mprj 7 
            is_pass = true;
            break;
        }
    }
    if (!is_pass){
        reg_debug_1 = 0x1E; // timeout
    }

    // test interrupt doesn't happened when mprj[7] is deasserted
    reg_debug_2 = 0xBB;
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
