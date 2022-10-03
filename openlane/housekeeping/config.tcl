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

set ::env(DESIGN_NAME) "housekeeping"
set ::env(ROUTING_CORES) 36
set ::env(RUN_KLAYOUT) 0

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
    $::env(DESIGN_DIR)/../../verilog/rtl/housekeeping_spi.v\
    $::env(DESIGN_DIR)/../../verilog/rtl/housekeeping.v"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "$::env(CLOCK_PORT) csclk mgmt_gpio_in\[4\]"

set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/template/housekeeping.def

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc

## Synthesis 
set ::env(NO_SYNTH_CELL_LIST) $::env(DESIGN_DIR)/no_synth.list 
set ::env(SYNTH_STRATEGY) "AREA 0"

set ::env(SYNTH_MAX_FANOUT) 7

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 300.230 550.950"

set ::env(DPL_CELL_PADDING) 2
set ::env(GPL_CELL_PADDING) 2

## Routing 
set ::env(GRT_ADJUSTMENT) 0.06
set ::env(GRT_LAYER_ADJUSTMENTS) "0.99,0.2,0,0,0,0"
set ::env(GRT_OVERFLOW_ITERS) 100

set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.17

## Placement
set ::env(PL_TARGET_DENSITY) 0.5

set ::env(GRT_ALLOW_CONGESTION) 0

set ::env(CLOCK_TREE_SYNTH) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) .17
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) "30"

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) "3"
set ::env(GRT_ANT_ITERS) "7"
