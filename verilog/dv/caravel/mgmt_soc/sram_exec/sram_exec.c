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
// Test copying code into SRAM and running it from there.
// -------------------------------------------------------------------------

void test_function()
{
    int i;
    reg_mprj_datah = 0xa;	// Signal middle of test
    for (i = 0; i < 10; i++) {
	reg_mprj_datal = i << 16;
    }
    return;
}

void main()
{
    uint16_t func[&main - &test_function];
    uint16_t *src_ptr;
    uint16_t *dst_ptr;

    // Copy test routine from flash into SRAM
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

    src_ptr = &test_function;
    dst_ptr = func;

    while (src_ptr != &main)
	*(dst_ptr++) = *(src_ptr++);

    // Call the routine in SRAM
    
    ((void(*)())func)();

    reg_mprj_datal = 0x40000;
    reg_mprj_datah = 0xc;	// Signal end of test
}

