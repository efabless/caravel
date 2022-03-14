.. |ss| raw:: html

 <strike>

.. |se| raw:: html

 </strike>

.. raw:: html
   
   <!---
   # SPDX-FileCopyrightText: D. Mitch Bailey
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

Device level LVS instructions for mpw4 caravel using slot-002
=====================================================
These instructions use the ``verilog/gl/*.v`` (except caravel.v and gpio_default_0403.v) files from the caravel repo, ``jobs/tapeout/*/outputs/gds/caravel_*.gds.gz.*.split`` from the mpw-4/slot-002 repo, 
and the ``STD_CELL_LIBRARY`` spice from the PDK by default. 
Additional verilog and spice files may be included using the ``LVS_EXTRA_GATE_LEVEL_VERILOG`` or ``LVS_EXTRA_SPICE``/``LVS_EXTRA_STD_CELL_LIBRARY`` 
environment variables, respectively, in each circuit's ``config.tcl``.

Requirements
============

SRAM modules are required.

In the ``openlane`` installation directory, ``export INSTALL_SRAM=yes`` and then ``make build-pdk``.

Use ``magic 8.3.241`` and ``netgen 1.5.213``.

Use ``https://github.com/efabless/caravel.git commit 31e3d9c1063d4ec987760fb34579e123c9196e8d``.

Execution
=========

From within docker, the following ``run_lvs`` script may be used::

 #! /bin/bash

 if [[ ! -f ../gds/$1.gds ]]; then
        gunzip ../gds/$1.gds
 fi

 flow.tcl -design $1 -tag lvs -lvs -gds ../gds/$1.gds -net ../verilog/gl/$1.v

For example, in the ``openlane`` directory, ``run_lvs chip_io`` will run LVS on the `chip_io` circuit.


Results
=======

The following error 
```
Device pdiodec does not have a compatible substrate node!
```
occurs in these cells.
``K0_sky130_ef_io__vccd_lvc_clamped3_pad``
``K0_sky130_ef_io__vssd_lvc_clamped3_pad``
``K0_sky130_ef_io__vssd_lvc_clamped_pad``
``K0_sky130_ef_io__vccd_lvc_clamped_pad``
It can be fixed by changing the DIODE recognition layer ``81/23`` from

to

These cells have pins that need to be separated.
Extracting K0_sky130_ef_io__vssio_hvc_clamped_pad into K0_sky130_ef_io__vssio_hvc_clamped_pad.ext:
Warning:  Ports "VSSIO" and "VSSIO_Q" are electrically shorted.
Extracting K0_sky130_ef_io__vddio_hvc_clamped_pad into K0_sky130_ef_io__vddio_hvc_clamped_pad.ext:
Warning:  Ports "VDDIO" and "VDDIO_Q" are electrically shorted.

``gpio_defaults_block``
``gpio_defaults_block_34`` should be converted from ``gpio_defaults_block`` to ``gpio_defaults_block_34`` in verilog. It is not because the `mag` file instance name is ``gpio_defaults_defaults_block_34`` instead of ````gpio_defaults_block_34``.
Modified ``caravel.v`` to match.

Layout has substrate short between ``vssd_core`` and ``vssd1_core``.
Shorted via ``assign`` in ``caravel.v`` to compensate.

simple_por in layout has only ``vss`` terminal. verilog has ``vss3v3`` and ``vss1v8``
Change verilog ``.vss1v8(vssd_core)`` to ``.vss(vssio_core)``



Everything after this line applies to the original mpw-one caravel. Update is pending.

Here are the required additions to the config.tcl files::

 cat >> chip_io/config.tcl <<"+chip_io"
 
 set ::env(LVS_EXTRA_STD_CELL_LIBRARY) "
       \$::env(PDK_ROOT)/\$::env(PDK)/libs.ref/sky130_fd_io/spice/sky130_ef_io.spice
       \$::env(PDK_ROOT)/\$::env(PDK)/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice"
 
 +chip_io
 
 cat >> gpio_control_block/config.tcl <<"+gpio_control_block"

 set ::env(LVS_EXTRA_GATE_LEVEL_VERILOG) "
       $script_dir/../../verilog/gl/gpio_logic_high.v"

 +gpio_control_block


 cat >> mgmt_core/config.tcl <<"+mgmt_core"

 set ::env(LVS_EXTRA_GATE_LEVEL_VERILOG) "
       $script_dir/../../verilog/gl/DFFRAM.v
       $script_dir/../../verilog/gl/digital_pll.v"

 +mgmt_core


 cat >> mgmt_protect/config.tcl <<"+mgmt_protect"

 set ::env(LVS_EXTRA_STD_CELL_LIBRARY) "
       \$::env(PDK_ROOT)/\$::env(PDK)/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice"

 set ::env(LVS_EXTRA_GATE_LEVEL_VERILOG) "
       $script_dir/../../verilog/gl/mprj_logic_high.v
       $script_dir/../../verilog/gl/mprj2_logic_high.v
       $script_dir/../../verilog/gl/mgmt_protect_hv.v"

 +mgmt_protect


 cat >> storage/config.tcl <<"+storage"

 set ::env(LVS_EXTRA_SPICE) "
       \$::env(PDK_ROOT)/\$::env(PDK)/libs.ref/sky130_sram_macros/spice/sram_1rw1r_32_256_8_sky130.spice"

 +storage

chip_io
=======

1. Add ``sky130_fd_pr__esd_nfet_g5v0d10v5`` to ``$PDK_ROOT/sky130/libs.tech/netgen/sky130A_setup.tcl``.

2. The ``sky130_fd_pr__nfet_g5v0d10v5``, ``sky130_fd_pr__esd_nfet_g5v0d10v50``, and ``sky130_fd_pr__pfet_g5v0d10v5`` have ``area topography perim`` 
   properties that are not extracted.
   One possible soloution is to ignore these parameters in the ``$PDK_ROOT/sky130/libs.tech/netgen/sky130A_setup.tcl`` file::

    property "-circuit2 $dev" delete as ad ps pd mult sa sb sd nf nrd nrs area topography perim

3. ``sky130_fd_pr__res_generic_m1`` and ``sky130_fd_pr__res_generic_m2`` are missing parameters in the source netlist.
   Add them with this script::
   
    cat > add_res_parameters.sed <<-"+res_generic"
     /SUBCKT sky130_fd_io__tk_em1s/,/ENDS/s/^R.*sky130_fd_pr__res_generic_m1$/& w=260000u l=10000u/
     /SUBCKT sky130_fd_io__tk_em2s/,/ENDS/s/^R.*sky130_fd_pr__res_generic_m2$/& w=650000u l=10000u/
     /SUBCKT sky130_fd_io__tk_em2o/,/ENDS/s/^R.*sky130_fd_pr__res_generic_m2$/& w=650000u l=10000u/
     /SUBCKT sky130_fd_io__signal_5_sym_hv_local_5term/,/ENDS/s/^R.*sky130_fd_pr__res_generic_m1$/& w=20000u l=5000u/
     s/sky130_fd_pr__res_generic_m5$/& w=2.5284e+08u l=100000u/
    +res_generic
    
    sed -i.bak -f add_res_parameters.sed $::env(PDK_ROOT)/sky130A/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice

4. Size errors::
 
    sky130_fd_io__hvsbt_nor layout 2/0.7 source 1/0.7 
    sky130_fd_io__signal_5_sym_hv_local_5term  nmos layout 5.75/0.6 source 5.4/0.6

Extraction problems:
====================
``K0_sky130_ef_io__vccd_lvc_clamped3_pad``
``K0_sky130_ef_io__vssd_lvc_clamped3_pad``
``K0_sky130_ef_io__vssd_lvc_clamped_pad``
``K0_sky130_ef_io__vccd_lvc_clamped_pad``
```
Device pdiodec does not have a compatible substrate node!
```
``K0_sky130_ef_io__vddio_hvc_clamped_pad``
```
Warning:  Ports "VDDIO" and "VDDIO_Q" are electrically shorted.
```
``K0_sky130_ef_io__vddio_hvc_clamped_pad``
```
Warning:  Ports "VDDIO" and "VDDIO_Q" are electrically shorted.
```


storage
=======

1. The parasitic devices in the ``sram_1rw1r_32_256_8_sky130`` modules do not match. 

   Use the following sed command to remove them from both netlists (replace <tag>)::

    TAG=<tag> 
    
    sed -i.bak \
    -e 's/^X.*L=0.08/* &/' \
    -e 's/^X.*l=80000u/* &/' \
    -e 's/^X.*w=70000u/* &/' storage/runs/$TAG/results/magic/storage.gds.spice \
    $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/spice/sram_1rw1r_32_256_8_sky130.spice

2. Disconnected substrate connections yield mismatches. 
   
   |ss| NB: Merging netgen pull request #33 will remedy the problem without having to explicity flatten the suggested cells. |se|
   
   The ``pmos_m1_w0_550_sli_dli`` is automatically flattened into ``precharge_1``, but the ``VSUBS`` connection is not recognized as a disconnected node. 
   Maybe recalculate connectivity after flattening in netgen?::

    .subckt pmos_m1_w0_550_sli_dli D S G w_n59_n29# VSUBS
    X0 D G S w_n59_n29# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=550000u l=150000u
    .ends
    
    .subckt precharge_1 bl br en_bar vdd VSUBS
    Xpmos_m1_w0_550_sli_dli_0 br vdd en_bar vdd VSUBS pmos_m1_w0_550_sli_dli
    Xpmos_m1_w0_550_sli_dli_1 vdd bl en_bar vdd VSUBS pmos_m1_w0_550_sli_dli
    Xpmos_m1_w0_550_sli_dli_2 br bl en_bar vdd VSUBS pmos_m1_w0_550_sli_dli
    .ends

   This looks ok,::

    Subcircuit summary:
    Circuit 1: precharge_1                     |Circuit 2: precharge_1
    -------------------------------------------|-------------------------------------------
    sky130_fd_pr__pfet_01v8 (3)                |sky130_fd_pr__pfet_01v8 (3)
    Number of devices: 3                       |Number of devices: 3
    Number of nets: 4                          |Number of nets: 4
    ---------------------------------------------------------------------------------------
    Resolving automorphisms by property value.
    Resolving automorphisms by pin name.
    Netlists match uniquely.
    Circuits match correctly.
    
    Subcircuit pins:
    Circuit 1: precharge_1                     |Circuit 2: precharge_1
    -------------------------------------------|-------------------------------------------
    en_bar                                     |en_bar
    vdd                                        |vdd
    bl                                         |bl
    br                                         |br
    VSUBS                                      |(no matching pin)
    ---------------------------------------------------------------------------------------
    Cell pin lists are equivalent.
    Device classes precharge_1 and precharge_1 are equivalent.

   but later::

    Subcircuit summary:
    Circuit 1: precharge_array_0               |Circuit 2: precharge_array_0
    -------------------------------------------|-------------------------------------------
    precharge_1 (65)                           |precharge_1 (65)
    Number of devices: 65                      |Number of devices: 65
    Number of nets: 133 **Mismatch**           |Number of nets: 197 **Mismatch**
    ---------------------------------------------------------------------------------------
    NET mismatches: Class fragments follow (with fanout counts):
    Circuit 1: precharge_array_0               |Circuit 2: precharge_array_0
    
    ---------------------------------------------------------------------------------------
    Net: VSUBS                                 |Net: dummy_133
      precharge_1/VSUBS = 65                   |  precharge_1/proxyVSUBS = 1
                                               |
    (no matching net)                          |Net: dummy_134
                                               |  precharge_1/proxyVSUBS = 1
                                               |
    (no matching net)                          |Net: dummy_135
                                               |  precharge_1/proxyVSUBS = 1
                                               |
   
   This, in turn, results in a drastic difference in the net counts at higher hierarchies::
   
     Circuit bank contains 10905 device instances.
      Class: sky130_fd_pr__nfet_01v8 instances: 544
      Class: pinv_dec              instances: 302
      Class: single_level_column_mux_array_0 instances:   1
      Class: pinv_dec_0            instances: 256
      Class: pinvbuf               instances:   2
      Class: write_mask_and_array  instances:   1
      Class: sky130_fd_pr__pfet_01v8 instances: 544
      Class: precharge_0           instances:  65
      Class: precharge_1           instances:  65
      Class: sky130_fd_bd_sram__openram_dp_cell_dummy instances: 130
      Class: sky130_fd_bd_sram__openram_dp_cell_replica instances: 258
      Class: nand3_dec             instances: 272
      Class: single_level_column_mux_array instances:   1
      Class: nand2_dec             instances: 272
      Class: sky130_fd_bd_sram__openram_dp_cell instances: 8192
    Circuit contains 19467 nets.
    
    Circuit 1 contains 10905 devices, Circuit 2 contains 10905 devices.
    Circuit 1 contains 2331 nets,    Circuit 2 contains 19463 nets. *** MISMATCH ***
   
   Temporary solution is to flatten all cells with disconnected ports by adding the following to ``$PDK_ROOT/sky130/libs.tech/netgen/sky130A_setup.tcl``.
   (Warning: much longer run times)::

    flatten class precharge_array "-circuit1 precharge_0"
    flatten class precharge_array_0 "-circuit1 precharge_1"
    flatten class port_data "-circuit1 precharge_array"
    flatten class port_data_0 "-circuit1 precharge_array_0"
    flatten class dummy_array "-circuit1 sky130_fd_bd_sram__openram_dp_cell_dummy"
    flatten class replica_column "-circuit1 sky130_fd_bd_sram__openram_dp_cell_dummy"
    flatten class replica_column "-circuit1 sky130_fd_bd_sram__openram_dp_cell_replica"
    flatten class replica_column_0 "-circuit1 sky130_fd_bd_sram__openram_dp_cell_dummy"
    flatten class replica_column_0 "-circuit1 sky130_fd_bd_sram__openram_dp_cell_replica"
    flatten class replica_bitcell_array "-circuit1 dummy_array"
    flatten class replica_bitcell_array "-circuit2 dummy_array"
    flatten class bitcell_array "-circuit1 sky130_fd_bd_sram__openram_dp_cell"
    flatten class bitcell_array "-circuit2 sky130_fd_bd_sram__openram_dp_cell"

   This gives us the following results::

    Result: Netlists do not match.
    Logging to file "storage/runs/cvc/results/lvs/storage.lvs.gds.log" disabled
    LVS Done.
    LVS reports:
        net count difference = 62
        device count difference = 0
        unmatched nets = 7937
        unmatched devices = 0
        unmatched pins = 0
        property failures = 0

3. ``control_logic_r`` has been flattened in the layout, but not in the netlist.
   
   NB: Merging netgen pull request #36 (version 1.5.207 or later) will remedy the problem without having to explicity flatten the suggested cells::

    Subcircuit summary:
    Circuit 1: control_logic_r                 |Circuit 2: control_logic_r
    -------------------------------------------|-------------------------------------------
    sky130_fd_pr__pfet_01v8 (87)               |sky130_fd_pr__pfet_01v8 (5) **Mismatch**
    sky130_fd_pr__nfet_01v8 (87)               |sky130_fd_pr__nfet_01v8 (5) **Mismatch**
    (no matching element)                      |dff_buf_0 (1)
    (no matching element)                      |pinv_6 (1)
    (no matching element)                      |pinv_0 (1)
    (no matching element)                      |pand2_0 (2)
    (no matching element)                      |pdriver_2 (1)
    (no matching element)                      |pand3_0 (1)
    (no matching element)                      |pinv_20 (45)
    (no matching element)                      |pnand2_1 (1)
    (no matching element)                      |pdriver_5 (1)
    Number of devices: 174 **Mismatch**        |Number of devices: 64 **Mismatch**
    Number of nets: 102 **Mismatch**           |Number of nets: 65 **Mismatch**
    ---------------------------------------------------------------------------------------
    Flattening instances of pinv_0 in cell control_logic_r makes a better match
    Flattening instances of pinv_6 in cell control_logic_r makes a better match
    Flattening instances of pinv_20 in cell control_logic_r makes a better match
    Flattening instances of pnand2_1 in cell control_logic_r makes a better match
    Making another compare attempt.

    Subcircuit summary:
    Circuit 1: control_logic_r                 |Circuit 2: control_logic_r
    -------------------------------------------|-------------------------------------------
    sky130_fd_pr__pfet_01v8 (87)               |sky130_fd_pr__pfet_01v8 (54) **Mismatch**
    sky130_fd_pr__nfet_01v8 (87)               |sky130_fd_pr__nfet_01v8 (54) **Mismatch**
    (no matching element)                      |dff_buf_0 (1)
    (no matching element)                      |pand2_0 (2)
    (no matching element)                      |pdriver_2 (1)
    (no matching element)                      |pand3_0 (1)
    (no matching element)                      |pdriver_5 (1)
    Number of devices: 174 **Mismatch**        |Number of devices: 114 **Mismatch**
    Number of nets: 102 **Mismatch**           |Number of nets: 66 **Mismatch**
    ---------------------------------------------------------------------------------------
    NET mismatches: Class fragments follow (with fanout counts):
    Circuit 1: control_logic_r                 |Circuit 2: control_logic_r

   netgen only does partial flattening, resulting in a mismatch. A temporary solution is to explicitly flatten the cells in ``control_logic_r`` 
   by adding the following to ``$PDK_ROOT/sky130/libs.tech/netgen/sky130A_setup.tcl``::

    flatten class dff_buf_array_0 "-circuit2 dff_buf_0"
    flatten class pand2_0 "-circuit2 pdriver_0"
    flatten class pand3_0 "-circuit2 pdriver_4"

    flatten class control_logic_r "-circuit2 pand2_0"
    flatten class control_logic_r "-circuit2 pdriver_2"
    flatten class control_logic_r "-circuit2 pand3_0"
    flatten class control_logic_r "-circuit2 pdriver_5"

4. Several of the power supplies to the memory cells are not extracted correctly. 
   Use the following sed command to remove them from both netlists (replace <tag>)::

    TAG=<tag> 
    
    cat >> vdd.sed <<+vdd_changes
    s/vdd_uq1854/vdd/g
    s/vdd_uq1982/vdd/g
    s/vdd_uq3134/vdd/g
    s/vdd_uq1918/vdd/g
    s/vdd_uq3326/vdd/g
    s/vdd_uq3710/vdd/g
    s/vdd_uq3838/vdd/g
    s/vdd_uq2622/vdd/g
    s/vdd_uq3070/vdd/g
    s/vdd_uq2558/vdd/g
    s/vdd_uq4030/vdd/g
    s/vdd_uq3902/vdd/g
    s/vdd_uq2686/vdd/g
    s/vdd_uq3774/vdd/g
    s/vdd_uq2238/vdd/g
    s/vdd_uq2302/vdd/g
    s/vdd_uq2174/vdd/g
    s/vdd_uq2366/vdd/g
    s/vdd_uq2750/vdd/g
    s/vdd_uq2430/vdd/g
    s/vdd_uq3582/vdd/g
    s/vdd_uq3646/vdd/g
    s/vdd_uq4094/vdd/g
    s/vdd_uq3006/vdd/g
    s/vdd_uq2878/vdd/g
    s/vdd_uq3198/vdd/g
    s/vdd_uq3454/vdd/g
    s/vdd_uq2494/vdd/g
    s/vdd_uq3390/vdd/g
    s/vdd_uq3518/vdd/g
    s/vdd_uq2046/vdd/g
    +vdd_changes
    
    sed -i.bak2 -f vdd.sed storage/runs/$TAG/results/magic/storage.gds.spice

   This gives us the following results::

    Logging to file "storage/runs/cvc/results/lvs/storage.lvs.gds.log" disabled
    LVS Done.
    LVS reports:
        net count difference = 0
        device count difference = 0
        unmatched nets = 0
        unmatched devices = 0
        unmatched pins = 152
        property failures = 0

5. Looking at the details, we can see the bus indices connected in reverse order::

    Subcircuit pins:
    Circuit 1: storage                         |Circuit 2: storage
    -------------------------------------------|-------------------------------------------
    mgmt_rdata[0]                              |mgmt_rdata[31] **Mismatch**
    ...
    mgmt_rdata[31]                             |mgmt_rdata[0] **Mismatch**
    mgmt_rdata_ro[0]                           |mgmt_rdata_ro[31] **Mismatch**
    ...
    mgmt_rdata_ro[31]                          |mgmt_rdata_ro[0] **Mismatch**
    mgmt_rdata[32]                             |mgmt_rdata[63] **Mismatch**
    ...
    mgmt_rdata[63]                             |mgmt_rdata[32] **Mismatch**
    ...
    mgmt_addr_ro[0]                            |mgmt_addr_ro[7] **Mismatch**
    ...
    mgmt_addr_ro[7]                            |mgmt_addr_ro[0] **Mismatch**
    ...
    mgmt_wen_mask[0]                           |mgmt_wen_mask[3] **Mismatch**
    mgmt_wen_mask[1]                           |mgmt_wen_mask[2] **Mismatch**
    mgmt_wen_mask[2]                           |mgmt_wen_mask[1] **Mismatch**
    mgmt_wen_mask[3]                           |mgmt_wen_mask[0] **Mismatch**
    ...
    mgmt_wen_mask[4]                           |mgmt_wen_mask[7] **Mismatch**
    mgmt_wen_mask[5]                           |mgmt_wen_mask[6] **Mismatch**
    mgmt_wen_mask[6]                           |mgmt_wen_mask[5] **Mismatch**
    mgmt_wen_mask[7]                           |mgmt_wen_mask[4] **Mismatch**
    mgmt_wdata[0]                              |mgmt_wdata[31] **Mismatch**
    ...
    mgmt_wdata[31]                             |mgmt_wdata[0] **Mismatch**
    mgmt_addr[0]                               |mgmt_addr[7] **Mismatch**
    ...
    mgmt_addr[7]                               |mgmt_addr[0] **Mismatch**

   The bus signals are reversed. Reversing the bus order in the ``sram_1rw1r_32_256_8_sky130.spice`` file fixes this. 
   Here's a script ``reorder_bus.awk`` that will do that::

    BEGIN {
           IGNORECASE = "true";
    }
    /^.subckt/ && $2 == TOP {
           lastBase = "";
           delete busStack;
           printf("%s %s", $1, $2);
           for ( pin_it = 3; pin_it <= NF; pin_it++ ) {
                   split($pin_it, busToken, /[\[\]]/);
                   base = busToken[1];
                   if ( base != lastBase && length(busStack) > 0 ) {
                           PrintBus(busStack);
                           delete busStack;
                   }
                   busStack[length(busStack)] = $pin_it;
                   lastBase = base;
           }
           PrintBus(busStack);  # print last signal or bus
           print("");
           next;
    }
     {
           print;
    }
    function PrintBus(theBusStack) {
           for ( bus_it = length(theBusStack) - 1; bus_it >= 0; bus_it-- ) {
                   printf(" %s", theBusStack[bus_it]);
           }
    }

   Execute ``awk -f reorder_bus.awk -v TOP=sram_1rw1r_32_256_8_sky130 $PDK_ROOT/sky130A/libs.ref/sky130A_sram_macros/spice/sram_1rw1r_32_256_8_sky130.spice > <new_file>``, and then use ``<new_file>`` for LVS.

6. Next, the ``dff`` subcircuit has an extra pin, ``ON``, on the layout side. This has connections within the cell, but not at higher levels. Here's the result::

    Subcircuit pins:
    Circuit 1: dff                             |Circuit 2: dff
    -------------------------------------------|-------------------------------------------
    Q                                          |Q
    D                                          |D
    clk                                        |clk
    ON                                         |(no matching pin)
    vdd                                        |vdd
    gnd                                        |gnd
    ON                                         |(no matching pin)
    ---------------------------------------------------------------------------------------
    Cell pin lists for dff and dff altered to match.

   ``netgen`` sees this as a match, but at higher hierarchies, we get unmatched signals. 
   There is a matching node on the source side, but it's not a pin. So we get::

    Subcircuit summary:
    Circuit 1: dff_buf_0                       |Circuit 2: dff_buf_0
    -------------------------------------------|-------------------------------------------
    dff (1)                                    |dff (1)
    pinv_1 (1)                                 |pinv_1 (1)
    pinv_2 (1)                                 |pinv_2 (1)
    Number of devices: 3                       |Number of devices: 3
    Number of nets: 8 **Mismatch**             |Number of nets: 7 **Mismatch**
    ---------------------------------------------------------------------------------------
    NET mismatches: Class fragments follow (with fanout counts):
    Circuit 1: dff_buf_0                       |Circuit 2: dff_buf_0
   
    ---------------------------------------------------------------------------------------
    Net: D                                     |Net: D
      dff/D = 1                                |  dff/D = 1
                                               |
    Net: clk                                   |Net: clk
      dff/clk = 1                              |  dff/clk = 1
                                               |
    Net: dff_0/ON                              |(no matching net)
      dff/ON = 1                               |
    ---------------------------------------------------------------------------------------

   One solution would be to change netgen processing to flatten cells with pin lists that have been altered to match. 
   However, a temporary solution is to explicitly flatten the ``dff`` cells by adding adding the following 
   to ``$PDK_ROOT/sky130/libs.tech/netgen/sky130A_setup.tcl``::

    flatten class wmask_dff "-circuit1 dff"
    flatten class data_dff "-circuit1 dff"
    flatten class dff_buf_0 "-circuit1 dff"
    flatten class col_addr_dff "-circuit1 dff"
    flatten class row_addr_dff "-circuit1 dff"

gpio_control_block
==================

``vssd`` and ``vssd1`` are connected via pwell. 
Enhancements to magic extraction routine/rule file may permit separate extracted connectivity in the future.
As a work-aroung add the following to ``gpio_control_block.v`` to virtually connect the nets in verilog::

 assign vssd1 = vssd;

Unfortunately, this still results in port name mismatch::

 vccd1                                      |vccd1
 vssd                                       |vssd1 **Mismatch**
 vccd                                       |vccd
 ---------------------------------------------------------------------------------------
 Cell pin lists for gpio_control_block and gpio_control_block altered to match.
 Cells failed matching, or top level cell failed pin matching.
 
The solution is to change the port order definition in ``gpio_control_block.v``::

 Before:
   ...
   input vccd;
   input vssd;
   input vccd1;
   input vssd1;
   output [2:0] pad_gpio_dm;
   ...
   
 After:
   ...
   input vccd;
   input vssd1;
   input vccd1;
   input vssd;
   output [2:0] pad_gpio_dm;
   ...

This is good enough to give us a match::

 vccd1                                      |vccd1
 vssd                                       |vssd
 vccd                                       |vccd
 ---------------------------------------------------------------------------------------
 Cell pin lists are equivalent.
 Device classes gpio_control_block and gpio_control_block are equivalent.
 Circuits match uniquely.

mgmt_protect_hv, sky130_fd_sc_hvl__lsbufhv2lv_1_wrapped
=======================================================

The library spice for the level shifters is incorrect. The following patch will fix it (and similar problems)::

 sed -i.bak \
 -e '/^.subckt sky130_fd_sc_hvl__lsbufhv2lv_1/,/^.ends/s/a_30_443#/VPWR/g' \
 -e '/^.subckt sky130_fd_sc_hvl__lsbufhv2lv_1/,/^.ends/s/a_187_207#/VGND/g' \
 -e '/^.subckt sky130_fd_sc_hvl__lsbuflv2hv_1/,/^.ends/s/a_1606_563#/VPWR/g' \
 -e '/^.subckt sky130_fd_sc_hvl__lsbuflv2hv_1/,/^.ends/s/a_686_151#/VGND/g' $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice

The layout from which the spice file was created contained 2 separate ports for VPWR and VGND each. 
One of each of the duplicate pins was extracted as an arbitary net. 
At a higher level in the hierarchy, these ports must be connected, so it is sufficient to rename the arbitrary net in the spice file.
