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

====================
Caravel vs. Caravan
====================

-----------
Caravel
-----------

The Caravel chip user project can use the GPIO pins as analog signals,
and this is the preferred method, as the GPIO pins have ESD protection
on them.

The restrictions on the use of GPIO pins for analog are the following:

(1) The voltage range of the analog signal must be between ``VSSIO`` and
    ``VDDIO``.  On the demonstration board shipped with Caravel, ``VDDIO`` will
    be set to ``3.3V`` from an external voltage regulator.  However, ``VDDIO``
    may be anywhere in the range of ````1.8V```` to ``5.5V``.

(2) The frequency range of the GPIO pads is ``0`` to ``60MHz``

(3) Analog signals should be connected to the ``analog_io`` pins of the user
    project wrapper.  This pin connects to the pad through a 120 ohm
    resistor, for ESD protection.  However, it is recommended to place a
    diode close to the terminus in the user project circuit for any input
    signal that is not otherwise connected to diffusion, for additional
    ESD protection.  This resistance should be included in system-level
    simulations.

(4) When an analog signal is connected to a GPIO pad, the input and
    output buffers of the GPIO pad should be turned off, by setting the
    GPIO configuration to ``GPIO_MODE_USER_STD_ANALOG`` (see defs.h).
    Ideally, the buffers should be turned off by default on chip power-up,
    which is done by applying the same configuration in the ``user_defines.v``
    file.  This ensures that the digital buffers will never be turned on
    for those GPIOs.

(5) Analog signals may not use GPIO ``0 to 6 or GPIO 36 and 37``.  This prevents
    the critical signals such as debug, housekeeping SPI, and flash QSPI
    mode pins from being unable to operate due to a constant analog signal
    being present on the pad.  Therefore there are up to 28 GPIO pins that
    can be used for analog signaling.

    Note that the signal names ``analog_io[27:0]`` are shifted relative to the
    GPIO pad names (mprj_io).  So analog_io[0] connects to ``mprj_io[7]``, and
    so forth up to ``analog_io[27]`` which connects to ``mprj_io[34]``.

---------
Caravan
---------

In the case that a pin is needed that requires voltages above ``5.5V``, below
``0.0V``, has a frequency higher than ``60MHz``, or cannot tolerate the ``120 ohm``
series resistance, then the Caravan chip provides 11 pads which are
straight-through connections from core to pad.  These pads replace pads
``mprj_io[14]`` to ``mprj_io[24]`` and extend across the top of the padframe.

**WARNING:** 

        The analog pads provide NO ESD protection, because the use of
        the pads is open-ended and requirements are different for protection of,
        say, high voltage, negative voltage, and very high frequency.

All pads other than the 11 that have straight-through connections from
user project to pad are the same pads as used on Caravel, so there are
up to 17 GPIO pins that can be used for analog signaling under the same
restrictions as noted above for Caravel.  These pins are given a different
name on Caravan, which is ``user_gpio_analog[17:0]``.

Because analog circuits will often run at ``3.3V``, digital circuitry for
controlling such circuits should use the HVL digital standard cell library
for ``3.3V`` compatibility.  These circuits can connect directly to I/O inputs
if the ``io_in_3v3[26:0]`` pins are used.  These pins are copies of the GPIO
pin digital inputs in the ``3.3V`` domain.  Note, however, that there is no
corresponding GPIO output in the ``3.3V`` domain.  ``3.3V`` outputs must be level
converted into the ``1.8V`` domain using, for example, the cell
sky130_fd_sc_hvl__lsbufhv2lv_1, before being connected to either io_out
or io_oeb.

The full correspondence between mprj_io pins and internal connections is
shown below, copied from

``caravel_user_project_analog/verilog/rtl/user_analog_proj_example.v``:

Caravan signal connections to I/O pins:

============ =============================== ============================== ================================
I/O pin      user project digital connection user project analog connection optional power clamp connection
============ =============================== ============================== ================================
mprj_io[37]  io_in/out/oeb/in_3v3[26]        ---                            ---
mprj_io[36]  io_in/out/oeb/in_3v3[25]        ---                            ---
mprj_io[35]  io_in/out/oeb/in_3v3[24]        gpio_analog/noesd[17]          ---
mprj_io[34]  io_in/out/oeb/in_3v3[23]        gpio_analog/noesd[16]          ---
mprj_io[33]  io_in/out/oeb/in_3v3[22]        gpio_analog/noesd[15]          ---
mprj_io[32]  io_in/out/oeb/in_3v3[21]        gpio_analog/noesd[14]          ---
mprj_io[31]  io_in/out/oeb/in_3v3[20]        gpio_analog/noesd[13]          ---
mprj_io[30]  io_in/out/oeb/in_3v3[19]        gpio_analog/noesd[12]          ---
mprj_io[29]  io_in/out/oeb/in_3v3[18]        gpio_analog/noesd[11]          ---
mprj_io[28]  io_in/out/oeb/in_3v3[17]        gpio_analog/noesd[10]          ---
mprj_io[27]  io_in/out/oeb/in_3v3[16]        gpio_analog/noesd[9]           ---
mprj_io[26]  io_in/out/oeb/in_3v3[15]        gpio_analog/noesd[8]           ---
mprj_io[25]  io_in/out/oeb/in_3v3[14]        gpio_analog/noesd[7]           ---
mprj_io[24]  ---                             user_analog[10]                ---
mprj_io[23]  ---                             user_analog[9]                 ---
mprj_io[22]  ---                             user_analog[8]                 ---
mprj_io[21]  ---                             user_analog[7]                 ---
mprj_io[20]  ---                             user_analog[6]                 clamp_high/low[2]
mprj_io[19]  ---                             user_analog[5]                 clamp_high/low[1]
mprj_io[18]  ---                             user_analog[4]                 clamp_high/low[0]
mprj_io[17]  ---                             user_analog[3]                 ---
mprj_io[16]  ---                             user_analog[2]                 ---
mprj_io[15]  ---                             user_analog[1]                 ---
mprj_io[14]  ---                             user_analog[0]                 ---
mprj_io[13]  io_in/out/oeb/in_3v3[13]        gpio_analog/noesd[6]           ---
mprj_io[12]  io_in/out/oeb/in_3v3[12]        gpio_analog/noesd[5]           ---
mprj_io[11]  io_in/out/oeb/in_3v3[11]        gpio_analog/noesd[4]           ---
mprj_io[10]  io_in/out/oeb/in_3v3[10]        gpio_analog/noesd[3]           ---
mprj_io[9]   io_in/out/oeb/in_3v3[9]         gpio_analog/noesd[2]           ---
mprj_io[8]   io_in/out/oeb/in_3v3[8]         gpio_analog/noesd[1]           ---
mprj_io[7]   io_in/out/oeb/in_3v3[7]         gpio_analog/noesd[0]           ---
mprj_io[6]   io_in/out/oeb/in_3v3[6]         ---                            ---
mprj_io[5]   io_in/out/oeb/in_3v3[5]         ---                            ---
mprj_io[4]   io_in/out/oeb/in_3v3[4]         ---                            ---
mprj_io[3]   io_in/out/oeb/in_3v3[3]         ---                            ---
mprj_io[2]   io_in/out/oeb/in_3v3[2]         ---                            ---
mprj_io[1]   io_in/out/oeb/in_3v3[1]         ---                            ---
mprj_io[0]   io_in/out/oeb/in_3v3[0]         ---                            ---
============ =============================== ============================== ================================


Three of the eleven stright-through analog connections on the Caravel chip
go to pads which have voltage clamps underneath.  A voltage clamp is a
circuit that protects against ESD events by detecting a rapid rise in
voltage on a power supply pad, and enabling a switch that shorts the
power supply to a nearby ground, reducing the event's voltage spike and
shunting current through a path close to the pads and away from sensitive
circuitry.  Each clamp has a positive connection (clamp_high) and a negative
connection (clamp_low).  Neither of these pins is connected by default.  The
clamp_high pin should be connected to a power supply, preferably the one
connected to the pad directly above it.  The clamp_low pin should be
connected to a ground return.  Due to the nature of the user project wrapper
as a drop-in module, the current shunting path will be much longer than the
ideal short path.  Be sure to make this path as wide as practicable.

The clamp circuit is a high-voltage clamp type intended for operation on a
power supply equal to VDDIO, or nominally ``3.3V`` for the demonstration board
(and otherwise within the range of ``1.8V`` to ``5.5V``).  Because the I/O voltage
range includes ``1.8V``, this clamp will operate at ``1.8V``.  However, it provides
the best ESD protection for ``3.3V`` supplies.  It should not be used with any
supply higher than VDDIO.

Because of the large amount of circuitry (the clamp) directly underneath the
pad, the three pads with the clamps are not intended for high-speed use.  These
pads are best used for additional power supply inputs to the analog chip.
The three pads that contain clamps are also designed to provide the largest
amount of current, up to 265mA for each pad (see below).  The pin connection
at the user project wrapper boundary consists of two ports, 25um wide, each
comprising a stack of metals 3, 4, and 5.  To get the maximum current through
the pad without creating electromigration issues, connect to all three metals
on both ports.

Power supply routing on Caravan is expected to be done manually.  Allow less
than ``1.5mA`` per micron width on metal3 and metal4 to satisfy electromigration
rules, and less than ``2.3mA`` per micron on metal5.  The maximum current per
dedicated power pad is 

.. math::
    ((25um * 2) * (1.5 + 1.5 + 2.3)) = 265mA

Wrapper pins
--------------------------

Due to the way the wrapper circuit is "dropped into" the Caravel or Caravan
harness chip, a continuity check must be run at tape-in to ensure that the
pins of the wrapper connect correctly to the corresponding locations on the
harness.  This requires that each pin in the design must be on a unique net.
Because of this requirement, pins in the user wrapper may not be shorted
together, otherwise only one of the shorted pins can be represented as a
subcircuit port in the extracted SPICE netlist.

Because shorting pins together is a likely use case, especially in analog
designs, the recommended procedure when connecting pins together is to
place a "metal resistor" in front of the pin connection on all connections
other than the primary one.  Most pin connections are on metal3, so a
metal3 resistor is preferred.  The "metal resistor" in the layout is an
identifying layer, not a mask layer, so the metal should be continuous
through to the connection, with the resistor identifier layer spanning the
width of the connection.

For example, the user may want to tie together VDDA1 and VDDA2 to double
the current capacity of the ``3.3V`` domain power supply.  The user should
route a power bus and connect it directly to the VDDA1 pin.  Then, a
route can be made to the VDDA2 pin but should pass through a metal3
resistor before making the connection to the pin.  Any such resistor
must be represented as a device in a schematic drawing for the design to
pass LVS.

Allocating power supplies
--------------------------

As mentioned above, power supplies may be connected together if needed.
These are the available power supplies:

- VCCD1/VSSD1 :  User domain 1, ``1.8V`` power
- VCCD2/VSSD2 :  User domain 2, ``1.8V`` power
- VDDA1/VSSA1 :  User domain 1, ``3.3V`` power
- VDDA2/VSSA2 :  User domain 2, ``3.3V`` power
- VDDIO/VSSIO :  Management domain, ``3.3V`` power supply to padframe
- VCCD/VSSD   :  Management domain, ``1.8V`` power supply to padframe and SoC

All pad connections that are chip pins are in the VDDIO domain.  All low
voltage pad connections to the chip core are in the VCCD domain, and 
the only high voltage pins (io_in_3v3;  see above) connected to the user
project wrapper are in the VDDIO domain.

Any of the user power supplies that are in the same power domain can be
connected together to provide additional current capacity.  So VCCD1 and
VCCD2 may be connected together (along with connecting together VSSD1
and VSSD2);  and VDDA1 and VDDA2 may be connected together (along with
VSSA1 and VSSA2).  The user project does not have direct access to the
management area power domains, including the supplies that drive the
padframe I/O.
