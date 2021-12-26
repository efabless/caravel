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
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
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
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire net47;
 wire net48;
 wire net49;
 wire net5;
 wire net50;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
 wire net59;
 wire net6;
 wire net60;
 wire net61;
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

 sky130_fd_sc_hd__diode_2 ANTENNA_0 (.DIODE(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_1 (.DIODE(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_2 (.DIODE(one),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_3 (.DIODE(one),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_4 (.DIODE(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_5 (.DIODE(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_6 (.DIODE(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_7 (.DIODE(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_50 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_4 FILLER_0_58 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_65 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_69 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_73 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_77 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_80 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_10_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_10_37 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_11_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_11_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_12_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_12_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_13_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_13_36 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_13_62 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_43 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_49 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_15_73 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_16_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_16_37 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_75 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_85 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_18_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_18_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_49 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_18_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_18_67 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_18_85 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_30 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_35 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_53 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_58 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_62 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_73 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_1_80 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_32 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_36 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_41 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_46 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_50 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_70 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_75 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_70 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_80 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_3_86 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_90 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_4_46 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_4_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_5_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_6_52 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_7_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_7_88 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_8_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_8_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_8_82 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_9_45 (.VGND(vssd),
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
 sky130_fd_sc_hd__clkbuf_1 _108_ (.A(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_077_));
 sky130_fd_sc_hd__dlymetal6s2s_1 _109_ (.A(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_078_));
 sky130_fd_sc_hd__or2b_1 _110_ (.A(_078_),
    .B_N(net11),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_079_));
 sky130_fd_sc_hd__clkbuf_1 _111_ (.A(_079_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_043_));
 sky130_fd_sc_hd__dlymetal6s2s_1 _112_ (.A(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_080_));
 sky130_fd_sc_hd__or2_1 _113_ (.A(_080_),
    .B(net11),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_081_));
 sky130_fd_sc_hd__clkbuf_1 _114_ (.A(_081_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_042_));
 sky130_fd_sc_hd__inv_2 _115__1 (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net38));
 sky130_fd_sc_hd__inv_2 _115__2 (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net39));
 sky130_fd_sc_hd__inv_2 _115__3 (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net40));
 sky130_fd_sc_hd__inv_2 _115__4 (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net41));
 sky130_fd_sc_hd__inv_2 _115__5 (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net42));
 sky130_fd_sc_hd__buf_1 _116_ (.A(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_041_));
 sky130_fd_sc_hd__or2b_1 _117_ (.A(_078_),
    .B_N(net10),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_083_));
 sky130_fd_sc_hd__clkbuf_1 _118_ (.A(_083_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_040_));
 sky130_fd_sc_hd__or2_1 _119_ (.A(_080_),
    .B(net10),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_084_));
 sky130_fd_sc_hd__clkbuf_1 _120_ (.A(_084_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_039_));
 sky130_fd_sc_hd__buf_1 _121_ (.A(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_085_));
 sky130_fd_sc_hd__buf_1 _122_ (.A(_085_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_038_));
 sky130_fd_sc_hd__or2b_1 _123_ (.A(_078_),
    .B_N(net9),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_086_));
 sky130_fd_sc_hd__clkbuf_1 _124_ (.A(_086_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_037_));
 sky130_fd_sc_hd__dlymetal6s2s_1 _125_ (.A(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_087_));
 sky130_fd_sc_hd__or2_1 _126_ (.A(_087_),
    .B(net9),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_088_));
 sky130_fd_sc_hd__clkbuf_1 _127_ (.A(_088_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_036_));
 sky130_fd_sc_hd__buf_1 _128_ (.A(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_089_));
 sky130_fd_sc_hd__buf_1 _129_ (.A(_089_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_035_));
 sky130_fd_sc_hd__or2b_1 _130_ (.A(_078_),
    .B_N(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_090_));
 sky130_fd_sc_hd__clkbuf_1 _131_ (.A(_090_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_034_));
 sky130_fd_sc_hd__or2_1 _132_ (.A(_087_),
    .B(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_091_));
 sky130_fd_sc_hd__clkbuf_1 _133_ (.A(_091_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_033_));
 sky130_fd_sc_hd__buf_1 _134_ (.A(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_092_));
 sky130_fd_sc_hd__buf_1 _135_ (.A(_092_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_032_));
 sky130_fd_sc_hd__or2b_1 _136_ (.A(_078_),
    .B_N(net3),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_093_));
 sky130_fd_sc_hd__clkbuf_1 _137_ (.A(_093_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_031_));
 sky130_fd_sc_hd__or2_1 _138_ (.A(_087_),
    .B(net3),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_094_));
 sky130_fd_sc_hd__clkbuf_1 _139_ (.A(_094_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_030_));
 sky130_fd_sc_hd__buf_1 _140_ (.A(_041_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_045_));
 sky130_fd_sc_hd__buf_1 _141_ (.A(_045_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_029_));
 sky130_fd_sc_hd__dlymetal6s2s_1 _142_ (.A(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_046_));
 sky130_fd_sc_hd__or2b_1 _143_ (.A(_046_),
    .B_N(net2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_047_));
 sky130_fd_sc_hd__clkbuf_1 _144_ (.A(_047_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_028_));
 sky130_fd_sc_hd__or2_1 _145_ (.A(_087_),
    .B(net2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_048_));
 sky130_fd_sc_hd__clkbuf_1 _146_ (.A(_048_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_027_));
 sky130_fd_sc_hd__buf_1 _147_ (.A(net41),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_049_));
 sky130_fd_sc_hd__buf_1 _148_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_050_));
 sky130_fd_sc_hd__buf_1 _149_ (.A(_050_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_026_));
 sky130_fd_sc_hd__or2b_1 _150_ (.A(_046_),
    .B_N(net5),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_051_));
 sky130_fd_sc_hd__clkbuf_1 _151_ (.A(_051_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_025_));
 sky130_fd_sc_hd__or2_1 _152_ (.A(_087_),
    .B(net5),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_052_));
 sky130_fd_sc_hd__clkbuf_1 _153_ (.A(_052_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_024_));
 sky130_fd_sc_hd__buf_1 _154_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_053_));
 sky130_fd_sc_hd__buf_1 _155_ (.A(_053_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_023_));
 sky130_fd_sc_hd__or2b_1 _156_ (.A(_046_),
    .B_N(net8),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_054_));
 sky130_fd_sc_hd__clkbuf_1 _157_ (.A(_054_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_022_));
 sky130_fd_sc_hd__clkbuf_1 _158_ (.A(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_055_));
 sky130_fd_sc_hd__or2_1 _159_ (.A(_055_),
    .B(net8),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_056_));
 sky130_fd_sc_hd__clkbuf_1 _160_ (.A(_056_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_021_));
 sky130_fd_sc_hd__buf_1 _161_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_057_));
 sky130_fd_sc_hd__buf_1 _162_ (.A(_057_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_020_));
 sky130_fd_sc_hd__or2b_1 _163_ (.A(_046_),
    .B_N(net7),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_058_));
 sky130_fd_sc_hd__clkbuf_1 _164_ (.A(_058_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_019_));
 sky130_fd_sc_hd__or2_1 _165_ (.A(_055_),
    .B(net7),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_059_));
 sky130_fd_sc_hd__clkbuf_1 _166_ (.A(_059_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_018_));
 sky130_fd_sc_hd__buf_1 _167_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_060_));
 sky130_fd_sc_hd__buf_1 _168_ (.A(_060_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_017_));
 sky130_fd_sc_hd__or2b_1 _169_ (.A(_046_),
    .B_N(net13),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_061_));
 sky130_fd_sc_hd__clkbuf_1 _170_ (.A(_061_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_016_));
 sky130_fd_sc_hd__or2_1 _171_ (.A(_055_),
    .B(net13),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_062_));
 sky130_fd_sc_hd__clkbuf_1 _172_ (.A(_062_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_015_));
 sky130_fd_sc_hd__buf_1 _173_ (.A(_049_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_063_));
 sky130_fd_sc_hd__buf_1 _174_ (.A(_063_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_014_));
 sky130_fd_sc_hd__or2b_1 _175_ (.A(_080_),
    .B_N(net12),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_064_));
 sky130_fd_sc_hd__clkbuf_1 _176_ (.A(_064_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_013_));
 sky130_fd_sc_hd__or2_1 _177_ (.A(_055_),
    .B(net12),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_065_));
 sky130_fd_sc_hd__clkbuf_1 _178_ (.A(_065_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_012_));
 sky130_fd_sc_hd__buf_1 _179_ (.A(net40),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_066_));
 sky130_fd_sc_hd__buf_1 _180_ (.A(_066_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_011_));
 sky130_fd_sc_hd__or2b_1 _181_ (.A(_080_),
    .B_N(net6),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_067_));
 sky130_fd_sc_hd__clkbuf_1 _182_ (.A(_067_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_010_));
 sky130_fd_sc_hd__or2_1 _183_ (.A(_055_),
    .B(net6),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_068_));
 sky130_fd_sc_hd__clkbuf_1 _184_ (.A(_068_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_009_));
 sky130_fd_sc_hd__buf_1 _185_ (.A(net39),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_069_));
 sky130_fd_sc_hd__buf_1 _186_ (.A(_069_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_008_));
 sky130_fd_sc_hd__or2b_1 _187_ (.A(_080_),
    .B_N(net1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_070_));
 sky130_fd_sc_hd__clkbuf_1 _188_ (.A(_070_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_007_));
 sky130_fd_sc_hd__or2_1 _189_ (.A(net1),
    .B(_077_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_071_));
 sky130_fd_sc_hd__clkbuf_1 _190_ (.A(_071_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_006_));
 sky130_fd_sc_hd__or2b_1 _191_ (.A(net29),
    .B_N(gpio_outenb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_072_));
 sky130_fd_sc_hd__clkbuf_1 _192_ (.A(_072_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_095_));
 sky130_fd_sc_hd__and2_1 _193_ (.A(gpio_outenb),
    .B(net14),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_073_));
 sky130_fd_sc_hd__clkbuf_1 _194_ (.A(_073_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_000_));
 sky130_fd_sc_hd__or2b_1 _195_ (.A(net26),
    .B_N(net25),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_074_));
 sky130_fd_sc_hd__clkbuf_1 _196_ (.A(_074_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_002_));
 sky130_fd_sc_hd__inv_2 _197_ (.A(net16),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_005_));
 sky130_fd_sc_hd__and2_1 _198_ (.A(one),
    .B(serial_data_pre),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_075_));
 sky130_fd_sc_hd__clkbuf_1 _199_ (.A(_075_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net36));
 sky130_fd_sc_hd__buf_1 _200_ (.A(net38),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_076_));
 sky130_fd_sc_hd__buf_1 _201_ (.A(_076_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_044_));
 sky130_fd_sc_hd__clkbuf_1 _202_ (.A(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net34));
 sky130_fd_sc_hd__buf_2 _203_ (.A(clknet_1_1_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net35));
 sky130_fd_sc_hd__buf_2 _204_ (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net37));
 sky130_fd_sc_hd__mux2_1 _205_ (.A0(net19),
    .A1(_000_),
    .S(mgmt_ena),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net31));
 sky130_fd_sc_hd__mux2_1 _206_ (.A0(_001_),
    .A1(net15),
    .S(_002_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_003_));
 sky130_fd_sc_hd__mux2_1 _207_ (.A0(net15),
    .A1(_003_),
    .S(net14),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_004_));
 sky130_fd_sc_hd__mux2_1 _208_ (.A0(net20),
    .A1(_004_),
    .S(mgmt_ena),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net30));
 sky130_fd_sc_hd__ebufn_8 _209_ (.A(net16),
    .TE_B(_095_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Z(mgmt_gpio_in));
 sky130_fd_sc_hd__dfbbn_1 _210_ (.CLK_N(_008_),
    .D(net53),
    .RESET_B(_006_),
    .SET_B(_007_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(mgmt_ena),
    .Q_N(_096_));
 sky130_fd_sc_hd__dfbbn_1 _211_ (.CLK_N(_011_),
    .D(net52),
    .RESET_B(_009_),
    .SET_B(_010_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net27),
    .Q_N(_097_));
 sky130_fd_sc_hd__dfbbn_1 _212_ (.CLK_N(_014_),
    .D(net46),
    .RESET_B(_012_),
    .SET_B(_013_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net32),
    .Q_N(_098_));
 sky130_fd_sc_hd__dfbbn_1 _213_ (.CLK_N(_017_),
    .D(net43),
    .RESET_B(_015_),
    .SET_B(_016_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net33),
    .Q_N(_099_));
 sky130_fd_sc_hd__dfbbn_1 _214_ (.CLK_N(_020_),
    .D(net49),
    .RESET_B(_018_),
    .SET_B(_019_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net29),
    .Q_N(_100_));
 sky130_fd_sc_hd__dfbbn_1 _215_ (.CLK_N(_023_),
    .D(net44),
    .RESET_B(_021_),
    .SET_B(_022_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net28),
    .Q_N(_101_));
 sky130_fd_sc_hd__dfbbn_1 _216_ (.CLK_N(_026_),
    .D(net45),
    .RESET_B(_024_),
    .SET_B(_025_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(gpio_outenb),
    .Q_N(_102_));
 sky130_fd_sc_hd__dfbbn_1 _217_ (.CLK_N(_029_),
    .D(net48),
    .RESET_B(_027_),
    .SET_B(_028_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net24),
    .Q_N(_001_));
 sky130_fd_sc_hd__dfbbn_1 _218_ (.CLK_N(_032_),
    .D(net47),
    .RESET_B(_030_),
    .SET_B(_031_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net25),
    .Q_N(_103_));
 sky130_fd_sc_hd__dfbbn_1 _219_ (.CLK_N(_035_),
    .D(net50),
    .RESET_B(_033_),
    .SET_B(_034_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net26),
    .Q_N(_104_));
 sky130_fd_sc_hd__dfbbn_1 _220_ (.CLK_N(_038_),
    .D(net51),
    .RESET_B(_036_),
    .SET_B(_037_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net21),
    .Q_N(_105_));
 sky130_fd_sc_hd__dfbbn_1 _221_ (.CLK_N(_041_),
    .D(net54),
    .RESET_B(_039_),
    .SET_B(_040_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net23),
    .Q_N(_106_));
 sky130_fd_sc_hd__dfbbn_1 _222_ (.CLK_N(_044_),
    .D(net56),
    .RESET_B(_042_),
    .SET_B(_043_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net22),
    .Q_N(_107_));
 sky130_fd_sc_hd__dfrtp_1 _223_ (.CLK(clknet_1_1_0_serial_clock),
    .D(net18),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[0] ));
 sky130_fd_sc_hd__dfrtp_1 _224_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[0] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[1] ));
 sky130_fd_sc_hd__dfrtp_1 _225_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[1] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[2] ));
 sky130_fd_sc_hd__dfrtp_1 _226_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[2] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[3] ));
 sky130_fd_sc_hd__dfrtp_1 _227_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[3] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[4] ));
 sky130_fd_sc_hd__dfrtp_1 _228_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[4] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[5] ));
 sky130_fd_sc_hd__dfrtp_1 _229_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[5] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[6] ));
 sky130_fd_sc_hd__dfrtp_1 _230_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[6] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[7] ));
 sky130_fd_sc_hd__dfrtp_1 _231_ (.CLK(clknet_1_0_0_serial_clock),
    .D(\shift_register[7] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[8] ));
 sky130_fd_sc_hd__dfrtp_1 _232_ (.CLK(clknet_1_1_0_serial_clock),
    .D(\shift_register[8] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[9] ));
 sky130_fd_sc_hd__dfrtp_1 _233_ (.CLK(clknet_1_1_0_serial_clock),
    .D(\shift_register[9] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[10] ));
 sky130_fd_sc_hd__dfrtp_1 _234_ (.CLK(clknet_1_1_0_serial_clock),
    .D(\shift_register[10] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[11] ));
 sky130_fd_sc_hd__dfrtp_1 _235_ (.CLK(clknet_1_1_0_serial_clock),
    .D(\shift_register[11] ),
    .RESET_B(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(serial_data_pre));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_clock (.A(serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0_serial_clock));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0_0_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0_0_serial_clock));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1_0_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1_0_serial_clock));
 sky130_fd_sc_hd__conb_1 const_source (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .HI(one),
    .LO(zero));
 sky130_fd_sc_hd__einvp_8 gpio_in_buf (.A(_005_),
    .TE(gpio_logic1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Z(user_gpio_in));
 gpio_logic_high gpio_logic_high (.gpio_logic1(gpio_logic1),
    .vccd1(vccd1),
    .vssd1(vssd1));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold1 (.A(net55),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net43));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold10 (.A(\shift_register[2] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net52));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold11 (.A(\shift_register[0] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net53));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold12 (.A(\shift_register[6] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net54));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold13 (.A(\shift_register[9] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net55));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold14 (.A(\shift_register[7] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net56));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold15 (.A(\shift_register[8] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net57));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold16 (.A(\shift_register[4] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net58));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold17 (.A(\shift_register[10] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net59));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold18 (.A(\shift_register[1] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net60));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold19 (.A(\shift_register[11] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net61));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold2 (.A(net58),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net44));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold3 (.A(net60),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net45));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold4 (.A(net57),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net46));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold5 (.A(net61),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net47));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold6 (.A(net59),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net48));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold7 (.A(\shift_register[3] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net49));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold8 (.A(serial_data_pre),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net50));
 sky130_fd_sc_hd__clkdlybuf4s25_1 hold9 (.A(\shift_register[5] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net51));
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input10 (.A(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_1 input12 (.A(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_1 input13 (.A(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_1 input14 (.A(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_1 input15 (.A(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 input16 (.A(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net16));
 sky130_fd_sc_hd__buf_6 input17 (.A(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_1 input18 (.A(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_1 input19 (.A(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net19));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input20 (.A(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net9));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_en));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_pol));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_sel));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[0]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[1]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[2]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_holdover));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ib_mode_sel));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_inenb));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_out));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_outenb));
 sky130_fd_sc_hd__buf_2 output32 (.A(net32),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_slow_sel));
 sky130_fd_sc_hd__buf_2 output33 (.A(net33),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_vtrip_sel));
 sky130_fd_sc_hd__buf_2 output34 (.A(net34),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(resetn_out));
 sky130_fd_sc_hd__clkbuf_1 output35 (.A(net35),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_clock_out));
 sky130_fd_sc_hd__buf_2 output36 (.A(net36),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_data_out));
 sky130_fd_sc_hd__clkbuf_1 output37 (.A(net37),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_load_out));
endmodule
