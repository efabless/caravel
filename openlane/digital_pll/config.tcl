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
set ::env(DESIGN_NAME) digital_pll
set ::env(DESIGN_IS_CORE) 1

set ::env(VERILOG_FILES) $::env(DESIGN_DIR)/../../verilog/rtl/digital_pll.v

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_TREE_SYNTH) 0

# Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_MAX_FANOUT) 6
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_SIZING) 0

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc 

## Floorplan
set ::env(FP_DEF_TEMPLATE) $::env(DESIGN_DIR)/template/digital_pll.def

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 75 75"

set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2

set ::env(DIODE_PADDING) 0
set ::env(DPL_CELL_PADDING) 0
set ::env(DRT_CELL_PADDING)  0

## PDN 
set ::env(FP_PDN_VPITCH) 40
set ::env(FP_PDN_HPITCH) 40
set ::env(FP_PDN_HOFFSET) 16.41
set ::env(FP_PDN_HSPACING) 18.4
set ::env(FP_PDN_VSPACING) 18.4

## Placement
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_TARGET_DENSITY) 0.9

## Routing 
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GRT_ADJUSTMENT) 0

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) "4"

set ::env(STA_WRITE_LIB) 0
set ::env(FP_PDN_SKIPTRIM) 1

