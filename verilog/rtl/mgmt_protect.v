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
/*----------------------------------------------------------------------*/
/* Buffers protecting the management region from the user region.	*/
/* This mainly consists of tristate buffers that are enabled by a	*/
/* "logic 1" output connected to the user's VCCD domain.  This ensures	*/
/* that the buffer is disabled and the output high-impedence when the	*/
/* user 1.8V supply is absent.						*/
/*----------------------------------------------------------------------*/
/* Because there is no tristate buffer with a non-inverted enable, a	*/
/* tristate inverter with non-inverted enable is used in series with	*/
/* another (normal) inverter.						*/
/*----------------------------------------------------------------------*/
/* For the sake of placement/routing, one conb (logic 1) cell is used	*/
/* for every buffer.							*/
/*----------------------------------------------------------------------*/
/* 10/3/2022:  Removed tri-state buffers in favor of AND gates;  i.e.,	*/
/* if the user project is powered down, then the outputs are grounded	*/
/* rather than tristated.  Other explicitly-referenced gates removed	*/
/* with the assumption that all outputs will be buffered as needed by	*/
/* the synthesis tools.  Therefore the only restrictions needed on the	*/
/* synthesis tools is the list of input signals that must not be	*/
/* buffered because they are allowed to be floating.			*/
/*----------------------------------------------------------------------*/

module mgmt_protect (
`ifdef USE_POWER_PINS
    inout	  vccd,
    inout	  vssd,
    inout	  vccd1,
    inout	  vssd1,
    inout	  vccd2,
    inout	  vssd2,
    inout	  vdda1,
    inout	  vssa1,
    inout	  vdda2,
    inout	  vssa2,
`endif

    input 	  caravel_clk,
    input 	  caravel_clk2,
    input	  caravel_rstn,
    input 	  mprj_cyc_o_core,
    input 	  mprj_stb_o_core,
    input         mprj_we_o_core,
    input [3:0]   mprj_sel_o_core,
    input [31:0]  mprj_adr_o_core,
    input [31:0]  mprj_dat_o_core,
    input [2:0]	  user_irq_core,

    output [31:0] mprj_dat_i_core,
    output	  mprj_ack_i_core,

    input  	  mprj_iena_wb,		// Enable wishbone from user project

    // All signal in/out directions are the reverse of the signal
    // names at the buffer intrface.

    output [127:0] la_data_in_mprj,
    input  [127:0] la_data_out_mprj,
    input  [127:0] la_oenb_mprj,
    input  [127:0] la_iena_mprj,

    input  [127:0] la_data_out_core,
    output [127:0] la_data_in_core,
    output [127:0] la_oenb_core,

    input  [2:0]  user_irq_ena,

    output 	  user_clock,
    output 	  user_clock2,
    output 	  user_reset,
    output 	  mprj_cyc_o_user,
    output 	  mprj_stb_o_user,
    output 	  mprj_we_o_user,
    output [3:0]  mprj_sel_o_user,
    output [31:0] mprj_adr_o_user,
    output [31:0] mprj_dat_o_user,
    input  [31:0] mprj_dat_i_user,
    input	  mprj_ack_i_user,
    output [2:0]  user_irq,
    output	  user1_vcc_powergood,
    output	  user2_vcc_powergood,
    output	  user1_vdd_powergood,
    output	  user2_vdd_powergood
);

	wire [462:0] mprj_logic1;
	wire	     mprj2_logic1;

	wire mprj_vdd_logic1_h;
	wire mprj2_vdd_logic1_h;
	wire mprj_vdd_logic1;
	wire mprj2_vdd_logic1;

	wire user1_vcc_powergood;
	wire user2_vcc_powergood;
	wire user1_vdd_powergood;
	wire user2_vdd_powergood;

	wire [127:0] la_data_in_mprj_bar;
	wire [2:0] user_irq_bar;

	wire [127:0] la_data_in_enable;
	wire [127:0] la_data_out_enable;
	wire [2:0] user_irq_enable;
	wire 	   wb_in_enable;

	wire [31:0] mprj_dat_i_core_bar;
	wire 	    mprj_ack_i_core_bar;

        mprj_logic_high mprj_logic_high_inst (
`ifdef USE_POWER_PINS
                .vccd1(vccd1),
                .vssd1(vssd1),
`endif
                .HI(mprj_logic1)
        );

        mprj2_logic_high mprj2_logic_high_inst (
`ifdef USE_POWER_PINS
                .vccd2(vccd2),
                .vssd2(vssd2),
`endif
                .HI(mprj2_logic1)
        );

	// Logic high in the VDDA (3.3V) domains

	mgmt_protect_hv powergood_check (
`ifdef USE_POWER_PINS
	    .vccd(vccd),
	    .vssd(vssd),
	    .vdda1(vdda1),
	    .vssa1(vssa1),
	    .vdda2(vdda2),
	    .vssa2(vssa2),
`endif
	    .mprj_vdd_logic1(mprj_vdd_logic1),
	    .mprj2_vdd_logic1(mprj2_vdd_logic1)
	);

	// Buffering from the user side to the management side.
	// NOTE:  This is intended to be better protected, by a full
	// chain of an lv-to-hv buffer followed by an hv-to-lv buffer.
	// This serves as a placeholder until that configuration is
	// checked and characterized.  The function below forces the
	// data input to the management core to be a solid logic 0 when
	// the user project is powered down.

	assign la_data_in_enable = la_iena_mprj & mprj_logic1[457:330];

	sky130_fd_sc_hd__nand2_4 user_to_mprj_in_gates [127:0] (
`ifdef USE_POWER_PINS
                .VPWR(vccd),
                .VGND(vssd),
                .VPB(vccd),
                .VNB(vssd),
`endif
		.Y(la_data_in_mprj_bar),
		.A(la_data_out_core),		// may be floating
		.B(la_data_in_enable)
	);

	assign la_data_in_mprj = ~la_data_in_mprj_bar;

	// Protection, similar to the above, for the three user IRQ lines

	assign user_irq_enable = user_irq_ena & mrpj_logic1[460:458];

	sky130_fd_sc_hd__nand2_4 user_irq_gates [2:0] (
`ifdef USE_POWER_PINS
                .VPWR(vccd),
                .VGND(vssd),
                .VPB(vccd),
                .VNB(vssd),
`endif
		.Y(user_irq_bar),
		.A(user_irq_core),		// may be floating
		.B(user_irq_enable)
	);

	assign user_irq = ~user_irq_bar;

	// Protection, similar to the above, for the return
	// signals from user area to managment on the wishbone bus

	assign wb_in_enable = mprj_iena_wb & mprj_logic1[462];

	sky130_fd_sc_hd__nand2_4 user_wb_dat_gates [31:0] (
`ifdef USE_POWER_PINS
                .VPWR(vccd),
                .VGND(vssd),
                .VPB(vccd),
                .VNB(vssd),
`endif
		.Y(mprj_dat_i_core_bar),
		.A(mprj_dat_i_user),		// may be floating
		.B(wb_in_enable)
	);

	assign mprj_dat_i_core = ~mprj_dat_i_core_bar;

	sky130_fd_sc_hd__nand2_4 user_wb_ack_gate (
`ifdef USE_POWER_PINS
                .VPWR(vccd),
                .VGND(vssd),
                .VPB(vccd),
                .VNB(vssd),
`endif
		.Y(mprj_ack_i_core_bar),
		.A(mprj_ack_i_user),		// may be floating
		.B(wb_in_enable)
	);

	assign mprj_ack_i_core = ~mprj_ack_i_core_bar;

	// The remaining circuitry guards against the management
	// SoC dumping current into the user project area when
	// the user project area is powered down.
	
	assign user_reset      = (~caravel_rstn) & mprj_logic1[0]);
	assign user_clock      = caravel_clk     & mprj_logic1[1];
	assign user_clock2     = caravel_clk2    & mprj_logic1[2];
	assign mprj_cyc_o_user = mprj_cyc_o_core & mprj_logic1[3];
	assign mprj_stb_o_user = mprj_stb_o_core & mprj_logic1[4];
	assign mprj_we_o_user  = mprj_we_o_core  & mprj_logic1[5];
	assign mprj_sel_o_user = mprj_sel_o_core & mprj_logic1[9:6];
	assign mprj_adr_o_user = mprj_adr_o_core & mprj_logic1[41:10];
	assign mprj_dat_o_user = mprj_dat_o_core & mprj_logic1[73:42];

	/* Project data out from the managment side to the user project	*/
	/* area when the user project is powered down.			*/

	assign la_data_out_enable = (~la_oenb_mprj) & mprj_logic1[201:74];
	assign la_data_in_core = la_data_out_mprj & la_data_out_enable;

	/* Project data out enable (bar) from the managment side to the	*/
	/* user project	area when the user project is powered down.	*/

	assign la_oenb_core = la_oenb_mprj & mprj_logic1[329:202]);

	/* The conb cell output is a resistive connection directly to	*/
	/* the power supply, so when returning the user1_powergood	*/
	/* signal, make sure that it is buffered properly.		*/

	assign user1_vcc_powergood = mprj_logic1[461];
	assign user2_vcc_powergood = mprj2_logic1;
	assign user1_vdd_powergood = mprj_vdd_logic1;
	assign user2_vdd_powergood = mprj2_vdd_logic1;

endmodule
`default_nettype wire
