module constant_block (one,
    zero,
    vccd,
    vssd);
 output one;
 output zero;
 input vccd;
 input vssd;

 wire one_unbuf;
 wire zero_unbuf;

 sky130_fd_sc_hd__buf_16 const_one_buf (.A(one_unbuf),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(one));
 sky130_fd_sc_hd__conb_1 const_source (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .HI(one_unbuf),
    .LO(zero_unbuf));
 sky130_fd_sc_hd__buf_16 const_zero_buf (.A(zero_unbuf),
    .VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd),
    .X(zero));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_0 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_1 (.VGND(vssd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_0 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_0_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_0_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_4 FILLER_1_0 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_1_4 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_8 FILLER_1_8 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_8 FILLER_1_16 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_4 FILLER_1_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_0 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_2 FILLER_2_24 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
 sky130_fd_sc_hd__fill_1 FILLER_2_27 (.VGND(vssd),
    .VNB(vssd),
    .VPB(vccd),
    .VPWR(vccd));
endmodule
