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

// This module represents an unprogrammed set of GPIO pad default
// values that is configured with via programming on the chip top
// level.  This value is passed as a set of parameters (formerly
// part of gpio_control_block.v).

module gpio_defaults_block #(
    // Parameterized initial startup state of the pad.  The default
    // parameters if unspecified is for the pad to be a user input
    // with no pull-up or pull-down, so that it is disconnected
    // from the outside world.  See defs.h for configuration word
    // definitions.
    parameter GPIO_CONFIG_INIT = 13'h0402
) (
`ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
`endif
    output [12:0] gpio_defaults
);
    wire [12:0] gpio_defaults;
    wire [12:0] gpio_defaults_high;
    wire [12:0] gpio_defaults_low;

    // For the mask revision input, use an array of digital constant logic cells

    sky130_fd_sc_hd__conb_1 gpio_default_value [12:0] (
`ifdef USE_POWER_PINS
            .VPWR(VPWR),
            .VPB(VPWR),
            .VNB(VGND),
            .VGND(VGND),
`endif
            .HI(gpio_defaults_high),
            .LO(gpio_defaults_low)
    );

    genvar i;
    generate
        for (i = 0; i < 13; i = i+1) begin
    	    assign gpio_defaults[i] = (GPIO_CONFIG_INIT & (13'h0001 << i)) ?
			gpio_defaults_high[i] : gpio_defaults_low[i];
	end
    endgenerate

endmodule
`default_nettype wire
