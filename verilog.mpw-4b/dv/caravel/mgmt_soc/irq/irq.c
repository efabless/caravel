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

#include "../../defs.h"

// -------------------------------------------------------------------------
// Test IRQ callback
// -------------------------------------------------------------------------

uint16_t flag;

void irq_callback()
{
    /* If this routine is called, then the test passes the 1st stage */
    reg_mprj_datah = 0xa;	// Signal end of test 1st stage 
    reg_mprj_datal = 0x20000;
    flag = 1;
    return;
}

void main()
{
    uint16_t data;
    int i;

    // Configure GPIO upper bits to assert the test code
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_OUTPUT;

    reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;

    /* Apply the GPIO configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_mprj_datah = 0x5;	// Signal start of test
    reg_mprj_datal = 0;
    flag = 0;

    // Loop, waiting for the interrupt to change reg_mprj_datah

    while (flag == 0) {
        reg_mprj_datal = 0x10000;
    }
    reg_mprj_datal = 0x40000;
    reg_mprj_datah = 0xc;	// Signal end of test
}

