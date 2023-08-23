// `default_nettype none
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
/* caravel_openframe, a project harness for the Google/SkyWater	*/
/* sky130 fabrication process and open source PDK		*/
/*                                                          	*/
/* Copyright 2023 Efabless Corporation				*/
/* Written by Tim Edwards, March 2023                    	*/
/* This file is open source hardware released under the     	*/
/* Apache 2.0 license.  See file LICENSE.                   	*/
/*								*/
/* The caravel_openframe is a chip top level design conforming	*/
/* to the pad locations and assignments used by the Caravel and	*/
/* Caravan chips top level definition.  However, it does not	*/
/* define any embedded processor or other interfaces.		*/
/*								*/
/* The padframe of caravel_openframe consists of the same 38	*/
/* general-purpose I/O pads as Caravel.  The pads formerly	*/
/* used by Caravel for dedicated functions of the management	*/
/* SoC (flash controller CSB, SCK, IO0 and IO1, gpio, and	*/
/* clock) are redefined as additional general-purpose I/O for	*/
/* a total of 44 GPIO pads.  The resetb pad retains its		*/
/* function as an input pin with weak pull-up with high and	*/
/* low voltage domain (3.3V and 1.8V) versions of the output	*/
/* exported to the chip project core.  The user may elect to	*/
/* use the reset pin for a purpose other than a master reset.	*/
/*								*/
/* The padframe implements a simple power-on reset circuit, and	*/
/* provides a 32-bit bus in the 1.8V digital domain consisting	*/
/* of the (fixed) user project ID.				*/
/*								*/
/* Each GPIO pad must be configured by the user project.  The	*/
/* padframe exports constant value "1" and "0" bits in the 1.8V	*/
/* domain for each GPIO pad that can be used by the user	*/
/* project to loop back to the GPIO to set a static		*/
/* configuration on power-up.					*/
/*								*/
/* Every user project must instantiate a module called		*/
/* "openframe_project_wrapper" that connects to all of the	*/
/* signals as defined in the module call, below.  The layout	*/
/* of the user project must correspond to the provided wrapper	*/
/* cell layout, describing the position of signal and power	*/
/* pins on the perimeter of the wrapper.			*/
/*								*/
/* Bon voyage!							*/
/*--------------------------------------------------------------*/

/*--------------------------------------------------------------*/
/* NOTE:  This file can be checked for syntax directly using:	*/
/*								*/
/* iverilog -I ${PDK_ROOT}/${PDK} -DSIM -DFUNCTIONAL \		*/
/* openframe_netlists.v __openframe_project_wrapper.v \		*/
/* -s caravel_openframe						*/
/*--------------------------------------------------------------*/

module caravel_openframe (

    // All top-level I/O are package-facing pins

    inout vddio,	// Common 3.3V padframe/ESD power
    inout vddio_2,	// Common 3.3V padframe/ESD power
    inout vssio,	// Common padframe/ESD ground
    inout vssio_2,	// Common padframe/ESD ground
    inout vdda,		// Management 3.3V power
    inout vssa,		// Common analog ground
    inout vccd,		// Management/Common 1.8V power
    inout vssd,		// Common digital ground
    inout vdda1,	// User area 1 3.3V power
    inout vdda1_2,	// User area 1 3.3V power
    inout vdda2,	// User area 2 3.3V power
    inout vssa1,	// User area 1 analog ground
    inout vssa1_2,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V power
    inout vccd2,	// User area 2 1.8V power
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground

    inout [`OPENFRAME_IO_PADS-1:0] gpio,
    input resetb	// Reset input (sense inverted)
);

    //------------------------------------------------------------
    // This value is uniquely defined for each user project.
    //------------------------------------------------------------
    parameter USER_PROJECT_ID = 32'h00000000;

    // Project Control (pad-facing)
    wire [`OPENFRAME_IO_PADS-1:0] gpio_inp_dis;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_oeb;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_ib_mode_sel;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_vtrip_sel;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_slow_sel;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_holdover;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_analog_en;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_analog_sel;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_analog_pol;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_dm0;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_dm1;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_dm2;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_in;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_in_h;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_out;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_loopback_zero;
    wire [`OPENFRAME_IO_PADS-1:0] gpio_loopback_one;
    wire [`OPENFRAME_IO_PADS-1:0] analog_io;
    wire [`OPENFRAME_IO_PADS-1:0] analog_noesd_io;

    // Power-on-reset signal.  The simple POR circuit generates these
    // three signals, uses them to enable the GPIO, and exports the
    // signals to the core.

    wire porb_h;
    wire porb_l;
    wire por_l;

    // Master reset signal.  The reset pad generates the sense-inverted
    // reset at 3.3V.  The 1.8V signal is derived.

    wire rstb_h;
    wire rstb_l;

    // Mask revision:  Output from the padframe, exporting the 32-bit
    // user ID value.

    wire [31:0] mask_rev;

    chip_io_openframe #(
		.USER_PROJECT_ID(USER_PROJECT_ID)
	) padframe (
	
	// Pad side power connections
	`ifndef TOP_ROUTING
		// Package Pins
		.vddio_pad	(vddio),		// Common padframe/ESD supply
		.vddio_pad2	(vddio_2),
		.vssio_pad	(vssio),		// Common padframe/ESD ground
		.vssio_pad2	(vssio_2),
		.vccd_pad	(vccd),			// Common 1.8V supply
		.vssd_pad	(vssd),			// Common digital ground
		.vdda_pad	(vdda),			// Management analog 3.3V supply
		.vssa_pad	(vssa),			// Management analog ground
		.vdda1_pad	(vdda1),		// User area 1 3.3V supply
		.vdda1_pad2	(vdda1_2),		
		.vdda2_pad	(vdda2),		// User area 2 3.3V supply
		.vssa1_pad	(vssa1),		// User area 1 analog ground
		.vssa1_pad2	(vssa1_2),
		.vssa2_pad	(vssa2),		// User area 2 analog ground
		.vccd1_pad	(vccd1),		// User area 1 1.8V supply
		.vccd2_pad	(vccd2),		// User area 2 1.8V supply
		.vssd1_pad	(vssd1),		// User area 1 digital ground
		.vssd2_pad	(vssd2),		// User area 2 digital ground
	`endif

	// Pad side signals
	.resetb_pad(resetb),
	.gpio(gpio),

	// Core side power connections
	.vddio	(vddio_core),
	.vssio	(vssio_core),
	.vdda	(vdda_core),
	.vssa	(vssa_core),
	.vccd	(vccd_core),
	.vssd	(vssd_core),
	.vdda1	(vdda1_core),
	.vdda2	(vdda2_core),
	.vssa1	(vssa1_core),
	.vssa2	(vssa2_core),
	.vccd1	(vccd1_core),
	.vccd2	(vccd2_core),
	.vssd1	(vssd1_core),
	.vssd2	(vssd2_core),

	// Core side signals
	.porb_h(porb_h),
	.porb_l(porb_l),
	.por_l(por_l),
	.resetb_h(rstb_h),
	.resetb_l(rstb_l),
	.mask_rev(mask_rev),

	.gpio_in(gpio_in),
	.gpio_in_h(gpio_in_h),
	.gpio_out(gpio_out),
	.gpio_oeb(gpio_oeb),
	.gpio_inp_dis(gpio_inp_dis),
	.gpio_ib_mode_sel(gpio_ib_mode_sel),
	.gpio_vtrip_sel(gpio_vtrip_sel),
	.gpio_slow_sel(gpio_slow_sel),
	.gpio_holdover(gpio_holdover),
	.gpio_analog_en(gpio_analog_en),
	.gpio_analog_sel(gpio_analog_sel),
	.gpio_analog_pol(gpio_analog_pol),
	.gpio_dm0(gpio_dm0),
	.gpio_dm1(gpio_dm1),
	.gpio_dm2(gpio_dm2),
	.gpio_loopback_zero(gpio_loopback_zero),
	.gpio_loopback_one(gpio_loopback_one),
	.analog_io(analog_io),
	.analog_noesd_io(analog_noesd_io)
    );

    /*--------------------------------------------------*/
    /* Wrapper module around the user project 		*/
    /*--------------------------------------------------*/

    openframe_project_wrapper user_project (
        `ifdef USE_POWER_PINS
	    .vdda(vdda_core),
	    .vssa(vssa_core),
	    .vccd(vccd_core),
	    .vssd(vssd_core),
	    .vdda1(vdda1_core),		// User area 1 3.3V power
	    .vdda2(vdda2_core),		// User area 2 3.3V power
	    .vssa1(vssa1_core),		// User area 1 analog ground
	    .vssa2(vssa2_core),		// User area 2 analog ground
	    .vccd1(vccd1_core),		// User area 1 1.8V power
	    .vccd2(vccd2_core),		// User area 2 1.8V power
	    .vssd1(vssd1_core),		// User area 1 digital ground
	    .vssd2(vssd2_core),		// User area 2 digital ground
    	`endif

	.porb_h(porb_h),
	.porb_l(porb_l),
	.por_l(por_l),
	.resetb_h(rstb_h),
	.resetb_l(rstb_l),
	.mask_rev(mask_rev),

	.gpio_in(gpio_in),
	.gpio_in_h(gpio_in_h),
	.gpio_out(gpio_out),
	.gpio_oeb(gpio_oeb),
	.gpio_inp_dis(gpio_inp_dis),
	.gpio_ib_mode_sel(gpio_ib_mode_sel),
	.gpio_vtrip_sel(gpio_vtrip_sel),
	.gpio_slow_sel(gpio_slow_sel),
	.gpio_holdover(gpio_holdover),
	.gpio_analog_en(gpio_analog_en),
	.gpio_analog_sel(gpio_analog_sel),
	.gpio_analog_pol(gpio_analog_pol),
	.gpio_dm0(gpio_dm0),
	.gpio_dm1(gpio_dm1),
	.gpio_dm2(gpio_dm2),
	.gpio_loopback_zero(gpio_loopback_zero),
	.gpio_loopback_one(gpio_loopback_one),
	.analog_io(analog_io),
	.analog_noesd_io(analog_noesd_io)
    );

    /*------------------------------------------*/
    /* End user project instantiation		*/
    /*------------------------------------------*/

endmodule
// `default_nettype wire
