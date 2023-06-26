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

#include <csr.h>
#include <soc.h>
#include <irq_vex.h>
#include <uart.h>

#include <defs.h>

// -------------------------------------------------------------------------
// Test IRQ callback
// -------------------------------------------------------------------------

extern uint16_t flag;

void main()
{
    uint16_t data;
    int i;

    reg_la1_data = 0x5;	// Signal start of test
    reg_la0_data = 0;
    flag = 0;

    irq_setmask(0);
	irq_setie(1);


	irq_setmask(irq_getmask() | (1 << TIMER0_INTERRUPT));

    /* Configure timer for a single-shot countdown */
	reg_timer0_config = 0;
	reg_timer0_data = 3000;
    reg_timer0_irq_en = 1;
    reg_timer0_config = 1;

    // Loop, waiting for the interrupt to change reg_mprj_datah

    while (flag == 0) {
        reg_la0_data = 0x10000;
    }
    reg_la0_data = 0x40000;
    reg_la1_data = 0xc;	// Signal end of test
}

