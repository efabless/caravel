if {$::env(PROC_CORNER) == "t"} {
    puts "\nset link_path \"* $::env(PT_LIB_ROOT)/scs130hd_tt_1.80v_25C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_25C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_lowhv_3.3v_lv_1.8v_25C.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib 
    \""
    set link_path "* $::env(PT_LIB_ROOT)/scs130hd_tt_1.80v_25C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_25C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_tt_3.3v_lowhv_3.3v_lv_1.8v_25C.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib \
    "
} elseif {$::env(PROC_CORNER) == "f"} {
    puts "\nset link_path \"* $::env(PT_LIB_ROOT)/scs130hd_ff_1.95v_-40C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_-40C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_lowhv_5.5v_lv_1.95v_-40C.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_ff_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ff_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ff_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ff_n40C_1v95_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib 
    \""
    set link_path "* $::env(PT_LIB_ROOT)/scs130hd_ff_1.95v_-40C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_-40C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_ff_5.5v_lowhv_5.5v_lv_1.95v_-40C.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_ff_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ff_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ff_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ff_n40C_1v95_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_ff_n40C_1v95_5v50_5v50.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib \
    "
} elseif {$::env(PROC_CORNER) == "s"} {
    puts "\nset link_path \"* $::env(PT_LIB_ROOT)/scs130hd_ss_1.60v_100C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_ss_3.00v_100C.lib 
    $::env(PT_LIB_ROOT)/scs130hvl_ss_3.00v_lowhv_1.65v_lv_1.6v_100C.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_ss_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ss_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ss_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ss_100C_1v60_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib 
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib 
    \""
    set link_path "* $::env(PT_LIB_ROOT)/scs130hd_ss_1.60v_100C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_ss_3.00v_100C.lib \
    $::env(PT_LIB_ROOT)/scs130hvl_ss_3.00v_lowhv_1.65v_lv_1.6v_100C.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_ss_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_ss_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_wrapped_ss_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_ss_100C_1v60_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_ss_100C_1v60_3v00_3v00.lib \
    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib \
    "
}
puts "\[INFO\]: set link_path for PDK: $::env(PDK)"