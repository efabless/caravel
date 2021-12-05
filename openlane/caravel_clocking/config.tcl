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

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) caravel_clocking
set ::env(DESIGN_IS_CORE) 1

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v\
	$script_dir/../../verilog/rtl/clock_div.v\
	$script_dir/../../verilog/rtl/caravel_clocking.v"

set ::env(CLOCK_PORT) "ext_clk"
set ::env(CLOCK_NET) "ext_clk core_clk pll_clk pll_clk90"

set ::env(ROUTING_CORES) "6"
set ::env(RUN_KLAYOUT) 0

## Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(BASE_SDC_FILE) $script_dir/base.sdc 

set ::env(NO_SYNTH_CELL_LIST) $script_dir/no_synth.list 

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 60"

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

set ::env(FP_TAPCELL_DIST) 6

set ::env(LEFT_MARGIN_MULT) 0
set ::env(BOTTOM_MARGIN_MULT) 0
set ::env(TOP_MARGIN_MULT) "2"

set ::env(CELL_PAD) 0

## PDN
set ::env(FP_PDN_HPITCH) 16.9
set ::env(FP_PDN_VPITCH) 15.5

## Placement
set ::env(PL_TARGET_DENSITY) 0.715

set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.25

## Routing
set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(GLB_RT_MINLAYER) 2
set ::env(GLB_RT_MAXLAYER) 6

# prevent signal routing on li1
set ::env(GLB_RT_OBS) "\
	li1 0 54.64000 100.0 60,\
	li1 94.29500 0 100 60"

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 4
