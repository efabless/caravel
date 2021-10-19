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
 *	System Control Test
 *	- Enables SPI master
 *	- Uses SPI master to internally access the housekeeping SPI
 *      - Reads default value of SPI-Controlled registers
 *      - Flags failure/success using mprj_io
 */
void main()
{
    int i;
    uint32_t value;

    // Force housekeeping SPI into a disabled state so that the CSB
    // pin can be used as an output without the system failing

    reg_hkspi_disable = 1;

    reg_mprj_datal = 0;

    // Configure upper 6 bits of user GPIO for generating testbench
    // checkpoints.

    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_OUTPUT;

    // Configure all lower 32 bits for writing the SPI value read on GPIO
    // NOTE:  Converting reg_mprj_io_3 (CSB) to output will disable the
    // SPI.  But that should not disable the back-door access to the SPI
    // register values!

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

    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_13 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_12 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_11 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_10 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_9  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_8  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_7  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_6  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_5  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_4  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_3  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_2  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_1  = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_0  = GPIO_MODE_MGMT_STD_OUTPUT;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Start test
    reg_mprj_datah = 0x04;

    // Read manufacturer and product ID
    value = reg_hkspi_chip_id;
    reg_mprj_datal = value;	// Mfgr + product ID
    reg_mprj_datah = 0x05;

    // Read user ID
    value = reg_hkspi_user_id;
    reg_mprj_datal = value;	// User ID
    reg_mprj_datah = 0x06;

    // Read PLL enables
    value = reg_hkspi_pll_ena;
    reg_mprj_datal = value;	// DLL enables
    reg_mprj_datah = 0x07;

    // Read PLL bypass state
    value = reg_hkspi_pll_bypass;
    reg_mprj_datal = value;	// DLL bypass state
    reg_mprj_datah = 0x08;

    // Read PLL trim
    value = reg_hkspi_pll_trim;
    reg_mprj_datal = value;	// DLL trim
    reg_mprj_datah = 0x09;

    // Read PLL source
    value = reg_hkspi_pll_source;
    reg_mprj_datal = value;	// DLL source
    reg_mprj_datah = 0x0a;

    // Read PLL divider
    value = reg_hkspi_pll_divider;
    reg_mprj_datal = value;	// DLL divider
    reg_mprj_datah = 0x0b;

    // Read a GPIO configuration word
    value = reg_mprj_io_6;
    reg_mprj_datal = value;	// DLL divider
    reg_mprj_datah = 0x0c;

    // End test
    reg_mprj_datah = 0x0d;
}

