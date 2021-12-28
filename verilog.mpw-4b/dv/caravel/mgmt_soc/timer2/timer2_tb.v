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

`include "__uprj_netlists.v"
`include "caravel_netlists.v"
`include "spiflash.v"

module timer2_tb;

	reg clock;
	reg RSTB;
	reg power1, power2;

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock <= 0;
	end

	initial begin
		$dumpfile("timer2.vcd");
		$dumpvars(0, timer2_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (60) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Timer2 (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Timer2 (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	wire [37:0] mprj_io;	// Most of these are no-connects
	wire [5:0] checkbits;
	wire [31:0] countbits;

	assign checkbits = mprj_io[37:32];
	assign countbits = mprj_io[31:0];

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire gpio;

	// Monitor
	initial begin
		wait(checkbits == 6'h0a);
		`ifdef GL
			$display("Monitor: Test Timer2 (GL) Started");
		`else
			$display("Monitor: Test Timer2 (RTL) Started");
		`endif
		/* Add checks here */
		wait(checkbits == 6'h01);
		$display("   countbits = 0x%x (should be 0xdcba7cfb)", countbits);
		if(countbits !== 32'hdcba7cfb) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end
		wait(checkbits == 6'h02);
		$display("   countbits = 0x%x (should be 0x19)", countbits);
		if(countbits !== 32'h19) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end
		wait(checkbits == 6'h03);
		$display("   countbits = %x (should be 0x0f)", countbits);
		if(countbits !== 32'h0f) begin
		    $display("Monitor: Test Timer (RTL) Failed");
		    $finish;
		end
		wait(checkbits == 6'h04);
		$display("   countbits = %x (should be 0x0f)", countbits);
		if(countbits !== 32'h0f) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end
		wait(checkbits == 6'h05);
		$display("   countbits = %x (should be 0x12bc)", countbits);
		if(countbits !== 32'h12bc) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end

		wait(checkbits == 6'h06);
		$display("   countbits = %x (should be 0x005d)", countbits);
		if(countbits !== 32'h005d) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end

		wait(checkbits == 6'h07);
		$display("   countbits = %x (should be 0x0008)", countbits);
		if(countbits !== 32'h0008) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end

		wait(checkbits == 6'h08);
		$display("   countbits = %x (should be 0x0259)", countbits);
		if(countbits !== 32'h0259) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end

		wait(checkbits == 6'h10);
		$display("   countbits = %x (should be 0x000a)", countbits);
		if(countbits !== 32'h000a) begin
		    $display("Monitor: Test Timer2 (RTL) Failed");
		    $finish;
		end

		`ifdef GL
			$display("Monitor: Test Timer2 (GL) Passed");
		`else
			$display("Monitor: Test Timer2 (RTL) Passed");
		`endif
		$finish;
	end

	initial begin
		RSTB <= 1'b0;
		#1000;
		RSTB <= 1'b1;	    // Release reset
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

	always @(checkbits) begin
		#1 $display("Timer state = %b (%d)", countbits, countbits);
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;
	
	assign mprj_io[3] = 1'b1;  // Force CSB high.

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

	caravel uut (
		.vddio	  (VDD3V3),
		.vssio	  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock	  (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("timer2.hex")
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
