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
 *	PLL Test (self-switching)
 *	- Enables SPI master
 *	- Uses SPI master to internally access the housekeeping SPI
 *      - Switches PLL bypass
 *	- Changes PLL divider
 *
 * 	Tesbench mostly copied from sysctrl
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

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    // Start test
    reg_mprj_datal = 0xA0400000;

    // Enable SPI master
    // SPI master configuration bits:
    // bits 7-0:	Clock prescaler value (default 2)
    // bit  8:		MSB/LSB first (0 = MSB first, 1 = LSB first)
    // bit  9:		CSB sense (0 = inverted, 1 = noninverted)
    // bit 10:		SCK sense (0 = noninverted, 1 = inverted)
    // bit 11:		mode (0 = read/write opposite edges, 1 = same edges)
    // bit 12:		stream (1 = CSB ends transmission)
    // bit 13:		enable (1 = enabled)
    // bit 14:		IRQ enable (1 = enabled)
    // bit 15:		Connect to housekeeping SPI (1 = connected)

    reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
					// connect to housekeeping SPI

    // Apply stream read (0x40 + 0x03) and read back one byte 

    reg_spimaster_config = 0xb002;	// Apply stream mode
    reg_spimaster_data = 0x80;		// Write 0x80 (write mode)
    reg_spimaster_data = 0x08;		// Write 0x18 (start address)
    reg_spimaster_data = 0x01;		// Write 0x01 to PLL enable, no DCO mode
    reg_spimaster_config = 0xa102;	// Release CSB (ends stream mode)

    reg_spimaster_config = 0xb002;	// Apply stream mode
    reg_spimaster_data = 0x80;		// Write 0x80 (write mode)
    reg_spimaster_data = 0x11;		// Write 0x11 (start address)
    reg_spimaster_data = 0x03;		// Write 0x03 to PLL output divider
    reg_spimaster_config = 0xa102;	// Release CSB (ends stream mode)

    reg_spimaster_config = 0xb002;	// Apply stream mode
    reg_spimaster_data = 0x80;		// Write 0x80 (write mode)
    reg_spimaster_data = 0x09;		// Write 0x09 (start address)
    reg_spimaster_data = 0x00;		// Write 0x00 to clock from PLL (no bypass)
    reg_spimaster_config = 0xa102;	// Release CSB (ends stream mode)

    // Write checkpoint
    reg_mprj_datal = 0xA0410000;

    reg_spimaster_config = 0xb002;	// Apply stream mode
    reg_spimaster_data = 0x80;		// Write 0x80 (write mode)
    reg_spimaster_data = 0x12;		// Write 0x12 (start address)
    reg_spimaster_data = 0x03;		// Write 0x03 to feedback divider (was 0x04)
    reg_spimaster_config = 0xa102;	// Release CSB (ends stream mode)

    // Write checkpoint
    reg_mprj_datal = 0xA0420000;

    reg_spimaster_config = 0xb002;	// Apply stream mode
    reg_spimaster_data = 0x80;		// Write 0x80 (write mode)
    reg_spimaster_data = 0x11;		// Write 0x11 (start address)
    reg_spimaster_data = 0x04;		// Write 0x04 to PLL output divider
    reg_spimaster_config = 0xa102;	// Release CSB (ends stream mode)

    reg_spimaster_config = 0x2102;	// Release housekeeping SPI

    // End test
    reg_mprj_datal = 0xA0900000;
}

