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
/* The "openframe" version does not specify a management SoC	*/
/* and only implements the padframe and related infrastructure.	*/
/*                                                          	*/
/* Copyright 2020 efabless, Inc.                            	*/
/* Written by Tim Edwards, December 2019                    	*/
/* and Mohamed Shalan, August 2020			    	*/
/* This file is open source hardware released under the     	*/
/* Apache 2.0 license.  See file LICENSE.                   	*/
/*                                                          	*/
/*--------------------------------------------------------------*/

module caravel_openframe (
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

    inout gpio,		// Used for external LDO control
    inout [`MPRJ_IO_PADS-1:0] mprj_io,
    output [`MPRJ_PWR_PADS-1:0] pwr_ctrl_out,
    input clock,    	// CMOS core clock input, not a crystal
    input resetb,	// Reset input (sense inverted)

    // Note that only two flash data pins are dedicated to the
    // management SoC wrapper.  The management SoC exports the
    // quad SPI mode status to make use of the top two mprj_io
    // pins for io2 and io3.

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
     *
     * These pins are overlaid on mprj_io space.  They have the function
     * below when the management processor is in reset, or in the default
     * configuration.  They are assigned to uses in the user space by the
     * configuration program running off of the SPI flash.  Note that even
     * when the user has taken control of these pins, they can be restored
     * to the original use by setting the resetb pin low.  The SPI pins and
     * UART pins can be connected directly to an FTDI chip as long as the
     * FTDI chip sets these lines to high impedence (input function) at
     * all times except when holding the chip in reset.
     *
     * JTAG      = mprj_io[0]		(inout)
     * SDO 	 = mprj_io[1]		(output)
     * SDI 	 = mprj_io[2]		(input)
     * CSB 	 = mprj_io[3]		(input)
     * SCK	 = mprj_io[4]		(input)
     * ser_rx    = mprj_io[5]		(input)
     * ser_tx    = mprj_io[6]		(output)
     * irq 	 = mprj_io[7]		(input)
     *
     * flash_io2 = mprj_io[36]		(inout) 
     * flash_io3 = mprj_io[37]		(inout) 
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

    // User Project Control (pad-facing)
    wire [`MPRJ_IO_PADS-1:0] mprj_io_inp_dis;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_oeb;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_ib_mode_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_vtrip_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_slow_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_holdover;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_analog_en;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_analog_sel;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_analog_pol;
    wire [`MPRJ_IO_PADS*3-1:0] mprj_io_dm;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_in;
    wire [`MPRJ_IO_PADS-1:0] mprj_io_out;

    // User Project Control (user-facing)
    wire [`MPRJ_IO_PADS-1:0] user_io_oeb;
    wire [`MPRJ_IO_PADS-1:0] user_io_in;
    wire [`MPRJ_IO_PADS-1:0] user_io_out;
    wire [`MPRJ_IO_PADS-10:0] user_analog_io;

    /* Padframe control signals */
    wire [`MPRJ_IO_PADS_1-1:0] gpio_serial_link_1;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_serial_link_2;
    wire mprj_io_loader_resetn;
    wire mprj_io_loader_clock;
    wire mprj_io_loader_data_1;		/* user1 side serial loader */
    wire mprj_io_loader_data_2;		/* user2 side serial loader */

    // User Project Control management I/O
    // There are two types of GPIO connections:
    // (1) Full Bidirectional: Management connects to in, out, and oeb
    //     Uses:  JTAG and SDO
    // (2) Selectable bidirectional:  Management connects to in and out,
    //	   which are tied together.  oeb is grounded (oeb from the
    //	   configuration is used)

    // SDI 	 = mprj_io[2]		(input)
    // CSB 	 = mprj_io[3]		(input)
    // SCK	 = mprj_io[4]		(input)
    // ser_rx    = mprj_io[5]		(input)
    // ser_tx    = mprj_io[6]		(output)
    // irq 	 = mprj_io[7]		(input)

    wire [`MPRJ_IO_PADS-1:0] mgmt_io_in;
    wire jtag_out, sdo_out;
    wire jtag_outenb, sdo_outenb;
    wire gpio_flash_io2_out, gpio_flash_io3_out;

    wire [1:0] mgmt_io_nc;			/* no-connects */

    wire clock_core;

    // Power-on-reset signal.  The reset pad generates the sense-inverted
    // reset at 3.3V.  The 1.8V signal and the inverted 1.8V signal are
    // derived.

    wire porb_h;
    wire porb_l;
    wire por_l;

    wire rstb_h;
    wire rstb_l;

    wire flash_clk_core,     flash_csb_core;
    wire flash_clk_oeb_core, flash_csb_oeb_core;
    wire flash_clk_ieb_core, flash_csb_ieb_core;
    wire flash_io0_oeb_core, flash_io1_oeb_core;
    wire flash_io2_oeb_core, flash_io3_oeb_core;
    wire flash_io0_ieb_core, flash_io1_ieb_core;
    wire flash_io0_do_core,  flash_io1_do_core;
    wire flash_io0_di_core,  flash_io1_di_core;

    chip_io padframe(
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
	// Power Pins
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

	// Signal Pins
	.gpio(gpio),
	.mprj_io(mprj_io),
	.clock(clock),
	.resetb(resetb),
	.flash_csb(flash_csb),
	.flash_clk(flash_clk),
	.flash_io0(flash_io0),
	.flash_io1(flash_io1),

	// Clock and Reset Interface
	.porb_h(porb_h),
	.por(por_l),
	.resetb_core_h(rstb_h),
	.clock_core(clock_core),

	// Core-facing side of the pads
	.gpio_out_core(gpio_out_core),
	.gpio_in_core(gpio_in_core),
	.gpio_mode0_core(gpio_mode0_core),
	.gpio_mode1_core(gpio_mode1_core),
	.gpio_outenb_core(gpio_outenb_core),
	.gpio_inenb_core(gpio_inenb_core),
	.flash_csb_core(flash_csb_core),
	.flash_clk_core(flash_clk_core),
	.flash_csb_oeb_core(flash_csb_oeb_core),
	.flash_clk_oeb_core(flash_clk_oeb_core),
	.flash_io0_oeb_core(flash_io0_oeb_core),
	.flash_io1_oeb_core(flash_io1_oeb_core),
	.flash_csb_ieb_core(flash_csb_ieb_core),
	.flash_clk_ieb_core(flash_clk_ieb_core),
	.flash_io0_ieb_core(flash_io0_ieb_core),
	.flash_io1_ieb_core(flash_io1_ieb_core),
	.flash_io0_do_core(flash_io0_do_core),
	.flash_io1_do_core(flash_io1_do_core),
	.flash_io0_di_core(flash_io0_di_core),
	.flash_io1_di_core(flash_io1_di_core),
	.mprj_io_in(mprj_io_in),
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
	.mprj_analog_io(user_analog_io)
    );

    // Clock and reset
    wire caravel_clk;
    wire caravel_clk2;
    wire caravel_rstn;

    wire    mprj_clock;
    wire    mprj_clock2;
    wire    mprj_reset;

    // Mask revision (User ID)
    wire [31:0] mask_rev;

    // Power Monitoring
    wire    mprj_vcc_pwrgood;
    wire    mprj2_vcc_pwrgood;
    wire    mprj_vdd_pwrgood;
    wire    mprj2_vdd_pwrgood;

    // Open Frame wrapper
    openframe_wrapper openframe (
	`ifdef USE_POWER_PINS
		.VPWR(vccd_core),
		.VGND(vssd_core),
	`endif
		// GPIO (1 pin)
		.gpio_out_pad(gpio_out_core),
		.gpio_in_pad(gpio_in_core),
		.gpio_mode0_pad(gpio_mode0_core),
		.gpio_mode1_pad(gpio_mode1_core),
		.gpio_outenb_pad(gpio_outenb_core),
		.gpio_inenb_pad(gpio_inenb_core),

		// GPIO

		// Primary SPI flash controller
		.flash_csb(flash_csb_core),
		.flash_csb_ieb(flash_csb_ieb_core),
		.flash_csb_oeb(flash_csb_oeb_core),
		.flash_clk(flash_clk_core),
		.flash_clk_ieb(flash_clk_ieb_core),
		.flash_clk_oeb(flash_clk_oeb_core),
		.flash_io0_ieb(flash_io0_ieb_core),
		.flash_io0_oeb(flash_io0_oeb_core),
		.flash_io0_di(flash_io0_di_core),
		.flash_io0_do(flash_io0_do_core),
		.flash_io1_ieb(flash_io1_ieb_core),
		.flash_io1_oeb(flash_io1_oeb_core),
		.flash_io1_di(flash_io1_di_core),
		.flash_io1_do(flash_io1_do_core),
		.flash_io2_ieb(flash_io2_ieb_core),
		.flash_io2_oeb(flash_io2_oeb_core),
		.flash_io2_di(flash_io2_di_core),
		.flash_io2_do(flash_io2_do_core),
		.flash_io3_ieb(flash_io3_ieb_core),
		.flash_io3_oeb(flash_io3_oeb_core),
		.flash_io3_di(flash_io3_di_core),
		.flash_io3_do(flash_io3_do_core),

		// Clock and reset
		.core_clk(caravel_clk),
		.core_rstn(caravel_rstn)
    	);

    wire [`MPRJ_IO_PADS_1-1:0] gpio_serial_link_1_shifted;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_serial_link_2_shifted;

    assign gpio_serial_link_1_shifted = {gpio_serial_link_1[`MPRJ_IO_PADS_1-2:0],
					 mprj_io_loader_data_1};
    // Note that serial_link_2 is backwards compared to serial_link_1, so it
    // shifts in the other direction.
    assign gpio_serial_link_2_shifted = {mprj_io_loader_data_2,
					 gpio_serial_link_2[`MPRJ_IO_PADS_2-1:1]};

    // Propagating clock and reset to mitigate timing and fanout issues
    wire [`MPRJ_IO_PADS_1-1:0] gpio_clock_1;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_clock_2;
    wire [`MPRJ_IO_PADS_1-1:0] gpio_resetn_1;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_resetn_2;
    wire [`MPRJ_IO_PADS_1-1:0] gpio_clock_1_shifted;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_clock_2_shifted;
    wire [`MPRJ_IO_PADS_1-1:0] gpio_resetn_1_shifted;
    wire [`MPRJ_IO_PADS_2-1:0] gpio_resetn_2_shifted;

    assign gpio_clock_1_shifted = {gpio_clock_1[`MPRJ_IO_PADS_1-2:0],
					 mprj_io_loader_clock};
    assign gpio_clock_2_shifted = {mprj_io_loader_clock,
					gpio_clock_2[`MPRJ_IO_PADS_2-1:1]};
    assign gpio_resetn_1_shifted = {gpio_resetn_1[`MPRJ_IO_PADS_1-2:0],
					 mprj_io_loader_resetn};
    assign gpio_resetn_2_shifted = {mprj_io_loader_resetn,
					gpio_resetn_2[`MPRJ_IO_PADS_2-1:1]};

    // Clocking control

    caravel_clocking clocking(
        `ifdef USE_POWER_PINS
            .vdd1v8(VPWR),
            .vss(VGND),
        `endif
        .ext_clk_sel(ext_clk_sel),
        .ext_clk(clock),
        .pll_clk(pll_clk),
        .pll_clk90(pll_clk90),
        .resetb(resetb),
        .sel(spi_pll_sel),
        .sel2(spi_pll90_sel),
        .ext_reset(ext_reset),  // From housekeeping SPI
        .core_clk(core_clk),
        .user_clk(user_clk),
        .resetb_sync(core_rstn)
    );

    // DCO/Digital Locked Loop
    digital_pll pll (
        `ifdef USE_POWER_PINS
            .VPWR(VPWR),
            .VGND(VGND),
        `endif
        .resetb(resetb),
        .enable(spi_pll_ena),
        .osc(clock),
        .clockp({pll_clk, pll_clk90}),
        .div(spi_pll_div),
        .dco(spi_pll_dco_ena),
        .ext_trim(spi_pll_trim)
    );

    // Housekeeping SPI interface
    housekeeping_spi housekeeping (
        `ifdef USE_POWER_PINS
                .vdd(VPWR),
                .vss(VGND),
        `endif
        .RSTB(porb),
        .SCK((hk_connect) ? mgmt_out_predata[4] : mgmt_in_data[4]),
        .SDI((hk_connect) ? mgmt_out_predata[2] : mgmt_in_data[2]),
        .CSB((hk_connect) ? mgmt_out_predata[3] : mgmt_in_data[3]),
        .SDO(sdo_out_pre),
        .sdo_enb(sdo_outenb_pre),
        .pll_dco_ena(spi_pll_dco_ena),
        .pll_sel(spi_pll_sel),
        .pll90_sel(spi_pll90_sel),
        .pll_div(spi_pll_div),
        .pll_ena(spi_pll_ena),
        .pll_trim(spi_pll_trim),
        .pll_bypass(ext_clk_sel),
        .irq(irq_spi),
        .reset(ext_reset),
        .trap(trap),
        .mask_rev_in(mask_rev),
        .gpio_enable(gpio_enable),
        .gpio_resetn(gpio_resetn),
        .gpio_clock(gpio_clock),
        .gpio_data_1(gpio_data_1),
        .gpio_data_2(gpio_data_2),
        .sram_clk(hkspi_sram_clk),
        .sram_csb(hkspi_sram_csb),
        .sram_addr(hkspi_sram_addr),
        .sram_rdata(hkspi_sram_rdata),
        .pass_thru_mgmt_reset(pass_thru_mgmt),
        .pass_thru_user_reset(pass_thru_user),
        .pass_thru_mgmt_sck(pass_thru_mgmt_sck),
        .pass_thru_mgmt_csb(pass_thru_mgmt_csb),
        .pass_thru_mgmt_sdi(pass_thru_mgmt_sdi),
        .pass_thru_mgmt_sdo(pass_thru_mgmt_sdo),
        .pass_thru_user_sck(pass_thru_user_sck),
        .pass_thru_user_csb(pass_thru_user_csb),
        .pass_thru_user_sdi(pass_thru_user_sdi),
        .pass_thru_user_sdo(mgmt_in_data[11])
    );

    // GPIO control
    mprj_ctrl_wb #(
        .BASE_ADR(MPRJ_CTRL_ADR)
    ) mprj_ctrl (
        .wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),

        .wb_adr_i(cpu_adr_o),
        .wb_dat_i(cpu_dat_o),
        .wb_sel_i(cpu_sel_o),
        .wb_we_i(cpu_we_o),
        .wb_cyc_i(cpu_cyc_o),
        .wb_stb_i(mprj_ctrl_stb_i),
        .wb_ack_o(mprj_ctrl_ack_o),
        .wb_dat_o(mprj_ctrl_dat_o),

        .serial_clock(mprj_io_loader_clock),
        .serial_resetn(mprj_io_loader_resetn),
        .serial_data_out_1(mprj_io_loader_data_1),
        .serial_data_out_2(mprj_io_loader_data_2),
        .ext_enable(gpio_enable),
        .ext_resetn(gpio_resetn),
        .ext_clock(gpio_clock),
        .ext_data_1(gpio_data_1),
        .ext_data_2(gpio_data_2),
        .sdo_oenb_state(sdo_oenb_state),
        .jtag_oenb_state(jtag_oenb_state),
        .flash_io2_oenb_state(flash_io2_oenb_state),
        .flash_io3_oenb_state(flash_io3_oenb_state),
        .mgmt_gpio_out(mgmt_out_pre),
        .mgmt_gpio_oeb(mgmt_oeb_data),
        .mgmt_gpio_in(mgmt_in_data),
        .pwr_ctrl_out(pwr_ctrl_out),
        .user_irq_ena(user_irq_ena)
    );

    // Each control block sits next to an I/O pad in the user area.
    // It gets input through a serial chain from the previous control
    // block and passes it to the next control block.  Due to the nature
    // of the shift register, bits are presented in reverse, as the first
    // bit in ends up as the last bit of the last I/O pad control block.

    // There are two types of block;  the first two and the last two
    // are configured to be full bidirectional under control of the
    // management Soc (JTAG and SDO for the first two;  flash_io2 and
    // flash_io3 for the last two).  The rest are configured to be default
    // (input).  Note that the first two and last two are the ones closest
    // to the management SoC on either side, which minimizes the wire length
    // of the extra signals those pads need.

    /* First two GPIOs (JTAG and SDO) */
    gpio_control_block #(
	.MGMT_INIT(1'b1),	// Management-controlled
	.OENB_INIT(1'b1)	// Output controlled from bidirectional pin
    ) gpio_control_bidir_1 [1:0] (
    	`ifdef USE_POWER_PINS
			.vccd(vccd_core),
			.vssd(vssd_core),
			.vccd1(vccd1_core),
			.vssd1(vssd1_core),
        `endif

    	// Management Soc-facing signals

    	.resetn(gpio_resetn_1_shifted[1:0]),
    	.serial_clock(gpio_clock_1_shifted[1:0]),

    	.resetn_out(gpio_resetn_1[1:0]),
    	.serial_clock_out(gpio_clock_1[1:0]),

    	.mgmt_gpio_in(mgmt_io_in[1:0]),
		.mgmt_gpio_out({sdo_out, jtag_out}),
		.mgmt_gpio_oeb({sdo_outenb, jtag_outenb}),

        .one(),
        .zero(),

    	// Serial data chain for pad configuration
    	.serial_data_in(gpio_serial_link_1_shifted[1:0]),
    	.serial_data_out(gpio_serial_link_1[1:0]),

    	// User-facing signals
    	.user_gpio_out(user_io_out[1:0]),
    	.user_gpio_oeb(user_io_oeb[1:0]),
    	.user_gpio_in(user_io_in[1:0]),

    	// Pad-facing signals (Pad GPIOv2)
    	.pad_gpio_inenb(mprj_io_inp_dis[1:0]),
    	.pad_gpio_ib_mode_sel(mprj_io_ib_mode_sel[1:0]),
    	.pad_gpio_vtrip_sel(mprj_io_vtrip_sel[1:0]),
    	.pad_gpio_slow_sel(mprj_io_slow_sel[1:0]),
    	.pad_gpio_holdover(mprj_io_holdover[1:0]),
    	.pad_gpio_ana_en(mprj_io_analog_en[1:0]),
    	.pad_gpio_ana_sel(mprj_io_analog_sel[1:0]),
    	.pad_gpio_ana_pol(mprj_io_analog_pol[1:0]),
    	.pad_gpio_dm(mprj_io_dm[5:0]),
    	.pad_gpio_outenb(mprj_io_oeb[1:0]),
    	.pad_gpio_out(mprj_io_out[1:0]),
    	.pad_gpio_in(mprj_io_in[1:0])
    );

    /* Section 1 GPIOs (GPIO 0 to 18) */
    wire [`MPRJ_IO_PADS_1-1:2] one_loop1;

    /* Section 1 GPIOs (GPIO 3 to 7) that start up under management control */

    gpio_control_block #( 
	.DM_INIT(3'b001),	// Configured as inputs
	.MGMT_INIT(1'b1),	// Management-controlled
	.OENB_INIT(1'b1)	// Output disabled
    ) gpio_control_in_1a [5:0] (
    `ifdef USE_POWER_PINS
        .vccd(vccd_core),
		.vssd(vssd_core),
		.vccd1(vccd1_core),
		.vssd1(vssd1_core),
    `endif

    	// Management Soc-facing signals

    	.resetn(gpio_resetn_1_shifted[7:2]),
    	.serial_clock(gpio_clock_1_shifted[7:2]),

    	.resetn_out(gpio_resetn_1[7:2]),
    	.serial_clock_out(gpio_clock_1[7:2]),

		.mgmt_gpio_in(mgmt_io_in[7:2]),
		.mgmt_gpio_out(mgmt_io_in[7:2]),
		.mgmt_gpio_oeb(one_loop1[7:2]),

        .one(one_loop1[7:2]),
        .zero(),

    	// Serial data chain for pad configuration
    	.serial_data_in(gpio_serial_link_1_shifted[7:2]),
    	.serial_data_out(gpio_serial_link_1[7:2]),

    	// User-facing signals
    	.user_gpio_out(user_io_out[7:2]),
    	.user_gpio_oeb(user_io_oeb[7:2]),
    	.user_gpio_in(user_io_in[7:2]),

    	// Pad-facing signals (Pad GPIOv2)
    	.pad_gpio_inenb(mprj_io_inp_dis[7:2]),
    	.pad_gpio_ib_mode_sel(mprj_io_ib_mode_sel[7:2]),
    	.pad_gpio_vtrip_sel(mprj_io_vtrip_sel[7:2]),
    	.pad_gpio_slow_sel(mprj_io_slow_sel[7:2]),
    	.pad_gpio_holdover(mprj_io_holdover[7:2]),
    	.pad_gpio_ana_en(mprj_io_analog_en[7:2]),
    	.pad_gpio_ana_sel(mprj_io_analog_sel[7:2]),
    	.pad_gpio_ana_pol(mprj_io_analog_pol[7:2]),
    	.pad_gpio_dm(mprj_io_dm[23:6]),
    	.pad_gpio_outenb(mprj_io_oeb[7:2]),
    	.pad_gpio_out(mprj_io_out[7:2]),
    	.pad_gpio_in(mprj_io_in[7:2])
    );

    /* Section 1 GPIOs (GPIO 8 to 18) */

    gpio_control_block gpio_control_in_1 [`MPRJ_IO_PADS_1-9:0] (
    `ifdef USE_POWER_PINS
        .vccd(vccd_core),
		.vssd(vssd_core),
		.vccd1(vccd1_core),
		.vssd1(vssd1_core),
    `endif

    	// Management Soc-facing signals

    	.resetn(gpio_resetn_1_shifted[(`MPRJ_IO_PADS_1-1):8]),
    	.serial_clock(gpio_clock_1_shifted[(`MPRJ_IO_PADS_1-1):8]),

    	.resetn_out(gpio_resetn_1[(`MPRJ_IO_PADS_1-1):8]),
    	.serial_clock_out(gpio_clock_1[(`MPRJ_IO_PADS_1-1):8]),

		.mgmt_gpio_in(mgmt_io_in[(`MPRJ_IO_PADS_1-1):8]),
		.mgmt_gpio_out(mgmt_io_in[(`MPRJ_IO_PADS_1-1):8]),
		.mgmt_gpio_oeb(one_loop1[(`MPRJ_IO_PADS_1-1):8]),

        .one(one_loop1[(`MPRJ_IO_PADS_1-1):8]),
        .zero(),

    	// Serial data chain for pad configuration
    	.serial_data_in(gpio_serial_link_1_shifted[(`MPRJ_IO_PADS_1-1):8]),
    	.serial_data_out(gpio_serial_link_1[(`MPRJ_IO_PADS_1-1):8]),

    	// User-facing signals
    	.user_gpio_out(user_io_out[(`MPRJ_IO_PADS_1-1):8]),
    	.user_gpio_oeb(user_io_oeb[(`MPRJ_IO_PADS_1-1):8]),
    	.user_gpio_in(user_io_in[(`MPRJ_IO_PADS_1-1):8]),

    	// Pad-facing signals (Pad GPIOv2)
    	.pad_gpio_inenb(mprj_io_inp_dis[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_ib_mode_sel(mprj_io_ib_mode_sel[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_vtrip_sel(mprj_io_vtrip_sel[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_slow_sel(mprj_io_slow_sel[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_holdover(mprj_io_holdover[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_ana_en(mprj_io_analog_en[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_ana_sel(mprj_io_analog_sel[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_ana_pol(mprj_io_analog_pol[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_dm(mprj_io_dm[(`MPRJ_IO_PADS_1*3-1):24]),
    	.pad_gpio_outenb(mprj_io_oeb[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_out(mprj_io_out[(`MPRJ_IO_PADS_1-1):8]),
    	.pad_gpio_in(mprj_io_in[(`MPRJ_IO_PADS_1-1):8])
    );


    /* Last two GPIOs (flash_io2 and flash_io3) */
    gpio_control_block #(
	.MGMT_INIT(1'b1),	// Management-controlled
	.OENB_INIT(1'b1)	// Output controlled from bidirectional pin
    ) gpio_control_bidir_2 [1:0] (
    	`ifdef USE_POWER_PINS
			.vccd(vccd_core),
			.vssd(vssd_core),
			.vccd1(vccd1_core),
			.vssd1(vssd1_core),
        `endif

    	// Management Soc-facing signals

    	.resetn(gpio_resetn_1_shifted[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),
    	.serial_clock(gpio_clock_1_shifted[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),

    	.resetn_out(gpio_resetn_1[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),
    	.serial_clock_out(gpio_clock_1[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),

    	.mgmt_gpio_in(mgmt_io_in[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
		.mgmt_gpio_out({gpio_flash_io3_out, gpio_flash_io2_out}),
		.mgmt_gpio_oeb({flash_io3_oeb_core, flash_io2_oeb_core}),

        .one(),
        .zero(),

    	// Serial data chain for pad configuration
    	.serial_data_in(gpio_serial_link_2_shifted[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),
    	.serial_data_out(gpio_serial_link_2[(`MPRJ_IO_PADS_2-1):(`MPRJ_IO_PADS_2-2)]),

    	// User-facing signals
    	.user_gpio_out(user_io_out[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.user_gpio_oeb(user_io_oeb[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.user_gpio_in(user_io_in[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),

    	// Pad-facing signals (Pad GPIOv2)
    	.pad_gpio_inenb(mprj_io_inp_dis[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_ib_mode_sel(mprj_io_ib_mode_sel[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_vtrip_sel(mprj_io_vtrip_sel[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_slow_sel(mprj_io_slow_sel[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_holdover(mprj_io_holdover[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_ana_en(mprj_io_analog_en[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_ana_sel(mprj_io_analog_sel[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_ana_pol(mprj_io_analog_pol[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_dm(mprj_io_dm[(`MPRJ_IO_PADS*3-1):(`MPRJ_IO_PADS*3-6)]),
    	.pad_gpio_outenb(mprj_io_oeb[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_out(mprj_io_out[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)]),
    	.pad_gpio_in(mprj_io_in[(`MPRJ_IO_PADS-1):(`MPRJ_IO_PADS-2)])
    );

    /* Section 2 GPIOs (GPIO 19 to 37) */
    wire [`MPRJ_IO_PADS_2-3:0] one_loop2;
    gpio_control_block gpio_control_in_2 [`MPRJ_IO_PADS_2-3:0] (
    	`ifdef USE_POWER_PINS
        .vccd(vccd_core),
		.vssd(vssd_core),
		.vccd1(vccd1_core),
		.vssd1(vssd1_core),
        `endif

    	// Management Soc-facing signals

    	.resetn(gpio_resetn_1_shifted[(`MPRJ_IO_PADS_2-3):0]),
    	.serial_clock(gpio_clock_1_shifted[(`MPRJ_IO_PADS_2-3):0]),

    	.resetn_out(gpio_resetn_1[(`MPRJ_IO_PADS_2-3):0]),
    	.serial_clock_out(gpio_clock_1[(`MPRJ_IO_PADS_2-3):0]),

		.mgmt_gpio_in(mgmt_io_in[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
		.mgmt_gpio_out(mgmt_io_in[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
		.mgmt_gpio_oeb(one_loop2),

        .one(one_loop2),
        .zero(),

    	// Serial data chain for pad configuration
    	.serial_data_in(gpio_serial_link_2_shifted[(`MPRJ_IO_PADS_2-3):0]),
    	.serial_data_out(gpio_serial_link_2[(`MPRJ_IO_PADS_2-3):0]),

    	// User-facing signals
    	.user_gpio_out(user_io_out[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.user_gpio_oeb(user_io_oeb[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.user_gpio_in(user_io_in[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),

    	// Pad-facing signals (Pad GPIOv2)
    	.pad_gpio_inenb(mprj_io_inp_dis[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_ib_mode_sel(mprj_io_ib_mode_sel[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_vtrip_sel(mprj_io_vtrip_sel[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_slow_sel(mprj_io_slow_sel[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_holdover(mprj_io_holdover[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_ana_en(mprj_io_analog_en[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_ana_sel(mprj_io_analog_sel[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_ana_pol(mprj_io_analog_pol[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_dm(mprj_io_dm[(`MPRJ_IO_PADS*3-7):(`MPRJ_IO_PADS_1*3)]),
    	.pad_gpio_outenb(mprj_io_oeb[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_out(mprj_io_out[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)]),
    	.pad_gpio_in(mprj_io_in[(`MPRJ_IO_PADS-3):(`MPRJ_IO_PADS_1)])
    );

    user_id_programming #(
	.USER_PROJECT_ID(USER_PROJECT_ID)
    ) user_id_value (
	`ifdef USE_POWER_PINS
		.VPWR(vccd_core),
		.VGND(vssd_core),
	`endif
	.mask_rev(mask_rev)
    );

    // Power-on-reset circuit
    simple_por por (
	`ifdef USE_POWER_PINS
		.vdd3v3(vddio_core),
		.vdd1v8(vccd_core),
		.vss(vssio_core),
	`endif
		.porb_h(porb_h),
		.porb_l(porb_l),
		.por_l(por_l)
    );

    // XRES (chip input pin reset) reset level converter
    sky130_fd_sc_hvl__lsbufhv2lv_1_wrapped rstb_level (
	`ifdef USE_POWER_PINS
		.VPWR(vddio_core),
		.LVPWR(vccd_core),
		.LVGND(vssd_core),
		.VGND(vssio_core),
	`endif
		.A(rstb_h),
		.X(rstb_l)
    );

endmodule
// `default_nettype wire
