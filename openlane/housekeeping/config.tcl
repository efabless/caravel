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

# OR COMMIT: 182e733faa149c80f36cfd2198a83dcdeb7853ea
set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) "housekeeping"
set ::env(ROUTING_CORES) 12
set ::env(RUN_KLAYOUT) 0
set ::env(PDK) "sky130A"

set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_NET) "wb_clk_i csclk mgmt_gpio_in\[4\]"

set ::env(BASE_SDC_FILE) [glob $::env(DESIGN_DIR)/base.sdc]

## Synthesis 
set ::env(NO_SYNTH_CELL_LIST) [glob $::env(DESIGN_DIR)/no_synth.list] 
set ::env(SYNTH_STRATEGY) "AREA 0"

set ::env(SYNTH_MAX_FANOUT) 10
set ::env(SYNTH_MAX_TRAN) 1.25

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 370.230 550.950"

set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/pin_order.cfg]

set ::env(FP_IO_MIN_DISTANCE) 2

set ::env(CELL_PAD) 0
set ::env(FP_PDN_HPITCH) 153.18
set ::env(FP_PDN_HSPACING) 74.99
set ::env(FP_PDN_HOFFSET) 16.41

## Placement
set ::env(PL_TARGET_DENSITY) 0.31
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1

set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.3
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) "70"
set ::env(PL_RESIZER_MAX_CAP_MARGIN) "70"

set ::env(PL_RESIZER_HOLD_MAX_BUFFER_PERCENT) 50
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 14
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 1


## Routing 
set ::env(GLB_ADJUSTMENT) 0.06 
set ::env(GLB_OVERFLOW_ITERS) 100
set ::env(GRT_ALLOW_CONGESTION) 1
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1

set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.2
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) "70"
set ::env(GLB_RESIZER_MAX_CAP_MARGIN) "70"

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(GLB_ANT_ITERS) 15

## RCX
# Open-RCX Rules File
# set ::env(RCX_RULES) [glob $::env(DESIGN_DIR)/RCX/rules.openrcx.sky130A.nom.calibre]
# set ::env(RCX_RULES_MIN) [glob $::env(DESIGN_DIR)/RCX/rules.openrcx.sky130A.min.calibre]
# set ::env(RCX_RULES_MAX) [glob $::env(DESIGN_DIR)/RCX/rules.openrcx.sky130A.max.calibre]