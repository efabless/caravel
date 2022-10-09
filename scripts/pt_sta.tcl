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

# proc spefs {design rc_corner proc_corner} {
#   set spef_mapping(rstb_level)                               ./files/from-def/spef/xres_buf-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(padframe)                                 ./files/from-def/spef/chip_io-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(housekeeping)                             ./files/from-def/spef/housekeeping-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(mgmt_buffers)                             ./files/from-def/spef/mgmt_protect-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(pll)                                      ./files/from-def/spef/digital_pll-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(clocking)                                 ./files/from-def/spef/caravel_clocking-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(soc)                                      ./files/from-def/spef/mgmt_core_wrapper-${rc_corner}-${proc_corner}.spef

#   set spef_mapping(mgmt_buffers/powergood_check)             ./files/from-def/spef/mgmt_protect_hv-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(mgmt_buffers/mprj_logic_high_inst)        ./files/from-def/spef/mprj_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(soc/DFFRAM_0)                             ./files/from-def/spef/DFFRAM-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(soc/core)                                 ./files/from-def/spef/mgmt_core-${rc_corner}-${proc_corner}.spef

#   set spef_mapping(\gpio_control_bidir_1[0]/gpio_logic_high) ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_1[1]/gpio_logic_high) ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[0]/gpio_logic_high) ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[1]/gpio_logic_high) ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[2]/gpio_logic_high) ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[0]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[10]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[1]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[2]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[3]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[4]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[5]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[6]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[7]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[8]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[9]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[0]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[1]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[2]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[3]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[4]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[5]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[0]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[10]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[11]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[12]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[13]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[14]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[15]/gpio_logic_high)   ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[1]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[2]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[3]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[4]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[5]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[6]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[7]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[8]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[9]/gpio_logic_high)    ./files/from-def/spef/gpio_logic_high-${rc_corner}-${proc_corner}.spef

#   set spef_mapping(gpio_defaults_block_0)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_1)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_10)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_10)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_11)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_12)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_13)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_14)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_15)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_16)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_17)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_18)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_19)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_2)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_20)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_21)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_22)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_23)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_24)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_25)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_26)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_27)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_28)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_29)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_3)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_30)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_31)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_32)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_33)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_35)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_36)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_37)                   ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_4)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_5)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_6)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_7)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_8)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_block_9)                    ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(gpio_defaults_defaults_block_34)          ./files/from-def/spef/gpio_defaults_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_1[0])                 ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_1[1])                 ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[0])                 ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[1])                 ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_bidir_2[2])                 ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[0])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[10])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[1])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[2])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[3])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[4])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[5])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[6])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[7])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[8])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1[9])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[0])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[1])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[2])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[3])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[4])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_1a[5])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[0])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[10])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[11])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[12])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[13])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[14])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[15])                   ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[1])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[2])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[3])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[4])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[5])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[6])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[7])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[8])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef
#   set spef_mapping(\gpio_control_in_2[9])                    ./files/from-def/spef/gpio_control_block-${rc_corner}-${proc_corner}.spef

#   foreach key [array names spef_mapping] {
#     read_parasitics -path $key $spef_mapping($key)
#   }
# }
proc read_spefs {design} {
  set spef_mapping(rstb_level)                               $::env(CARAVEL_ROOT)/spef/xres_buf.spef
  set spef_mapping(padframe)                                 $::env(CARAVEL_ROOT)/spef/chip_io.spef
  set spef_mapping(housekeeping)                             $::env(CARAVEL_ROOT)/spef/housekeeping.spef
  set spef_mapping(mgmt_buffers)                             $::env(CARAVEL_ROOT)/spef/mgmt_protect.spef
  set spef_mapping(pll)                                      $::env(CARAVEL_ROOT)/spef/digital_pll.spef
  set spef_mapping(clocking)                                 $::env(CARAVEL_ROOT)/spef/caravel_clocking.spef
  set spef_mapping(soc)                                      $::env(MCW_ROOT)/spef/mgmt_core_wrapper.spef

  set spef_mapping(mgmt_buffers/powergood_check)             $::env(CARAVEL_ROOT)/spef/mgmt_protect_hv.spef
  set spef_mapping(mgmt_buffers/mprj_logic_high_inst)        $::env(CARAVEL_ROOT)/spef/mprj_logic_high.spef
  set spef_mapping(soc/DFFRAM_0)                             $::env(MCW_ROOT)/spef/DFFRAM.spef
  set spef_mapping(soc/core)                                 $::env(MCW_ROOT)/spef/mgmt_core.spef

  set spef_mapping(\gpio_control_bidir_1[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_bidir_1[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_bidir_2[0]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_bidir_2[1]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_bidir_2[2]/gpio_logic_high) $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[0]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[1]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[2]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[3]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[4]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_1a[5]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[0]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[10]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[11]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[12]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[13]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[14]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[15]/gpio_logic_high)   $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[1]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[2]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[3]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[4]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[5]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[6]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[7]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[8]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef
  set spef_mapping(\gpio_control_in_2[9]/gpio_logic_high)    $::env(CARAVEL_ROOT)/spef/gpio_logic_high.spef

  set spef_mapping(gpio_defaults_block_0)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
  set spef_mapping(gpio_defaults_block_1)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
  set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_10)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_11)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_12)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_13)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_14)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_15)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_16)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_17)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_18)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_19)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_2)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_20)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_21)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_22)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_23)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_24)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_25)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_26)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_27)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_28)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_29)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_3)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block.spef
  set spef_mapping(gpio_defaults_block_30)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_31)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_32)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_33)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_35)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_36)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_37)                   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_4)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_5)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_6)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_7)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_8)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(gpio_defaults_block_9)                    $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
  set spef_mapping(\gpio_control_bidir_1[0])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_bidir_1[1])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_bidir_2[0])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_bidir_2[1])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_bidir_2[2])                 $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[0])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[10])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[1])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[2])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[3])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[4])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[5])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[6])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[7])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[8])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1[9])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[0])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[1])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[2])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[3])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[4])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_1a[5])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[0])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[10])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[11])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[12])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[13])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[14])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[15])                   $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[1])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[2])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[3])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[4])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[5])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[6])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[7])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[8])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef
  set spef_mapping(\gpio_control_in_2[9])                    $::env(CARAVEL_ROOT)/spef/gpio_control_block.spef

  foreach key [array names spef_mapping] {
    read_parasitics -path $key $spef_mapping($key)
  }
  read_parasitics -verbose $::env(CARAVEL_ROOT)/spef/$::env(DESIGN).spef -pin_cap_included
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

read_spefs $::env(DESIGN)
update_timing
report_results $::env(DESIGN) $::env(RC_CORNER) $::env(PROC_CORNER)

exit