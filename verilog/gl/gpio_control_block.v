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
 wire clknet_0__049_;
 wire clknet_0__077_;
 wire clknet_0_serial_clock;
 wire clknet_0_serial_load;
 wire clknet_1_0_0__049_;
 wire clknet_1_0_0__077_;
 wire clknet_1_0_0_serial_clock;
 wire clknet_1_0_0_serial_load;
 wire clknet_1_1_0__049_;
 wire clknet_1_1_0__077_;
 wire clknet_1_1_0_serial_clock;
 wire clknet_1_1_0_serial_load;
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
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire serial_data_post_1;
 wire serial_data_post_2;
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

 sky130_fd_sc_hd__diode_2 ANTENNA__096__A (.DIODE(pad_gpio_inenb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__098__B (.DIODE(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__099__A2 (.DIODE(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__100__A (.DIODE(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__101__A (.DIODE(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__102__A (.DIODE(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__106__A (.DIODE(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__109__A (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__110__B (.DIODE(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__114__A (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__116__B_N (.DIODE(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__118__B (.DIODE(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__121__B_N (.DIODE(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__124__B (.DIODE(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__127__B_N (.DIODE(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__129__B (.DIODE(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__132__B_N (.DIODE(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__134__B (.DIODE(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__137__B_N (.DIODE(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__139__B (.DIODE(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__144__B_N (.DIODE(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__146__B (.DIODE(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__149__B_N (.DIODE(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__152__B (.DIODE(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__155__B_N (.DIODE(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__157__B (.DIODE(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__160__B_N (.DIODE(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__162__B (.DIODE(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__165__B_N (.DIODE(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__167__B (.DIODE(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__170__B_N (.DIODE(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__172__B (.DIODE(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__175__B_N (.DIODE(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__177__B (.DIODE(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__180__B_N (.DIODE(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__195__D (.DIODE(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__195__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__196__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__197__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__198__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__199__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__200__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__201__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__202__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__203__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__204__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__205__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__206__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__207__RESET_B (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__208__A (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__211__A (.DIODE(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_serial_clock_A (.DIODE(serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_serial_load_A (.DIODE(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_47 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_84 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_10_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_10_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_11_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_11_60 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_12_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_12_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_12_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_13_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_13_69 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_42 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_45 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_48 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_4 FILLER_18_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_31 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_18_63 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_8 FILLER_1_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_78 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_47 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_5_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_5_32 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_6_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_7_34 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_9_3 (.VGND(vssd),
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
 sky130_fd_sc_hd__decap_3 PHY_34 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_35 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_36 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_37 (.VGND(vssd),
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
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_59 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_60 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_61 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_62 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_63 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_64 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_65 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__or2b_2 _096_ (.A(pad_gpio_inenb),
    .B_N(gpio_outenb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_067_));
 sky130_fd_sc_hd__buf_1 _097_ (.A(_067_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_083_));
 sky130_fd_sc_hd__and2b_2 _098_ (.A_N(mgmt_ena),
    .B(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_068_));
 sky130_fd_sc_hd__a31o_2 _099_ (.A1(gpio_outenb),
    .A2(mgmt_gpio_oeb),
    .A3(mgmt_ena),
    .B1(_068_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_outenb));
 sky130_fd_sc_hd__inv_2 _100_ (.A(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_069_));
 sky130_fd_sc_hd__nand2_2 _101_ (.A(mgmt_gpio_oeb),
    .B(pad_gpio_dm[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_070_));
 sky130_fd_sc_hd__inv_2 _102_ (.A(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_071_));
 sky130_fd_sc_hd__o21a_2 _103_ (.A1(pad_gpio_dm[2]),
    .A2(_070_),
    .B1(_071_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_072_));
 sky130_fd_sc_hd__o31ai_2 _104_ (.A1(pad_gpio_dm[2]),
    .A2(_000_),
    .A3(_070_),
    .B1(mgmt_ena),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_073_));
 sky130_fd_sc_hd__o22ai_2 _105_ (.A1(mgmt_ena),
    .A2(_069_),
    .B1(_072_),
    .B2(_073_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(pad_gpio_out));
 sky130_fd_sc_hd__inv_2 _106_ (.A(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_001_));
 sky130_fd_sc_hd__and2_2 _107_ (.A(one),
    .B(serial_data_post_2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_074_));
 sky130_fd_sc_hd__buf_1 _108_ (.A(_074_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_data_out));
 sky130_fd_sc_hd__buf_1 _109_ (.A(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_075_));
 sky130_fd_sc_hd__or2_2 _110_ (.A(_075_),
    .B(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_076_));
 sky130_fd_sc_hd__buf_1 _111_ (.A(_076_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_002_));
 sky130_fd_sc_hd__buf_1 _112_ (.A(clknet_1_1_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_077_));
 sky130_fd_sc_hd__inv_2 _113__4 (.A(clknet_1_0_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net4));
 sky130_fd_sc_hd__buf_1 _114_ (.A(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_078_));
 sky130_fd_sc_hd__buf_1 _115_ (.A(_078_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_079_));
 sky130_fd_sc_hd__or2b_2 _116_ (.A(_079_),
    .B_N(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_080_));
 sky130_fd_sc_hd__buf_1 _117_ (.A(_080_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_003_));
 sky130_fd_sc_hd__or2_2 _118_ (.A(_075_),
    .B(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_081_));
 sky130_fd_sc_hd__buf_1 _119_ (.A(_081_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_004_));
 sky130_fd_sc_hd__inv_2 _120__5 (.A(clknet_1_0_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net5));
 sky130_fd_sc_hd__or2b_2 _121_ (.A(_079_),
    .B_N(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_082_));
 sky130_fd_sc_hd__buf_1 _122_ (.A(_082_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_005_));
 sky130_fd_sc_hd__buf_1 _123_ (.A(_078_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_041_));
 sky130_fd_sc_hd__or2_2 _124_ (.A(_041_),
    .B(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_042_));
 sky130_fd_sc_hd__buf_1 _125_ (.A(_042_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_006_));
 sky130_fd_sc_hd__inv_2 _126__6 (.A(clknet_1_1_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net6));
 sky130_fd_sc_hd__or2b_2 _127_ (.A(_079_),
    .B_N(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_043_));
 sky130_fd_sc_hd__buf_1 _128_ (.A(_043_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_007_));
 sky130_fd_sc_hd__or2_2 _129_ (.A(_041_),
    .B(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_044_));
 sky130_fd_sc_hd__buf_1 _130_ (.A(_044_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_008_));
 sky130_fd_sc_hd__inv_2 _131__7 (.A(clknet_1_1_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net7));
 sky130_fd_sc_hd__or2b_2 _132_ (.A(_079_),
    .B_N(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_045_));
 sky130_fd_sc_hd__buf_1 _133_ (.A(_045_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_009_));
 sky130_fd_sc_hd__or2_2 _134_ (.A(_041_),
    .B(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_046_));
 sky130_fd_sc_hd__buf_1 _135_ (.A(_046_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_010_));
 sky130_fd_sc_hd__inv_2 _136__8 (.A(clknet_1_0_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net8));
 sky130_fd_sc_hd__or2b_2 _137_ (.A(_079_),
    .B_N(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_047_));
 sky130_fd_sc_hd__buf_1 _138_ (.A(_047_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_011_));
 sky130_fd_sc_hd__or2_2 _139_ (.A(_041_),
    .B(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_048_));
 sky130_fd_sc_hd__buf_1 _140_ (.A(_048_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_012_));
 sky130_fd_sc_hd__buf_1 _141_ (.A(clknet_1_1_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_049_));
 sky130_fd_sc_hd__inv_2 _142__9 (.A(clknet_1_1_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net9));
 sky130_fd_sc_hd__buf_1 _143_ (.A(_078_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_050_));
 sky130_fd_sc_hd__or2b_2 _144_ (.A(_050_),
    .B_N(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_051_));
 sky130_fd_sc_hd__buf_1 _145_ (.A(_051_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_013_));
 sky130_fd_sc_hd__or2_2 _146_ (.A(_041_),
    .B(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_052_));
 sky130_fd_sc_hd__buf_1 _147_ (.A(_052_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_014_));
 sky130_fd_sc_hd__inv_2 _148__10 (.A(clknet_1_1_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net10));
 sky130_fd_sc_hd__or2b_2 _149_ (.A(_050_),
    .B_N(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_053_));
 sky130_fd_sc_hd__buf_1 _150_ (.A(_053_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_015_));
 sky130_fd_sc_hd__buf_1 _151_ (.A(_078_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_054_));
 sky130_fd_sc_hd__or2_2 _152_ (.A(_054_),
    .B(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_055_));
 sky130_fd_sc_hd__buf_1 _153_ (.A(_055_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_016_));
 sky130_fd_sc_hd__inv_2 _154__11 (.A(clknet_1_1_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net11));
 sky130_fd_sc_hd__or2b_2 _155_ (.A(_050_),
    .B_N(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_056_));
 sky130_fd_sc_hd__buf_1 _156_ (.A(_056_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_017_));
 sky130_fd_sc_hd__or2_2 _157_ (.A(_054_),
    .B(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_057_));
 sky130_fd_sc_hd__buf_1 _158_ (.A(_057_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_018_));
 sky130_fd_sc_hd__inv_2 _159__12 (.A(clknet_1_0_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net12));
 sky130_fd_sc_hd__or2b_2 _160_ (.A(_050_),
    .B_N(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_058_));
 sky130_fd_sc_hd__buf_1 _161_ (.A(_058_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_019_));
 sky130_fd_sc_hd__or2_2 _162_ (.A(_054_),
    .B(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_059_));
 sky130_fd_sc_hd__buf_1 _163_ (.A(_059_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_020_));
 sky130_fd_sc_hd__inv_2 _164__13 (.A(clknet_1_0_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net13));
 sky130_fd_sc_hd__or2b_2 _165_ (.A(_050_),
    .B_N(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_060_));
 sky130_fd_sc_hd__buf_1 _166_ (.A(_060_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_021_));
 sky130_fd_sc_hd__or2_2 _167_ (.A(_054_),
    .B(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_061_));
 sky130_fd_sc_hd__buf_1 _168_ (.A(_061_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_022_));
 sky130_fd_sc_hd__inv_2 _169__1 (.A(clknet_1_0_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net1));
 sky130_fd_sc_hd__or2b_2 _170_ (.A(_075_),
    .B_N(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_062_));
 sky130_fd_sc_hd__buf_1 _171_ (.A(_062_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_023_));
 sky130_fd_sc_hd__or2_2 _172_ (.A(_054_),
    .B(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_063_));
 sky130_fd_sc_hd__buf_1 _173_ (.A(_063_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_024_));
 sky130_fd_sc_hd__inv_2 _174__2 (.A(clknet_1_0_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net2));
 sky130_fd_sc_hd__or2b_2 _175_ (.A(_075_),
    .B_N(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_064_));
 sky130_fd_sc_hd__buf_1 _176_ (.A(_064_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_025_));
 sky130_fd_sc_hd__or2_2 _177_ (.A(_078_),
    .B(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_065_));
 sky130_fd_sc_hd__buf_1 _178_ (.A(_065_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_026_));
 sky130_fd_sc_hd__inv_2 _179__3 (.A(clknet_1_0_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net3));
 sky130_fd_sc_hd__or2b_2 _180_ (.A(_075_),
    .B_N(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_066_));
 sky130_fd_sc_hd__buf_1 _181_ (.A(_066_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_027_));
 sky130_fd_sc_hd__dfbbn_2 _182_ (.CLK_N(net4),
    .D(net24),
    .RESET_B(_002_),
    .SET_B(_003_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(mgmt_ena),
    .Q_N(_094_));
 sky130_fd_sc_hd__dfbbn_2 _183_ (.CLK_N(net5),
    .D(net22),
    .RESET_B(_004_),
    .SET_B(_005_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_holdover),
    .Q_N(_093_));
 sky130_fd_sc_hd__dfbbn_2 _184_ (.CLK_N(net6),
    .D(net28),
    .RESET_B(_006_),
    .SET_B(_007_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_slow_sel),
    .Q_N(_092_));
 sky130_fd_sc_hd__dfbbn_2 _185_ (.CLK_N(net7),
    .D(net35),
    .RESET_B(_008_),
    .SET_B(_009_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_vtrip_sel),
    .Q_N(_091_));
 sky130_fd_sc_hd__dfbbn_2 _186_ (.CLK_N(net8),
    .D(net26),
    .RESET_B(_010_),
    .SET_B(_011_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_inenb),
    .Q_N(_090_));
 sky130_fd_sc_hd__dfbbn_2 _187_ (.CLK_N(net9),
    .D(net14),
    .RESET_B(_012_),
    .SET_B(_013_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_ib_mode_sel),
    .Q_N(_089_));
 sky130_fd_sc_hd__dfbbn_2 _188_ (.CLK_N(net10),
    .D(net20),
    .RESET_B(_014_),
    .SET_B(_015_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(gpio_outenb),
    .Q_N(_088_));
 sky130_fd_sc_hd__dfbbn_2 _189_ (.CLK_N(net11),
    .D(net18),
    .RESET_B(_016_),
    .SET_B(_017_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_dm[0]),
    .Q_N(_000_));
 sky130_fd_sc_hd__dfbbn_2 _190_ (.CLK_N(net12),
    .D(net36),
    .RESET_B(_018_),
    .SET_B(_019_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_dm[1]),
    .Q_N(_087_));
 sky130_fd_sc_hd__dfbbn_2 _191_ (.CLK_N(net13),
    .D(net16),
    .RESET_B(_020_),
    .SET_B(_021_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_dm[2]),
    .Q_N(_086_));
 sky130_fd_sc_hd__dfbbn_2 _192_ (.CLK_N(net1),
    .D(net34),
    .RESET_B(_022_),
    .SET_B(_023_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_ana_en),
    .Q_N(_085_));
 sky130_fd_sc_hd__dfbbn_2 _193_ (.CLK_N(net2),
    .D(net33),
    .RESET_B(_024_),
    .SET_B(_025_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_ana_sel),
    .Q_N(_084_));
 sky130_fd_sc_hd__dfbbn_2 _194_ (.CLK_N(net3),
    .D(net32),
    .RESET_B(_026_),
    .SET_B(_027_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(pad_gpio_ana_pol),
    .Q_N(_095_));
 sky130_fd_sc_hd__dfrtp_2 _195_ (.CLK(clknet_1_1_0_serial_clock),
    .D(serial_data_in),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[0] ));
 sky130_fd_sc_hd__dfrtp_2 _196_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net24),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[1] ));
 sky130_fd_sc_hd__dfrtp_2 _197_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net20),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[2] ));
 sky130_fd_sc_hd__dfrtp_2 _198_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net22),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[3] ));
 sky130_fd_sc_hd__dfrtp_2 _199_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net26),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[4] ));
 sky130_fd_sc_hd__dfrtp_2 _200_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net14),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[5] ));
 sky130_fd_sc_hd__dfrtp_2 _201_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net34),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[6] ));
 sky130_fd_sc_hd__dfrtp_2 _202_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net33),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[7] ));
 sky130_fd_sc_hd__dfrtp_2 _203_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net32),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[8] ));
 sky130_fd_sc_hd__dfrtp_2 _204_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net28),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[9] ));
 sky130_fd_sc_hd__dfrtp_2 _205_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net30),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[10] ));
 sky130_fd_sc_hd__dfrtp_2 _206_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net18),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[11] ));
 sky130_fd_sc_hd__dfrtp_2 _207_ (.CLK(clknet_1_0_0_serial_clock),
    .D(net31),
    .RESET_B(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(serial_data_pre));
 sky130_fd_sc_hd__buf_2 _208_ (.A(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(resetn_out));
 sky130_fd_sc_hd__buf_2 _209_ (.A(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_clock_out));
 sky130_fd_sc_hd__buf_2 _210_ (.A(clknet_1_1_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_load_out));
 sky130_fd_sc_hd__ebufn_2 _211_ (.A(pad_gpio_in),
    .TE_B(_083_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Z(mgmt_gpio_in));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0__049_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0__049_));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0__077_ (.A(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0__077_));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_clock (.A(serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0_serial_clock));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_load (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0_serial_load));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0__049_ (.A(clknet_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0_0__049_));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0__077_ (.A(clknet_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0_0__077_));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0_0_serial_clock));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0_serial_load (.A(clknet_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0_0_serial_load));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0__049_ (.A(clknet_0__049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1_0__049_));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0__077_ (.A(clknet_0__077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1_0__077_));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1_0_serial_clock));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0_serial_load (.A(clknet_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1_0_serial_load));
 sky130_fd_sc_hd__conb_1 const_source (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .HI(one),
    .LO(zero));
 sky130_fd_sc_hd__dlygate4sd2_1 data_delay_1 (.A(serial_data_pre),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_data_post_1));
 sky130_fd_sc_hd__dlygate4sd2_1 data_delay_2 (.A(serial_data_post_1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_data_post_2));
 sky130_fd_sc_hd__einvp_8 gpio_in_buf (.A(_001_),
    .TE(gpio_logic1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Z(user_gpio_in));
 gpio_logic_high gpio_logic_high (.gpio_logic1(gpio_logic1),
    .vccd1(vccd1),
    .vssd1(vssd1));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(\shift_register[4] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net15));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold10 (.A(net23),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net22));
 sky130_fd_sc_hd__dlygate4sd3_1 hold11 (.A(\shift_register[0] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net25));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold12 (.A(net25),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net24));
 sky130_fd_sc_hd__dlygate4sd3_1 hold13 (.A(\shift_register[3] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net27));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold14 (.A(net27),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net26));
 sky130_fd_sc_hd__dlygate4sd3_1 hold15 (.A(\shift_register[8] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net29));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold16 (.A(net29),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net28));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold17 (.A(\shift_register[9] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net30));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold18 (.A(\shift_register[11] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net31));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold19 (.A(\shift_register[7] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net32));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold2 (.A(net15),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net14));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold20 (.A(\shift_register[6] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net33));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold21 (.A(\shift_register[5] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net34));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold22 (.A(net30),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net35));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold23 (.A(net31),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net36));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(serial_data_pre),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net17));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold4 (.A(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net16));
 sky130_fd_sc_hd__dlygate4sd3_1 hold5 (.A(\shift_register[10] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net19));
 sky130_fd_sc_hd__clkdlybuf4s50_1 hold6 (.A(net19),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net18));
 sky130_fd_sc_hd__dlygate4sd3_1 hold7 (.A(\shift_register[1] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net21));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold8 (.A(net21),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net20));
 sky130_fd_sc_hd__dlygate4sd3_1 hold9 (.A(\shift_register[2] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net23));
endmodule
