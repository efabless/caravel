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
 *	Timer2 Test --- This runs the same testbench as the
 *	other timer, on the 2nd counter/timer module instance.
 */

void main()
{
	int i;
	uint32_t value;

	/* Initialize output data vector to zero */
	reg_mprj_datah = 0x00000000;
	reg_mprj_datal = 0x00000000;

	/* Apply all 38 bits to management standard output.	*/

	/* The lower 32 will be used to output the count value	*/
	/* from the timer.  The top 5 bits will be used	to mark	*/
	/* specific checkpoints for the testbench simulation.	*/

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
	// reg_mprj_io_3  = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_2  = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_1  = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_0  = GPIO_MODE_MGMT_STD_OUTPUT;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Present start marker (see testbench verilog) */
	reg_mprj_datah = 0x0a;

	/* Configure timer for a single-shot countdown */
	reg_timer1_value = 0xdcba9876;

	/* Timer configuration bits:				*/
	/* 0 = timer enable (1 = enabled, 0 = disabled)		*/
	/* 1 = one-shot mode (1 = oneshot, 0 = continuous)	*/
	/* 2 = up/down (1 = count up, 0 = count down)		*/
	/* 3 = IRQ enable (1 = enabled, 0 = disabled)		*/

	reg_timer1_config = 3;	/* Enabled, one-shot, down count */

	for (i = 0; i < 8; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_timer1_config = 0;	/* Disabled */

	reg_mprj_datah = 0x01;	/* Check value in testbench */

	reg_timer1_value = 0x00000011;
	reg_timer1_config = 7;	/* Enabled, one-shot, count up */
	
	for (i = 0; i < 3; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x02;	/* Check value in testbench */
	
	reg_timer1_data = 0x00000101;	// Set value (will be reset)
	reg_timer1_config = 2;	/* Disabled, one-shot, count up */
	reg_timer1_config = 5;	/* Enabled, continuous, count down */
	
	for (i = 0; i < 5; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x03;	/* Check value in testbench */

	reg_timer1_data = 0x00000145;	// Force new value

	reg_mprj_datah = 0x04;	/* Check value in testbench */
	
	for (i = 0; i < 5; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x05;	/* Check value in testbench */

	/* Now, set up chained 64 bit timer.  Check count-up	*/
	/* value and count-down value crossing the 32-bit	*/
	/* boundary.						*/

	/* First disable both counters, and set the "chained"	*/
	/* property so that enable/disable will be synchronized	*/

	reg_timer1_config = 8;	/* Disabled, chained */
	reg_timer0_config = 8;	/* Disabled, chained */

	/* Configure timer for a chained single-shot countdown. */
	/* Count start = 0x0000000100001000, end = 0x0		*/

	reg_timer1_value = 0x00000055;
	reg_timer0_value = 0x00001000;

	/* Timer configuration bits:				*/
	/* 0 = timer enable (1 = enabled, 0 = disabled)		*/
	/* 1 = one-shot mode (1 = oneshot, 0 = continuous)	*/
	/* 2 = up/down (1 = count up, 0 = count down)		*/
	/* 3 = chain (1 = enabled, 0 = disabled)		*/
	/* 4 = IRQ enable (1 = enabled, 0 = disabled)		*/

	reg_timer1_config = 11;	/* Enabled, one-shot, down count, chained */
	reg_timer0_config = 11;	/* Enabled, one-shot, down count, chained */

	for (i = 0; i < 1; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x06;	/* Check value in testbench */

	// Skip to the end. . .
	reg_timer1_data = 0x00000000;
	reg_timer0_data = 0x00000200;

	for (i = 0; i < 4; i++) {
	    value = reg_timer0_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x07;	/* Check value in testbench */

	reg_timer1_config = 14;	/* Disabled, one-shot, up count, chained */
	reg_timer0_config = 14;	/* Disabled, one-shot, up count, chained */

	reg_timer1_value = 0x00000002;
	reg_timer0_value = 0x00000000;

	reg_timer1_config = 15;	/* Enabled, one-shot, up count, chained */
	reg_timer0_config = 15;	/* Enabled, one-shot, up count, chained */

	for (i = 0; i < 1; i++) {
	    value = reg_timer0_data;
	    reg_mprj_datal = value;	// Put count value on GPIO
	}

	reg_mprj_datah = 0x08;	/* Check value in testbench */

	// Skip to the end. . . 
	/* Count 0x00000001ffffff00 to 0x0000000200000000 and stop */

	reg_timer1_data = 0x00000001;	// Set value (will be reset)
	reg_timer0_data = 0xffffff00;	// Set value (will be reset)

	for (i = 0; i < 4; i++) {
	    value = reg_timer1_data;
	    reg_mprj_datal = value;	// Put timer1 count value on GPIO
	}

	/* Present end marker (see testbench verilog) */
	reg_mprj_datah = 0x10;
}

