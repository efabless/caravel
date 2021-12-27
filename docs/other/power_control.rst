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

======================
Caravel Power control
======================

The user project power control register is a "reserved" register that is
intended for future use with on-chip LDOs to power the user project
area.  In the current version of the Caravel chip, it has no function.

In the current version of the Caravel chip, all user area power supplies
are provided by voltage regulators on the demonstration/development
board.

**The usable ranges of these power supplies is**:

user1 vccd (VCCD1) = ``1.8V``
user2 vccd (VCCD2) = ``1.8V``

user1 vdda (VDDA1) = ``1.8V`` to ``5.5V`` (nominally ``3.3V``)
user2 vdda (VDDA2) = ``1.8V`` to ``5.5V`` (nominally ``3.3V``)

It is the responsibility of the user project area designer to ensure that
the value of VDDA1 and VDDA2 is compatible with the circuitry connected
to it in the user project.

--------------------------------------------------------------------------

- Register name = ``reg_mprj_pwr``
- Memory location = ``0x26000004``
- Housekeeping SPI location = ``0x6e``

+------+-------+-------+-------+-------+-------+-------+-------+-------+
|      |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
+------+-------+-------+-------+-------+-------+-------+-------+-------+
| 0x6e |       |       |       |       | user1 | user2 | user1 | user2 |
|      |       |       |       |       | vccd  | vccd  | vdda  | vdda  |
+------+-------+-------+-------+-------+-------+-------+-------+-------+

