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

set ::env(SAVE_DEF) [index_file $::env(floorplan_tmpfiles)/gpio_control_block.io.def]
try_catch openroad -exit $script_dir/io_place.tcl |& tee $::env(TERMINAL_OUTPUT) [index_file $::env(floorplan_logs)/io.log 0]
set_def $::env(SAVE_DEF)

file copy -force $::env(MACRO_PLACEMENT_CFG) $::env(TMP_DIR)/placement/macro_placement.cfg
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

set powered_netlist_name [index_file $::env(finishing_tmpfiles)/powered_netlist.v]
set powered_def_name [index_file $::env(finishing_tmpfiles)/powered_def.def]
write_powered_verilog\
-output_verilog $powered_netlist_name\
-output_def $powered_def_name\
-log $::env(finishing_logs)/write_verilog.log\
-def_log $::env(finishing_logs)/write_powered_def.log

set_netlist $powered_netlist_name
            
run_magic_drc

run_lvs 

run_antenna_check

run_lef_cvc

save_views -save_path $save_path \
        -def_path $::env(CURRENT_DEF) \
        -lef_path $::env(finishing_results)/$::env(DESIGN_NAME).lef \
        -gds_path $::env(finishing_results)/$::env(DESIGN_NAME).gds \
        -mag_path $::env(finishing_results)/$::env(DESIGN_NAME).mag \
        -maglef_path $::env(finishing_results)/$::env(DESIGN_NAME).lef.mag \
        -spice_path $::env(finishing_results)/$::env(DESIGN_NAME).spice \
        -verilog_path $::env(CURRENT_NETLIST) \
        -spef_path $::env(SPEF_TYPICAL) \
        -sdf_path $::env(CURRENT_SDF) \
        -sdc_path $::env(CURRENT_SDC)

calc_total_runtime
save_state
generate_final_summary_report

check_timing_violations