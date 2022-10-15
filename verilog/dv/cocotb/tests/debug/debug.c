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
#include <stub.c>

// --------------------------------------------------------

void main()
{
    int j;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;


    reg_mprj_io_6 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_5 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;

    // Set clock to 64 kbaud and enable the UART.  It is important to do this
    // before applying the configuration, or else the Tx line initializes as
    // zero, which indicates the start of a byte to the receiver.


    // Now, apply the configuration
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);
    // reg_uart_enable = 1;
    // start of the test
    reg_debug_1 = 0xAA;
    // very long wait
    for (j = 0; j < 160; j++);
    for (j = 0; j < 160; j++);
    for (j = 0; j < 160; j++);


    // Set clock to 64 kbaud and enable the UART.  It is important to do this
    // before applying the configuration, or else the Tx line initializes as
    // zero, which indicates the start of a byte to the receiver.

//     // these instruction work without using interrupt, they seem to be timing dependent
//    reg_uart_enable = 1;
//    reg_debug_irq_en = 1;
//    reg_reset = 1;


//     irq_setmask(0);
// 	irq_setie(1);
// 	irq_setmask(irq_getmask() | (1 << USER_IRQ_3_INTERRUPT));

//     for (j = 0; j < 500; j++);

// //    reg_uart_data = 0xab;

//     // Allow transmission to complete before signalling that the program
//     // has ended.
//     for (j = 0; j < 160; j++);
}
