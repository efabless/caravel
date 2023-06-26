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

module spi_master_tb;
	reg clock;
	reg RSTB;
	reg power1, power2;

	wire gpio;
	wire [15:0] checkbits;
	wire [7:0] spivalue;
	wire [127:0] la_output;
	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire spi_clk;
	wire spi_cs_n;
	wire spi_mosi;
	wire spi_miso;
	wire spi_sdoenb;

	assign checkbits = la_output[31:16];
	assign spivalue  = la_output[15:8];

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

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
		$dumpfile("spi_master.vcd");
		$dumpvars(0, spi_master_tb);
		repeat (50) begin
			repeat (5000) @(posedge clock);
			$display("+5000 cycles");
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
	    wait(checkbits === 16'hA040);
			`ifdef GL
            	$display("Monitor: Test SPI Master (GL) Started");
			`else
			    $display("Monitor: Test SPI Master (RTL) Started");
			`endif		
	    wait(checkbits === 16'hA041);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x93)", spivalue);
				if(spivalue !== 32'h93) begin
					$display("Monitor: Test SPI Master Failed");
					#1000 $finish;
				end
			end
	    wait(checkbits === 16'hA042);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x01)", spivalue);
				if(spivalue !== 32'h01) begin
					$display("Monitor: Test SPI Master Failed");
					#1000 $finish;
				end
			end
	    wait(checkbits === 16'hA043);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x00)", spivalue);
				if(spivalue !== 32'h00) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
            	end
			end
	    wait(checkbits === 16'hA044);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x13)", spivalue);
				if(spivalue !== 32'h13) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end 
	    wait(checkbits === 16'hA045);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x02)", spivalue);
				if(spivalue !== 32'h02) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA046);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x63)", spivalue);
				if(spivalue !== 32'h63) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA047);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x57)", spivalue);
				if(spivalue !== 32'h57) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA048);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0xb5)", spivalue);
				if(spivalue !== 32'hb5) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA049);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x00)", spivalue);
				if(spivalue !== 32'h00) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA04a);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x23)", spivalue);
				if(spivalue !== 32'h23) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA04b);
			@(posedge clock) begin
				$display("   SPI value = 0x%x (should be 0x20)", spivalue);
				if(spivalue !== 32'h20) begin
					$display("Monitor: Test SPI Master Failed");
					$finish;
				end
			end
	    wait(checkbits === 16'hA090);
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

	mgmt_core_wrapper uut (
	`ifdef USE_POWER_PINS
		.VPWR		  (VDD1V8),
		.VGND		  (VSS),
	`endif
		.core_clk	  (clock),
		.core_rstn	  (RSTB),
        .debug_in(1'b0),
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
		.ser_rx(1'b1),
		.ser_tx(),
		.qspi_enabled(),
		.spi_sck(spi_clk),
	    .spi_csb(spi_cs_n),
        .spi_sdo(spi_miso),
        .spi_sdi(spi_mosi),
        .spi_sdoenb(spi_sdoenb),
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
		.FILENAME("test_data")
	) test_spi (
		.csb(spi_cs_n),
		.clk(spi_clk),
		.io0(spi_miso),
		.io1(spi_mosi),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
