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

QSPI Flash interface
====================

Related pins
------------

* :ref:`flash_io[1:0] <flash_io>` - D9 and D10, respectively,
* :ref:`flash_csb <flash_csb>` - C10,
* :ref:`flash_clk <flash_clk>` - D8.

Description
-----------

The QSPI flash controller is automatically enabled on power-up, and will
immediately initiate a read sequence in single-bit mode
with pin :ref:`flash_io0 <flash_io>` acting as ``SDI`` (data from flash to CPU)
and pin :ref:`flash_io1 <flash_io>` acting as ``SDO`` (data from CPU to flash).
Protocol is according to, e.g., `Cypress S25FL256L <https://www.cypress.com/file/316171/download>`_.

The initial SPI instruction sequence is :ref:`as follows: <initial_spi_instruction_sequence>`.

.. list-table:: Initial SPI instruction sequence
    :name: initial_spi_instruction_sequence
    :widths: auto

    * - ``0xFF``
      - Mode bit reset
    * - ``0xAB``
      - Release from deep power-down
    * - ``0x03``
      - Read w/3 byte address
    * - ``0x00``
      - Program start address (``0x10000000``) (3 bytes) (upper byte is ignored)
    * - ``0x00``
      -
    * - ``0x00``
      -

The QSPI flash continues to read bytes, either sequentially on the same command,
or issuing a new read command to read from a new address.

.. _reg_spictrl:

``reg_spictrl``
---------------
**QSPI control register**

The behaviour of the QSPI flash controller can be modified by changing values in the register below:

Base address: ``0x2d000000``

.. wavedrom::

     { "reg": [
         {"name": "FLASH_IO[3:0]", "bits": 4},
         {"name": "CLK", "bits": 1},
         {"name": "CSB", "bits": 1},
         {"bits": 2, "type": 1},
         {"name": "OE_FLASH_IO [3:0]", "bits": 4},
         {"bits": 4, "type": 1},
         {"name": "DUMMY CLK COUNT", "bits": 4},
         {"name": "ACCESS MODE", "bits": 3},
         {"bits": 8, "type": 1},
         {"name": "EN", "bits": 1}],
       "config": {"hspace": 1400}
   }

.. list-table:: ``reg_spictrl`` register description
    :name: reg_spictrl_description
    :header-rows: 1
    :widths: auto

    * - Mask bit
      - Default
      - Description
    * - 31
      - 1
      - QSPI flash interface enable
    * - 22-20
      - 0
      - Access mode *(including DDR enable, QSPI enable, CRM enable)* (see :ref:`reg_spictrl_access_mode_values`)
    * - 19-16
      - 8
      - Dummy clock cycle count / Read latency cycles
    * - 11-8
      - 0
      - Bit-bang ``OE_FLASH_IO[3:0]`` I/O output enable
    * - 5
      - 0
      - Bit-bang ``FLASH_CSB`` chip select bit
    * - 4
      - 0
      - Bit-bang ``FLASH_CLK`` serial clock line
    * - 3-0
      - 0
      - Bit-bang ``FLASH_IO[3:0]`` data bits

QSPI access modes
-----------------

.. list-table:: ``reg_spictrl`` Access mode bit values
    :name: reg_spictrl_access_mode_values
    :widths: auto

    * - 0
      - ``000``
      - Single bit per clock
    * - 1
      - ``001``
      - Single bit per clock (same as 0)

All additional modes (QSPI dual and quad modes) cannot be used,
as the management SoC only has pins for data lines 0 and 1.

The SPI flash can be accessed by bit banging when the enable is off.
To do this from the CPU, the entire routine to access the SPI flash
must be read into SRAM and executed from the SRAM.

.. note::

    To sum up, the DDR enable, QSPI enable and CRM enable bits cannot be used due to the limited number of data pins.
