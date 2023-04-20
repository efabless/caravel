if {\
  [catch {
    ##PT script
    # Adding SCL and IO link libraries based on the PDK and process corner specified
    if {[string match gf180* $::env(PDK)]} {
      source ./gf180_libs.tcl
    } elseif {[string match sky130* $::env(PDK)]} {
      source ./sky130_libs.tcl
    }

    # Reading design netlist
    set search_path "$::env(CARAVEL_ROOT)/verilog/gl $::env(MCW_ROOT)/verilog/gl $::env(UPRJ_ROOT)/verilog/gl"

    if {$::env(UPRJ_ROOT) == $::env(CARAVEL_ROOT)} {
      set verilogs [concat [glob $::env(CARAVEL_ROOT)/verilog/gl/*.v]]
    } elseif {$::env(MCW_ROOT) == $::env(CARAVEL_ROOT)} {
      set verilogs [concat [glob $::env(CARAVEL_ROOT)/verilog/gl/*.v] \
       [glob $::env(UPRJ_ROOT)/verilog/gl/*.v]]
    } elseif {$::env(UPRJ_ROOT) == $::env(CARAVEL_ROOT)} {
      set verilogs [concat [glob $::env(CARAVEL_ROOT)/verilog/gl/*.v] \
       [glob $::env(MCW_ROOT)/verilog/gl/*.v]]
    } else {
      set verilogs [concat [glob $::env(CARAVEL_ROOT)/verilog/gl/*.v] \
       [glob $::env(MCW_ROOT)/verilog/gl/*.v] \
       [glob $::env(UPRJ_ROOT)/verilog/gl/*.v]]
    }

    set verilog_exceptions [concat [glob $::env(CARAVEL_ROOT)/verilog/gl/*-signoff.v] \
      [glob $::env(CARAVEL_ROOT)/verilog/gl/__*.v]]

    # remove empty wrapper when including non-empty wrapper only
    if {!($::env(UPW))} {
      if {$::env(DESIGN) == $::env(CHIP_CORE) || $::env(DESIGN) == $::env(CHIP)} {
        set verilogs [concat $verilogs "$::env(CARAVEL_ROOT)/verilog/gl/__user_project_wrapper.v"]
        set verilog_exceptions [concat $verilog_exceptions "$::env(UPRJ_ROOT)/verilog/gl/user_project_wrapper.v"]
      } 
    } 

    foreach verilog_exception $verilog_exceptions {
        puts "verilog exception: $verilog_exception"
        set match_idx [lsearch $verilogs $verilog_exception]
        if {$match_idx} {
            puts "removing $verilog_exception from verilogs list"
            set verilogs [lreplace $verilogs $match_idx $match_idx]
        }
    }

    puts "list of verilog files:"
    foreach verilog $verilogs {
        puts $verilog
        read_verilog $verilog
    }

    current_design $::env(DESIGN)
    link

    # Reading constraints (signoff)
    read_sdc $::env(ROOT)/signoff/$::env(DESIGN)/$::env(DESIGN).sdc

    # debug interface input for swift
    if {$::env(DEBUG) && $::env(DESIGN) == $::env(CHIP)} {
      reset_path -from [get_ports mprj_io[0]]  
    }

    # Reading parasitics based on the RC corner specified
    proc read_spefs {design rc_corner} {
      if {[string match gf180* $::env(PDK)]} {
        source ./gf180_spef_mapping.tcl
      } elseif {[string match sky130* $::env(PDK)]} {
        source ./sky130_spef_mapping.tcl
      }
      foreach key [array names spef_mapping] {
        read_parasitics -keep_capacitive_coupling -path $key $spef_mapping($key)
      }
      # add -complete_with wlm to let PT complete incomplete RC networks at the top-level
      read_parasitics -keep_capacitive_coupling $::env(ROOT)/signoff/${design}/openlane-signoff/spef/${design}.${rc_corner}.spef -pin_cap_included
      # read_parasitics -keep_capacitive_coupling $::env(ROOT)/signoff/${design}/openlane-signoff/spef/${design}.${rc_corner}.spef -pin_cap_included -complete_with wlm
    }

    proc report_results {design rc_corner proc_corner} {
      report_global_timing -separate_all_groups -significant_digits 4 > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-global.rpt
      report_analysis_coverage -significant_digits 4 -nosplit -status_details {untested} > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-coverage.rpt

      report_constraint -all_violators -significant_digits 4 -nosplit > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-all_viol.rpt

      report_timing -unique_pins -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
      -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-min_timing.rpt
      
      report_timing -unique_pins -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
      -max_paths 1000 -slack_lesser_than 20 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-max_timing.rpt

      report_si_bottleneck -significant_digits 4 -nosplit -slack_lesser_than 10 -all_nets > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-si_bottleneck.rpt

      if {$design == $::env(CHIP) | $design == $::env(CHIP_CORE)} {
        if {$::env(UPW) && $design == $::env(CHIP)} {
            report_timing -unique_pins -delay min -through [get_cells chip_core/mprj] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
            -max_paths 1000 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-mprj-min_timing.rpt

            report_timing -unique_pins -delay max -through [get_cells chip_core/mprj] -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit \
            -max_paths 1000 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-mprj-max_timing.rpt
        }
        if {$::env(DEBUG)} {
          report_timing -unique_pins -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group debug_clk \
          -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-debug_clk-min_timing.rpt
          
          report_timing -unique_pins -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group debug_clk \
          -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-debug_clk-max_timing.rpt
        } else {
          report_timing -unique_pins -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hkspi_clk \
          -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-hkspi_clk-max_timing.rpt
  
          report_timing -unique_pins -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hkspi_clk \
          -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-hkspi_clk-min_timing.rpt
        }
        report_timing -unique_pins -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group clk \
        -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-clk-min_timing.rpt
        
        report_timing -unique_pins -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group clk \
        -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-clk-max_timing.rpt
        
        report_timing -unique_pins -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hk_serial_clk \
        -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-hk_serial_clk-min_timing.rpt
        
        report_timing -unique_pins -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -crosstalk_delta -derate -nosplit -group hk_serial_clk \
        -max_paths 1000 -slack_lesser_than 10 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/reports/${proc_corner}${proc_corner}/${design}.${rc_corner}-hk_serial_clk-max_timing.rpt

        report_case_analysis -nosplit > $::env(OUT_DIR)/reports/${design}.case_analysis.rpt
        report_exceptions -nosplit > $::env(OUT_DIR)/reports/${design}.false_paths.rpt
      }

      if {$::env(REPORTS_ONLY) == 0} {
        write_sdf -compress gzip $::env(OUT_DIR)/sdf/${proc_corner}${proc_corner}/${design}.${rc_corner}.sdf.gz

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

        # remove boundary constraints
        reset_timing_derate
        remove_input_delay [all_inputs]
        remove_output_delay [all_outputs]
        remove_capacitance [all_outputs]

        extract_model -output $::env(OUT_DIR)/lib/${proc_corner}${proc_corner}/${design}.${rc_corner} -format {lib}  
      }
    }
    # set timing_report_unconstrained_paths TRUE
    set parasitics_log_file $::env(OUT_DIR)/logs/$::env(RC_CORNER)-parasitics.log
    set si_enable_analysis TRUE
    # set si_enable_analysis FALSE
    set sh_message_limit 1500
    read_spefs $::env(DESIGN) $::env(RC_CORNER)
    set parasitics_log_file $::env(OUT_DIR)/logs/$::env(RC_CORNER)-unannotated.log
    report_annotated_parasitics -list_not_annotated -max_nets 5000 
    update_timing
    report_results $::env(DESIGN) $::env(RC_CORNER) $::env(PROC_CORNER)
    exit
  } err]
} {
  puts stderr $err
  exit 1
}