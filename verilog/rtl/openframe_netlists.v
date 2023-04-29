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

    `ifdef  EF_STYLE 
	`include "libs.ref/verilog/sky130_fd_io/sky130_fd_io.v"
	`include "libs.ref/verilog/sky130_fd_io/sky130_ef_io.v"

	`include "libs.ref/verilog/sky130_fd_sc_hd/primitives.v"
	`include "libs.ref/verilog/sky130_fd_sc_hd/sky130_fd_sc_hd.v"
	`include "libs.ref/verilog/sky130_fd_sc_hvl/primitives.v"
	`include "libs.ref/verilog/sky130_fd_sc_hvl/sky130_fd_sc_hvl.v"
    `else 
	`include "libs.ref/sky130_fd_io/verilog/sky130_fd_io.v"
	`include "libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"

	`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/sky130_fd_sc_hvl.v"
    `endif 

    `ifdef GL
	`include "gl/user_id_programming.v"
	`include "gl/chip_io_openframe.v"
	`include "gl/constant_block.v"
	`include "gl/xres_buf.v"
	`include "gl/caravel_openframe.v"
    `else
	`include "user_id_programming.v"
	`include "chip_io_openframe.v"
	`include "constant_block.v"
	`include "xres_buf.v"
	`include "caravel_openframe.v"
    `endif

    `include "simple_por.v"

`endif
