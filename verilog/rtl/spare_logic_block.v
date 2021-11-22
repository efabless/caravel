module spare_logic_block (
 `ifdef USE_POWER_PINS
         inout vccd,
         inout vssd,
  `endif

   output wire spare_x1
);

 sky130_fd_sc_hd__conb_1 spare_logic_high (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .HI(spare_logic1_0),
            .LO(spare_logic0_0)
    );

 sky130_fd_sc_hd__conb_1 spare_logic_high (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .HI(spare_logic1_1),
            .LO(spare_logic0_1)
    );

 sky130_fd_sc_hd__inv_2 spare_logic_inv_0 (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .X(spare_x1),
            .A(spare_logic0_1)
    );

endmodule
