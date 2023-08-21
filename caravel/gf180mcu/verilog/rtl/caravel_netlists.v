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

    /* NOTE: Need to pass the PDK root directory to iverilog with option -I */
	`default_nettype wire
    `ifdef  EF_STYLE 
	`include "libs.ref/verilog/gf180mcu_fd_io/gf180mcu_fd_io.v"
	`include "libs.ref/verilog/gf180mcu_fd_sc_mcu7t5v0/gf180mcu_fd_sc_mcu7t5v0.v"
	`include "libs.ref/verilog/gf180mcu_fd_ip_sram/gf180mcu_fd_ip_sram__sram512x8m8wm1.v"
    `else 
	`include "libs.ref/gf180mcu_fd_io/verilog/gf180mcu_fd_io.v"
	`include "libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v"
	`include "libs.ref/gf180mcu_fd_ip_sram/verilog/gf180mcu_fd_ip_sram__sram512x8m8wm1.v"
    `endif 

	`default_nettype none

    `ifdef GL
	`include "gl/digital_pll.v"
	`include "gl/caravel_clocking.v"
	`include "gl/user_id_programming.v"
	`include "gl/chip_io.v"
	`include "gl/housekeeping.v"
	`include "gl/mgmt_protect.v"
	`include "gl/gpio_control_block.v"
	`include "gl/gpio_defaults_block.v"
	`include "gl/gpio_defaults_block_007.v"
	`include "gl/gpio_defaults_block_009.v"
	`include "gl/spare_logic_block.v"
	`include "gl/mgmt_defines.v"
	`include "gl/GF180_RAM_512x32.v"
	`include "gl/mgmt_core_wrapper.v"
	`include "gl/caravel.v"
    `else
	`include "digital_pll.v"
	`include "digital_pll_controller.v"
	`include "ring_osc2x13.v"
	`include "caravel_clocking.v"
	`include "user_id_programming.v"
	`include "clock_div.v"
	// `include "mprj_io.v"
	`include "chip_io.v"
	`include "housekeeping_spi.v"
	`include "housekeeping.v"
	`include "mgmt_protect.v"
	`include "gpio_control_block.v"
	`include "gpio_defaults_block.v"
	`include "spare_logic_block.v"
	`include "mgmt_core_wrapper.v"
	`include "mgmt_core.v"
	`include "GF180_RAM_512x32.v"
	`include "VexRiscv_MinDebugCache.v"
	`include "caravel.v"
    `endif

    `include "simple_por.v"

`endif
