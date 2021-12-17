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

SRAM
====

.. _management-area-sram:

Management area SRAM
--------------------

The Caravel chip has an on-board memory of 256 words of width 32 bits.
The memory is located at address ``0``.
There are additional blocks of memory above this area, size and location TDB.

.. _storage-area-sram:

Storage area SRAM
-----------------

The Caravel chip has a *storage area* SRAM block that is auxiliary space
that can be used by either the management SoC or the user project, through the Wishbone bus interface.
The storage area is connected into the user area 2 power supply,
and so is nominally considered to be part of the user area.

The storage area may be used as an experimentation area for OpenRAM, so for any user project making use of this space, the user should notify efabless of their requirement for the size and configuration of the SRAM block.
