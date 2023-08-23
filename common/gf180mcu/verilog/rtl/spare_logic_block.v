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
// a design.  It contains flops, taps, muxes, and diodes in addition
// to inverters, NOR, NAND, and constant gates.

module spare_logic_block (
    `ifdef USE_POWER_PINS
        inout VDD,
        inout VSS,
    `endif

    output [30:0] spare_xz,	// Constant 0 outputs (and block inputs)
    output [3:0]  spare_xi,	// Inverter outputs
    output	  spare_xib,	// Big inverter output
    output [1:0]  spare_xna,	// NAND outputs
    output [1:0]  spare_xno,	// NOR outputs
    output [1:0]  spare_xmx,	// Mux outputs
    output [1:0]  spare_xfq	// Flop noninverted output
);

    wire [3:0] spare_logic_nc;

    wire [3:0] spare_xi;
    wire       spare_xib;
    wire [1:0] spare_xna;
    wire [1:0] spare_xno;
    wire [1:0] spare_xmx;
    wire [1:0] spare_xfq;

    wire [26:0] spare_logic0;
    wire [3:0] spare_logic1;
    wire [30:0] spare_xz;

    // Rename the logic0 outputs at the block pins.
    assign spare_xz = {spare_logic1, spare_logic0};

    gf180mcu_fd_sc_mcu7t5v0__tiel spare_logic_const_zero [26:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .ZN(spare_logic0)
    );

    gf180mcu_fd_sc_mcu7t5v0__tieh spare_logic_const_one [3:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .Z(spare_logic1)
    );

    gf180mcu_fd_sc_mcu7t5v0__inv_2 spare_logic_inv [3:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .ZN(spare_xi),
            .I(spare_logic0[3:0])
    );

    gf180mcu_fd_sc_mcu7t5v0__inv_12 spare_logic_biginv (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .ZN(spare_xib),
            .I(spare_logic0[4])
    );

    gf180mcu_fd_sc_mcu7t5v0__nand2_2 spare_logic_nand [1:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .ZN(spare_xna),
            .A1(spare_logic0[6:5]),
            .A2(spare_logic0[8:7])
    );

    gf180mcu_fd_sc_mcu7t5v0__nor2_2 spare_logic_nor [1:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .ZN(spare_xno),
            .A1(spare_logic0[10:9]),
            .A2(spare_logic0[12:11])
    );

    gf180mcu_fd_sc_mcu7t5v0__mux2_2 spare_logic_mux [1:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .Z(spare_xmx),
            .I0(spare_logic0[14:13]),
            .I1(spare_logic0[16:15]),
            .S(spare_logic0[18:17])
    );

    gf180mcu_fd_sc_mcu7t5v0__dffrsnq_2 spare_logic_flop [1:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
            .Q(spare_xfq),
            .D(spare_logic0[20:19]),
            .CLK(spare_logic0[22:21]),
            .SETN(spare_logic0[24:23]),
            .RN(spare_logic0[26:25])
    );

    gf180mcu_fd_sc_mcu7t5v0__antenna spare_logic_diode [3:0] (
	`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
	`endif
	    .I(spare_logic_nc)
    );
 
endmodule
`default_nettype wire
