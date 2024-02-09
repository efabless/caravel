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
CARAVEL TOPLEVEL ECO
====================

ECOs were done on top level caravel for several reasons

1. `porb_h_in` shorted with `por_l_in` because it was a floating wire
2. `mgmt_gpio_oeb` was not shorted with `mprj_io_one` in some instances of `gpio_control_block`, this is due to an issue with the router

The flow to generate caravel top level:
=======================================

==================================================== ============================== ============================= ==========
Flow                                                 Input Filename                 Output Filename               Tool
==================================================== ============================== ============================= ==========
def to mag                                           caravel.def                    caravel-openlane.mag          OpenLane
create_top_pins.sh                                   caravel-openlane.mag           caravel-with-label.mag        magic
ECO to gpio_control_block to fix LVS issue           caravel-with-label.mag         caravel-eco-gpio_control.mag  magic GUI
mag to GDS (build script)                            caravel-eco-gpio_control.mag   caravel-eco-gpio_control.gds  magic
ECO to gpio_control_block to fix LVS issue           caravel-eco-gpio_control.gds   caravel-eco-gpio_antenna.gds  klayout
GDS to mag                                           caravel-eco-gpio_antenna.gds   caravel-eco-antenna.mag       magic
gen_gpio_defaults.py                                 caravel-eco-antenna.mag        caravel-signoff.mag           python
mag to GDS (build script)                            caravel-signoff.mag            caravel-signoff.gds           magic
==================================================== ============================== ============================= ==========

**NOTE: caravel-eco-antenna.mag is the same as caravel.mag (this is for tracebility issues)**
