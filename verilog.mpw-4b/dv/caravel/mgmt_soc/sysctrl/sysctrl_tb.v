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

module sysctrl_tb;
	reg clock;
	reg power1;
	reg power2;
	reg RSTB;

	wire gpio;
	wire [15:0] checkbits;
	wire [7:0] spivalue;
	wire [37:0] mprj_io;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire SDO;

	integer ccount;
	integer ucount;

	assign checkbits = mprj_io[31:16];
	assign spivalue  = mprj_io[15:8];

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #10 clock <= (clock === 1'b0);

	// User clock monitoring
	always @(posedge mprj_io[15]) begin
	    ucount = ucount + 1;
	end

	// Core clock monitoring
	always @(posedge mprj_io[14]) begin
	    ccount = ccount + 1;
	end

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("sysctrl.vcd");
		$dumpvars(0, sysctrl_tb);
		repeat (25) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		$display ("Monitor: Timeout, Test Sysctrl (RTL) Failed");
		$display("%c[0m",27);
		$finish;
	end

	// Monitor
	initial begin
	    wait(checkbits == 16'hA040);
	    $display("Monitor: Test 1 Sysctrl (RTL) Started");
	    ucount = 0;
	    ccount = 0;
	    wait(checkbits == 16'hA041);
	    $display("Monitor: ucount = %d ccount = %d", ucount, ccount);
            if (ucount !== 0 || ccount != 0) begin
                $display("Monitor: Test Sysctrl Failed");
                $finish;
            end
		
	    wait(checkbits == 16'hA042);
	    $display("Monitor: Test 1 Sysctrl (RTL) Started");
	    ucount = 0;
	    ccount = 0;
	    wait(checkbits == 16'hA043);
	    $display("Monitor: ucount = %d ccount = %d", ucount, ccount);
            if (ucount !== 129 || ccount != 0) begin
                $display("Monitor: Test Sysctrl Failed");
                $finish;
            end
		
	    wait(checkbits == 16'hA044);
	    $display("Monitor: Test 2 Sysctrl (RTL) Started");
	    ucount = 0;
	    ccount = 0;
	    wait(checkbits == 16'hA045);
	    $display("Monitor: ucount = %d ccount = %d", ucount, ccount);
            if (ucount !== 0 || ccount != 129) begin
                $display("Monitor: Test Sysctrl Failed");
                $finish;
            end

	    wait(checkbits == 16'hA090);

	    $display("Monitor: Test Sysctrl (RTL) Passed");
	    $finish;
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

	always @(checkbits) begin
		#1 $display("GPIO state = %b ", checkbits);
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	assign mprj_io[3] = 1'b1;  // Force CSB high.

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
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("sysctrl.hex")
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
