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

Counter-Timers
==============

The counter/timer is a general-purpose 32-bit adder and subtractor that can be configured for a variety of timing functions including one-shot counts, continuous timing and interval interrupts.
At a core clock rate of 80 MHz, the longest single time interval is 26.84 seconds.

Functionality
-------------

When enabled, the counter counts up or down from the value set in ``reg_timerX_value`` (X is replaced by 0 or 1) at the time the counter is enabled.
If counting up, the count continues until the counter reaches ``reg_timerX_data``.
If counting down, the count continues until the counter reaches zero.

In continuous mode, the counter resets to zero if counting up, and resets to the value in ``reg_timerX_data`` if counting down, and the count continues immediately.
If the interrupt is enabled, the counter will generate an interrupt on every cycle.

In one-shot mode, the counter triggers an interrupt (:doc:`IRQ channels 10 and 11 <irq>` for Timer 0 and 1, respectively), when it reaches the value of ``reg_timerX_data`` (up count) or zero (down count) and stops.

.. note::

    When the counter/timer is disabled, the ``reg_timerX_value`` remains unchanged, which puts the timer in a hold state.
    When reenabled, counting resumes.
    To reset the timer, write zero to the ``reg_timerX_value`` register.

Counter-Timer 0
---------------

The counter triggers an interrupt on IRQ channel 10.

.. _reg_timer0_config:

``reg_timer0_config``
~~~~~~~~~~~~~~~~~~~~~

Base address: ``0x22000000``

.. wavedrom::

     { "reg": [
         {"name": "Timer config", "bits": 8},
         {"name": "(undefined, reads zero)", "bits": 24, "type": 1}]
     }

.. list-table:: Timer 0 configuration bit definitions
    :name: reg_timer0_configuration_bit_definitions
    :header-rows: 1
    :widths: auto

    * - Bit
      - Name
      - Values
    * - 3
      - Counter/timer enable
      - 0 - counter/timer disabled

        1 - counter/timer enabled
    * - 2
      - One-shot mode
      - 0 - continuous mode

        1 - one-shot mode
    * - 1
      - Updown
      - 0 - count down

        1 - count up
    * - 0
      - Interrupt enable
      - 0 - interrupt disabled

        1 - interrupt enabled

.. _reg_timer0_value:

``reg_timer0_value``
~~~~~~~~~~~~~~~~~~~~

Base address: ``0x22000004``

.. wavedrom::

     { "reg": [
         {"name": "Timer value", "bits": 32}]
     }

|

The value in this register is the current value of the counter.
Value is 32 bits.
The register is read-write and can be used to reset the timer.

.. _reg_timer0_data:

``reg_timer0_data``
~~~~~~~~~~~~~~~~~~~~

Base address: ``0x22000008``

.. wavedrom::

     { "reg": [
         {"name": "Timer data", "bits": 32}]
     }

|

The value in this register is the reset value for the comparator.

Counter-Timer 1
---------------

The counter triggers an interrupt on IRQ channel 11.

.. _reg_timer1_config:

``reg_timer1_config``
~~~~~~~~~~~~~~~~~~~~~

Base address: ``0x23000000``

.. wavedrom::

     { "reg": [
         {"name": "Timer config", "bits": 8},
         {"name": "(undefined, reads zero)", "bits": 24, "type": 1}]
     }

.. list-table:: Timer 1 configuration bit definitions
    :name: reg_timer1_configuration_bit_definitions
    :header-rows: 1
    :widths: auto

    * - Bit
      - Name
      - Values
    * - 3
      - Counter/timer enable
      - 0 - counter/timer disabled

        1 - counter/timer enabled
    * - 2
      - One-shot mode
      - 0 - continuous mode

        1 - one-shot mode
    * - 1
      - Updown
      - 0 - count down

        1 - count up
    * - 0
      - Interrupt enable
      - 0 - interrupt disabled

        1 - interrupt enabled

.. _reg_timer1_value:

``reg_timer1_value``
~~~~~~~~~~~~~~~~~~~~

Base address: ``0x23000004``

.. wavedrom::

     { "reg": [
         {"name": "Timer value", "bits": 32}]
     }

|

The value in this register is the current value of the counter.
Value is 32 bits.
The register is read-write and can be used to reset the timer.

.. _reg_timer1_data:

``reg_timer1_data``
~~~~~~~~~~~~~~~~~~~~

Base address: ``0x23000008``

.. wavedrom::

     { "reg": [
         {"name": "Timer data", "bits": 32}]
     }

|

The value in this register is the reset value for the comparator.
