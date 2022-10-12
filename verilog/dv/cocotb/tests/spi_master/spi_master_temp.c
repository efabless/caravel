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
#include <csr.h>

// --------------------------------------------------------

/*
 *	SPI master Test
 *	- Enables SPI master
 *	- Uses SPI master to talk to external SPI module
 */

 void spi_write(char c)
{
    reg_spimaster_wdata = (unsigned long) c;
//    reg_spimaster_wdata = c;
//    spi_master_control_length_write(8);
//    spi_master_control_start_write(1);
//    reg_spimaster_control = 0x0800;
    reg_spimaster_control = 0x0801;
}
 char spi_read()
{
//    reg_spimaster_wdata = c;
//    spi_master_control_length_write(8);
//    spi_master_control_start_write(1);
//    reg_spimaster_control = 0x0800;
//    spi_write(0x00);
//    reg_spimaster_rdata = 0x00;
//    reg_spimaster_control = 0x0801;
    spi_write(0x00);
    while (reg_spimaster_status != 1);
    return reg_spimaster_rdata;
}

void main()
{
    int i;
    uint32_t value;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    // For SPI operation, GPIO 1 should be an input, and GPIOs 2 to 4
    // should be outputs.

    reg_mprj_io_34  = GPIO_MODE_MGMT_STD_INPUT_NOPULL;	// SDI
    reg_mprj_io_35  = GPIO_MODE_MGMT_STD_BIDIRECTIONAL;	// SDO
    reg_mprj_io_33  = GPIO_MODE_MGMT_STD_OUTPUT;	// CSB
    reg_mprj_io_32  = GPIO_MODE_MGMT_STD_OUTPUT;	// SCK

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_debug_2 =0xAA;

    reg_spi_enable = 1;


    // For SPI operation, GPIO 1 should be an input, and GPIOs 2 to 4
    // should be outputs.

    // Start test

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
    // bit 15:		(unused)


    reg_spimaster_cs = 0x10001;  // sel=0, manual CS

    spi_write(0x08);        // Write 0x03 (read mode)
    spi_write(0x05);        // Write 0x00 (start address high byte)
    value = spi_read(); // 0x93
    if (value == 0xD)
        reg_debug_1 = 0xBB; // get correct value
    else {
        reg_debug_2 = value;
        reg_debug_1 = 0xEE; // get wrong value
    }

    reg_spimaster_cs = 0x0000;  // release CS
    reg_spimaster_cs = 0x10001;  // sel=0, manual CS

    print("adding a very very long delay because cpu produces X's when code finish and this break the simulation");
}

