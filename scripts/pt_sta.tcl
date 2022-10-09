##PT script
set link_path "* $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_25C.lib \
$::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_lowhv_3.3v_lv_1.8v_25C.lib \
$::env(PT_LIB_ROOT)/s8iom0s8_top_gpiov2_tt_tt_1p80v_x_3p30v_025C.lib \
$::env(PT_LIB_ROOT)/s8iom0s8_top_ground_hvc_wpad_tt_1.80v_3.30v_3.30v_025C.lib \
$::env(PT_LIB_ROOT)/s8iom0s8_top_ground_lvc_wpad_tt_1.80v_3.30v_025C.lib \
$::env(PT_LIB_ROOT)/s8iom0s8_top_power_lvc_wpad_tt_1.80v_3.30v_3.30v_025C.lib \
$::env(PT_LIB_ROOT)/s8iom0s8_top_xres4v2_tt_tt_1p80v_x_3p30v_025C.lib \
$::env(PT_LIB_ROOT)/simple_por.lib \
$::env(PT_LIB_ROOT)/sky130_ef_io__corner_pad.lib \
$::env(PT_LIB_ROOT)/spare_logic_block.lib \
$::env(PT_LIB_ROOT)/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib \
"
if {$::env(PROC_CORNER) == "t"} {
  append link_path "$::env(PT_LIB_ROOT)/scs130hd_tt_1.80v_25C.lib"
} elseif {$::env(PROC_CORNER) == "f"} {
  append link_path "$::env(PT_LIB_ROOT)/scs130hd_ff_1.95v_-40C.lib"
} elseif {$::env(PROC_CORNER) == "s"} {
  append link_path "$::env(PT_LIB_ROOT)/scs130hd_ss_1.40v_100C.lib"
}

set search_path "$::env(CARAVEL_ROOT)/verilog/gl $::env(MCW_ROOT)/verilog/gl $::env(PT_LIB_ROOT)"
foreach verilog "[glob $::env(CARAVEL_ROOT)/verilog/gl/*.v] [glob $::env(MCW_ROOT)/verilog/gl/*.v]" {
  puts "list of .v: $verilog"  
  read_verilog $verilog
}

current_design $::env(DESIGN)
link
read_sdc $::env(CARAVEL_ROOT)/openlane/$::env(DESIGN)/signoff.sdc

proc read_spefs {design rc_corner} {
  set spef_mapping(rstb_level)                               $::env(CARAVEL_ROOT)/spef/multicorner/xres_buf.${rc_corner}.spef
  set spef_mapping(padframe)                                 $::env(CARAVEL_ROOT)/spef/multicorner/chip_io.${rc_corner}.spef
  set spef_mapping(housekeeping)                             $::env(CARAVEL_ROOT)/spef/multicorner/housekeeping.${rc_corner}.spef
  set spef_mapping(mgmt_buffers)                             $::env(CARAVEL_ROOT)/spef/multicorner/mgmt_protect.${rc_corner}.spef
  set spef_mapping(pll)                                      $::env(CARAVEL_ROOT)/spef/multicorner/digital_pll.${rc_corner}.spef
  set spef_mapping(clocking)                                 $::env(CARAVEL_ROOT)/spef/multicorner/caravel_clocking.${rc_corner}.spef
  set spef_mapping(mgmt_buffers/powergood_check)             $::env(CARAVEL_ROOT)/spef/multicorner/mgmt_protect_hv.${rc_corner}.spef
  set spef_mapping(mgmt_buffers/mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/spef/multicorner/mprj_logic_high.${rc_corner}.spef
  set spef_mapping(soc)                                      $::env(MCW_ROOT)/spef/multicorner/mgmt_core_wrapper.${rc_corner}.spef
  set spef_mapping(soc/DFFRAM_0)                             $::env(MCW_ROOT)/spef/multicorner/DFFRAM.${rc_corner}.spef
  set spef_mapping(soc/core)                                 $::env(MCW_ROOT)/spef/multicorner/mgmt_core.${rc_corner}.spef

  set spef_mapping(\gpio_control_bidir_1[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_1[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[2]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[0]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[1]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[2]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[3]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[4]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[5]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[11]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[12]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[13]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[14]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[15]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_logic_high.${rc_corner}.spef

  set spef_mapping(gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_1803.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_1803.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_defaults_block_0403.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_1[0])                 $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_1[1])                 $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[0])                 $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[1])                 $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_bidir_2[2])                 $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[0])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[10])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[1])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[2])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[3])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[4])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[5])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[6])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[7])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[8])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1[9])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[0])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[1])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[2])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[3])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[4])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_1a[5])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[0])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[10])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[11])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[12])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[13])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[14])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[15])                   $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[1])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[2])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[3])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[4])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[5])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[6])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[7])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[8])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef
  set spef_mapping(\gpio_control_in_2[9])                    $::env(CARAVEL_ROOT)/spef/multicorner/gpio_control_block.${rc_corner}.spef

  foreach key [array names spef_mapping] {
    read_parasitics -path $key $spef_mapping($key)
  }
  read_parasitics -verbose $::env(CARAVEL_ROOT)/spef/multicorner/$::env(DESIGN).${rc_corner}.spef -pin_cap_included
}
proc report_results {design rc_corner proc_corner} {
  report_constraint -all_violators -significant_digits 4 -nosplit > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-all_viol.rpt

  report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
  -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-min_timing.rpt
  
  report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
  -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-max_timing.rpt

  if {$design == "caravel"} {
    report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group clk \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-clk-min_timing.rpt
    
    report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hk_serial_clk \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-hk_serial_clk-min_timing.rpt
    
    report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hk_serial_clk \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-hk_serial_clk-max_timing.rpt

    report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hkspi_clk \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-hkspi_clk-min_timing.rpt

    report_timing -delay min -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-soc-min_timing.rpt

    report_timing -delay max -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
    -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}-${rc_corner}-${proc_corner}-soc-max_timing.rpt
  }

  write_sdf -version 3.0 -significant_digits 4 $::env(OUT_DIR)/pt_sdf/${design}-${rc_corner}-${proc_corner}.sdf
}

read_spefs $::env(DESIGN) $::env(RC_CORNER)
update_timing
report_results $::env(DESIGN) $::env(RC_CORNER) $::env(PROC_CORNER)

exit