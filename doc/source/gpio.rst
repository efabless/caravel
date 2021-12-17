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
    * - :ref:`reg_gpio_data`
      - ``0x21000000``
      - GPIO input/output (low bit)

        GPIO output readback (16th bit)
    * - :ref:`reg_gpio_ena`
      - ``0x21000004``
      - GPIO output enable (`0 = output`, `1 = input`)
    * - :ref:`reg_gpio_pu`
      - ``0x21000008``
      - GPIO pullup enable (`0 = none`, `1 = pullup`)
    * - :ref:`reg_gpio_pd`
      - ``0x2100000c``
      - GPIO pulldown enable (`0 = none`, `1 = pulldown`)
    * - :ref:`reg_pll_out_dest`
      - ``0x2f000000``
      - PLL clock output destination (low bit)
    * - :ref:`reg_trap_out_dest`
      - ``0x2f000004``
      - Trap output destination (low bit)
    * - :ref:`reg_irq7_source`
      - ``0x2f000008``
      - IRQ 7 input source (low bit)

.. note::

    In the registers description below, each register is shown as 32 bits corresponding
    to the data bus width of the wishbone bus. Depending on the instruction and data type,
    the entire 32-bit register can be read in one instruction, or one 16-bit word,
    or one 8-bit byte.

.. _reg_gpio_data:

``reg_gpio_data``
-----------------

Base address: ``0x21000000``

.. wavedrom::

     { "reg": [
         {"name": "GPIO input/output", "bits": 16},
         {"name": "GPIO output readback", "bits": 16}]
     }

|

* Writing to the address low bit always sets the registered value at the GPIO.
* Writing to address bit 16 has no effect.
* Reading from the address low bit reads the value at the chip pin.
* Reading from address bit 16 reads the value at the multiplexer output (see :ref:`gpio_structure`).

.. _reg_gpio_ena:

``reg_gpio_ena``
----------------

Base address: ``0x21000004``

.. wavedrom::

     { "reg": [
         {"name": "GPIO output enable", "bits": 16},
         {"name": "(undefined, reads zero)", "bits": 16, "type": 1}]
     }

|

* Bit 0 corresponds to the GPIO channel enable.
* Bit value 1 indicates an output channel; 0 indicates an input.

.. _reg_gpio_pu:

``reg_gpio_pu``
---------------

Base address: ``0x21000008``

.. wavedrom::

     { "reg": [
         {"name": "GPIO pin pull-up", "bits": 16},
         {"name": "(undefined, reads zero)", "bits": 16, "type": 1}]
     }

|

* Bit 0 corresponds to the GPIO channel pull-up state.
* Bit value 1 indicates pullup is active; 0 indicates pullup is inactive.

.. _reg_gpio_pd:

``reg_gpio_pd``
---------------

Base address: ``0x2100000c``

.. wavedrom::

     { "reg": [
         {"name": "GPIO pin pull-down (inverted)", "bits": 16},
         {"name": "(undefined, reads zero)", "bits": 16, "type": 1}]
     }

|

.. todo:: The statement below (second sentence) seems to be invalid.

* Bit 0 corresponds to the GPIO channel pull-down state.
* Bit value 1 indicates pullup is active; 0 indicates pulldown is inactive.

.. _reg_pll_out_dest:

``reg_pll_out_dest``
--------------------

Base address: ``0x2f000000``

.. wavedrom::

     { "reg": [
         {"name": "PLL clock dest.", "bits": 8},
         {"name": "(undefined, reads zero)", "bits": 24, "type": 1}]
     }

|

The PLL clock (crystal oscillator clock multiplied up by PLL) can be viewed on the GPIO pin.
The GPIO pin cannot be used as general-purpose I/O when selected for PLL clock output.

The low bit of this register directs the output of the core clock to the GPIO channel, according to the :ref:`reg_pll_out_dest_table`.

.. list-table:: ``reg_pll_out_dest`` register settings
    :name: reg_pll_out_dest_table
    :header-rows: 1

    * - ``0x2f000000`` value
      - Clock output directed to this channel
    * - ``0``
      - (none)
    * - ``1``
      - Core PLL clock to GPIO output

.. note::

    High rate core clock (e.g. 80MHz) may be unable to generate a full swing on the GPIO output, but is detectable.

.. _reg_trap_out_dest:

``reg_trap_out_dest``
---------------------

Base address: ``0x2f000004``

.. wavedrom::

     { "reg": [
         {"name": "trap signal dest.", "bits": 8},
         {"name": "(undefined, reads zero)", "bits": 24, "type": 1}]
     }

|

The CPU fault state (trap) can be viewed at the GPIO pin as a way to monitor the CPU trap state externally.
The low bit of this register directs the output of the processor trap signal to the GPIO channel, according to the :ref:`reg_trap_out_dest_table`.


.. list-table:: ``reg_trap_out_dest`` register settings
    :name: reg_trap_out_dest_table
    :header-rows: 1

    * - ``0x2f000004`` value
      - Trap signal output directed to this channel
    * - ``0``
      - (none)
    * - ``1``
      - GPIO

.. _reg_irq7_source:

``reg_irq7_source``
-------------------

Base address: ``0x2f000008``

.. wavedrom::

     { "reg": [
         {"name": "IRQ 7 source", "bits": 8},
         {"name": "(undefined, reads zero)", "bits": 24, "type": 1}]
     }

|

The GPIO input can be used as an IRQ event source and passed to the CPU through IRQ channel 7 (see :doc:`irq`).
When used as an IRQ source, the GPIO pin must be configured as an input.
The low bit of this register directs the input of the GPIO to the processor's IRQ7 channel, according to the :ref:`reg_irq7_source_table`.


.. list-table:: ``reg_irq7_source`` register settings
    :name: reg_irq7_source_table
    :header-rows: 1

    * - Register byte
      - ``0x2f000008`` value
      - This channel directed to IRQ channel 7
    * - 0
      - ``00``
      - (none)
    * - 1
      - ``01``
      - GPIO

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
