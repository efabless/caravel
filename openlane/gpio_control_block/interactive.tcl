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
set save_path $script_dir/../..

prep -design $script_dir -tag gpio_control_block -overwrite

run_synthesis

init_floorplan

set ::env(SAVE_DEF) [index_file $::env(ioPlacer_tmp_file_tag).def]
try_catch openroad -exit $script_dir/io_place.tcl |& tee $::env(TERMINAL_OUTPUT) [index_file $::env(ioPlacer_log_file_tag).log 0]
set_def $::env(SAVE_DEF)

file copy -force $::env(MACRO_PLACEMENT_CFG) $::env(TMP_DIR)/macro_placement.cfg
manual_macro_placement f

tap_decap_or

run_power_grid_generation

run_placement

run_cts
run_resizer_timing

run_routing

if { ($::env(DIODE_INSERTION_STRATEGY) == 2) || ($::env(DIODE_INSERTION_STRATEGY) == 5) } {
        run_antenna_check
        heal_antenna_violators; # modifies the routed DEF
}

run_magic

run_magic_spice_export

write_powered_verilog
set_netlist $::env(lvs_result_file_tag).powered.v

run_magic_drc

run_lvs $::env(magic_result_file_tag).spice $::env(CURRENT_NETLIST)

run_antenna_check

run_lef_cvc

save_views -lef_path $::env(magic_result_file_tag).lef \
        -def_path $::env(tritonRoute_result_file_tag).def \
        -gds_path $::env(magic_result_file_tag).gds \
        -mag_path $::env(magic_result_file_tag).mag \
        -verilog_path $::env(CURRENT_NETLIST) \
        -spice_path $::env(magic_result_file_tag).spice \
        -save_path $save_path \
        -tag $::env(RUN_TAG)

calc_total_runtime
save_state
generate_final_summary_report

check_timing_violations