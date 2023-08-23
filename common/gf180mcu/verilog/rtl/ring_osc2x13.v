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
// Tunable ring oscillator---synthesizable (physical) version.
//
// NOTE:  This netlist cannot be simulated correctly due to lack
// of accurate timing in the digital cell verilog models.

module delay_stage(in, trim, out);
    input in;
    input [1:0] trim;
    output out;

    wire d0, d1, d2, ts;
    wire trim0b, trim1b;

    gf180mcu_fd_sc_mcu7t5v0__inv_1 trim0bar (
	.I(trim[0]),
	.ZN(trim0b)
    );

    gf180mcu_fd_sc_mcu7t5v0__inv_1 trim1bar (
	.I(trim[1]),
	.ZN(trim1b)
    );

    gf180mcu_fd_sc_mcu7t5v0__clkbuf_2 delaybuf0 (
	.I(in),
	.Z(ts)
    );

    gf180mcu_fd_sc_mcu7t5v0__clkbuf_1 delaybuf1 (
	.I(ts),
	.Z(d0)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_2 delayen1 (
	.I(d0),
	.EN(trim[1]),
	.ZN(d1)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_4 delayenb1 (
	.I(ts),
	.EN(trim1b),
	.ZN(d1)
    );

    gf180mcu_fd_sc_mcu7t5v0__clkinv_2 delayint0 (
	.I(d1),
	.ZN(d2)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_2 delayen0 (
	.I(d2),
	.EN(trim[0]),
	.ZN(out)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_8 delayenb0 (
	.I(ts),
	.EN(trim0b),
	.ZN(out)
    );

endmodule

module start_stage(in, trim, reset, out);
    input in;
    input [1:0] trim;
    input reset;
    output out;

    wire d0, d1, d2, ctrl0b, one;
    wire trim1b;

    gf180mcu_fd_sc_mcu7t5v0__inv_1 trim1bar (
	.I(trim[1]),
	.ZN(trim1b)
    );

    gf180mcu_fd_sc_mcu7t5v0__clkbuf_1 delaybuf0 (
	.I(in),
	.Z(d0)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_2 delayen1 (
	.I(d0),
	.EN(trim[1]),
	.ZN(d1)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_4 delayenb1 (
	.I(in),
	.EN(trim1b),
	.ZN(d1)
    );

    gf180mcu_fd_sc_mcu7t5v0__clkinv_1 delayint0 (
	.I(d1),
	.ZN(d2)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_2 delayen0 (
	.I(d2),
	.EN(trim[0]),
	.ZN(out)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_8 delayenb0 (
	.I(in),
	.EN(ctrl0b),
	.ZN(out)
    );

    gf180mcu_fd_sc_mcu7t5v0__invz_1 reseten0 (
	.I(one),
	.EN(reset),
	.ZN(out)
    );

    gf180mcu_fd_sc_mcu7t5v0__nor2_2 ctrlen0 (
	.A1(reset),
	.A2(trim[0]),
	.ZN(ctrl0b)
    );

    gf180mcu_fd_sc_mcu7t5v0__tieh const1 (
	.Z(one)
    );

endmodule

// Ring oscillator with 13 stages, each with two trim bits delay
// (see above).  Trim is not binary:  For trim[1:0], lower bit
// trim[0] is primary trim and must be applied first;  upper
// bit trim[1] is secondary trim and should only be applied
// after the primary trim is applied, or it has no effect.
//
// Total effective number of inverter stages in this oscillator
// ranges from 13 at trim 0 to 65 at trim 24.  The intention is
// to cover a range greater than 2x so that the midrange can be
// reached over all PVT conditions.
//
// Frequency of this ring oscillator under SPICE simulations at
// nominal PVT is maximum 214 MHz (trim 0), minimum 90 MHz (trim 24).

module ring_osc2x13(reset, trim, clockp);
    input reset;
    input [25:0] trim;
    output[1:0] clockp;

`ifdef FUNCTIONAL	// i.e., behavioral model below

    reg [1:0] clockp;
    reg hiclock;
    integer i;
    real delay;
    wire [5:0] bcount;

    assign bcount = trim[0] + trim[1] + trim[2]
		+ trim[3] + trim[4] + trim[5] + trim[6] + trim[7]
		+ trim[8] + trim[9] + trim[10] + trim[11] + trim[12]
		+ trim[13] + trim[14] + trim[15] + trim[16] + trim[17]
		+ trim[18] + trim[19] + trim[20] + trim[21] + trim[22]
		+ trim[23] + trim[24] + trim[25];

    initial begin
	hiclock <= 1'b0;
	delay = 3.0;
    end

    // Fastest operation is 214 MHz = 4.67ns
    // Delay per trim is 0.02385
    // Run "hiclock" at 2x this rate, then use positive and negative
    // edges to derive the 0 and 90 degree phase clocks.

    always #delay begin
	hiclock <= (hiclock === 1'b0);
    end

    always @(trim) begin
    	// Implement trim as a variable delay, one delay per trim bit
	delay = 1.168 + 0.012 * $itor(bcount);
    end

    always @(posedge hiclock or posedge reset) begin
	if (reset == 1'b1) begin
	    clockp[0] <= 1'b0;
	end else begin
	    clockp[0] <= (clockp[0] === 1'b0);
	end
    end

    always @(negedge hiclock or posedge reset) begin
	if (reset == 1'b1) begin
	    clockp[1] <= 1'b0;
	end else begin
	    clockp[1] <= (clockp[1] === 1'b0);
	end
    end

`else 			// !FUNCTIONAL;  i.e., gate level netlist below

    wire [1:0] clockp;
    wire [12:0] d;
    wire [1:0] c;

    // Main oscillator loop stages
 
    genvar i;
    generate
	for (i = 0; i < 12; i = i + 1) begin : dstage
	    delay_stage id (
		.in(d[i]),
		.trim({trim[i+13], trim[i]}),
		.out(d[i+1])
	    );
	end
    endgenerate

    // Reset/startup stage
 
    start_stage iss (
	.in(d[12]),
	.trim({trim[25], trim[12]}),
	.reset(reset),
	.out(d[0])
    );

    // Buffered outputs a 0 and 90 degrees phase (approximately)

    gf180mcu_fd_sc_mcu7t5v0__clkinv_2 ibufp00 (
	.I(d[0]),
	.ZN(c[0])
    );
    gf180mcu_fd_sc_mcu7t5v0__clkinv_8 ibufp01 (
	.I(c[0]),
	.ZN(clockp[0])
    );
    gf180mcu_fd_sc_mcu7t5v0__clkinv_2 ibufp10 (
	.I(d[6]),
	.ZN(c[1])
    );
    gf180mcu_fd_sc_mcu7t5v0__clkinv_8 ibufp11 (
	.I(c[1]),
	.ZN(clockp[1])
    );

`endif // !FUNCTIONAL

endmodule
`default_nettype wire
