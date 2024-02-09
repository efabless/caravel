# mapping instances to a .spef to enable hierarchical parasitic annotation
if {$design == "user_project_wrapper"} {
    # add spefs of modules instantiated in user_project_wrapper/user_analog_project_wrapper here
    set spef_mapping(mprj)                            $::env(UPRJ_ROOT)/signoff/user_proj_example/openlane-signoff/spef/user_proj_example.${rc_corner}.spef

} elseif {$design == $::env(CHIP_CORE)} {
    if {$::env(UPW)} {
        # user_project_wrapper spefs
        # update the path to match the spefs path
        if {$design == "caravan_core"} {
            set spef_mapping(mprj)                             $::env(UPRJ_ROOT)/signoff/user_analog_project_wrapper/openlane-signoff/spef/user_analog_project_wrapper.${rc_corner}.spef
        } else {
            set spef_mapping(mprj)                             $::env(UPRJ_ROOT)/signoff/user_project_wrapper/openlane-signoff/spef/user_project_wrapper.${rc_corner}.spef
        }
        # add spefs of modules instantiated in user_project_wrapper/user_analog_project_wrapper here
        # set spef_mapping(mprj/mprj)                            $::env(UPRJ_ROOT)/signoff/user_proj_example/openlane-signoff/spef/user_proj_example.${rc_corner}.spef
    }

    #caravel litex macros
    set spef_mapping(\soc.core.RAM256.BANK128[0].RAM128)          $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    set spef_mapping(\soc.core.RAM256.BANK128[1].RAM128)          $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    set spef_mapping(\soc.core.RAM128)                            $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    
    set spef_mapping(clock_ctrl)                             $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.${rc_corner}.spef
    if {$design == "caravan_core"} {
        set spef_mapping(housekeeping_alt)                       $::env(CARAVEL_ROOT)/signoff/housekeeping_alt/openlane-signoff/spef/housekeeping_alt.${rc_corner}.spef
    } else {
        set spef_mapping(housekeeping)                           $::env(CARAVEL_ROOT)/signoff/housekeeping/openlane-signoff/spef/housekeeping.${rc_corner}.spef
    }    
    set spef_mapping(gpio_buf)                               $::env(CARAVEL_ROOT)/signoff/mprj_io_buffer/openlane-signoff/spef/mprj_io_buffer.${rc_corner}.spef

    set spef_mapping(rstb_level)                             $::env(CARAVEL_ROOT)/signoff/xres_buf/openlane-signoff/spef/xres_buf.${rc_corner}.spef
    set spef_mapping(por)                                    $::env(CARAVEL_ROOT)/signoff/simple_por/openlane-signoff/spef/simple_por.${rc_corner}.spef


    set spef_mapping(\spare_logic[0])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[1])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[2])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(\spare_logic[3])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef

    set spef_mapping(gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_34)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef

    set spef_mapping(\gpio_control_bidir_1[0].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_1[1].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[0].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[1].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_bidir_2[2].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[0].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[10].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[1].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[2].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[3].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[4].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[5].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[6].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[7].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[8].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1[9].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[0].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[1].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[2].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[3].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[4].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_1a[5].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[0].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[10].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[11].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[12].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[13].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[14].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[15].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[1].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[2].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[3].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[4].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[5].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[6].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[7].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[8].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(\gpio_control_in_2[9].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    
    set spef_mapping(mgmt_buffers.powergood_check)             $::env(CARAVEL_ROOT)/signoff/mgmt_protect_hv/openlane-signoff/spef/mgmt_protect_hv.${rc_corner}.spef
    set spef_mapping(mgmt_buffers.mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/signoff/mprj_logic_high/openlane-signoff/spef/mprj_logic_high.${rc_corner}.spef
    set spef_mapping(mgmt_buffers.mprj2_logic_high_inst)       $::env(CARAVEL_ROOT)/signoff/mprj2_logic_high/openlane-signoff/spef/mprj2_logic_high.${rc_corner}.spef
    
    set spef_mapping(user_id_value)                            $::env(CARAVEL_ROOT)/signoff/user_id_programming/openlane-signoff/spef/user_id_programming.${rc_corner}.spef
} elseif {$design == $::env(CHIP)} {
    if {$::env(UPW)} {
        # user_project_wrapper spefs
        # update the path to match the spefs path
        if {$design == "caravan"} {
            set spef_mapping(chip_core/mprj)                             $::env(UPRJ_ROOT)/signoff/user_analog_project_wrapper/openlane-signoff/spef/user_analog_project_wrapper.${rc_corner}.spef
        } else {
            set spef_mapping(chip_core/mprj)                                 $::env(UPRJ_ROOT)/signoff/user_project_wrapper/openlane-signoff/spef/user_project_wrapper.${rc_corner}.spef
        }

        # add spefs of modules instantiated in user_project_wrapper/user_analog_project_wrapper here
        # set spef_mapping(chip_core/mprj/mprj)                            $::env(UPRJ_ROOT)/signoff/user_proj_example/openlane-signoff/spef/user_proj_example.${rc_corner}.spef
    }

    if {$design == "caravan"} {
        set spef_mapping(padframe)                                          $::env(CARAVEL_ROOT)/signoff/chip_io_alt/openlane-signoff/spef/chip_io_alt.${rc_corner}.spef
    } else {
        set spef_mapping(padframe)                                          $::env(CARAVEL_ROOT)/signoff/chip_io/openlane-signoff/spef/chip_io.${rc_corner}.spef
    }

    set spef_mapping(padframe/\constant_value_inst[0])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[1])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[2])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[3])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[4])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[5])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef
    set spef_mapping(padframe/\constant_value_inst[6])                  $::env(CARAVEL_ROOT)/signoff/constant_block/openlane-signoff/spef/constant_block.${rc_corner}.spef

    set spef_mapping(chip_core)                                          $::env(CARAVEL_ROOT)/signoff/$::env(CHIP_CORE)/openlane-signoff/spef/$::env(CHIP_CORE).${rc_corner}.spef

    #caravel litex macros
    set spef_mapping(chip_core/\soc.core.RAM256.BANK128[0].RAM128)          $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    set spef_mapping(chip_core/\soc.core.RAM256.BANK128[1].RAM128)          $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    set spef_mapping(chip_core/\soc.core.RAM128)                            $::env(MCW_ROOT)/signoff/RAM128/openlane-signoff/spef/RAM128.${rc_corner}.spef
    
    set spef_mapping(chip_core/clock_ctrl)                             $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.${rc_corner}.spef
    if {$design == "caravan"} {
        set spef_mapping(chip_core/housekeeping_alt)                       $::env(CARAVEL_ROOT)/signoff/housekeeping_alt/openlane-signoff/spef/housekeeping_alt.${rc_corner}.spef
    } else {
        set spef_mapping(chip_core/housekeeping)                           $::env(CARAVEL_ROOT)/signoff/housekeeping/openlane-signoff/spef/housekeeping.${rc_corner}.spef
    }
    set spef_mapping(chip_core/gpio_buf)                               $::env(CARAVEL_ROOT)/signoff/mprj_io_buffer/openlane-signoff/spef/mprj_io_buffer.${rc_corner}.spef

    set spef_mapping(chip_core/rstb_level)                             $::env(CARAVEL_ROOT)/signoff/xres_buf/openlane-signoff/spef/xres_buf.${rc_corner}.spef
    set spef_mapping(chip_core/por)                                    $::env(CARAVEL_ROOT)/signoff/simple_por/openlane-signoff/spef/simple_por.${rc_corner}.spef


    set spef_mapping(chip_core/\spare_logic[0])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(chip_core/\spare_logic[1])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(chip_core/\spare_logic[2])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef
    set spef_mapping(chip_core/\spare_logic[3])                          $::env(CARAVEL_ROOT)/signoff/spare_logic_block/openlane-signoff/spef/spare_logic_block.${rc_corner}.spef

    set spef_mapping(chip_core/gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_34)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef
    set spef_mapping(chip_core/gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/signoff/gpio_defaults_block/openlane-signoff/spef/gpio_defaults_block.${rc_corner}.spef

    set spef_mapping(chip_core/\gpio_control_bidir_1[0].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_bidir_1[1].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_bidir_2[0].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_bidir_2[1].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_bidir_2[2].gpio_logic_high)   $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[0].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[10].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[1].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[2].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[3].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[4].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[5].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[6].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[7].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[8].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1[9].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[0].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[1].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[2].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[3].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[4].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_1a[5].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[0].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[10].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[11].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[12].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[13].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[14].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[15].gpio_logic_high)     $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[1].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[2].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[3].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[4].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[5].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[6].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[7].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[8].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/\gpio_control_in_2[9].gpio_logic_high)      $::env(CARAVEL_ROOT)/signoff/gpio_logic_high/openlane-signoff/spef/gpio_logic_high.${rc_corner}.spef
    
    set spef_mapping(chip_core/mgmt_buffers.powergood_check)             $::env(CARAVEL_ROOT)/signoff/mgmt_protect_hv/openlane-signoff/spef/mgmt_protect_hv.${rc_corner}.spef
    set spef_mapping(chip_core/mgmt_buffers.mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/signoff/mprj_logic_high/openlane-signoff/spef/mprj_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/mgmt_buffers.mprj2_logic_high_inst)       $::env(CARAVEL_ROOT)/signoff/mprj2_logic_high/openlane-signoff/spef/mprj2_logic_high.${rc_corner}.spef
    set spef_mapping(chip_core/user_id_value)                            $::env(CARAVEL_ROOT)/signoff/user_id_programming/openlane-signoff/spef/user_id_programming.${rc_corner}.spef
}
puts "\[INFO\]: Spef mapping done"