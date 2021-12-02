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
// This routine synchronizes the 

module caravel_clocking(
`ifdef USE_POWER_PINS
    input VPWR,
    input VGND,
`endif
    input resetb, 	// Master (negative sense) reset
    input ext_clk_sel,	// 0=use PLL clock, 1=use external (pad) clock
    input ext_clk,	// External pad (slow) clock
    input pll_clk,	// Internal PLL (fast) clock
    input pll_clk90,	// Internal PLL (fast) clock, 90 degree phase
    input [2:0] sel,	// Select clock divider value (0=thru, 1=divide-by-2, etc.)
    input [2:0] sel2,	// Select clock divider value for 90 degree phase divided clock
    input ext_reset,	// Positive sense reset from housekeeping SPI.
    output core_clk,	// Output core clock
    output user_clk,	// Output user (secondary) clock
    output resetb_sync	// Output propagated and buffered reset
);

    wire pll_clk_sel;
    wire pll_clk_divided;
    wire pll_clk90_divided;
    wire core_ext_clk;
    reg  use_pll_first;
    reg  use_pll_second;
    reg	 ext_clk_syncd_pre;
    reg	 ext_clk_syncd;

    assign pll_clk_sel = ~ext_clk_sel;

    // Note that this implementation does not guard against switching to
    // the PLL clock if the PLL clock is not present.

    always @(posedge pll_clk or negedge resetb) begin
	if (resetb == 1'b0) begin
	    use_pll_first <= 1'b0;
	    use_pll_second <= 1'b0;
	    ext_clk_syncd <= 1'b0;
	end else begin
	    use_pll_first <= pll_clk_sel;
	    use_pll_second <= use_pll_first;
	    ext_clk_syncd_pre <= ext_clk;	// Sync ext_clk to pll_clk
	    ext_clk_syncd <= ext_clk_syncd_pre;	// Do this twice (resolve metastability)
	end
    end

    // Apply PLL clock divider

    clock_div #(
	.SIZE(3)
    ) divider (
	.in(pll_clk),
	.out(pll_clk_divided),
	.N(sel),
	.resetb(resetb)
    ); 

    // Secondary PLL clock divider for user space access

    clock_div #(
	.SIZE(3)
    ) divider2 (
	.in(pll_clk90),
	.out(pll_clk90_divided),
	.N(sel2),
	.resetb(resetb)
    ); 


    // Multiplex the clock output

    assign core_ext_clk = (use_pll_first) ? ext_clk_syncd : ext_clk;
    assign core_clk = (use_pll_second) ? pll_clk_divided : core_ext_clk;
    assign user_clk = (use_pll_second) ? pll_clk90_divided : core_ext_clk;

    // Reset assignment.  "reset" comes from POR, while "ext_reset"
    // comes from standalone SPI (and is normally zero unless
    // activated from the SPI).

    // Staged-delay reset
    reg [2:0] reset_delay;

    always @(negedge core_clk or negedge resetb) begin
        if (resetb == 1'b0) begin
        reset_delay <= 3'b111;
        end else begin
        reset_delay <= {1'b0, reset_delay[2:1]};
        end
    end

    assign resetb_sync = ~(reset_delay[0] | ext_reset);

endmodule
`default_nettype wire
