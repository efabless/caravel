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

1. ``porb_h_in`` shorted with ``por_l_in`` because it was a floating wire
2. ``mgmt_gpio_oeb`` was not shorted with ``mprj_io_one`` in some instances of ``gpio_control_block``, this is due to an issue with the router
3. To get caravel device level LVS clean, mask layer in the IO cells in the library needed modifications, can be found in ``gds/caravel+io.gds``

The non-eco'd views coming out of OpenLane is postfixed by ``-openlane``, for example: ``gds/caravel-openlane.gds.gz``

After applying ``scripts/create_top_pins.sh`` on ``caravel.mag``, the views have a postfix ``-with-labels``

The eco'd views have postfix ``-eco``

After running tapeout scripts on ``caravel.mag``, the views have a postfix ``-signoff``

``caravel-signoff.gds`` was generated on two steps, running ``scripts/gen_gpio_defaults.py`` first to add the default blocks, then running ``make ship`` to generate the gds view for mag views.

LVL on ``caravel-signoff.gds`` and ``caravel.gds`` shows only differences in the mcon layer in the gpio_defaults
