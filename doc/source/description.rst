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

Description
===========

This section provides basic description of the Efabless Caravel "harness" SoC.

Core
----

The processor core is the PicoRV32 design.
See GitHub `cliffordwolf/picorv32 repository <https://github.com/cliffordwolf/picorv32>`_ for the core implementation and description.
The hardware implementation is the "large" variant, incorporating options ``IRQ``, ``MUL``, ``DIV``, ``BARREL_SHIFTER``, and ``COMPRESSED_ISA`` (16-bit instructions).

Core clock rate: (TBD) MHz maximum over all PVT conditions (likely around 50MHz guaranteed).

Features
--------

Functions/features of the SoC include:

* 1 SPI flash controller,
* 1 UART,
* 1 SPI controller,
* 2 counter-timers,
* 1 dedicated GPIO channel,
* 27 shared GPIO channels,
* 8k word (32768 bytes x 8 bits) on-board SRAM,
* All-digital frequency-locked loop clock multiplier 128bit logic analyzer.

License
-------

The Caravel is an open-source design, licensed under the terms of Apache 2.0.

Repository
----------

The complete Caravel chip design may be obtained from the git repository located at GitHub `efabless/caravel repository <https://github.com/efabless/caravel>`_.

Process
-------

The efabless Caravel harness chip is fabricated in SkyWater 0.13um CMOS technology, with process specifications and data at GitHub `google/skywater-pdk repository <https://github.com/google/skywater-pdk>`_.
