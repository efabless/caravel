package require openlane
variable SCRIPT_DIR [file dirname [file normalize [info script]]]
# prep -ignore_mismatches -design $SCRIPT_DIR -tag techlef_for_antenna -overwrite -verbose 0
prep -ignore_mismatches -design $SCRIPT_DIR -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 0

set save_path $::env(CARAVEL_ROOT)

################   Synthesis   ################
run_synthesis
# set_netlist $::env(DESIGN_DIR)/synth_configuration/caravel_core.v
# set ::env(CURRENT_SDC) $::env(DESIGN_DIR)/sdc_files/base.sdc

################   Floorplan   ################
init_floorplan
apply_def_template

# Placing the macros in the core area and marking them fixed
file copy -force $::env(MACRO_PLACEMENT_CFG_1) $::env(placement_tmpfiles)/macro_placement.cfg
manual_macro_placement -f
file copy -force $::env(MACRO_PLACEMENT_CFG_2) $::env(placement_tmpfiles)/macro_placement.cfg
manual_macro_placement

# Tap/Decap insertion
tap_decap_or

# Adding met4 and met5 obstructions to prevent power stripes over the user_project_wrapper and obs for vssio and vddio
set ::env(GRT_OBS) "\
    met4 80 989 3080 4596.3, \
    met5 76.6 1000 3086.5 4585, \
    met5 631 144 650 167, \
    met4 1040 189 1052 190 \
"
add_route_obs

run_power_grid_generation

# run_magic
# save_final_views
# save_views -save_path .. -tag $::env(OPENLANE_RUN_TAG)
################   placement   ################
set ::env(PL_TARGET_DENSITY) 0.24
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 70
set ::env(PL_RESIZER_CAP_SLEW_MARGIN) 70
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 2
run_placement

################   CTS   ################
# run_cts

################ Global Routing Optmization  ################
# run_resizer_timing_routing

################ Place and route on optmized netlist ################
set ::env(PL_TARGET_DENSITY) 0.28
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 50
set ::env(PL_RESIZER_CAP_SLEW_MARGIN) 50
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.05
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 1

# run_placement_incr
run_placement
run_cts

# adding hk_serial_clock and hk_serial_load as clocks after CTS by changing
# the sdc file to another one which they are defined as clocks in it. 
set ::env(CURRENT_SDC) $::env(DESIGN_DIR)/sdc_files/base_2.sdc
run_resizer_timing

################   Routing   ################
# Adding met5 routing obstructions over the the RAMs and housekeeping to prevent routing DRCs
run_resizer_timing_routing
set ::env(GRT_OBS) "\
    met5 90 130 890 680, \
    met5 1800 140 2280 590, \
    met5 2570 210 2950 761 \
"
add_route_obs
global_routing
ins_fill_cells
file copy -force $::env(MACRO_PLACEMENT_CFG_3) $::env(placement_tmpfiles)/macro_placement.cfg
manual_macro_placement -f
detailed_routing
check_wire_lengths

# run_routing

################   RCX sta    ################
run_parasitics_sta

################   Antenna check    ################
run_antenna_check

################   magic    ################
run_magic

################   LVS    ################
# run_magic_spice_export;
# run_lvs;

###############   DRC    ################
# run_magic_drc

################   Saving views and reports    ################
save_final_views
save_views -save_path .. -tag $::env(OPENLANE_RUN_TAG)
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

################   Copying reports    ################
set run_dir $::env(DESIGN_DIR)/runs/$::env(RUN_TAG)
## copying signoff reports
set sourceDir $run_dir/reports/signoff
set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/
foreach f [glob -directory $sourceDir -nocomplain *] {
    file copy -force $f $targetDir
}
## copying spefs
set sourceDir $run_dir/results/routing/mca/spef/
set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/spef/
foreach f [glob -directory $sourceDir -nocomplain *] {
    file copy -force $f $targetDir
}
## copying sdf
set sourceDir $run_dir/results/routing/mca/sdf/nom/
set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/sdf/nom/
foreach f [glob -directory $sourceDir -nocomplain *] {
    file copy -force $f $targetDir
}
set sourceDir $run_dir/results/routing/mca/sdf/min/
set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/sdf/min/
foreach f [glob -directory $sourceDir -nocomplain *] {
    file copy -force $f $targetDir
}
set sourceDir $run_dir/results/routing/mca/sdf/max/
set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/sdf/max/
foreach f [glob -directory $sourceDir -nocomplain *] {
    file copy -force $f $targetDir
}
## coping other files
set flist [list $run_dir/config.tcl $run_dir/openlane.log $run_dir/runtime.yaml $run_dir/warnings.log]
file copy -force {*}$flist $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/