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

module spi_master_tb;
	reg clock;
	reg RSTB;
	reg power1, power2;

	wire gpio;
	wire [15:0] checkbits;
	wire [7:0] spivalue;
	wire [37:0] mprj_io;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	assign checkbits = mprj_io[31:16];
	assign spivalue  = mprj_io[15:8];

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock <= 0;
	end

	initial begin
		$dumpfile("spi_master.vcd");
		$dumpvars(0, spi_master_tb);
		repeat (25) begin
			repeat (1000) @(posedge clock);
			$display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test SPI Master (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test SPI Master (RTL) Failed");
		`endif
		 $display("%c[0m",27);
		$finish;
	end

	// Monitor
	initial begin
	    wait(checkbits == 16'hA040);
			`ifdef GL
            	$display("Monitor: Test SPI Master (GL) Started");
			`else
			    $display("Monitor: Test SPI Master (RTL) Started");
			`endif
	    wait(checkbits == 16'hA041);
            $display("   SPI value = 0x%x (should be 0x93)", spivalue);
            if(spivalue !== 32'h93) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA042);
            $display("   SPI value = 0x%x (should be 0x01)", spivalue);
            if(spivalue !== 32'h01) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA043);
            $display("   SPI value = 0x%x (should be 0x00)", spivalue);
            if(spivalue !== 32'h00) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA044);
            $display("   SPI value = 0x%x (should be 0x13)", spivalue);
            if(spivalue !== 32'h13) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA045);
            $display("   SPI value = 0x%x (should be 0x02)", spivalue);
            if(spivalue !== 32'h02) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA046);
            $display("   SPI value = 0x%x (should be 0x63)", spivalue);
            if(spivalue !== 32'h63) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA047);
            $display("   SPI value = 0x%x (should be 0x57)", spivalue);
            if(spivalue !== 32'h57) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA048);
            $display("   SPI value = 0x%x (should be 0xb5)", spivalue);
            if(spivalue !== 32'hb5) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA049);
            $display("   SPI value = 0x%x (should be 0x00)", spivalue);
            if(spivalue !== 32'h00) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA04a);
            $display("   SPI value = 0x%x (should be 0x23)", spivalue);
            if(spivalue !== 32'h23) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end
	    wait(checkbits == 16'hA04b);
            $display("   SPI value = 0x%x (should be 0x20)", spivalue);
            if(spivalue !== 32'h20) begin
                $display("Monitor: Test SPI Master Failed");
                $finish;
            end

	    wait(checkbits == 16'hA090);
		 	`ifdef GL
            	$display("Monitor: Test SPI Master (GL) Passed");
			`else
		        $display("Monitor: Test SPI Master (RTL) Passed");
			`endif
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

	always @(checkbits) begin
		#1 $display("GPIO state = %b ", checkbits);
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	assign mprj_io[3] = 1'b1;	// Keep CSB high
	
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
		.FILENAME("spi_master.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

	/* Instantiate a 2nd SPI flash so the SPI master can talk to it */

	spiflash #(
		.FILENAME("spi_master.hex")
	) test_spi (
		.csb(mprj_io[33]),
		.clk(mprj_io[32]),
		.io0(mprj_io[35]),
		.io1(mprj_io[34]),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
