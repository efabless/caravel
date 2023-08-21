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

package require openlane
set script_dir [file dirname [file normalize [info script]]]
## ORIGINAL FLOORPLAN FOR CONNECTIVITY INFO
set ::env(CONNECTIVITY_RUN) 1

prep -design $script_dir -tag caravel_lvs -overwrite
set top_rtl $script_dir/../../verilog/rtl/caravel.v

set ::env(SYNTH_DEFINES) "USE_POWER_PINS"
verilog_elaborate

logic_equiv_check -lhs $top_rtl -rhs $::env(yosys_result_file_tag).v

init_floorplan

if { [info exists ::env(LVS_RUN_DIR)] } {
	file copy -force $::env(CURRENT_DEF) $::env(LVS_RUN_DIR)/lvs.def
	file copy -force $::env(CURRENT_NETLIST) $::env(LVS_RUN_DIR)/lvs.v
	file copy -force $::env(MERGED_LEF_UNPADDED) $::env(LVS_RUN_DIR)/lvs.lef
} else {
	puts "Warning: LVS_RUN_DIR not defined"
}
