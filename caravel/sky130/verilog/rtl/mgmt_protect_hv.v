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

`default_nettype none
/*----------------------------------------------------------------------*/
/* mgmt_protect_hv:							*/
/*									*/
/* High voltage (3.3V) part of the mgmt_protect module.  Split out into	*/
/* a separate module and file so that the synthesis tools can handle it	*/
/* separately from the rest, since it uses a different standard cell	*/
/* library.  See the file mgmt_protect.v for a full description of the	*/
/* whole management protection method.					*/
/*----------------------------------------------------------------------*/

module mgmt_protect_hv (
`ifdef USE_POWER_PINS
    inout	vccd,
    inout	vssd,
    inout	vdda1,
    inout	vssa1,
    inout	vdda2,
    inout	vssa2,
`endif

    output	mprj_vdd_logic1,
    output	mprj2_vdd_logic1

);

    wire mprj_vdd_logic1_h;
    wire mprj2_vdd_logic1_h;

`ifdef USE_POWER_PINS
    // This is to emulate the substrate shorting grounds together for LVS
    // purposes
    assign vssa2 = vssa1;
    assign vssa1 = vssd;
`endif

    // Logic high in the VDDA (3.3V) domains

    sky130_fd_sc_hvl__conb_1 mprj_logic_high_hvl (
`ifdef USE_POWER_PINS
        .VPWR(vdda1),
        .VGND(vssa1),
        .VPB(vdda1),
        .VNB(vssa1),
`endif
        .HI(mprj_vdd_logic1_h),
        .LO()
    );

    sky130_fd_sc_hvl__conb_1 mprj2_logic_high_hvl (
`ifdef USE_POWER_PINS
        .VPWR(vdda2),
        .VGND(vssa2),
        .VPB(vdda2),
        .VNB(vssa2),
`endif
        .HI(mprj2_vdd_logic1_h),
        .LO()
    );

    // Level shift the logic high signals into the 1.8V domain

    sky130_fd_sc_hvl__lsbufhv2lv_1 mprj_logic_high_lv (
`ifdef USE_POWER_PINS
	.VPWR(vdda1),
	.VGND(vssd),
	.LVPWR(vccd),
	.VPB(vdda1),
	.VNB(vssd),
`endif
	.X(mprj_vdd_logic1),
	.A(mprj_vdd_logic1_h)
    );

    sky130_fd_sc_hvl__lsbufhv2lv_1 mprj2_logic_high_lv (
`ifdef USE_POWER_PINS
	.VPWR(vdda2),
	.VGND(vssd),
	.LVPWR(vccd),
	.VPB(vdda2),
	.VNB(vssd),
`endif
	.X(mprj2_vdd_logic1),
	.A(mprj2_vdd_logic1_h)
    );
endmodule

`default_nettype wire
