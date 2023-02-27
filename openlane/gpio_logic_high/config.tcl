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


set ::env(DESIGN_NAME) gpio_logic_high
set ::env(DESIGN_IS_CORE) 1

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
	$::env(DESIGN_DIR)/../../verilog/rtl/gpio_logic_high.v"

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_TREE_SYNTH) 0

## Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

## Floorplan
set ::env(DIE_AREA) "0 0 22 22"

set ::env(FP_SIZING) absolute

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
set ::env(FP_IO_VLENGTH) 2
set ::env(FP_IO_HLENGTH) 2

set ::env(FP_PDN_HORIZONTAL_HALO) 0
set ::env(FP_PDN_VERTICAL_HALO) 0

set ::env(FP_TOP_HORIZONTAL_HALO) 0
set ::env(FP_TOP_VERTICAL_HALO) 0

set ::env(FP_TAPCELL_DIST) 4

set ::env(TOP_MARGIN_MULT) 1
set ::env(BOTTOM_MARGIN_MULT) 1
set ::env(LEFT_MARGIN_MULT) 1
set ::env(RIGHT_MARGIN_MULT) 1

set ::env(CELL_PAD) 0

# Power nets
set ::env(VDD_NETS) "vccd1"
set ::env(GND_NETS) "vssd1"

## PDN Configuration
set ::env(FP_PDN_AUTO_ADJUST) 0
set ::env(FP_PDN_VWIDTH) 1.6
set ::env(FP_PDN_HWIDTH) 1.6
set ::env(FP_PDN_VSPACING) 2.0
set ::env(FP_PDN_HSPACING) 2.0
set ::env(FP_PDN_VOFFSET) 1
set ::env(FP_PDN_HOFFSET) 1
set ::env(FP_PDN_VPITCH) 7.6
set ::env(FP_PDN_HPITCH) 7.6
set ::env(FP_PDN_LOWER_LAYER) met2
set ::env(FP_PDN_UPPER_LAYER) met3
set ::env(FP_PDN_SKIPTRIM) 1

## Placement
set ::env(PL_TARGET_DENSITY) 0.5
set ::env(PL_RANDOM_INITIAL_PLACEMENT) 0
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

