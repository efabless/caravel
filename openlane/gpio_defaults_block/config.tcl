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

set ::env(DESIGN_NAME) gpio_defaults_block
set ::env(DESIGN_IS_CORE) 1

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/gpio_defaults_block.v"

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_TREE_SYNTH) 0

## Synthesis
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_ELABORATE_ONLY) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

## Floorplan
set ::env(DIE_AREA) "0 0 17 28"
set ::env(FP_SIZING) absolute

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
set ::env(FP_IO_VLENGTH) 3
set ::env(FP_IO_HLENGTH) 3
set ::env(FP_IO_HEXTEND) 3
set ::env(FP_IO_VEXTEND) 3

set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2
set ::env(LEFT_MARGIN_MULT) 5
set ::env(RIGHT_MARGIN_MULT) 1

set ::env(CELL_PAD) 0
set ::env(FP_TAPCELL_DIST) 8

## PDN Configuration
set ::env(FP_PDN_AUTO_ADJUST) 0
set ::env(FP_PDN_VWIDTH) 1.4
set ::env(FP_PDN_HWIDTH) 1.4
set ::env(FP_PDN_VOFFSET) 2.4
set ::env(FP_PDN_HOFFSET) 4.2
set ::env(FP_PDN_VSPACING) 8
set ::env(FP_PDN_HSPACING) 6
set ::env(FP_PDN_VPITCH) 18.8
set ::env(FP_PDN_HPITCH) 18.8
set ::env(FP_PDN_LOWER_LAYER) met2
set ::env(FP_PDN_UPPER_LAYER) met3
set ::env(FP_PDN_SKIPTRIM) 1

## Placement
set ::env(PL_TARGET_DENSITY) 0.45
set ::env(PL_ROUTABILITY_DRIVEN) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESZIER_REPIAR_TIE_FANOUT) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

## Routing
set ::env(GRT_MINLAYER) "met1"
set ::env(GRT_MAXLAYER) "met3"

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

## LVS
set ::env(MAGIC_EXT_USE_GDS) 1