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

=========================
Clamp List
=========================

============================ =========================== ====== ====== ====== ====== =====
Pad                          Instance                    Clamp connections
---------------------------- --------------------------- ---------------------------------
--                           --                          DRN1   SRC1   DRN2   SRC2   B2B
============================ =========================== ====== ====== ====== ====== =====
sky130_ef_io__vddio_hvc_pad  \mgmt_vddio_hvclamp_pad[0]  vddio  vssio
sky130_ef_io__vddio_hvc_pad  \mgmt_vddio_hvclamp_pad[1]  vddio  vssio
sky130_ef_io__vssio_hvc_pad  \mgmt_vssio_hvclamp_pad[0]  vddio  vssio
sky130_ef_io__vssio_hvc_pad  \mgmt_vssio_hvclamp_pad[1]  vddio  vssio
sky130_ef_io__vdda_hvc_pad   mgmt_vdda_hvclamp_pad       vdda   vssa
sky130_ef_io__vssa_hvc_pad   mgmt_vssa_hvclamp_pad       vdda   vssa
sky130_ef_io__vdda_hvc_pad   user1_vdda_hvclamp_pad      vdda1  vssa1
sky130_ef_io__vssa_hvc_pad   user1_vssa_hvclamp_pad      vdda1  vssa1
sky130_ef_io__vdda_hvc_pad   user2_vdda_hvclamp_pad      vdda2  vssa2
sky130_ef_io__vssa_hvc_pad   user2_vssa_hvclamp_pad      vdda2  vssa2
sky130_ef_io__vccd_lvc_pad   mgmt_vccd_lvclamp_pad       vccd   vssio  vccd   vssd   vssa
sky130_ef_io__vssd_lvc_pad   mgmt_vssd_lvclmap_pad       vccd   vssio  vccd   vssd   vssa
sky130_ef_io__vccd_lvc_pad   user1_vccd_lvclamp_pad      vccd1  vssd1  vccd1  vssd   vssio
sky130_ef_io__vssd_lvc_pad   user1_vssd_lvclmap_pad      vccd1  vssd1  vccd1  vssd   vssio
sky130_ef_io__vccd_lvc_pad   user2_vccd_lvclamp_pad      vccd2  vssd2  vccd2  vssd   vssio
sky130_ef_io__vssd_lvc_pad   user2_vssd_lvclmap_pad      vccd2  vssd2  vccd2  vssd   vssio
============================ =========================== ====== ====== ====== ====== =====

Overlay types used:
===================

1. hvc_pad:		vddio -> vssio
2. hvc_pad:		vdda  -> vssa
3. lvc_pad:		vccd  -> vssio,  vccd -> vssd    vssa
4. lvc_pad:		vccd  -> vssd, 	 vccd -> vssdG   vssio

**NOTE:**  

        Type (4) crosses domains, so that the local VCCD has a diode to the
        local VSSD and also to the global VSSD.  **BUT:**  Although vccd goes all the way
        around the chip in the form of vcchib, vssd does not, which makes the SRC2
        connection effectively unreachable in this configuration, so better to just
        change it to vssd1 and vssd2 for the respective domains.

New overlay types created:
==========================

1. sky130_ef_io__vddio_hvc_clamped_pad:	sky130_ef_io__vddio_hvc_pad + overlay (1)
2. sky130_ef_io__vssio_hvc_clamped_pad:	sky130_ef_io__vssio_hvc_pad + overlay (1)
3. sky130_ef_io__vdda_hvc_clamped_pad:	sky130_ef_io__vdda_hvc_pad  + overlay (2)
4. sky130_ef_io__vssa_hvc_clamped_pad:	sky130_ef_io__vssa_hvc_pad  + overlay (2)
5. sky130_ef_io__vccd_lvc_clamped_pad:	sky130_ef_io__vccd_lvc_pad  + overlay (3)
6. sky130_ef_io__vssd_lvc_clamped_pad:	sky130_ef_io__vssd_lvc_pad  + overlay (3)
7. sky130_ef_io__vccd_lvc_clamped2_pad:	sky130_ef_io__vccd_lvc_pad  + overlay (4)
8. sky130_ef_io__vssd_lvc_clamped2_pad:	sky130_ef_io__vssd_lvc_pad  + overlay (4)
9. sky130_ef_io__vccd_lvc_clamped3_pad:	sky130_ef_io__vccd_lvc_pad  + overlay (4)
10. sky130_ef_io__vssd_lvc_clamped3_pad: sky130_ef_io__vssd_lvc_pad + overlay (4)

**NOTE:**

        The ``clamped3`` pads correspond to a change in the Caravel design for MPW-2,
        in which the vccd/vssd domain has continuous supply rings around the chip
        periphery.  The pad connection of these two pads does not connect to the padframe
        power rings, but connects to a separate set of power rails in the chip core.
