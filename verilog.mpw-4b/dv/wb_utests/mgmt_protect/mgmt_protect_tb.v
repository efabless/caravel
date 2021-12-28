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

`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

`include "libs.ref/sky130_fd_sc_hvl/verilog/primitives.v"
`include "libs.ref/sky130_fd_sc_hvl/verilog/sky130_fd_sc_hvl.v"

`include "defines.v"

`ifdef GL
    // Assume default net type to be wire because GL netlists don't have the wire definitions
    `default_nettype wire
    `include "gl/mprj_logic_high.v"
    `include "gl/mprj2_logic_high.v"
    `include "gl/mgmt_protect.v"
    `include "gl/mgmt_protect_hv.v"
`else
    `include "mprj_logic_high.v"
    `include "mprj2_logic_high.v"
    `include "mgmt_protect.v"
    `include "mgmt_protect_hv.v"
`endif 

module mgmt_protect_tb;

    reg caravel_clk;
    reg caravel_clk2;
    reg caravel_rstn;

    reg mprj_cyc_o_core;
    reg mprj_stb_o_core;
    reg mprj_we_o_core;
    reg [31:0] mprj_adr_o_core;
    reg [31:0] mprj_dat_o_core;
    reg [3:0]  mprj_sel_o_core;

    wire [127:0] la_data_in_mprj;
    reg  [127:0] la_data_out_mprj;
    reg  [127:0] la_oenb_mprj;
    reg  [127:0] la_iena_mprj;

    reg  [127:0] la_data_out_core;
    wire [127:0] la_data_in_core;
    wire [127:0] la_oenb_core;

    wire 	  user_clock;
    wire 	  user_clock2;
    wire 	  user_reset;
    wire 	  mprj_cyc_o_user;
    wire 	  mprj_stb_o_user;
    wire 	  mprj_we_o_user;
    wire [3:0]  mprj_sel_o_user;
    wire [31:0] mprj_adr_o_user;
    wire [31:0] mprj_dat_o_user;
    wire	  user1_vcc_powergood;
    wire	  user2_vcc_powergood;
    wire	  user1_vdd_powergood;
    wire	  user2_vdd_powergood;

    always #12.5 caravel_clk  <= (caravel_clk === 1'b0);
	always #12.5 caravel_clk2 <= (caravel_clk2 === 1'b0);

    initial begin
        caravel_clk  = 0;
        caravel_clk2 = 0;
        caravel_rstn = 0;

        mprj_cyc_o_core = 0;
        mprj_stb_o_core = 0;
        mprj_we_o_core  = 0;
        mprj_adr_o_core = 0;
        mprj_dat_o_core = 0;
        mprj_sel_o_core = 0;

        la_data_out_mprj = 0;
        la_oenb_mprj      = 0;
        la_data_out_core = 0;
    end

    reg USER_VDD3V3;
    reg USER_VDD1V8;
    reg VDD3V3;
    reg VDD1V8;
    
    wire VCCD;      // Management/Common 1.8V power
    wire VSSD;      // Common digital ground
  
    wire VCCD1;     // User area 1 1.8V power
	wire VSSD1;     // User area 1 digital ground
	wire VCCD2;     // User area 2 1.8V power
	wire VSSD2;     // User area 2 digital ground

	wire VDDA1;     // User area 1 3.3V power
	wire VSSA1;     // User area 1 analog ground
    wire VDDA2; 	// User area 2 3.3V power
	wire VSSA2;     // User area 2 analog ground

    assign VCCD = VDD1V8;
	assign VSSD  = 1'b0;

    assign VCCD1 = USER_VDD1V8;
	assign VSSD1 = 1'b0;
    
    assign VCCD2 = USER_VDD1V8;
	assign VSSD2 = 1'b0;

    assign VDDA1 = USER_VDD3V3;
	assign VSSA1 = 1'b0;

    assign VDDA2 = USER_VDD3V3;
	assign VSSA2 = 1'b0;

	initial begin	// Power-up sequence
        VDD1V8      <= 1'b0;
		USER_VDD3V3 <= 1'b0;
		USER_VDD1V8 <= 1'b0;
		#200;
		VDD1V8 <= 1'b1;
		#200;
        USER_VDD3V3 <= 1'b1;
		#200;
    	USER_VDD1V8 <= 1'b1;
	end

    initial begin
        $dumpfile("mgmt_protect.vcd");
        $dumpvars(0, mgmt_protect_tb);
        #(`SIM_TIME);
        $display("%c[1;31m",27);
        $display ("Monitor: Timeout, Test Management Protect Failed");
        $display("%c[0m",27);
        $finish;
    end

    integer i;

    initial begin
        caravel_rstn = 1'b1;
        mprj_cyc_o_core = 1'b1;
        mprj_stb_o_core = 1'b1;
        mprj_we_o_core = 1'b1;
        mprj_sel_o_core = 4'b1010;
        mprj_adr_o_core = 32'hF0F0;
        mprj_dat_o_core = 32'h0F0F;
        la_data_out_mprj = 128'hFFFF_FFFF_FFFF_FFFF;
        la_oenb_mprj = 128'h0000_0000_0000_0000;
        la_data_out_core = 128'h0F0F_FFFF_F0F0_FFFF;
        la_iena_mprj  = 128'hFFFF_FFFF_FFFF_FFFF;

        wait(user1_vdd_powergood === 1'b1);
        wait(user2_vdd_powergood === 1'b1);
        wait(user1_vcc_powergood === 1'b1);
        wait(user2_vcc_powergood === 1'b1);
        #25;
        if (user_reset !== ~caravel_rstn) begin 
            $display("Monitor: Error on user_reset. "); $finish; 
        end
        if (mprj_cyc_o_user !== mprj_cyc_o_core) begin 
            $display("Monitor: Error on mprj_cyc_o_user. "); $finish; 
        end
        if (mprj_stb_o_user !== mprj_stb_o_core) begin 
            $display("Monitor: Error on mprj_stb_o_user. "); $finish; 
        end
        if (mprj_we_o_user !== mprj_we_o_core) begin 
            $display("Monitor: Error on mprj_we_o_user. "); $finish;
        end
        if (mprj_sel_o_user !== mprj_sel_o_core) begin 
            $display("Monitor: Error on mprj_sel_o_user. "); $finish; 
        end
        if (mprj_adr_o_user !== mprj_adr_o_core) begin 
            $display("Monitor: Error on mprj_adr_o_user. "); $finish;
        end
        if (la_data_in_core !== la_data_out_mprj) begin 
            $display("%0h", la_data_in_core);
            $display("Monitor: Error on la_data_in_core. "); $finish;
        end
        if (la_oenb_core !== la_oenb_mprj) begin 
            $display("Monitor: Error on la_oenb_core. "); $finish;
        end
        if (la_data_in_mprj !== la_data_out_core) begin 
            $display("%0h , %0h", la_data_in_mprj, la_data_out_core);
            $display("Monitor: Error on la_data_in_mprj. "); $finish;
        end
        $display ("Success!");
        $display ("Monitor: Test Management Protect Passed");
        $finish;
    end

    mgmt_protect uut (
	`ifdef USE_POWER_PINS
		.vccd(VCCD),
		.vssd(VSSD),
		.vccd1(VCCD1),
		.vssd1(VSSD1),
        .vccd2(VCCD2),
		.vssd2(VSSD2),
		.vdda1(VDDA1),
		.vssa1(VSSA1),
		.vdda2(VDDA2),
		.vssa2(VSSA2),
    `endif

		.caravel_clk (caravel_clk),
		.caravel_clk2(caravel_clk2),
		.caravel_rstn(caravel_rstn),

		.mprj_cyc_o_core(mprj_cyc_o_core),
		.mprj_stb_o_core(mprj_stb_o_core),
		.mprj_we_o_core (mprj_we_o_core),
		.mprj_sel_o_core(mprj_sel_o_core),
		.mprj_adr_o_core(mprj_adr_o_core),
		.mprj_dat_o_core(mprj_dat_o_core),

		.la_data_out_core(la_data_out_core),
		.la_data_in_core (la_data_in_core),
		.la_oenb_core(la_oenb_core),

        .la_data_in_mprj(la_data_in_mprj),
    	.la_data_out_mprj(la_data_out_mprj),
    	.la_oenb_mprj(la_oenb_mprj),
        .la_iena_mprj(la_iena_mprj),

		.user_clock (user_clock),
		.user_clock2(user_clock2),
		.user_reset (user_reset),

		.mprj_cyc_o_user(mprj_cyc_o_user),
		.mprj_stb_o_user(mprj_stb_o_user),
		.mprj_we_o_user (mprj_we_o_user),
		.mprj_sel_o_user(mprj_sel_o_user),
		.mprj_adr_o_user(mprj_adr_o_user),
		.mprj_dat_o_user(mprj_dat_o_user),

		.user1_vcc_powergood(user1_vcc_powergood),
		.user2_vcc_powergood(user2_vcc_powergood),
		.user1_vdd_powergood(user1_vdd_powergood),
		.user2_vdd_powergood(user2_vdd_powergood)
	);

endmodule