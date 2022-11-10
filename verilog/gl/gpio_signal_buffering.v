module gpio_signal_buffering (vccd,
    vssd,
    mgmt_io_in_buf,
    mgmt_io_in_unbuf,
    mgmt_io_oeb_buf,
    mgmt_io_oeb_unbuf,
    mgmt_io_out_buf,
    mgmt_io_out_unbuf);
 input vccd;
 input vssd;
 output [30:0] mgmt_io_in_buf;
 input [30:0] mgmt_io_in_unbuf;
 output [2:0] mgmt_io_oeb_buf;
 input [2:0] mgmt_io_oeb_unbuf;
 output [30:0] mgmt_io_out_buf;
 input [30:0] mgmt_io_out_unbuf;

 wire sky130_fd_sc_hd__buf_8_29__A;
 wire sky130_fd_sc_hd__buf_8_28__X;
 wire sky130_fd_sc_hd__buf_8_29__X;
 wire sky130_fd_sc_hd__buf_8_40__A;
 wire sky130_fd_sc_hd__buf_8_28__A;
 wire sky130_fd_sc_hd__buf_8_41__X;
 wire sky130_fd_sc_hd__buf_8_59__X;
 wire sky130_fd_sc_hd__buf_8_59__A;
 wire sky130_fd_sc_hd__buf_8_37__X;
 wire sky130_fd_sc_hd__buf_8_27__A;
 wire sky130_fd_sc_hd__buf_8_171__X;
 wire sky130_fd_sc_hd__buf_8_69__X;
 wire sky130_fd_sc_hd__buf_8_69__A;
 wire sky130_fd_sc_hd__buf_8_58__X;
 wire sky130_fd_sc_hd__buf_8_58__A;
 wire sky130_fd_sc_hd__buf_8_36__A;
 wire sky130_fd_sc_hd__buf_8_26__X;
 wire sky130_fd_sc_hd__buf_8_170__A;
 wire sky130_fd_sc_hd__buf_8_178__A;
 wire sky130_fd_sc_hd__buf_8_183__X;
 wire sky130_fd_sc_hd__buf_8_93__A;
 wire sky130_fd_sc_hd__buf_8_79__A;
 wire sky130_fd_sc_hd__buf_8_68__X;
 wire sky130_fd_sc_hd__buf_8_68__A;
 wire sky130_fd_sc_hd__buf_8_57__X;
 wire sky130_fd_sc_hd__buf_8_57__A;
 wire sky130_fd_sc_hd__buf_8_169__X;
 wire sky130_fd_sc_hd__buf_8_179__X;
 wire sky130_fd_sc_hd__buf_8_184__A;
 wire sky130_fd_sc_hd__buf_8_78__X;
 wire sky130_fd_sc_hd__buf_8_92__X;
 wire sky130_fd_sc_hd__buf_8_67__X;
 wire sky130_fd_sc_hd__buf_8_67__A;
 wire sky130_fd_sc_hd__buf_8_56__X;
 wire sky130_fd_sc_hd__buf_8_0__X;
 wire sky130_fd_sc_hd__buf_8_33__A;
 wire sky130_fd_sc_hd__buf_8_158__A;
 wire sky130_fd_sc_hd__buf_8_168__A;
 wire sky130_fd_sc_hd__buf_8_176__A;
 wire sky130_fd_sc_hd__buf_8_77__X;
 wire sky130_fd_sc_hd__buf_8_94__X;
 wire sky130_fd_sc_hd__buf_8_66__X;
 wire sky130_fd_sc_hd__buf_8_66__A;
 wire sky130_fd_sc_hd__buf_8_55__A;
 wire sky130_fd_sc_hd__buf_8_32__X;
 wire sky130_fd_sc_hd__buf_8_33__X;
 wire sky130_fd_sc_hd__buf_8_11__X;
 wire sky130_fd_sc_hd__buf_8_159__X;
 wire sky130_fd_sc_hd__buf_8_166__A;
 wire sky130_fd_sc_hd__buf_8_177__X;
 wire sky130_fd_sc_hd__buf_8_186__X;
 wire sky130_fd_sc_hd__buf_8_39__X;
 wire sky130_fd_sc_hd__buf_8_95__A;
 wire sky130_fd_sc_hd__buf_8_76__A;
 wire sky130_fd_sc_hd__buf_8_65__X;
 wire sky130_fd_sc_hd__buf_8_65__A;
 wire sky130_fd_sc_hd__buf_8_54__X;
 wire sky130_fd_sc_hd__buf_8_54__A;
 wire sky130_fd_sc_hd__buf_8_31__A;
 wire sky130_fd_sc_hd__buf_8_32__A;
 wire sky130_fd_sc_hd__buf_8_10__A;
 wire sky130_fd_sc_hd__buf_8_165__X;
 wire sky130_fd_sc_hd__buf_8_167__X;
 wire sky130_fd_sc_hd__buf_8_185__A;
 wire sky130_fd_sc_hd__buf_8_75__X;
 wire sky130_fd_sc_hd__buf_8_98__X;
 wire sky130_fd_sc_hd__buf_8_64__X;
 wire sky130_fd_sc_hd__buf_8_64__A;
 wire sky130_fd_sc_hd__buf_8_30__X;
 wire sky130_fd_sc_hd__buf_8_31__X;
 wire sky130_fd_sc_hd__buf_8_164__A;
 wire sky130_fd_sc_hd__buf_8_175__X;
 wire sky130_fd_sc_hd__buf_8_188__X;
 wire sky130_fd_sc_hd__buf_8_85__X;
 wire sky130_fd_sc_hd__buf_8_96__A;
 wire sky130_fd_sc_hd__buf_8_74__A;
 wire sky130_fd_sc_hd__buf_8_63__X;
 wire sky130_fd_sc_hd__buf_8_63__A;
 wire sky130_fd_sc_hd__buf_8_30__A;
 wire sky130_fd_sc_hd__buf_8_41__A;
 wire sky130_fd_sc_hd__buf_8_162__A;
 wire sky130_fd_sc_hd__buf_8_174__A;
 wire sky130_fd_sc_hd__buf_8_187__A;
 wire sky130_fd_sc_hd__buf_8_84__A;
 wire sky130_fd_sc_hd__buf_8_73__X;
 wire sky130_fd_sc_hd__buf_8_99__X;
 wire sky130_fd_sc_hd__buf_8_62__X;
 wire sky130_fd_sc_hd__buf_8_62__A;
 wire sky130_fd_sc_hd__buf_8_40__X;
 wire sky130_fd_sc_hd__buf_8_163__X;
 wire sky130_fd_sc_hd__buf_8_172__X;
 wire sky130_fd_sc_hd__buf_8_189__X;
 wire sky130_fd_sc_hd__buf_8_83__X;
 wire sky130_fd_sc_hd__buf_8_88__X;
 wire sky130_fd_sc_hd__buf_8_97__A;
 wire sky130_fd_sc_hd__buf_8_72__A;
 wire sky130_fd_sc_hd__buf_8_61__X;
 wire sky130_fd_sc_hd__buf_8_61__A;
 wire sky130_fd_sc_hd__buf_8_160__A;
 wire sky130_fd_sc_hd__buf_8_173__A;
 wire sky130_fd_sc_hd__buf_8_190__A;
 wire sky130_fd_sc_hd__buf_8_43__A;
 wire sky130_fd_sc_hd__buf_8_89__A;
 wire sky130_fd_sc_hd__buf_8_82__A;
 wire sky130_fd_sc_hd__buf_8_71__X;
 wire sky130_fd_sc_hd__buf_8_71__A;
 wire sky130_fd_sc_hd__buf_8_60__X;
 wire sky130_fd_sc_hd__buf_8_60__A;
 wire sky130_fd_sc_hd__buf_8_181__X;
 wire sky130_fd_sc_hd__buf_8_42__X;
 wire sky130_fd_sc_hd__buf_8_81__X;
 wire sky130_fd_sc_hd__buf_8_91__X;
 wire sky130_fd_sc_hd__buf_8_70__X;
 wire sky130_fd_sc_hd__buf_8_70__A;
 wire sky130_fd_sc_hd__buf_8_182__A;
 wire sky130_fd_sc_hd__buf_8_44__A;
 wire sky130_fd_sc_hd__buf_8_90__A;
 wire sky130_fd_sc_hd__buf_8_80__A;
 wire sky130_fd_sc_hd__buf_8_38__X;
 wire sky130_fd_sc_hd__buf_8_45__A;
 wire sky130_fd_sc_hd__buf_8_9__A;
 wire sky130_fd_sc_hd__buf_8_8__A;
 wire sky130_fd_sc_hd__buf_8_7__A;
 wire sky130_fd_sc_hd__buf_8_6__X;
 wire sky130_fd_sc_hd__buf_8_5__A;
 wire sky130_fd_sc_hd__buf_8_4__X;
 wire sky130_fd_sc_hd__buf_8_3__A;
 wire sky130_fd_sc_hd__buf_8_2__X;
 wire sky130_fd_sc_hd__buf_8_1__X;
 wire sky130_fd_sc_hd__buf_8_1__A;
 wire sky130_fd_sc_hd__buf_8_0__A;

 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_21 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_1 (.A(sky130_fd_sc_hd__buf_8_1__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_1__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_3 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_238 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_241 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_82 (.A(sky130_fd_sc_hd__buf_8_82__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_89__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_83 (.A(sky130_fd_sc_hd__buf_8_88__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_83__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_92 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_93 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_80 (.A(sky130_fd_sc_hd__buf_8_80__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_90__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_81 (.A(sky130_fd_sc_hd__buf_8_91__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_81__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_90 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_91 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_23 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_240 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_26 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_242 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_78 (.A(sky130_fd_sc_hd__buf_8_92__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_78__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_79 (.A(sky130_fd_sc_hd__buf_8_79__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_93__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_88 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_89 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_76 (.A(sky130_fd_sc_hd__buf_8_76__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_95__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_77 (.A(sky130_fd_sc_hd__buf_8_94__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_77__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_86 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_87 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_25 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_243 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_244 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_74 (.A(sky130_fd_sc_hd__buf_8_74__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_96__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_75 (.A(sky130_fd_sc_hd__buf_8_98__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_75__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_84 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_85 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_72 (.A(sky130_fd_sc_hd__buf_8_72__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_97__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_73 (.A(sky130_fd_sc_hd__buf_8_99__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_73__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_82 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_83 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_70 (.A(sky130_fd_sc_hd__buf_8_70__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_70__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_71 (.A(sky130_fd_sc_hd__buf_8_71__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_71__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_80 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_81 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_29 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_246 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_28 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_245 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_30 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_247 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_68 (.A(sky130_fd_sc_hd__buf_8_68__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_68__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_69 (.A(sky130_fd_sc_hd__buf_8_69__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_69__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_78 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_79 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_66 (.A(sky130_fd_sc_hd__buf_8_66__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_66__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_67 (.A(sky130_fd_sc_hd__buf_8_67__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_67__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_76 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_77 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_32 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_249 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_31 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_248 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_64 (.A(sky130_fd_sc_hd__buf_8_64__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_64__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_65 (.A(sky130_fd_sc_hd__buf_8_65__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_65__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_74 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_75 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_62 (.A(sky130_fd_sc_hd__buf_8_62__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_62__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_63 (.A(sky130_fd_sc_hd__buf_8_63__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_63__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_72 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_73 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_34 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_250 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_33 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_251 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_60 (.A(sky130_fd_sc_hd__buf_8_60__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_60__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_61 (.A(sky130_fd_sc_hd__buf_8_61__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_61__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_70 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_71 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_58 (.A(sky130_fd_sc_hd__buf_8_58__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_58__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_59 (.A(sky130_fd_sc_hd__buf_8_59__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_59__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_68 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_69 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_56 (.A(sky130_fd_sc_hd__buf_8_0__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_56__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_57 (.A(sky130_fd_sc_hd__buf_8_57__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_57__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_66 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_67 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_36 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_253 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_35 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_252 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_37 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_254 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_54 (.A(sky130_fd_sc_hd__buf_8_54__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_54__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_55 (.A(sky130_fd_sc_hd__buf_8_55__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[27]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_64 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_65 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_2 (.A(mgmt_io_in_unbuf[27]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_2__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_3 (.A(sky130_fd_sc_hd__buf_8_3__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[28]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_6 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_7 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_39 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_256 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_40 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_257 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_84 (.A(sky130_fd_sc_hd__buf_8_84__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[29]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_85 (.A(mgmt_io_in_unbuf[28]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_85__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_94 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_95 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_4 (.A(mgmt_io_in_unbuf[29]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_4__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_5 (.A(sky130_fd_sc_hd__buf_8_5__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[30]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_4 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_5 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_8 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_9 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_38 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_255 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_42 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_259 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_258 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_6 (.A(mgmt_io_in_unbuf[30]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_6__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_7 (.A(sky130_fd_sc_hd__buf_8_7__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_oeb_buf[0]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_10 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_11 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_8 (.A(sky130_fd_sc_hd__buf_8_8__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_oeb_buf[1]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_9 (.A(sky130_fd_sc_hd__buf_8_9__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_oeb_buf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_12 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_13 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_41 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_260 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_43 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_326 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_1 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_86 (.A(mgmt_io_out_unbuf[26]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_1__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_96 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_97 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_88 (.A(mgmt_io_out_unbuf[25]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_88__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_89 (.A(sky130_fd_sc_hd__buf_8_89__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[26]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_98 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_99 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_22 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_239 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_2 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_218 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_90 (.A(sky130_fd_sc_hd__buf_8_90__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[25]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_91 (.A(mgmt_io_out_unbuf[24]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_91__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_100 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_101 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_92 (.A(mgmt_io_out_unbuf[23]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_92__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_93 (.A(sky130_fd_sc_hd__buf_8_93__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[24]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_104 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_105 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_94 (.A(mgmt_io_out_unbuf[22]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_94__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_95 (.A(sky130_fd_sc_hd__buf_8_95__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[23]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_102 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_103 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_3 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_219 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_4 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_220 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_0 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_2 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_96 (.A(sky130_fd_sc_hd__buf_8_96__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[22]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_98 (.A(mgmt_io_out_unbuf[21]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_98__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_106 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_109 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_97 (.A(sky130_fd_sc_hd__buf_8_97__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[21]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_99 (.A(mgmt_io_out_unbuf[20]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_99__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_107 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_110 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_100 (.A(sky130_fd_sc_hd__buf_8_70__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[20]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_103 (.A(mgmt_io_out_unbuf[19]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_71__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_108 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_111 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_6 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_222 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_7 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_223 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_8 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_224 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_101 (.A(sky130_fd_sc_hd__buf_8_68__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[19]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_104 (.A(mgmt_io_out_unbuf[18]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_69__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_112 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_114 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_102 (.A(sky130_fd_sc_hd__buf_8_67__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[18]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_105 (.A(mgmt_io_out_unbuf[17]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_66__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_113 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_115 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_106 (.A(mgmt_io_out_unbuf[16]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_65__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_107 (.A(sky130_fd_sc_hd__buf_8_64__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[17]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_116 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_117 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_9 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_225 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_10 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_226 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_5 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_221 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_108 (.A(mgmt_io_out_unbuf[15]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_63__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_109 (.A(sky130_fd_sc_hd__buf_8_62__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[16]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_118 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_119 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_110 (.A(sky130_fd_sc_hd__buf_8_60__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[15]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_111 (.A(mgmt_io_out_unbuf[14]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_61__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_120 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_121 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_11 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_227 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_13 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_229 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_112 (.A(sky130_fd_sc_hd__buf_8_58__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[14]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_113 (.A(mgmt_io_out_unbuf[13]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_59__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_122 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_123 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_114 (.A(sky130_fd_sc_hd__buf_8_56__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[13]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_115 (.A(mgmt_io_out_unbuf[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_57__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_124 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_125 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_12 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_228 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_14 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_230 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_15 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_116 (.A(sky130_fd_sc_hd__buf_8_54__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[12]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_117 (.A(mgmt_io_out_unbuf[27]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_55__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_126 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_127 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_231 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_16 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_118 (.A(mgmt_io_out_unbuf[28]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_3__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_119 (.A(sky130_fd_sc_hd__buf_8_2__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[27]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_128 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_129 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_232 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_18 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_120 (.A(mgmt_io_out_unbuf[29]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_84__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_121 (.A(sky130_fd_sc_hd__buf_8_85__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[28]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_130 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_131 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_234 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_17 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_122 (.A(sky130_fd_sc_hd__buf_8_4__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[29]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_123 (.A(mgmt_io_out_unbuf[30]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_5__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_132 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_133 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_233 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_19 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_124 (.A(sky130_fd_sc_hd__buf_8_6__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[30]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_126 (.A(mgmt_io_oeb_unbuf[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_7__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_134 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_137 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_236 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_20 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_125 (.A(mgmt_io_oeb_unbuf[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_8__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_127 (.A(mgmt_io_oeb_unbuf[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_9__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_135 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_138 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_235 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_136 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_139 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_237 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_128 (.A(mgmt_io_in_unbuf[26]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_82__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_129 (.A(sky130_fd_sc_hd__buf_8_1__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[26]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_140 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_309 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_57 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_141 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_130 (.A(mgmt_io_in_unbuf[25]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_80__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_131 (.A(sky130_fd_sc_hd__buf_8_83__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[25]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_142 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_143 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_56 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_310 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_132 (.A(mgmt_io_in_unbuf[24]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_79__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_133 (.A(sky130_fd_sc_hd__buf_8_81__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[24]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_144 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_145 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_44 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_312 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_138 (.A(sky130_fd_sc_hd__buf_8_78__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[23]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_139 (.A(mgmt_io_in_unbuf[23]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_76__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_150 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_151 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_46 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_311 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_136 (.A(sky130_fd_sc_hd__buf_8_179__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_74__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_137 (.A(sky130_fd_sc_hd__buf_8_77__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_178__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_148 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_149 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_45 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_313 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_134 (.A(sky130_fd_sc_hd__buf_8_177__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_72__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_135 (.A(sky130_fd_sc_hd__buf_8_75__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_176__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_146 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_147 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_47 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_314 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_142 (.A(sky130_fd_sc_hd__buf_8_73__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_174__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_143 (.A(sky130_fd_sc_hd__buf_8_175__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_70__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_154 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_155 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_49 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_316 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_140 (.A(sky130_fd_sc_hd__buf_8_71__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_173__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_141 (.A(sky130_fd_sc_hd__buf_8_172__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_68__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_152 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_153 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_48 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_315 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_148 (.A(sky130_fd_sc_hd__buf_8_69__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_170__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_149 (.A(sky130_fd_sc_hd__buf_8_171__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_67__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_160 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_161 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_50 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_317 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_146 (.A(sky130_fd_sc_hd__buf_8_66__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_168__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_147 (.A(sky130_fd_sc_hd__buf_8_169__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_64__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_158 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_159 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_51 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_318 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_144 (.A(sky130_fd_sc_hd__buf_8_167__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_62__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_145 (.A(sky130_fd_sc_hd__buf_8_65__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_166__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_156 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_157 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_53 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_320 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_154 (.A(sky130_fd_sc_hd__buf_8_63__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_164__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_155 (.A(sky130_fd_sc_hd__buf_8_165__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_60__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_166 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_167 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_52 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_319 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_152 (.A(sky130_fd_sc_hd__buf_8_163__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_58__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_153 (.A(sky130_fd_sc_hd__buf_8_61__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_162__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_164 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_165 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_100 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_162 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_0 (.A(sky130_fd_sc_hd__buf_8_0__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_0__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_151 (.A(sky130_fd_sc_hd__buf_8_59__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_160__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_163 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_323 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_54 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_321 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_156 (.A(sky130_fd_sc_hd__buf_8_159__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_54__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_157 (.A(sky130_fd_sc_hd__buf_8_57__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_158__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_170 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_171 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_55 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_322 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_168 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_169 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_324 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_98 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_12 (.A(mgmt_io_out_unbuf[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[0]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_13 (.A(mgmt_io_in_unbuf[0]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[0]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_53 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_261 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_262 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_99 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_52 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_46 (.A(mgmt_io_in_unbuf[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[1]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_55 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_47 (.A(mgmt_io_out_unbuf[1]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[1]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_54 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_96 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_264 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_49 (.A(mgmt_io_in_unbuf[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_57 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_48 (.A(mgmt_io_out_unbuf[2]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_56 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_97 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_263 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_51 (.A(mgmt_io_in_unbuf[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[3]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_59 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_50 (.A(mgmt_io_out_unbuf[3]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[3]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_58 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_265 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_61 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_60 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_95 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_267 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_53 (.A(mgmt_io_in_unbuf[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[4]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_63 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_52 (.A(mgmt_io_out_unbuf[4]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[4]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_62 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_93 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_266 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_34 (.A(mgmt_io_in_unbuf[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[5]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_38 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_35 (.A(mgmt_io_out_unbuf[5]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[5]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_39 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_94 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_269 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_36 (.A(sky130_fd_sc_hd__buf_8_36__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[6]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_16 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_37 (.A(mgmt_io_out_unbuf[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_37__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_17 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_91 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_14 (.A(sky130_fd_sc_hd__buf_8_26__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[7]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_15 (.A(mgmt_io_out_unbuf[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_27__A));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_92 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_18 (.A(sky130_fd_sc_hd__buf_8_28__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[8]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_19 (.A(mgmt_io_out_unbuf[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_29__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_20 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_21 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_268 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_89 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_20 (.A(sky130_fd_sc_hd__buf_8_30__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[9]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_21 (.A(mgmt_io_out_unbuf[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_31__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_22 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_23 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_271 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_90 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_16 (.A(sky130_fd_sc_hd__buf_8_41__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[10]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_17 (.A(mgmt_io_out_unbuf[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_40__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_18 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_19 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_270 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_88 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_22 (.A(sky130_fd_sc_hd__buf_8_32__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_in_buf[11]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_23 (.A(mgmt_io_out_unbuf[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_33__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_24 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_25 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_325 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_26 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_27 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_273 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_68 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_178 (.A(sky130_fd_sc_hd__buf_8_178__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[22]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_179 (.A(mgmt_io_in_unbuf[22]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_179__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_194 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_195 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_297 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_67 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_176 (.A(sky130_fd_sc_hd__buf_8_176__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[21]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_177 (.A(mgmt_io_in_unbuf[21]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_177__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_190 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_192 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_299 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_65 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_174 (.A(sky130_fd_sc_hd__buf_8_174__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[20]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_175 (.A(mgmt_io_in_unbuf[20]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_175__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_191 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_193 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_298 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_66 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_172 (.A(mgmt_io_in_unbuf[19]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_172__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_173 (.A(sky130_fd_sc_hd__buf_8_173__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[19]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_188 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_189 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_300 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_63 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_170 (.A(sky130_fd_sc_hd__buf_8_170__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[18]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_171 (.A(mgmt_io_in_unbuf[18]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_171__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_186 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_187 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_302 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_64 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_168 (.A(sky130_fd_sc_hd__buf_8_168__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[17]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_169 (.A(mgmt_io_in_unbuf[17]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_169__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_184 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_185 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_301 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_61 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_166 (.A(sky130_fd_sc_hd__buf_8_166__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_185__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_167 (.A(sky130_fd_sc_hd__buf_8_186__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_167__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_182 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_183 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_304 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_62 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_164 (.A(sky130_fd_sc_hd__buf_8_164__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_187__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_165 (.A(sky130_fd_sc_hd__buf_8_188__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_165__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_180 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_181 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_303 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_59 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_162 (.A(sky130_fd_sc_hd__buf_8_162__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_190__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_163 (.A(sky130_fd_sc_hd__buf_8_189__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_163__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_178 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_179 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_306 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_60 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_160 (.A(sky130_fd_sc_hd__buf_8_160__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_182__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_161 (.A(sky130_fd_sc_hd__buf_8_181__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_0__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_176 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_177 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_305 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_58 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_158 (.A(sky130_fd_sc_hd__buf_8_158__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_184__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_159 (.A(sky130_fd_sc_hd__buf_8_183__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_159__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_174 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_175 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_308 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_172 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_173 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_307 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_28 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_274 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_272 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_86 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_25 (.A(mgmt_io_in_unbuf[6]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_36__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_29 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_275 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_24 (.A(sky130_fd_sc_hd__buf_8_37__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[6]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_1 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_85 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_26 (.A(mgmt_io_in_unbuf[7]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_26__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_27 (.A(sky130_fd_sc_hd__buf_8_27__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[7]));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_87 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_28 (.A(sky130_fd_sc_hd__buf_8_28__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_28__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_0 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_30 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_29 (.A(sky130_fd_sc_hd__buf_8_29__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_29__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_31 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_83 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_30 (.A(sky130_fd_sc_hd__buf_8_30__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_30__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_32 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_277 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_31 (.A(sky130_fd_sc_hd__buf_8_31__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_31__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_33 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_82 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_41 (.A(sky130_fd_sc_hd__buf_8_41__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_41__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_34 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_278 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_40 (.A(sky130_fd_sc_hd__buf_8_40__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_40__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_35 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_84 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_32 (.A(sky130_fd_sc_hd__buf_8_32__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_32__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_45 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_276 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_33 (.A(sky130_fd_sc_hd__buf_8_33__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_33__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_44 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_36 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_279 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_37 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_200 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_201 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_291 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_73 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_185 (.A(sky130_fd_sc_hd__buf_8_185__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[16]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_186 (.A(mgmt_io_in_unbuf[16]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_186__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_202 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_203 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_292 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_72 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_187 (.A(sky130_fd_sc_hd__buf_8_187__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[15]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_188 (.A(mgmt_io_in_unbuf[15]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_188__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_204 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_205 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_293 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_71 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_189 (.A(sky130_fd_sc_hd__buf_8_39__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_189__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_190 (.A(sky130_fd_sc_hd__buf_8_190__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_45__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_206 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_207 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_294 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_70 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_181 (.A(sky130_fd_sc_hd__buf_8_38__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_181__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_182 (.A(sky130_fd_sc_hd__buf_8_182__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_44__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_196 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_197 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_296 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_69 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_183 (.A(sky130_fd_sc_hd__buf_8_42__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_183__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_184 (.A(sky130_fd_sc_hd__buf_8_184__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_43__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_198 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_199 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_295 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_75 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_76 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_51 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_288 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_74 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_289 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_290 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_38 (.A(mgmt_io_in_unbuf[13]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_38__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_39 (.A(mgmt_io_in_unbuf[14]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_39__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_44 (.A(sky130_fd_sc_hd__buf_8_44__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[13]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_45 (.A(sky130_fd_sc_hd__buf_8_45__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[14]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_48 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_49 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_50 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_287 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_42 (.A(mgmt_io_in_unbuf[12]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_42__X));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_43 (.A(sky130_fd_sc_hd__buf_8_43__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[12]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_42 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_43 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_46 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_47 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_77 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_10 (.A(sky130_fd_sc_hd__buf_8_10__A),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[11]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_11 (.A(mgmt_io_in_unbuf[11]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_11__X));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_14 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_15 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_40 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_41 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_285 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_286 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_81 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_180 (.A(sky130_fd_sc_hd__buf_8_11__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_32__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_194 (.A(sky130_fd_sc_hd__buf_8_33__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_10__A));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_208 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_212 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_280 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_78 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_80 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_281 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_283 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_191 (.A(mgmt_io_in_unbuf[10]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_41__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_192 (.A(mgmt_io_in_unbuf[9]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_30__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_195 (.A(sky130_fd_sc_hd__buf_8_40__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[10]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_196 (.A(sky130_fd_sc_hd__buf_8_31__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[9]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_209 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_210 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_213 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_214 (.VGND(vssd),
    .VPWR(vccd));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_79 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_193 (.A(mgmt_io_in_unbuf[8]),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(sky130_fd_sc_hd__buf_8_28__A));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_197 (.A(sky130_fd_sc_hd__buf_8_29__X),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(mgmt_io_out_buf[8]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_211 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_215 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_216 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_217 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_282 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_284 (.VGND(vssd),
    .VPWR(vccd));
endmodule
