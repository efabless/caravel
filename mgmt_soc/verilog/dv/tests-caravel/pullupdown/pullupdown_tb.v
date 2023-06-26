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

module pullupdown_tb;

	reg clock;
	reg power1;
	reg power2;

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock <= 0;
	end

	initial begin
		$dumpfile("pullupdown.vcd");
		$dumpvars(3, pullupdown_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (500) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Pullupdown (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Pullupdown (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	wire [37:0] mprj_io;
	wire [5:0] checkbits_lo;
	wire [5:0] checkbits_hi;

	assign checkbits_hi = mprj_io[37:32];
	assign checkbits_lo = mprj_io[5:0];

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire gpio;

	reg RSTB;

	integer i;
	reg w;
	reg [37:0] mprj_apply = 38'bz;

        assign mprj_io = mprj_apply;

	// Monitor
	initial begin
		wait(checkbits_hi == 6'h20);
		w = mprj_io[3];
		if (w != 1'b1) begin
		    $display("Monitor: CSB value %b should be 1.", w);
		    $display("Monitor: Test CSB check-pullup failed.");
		    $finish;
		end
		// Should be able to force the pin low against the pull-up
		mprj_apply[3] = 1'b0;
		#10;
		w = mprj_io[3];
		if (w != 1'b0) begin
		    $display("Monitor: CSB value %b should be 0.", w);
		    $display("Monitor: Test CSB force-low failed.");
		    $finish;
		end
		mprj_apply[3] = 1'bz;
		$display("Monitor: CSB default pull-up state check passed");

		wait(checkbits_hi == 6'h30);
		for (i = 0; i < 32; i++) begin
		   wait(checkbits_hi == 6'h31);
		   w = mprj_io[i];
		   if (w != 1'b0) begin
			$display("Monitor: wire value %b should be 0.", w);
			$display("Monitor: Test pullupdown check-pulldown failed.");
			$finish;
		   end
		   // Should be able to force the pin high against the pull-down
		   mprj_apply[i] = 1'b1;
		   #10;
		   w = mprj_io[i];
		   if (w != 1'b1) begin
			$display("Monitor: wire value %b should be 1.", w);
			$display("Monitor: Test pullupdown force-high failed.");
			$finish;
		   end
		   mprj_apply[i] = 1'bz;
		   wait(checkbits_hi == 6'h32);
		   w = mprj_io[i];
		   if (w != 1'b1) begin
			$display("Monitor: wire value %b should be 1.", w);
			$display("Monitor: Test pullupdown check-pullup failed.");
			$finish;
		   end
		   // Should be able to force the pin low against the pull-up
		   mprj_apply[i] = 1'b0;
		   #10;
		   w = mprj_io[i];
		   if (w != 1'b0) begin
			$display("Monitor: wire value %b should be 0.", w);
			$display("Monitor: Test pullupdown force-low failed.");
			$finish;
		   end
		   mprj_apply[i] = 1'bz;
		   wait(checkbits_hi == 6'h33);
		   w = mprj_io[i];
		   if (w != 1'bz) begin
			$display("Monitor: wire value %b should be z.", w);
			$display("Monitor: Test pullupdown check-disabled failed.");
			$finish;
		   end
		end
		wait(checkbits_hi == 6'h34);
		$display("Monitor: Switch from low to high GPIOs");
		wait(checkbits_lo == 6'h35);
		$display("Monitor: GPIO 0-31 pull-up/down check passed");
		wait(checkbits_lo == 6'h36);
		$display("Monitor: Start test of high GPIOs");
		for (i = 32; i < 38; i++) begin
		   wait(checkbits_lo == 6'h37);
		   w = mprj_io[i];
		   if (w != 1'b0) begin
			$display("Monitor: wire value %b should be 0.", w);
			$display("Monitor: Test pullupdown check-pulldown failed.");
			$finish;
		   end
		   // Should be able to force the pin high against the pull-down
		   mprj_apply[i] = 1'b1;
		   #10;
		   w = mprj_io[i];
		   if (w != 1'b1) begin
			$display("Monitor: wire value %b should be 1.", w);
			$display("Monitor: Test pullupdown force-high failed.");
			$finish;
		   end
		   mprj_apply[i] = 1'bz;
		   wait(checkbits_lo == 6'h38);
		   w = mprj_io[i];
		   if (w != 1'b1) begin
			$display("Monitor: wire value %b should be 1.", w);
			$display("Monitor: Test pullupdown check-pullup failed.");
			$finish;
		   end
		   // Should be able to force the pin low against the pull-up
		   mprj_apply[i] = 1'b0;
		   #10;
		   w = mprj_io[i];
		   if (w != 1'b0) begin
			$display("Monitor: wire value %b should be 0.", w);
			$display("Monitor: Test pullupdown force-low failed.");
			$finish;
		   end
		   mprj_apply[i] = 1'bz;
		   wait(checkbits_lo == 6'h39);
		   w = mprj_io[i];
		   if (w != 1'bz) begin
			$display("Monitor: wire value %b should be z.", w);
			$display("Monitor: Test pullupdown check-disabled failed.");
			$finish;
		   end
		end
		wait(checkbits_lo == 6'h3a);
		$display("Monitor: GPIO 37-32 pull-up/down check passed");
		`ifdef GL
			$display("Monitor: Test Pullupdown (GL) Passed");
		`else
			$display("Monitor: Test Pullupdown (RTL) Passed");
		`endif
		#2000;
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
		#1 $display("Mgmt GPIO state = %b (%d - %d)", mprj_io,
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

 	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),		
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
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
		.FILENAME("pullupdown.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
