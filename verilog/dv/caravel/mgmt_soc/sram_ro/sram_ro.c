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

#define reg_hkspi_sram_ctrl (*(volatile uint32_t *)0x26100034)
#define reg_hkspi_sram_addr (*(volatile uint32_t *)0x26100030)
#define reg_hkspi_sram_data (*(volatile uint32_t *)0x2610002c)

// --------------------------------------------------------

/*
 *	SRAM read-only Test
 *		Tests the read-only port of the dual port SRAM,
 *		which can be read back through the housekeeping
 *		module or from the SoC.
 */

void main()
{
	int i;

	/* Set data out to zero */
	reg_mprj_datal = 0;

	/* Set mprj_io[31:16] to outputs so that we can place values on	*/
	/* the output pins and check them in the testbench verilog.	*/

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

	/* Flag start of test */
	reg_mprj_datal = 0x48000000;

	/* Write to SRAM (reg_rw_block0 = 0x01000000) */
	/* BUT housekeeping RO data is only 256 words at 0x01000400 */
	/* The lower half is accessible by the management SoC 	    */
	(*(volatile uint32_t*)0x01000400) = 0x04030201; 
	(*(volatile uint32_t*)0x01000404) = 0xaa55aa55; 
	(*(volatile uint32_t*)0x01000408) = 0x55aa55aa; 
	(*(volatile uint32_t*)0x0100040c) = 0xcc33cc33; 
	(*(volatile uint32_t*)0x01000410) = 0xff00ff00; 

	/* Read data from housekeeping back-door */
	reg_hkspi_sram_ctrl = 0;	/* assert select */

	/* Note that addressing in this mode is word-wise;	*/
	/* address 0 in housekeeping = SRAM word address 0x100 	*/
	/* = SRAM byte address 0x400 = memory-mapped address	*/
	/* 0x01000400, while address 1 in housekeeping = SRAM	*/
	/* word address 0x101 = SRAM byte address 0x404 =	*/
	/* memory-mapped address 0x01000404, and so forth.	*/
	
	reg_hkspi_sram_addr = 0;	/* first word address */

	/* Apply value to output */
	reg_mprj_datal = reg_hkspi_sram_data;

	reg_hkspi_sram_addr = 1;	/* next word address */

	/* Apply value to output */
	reg_mprj_datal = reg_hkspi_sram_data;

	reg_hkspi_sram_addr = 2;	/* next word address */

	/* Apply value to output */
	reg_mprj_datal = reg_hkspi_sram_data;

	reg_hkspi_sram_addr = 3;	/* next word address */

	/* Apply value to output */
	reg_mprj_datal = reg_hkspi_sram_data;

	reg_hkspi_sram_addr = 4;	/* next word address */

	/* Apply value to output */
	reg_mprj_datal = reg_hkspi_sram_data;

	/* Flag end of first test */
	reg_mprj_datal = 0x48010000;

	/* Now do the same thing using the management SoC access only, */
	/* which requires CSB set high */

	reg_hkspi_sram_ctrl = 1;	/* de-assert select */

	(*(volatile uint32_t*)0x01000000) = 0xff00ff00; 
	(*(volatile uint32_t*)0x01000004) = 0xcc33cc33; 
	(*(volatile uint32_t*)0x01000008) = 0x55aa55aa; 
	(*(volatile uint32_t*)0x0100000c) = 0xaa55aa55; 
	(*(volatile uint32_t*)0x01000010) = 0x04030201; 

	/* Read back from read-only port (note different address block) */

	reg_mprj_datal = (*(volatile uint32_t*)0x02000000);
	reg_mprj_datal = (*(volatile uint32_t*)0x02000004);
	reg_mprj_datal = (*(volatile uint32_t*)0x02000008);
	reg_mprj_datal = (*(volatile uint32_t*)0x0200000c);
	reg_mprj_datal = (*(volatile uint32_t*)0x02000010);

	/* Flag end of second test */
	reg_mprj_datal = 0x48020000;
}

