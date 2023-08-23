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
==============================
Caravel Management SoC - Litex
==============================

|License| |User CI| |Caravel Build|

.. contents:: Table of Contents
    :local:
    :depth: 2

Overview
========

This repository contains an implementation of the management area for
`Caravel <https://github.com/efabless/caravel.git>`__.
The management area is SoC generated using Litex containing a VexRiscv core with memory, a flash controller and serial peripherals.

.. image:: _static/block_diagram.png
    :width: 100%
    :alt: Caravel Management Area Block Diagram

Features
=============

* VexRiscv core with debug port
* 2 kB SRAM plus 1 kB of DFFRAM
* XIP SPI Flash controller
* UART, SPI and GPIO ports
* 128 port logic analyzer
* Counter / timer
* 32-bit Wishbone bus extending to the user project area
* 6 user interrupts

Processor
=========

The processor core is based on a VexRiscv minimal+debug configuration.  The core has been configured with 64 bytes of instruction cache.
The core has not been configured with compress or multiply instructions.

Flash Controller
================

Description
-----------

The flash controller supports single mode SPI to a compatible W25Q128JV Flash device.  The configuration supports
execute-in-place and the CPU reset vector is configured for the beginning of the Flash memory region.

Interrupts (IRQ)
================

Description
-----------

The processor is configured with interrupts for the Uart and Timer devices.  It also supports 6 user IRQS extended
to the user project.

The corresponding register must be set to enable interrupts from the respective device.  The following registers are
applicable:

* reg_timer0_irq_en
* reg_timer0_irq_en
* reg_timer0_irq_en

.. include:: generated/interrupts.rst
    :start-after: Interrupt


UART
====

Description
-----------
The UART provide general serial communication with the management SoC.  The baud rate is configured at 9600.

The ``reg_uart_enable`` must be set in order to run (disabled by default).

``reg_uart_enable`` can be used to read and write data to the port.

.. include:: generated/uart.rst
    :start-after: UART

SPI Controller
==============

Description
-----------
The SPI controller is operated through the ``reg_spimaster_control`` and ``reg_spimaster_status'' registers.

``reg_spimaster_rdata`` and ``reg_spimaster_wdata`` are used to read abd write data through to the port.

.. include:: generated/spi_master.rst
    :start-after: SPI_MASTER

GPIO
====
.. include:: generated/gpio.rst
    :start-after: GPIO

Description
-----------
A single GPIO port is provided from the Management SoC as general indicator and diagnostic for programming or as a means
to control functionality off chip.

One example user case is to set an enable for an off-chip LDO enabling a controlled power-up sequence for the user project.

Debug
=====

Description
-----------
Debug support is enabled in the core and can be accessed through a dedicated UART port configured as a wishbone master.
The baud rate for the port is 9600.

See the following reference for more information <https://github.com/SpinalHDL/VexRiscv#debugplugin>.

Counter / Timer
===============

Description
-----------
.. include:: generated/timer0.rst
    :start-after: Timer

Logic Analyzer
==============

Description
-----------
The logic analyzer function provides a flexible means to monitor signals from the user project wrapper or drive them
from the management core.

The logic analyzer supports 128 signals mapped to separated GPIO in, out and oeb ports.

.. include:: generated/la.rst
    :start-after: LA

Memory Regions
==============

+---------------------+----------------------------+--------------------------+
| Region              | Address                    | Size                     |
+=====================+============================+==========================+
| dff                 | 0x00000000                 | 0x00000400               |
+---------------------+----------------------------+--------------------------+
| sram                | 0x01000000                 | 0x00000800               |
+---------------------+----------------------------+--------------------------+
| flash               | 0x10000000                 | 0x01000000               |
+---------------------+----------------------------+--------------------------+
| hk                  | 0x26000000                 | 0x00100000               |
+---------------------+----------------------------+--------------------------+
| user project        | 0x30000000                 | 0x10000000               |
+---------------------+----------------------------+--------------------------+
| csr                 | 0xf0000000                 | 0x00010000               |
+---------------------+----------------------------+--------------------------+
| vexriscv_debug      | 0xf00f0000                 | 0x00000100               |
+---------------------+----------------------------+--------------------------+


Other Registers
===============

.. toctree::
    :maxdepth: 1

    generated/interrupts

    generated/ctrl
    generated/debug_mode
    generated/debug_oeb
    generated/flash_core
    generated/flash_phy
    generated/la
    generated/mprj_wb_iena
    generated/spi_enabled
    generated/uart_enabled
    generated/user_irq_0
    generated/user_irq_1
    generated/user_irq_2
    generated/user_irq_3
    generated/user_irq_4
    generated/user_irq_5
    generated/user_irq_ena


.. include:: references.rst

   
.. |License| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0
.. |User CI| image:: https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg
   :target: https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml
.. |Caravel Build| image:: https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg
   :target: https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml

