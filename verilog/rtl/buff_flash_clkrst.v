module buff_flash_clkrst (
	`ifdef USE_POWER_PINS
		inout VPWR,
		inout VGND,
	`endif
	input[11:0] in_n, 
	input[2:0] in_s, 
	output[11:0] out_s, 
	output[2:0] out_n);

	sky130_fd_sc_hd__clkbuf_8 BUF[14:0] (
		`ifdef USE_POWER_PINS
			.VGND(VGND),
			.VNB(VGND),
			.VPB(VPWR),
			.VPWR(VPWR),
		`endif
		.A({in_n, in_s}), 
		.X({out_s, out_n})); 

endmodule