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
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ff_ff_n40C_1v95_5v50.lib.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ff_ff_n40C_1v95_5v50.lib \
      $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib.lib \
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
      read_sdc $::env(MCW_ROOT)/sdc/$::env(DESIGN).sdc
    } else {
      read_sdc $::env(CARAVEL_ROOT)/sdc/$::env(DESIGN).sdc
    }

    # Reading parasitics based on the RC corner specified
    proc read_spefs {design rc_corner} {
      if {$design == "caravel"} {
        set spef_mapping(mprj)                                     $::env(UPRJ_ROOT)/spef/user_project_wrapper/user_project_wrapper.${rc_corner}.spef
        # add your module name instantiated in user_project_wrapper here
        # set spef_mapping(mprj/<instance name>)                     $::env(UPRJ_ROOT)/spef/<design name>/<design name>.${rc_corner}.spef

        set spef_mapping(rstb_level)                               $::env(CARAVEL_ROOT)/spef/xres_buf/xres_buf.${rc_corner}.spef
        set spef_mapping(padframe)                                 $::env(CARAVEL_ROOT)/spef/chip_io/chip_io.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[0])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[1])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[2])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[3])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[4])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[5])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        set spef_mapping(padframe/\constant_value_inst[6])         $::env(CARAVEL_ROOT)/spef/constant_block/constant_block.${rc_corner}.spef
        
        set spef_mapping(housekeeping)                             $::env(CARAVEL_ROOT)/spef/housekeeping/housekeeping.${rc_corner}.spef
        set spef_mapping(pll)                                      $::env(CARAVEL_ROOT)/spef/digital_pll/digital_pll.${rc_corner}.spef
        set spef_mapping(clock_ctrl)                               $::env(CARAVEL_ROOT)/spef/caravel_clocking/caravel_clocking.${rc_corner}.spef
        set spef_mapping(mgmt_buffers)                             $::env(CARAVEL_ROOT)/spef/mgmt_protect/mgmt_protect.${rc_corner}.spef
        set spef_mapping(mgmt_buffers/powergood_check)             $::env(CARAVEL_ROOT)/spef/mgmt_protect_hv/mgmt_protect_hv.${rc_corner}.spef
        set spef_mapping(mgmt_buffers/mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/spef/mprj_logic_high/mprj_logic_high.${rc_corner}.spef
        set spef_mapping(mgmt_buffers/mprj2_logic_high_inst)       $::env(CARAVEL_ROOT)/spef/mprj2_logic_high/mprj2_logic_high.${rc_corner}.spef
        
        set spef_mapping(soc)                                      $::env(MCW_ROOT)/spef/mgmt_core_wrapper/mgmt_core_wrapper.${rc_corner}.spef
        set spef_mapping(soc/\core.RAM256)                         $::env(MCW_ROOT)/spef/RAM256/RAM256.${rc_corner}.spef
        set spef_mapping(soc/\core.RAM128)                         $::env(MCW_ROOT)/spef/RAM128/RAM128.${rc_corner}.spef
        
        set spef_mapping(\gpio_control_bidir_1[0])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_1[1])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[0])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[1])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[2])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[0])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[10])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[1])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[2])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[3])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[4])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[5])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[6])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[7])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[8])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[9])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[0])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[1])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[2])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[3])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[4])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[5])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[0])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[10])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[11])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[12])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[13])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[14])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[15])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[1])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[2])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[3])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[4])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[5])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[6])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[7])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[8])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[9])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block/gpio_control_block.${rc_corner}.spef

        set spef_mapping(\gpio_control_bidir_1[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_1[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_bidir_2[2]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[0]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[1]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[2]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[3]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[4]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_1a[5]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[11]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[12]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[13]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[14]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[15]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
        set spef_mapping(\gpio_control_in_2[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef

        set spef_mapping(gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803/gpio_defaults_block_1803.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803/gpio_defaults_block_1803.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0801/gpio_defaults_block_0801.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
        set spef_mapping(gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403/gpio_defaults_block_0403.${rc_corner}.spef
      } elseif {$design == "mgmt_core_wrapper"} {
        set spef_mapping(\core.RAM128)                             $::env(MCW_ROOT)/spef/RAM128/RAM128.${rc_corner}.spef
        set spef_mapping(\core.RAM256)                             $::env(MCW_ROOT)/spef/RAM512/RAM512.${rc_corner}.spef
      } elseif {$design == "gpio_control_block"} {
        set spef_mapping(gpio_logic_high)                          $::env(CARAVEL_ROOT)/spef/gpio_logic_high/gpio_logic_high.${rc_corner}.spef
      } elseif {$design == "mgmt_protect"} {
        set spef_mapping(powergood_check)                          $::env(CARAVEL_ROOT)/spef/mgmt_protect_hv/mgmt_protect_hv.${rc_corner}.spef
        set spef_mapping(mprj_logic_high_inst)                     $::env(CARAVEL_ROOT)/spef/mprj_logic_high/mprj_logic_high.${rc_corner}.spef
        set spef_mapping(mprj2_logic_high_inst)                    $::env(CARAVEL_ROOT)/spef/mprj2_logic_high/mprj2_logic_high.${rc_corner}.spef
      }

      foreach key [array names spef_mapping] {
        read_parasitics -path $key $spef_mapping($key)
      }

      if {$design == "mgmt_core_wrapper" | $design == "RAM128" | $design == "RAM256"} {
        read_parasitics -verbose $::env(MCW_ROOT)/spef/${design}/${design}.${rc_corner}.spef -pin_cap_included
      } else {
        read_parasitics -verbose $::env(CARAVEL_ROOT)/spef/${design}/${design}.${rc_corner}.spef -pin_cap_included
      }

    }
    proc report_results {design rc_corner proc_corner} {
      report_constraint -all_violators -significant_digits 4 -nosplit > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-all_viol.rpt

      report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
      -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-min_timing.rpt
      
      report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
      -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-max_timing.rpt

      if {$design == "caravel"} {
        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group clk \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-clk-min_timing.rpt
        
        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hk_serial_clk \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-hk_serial_clk-min_timing.rpt
        
        report_timing -delay max -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hk_serial_clk \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-hk_serial_clk-max_timing.rpt

        report_timing -delay min -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit -group hkspi_clk \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-hkspi_clk-min_timing.rpt

        report_timing -delay min -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-soc-min_timing.rpt

        report_timing -delay max -through [get_cells soc] -path_type full_clock_expanded -transition_time -capacitance -nets -nosplit \
        -max_paths 1000 -nworst 10 -slack_lesser_than 100 -significant_digits 4 -include_hierarchical_pins > $::env(OUT_DIR)/pt_reports/${design}/${design}-${rc_corner}-${proc_corner}-soc-max_timing.rpt
      }

      write_sdf -version 3.0 -significant_digits 4 $::env(OUT_DIR)/pt_sdf/${design}/${design}-${rc_corner}-${proc_corner}.sdf

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
      extract_model -output $::env(OUT_DIR)/pt_etm/${design}/${design}-${rc_corner}-${proc_corner} -format {db lib} -test_design
    }

    read_spefs $::env(DESIGN) $::env(RC_CORNER)
    update_timing
    report_results $::env(DESIGN) $::env(RC_CORNER) $::env(PROC_CORNER)

    exit
  } err]
} {
  puts stderr $err
  exit 1
}
