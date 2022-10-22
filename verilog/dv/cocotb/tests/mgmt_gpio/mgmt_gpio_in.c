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
 *	Management SoC GPIO Pin Test
 *		Tests writing to the GPIO pin.
 */

void main()
{
    int temp_in;
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_gpio_mode1 = 1;
    reg_gpio_mode0 = 0; // for full swing

    reg_gpio_ien = 1;
    reg_gpio_oe = 1;

    reg_debug_1 = 10; // wait for 10 blinks
	for (int i = 0; i < 10; i++) {
		while(reg_gpio_in == 0);
        reg_debug_2 = 0XAA; //  1 is recieved
		while(reg_gpio_in == 1);
        reg_debug_2 = 0XBB; // 0 is recieved
	}
    reg_debug_2 = 0x1B;
    reg_debug_1 = 20;
	for (int i = 0; i < 20; i++) {
		while(reg_gpio_in == 0);
        reg_debug_2 = 0XAA; // 1 is recieved
		while(reg_gpio_in == 1);
        reg_debug_2 = 0XBB; // 0 is recieved
	}
    reg_debug_2 = 0x2B;
    temp_in = reg_gpio_in;
    reg_debug_1 = 0;
    for (int i =0; i<50;i++){ // timeout
        if (temp_in != reg_gpio_in)
            reg_debug_2 = 0xEE; //finish test

    }
    reg_debug_2 = 0xFF; //finish test


}

