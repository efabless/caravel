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
/* Since there is only one voltage domain on the GF180MCU version of	*/
/* caravel, this consists mainly of protecting against unconnected	*/
/* inputs.								*/
/*----------------------------------------------------------------------*/
/* 11/24/2022:  Removed tri-state buffers in favor of AND gates; i.e.,	*/
/* outputs from the management SoC, when disabled, will drive value	*/
/* zero instead of tristating.						*/
/*----------------------------------------------------------------------*/

module mgmt_protect (
`ifdef USE_POWER_PINS
    inout	  VDD,
    inout	  VSS,
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

    output [63:0] la_data_in_mprj,
    input  [63:0] la_data_out_mprj,
    input  [63:0] la_oenb_mprj,
    input  [63:0] la_iena_mprj,

    input  [63:0] la_data_out_core,
    output [63:0] la_data_in_core,
    output [63:0] la_oenb_core,

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
    output [2:0]  user_irq
);

	wire [63:0] la_data_in_mprj_bar;
	wire [2:0] user_irq_bar;

	wire [63:0] la_data_in_enable;
	wire [63:0] la_data_out_enable;
	wire [2:0] user_irq_enable;
	wire 	   wb_in_enable;

	wire [31:0] mprj_dat_i_core_bar;
	wire 	    mprj_ack_i_core_bar;

	// Buffering from the user side to the management side.
	// NOTE:  This is intended to be better protected, by a full
	// chain of an lv-to-hv buffer followed by an hv-to-lv buffer.
	// This serves as a placeholder until that configuration is
	// checked and characterized.  The function below forces the
	// data input to the management core to be a solid logic 0 when
	// the user project is powered down.

	assign la_data_in_enable = la_iena_mprj;

	gf180mcu_fd_sc_mcu7t5v0__nand2_4 user_to_mprj_in_gates [63:0] (
`ifdef USE_POWER_PINS
                .VDD(VDD),
                .VSS(VSS),
`endif
		.ZN(la_data_in_mprj_bar),
		.A1(la_data_out_core),
		.A2(la_data_in_enable)
	);

	assign la_data_in_mprj = ~la_data_in_mprj_bar;

	// Protection, similar to the above, for the three user IRQ lines

	assign user_irq_enable = user_irq_ena;

	gf180mcu_fd_sc_mcu7t5v0__nand2_4 user_irq_gates [2:0] (
`ifdef USE_POWER_PINS
                .VDD(VDD),
                .VSS(VSS),
`endif
		.ZN(user_irq_bar),
		.A1(user_irq_core),
		.A2(user_irq_enable)
	);

	assign user_irq = ~user_irq_bar;

	// Protection, similar to the above, for the return
	// signals from user area to managment on the wishbone bus

	assign wb_in_enable = mprj_iena_wb;

	gf180mcu_fd_sc_mcu7t5v0__nand2_4 user_wb_dat_gates [31:0] (
`ifdef USE_POWER_PINS
                .VDD(VDD),
                .VSS(VSS),
`endif
		.ZN(mprj_dat_i_core_bar),
		.A1(mprj_dat_i_user),
		.A2(wb_in_enable)
	);

	assign mprj_dat_i_core = ~mprj_dat_i_core_bar;

	gf180mcu_fd_sc_mcu7t5v0__nand2_4 user_wb_ack_gate (
`ifdef USE_POWER_PINS
                .VDD(VDD),
                .VSS(VSS),
`endif
		.ZN(mprj_ack_i_core_bar),
		.A1(mprj_ack_i_user),
		.A2(wb_in_enable)
	);

	assign mprj_ack_i_core = ~mprj_ack_i_core_bar;

	// The remaining assignments are generally non-functional;
	// the original intent was to AND the signals with tie-high
 	// gates from the user project power supply.  As long as the
	// power supplies are not separated on-chip, there is no
	// need for this.
	
	assign user_reset = ~caravel_rstn;
	assign user_clock = caravel_clk;
	assign user_clock2 = caravel_clk2;
	assign mprj_cyc_o_user = mprj_cyc_o_core;
	assign mprj_stb_o_user = mprj_stb_o_core;
	assign mprj_we_o_user = mprj_we_o_core;
	assign mprj_sel_o_user = mprj_sel_o_core;
	assign mprj_adr_o_user = mprj_adr_o_core;
	assign mprj_dat_o_user = mprj_dat_o_core;
	assign la_data_out_enable = ~la_oenb_mprj;

	assign la_data_in_core = la_data_out_mprj & la_data_out_enable;

	assign la_oenb_core = la_oenb_mprj;

endmodule
`default_nettype wire
