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
    reg_wb_enable =1; // for enable writing to reg_debug_1 and reg_debug_2
    reg_debug_1  = 0x0;
    reg_debug_2  = 0x0;

    reg_gpio_mode1 = 1;
    reg_gpio_mode0 = 0; // for full swing

    reg_gpio_ien = 1;
    reg_gpio_oe = 1;

    reg_debug_1 = 10;
	for (int i = 0; i < 10; i++) {
		/* Fast blink for simulation */
		reg_gpio_out = 1;
		reg_gpio_out = 0;
	}
    reg_debug_1 = 20;
	for (int i = 0; i < 20; i++) {
		/* Fast blink for simulation */
		reg_gpio_out = 1;
		reg_gpio_out = 0;
	}
    reg_debug_1 = 0;
    reg_debug_1 = 0; // for more delay
    reg_debug_1 = 0;

    reg_debug_2 = 0xFF; //finish test


}

