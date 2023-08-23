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

/* Integer-N clock divider */
`default_nettype none
 
module clock_div #(
    parameter SIZE = 3		// Number of bits for the divider value
) (
    in, out, N, resetb
);
    input in;			// input clock
    input [SIZE-1:0] N;		// the number to be divided by
    input resetb;		// asynchronous reset (sense negative)
    output out;			// divided output clock
 
    wire out_odd;		// output of odd divider
    wire out_even;		// output of even divider
    wire not_zero;		// signal to find divide by 0 case
    wire enable_even;		// enable of even divider
    wire enable_odd;		// enable of odd divider

    reg [SIZE-1:0] syncN;	// N synchronized to output clock
    reg [SIZE-1:0] syncNp;	// N synchronized to output clock
 
    assign not_zero = | syncN[SIZE-1:1];
 
    assign out = (out_odd & syncN[0] & not_zero) | (out_even & !syncN[0]);
    assign enable_odd = syncN[0] & not_zero;
    assign enable_even = !syncN[0];

    // Divider value synchronization (double-synchronized to avoid metastability)
    always @(posedge out or negedge resetb) begin
	if (resetb == 1'b0) begin
	    syncN <= `CLK_DIV;	// Default to divide-by-2 on system reset
	    syncNp <= `CLK_DIV;	// Default to divide-by-2 on system reset
	end else begin
	    syncNp <= N;
	    syncN <= syncNp;
	end
    end
 
    // Even divider
    even even_0(in, out_even, syncN, resetb, not_zero, enable_even);
    // Odd divider
    odd odd_0(in, out_odd, syncN, resetb, enable_odd);
 
endmodule // clock_div
 
/* Odd divider */

module odd #(
    parameter SIZE = 3
) (
    clk, out, N, resetb, enable
);
    input clk;			// slow clock
    output out;			// fast output clock
    input [SIZE-1:0] N;		// division factor
    input resetb;		// synchronous reset
    input enable;		// odd enable
 
    reg [SIZE-1:0] counter;	// these 2 counters are used
    reg [SIZE-1:0] counter2;	// to non-overlapping signals
    reg out_counter;		// positive edge triggered counter
    reg out_counter2;		// negative edge triggered counter
    reg rst_pulse;		// pulse generated when vector N changes
    reg [SIZE-1:0] old_N;	// gets set to old N when N is changed
    wire not_zero;		// if !not_zero, we devide by 1
 
    // xor to generate 50% duty, half-period waves of final output
    assign out = out_counter2 ^ out_counter;

    // positive edge counter/divider
    always @(posedge clk or negedge resetb) begin
	if (resetb == 1'b0) begin
	    counter <= `CLK_DIV;
	    out_counter <= 1;
	end else if (rst_pulse) begin
	    counter <= N;
	    out_counter <= 1;
	end else if (enable) begin
	    if (counter == 1) begin
		counter <= N;
		out_counter <= ~out_counter;
	    end else begin
		counter <= counter - 1'b1;
	    end
	end
    end
 
    reg [SIZE-1:0] initial_begin;	// this is used to offset the negative edge counter
    wire [SIZE:0] interm_3;		// from the positive edge counter in order to
    assign interm_3 = {1'b0, N} + 2'b11;	// guarantee 50% duty cycle.

    localparam [SIZE:0] interm_init = {1'b0,`CLK_DIV} + 2'b11;

    // Counter driven by negative edge of clock.

    always @(negedge clk or negedge resetb) begin
	if (resetb == 1'b0) begin
	    // reset the counter at system reset
	    counter2 <= `CLK_DIV;
	    initial_begin <= interm_init[SIZE:1];
	    out_counter2 <= 1;
	end else if (rst_pulse) begin
	    // reset the counter at change of N.
	    counter2 <= N;
	    initial_begin <= interm_3[SIZE:1];
	    out_counter2 <= 1;
	end else if ((initial_begin <= 1) && enable) begin

	    // Do normal logic after odd calibration.
	    // This is the same as the even counter.
	    if (counter2 == 1) begin
		counter2 <= N;
		out_counter2 <= ~out_counter2;
	    end else begin
		counter2 <= counter2 - 1'b1;
	    end
	end else if (enable) begin
	    initial_begin <= initial_begin - 1'b1;
	end
    end
 
    //
    // reset pulse generator:
    //               __    __    __    __    _
    // clk:       __/  \__/  \__/  \__/  \__/
    //            _ __________________________
    // N:         _X__________________________
    //               _____
    // rst_pulse: __/     \___________________
    //
    // This block generates an internal reset for the odd divider in the
    // form of a single pulse signal when the odd divider is enabled.

    always @(posedge clk or negedge resetb) begin
	if (resetb == 1'b0) begin
	    rst_pulse <= 0;
	end else if (enable) begin
	    if (N != old_N) begin
		// pulse when reset changes
		rst_pulse <= 1;
	    end else begin
		rst_pulse <= 0;
	    end
	end
    end
 
    always @(posedge clk) begin
	// always save the old N value to guarante reset from
	// an even-to-odd transition.
	old_N <= N;
    end	
 
endmodule // odd

/* Even divider */

module even #(
    parameter SIZE = 3
) (
    clk, out, N, resetb, not_zero, enable
);
    input clk;		// fast input clock
    output out;		// slower divided clock
    input [SIZE-1:0] N;	// divide by factor 'N'
    input resetb;	// asynchronous reset
    input not_zero;	// if !not_zero divide by 1
    input enable;	// enable the even divider
 
    reg [SIZE-1:0] counter;
    reg out_counter;
    wire [SIZE-1:0] div_2;
 
    // if N=0 just output the clock, otherwise, divide it.
    assign out = (clk & !not_zero) | (out_counter & not_zero);
    assign div_2 = {1'b0, N[SIZE-1:1]};
 
    // simple flip-flop even divider
    always @(posedge clk or negedge resetb) begin
	if (resetb == 1'b0) begin
	    counter <= 1;
	    out_counter <= 1;

	end else if (enable) begin
	    // only use switching power if enabled
	    if (counter == 1) begin
		// divide after counter has reached bottom
		// of interval 'N' which will be value '1'
		counter <= div_2;
		out_counter <= ~out_counter;
	    end else begin
		// decrement the counter and wait
		counter <= counter-1;	// to start next transition.
	    end
	end
    end
 
endmodule //even
`default_nettype wire
