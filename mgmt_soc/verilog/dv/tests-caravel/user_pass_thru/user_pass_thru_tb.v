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
 *	StriVe housekeeping pass-thru mode SPI testbench.
 */

`timescale 1 ns / 1 ps

module user_pass_thru_tb;
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

//	always #10 clock <= (clock === 1'b0);
    always #12.5 clock <= (clock === 1'b0);

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
	
	integer i;

    // Now drive the digital signals on the housekeeping SPI
	reg [7:0] tbdata;

	initial begin
	    $dumpfile("user_pass_thru.vcd");
	    $dumpvars(0, user_pass_thru_tb);

	    CSB <= 1'b1;
	    SCK <= 1'b0;
	    SDI <= 1'b0;
	    RSTB <= 1'b0;

	    #2000;

	    RSTB <= 1'b1;

	    // Wait on start of program execution
        $display(">> Waiting for program start...");

	    wait(checkbits == 16'hA000);
	    #5000;

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
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end

	    // The SPI flash may need to be reset.
	    start_csb();
	    write_byte(8'hc2);	// Apply user pass-thru command to housekeeping SPI
	    write_byte(8'hff);	// SPI flash command ff
	    end_csb();

	    start_csb();
	    write_byte(8'hc2);	// Apply user pass-thru command to housekeeping SPI
	    write_byte(8'hab);	// SPI flash command ab
	    end_csb();

	    start_csb();
	    write_byte(8'hc2); // Apply user pass-thru command to housekeeping SPI
	    write_byte(8'h03);	// Command 03 (read values w/3-byte address)
	    write_byte(8'h00);	// Address is next three bytes (0x000000)
	    write_byte(8'h00);
	    write_byte(8'h00);

	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x6f)", tbdata);
	    if(tbdata !== 8'h6f) begin
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x00)", tbdata);
	    if(tbdata !== 8'h00) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x00)", tbdata);
	    if(tbdata !== 8'h00) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x0b)", tbdata);
	    if(tbdata !== 8'h0b) begin
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x93)", tbdata);
	    if(tbdata !== 8'h93) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x01)", tbdata);
	    if(tbdata !== 8'h01) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x00)", tbdata);
	    if(tbdata !== 8'h00) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end
	    read_byte(tbdata);
	    $display("Read flash data = 0x%02x (should be 0x00)", tbdata);
	    if(tbdata !== 8'h00) begin
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end

	    end_csb();

	    $display(">> Initiating reset thru housekeeping...");
	    #5000;

	    // Reset processor
	    start_csb();
	    write_byte(8'h80);	// Write stream command
	    write_byte(8'h0b);	// Address (register 11 = reset)
	    write_byte(8'h01);	// Data (value 1 = apply reset)
	    end_csb();

	    start_csb();
	    write_byte(8'h80);	// Write stream command
	    write_byte(8'h0b);	// Address (register 11 = reset)
	    write_byte(8'h00);	// Data (value 1 = apply reset)
	    end_csb();

	    // Wait for processor to restart
        $display(">> Waiting for processor to restart...");
	    wait(checkbits == 16'hA000);

	    // Read product ID register again

	    start_csb();
	    write_byte(8'h40);	// Read stream command
	    write_byte(8'h03);	// Address (register 3 = product ID)
	    read_byte(tbdata);
	    end_csb();
	    #10;
	    $display("Read data = 0x%02x (should be 0x11)", tbdata);
	    if(tbdata !== 8'h11) begin 
			`ifdef GL
				$display("Monitor: Test HK SPI Pass-thru (GL) Failed"); $finish; 
			`else
				$display("Monitor: Test HK SPI Pass-thru (RTL) Failed"); $finish; 
			`endif
		end

        $display(">> Waiting for program end...");
        wait(checkbits == 16'hAb00);
        #5000;
//	    #50000;

		`ifdef GL
	    	$display("Monitor: Test HK SPI Pass-thru (GL) Passed");
		`else
			$display("Monitor: Test HK SPI Pass-thru (RTL) Passed");
		`endif

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
    assign mprj_io[0] = 1'b0;  // Disable debug mode

	assign SDO = mprj_io[1];

	assign user_csb = mprj_io[8];
	assign user_clk = mprj_io[9];
	assign user_io0 = mprj_io[10];
	assign mprj_io[11] = user_io1;
	
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
		.FILENAME("user_pass_thru.hex")
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
		.FILENAME("test_data")
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
