package require openlane
variable SCRIPT_DIR [file dirname [file normalize [info script]]]
prep -ignore_mismatches -design $SCRIPT_DIR -tag $::env(OPENLANE_RUN_TAG) -overwrite -verbose 0

set save_path $::env(CARAVEL_ROOT)

##synthesis
run_synthesis
#
##floorplan
run_floorplan
##placement
if { ! [ info exists ::env(PLACEMENT_CURRENT_DEF) ] } {
        set ::env(PLACEMENT_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(PLACEMENT_CURRENT_DEF)
    }
    run_placement
##cts
if { ! [ info exists ::env(CTS_CURRENT_DEF) ] } {
        set ::env(CTS_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(CTS_CURRENT_DEF)
    }
    run_cts
    ##adding hk_serial_clock and hk_serial_load as clocks after CTS.
    set ::env(CURRENT_SDC) $::env(DESIGN_DIR)/base_2.sdc
    run_resizer_timing
    if { $::env(RSZ_USE_OLD_REMOVER) == 1} {
        remove_buffers_from_nets
    }
##routing
if { ! [ info exists ::env(ROUTING_CURRENT_DEF) ] } {
        set ::env(ROUTING_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(ROUTING_CURRENT_DEF)
    }
    if { $::env(ECO_ENABLE) == 0 } {
        run_routing
    }
##RCX sta
    if { ! [ info exists ::env(PARSITICS_CURRENT_DEF) ] } {
        set ::env(PARSITICS_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(PARSITICS_CURRENT_DEF)
    }

    if { $::env(RUN_SPEF_EXTRACTION) && ($::env(ECO_ENABLE) == 0)} {
        run_parasitics_sta
    }
##diode
    if { ! [ info exists ::env(DIODE_INSERTION_CURRENT_DEF) ] } {
        set ::env(DIODE_INSERTION_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(DIODE_INSERTION_CURRENT_DEF)
    }
    if { ($::env(DIODE_INSERTION_STRATEGY) == 2) || ($::env(DIODE_INSERTION_STRATEGY) == 5) } {
        run_antenna_check
        heal_antenna_violators; # modifies the routed DEF
    }
##antenna check
    if { ! [ info exists ::env(ANTENNA_CHECK_CURRENT_DEF) ] } {
        set ::env(ANTENNA_CHECK_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(ANTENNA_CHECK_CURRENT_DEF)
    }
        run_antenna_check
##magic
    if {$::env(RUN_MAGIC)} {
        run_magic
    }
##lvs
    if { ! [ info exists ::env(LVS_CURRENT_DEF) ] } {
        set ::env(LVS_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(LVS_CURRENT_DEF)
    }

    if {$::env(RUN_LVS) } {
        run_magic_spice_export;
        run_lvs; # requires run_magic_spice_export
    }
##drc
if { ! [ info exists ::env(DRC_CURRENT_DEF) ] } {
        set ::env(DRC_CURRENT_DEF) $::env(CURRENT_DEF)
    } else {
        set ::env(CURRENT_DEF) $::env(DRC_CURRENT_DEF)
    }
    if { $::env(RUN_MAGIC_DRC) } {
        run_magic_drc
    }
    if {$::env(RUN_KLAYOUT_DRC)} {
        run_klayout_drc
    }
##saves to <RUN_DIR>/results/final
    save_final_views
    ##saving views
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

##Copying reports
    set run_dir $::env(DESIGN_DIR)/runs/$::env(RUN_TAG)
    ##copying signoff reports
    set sourceDir $run_dir/reports/signoff
    set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/
    foreach f [glob -directory $sourceDir -nocomplain *] {
        file copy -force $f $targetDir
    }
    ##copying spefs
    set sourceDir $run_dir/results/routing/mca/spef/
    set targetDir $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/openlane-signoff/spef/
    foreach f [glob -directory $sourceDir -nocomplain *] {
        file copy -force $f $targetDir
    }
    ##copying sdf
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
    ##coping other files
    set flist [list $run_dir/config.tcl $run_dir/openlane.log $run_dir/runtime.yaml $run_dir/warnings.log]
    file copy -force {*}$flist $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN_NAME)/