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

`define UNIT_DELAY #1
`define USE_POWER_PINS
`define SIM_TIME 100_000

`include "libs.ref/sky130_fd_io/verilog/sky130_fd_io.v"
`include "libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"
`include "libs.ref/sky130_fd_io/verilog/sky130_ef_io__gpiov2_pad_wrapped.v"

`include "defines.v"

`ifdef GL
    `include "gl/chip_io.v"
`else
    `ifdef SPLIT_BUS
        `include "ports.v"
        `include "chip_io_split.v"
    `else
        `include "pads.v"
        `include "mprj_io.v"
        `include "chip_io.v"
    `endif
`endif 

module chip_io_tb;
    
    wire clock_core;
    reg clock;

    wire rstb_h;
    reg RSTB;
    
    reg porb_h;
    wire por_l;

    wire gpio;
    reg gpio_out_core;
    reg gpio_inenb_core;
    reg gpio_outenb_core;

    wire flash_csb;
    reg flash_csb_core;
    reg flash_csb_ieb_core;        
    reg flash_csb_oeb_core; 
    
    wire flash_clk;
    reg flash_clk_core;
    reg flash_clk_ieb_core;       
    reg flash_clk_oeb_core; 

    wire flash_io0;
    wire flash_io0_di_core;
    reg flash_io0_do_core;
    reg flash_io0_ieb_core;
    reg flash_io0_oeb_core;

    wire flash_io1;
    wire flash_io1_di_core;
    reg flash_io1_do_core;
    reg flash_io1_ieb_core;
    reg flash_io1_oeb_core;
    
    wire gpio_in_core;
    wire gpio_mode0_core;
    wire gpio_mode1_core;

    wire [`MPRJ_IO_PADS-1:0] mprj_io;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_inp_dis;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_oeb;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_ib_mode_sel;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_vtrip_sel;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_slow_sel;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_holdover;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_analog_en;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_analog_sel;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_analog_pol;
    reg [`MPRJ_IO_PADS*3-1:0] mprj_io_dm;
    reg [`MPRJ_IO_PADS-1:0] mprj_io_out;
    
    wire [`MPRJ_IO_PADS-1:0] mprj_io_in;
    wire [`MPRJ_IO_PADS-10:0] mprj_analog_io;

    always #12.5 clock <= (clock === 1'b0);

    initial begin
        clock  = 0;
        porb_h = 0;
        flash_csb_core = 0;
        flash_csb_ieb_core = 1;
        flash_csb_oeb_core = 0;
        flash_clk_ieb_core = 1;
        flash_clk_oeb_core = 0;
        mprj_io_ib_mode_sel = {38{1'b0}};
        mprj_io_vtrip_sel = {38{1'b0}};
        mprj_io_slow_sel  = {38{1'b0}};
        mprj_io_holdover  = {38{1'b0}};
        mprj_io_analog_en  = {38{1'b0}};
        mprj_io_analog_sel = {38{1'b0}};
        mprj_io_analog_pol = {38{1'b0}};
    end

    wire VDD3V3;
	wire VDD1V8;
	wire VSS;

	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;
	
    reg power1, power2;

    initial begin
		RSTB   <= 1'b0;
        porb_h <= 1'b0;
        #500;
        porb_h <= 1'b1;
		#500;
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

    initial begin
        $dumpfile("chip_io.vcd");
        $dumpvars(0, chip_io_tb);
        #(`SIM_TIME);
        $display("%c[1;31m",27);
        $display ("Monitor: Timeout, Test Management Protect Failed");
        $display("%c[0m",27);
        $finish;
    end

    integer i;

    reg [2:0] dm_all;
    reg gpio_bit;
    
    assign gpio = gpio_bit;
    assign gpio_mode0_core = dm_all[0];
    assign gpio_mode1_core = dm_all[1];

    reg flash_io0_bit;
    reg flash_io1_bit;

    assign flash_io0 = flash_io0_bit;
    assign flash_io1 = flash_io1_bit;

    reg [`MPRJ_IO_PADS-1:0] mprj_io_bits;

    assign mprj_io = mprj_io_bits;

    initial begin
        wait(RSTB == 1'b1);        // wait for reset 
        #25;
        // Clock & Reset Pads 
        if (clock !== clock_core) begin
            $display("Error: Clock Pad Test Failed."); $finish; 
        end
        if (RSTB !== rstb_h) begin
            $display("Error: Reset Pad Test Failed."); $finish; 
        end
        
        // Management GPIO Pad
        gpio_bit = 1'b1;
        gpio_out_core = 1'b0;  
        gpio_inenb_core = 1'b0;
        gpio_outenb_core = 1'b1;
        dm_all = 3'b001;            // input-only
        #25;
        if (gpio_in_core !== gpio) begin
            $display("Error: GPIO Pad Input Test Failed."); $finish;
        end

        gpio_bit = 1'bz;
        gpio_out_core    = 1'b1;   
        gpio_inenb_core  = 1'b1;
        gpio_outenb_core = 1'b0;
        dm_all = 3'b110;            // output-only
        #25;
        if (gpio_out_core !== gpio) begin
            $display("Error: GPIO Pad Output Test Failed."); $finish;
        end

        // Flash Output Pads
        flash_csb_core = 1'b1;        // CSB Pad
        #25;
        if (flash_csb !== flash_csb_core) begin
            $display("Error: Flash CSB Pad Test Failed."); $finish;
        end

        flash_clk_core = 1'b1;         // CLK Pad
        #25;
        if (flash_clk !== flash_clk_core) begin
            $display("Error: Flash CLK Pad Test Failed."); $finish;
        end

        // Flash Inout Pads
        flash_io0_bit = 1'b1;            
        flash_io0_ieb_core = 1'b0;     // Input
        flash_io0_oeb_core = 1'b1;
        #25;
        if (flash_io0_di_core !== flash_io0_bit) begin
            $display("Error: Flash io0 Pad Input Test Failed."); $finish;
        end

        flash_io0_bit = 1'bz;   
        flash_io0_do_core = 1'b1;       
        flash_io0_ieb_core = 1'b1;     
        flash_io0_oeb_core = 1'b0;    // Output
        #25
        if (flash_io0 !== flash_io0_do_core) begin
            $display("Error: Flash io0 Pad Output Test Failed."); $finish;
        end

        // User Project Pads - All Outputs
        mprj_io_bits = {38{1'bz}};
        mprj_io_out = {6'b10101, 32'hF0F0};
        mprj_io_oeb = {38{1'b0}};
        mprj_io_inp_dis = {38{1'b1}};
        mprj_io_dm = {38*3{3'b110}};

        #25;
        if (mprj_io !== mprj_io_out) begin
            $display("Error: User Project Pads Output Test Failed."); $finish;
        end
        
        // User Project Pads - All Inputs
        mprj_io_bits = {6'b01010, 32'hFF0F};
        mprj_io_out  = {38{1'b0}};
        mprj_io_oeb  = {38{1'b1}};
        mprj_io_inp_dis = {38{1'b0}};
        mprj_io_dm = {38*3{3'b001}};

        #25;
        if (mprj_io_in !== mprj_io_bits) begin
            $display("Error: User Project Pads Input Test Failed."); $finish;
        end
        
        // User Project Pads - All Bidirectional
        mprj_io_bits = {6'b01010, 32'hF00F};  // drive input signal
        mprj_io_out  = {38{1'bz}}; 
        mprj_io_oeb  = {38{1'b1}};
        mprj_io_inp_dis = {38{1'b0}};
        mprj_io_dm = {38{3'b110}};

        #25;
        if (mprj_io_in !== mprj_io_bits) begin
            $display("Error: User Project Pads Bidirectional Test Failed."); $finish;
        end
        
        mprj_io_bits = {38{1'bz}};  
        mprj_io_out  = {6'b01110, 32'h0FF0};  // drive output signal
        mprj_io_oeb  = {38{1'b0}};
        mprj_io_inp_dis = {38{1'b0}};
        mprj_io_dm = {38{3'b110}};

        #25;
        if (mprj_io !== mprj_io_out) begin
            $display("Error: User Project Pads Output Test Failed."); $finish;
        end
        $display("Success");
        $display("Monitor: Chip IO Test Passed.");
        #2000;
        $finish;
    end

    assign por_l = ~porb_h;

    chip_io uut (
        // Package Pins
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

        .gpio(gpio),
        .clock(clock),
        .resetb(RSTB),
        .flash_csb(flash_csb),
        .flash_clk(flash_clk),
        .flash_io0(flash_io0),
        .flash_io1(flash_io1),
        // SoC Core Interface
        .porb_h(porb_h),
        .por(por_l),
        .resetb_core_h(rstb_h),
        .clock_core(clock_core),
        .gpio_out_core(gpio_out_core),
        .gpio_in_core(gpio_in_core),
        .gpio_mode0_core(gpio_mode0_core),
        .gpio_mode1_core(gpio_mode1_core),
        .gpio_outenb_core(gpio_outenb_core),
        .gpio_inenb_core(gpio_inenb_core),
        .flash_csb_core(flash_csb_core),
        .flash_clk_core(flash_clk_core),
        .flash_csb_oeb_core(flash_csb_oeb_core),
        .flash_clk_oeb_core(flash_clk_oeb_core),
        .flash_io0_oeb_core(flash_io0_oeb_core),
        .flash_io1_oeb_core(flash_io1_oeb_core),
        .flash_csb_ieb_core(flash_csb_ieb_core),
        .flash_clk_ieb_core(flash_clk_ieb_core),
        .flash_io0_ieb_core(flash_io0_ieb_core),
        .flash_io1_ieb_core(flash_io1_ieb_core),
        .flash_io0_do_core(flash_io0_do_core),
        .flash_io1_do_core(flash_io1_do_core),
        .flash_io0_di_core(flash_io0_di_core),
        .flash_io1_di_core(flash_io1_di_core),        
 `ifdef SPLIT_BUS
        `MPRJ_IO,
        `MPRJ_IO_IN,
        `MPRJ_IO_OUT,
        `MPRJ_IO_OEB,
        `MPRJ_IO_INP_DIS,
        `MPRJ_IO_IB_MODE_SEL,
        `MPRJ_IO_VTRIP_SEL,
        `MPRJ_IO_SLOW_SEL,
        `MPRJ_IO_HOLDOVER,
        `MPRJ_IO_ANALOG_EN,
        `MPRJ_IO_ANALOG_SEL,
        `MPRJ_IO_ANALOG_POL,
        `MPRJ_IO_DM,
        `MPRJ_IO_ANALOG
 `else
        .mprj_io(mprj_io),
        .mprj_io_in(mprj_io_in),
        .mprj_io_out(mprj_io_out),
        .mprj_io_oeb(mprj_io_oeb),
        .mprj_io_inp_dis(mprj_io_inp_dis),
        .mprj_io_ib_mode_sel(mprj_io_ib_mode_sel),
        .mprj_io_vtrip_sel(mprj_io_vtrip_sel),
        .mprj_io_slow_sel(mprj_io_slow_sel),
        .mprj_io_holdover(mprj_io_holdover),
        .mprj_io_analog_en(mprj_io_analog_en),
        .mprj_io_analog_sel(mprj_io_analog_sel),
        .mprj_io_analog_pol(mprj_io_analog_pol),
        .mprj_io_dm(mprj_io_dm),
        .mprj_analog_io(mprj_analog_io)
`endif
    );

endmodule
