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

/* chip_io_openframe ---
 *
 * RTL verilog definition of the padframe for the open-frame version
 * of the Caravel harness chip, sky130 process
 *
 * Written by Tim Edwards
 * March 27, 2023
 */

// `default_nettype none
module chip_io_openframe #(
	parameter USER_PROJECT_ID = 32'h00000000
) (
	// Package Pins
	inout  vddio_pad,		// Common padframe/ESD supply
	inout  vddio_pad2,
	inout  vssio_pad,		// Common padframe/ESD ground
	inout  vssio_pad2,
	inout  vccd_pad,		// Common 1.8V supply
	inout  vssd_pad,		// Common digital ground
	inout  vdda_pad,		// User area 0 3.3V supply
	inout  vssa_pad,		// User area 0 analog ground
	inout  vdda1_pad,		// User area 1 3.3V supply
	inout  vdda1_pad2,		
	inout  vdda2_pad,		// User area 2 3.3V supply
	inout  vssa1_pad,		// User area 1 analog ground
	inout  vssa1_pad2,
	inout  vssa2_pad,		// User area 2 analog ground
	inout  vccd1_pad,		// User area 1 1.8V supply
	inout  vccd2_pad,		// User area 2 1.8V supply
	inout  vssd1_pad,		// User area 1 digital ground
	inout  vssd2_pad,		// User area 2 digital ground

	// Core Side
	inout  vddio,		// Common padframe/ESD supply
	inout  vssio,		// Common padframe/ESD ground
	inout  vccd,		// Common 1.8V supply
	inout  vssd,		// Common digital ground
	inout  vdda,		// User area 0 3.3V supply
	inout  vssa,		// User area 0 analog ground
	inout  vdda1,		// User area 1 3.3V supply
	inout  vdda2,		// User area 2 3.3V supply
	inout  vssa1,		// User area 1 analog ground
	inout  vssa2,		// User area 2 analog ground
	inout  vccd1,		// User area 1 1.8V supply
	inout  vccd2,		// User area 2 1.8V supply
	inout  vssd1,		// User area 1 digital ground
	inout  vssd2,		// User area 2 digital ground

	input  resetb_pad,

	// Chip Core Interface
	output  porb_h,
	output  porb_l,
	output  por_l,
	output  resetb_h,
	output  resetb_l,
	output [31:0] mask_rev,

	// User project IOs
	inout [`OPENFRAME_IO_PADS-1:0] gpio,
	input [`OPENFRAME_IO_PADS-1:0] gpio_out,
	input [`OPENFRAME_IO_PADS-1:0] gpio_oeb,
	input [`OPENFRAME_IO_PADS-1:0] gpio_inp_dis,
	input [`OPENFRAME_IO_PADS-1:0] gpio_ib_mode_sel,
	input [`OPENFRAME_IO_PADS-1:0] gpio_vtrip_sel,
	input [`OPENFRAME_IO_PADS-1:0] gpio_slow_sel,
	input [`OPENFRAME_IO_PADS-1:0] gpio_holdover,
	input [`OPENFRAME_IO_PADS-1:0] gpio_analog_en,
	input [`OPENFRAME_IO_PADS-1:0] gpio_analog_sel,
	input [`OPENFRAME_IO_PADS-1:0] gpio_analog_pol,
	input [`OPENFRAME_IO_PADS-1:0] gpio_dm0,
	input [`OPENFRAME_IO_PADS-1:0] gpio_dm1,
	input [`OPENFRAME_IO_PADS-1:0] gpio_dm2,
	output [`OPENFRAME_IO_PADS-1:0] gpio_in,
	output [`OPENFRAME_IO_PADS-1:0] gpio_in_h,
	output [`OPENFRAME_IO_PADS-1:0] gpio_loopback_zero,
	output [`OPENFRAME_IO_PADS-1:0] gpio_loopback_one,
	inout [`OPENFRAME_IO_PADS-1:0] analog_io,
	inout [`OPENFRAME_IO_PADS-1:0] analog_noesd_io
);

	// To be considered:  Individual hold signals on all GPIO pads
	// For now, set holdh_n to 1 internally (NOTE:  This is in the
	// VDDIO 3.3V domain) and set enh to porb_h for all GPIO pads.

	wire [`OPENFRAME_IO_PADS-1:0] gpio_enh;

	assign gpio_enh = {`OPENFRAME_IO_PADS{porb_h}};
	
	// Internal bus wires
	wire analog_a, analog_b;
	wire vddio_q, vssio_q;

	// Instantiate power and ground pads for management domain
	// 12 pads:  vddio, vssio, vdda, vssa, vccd, vssd
	// One each HV and LV clamp.

	// HV clamps connect between one HV power rail and one ground
	// LV clamps have two clamps connecting between any two LV power
	// rails and grounds, and one back-to-back diode which connects
	// between the first LV clamp ground and any other ground.

    	sky130_ef_io__vddio_hvc_clamped_pad user0_vddio_hvclamp_pad_0  (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDIO_PAD(vddio_pad)
`endif
    	);

	// lies in user area 2
    	sky130_ef_io__vddio_hvc_clamped_pad user0_vddio_hvclamp_pad_1  (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDIO_PAD(vddio_pad2)
`endif
    	);

    	sky130_ef_io__vdda_hvc_clamped_pad user0_vdda_hvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda_pad)
`endif
    	);

    	sky130_ef_io__vccd_lvc_clamped_pad user0_vccd_lvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd_pad)
`endif
    	);

    	sky130_ef_io__vssio_hvc_clamped_pad user0_vssio_hvclamp_pad_0  (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSIO_PAD(vssio_pad)
`endif
    	);

    	sky130_ef_io__vssio_hvc_clamped_pad user0_vssio_hvclamp_pad_1  (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSIO_PAD(vssio_pad2)
`endif
    	);

    	sky130_ef_io__vssa_hvc_clamped_pad user0_vssa_hvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa_pad)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped_pad user0_vssd_lvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd_pad)
`endif
    	);

	// Instantiate power and ground pads for user 1 domain
	// 8 pads:  vdda, vssa, vccd, vssd;  One each HV and LV clamp.

    	sky130_ef_io__vdda_hvc_clamped_pad user1_vdda_hvclamp_pad_0 (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda1_pad)
`endif
    	);

		sky130_ef_io__vdda_hvc_clamped_pad user1_vdda_hvclamp_pad_1 (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda1_pad2)
`endif
    	);

    	sky130_ef_io__vccd_lvc_clamped3_pad user1_vccd_lvclamp_pad (
		`USER1_ABUTMENT_PINS
		.VCCD1(vccd1),
		.VSSD1(vssd1),
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd1_pad)
`endif
    	);

    	sky130_ef_io__vssa_hvc_clamped_pad user1_vssa_hvclamp_pad_0 (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa1_pad)
`endif
    	);


    	sky130_ef_io__vssa_hvc_clamped_pad user1_vssa_hvclamp_pad_1 (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa1_pad2)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped3_pad user1_vssd_lvclamp_pad (
		`USER1_ABUTMENT_PINS
		.VCCD1(vccd1),
		.VSSD1(vssd1),
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd1_pad)
`endif
    	);

	// Instantiate power and ground pads for user 2 domain
	// 8 pads:  vdda, vssa, vccd, vssd;  One each HV and LV clamp.

    	sky130_ef_io__vdda_hvc_clamped_pad user2_vdda_hvclamp_pad (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda2_pad)
`endif
    	);

    	sky130_ef_io__vccd_lvc_clamped3_pad user2_vccd_lvclamp_pad (
		`USER2_ABUTMENT_PINS
		.VCCD1(vccd2),
		.VSSD1(vssd2),
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd2_pad)
`endif
    	);

    	sky130_ef_io__vssa_hvc_clamped_pad user2_vssa_hvclamp_pad (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa2_pad)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped3_pad user2_vssd_lvclamp_pad (
		`USER2_ABUTMENT_PINS
		.VCCD1(vccd2),
		.VSSD1(vssd2),
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd2_pad)
`endif
    	);

	// Constant values in 1.8V domain to drive constant signals on GPIO pads
	// These are exported to the user project for direct loopback if needed.

	constant_block constant_value_inst [`OPENFRAME_IO_PADS-1:0] (
		.vccd(vccd),
		.vssd(vssd),
		.one(gpio_loopback_one),
		.zero(gpio_loopback_zero)
	);

	// One additional constant block provides the constant one value
	// for the reset pad (see below)

	wire xres_loopback_one;
	wire xres_loopback_zero;

	constant_block constant_value_xres_inst (
		.vccd(vccd),
		.vssd(vssd),
		.one(xres_loopback_one),
		.zero(xres_loopback_zero)	// (unused)
	);

	// Master reset pad (only digital pad not assigned as GPIO)

	wire xresloop;
	wire xres_vss_loop;

	sky130_fd_io__top_xres4v2 master_resetb_pad (
		`MGMT_ABUTMENT_PINS
		`ifndef	TOP_ROUTING
		    .PAD(resetb_pad),
		`endif
		.TIE_WEAK_HI_H(xresloop),   // Loop-back connection to pad through pad_a_esd_h
		.TIE_HI_ESD(),
		.TIE_LO_ESD(xres_vss_loop),
		.PAD_A_ESD_H(xresloop),
		.XRES_H_N(resetb_h),
		.DISABLE_PULLUP_H(xres_vss_loop), // 0 = enable pull-up on reset pad
		.ENABLE_H(porb_h),	 	  // Power-on-reset
   		.EN_VDDIO_SIG_H(xres_vss_loop),	  // No idea.
   		.INP_SEL_H(xres_vss_loop),	  // 1 = use filt_in_h else filter the pad input
   		.FILT_IN_H(xres_vss_loop),	  // Alternate input for glitch filter
   		.PULLUP_H(xres_vss_loop),	  // Pullup connection for alternate filter input
		.ENABLE_VDDIO(xres_loopback_one)
    	);

	// Buffer the reset pad output to generate a signal in the 1.8V domain

	xres_buf rstb_level (
`ifdef USE_POWER_PINS
		.VPWR(vddio),
		.LVPWR(vccd),
		.LVGND(vssd),
		.VGND(vssio),
`endif
		.A(resetb_h),
		.X(resetb_l)
	);

	// Power-on-reset circuit

	simple_por por (
`ifdef USE_POWER_PINS
		.vdd3v3(vddio),
		.vdd1v8(vccd),
		.vss3v3(vssio),
		.vss1v8(vssd),
`endif
		.porb_h(porb_h),
		.porb_l(porb_l),
		.por_l(por_l)
	);

	// User ID block
	user_id_programming #(
		.USER_PROJECT_ID(USER_PROJECT_ID)
	) user_id_value (
	`ifdef USE_POWER_PINS
		.VPWR(vccd),
		.VGND(vssd),
	`endif
		.mask_rev(mask_rev)
	);

	// Corner cells (These are overlay cells;  it is not clear what is normally
    	// supposed to go under them.)

	sky130_ef_io__corner_pad user0_corner [1:0] (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa),
		.VSWITCH(vddio),
		.VDDA(vdda),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
	);
	sky130_ef_io__corner_pad user1_corner (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa1),
		.VSWITCH(vddio),
		.VDDA(vdda1),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
	);
	sky130_ef_io__corner_pad user2_corner (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa2),
		.VSWITCH(vddio),
		.VDDA(vdda2),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
    	);

	wire [`OPENFRAME_IO_PADS-1:0] loop0_gpio;	// Internal loopback to 3.3V domain ground
	wire [`OPENFRAME_IO_PADS-1:0] loop1_gpio;	// Internal loopback to 3.3V domain power

	/* Digital mode signal DM is the interleaved concatenation of	*/
	/* GPIO signals dm2, dm1, and dm0 when passed to the GPIO pad	*/
	/* array, so generated the concatenated signal dm_all.		*/

	wire [(`OPENFRAME_IO_PADS * 3)-1:0] gpio_dm_all;

	genvar i;
	generate
		for (i = 0; i < `OPENFRAME_IO_PADS; i = i+1) begin
			assign gpio_dm_all[(i*3) + 2] = gpio_dm2[i];
			assign gpio_dm_all[(i*3) + 1] = gpio_dm1[i];
			assign gpio_dm_all[(i*3) + 0] = gpio_dm0[i];
		end
	endgenerate

	/* Openframe pads (right side, power domain 1) */

	sky130_ef_io__gpiov2_pad_wrapped  area1_gpio_pad [`MPRJ_IO_PADS_1 - 1:0] (
		`USER1_ABUTMENT_PINS
`ifndef	TOP_ROUTING
		.PAD(gpio[`MPRJ_IO_PADS_1 - 1:0]),
`endif
		.OUT(gpio_out[`MPRJ_IO_PADS_1 - 1:0]),
		.OE_N(gpio_oeb[`MPRJ_IO_PADS_1 - 1:0]),
		.HLD_H_N(loop1_gpio[`MPRJ_IO_PADS_1 - 1:0]),
		.ENABLE_H(gpio_enh[`MPRJ_IO_PADS_1 - 1:0]),
		.ENABLE_INP_H(loop0_gpio[`MPRJ_IO_PADS_1 - 1:0]),
		.ENABLE_VDDA_H(porb_h),
		.ENABLE_VSWITCH_H(loop0_gpio[`MPRJ_IO_PADS_1 - 1:0]),
		.ENABLE_VDDIO(gpio_loopback_one[`MPRJ_IO_PADS_1 - 1:0]),
		.INP_DIS(gpio_inp_dis[`MPRJ_IO_PADS_1 - 1:0]),
		.IB_MODE_SEL(gpio_ib_mode_sel[`MPRJ_IO_PADS_1 - 1:0]),
		.VTRIP_SEL(gpio_vtrip_sel[`MPRJ_IO_PADS_1 - 1:0]),
		.SLOW(gpio_slow_sel[`MPRJ_IO_PADS_1 - 1:0]),
		.HLD_OVR(gpio_holdover[`MPRJ_IO_PADS_1 - 1:0]),
		.ANALOG_EN(gpio_analog_en[`MPRJ_IO_PADS_1 - 1:0]),
		.ANALOG_SEL(gpio_analog_sel[`MPRJ_IO_PADS_1 - 1:0]),
		.ANALOG_POL(gpio_analog_pol[`MPRJ_IO_PADS_1 - 1:0]),
		.DM(gpio_dm_all[(`MPRJ_IO_PADS_1)*3 - 1:0]),
		.PAD_A_NOESD_H(analog_noesd_io[`MPRJ_IO_PADS_1 - 1:0]),
		.PAD_A_ESD_0_H(analog_io[`MPRJ_IO_PADS_1 - 1:0]),
		.PAD_A_ESD_1_H(),
		.IN(gpio_in[`MPRJ_IO_PADS_1 - 1:0]),
		.IN_H(gpio_in_h[`MPRJ_IO_PADS_1 - 1:0]),
		.TIE_HI_ESD(loop1_gpio[`MPRJ_IO_PADS_1 - 1:0]),
		.TIE_LO_ESD(loop0_gpio[`MPRJ_IO_PADS_1 - 1:0])
	);

	/* Openframe pads (left side, power domain 2) */

	sky130_ef_io__gpiov2_pad_wrapped area2_gpio_pad [`MPRJ_IO_PADS_2 - 1:0] (
		`USER2_ABUTMENT_PINS
`ifndef	TOP_ROUTING
		.PAD(gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
`endif
		.OUT(gpio_out[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.OE_N(gpio_oeb[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.HLD_H_N(loop1_gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ENABLE_H(gpio_enh[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ENABLE_INP_H(loop0_gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ENABLE_VDDA_H(porb_h),
		.ENABLE_VSWITCH_H(loop0_gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ENABLE_VDDIO(gpio_loopback_one[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.INP_DIS(gpio_inp_dis[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.IB_MODE_SEL(gpio_ib_mode_sel[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.VTRIP_SEL(gpio_vtrip_sel[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.SLOW(gpio_slow_sel[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.HLD_OVR(gpio_holdover[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ANALOG_EN(gpio_analog_en[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ANALOG_SEL(gpio_analog_sel[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.ANALOG_POL(gpio_analog_pol[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.DM(gpio_dm_all[(`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2)*3 - 1:(`MPRJ_IO_PADS_1)*3]),
		.PAD_A_NOESD_H(analog_noesd_io[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.PAD_A_ESD_0_H(analog_io[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.PAD_A_ESD_1_H(),
		.IN(gpio_in[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.IN_H(gpio_in_h[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.TIE_HI_ESD(loop1_gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1]),
		.TIE_LO_ESD(loop0_gpio[`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2 - 1:`MPRJ_IO_PADS_1])
	);

	/* Openframe pads (bottom side, power domain 0) */

	sky130_ef_io__gpiov2_pad_wrapped  area0_gpio_pad [`OPENFRAME_IO_PADS - (`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2) - 1:0] (
		`MGMT_ABUTMENT_PINS
`ifndef	TOP_ROUTING
		.PAD(gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
`endif
		.OUT(gpio_out[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.OE_N(gpio_oeb[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.HLD_H_N(loop1_gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ENABLE_H(gpio_enh[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ENABLE_INP_H(loop0_gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ENABLE_VDDA_H(porb_h),
		.ENABLE_VSWITCH_H(loop0_gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ENABLE_VDDIO(gpio_loopback_one[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.INP_DIS(gpio_inp_dis[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.IB_MODE_SEL(gpio_ib_mode_sel[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.VTRIP_SEL(gpio_vtrip_sel[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.SLOW(gpio_slow_sel[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.HLD_OVR(gpio_holdover[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ANALOG_EN(gpio_analog_en[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ANALOG_SEL(gpio_analog_sel[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.ANALOG_POL(gpio_analog_pol[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.DM(gpio_dm_all[(`OPENFRAME_IO_PADS)*3 - 1:(`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2)*3]),
		.PAD_A_NOESD_H(analog_noesd_io[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.PAD_A_ESD_0_H(analog_io[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.PAD_A_ESD_1_H(),
		.IN(gpio_in[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.IN_H(gpio_in_h[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.TIE_HI_ESD(loop1_gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2]),
		.TIE_LO_ESD(loop0_gpio[`OPENFRAME_IO_PADS - 1:`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2])
	);

endmodule
// `default_nettype wire

