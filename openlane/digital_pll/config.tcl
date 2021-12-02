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

set ::env(DESIGN_NAME) digital_pll
set ::env(DESIGN_IS_CORE) 1

set ::env(VERILOG_FILES) $script_dir/../../verilog/rtl/digital_pll.v

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_TREE_SYNTH) 0

# Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_MAX_FANOUT) 6
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_SIZING) 0

set ::env(BASE_SDC_FILE) $script_dir/base.sdc 

## Floorplan
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 75 75"

set ::env(TOP_MARGIN_MULT) 2
set ::env(BOTTOM_MARGIN_MULT) 2

set ::env(CELL_PAD)  0

## PDN 
set ::env(FP_PDN_VPITCH) 40
set ::env(FP_PDN_HPITCH) 40

## Placement
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_TARGET_DENSITY) 0.82

## Routing 
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(GLB_RT_MINLAYER) 2
set ::env(GLB_RT_MAXLAYER) 6

## Diode Insertion
set ::env(DIODE_INSERTION_STRATEGY) "4"
