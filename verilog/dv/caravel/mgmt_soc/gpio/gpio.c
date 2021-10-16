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
 *	GPIO Test
 *		Tests PU and PD on the lower 8 pins while being driven from outside
 *		Tests Writing to the upper 8 pins
 *		Tests reading from the lower 8 pins
 */

void main()
{
	int i;

	/* Set data out to zero */
	reg_mprj_datal = 0;

	/* Lower 8 pins are input and upper 8 pins are output */
	reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_29 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_28 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_27 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_26 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_25 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_24 = GPIO_MODE_MGMT_STD_OUTPUT;

	reg_mprj_io_23 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_22 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_21 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_20 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_19 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_18 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_17 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;
	reg_mprj_io_16 = GPIO_MODE_MGMT_STD_INPUT_NOPULL;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	// change the pull up and pull down (checked by the TB)
	reg_mprj_datal = 0xa0000000;

	reg_mprj_io_23 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_22 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_21 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_20 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;

	reg_mprj_io_19 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_18 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_17 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_16 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	reg_mprj_datal = 0x0b000000;

	reg_mprj_io_23 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_22 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_21 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_20 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

	reg_mprj_io_19 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_18 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_17 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_16 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	reg_mprj_io_23 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_22 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_21 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;
	reg_mprj_io_20 = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;

	reg_mprj_io_19 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_18 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_17 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;
	reg_mprj_io_16 = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	// read the lower 8 pins, add 1 then output the result
	// checked by the TB
	reg_mprj_datal = 0xab000000;

	while (1){
		int x = (reg_mprj_datal & 0xff0000) >> 16;
		reg_mprj_datal = (x+1) << 24;
	}
}

