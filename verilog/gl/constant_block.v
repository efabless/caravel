module constant_block (one,
    zero);
 output one;
 output zero;

 wire one_unbuf;
 wire zero_unbuf;

 sky130_fd_sc_hd__buf_16 const_one_buf (.A(one_unbuf),
    .X(one));
 sky130_fd_sc_hd__conb_1 const_source (.HI(one_unbuf),
    .LO(zero_unbuf));
 sky130_fd_sc_hd__buf_16 const_zero_buf (.A(zero_unbuf),
    .X(zero));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_0 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_1 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_0 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_27 ();
 sky130_fd_sc_hd__fill_4 FILLER_1_0 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_4 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_8 ();
 sky130_fd_sc_hd__fill_8 FILLER_1_16 ();
 sky130_fd_sc_hd__fill_4 FILLER_1_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_0 ();
 sky130_fd_sc_hd__fill_2 FILLER_2_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_27 ();
endmodule
