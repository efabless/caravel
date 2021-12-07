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

// --------------------------------------------------------

/*
 *	System control test
 *      - Sets GPIO to monitor the core and user clocks
 *
 *	This test is basically just the first part of the
 *	PLL test, with the PLL bypassed.  Unlike the PLL
 *	test, it can be run on a gate-level netlist.
 *
 */
void main()
{
    int i;

    reg_mprj_datal = 0;

    // Configure upper 16 bits of user GPIO for generating testbench
    // checkpoints.

    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_29 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_28 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_27 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_26 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_25 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_24 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_23 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_22 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_21 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_20 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;

    /* Monitor pins must be set to output */
    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Start test

    /*
     *-------------------------------------------------------------
     * Register 2620_0004	reg_clk_out_dest
     * SPI address 0x1b = Output redirect
     * bit 0 = trap to mprj_io[13]
     * bit 1 = clk  to mprj_io[14]
     * bit 2 = clk2 to mprj_io[15]
     *-------------------------------------------------------------
     */

    // Monitor the core clock and user clock on mprj_io[14] and mprj_io[15]
    // reg_clk_out_dest = 0x6 to turn on, 0x0 to turn off

    // Write checkpoint for making sure nothing is counted when monitoring is off
    reg_mprj_datal = 0xA0400000;
    reg_clk_out_dest = 0x0;
    reg_clk_out_dest = 0x0;
    reg_mprj_datal = 0xA0410000;

    // Write checkpoint for core clock counting (PLL bypassed)
    reg_mprj_datal = 0xA0420000;
    reg_clk_out_dest = 0x2;
    reg_clk_out_dest = 0x0;
    reg_mprj_datal = 0xA0430000;

    // Write checkpoint for user clock counting (PLL bypassed)
    reg_mprj_datal = 0xA0440000;
    reg_clk_out_dest = 0x4;
    reg_clk_out_dest = 0x0;
    reg_mprj_datal = 0xA0450000;

    // End test
    reg_mprj_datal = 0xA0900000;
}

