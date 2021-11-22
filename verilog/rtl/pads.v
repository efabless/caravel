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
`ifndef TOP_ROUTING 
	`define USER1_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa1),\
	.VDDA(vdda1),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q)

	`define USER2_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa2),\
	.VDDA(vdda2),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q)

	`define MGMT_ABUTMENT_PINS \
	.AMUXBUS_A(analog_a),\
	.AMUXBUS_B(analog_b),\
	.VSSA(vssa),\
	.VDDA(vdda),\
	.VSWITCH(vddio),\
	.VDDIO_Q(vddio_q),\
	.VCCHIB(vccd),\
	.VDDIO(vddio),\
	.VCCD(vccd),\
	.VSSIO(vssio),\
	.VSSD(vssd),\
	.VSSIO_Q(vssio_q)
`else 
	`define USER1_ABUTMENT_PINS 
	`define USER2_ABUTMENT_PINS 
	`define MGMT_ABUTMENT_PINS 
`endif

`define HVCLAMP_PINS(H,L) \
	.DRN_HVC(H), \
	.SRC_BDY_HVC(L)

`define LVCLAMP_PINS(H1,L1,H2,L2,L3) \
	.BDY2_B2B(L3), \
	.DRN_LVC1(H1), \
	.DRN_LVC2(H2), \
	.SRC_BDY_LVC1(L1), \
	.SRC_BDY_LVC2(L2)

`define INPUT_PAD(X,Y) \
	wire loop_``X; \
	sky130_ef_io__gpiov2_pad_wrapped X``_pad ( \
	`MGMT_ABUTMENT_PINS \
	`ifndef	TOP_ROUTING \
		,.PAD(X), \
	`endif	\
		.OUT(vssd), \
		.OE_N(vccd), \
		.HLD_H_N(vddio), \
		.ENABLE_H(porb_h), \
		.ENABLE_INP_H(loop_``X), \
		.ENABLE_VDDA_H(porb_h), \
		.ENABLE_VSWITCH_H(vssa), \
		.ENABLE_VDDIO(vccd), \
		.INP_DIS(por), \
		.IB_MODE_SEL(vssd), \
		.VTRIP_SEL(vssd), \
		.SLOW(vssd),	\
		.HLD_OVR(vssd), \
		.ANALOG_EN(vssd), \
		.ANALOG_SEL(vssd), \
		.ANALOG_POL(vssd), \
		.DM({vssd, vssd, vccd}), \
		.PAD_A_NOESD_H(), \
		.PAD_A_ESD_0_H(), \
		.PAD_A_ESD_1_H(), \
		.IN(Y), \
		.IN_H(), \
		.TIE_HI_ESD(), \
		.TIE_LO_ESD(loop_``X) )

`define OUTPUT_PAD(X,Y,INPUT_DIS,OUT_EN_N) \
	wire loop_``X; \
	sky130_ef_io__gpiov2_pad_wrapped X``_pad ( \
	`MGMT_ABUTMENT_PINS \
	`ifndef	TOP_ROUTING \
		,.PAD(X), \
	`endif \
		.OUT(Y), \
		.OE_N(OUT_EN_N), \
		.HLD_H_N(vddio), \
		.ENABLE_H(porb_h),	\
		.ENABLE_INP_H(loop_``X), \
		.ENABLE_VDDA_H(porb_h), \
		.ENABLE_VSWITCH_H(vssa), \
		.ENABLE_VDDIO(vccd), \
		.INP_DIS(INPUT_DIS), \
		.IB_MODE_SEL(vssd), \
		.VTRIP_SEL(vssd), \
		.SLOW(vssd),	\
		.HLD_OVR(vssd), \
		.ANALOG_EN(vssd), \
		.ANALOG_SEL(vssd), \
		.ANALOG_POL(vssd), \
		.DM({vccd, vccd, vssd}),	\
		.PAD_A_NOESD_H(), \
		.PAD_A_ESD_0_H(), \
		.PAD_A_ESD_1_H(), \
		.IN(), \
		.IN_H(), \
		.TIE_HI_ESD(), \
		.TIE_LO_ESD(loop_``X)) 

`define OUTPUT_NO_INP_DIS_PAD(X,Y,OUT_EN_N) \
	wire loop_``X; \
	sky130_ef_io__gpiov2_pad_wrapped X``_pad ( \
	`MGMT_ABUTMENT_PINS \
	`ifndef	TOP_ROUTING \
		,.PAD(X), \
	`endif \
		.OUT(Y), \
		.OE_N(OUT_EN_N), \
		.HLD_H_N(vddio), \
		.ENABLE_H(porb_h),	\
		.ENABLE_INP_H(loop_``X), \
		.ENABLE_VDDA_H(porb_h), \
		.ENABLE_VSWITCH_H(vssa), \
		.ENABLE_VDDIO(vccd), \
		.INP_DIS(loop_``X), \
		.IB_MODE_SEL(vssd), \
		.VTRIP_SEL(vssd), \
		.SLOW(vssd),	\
		.HLD_OVR(vssd), \
		.ANALOG_EN(vssd), \
		.ANALOG_SEL(vssd), \
		.ANALOG_POL(vssd), \
		.DM({vccd, vccd, vssd}),	\
		.PAD_A_NOESD_H(), \
		.PAD_A_ESD_0_H(), \
		.PAD_A_ESD_1_H(), \
		.IN(), \
		.IN_H(), \
		.TIE_HI_ESD(), \
		.TIE_LO_ESD(loop_``X)) 

`define INOUT_PAD(X,Y,Y_OUT,INPUT_DIS,OUT_EN_N,MODE) \
	wire loop_``X; \
	sky130_ef_io__gpiov2_pad_wrapped X``_pad ( \
	`MGMT_ABUTMENT_PINS \
	`ifndef	TOP_ROUTING \
		,.PAD(X), \
	`endif	\
		.OUT(Y_OUT),	\
		.OE_N(OUT_EN_N), \
		.HLD_H_N(vddio),	\
		.ENABLE_H(porb_h), \
		.ENABLE_INP_H(loop_``X), \
		.ENABLE_VDDA_H(porb_h), \
		.ENABLE_VSWITCH_H(vssa), \
		.ENABLE_VDDIO(vccd), \
		.INP_DIS(INPUT_DIS), \
		.IB_MODE_SEL(vssd), \
		.VTRIP_SEL(vssd), \
		.SLOW(vssd),	\
		.HLD_OVR(vssd), \
		.ANALOG_EN(vssd), \
		.ANALOG_SEL(vssd), \
		.ANALOG_POL(vssd), \
		.DM(MODE), \
		.PAD_A_NOESD_H(), \
		.PAD_A_ESD_0_H(), \
		.PAD_A_ESD_1_H(), \
		.IN(Y),  \
		.IN_H(), \
		.TIE_HI_ESD(), \
		.TIE_LO_ESD(loop_``X) )

// `default_nettype wire
