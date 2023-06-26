`default_nettype none
/*
 *  SPDX-FileCopyrightText: 2017  Clifford Wolf, 2018  Tim Edwards
 *
 *  Caravel - A full example SoC using PicoRV32 in SkyWater sky130
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *  Copyright (C) 2021  Tim Edwards <tim@efabless.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  SPDX-License-Identifier: ISC
 */

`timescale 1 ns / 1 ps


module irq_tb;

	reg clock;
	reg power1;
	reg power2;

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock <= 0;
	end

	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../../sdf/DFFRAM.sdf", uut.DFFRAM_0 );
			$sdf_annotate("../../../../sdf/mgmt_core.sdf", uut.core);
		end
	`endif 

	initial begin
		$dumpfile("irq.vcd");
		$dumpvars(1, irq_tb);
		
		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (50) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test IRQ (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test IRQ (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	wire [127:0] la_output;	// Most of these are no-connects
	wire [3:0]  status;
	wire [3:0] checkbits;

	assign checkbits = la_output[19:16];
	assign status = la_output[35:32];
//	assign mprj_io[3] = 1'b1;	// Force CSB high.

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire gpio;

	reg RSTB;

	// Monitor
	initial begin
		wait(status == 4'h5);
		`ifdef GL
			$display("Monitor: Test IRQ (GL) Started");
		`else
			$display("Monitor: Test IRQ (RTL) Started");
		`endif
		wait(status == 4'ha);
		wait(status == 4'hc);
		`ifdef GL
			$display("Monitor: Test IRQ (GL) Passed");
		`else
			$display("Monitor: Test IRQ (RTL) Passed");
		`endif
		$finish;
	end

	initial begin
		RSTB <= 1'b0;
		#1000;
		RSTB <= 1'b1;		// Release reset
		#2000;
	end

	initial begin			// Power-up
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end
               
	always @(checkbits, status) begin
		#1 $display("GPIO state = %b (%b)", checkbits, status);
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	// These are the mappings of mprj_io GPIO pads that are set to
	// specific functions on startup:
	//
	// JTAG      = mgmt_gpio_io[0]              (inout)
	// SDO       = mgmt_gpio_io[1]              (output)
	// SDI       = mgmt_gpio_io[2]              (input)
	// CSB       = mgmt_gpio_io[3]              (input)
	// SCK       = mgmt_gpio_io[4]              (input)
	// ser_rx    = mgmt_gpio_io[5]              (input)
	// ser_tx    = mgmt_gpio_io[6]              (output)
	// irq       = mgmt_gpio_io[7]              (input)

	mgmt_core_wrapper uut (
	`ifdef USE_POWER_PINS
		.VPWR		  (VDD1V8),
		.VGND		  (VSS),
	`endif
		.core_clk	  (clock),
		.core_rstn	  (RSTB),
        .debug_in(1'b0),
        .debug_mode(),
        .debug_oeb(),
        .debug_out(),
		.gpio_out_pad(gpio),
        .gpio_in_pad(1'b0),
        .gpio_inenb_pad(),
        .gpio_mode0_pad(),
        .gpio_mode1_pad(),
        .gpio_outenb_pad(),
		.la_output (la_output),
        .la_iena(),
        .la_input(128'b0),
        .la_oenb(),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0_oeb(),
		.flash_io1_oeb(),
		.flash_io2_oeb(),
		.flash_io3_oeb(),
		.flash_io0_do(flash_io0),
		.flash_io0_di(1'b0),
		.flash_io1_do(),
		.flash_io1_di(flash_io1),
		.flash_io2_do(),
		.flash_io2_di(1'b0),
        .flash_io3_do(),
		.flash_io3_di(1'b0),
        .mprj_adr_o(),
        .mprj_sel_o(),
		.mprj_dat_i(32'b0),
		.mprj_ack_i(1'b0),
		.mprj_cyc_o(),
        .mprj_stb_o(),
        .mprj_wb_iena(),
        .mprj_we_o(),
        .hk_dat_i(32'b0),
		.hk_ack_i(1'b0),
		.hk_cyc_o(),
		.hk_stb_o(),
		.ser_rx(1'b1),
		.ser_tx(),
		.qspi_enabled(),
        .spi_csb(),
        .spi_enabled(),
        .spi_sck(),
        .spi_sdi(1'b0),
        .spi_sdo(),
        .spi_sdoenb(),
        .sram_ro_csb(),
        .sram_ro_clk(),
        .sram_ro_addr(8'b0),
        .sram_ro_data(),
        .trap(),
        .uart_enabled(),
        .irq(6'b0),
        .user_irq_ena()
	);

	spiflash #(
		.FILENAME("irq.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
