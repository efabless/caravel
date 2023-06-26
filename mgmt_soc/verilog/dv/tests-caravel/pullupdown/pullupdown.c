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
 * GPIO Pin test pull-up and pull-down modes.
 */

void main()
{
    int j;

    /* Configure top 6 GPIO for signaling the testbench. */
    /* The signal GPIOs will be swapped later so the	 */
    /* top GPIOs can be tested.				 */

    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_OUTPUT;

    /* Turn off the remaining I/O */

    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_29 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_28 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_27 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_26 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_25 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_24 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_23 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_22 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_21 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_20 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_19 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_18 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_17 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_16 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_15 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_14 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_13 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_12 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_11 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_10 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_9 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_8 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_7 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_6 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_5 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_4 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_3 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_2 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_1 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_0 = GPIO_MODE_MGMT_STD_ANALOG;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_mprj_datah = 0x20;	/* Flag start of CSB test */

    /* Turn off the SPI because we will test the	*/
    /* GPIO pins connected to the SPI lines.		*/

    reg_hkspi_disable = 1;

    /* Flag the start of the full GPIO test */
    reg_mprj_datah = 0x30;

    for (j = 0; j < 32; j++) {
	/* Set output j to weak pull-down */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the pulldown test */
	reg_mprj_datah = 0x31;

	/* During this time, GPIO j is tested for the pull-down state */

	/* Set output j to weak pull-up */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the pullup test */
	reg_mprj_datah = 0x32;

	/* During this time, GPIO j is tested for the pull-up state */

	/* Set output j to disabled state */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_ANALOG;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the disabled state test */
	reg_mprj_datah = 0x33;

	/* During this time, GPIO j is tested for the disabled state */
    }    

    /* Flag the change of GPIOs */
    reg_mprj_datah = 0x34;

    reg_mprj_io_0 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_1 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_2 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_3 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_4 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_5 = GPIO_MODE_MGMT_STD_OUTPUT;

    reg_mprj_datal = 0x35;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_ANALOG;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_ANALOG;

    /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    /* Flag start of testing upper GPIOs */
    reg_mprj_datal = 0x36;

    for (j = 32; j < 38; j++) {
	/* Set output j to weak pull-down */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_INPUT_PULLDOWN;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the pulldown test */
	reg_mprj_datal = 0x37;

	/* During this time, GPIO j is tested for the pull-down state */

	/* Set output j to weak pull-up */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_INPUT_PULLUP;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the pullup test */
	reg_mprj_datal = 0x38;

	/* During this time, GPIO j is tested for the pull-up state */

	/* Set output j to disabled state */
	(*(volatile uint32_t*)(0x26000024 + 4 * j)) = GPIO_MODE_MGMT_STD_ANALOG;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	/* Flag the disabled state test */
	reg_mprj_datal = 0x39;

	/* During this time, GPIO j is tested for the disabled state */
    }    

    /* Flag the end of the test */
    reg_mprj_datal = 0x3a;
}

