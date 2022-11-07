if {\
  [catch {
    ##PT script
    # Adding SCL and IO link libraries based on the process corner specified
    if {$::env(PROC_CORNER) == "t"} {
      set link_path "* $::env(PT_LIB_ROOT)/scs130hd_tt_1.80v_25C.lib \
      $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_25C.lib \
      $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_lowhv_3.3v_lv_1.8v_25C.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib \
      "
    } elseif {$::env(PROC_CORNER) == "f"} {
      set link_path "* $::env(PT_LIB_ROOT)/scs130hd_ff_1.95v_-40C.lib \
      $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_-40C.lib \
      $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_lowhv_5.5v_lv_1.95v_-40C.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ff_ff_n40C_1v95_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ff_ff_n40C_1v95_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ff_n40C_1v95_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ff_n40C_1v95_5v50_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ff_n40C_1v95_5v50.lib \
      "
    } elseif {$::env(PROC_CORNER) == "s"} {
      set link_path "* $::env(PT_LIB_ROOT)/scs130hd_ss_1.40v_100C.lib \
      $::env(PT_LIB_ROOT)/scs130hvl_ss_3.00v_100C.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ss_ss_100C_1v60_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ss_ss_100C_1v60_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ss_100C_1v60_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ss_100C_1v60_3v00_3v00.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ss_100C_1v60_3v00.lib \
      "
    }

    # Reading design netlist
    set search_path "$::env(CARAVEL_ROOT)/verilog/gl $::env(MCW_ROOT)/verilog/gl $::env(UPRJ_ROOT)/verilog/gl $::env(PT_LIB_ROOT)"
    puts "list of verilog files:"
    foreach verilog "[glob $::env(CARAVEL_ROOT)/verilog/gl/*.v] [glob $::env(MCW_ROOT)/verilog/gl/*.v] [glob $::env(UPRJ_ROOT)/verilog/gl/*.v]" {
        puts $verilog
        read_verilog $verilog
    }

    current_design $::env(DESIGN)
    link

    # Reading constraints (signoff)
    if {$::env(DESIGN) == "mgmt_core_wrapper" | $::env(DESIGN) == "RAM256" | $::env(DESIGN) == "RAM128"} {
      read_sdc $::env(MCW_ROOT)/signoff/$::env(DESIGN)/$::env(DESIGN).sdc
    } else {
      read_sdc $::env(CARAVEL_ROOT)/signoff/$::env(DESIGN)/$::env(DESIGN).sdc
      # -filter is supported by PT but not in the read_sdc  
      # add max_tran constraint as the default max_tran of the ss hd SCL is 10 so the violations are not caught in ss corners
      # apply the constraint to hd cells at the ss corner on caravel/caravan 
      if { $::env(DESIGN) == "caravel" | $::env(DESIGN) == "caravan" } {
        if { $::env(PROC_CORNER) == "s" } {
          set max_tran 1.5
          puts "\[INFO\]: Setting maximum transition of HD cells in slow process corner to: $max_tran"
          puts "For HD cells in the hierarchy of $::env(DESIGN)"
          set_max_transition $max_tran [get_pins -of_objects [get_cells */* -filter {ref_name=~sky130_fd_sc_hd*}]]
          set_max_transition $max_tran [get_pins -of_objects [get_cells */*/* -filter {ref_name=~sky130_fd_sc_hd*}]]
        } 
      }
    }

    # Reading parasitics based on the RC corner specified
    proc read_spefs {design rc_corner} {
      source ./spef_mapping.tcl
      foreach key [array names spef_mapping] {
        read_parasitics -keep_capacitive_coupling -path $key $spef_mapping($key)
      }

      if {$design == "mgmt_core_wrapper" | $design == "RAM128" | $design == "RAM256"} {
        read_parasitics -keep_capacitive_coupling -verbose $::env(MCW_ROOT)/signoff/${design}/openlane-signoff/spef/${design}.${rc_corner}.spef -pin_cap_included
      } else {
        read_parasitics -keep_capacitive_coupling -verbose $::env(CARAVEL_ROOT)/signoff/${design}/openlane-signoff/spef/${design}.${rc_corner}.spef -pin_cap_included
      }

    }
    
    proc report_results {design rc_corner proc_corner} {
      report_global_timing -separate_all_groups -significant_digits 4 > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-global.rpt
      report_analysis_coverage -significant_digits 4 -nosplit -status_details {untested} > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-coverage.rpt

      report_constraint -all_violators -significant_digits 4 -nosplit > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-all_viol.rpt

      report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
      -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-min_timing.rpt
      
      report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
      -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-max_timing.rpt

      if {$design == "caravel" | $design == "caravan"} {
        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-clk-min_timing.rpt
        
        report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-clk-max_timing.rpt
        
        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hk_serial_clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-hk_serial_clk-min_timing.rpt
        
        report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hk_serial_clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-hk_serial_clk-max_timing.rpt

        report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hkspi_clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-hkspi_clk-max_timing.rpt

        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hkspi_clk \
        -max_paths 10000 -nworst 10 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-hkspi_clk-min_timing.rpt

        report_timing -delay min -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
        -max_paths 10000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-soc-min_timing.rpt

        report_timing -delay max -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
        -max_paths 10000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-soc-max_timing.rpt

        report_case_analysis -nosplit > $::env(OUT_DIR)/reports/${design}.case_analysis.rpt
        report_exceptions -nosplit > $::env(OUT_DIR)/reports/${design}.false_paths.rpt

        report_timing -delay min -through [get_cells mprj] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
        -max_paths 10000 -nworst 5 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-mprj-min_timing.rpt

        report_timing -delay max -through [get_cells mprj] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
        -max_paths 10000 -nworst 5 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-mprj-max_timing.rpt

        report_si_bottleneck -significant_digits 4 -nosplit -slack_lesser_than 10 -all_nets > $::env(OUT_DIR)/reports/${rc_corner}/${design}.${proc_corner}${proc_corner}-si_bottleneck.rpt
      }

      write_sdf -version 3.0 -significant_digits 4 $::env(OUT_DIR)/sdf/${rc_corner}/${design}.${proc_corner}${proc_corner}.sdf

      # Extract timing model
      set extract_model_clock_transition_limit 0.75
      set extract_model_data_transition_limit 0.75
      set_app_var extract_model_capacitance_limit 1.0
      set extract_model_num_capacitance_points 7
      set extract_model_num_clock_transition_points 7
      set extract_model_num_data_transition_points 7
      set extract_model_use_conservative_current_slew true
      set extract_model_enable_report_delay_calculation true
      set extract_model_with_clock_latency_arcs true
      extract_model -output $::env(OUT_DIR)/lib/${rc_corner}/${design}.${proc_corner}${proc_corner} -format {db lib} -test_design
    }

    set si_enable_analysis TRUE
    read_spefs $::env(DESIGN) $::env(RC_CORNER)
    update_timing
    report_results $::env(DESIGN) $::env(RC_CORNER) $::env(PROC_CORNER)

    exit
  } err]
} {
  puts stderr $err
  exit 1
}
