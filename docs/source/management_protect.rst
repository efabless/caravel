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

==================================
Caravel management protect module
==================================

The management protection module sits between the management SoC and
the user project area on the Caravel chip.  Its purpose is to maintain
a protective buffer between the two, so that the user project area can
be completely powered down without the management SoC dumping current
into the user project circuits.

The management protection module has two main functions:

1. Put tristate buffers on all outputs of the management SoC or
housekeeping that connect to the user project wrapper pins, enabled
with the 1/0 ("power good") state of the user project primary digital
power supply (vccd1).  This ensures that if the user project vccd1
supply is not present and powered up to 1.8V, then the management SoC
and housekeeping modules cannot generate current on these pins that
would sink into the user project area.

2. AND all outputs of the user project that connect to the management
SoC with memory-mapped enable bits.  This allows the user project to
leave any pins of the user project wrapper unconnected or tristated.
Unconnected outputs of the user project wrapper going to the management
SoC can be floating and will not affect operation of the chip as long
as the respective enable bits are not set in the corresponding registers.

Most of the protection circuitry is transparent to the user project, but
the input enable registers must be set by the program running on the
management SoC for the user project to be able to communicate data to the
management SoC through either the logic analyzer interface or the wishbone
bus interface.

--------------------------------------------------------------------------

- Register name = ``reg_power_good``
- Memory location = ``0x2f000000``
- Housekeeping SPI location = ``0x1a``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |       |       |       |       | user1 | user2 | user1 | user2 |
| 0x1a |       |       |       |       | vccd  | vccd  | vdda  | vdda  |
|      |       |       |       |       | power | power | power | power |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  User 2 domain VDDA ``3.3V`` supply (VDDA2) power good (read-only)
    - value 1 = Supply VDDA2 is present and powered (``1.8V`` to ``5.5V``)
    - value 0 = Supply VDDA2 is not present or under-voltage 

*bit 1*:  User 1 domain VDDA ``3.3V`` supply (VDDA1) power good (read-only)
    - value 0 = Supply VDDA1 is not present or under-voltage 
    - value 1 = Supply VDDA1 is present and powered (``1.8V`` to ``5.5V``)

*bit 2*:  User 2 domain VCCD ``1.8V`` supply (VCCD2) power good (read-only)
    - value 0 = Supply VCCD2 is not present or under-voltage 
    - value 1 = Supply VCCD2 is present and ``1.8V``

*bit 3*:  User 1 domain VCCD ``1.8V`` supply (VCCD1) power good (read-only)
    - value 0 = Supply VCCD1 is not present or under-voltage 
    - value 1 = Supply VCCD1 is present and ``1.8V``

--------------------------------------------------------------------------

- Register name = ``reg_la0_iena``
- Memory location = ``0x25000020`` to ``0x25000023`` (32 bits or 4 bytes or 1 word)

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |  31   |  30   |  29   |       |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      | la    | la    | la    |       | la    | la    | la    | la    |
|      | iena  | iena  | iena  |  ...  | iena  | iena  | iena  | iena  |
|      | [31]  | [30]  | [29]  |       | [3]   | [2]   | [1]   | [0]   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

- Register name = ``reg_la1_iena``
- Memory location = ``0x25000024`` to ``0x25000027`` (32 bits or 4 bytes or 1 word)

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |  31   |  30   |  29   |       |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      | la    | la    | la    |       | la    | la    | la    | la    |
|      | iena  | iena  | iena  |  ...  | iena  | iena  | iena  | iena  |
|      | [63]  | [62]  | [61]  |       | [35]  | [34]  | [33]  | [32]  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

- Register name = ``reg_la2_iena``
- Memory location = ``0x25000028`` to ``0x2500002b`` (32 bits or 4 bytes or 1 word)

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |  31   |  30   |  29   |       |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      | la    | la    | la    |       | la    | la    | la    | la    |
|      | iena  | iena  | iena  |  ...  | iena  | iena  | iena  | iena  |
|      | [95]  | [94]  | [93]  |       | [67]  | [66]  | [65]  | [64]  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

- Register name = ``reg_la3_iena``
- Memory location = ``0x2500002c`` to ``0x2500002f`` (32 bits or 4 bytes or 1 word)

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |  31   |  30   |  29   |       |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      | la    | la    | la    |       | la    | la    | la    | la    |
|      | iena  | iena  | iena  |  ...  | iena  | iena  | iena  | iena  |
|      | [127] | [126] | [125  |       | [99]  | [98]  | [97]  | [96]  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

**Note** 

    The la_iena[] bits are not ports of the user project wrapper.
    They originate in the management SoC and terminate at the management
    protect module.  They can only be set from the management SoC program.

--------------------------------------------------------------------------

- Register name = ``reg_irq_enable``
- Memory location = ``0x2f000000``
- 
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |       |       |       |       |       | irq 2 | irq 1 | irq 0 |
|      |       |       |       |       |       | enable| enable| enable|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  IRQ 0 enable
    - value 0 = User IRQ 0 from the user project is disabled and may be left unconnected or tristated.
    - value 1 = User IRQ 0 from the user project is enabled and must be connected and driven.

*bit 1*:  IRQ 1 enable
    - value 0 = User IRQ 1 from the user project is disabled and may be left unconnected or tristated.
    - value 1 = User IRQ 1 from the user project is enabled and must be connected and driven.

*bit 2*:  IRQ 2 enable
    - value 0 = User IRQ 2 from the user project is disabled and may be left unconnected or tristated.
    - value 1 = User IRQ 2 from the user project is enabled and must be connected and driven.

--------------------------------------------------------------------------

- Register name = ``reg_wb_enable``
- Memory location = ``0x2f000000``
- 
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |       |       |       |       |       |       |       | wb    |
|      |       |       |       |       |       |       |       | enable|
+------+-------+-------+-------+-------+-------+-------+-------+-------+

*bit 0*:  User wishbone enable
    - value 0 = Wishbone signals wbs_dat_o and wbs_ack_o are disabled and may be left unconnected.
    - value 1 = Wishbone signals wbs_dat_o and wbs_ack_o are enabled and must be connected and driven.

