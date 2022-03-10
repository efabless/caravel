set std_cell_library        "sky130_fd_sc_hd"
set special_voltage_library "sky130_fd_sc_hvl"
set io_library              "sky130_fd_io"
set primitives_library      "sky130_fd_pr"

set signal_layer            "met2"
set clock_layer             "met5"

set extra_lefs "
    [glob $::env(CARAVEL_ROOT)/lef/*.lef]
    [glob $::env(MCW_ROOT)/lef/*.lef]
    [glob $::env(CUP_ROOT)/lef/*.lef]"
set tech_lef $::env(PDK_REF_PATH)/$std_cell_library/techlef/$std_cell_library.$::env(SPEF_CORNER).tlef
set cells_lef $::env(PDK_REF_PATH)/$std_cell_library/lef/$std_cell_library.lef

# search order:
# cup -> mcw -> caravel
set def $::env(CUP_ROOT)/def/$::env(BLOCK).def
set spef $::env(CUP_ROOT)/spef/$::env(BLOCK)_$::env(SPEF_CORNER).spef
if { ![file exists $def] } {
    set def $::env(MCW_ROOT)/def/$::env(BLOCK).def
    set spef $::env(MCW_ROOT)/spef/$::env(BLOCK)_$::env(SPEF_CORNER).spef
}
if { ![file exists $def] } {
    set def $::env(CARAVEL_ROOT)/def/$::env(BLOCK).def
    set spef $::env(CARAVEL_ROOT)/spef/$::env(BLOCK)_$::env(SPEF_CORNER).spef
}

set sdc $::env(CUP_ROOT)/sdc/$::env(BLOCK).sdc
if { ![file exists $sdc] } {
    set sdc $::env(MCW_ROOT)/sdc/$::env(BLOCK).sdc
}
if { ![file exists $sdc] } {
    set sdc $::env(CARAVEL_ROOT)/sdc/$::env(BLOCK).sdc
}

# not sure why we need sdf yet
set sdf $::env(CUP_ROOT)/sdf/$::env(BLOCK).sdf
if { ![file exists $sdf] } {
    set sdf $::env(MCW_ROOT)/sdf/$::env(BLOCK).sdf
}
if { ![file exists $sdf] } {
    set sdf $::env(CARAVEL_ROOT)/sdf/$::env(BLOCK).sdf
}

set block $::env(BLOCK)
set rcx_rules_file $::env(PDK_TECH_PATH)/openlane/rules.openrcx.sky130A.$::env(SPEF_CORNER).spef_extractor
set merged_lef $::env(CARAVEL_ROOT)/tmp/merged_lef-$::env(SPEF_CORNER).lef

set sram_lef $::env(PDK_REF_PATH)/sky130_sram_macros/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef

# order matter
set verilogs "
    [glob $::env(MCW_ROOT)/verilog/gl/*]
    [glob $::env(CARAVEL_ROOT)/verilog/gl/*]
    [glob $::env(CUP_ROOT)/verilog/gl/*]
"

set verilog_exceptions {}
lappend verilog_exceptions "$::env(CARAVEL_ROOT)/verilog/gl/__user_analog_project_wrapper.v"
lappend verilog_exceptions "$::env(CARAVEL_ROOT)/verilog/gl/__user_project_wrapper.v"

foreach verilog_exception $verilog_exceptions {
    set verilogs [regsub "$verilog_exception" "$verilogs" ""]
}

set spef_mapping(gpio_defaults_block_0)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
set spef_mapping(gpio_defaults_block_1)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
set spef_mapping(gpio_defaults_block_2)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
set spef_mapping(gpio_defaults_block_3)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
set spef_mapping(gpio_defaults_block_4)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
set spef_mapping(rstb_level)                         $::env(CARAVEL_ROOT)/spef/xres_buf.spef
set spef_mapping(mgmt_buffers/powergood_check)       $::env(CARAVEL_ROOT)/spef/mgmt_protect_hv.spef
set spef_mapping(soc/DFFRAM_0)                       $::env(MCW_ROOT)/spef/DFFRAM_$::env(SPEF_CORNER).spef
set spef_mapping(soc/core)                           $::env(MCW_ROOT)/spef/mgmt_core_$::env(SPEF_CORNER).spef
set spef_mapping(soc)                                $::env(MCW_ROOT)/spef/mgmt_core_wrapper_$::env(SPEF_CORNER).spef
set spef_mapping(padframe)                           $::env(CARAVEL_ROOT)/spef/chip_io_$::env(SPEF_CORNER).spef
set spef_mapping(pll)                                $::env(CARAVEL_ROOT)/spef/digital_pll_$::env(SPEF_CORNER).spef
set spef_mapping(housekeeping)                       $::env(CARAVEL_ROOT)/spef/housekeeping_$::env(SPEF_CORNER).spef
set spef_mapping(mgmt_buffers/mprj_logic_high_inst)  $::env(CARAVEL_ROOT)/spef/mprj_logic_high_$::env(SPEF_CORNER).spef
set spef_mapping(mgmt_buffers/mprj2_logic_high_inst) $::env(CARAVEL_ROOT)/spef/mprj2_logic_high_$::env(SPEF_CORNER).spef
set spef_mapping(mgmt_buffers)                       $::env(CARAVEL_ROOT)/spef/mgmt_protect_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_bidir_1[0])            $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_bidir_1[1])            $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_bidir_2[1])            $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_bidir_2[2])            $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[0])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[10])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[1])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[2])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[3])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[4])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[5])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[6])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[7])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[8])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1[9])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[0])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[1])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[2])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[3])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[4])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_1a[5])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[0])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[10])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[11])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[12])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[13])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[14])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[15])              $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[1])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[2])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[3])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[4])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[5])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[6])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[7])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[8])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_control_in_2[9])               $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_5)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_6)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_7)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_8)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_9)              $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_10)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_11)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_12)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_13)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_14)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_15)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_16)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_17)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_18)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_19)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_20)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_21)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_22)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_23)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_24)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_25)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_26)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_27)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_28)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_29)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_30)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_31)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_32)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_33)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_34)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_35)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_36)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef
set spef_mapping(gpio_defaults_block_37)             $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(SPEF_CORNER).spef

