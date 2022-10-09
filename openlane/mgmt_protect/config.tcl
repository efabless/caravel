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


set ::env(DESIGN_NAME) mgmt_protect
set ::env(ROUTING_CORES) 24
set ::env(DESIGN_IS_CORE) 1
set ::env(PDK) "sky130A"

set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]
set ::env(BASE_SDC_FILE) [glob $::env(DESIGN_DIR)/base.sdc]

# set ::env(RUN_KLAYOUT) 1

# virtual clock
set ::env(CLOCK_PERIOD) 8
set ::env(CLOCK_PORT) ""

# Synthesis
set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

set ::env(CLOCK_TREE_SYNTH) 0

## Floorplan
set ::env(FP_SIZING) absolute
# set ::env(DIE_AREA) "0 0 1100 160" 320um to the left
set ::env(DIE_AREA) "0 0 1900 160"

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
set ::env(PL_TARGET_DENSITY) 0.11
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1

set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 25

## Routing 
set ::env(RT_MIN_LAYER) "met1"
set ::env(RT_MAX_LAYER) "met4"
set ::env(GRT_ADJUSTMENT) 0.05
set ::env(GRT_OVERFLOW_ITERS) 250
set ::env(GRT_ALLOW_CONGESTION) 0

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1

# set ::env(GLB_RT_OBS) "\
# 	met4 390.000 5.26500 414.00 152.68000,\
# 	met4 465.0000 5.17000 487.00 153.09000,\
# 	met4 540.0000 5.03500 563.0000 152.73000,\
# 	met4 691.0000 4.85500 713.0000 152.55000,\
# 	met4 766.0000 4.88500 788.0000 152.58000,\
# 	met4 841.0000 5.04500 864.0000 152.74000,\
# 	met4 916.0000 5.35500 946.0000 153.46500,\
# 	met4 992.0000 5.20000 1006.0000 152.56000,\
# 	met4 1066.0000 4.90000 1096.0000 153.01000,\
# 	met4 612.0000 5.26500 638.0000 153.08000,\
# 	met4 990.00000 5.17000 1022.000 153.39500"

# set ::env(GRT_OBS) "met5 0 0 1900 160"

## Diode Insertion 
set ::env(DIODE_INSERTION_STRATEGY) 4

## Internal Macros 
set ::env(MACRO_PLACEMENT_CFG) [glob $::env(DESIGN_DIR)/macro_placement.cfg]

set ::env(VERILOG_FILES_BLACKBOX) [glob $::env(DESIGN_DIR)/macros/verilog/*.v]

set ::env(EXTRA_LEFS) [glob $::env(DESIGN_DIR)/macros/lef/*.lef]

set ::env(EXTRA_GDS_FILES) [glob $::env(DESIGN_DIR)/macros/gds/*.gds]

## SIGNOFF
# set ::env(PRIMARY_SIGNOFF_TOOL) "klayout"

## DRC
set ::env(QUIT_ON_MAGIC_DRC) 0
set ::env(KLAYOUT_DRC_KLAYOUT_GDS) 1

## LVS
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(MAGIC_EXT_USE_GDS) 0

# mprj_dat_i_user
# mprj_ack_i_user
# user_irq_core
# set ::env(DONT_TOUCH_PORTS) "la_data_out_core\[*\] mprj_ack_i_user mprj_dat_i_user\[*\] user_irq_core\[*\]"
set ::env(RSZ_DONT_TOUCH_RX) {la_data_out_core\[.*\]|mprj_ack_i_user|mprj_dat_i_user\[.*\]|user_irq_core\[.*\]}
