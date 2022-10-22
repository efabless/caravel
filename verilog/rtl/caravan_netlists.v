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

`timescale 1 ns / 1 ps

`define UNIT_DELAY #1
`define USE_POWER_PINS

`ifdef SIM

    `include "defines.v"
    `include "user_defines.v"
    `include "pads.v"

    /* NOTE: Need to pass the PDK root directory to iverilog with option -I */
    `ifdef EF_STYLE // efabless style pdk installation; mainly for open galaxy users
	`include "libs.ref/verilog/sky130_fd_io/sky130_fd_io.v"
	`include "libs.ref/verilog/sky130_fd_io/sky130_ef_io.v"

	`include "libs.ref/verilog/sky130_fd_sc_hd/primitives.v"
	`include "libs.ref/verilog/sky130_fd_sc_hd/sky130_fd_sc_hd.v"
	`include "libs.ref/verilog/sky130_fd_sc_hvl/primitives.v"
	`include "libs.ref/verilog/sky130_fd_sc_hvl/sky130_fd_sc_hvl.v"
	`include "libs.ref/verilog/sky130_sram_macros/sky130_sram_2kbyte_1rw1r_32x512_8.v"
    `else 
	`include "libs.ref/sky130_fd_io/verilog/sky130_fd_io.v"
	`include "libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"

	`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/sky130_fd_sc_hvl.v"
	`include "libs.ref/sky130_sram_macros/verilog/sky130_sram_2kbyte_1rw1r_32x512_8.v"
    `endif 

    `ifdef GL
	// Assume default net type to be wire because GL netlists don't have the wire
	// definitions
	`default_nettype wire
	`include "gl/digital_pll.v"
	`include "gl/caravel_clocking.v"
	`include "gl/user_id_programming.v"
	`include "gl/chip_io_alt.v"
	`include "gl/housekeeping.v"
	`include "gl/mprj_logic_high.v"
	`include "gl/mprj2_logic_high.v"
	`include "gl/mgmt_protect.v"
	`include "gl/mgmt_protect_hv.v"
	`include "gl/constant_block.v"
	`include "gl/gpio_control_block.v"
	`include "gl/gpio_defaults_block.v"
	`include "gl/gpio_defaults_block_0403.v"
	`include "gl/gpio_defaults_block_1803.v"
	`include "gl/gpio_defaults_block_0801.v"
	`include "gl/gpio_signal_buffering_alt.v"
	`include "gl/gpio_logic_high.v"
	`include "gl/xres_buf.v"
	`include "gl/spare_logic_block.v"
	`include "gl/mgmt_defines.v"
	`include "gl/mgmt_core_wrapper.v"
	`include "gl/caravan.v"
    `else
	`include "digital_pll.v"
	`include "digital_pll_controller.v"
	`include "ring_osc2x13.v"
	`include "caravel_clocking.v"
	`include "user_id_programming.v"
	`include "clock_div.v"
	`include "mprj_io.v"
	`include "chip_io_alt.v"
	`include "housekeeping_spi.v"
	`include "housekeeping.v"
	`include "mprj_logic_high.v"
	`include "mprj2_logic_high.v"
	`include "mgmt_protect.v"
	`include "mgmt_protect_hv.v"
	`include "constant_block.v"
	`include "gpio_control_block.v"
	`include "gpio_defaults_block.v"
	`include "gpio_signal_buffering_alt.v"
	`include "gpio_logic_high.v"
	`include "xres_buf.v"
	`include "spare_logic_block.v"
	`include "mgmt_core_wrapper.v"
	`include "caravan.v"
    `endif

    `include "simple_por.v"

`endif
