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

// --------------------------------------------------------

/*
 *	Timer Test
 */

void main()
{
	int i;
	uint32_t value;

	/* Initialize output data vector to zero */
	reg_la1_data = 0x00000000;
	reg_la0_data = 0x00000000;

	/* Present start marker (see testbench verilog) */
	reg_la1_data = 0x0a;

	/* Configure timer for a single-shot countdown */
	reg_timer0_config = 0;
//	reg_timer0_value = 0xdcba9876;
	reg_timer0_data = 0xdcba9876;
    reg_timer0_config = 1;


	/* Timer configuration bits:				*/
	/* 0 = timer enable (1 = enabled, 0 = disabled)		*/
	/* 1 = one-shot mode (1 = oneshot, 0 = continuous)	*/
	/* 2 = up/down (1 = count up, 0 = count down)		*/
	/* 3 = chain (1 = enabled, 0 = disabled)		*/
	/* 4 = IRQ enable (1 = enabled, 0 = disabled)		*/

//	reg_timer0_config = 3;	/* Enabled, one-shot, down count */

	for (i = 0; i < 8; i++) {
//	    value = reg_timer0_data;
        reg_timer0_update = 1;
	    value = reg_timer0_value;
	    reg_la0_data = value;	// Put count value on GPIO
	}

	reg_timer0_config = 0;	/* Disabled */

	reg_la1_data = 0x01;	/* Check value in testbench */

	reg_timer0_value = 0x00000011;
	reg_timer0_config = 7;	/* Enabled, one-shot, count up */
	
	for (i = 0; i < 3; i++) {
	    value = reg_timer0_data;
	    reg_la0_data = value;	// Put count value on GPIO
	}

	reg_la1_data = 0x02;	/* Check value in testbench */
	
	reg_timer0_data = 0x00000101;	// Set value (will be reset)
	reg_timer0_config = 2;	/* Disabled, one-shot, count up */
	reg_timer0_config = 5;	/* Enabled, continuous, count down */
	
	for (i = 0; i < 5; i++) {
	    value = reg_timer0_data;
	    reg_la0_data = value;	// Put count value on GPIO
	}

	reg_la1_data = 0x03;	/* Check value in testbench */

	reg_timer0_data = 0x00000145;	// Force new value

	reg_la1_data = 0x04;	/* Check value in testbench */
	
	for (i = 0; i < 5; i++) {
	    value = reg_timer0_data;
	    reg_la0_data = value;	// Put count value on GPIO
	}
	
	/* Present end marker (see testbench verilog) */
	reg_la1_data = 0x05;
}

