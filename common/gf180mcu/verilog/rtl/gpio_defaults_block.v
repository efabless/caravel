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
// level.  This value is passed as a set of parameters.

module gpio_defaults_block #(
    // Parameterized initial startup state of the pad.  The default
    // parameters if unspecified is for the pad to be a user input
    // with no pull-up or pull-down, so that it is disconnected
    // from the outside world.  See defs.h for configuration word
    // definitions.  Bits set:  MGMT_EN, OE_OVR, IE (management
    // enable, output enable override, input enable).
    parameter GPIO_CONFIG_INIT = 10'h007
) (
`ifdef USE_POWER_PINS
    inout VDD,
    inout VSS,
`endif
    output [9:0] gpio_defaults
);
    wire [9:0] gpio_defaults;
    wire [9:0] gpio_defaults_high;
    wire [9:0] gpio_defaults_low;

    // For the mask revision input, use an array of digital constant logic cells
    // NOTE:  These need to be placed in pairs in the same order.  Manual placement
    // required.

    gf180mcu_fd_sc_mcu7t5v0__tieh gpio_default_value_one [9:0] (
`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
`endif
            .Z(gpio_defaults_high)
    );

    gf180mcu_fd_sc_mcu7t5v0__tiel gpio_default_value_zero [9:0] (
`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
`endif
            .ZN(gpio_defaults_low)
    );

    genvar i;
    generate
        for (i = 0; i < 10; i = i+1) begin
    	    assign gpio_defaults[i] = (GPIO_CONFIG_INIT & (10'h001 << i)) ?
			gpio_defaults_high[i] : gpio_defaults_low[i];
	end
    endgenerate

endmodule
`default_nettype wire
