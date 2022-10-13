module buff8x20(input[19:0] in, output[19:0] out);
	
	sky130_fd_sc_hd__buf_8 BUF[19:0] ( .A(in), .X(out) ); 

endmodule
