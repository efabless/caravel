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
# User config
set ::env(DESIGN_NAME) user_id_programming

# Change if needed
set ::env(VERILOG_FILES) $script_dir/../../verilog/rtl/user_id_programming.v
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# Fill this
set ::env(CLOCK_TREE_SYNTH) 0

set ::env(CELL_PAD) 0

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 35 35"
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(BOTTOM_MARGIN_MULT) 2
set ::env(TOP_MARGIN_MULT) 2
