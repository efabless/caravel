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

set ::env(DESIGN_NAME) chip_io_alt

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v\
	$script_dir/../../verilog/rtl/pads.v\
	$script_dir/../../verilog/rtl/mprj_io.v\
	$script_dir/../../verilog/rtl/chip_io_alt.v"

# The removal of this line is pending the IO verilog files being parsable by yosys...
set ::env(VERILOG_FILES_BLACKBOX) "\
    $script_dir/../../verilog/stubs/sky130_fd_io__top_xres4v2.v\
    $script_dir/../../verilog/stubs/sky130_fd_io__top_ground_lvc_wpad.v\
    $script_dir/../../verilog/stubs/sky130_fd_io__top_power_lvc_wpad.v"

set ::env(GPIO_PADS_VERILOG) "\
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"


set ::env(DESIGN_IS_PADFRAME) 1
set ::env(SYNTH_FLAT_TOP) 1
set ::env(USE_GPIO_PADS) 1


set ::env(FP_SIZING) absolute

set fd [open "$script_dir/../chip_dimensions.txt" "r"]
set ::env(DIE_AREA) [read $fd]
close $fd


set ::env(MAGIC_WRITE_FULL_LEF) 1

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(GLB_RT_TILES) 30
set ::env(GLB_RT_MAXLAYER) 4
set ::env(GLB_RT_UNIDIRECTIONAL) 0
# set ::env(GLB_RT_ALLOW_CONGESTION) 1
# set ::env(GLB_RT_OVERFLOW_ITERS) 150

set ::env(LVS_CONNECT_BY_LABEL) 1

set ::env(QUIT_ON_ILLEGAL_OVERLAPS) 0