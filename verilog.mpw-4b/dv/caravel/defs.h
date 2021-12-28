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

#ifndef _CARAVEL_H_
#define _CARAVEL_H_

#include <stdint.h>
#include <stdbool.h>

// a pointer to this is a null pointer, but the compiler does not
// know that because "sram" is a linker symbol from sections.lds.
extern uint32_t sram;

// Pointer to firmware flash routines
extern uint32_t flashio_worker_begin;
extern uint32_t flashio_worker_end;

// Storage area (MGMT: 0x0100_0000, User: 0x0200_0000)
#define reg_rw_block0  (*(volatile uint32_t*)0x01000000)
#define reg_ro_block0  (*(volatile uint32_t*)0x02000000)

// UART (0x2000_0000)
#define reg_uart_clkdiv (*(volatile uint32_t*)0x20000000)
#define reg_uart_data   (*(volatile uint32_t*)0x20000004)
#define reg_uart_enable (*(volatile uint32_t*)0x20000008)

// GPIO (0x2100_0000)
#define reg_gpio_data (*(volatile uint32_t*)0x21000000)
#define reg_gpio_ena  (*(volatile uint32_t*)0x21000004)
#define reg_gpio_pu   (*(volatile uint32_t*)0x21000008)
#define reg_gpio_pd   (*(volatile uint32_t*)0x2100000c)

// Logic Analyzer (0x2200_0000)
#define reg_la0_data (*(volatile uint32_t*)0x25000000)
#define reg_la1_data (*(volatile uint32_t*)0x25000004)
#define reg_la2_data (*(volatile uint32_t*)0x25000008)
#define reg_la3_data (*(volatile uint32_t*)0x2500000c)

#define reg_la0_oenb (*(volatile uint32_t*)0x25000010)
#define reg_la1_oenb (*(volatile uint32_t*)0x25000014)
#define reg_la2_oenb (*(volatile uint32_t*)0x25000018)
#define reg_la3_oenb (*(volatile uint32_t*)0x2500001c)

#define reg_la0_iena (*(volatile uint32_t*)0x25000020)
#define reg_la1_iena (*(volatile uint32_t*)0x25000024)
#define reg_la2_iena (*(volatile uint32_t*)0x25000028)
#define reg_la3_iena (*(volatile uint32_t*)0x2500002c)

#define reg_la_sample (*(volatile uint32_t*)0x25000030)

// User Project Control (0x2300_0000)
#define reg_mprj_xfer (*(volatile uint32_t*)0x26000000)
#define reg_mprj_pwr  (*(volatile uint32_t*)0x26000004)
#define reg_mprj_irq  (*(volatile uint32_t*)0x26100014)
#define reg_mprj_datal (*(volatile uint32_t*)0x2600000c)
#define reg_mprj_datah (*(volatile uint32_t*)0x26000010)

#define reg_mprj_io_0 (*(volatile uint32_t*)0x26000024)
#define reg_mprj_io_1 (*(volatile uint32_t*)0x26000028)
#define reg_mprj_io_2 (*(volatile uint32_t*)0x2600002c)
#define reg_mprj_io_3 (*(volatile uint32_t*)0x26000030)
#define reg_mprj_io_4 (*(volatile uint32_t*)0x26000034)
#define reg_mprj_io_5 (*(volatile uint32_t*)0x26000038)
#define reg_mprj_io_6 (*(volatile uint32_t*)0x2600003c)

#define reg_mprj_io_7 (*(volatile uint32_t*)0x26000040)
#define reg_mprj_io_8 (*(volatile uint32_t*)0x26000044)
#define reg_mprj_io_9 (*(volatile uint32_t*)0x26000048)
#define reg_mprj_io_10 (*(volatile uint32_t*)0x2600004c)

#define reg_mprj_io_11 (*(volatile uint32_t*)0x26000050)
#define reg_mprj_io_12 (*(volatile uint32_t*)0x26000054)
#define reg_mprj_io_13 (*(volatile uint32_t*)0x26000058)
#define reg_mprj_io_14 (*(volatile uint32_t*)0x2600005c)

#define reg_mprj_io_15 (*(volatile uint32_t*)0x26000060)
#define reg_mprj_io_16 (*(volatile uint32_t*)0x26000064)
#define reg_mprj_io_17 (*(volatile uint32_t*)0x26000068)
#define reg_mprj_io_18 (*(volatile uint32_t*)0x2600006c)

#define reg_mprj_io_19 (*(volatile uint32_t*)0x26000070)
#define reg_mprj_io_20 (*(volatile uint32_t*)0x26000074)
#define reg_mprj_io_21 (*(volatile uint32_t*)0x26000078)
#define reg_mprj_io_22 (*(volatile uint32_t*)0x2600007c)

#define reg_mprj_io_23 (*(volatile uint32_t*)0x26000080)
#define reg_mprj_io_24 (*(volatile uint32_t*)0x26000084)
#define reg_mprj_io_25 (*(volatile uint32_t*)0x26000088)
#define reg_mprj_io_26 (*(volatile uint32_t*)0x2600008c)

#define reg_mprj_io_27 (*(volatile uint32_t*)0x26000090)
#define reg_mprj_io_28 (*(volatile uint32_t*)0x26000094)
#define reg_mprj_io_29 (*(volatile uint32_t*)0x26000098)
#define reg_mprj_io_30 (*(volatile uint32_t*)0x2600009c)
#define reg_mprj_io_31 (*(volatile uint32_t*)0x260000a0)

#define reg_mprj_io_32 (*(volatile uint32_t*)0x260000a4)
#define reg_mprj_io_33 (*(volatile uint32_t*)0x260000a8)
#define reg_mprj_io_34 (*(volatile uint32_t*)0x260000ac)
#define reg_mprj_io_35 (*(volatile uint32_t*)0x260000b0)
#define reg_mprj_io_36 (*(volatile uint32_t*)0x260000b4)
#define reg_mprj_io_37 (*(volatile uint32_t*)0x260000b8)

// Housekeeping
#define reg_hkspi_status      (*(volatile uint32_t*)0x26100000)
#define reg_hkspi_chip_id     (*(volatile uint32_t*)0x26100004)
#define reg_hkspi_user_id     (*(volatile uint32_t*)0x26100008)
#define reg_hkspi_pll_ena     (*(volatile uint32_t*)0x2610000c)
#define reg_hkspi_pll_bypass  (*(volatile uint32_t*)0x26100010)
#define reg_hkspi_irq 	      (*(volatile uint32_t*)0x26100014)
#define reg_hkspi_reset       (*(volatile uint32_t*)0x26100018)
#define reg_hkspi_trap 	      (*(volatile uint32_t*)0x26100028)
#define reg_hkspi_pll_trim    (*(volatile uint32_t*)0x2610001c)
#define reg_hkspi_pll_source  (*(volatile uint32_t*)0x26100020)
#define reg_hkspi_pll_divider (*(volatile uint32_t*)0x26100024)
#define reg_hkspi_disable     (*(volatile uint32_t*)0x26200010)

// User Project Slaves (0x3000_0000)
#define reg_mprj_slave (*(volatile uint32_t*)0x30000000)

// Flash Control SPI Configuration (2D00_0000)
#define reg_spictrl (*(volatile uint32_t*)0x2d000000)         

// Bit fields for Flash SPI control
#define FLASH_BITBANG_IO0	0x00000001
#define FLASH_BITBANG_IO1	0x00000002
#define FLASH_BITBANG_CLK	0x00000010
#define FLASH_BITBANG_CSB	0x00000020
#define FLASH_BITBANG_OEB0	0x00000100
#define FLASH_BITBANG_OEB1	0x00000200
#define FLASH_ENABLE		0x80000000

// Counter-Timer 0 Configuration
#define reg_timer0_config (*(volatile uint32_t*)0x22000000)
#define reg_timer0_value  (*(volatile uint32_t*)0x22000004)
#define reg_timer0_data   (*(volatile uint32_t*)0x22000008)

// Counter-Timer 1 Configuration
#define reg_timer1_config (*(volatile uint32_t*)0x23000000)
#define reg_timer1_value  (*(volatile uint32_t*)0x23000004)
#define reg_timer1_data   (*(volatile uint32_t*)0x23000008)

// Bit fields for Counter-timer configuration
#define TIMER_ENABLE		0x01
#define TIMER_ONESHOT		0x02
#define TIMER_UPCOUNT		0x04
#define TIMER_CHAIN		0x08
#define TIMER_IRQ_ENABLE	0x10

// SPI Master Configuration
#define reg_spimaster_config (*(volatile uint32_t*)0x24000000)
#define reg_spimaster_data   (*(volatile uint32_t*)0x24000004)

// Bit fields for SPI master configuration
#define SPI_MASTER_DIV_MASK	0x00ff
#define SPI_MASTER_MLB		0x0100
#define SPI_MASTER_INV_CSB	0x0200
#define SPI_MASTER_INV_CLK	0x0400
#define SPI_MASTER_MODE_1	0x0800
#define SPI_MASTER_STREAM	0x1000
#define SPI_MASTER_ENABLE	0x2000
#define SPI_MASTER_IRQ_ENABLE	0x4000
#define SPI_HOUSEKEEPING_CONN	0x8000

// System Area (0x2620_0000)
#define reg_power_good    (*(volatile uint32_t*)0x26200000)
#define reg_clk_out_dest  (*(volatile uint32_t*)0x26200004)
#define reg_trap_out_dest (*(volatile uint32_t*)0x26200004)
#define reg_irq_source    (*(volatile uint32_t*)0x2620000C)

// Management protection (0x2f00_0000)
#define reg_irq_enable	  (*(volatile uint32_t*)0x2f000000)
#define reg_wb_enable	  (*(volatile uint32_t*)0x2f000004)

// Bit fields for reg_power_good
#define USER1_VCCD_POWER_GOOD 0x01
#define USER2_VCCD_POWER_GOOD 0x02
#define USER1_VDDA_POWER_GOOD 0x04
#define USER2_VDDA_POWER_GOOD 0x08

// Bit fields for reg_clk_out_dest
#define CLOCK1_MONITOR 0x01
#define CLOCK2_MONITOR 0x02
#define TRAP_MONITOR 0x04

// Bit fields for reg_irq_source
#define IRQ7_SOURCE 0x01
#define IRQ8_SOURCE 0x02

// Individual bit fields for the GPIO pad control
#define MGMT_ENABLE	  0x0001
#define OUTPUT_DISABLE	  0x0002
#define HOLD_OVERRIDE	  0x0004
#define INPUT_DISABLE	  0x0008
#define MODE_SELECT	  0x0010
#define ANALOG_ENABLE	  0x0020
#define ANALOG_SELECT	  0x0040
#define ANALOG_POLARITY	  0x0080
#define SLOW_SLEW_MODE	  0x0100
#define TRIPPOINT_SEL	  0x0200
#define DIGITAL_MODE_MASK 0x1c00

// Useful GPIO mode values
#define GPIO_MODE_MGMT_STD_INPUT_NOPULL    0x0403
#define GPIO_MODE_MGMT_STD_INPUT_PULLDOWN  0x0803
#define GPIO_MODE_MGMT_STD_INPUT_PULLUP	   0x0c03
#define GPIO_MODE_MGMT_STD_OUTPUT	   0x1809
#define GPIO_MODE_MGMT_STD_BIDIRECTIONAL   0x1801
#define GPIO_MODE_MGMT_STD_ANALOG   	   0x000b

#define GPIO_MODE_USER_STD_INPUT_NOPULL	   0x0402
#define GPIO_MODE_USER_STD_INPUT_PULLDOWN  0x0802
#define GPIO_MODE_USER_STD_INPUT_PULLUP	   0x0c02
#define GPIO_MODE_USER_STD_OUTPUT	   0x1808
#define GPIO_MODE_USER_STD_BIDIRECTIONAL   0x1800
#define GPIO_MODE_USER_STD_OUT_MONITORED   0x1802
#define GPIO_MODE_USER_STD_ANALOG   	   0x000a

// --------------------------------------------------------
#endif
