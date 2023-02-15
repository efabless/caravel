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


set ::env(DESIGN_NAME) caravel_clocking
set ::env(DESIGN_IS_CORE) 0

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/clock_div.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/caravel_clocking.v"

set ::env(CLOCK_PORT) "ext_clk"
set ::env(CLOCK_NET) "ext_clk core_clk pll_clk pll_clk90"

set ::env(ROUTING_CORES) "6"
set ::env(RUN_KLAYOUT) 0

## Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(SYNTH_SIZING) 0
set ::env(SYNTH_BUFFERING) 0

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc 

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

set ::env(NO_SYNTH_CELL_LIST) $::env(DESIGN_DIR)/no_synth.list 

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 100"

# set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/template/caravel_clocking.def

set ::env(FP_TAPCELL_DIST) 6

set ::env(LEFT_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2
set ::env(TOP_MARGIN_MULT) "2"
set ::env(BOTTOM_MARGIN_MULT) "1"

set ::env(DPL_CELL_PADDING) 2
set ::env(GPL_CELL_PADDING) 4
set ::env(DIODE_PADDING) 0

## PDN
set ::env(FP_PDN_HPITCH) 16.9
set ::env(FP_PDN_VPITCH) 15.5
set ::env(FP_PDN_HSPACING) 6.85
set ::env(FP_PDN_VSPACING) 6.15
set ::env(FP_PDN_HOFFSET) 5.73
set ::env(FP_PDN_VOFFSET) 7.63
# vertical 21.29 15.61

## Placement
set ::env(PL_TARGET_DENSITY) 0.63

set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
# set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.25

## Routing
set ::env(GRT_ADJUSTMENT) 0

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 4

set ::env(SYNTH_EXTRA_MAPPING_FILE) $::env(SYNTH_MUX_MAP)
set ::env(RSZ_DONT_TOUCH_RX) "core_clk|user_clk"
set ::env(RSZ_USE_OLD_REMOVER) 1
set ::env(FP_PDN_SKIP_TRIM) 1
set ::env(CTS_MAX_CAP) 0.25

#set ::env(DRC_EXCLUDE_CELL_LIST) $::env(DESIGN_DIR)/drc_exclude.list
set ::env(SYNTH_MAX_FANOUT) 12
