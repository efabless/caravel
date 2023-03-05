package require openlane
variable SCRIPT_DIR [file dirname [file normalize [info script]]]
# prep -ignore_mismatches -design $SCRIPT_DIR -tag techlef_for_antenna -overwrite -verbose 0
prep -ignore_mismatches -design $SCRIPT_DIR -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 0

set save_path $::env(CARAVEL_ROOT)

################   Synthesis   ################
# run_synthesis
set_netlist $::env(DESIGN_DIR)/synth_configuration/caravel_core.v
set ::env(CURRENT_SDC) $::env(DESIGN_DIR)/sdc_files/base.sdc

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
    met5 75.92 1000 3087.18 4585, \
    met5 631 144 650 183, \
    met4 1040 189 1052 190 \
"
add_route_obs

# Adding met4 and met5 obstructions for the power connections to the padframe
set ::env(GRT_OBS) "\
    met5 0.000 126.0 28.00 210.0, \
    met4 988.0 0.000 1073.0 34.08, \
    met5 0.000 1989 70.00 2079, \
    met5 0.000 2189 70.00 2279, \
    met5 0.000 4342 70.00 4432, \
    met5 3093 1862 3165 1952, \
    met5 3093 2082 3165 2172, \
    met5 3093 2301 3165 2391, \
    met5 3093 3871 3165 3961, \
    met5 3093 4315 3165 4405, \
    met4 2667 4603 2741 4767 \
"
add_route_obs

run_power_grid_generation

# run_magic
# save_final_views
# save_views -save_path .. -tag $::env(OPENLANE_RUN_TAG)
################   placement   ################
set ::env(PL_TARGET_DENSITY) 0.195
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 70
set ::env(PL_RESIZER_CAP_SLEW_MARGIN) 70
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 2
run_placement

################   CTS   ################
run_cts

################ Global Routing Optmization  ################
run_resizer_timing_routing

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
run_resizer_timing_routing
# ins_diode_cells_4
# Adding met4/5 routing obstructions over the the RAMs and housekeeping to prevent routing DRCs
set ::env(GRT_OBS) "\
    met5 90 175.0 496.18 612.92, \
    met5 582.00 175.00 988.18 612.92, \
    met5 1800 125.00 2206.18 562.92, \
    met5 2650 190 3060.23 740.95, \
    met4 90 175.0 496.18 612.92, \
    met4 582.00 175.00 988.18 612.92, \
    met4 1800 125.00 2206.18 562.92, \
    met4 2650 190 3060.23 740.95 \
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

################   IR drop    ################
run_irdrop_report

################   Antenna check    ################
run_antenna_check

################   magic    ################
run_magic

################   LVS    ################
# run_magic_spice_export;
# run_lvs;

###############   DRC    ################
run_magic_drc

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