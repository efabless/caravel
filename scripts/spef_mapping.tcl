# mapping instances to a .spef to enable hierarchical parasitic annotation
if {$design == "caravel" | $design == "caravan"} {
    # user_project_wrapper spefs
    # update the path to match the spefs path
    set spef_mapping(mprj)                                     $::env(UPRJ_ROOT)/signoff/user_project_wrapper/openlane-signoff/spef/user_project_wrapper.${rc_corner}.spef
    if {$design == "caravan"} {
        set spef_mapping(mprj)                                 $::env(UPRJ_ROOT)/signoff/user_analog_project_wrapper/openlane-signoff/spef/user_analog_project_wrapper.${rc_corner}.spef
    }

    # add spefs of modules instantiated in user_project_wrapper/user_analog_project_wrapper here
    set spef_mapping(mprj/mprj)                                $::env(UPRJ_ROOT)/signoff/user_project_example/openlane-signoff/spef/user_project_example.${rc_corner}.spef

    #caravel/caravan macros
    set spef_mapping(flash_clkrst_buffers)                     $::env(CARAVEL_ROOT)/signoff/buff_flash_clkrst/openlane-signoff/buff_flash_clkrst.${rc_corner}.spef
    set spef_mapping(rstb_level)                               $::env(CARAVEL_ROOT)/signoff/xres_buf/openlane-signoff/xres_buf.${rc_corner}.spef

    set spef_mapping(padframe)                                 $::env(CARAVEL_ROOT)/signoff/chip_io/chip_io.${rc_corner}.spef
    if {$design == "caravan"} {
        set spef_mapping(padframe)                             $::env(CARAVEL_ROOT)/signoff/chip_io_alt/chip_io_alt.${rc_corner}.spef
    }
    set spef_mapping(padframe/\constant_value_inst[0])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[1])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[2])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[3])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[4])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[5])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[6])         $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef

    set spef_mapping(\spare_logic[0])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[1])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[2])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[3])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef

    set spef_mapping(housekeeping)                             $::env(CARAVEL_ROOT)/signoff/housekeeping/openlane-signoff/spef/housekeeping.${rc_corner}.spef
    set spef_mapping(pll)                                      $::env(CARAVEL_ROOT)/signoff/digital_pll/openlane-signoff/spef/digital_pll.${rc_corner}.spef
    set spef_mapping(clock_ctrl)                               $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.${rc_corner}.spef
    set spef_mapping(mgmt_buffers)                             $::env(CARAVEL_ROOT)/signoff/mgmt_protect/openlane-signoff/spef/mgmt_protect.${rc_corner}.spef
    set spef_mapping(mgmt_buffers/powergood_check)             $::env(CARAVEL_ROOT)/signoff/mgmt_protect_hv/openlane-signoff/spef/mgmt_protect_hv.${rc_corner}.spef
    set spef_mapping(mgmt_buffers/mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/signoff/mprj_logic_high/openlane-signoff/spef/mprj_logic_high.${rc_corner}.spef
    set spef_mapping(mgmt_buffers/mprj2_logic_high_inst)       $::env(CARAVEL_ROOT)/signoff/mprj2_logic_high/openlane-signoff/spef/mprj2_logic_high.${rc_corner}.spef

    set spef_mapping(soc)                                      $::env(MCW_ROOT)/signoff/mgmt_core_wrapper/openlane-signoff/spef/mgmt_core_wrapper.${rc_corner}.spef
    set spef_mapping(soc/\core.RAM256)                         $::env(MCW_ROOT)/signoff/RAM256/spef/openlane-signoff/spef/RAM256.${rc_corner}.spef
    set spef_mapping(soc/\core.RAM128)                         $::env(MCW_ROOT)/signoff/RAM128/spef/openlane-signoff/spef/RAM128.${rc_corner}.spef

    set spef_mapping(\gpio_control_bidir_1[0])                 $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_1[1])                 $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[0])                 $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[1])                 $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[2])                 $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[0])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[10])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[1])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[2])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[3])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[4])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[5])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[6])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[7])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[8])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[9])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[0])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[1])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[2])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[3])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[4])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[5])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[0])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[10])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[11])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[12])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[13])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[14])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[15])                   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[1])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[2])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[3])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[4])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[5])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[6])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[7])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[8])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[9])                    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.${rc_corner}.spef

    set spef_mapping(\gpio_control_bidir_1[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_1[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[2]/gpio_logic_high) $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[0]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[1]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[2]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[3]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[4]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[5]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[11]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[12]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[13]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[14]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[15]/gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef

    set spef_mapping(gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_1803/openlane-signoff/spef/gpio_defaults_block_1803.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_1803/openlane-signoff/spef/gpio_defaults_block_1803.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0801/openlane-signoff/spef/gpio_defaults_block_0801.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block_0403/openlane-signoff/spef/gpio_defaults_block_0403.${rc_corner}.spef

} elseif {$design == "mgmt_core_wrapper"} {
    set spef_mapping(\core.RAM128)                             $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    set spef_mapping(\core.RAM256)                             $::env(MCW_ROOT)/signoff/RAM512/openlane-signoff/spef/RAM512.${rc_corner}.spef
} elseif {$design == "gpio_control_block"} {
    set spef_mapping(gpio_logic_high)                          $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
} elseif {$design == "mgmt_protect"} {
    set spef_mapping(powergood_check)                          $::env(CARAVEL_ROOT)/signoff/mgmt_protect_hv/openlane-signoff/spef/mgmt_protect_hv.${rc_corner}.spef
    set spef_mapping(mprj_logic_high_inst)                     $::env(CARAVEL_ROOT)/signoff/mprj_logic_high/openlane-signoff/spef/mprj_logic_high.${rc_corner}.spef
    set spef_mapping(mprj2_logic_high_inst)                    $::env(CARAVEL_ROOT)/signoff/mprj2_logic_high/openlane-signoff/spef/mprj2_logic_high.${rc_corner}.spef
}