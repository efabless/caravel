// This is the unpowered netlist.
module buff_flash_clkrst (in_n,
    in_s,
    out_n,
    out_s);
 input [11:0] in_n;
 input [2:0] in_s;
 output [2:0] out_n;
 output [11:0] out_s;


 sky130_fd_sc_hd__clkbuf_8 \BUF[0]  (.A(in_s[0]),
    .X(out_n[0]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[10]  (.A(in_n[7]),
    .X(out_s[7]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[11]  (.A(in_n[8]),
    .X(out_s[8]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[12]  (.A(in_n[9]),
    .X(out_s[9]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[13]  (.A(in_n[10]),
    .X(out_s[10]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[14]  (.A(in_n[11]),
    .X(out_s[11]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[1]  (.A(in_s[1]),
    .X(out_n[1]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[2]  (.A(in_s[2]),
    .X(out_n[2]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[3]  (.A(in_n[0]),
    .X(out_s[0]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[4]  (.A(in_n[1]),
    .X(out_s[1]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[5]  (.A(in_n[2]),
    .X(out_s[2]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[6]  (.A(in_n[3]),
    .X(out_s[3]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[7]  (.A(in_n[4]),
    .X(out_s[4]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[8]  (.A(in_n[5]),
    .X(out_s[5]));
 sky130_fd_sc_hd__clkbuf_8 \BUF[9]  (.A(in_n[6]),
    .X(out_s[6]));
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
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_10 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_11 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_12 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_13 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_14 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_15 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_16 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_0_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_0_29 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_41 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_54 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_0_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_3 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_17 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_32 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_1_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_74 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_3 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_26 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_29 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_52 ();
 sky130_fd_sc_hd__decap_8 FILLER_2_67 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_15 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_42 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_54 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_74 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_4_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_27 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_29 ();
 sky130_ef_sc_hd__decap_12 FILLER_4_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_53 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_57 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_70 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_74 ();
endmodule

