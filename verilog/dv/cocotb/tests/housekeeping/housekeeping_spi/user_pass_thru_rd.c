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



void main()
{
    // This program is just to keep the processor busy while the
    // housekeeping SPI is being accessed. to show that the
    // processor is halted while the SPI is accessing the
    // flash SPI in pass-through mode.

    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    // Management needs to apply output on these pads to access the user area SPI flash
    reg_mprj_io_11 = GPIO_MODE_MGMT_STD_INPUT_NOPULL; // SDI
    reg_mprj_io_10 = GPIO_MODE_MGMT_STD_OUTPUT; // SDO
    reg_mprj_io_9 = GPIO_MODE_MGMT_STD_OUTPUT; // clk
    reg_mprj_io_8 = GPIO_MODE_MGMT_STD_OUTPUT; // csb


    // Apply configuration
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Start test
    reg_debug_1 = 0xAA;
    reg_debug_1 = 0xBB;
    reg_uart_enable = 1;

    // Test in progress
    reg_mprj_datal = 0xa5000000;

    // Test message
//    print("Test message\n");
    print("ABC\n");

    for (int i=0; i<1200; i++);

    // End test
    reg_debug_1 = 0xFF;
}

