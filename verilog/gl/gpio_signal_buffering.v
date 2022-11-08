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
 input [2:0] mgmt_io_oeb_unbuf;
 input [30:0] mgmt_io_in_unbuf;
 input [30:0] mgmt_io_out_unbuf;
 output [2:0] mgmt_io_oeb_buf;
 output [30:0] mgmt_io_in_buf;
 output [30:0] mgmt_io_out_buf;

 wire \sky130_fd_sc_hd__buf_8_29/A ;
 wire \sky130_fd_sc_hd__buf_8_28/X ;
 wire \sky130_fd_sc_hd__buf_8_29/X ;
 wire \sky130_fd_sc_hd__buf_8_40/A ;
 wire \sky130_fd_sc_hd__buf_8_28/A ;
 wire \sky130_fd_sc_hd__buf_8_41/X ;
 wire \sky130_fd_sc_hd__buf_8_59/X ;
 wire \sky130_fd_sc_hd__buf_8_59/A ;
 wire \sky130_fd_sc_hd__buf_8_37/X ;
 wire \sky130_fd_sc_hd__buf_8_27/A ;
 wire \sky130_fd_sc_hd__buf_8_171/X ;
 wire \sky130_fd_sc_hd__buf_8_69/X ;
 wire \sky130_fd_sc_hd__buf_8_69/A ;
 wire \sky130_fd_sc_hd__buf_8_58/X ;
 wire \sky130_fd_sc_hd__buf_8_58/A ;
 wire \sky130_fd_sc_hd__buf_8_36/A ;
 wire \sky130_fd_sc_hd__buf_8_26/X ;
 wire \sky130_fd_sc_hd__buf_8_170/A ;
 wire \sky130_fd_sc_hd__buf_8_178/A ;
 wire \sky130_fd_sc_hd__buf_8_183/X ;
 wire \sky130_fd_sc_hd__buf_8_93/A ;
 wire \sky130_fd_sc_hd__buf_8_79/A ;
 wire \sky130_fd_sc_hd__buf_8_68/X ;
 wire \sky130_fd_sc_hd__buf_8_68/A ;
 wire \sky130_fd_sc_hd__buf_8_57/X ;
 wire \sky130_fd_sc_hd__buf_8_57/A ;
 wire \sky130_fd_sc_hd__buf_8_169/X ;
 wire \sky130_fd_sc_hd__buf_8_179/X ;
 wire \sky130_fd_sc_hd__buf_8_184/A ;
 wire \sky130_fd_sc_hd__buf_8_78/X ;
 wire \sky130_fd_sc_hd__buf_8_92/X ;
 wire \sky130_fd_sc_hd__buf_8_67/X ;
 wire \sky130_fd_sc_hd__buf_8_67/A ;
 wire \sky130_fd_sc_hd__buf_8_56/X ;
 wire \sky130_fd_sc_hd__buf_8_0/X ;
 wire \sky130_fd_sc_hd__buf_8_33/A ;
 wire \sky130_fd_sc_hd__buf_8_158/A ;
 wire \sky130_fd_sc_hd__buf_8_168/A ;
 wire \sky130_fd_sc_hd__buf_8_176/A ;
 wire \sky130_fd_sc_hd__buf_8_77/X ;
 wire \sky130_fd_sc_hd__buf_8_94/X ;
 wire \sky130_fd_sc_hd__buf_8_66/X ;
 wire \sky130_fd_sc_hd__buf_8_66/A ;
 wire \sky130_fd_sc_hd__buf_8_55/A ;
 wire \sky130_fd_sc_hd__buf_8_32/X ;
 wire \sky130_fd_sc_hd__buf_8_33/X ;
 wire \sky130_fd_sc_hd__buf_8_11/X ;
 wire \sky130_fd_sc_hd__buf_8_159/X ;
 wire \sky130_fd_sc_hd__buf_8_166/A ;
 wire \sky130_fd_sc_hd__buf_8_177/X ;
 wire \sky130_fd_sc_hd__buf_8_186/X ;
 wire \sky130_fd_sc_hd__buf_8_39/X ;
 wire \sky130_fd_sc_hd__buf_8_95/A ;
 wire \sky130_fd_sc_hd__buf_8_76/A ;
 wire \sky130_fd_sc_hd__buf_8_65/X ;
 wire \sky130_fd_sc_hd__buf_8_65/A ;
 wire \sky130_fd_sc_hd__buf_8_54/X ;
 wire \sky130_fd_sc_hd__buf_8_54/A ;
 wire \sky130_fd_sc_hd__buf_8_31/A ;
 wire \sky130_fd_sc_hd__buf_8_32/A ;
 wire \sky130_fd_sc_hd__buf_8_10/A ;
 wire \sky130_fd_sc_hd__buf_8_165/X ;
 wire \sky130_fd_sc_hd__buf_8_167/X ;
 wire \sky130_fd_sc_hd__buf_8_185/A ;
 wire \sky130_fd_sc_hd__buf_8_75/X ;
 wire \sky130_fd_sc_hd__buf_8_98/X ;
 wire \sky130_fd_sc_hd__buf_8_64/X ;
 wire \sky130_fd_sc_hd__buf_8_64/A ;
 wire \sky130_fd_sc_hd__buf_8_30/X ;
 wire \sky130_fd_sc_hd__buf_8_31/X ;
 wire \sky130_fd_sc_hd__buf_8_164/A ;
 wire \sky130_fd_sc_hd__buf_8_175/X ;
 wire \sky130_fd_sc_hd__buf_8_188/X ;
 wire \sky130_fd_sc_hd__buf_8_85/X ;
 wire \sky130_fd_sc_hd__buf_8_96/A ;
 wire \sky130_fd_sc_hd__buf_8_74/A ;
 wire \sky130_fd_sc_hd__buf_8_63/X ;
 wire \sky130_fd_sc_hd__buf_8_63/A ;
 wire \sky130_fd_sc_hd__buf_8_30/A ;
 wire \sky130_fd_sc_hd__buf_8_41/A ;
 wire \sky130_fd_sc_hd__buf_8_162/A ;
 wire \sky130_fd_sc_hd__buf_8_174/A ;
 wire \sky130_fd_sc_hd__buf_8_187/A ;
 wire \sky130_fd_sc_hd__buf_8_84/A ;
 wire \sky130_fd_sc_hd__buf_8_73/X ;
 wire \sky130_fd_sc_hd__buf_8_99/X ;
 wire \sky130_fd_sc_hd__buf_8_62/X ;
 wire \sky130_fd_sc_hd__buf_8_62/A ;
 wire \sky130_fd_sc_hd__buf_8_40/X ;
 wire \sky130_fd_sc_hd__buf_8_163/X ;
 wire \sky130_fd_sc_hd__buf_8_172/X ;
 wire \sky130_fd_sc_hd__buf_8_189/X ;
 wire \sky130_fd_sc_hd__buf_8_83/X ;
 wire \sky130_fd_sc_hd__buf_8_88/X ;
 wire \sky130_fd_sc_hd__buf_8_97/A ;
 wire \sky130_fd_sc_hd__buf_8_72/A ;
 wire \sky130_fd_sc_hd__buf_8_61/X ;
 wire \sky130_fd_sc_hd__buf_8_61/A ;
 wire \sky130_fd_sc_hd__buf_8_160/A ;
 wire \sky130_fd_sc_hd__buf_8_173/A ;
 wire \sky130_fd_sc_hd__buf_8_190/A ;
 wire \sky130_fd_sc_hd__buf_8_43/A ;
 wire \sky130_fd_sc_hd__buf_8_89/A ;
 wire \sky130_fd_sc_hd__buf_8_82/A ;
 wire \sky130_fd_sc_hd__buf_8_71/X ;
 wire \sky130_fd_sc_hd__buf_8_71/A ;
 wire \sky130_fd_sc_hd__buf_8_60/X ;
 wire \sky130_fd_sc_hd__buf_8_60/A ;
 wire \sky130_fd_sc_hd__buf_8_0/A ;

 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_21 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_24 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_1 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_3 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_238 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_241 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_82 (.A(\sky130_fd_sc_hd__buf_8_82/A ),
    .X(\sky130_fd_sc_hd__buf_8_89/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_83 (.A(\sky130_fd_sc_hd__buf_8_88/X ),
    .X(\sky130_fd_sc_hd__buf_8_83/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_93 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_80 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_91 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_23 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_240 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_26 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_242 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_78 (.A(\sky130_fd_sc_hd__buf_8_92/X ),
    .X(\sky130_fd_sc_hd__buf_8_78/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_79 (.A(\sky130_fd_sc_hd__buf_8_79/A ),
    .X(\sky130_fd_sc_hd__buf_8_93/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_89 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_76 (.A(\sky130_fd_sc_hd__buf_8_76/A ),
    .X(\sky130_fd_sc_hd__buf_8_95/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_77 (.A(\sky130_fd_sc_hd__buf_8_94/X ),
    .X(\sky130_fd_sc_hd__buf_8_77/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_87 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_25 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_243 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_27 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_244 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_74 (.A(\sky130_fd_sc_hd__buf_8_74/A ),
    .X(\sky130_fd_sc_hd__buf_8_96/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_75 (.A(\sky130_fd_sc_hd__buf_8_98/X ),
    .X(\sky130_fd_sc_hd__buf_8_75/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_85 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_72 (.A(\sky130_fd_sc_hd__buf_8_72/A ),
    .X(\sky130_fd_sc_hd__buf_8_97/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_73 (.A(\sky130_fd_sc_hd__buf_8_99/X ),
    .X(\sky130_fd_sc_hd__buf_8_73/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_83 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_70 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_71 (.A(\sky130_fd_sc_hd__buf_8_71/A ),
    .X(\sky130_fd_sc_hd__buf_8_71/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_81 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_29 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_246 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_28 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_245 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_30 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_247 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_68 (.A(\sky130_fd_sc_hd__buf_8_68/A ),
    .X(\sky130_fd_sc_hd__buf_8_68/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_69 (.A(\sky130_fd_sc_hd__buf_8_69/A ),
    .X(\sky130_fd_sc_hd__buf_8_69/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_79 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_66 (.A(\sky130_fd_sc_hd__buf_8_66/A ),
    .X(\sky130_fd_sc_hd__buf_8_66/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_67 (.A(\sky130_fd_sc_hd__buf_8_67/A ),
    .X(\sky130_fd_sc_hd__buf_8_67/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_77 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_32 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_249 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_31 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_248 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_64 (.A(\sky130_fd_sc_hd__buf_8_64/A ),
    .X(\sky130_fd_sc_hd__buf_8_64/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_65 (.A(\sky130_fd_sc_hd__buf_8_65/A ),
    .X(\sky130_fd_sc_hd__buf_8_65/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_75 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_62 (.A(\sky130_fd_sc_hd__buf_8_62/A ),
    .X(\sky130_fd_sc_hd__buf_8_62/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_63 (.A(\sky130_fd_sc_hd__buf_8_63/A ),
    .X(\sky130_fd_sc_hd__buf_8_63/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_73 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_250 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_251 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_60 (.A(\sky130_fd_sc_hd__buf_8_60/A ),
    .X(\sky130_fd_sc_hd__buf_8_60/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_61 (.A(\sky130_fd_sc_hd__buf_8_61/A ),
    .X(\sky130_fd_sc_hd__buf_8_61/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_71 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_58 (.A(\sky130_fd_sc_hd__buf_8_58/A ),
    .X(\sky130_fd_sc_hd__buf_8_58/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_59 (.A(\sky130_fd_sc_hd__buf_8_59/A ),
    .X(\sky130_fd_sc_hd__buf_8_59/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_69 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_56 (.A(\sky130_fd_sc_hd__buf_8_0/X ),
    .X(\sky130_fd_sc_hd__buf_8_56/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_57 (.A(\sky130_fd_sc_hd__buf_8_57/A ),
    .X(\sky130_fd_sc_hd__buf_8_57/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_67 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_253 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_252 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_254 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_54 (.A(\sky130_fd_sc_hd__buf_8_54/A ),
    .X(\sky130_fd_sc_hd__buf_8_54/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_55 (.A(\sky130_fd_sc_hd__buf_8_55/A ),
    .X(mgmt_io_out_buf[27]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_65 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_2 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_3 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_6 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_7 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_256 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_257 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_84 (.A(\sky130_fd_sc_hd__buf_8_84/A ),
    .X(mgmt_io_out_buf[29]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_85 (.A(mgmt_io_in_unbuf[28]),
    .X(\sky130_fd_sc_hd__buf_8_85/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_95 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_4 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_5 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_4 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_5 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_8 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_9 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_255 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_259 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_258 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_6 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_7 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_10 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_11 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_8 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_12 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_13 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_260 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_326 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_1 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_86 (.A(mgmt_io_out_unbuf[26]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_97 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_88 (.A(mgmt_io_out_unbuf[25]),
    .X(\sky130_fd_sc_hd__buf_8_88/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_89 (.A(\sky130_fd_sc_hd__buf_8_89/A ),
    .X(mgmt_io_in_buf[26]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_99 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_22 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_239 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_2 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_218 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_90 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_101 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_92 (.X(\sky130_fd_sc_hd__buf_8_92/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_93 (.A(\sky130_fd_sc_hd__buf_8_93/A ),
    .X(mgmt_io_in_buf[24]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_105 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_94 (.A(mgmt_io_out_unbuf[22]),
    .X(\sky130_fd_sc_hd__buf_8_94/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_95 (.A(\sky130_fd_sc_hd__buf_8_95/A ),
    .X(mgmt_io_in_buf[23]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_103 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_3 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_219 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_4 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_220 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_0 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_2 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_96 (.A(\sky130_fd_sc_hd__buf_8_96/A ),
    .X(mgmt_io_in_buf[22]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_98 (.A(mgmt_io_out_unbuf[21]),
    .X(\sky130_fd_sc_hd__buf_8_98/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_109 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_97 (.A(\sky130_fd_sc_hd__buf_8_97/A ),
    .X(mgmt_io_in_buf[21]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_99 (.A(mgmt_io_out_unbuf[20]),
    .X(\sky130_fd_sc_hd__buf_8_99/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_110 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_100 (.X(mgmt_io_in_buf[20]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_103 (.A(mgmt_io_out_unbuf[19]),
    .X(\sky130_fd_sc_hd__buf_8_71/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_111 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_6 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_222 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_7 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_223 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_8 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_224 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_101 (.A(\sky130_fd_sc_hd__buf_8_68/X ),
    .X(mgmt_io_in_buf[19]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_104 (.A(mgmt_io_out_unbuf[18]),
    .X(\sky130_fd_sc_hd__buf_8_69/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_114 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_102 (.A(\sky130_fd_sc_hd__buf_8_67/X ),
    .X(mgmt_io_in_buf[18]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_105 (.A(mgmt_io_out_unbuf[17]),
    .X(\sky130_fd_sc_hd__buf_8_66/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_115 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_106 (.A(mgmt_io_out_unbuf[16]),
    .X(\sky130_fd_sc_hd__buf_8_65/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_107 (.A(\sky130_fd_sc_hd__buf_8_64/X ),
    .X(mgmt_io_in_buf[17]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_117 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_225 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_10 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_226 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_5 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_221 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_108 (.A(mgmt_io_out_unbuf[15]),
    .X(\sky130_fd_sc_hd__buf_8_63/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_109 (.A(\sky130_fd_sc_hd__buf_8_62/X ),
    .X(mgmt_io_in_buf[16]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_119 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_110 (.A(\sky130_fd_sc_hd__buf_8_60/X ),
    .X(mgmt_io_in_buf[15]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_111 (.A(mgmt_io_out_unbuf[14]),
    .X(\sky130_fd_sc_hd__buf_8_61/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_121 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_11 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_227 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_13 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_229 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_112 (.A(\sky130_fd_sc_hd__buf_8_58/X ),
    .X(mgmt_io_in_buf[14]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_113 (.A(mgmt_io_out_unbuf[13]),
    .X(\sky130_fd_sc_hd__buf_8_59/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_123 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_114 (.A(\sky130_fd_sc_hd__buf_8_56/X ),
    .X(mgmt_io_in_buf[13]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_115 (.A(mgmt_io_out_unbuf[12]),
    .X(\sky130_fd_sc_hd__buf_8_57/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_125 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_12 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_228 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_14 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_230 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_15 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_116 (.A(\sky130_fd_sc_hd__buf_8_54/X ),
    .X(mgmt_io_in_buf[12]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_117 (.A(mgmt_io_out_unbuf[27]),
    .X(\sky130_fd_sc_hd__buf_8_55/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_231 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_16 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_118 (.A(mgmt_io_out_unbuf[28]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_119 (.X(mgmt_io_in_buf[27]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_232 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_18 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_120 (.A(mgmt_io_out_unbuf[29]),
    .X(\sky130_fd_sc_hd__buf_8_84/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_121 (.A(\sky130_fd_sc_hd__buf_8_85/X ),
    .X(mgmt_io_in_buf[28]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_234 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_17 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_122 (.X(mgmt_io_in_buf[29]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_123 (.A(mgmt_io_out_unbuf[30]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_233 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_19 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_124 (.X(mgmt_io_in_buf[30]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_126 (.A(mgmt_io_oeb_unbuf[0]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_236 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_20 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_125 (.A(mgmt_io_oeb_unbuf[1]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_127 (.A(mgmt_io_oeb_unbuf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_235 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_237 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_128 (.A(mgmt_io_in_unbuf[26]),
    .X(\sky130_fd_sc_hd__buf_8_82/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_129 (.X(mgmt_io_out_buf[26]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_309 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_141 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_130 (.A(mgmt_io_in_unbuf[25]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_131 (.A(\sky130_fd_sc_hd__buf_8_83/X ),
    .X(mgmt_io_out_buf[25]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_143 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_310 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_132 (.A(mgmt_io_in_unbuf[24]),
    .X(\sky130_fd_sc_hd__buf_8_79/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_133 (.X(mgmt_io_out_buf[24]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_145 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_312 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_138 (.A(\sky130_fd_sc_hd__buf_8_78/X ),
    .X(mgmt_io_out_buf[23]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_139 (.A(mgmt_io_in_unbuf[23]),
    .X(\sky130_fd_sc_hd__buf_8_76/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_151 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_311 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_136 (.A(\sky130_fd_sc_hd__buf_8_179/X ),
    .X(\sky130_fd_sc_hd__buf_8_74/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_137 (.A(\sky130_fd_sc_hd__buf_8_77/X ),
    .X(\sky130_fd_sc_hd__buf_8_178/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_149 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_313 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_134 (.A(\sky130_fd_sc_hd__buf_8_177/X ),
    .X(\sky130_fd_sc_hd__buf_8_72/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_135 (.A(\sky130_fd_sc_hd__buf_8_75/X ),
    .X(\sky130_fd_sc_hd__buf_8_176/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_147 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_314 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_142 (.A(\sky130_fd_sc_hd__buf_8_73/X ),
    .X(\sky130_fd_sc_hd__buf_8_174/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_143 (.A(\sky130_fd_sc_hd__buf_8_175/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_155 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_316 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_140 (.A(\sky130_fd_sc_hd__buf_8_71/X ),
    .X(\sky130_fd_sc_hd__buf_8_173/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_141 (.A(\sky130_fd_sc_hd__buf_8_172/X ),
    .X(\sky130_fd_sc_hd__buf_8_68/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_153 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_315 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_148 (.A(\sky130_fd_sc_hd__buf_8_69/X ),
    .X(\sky130_fd_sc_hd__buf_8_170/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_149 (.A(\sky130_fd_sc_hd__buf_8_171/X ),
    .X(\sky130_fd_sc_hd__buf_8_67/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_161 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_317 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_146 (.A(\sky130_fd_sc_hd__buf_8_66/X ),
    .X(\sky130_fd_sc_hd__buf_8_168/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_147 (.A(\sky130_fd_sc_hd__buf_8_169/X ),
    .X(\sky130_fd_sc_hd__buf_8_64/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_159 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_318 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_144 (.A(\sky130_fd_sc_hd__buf_8_167/X ),
    .X(\sky130_fd_sc_hd__buf_8_62/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_145 (.A(\sky130_fd_sc_hd__buf_8_65/X ),
    .X(\sky130_fd_sc_hd__buf_8_166/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_157 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_320 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_154 (.A(\sky130_fd_sc_hd__buf_8_63/X ),
    .X(\sky130_fd_sc_hd__buf_8_164/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_155 (.A(\sky130_fd_sc_hd__buf_8_165/X ),
    .X(\sky130_fd_sc_hd__buf_8_60/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_167 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_319 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_152 (.A(\sky130_fd_sc_hd__buf_8_163/X ),
    .X(\sky130_fd_sc_hd__buf_8_58/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_153 (.A(\sky130_fd_sc_hd__buf_8_61/X ),
    .X(\sky130_fd_sc_hd__buf_8_162/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_165 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_162 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_0 (.A(\sky130_fd_sc_hd__buf_8_0/A ),
    .X(\sky130_fd_sc_hd__buf_8_0/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_151 (.A(\sky130_fd_sc_hd__buf_8_59/X ),
    .X(\sky130_fd_sc_hd__buf_8_160/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_323 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_321 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_156 (.A(\sky130_fd_sc_hd__buf_8_159/X ),
    .X(\sky130_fd_sc_hd__buf_8_54/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_157 (.A(\sky130_fd_sc_hd__buf_8_57/X ),
    .X(\sky130_fd_sc_hd__buf_8_158/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_171 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_322 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_324 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_98 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_12 (.A(mgmt_io_out_unbuf[0]),
    .X(mgmt_io_out_buf[0]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_13 (.A(mgmt_io_in_unbuf[0]),
    .X(mgmt_io_in_buf[0]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_261 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_262 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_52 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_46 (.A(mgmt_io_in_unbuf[1]),
    .X(mgmt_io_in_buf[1]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_55 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_47 (.A(mgmt_io_out_unbuf[1]),
    .X(mgmt_io_out_buf[1]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_54 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_264 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_49 (.A(mgmt_io_in_unbuf[2]),
    .X(mgmt_io_in_buf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_57 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_48 (.A(mgmt_io_out_unbuf[2]),
    .X(mgmt_io_out_buf[2]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_56 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_263 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_51 (.A(mgmt_io_in_unbuf[3]),
    .X(mgmt_io_in_buf[3]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_59 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_50 (.A(mgmt_io_out_unbuf[3]),
    .X(mgmt_io_out_buf[3]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_265 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_60 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_267 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_53 (.A(mgmt_io_in_unbuf[4]),
    .X(mgmt_io_in_buf[4]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_63 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_52 (.A(mgmt_io_out_unbuf[4]),
    .X(mgmt_io_out_buf[4]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_62 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_266 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_34 (.A(mgmt_io_in_unbuf[5]),
    .X(mgmt_io_in_buf[5]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_38 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_35 (.A(mgmt_io_out_unbuf[5]),
    .X(mgmt_io_out_buf[5]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_39 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_269 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_36 (.A(\sky130_fd_sc_hd__buf_8_36/A ),
    .X(mgmt_io_in_buf[6]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_16 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_37 (.A(mgmt_io_out_unbuf[6]),
    .X(\sky130_fd_sc_hd__buf_8_37/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_17 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_91 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_14 (.A(\sky130_fd_sc_hd__buf_8_26/X ),
    .X(mgmt_io_in_buf[7]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_15 (.A(mgmt_io_out_unbuf[7]),
    .X(\sky130_fd_sc_hd__buf_8_27/A ));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_92 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_18 (.A(\sky130_fd_sc_hd__buf_8_28/X ),
    .X(mgmt_io_in_buf[8]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_19 (.A(mgmt_io_out_unbuf[8]),
    .X(\sky130_fd_sc_hd__buf_8_29/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_20 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_21 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_268 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_89 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_20 (.A(\sky130_fd_sc_hd__buf_8_30/X ),
    .X(mgmt_io_in_buf[9]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_21 (.A(mgmt_io_out_unbuf[9]),
    .X(\sky130_fd_sc_hd__buf_8_31/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_22 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_23 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_271 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_90 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_16 (.A(\sky130_fd_sc_hd__buf_8_41/X ),
    .X(mgmt_io_in_buf[10]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_17 (.A(mgmt_io_out_unbuf[10]),
    .X(\sky130_fd_sc_hd__buf_8_40/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_18 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_19 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_270 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_88 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_22 (.A(\sky130_fd_sc_hd__buf_8_32/X ),
    .X(mgmt_io_in_buf[11]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_23 (.A(mgmt_io_out_unbuf[11]),
    .X(\sky130_fd_sc_hd__buf_8_33/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_24 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_25 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_325 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_26 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_27 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_273 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_68 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_178 (.A(\sky130_fd_sc_hd__buf_8_178/A ),
    .X(mgmt_io_out_buf[22]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_179 (.A(mgmt_io_in_unbuf[22]),
    .X(\sky130_fd_sc_hd__buf_8_179/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_194 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_195 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_297 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_67 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_176 (.A(\sky130_fd_sc_hd__buf_8_176/A ),
    .X(mgmt_io_out_buf[21]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_177 (.A(mgmt_io_in_unbuf[21]),
    .X(\sky130_fd_sc_hd__buf_8_177/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_299 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_65 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_174 (.A(\sky130_fd_sc_hd__buf_8_174/A ),
    .X(mgmt_io_out_buf[20]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_175 (.A(mgmt_io_in_unbuf[20]),
    .X(\sky130_fd_sc_hd__buf_8_175/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_298 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_66 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_172 (.X(\sky130_fd_sc_hd__buf_8_172/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_173 (.A(\sky130_fd_sc_hd__buf_8_173/A ),
    .X(mgmt_io_out_buf[19]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_300 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_63 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_170 (.A(\sky130_fd_sc_hd__buf_8_170/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_171 (.X(\sky130_fd_sc_hd__buf_8_171/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_302 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_64 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_168 (.A(\sky130_fd_sc_hd__buf_8_168/A ),
    .X(mgmt_io_out_buf[17]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_169 (.A(mgmt_io_in_unbuf[17]),
    .X(\sky130_fd_sc_hd__buf_8_169/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_301 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_61 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_166 (.A(\sky130_fd_sc_hd__buf_8_166/A ),
    .X(\sky130_fd_sc_hd__buf_8_185/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_167 (.A(\sky130_fd_sc_hd__buf_8_186/X ),
    .X(\sky130_fd_sc_hd__buf_8_167/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_304 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_62 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_164 (.A(\sky130_fd_sc_hd__buf_8_164/A ),
    .X(\sky130_fd_sc_hd__buf_8_187/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_165 (.A(\sky130_fd_sc_hd__buf_8_188/X ),
    .X(\sky130_fd_sc_hd__buf_8_165/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_303 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_59 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_162 (.A(\sky130_fd_sc_hd__buf_8_162/A ),
    .X(\sky130_fd_sc_hd__buf_8_190/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_163 (.A(\sky130_fd_sc_hd__buf_8_189/X ),
    .X(\sky130_fd_sc_hd__buf_8_163/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_306 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_60 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_160 (.A(\sky130_fd_sc_hd__buf_8_160/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_161 (.X(\sky130_fd_sc_hd__buf_8_0/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_305 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_58 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_158 (.A(\sky130_fd_sc_hd__buf_8_158/A ),
    .X(\sky130_fd_sc_hd__buf_8_184/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_159 (.A(\sky130_fd_sc_hd__buf_8_183/X ),
    .X(\sky130_fd_sc_hd__buf_8_159/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_308 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_307 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_28 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_274 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_272 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_86 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_25 (.A(mgmt_io_in_unbuf[6]),
    .X(\sky130_fd_sc_hd__buf_8_36/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_29 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_275 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_24 (.A(\sky130_fd_sc_hd__buf_8_37/X ),
    .X(mgmt_io_out_buf[6]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_1 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_85 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_26 (.A(mgmt_io_in_unbuf[7]),
    .X(\sky130_fd_sc_hd__buf_8_26/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_27 (.A(\sky130_fd_sc_hd__buf_8_27/A ),
    .X(mgmt_io_out_buf[7]));
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_87 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_28 (.A(\sky130_fd_sc_hd__buf_8_28/A ),
    .X(\sky130_fd_sc_hd__buf_8_28/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_0 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_30 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_29 (.A(\sky130_fd_sc_hd__buf_8_29/A ),
    .X(\sky130_fd_sc_hd__buf_8_29/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_31 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_83 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_30 (.A(\sky130_fd_sc_hd__buf_8_30/A ),
    .X(\sky130_fd_sc_hd__buf_8_30/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_32 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_277 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_31 (.A(\sky130_fd_sc_hd__buf_8_31/A ),
    .X(\sky130_fd_sc_hd__buf_8_31/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_33 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_82 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_41 (.A(\sky130_fd_sc_hd__buf_8_41/A ),
    .X(\sky130_fd_sc_hd__buf_8_41/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_278 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_40 (.A(\sky130_fd_sc_hd__buf_8_40/A ),
    .X(\sky130_fd_sc_hd__buf_8_40/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_35 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_84 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_32 (.A(\sky130_fd_sc_hd__buf_8_32/A ),
    .X(\sky130_fd_sc_hd__buf_8_32/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_276 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_33 (.A(\sky130_fd_sc_hd__buf_8_33/A ),
    .X(\sky130_fd_sc_hd__buf_8_33/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_279 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_200 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_201 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_291 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_73 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_185 (.A(\sky130_fd_sc_hd__buf_8_185/A ),
    .X(mgmt_io_out_buf[16]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_186 (.A(mgmt_io_in_unbuf[16]),
    .X(\sky130_fd_sc_hd__buf_8_186/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_202 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_203 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_292 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_72 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_187 (.A(\sky130_fd_sc_hd__buf_8_187/A ),
    .X(mgmt_io_out_buf[15]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_188 (.A(mgmt_io_in_unbuf[15]),
    .X(\sky130_fd_sc_hd__buf_8_188/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_204 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_205 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_293 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_71 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_189 (.A(\sky130_fd_sc_hd__buf_8_39/X ),
    .X(\sky130_fd_sc_hd__buf_8_189/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_190 (.A(\sky130_fd_sc_hd__buf_8_190/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_206 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_207 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_294 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_70 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_181 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_196 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_197 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_296 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_69 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_183 (.X(\sky130_fd_sc_hd__buf_8_183/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_184 (.A(\sky130_fd_sc_hd__buf_8_184/A ),
    .X(\sky130_fd_sc_hd__buf_8_43/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_198 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_199 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_295 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_75 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_288 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_289 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_290 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_38 (.A(mgmt_io_in_unbuf[13]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_39 (.A(mgmt_io_in_unbuf[14]),
    .X(\sky130_fd_sc_hd__buf_8_39/X ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_44 (.X(mgmt_io_out_buf[13]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_45 (.X(mgmt_io_out_buf[14]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_287 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_42 (.A(mgmt_io_in_unbuf[12]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_43 (.A(\sky130_fd_sc_hd__buf_8_43/A ),
    .X(mgmt_io_out_buf[12]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_47 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_77 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_10 (.A(\sky130_fd_sc_hd__buf_8_10/A ),
    .X(mgmt_io_out_buf[11]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_11 (.A(mgmt_io_in_unbuf[11]),
    .X(\sky130_fd_sc_hd__buf_8_11/X ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_14 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_15 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_285 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_286 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_81 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_180 (.A(\sky130_fd_sc_hd__buf_8_11/X ),
    .X(\sky130_fd_sc_hd__buf_8_32/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_194 (.A(\sky130_fd_sc_hd__buf_8_33/X ),
    .X(\sky130_fd_sc_hd__buf_8_10/A ));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_208 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_212 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_280 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_78 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_281 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_283 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_191 (.X(\sky130_fd_sc_hd__buf_8_41/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_192 (.X(\sky130_fd_sc_hd__buf_8_30/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_195 (.A(\sky130_fd_sc_hd__buf_8_40/X ),
    .X(mgmt_io_out_buf[10]));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_196 (.A(\sky130_fd_sc_hd__buf_8_31/X ),
    .X(mgmt_io_out_buf[9]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_209 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_210 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_213 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_214 ();
 sky130_ef_sc_hd__decap_12 sky130_ef_sc_hd__decap_12_79 ();
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_193 (.X(\sky130_fd_sc_hd__buf_8_28/A ));
 sky130_fd_sc_hd__buf_8 sky130_fd_sc_hd__buf_8_197 (.A(\sky130_fd_sc_hd__buf_8_29/X ),
    .X(mgmt_io_out_buf[8]));
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_211 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_215 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_216 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_217 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_282 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 sky130_fd_sc_hd__tapvpwrvgnd_1_284 ();
endmodule
