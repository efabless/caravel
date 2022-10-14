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

variable SCRIPT_DIR [file dirname [file normalize [info script]]]
prep -ignore_mismatches -design $SCRIPT_DIR -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 0
exec rm -rf $SCRIPT_DIR/runs/caravel_clocking_interactive
exec ln -sf $SCRIPT_DIR/runs/$::env(OPENLANE_RUN_TAG) $SCRIPT_DIR/runs/caravel_clocking_interactive

run_synthesis
init_floorplan
place_io
apply_def_template
tap_decap_or
run_power_grid_generation
global_placement_or
run_resizer_design
detailed_placement_or
run_cts
run_resizer_timing
remove_buffers_from_nets
puts_info "Running custom buffer script"
run_openroad_script $::env(DESIGN_DIR)/buffer.tcl\
    -indexed_log [index_file $::env(cts_logs)/custom-buffer.log]\
    -save "to=$::env(cts_tmpfiles),name=$::env(DESIGN_NAME).custom-buffered,def,sdc,odb,netlist,powered_netlist"
run_resizer_timing_routing
ins_diode_cells_4
ins_fill_cells
global_routing
detailed_routing
run_parasitics_sta
run_irdrop_report
run_magic
run_magic_spice_export;
run_lvs;
run_magic_drc
run_antenna_check
run_lef_cvc
calc_total_runtime
save_final_views
save_final_views -save_path .. -tag $::env(OPENLANE_RUN_TAG)
save_state
generate_final_summary_report
check_timing_violations

