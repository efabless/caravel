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
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

// Dummy assignments so that we can take it through the openlane flow
`ifndef GPIO_TESTING
`ifdef SIM
// Needed for running GL simulation
assign io_out = 0;
assign io_oeb = 0;
`else
assign io_out = io_in;
`endif
`endif // GPIO_TESTING

`ifdef LA_TESTING
user_project_la_example la_testing(la_data_in,la_data_out,la_oenb);
`endif

// splitting the address space to user address space and debug address space 
// debug address space are the last 2 registers of user_project_wrapper address space
wire wbs_cyc_i_user;
wire  wbs_ack_o_user;
wire [31:0] wbs_dat_o_user;

wire  wbs_cyc_i_debug;
wire wbs_ack_o_debug;
`ifdef GPIO_TESTING
wire wbs_ack_o_gpio;
wire [31:0] wbs_dat_o_gpio;
`endif
wire [31:0] wbs_dat_o_debug;

// reserve the last 2 regs for debugging registers
// `ifndef GPIO_TESTING
assign wbs_cyc_i_user  = (wbs_adr_i[31:3] != 29'h601FFFF) ? wbs_cyc_i : 0; 
assign wbs_cyc_i_debug = (wbs_adr_i[31:3] == 29'h601FFFF) ? wbs_cyc_i : 0; 
// `endif


// `ifndef GPIO_TESTING
assign wbs_ack_o = (wbs_adr_i[31:3] == 28'h601FFFF) ? wbs_ack_o_debug : wbs_ack_o_user; 
assign wbs_dat_o = (wbs_adr_i[31:3] == 28'h601FFFF) ? wbs_dat_o_debug : wbs_dat_o_user; 
// `endif

`ifndef GPIO_TESTING
assign wbs_ack_o_user = 0;
`endif
// // reserve the last 4 regs for debugging registers in case of user gpio testing 
// `ifdef GPIO_TESTING
// assign wbs_cyc_i_user  = (wbs_adr_i[31:4] != 28'h300FFFF) ? wbs_cyc_i : 0; 
// assign wbs_cyc_i_debug = (wbs_adr_i[31:4] == 28'h300FFFF) ? wbs_cyc_i : 0; 
// `endif

// `ifdef GPIO_TESTING
// assign wbs_ack_o = (wbs_adr_i[31:4] == 28'h300FFFF) ? (wbs_adr_i[3:0]>=4'h8) ? wbs_ack_o_debug : wbs_ack_o_gpio  : wbs_ack_o_debug; 
// assign wbs_dat_o = (wbs_adr_i[31:4] == 28'h300FFFF) ? (wbs_adr_i[3:0]>=4'h8) ? wbs_dat_o_debug : wbs_dat_o_gpio : wbs_dat_o_user; 
// `endif


`ifdef GPIO_TESTING
user_project_gpio_example gpio_testing(
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_cyc_i(wbs_cyc_i_user),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_ack_o(wbs_ack_o_user),
    .wbs_dat_o(wbs_dat_o_user), 
    .io_in(io_in),
    .io_out(io_out),
    .io_oeb(io_oeb));
`endif

debug_regs debug(
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wbs_cyc_i(wbs_cyc_i_debug),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_ack_o(wbs_ack_o_debug),
    .wbs_dat_o(wbs_dat_o_debug)
);

endmodule	// user_project_wrapper
