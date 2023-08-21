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
set save_path "$script_dir/../.."

# ACTUAL CHIP INTEGRATION
prep -design $script_dir -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 2 -ignore_mismatches
exec rm -rf $script_dir/runs/final
exec ln -sf $script_dir/runs/$::env(OPENLANE_RUN_TAG) $script_dir/runs/final

verilog_elaborate

init_floorplan
add_macro_placement padframe 0 0 N
add_macro_placement caravel_power_routing 0 0 N
add_macro_placement chip_core 355 355 N
add_macro_placement copyright_block 650.0 8.0 N
add_macro_placement open_source 939.0 12.0 N
add_macro_placement user_id_textblock 260.0 4.0 N
add_macro_placement caravel_logo 1219.0 4.0 N
add_macro_placement caravel_motto 1474.0 17.0 N

manual_macro_placement f

label_macro_pins \
    -lef $::env(CARAVEL_ROOT)/lef/caravel.lef \
    -netlist_def $::env(CURRENT_DEF)

run_magic

##saves to <RUN_DIR>/results/final
    save_final_views
    save_final_views -save_path .. -tag $::env(RUN_TAG)
## 
    calc_total_runtime
    save_state
    generate_final_summary_report
    check_timing_violations
    if { [info exists arg_values(-save_path)]\
        && $arg_values(-save_path) != "" } {
        set ::env(HOOK_OUTPUT_PATH) "[file normalize $arg_values(-save_path)]"
    } else {
        set ::env(HOOK_OUTPUT_PATH) $::env(RESULTS_DIR)/final
    }
    if {[info exists flags_map(-run_hooks)]} {
        run_post_run_hooks
    }
    puts_success "Flow complete."
    show_warnings "Note that the following warnings have been generated:"
