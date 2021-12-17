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

External clock
==============

The external clock is provided to :ref:`clock <clock>` pin (C9).

The external clock functions as the source clock for the entire processor.
On startup, the processor runs at the same rate as the external clock.
The processor program may access the :doc:`housekeeping-spi` to set the processor into PLL mode or DCO free-running mode.
In PLL mode, the external clock is multiplied by the feedback divider value to obtain the core clock.
In DCO mode, the processor is driven by a trimmed free-running ring oscillator.
