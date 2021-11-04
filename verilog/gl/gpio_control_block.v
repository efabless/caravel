module gpio_control_block (mgmt_gpio_in,
    mgmt_gpio_oeb,
    mgmt_gpio_out,
    one,
    pad_gpio_ana_en,
    pad_gpio_ana_pol,
    pad_gpio_ana_sel,
    pad_gpio_holdover,
    pad_gpio_ib_mode_sel,
    pad_gpio_in,
    pad_gpio_inenb,
    pad_gpio_out,
    pad_gpio_outenb,
    pad_gpio_slow_sel,
    pad_gpio_vtrip_sel,
    resetn,
    resetn_out,
    serial_clock,
    serial_clock_out,
    serial_data_in,
    serial_data_out,
    serial_load,
    serial_load_out,
    user_gpio_in,
    user_gpio_oeb,
    user_gpio_out,
    vccd,
    vccd1,
    vssd,
    vssd1,
    zero,
    gpio_defaults,
    pad_gpio_dm);
 output mgmt_gpio_in;
 input mgmt_gpio_oeb;
 input mgmt_gpio_out;
 output one;
 output pad_gpio_ana_en;
 output pad_gpio_ana_pol;
 output pad_gpio_ana_sel;
 output pad_gpio_holdover;
 output pad_gpio_ib_mode_sel;
 input pad_gpio_in;
 output pad_gpio_inenb;
 output pad_gpio_out;
 output pad_gpio_outenb;
 output pad_gpio_slow_sel;
 output pad_gpio_vtrip_sel;
 input resetn;
 output resetn_out;
 input serial_clock;
 output serial_clock_out;
 input serial_data_in;
 output serial_data_out;
 input serial_load;
 output serial_load_out;
 output user_gpio_in;
 input user_gpio_oeb;
 input user_gpio_out;
 input vccd;
 input vccd1;
 input vssd;
 input vssd1;
 output zero;
 input [12:0] gpio_defaults;
 output [2:0] pad_gpio_dm;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire clknet_0_serial_clock;
 wire clknet_1_0_0_serial_clock;
 wire clknet_1_1_0_serial_clock;
 wire gpio_logic1;
 wire gpio_outenb;
 wire mgmt_ena;
 wire net1;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net2;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net3;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net4;
 wire net40;
 wire net41;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire serial_data_pre;
 wire \shift_register[0] ;
 wire \shift_register[10] ;
 wire \shift_register[11] ;
 wire \shift_register[1] ;
 wire \shift_register[2] ;
 wire \shift_register[3] ;
 wire \shift_register[4] ;
 wire \shift_register[5] ;
 wire \shift_register[6] ;
 wire \shift_register[7] ;
 wire \shift_register[8] ;
 wire \shift_register[9] ;

 sky130_fd_sc_hd__diode_2 ANTENNA_0 (.DIODE(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_1 (.DIODE(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_10 (.DIODE(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_11 (.DIODE(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_12 (.DIODE(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_13 (.DIODE(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_14 (.DIODE(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_15 (.DIODE(one),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_16 (.DIODE(one),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_17 (.DIODE(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_18 (.DIODE(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_19 (.DIODE(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_2 (.DIODE(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_20 (.DIODE(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_21 (.DIODE(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_3 (.DIODE(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_4 (.DIODE(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_5 (.DIODE(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_6 (.DIODE(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_7 (.DIODE(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_8 (.DIODE(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_9 (.DIODE(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_46 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_50 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_52 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_59 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_77 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_10_23 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_10_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_10_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_10_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_11_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_11_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_11_54 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_12_12 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_12_69 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_12_75 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 FILLER_13_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_13_22 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_8 FILLER_13_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_4 FILLER_14_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_7 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_14_82 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_15_9 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_16_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_15 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_16_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_7 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 FILLER_16_77 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_85 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_63 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_47 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_3_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_34 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_3_64 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_4_61 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_5_32 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_6_61 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_6_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_7_77 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_7_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_8_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_8_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_9_16 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_9_20 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_9_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_9_54 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_9_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_0 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_1 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_10 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_12 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_13 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_14 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_15 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_16 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_17 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_18 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_19 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_2 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_20 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_21 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_22 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_23 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_25 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_28 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_30 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_31 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_32 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_33 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_4 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_5 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_6 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_7 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_8 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_9 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_34 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_35 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_36 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_37 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_38 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_39 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_40 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_41 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_42 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_43 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_44 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_45 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_46 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_47 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_48 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_49 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_50 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_51 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_52 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_53 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_54 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_55 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_56 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_57 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_58 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _102_ (.A(net17),
    .B_N(net11),
    .X(_073_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _103_ (.A(_073_),
    .X(_043_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _104_ (.A(net17),
    .B(net11),
    .X(_074_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _105_ (.A(_074_),
    .X(_042_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__inv_2 _106_ (.A(net19),
    .Y(_075_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dlymetal6s2s_1 _107_ (.A(_075_),
    .X(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _108_ (.A(net17),
    .B_N(net10),
    .X(_076_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _109_ (.A(_076_),
    .X(_040_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _110_ (.A(net17),
    .B(net10),
    .X(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _111_ (.A(_077_),
    .X(_039_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _112_ (.A(_041_),
    .X(_078_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _113_ (.A(_078_),
    .X(_038_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _114_ (.A(net17),
    .B_N(net9),
    .X(_079_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _115_ (.A(_079_),
    .X(_037_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _116_ (.A(net17),
    .B(net9),
    .X(_080_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _117_ (.A(_080_),
    .X(_036_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _118_ (.A(_041_),
    .X(_081_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _119_ (.A(_081_),
    .X(_035_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _120_ (.A(net17),
    .B_N(net4),
    .X(_082_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _121_ (.A(_082_),
    .X(_034_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _122_ (.A(net17),
    .B(net4),
    .X(_083_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _123_ (.A(_083_),
    .X(_033_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _124_ (.A(_041_),
    .X(_084_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _125_ (.A(_084_),
    .X(_032_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _126_ (.A(net17),
    .B_N(net3),
    .X(_085_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _127_ (.A(_085_),
    .X(_031_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _128_ (.A(net17),
    .B(net3),
    .X(_086_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _129_ (.A(_086_),
    .X(_030_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _130_ (.A(_041_),
    .X(_087_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _131_ (.A(_087_),
    .X(_029_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _132_ (.A(net17),
    .B_N(net2),
    .X(_088_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _133_ (.A(_088_),
    .X(_028_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _134_ (.A(net17),
    .B(net2),
    .X(_045_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _135_ (.A(_045_),
    .X(_027_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dlymetal6s2s_1 _136_ (.A(_075_),
    .X(_046_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _137_ (.A(_046_),
    .X(_047_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _138_ (.A(_047_),
    .X(_026_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _139_ (.A(net17),
    .B_N(net5),
    .X(_048_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _140_ (.A(_048_),
    .X(_025_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _141_ (.A(net17),
    .B(net5),
    .X(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _142_ (.A(_049_),
    .X(_024_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _143_ (.A(_046_),
    .X(_050_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _144_ (.A(_050_),
    .X(_023_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _145_ (.A(net17),
    .B_N(net8),
    .X(_051_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _146_ (.A(_051_),
    .X(_022_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _147_ (.A(net17),
    .B(net8),
    .X(_052_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _148_ (.A(_052_),
    .X(_021_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _149_ (.A(_046_),
    .X(_053_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _150_ (.A(_053_),
    .X(_020_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _151_ (.A(net17),
    .B_N(net7),
    .X(_054_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _152_ (.A(_054_),
    .X(_019_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _153_ (.A(net17),
    .B(net7),
    .X(_055_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _154_ (.A(_055_),
    .X(_018_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _155_ (.A(_046_),
    .X(_056_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _156_ (.A(_056_),
    .X(_017_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _157_ (.A(net17),
    .B_N(net13),
    .X(_057_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _158_ (.A(_057_),
    .X(_016_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _159_ (.A(net17),
    .B(net13),
    .X(_058_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _160_ (.A(_058_),
    .X(_015_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _161_ (.A(_046_),
    .X(_059_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _162_ (.A(_059_),
    .X(_014_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _163_ (.A(net17),
    .B_N(net12),
    .X(_060_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _164_ (.A(_060_),
    .X(_013_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _165_ (.A(net17),
    .B(net12),
    .X(_061_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _166_ (.A(_061_),
    .X(_012_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _167_ (.A(_075_),
    .X(_062_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _168_ (.A(_062_),
    .X(_011_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _169_ (.A(net17),
    .B_N(net6),
    .X(_063_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _170_ (.A(_063_),
    .X(_010_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _171_ (.A(net17),
    .B(net6),
    .X(_064_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _172_ (.A(_064_),
    .X(_009_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _173_ (.A(_075_),
    .X(_065_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _174_ (.A(_065_),
    .X(_008_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _175_ (.A(net17),
    .B_N(net1),
    .X(_066_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _176_ (.A(_066_),
    .X(_007_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2_1 _177_ (.A(net1),
    .B(net17),
    .X(_067_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _178_ (.A(_067_),
    .X(_006_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _179_ (.A(net31),
    .B_N(gpio_outenb),
    .X(_068_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _180_ (.A(_068_),
    .X(_089_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__and2_1 _181_ (.A(gpio_outenb),
    .B(net14),
    .X(_069_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _182_ (.A(_069_),
    .X(_000_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_1 _183_ (.A(net28),
    .B_N(net27),
    .X(_070_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _184_ (.A(_070_),
    .X(_002_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__inv_2 _185_ (.A(net16),
    .Y(_005_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__and2_1 _186_ (.A(one),
    .B(serial_data_pre),
    .X(_071_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _187_ (.A(_071_),
    .X(net38),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _188_ (.A(_075_),
    .X(_072_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _189_ (.A(_072_),
    .X(_044_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _190_ (.A(net17),
    .X(net36),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 _191_ (.A(clknet_1_1_0_serial_clock),
    .X(net37),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 _192_ (.A(net19),
    .X(net39),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__mux2_1 _193_ (.A0(net20),
    .A1(_000_),
    .S(mgmt_ena),
    .X(net33),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__mux2_1 _194_ (.A0(_001_),
    .A1(net15),
    .S(_002_),
    .X(_003_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__mux2_1 _195_ (.A0(net15),
    .A1(_003_),
    .S(net14),
    .X(_004_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__mux2_1 _196_ (.A0(net21),
    .A1(_004_),
    .S(mgmt_ena),
    .X(net32),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__ebufn_1 _197_ (.A(net16),
    .TE_B(_089_),
    .Z(mgmt_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _198_ (.D(\shift_register[0] ),
    .Q(mgmt_ena),
    .Q_N(_090_),
    .RESET_B(_006_),
    .SET_B(_007_),
    .CLK_N(_008_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _199_ (.D(\shift_register[2] ),
    .Q(net29),
    .Q_N(_091_),
    .RESET_B(_009_),
    .SET_B(_010_),
    .CLK_N(_011_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _200_ (.D(\shift_register[8] ),
    .Q(net34),
    .Q_N(_092_),
    .RESET_B(_012_),
    .SET_B(_013_),
    .CLK_N(_014_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _201_ (.D(\shift_register[9] ),
    .Q(net35),
    .Q_N(_093_),
    .RESET_B(_015_),
    .SET_B(_016_),
    .CLK_N(_017_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _202_ (.D(\shift_register[3] ),
    .Q(net31),
    .Q_N(_094_),
    .RESET_B(_018_),
    .SET_B(_019_),
    .CLK_N(_020_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _203_ (.D(\shift_register[4] ),
    .Q(net30),
    .Q_N(_095_),
    .RESET_B(_021_),
    .SET_B(_022_),
    .CLK_N(_023_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _204_ (.D(\shift_register[1] ),
    .Q(gpio_outenb),
    .Q_N(_096_),
    .RESET_B(_024_),
    .SET_B(_025_),
    .CLK_N(_026_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _205_ (.D(\shift_register[10] ),
    .Q(net26),
    .Q_N(_001_),
    .RESET_B(_027_),
    .SET_B(_028_),
    .CLK_N(_029_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _206_ (.D(\shift_register[11] ),
    .Q(net27),
    .Q_N(_097_),
    .RESET_B(_030_),
    .SET_B(_031_),
    .CLK_N(_032_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _207_ (.D(serial_data_pre),
    .Q(net28),
    .Q_N(_098_),
    .RESET_B(_033_),
    .SET_B(_034_),
    .CLK_N(_035_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _208_ (.D(\shift_register[5] ),
    .Q(net23),
    .Q_N(_099_),
    .RESET_B(_036_),
    .SET_B(_037_),
    .CLK_N(_038_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _209_ (.D(\shift_register[6] ),
    .Q(net25),
    .Q_N(_100_),
    .RESET_B(_039_),
    .SET_B(_040_),
    .CLK_N(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfbbn_1 _210_ (.D(\shift_register[7] ),
    .Q(net24),
    .Q_N(_101_),
    .RESET_B(_042_),
    .SET_B(_043_),
    .CLK_N(_044_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _211_ (.D(net18),
    .Q(\shift_register[0] ),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _212_ (.D(\shift_register[0] ),
    .Q(\shift_register[1] ),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _213_ (.D(\shift_register[1] ),
    .Q(\shift_register[2] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _214_ (.D(\shift_register[2] ),
    .Q(\shift_register[3] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _215_ (.D(\shift_register[3] ),
    .Q(\shift_register[4] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _216_ (.D(\shift_register[4] ),
    .Q(\shift_register[5] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _217_ (.D(\shift_register[5] ),
    .Q(\shift_register[6] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _218_ (.D(\shift_register[6] ),
    .Q(\shift_register[7] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _219_ (.D(\shift_register[7] ),
    .Q(\shift_register[8] ),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _220_ (.D(\shift_register[8] ),
    .Q(\shift_register[9] ),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _221_ (.D(\shift_register[9] ),
    .Q(\shift_register[10] ),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _222_ (.D(\shift_register[10] ),
    .Q(\shift_register[11] ),
    .RESET_B(net17),
    .CLK(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__dfrtp_1 _223_ (.D(net41),
    .Q(serial_data_pre),
    .RESET_B(net17),
    .CLK(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_clock (.A(serial_clock),
    .X(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0_serial_clock (.A(clknet_0_serial_clock),
    .X(clknet_1_0_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0_serial_clock (.A(clknet_0_serial_clock),
    .X(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__conb_1 const_source (.HI(one),
    .LO(zero),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__einvp_2 gpio_in_buf (.A(_005_),
    .TE(gpio_logic1),
    .Z(net40),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 gpio_logic_high gpio_logic_high (.gpio_logic1(gpio_logic1),
    .vccd1(vccd1),
    .vssd1(vssd1));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold1 (.A(\shift_register[11] ),
    .X(net41),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(gpio_defaults[0]),
    .X(net1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input10 (.A(gpio_defaults[6]),
    .X(net10),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(gpio_defaults[7]),
    .X(net11),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input12 (.A(gpio_defaults[8]),
    .X(net12),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input13 (.A(gpio_defaults[9]),
    .X(net13),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input14 (.A(mgmt_gpio_oeb),
    .X(net14),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input15 (.A(mgmt_gpio_out),
    .X(net15),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input16 (.A(pad_gpio_in),
    .X(net16),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_12 input17 (.A(resetn),
    .X(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input18 (.A(serial_data_in),
    .X(net18),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input19 (.A(serial_load),
    .X(net19),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(gpio_defaults[10]),
    .X(net2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input20 (.A(user_gpio_oeb),
    .X(net20),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input21 (.A(user_gpio_out),
    .X(net21),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(gpio_defaults[11]),
    .X(net3),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(gpio_defaults[12]),
    .X(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(gpio_defaults[1]),
    .X(net5),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(gpio_defaults[2]),
    .X(net6),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(gpio_defaults[3]),
    .X(net7),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(gpio_defaults[4]),
    .X(net8),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(gpio_defaults[5]),
    .X(net9),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(pad_gpio_ana_en),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(pad_gpio_ana_pol),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(pad_gpio_ana_sel),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(pad_gpio_dm[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(pad_gpio_dm[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(pad_gpio_dm[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .X(pad_gpio_holdover),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .X(pad_gpio_ib_mode_sel),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .X(pad_gpio_inenb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output32 (.A(net32),
    .X(pad_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output33 (.A(net33),
    .X(pad_gpio_outenb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output34 (.A(net34),
    .X(pad_gpio_slow_sel),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output35 (.A(net35),
    .X(pad_gpio_vtrip_sel),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output36 (.A(net36),
    .X(resetn_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_1 output37 (.A(net37),
    .X(serial_clock_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output38 (.A(net38),
    .X(serial_data_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output39 (.A(net39),
    .X(serial_load_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_2 output40 (.A(net40),
    .X(user_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
endmodule
