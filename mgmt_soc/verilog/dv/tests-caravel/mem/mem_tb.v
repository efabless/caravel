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

module mem_tb;
	reg clock;
	reg RSTB;
	reg power1, power2;

	wire gpio;
    wire [15:0] checkbits;
	wire [37:0] mprj_io;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	assign checkbits = mprj_io[31:16];

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("mem.vcd");
		$dumpvars(0, mem_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (100) begin
			repeat (5000) @(posedge clock);
			$display("+5000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test MEM (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test MEM (RTL) Failed");
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

    reg flag_1 = 0;
	reg flag_2 = 0;
	reg flag_3 = 0;
	reg flag_4 = 0;
	reg flag_5 = 0;
	reg flag_6 = 0;
	reg flag_7 = 0;

	always @(posedge clock) begin
		if(checkbits == 16'hA040 && flag_1 === 0 ) begin
			$display("Mem Test (word rw) started");
            $display("GPIO state = %h", checkbits);
			flag_1 <= 1;
		end
		else if(checkbits == 16'hAB40) begin
			$display("%c[1;31m",27);
			`ifdef GL
				$display("Monitor: Test MEM (GL) [word rw] failed");
			`else
				$display("Monitor: Test MEM (RTL) [word rw] failed");
			`endif
			$display("%c[0m",27);
			$finish;
		end
		else if(checkbits == 16'hAB41 && flag_2 == 0) begin
			`ifdef GL
				$display("Monitor: Test MEM (GL) [word rw]  passed");
			`else
				$display("Monitor: Test MEM (RTL) [word rw]  passed");
			`endif
			$display("GPIO state = %h", checkbits);
			flag_2 <= 1;
		end
		else if(checkbits == 16'hA020  && flag_3 == 0) begin
			$display("Mem Test (short rw) started");
			flag_3 <= 1;
		end
		else if(checkbits == 16'hAB20) begin
			$display("%c[1;31m",27);
			`ifdef GL
				$display("Monitor: Test MEM (GL) [short rw] failed");
			`else
				$display("Monitor: Test MEM (RTL) [short rw] failed");
			`endif
			$display("%c[0m",27);
			$finish;
		end
		else if(checkbits == 16'hAB21) begin
			`ifdef GL
				$display("Monitor: Test MEM (GL) [short rw]  passed");
			`else
				$display("Monitor: Test MEM (RTL) [short rw]  passed");
			`endif
			flag_4 <= 1;
		end
		else if(checkbits == 16'hA010 && flag_5 == 0) begin
			$display("Mem Test (byte rw) started");
			flag_5 <= 1;
		end
		else if(checkbits == 16'hAB10) begin
			$display("%c[1;31m",27);
			`ifdef GL
				$display("Monitor: Test MEM (GL) [byte rw] failed");
			`else
				$display("Monitor: Test MEM (RTL) [byte rw] failed");
			`endif
			$display("%c[0m",27);
			$finish;
		end
		else if(checkbits == 16'hAB11 && flag_6 == 0) begin
			`ifdef GL
				$display("Monitor: Test MEM (GL) [byte rw] passed");
			`else
				$display("Monitor: Test MEM (RTL) [byte rw] passed");
			`endif
			flag_6 <= 1;
		end
		else if(checkbits === 16'hA050 && flag_7 == 0) begin
			$display("Mem Test (byte w word r) started");
			flag_7 <= 1;
		end
		else if(checkbits === 16'hAB50) begin
			$display("%c[1;31m",27);
			`ifdef GL
				$display("Monitor: Test MEM (GL) [byte w word r] failed");
			`else
				$display("Monitor: Test MEM (RTL) [byte w word r] failed");
			`endif
			$display("%c[0m",27);
			$finish;
		end
		else if(checkbits === 16'hAB51) begin
			`ifdef GL
				$display("Monitor: Test MEM (GL) [byte w word r] passed");
			`else
				$display("Monitor: Test MEM (RTL) [byte w word r] passed");
			`endif
			$finish;
		end

	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VSS = 1'b0;
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;

	assign mprj_io[3] = 1'b1;       // Force CSB high.
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
		.FILENAME("mem.hex")
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
