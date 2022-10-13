// This is the unpowered netlist.
module caravel_clocking (core_clk,
    ext_clk,
    ext_clk_sel,
    ext_reset,
    pll_clk,
    pll_clk90,
    resetb,
    resetb_sync,
    user_clk,
    sel,
    sel2);
 output core_clk;
 input ext_clk;
 input ext_clk_sel;
 input ext_reset;
 input pll_clk;
 input pll_clk90;
 input resetb;
 output resetb_sync;
 output user_clk;
 input [2:0] sel;
 input [2:0] sel2;

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
 wire net38;
 wire net39;
 wire clknet_0_ext_clk;
 wire net35;
 wire net36;
 wire net37;
 wire net32;
 wire net33;
 wire net34;
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
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire _143_;
 wire _144_;
 wire _145_;
 wire _146_;
 wire _147_;
 wire _148_;
 wire _149_;
 wire _150_;
 wire _151_;
 wire _152_;
 wire _153_;
 wire _154_;
 wire _155_;
 wire _156_;
 wire _157_;
 wire _158_;
 wire _159_;
 wire _160_;
 wire _161_;
 wire _162_;
 wire _163_;
 wire _164_;
 wire _165_;
 wire _166_;
 wire _167_;
 wire _168_;
 wire _169_;
 wire _170_;
 wire _171_;
 wire _172_;
 wire _173_;
 wire _174_;
 wire _175_;
 wire _176_;
 wire _177_;
 wire _178_;
 wire _179_;
 wire _180_;
 wire _181_;
 wire _182_;
 wire _183_;
 wire _184_;
 wire _185_;
 wire _186_;
 wire _187_;
 wire _188_;
 wire _189_;
 wire _190_;
 wire _191_;
 wire _192_;
 wire _193_;
 wire _194_;
 wire _195_;
 wire _196_;
 wire _197_;
 wire _198_;
 wire _199_;
 wire _200_;
 wire _201_;
 wire _202_;
 wire _203_;
 wire _204_;
 wire net31;
 wire \divider.even_0.N[0] ;
 wire \divider.even_0.N[1] ;
 wire \divider.even_0.N[2] ;
 wire \divider.even_0.counter[0] ;
 wire \divider.even_0.counter[1] ;
 wire \divider.even_0.counter[2] ;
 wire \divider.even_0.out_counter ;
 wire \divider.odd_0.counter2[0] ;
 wire \divider.odd_0.counter2[1] ;
 wire \divider.odd_0.counter2[2] ;
 wire \divider.odd_0.counter[0] ;
 wire \divider.odd_0.counter[1] ;
 wire \divider.odd_0.counter[2] ;
 wire \divider.odd_0.initial_begin[0] ;
 wire \divider.odd_0.initial_begin[1] ;
 wire \divider.odd_0.initial_begin[2] ;
 wire \divider.odd_0.old_N[0] ;
 wire \divider.odd_0.old_N[1] ;
 wire \divider.odd_0.old_N[2] ;
 wire \divider.odd_0.out_counter ;
 wire \divider.odd_0.out_counter2 ;
 wire \divider.odd_0.rst_pulse ;
 wire \divider.out ;
 wire \divider.syncNp[0] ;
 wire \divider.syncNp[1] ;
 wire \divider.syncNp[2] ;
 wire \divider2.even_0.N[0] ;
 wire \divider2.even_0.N[1] ;
 wire \divider2.even_0.N[2] ;
 wire \divider2.even_0.counter[0] ;
 wire \divider2.even_0.counter[1] ;
 wire \divider2.even_0.counter[2] ;
 wire \divider2.even_0.out_counter ;
 wire \divider2.odd_0.counter2[0] ;
 wire \divider2.odd_0.counter2[1] ;
 wire \divider2.odd_0.counter2[2] ;
 wire \divider2.odd_0.counter[0] ;
 wire \divider2.odd_0.counter[1] ;
 wire \divider2.odd_0.counter[2] ;
 wire \divider2.odd_0.initial_begin[0] ;
 wire \divider2.odd_0.initial_begin[1] ;
 wire \divider2.odd_0.initial_begin[2] ;
 wire \divider2.odd_0.old_N[0] ;
 wire \divider2.odd_0.old_N[1] ;
 wire \divider2.odd_0.old_N[2] ;
 wire \divider2.odd_0.out_counter ;
 wire \divider2.odd_0.out_counter2 ;
 wire \divider2.odd_0.rst_pulse ;
 wire \divider2.out ;
 wire \divider2.syncNp[0] ;
 wire \divider2.syncNp[1] ;
 wire \divider2.syncNp[2] ;
 wire ext_clk_syncd;
 wire ext_clk_syncd_pre;
 wire pll_clk_sel;
 wire \reset_delay[0] ;
 wire \reset_delay[1] ;
 wire \reset_delay[2] ;
 wire use_pll_first;
 wire use_pll_second;
 wire net18;
 wire net17;
 wire net16;
 wire net15;
 wire net14;
 wire net13;
 wire user_clk_buffered;
 wire net11;
 wire net10;
 wire net9;
 wire net8;
 wire net7;
 wire net6;
 wire net5;
 wire net4;
 wire net3;
 wire net2;
 wire net1;
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
 wire clknet_1_0__leaf_ext_clk;
 wire clknet_1_1__leaf_ext_clk;
 wire clknet_0__037_;
 wire clknet_1_0__leaf__037_;
 wire clknet_1_1__leaf__037_;
 wire clknet_0_net10;
 wire clknet_1_1__leaf_net10;
 wire clknet_0_pll_clk;
 wire clknet_1_0__leaf_pll_clk;
 wire clknet_1_1__leaf_pll_clk;
 wire \clknet_0_divider.out ;
 wire \clknet_1_0__leaf_divider.out ;
 wire \clknet_1_1__leaf_divider.out ;
 wire clknet_0_pll_clk90;
 wire clknet_1_0__leaf_pll_clk90;
 wire clknet_1_1__leaf_pll_clk90;
 wire \clknet_0_divider2.out ;
 wire \clknet_1_0__leaf_divider2.out ;
 wire \clknet_1_1__leaf_divider2.out ;

 sky130_fd_sc_hd__mux2_1 _206_ (.A0(_001_),
    .A1(net23),
    .S(_029_),
    .X(_003_));
 sky130_fd_sc_hd__mux2_1 _207_ (.A0(_000_),
    .A1(net21),
    .S(_033_),
    .X(_002_));
 sky130_fd_sc_hd__mux2_1 _208_ (.A0(\divider.even_0.out_counter ),
    .A1(clknet_1_1__leaf_pll_clk),
    .S(_026_),
    .X(_036_));
 sky130_fd_sc_hd__mux2_1 _209_ (.A0(clknet_1_1__leaf_ext_clk),
    .A1(ext_clk_syncd),
    .S(use_pll_first),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _210_ (.A0(clknet_1_0__leaf__037_),
    .A1(\clknet_1_1__leaf_divider.out ),
    .S(use_pll_second),
    .X(net10));
 sky130_fd_sc_hd__mux2_1 _211_ (.A0(\divider2.even_0.out_counter ),
    .A1(clknet_1_1__leaf_pll_clk90),
    .S(_027_),
    .X(_038_));
 sky130_fd_sc_hd__mux2_1 _212_ (.A0(clknet_1_1__leaf__037_),
    .A1(\clknet_1_0__leaf_divider2.out ),
    .S(use_pll_second),
    .X(user_clk_buffered));
 sky130_fd_sc_hd__mux2_1 _213_ (.A0(_039_),
    .A1(_040_),
    .S(net23),
    .X(_012_));
 sky130_fd_sc_hd__mux2_1 _214_ (.A0(_041_),
    .A1(_042_),
    .S(net23),
    .X(_013_));
 sky130_fd_sc_hd__mux2_1 _215_ (.A0(_043_),
    .A1(_044_),
    .S(net23),
    .X(_014_));
 sky130_fd_sc_hd__mux2_1 _216_ (.A0(_045_),
    .A1(net20),
    .S(_030_),
    .X(_046_));
 sky130_fd_sc_hd__mux2_1 _217_ (.A0(_046_),
    .A1(net19),
    .S(net23),
    .X(_006_));
 sky130_fd_sc_hd__mux2_1 _218_ (.A0(_047_),
    .A1(net18),
    .S(_030_),
    .X(_048_));
 sky130_fd_sc_hd__mux2_1 _219_ (.A0(_048_),
    .A1(net18),
    .S(net23),
    .X(_007_));
 sky130_fd_sc_hd__mux2_1 _220_ (.A0(_049_),
    .A1(net17),
    .S(_030_),
    .X(_050_));
 sky130_fd_sc_hd__mux2_1 _221_ (.A0(_050_),
    .A1(net17),
    .S(net23),
    .X(_008_));
 sky130_fd_sc_hd__mux2_1 _222_ (.A0(_051_),
    .A1(net20),
    .S(_031_),
    .X(_052_));
 sky130_fd_sc_hd__mux2_1 _223_ (.A0(_052_),
    .A1(net20),
    .S(net24),
    .X(_009_));
 sky130_fd_sc_hd__mux2_1 _224_ (.A0(_053_),
    .A1(\divider.even_0.N[1] ),
    .S(_031_),
    .X(_054_));
 sky130_fd_sc_hd__mux2_1 _225_ (.A0(_054_),
    .A1(net18),
    .S(net24),
    .X(_010_));
 sky130_fd_sc_hd__mux2_1 _226_ (.A0(_055_),
    .A1(\divider.even_0.N[2] ),
    .S(_031_),
    .X(_056_));
 sky130_fd_sc_hd__mux2_1 _227_ (.A0(_056_),
    .A1(net17),
    .S(net24),
    .X(_011_));
 sky130_fd_sc_hd__mux2_1 _228_ (.A0(net18),
    .A1(_057_),
    .S(_028_),
    .X(_004_));
 sky130_fd_sc_hd__mux2_1 _229_ (.A0(net17),
    .A1(_058_),
    .S(_028_),
    .X(_005_));
 sky130_fd_sc_hd__mux2_1 _230_ (.A0(_059_),
    .A1(_060_),
    .S(net21),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _231_ (.A0(_061_),
    .A1(_062_),
    .S(net21),
    .X(_024_));
 sky130_fd_sc_hd__mux2_1 _232_ (.A0(_063_),
    .A1(_064_),
    .S(net21),
    .X(_025_));
 sky130_fd_sc_hd__mux2_1 _233_ (.A0(_065_),
    .A1(net15),
    .S(_034_),
    .X(_066_));
 sky130_fd_sc_hd__mux2_1 _234_ (.A0(_066_),
    .A1(net15),
    .S(net22),
    .X(_017_));
 sky130_fd_sc_hd__mux2_1 _235_ (.A0(_067_),
    .A1(net14),
    .S(_034_),
    .X(_068_));
 sky130_fd_sc_hd__mux2_1 _236_ (.A0(_068_),
    .A1(net14),
    .S(net22),
    .X(_018_));
 sky130_fd_sc_hd__mux2_1 _237_ (.A0(_069_),
    .A1(net13),
    .S(_034_),
    .X(_070_));
 sky130_fd_sc_hd__mux2_1 _238_ (.A0(_070_),
    .A1(net13),
    .S(net21),
    .X(_019_));
 sky130_fd_sc_hd__mux2_1 _239_ (.A0(_071_),
    .A1(net16),
    .S(_035_),
    .X(_072_));
 sky130_fd_sc_hd__mux2_1 _240_ (.A0(_072_),
    .A1(net16),
    .S(net22),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _241_ (.A0(_073_),
    .A1(net14),
    .S(_035_),
    .X(_074_));
 sky130_fd_sc_hd__mux2_1 _242_ (.A0(_074_),
    .A1(net14),
    .S(net22),
    .X(_021_));
 sky130_fd_sc_hd__mux2_1 _243_ (.A0(_075_),
    .A1(net13),
    .S(_035_),
    .X(_076_));
 sky130_fd_sc_hd__mux2_1 _244_ (.A0(_076_),
    .A1(net13),
    .S(net21),
    .X(_022_));
 sky130_fd_sc_hd__mux2_1 _245_ (.A0(net14),
    .A1(_077_),
    .S(_032_),
    .X(_015_));
 sky130_fd_sc_hd__mux2_1 _246_ (.A0(net13),
    .A1(_078_),
    .S(_032_),
    .X(_016_));
 sky130_fd_sc_hd__clkinv_4 _247_ (.A(\divider2.odd_0.initial_begin[1] ),
    .Y(_121_));
 sky130_fd_sc_hd__inv_2 _248_ (.A(\divider2.odd_0.out_counter2 ),
    .Y(_122_));
 sky130_fd_sc_hd__inv_2 _249_ (.A(_018_),
    .Y(_123_));
 sky130_fd_sc_hd__clkinv_4 _250_ (.A(\divider.odd_0.initial_begin[1] ),
    .Y(_124_));
 sky130_fd_sc_hd__clkinv_4 _251_ (.A(\divider.odd_0.out_counter2 ),
    .Y(_125_));
 sky130_fd_sc_hd__inv_2 _252_ (.A(_007_),
    .Y(_126_));
 sky130_fd_sc_hd__clkinv_2 _253_ (.A(\divider.even_0.counter[0] ),
    .Y(_057_));
 sky130_fd_sc_hd__inv_2 _254_ (.A(\divider.odd_0.initial_begin[0] ),
    .Y(_039_));
 sky130_fd_sc_hd__clkinv_4 _255_ (.A(\divider.odd_0.initial_begin[2] ),
    .Y(_127_));
 sky130_fd_sc_hd__clkinv_2 _256_ (.A(\divider.odd_0.counter2[0] ),
    .Y(_045_));
 sky130_fd_sc_hd__clkinv_4 _257_ (.A(\divider.odd_0.counter[0] ),
    .Y(_051_));
 sky130_fd_sc_hd__clkinv_2 _258_ (.A(\divider2.even_0.counter[0] ),
    .Y(_077_));
 sky130_fd_sc_hd__clkinv_4 _259_ (.A(\divider2.odd_0.initial_begin[2] ),
    .Y(_128_));
 sky130_fd_sc_hd__inv_2 _260_ (.A(\divider2.odd_0.initial_begin[0] ),
    .Y(_059_));
 sky130_fd_sc_hd__clkinv_2 _261_ (.A(\divider2.odd_0.counter2[0] ),
    .Y(_065_));
 sky130_fd_sc_hd__clkinv_4 _262_ (.A(\divider2.odd_0.counter[0] ),
    .Y(_071_));
 sky130_fd_sc_hd__inv_2 _263_ (.A(net1),
    .Y(pll_clk_sel));
 sky130_fd_sc_hd__inv_2 _264_ (.A(\divider.even_0.out_counter ),
    .Y(_129_));
 sky130_fd_sc_hd__inv_2 _265_ (.A(\divider2.even_0.out_counter ),
    .Y(_130_));
 sky130_fd_sc_hd__inv_4 _411__8 (.A(clknet_1_1__leaf_net10),
    .Y(net38));
 sky130_fd_sc_hd__inv_2 _267_ (.A(_006_),
    .Y(_131_));
 sky130_fd_sc_hd__inv_4 _413__5 (.A(clknet_1_1__leaf_pll_clk),
    .Y(net35));
 sky130_fd_sc_hd__inv_2 _269_ (.A(_008_),
    .Y(_132_));
 sky130_fd_sc_hd__inv_2 _270_ (.A(_017_),
    .Y(_133_));
 sky130_fd_sc_hd__inv_4 _415__2 (.A(clknet_1_1__leaf_pll_clk90),
    .Y(net32));
 sky130_fd_sc_hd__inv_2 _272_ (.A(_019_),
    .Y(_134_));
 sky130_fd_sc_hd__mux2_1 _273_ (.A0(\divider2.odd_0.initial_begin[1] ),
    .A1(_024_),
    .S(_002_),
    .X(_112_));
 sky130_fd_sc_hd__nor2_1 _274_ (.A(\divider2.odd_0.initial_begin[1] ),
    .B(\divider2.odd_0.initial_begin[2] ),
    .Y(_135_));
 sky130_fd_sc_hd__nor2_1 _275_ (.A(net13),
    .B(net14),
    .Y(_027_));
 sky130_fd_sc_hd__o21a_4 _276_ (.A1(net13),
    .A2(\divider2.even_0.N[1] ),
    .B1(net15),
    .X(_136_));
 sky130_fd_sc_hd__o2111ai_4 _277_ (.A1(net13),
    .A2(net14),
    .B1(net15),
    .C1(_128_),
    .D1(_121_),
    .Y(_137_));
 sky130_fd_sc_hd__inv_2 _278_ (.A(_137_),
    .Y(_033_));
 sky130_fd_sc_hd__nor3b_2 _279_ (.A(\divider2.odd_0.counter2[1] ),
    .B(\divider2.odd_0.counter2[2] ),
    .C_N(\divider2.odd_0.counter2[0] ),
    .Y(_034_));
 sky130_fd_sc_hd__o2111a_1 _280_ (.A1(net13),
    .A2(net14),
    .B1(net15),
    .C1(_135_),
    .D1(_034_),
    .X(_138_));
 sky130_fd_sc_hd__a41oi_1 _281_ (.A1(_135_),
    .A2(_136_),
    .A3(_034_),
    .A4(_122_),
    .B1(\divider2.odd_0.rst_pulse ),
    .Y(_139_));
 sky130_fd_sc_hd__o21ai_1 _282_ (.A1(_122_),
    .A2(_138_),
    .B1(_139_),
    .Y(_110_));
 sky130_fd_sc_hd__a31oi_2 _283_ (.A1(_136_),
    .A2(_128_),
    .A3(_121_),
    .B1(net21),
    .Y(_140_));
 sky130_fd_sc_hd__nand3b_1 _284_ (.A_N(net21),
    .B(_137_),
    .C(\divider2.odd_0.counter2[1] ),
    .Y(_141_));
 sky130_fd_sc_hd__o21ai_1 _285_ (.A1(_123_),
    .A2(_140_),
    .B1(_141_),
    .Y(_108_));
 sky130_fd_sc_hd__mux2_1 _286_ (.A0(\divider.odd_0.initial_begin[1] ),
    .A1(_013_),
    .S(_003_),
    .X(_096_));
 sky130_fd_sc_hd__nor2_1 _287_ (.A(\divider.odd_0.initial_begin[1] ),
    .B(\divider.odd_0.initial_begin[2] ),
    .Y(_142_));
 sky130_fd_sc_hd__nor2_1 _288_ (.A(net17),
    .B(\divider.even_0.N[1] ),
    .Y(_026_));
 sky130_fd_sc_hd__o21a_4 _289_ (.A1(net17),
    .A2(\divider.even_0.N[1] ),
    .B1(net20),
    .X(_143_));
 sky130_fd_sc_hd__o2111ai_4 _290_ (.A1(net17),
    .A2(net18),
    .B1(net19),
    .C1(_127_),
    .D1(_124_),
    .Y(_144_));
 sky130_fd_sc_hd__inv_2 _291_ (.A(_144_),
    .Y(_029_));
 sky130_fd_sc_hd__nor3b_2 _292_ (.A(\divider.odd_0.counter2[1] ),
    .B(\divider.odd_0.counter2[2] ),
    .C_N(\divider.odd_0.counter2[0] ),
    .Y(_030_));
 sky130_fd_sc_hd__o2111a_1 _293_ (.A1(net17),
    .A2(net18),
    .B1(net19),
    .C1(_142_),
    .D1(_030_),
    .X(_145_));
 sky130_fd_sc_hd__a41oi_1 _294_ (.A1(_142_),
    .A2(_143_),
    .A3(_030_),
    .A4(_125_),
    .B1(net24),
    .Y(_146_));
 sky130_fd_sc_hd__o21ai_1 _295_ (.A1(_125_),
    .A2(_145_),
    .B1(_146_),
    .Y(_094_));
 sky130_fd_sc_hd__a31oi_2 _296_ (.A1(_143_),
    .A2(_127_),
    .A3(_124_),
    .B1(net23),
    .Y(_147_));
 sky130_fd_sc_hd__nand3b_1 _297_ (.A_N(net23),
    .B(_144_),
    .C(\divider.odd_0.counter2[1] ),
    .Y(_148_));
 sky130_fd_sc_hd__o21ai_1 _298_ (.A1(_126_),
    .A2(_147_),
    .B1(_148_),
    .Y(_092_));
 sky130_fd_sc_hd__nor2_1 _299_ (.A(\divider.even_0.counter[1] ),
    .B(\divider.even_0.counter[2] ),
    .Y(_149_));
 sky130_fd_sc_hd__nand2_1 _300_ (.A(\divider.even_0.counter[0] ),
    .B(_149_),
    .Y(_028_));
 sky130_fd_sc_hd__or2_1 _301_ (.A(net23),
    .B(_143_),
    .X(_001_));
 sky130_fd_sc_hd__nor2_1 _302_ (.A(\divider.odd_0.counter[1] ),
    .B(\divider.odd_0.counter[2] ),
    .Y(_150_));
 sky130_fd_sc_hd__nor3_2 _303_ (.A(\divider.odd_0.counter[1] ),
    .B(\divider.odd_0.counter[2] ),
    .C(_051_),
    .Y(_031_));
 sky130_fd_sc_hd__nor2_1 _304_ (.A(\divider2.even_0.counter[1] ),
    .B(\divider2.even_0.counter[2] ),
    .Y(_151_));
 sky130_fd_sc_hd__nand2_1 _305_ (.A(\divider2.even_0.counter[0] ),
    .B(_151_),
    .Y(_032_));
 sky130_fd_sc_hd__or2_1 _306_ (.A(net21),
    .B(_136_),
    .X(_000_));
 sky130_fd_sc_hd__nor2_1 _307_ (.A(\divider2.odd_0.counter[1] ),
    .B(\divider2.odd_0.counter[2] ),
    .Y(_152_));
 sky130_fd_sc_hd__nor3_2 _308_ (.A(\divider2.odd_0.counter[1] ),
    .B(\divider2.odd_0.counter[2] ),
    .C(_071_),
    .Y(_035_));
 sky130_fd_sc_hd__and2b_2 _309_ (.A_N(net20),
    .B(_036_),
    .X(_153_));
 sky130_fd_sc_hd__nand2_1 _310_ (.A(\divider.odd_0.out_counter2 ),
    .B(\divider.odd_0.out_counter ),
    .Y(_154_));
 sky130_fd_sc_hd__or2_1 _311_ (.A(\divider.odd_0.out_counter2 ),
    .B(\divider.odd_0.out_counter ),
    .X(_155_));
 sky130_fd_sc_hd__a31o_2 _312_ (.A1(_155_),
    .A2(_143_),
    .A3(_154_),
    .B1(_153_),
    .X(\divider.out ));
 sky130_fd_sc_hd__and2b_2 _313_ (.A_N(net15),
    .B(_038_),
    .X(_156_));
 sky130_fd_sc_hd__nand2_1 _314_ (.A(\divider2.odd_0.out_counter2 ),
    .B(\divider2.odd_0.out_counter ),
    .Y(_157_));
 sky130_fd_sc_hd__or2_1 _315_ (.A(\divider2.odd_0.out_counter2 ),
    .B(\divider2.odd_0.out_counter ),
    .X(_158_));
 sky130_fd_sc_hd__a31o_2 _316_ (.A1(_158_),
    .A2(_136_),
    .A3(_157_),
    .B1(_156_),
    .X(\divider2.out ));
 sky130_fd_sc_hd__xnor2_1 _317_ (.A(net18),
    .B(net19),
    .Y(_040_));
 sky130_fd_sc_hd__xnor2_1 _318_ (.A(\divider.odd_0.initial_begin[1] ),
    .B(\divider.odd_0.initial_begin[0] ),
    .Y(_041_));
 sky130_fd_sc_hd__nor3_1 _319_ (.A(net17),
    .B(net18),
    .C(net19),
    .Y(_159_));
 sky130_fd_sc_hd__o21a_1 _320_ (.A1(net18),
    .A2(net19),
    .B1(net17),
    .X(_044_));
 sky130_fd_sc_hd__nor2_1 _321_ (.A(_159_),
    .B(_044_),
    .Y(_042_));
 sky130_fd_sc_hd__o21a_1 _322_ (.A1(\divider.odd_0.initial_begin[1] ),
    .A2(\divider.odd_0.initial_begin[0] ),
    .B1(\divider.odd_0.initial_begin[2] ),
    .X(_160_));
 sky130_fd_sc_hd__a21o_1 _323_ (.A1(_039_),
    .A2(_142_),
    .B1(_160_),
    .X(_043_));
 sky130_fd_sc_hd__xnor2_1 _324_ (.A(\divider.odd_0.counter2[1] ),
    .B(\divider.odd_0.counter2[0] ),
    .Y(_047_));
 sky130_fd_sc_hd__or3_1 _325_ (.A(\divider.odd_0.counter2[1] ),
    .B(\divider.odd_0.counter2[0] ),
    .C(\divider.odd_0.counter2[2] ),
    .X(_161_));
 sky130_fd_sc_hd__o21ai_1 _326_ (.A1(\divider.odd_0.counter2[1] ),
    .A2(\divider.odd_0.counter2[0] ),
    .B1(\divider.odd_0.counter2[2] ),
    .Y(_162_));
 sky130_fd_sc_hd__nand2_1 _327_ (.A(_161_),
    .B(_162_),
    .Y(_049_));
 sky130_fd_sc_hd__xnor2_1 _328_ (.A(\divider.odd_0.counter[0] ),
    .B(\divider.odd_0.counter[1] ),
    .Y(_053_));
 sky130_fd_sc_hd__or3_1 _329_ (.A(\divider.odd_0.counter[0] ),
    .B(\divider.odd_0.counter[1] ),
    .C(\divider.odd_0.counter[2] ),
    .X(_163_));
 sky130_fd_sc_hd__o21ai_1 _330_ (.A1(\divider.odd_0.counter[0] ),
    .A2(\divider.odd_0.counter[1] ),
    .B1(\divider.odd_0.counter[2] ),
    .Y(_164_));
 sky130_fd_sc_hd__nand2_1 _331_ (.A(_163_),
    .B(_164_),
    .Y(_055_));
 sky130_fd_sc_hd__xnor2_1 _332_ (.A(\divider.even_0.counter[1] ),
    .B(\divider.even_0.counter[0] ),
    .Y(_058_));
 sky130_fd_sc_hd__xnor2_1 _333_ (.A(net14),
    .B(net15),
    .Y(_060_));
 sky130_fd_sc_hd__xnor2_1 _334_ (.A(\divider2.odd_0.initial_begin[1] ),
    .B(\divider2.odd_0.initial_begin[0] ),
    .Y(_061_));
 sky130_fd_sc_hd__nor3_1 _335_ (.A(net13),
    .B(net14),
    .C(net15),
    .Y(_165_));
 sky130_fd_sc_hd__o21a_1 _336_ (.A1(net14),
    .A2(net15),
    .B1(net13),
    .X(_064_));
 sky130_fd_sc_hd__nor2_1 _337_ (.A(_165_),
    .B(_064_),
    .Y(_062_));
 sky130_fd_sc_hd__o21a_1 _338_ (.A1(\divider2.odd_0.initial_begin[1] ),
    .A2(\divider2.odd_0.initial_begin[0] ),
    .B1(\divider2.odd_0.initial_begin[2] ),
    .X(_166_));
 sky130_fd_sc_hd__a21o_1 _339_ (.A1(_059_),
    .A2(_135_),
    .B1(_166_),
    .X(_063_));
 sky130_fd_sc_hd__xnor2_1 _340_ (.A(\divider2.odd_0.counter2[1] ),
    .B(\divider2.odd_0.counter2[0] ),
    .Y(_067_));
 sky130_fd_sc_hd__or3_1 _341_ (.A(\divider2.odd_0.counter2[1] ),
    .B(\divider2.odd_0.counter2[0] ),
    .C(\divider2.odd_0.counter2[2] ),
    .X(_167_));
 sky130_fd_sc_hd__o21ai_1 _342_ (.A1(\divider2.odd_0.counter2[1] ),
    .A2(\divider2.odd_0.counter2[0] ),
    .B1(\divider2.odd_0.counter2[2] ),
    .Y(_168_));
 sky130_fd_sc_hd__nand2_1 _343_ (.A(_167_),
    .B(_168_),
    .Y(_069_));
 sky130_fd_sc_hd__xnor2_1 _344_ (.A(\divider2.odd_0.counter[1] ),
    .B(\divider2.odd_0.counter[0] ),
    .Y(_073_));
 sky130_fd_sc_hd__or3_1 _345_ (.A(\divider2.odd_0.counter[1] ),
    .B(\divider2.odd_0.counter[0] ),
    .C(\divider2.odd_0.counter[2] ),
    .X(_169_));
 sky130_fd_sc_hd__o21ai_1 _346_ (.A1(\divider2.odd_0.counter[1] ),
    .A2(\divider2.odd_0.counter[0] ),
    .B1(\divider2.odd_0.counter[2] ),
    .Y(_170_));
 sky130_fd_sc_hd__nand2_1 _347_ (.A(_169_),
    .B(_170_),
    .Y(_075_));
 sky130_fd_sc_hd__xnor2_1 _348_ (.A(\divider2.even_0.counter[1] ),
    .B(\divider2.even_0.counter[0] ),
    .Y(_078_));
 sky130_fd_sc_hd__nor2_1 _349_ (.A(net2),
    .B(\reset_delay[0] ),
    .Y(net11));
 sky130_fd_sc_hd__o2111ai_1 _350_ (.A1(\divider2.even_0.N[2] ),
    .A2(\divider2.even_0.N[1] ),
    .B1(net16),
    .C1(\divider2.odd_0.counter[0] ),
    .D1(_152_),
    .Y(_171_));
 sky130_fd_sc_hd__a21oi_1 _351_ (.A1(_171_),
    .A2(\divider2.odd_0.out_counter ),
    .B1(net22),
    .Y(_172_));
 sky130_fd_sc_hd__o21ai_1 _352_ (.A1(\divider2.odd_0.out_counter ),
    .A2(_171_),
    .B1(_172_),
    .Y(_088_));
 sky130_fd_sc_hd__o21ai_1 _353_ (.A1(net19),
    .A2(_028_),
    .B1(\divider.even_0.out_counter ),
    .Y(_173_));
 sky130_fd_sc_hd__nand4b_1 _354_ (.A_N(net19),
    .B(\divider.even_0.counter[0] ),
    .C(_149_),
    .D(_129_),
    .Y(_174_));
 sky130_fd_sc_hd__nand2_1 _355_ (.A(_173_),
    .B(_174_),
    .Y(_089_));
 sky130_fd_sc_hd__nand2b_1 _356_ (.A_N(\divider.odd_0.old_N[1] ),
    .B(net18),
    .Y(_175_));
 sky130_fd_sc_hd__nand2b_1 _357_ (.A_N(net18),
    .B(\divider.odd_0.old_N[1] ),
    .Y(_176_));
 sky130_fd_sc_hd__nand3_1 _358_ (.A(_175_),
    .B(_176_),
    .C(\divider.odd_0.old_N[0] ),
    .Y(_177_));
 sky130_fd_sc_hd__nor2_1 _359_ (.A(\divider.even_0.N[2] ),
    .B(\divider.odd_0.old_N[2] ),
    .Y(_178_));
 sky130_fd_sc_hd__and2_1 _360_ (.A(net17),
    .B(\divider.odd_0.old_N[2] ),
    .X(_179_));
 sky130_fd_sc_hd__o21ai_1 _361_ (.A1(_178_),
    .A2(_179_),
    .B1(_143_),
    .Y(_180_));
 sky130_fd_sc_hd__o22a_1 _362_ (.A1(\divider.odd_0.rst_pulse ),
    .A2(_143_),
    .B1(_177_),
    .B2(_180_),
    .X(_090_));
 sky130_fd_sc_hd__nand3b_1 _363_ (.A_N(net23),
    .B(_144_),
    .C(\divider.odd_0.counter2[0] ),
    .Y(_181_));
 sky130_fd_sc_hd__o21ai_1 _364_ (.A1(_131_),
    .A2(_147_),
    .B1(_181_),
    .Y(_091_));
 sky130_fd_sc_hd__nand3b_1 _365_ (.A_N(net23),
    .B(_144_),
    .C(\divider.odd_0.counter2[2] ),
    .Y(_182_));
 sky130_fd_sc_hd__o21ai_1 _366_ (.A1(_132_),
    .A2(_147_),
    .B1(_182_),
    .Y(_093_));
 sky130_fd_sc_hd__mux2_1 _367_ (.A0(\divider.odd_0.initial_begin[0] ),
    .A1(_012_),
    .S(_003_),
    .X(_095_));
 sky130_fd_sc_hd__mux2_1 _368_ (.A0(\divider.odd_0.initial_begin[2] ),
    .A1(_014_),
    .S(_003_),
    .X(_097_));
 sky130_fd_sc_hd__o21ai_1 _369_ (.A1(net24),
    .A2(_143_),
    .B1(_009_),
    .Y(_183_));
 sky130_fd_sc_hd__o31ai_1 _370_ (.A1(net24),
    .A2(_051_),
    .A3(_143_),
    .B1(_183_),
    .Y(_098_));
 sky130_fd_sc_hd__o21bai_1 _371_ (.A1(net24),
    .A2(_143_),
    .B1_N(_010_),
    .Y(_184_));
 sky130_fd_sc_hd__o31a_1 _372_ (.A1(net24),
    .A2(\divider.odd_0.counter[1] ),
    .A3(_143_),
    .B1(_184_),
    .X(_099_));
 sky130_fd_sc_hd__o21bai_1 _373_ (.A1(net24),
    .A2(_143_),
    .B1_N(_011_),
    .Y(_185_));
 sky130_fd_sc_hd__o31a_1 _374_ (.A1(net24),
    .A2(\divider.odd_0.counter[2] ),
    .A3(_143_),
    .B1(_185_),
    .X(_100_));
 sky130_fd_sc_hd__mux2_1 _375_ (.A0(_004_),
    .A1(\divider.even_0.counter[0] ),
    .S(net19),
    .X(_101_));
 sky130_fd_sc_hd__mux2_1 _376_ (.A0(_005_),
    .A1(\divider.even_0.counter[1] ),
    .S(net19),
    .X(_102_));
 sky130_fd_sc_hd__nor4_1 _377_ (.A(net19),
    .B(\divider.even_0.counter[1] ),
    .C(\divider.even_0.counter[0] ),
    .D(\divider.even_0.counter[2] ),
    .Y(_186_));
 sky130_fd_sc_hd__o31a_1 _378_ (.A1(net19),
    .A2(\divider.even_0.counter[1] ),
    .A3(\divider.even_0.counter[0] ),
    .B1(\divider.even_0.counter[2] ),
    .X(_187_));
 sky130_fd_sc_hd__or2_1 _379_ (.A(_186_),
    .B(_187_),
    .X(_103_));
 sky130_fd_sc_hd__mux2_1 _380_ (.A0(ext_clk_syncd_pre),
    .A1(clknet_1_0__leaf_ext_clk),
    .S(net25),
    .X(_104_));
 sky130_fd_sc_hd__o21ai_1 _381_ (.A1(net15),
    .A2(_032_),
    .B1(\divider2.even_0.out_counter ),
    .Y(_188_));
 sky130_fd_sc_hd__nand4b_1 _382_ (.A_N(net16),
    .B(\divider2.even_0.counter[0] ),
    .C(_151_),
    .D(_130_),
    .Y(_189_));
 sky130_fd_sc_hd__nand2_1 _383_ (.A(_188_),
    .B(_189_),
    .Y(_105_));
 sky130_fd_sc_hd__nand2b_1 _384_ (.A_N(\divider2.even_0.N[1] ),
    .B(\divider2.odd_0.old_N[1] ),
    .Y(_190_));
 sky130_fd_sc_hd__nand2b_1 _385_ (.A_N(\divider2.odd_0.old_N[2] ),
    .B(\divider2.even_0.N[2] ),
    .Y(_191_));
 sky130_fd_sc_hd__nand2b_1 _386_ (.A_N(\divider2.odd_0.old_N[1] ),
    .B(\divider2.even_0.N[1] ),
    .Y(_192_));
 sky130_fd_sc_hd__nand2b_1 _387_ (.A_N(net13),
    .B(\divider2.odd_0.old_N[2] ),
    .Y(_193_));
 sky130_fd_sc_hd__nand3_1 _388_ (.A(_136_),
    .B(_191_),
    .C(_193_),
    .Y(_194_));
 sky130_fd_sc_hd__nand3_1 _389_ (.A(_190_),
    .B(_192_),
    .C(\divider2.odd_0.old_N[0] ),
    .Y(_195_));
 sky130_fd_sc_hd__o22a_1 _390_ (.A1(net22),
    .A2(_136_),
    .B1(_194_),
    .B2(_195_),
    .X(_106_));
 sky130_fd_sc_hd__nand3b_1 _391_ (.A_N(net21),
    .B(_137_),
    .C(\divider2.odd_0.counter2[0] ),
    .Y(_196_));
 sky130_fd_sc_hd__o21ai_1 _392_ (.A1(_133_),
    .A2(_140_),
    .B1(_196_),
    .Y(_107_));
 sky130_fd_sc_hd__nand3b_1 _393_ (.A_N(net21),
    .B(_137_),
    .C(\divider2.odd_0.counter2[2] ),
    .Y(_197_));
 sky130_fd_sc_hd__o21ai_1 _394_ (.A1(_134_),
    .A2(_140_),
    .B1(_197_),
    .Y(_109_));
 sky130_fd_sc_hd__mux2_1 _395_ (.A0(\divider2.odd_0.initial_begin[0] ),
    .A1(_023_),
    .S(_002_),
    .X(_111_));
 sky130_fd_sc_hd__mux2_1 _396_ (.A0(\divider2.odd_0.initial_begin[2] ),
    .A1(_025_),
    .S(_002_),
    .X(_113_));
 sky130_fd_sc_hd__o21ai_1 _397_ (.A1(net22),
    .A2(_136_),
    .B1(_020_),
    .Y(_198_));
 sky130_fd_sc_hd__o31ai_1 _398_ (.A1(net22),
    .A2(_071_),
    .A3(_136_),
    .B1(_198_),
    .Y(_114_));
 sky130_fd_sc_hd__o21bai_1 _399_ (.A1(net22),
    .A2(_136_),
    .B1_N(_021_),
    .Y(_199_));
 sky130_fd_sc_hd__o31a_1 _400_ (.A1(net22),
    .A2(\divider2.odd_0.counter[1] ),
    .A3(_136_),
    .B1(_199_),
    .X(_115_));
 sky130_fd_sc_hd__o21bai_1 _401_ (.A1(net21),
    .A2(_136_),
    .B1_N(_022_),
    .Y(_200_));
 sky130_fd_sc_hd__o31a_1 _402_ (.A1(net22),
    .A2(\divider2.odd_0.counter[2] ),
    .A3(_136_),
    .B1(_200_),
    .X(_116_));
 sky130_fd_sc_hd__o2111ai_1 _403_ (.A1(\divider.even_0.N[2] ),
    .A2(\divider.even_0.N[1] ),
    .B1(net20),
    .C1(\divider.odd_0.counter[0] ),
    .D1(_150_),
    .Y(_201_));
 sky130_fd_sc_hd__a21oi_1 _404_ (.A1(_201_),
    .A2(\divider.odd_0.out_counter ),
    .B1(net24),
    .Y(_202_));
 sky130_fd_sc_hd__o21ai_1 _405_ (.A1(\divider.odd_0.out_counter ),
    .A2(_201_),
    .B1(_202_),
    .Y(_117_));
 sky130_fd_sc_hd__mux2_1 _406_ (.A0(_015_),
    .A1(\divider2.even_0.counter[0] ),
    .S(net16),
    .X(_118_));
 sky130_fd_sc_hd__mux2_1 _407_ (.A0(_016_),
    .A1(\divider2.even_0.counter[1] ),
    .S(net16),
    .X(_119_));
 sky130_fd_sc_hd__nor4_1 _408_ (.A(net15),
    .B(\divider2.even_0.counter[1] ),
    .C(\divider2.even_0.counter[0] ),
    .D(\divider2.even_0.counter[2] ),
    .Y(_203_));
 sky130_fd_sc_hd__o31a_1 _409_ (.A1(net15),
    .A2(\divider2.even_0.counter[1] ),
    .A3(\divider2.even_0.counter[0] ),
    .B1(\divider2.even_0.counter[2] ),
    .X(_204_));
 sky130_fd_sc_hd__or2_1 _410_ (.A(_203_),
    .B(_204_),
    .X(_120_));
 sky130_fd_sc_hd__inv_4 _412__9 (.A(core_clk),
    .Y(net39));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_ext_clk (.A(ext_clk),
    .X(clknet_0_ext_clk));
 sky130_fd_sc_hd__inv_4 _414__6 (.A(clknet_1_0__leaf_pll_clk),
    .Y(net36));
 sky130_fd_sc_hd__inv_4 _266__7 (.A(clknet_1_1__leaf_net10),
    .Y(net37));
 sky130_fd_sc_hd__inv_4 _416__3 (.A(clknet_1_0__leaf_pll_clk90),
    .Y(net33));
 sky130_fd_sc_hd__inv_4 _268__4 (.A(clknet_1_0__leaf_pll_clk),
    .Y(net34));
 sky130_fd_sc_hd__dfstp_1 _417_ (.CLK(net37),
    .D(\reset_delay[1] ),
    .SET_B(net28),
    .Q(\reset_delay[0] ));
 sky130_fd_sc_hd__dfstp_1 _418_ (.CLK(net38),
    .D(\reset_delay[2] ),
    .SET_B(net25),
    .Q(\reset_delay[1] ));
 sky130_fd_sc_hd__dfstp_1 _419_ (.CLK(net39),
    .D(net30),
    .SET_B(net25),
    .Q(\reset_delay[2] ));
 sky130_fd_sc_hd__dfrtp_1 _420_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(pll_clk_sel),
    .RESET_B(net27),
    .Q(use_pll_first));
 sky130_fd_sc_hd__dfrtp_1 _421_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(use_pll_first),
    .RESET_B(net28),
    .Q(use_pll_second));
 sky130_fd_sc_hd__dfstp_1 _422_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_088_),
    .SET_B(net28),
    .Q(\divider2.odd_0.out_counter ));
 sky130_fd_sc_hd__dfrtp_1 _423_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(ext_clk_syncd_pre),
    .RESET_B(net26),
    .Q(ext_clk_syncd));
 sky130_fd_sc_hd__dfxtp_1 _424_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(net20),
    .Q(\divider.odd_0.old_N[0] ));
 sky130_fd_sc_hd__dfxtp_1 _425_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(net18),
    .Q(\divider.odd_0.old_N[1] ));
 sky130_fd_sc_hd__dfxtp_1 _426_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(net17),
    .Q(\divider.odd_0.old_N[2] ));
 sky130_fd_sc_hd__dfstp_1 _427_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_089_),
    .SET_B(net27),
    .Q(\divider.even_0.out_counter ));
 sky130_fd_sc_hd__dfrtp_1 _428_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_090_),
    .RESET_B(net27),
    .Q(\divider.odd_0.rst_pulse ));
 sky130_fd_sc_hd__dfrtn_1 _429_ (.CLK_N(clknet_1_0__leaf_pll_clk),
    .D(_091_),
    .RESET_B(net25),
    .Q(\divider.odd_0.counter2[0] ));
 sky130_fd_sc_hd__dfstp_1 _430_ (.CLK(net34),
    .D(_092_),
    .SET_B(net25),
    .Q(\divider.odd_0.counter2[1] ));
 sky130_fd_sc_hd__dfrtn_1 _431_ (.CLK_N(clknet_1_1__leaf_pll_clk),
    .D(_093_),
    .RESET_B(net27),
    .Q(\divider.odd_0.counter2[2] ));
 sky130_fd_sc_hd__dfstp_1 _432_ (.CLK(net35),
    .D(_094_),
    .SET_B(net25),
    .Q(\divider.odd_0.out_counter2 ));
 sky130_fd_sc_hd__dfrtn_1 _433_ (.CLK_N(clknet_1_0__leaf_pll_clk),
    .D(_095_),
    .RESET_B(net25),
    .Q(\divider.odd_0.initial_begin[0] ));
 sky130_fd_sc_hd__dfstp_2 _434_ (.CLK(net36),
    .D(_096_),
    .SET_B(net25),
    .Q(\divider.odd_0.initial_begin[1] ));
 sky130_fd_sc_hd__dfrtn_1 _435_ (.CLK_N(clknet_1_0__leaf_pll_clk),
    .D(_097_),
    .RESET_B(net25),
    .Q(\divider.odd_0.initial_begin[2] ));
 sky130_fd_sc_hd__dfrtp_2 _436_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_098_),
    .RESET_B(net27),
    .Q(\divider.odd_0.counter[0] ));
 sky130_fd_sc_hd__dfstp_1 _437_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_099_),
    .SET_B(net29),
    .Q(\divider.odd_0.counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _438_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_100_),
    .RESET_B(net29),
    .Q(\divider.odd_0.counter[2] ));
 sky130_fd_sc_hd__dfstp_2 _439_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(_101_),
    .SET_B(net25),
    .Q(\divider.even_0.counter[0] ));
 sky130_fd_sc_hd__dfrtp_1 _440_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(_102_),
    .RESET_B(net25),
    .Q(\divider.even_0.counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _441_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(_103_),
    .RESET_B(net25),
    .Q(\divider.even_0.counter[2] ));
 sky130_fd_sc_hd__dfrtp_1 _442_ (.CLK(\clknet_1_0__leaf_divider.out ),
    .D(net7),
    .RESET_B(net27),
    .Q(\divider.syncNp[0] ));
 sky130_fd_sc_hd__dfstp_1 _443_ (.CLK(\clknet_1_0__leaf_divider.out ),
    .D(net8),
    .SET_B(net27),
    .Q(\divider.syncNp[1] ));
 sky130_fd_sc_hd__dfrtp_1 _444_ (.CLK(\clknet_1_1__leaf_divider.out ),
    .D(net9),
    .RESET_B(net27),
    .Q(\divider.syncNp[2] ));
 sky130_fd_sc_hd__dfrtp_1 _445_ (.CLK(\clknet_1_0__leaf_divider.out ),
    .D(\divider.syncNp[0] ),
    .RESET_B(net27),
    .Q(\divider.even_0.N[0] ));
 sky130_fd_sc_hd__dfstp_1 _446_ (.CLK(\clknet_1_0__leaf_divider.out ),
    .D(\divider.syncNp[1] ),
    .SET_B(net27),
    .Q(\divider.even_0.N[1] ));
 sky130_fd_sc_hd__dfrtp_1 _447_ (.CLK(\clknet_1_0__leaf_divider.out ),
    .D(\divider.syncNp[2] ),
    .RESET_B(net27),
    .Q(\divider.even_0.N[2] ));
 sky130_fd_sc_hd__dfxtp_1 _448_ (.CLK(clknet_1_0__leaf_pll_clk),
    .D(_104_),
    .Q(ext_clk_syncd_pre));
 sky130_fd_sc_hd__dfxtp_1 _449_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(net16),
    .Q(\divider2.odd_0.old_N[0] ));
 sky130_fd_sc_hd__dfxtp_1 _450_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(net14),
    .Q(\divider2.odd_0.old_N[1] ));
 sky130_fd_sc_hd__dfxtp_1 _451_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(\divider2.even_0.N[2] ),
    .Q(\divider2.odd_0.old_N[2] ));
 sky130_fd_sc_hd__dfstp_1 _452_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_105_),
    .SET_B(net28),
    .Q(\divider2.even_0.out_counter ));
 sky130_fd_sc_hd__dfrtp_1 _453_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_106_),
    .RESET_B(net28),
    .Q(\divider2.odd_0.rst_pulse ));
 sky130_fd_sc_hd__dfrtn_1 _454_ (.CLK_N(clknet_1_0__leaf_pll_clk90),
    .D(_107_),
    .RESET_B(net26),
    .Q(\divider2.odd_0.counter2[0] ));
 sky130_fd_sc_hd__dfstp_1 _455_ (.CLK(net31),
    .D(_108_),
    .SET_B(net26),
    .Q(\divider2.odd_0.counter2[1] ));
 sky130_fd_sc_hd__dfrtn_1 _456_ (.CLK_N(clknet_1_0__leaf_pll_clk90),
    .D(_109_),
    .RESET_B(net26),
    .Q(\divider2.odd_0.counter2[2] ));
 sky130_fd_sc_hd__dfstp_1 _457_ (.CLK(net32),
    .D(_110_),
    .SET_B(net28),
    .Q(\divider2.odd_0.out_counter2 ));
 sky130_fd_sc_hd__dfrtn_1 _458_ (.CLK_N(clknet_1_0__leaf_pll_clk90),
    .D(_111_),
    .RESET_B(net26),
    .Q(\divider2.odd_0.initial_begin[0] ));
 sky130_fd_sc_hd__dfstp_2 _459_ (.CLK(net33),
    .D(_112_),
    .SET_B(net26),
    .Q(\divider2.odd_0.initial_begin[1] ));
 sky130_fd_sc_hd__dfrtn_1 _460_ (.CLK_N(clknet_1_0__leaf_pll_clk90),
    .D(_113_),
    .RESET_B(net26),
    .Q(\divider2.odd_0.initial_begin[2] ));
 sky130_fd_sc_hd__dfrtp_4 _461_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_114_),
    .RESET_B(net28),
    .Q(\divider2.odd_0.counter[0] ));
 sky130_fd_sc_hd__dfstp_1 _462_ (.CLK(clknet_1_0__leaf_pll_clk90),
    .D(_115_),
    .SET_B(net26),
    .Q(\divider2.odd_0.counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _463_ (.CLK(clknet_1_0__leaf_pll_clk90),
    .D(_116_),
    .RESET_B(net28),
    .Q(\divider2.odd_0.counter[2] ));
 sky130_fd_sc_hd__dfstp_1 _464_ (.CLK(clknet_1_1__leaf_pll_clk),
    .D(_117_),
    .SET_B(net27),
    .Q(\divider.odd_0.out_counter ));
 sky130_fd_sc_hd__dfstp_2 _465_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_118_),
    .SET_B(net28),
    .Q(\divider2.even_0.counter[0] ));
 sky130_fd_sc_hd__dfrtp_1 _466_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_119_),
    .RESET_B(net28),
    .Q(\divider2.even_0.counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _467_ (.CLK(clknet_1_1__leaf_pll_clk90),
    .D(_120_),
    .RESET_B(net29),
    .Q(\divider2.even_0.counter[2] ));
 sky130_fd_sc_hd__dfrtp_1 _468_ (.CLK(\clknet_1_1__leaf_divider2.out ),
    .D(net4),
    .RESET_B(net29),
    .Q(\divider2.syncNp[0] ));
 sky130_fd_sc_hd__dfstp_1 _469_ (.CLK(\clknet_1_0__leaf_divider2.out ),
    .D(net5),
    .SET_B(net28),
    .Q(\divider2.syncNp[1] ));
 sky130_fd_sc_hd__dfrtp_1 _470_ (.CLK(\clknet_1_1__leaf_divider2.out ),
    .D(net6),
    .RESET_B(net29),
    .Q(\divider2.syncNp[2] ));
 sky130_fd_sc_hd__dfrtp_1 _471_ (.CLK(\clknet_1_1__leaf_divider2.out ),
    .D(\divider2.syncNp[0] ),
    .RESET_B(net29),
    .Q(\divider2.even_0.N[0] ));
 sky130_fd_sc_hd__dfstp_1 _472_ (.CLK(\clknet_1_0__leaf_divider2.out ),
    .D(\divider2.syncNp[1] ),
    .SET_B(net28),
    .Q(\divider2.even_0.N[1] ));
 sky130_fd_sc_hd__dfrtp_1 _473_ (.CLK(\clknet_1_1__leaf_divider2.out ),
    .D(\divider2.syncNp[2] ),
    .RESET_B(net29),
    .Q(\divider2.even_0.N[2] ));
 sky130_fd_sc_hd__inv_4 _271__1 (.A(clknet_1_0__leaf_pll_clk90),
    .Y(net31));
 sky130_fd_sc_hd__decap_3 PHY_0 ();
 sky130_fd_sc_hd__decap_3 PHY_1 ();
 sky130_fd_sc_hd__decap_3 PHY_2 ();
 sky130_fd_sc_hd__decap_3 PHY_3 ();
 sky130_fd_sc_hd__decap_3 PHY_4 ();
 sky130_fd_sc_hd__decap_3 PHY_5 ();
 sky130_fd_sc_hd__decap_3 PHY_6 ();
 sky130_fd_sc_hd__decap_3 PHY_7 ();
 sky130_fd_sc_hd__decap_3 PHY_8 ();
 sky130_fd_sc_hd__decap_3 PHY_9 ();
 sky130_fd_sc_hd__decap_3 PHY_10 ();
 sky130_fd_sc_hd__decap_3 PHY_11 ();
 sky130_fd_sc_hd__decap_3 PHY_12 ();
 sky130_fd_sc_hd__decap_3 PHY_13 ();
 sky130_fd_sc_hd__decap_3 PHY_14 ();
 sky130_fd_sc_hd__decap_3 PHY_15 ();
 sky130_fd_sc_hd__decap_3 PHY_16 ();
 sky130_fd_sc_hd__decap_3 PHY_17 ();
 sky130_fd_sc_hd__decap_3 PHY_18 ();
 sky130_fd_sc_hd__decap_3 PHY_19 ();
 sky130_fd_sc_hd__decap_3 PHY_20 ();
 sky130_fd_sc_hd__decap_3 PHY_21 ();
 sky130_fd_sc_hd__decap_3 PHY_22 ();
 sky130_fd_sc_hd__decap_3 PHY_23 ();
 sky130_fd_sc_hd__decap_3 PHY_24 ();
 sky130_fd_sc_hd__decap_3 PHY_25 ();
 sky130_fd_sc_hd__decap_3 PHY_26 ();
 sky130_fd_sc_hd__decap_3 PHY_27 ();
 sky130_fd_sc_hd__decap_3 PHY_28 ();
 sky130_fd_sc_hd__decap_3 PHY_29 ();
 sky130_fd_sc_hd__decap_3 PHY_30 ();
 sky130_fd_sc_hd__decap_3 PHY_31 ();
 sky130_fd_sc_hd__decap_3 PHY_32 ();
 sky130_fd_sc_hd__decap_3 PHY_33 ();
 sky130_fd_sc_hd__decap_3 PHY_34 ();
 sky130_fd_sc_hd__decap_3 PHY_35 ();
 sky130_fd_sc_hd__decap_3 PHY_36 ();
 sky130_fd_sc_hd__decap_3 PHY_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_165 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_167 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_171 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_194 ();
 sky130_fd_sc_hd__clkbuf_4 fanout18 (.A(\divider.even_0.N[1] ),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_4 fanout17 (.A(\divider.even_0.N[2] ),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_2 fanout16 (.A(\divider2.even_0.N[0] ),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_4 fanout15 (.A(\divider2.even_0.N[0] ),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_4 fanout14 (.A(\divider2.even_0.N[1] ),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_4 fanout13 (.A(\divider2.even_0.N[2] ),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_16 user_clk_out_buffer (.A(user_clk_buffered),
    .X(user_clk));
 sky130_fd_sc_hd__buf_12 output11 (.A(net11),
    .X(resetb_sync));
 sky130_fd_sc_hd__diode_2 ANTENNA__402__A3 (.DIODE(_136_));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(sel[2]),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(sel[1]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(sel[0]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(sel2[2]),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(sel2[1]),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(sel2[0]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(resetb),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(ext_reset),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(ext_clk_sel),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_4 fanout19 (.A(net20),
    .X(net19));
 sky130_fd_sc_hd__clkbuf_2 fanout20 (.A(\divider.even_0.N[0] ),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_4 fanout21 (.A(net22),
    .X(net21));
 sky130_fd_sc_hd__clkbuf_4 fanout22 (.A(\divider2.odd_0.rst_pulse ),
    .X(net22));
 sky130_fd_sc_hd__clkbuf_4 fanout23 (.A(net24),
    .X(net23));
 sky130_fd_sc_hd__clkbuf_4 fanout24 (.A(\divider.odd_0.rst_pulse ),
    .X(net24));
 sky130_fd_sc_hd__buf_4 fanout25 (.A(net3),
    .X(net25));
 sky130_fd_sc_hd__buf_2 fanout26 (.A(net3),
    .X(net26));
 sky130_fd_sc_hd__buf_4 fanout27 (.A(net29),
    .X(net27));
 sky130_fd_sc_hd__buf_4 fanout28 (.A(net29),
    .X(net28));
 sky130_fd_sc_hd__clkbuf_4 fanout29 (.A(net3),
    .X(net29));
 sky130_fd_sc_hd__conb_1 _419__30 (.LO(net30));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_ext_clk (.A(clknet_0_ext_clk),
    .X(clknet_1_0__leaf_ext_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_ext_clk (.A(clknet_0_ext_clk),
    .X(clknet_1_1__leaf_ext_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0__037_ (.A(_037_),
    .X(clknet_0__037_));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f__037_ (.A(clknet_0__037_),
    .X(clknet_1_0__leaf__037_));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f__037_ (.A(clknet_0__037_),
    .X(clknet_1_1__leaf__037_));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_net10 (.A(net10),
    .X(clknet_0_net10));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_net10 (.A(clknet_0_net10),
    .X(core_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_net10 (.A(clknet_0_net10),
    .X(clknet_1_1__leaf_net10));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_pll_clk (.A(pll_clk),
    .X(clknet_0_pll_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_pll_clk (.A(clknet_0_pll_clk),
    .X(clknet_1_0__leaf_pll_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_pll_clk (.A(clknet_0_pll_clk),
    .X(clknet_1_1__leaf_pll_clk));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_0_divider.out  (.A(\divider.out ),
    .X(\clknet_0_divider.out ));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_1_0__f_divider.out  (.A(\clknet_0_divider.out ),
    .X(\clknet_1_0__leaf_divider.out ));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_1_1__f_divider.out  (.A(\clknet_0_divider.out ),
    .X(\clknet_1_1__leaf_divider.out ));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_pll_clk90 (.A(pll_clk90),
    .X(clknet_0_pll_clk90));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_pll_clk90 (.A(clknet_0_pll_clk90),
    .X(clknet_1_0__leaf_pll_clk90));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_pll_clk90 (.A(clknet_0_pll_clk90),
    .X(clknet_1_1__leaf_pll_clk90));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_0_divider2.out  (.A(\divider2.out ),
    .X(\clknet_0_divider2.out ));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_1_0__f_divider2.out  (.A(\clknet_0_divider2.out ),
    .X(\clknet_1_0__leaf_divider2.out ));
 sky130_fd_sc_hd__clkbuf_16 \clkbuf_1_1__f_divider2.out  (.A(\clknet_0_divider2.out ),
    .X(\clknet_1_1__leaf_divider2.out ));
 sky130_fd_sc_hd__diode_2 ANTENNA__401__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__400__A3 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__399__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__398__A3 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__397__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__390__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__388__A (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__316__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__306__B (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__283__A1 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA__281__A2 (.DIODE(_136_));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_ext_clk_A (.DIODE(ext_clk));
 sky130_fd_sc_hd__diode_2 ANTENNA_input1_A (.DIODE(ext_clk_sel));
 sky130_fd_sc_hd__diode_2 ANTENNA_input2_A (.DIODE(ext_reset));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_pll_clk_A (.DIODE(pll_clk));
 sky130_fd_sc_hd__diode_2 ANTENNA_clkbuf_0_pll_clk90_A (.DIODE(pll_clk90));
 sky130_fd_sc_hd__diode_2 ANTENNA_input3_A (.DIODE(resetb));
 sky130_fd_sc_hd__diode_2 ANTENNA_input4_A (.DIODE(sel2[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA_input5_A (.DIODE(sel2[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA_input6_A (.DIODE(sel2[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA_input7_A (.DIODE(sel[0]));
 sky130_fd_sc_hd__diode_2 ANTENNA_input8_A (.DIODE(sel[1]));
 sky130_fd_sc_hd__diode_2 ANTENNA_input9_A (.DIODE(sel[2]));
 sky130_fd_sc_hd__diode_2 ANTENNA__409__A1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__408__A (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__381__A1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__313__A_N (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__276__B1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__277__B1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__233__A1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__335__C (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__333__B (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__234__A1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__336__A2 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__280__B1 (.DIODE(net15));
 sky130_fd_sc_hd__diode_2 ANTENNA__245__A0 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__275__B (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__450__D (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__336__A1 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__280__A2 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__277__A2 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__241__A1 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__235__A1 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__335__B (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__333__A (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__242__A1 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__236__A1 (.DIODE(net14));
 sky130_fd_sc_hd__diode_2 ANTENNA__387__A_N (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__246__A0 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__275__A (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__276__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__280__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__277__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__336__B1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__335__A (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__237__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__244__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__243__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__238__A1 (.DIODE(net13));
 sky130_fd_sc_hd__diode_2 ANTENNA__402__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__240__S (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__351__B1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__390__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__398__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__397__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__400__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__236__S (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__399__A1 (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__242__S (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__234__S (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA_fanout21_A (.DIODE(net22));
 sky130_fd_sc_hd__diode_2 ANTENNA__466__RESET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__465__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__452__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__472__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__469__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__463__RESET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__461__RESET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__457__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__453__RESET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__422__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__421__RESET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__417__SET_B (.DIODE(net28));
 sky130_fd_sc_hd__diode_2 ANTENNA__467__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__468__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__470__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__471__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__473__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA_fanout28_A (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__437__SET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA__438__RESET_B (.DIODE(net29));
 sky130_fd_sc_hd__diode_2 ANTENNA_fanout27_A (.DIODE(net29));
 sky130_fd_sc_hd__decap_8 FILLER_0_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_11 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_14 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_40 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_53 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_70 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_88 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_96 ();
 sky130_fd_sc_hd__decap_6 FILLER_0_110 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_116 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_118 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_126 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_144 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_179 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_185 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_196 ();
 sky130_ef_sc_hd__decap_12 FILLER_1_3 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_23 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_50 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_56 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_69 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_83 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_95 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_99 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_124 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_135 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_157 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_185 ();
 sky130_fd_sc_hd__decap_8 FILLER_2_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_11 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_14 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_26 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_35 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_92 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_133 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_196 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_3 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_15 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_45 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_56 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_125 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_155 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_159 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_199 ();
 sky130_fd_sc_hd__decap_8 FILLER_4_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_11 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_14 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_92 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_120 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_142 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_196 ();
 sky130_ef_sc_hd__decap_12 FILLER_5_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_53 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_88 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_175 ();
 sky130_fd_sc_hd__decap_8 FILLER_6_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_11 ();
 sky130_fd_sc_hd__decap_4 FILLER_6_14 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_18 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_116 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_121 ();
 sky130_ef_sc_hd__decap_12 FILLER_7_3 ();
 sky130_fd_sc_hd__decap_8 FILLER_7_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_23 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_181 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_183 ();
 sky130_fd_sc_hd__decap_8 FILLER_8_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_11 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_34 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_64 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_168 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_79 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_155 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_35 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_55 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_148 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_49 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_75 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_79 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_129 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_54 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_138 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_196 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_79 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_125 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_195 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_142 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_75 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_44 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_120 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_142 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_53 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_199 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_53 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_88 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_92 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_116 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_155 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_168 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_199 ();
endmodule

