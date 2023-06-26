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
/*	
 *	Test fix of the housekeeping pass-thru and user pass-thru
 *	modes on caravel_redesign (MPW-7).  Previous caravel
 *	housekeeping versions applied the data at the same time
 *	as the clock, so the first data bit (msb) could get missed.
 */

`timescale 1 ns / 1 ps

//`include "__uprj_netlists.v"
//`include "caravel_netlists.v"
//`include "spiflash.v"
//`include "tbuart.v"

module pass_thru_fix_tb;
	reg clock;
	reg SDI, CSB, SCK, RSTB;
	reg power1, power2;

	wire gpio;
	wire [15:0] checkbits;
	wire [37:0] mprj_io;
	wire uart_tx;
	wire uart_rx;

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire flash_io2;
	wire flash_io3;

	wire user_csb;
	wire user_clk;
	wire user_io0;
	wire user_io1;

	wire SDO;

	always #10 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

    // The main testbench is here.  Put the housekeeping SPI into
    // pass-thru mode and read several bytes from the flash SPI.

    // First define tasks for SPI functions

	task start_csb;
	    begin
		SCK <= 1'b0;
		SDI <= 1'b0;
		CSB <= 1'b0;
		#50;
	    end
	endtask

	task end_csb;
	    begin
		SCK <= 1'b0;
		SDI <= 1'b0;
		CSB <= 1'b1;
		#50;
	    end
	endtask

	task write_byte;
	    input [7:0] odata;
	    begin
		SCK <= 1'b0;
		for (i=7; i >= 0; i--) begin
		    #50;
		    SDI <= odata[i];
                    #50;
		    SCK <= 1'b1;
                    #100;
		    SCK <= 1'b0;
		end
	    end
	endtask

	task read_byte;
	    output [7:0] idata;
	    begin
		SCK <= 1'b0;
		SDI <= 1'b0;
		for (i=7; i >= 0; i--) begin
		    #50;
                    idata[i] = SDO;
                    #50;
		    SCK <= 1'b1;
                    #100;
		    SCK <= 1'b0;
		end
	    end
	endtask

	task read_write_byte
	    (input [7:0] odata,
	    output [7:0] idata);
	    begin
		SCK <= 1'b0;
		for (i=7; i >= 0; i--) begin
		    #50;
		    SDI <= odata[i];
                    idata[i] = SDO;
                    #50;
		    SCK <= 1'b1;
                    #100;
		    SCK <= 1'b0;
		end
	    end
	endtask
	
	// This block checks for the rising edge of the data on user SPI
	// pin SDI (mprj_io[10]) and ensures that a slight time later,
	// the user SCK clock (mprj_io[9]) is still low.

	initial begin
	    wait(mprj_io[10] == 1'b1);
	    #10;
	    if (mprj_io[9] == 1'b1) begin
	    	`ifdef GL
		    $display("Monitor: Test HK SPI Pass-thru fix (GL) failed");
		`else
		    $display("Monitor: Test HK SPI Pass-thru fix (RTL) failed");
		`endif
		$finish();
	    end else begin
		$display("Monitor: User flash data meets setup time.");
	    end
	end

	// This block checks for the rising edge of the data on HK SPI
	// pin SDI (mprj_io[2]) and ensures that a slight time later,
	// the HK SCK clock (mprj_io[4]) is still low.

	initial begin
	    // First wait for the 2nd time that CSB goes high
	    wait(mprj_io[3] == 1'b0);
	    wait(mprj_io[3] == 1'b1);
	    wait(mprj_io[3] == 1'b0);
	    wait(mprj_io[3] == 1'b1);

	    wait(mprj_io[2] == 1'b1);
	    #10;
	    if (mprj_io[4] == 1'b1) begin
	    	`ifdef GL
		    $display("Monitor: Test HK SPI Pass-thru fix (GL) failed");
		`else
		    $display("Monitor: Test HK SPI Pass-thru fix (RTL) failed");
		`endif
		$finish();
	    end else begin
		$display("Monitor: Primary flash data meets setup time.");
	    end
	end

	integer i;

	reg [7:0] tbdata;

	initial begin
	    $dumpfile("pass_thru_fix.vcd");
	    $dumpvars(0, pass_thru_fix_tb);

	    CSB <= 1'b1;
	    SCK <= 1'b0;
	    SDI <= 1'b0;
	    RSTB <= 1'b0;

	    #2000;

	    RSTB <= 1'b1;

	    // Wait on start of program execution
	    wait(checkbits == 16'hA000);
	    $display("Start test");

            // First do a normal read from the housekeeping SPI to
	    // make sure the housekeeping SPI works.

	    start_csb();
	    write_byte(8'h40);	// Read stream command
	    write_byte(8'h03);	// Address (register 3 = product ID)
	    read_byte(tbdata);
	    end_csb();
	    #10;
	    $display("Read data = 0x%02x (should be 0x11)", tbdata);
	    if(tbdata !== 8'h11) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru fix (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru fix (RTL) Failed"); $finish; 
			`endif
		end

	    // Now write a command directly to the SPI flash.
	    // The power-down command has the high bit set.  If the high
	    // bit is missed because the data did not get set in time for
	    // the clock, then the command 0xb9 will instead be interpreted
	    // as 0x39 and the next byte will be interpreted as a read
	    // command.  If it works correctly, then the command will
	    // power down the flash SPI and the flash will not parse any
	    // incoming data.

	    start_csb();
	    write_byte(8'hc2);	// User pass-thru mode
	    write_byte(8'hb9);	// Power down
	    write_byte(8'h03);	// Read command
	    write_byte(8'h00);	// Address is next three bytes (0x000000)
	    write_byte(8'h00);
	    write_byte(8'h00);

	    read_byte(tbdata);
	    end_csb();

	    // Next, run the SPI in regular pass-through mode

	    start_csb();
	    write_byte(8'hc4);	// Pass through mode
	    write_byte(8'hb9);	// Power down command
	    end_csb();

	    `ifdef GL
		$display("Monitor: Test HK SPI Pass-thru fix (GL) Passed");
	    `else
		$display("Monitor: Test HK SPI Pass-thru fix (RTL) Passed");
	    `endif
		
	    #10000;
 	    $finish;
	end

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	wire hk_sck;
	wire hk_csb;
	wire hk_sdi;

	assign hk_sck = SCK;
	assign hk_csb = CSB;
	assign hk_sdi = SDI;

	assign checkbits = mprj_io[31:16];
	assign uart_tx = mprj_io[6];
	assign mprj_io[5] = uart_rx;
	assign mprj_io[4] = hk_sck;
	assign mprj_io[3] = hk_csb;
	assign mprj_io[2] = hk_sdi;
	assign SDO = mprj_io[1];

	assign user_csb = mprj_io[8];
	assign user_clk = mprj_io[9];
	assign user_io0 = mprj_io[10];
	assign mprj_io[11] = user_io1;
	
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
		.FILENAME("pass_thru_fix.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

	// Use the same flash; this is just to put known data in memory that can be
	// checked by reading it back through a pass-through command.

	spiflash #(
		.FILENAME("pass_thru_fix.hex")
	) secondary (
 		.csb(user_csb),
		.clk(user_clk),
		.io0(user_io0),
		.io1(user_io1),
		.io2(),			// not used
		.io3()			// not used
	);

	tbuart tbuart (
		.ser_rx(uart_tx)
	);
		
endmodule
`default_nettype wire
