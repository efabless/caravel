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
source $script_dir/fixed_wrapper_cfgs.tcl

set ::env(DESIGN_NAME) user_analog_project_wrapper

set ::env(GLB_RT_OBS) "met1 0 0 $::env(DIE_AREA),\
					   met2 0 0 $::env(DIE_AREA),\
					   met3 0 0 $::env(DIE_AREA),\
					   met4 0 0 $::env(DIE_AREA),\
					   met5 0 0 $::env(DIE_AREA)"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET)  "wb_clk_i"

set ::env(CLOCK_PERIOD) "10"

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(SYNTH_DEFINES) "USE_POWER_PINS"

set ::env(MAGIC_WRITE_FULL_LEF) 1

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/__user_analog_project_wrapper.v"