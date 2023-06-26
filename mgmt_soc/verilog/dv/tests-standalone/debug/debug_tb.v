`default_nettype none
/*
 *  SPDX-FileCopyrightText: 2017  Clifford Wolf, 2018  Tim Edwards
 *
 *  StriVe - A full example SoC using PicoRV32 in SkyWater s8
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *  Copyright (C) 2018  Tim Edwards <tim@efabless.com>
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

module debug_tb;
	reg clock;
	reg RSTB;
	reg power1, power2;

	wire gpio;
    wire [15:0] checkbits;
	wire [127:0] la_output;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
//	wire [37:0] mprj_io;
	wire uart_tx;
	wire uart_rx;
	wire uart_loopback;
	wire SDO;

	reg debug_in;
//	wire debug_in;
	reg [5:0] irq;

	assign checkbits = la_output[31:16];
//	assign debug_in = 1'b0;
//	assign uart_tx = la_output[6];

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../../sdf/DFFRAM.sdf", uut.DFFRAM_0 );
			$sdf_annotate("../../../../sdf/mgmt_core.sdf", uut.core);
		end
	`endif 

	initial begin
		$dumpfile("debug.vcd");
		$dumpvars(3, debug_tb);

		$display("Wait for Debug o/p");
		repeat (60) begin
			repeat (1000) @(posedge clock);
			// Diagnostic. . . interrupts output pattern.
		end
        $display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Debug (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Debug (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	initial begin
		RSTB <= 1'b0;
		#1000;
		RSTB <= 1'b1;	    // Release reset
		#2000;
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

    initial begin
        debug_in = 1'b0;
//        irq <= 6'b0;
        #1000
		debug_in = 1'b1;	    // Debug mode
//		#350000;
//		#250000;
		#3000;
//		irq[3] <= 1'b1;	    // Raise IRQ
//		irq <= 6'b111111;	    // Raise IRQ
//		#100
//		irq <= 6'b0;
	end

	always @(checkbits) begin
		if(checkbits == 16'hA000) begin
			$display("Debug Test started");
		end
		else if(checkbits == 16'hAB00) begin
			`ifdef GL
				$display("Monitor: Test Debug (GL) passed");
			`else
				$display("Monitor: Test Debug (RTL) passed");
			`endif
			$finish;
		end
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;
	
//	assign la_output[3] = 1'b1;  // Force CSB high.

	mgmt_core_wrapper uut (
	`ifdef USE_POWER_PINS
		.VPWR		  (VDD1V8),
		.VGND		  (VSS),
	`endif
		.core_clk	  (clock),
		.core_rstn	  (RSTB),
//        .debug_in(1'b1),
        .debug_in(debug_in),
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
		.ser_tx(uart_tx),
		.ser_rx(uart_rx),
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
		.FILENAME("debug.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

    // Testbench UART
	wb_rw_test debug_uart (
		.rx(uart_tx),
		.tx(uart_rx)
	);
		
endmodule
`default_nettype wire
