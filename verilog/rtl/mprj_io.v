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

// `default_nettype none

/* Define the array of GPIO pads.  Note that the analog project support
 * version of caravel (caravan) defines fewer GPIO and replaces them
 * with analog in the chip_io_alt module.  Because the pad signalling
 * remains the same, `MPRJ_IO_PADS does not change, so a local parameter
 * is made that can be made smaller than `MPRJ_IO_PADS to accommodate
 * the analog pads.
 */

module mprj_io #(
    parameter AREA1PADS = `MPRJ_IO_PADS_1,
    parameter TOTAL_PADS = `MPRJ_IO_PADS
) (
    inout vddio,
    inout vssio,
    inout vdda,
    inout vssa,
    inout vccd,
    inout vssd,

    inout vdda1,
    inout vdda2,
    inout vssa1,
    inout vssa2,

    input vddio_q,
    input vssio_q,
    input analog_a,
    input analog_b,
    input porb_h,
    input [TOTAL_PADS-1:0] vccd_conb,
    inout [TOTAL_PADS-1:0] io,
    input [TOTAL_PADS-1:0] io_out,
    input [TOTAL_PADS-1:0] oeb,
    input [TOTAL_PADS-1:0] enh,
    input [TOTAL_PADS-1:0] inp_dis,
    input [TOTAL_PADS-1:0] ib_mode_sel,
    input [TOTAL_PADS-1:0] vtrip_sel,
    input [TOTAL_PADS-1:0] slow_sel,
    input [TOTAL_PADS-1:0] holdover,
    input [TOTAL_PADS-1:0] analog_en,
    input [TOTAL_PADS-1:0] analog_sel,
    input [TOTAL_PADS-1:0] analog_pol,
    input [TOTAL_PADS*3-1:0] dm,
    output [TOTAL_PADS-1:0] io_in,
    output [TOTAL_PADS-1:0] io_in_3v3,
    inout [TOTAL_PADS-10:0] analog_io,
    inout [TOTAL_PADS-10:0] analog_noesd_io
);

    wire [TOTAL_PADS-1:0] loop0_io;	// Internal loopback to 3.3V domain ground
    wire [TOTAL_PADS-1:0] loop1_io;	// Internal loopback to 3.3V domain power
    wire [6:0] no_connect_1a, no_connect_1b;
    wire [1:0] no_connect_2a, no_connect_2b;

    sky130_ef_io__gpiov2_pad_wrapped  area1_io_pad [AREA1PADS - 1:0] (
	`USER1_ABUTMENT_PINS
	`ifndef	TOP_ROUTING
	    .PAD(io[AREA1PADS - 1:0]),
	`endif
	    .OUT(io_out[AREA1PADS - 1:0]),
	    .OE_N(oeb[AREA1PADS - 1:0]),
	    .HLD_H_N(loop1_io[AREA1PADS - 1:0]),
	    .ENABLE_H(enh[AREA1PADS - 1:0]),
	    .ENABLE_INP_H(loop0_io[AREA1PADS - 1:0]),
	    .ENABLE_VDDA_H(porb_h),
	    .ENABLE_VSWITCH_H(loop0_io[AREA1PADS - 1:0]),
	    .ENABLE_VDDIO(vccd_conb[AREA1PADS - 1:0]),
	    .INP_DIS(inp_dis[AREA1PADS - 1:0]),
	    .IB_MODE_SEL(ib_mode_sel[AREA1PADS - 1:0]),
	    .VTRIP_SEL(vtrip_sel[AREA1PADS - 1:0]),
	    .SLOW(slow_sel[AREA1PADS - 1:0]),
	    .HLD_OVR(holdover[AREA1PADS - 1:0]),
	    .ANALOG_EN(analog_en[AREA1PADS - 1:0]),
	    .ANALOG_SEL(analog_sel[AREA1PADS - 1:0]),
	    .ANALOG_POL(analog_pol[AREA1PADS - 1:0]),
	    .DM(dm[AREA1PADS*3 - 1:0]),
	    .PAD_A_NOESD_H({analog_noesd_io[AREA1PADS - 8:0], no_connect_1a}),
	    .PAD_A_ESD_0_H({analog_io[AREA1PADS - 8:0], no_connect_1b}),
	    .PAD_A_ESD_1_H(),
	    .IN(io_in[AREA1PADS - 1:0]),
	    .IN_H(io_in_3v3[AREA1PADS - 1:0]),
	    .TIE_HI_ESD(loop1_io[AREA1PADS - 1:0]),
	    .TIE_LO_ESD(loop0_io[AREA1PADS - 1:0])
    );

    sky130_ef_io__gpiov2_pad_wrapped area2_io_pad [TOTAL_PADS - AREA1PADS - 1:0] (
	`USER2_ABUTMENT_PINS
	`ifndef	TOP_ROUTING
	    .PAD(io[TOTAL_PADS - 1:AREA1PADS]),
	`endif
	    .OUT(io_out[TOTAL_PADS - 1:AREA1PADS]),
	    .OE_N(oeb[TOTAL_PADS - 1:AREA1PADS]),
	    .HLD_H_N(loop1_io[TOTAL_PADS - 1:AREA1PADS]),
	    .ENABLE_H(enh[TOTAL_PADS - 1:AREA1PADS]),
	    .ENABLE_INP_H(loop0_io[TOTAL_PADS - 1:AREA1PADS]),
	    .ENABLE_VDDA_H(porb_h),
	    .ENABLE_VSWITCH_H(loop0_io[TOTAL_PADS - 1:AREA1PADS]),
	    .ENABLE_VDDIO(vccd_conb[TOTAL_PADS - 1:AREA1PADS]),
	    .INP_DIS(inp_dis[TOTAL_PADS - 1:AREA1PADS]),
	    .IB_MODE_SEL(ib_mode_sel[TOTAL_PADS - 1:AREA1PADS]),
	    .VTRIP_SEL(vtrip_sel[TOTAL_PADS - 1:AREA1PADS]),
	    .SLOW(slow_sel[TOTAL_PADS - 1:AREA1PADS]),
	    .HLD_OVR(holdover[TOTAL_PADS - 1:AREA1PADS]),
	    .ANALOG_EN(analog_en[TOTAL_PADS - 1:AREA1PADS]),
	    .ANALOG_SEL(analog_sel[TOTAL_PADS - 1:AREA1PADS]),
	    .ANALOG_POL(analog_pol[TOTAL_PADS - 1:AREA1PADS]),
	    .DM(dm[TOTAL_PADS*3 - 1:AREA1PADS*3]),
	    .PAD_A_NOESD_H({no_connect_2a, analog_noesd_io[TOTAL_PADS - 10:AREA1PADS - 7]}),
	    .PAD_A_ESD_0_H({no_connect_2b, analog_io[TOTAL_PADS - 10:AREA1PADS - 7]}),
	    .PAD_A_ESD_1_H(),
	    .IN(io_in[TOTAL_PADS - 1:AREA1PADS]),
	    .IN_H(io_in_3v3[TOTAL_PADS - 1:AREA1PADS]),
	    .TIE_HI_ESD(loop1_io[TOTAL_PADS - 1:AREA1PADS]),
	    .TIE_LO_ESD(loop0_io[TOTAL_PADS - 1:AREA1PADS])
    );

endmodule
// `default_nettype wire
