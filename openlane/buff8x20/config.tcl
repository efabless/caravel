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
# virtual clock
set ::env(CLOCK_PERIOD) 8
set ::env(CLOCK_PORT) ""
set ::env(DESIGN_NAME) buff8x20
set ::env(DESIGN_IS_CORE) 0
# set ::env(DESIGN_IS_CORE) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 40 30"
# set ::env(CORE_AREA) "1 1 19 19"

set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/../../verilog/rtl/buff8x20.v"
set ::env(DRC_EXCLUDE_CELL_LIST) [glob $::env(DESIGN_DIR)/drc_exclude.list]
set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/pin_order.cfg] 

set ::env(FP_PDN_VOFFSET) 2
set ::env(FP_PDN_VPITCH) 7
set ::env(FP_PDN_VSPACING) 2
# set ::env(PL_TARGET_DENSITY) 0.60
# set ::env(FP_CORE_UTIL) 0.99
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_SIZING) 0
set ::env(TAP_DECAP_INSERTION) 1
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(RIGHT_MARGIN_MULT) {4}
set ::env(LEFT_MARGIN_MULT) {4}
set ::env(TOP_MARGIN_MULT) {2}
set ::env(BOTTOM_MARGIN_MULT) {2}
set ::env(MAGIC_EXT_USE_GDS) 1