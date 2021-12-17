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

SPI Controller
==============

This section describes the SPI configuration registers.

Related pins
------------

- :ref:`SDI <sdi>` - E9,
- :ref:`CSB <csb>` - E8,
- :ref:`SCK <sck>` - F8,
- :ref:`SDO <sdo>` - F9.

.. _reg_spi_config:

``reg_spi_config``
------------------

Base address: ``0x24000000``

.. wavedrom::

     { "reg": [
         {"name": "prescaler", "bits": 8},
         {"bits": 1, "name": "MLB"},
         {"bits": 1, "name": "nCSB"},
         {"bits": 1, "name": "nSCK"},
         {"bits": 1, "name": "MOD"},
         {"bits": 1, "name": "STM"},
         {"bits": 1, "name": "IE"},
         {"bits": 1, "name": "INT"},
         {"bits": 1, "name": "HK"},
         {"name": "(undefined, reads zero)", "type": 1, "bits": 16}],
        "config": {"hspace": 1400}
     }


.. list-table:: Configuration bit definitions
    :name: spi_configuration_bit_definitions
    :header-rows: 1
    :widths: auto

    * - Bit
      - Name
      - Values
    * - 15
      - Housekeeping
      - 0 - SPI controller connected to external pins

        1 - SPI controller connected directly to housekeeping SPI
    * - 14
      - SPI interrupt enable
      - 0 - interrupt disabled

        1 - interrupt enabled ( :ref:`IRQ channel 9 <cpu_irq_channel_definitions>` )
    * - 13
      - SPI system enable
      - 0 - SPI disabled

        1 - SPI enabled
    * - 12
      - stream
      - 0 - apply/release :ref:`CSB <csb>` separately for each byte

        1 - apply :ref:`CSB <csb>` until stream bit is cleared (manually)
    * - 11
      - mode
      - 0 - read and change data on opposite :ref:`SCK <sck>` edges (default)

        1 - read and change data on the same :ref:`SCK <sck>` edges
    * - 10
      - invert :ref:`SCK <sck>`
      - 0 - normal :ref:`SCK <sck>` (default)

        1 - inverted :ref:`SCK <sck>`
    * - 9
      - invert :ref:`CSB <csb>`
      - 0 - normal :ref:`CSB <csb>` (low is active, default)

        1 - inverted :ref:`CSB <csb>` (high is active)
    * - 8
      - MLB
      - 0 - MSB first

        1 - LSB first
    * - 7-0
      - prescaler
      - count (in controller clock cycles) of 1/2 :ref:`SCK <sck>` cycle
        (default value 2). Clock rate formula:
        `SPI clock rate = 2 * core_clock / (prescaler + 1)`


.. note::

    All configuration bits other than the prescaler default to value zero.

.. _reg_spi_data:

``reg_spi_data``
----------------

Base address: ``0x24000004``

.. wavedrom::

     { "reg": [
         {"name": "SPI data", "bits": 8},
         {"name": "(undefined, reads zero)", "type": 1, "bits": 24}]
     }

|

The byte at ``0x24000004`` holds the SPI data (either read or write).

Reading to and writing from the SPI controller is simply a matter of setting the required values in the configuration register, and writing values to or reading from ``reg_spi_data``.
The protocol is similar to the UART.

A write operation will stall the CPU if an incomplete SPI transmission is still in progress.

Reading from the SPI will also stall the CPU if an incomplete SPI transmission is still in progress.
There is no FIFO buffer for data.
Therefore SPI reads and writes are relatively expensive operations that tie up the CPU, but will not lose or overwrite data.

.. note::

    There is no FIFO associated with the SPI controller.
