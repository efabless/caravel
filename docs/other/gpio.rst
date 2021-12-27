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

=============
Caravel GPIO
=============

The Caravel GPIO pins are multi-purpose pins capable of being configured
for numerous applications, including digital input, output, analog
signaling, with slew rate control, transition level control, and weak
pull-up and pull-down functions.

The GPIO pins are configured to operate either under the control of the
Caravel management SoC or under the control of the user project.  When
used under management SoC control, certain pins have certain special
functions.

--------------------------------------------------------------------------

- Register name = ``reg_mprj_io_0``
- Memory location = ``0x26000024``
- Housekeeping SPI location = ``0x1d, 0x1e`` 

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x1e |analog |analog |analog | mode  |input  | hold  | output| mgmt  |
|      |polar. |select |enable | select|disable| over  | enb   | enable|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |  15   |  14   |  13   |  12   |  11   |  10   |   9   |   8   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x1d |       |       |       |digital|digital|digital| trip  | slow  |
|      |       |       |       |mode 0 |mode 1 |mode 2 | point | slew  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  Management enable (bit field ``MGMT_ENABLE``)
    - value 0 = User project controls the GPIO pin
    - value 1 = Management SoC controls the GPIO pin

*bit 1*:  Output enable bar (output disable) (bit field ``OUTPUT_DISABLE``)
    - value 0 = Pad enabled for digital output
    - value 1 = Pad disabled for digital output

*bit 2*:  Holdover (bit field ``HOLD_OVERRIDE``)
    - value 0 = all I/O latched during hold mode
    - value 1 = only inputs latched during hold mode
  
    **NOTE:**  
    
        The GPIO cannot be placed in hold mode in this version of Caravel.

*bit 3*:  Input disable (bit field ``INPUT_DISABLE``)
    - value 0 = Pin enabled for digital input
    - value 1 = Pin disabled for digital input

*bit 4*:  Input buffer Mode select (bit field ``MODE_SELECT``)
    - value 0 =  CMOS/LVTTL mode (see trip point value, below)
    - value 1 =  Input buffer compliant with 1.8V external signals ``VIL = 0.54V``; ``VIH = 1.26V``.  Overrides the trip point setting.

*bit 5*:  Analog enable (bit field ``ANALOG_ENABLE``)
    - value 0 =	analog busses disconnected
    - value 1 =	analog busses connected

    The analog function is intended for a type of switched-capacitor operation on the inputs.  Its use is limited in Caravel.

*bits 6-7*:  Analog select and polarity (bit field ``ANALOG_SELECT`` | ``ANALOG_POLARITY``)
    - (value    = ``{out, bit[7], bit[6], out}`` in the list below)
    - value 000 =	connect pad to VSSIO
    - value 001 =	connect pad to analog A bus
    - value 010 =	connect pad to VSSIO
    - value 011 =	connect pad to analog B bus
    - value 100 =	connect pad to analog A bus
    - value 101 =	connect pad to VDDIO
    - value 110 =	connect pad to analog B bus
    - value 111 =	connect pad to VDDIO

*bit 8*:  Slow slew (bit field ``SLOW_SLEW_MODE``)
    - value 0 = Fast output slew rate
    - value 1 = Slow output slew rate

*bit 9*:  Trip point (bit field ``TRIPPOINT_SEL``)
    - value 0 = CMOS (VIL = 0.3 * VDDIO; VIH = 0.7 * VDDIO)
    - value 1 = LVTTL (VIL = 0.8V; VIH = 2.0V)

    The value determines what input voltage is converted to a
    0 or 1 bit by the input buffer.  Value 0 is appropriate
    for CMOS operation;  value 1 is appropriate for ``LVTTL``
    operation.  When the VDDIO power supply is less than ``2.7V``,
    then the trip point is always in CMOS mode.  See also
    the input buffer mode select, above.

*bits 10-12*:  Digital mode (bit field ``DIGITAL_MODE_MASK``)
    - (value = ``{bit[12], bit[11], bit[10]}`` in the list below)
    - value 000 = analog mode 
    - value 001 = analog mode
    - value 010 = digital input, 5kohm pull-up
    - value 011 = digital input, 5kohm pull-up
    - value 100 = open drain to power
    - value 101 = open drain to ground
    - value 110 = digital output
    - value 111 = digital output (weak)

*The remaining I/O configuration registers have the same form as above.*

The memory mapped addresses are as follows:
-------------------------------------------

- Register name = ``reg_mprj_io_1``,  Memory location = ``0x26000028``,  Housekeeping SPI location = ``0x1f, 0x20``

- Register name = ``reg_mprj_io_2``, Memory location = ``0x2600002c``, Housekeeping SPI location = ``0x21, 0x22``

- Register name = ``reg_mprj_io_3``, Memory location = ``0x26000030``, Housekeeping SPI location = ``0x23, 0x24``

- Register name = ``reg_mprj_io_4``, Memory location = ``0x26000034``, Housekeeping SPI location = ``0x25, 0x26``

- Register name = ``reg_mprj_io_5``, Memory location = ``0x26000038``, Housekeeping SPI location = ``0x27, 0x28``

- Register name = ``reg_mprj_io_6``, Memory location = ``0x2600003c``, Housekeeping SPI location = ``0x29, 0x2a``

- Register name = ``reg_mprj_io_7``, Memory location = ``0x26000040``, Housekeeping SPI location = ``0x2b, 0x2c``

- Register name = ``reg_mprj_io_8``, Memory location = ``0x26000044``, Housekeeping SPI location = ``0x2d, 0x2e``

- Register name = ``reg_mprj_io_9``, Memory location = ``0x26000048``, Housekeeping SPI location = ``0x2f, 0x30``

- Register name = ``reg_mprj_io_10``, Memory location = ``0x2600004c``, Housekeeping SPI location = ``0x31, 0x32``

- Register name = ``reg_mprj_io_11``, Memory location = ``0x26000050``, Housekeeping SPI location = ``0x33, 0x34``

- Register name = ``reg_mprj_io_12``, Memory location = ``0x26000054``, Housekeeping SPI location = ``0x35, 0x36``

- Register name = ``reg_mprj_io_13``, Memory location = ``0x26000058``, Housekeeping SPI location = ``0x37, 0x38``

- Register name = ``reg_mprj_io_14``, Memory location = ``0x2600005c``, Housekeeping SPI location = ``0x39, 0x3a``

- Register name = ``reg_mprj_io_15``, Memory location = ``0x26000060``, Housekeeping SPI location = ``0x3b, 0x3c``

- Register name = ``reg_mprj_io_16``, Memory location = ``0x26000064``, Housekeeping SPI location = ``0x3d, 0x3e``

- Register name = ``reg_mprj_io_17``, Memory location = ``0x26000068``, Housekeeping SPI location = ``0x3f, 0x40``

- Register name = ``reg_mprj_io_18``, Memory location = ``0x2600006c``, Housekeeping SPI location = ``0x41, 0x42``

- Register name = ``reg_mprj_io_19``, Memory location = ``0x26000070``, Housekeeping SPI location = ``0x43, 0x44``

- Register name = ``reg_mprj_io_20``, Memory location = ``0x26000074``, Housekeeping SPI location = ``0x45, 0x46``

- Register name = ``reg_mprj_io_21``, Memory location = ``0x26000078``, Housekeeping SPI location = ``0x47, 0x48``

- Register name = ``reg_mprj_io_22``, Memory location = ``0x2600007c``, Housekeeping SPI location = ``0x49, 0x4a``

- Register name = ``reg_mprj_io_23``, Memory location = ``0x26000080``, Housekeeping SPI location = ``0x4b, 0x4c``

- Register name = ``reg_mprj_io_24``, Memory location = ``0x26000084``, Housekeeping SPI location = ``0x4d, 0x4e``

- Register name = ``reg_mprj_io_25``, Memory location = ``0x26000088``, Housekeeping SPI location = ``0x4f, 0x50``

- Register name = ``reg_mprj_io_26``, Memory location = ``0x2600008c``, Housekeeping SPI location = ``0x51, 0x52``

- Register name = ``reg_mprj_io_27``, Memory location = ``0x26000090``, Housekeeping SPI location = ``0x53, 0x54``

- Register name = ``reg_mprj_io_28``, Memory location = ``0x26000094``, Housekeeping SPI location = ``0x55, 0x56``

- Register name = ``reg_mprj_io_29``, Memory location = ``0x26000098``, Housekeeping SPI location = ``0x57, 0x58``

- Register name = ``reg_mprj_io_30``, Memory location = ``0x2600009c``, Housekeeping SPI location = ``0x59, 0x5a``

- Register name = ``reg_mprj_io_31``, Memory location = ``0x260000a0``, Housekeeping SPI location = ``0x5b, 0x5c``

- Register name = ``reg_mprj_io_32``, Memory location = ``0x260000a4``, Housekeeping SPI location = ``0x5d, 0x5e``

- Register name = ``reg_mprj_io_33``, Memory location = ``0x260000a8``, Housekeeping SPI location = ``0x5f, 0x60``

- Register name = ``reg_mprj_io_34``, Memory location = ``0x260000ac``, Housekeeping SPI location = ``0x61, 0x62``

- Register name = ``reg_mprj_io_35``, Memory location = ``0x260000b0``, Housekeeping SPI location = ``0x63, 0x64``

- Register name = ``reg_mprj_io_36``, Memory location = ``0x260000b4``, Housekeeping SPI location = ``0x65, 0x66``

- Register name = ``reg_mprj_io_37``, Memory location = ``0x260000b8``, Housekeeping SPI location = ``0x67, 0x68``

The bit value of the 13-bit static configuration GPIO setting is difficult
to remember, so the "defs.h" file (included when compiling a C program for
the management SoC) contains some definitions for typical useful configuration
values, **as follows**:

.. code:: bash

   #define GPIO_MODE_MGMT_STD_INPUT_NOPULL    0x0403
   #define GPIO_MODE_MGMT_STD_INPUT_PULLDOWN  0x0803
   #define GPIO_MODE_MGMT_STD_INPUT_PULLUP    0x0c03
   #define GPIO_MODE_MGMT_STD_OUTPUT          0x1809
   #define GPIO_MODE_MGMT_STD_BIDIRECTIONAL   0x1801
   #define GPIO_MODE_MGMT_STD_ANALOG          0x000b

   #define GPIO_MODE_USER_STD_INPUT_NOPULL    0x0402
   #define GPIO_MODE_USER_STD_INPUT_PULLDOWN  0x0802
   #define GPIO_MODE_USER_STD_INPUT_PULLUP    0x0c02
   #define GPIO_MODE_USER_STD_OUTPUT          0x1808
   #define GPIO_MODE_USER_STD_BIDIRECTIONAL   0x1800
   #define GPIO_MODE_USER_STD_OUT_MONITORED   0x1802
   #define GPIO_MODE_USER_STD_ANALOG          0x000a

**Defintion**:

    ``GPIO_MODE_MGMT_STD_INPUT_NOPULL``:
        Management controls the GPIO pin.
        Pin is configured as a digital input, no pull-up or pull-down.

    ``GPIO_MODE_MGMT_STD_INPUT_PULLDOWN``:
        Management controls the GPIO pin.
        Pin is configured as a digital input with a weak (5k) pull-down.

    ``GPIO_MODE_MGMT_STD_INPUT_PULLUP``:
        Management controls the GPIO pin.
        Pin is configured as a digital input with a weak (5k) pull-up.

    ``GPIO_MODE_MGMT_STD_OUTPUT``:
        Management controls the GPIO pin.
        Pin is configured as a digital output (output only).

    ``GPIO_MODE_MGMT_STD_BIDIRECTIONAL``:
        Management controls the GPIO pin.
        Pin is configured as a digital input or output.  The direct
        control of the GPIO from the management SoC does not include
        bidirectional control, and this should only be set for those
        special functions that use bidirectional or tristatable pins
        (flash QSPI data pins, housekeeping SDO, SPI master SDO, and
        the debug pin).

    ``GPIO_MODE_MGMT_STD_ANALOG``:
        Digital input and output buffers are disabled.  The pin has no
        function for the management SoC.
        
    ``GPIO_MODE_USER_STD_INPUT_NOPULL``:
        The user project controls the GPIO pin.
        Pin is configured as a digital input, no pull-up or pull-down.

    ``GPIO_MODE_USER_STD_INPUT_PULLDOWN``:
        The user project controls the GPIO pin.
        Pin is configured as a digital input with a weak (5k) pull-down.

    ``GPIO_MODE_USER_STD_INPUT_PULLUP``:
        The user project controls the GPIO pin.
        Pin is configured as a digital input with a weak (5k) pull-up.

    ``GPIO_MODE_USER_STD_OUTPUT``:
        The user project controls the GPIO pin.
        Pin is configured as a digital output (output only).

    ``GPIO_MODE_USER_STD_BIDIRECTIONAL``:
        The user project controls the GPIO pin.
        Pin is configured as a digital input or output.  The input
        (io_in) is always active.  The output (io_out) is applied to
        the pad only if the corresponding output disable (io_oeb) is
        set to zero.

    ``GPIO_MODE_USER_STD_OUT_MONITORED``:
        The user project controls the GPIO pin like
        the ``GPIO_MODE_USER_STD_BIDIRECTIONAL`` mode, above;  however,
        the pad value also appears at the management SoC, so the
        management SoC can treat this pad as an input pin, monitoring
        the value seen by the user project.

    ``GPIO_MODE_USER_STD_ANALOG``:
        The user project controls the GPIO pin.
        Digital input and output buffers are disabled.  If the
        corresponding analog_io pin is connected to an analog signal
        in the user project, then that signal (unbuffered) appears on
        the pad.

--------------------------------------------------------------------------

- Register name = ``reg_mprj_xfer``
- Memory location = ``0x26000000``
- Housekeeping SPI location = ``0x13``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x13 |       | data  | data  | clock | load  | resetn| enable| xfer/ |
|      |       |  2    |  1    |       |       |       |       | busy  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  xfer / busy

**On reading this bit:**

- value 0 = The serial transfer is idle
- value 1 = The serial transfer is in progress

**On writing this bit:**

- value 0 = No action (the default state)
- value 1 = Initiate a serial transfer of GPIO configuration data from the housekeeping registers to the GPIOs.

*bit 1*:  Serial bit-bang enable:

- value 0 = Serial transfer is done by the "xfer" bit.
- value 1 = Serial transfer is done by bit banging.

*bit 2*:  Serial bit-bang reset bar:

- value 0 = Reset all GPIO to their default values
- value 1 = No action (the default state)

*(See also the page on setting the default GPIO configuration.)*

*bit 3*:  Serial bit-bang load:

- value 0 = No action (the default state)
- value 1 = Simultaneously copy all GPIO configuration data from the shift register to the GPIOs.

*bit 4*:  Serial bit-bang clock:

- value 0 = No action (the default state)
- value 1 = Advance data in the serial shift registers by 1 bit

*bit 5*:  Serial bit-bang data 1:

value = GPIO configuration for the left side to be shifted on next clock.

*bit 6*:  Serial bit-bang data 2:

value = GPIO configuration for the right side to be shifted on next clock.

The GPIO pins are configured through a serial chain that allows the
static configuration setting of each GPIO to be registered close to the
pad and avoid wiring every configuration bit of every pad back to the
management area.  The configuration held near the pad is a copy of the
configuration held in the memory mapped registers.  The value in the
memory mapped register can be considered a "staging area" value.  The
GPIO function will not update until the values are transferred from the
housekeeping registers to the GPIO pad.  The function that does this is
the "transfer" bit in this register.  The remaining values allow the
serial programming to be done manually by "bit banging".  The bit
bang functions should be considered diagnostic only.

In normal (not bit-bang) mode, the "xfer" bit needs to be set to one to
initiate a transfer of data from the memory mapped registers in the
housekeeping module to the GPIOs.  The "xfer" bit is self-resetting back
to zero.  The value of this bit cannot be read directly.  When reading
back this register, the bit 0 position contains the "busy" state of the
serial transfer.  This allows the control program for the management SoC
to know when the GPIO pins have been properly configured.  The "busy" bit
will be set back to zero after the serial load has occurred.

In "bit-bang" mode, the register is used to directly control the
operation of the serial load instead of the automatic load initiated
by the "xfer" bit.  "bit-bang" mode is considered diagnostic, and should
not need to be used.  For completeness, its operation is described below:

There are two serial shift registers, one on the left side of the chip
running from ``mprj_io[37]`` to ``mprj_io[19]``, and the other on the right side
of the chip running from ``mprj_io[0]`` to ``mprj_io[18]``.  There are 13 bits
per GPIO according to the configuration registers (see above), applied
consecutively and in reverse.  So the first value applied to data 2 is
``mprj_io[18]`` configuration bit 12, and the the last value is ``mprj_io[0]``
configuration bit 0, with ``19 * 13 = 247 bits total``.  After applying each
data bit, toggle the clock.  At the end of 247 clocks, the load bit is
toggled to transfer the data from the shift register to the GPIOs.

General-purpose I/O standard operation:
----------------------------------------

When a GPIO is configured for management control, and the management SoC
is not using that pin for a special function (see special functions,
below), the GPIO pin may be used for bit-wise read and write operations.

The two registers reg_mprj_datal (32 bits) and reg_mprj_datah (6 bits)
together comprise the data registers for direct readback and control of
the GPIO pad values to and from the management SoC.  Unlike the static
configuration setting, these values are connected directly to the GPIOs
and update when written.

Note that the registers reg_mprj_datal and reg_mprj_datah are effectively
write-only.  Reading from these addresses reads the bit value of the GPIO
pad, not the value stored in the register.  There is no method implemented
to read back the value written to these registers.

--------------------------------------------------------------------------

- Register name = reg_mprj_datal
- Memory location = 0x2600000c
- Housekeeping SPI location = 0x6a to 0x6d

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x6d | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  |
|      |  7    |  6    |  5    |  4    |  3    |  2    |  1    |  0    |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   15  |   14  |   13  |   12  |   11  |   10  |   9   |   8   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x6c | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  |
|      |  15   |  14   |  13   |  12   |  11   |  10   |  9    |  8    |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   23  |   22  |   21  |   20  |   19  |   18  |   17  |   16  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x6b | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  |
|      |  23   |  22   |  21   |  20   |  19   |  18   |  17   |  16   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   31  |   30  |   29  |   28  |   27  |   26  |   25  |   24  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x6a | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  |
|      |  31   |  30   |  29   |  28   |  27   |  26   |  25   |  24   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

--------------------------------------------------------------------------

- Register name = reg_mprj_datah
- Memory location = 0x26000010
- Housekeeping SPI location = 0x69

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x69 |       |       | gpio  | gpio  | gpio  | gpio  | gpio  | gpio  |
|      |       |       |  37   |  36   |  35   |  34   |  33   |  32   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

**IMPORTANT NOTE:**  

    When writing to the GPIO data from the housekeeping
    SPI, all writes are done byte-wise.  When writing GPIO data from the
    management SoC, the lower word (GPIO 0 to 31) is written simultaneously,
    and the upper word (GPIO 32 to 37) is written simultaneously.  There is
    no option at this time to update all 38 GPIO outputs at the same time.
    In particular, note that an 8-bit or 16-bit write to the register from
    the management SoC that does not include the upper byte will *not*
    update, but will save the written value to a temporary register that
    will be applied when the upper byte is written.  Therefore it is
    recommended to always make 32-bit writes to the ``reg_mprj_datal`` register
    to avoid unexpected behavior.  8-, 16-, and 32-bit reads on this register
    will work as expected.

GPIO under user project control
---------------------------------------------------

When used by the user project, every GPIO is a simple bidirectional digital
pad.  The GPIO is configured by the serial transfer method above to behave
as required by the user project.  Once configured to user control, the GPIO
can be controlled by three pins:

- io_in[37:0]
- io_out[37:0]
- io_oeb[37:0]

The io_in[..] signals are from the pad to the user project and are always
active unless the pad has been configured with the "input disable" bit set.

The io_out[..] signals are from the user project to the pad.

The io_oeb[..] signals are from the user project to the pad cell.  This
controls the direction of the pad when in bidirectional mode.  When set to
value zero, the pad direction is output and the value of io_out[..] appears
on the pad.  When set to value one, the pad direction is input and the pad
output buffer is disabled.

The exact behavior of these signals depends on the static configuration of
the corresponding GPIO pad.  See the predefined user mode definitions,
above.

Dedicated GPIO functions used by the management SoC
---------------------------------------------------

The housekeeping module defines specific GPIOs to be used for special
functions when those GPIOs are under control of the management SoC.
The dual function for each ``mprj_io`` pad is as follows:

``mprj_io[0]``	Debug*

``mprj_io[1]``	housekeeping SDO

``mprj_io[2]``	housekeeping SDI

``mprj_io[3]``	housekeeping CSB

``mprj_io[4]``	housekeeping SCK

``mprj_io[5]``	UART ser_rx

``mprj_io[6]``	UART ser_tx

``mprj_io[7]``	IRQ 1 source

``mrpj_io[8]``	user flash CSB

``mrpj_io[9]``	user flash SCK

``mrpj_io[10]``	user flash IO0

``mrpj_io[11]``	user flash IO1

``mprj_io[12]``	IRQ 2 source

``mprj_io[13]``	Trap monitor**

``mprj_io[14]``	Core clock monitor

``mprj_io[15]``	User clock monitor

``mprj_io[32]``	SPI master SCK

``mprj_io[33]``	SPI master CSB

``mprj_io[34]``	SPI master SDI

``mprj_io[35]``	SPI master SDO

``mprj_io[36]``	flash IO2*

``mprj_io[37]``	flash IO3*

*The Debug and flash QSPI modes may not be available on all management SoC core types.*

**The trap signal may not be implemented on all management SoC core types, and this pin may be connected to a different signal for monitoring, or none at all.**

The 38 GPIO pins are accessed in the following order of precedence:

1. The user project accesses the GPIO whenever the GPIO configuration
"management enable" bit (bit 0) is set to 0, using the 3-wire
interface ``io_in, io_out, io_oeb``.

2. The management SoC accesses the GPIO with a special function when
the GPIO configuration "management enable" bit (bit 0) is set to
1, and the corresponding special function is enabled (see summary
below for the enable bit for each special function).

3. The management SoC accesses the GPIO with the standard GPIO read/
write data function when the GPIO configuration "management enable"
bit (bit 0) is set to 1, and no special function is enabled.

A summary of each dedicated management core function is provided below:
-----------------------------------------------------------------------

**Debug**:

The debug pin enables the debug function on any management SoC core
that supports a debug mode.  Its use is open-ended and depends on
the specific core, but a typical use case is that applying a "1"
value to this pin (setting to VDDIO) activates the UART and allows
debugging through the UART port.  The debug function is enabled by
the management SoC, and its state is defined by the SoC 
implementation.  The implementation may choose to set the debug
enable signal high always, in which case the GPIO 0 pin cannot be
used by the management SoC for general-purpose I/O (this does not
affect the use of the pin by the user project).

**Housekeeping SPI**:

GPIO pads 1-4 are dedicated to the housekeeping SPI on power-up and
may not be configured otherwise by default.  This allows a 4-pin
diagnostic SPI interface for querying the project ID of the chip and
a number of the internal memory mapped registers, as well as allowing
access to apply a manual interrupt to the CPU, to manually reset the
chip, or to program the SPI flash with the pass-through mode.  On the
demonstration board, these pins are connected directly to the FTDI
chip so that the housekeeping SPI can be read and written from a host
computer through USB.  They may be reconfigured for use by the user
project;  the FTDI can be configured to tristate these pins so that
the user project can use them unconditionally.  Generally speaking,
a user project should use these pins as a "last resort".  When a
user project controls these pads, the "housekeeping disable" bit
should be set to 1.  Likewise, when the management SoC wants to use
these pins for general-purpose I/O, the "housekeeping disable" bit
should be set to 1.  Otherwise the housekeeping SPI pins are always
enabled for the special function.

**UART**:

GPIO pads 5 and 6 can be used by the management SoC as a serial UART.
When the UART enable bit is set in the UART control register, these
pins are used for UART Tx and Rx.  When the UART enable bit is cleared,
these pins are general purpose I/O.  Generally, a user project should
try to keep these pins free for use by the management SoC, since the
UART is the most convenient method for communication between the
management SoC and a host computer.

**SPI master**:

GPIO pads 32 to 35 are the I/O of the SPI master when it is
enabled.

**Flash QSPI**:

For management SoC architectures that support QSPI mode on the
SPI flash controller, the two highest-numbered GPIOs (36 and 37)
will act as data lines IO2 and IO3 when QSPI mode is enabled
on the flash controller.

**Clock monitoring**:

The two primary clocks from the Caravel clock module are the
core clock driving the management SoC, and the user clock, which
is a secondary clock available to the user space that is derived
from the upstream clock but with an independent output divider
(see the page on the digital locked loop).  The core clock can
be copied to GPIO 14, and the secondary clock can be copied to
GPIO 15 for monitoring.  Note that the GPIOs have a bandwidth
limit of 60MHz, and it is possible to run a clock up to about
150MHz.  Frequencies higher than 60MHz will be severely
attenuated, although it should be possible to measure them
with a frequency counter.

**Trap monitoring**:

For management SoC architectures that generate a trap or fault
signal when the CPU fails, the signal can be routed to GPIO 13
for monitoring.

**IRQ source**:

GPIO pads 7 and 12 can be set to be the source for two IRQ lines
into the management SoC.  The specific IRQs used by the management
SoC depends largely on the SoC implementation.

**User flash SPI**:

GPIO pads 8 to 11 can be used with an alternate pass-through
programming mode if connected to an SPI flash with the pin
assignments shown above.  It is recommended that any user project
that has its own SPI flash controller should use these pins, so
that the flash can be programmed directly from a host computer
through the housekeeping SPI interface.  Since the pass-through
mode does not use QSPI mode, only four pins are needed for the
pass-through function.  If the user project's SPI flash controller
supports quad mode, then the additional two data pins can use
any available GPIO.  There is no requirement for the user to
make use of these pins for an SPI flash, but the pass-through
mode is implemented on these pins as a convenience.  To use the
pass-through mode, the following must be done:

1. The GPIO pads 8 to 11 are put under management SoC control with the "management enable" bit.
2. The housekeeping SPI pads 1 to 4 must be under management SoC control.
3. The houskeeping SPI is enabled.
4. The housekeeping SPI is given the command to enter pass-through mode.

In theory, any pins can be set to management control through the
housekeeping SPI and bit-banged, but the dedicated pass-through
mode is much faster and easier to implement since the SPI commands
can be passed straight through a USB connection from a host
computer.

*As noted above*, some of the special functions are enabled per implementation
of the management SoC (``debug``, ``UART``, ``SPI master``, ``flash QSPI``).  For the
register setting that enable these functions, please see the documentation
for the management SoC.  The enables are specified to be placed at the
following locations (but the actual location may be implementation dependent):

.. code:: bash

    UART:	0x20000008  bit 0  = UART enable
    SPI master: 0x24000000  bit 13 = SPI master enable
    QSPI:	0x2d000000  bit 21 = QSPI enable

The remaining special functions are controlled by the housekeeping module,
and **the special function enables are registered as shown below**:

- Register name = ``reg_hkspi_disable``
- Memory location = ``0x26200010``
- Housekeeping SPI location = ``0x1c``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x1c |       |       |       |       |       |       |       |house- |
|      |       |       |       |       |       |       |       |keeping|
|      |       |       |       |       |       |       |       |disable|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  Housekeeping SPI disable
    - value 0 = Housekeeping SPI is enabled on GPIO pins 1 to 4
    - value 1 = Housekeeping SPI is disabled;  GPIO pins 1 to 4 are general-purpose I/O.

--------------------------------------------------------------------------

- Register name = ``reg_trap_out_dest``, ``reg_clk_out_dest``
- Memory location = ``0x26200004``
- Housekeeping SPI location = ``0x1b``
  
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x1b |       |       |       |       |       |clk1   |clk2   |trap   |
|      |       |       |       |       |       |monitor|monitor|monitor|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  Trap source monitor
    - value = 0: GPIO pin 13 is general-purpose I/O
    - value = 1: GPIO pin 13 outputs the CPU trap state, if available

*bit 1*:  User clock monitor
    - value = 0: GPIO pin 15 is general-purpose I/O
    - value = 1: GPIO pin 15 outputs the user clock.

*bit 2*:  Core clock monitor
    - value = 0: GPIO pin 14 is general-purpose I/O
    - value = 1: GPIO pin 14 outputs the core clock.

--------------------------------------------------------------------------

- Register name = ``reg_irq_source``
- Memory location = ``0x2620000c``
- Housekeeping SPI location = ``0x1c``
  
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x1b |       |       |       |       |       |       | irq 2 | irq 1 |
|      |       |       |       |       |       |       | source| source|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

bit 0:  IRQ 1 source
    - value = 0: GPIO pin 7 is general-purpose I/O
    - value = 1: GPIO pin 7 is an interrupt to the CPU (the interrupt number is dependent on the management SoC architecture implementation).

bit 1:  IRQ 2 source
    - value = 0: GPIO pin 12 is general-purpose I/O
    - value = 1: GPIO pin 12 is an interrupt to the CPU (the interrupt number is dependent on the management SoC architecture implementation).
