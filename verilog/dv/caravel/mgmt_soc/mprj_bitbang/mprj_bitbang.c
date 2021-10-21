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
 *	User Project IO Control by Bit-bang Method Test
 */

void main()
{
    /* This program does nothing but apply output bits to all	*/
    /* GPIOs.  Configuring the GPIOs is done by the verilog	*/
    /* testbench through the housekeeping SPI.			*/

    /* However, the internal config must match the controller	*/
    /* config for the management SoC to apply output.		*/

    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_datal = 0xffffffff;
    reg_mprj_datah = 0x0000003f;

    return;
}

