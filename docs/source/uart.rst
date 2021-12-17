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

UART interface
==============

The UART is a standard 2-pin serial interface that can communicate with the most similar interfaces at a fixed baud rate.
Although the UART operates independently of the CPU, data transfers are blocking operations which will generate CPU wait states until the data transfer is completed.

Related pins
------------

* :ref:`SER_TX <ser_tx>` - F7,
* :ref:`SER_RX <ser_rx>` - E7.

UART control registers
----------------------

The behaviour of the UART can be modified by changing values in the registers described below.

.. _reg_uart_clkdiv:

``reg_uart_clkdiv``
~~~~~~~~~~~~~~~~~~~

Base address: ``0x20000000``

.. wavedrom::

     { "reg": [
         {"name": "UART clock divider", "bits": 32}]
     }

|

The entire 32bit word encodes the number of CPU core cycles to divide down to get the UART data bit rate (baud rate).
The default value is 1.

For example, if the external crystal is 12.5 MHz, then the core CPU clock runs at 100 MHz.
To get 9600 baud rate, you need to set::

    100 000 000 / 9600 = 10417 (0x28B1)

.. _reg_uart_data:

``reg_uart_data``
~~~~~~~~~~~~~~~~~

Base address: ``0x20000004``

.. wavedrom::

     { "reg": [
         {"name": "UART data", "bits": 8},
         {"name": "(unused, value is 0x0)", "type": 1, "bits": 24}]
     }

|

Writing a value to this register will immediately start a data transfer on the :ref:`SER_TX <ser_tx>` pin.
If the UART write operation is pending, then the CPU will be blocked with wait states until the transfer is complete before starting the new write operation.
This makes the UART transmit a relatively expensive operation on the CPU, but avoids the necessity of buffering data and checking for buffer overflow.

Reading a value from this register:

* returns ``255 (0xff)`` if no valid data byte is in the receive buffer (the whole register has value ``0xffffffff``), or
* returns the value of the received buffer otherwise, and
* clears the receive buffer for additional reads.

.. note:: There is no FIFO associated with the UART.

.. _reg_uart_enable:

``reg_uart_enable``
~~~~~~~~~~~~~~~~~~~

Base address: ``0x20000008``

.. wavedrom::

     { "reg": [
         {"name": "UART enable", "bits": 8},
         {"name": "(unused, value is 0x0)", "type": 1, "bits": 24}]
     }

|

The UART must be enabled to run (disabled by default).
