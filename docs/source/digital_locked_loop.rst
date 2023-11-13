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

===========================
Caravel digital locked loop
===========================

The Caravel digital locked loop ``DLL`` is an all-digital clock generating
module.

The GPIO pins on Caravel have a limit of 50MHz input.  Internally, it is
possible to generate a clean oscillation of up to around 200MHz or higher.
To ensure large margins of safety, the Caravel demonstration board ships
with an on-board oscillator of 10MHz.  The operational frequency of the
management SoC on Caravel differs according to which management SoC
architecture is present, but is generally in the range of around 50MHz.

The DLL comprises an on-chip tunable ring oscillator and a feedback
controller for locking to a known input clock.  It can operate in either
free-running ``DCO`` or locked ``DLL`` modes.  The Caravel system can run
directly off of the external clock (bypass mode), the free-running DCO,
or the DLL locked to the external clock.

The DLL's tunable oscillator has an operating range of approximately
75MHz to 150MHz.  The oscillator is a loop of from 13 to 39 inverter
stages with 26 bits of trim.  Each trim bit adds or subtracts one of
the stages.  So there are 27 effective frequency steps covering a range
of about 75MHz, with an incremental delay of about 250ps per step.

In the Caravel memory map, the DLL is controlled by a handful of registers
as shown below.  These registers are in the housekeeping SPI module, and
so can be controlled either from an external source through the housekeeping
SPI, or internally through the management SoC.

**WARNING:**

        The management SoC altering its own clock has not yet been tested
        as of this writing;  however, the core clock should be guaranteed to be glitch-
        free through transistions from external clock to DLL output and vice versa.

-------------
DLL operation
-------------

The DLL operates by taking the ring oscillator output, reducing its frequency
through a feedback divider, and comparing the result to the input clock.
If the frequency of the divided-down ring oscillator output is faster than
the input clock frequency, then an additional delay stage is added to the
ring oscillator, making it run slower.  If the frequency of the divided-down
ring oscillator output is slower than the input clock frequency, then a delay
stage is subtracted from the ring oscillator, making it faster.  This
operation is performed in a continuous loop to keep the DLL frequency locked
to the input clock.

**WARNING:**

        Using discrete delay state insertion and removal results in high
        phase noise (cycle to cycle jitter) on the core clock when running in DLL mode,
        due to instantaneous changes of 250ps between cycles (a 0.25% change in the
        clock period).  User projects that require a clock with low phase noise should
        use the external clock (DLL in bypass mode), and if the project requires a
        higher clock rate, then the 10MHz clock on the demonstration board may be
        replaced with another oscillator of the same footprint with a frequency up
        to 50MHz.  The DLL running in DCO mode has low cycle-to-cycle jitter but will
        have a large drift component, as it is not temperature stabilized.

The DLL controls are memory-mapped to the housekeeping space, and are as follows:
=================================================================================

- Register name = ``reg_hkspi_pll_ena``
- Memory location = ``0x2610000c``
- Housekeeping SPI location = ``0x08``
 
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x09 |       |       |       |       |       |       |  DCO  |  DLL  |
|      |       |       |       |       |       |       |  ena  |  ena  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
          

    bit 1:  DCO enable
	    value 0 = DCO disabled.  DLL runs in active locking mode
	    value 1 = DCO enabled.   DLL runs in DCO mode.

    bit 0:  DLL enable
	    value 0 = DLL disabled. DLL is disabled and the clock is stopped.
	    value 1 = DLL enabled.  DLL is enabled and outputs a clock.

=============================================================================

- Register name = ``reg_hkspi_pll_bypass``
- Memory location = ``0x26100010``
- Housekeeping SPI location = ``0x09``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x09 |       |       |       |       |       |       |       | DLL   |
|      |       |       |       |       |       |       |       | bypass|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

    bit 0:  DLL bypass
	    value 0 = DLL active.  Core clock is derived from the DLL output.
	    value 1 = DLL bypassed.  Core clock is derived from the external clock source.

=============================================================================


- Register name = ``reg_hkspi_pll_trim``
- Memory location = ``0x2610001c to 0x261001f``
- Housekeeping SPI location = ``0x0d to 0x10``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x10 |       |       |       |       |       |       | trim25| trim24|
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x0f | trim23| trim22| trim21| trim20| trim19| trim18| trim17| trim16|
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x0e | trim15| trim14| trim13| trim12| trim11| trim10| trim9 | trim8 |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x0d | trim7 | trim6 | trim5 | trim4 | trim3 | trim2 | trim1 | trim0 |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

**All bits:**

    DLL manual trim value.  This 26-bit value is applied to
    the DLL when in DCO mode and directly controls the frequency
    of the ring oscillator.  Each '1' bit turns on one delay
    stage in the oscillator.

**NOTE:**

    The phase relationship between the DLL outputs (for the core
    clock and the user clock) is nominally 90 degrees when the trim
    stages are balanced along the length of the oscillator, but this
    phase can be altered with non-uniform delays.

=============================================================================

- Register name = ``reg_hkspi_pll_divider``
- Memory location = ``0x26100024``
- Housekeeping SPI location = ``0x12``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x12 |       |       |       | div4  | div3  | div2  | div1  | div0  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

    bits 4 to 0:  Value of the DLL feedback divider.  In active DLL mode,
	    the DLL output is divided down by this amount, and then the
	    trim is adjusted to make the divided value match the incoming
	    external clock.

    For example, if the external clock is 10MHz and the divider value is
    9 (div = 5'b01001), then the DLL will trim the oscillator to run at
    10MHz * 9 = 90MHz.  The value of (external clock frequency * divider
    value) must always be within the DLL's trimmable range, or else the
    DLL will saturate.

=============================================================================

- Register name = ``reg_hkspi_pll_source``
- Memory location = ``0x26100020``
- Housekeeping SPI location = ``0x11``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x11 |       |       | core2 | core1 | core0 | user2 | user1 | user0 |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

   bits 2 to 0:  Value of the user clock output divider.  The value of
	    the secondary clock ("user_clock") in the user project area
	    is derived from the zero-phase ring oscillator output divided
	    down by this amount.  The values range from 1 (divide by 1)
	    to 7 (divide by 7).

   bits 5 to 3:  Value of the core clock output divider.  The value of
	    the primary clock ("wb_clk_i") in the user project area
	    is derived from the 90-degree-phase ring oscillator output
	    divided down by this amount.  The values range from 1 (divide
	    by 1) to 7 (divide by 7).

