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

# User config
set ::env(DESIGN_NAME) RAM256
set ::env(DESIGN_IS_CORE) 0

set ::env(ROUTING_CORES) 48
set ::env(RUN_KLAYOUT) 0

# Change if needed
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/RAM256.nl.v"

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc

set ::env(CLOCK_PERIOD) "25"
set ::env(CLOCK_PORT) "CLK"

## Synthesis
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 800 550"

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

set ::env(LEFT_MARGIN_MULT) 10
set ::env(RIGHT_MARGIN_MULT) 10

set ::env(DPL_CELL_PADDING) 0
set ::env(GPL_CELL_PADDING) 0

## PDN 
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_HPITCH) "130"
set ::env(FP_PDN_HSPACING) "63.4"
set ::env(FP_PDN_HOFFSET) "16.65"

set ::env(FP_PDN_VSPACING) "75.2"

## Placement
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0

set ::env(PL_TARGET_DENSITY) 0.78

## Routing
set ::env(GRT_ADJUSTMENT) 0.18

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) 0

set ::env(QUIT_ON_TIMING_VIOLATIONS) 0