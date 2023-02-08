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
set ::env(DIE_AREA) "0 0 1920 140"

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
set ::env(PL_TARGET_DENSITY) 0.08
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 320

set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 40
set ::env(PL_TIME_DRIVEN) 0
set ::env(PL_ROUTABILITY_DRIVEN) 1

## Routing 
set ::env(RT_MIN_LAYER) "met1"
set ::env(RT_MAX_LAYER) "met4"
set ::env(GRT_ADJUSTMENT) 0.3
set ::env(GRT_OVERFLOW_ITERS) 80
set ::env(GRT_ALLOW_CONGESTION) 1

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 320


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
set ::env(DIODE_INSERTION_STRATEGY) 6
set ::env(GRT_ANT_ITERS) 50
set ::env(GRT_MAX_DIODE_INS_ITERS) 50
# set ::env(USE_ARC_ANTENNA_CHECK) 0
# set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 150

set ::env(MAGIC_DEF_LABELS) 0