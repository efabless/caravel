.. raw:: html

   <!---
   # SPDX-FileCopyrightText: 2020 Efabless Corporation
   #
   # Licensed under the Apache License, Version 2.0 (the "License");
   # you may not use this file except in compliance with the License.
   # You may obtain a copy of the License at
   #
   #      http://www.apache.org/licenses/LICENSE-2.0
   #
   # Unless required by applicable law or agreed to in writing, software
   # distributed under the License is distributed on an "AS IS" BASIS,
   # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   # See the License for the specific language governing permissions and
   # limitations under the License.
   #
   # SPDX-License-Identifier: Apache-2.0
   -->

Memory Mapped I/O summary
=========================

.. list-table:: Memory mapped I/O summary by address
    :name: memory_mapped_io_summary_by_address
    :header-rows: 1
    :widths: auto

    * - Address (bytes)
      - Function
    * - `0x 00 00 00 00`
      - Flash SPI / overlaid SRAM (4k words) start of memory block
    * - `0x 00 00 3f ff`
      - End of SRAM
    * - `0x 10 00 00 00`
      - Flash SPI start of program block.
        Program to run starts here on reset
        (see :ref:`SPI Flash initialization <initial_spi_instruction_sequence>`).
    * - `0x 10 ff ff ff`
      - Maximum SPI flash addressable space (16MB) with QSPI 3-byte addressing
    * - `0x 1f ff ff ff`
      - Maximum SPI flash addressable space (32MB)
    * - `0x 20 00 00 00`
      - UART clock divider select (:ref:`reg_uart_clkdiv`)
    * - `0x 20 00 00 04`
      - UART data (:ref:`reg_uart_data`)
    * - `0x 20 00 00 08`
      - UART enable (:ref:`reg_uart_enable`)
    * - `0x 21 00 00 00`
      - GPIO input/output (bit 16/bit 0) (:ref:`reg_gpio_data`). 1 general-purpose digital, management area only.
    * - `0x 21 00 00 04`
      - GPIO output enable (:ref:`reg_gpio_ena`)
    * - `0x 21 00 00 08`
      - GPIO pullup enable (:ref:`reg_gpio_pu`)
    * - `0x 21 00 00 0c`
      - GPIO pulldown enable (:ref:`reg_gpio_pd`)
    * - `0x 22 00 00 00`
      - Counter/Timer 0 configuration register (:ref:`reg_timer0_config`)
    * - `0x 22 00 00 04`
      - Counter/Timer 0 current value (:ref:`reg_timer0_value`)
    * - `0x 22 00 00 08`
      - Counter/Timer 0 reset value (:ref:`reg_timer0_data`)
    * - `0x 23 00 00 00`
      - Counter/Timer 1 configuration register (:ref:`reg_timer1_config`)
    * - `0x 23 00 00 04`
      - Counter/Timer 1 current value (:ref:`reg_timer1_value`)
    * - `0x 23 00 00 08`
      - Counter/Timer 1 reset value (:ref:`reg_timer1_data`)
    * - `0x 24 00 00 00`
      - SPI controller configuration register (:ref:`reg_spi_config`)
    * - `0x 24 00 00 08`
      - SPI controller data register (:ref:`reg_spi_data`)
    * - `0x 25 00 00 00`
      - Logic Analyzer Data 0
    * - `0x 25 00 00 04`
      - Logic Analyzer Data 1
    * - `0x 25 00 00 08`
      - Logic Analyzer Data 2
    * - `0x 25 00 00 0c`
      - Logic Analyzer Data 3
    * - `0x 25 00 00 10`
      - Logic Analyzer Enable 0
    * - `0x 25 00 00 14`
      - Logic Analyzer Enable 1
    * - `0x 25 00 00 18`
      - Logic Analyzer Enable 2
    * - `0x 25 00 00 1c`
      - Logic Analyzer Enable 3
    * - `0x 26 00 00 00`
      - User project area GPIO data (L)
    * - `0x 26 00 00 04`
      - User project area GPIO data (H)
    * - `0x 26 00 00 08`
      - User project area GPIO data transfer (bit 0, auto-zeroing)
    * - `0x 26 00 00 0c`
      - User project area GPIO ``mprj_io[0]`` configure
    * - ...
      - ...
    * - `0x 26 00 00 a0`
      - User project area GPIO ``mprj_io[37]`` configure
    * - `0x 26 00 00 a4`
      - User project area GPIO power[0] configure (currently undefined/unused)
    * - ...
      - ...
    * - `0x 26 00 00 b4`
      - User project area GPIO power[3] configure (currently undefined/unused)
    * - `0x 2d 00 00 00`
      - QSPI controller config (:ref:`reg_spictrl`)
    * - `0x 2f 00 00 00`
      - PLL clock output destination (:ref:`reg_pll_out_dest`)
    * - `0x 2f 00 00 04`
      - Trap output destination (:ref:`reg_trap_out_dest`)
    * - `0x 2f 00 00 08`
      - IRQ 7 input source (:ref:`reg_irq7_source`)
    * - `0x 30 00 00 0`
      - User area base.
        A user project may define additional Wishbone responder modules starting at this address.
    * - `0x 80 00 00 00`
      - QSPI controller
    * - `0x 90 00 00 00`
      - :ref:`storage-area-sram`
    * - `0x a0 00 00 00`
      - Any responder 1
    * - `0x b0 00 00 00`
      - Any responder 2
