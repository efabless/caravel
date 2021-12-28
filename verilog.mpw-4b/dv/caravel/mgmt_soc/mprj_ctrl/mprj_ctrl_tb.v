// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

`include "__uprj_netlists.v"
`include "caravel_netlists.v"
`include "spiflash.v"

module mprj_ctrl_tb;
	reg clock;
	reg RSTB;
	reg power1, power2;

	wire gpio;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire [37:0] user_io;
	wire SDO;

	wire [3:0] checkbits;

	assign checkbits = user_io[31:28];

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("mprj_ctrl.vcd");
		$dumpvars(0, mprj_ctrl_tb);
		repeat (25) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test User Project (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test User Project (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	always @(checkbits) begin
		if(checkbits == 4'h5) begin
			$display("User Project control Test started");
		end else if(checkbits == 4'h6) begin
			$display("%c[1;31m",27);
			$display("Monitor: IO control R/W failed (check 6)");
			$display("%c[0m",27);
			$finish;
		end else if(checkbits == 4'h7) begin
			$display("Monitor: IO control R/W passed (check 7)");
		end else if(checkbits == 4'h8) begin
            		$display("%c[1;31m",27);
			$display("Monitor: power control R/W failed (check 8)");
			$display("%c[0m",27);
			$finish;
        	end else if(checkbits == 4'h9) begin
			$display("Monitor: power control R/W passed (check 9)");
		end else if(checkbits == 4'ha) begin
            		$display("%c[1;31m",27);
			$display("Monitor: power control R/W failed (check 10)");
			$display("%c[0m",27);
			$finish;
        	end else if(checkbits == 4'hb) begin
			$display("Monitor: power control R/W passed (check 11)");
		end else if(checkbits == 4'hc) begin
            		$display("%c[1;31m",27);
			$display("Monitor: power control R/W failed (check 12)");
			$display("%c[0m",27);
			$finish;
        	end else if(checkbits == 4'hd) begin

			$display("Monitor: power control R/W passed (check 13)");
			`ifdef GL
            	$display("Monitor: User Project control (GL) test passed.");
			`else
			    $display("Monitor: User Project control (RTL) test passed.");
			`endif
            $finish;
        	end			
	end

	initial begin
		RSTB <= 1'b0;
		#1000;
		RSTB <= 1'b1;	    // Release reset
		#2000;
	end

	initial begin
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

	always @(gpio) begin
		#1 $display("GPIO state = %b ", gpio);
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	assign user_io[3] = 1'b1;
	
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
		.clock	   (clock),
		.gpio      (gpio),
		.mprj_io   (user_io),
		.flash_csb (flash_csb),
		.flash_clk (flash_clk),
		.flash_io0 (flash_io0),
		.flash_io1 (flash_io1),
		.resetb	   (RSTB)
	);

	spiflash #(
		.FILENAME("mprj_ctrl.hex")
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
