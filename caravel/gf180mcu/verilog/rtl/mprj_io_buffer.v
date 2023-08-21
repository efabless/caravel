module mprj_io_buffer (
	`ifdef USE_POWER_PINS
		inout VDD,
		inout VSS,
	`endif
     input [17:0]  mgmt_gpio_in,
     output [17:0] mgmt_gpio_in_buf,
     input [2:0]   mgmt_gpio_oeb,
     output [2:0]  mgmt_gpio_oeb_buf,
     input [17:0]  mgmt_gpio_out,
     output [17:0] mgmt_gpio_out_buf);

gf180mcu_fd_sc_mcu7t5v0__clkbuf_8 BUF[38:0] (
		`ifdef USE_POWER_PINS
			.VDD(VDD),
			.VSS(VSS),
		`endif
		.I({mgmt_gpio_in, mgmt_gpio_oeb, mgmt_gpio_out}), 
		.Z({mgmt_gpio_in_buf, mgmt_gpio_oeb_buf, mgmt_gpio_out_buf})); 

endmodule