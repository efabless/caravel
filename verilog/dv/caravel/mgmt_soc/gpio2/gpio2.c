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

//---------------------------------------------------------
// This testbench checks that the internal register values
// {reg_mprj_datah, reg_mprj_datal} line up with the mprj_io
// pins, by applying bits in sequence on reg_mprj_data* in
// the C code and reading them in order from mprj_io in the
// testbench verilog.
//---------------------------------------------------------

void main()
{
    reg_hkspi_disable = 1;		// Shut off the housekeeping SPI,
					// so we can use all the pins as GPIO.

    reg_mprj_datal = 0xffffffff;
    reg_mprj_datah = 0xffffffff;

    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_OUTPUT;

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

    // Run through the GPIO bits from low to high
    reg_mprj_datah = 0x00000000;
    reg_mprj_datal = 0x00000000;
    reg_mprj_datal = 0x00000001;
    reg_mprj_datal = 0x00000002;
    reg_mprj_datal = 0x00000004;
    reg_mprj_datal = 0x00000008;
    reg_mprj_datal = 0x00000010;
    reg_mprj_datal = 0x00000020;
    reg_mprj_datal = 0x00000040;
    reg_mprj_datal = 0x00000080;
    reg_mprj_datal = 0x00000100;
    reg_mprj_datal = 0x00000200;
    reg_mprj_datal = 0x00000400;
    reg_mprj_datal = 0x00000800;
    reg_mprj_datal = 0x00001000;
    reg_mprj_datal = 0x00002000;
    reg_mprj_datal = 0x00004000;
    reg_mprj_datal = 0x00008000;
    reg_mprj_datal = 0x00010000;
    reg_mprj_datal = 0x00020000;
    reg_mprj_datal = 0x00040000;
    reg_mprj_datal = 0x00080000;
    reg_mprj_datal = 0x00100000;
    reg_mprj_datal = 0x00200000;
    reg_mprj_datal = 0x00400000;
    reg_mprj_datal = 0x00800000;
    reg_mprj_datal = 0x01000000;
    reg_mprj_datal = 0x02000000;
    reg_mprj_datal = 0x04000000;
    reg_mprj_datal = 0x08000000;
    reg_mprj_datal = 0x10000000;
    reg_mprj_datal = 0x20000000;
    reg_mprj_datal = 0x40000000;
    reg_mprj_datal = 0x80000000;
    reg_mprj_datal = 0x00000000;

    reg_mprj_datah = 0x00000001;
    reg_mprj_datah = 0x00000002;
    reg_mprj_datah = 0x00000004;
    reg_mprj_datah = 0x00000008;
    reg_mprj_datah = 0x00000010;
    reg_mprj_datah = 0x00000020;

}

