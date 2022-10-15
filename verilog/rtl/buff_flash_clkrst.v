module buff_flash_clkrst (
	`ifdef USE_POWER_PINS
		inout VPWR,
		inout VGND,
	`endif
	input[11:0] in_e, 
	input[2:0] in_w, 
	output[11:0] out_w, 
	output[2:0] out_e);

	sky130_fd_sc_hd__clkbuf_8 BUF[14:0] (
		`ifdef USE_POWER_PINS
		.VGND(VGND),
		.VNB(VGND),
		.VPB(VPWR),
		.VPWR(VPWR)
		`endif
		.A({in_e, in_w}), 
		.X({out_w, out_e})
		); 

endmodule
