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

/*
 *	PLL Test (self-switching)
 *      - Switches PLL bypass in housekeeping
 *	- Changes PLL divider in housekeeping
 *
 */
void main()
{
    int i;

    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    /* Monitor pins must be set to output */
    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;
    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Start test

    /*
     *-------------------------------------------------------------
     * Register 2610_000c	reg_hkspi_pll_ena
     * SPI address 0x08 = PLL enables
     * bit 0 = PLL enable, bit 1 = DCO enable
     *
     * Register 2610_0010	reg_hkspi_pll_bypass
     * SPI address 0x09 = PLL bypass
     * bit 0 = PLL bypass
     *
     * Register 2610_0020	reg_hkspi_pll_source
     * SPI address 0x11 = PLL source
     * bits 0-2 = phase 0 divider, bits 3-5 = phase 90 divider
     *
     * Register 2610_0024	reg_hkspi_pll_divider
     * SPI address 0x12 = PLL divider
     * bits 0-4 = feedback divider
     *
     * Register 2620_0004	reg_clk_out_dest
     * SPI address 0x1b = Output redirect
     * bit 0 = trap to mprj_io[13]
     * bit 1 = clk  to mprj_io[14]
     * bit 2 = clk2 to mprj_io[15]
     *-------------------------------------------------------------
     */

    // Monitor the core clock and user clock on mprj_io[14] and mprj_io[15]
    // reg_clk_out_dest = 0x6 to turn on, 0x0 to turn off

    // Write checkpoint for clock counting (PLL bypassed)
    reg_debug_1 = 0xA1;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x0;
    reg_debug_1 = 0xA2;

    // Set PLL enable, no DCO mode
    reg_hkspi_pll_ena = 0x1; 

    // Set PLL output divider to 0x03
    reg_hkspi_pll_source = 0x3;

    // Write checkpoint for clock counting (PLL bypassed)
    reg_debug_1 = 0xA3;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x0;
    reg_debug_1 = 0xA4;

    // Disable PLL bypass
    reg_hkspi_pll_bypass = 0x0;

    // Write checkpoint for clock counting
    reg_debug_1 = 0xA5;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x0;
    reg_debug_1 = 0xA6;

    // Write 0x03 to feedback divider (was 0x04)
    reg_hkspi_pll_divider = 0x3;

    // Write checkpoint
    reg_debug_1 = 0xA7;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x0;
    reg_debug_1 = 0xA8;

    // Write 0x04 to PLL output divider
    reg_hkspi_pll_source = 0x4;

    // Write checkpoint
    reg_debug_1 = 0xA9;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x6;
    reg_clk_out_dest = 0x0;
    reg_debug_1 = 0xAa;

    // End test
    reg_mprj_datal = 0xA0900000;
}

