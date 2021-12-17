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

Programming
===========

The RISC-V architecture has a ``gcc`` compiler.
The best reference for getting the correct cross-compiler version is the PicoRV32 source
in the `cliffordwolf/picorv32 repository <https://github.com/cliffordwolf/picorv32>`_.

Specifically, see the top-level ``README.md`` file section
`Building a pure RV32I Toolchain <https://github.com/cliffordwolf/picorv32#building-a-pure-rv32i-toolchain>`_.

For programming examples specifically for the Caravel chip
(assuming a correct installation of a RISC-V ``gcc`` toolchain as described above),
see `efabless/caravel repository <https://github.com/efabless/caravel>`_.

The directory ``verilog/dv`` contains example source code to program the Ravenna chip
along with the header file ``defs.h`` that defines the memory-mapped locations
as described throughout this text.

The ``verilog/dv`` directory contains a ``Makefile`` that compiles ``hex`` files
and runs simulations of a number of test programs that exercise various features of the chip.

Additional documentation exists on the same site for the provided demonstration circuit board and driver software.
