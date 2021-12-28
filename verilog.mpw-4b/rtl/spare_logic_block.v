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

// Spare logic block.  This block can be used for metal mask fixes to
// a design.  It is much larger and more comprehensive than the simple
// "macro_sparecell" in the HD library, and contains flops, taps, muxes,
// and diodes in addition to the inverters, NOR, NAND, and constant
// gates provided by macro_sparecell.

module spare_logic_block (
    `ifdef USE_POWER_PINS
        inout vccd,
        inout vssd,
    `endif

    output [26:0] spare_xz,	// Constant 0 outputs (and block inputs)
    output [3:0]  spare_xi,	// Inverter outputs
    output	  spare_xib,	// Big inverter output
    output [1:0]  spare_xna,	// NAND outputs
    output [1:0]  spare_xno,	// NOR outputs
    output [1:0]  spare_xmx,	// Mux outputs
    output [1:0]  spare_xfq,	// Flop noninverted output
    output [1:0]  spare_xfqn 	// Flop inverted output
);

    wire [3:0] spare_logic_nc;

    wire [3:0] spare_xi;
    wire       spare_xib;
    wire [1:0] spare_xna;
    wire [1:0] spare_xno;
    wire [1:0] spare_xmx;
    wire [1:0] spare_xfq;
    wire [1:0] spare_xfqn;

    wire [26:0] spare_logic1;
    wire [26:0] spare_logic0;
    wire [26:0] spare_xz;

    // Rename the logic0 outputs at the block pins.
    assign spare_xz = spare_logic0;

    sky130_fd_sc_hd__conb_1 spare_logic_const [26:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .HI(spare_logic1),
            .LO(spare_logic0)
    );

    sky130_fd_sc_hd__inv_2 spare_logic_inv [3:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .Y(spare_xi),
            .A(spare_logic0[3:0])
    );

    sky130_fd_sc_hd__inv_8 spare_logic_biginv (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .Y(spare_xib),
            .A(spare_logic0[4])
    );

    sky130_fd_sc_hd__nand2_2 spare_logic_nand [1:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .Y(spare_xna),
            .A(spare_logic0[6:5]),
            .B(spare_logic0[8:7])
    );

    sky130_fd_sc_hd__nor2_2 spare_logic_nor [1:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .Y(spare_xno),
            .A(spare_logic0[10:9]),
            .B(spare_logic0[12:11])
    );

    sky130_fd_sc_hd__mux2_2 spare_logic_mux [1:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .X(spare_xmx),
            .A0(spare_logic0[14:13]),
            .A1(spare_logic0[16:15]),
            .S(spare_logic0[18:17])
    );

    sky130_fd_sc_hd__dfbbp_1 spare_logic_flop [1:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
            .Q(spare_xfq),
            .Q_N(spare_xfqn),
            .D(spare_logic0[20:19]),
            .CLK(spare_logic0[22:21]),
            .SET_B(spare_logic0[24:23]),
            .RESET_B(spare_logic0[26:25])
    );

    sky130_fd_sc_hd__tapvpwrvgnd_1 spare_logic_tap [1:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd)
	`endif
    );

    sky130_fd_sc_hd__diode_2 spare_logic_diode [3:0] (
	`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
	`endif
	    .DIODE(spare_logic_nc)
    );
 
endmodule
`default_nettype wire
