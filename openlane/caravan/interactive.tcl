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
prep -design $script_dir -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 1 -ignore_mismatches
exec rm -rf $script_dir/runs/final
exec ln -sf $script_dir/runs/$::env(OPENLANE_RUN_TAG) $script_dir/runs/final

verilog_elaborate

init_floorplan
add_macro_placement padframe 0 0 N
add_macro_placement chip_core 211.5 210.5 N
add_macro_placement user_id_textblock 175 35 N
add_macro_placement copyright_block_a 482 85 N
add_macro_placement open_source 768 15 N
add_macro_placement caravan_logo 1010 25.5 N
add_macro_placement caravan_motto -540 -7 N

manual_macro_placement f

# modify to a different file
# remove_pins -input $::env(CURRENT_DEF)
# remove_empty_nets -input $::env(CURRENT_DEF)

label_macro_pins \
    -lef $::env(CARAVEL_ROOT)/lef/caravan.lef \
    -netlist_def $::env(CURRENT_DEF)

foreach {process_corner lef ruleset} {
        min MERGED_LEF_MIN RCX_RULES_MIN
        max MERGED_LEF_MAX RCX_RULES_MAX
        nom MERGED_LEF RCX_RULES
    } {
        run_spef_extraction\
            -log $::env(signoff_logs)/parasitics_extraction.$process_corner.log\
            -rcx_lib $::env(LIB_SYNTH_COMPLETE)\
            -rcx_rules $::env($ruleset)\
            -rcx_lef $::env($lef)\
            -process_corner $process_corner \
            -save "$script_dir/$::env(DESIGN_NAME).$process_corner.spef"
    }

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
