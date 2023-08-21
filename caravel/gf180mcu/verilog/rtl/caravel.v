`ifdef SIM
 `default_nettype wire
 `endif
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

/*--------------------------------------------------------------*/
/* caravel, a project harness for the Google/GF GF180MCU	*/
/* fabrication process and open source PDK			*/
/*                                                          	*/
/* Copyright 2020 efabless, Inc.                            	*/
/* Written by Tim Edwards, December 2019                    	*/
/* and Mohamed Shalan, August 2020			    	*/
/* This file is open source hardware released under the     	*/
/* Apache 2.0 license.  See file LICENSE.                   	*/
/*								*/
/* Updated 10/15/2021:  Revised using the housekeeping module	*/
/* from housekeeping.v (refactoring a number of functions from	*/
/* the management SoC).						*/
/* Updated 05/26/2022:  Revised for the GF180MCU process.	*/
/*                                                          	*/
/*--------------------------------------------------------------*/    
	
module caravel (
	`ifdef USE_POWER_PINS
    inout VDD,		// Common 5.0V padframe/ESD power
    inout VSS,		// Common padframe/ESD ground
	`endif
    inout gpio,		// Used for external LDO control
    inout [`MPRJ_IO_PADS-1:0] mprj_io,
    input clock,    	// CMOS core clock input, not a crystal
    input resetb,	// Reset input (sense inverted)

    // Note that only two flash data pins are dedicated to the
    // management SoC wrapper.  The management SoC exports the
    // quad SPI mode status to make use of the top two mprj_io
    // pins for io2 and io3.

    inout flash_csb,
    inout flash_clk,
    inout flash_io0,
    inout flash_io1
    );

    wire clock_core;
    wire rstb;

    // Flash SPI communication (
    wire flash_clk_frame;
    wire flash_csb_frame;
    wire flash_clk_oe, flash_csb_oe;
    wire flash_clk_ie, flash_csb_ie;
    wire flash_io0_oe, flash_io1_oe;
    wire flash_io0_ie, flash_io1_ie;
    wire flash_io0_do,  flash_io1_do;
    wire flash_io0_di,  flash_io1_di;

    // One-bit GPIO dedicated to management SoC (outside of user control)
    wire gpio_out_core;
    wire gpio_in_core;
    wire gpio_pu_select_core;
    wire gpio_pd_select_core;
    wire gpio_schmitt_select_core;
    wire gpio_slew_select_core;
    wire [1:0] gpio_drive_select_core;
    wire gpio_outenb_core;
    wire gpio_inenb_core;

    // User Project Control (pad-facing)
    wire [`MPRJ_IO_PADS-1:0] mprj_io_ie;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_oe;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_schmitt_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_slew_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_pullup_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_pulldown_sel;
    wire [`MPRJ_IO_PADS*2-1:0] mprj_io_drive_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_in;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_out;


    // Constant value inputs for chip_io (taken from control
    // blocks and routed during top-level routing)
    wire [9:0] const_zero;
    wire [1:0] const_one;

    chip_io padframe(
	// Package Pins
`ifdef USE_POWER_PINS
	.vdd	(VDD),		// Common padframe/ESD supply
	.vss	(VSS),		// Common digital ground
`endif
	.gpio_pu_select(const_zero[7]),
	.gpio_pd_select(const_zero[8]),
	.gpio_schmitt_select(const_zero[6]),
	.gpio_slew_select(const_zero[9]),
	//
	.gpio(gpio),
	.mprj_io(mprj_io),
	.clock(clock),
	.resetb(resetb),
	.flash_csb(flash_csb),
	.flash_clk(flash_clk),
	.flash_io0(flash_io0),
	.flash_io1(flash_io1),

	// SoC Core Interface
	.resetb_core(rstb),
	.clock_core(clock_core),
	.gpio_out_core(gpio_out_core),
	.gpio_in_core(gpio_in_core),
	// NOTE:  This redefines GPIO outenb/inenb;  effectively,
	// that is a documentation issue.
	.gpio_outen_core(gpio_outenb_core),
	.gpio_inen_core(gpio_inenb_core),
	// NOTE: mode0, mode1 mapped to drive select.
	// Would be nice to redefine the mgmt_core_wrapper
	// to export PU, PD, SC, and SL.
	.gpio_drive_select_core(gpio_drive_select_core),

	.flash_csb_core(flash_csb_frame),
	.flash_clk_core(flash_clk_frame),
	.flash_csb_oe_core(flash_csb_oe),
	.flash_clk_oe_core(flash_clk_oe),
	.flash_io0_oe_core(flash_io0_oe),
	.flash_io1_oe_core(flash_io1_oe),
	.flash_io0_ie_core(flash_io0_ie),
	.flash_io1_ie_core(flash_io1_ie),
	.flash_io0_do_core(flash_io0_do),
	.flash_io1_do_core(flash_io1_do),
	.flash_io0_di_core(flash_io0_di),
	.flash_io1_di_core(flash_io1_di),
	.mprj_io_in(mprj_io_in),
	.mprj_io_out(mprj_io_out),
	.mprj_io_outen(mprj_io_oe),
	.mprj_io_inen(mprj_io_ie),
	.mprj_io_schmitt_select(mprj_io_schmitt_sel),
	.mprj_io_pu_select(mprj_io_pullup_sel),
	.mprj_io_pd_select(mprj_io_pulldown_sel),
	.mprj_io_slew_select(mprj_io_slew_sel),
	.mprj_io_drive_sel(mprj_io_drive_sel),

	// constant value inputs
	.const_zero(const_zero[5:0]),
	.const_one(const_one)
    );

    caravel_core chip_core (
`ifdef USE_POWER_PINS
    .VDD	(VDD),		// Common padframe/ESD supply
    .VSS	(VSS),		// Common digital ground
`endif
    // SoC Core Interface
	.rstb(rstb),
    .clock_core(clock_core),
	.gpio_out_core(gpio_out_core),
	.gpio_in_core(gpio_in_core),
	// NOTE:  This redefines GPIO outenb/inenb;  effectively,
	// that is a documentation issue.
	.gpio_outenb_core(gpio_outenb_core),
	.gpio_inenb_core(gpio_inenb_core),
	// NOTE: mode0, mode1 mapped to drive select.
	// Would be nice to redefine the mgmt_core_wrapper
	// to export PU, PD, SC, and SL.
	.gpio_drive_select_core(gpio_drive_select_core),

	.flash_csb_frame(flash_csb_frame),
	.flash_clk_frame(flash_clk_frame),
	.flash_csb_oe(flash_csb_oe),
	.flash_clk_oe(flash_clk_oe),
	.flash_io0_oe(flash_io0_oe),
	.flash_io1_oe(flash_io1_oe),
	.flash_io0_ie(flash_io0_ie),
	.flash_io1_ie(flash_io1_ie),
	.flash_io0_do(flash_io0_do),
	.flash_io1_do(flash_io1_do),
	.flash_io0_di(flash_io0_di),
	.flash_io1_di(flash_io1_di),
	.mprj_io_in(mprj_io_in),
	.mprj_io_out(mprj_io_out),
	.mprj_io_oe(mprj_io_oe),
	.mprj_io_ie(mprj_io_ie),
	.mprj_io_schmitt_sel(mprj_io_schmitt_sel),
	.mprj_io_pullup_sel(mprj_io_pullup_sel),
	.mprj_io_pulldown_sel(mprj_io_pulldown_sel),
	.mprj_io_slew_sel(mprj_io_slew_sel),
	.mprj_io_drive_sel(mprj_io_drive_sel),

	.const_zero(const_zero),
	.const_one(const_one)
    );

	caravel_power_routing caravel_power_routing ();

    copyright_block copyright_block();
    caravel_logo caravel_logo();
    caravel_motto caravel_motto();
    open_source open_source();
    user_id_textblock user_id_textblock();

    endmodule
