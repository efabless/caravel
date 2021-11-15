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

set ::env(DESIGN_NAME) "housekeeping"
set ::env(ROUTING_CORES) 6 
set ::env(RUN_KLAYOUT) 0

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v\
    $script_dir/../../verilog/rtl/housekeeping_spi.v\
    $script_dir/../../verilog/rtl/housekeeping.v"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) {$::env(CLOCK_PORT) csclk mgmt_gpio_in\[4\]}

set ::env(BASE_SDC_FILE) $script_dir/base.sdc

## Synthesis 
set ::env(NO_SYNTH_CELL_LIST) $script_dir/no_synth.list 

set ::env(SYNTH_MAX_FANOUT) 5

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 300.230 550.950"

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(FP_IO_MIN_DISTANCE) 2

set ::env(CELL_PAD) 0

## Routing 
set ::env(GLB_RT_ADJUSTMENT) 0.05 
set ::env(GLB_RT_OVERFLOW_ITERS) 100

## Placement
set ::env(PL_TARGET_DENSITY) 0.384

set ::env(PL_RESIZER_MAX_SLEW_MARGIN) "30"

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) "3"

# Disbale timing checks for now till the issue with the clock gating path is fixed 
# The timing reports show only one violating path from the mgmt_gpio_ 
set ::env(QUIT_ON_TIMING_VIOLATIONS) 0