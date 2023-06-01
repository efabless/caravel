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
/* caravan, a project harness for the Google/SkyWater sky130	*/
/* fabrication process and open source PDK.  caravan is an 	*/
/* alternative architecture to caravel that has simple straight	*/
/* through connections replacing the GPIO pads on the top side	*/
/* of the padframe.  A total of 11 pads are converted from GPIO	*/
/* to analog, leaving 27 GPIO.					*/
/*                                                          	*/
/* Copyright 2021 efabless, Inc.                            	*/
/* Written by Tim Edwards, December 2019                    	*/
/* and Mohamed Shalan, August 2020			    	*/
/* This file is open source hardware released under the     	*/
/* Apache 2.0 license.  See file LICENSE.                   	*/
/*                                                          	*/
/*--------------------------------------------------------------*/

/*--------------------------------------------------------------*/
/* Derived types for the array bounds on the two digital and	*/
/* two analog pad arrays.  As defined above, the sections have	*/
/* the number of pads as follows:				*/
/*								*/
/*	DIG2 : 13 GPIO pads					*/
/*	ANA2 : 6  analog pads					*/
/*	ANA1 : 5  analog pads					*/
/*	DIG1 : 14 GPIO pads					*/
/*								*/
/* This makes a total of 38 pads = `MPRJ_IO_PADS		*/
/* The pads are still designated as mprj_io[37:0] around the	*/
/* padframe.  The SoC core remains the same, so the programming	*/
/* of the digital signals remains the same, but the values for	*/
/* GPIO 14-24 (indexed from 0) are not used.			*/
/*--------------------------------------------------------------*/

`define DIG2_TOP (`MPRJ_IO_PADS - 1)
`define DIG2_BOT (`MPRJ_IO_PADS_1 + `ANALOG_PADS_2)
`define ANA2_TOP (`MPRJ_IO_PADS_1 + `ANALOG_PADS_2 - 1)
`define ANA2_BOT (`MPRJ_IO_PADS_1)
`define ANA1_TOP (`MPRJ_IO_PADS_1 - 1)
`define ANA1_BOT (`MPRJ_IO_PADS_1 - `ANALOG_PADS_1)
`define DIG1_TOP (`MPRJ_IO_PADS_1 - `ANALOG_PADS_1 - 1)
`define DIG1_BOT (0)

`define MPRJ_DIG_PADS (`MPRJ_IO_PADS - `ANALOG_PADS)

/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/

module caravan (
    // All top-level I/O are package-facing pins
    inout                     vddio,    // Common 3.3V padframe/ESD power
    inout                     vddio_2,  // Common 3.3V padframe/ESD power
    inout                     vssio,    // Common padframe/ESD ground
    inout                     vssio_2,  // Common padframe/ESD ground
    inout                     vdda,     // Management 3.3V power
    inout                     vssa,     // Common analog ground
    inout                     vccd,     // Management/Common 1.8V power
    inout                     vssd,     // Common digital ground
    inout                     vdda1,    // User area 1 3.3V power
    inout                     vdda1_2,  // User area 1 3.3V power
    inout                     vdda2,    // User area 2 3.3V power
    inout                     vssa1,    // User area 1 analog ground
    inout                     vssa1_2,  // User area 1 analog ground
    inout                     vssa2,    // User area 2 analog ground
    inout                     vccd1,    // User area 1 1.8V power
    inout                     vccd2,    // User area 2 1.8V power
    inout                     vssd1,    // User area 1 digital ground
    inout                     vssd2,    // User area 2 digital ground	
    inout                     gpio,     // Used for external LDO control
    inout [`MPRJ_IO_PADS-1:0] mprj_io,
    input                     clock,    // CMOS core clock input, not a crystal
    input                     resetb,   // Reset input (Active Low)

    // Note that only two pins are available on the flash so dual and
    // quad flash modes are not available.

    output flash_csb,
    output flash_clk,
    output flash_io0,
    output flash_io1
);

    //------------------------------------------------------------
    // This value is uniquely defined for each user project.
    //------------------------------------------------------------
    parameter USER_PROJECT_ID = 32'h00000000;

    /*
     *--------------------------------------------------------------------
     * These pins are overlaid on mprj_io space. They have the function
     * below when the management processor is in reset, or in the default
     * configuration. They are assigned to uses in the user space by the
     * configuration program running off of the SPI flash.  Note that even
     * when the user has taken control of these pins, they can be restored
     * to the original use by setting the resetb pin low.  The SPI pins and
     * UART pins can be connected directly to an FTDI chip as long as the
     * FTDI chip sets these lines to high impedence (input function) at
     * all times except when holding the chip in reset.
     *
     * JTAG			= mprj_io[0]		(inout)
     * SDO			= mprj_io[1]		(output)
     * SDI			= mprj_io[2]		(input)
     * CSB			= mprj_io[3]		(input)
     * SCK			= mprj_io[4]		(input)
     * ser_rx		= mprj_io[5]		(input)
     * ser_tx		= mprj_io[6]		(output)
     * irq			= mprj_io[7]		(input)
     *
     * spi_sck		= mprj_io[32]		(output)
     * spi_csb		= mprj_io[33]		(output)
     * spi_sdi		= mprj_io[34]		(input)
     * spi_sdo		= mprj_io[35]		(output)
     * flash_io2	= mprj_io[36]		(inout) 
     * flash_io3	= mprj_io[37]		(inout) 
     *
     * These pins are reserved for any project that wants to incorporate
     * its own processor and flash controller.  While a user project can
     * technically use any available I/O pins for the purpose, these
     * four pins connect to a pass-through mode from the SPI slave (pins
     * 1-4 above) so that any SPI flash connected to these specific pins
     * can be accessed through the SPI slave even when the processor is in
     * reset.
     *
     * user_flash_csb = mprj_io[8]
     * user_flash_sck = mprj_io[9]
     * user_flash_io0 = mprj_io[10]
     * user_flash_io1 = mprj_io[11]
     *
     *--------------------------------------------------------------------
     */

    // One-bit GPIO dedicated to management SoC (outside of user control)
    wire gpio_out_core;
    wire gpio_in_core;
    wire gpio_mode0_core;
    wire gpio_mode1_core;
    wire gpio_outenb_core;
    wire gpio_inenb_core;

    // 27 GPIO pads with full controls
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_inp_dis;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_oeb;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_ib_mode_sel;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_vtrip_sel;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_slow_sel;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_holdover;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_analog_en;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_analog_sel;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_analog_pol;
    wire [(`MPRJ_IO_PADS-`ANALOG_PADS)*3-1:0] mprj_io_dm;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_in;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_in_3v3;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_out;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] mprj_io_one;
    wire [7:0] mprj_io_zero;

    // User Project Control (user-facing)
    // 27 GPIO bidirectional with in/out/oeb and a 3.3V copy of the input
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] user_io_oeb;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] user_io_in;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] user_io_out;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] user_io_in_3v3;

    // 18 direct connections to GPIO for low-frequency, low-voltage analog
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-10:0] user_gpio_analog;
    wire [`MPRJ_IO_PADS-`ANALOG_PADS-10:0] user_gpio_noesd;

    // 3 power supply ESD clamps for user applications
    wire [2:0] user_clamp_high;
    wire [2:0] user_clamp_low;

    // 11 core connections to the analog pads
    wire [`ANALOG_PADS-1:0] user_analog;

    /* Padframe control signals */
    wire [`MPRJ_IO_PADS_1-`ANALOG_PADS_1-1:0] gpio_serial_link_1;
    wire [`MPRJ_IO_PADS_2-`ANALOG_PADS_2-1:0] gpio_serial_link_2;
    wire mprj_io_loader_resetn;
    wire mprj_io_loader_clock;
    wire mprj_io_loader_strobe;
    wire mprj_io_loader_data_1;		/* user1 side serial loader */
    wire mprj_io_loader_data_2;		/* user2 side serial loader */

    // User Project Control management I/O
    // There are two types of GPIO connections:
    // (1) Full Bidirectional: Management connects to in, out, and oeb
    //     Uses:  JTAG and SDO
    // (2) Selectable bidirectional:  Management connects to in and out,
    //	   which are tied together.  oeb is grounded (oeb from the
    //	   configuration is used)

  // SDI		= mprj_io[2]		(input)
  // CSB		= mprj_io[3]		(input)
  // SCK		= mprj_io[4]		(input)
  // ser_rx	= mprj_io[5]		(input)
  // ser_tx	= mprj_io[6]		(output)
  // irq		= mprj_io[7]		(input)

    wire clock_core;

    // Power-on-reset signal.  The reset pad generates the sense-inverted
    // reset at 3.3V.  The 1.8V signal and the inverted 1.8V signal are
    // derived.

    wire porb_h;
    wire porb_l;
    wire por_l;

    wire rstb_h;

    // Flash SPI communication (
    wire flash_clk_frame;
    wire flash_csb_frame;
    wire flash_clk_oeb, flash_csb_oeb;
    wire flash_io0_oeb, flash_io1_oeb;
    wire flash_io0_ieb, flash_io1_ieb;
    wire flash_io0_do, flash_io1_do;
    wire flash_io0_di, flash_io1_di;

  wire vddio_core;
  wire vssio_core;
  wire vdda_core;
  wire vssa_core;
  wire vccd_core;
  wire vssd_core;
  wire vdda1_core;
  wire vdda2_core;
  wire vssa1_core;
  wire vssa2_core;
  wire vccd1_core;
  wire vccd2_core;
  wire vssd1_core;
  wire vssd2_core;

    chip_io_alt #(
	.ANALOG_PADS_1(`ANALOG_PADS_1),
	.ANALOG_PADS_2(`ANALOG_PADS_2)
    ) padframe (
	`ifndef TOP_ROUTING
      // Package Pins
      .vddio_pad(vddio),  // Common padframe/ESD supply
      .vddio_pad2(vddio_2),
      .vssio_pad(vssio),  // Common padframe/ESD ground
      .vssio_pad2(vssio_2),
      .vccd_pad(vccd),  // Common 1.8V supply
      .vssd_pad(vssd),  // Common digital ground
      .vdda_pad(vdda),  // Management analog 3.3V supply
      .vssa_pad(vssa),  // Management analog ground
      .vdda1_pad(vdda1),  // User area 1 3.3V supply
      .vdda1_pad2(vdda1_2),
      .vdda2_pad(vdda2),  // User area 2 3.3V supply
      .vssa1_pad(vssa1),  // User area 1 analog ground
      .vssa1_pad2(vssa1_2),
      .vssa2_pad(vssa2),  // User area 2 analog ground
      .vccd1_pad(vccd1),  // User area 1 1.8V supply
      .vccd2_pad(vccd2),  // User area 2 1.8V supply
      .vssd1_pad(vssd1),  // User area 1 digital ground
      .vssd2_pad(vssd2),  // User area 2 digital ground
      .vddio(vddio_core),
      .vssio(vssio_core),
      .vdda(vdda_core),
      .vssa(vssa_core),
      .vccd(vccd_core),
      .vssd(vssd_core),
      .vdda1(vdda1_core),
      .vdda2(vdda2_core),
      .vssa1(vssa1_core),
      .vssa2(vssa2_core),
      .vccd1(vccd1_core),
      .vccd2(vccd2_core),
      .vssd1(vssd1_core),
      .vssd2(vssd2_core),
	
	// Core Side Pins
	.gpio(gpio),
	.mprj_io(mprj_io),
	.clock(clock),
	.resetb(resetb),
	.flash_csb(flash_csb),
	.flash_clk(flash_clk),
	.flash_io0(flash_io0),
	.flash_io1(flash_io1),
`endif

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
	.flash_csb_core(flash_csb_frame),
	.flash_clk_core(flash_clk_frame),
	.flash_csb_oeb_core(flash_csb_oeb),
	.flash_clk_oeb_core(flash_clk_oeb),
	.flash_io0_oeb_core(flash_io0_oeb),
	.flash_io1_oeb_core(flash_io1_oeb),
	.flash_io0_ieb_core(flash_io0_ieb),
	.flash_io1_ieb_core(flash_io1_ieb),
	.flash_io0_do_core(flash_io0_do),
	.flash_io1_do_core(flash_io1_do),
	.flash_io0_di_core(flash_io0_di),
	.flash_io1_di_core(flash_io1_di),
	.mprj_io_one(mprj_io_one),
	.mprj_io_in(mprj_io_in),
	.mprj_io_in_3v3(mprj_io_in_3v3),
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
	.mprj_gpio_analog(user_gpio_analog),
	.mprj_gpio_noesd(user_gpio_noesd),
	.mprj_analog(user_analog),
	.mprj_clamp_high(user_clamp_high),
	.mprj_clamp_low(user_clamp_low)
    );

  caravan_core chip_core (
      // All top-level I/O are package-facing pins
`ifdef USE_POWER_PINS
      .vddio(vddio_core),  // Common 3.3V padframe/ESD power
      .vssio(vssio_core),  // Common padframe/ESD ground
      .vccd (vccd_core),   // Management/Common 1.8V power
      .vssd (vssd_core),   // Common digital ground
      .vdda1(vdda1_core),  // User area 1 3.3V power
      .vdda2(vdda2_core),  // User area 2 3.3V power
      .vssa1(vssa1_core),  // User area 1 analog ground
      .vssa2(vssa2_core),  // User area 2 analog ground
      .vccd1(vccd1_core),  // User area 1 1.8V power
      .vccd2(vccd2_core),  // User area 2 1.8V power
      .vssd1(vssd1_core),  // User area 1 digital ground
      .vssd2(vssd2_core),  // User area 2 digital ground	
`endif

	.porb_h(porb_h),
	.por_l(por_l),
	.rstb_h(rstb_h),
	.clock_core(clock_core),
	.gpio_out_core(gpio_out_core),
	.gpio_in_core(gpio_in_core),
	.gpio_mode0_core(gpio_mode0_core),
	.gpio_mode1_core(gpio_mode1_core),
	.gpio_outenb_core(gpio_outenb_core),
	.gpio_inenb_core(gpio_inenb_core),

	// Flash SPI communication
	.flash_csb_frame(flash_csb_frame),
	.flash_clk_frame(flash_clk_frame),
	.flash_csb_oeb(flash_csb_oeb),
	.flash_clk_oeb(flash_clk_oeb),
	.flash_io0_oeb(flash_io0_oeb),
	.flash_io1_oeb(flash_io1_oeb),
	.flash_io0_ieb(flash_io0_ieb),
	.flash_io1_ieb(flash_io1_ieb),
	.flash_io0_do(flash_io0_do),
	.flash_io1_do(flash_io1_do),
	.flash_io0_di(flash_io0_di),
	.flash_io1_di(flash_io1_di),

	// User project IOs
	.mprj_io_in(mprj_io_in),
	.mprj_io_in_3v3(mprj_io_in_3v3),
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
	.user_gpio_analog(user_gpio_analog),
	.user_gpio_noesd(user_gpio_noesd),
	.user_analog(user_analog),
	.user_clamp_high(user_clamp_high),
	.user_clamp_low(user_clamp_low),
	// Loopbacks to constant value 1 in the 1.8V domain
      .mprj_io_one(mprj_io_one)
    );

copyright_block_a copyright_block_a();
caravan_logo caravan_logo();
caravan_motto caravan_motto();
open_source open_source();
user_id_textblock user_id_textblock();

endmodule
// `default_nettype wire
