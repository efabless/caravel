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

Interrupts (IRQ)
================

The interrupt vector is set to memory address ``0`` (bottom of SRAM).
The program counter switches to this location when an interrupt is received.
To enable interrupts, it is necessary to copy an interrupt handler to memory location ``0``.
The `PicoRV32 <https://github.com/cliffordwolf/picorv32>`_ defines 32 IRQ channels, of which the Caravel chip uses only a handful, as described in the :ref:`cpu_irq_channel_definitions`.
All IRQ channels not in the :ref:`cpu_irq_channel_definitions` always have value zero.

.. list-table:: CPU IRQ channel definitions
    :name: cpu_irq_channel_definitions
    :header-rows: 1
    :widths: auto

    * - IRQ channel
      - description
    * - 4
      - :doc:`uart` data available
    * - 5
      - IRQ external pin (:ref:`IRQ E5 pin <irq>`)
    * - 6
      - :doc:`housekeeping-spi` IRQ
    * - 7
      - Assignable interrupt (see :ref:`reg_irq7_source`)
    * - 9
      - SPI controller data available, when enabled (see :ref:`reg_spi_config`)
    * - 10
      - Timer 0 expired, when enabled (see :ref:`reg_timer0_config`)
    * - 11
      - Timer 1 expired, when enabled (see :ref:`reg_timer1_config`)

The Caravel PicoRV32 implementation does not enable IRQ QREGS (see `PicoRV32 description <https://github.com/cliffordwolf/picorv32>`__).

The handling of interrupts is beyond the scope of this document
(see `RISC-V instruction set description <https://riscv.org/technical/specifications/>`_).
All interrupts are masked and must be enabled in software.
