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

`include "__uprj_analog_netlists.v"
`include "caravan_netlists.v"
`include "spiflash.v"

module caravan_tb;

	reg clock;
	reg power1;
	reg power2;

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock <= 0;
	end

	initial begin
		$dumpfile("caravan.vcd");
		$dumpvars(0, caravan_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test GPIO (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test GPIO (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	wire [37:0] mprj_io;		// Most of these are no-connects
	wire [6:0]  checkbits_hi;	// Upper 7 valid GPIO bits
	wire [7:0]  checkbits_lo;	// Lower 6 valid GPIO bits (read)

	reg  [7:0] setbits_lo;		// Lower 6 valid GPIO bits (write)

	assign mprj_io[13:7] = setbits_lo;
	assign checkbits_lo = mprj_io[13:7];
	assign checkbits_hi = mprj_io[31:25];
	assign mprj_io[3] = 1'b1;       // Force CSB high.

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire gpio;

	reg RSTB;

	// Transactor
	initial begin
		setbits_lo <= {7{1'bz}};
		wait(checkbits_hi == 7'h50);
		repeat (500) @(posedge clock);
		setbits_lo <= 7'h30;
		wait(checkbits_hi == 7'h05);
		repeat (500) @(posedge clock);
		setbits_lo <= 7'h0f;
		wait(checkbits_hi == 7'h55);
		repeat (1000) @(posedge clock);
		setbits_lo <= 7'h00;
		repeat (1300) @(posedge clock);
		setbits_lo <= 7'h01;
		repeat (1300) @(posedge clock);
		setbits_lo <= 7'h03;
	end

	// Monitor
	initial begin
		wait(checkbits_hi == 7'h50);	// 1st pull test
		`ifdef GL
			$display("Monitor: Test GPIO (GL) Started");
		`else
			$display("Monitor: Test GPIO (RTL) Started");
		`endif
		wait(checkbits_lo == 7'h30);	// (1st pull test result)
		$display("Monitor: Check 1 seen");
		wait(checkbits_hi == 7'h05);	// 2nd pull test
		$display("Monitor: Check 2 seen");
		wait(checkbits_lo == 7'h0F);	// (2nd pull test result)
		$display("Monitor: Check 3 seen");
		wait(checkbits_hi == 7'h55);	// loopback test
		$display("Monitor: Check 4 seen");
		wait(checkbits_lo == 7'h00);	// 1st value set
		$display("Monitor: Check 5 seen");
		wait(checkbits_hi == 7'h01);	// 1st loopback read
		$display("Monitor: Check 6 seen");
		wait(checkbits_lo == 7'h01);	// 2nd value set
		$display("Monitor: Check 7 seen");
		wait(checkbits_hi == 7'h02);	// 2nd loopback read
		$display("Monitor: Check 8 seen");
		wait(checkbits_lo == 7'h03);	// 3rd value set
		$display("Monitor: Check 9 seen");
		wait(checkbits_hi == 7'h04);	// 3rd loopback read
		`ifdef GL
			$display("Monitor: Test GPIO (GL) Passed");
		`else
			$display("Monitor: Test GPIO (RTL) Passed");
		`endif
		$finish;
	end

	initial begin
		RSTB <= 1'b0;
		
		#1000;
		RSTB <= 1'b1;	    // Release reset
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
		

	always @(mprj_io) begin
		#1 $display("GPIO state = %b (%d - %d)", mprj_io,
				checkbits_hi, checkbits_lo);
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

	caravan uut (
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
		.FILENAME("caravan.hex")
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
