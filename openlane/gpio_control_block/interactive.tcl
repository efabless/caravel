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

proc custom_run_placement {args} {
    global SCRIPT_DIR
    global_placement_or

    set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
    set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0
    set log [index_file $::env(placement_logs)/resizer-1.log]
    set ::env(SAVE_DEF) [index_file $::env(placement_tmpfiles)/resizer-1.def]
    set ::env(SAVE_SDC) [index_file $::env(placement_tmpfiles)/resizer-1.sdc]
    run_openroad_script $::env(SCRIPTS_DIR)/openroad/resizer.tcl -indexed_log $log
    set_def $::env(SAVE_DEF)
    set ::env(CURRENT_SDC) $::env(SAVE_SDC)

    set dont_use_buffers "sky130_fd_sc_hd__probe* sky130_fd_sc_hd__bufbuf* sky130_fd_sc_hd__buf_1 sky130_fd_sc_hd__buf_2 sky130_fd_sc_hd__buf_4 sky130_fd_sc_hd__buf_6 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_12 sky130_fd_sc_hd__clkbuf* "
    set dont_use_old ""
    if { [info exists ::env(DONT_USE_CELLS)] } {
      set ::env(DONT_USE_CELLS) "$::env(DONT_USE_CELLS) $dont_use_buffers"
    } else {
      set ::env(DONT_USE_CELLS) "$dont_use_buffers"
      set dont_use_old ::env(DONT_USE_CELLS)
    }
    set dont_touch_old "$::env(RSZ_DONT_TOUCH)"
    set ::env(RSZ_DONT_TOUCH) "$::env(RSZ_DONT_TOUCH) mgmt_gpio_out mgmt_gpio_oeb pad_gpio_in user_gpio_oeb user_gpio_out"
    set log [index_file $::env(placement_logs)/resizer-2.log]
    set ::env(SAVE_DEF) [index_file $::env(placement_tmpfiles)/resizer-2.def]
    set ::env(SAVE_SDC) [index_file $::env(placement_tmpfiles)/resizer-2.sdc]
    run_openroad_script $SCRIPT_DIR/buffer.tcl -indexed_log $log
    set_def $::env(SAVE_DEF)
    set ::env(CURRENT_SDC) $::env(SAVE_SDC)
    write_verilog $::env(placement_results)/$::env(DESIGN_NAME).resized.v -log $::env(placement_logs)/write_verilog.log

    set ::env(RSZ_DONT_TOUCH) "$dont_touch_old"
    set ::env(DONT_USE_CELLS) $dont_use_old

    exit 1

    detailed_placement_or -def $::env(placement_results)/$::env(DESIGN_NAME).def -log $::env(placement_logs)/detailed.log
}

variable SCRIPT_DIR [file dirname [file normalize [info script]]]
prep -design $SCRIPT_DIR -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 0
exec rm -rf $SCRIPT_DIR/runs/gpio_control_block_interactive
exec ln -sf $SCRIPT_DIR/runs/$::env(OPENLANE_RUN_TAG) $SCRIPT_DIR/runs/gpio_control_block_interactive
run_synthesis

init_floorplan
place_io
apply_def_template
file copy -force $::env(MACRO_PLACEMENT_CFG) $::env(placement_tmpfiles)/macro_placement.cfg
manual_macro_placement -f
tap_decap_or
add_route_obs
run_power_grid_generation

set dont_use_old ::env(DONT_USE_CELLS)
global_placement_or
set ::env(DONT_USE_CELLS) "$::env(DONT_USE_CELLS) sky130_fd_sc_hd__buf_1"
run_resizer_design
set ::env(DONT_USE_CELLS) "$dont_use_old"

set ::env(SAVE_DEF) [index_file $::env(placement_tmpfiles)/buffer_insert.def]
run_openroad_script $SCRIPT_DIR/buffer.tcl -indexed_log [index_file $::env(placement_logs)/buffer_insert.log]
set_def $::env(SAVE_DEF)
write_verilog [index_file $::env(placement_tmpfiles)/buffer_insert.v] -log $::env(placement_logs)/write_verilog_buffer.log
set ::env(UNBUFFER_NETS) "serial_clock_out_buffered|serial_load_out_buffered"
write_verilog [index_file $::env(placement_tmpfiles)/buffer_remove.v] -log $::env(placement_logs)/write_verilog_buffer_remove.log

detailed_placement_or -def $::env(CURRENT_DEF) -log $::env(placement_logs)/detailed.log
run_cts
remove_buffers_from_nets
run_resizer_timing_routing
ins_diode_cells_4
ins_fill_cells
global_routing
set global_routed_netlist [index_file $::env(routing_tmpfiles)/global.v]
write_verilog $global_routed_netlist -log $::env(routing_logs)/write_verilog_global.log
# detailed routing
detailed_routing
set detailed_routed_netlist [index_file $::env(routing_tmpfiles)/detailed.v]
write_verilog $detailed_routed_netlist -log $::env(routing_logs)/write_verilog_detailed.log
# for lvs
set_netlist $detailed_routed_netlist
run_parasitics_sta
run_irdrop_report
run_magic
run_magic_spice_export;
run_lvs; # requires run_magic_spice_export
run_magic_drc
run_antenna_check
run_lef_cvc
calc_total_runtime
save_final_views
save_final_views -save_path .. -tag $::env(RUN_TAG)
save_state
generate_final_summary_report
check_timing_violations

