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
# SPDX-License-Identifier: Apache-2.0

#Change this to the directory of caravel
set ::env(CARAVEL_ROOT) $::env(DESIGN_DIR)/../..

set ::env(DESIGN_NAME) mgmt_protect
set ::env(ROUTING_CORES) 24
set ::env(DESIGN_IS_CORE) 1
set ::env(PDK) "sky130A"

set ::env(VERILOG_FILES) "$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
        $::env(CARAVEL_ROOT)/verilog/rtl/mgmt_protect.v"

set ::env(BASE_SDC_FILE) [glob $::env(DESIGN_DIR)/base.sdc]
set ::env(RCX_SDC_FILE) [glob $::env(DESIGN_DIR)/rcx.sdc]

set ::env(RUN_KLAYOUT) 0

# virtual clock
set ::env(CLOCK_PERIOD) 10
set ::env(CLOCK_PORT) ""

# Synthesis
set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(SYNTH_BUFFERING) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(NO_SYNTH_CELL_LIST) [glob $::env(DESIGN_DIR)/no_synth.list] 
set ::env(DRC_EXCLUDE_CELL_LIST) [glob $::env(DESIGN_DIR)/drc_exclude.list]

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2120 160"

set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/pin_order.cfg]

set ::env(FP_PDN_VERTICAL_HALO) 10
set ::env(FP_PDN_HORIZONTAL_HALO) 10

set ::env(FP_IO_MIN_DISTANCE) 5

set ::env(BOTTOM_MARGIN_MULT) 2
set ::env(TOP_MARGIN_MULT) 2
set ::env(LEFT_MARGIN_MULT) 12
set ::env(RIGHT_MARGIN_MULT) 12

set ::env(FP_IO_VEXTEND) 2
set ::env(FP_IO_HEXTEND) 2

# set ::env(CELL_PAD) 0

## PDN 
set ::env(PDN_CFG) [glob $::env(DESIGN_DIR)/pdn.tcl]

set ::env(FP_PDN_UPPER_LAYER) met4

set ::env(VDD_NETS) "vccd vccd1 vccd2 vdda1 vdda2"
set ::env(GND_NETS) "vssd vssd1 vssd2 vssa1 vssa2"

set ::env(FP_PDN_MACRO_HOOKS) "\
    mprj_logic_high_inst vccd1 vssd1 vccd1 vssd1, \
    mprj2_logic_high_inst vccd2 vssd2 vccd2 vssd2, \
    powergood_check vccd vssd vccd vssd, \
    powergood_check vdda1 vssa1 vdda1 vssa1, \
    powergood_check vdda2 vssa2 vdda2 vssa2"

set ::env(FP_PDN_SKIPTRIM) 0

## Placement 
set ::env(PL_TARGET_DENSITY) 0.095
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 320

set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 25
set ::env(PL_TIME_DRIVEN) 0
set ::env(PL_ROUTABILITY_DRIVEN) 1

## Routing 
set ::env(RT_MIN_LAYER) "met1"
set ::env(RT_MAX_LAYER) "met4"
set ::env(GRT_ADJUSTMENT) 0.3
set ::env(GRT_OVERFLOW_ITERS) 280
set ::env(GRT_ALLOW_CONGESTION) 1

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 320

## prevent routing near the PDN to prevent DRCs at top-level
set ::env(GRT_OBS) "met4 60.970 0.000 63.870 160.000, \
        met4 136.220 0.000 140.120 160.000, \
        met4 211.470 0.000 214.370 160.000, \
        met4 286.720 0.000 289.620 160.000, \
        met4 361.970 0.000 364.870 160.000, \
        met4 437.220 0.000 440.120 160.000, \
        met4 512.470 0.000 515.370 160.000, \
        met4 587.720 0.000 590.620 160.000, \
        met4 662.970 0.000 665.870 160.000, \
        met4 738.220 0.000 741.120 160.000, \
        met4 813.470 0.000 816.370 160.000, \
        met4 888.720 0.000 891.620 160.000, \
        met4 963.970 0.000 966.870 160.000, \
        met4 1039.220 0.000 1042.120 160.000, \
        met4 1114.470 0.000 1117.370 160.000, \
        met4 1189.720 0.000 1192.620 160.000, \
        met4 1264.970 0.000 1267.870 160.000, \
        met4 1340.220 0.000 1343.120 160.000, \
        met4 1415.470 0.000 1418.370 160.000, \
        met4 1490.720 0.000 1493.620 160.000, \
        met4 1565.970 0.000 1568.870 160.000, \
        met4 1641.220 0.000 1644.120 160.000, \
        met4 1716.470 0.000 1719.370 160.000, \
        met4 1791.720 0.000 1794.620 160.000, \
        met4 1866.970 0.000 1869.870 160.000 \
        met4 24.070 0.000 26.970 160.000, \ 
        met4 99.320 0.000 102.220 160.000, \ 
        met4 174.570 0.000 177.470 160.000, \ 
        met4 249.820 0.000 252.720 160.000, \ 
        met4 325.070 0.000 327.970 160.000, \ 
        met4 400.320 0.000 403.220 160.000, \ 
        met4 475.570 0.000 478.470 160.000, \ 
        met4 550.820 0.000 553.720 160.000, \ 
        met4 626.070 0.000 628.970 160.000, \ 
        met4 701.320 0.000 704.220 160.000, \ 
        met4 776.570 0.000 779.470 160.000, \ 
        met4 851.820 0.000 854.720 160.000, \ 
        met4 927.070 0.000 929.970 160.000, \ 
        met4 1002.320 0.000 1005.220 160.000, \ 
        met4 1077.570 0.000 1080.470 160.000, \ 
        met4 1152.820 0.000 1155.720 160.000, \ 
        met4 1228.070 0.000 1230.970 160.000, \ 
        met4 1303.320 0.000 1306.220 160.000, \ 
        met4 1378.570 0.000 1381.470 160.000, \ 
        met4 1453.820 0.000 1456.720 160.000, \ 
        met4 1529.070 0.000 1531.970 160.000, \ 
        met4 1604.320 0.000 1607.220 160.000, \ 
        met4 1679.570 0.000 1682.470 160.000, \ 
        met4 1754.820 0.000 1757.720 160.000, \ 
        met4 1830.070 0.000 1832.970 160.000, \ 
        met4 705.420 0.000 708.320 160.000, \ 
        met4 780.670 0.000 783.570 160.000, \ 
        met4 855.920 0.000 858.820 160.000, \ 
        met4 931.170 0.000 934.070 160.000, \ 
        met4 333.270 0.000 336.170 160.000, \ 
        met4 383.270 0.000 386.170 160.000, \ 
        met4 1278.070 0.000 1280.970 160.000, \ 
        met4 1353.320 0.000 1356.220 160.000, \ 
        met4 1282.070 0.000 1284.970 160.000, \ 
        met4 1357.320 0.000 1360.220 160.000, \ 
        met4 1314.970 0.000 1317.870 160.000, \ 
        met4 1390.220 0.000 1393.120 160.000, \ 
        met4 1318.970 0.000 1321.870 160.000, \ 
        met4 1394.220 0.000 1397.120 160.000, \ 
        met4 742.320 0.000 745.220 160.000, \ 
        met4 817.570 0.000 820.470 160.000, \ 
        met4 892.820 0.000 895.720 160.000, \ 
        met4 968.070 0.000 970.970 160.000, \ 
        met4 354.170 0.000 357.070 160.000, \ 
        met4 404.170 0.000 407.070 160.000"


## Internal Macros 
set ::env(MACRO_PLACEMENT_CFG) [glob $::env(DESIGN_DIR)/macro_placement.cfg]

set ::env(VERILOG_FILES_BLACKBOX) "$::env(CARAVEL_ROOT)/verilog/rtl/mgmt_protect_hv.v \
        $::env(CARAVEL_ROOT)/verilog/rtl/mprj_logic_high.v \
        $::env(CARAVEL_ROOT)/verilog/rtl/mprj2_logic_high.v"

set ::env(EXTRA_LEFS) "$::env(CARAVEL_ROOT)/lef/mgmt_protect_hv.lef \
        $::env(CARAVEL_ROOT)/lef/mprj_logic_high.lef \
        $::env(CARAVEL_ROOT)/lef/mprj2_logic_high.lef"

set ::env(EXTRA_GDS_FILES) "$::env(CARAVEL_ROOT)/gds/mgmt_protect_hv.gds \
        $::env(CARAVEL_ROOT)/gds/mprj_logic_high.gds \
        $::env(CARAVEL_ROOT)/gds/mprj2_logic_high.gds"


## DRC
set ::env(QUIT_ON_MAGIC_DRC) 0

## LVS
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(MAGIC_EXT_USE_GDS) 0

set ::env(RSZ_DONT_TOUCH_RX) {la_data_out_core\[.*\]|mprj_ack_i_user|mprj_dat_i_user\[.*\]|user_irq_core\[.*\]}

## Antenna 
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(GRT_ANT_ITERS) 50
set ::env(GRT_MAX_DIODE_INS_ITERS) 50
# set ::env(USE_ARC_ANTENNA_CHECK) 0
# set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 150

set ::env(MAGIC_DEF_LABELS) 0