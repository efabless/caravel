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

General Purpose Input/Output
============================

The GPIO pin is a single assignable general-purpose digital input or output that is available only to the management SoC and cannot be assigned to the user project area.
On the test board provided with the completed user projects, this pin is used to enable the voltage regulators generating the user area power supplies.

The basic function of the GPIO is illustrated in :ref:`gpio_structure`.
All writes to :ref:`reg_gpio_data` are registered.
All reads from :ref:`reg_gpio_data` are immediate.

.. figure:: _static/gpio.svg
    :name: gpio_structure
    :alt: GPIO channel structure
    :align: center

    GPIO channel structure

Register descriptions
~~~~~~~~~~~~~~~~~~~~~

.. list-table:: GPIO memory address map
    :name: gpio_memory_address_map
    :header-rows: 1

    * - C header name
      - Address
      - Description
    * - :ref:`reg_gpio_data_in`
      - ``0xf0002810``
      - GPIO input (low bit)
    * - :ref:`reg_gpio_data_out`
      - ``0xf0002814``
      - GPIO output (low bit)
    * - :ref:`reg_gpio_ien`
      - ``0xf0002808``
      - GPIO input enable (`0 = input disable`, `1 = input enable`)
    * - :ref:`reg_gpio_oe`
      - ``0xf000280c``
      - GPIO output enable (`0 = output disable`, `1 = output enable`)
    * - :ref:`reg_gpio_mode1`
      - ``0xf0002800``
      - GPIO mode1 (`0 = dm[1:2] = 2b00`, `1 = dm[1:2] = 2b11`)
    * - :ref:`reg_gpio_mode0`
      - ``0xf0002804``
      - GPIO mode0 (`0 = dm[0] = 1b0`, `1 = dm[0] = 1b1`)

.. note::

    In the registers description below, each register is shown as 32 bits corresponding
    to the data bus width of the wishbone bus. Depending on the instruction and data type,
    the entire 32-bit register can be read in one instruction, or one 16-bit word,
    or one 8-bit byte.

.. _reg_gpio_data_in:

``reg_gpio_data_in``
-----------------

Base address: ``0xf0002810``

.. wavedrom::

     { "reg": [
         {"name": "GPIO input readback", "bits": 1}]
     }

|

* Writing to the address low bit always sets the registered value at the GPIO.
* Writing to address bit 16 has no effect.
* Reading from the address low bit reads the value at the chip pin.
* Reading from address bit 16 reads the value at the multiplexer output (see :ref:`gpio_structure`).

.. _reg_gpio_data_out:

``reg_gpio_data_out``
-----------------

Base address: ``0xf0002814``

.. wavedrom::

     { "reg": [
         {"name": "GPIO output", "bits": 1}]
     }

|

* Writing to the address low bit always sets the registered value at the GPIO.

.. _reg_gpio_ien:

``reg_gpio_ien``
----------------

Base address: ``0xf0002808``

.. wavedrom::

     { "reg": [
         {"name": "GPIO input enable", "bits": 1},
         ]
     }

|

* Writing 1 to this register enable using the GPIO pin as input.

.. _reg_gpio_oe:

``reg_gpio_oe``
----------------

Base address: ``0xf000280c``

.. wavedrom::

     { "reg": [
         {"name": "GPIO output enable", "bits": 1},
         ]
     }
|

* Writing 1 to this register enable using the GPIO pin as output.


.. _reg_gpio_mode1:

``reg_gpio_mode1``
---------------

Base address: ``0x21000008``

.. wavedrom::

     { "reg": [
         {"name": "GPIO mode1 enable", "bits": 1},
     }

|

* writing 1 to this register write managment GPIO dm[1:2] = 2'd11 
* writing 0 to this register write managment GPIO dm[1:2] = 2'd0 


.. _reg_gpio_mode0:

``reg_gpio_mode0``
---------------

Base address: ``0xf0002804``

.. wavedrom::

     { "reg": [
         {"name": "GPIO mode0 enable", "bits": 1},
     }

|

* writing 1 to this register write managment GPIO dm[0] = 1'd1
* writing 0 to this register write managment GPIO dm[0] = 1'd0 

.. note::

To set managment gpio in input pull-up or pull-down state. following conditions should be satisfied 
*  ``reg_gpio_mode0`` or ``reg_gpio_mode1`` == 1 
*  ``reg_gpio_oe`` == 1 
*  ``reg_gpio_ien`` == 1 
* To use pull-up  ``reg_gpio_data_out`` == 1
* To use pull-down  ``reg_gpio_data_out`` == 0

User project area GPIO
~~~~~~~~~~~~~~~~~~~~~~

.. todo::

    This section is based on Memory mapped I/O summary by address from PDF documentation.
    It needs some elaboration.

.. _reg_mprj_io_configure:

User project area GPIO ``mprj_io[37:0]`` configure registers
------------------------------------------------------------

Each of 38 ``mprj_io`` GPIOs has a configuration register.

.. csv-table:: Base addresses for ``mprj_io`` configuration registers
    :name: reg_mprj_io_configure_addresses
    :widths: auto
    :header-rows: 1
    :delim: ;

    User project area GPIO ; Address

    ``mprj_io[00]`` ; ``0x2600000c``
    ``mprj_io[01]`` ; ``0x26000010``
    ``mprj_io[02]`` ; ``0x26000014``
    ``mprj_io[03]`` ; ``0x26000018``
    ``mprj_io[04]`` ; ``0x2600001c``
    ``mprj_io[05]`` ; ``0x26000020``
    ``mprj_io[06]`` ; ``0x26000024``
    ``mprj_io[07]`` ; ``0x26000028``
    ``mprj_io[08]`` ; ``0x2600002c``
    ``mprj_io[09]`` ; ``0x26000030``
    ``mprj_io[10]`` ; ``0x26000034``
    ``mprj_io[11]`` ; ``0x26000038``
    ``mprj_io[12]`` ; ``0x2600003c``
    ``mprj_io[13]`` ; ``0x26000040``
    ``mprj_io[14]`` ; ``0x26000044``
    ``mprj_io[15]`` ; ``0x26000048``
    ``mprj_io[16]`` ; ``0x2600004c``
    ``mprj_io[17]`` ; ``0x26000050``
    ``mprj_io[18]`` ; ``0x26000054``
    ``mprj_io[19]`` ; ``0x26000058``
    ``mprj_io[20]`` ; ``0x2600005c``
    ``mprj_io[21]`` ; ``0x26000060``
    ``mprj_io[22]`` ; ``0x26000064``
    ``mprj_io[23]`` ; ``0x26000068``
    ``mprj_io[24]`` ; ``0x2600006c``
    ``mprj_io[25]`` ; ``0x26000070``
    ``mprj_io[26]`` ; ``0x26000074``
    ``mprj_io[27]`` ; ``0x26000078``
    ``mprj_io[28]`` ; ``0x2600007c``
    ``mprj_io[29]`` ; ``0x26000080``
    ``mprj_io[30]`` ; ``0x26000084``
    ``mprj_io[31]`` ; ``0x26000088``
    ``mprj_io[32]`` ; ``0x2600008c``
    ``mprj_io[33]`` ; ``0x26000090``
    ``mprj_io[34]`` ; ``0x26000094``
    ``mprj_io[35]`` ; ``0x26000098``
    ``mprj_io[36]`` ; ``0x2600009c``
    ``mprj_io[37]`` ; ``0x260000a0``

.. wavedrom::

     { "reg": [
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"bits": 1, "type": 2},
         {"name": "mode", "bits": 3, "type": 1},
         {"bits": 19, "type": 1}]
     }

|

.. todo:: Missing default values

.. todo:: Missing setting descriptions

.. list-table:: ``mprj_io[i]`` control register descriptions
    :name: reg_mprj_io_configure_description
    :header-rows: 1
    :widths: auto

    * - Mask bit
      - Default
      - Description
    * - 10-12
      - ``001``
      - Digital mode
    * - 9
      - TODO
      - input voltage trip point select
    * - 8
      - 0
      - slow slew (0 - fast slew, 1 - slow slew)
    * - 7
      - TODO
      - analog bus polarity
    * - 6
      - TODO
      - analog bus select
    * - 5
      - TODO
      - analog bus enable (0 - disabled, 1 - enabled)
    * - 4
      - TODO
      - IB mode select
    * - 3
      - 0
      - input disable (0 - input enabled, 1 - input disabled)
    * - 2
      - 0
      - hold override value (value is the value during hold mode)
    * - 1
      - 1
      - output disable (0 - output enabled, 1 - output disabled)
    * - 0
      - 1
      - management control enable (0 - user control, 1 - management control)

.. todo:: Missing *digital mode* description
