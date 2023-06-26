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

#ifndef _DEF_H_
#define _DEF_H_

#include <stdint.h>
#include <stdbool.h>

#include <csr.h>
#include <caravel.h>

// a pointer to this is a null pointer, but the compiler does not
// know that because "sram" is a linker symbol from sections.lds.
extern uint32_t sram;

// Pointer to firmware flash routines
extern uint32_t flashio_worker_begin;
extern uint32_t flashio_worker_end;

// Storage area (MGMT: 0x0100_0000, User: 0x0200_0000)
#define reg_rw_block0  (*(volatile uint32_t*)0x01000000)
#define reg_rw_block1  (*(volatile uint32_t*)0x01100000)
#define reg_ro_block0  (*(volatile uint32_t*)0x02000000)

// UART (0x2000_0000)
//#define reg_uart_clkdiv (*(volatile uint32_t*)0x20000000)
#define reg_uart_data   (*(volatile uint32_t*) CSR_UART_RXTX_ADDR)
#define reg_uart_txfull   (*(volatile uint32_t*) CSR_UART_TXFULL_ADDR)
#define reg_uart_enable (*(volatile uint32_t*) CSR_UART_ENABLED_OUT_ADDR)
#define reg_uart_irq_en    (*(volatile uint32_t*) CSR_UART_EV_ENABLE_ADDR)

// DEBUG (0x2000_0000)
//#define reg_uart_clkdiv (*(volatile uint32_t*)0x20000000)
#define reg_reset   (*(volatile uint32_t*) CSR_CTRL_RESET_ADDR)
#define reg_debug_data   (*(volatile uint32_t*) CSR_DEBUG_RXTX_ADDR)
#define reg_debug_txfull   (*(volatile uint32_t*) CSR_DEBUG_TXFULL_ADDR)
#define reg_debug_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_3_EV_ENABLE_ADDR)
//#define reg_debug_enable (*(volatile uint32_t*) CSR_UART_ENABLED_OUT_ADDR)

// GPIO (0x2100_0000)
#define reg_gpio_mode1  (*(volatile uint32_t*) CSR_GPIO_MODE1_ADDR)
#define reg_gpio_mode0  (*(volatile uint32_t*) CSR_GPIO_MODE0_ADDR)
#define reg_gpio_ien    (*(volatile uint32_t*) CSR_GPIO_IEN_ADDR)
#define reg_gpio_oe     (*(volatile uint32_t*) CSR_GPIO_OE_ADDR)
#define reg_gpio_in     (*(volatile uint32_t*) CSR_GPIO_IN_ADDR)
#define reg_gpio_out    (*(volatile uint32_t*) CSR_GPIO_OUT_ADDR)
//#define reg_gpio_pu   (*(volatile uint32_t*)0x21000008)
//#define reg_gpio_pd   (*(volatile uint32_t*)0x2100000c)

// Logic Analyzer (0x2200_0000)
#define reg_la3_data (*(volatile uint32_t*) CSR_LA_OUT_ADDR)
#define reg_la2_data (*(volatile uint32_t*) (CSR_LA_OUT_ADDR + 4))
#define reg_la1_data (*(volatile uint32_t*) (CSR_LA_OUT_ADDR + 8))
#define reg_la0_data (*(volatile uint32_t*) (CSR_LA_OUT_ADDR + 12))

#define reg_la3_data_in (*(volatile uint32_t*) CSR_LA_IN_ADDR)
#define reg_la2_data_in (*(volatile uint32_t*) (CSR_LA_IN_ADDR + 4))
#define reg_la1_data_in (*(volatile uint32_t*) (CSR_LA_IN_ADDR + 8))
#define reg_la0_data_in (*(volatile uint32_t*) (CSR_LA_IN_ADDR + 12))

#define reg_la3_oenb (*(volatile uint32_t*) CSR_LA_OE_ADDR)
#define reg_la2_oenb (*(volatile uint32_t*) (CSR_LA_OE_ADDR + 4))
#define reg_la1_oenb (*(volatile uint32_t*) (CSR_LA_OE_ADDR + 8))
#define reg_la0_oenb (*(volatile uint32_t*) (CSR_LA_OE_ADDR + 12))

#define reg_la3_iena (*(volatile uint32_t*) CSR_LA_IEN_ADDR)
#define reg_la2_iena (*(volatile uint32_t*) (CSR_LA_IEN_ADDR + 4))
#define reg_la1_iena (*(volatile uint32_t*) (CSR_LA_IEN_ADDR + 8))
#define reg_la0_iena (*(volatile uint32_t*) (CSR_LA_IEN_ADDR + 12))

#define reg_la_sample (*(volatile uint32_t*)0x25000030)

// User Project Control (0x2300_0000)
//#define reg_mprj_xfer (*(volatile uint32_t*)0x26000000)
//#define reg_mprj_pwr  (*(volatile uint32_t*)0x26000004)
//#define reg_mprj_irq  (*(volatile uint32_t*)0x26000008)
//#define reg_mprj_datal (*(volatile uint32_t*)0x2600000c)
//#define reg_mprj_datah (*(volatile uint32_t*)0x26000010)
//
//#define reg_mprj_io_0 (*(volatile uint32_t*)0x26000024)
//#define reg_mprj_io_1 (*(volatile uint32_t*)0x26000028)
//#define reg_mprj_io_2 (*(volatile uint32_t*)0x2600002c)
//#define reg_mprj_io_3 (*(volatile uint32_t*)0x26000030)
//#define reg_mprj_io_4 (*(volatile uint32_t*)0x26000034)
//#define reg_mprj_io_5 (*(volatile uint32_t*)0x26000038)
//#define reg_mprj_io_6 (*(volatile uint32_t*)0x2600003c)
//
//#define reg_mprj_io_7 (*(volatile uint32_t*)0x26000040)
//#define reg_mprj_io_8 (*(volatile uint32_t*)0x26000044)
//#define reg_mprj_io_9 (*(volatile uint32_t*)0x26000048)
//#define reg_mprj_io_10 (*(volatile uint32_t*)0x2600004c)
//
//#define reg_mprj_io_11 (*(volatile uint32_t*)0x26000050)
//#define reg_mprj_io_12 (*(volatile uint32_t*)0x26000054)
//#define reg_mprj_io_13 (*(volatile uint32_t*)0x26000058)
//#define reg_mprj_io_14 (*(volatile uint32_t*)0x2600005c)
//
//#define reg_mprj_io_15 (*(volatile uint32_t*)0x26000060)
//#define reg_mprj_io_16 (*(volatile uint32_t*)0x26000064)
//#define reg_mprj_io_17 (*(volatile uint32_t*)0x26000068)
//#define reg_mprj_io_18 (*(volatile uint32_t*)0x2600006c)
//
//#define reg_mprj_io_19 (*(volatile uint32_t*)0x26000070)
//#define reg_mprj_io_20 (*(volatile uint32_t*)0x26000074)
//#define reg_mprj_io_21 (*(volatile uint32_t*)0x26000078)
//#define reg_mprj_io_22 (*(volatile uint32_t*)0x2600007c)
//
//#define reg_mprj_io_23 (*(volatile uint32_t*)0x26000080)
//#define reg_mprj_io_24 (*(volatile uint32_t*)0x26000084)
//#define reg_mprj_io_25 (*(volatile uint32_t*)0x26000088)
//#define reg_mprj_io_26 (*(volatile uint32_t*)0x2600008c)
//
//#define reg_mprj_io_27 (*(volatile uint32_t*)0x26000090)
//#define reg_mprj_io_28 (*(volatile uint32_t*)0x26000094)
//#define reg_mprj_io_29 (*(volatile uint32_t*)0x26000098)
//#define reg_mprj_io_30 (*(volatile uint32_t*)0x2600009c)
//#define reg_mprj_io_31 (*(volatile uint32_t*)0x260000a0)
//
//#define reg_mprj_io_32 (*(volatile uint32_t*)0x260000a4)
//#define reg_mprj_io_33 (*(volatile uint32_t*)0x260000a8)
//#define reg_mprj_io_34 (*(volatile uint32_t*)0x260000ac)
//#define reg_mprj_io_35 (*(volatile uint32_t*)0x260000b0)
//#define reg_mprj_io_36 (*(volatile uint32_t*)0x260000b4)
//#define reg_mprj_io_37 (*(volatile uint32_t*)0x260000b8)

// User Project Slaves (0x3000_0000)
#define reg_wb_enable	  	(*(volatile uint32_t*) CSR_MPRJ_WB_IENA_OUT_ADDR)
#define reg_user_irq_enable	(*(volatile uint32_t*) CSR_USER_IRQ_ENA_OUT_ADDR)

// Debug reg DEBUG_ON
#define reg_debug_1 (*(volatile uint32_t*)0x300FFFF8)
#define reg_debug_2 (*(volatile uint32_t*)0x300FFFFC)


// Flash Control SPI Configuration (2D00_0000)
//#define reg_spictrl (*(volatile uint32_t*)0x2d000000)

// Bit fields for Flash SPI control
//#define FLASH_BITBANG_IO0	0x00000001
//#define FLASH_BITBANG_IO1	0x00000002
//#define FLASH_BITBANG_CLK	0x00000010
//#define FLASH_BITBANG_CSB	0x00000020
//#define FLASH_BITBANG_OEB0	0x00000100
//#define FLASH_BITBANG_OEB1	0x00000200
//#define FLASH_ENABLE		0x80000000

// Counter-Timer 0 Configuration
#define reg_timer0_config (*(volatile uint32_t*) CSR_TIMER0_EN_ADDR)
#define reg_timer0_update  (*(volatile uint32_t*) CSR_TIMER0_UPDATE_VALUE_ADDR)
#define reg_timer0_value  (*(volatile uint32_t*) CSR_TIMER0_VALUE_ADDR)
#define reg_timer0_data   (*(volatile uint32_t*) CSR_TIMER0_LOAD_ADDR)
#define reg_timer0_data_periodic  (*(volatile uint32_t*) CSR_TIMER0_RELOAD_ADDR)
#define reg_timer0_irq_en   (*(volatile uint32_t*) CSR_TIMER0_EV_ENABLE_ADDR)

// Bit fields for Counter-timer configuration
#define TIMER_ENABLE		0x01
#define TIMER_ONESHOT		0x02
#define TIMER_UPCOUNT		0x04
#define TIMER_CHAIN		    0x08
#define TIMER_IRQ_ENABLE	0x10

// SPI Master Configuration
#define reg_spimaster_control (*(volatile uint32_t*) CSR_SPI_MASTER_CONTROL_ADDR)
#define reg_spimaster_status (*(volatile uint32_t*) CSR_SPI_MASTER_STATUS_ADDR)
#define reg_spimaster_wdata   (*(volatile uint32_t*) CSR_SPI_MASTER_MOSI_ADDR)
#define reg_spimaster_rdata   (*(volatile uint32_t*) CSR_SPI_MASTER_MISO_ADDR)
#define reg_spimaster_cs   (*(volatile uint32_t*) CSR_SPI_MASTER_CS_ADDR)
#define reg_spimaster_clk_divider   (*(volatile uint32_t*) CSR_SPI_MASTER_CLK_DIVIDER_ADDR)
#define reg_spi_enable (*(volatile uint32_t*) CSR_SPI_ENABLED_OUT_ADDR)


// Bit fields for SPI master configuration
//#define SPI_MASTER_DIV_MASK	0x00ff
//#define SPI_MASTER_MLB		0x0100
//#define SPI_MASTER_INV_CSB	0x0200
//#define SPI_MASTER_INV_CLK	0x0400
//#define SPI_MASTER_MODE_1	0x0800
//#define SPI_MASTER_STREAM	0x1000
//#define SPI_MASTER_ENABLE	0x2000
//#define SPI_MASTER_IRQ_ENABLE	0x4000
//#define SPI_HOUSEKEEPING_CONN	0x8000

// System Area (0x2F00_0000)
//#define reg_power_good    (*(volatile uint32_t*)0x2F000000)
//#define reg_clk_out_dest  (*(volatile uint32_t*)0x2F000004)
//#define reg_trap_out_dest (*(volatile uint32_t*)0x2F000008)
//#define reg_irq_source    (*(volatile uint32_t*)0x2F00000C)

// Bit fields for reg_power_good
//#define USER1_VCCD_POWER_GOOD 0x01
//#define USER2_VCCD_POWER_GOOD 0x02
//#define USER1_VDDA_POWER_GOOD 0x04
//#define USER2_VDDA_POWER_GOOD 0x08

// Bit fields for reg_clk_out_dest
//#define CLOCK1_MONITOR 0x01
//#define CLOCK2_MONITOR 0x02

// Bit fields for reg_irq_source
//#define IRQ7_SOURCE 0x01
//#define IRQ8_SOURCE 0x02

// Added IRQ bit enable
#define reg_user0_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_0_EV_ENABLE_ADDR)
#define reg_user1_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_1_EV_ENABLE_ADDR)
#define reg_user2_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_2_EV_ENABLE_ADDR)
#define reg_user3_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_3_EV_ENABLE_ADDR)
#define reg_user4_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_4_EV_ENABLE_ADDR) // mprj[7]
#define reg_user5_irq_en   (*(volatile uint32_t*) CSR_USER_IRQ_5_EV_ENABLE_ADDR)

// Individual bit fields for the GPIO pad control
//#define MGMT_ENABLE	  0x0001
//#define OUTPUT_DISABLE	  0x0002
//#define HOLD_OVERRIDE	  0x0004
//#define INPUT_DISABLE	  0x0008
//#define MODE_SELECT	  0x0010
//#define ANALOG_ENABLE	  0x0020
//#define ANALOG_SELECT	  0x0040
//#define ANALOG_POLARITY	  0x0080
//#define SLOW_SLEW_MODE	  0x0100
//#define TRIPPOINT_SEL	  0x0200
//#define DIGITAL_MODE_MASK 0x1c00

//// Useful GPIO mode values
//#define GPIO_MODE_MGMT_STD_INPUT_NOPULL    0x0403
//#define GPIO_MODE_MGMT_STD_INPUT_PULLDOWN  0x0801
//#define GPIO_MODE_MGMT_STD_INPUT_PULLUP	   0x0c01
//#define GPIO_MODE_MGMT_STD_OUTPUT	   0x1809
//#define GPIO_MODE_MGMT_STD_BIDIRECTIONAL   0x1801
//#define GPIO_MODE_MGMT_STD_ANALOG   	   0x000b
//
//#define GPIO_MODE_USER_STD_INPUT_NOPULL	   0x0402
//#define GPIO_MODE_USER_STD_INPUT_PULLDOWN  0x0800
//#define GPIO_MODE_USER_STD_INPUT_PULLUP	   0x0c00
//#define GPIO_MODE_USER_STD_OUTPUT	   0x1808
//#define GPIO_MODE_USER_STD_BIDIRECTIONAL   0x1800
//#define GPIO_MODE_USER_STD_OUT_MONITORED   0x1802
//#define GPIO_MODE_USER_STD_ANALOG   	   0x000a

// --------------------------------------------------------

// configurations
#define SKY    1
#define LA_SIZE 128
#define CTRL_BITS_SIZE   13 // number of control bits in gpio control module 
#define TRAP_SUP 1 // trap support
#define PLL_SUP 0 // pll support

// RAM PARAMETER
#define DFF1_START_ADDR 0x00000000 
#define DFF1_SIZE 0x400
#define DFF2_START_ADDR 0x00000400 
#define DFF2_SIZE 0x200 

#define USER_SPACE_ADDR 0x30000000 
#define USER_SPACE_SIZE 0xFFFFC // sum with USER_SPACE_ADDR is the address of last address

#define reg_debug_2 (*(volatile unsigned int*)(USER_SPACE_ADDR + USER_SPACE_SIZE))
#define reg_debug_1 (*(volatile unsigned int*)(USER_SPACE_ADDR + USER_SPACE_SIZE - 4))

#define CPU_TYPE VexRISC
#endif
