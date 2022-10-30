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
    zero,
    vccd,
    vssd,
    vccd1,
    vssd1,
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
 output zero;
 input vccd;
 input vssd;
 input vccd1;
 input vssd1;
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
 wire net49;
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
 wire net60;
 wire net61;
 wire clknet_0_serial_clock;
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
 wire gpio_logic1;
 wire gpio_outenb;
 wire mgmt_ena;
 wire \shift_register[0] ;
 wire \shift_register[10] ;
 wire \shift_register[11] ;
 wire \shift_register[12] ;
 wire \shift_register[1] ;
 wire \shift_register[2] ;
 wire \shift_register[3] ;
 wire \shift_register[4] ;
 wire \shift_register[5] ;
 wire \shift_register[6] ;
 wire \shift_register[7] ;
 wire \shift_register[8] ;
 wire \shift_register[9] ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
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
 wire net40;
 wire net41;
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire net47;
 wire serial_clock_out_buffered;
 wire serial_load_out_buffered;
 wire one_buffered;
 wire zero_buffered;
 wire net48;
 wire clknet_1_0__leaf_serial_clock;
 wire clknet_1_1__leaf_serial_clock;
 wire clknet_0_serial_load;
 wire clknet_1_0__leaf_serial_load;
 wire clknet_1_1__leaf_serial_load;
 wire net62;
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire net67;
 wire net68;
 wire net69;
 wire net70;
 wire net71;
 wire net72;
 wire net73;
 wire net74;

 sky130_fd_sc_hd__inv_2 _094__2 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net49));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_clock (.A(serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0_serial_clock));
 sky130_fd_sc_hd__and2_0 _060_ (.A(gpio_outenb),
    .B(net14),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_041_));
 sky130_fd_sc_hd__mux2_2 _061_ (.A0(net19),
    .A1(_041_),
    .S(mgmt_ena),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net32));
 sky130_fd_sc_hd__nand2b_1 _062_ (.A_N(mgmt_ena),
    .B(net20),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_042_));
 sky130_fd_sc_hd__and3b_1 _063_ (.A_N(net27),
    .B(net26),
    .C(net14),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_043_));
 sky130_fd_sc_hd__and2b_1 _064_ (.A_N(_000_),
    .B(_043_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_044_));
 sky130_fd_sc_hd__o21ai_2 _065_ (.A1(net15),
    .A2(_043_),
    .B1(mgmt_ena),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_045_));
 sky130_fd_sc_hd__o21ai_4 _066_ (.A1(_044_),
    .A2(_045_),
    .B1(_042_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net31));
 sky130_fd_sc_hd__and2_2 _067_ (.A(gpio_logic1),
    .B(net16),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net39));
 sky130_fd_sc_hd__or2_0 _068_ (.A(net45),
    .B(net1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_001_));
 sky130_fd_sc_hd__nand2b_1 _069_ (.A_N(net43),
    .B(net1),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_002_));
 sky130_fd_sc_hd__or2_0 _070_ (.A(net42),
    .B(net6),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_003_));
 sky130_fd_sc_hd__nand2b_1 _071_ (.A_N(net42),
    .B(net6),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_004_));
 sky130_fd_sc_hd__or2_0 _072_ (.A(net44),
    .B(net12),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_005_));
 sky130_fd_sc_hd__nand2b_1 _073_ (.A_N(net44),
    .B(net12),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_006_));
 sky130_fd_sc_hd__or2_0 _074_ (.A(net44),
    .B(net13),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_007_));
 sky130_fd_sc_hd__nand2b_1 _075_ (.A_N(net44),
    .B(net13),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_008_));
 sky130_fd_sc_hd__or2_0 _076_ (.A(net42),
    .B(net7),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_009_));
 sky130_fd_sc_hd__nand2b_1 _077_ (.A_N(net42),
    .B(net7),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_010_));
 sky130_fd_sc_hd__or2_0 _078_ (.A(net40),
    .B(net8),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_011_));
 sky130_fd_sc_hd__nand2b_1 _079_ (.A_N(net41),
    .B(net8),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_012_));
 sky130_fd_sc_hd__or2_0 _080_ (.A(net43),
    .B(net5),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_013_));
 sky130_fd_sc_hd__nand2b_1 _081_ (.A_N(net42),
    .B(net5),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_014_));
 sky130_fd_sc_hd__or2_0 _082_ (.A(net46),
    .B(net2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_015_));
 sky130_fd_sc_hd__nand2b_1 _083_ (.A_N(net44),
    .B(net2),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_016_));
 sky130_fd_sc_hd__or2_0 _084_ (.A(net45),
    .B(net3),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_017_));
 sky130_fd_sc_hd__nand2b_1 _085_ (.A_N(net45),
    .B(net3),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_018_));
 sky130_fd_sc_hd__or2_0 _086_ (.A(net45),
    .B(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_019_));
 sky130_fd_sc_hd__nand2b_1 _087_ (.A_N(net45),
    .B(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_020_));
 sky130_fd_sc_hd__or2_0 _088_ (.A(net40),
    .B(net9),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_021_));
 sky130_fd_sc_hd__nand2b_1 _089_ (.A_N(net40),
    .B(net9),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_022_));
 sky130_fd_sc_hd__or2_0 _090_ (.A(net41),
    .B(net10),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_023_));
 sky130_fd_sc_hd__nand2b_1 _091_ (.A_N(net40),
    .B(net10),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_024_));
 sky130_fd_sc_hd__or2_0 _092_ (.A(net41),
    .B(net11),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(_025_));
 sky130_fd_sc_hd__nand2b_1 _093_ (.A_N(net41),
    .B(net11),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(_026_));
 sky130_fd_sc_hd__inv_2 _095__3 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net50));
 sky130_fd_sc_hd__inv_2 _096__4 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net51));
 sky130_fd_sc_hd__inv_2 _097__5 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net52));
 sky130_fd_sc_hd__inv_2 _098__6 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net53));
 sky130_fd_sc_hd__inv_2 _099__7 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net54));
 sky130_fd_sc_hd__inv_2 _100__8 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net55));
 sky130_fd_sc_hd__inv_2 _101__9 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net56));
 sky130_fd_sc_hd__inv_2 _102__10 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net57));
 sky130_fd_sc_hd__inv_2 _103__11 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net58));
 sky130_fd_sc_hd__inv_2 _104__12 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net59));
 sky130_fd_sc_hd__inv_2 _105__13 (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net60));
 sky130_fd_sc_hd__inv_2 _059__14 (.A(clknet_1_1__leaf_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net61));
 sky130_fd_sc_hd__dfbbn_2 _106_ (.CLK_N(net48),
    .D(net72),
    .RESET_B(_001_),
    .SET_B(_002_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(mgmt_ena),
    .Q_N(_056_));
 sky130_fd_sc_hd__dfbbn_2 _107_ (.CLK_N(net49),
    .D(net67),
    .RESET_B(_003_),
    .SET_B(_004_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net28),
    .Q_N(_055_));
 sky130_fd_sc_hd__dfbbn_2 _108_ (.CLK_N(net50),
    .D(net69),
    .RESET_B(_005_),
    .SET_B(_006_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net33),
    .Q_N(_054_));
 sky130_fd_sc_hd__dfbbn_2 _109_ (.CLK_N(net51),
    .D(net74),
    .RESET_B(_007_),
    .SET_B(_008_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net34),
    .Q_N(_053_));
 sky130_fd_sc_hd__dfbbn_2 _110_ (.CLK_N(net52),
    .D(net64),
    .RESET_B(_009_),
    .SET_B(_010_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net30),
    .Q_N(_052_));
 sky130_fd_sc_hd__dfbbn_2 _111_ (.CLK_N(net53),
    .D(net65),
    .RESET_B(_011_),
    .SET_B(_012_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net29),
    .Q_N(_051_));
 sky130_fd_sc_hd__dfbbn_2 _112_ (.CLK_N(net54),
    .D(net68),
    .RESET_B(_013_),
    .SET_B(_014_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(gpio_outenb),
    .Q_N(_050_));
 sky130_fd_sc_hd__dfbbn_2 _113_ (.CLK_N(net55),
    .D(net70),
    .RESET_B(_015_),
    .SET_B(_016_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net25),
    .Q_N(_000_));
 sky130_fd_sc_hd__dfbbn_2 _114_ (.CLK_N(net56),
    .D(net71),
    .RESET_B(_017_),
    .SET_B(_018_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net26),
    .Q_N(_049_));
 sky130_fd_sc_hd__dfbbn_2 _115_ (.CLK_N(net57),
    .D(net73),
    .RESET_B(_019_),
    .SET_B(_020_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net27),
    .Q_N(_048_));
 sky130_fd_sc_hd__dfbbn_2 _116_ (.CLK_N(net58),
    .D(net63),
    .RESET_B(_021_),
    .SET_B(_022_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net22),
    .Q_N(_047_));
 sky130_fd_sc_hd__dfbbn_2 _117_ (.CLK_N(net59),
    .D(net66),
    .RESET_B(_023_),
    .SET_B(_024_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net24),
    .Q_N(_046_));
 sky130_fd_sc_hd__dfbbn_2 _118_ (.CLK_N(net60),
    .D(net62),
    .RESET_B(_025_),
    .SET_B(_026_),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net23),
    .Q_N(_057_));
 sky130_fd_sc_hd__dfrtp_1 _119_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net18),
    .RESET_B(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[0] ));
 sky130_fd_sc_hd__dfrtp_1 _120_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net72),
    .RESET_B(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[1] ));
 sky130_fd_sc_hd__dfrtp_1 _121_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net68),
    .RESET_B(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[2] ));
 sky130_fd_sc_hd__dfrtp_1 _122_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net67),
    .RESET_B(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[3] ));
 sky130_fd_sc_hd__dfrtp_1 _123_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net64),
    .RESET_B(net41),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[4] ));
 sky130_fd_sc_hd__dfrtp_1 _124_ (.CLK(clknet_1_1__leaf_serial_clock),
    .D(net65),
    .RESET_B(net40),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[5] ));
 sky130_fd_sc_hd__dfrtp_1 _125_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net63),
    .RESET_B(net40),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[6] ));
 sky130_fd_sc_hd__dfrtp_1 _126_ (.CLK(clknet_1_1__leaf_serial_clock),
    .D(net66),
    .RESET_B(net40),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[7] ));
 sky130_fd_sc_hd__dfrtp_1 _127_ (.CLK(clknet_1_1__leaf_serial_clock),
    .D(net62),
    .RESET_B(net41),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[8] ));
 sky130_fd_sc_hd__dfrtp_1 _128_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net69),
    .RESET_B(net44),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[9] ));
 sky130_fd_sc_hd__dfrtp_1 _129_ (.CLK(clknet_1_1__leaf_serial_clock),
    .D(net74),
    .RESET_B(net44),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[10] ));
 sky130_fd_sc_hd__dfrtp_1 _130_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net70),
    .RESET_B(net45),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[11] ));
 sky130_fd_sc_hd__dfrtp_1 _131_ (.CLK(clknet_1_0__leaf_serial_clock),
    .D(net71),
    .RESET_B(net45),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(\shift_register[12] ));
 sky130_fd_sc_hd__dfrtp_4 _132_ (.CLK(net61),
    .D(\shift_register[12] ),
    .RESET_B(net46),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Q(net37));
 sky130_fd_sc_hd__clkbuf_2 _133_ (.A(net16),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net21));
 sky130_fd_sc_hd__clkbuf_2 _134_ (.A(net46),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net35));
 sky130_fd_sc_hd__buf_2 _135_ (.A(clknet_1_0__leaf_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net36));
 sky130_fd_sc_hd__buf_2 _136_ (.A(clknet_1_0__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net38));
 sky130_fd_sc_hd__conb_1 const_source (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .HI(one_buffered),
    .LO(zero_buffered));
 gpio_logic_high gpio_logic_high (.gpio_logic1(gpio_logic1),
    .vccd1(vccd1),
    .vssd1(vssd1));
 sky130_fd_sc_hd__macro_sparecell spare_cell (.VGND(vssd),
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
 sky130_fd_sc_hd__decap_3 PHY_2 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_3 (.VGND(vssd),
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
 sky130_fd_sc_hd__decap_3 PHY_38 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_40 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__decap_3 PHY_41 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
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
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_66 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_67 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_68 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_69 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_70 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_71 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_72 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_73 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__clkbuf_2 input1 (.A(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_2 input2 (.A(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_2 input3 (.A(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_2 input4 (.A(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_2 input5 (.A(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_2 input6 (.A(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_2 input7 (.A(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_2 input8 (.A(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_2 input9 (.A(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_2 input10 (.A(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_2 input11 (.A(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_2 input12 (.A(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_2 input13 (.A(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_2 input14 (.A(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_2 input15 (.A(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_2 input16 (.A(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_2 input17 (.A(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_2 input18 (.A(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_2 input19 (.A(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net19));
 sky130_fd_sc_hd__clkbuf_2 input20 (.A(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net20));
 sky130_fd_sc_hd__buf_16 output21 (.A(net21),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_gpio_in));
 sky130_fd_sc_hd__buf_16 output22 (.A(net22),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_en));
 sky130_fd_sc_hd__buf_16 output23 (.A(net23),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_pol));
 sky130_fd_sc_hd__buf_16 output24 (.A(net24),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ana_sel));
 sky130_fd_sc_hd__buf_16 output25 (.A(net25),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[0]));
 sky130_fd_sc_hd__buf_16 output26 (.A(net26),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[1]));
 sky130_fd_sc_hd__buf_16 output27 (.A(net27),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_dm[2]));
 sky130_fd_sc_hd__buf_16 output28 (.A(net28),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_holdover));
 sky130_fd_sc_hd__buf_16 output29 (.A(net29),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_ib_mode_sel));
 sky130_fd_sc_hd__buf_16 output30 (.A(net30),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_inenb));
 sky130_fd_sc_hd__buf_16 output31 (.A(net31),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_out));
 sky130_fd_sc_hd__buf_16 output32 (.A(net32),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_outenb));
 sky130_fd_sc_hd__buf_16 output33 (.A(net33),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_slow_sel));
 sky130_fd_sc_hd__buf_16 output34 (.A(net34),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(pad_gpio_vtrip_sel));
 sky130_fd_sc_hd__buf_16 output35 (.A(net35),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(resetn_out));
 sky130_fd_sc_hd__clkbuf_2 output36 (.A(net36),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_clock_out_buffered));
 sky130_fd_sc_hd__buf_16 output37 (.A(net37),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_data_out));
 sky130_fd_sc_hd__clkbuf_2 output38 (.A(net38),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_load_out_buffered));
 sky130_fd_sc_hd__buf_16 output39 (.A(net39),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(user_gpio_in));
 sky130_fd_sc_hd__buf_2 fanout40 (.A(net41),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net40));
 sky130_fd_sc_hd__clkbuf_2 fanout41 (.A(net47),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net41));
 sky130_fd_sc_hd__clkbuf_2 fanout42 (.A(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net42));
 sky130_fd_sc_hd__clkbuf_2 fanout43 (.A(net47),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net43));
 sky130_fd_sc_hd__clkbuf_2 fanout44 (.A(net46),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net44));
 sky130_fd_sc_hd__clkbuf_2 fanout45 (.A(net46),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net45));
 sky130_fd_sc_hd__clkbuf_2 fanout46 (.A(net47),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net46));
 sky130_fd_sc_hd__clkbuf_2 fanout47 (.A(net17),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net47));
 sky130_fd_sc_hd__clkbuf_16 serial_clock_out_buffer (.A(serial_clock_out_buffered),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_clock_out));
 sky130_fd_sc_hd__clkbuf_16 serial_load_out_buffer (.A(serial_load_out_buffered),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(serial_load_out));
 sky130_fd_sc_hd__buf_16 one_buffer (.A(one_buffered),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(one));
 sky130_fd_sc_hd__buf_16 zero_buffer (.A(zero_buffered),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(zero));
 sky130_fd_sc_hd__inv_2 _058__1 (.A(clknet_1_1__leaf_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .Y(net48));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0__leaf_serial_clock));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_serial_clock (.A(clknet_0_serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1__leaf_serial_clock));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_serial_load (.A(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_0_serial_load));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_serial_load (.A(clknet_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_0__leaf_serial_load));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_serial_load (.A(clknet_0_serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(clknet_1_1__leaf_serial_load));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(\shift_register[7] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net62));
 sky130_fd_sc_hd__dlygate4sd3_1 hold2 (.A(\shift_register[5] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net63));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(\shift_register[3] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net64));
 sky130_fd_sc_hd__dlygate4sd3_1 hold4 (.A(\shift_register[4] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net65));
 sky130_fd_sc_hd__dlygate4sd3_1 hold5 (.A(\shift_register[6] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net66));
 sky130_fd_sc_hd__dlygate4sd3_1 hold6 (.A(\shift_register[2] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net67));
 sky130_fd_sc_hd__dlygate4sd3_1 hold7 (.A(\shift_register[1] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net68));
 sky130_fd_sc_hd__dlygate4sd3_1 hold8 (.A(\shift_register[8] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net69));
 sky130_fd_sc_hd__dlygate4sd3_1 hold9 (.A(\shift_register[10] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net70));
 sky130_fd_sc_hd__dlygate4sd3_1 hold10 (.A(\shift_register[11] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net71));
 sky130_fd_sc_hd__dlygate4sd3_1 hold11 (.A(\shift_register[0] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net72));
 sky130_fd_sc_hd__dlygate4sd3_1 hold12 (.A(\shift_register[12] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net73));
 sky130_fd_sc_hd__dlygate4sd3_1 hold13 (.A(\shift_register[9] ),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(net74));
 sky130_fd_sc_hd__diode_2 ANTENNA_input1_A (.DIODE(gpio_defaults[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input2_A (.DIODE(gpio_defaults[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input3_A (.DIODE(gpio_defaults[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input4_A (.DIODE(gpio_defaults[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input5_A (.DIODE(gpio_defaults[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input6_A (.DIODE(gpio_defaults[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input7_A (.DIODE(gpio_defaults[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input8_A (.DIODE(gpio_defaults[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input9_A (.DIODE(gpio_defaults[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input10_A (.DIODE(gpio_defaults[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input11_A (.DIODE(gpio_defaults[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input12_A (.DIODE(gpio_defaults[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input13_A (.DIODE(gpio_defaults[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input14_A (.DIODE(mgmt_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input15_A (.DIODE(mgmt_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input16_A (.DIODE(pad_gpio_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input17_A (.DIODE(resetn),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_serial_clock_A (.DIODE(serial_clock),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input18_A (.DIODE(serial_data_in),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_serial_load_A (.DIODE(serial_load),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input19_A (.DIODE(user_gpio_oeb),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_input20_A (.DIODE(user_gpio_out),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__087__B (.DIODE(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__086__B (.DIODE(net4),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__120__RESET_B (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__081__A_N (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__077__A_N (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__076__A (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__071__A_N (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__070__A (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__122__RESET_B (.DIODE(net42),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__119__RESET_B (.DIODE(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__080__A (.DIODE(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__069__A_N (.DIODE(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA__121__RESET_B (.DIODE(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__diode_2 ANTENNA_fanout42_A (.DIODE(net43),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_61 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_87 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_30 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_3_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_4_50 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_5_84 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_9_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_10_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_11_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_13_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_13_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_14_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_16_60 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_17_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
endmodule
