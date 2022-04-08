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
/* 
 *---------------------------------------------------------------------
 * See gpio_control_block for description.  This module is like
 * gpio_contro_block except that it has an additional two management-
 * Soc-facing pins, which are the out_enb line and the output line.
 * If the chip is configured for output with the oeb control
 * register = 1, then the oeb line is controlled by the additional
 * signal from the management SoC.  If the oeb control register = 0,
 * then the output is disabled completely.  The "io" line is input
 * only in this module.
 *
 *---------------------------------------------------------------------
 */

/*
 *---------------------------------------------------------------------
 *
 * This module instantiates a shift register chain that passes through
 * each gpio cell.  These are connected end-to-end around the padframe
 * periphery.  The purpose is to avoid a massive number of control
 * wires between the digital core and I/O, passing through the user area.
 *
 * See mprj_ctrl.v for the module that registers the data for each
 * I/O and drives the input to the shift register.
 *
 *---------------------------------------------------------------------
 */

module gpio_control_block #(
    parameter PAD_CTRL_BITS = 13
) (
    `ifdef USE_POWER_PINS
         inout vccd,
         inout vssd,
         inout vccd1,
         inout vssd1,
    `endif

    // Power-on defaults
    input [PAD_CTRL_BITS-1:0] gpio_defaults,

    // Management Soc-facing signals
    input  	 resetn,		// Global reset, locally propagated
    output       resetn_out,
    input  	 serial_clock,		// Global clock, locally propatated
    output  	 serial_clock_out,
    input	 serial_load,		// Register load strobe
    output	 serial_load_out,

    output       mgmt_gpio_in,		// Management from pad (input only)
    input        mgmt_gpio_out,		// Management to pad (output only)
    input        mgmt_gpio_oeb,		// Management to pad (output only)

    // Serial data chain for pad configuration
    input  	 serial_data_in,
    output 	 serial_data_out,

    // User-facing signals
    input        user_gpio_out,		// User space to pad
    input        user_gpio_oeb,		// Output enable (user)
    output	 user_gpio_in,		// Pad to user space

    // Pad-facing signals (Pad GPIOv2)
    output	 pad_gpio_holdover,
    output	 pad_gpio_slow_sel,
    output	 pad_gpio_vtrip_sel,
    output       pad_gpio_inenb,
    output       pad_gpio_ib_mode_sel,
    output	 pad_gpio_ana_en,
    output	 pad_gpio_ana_sel,
    output	 pad_gpio_ana_pol,
    output [2:0] pad_gpio_dm,
    output       pad_gpio_outenb,
    output	 pad_gpio_out,
    input	 pad_gpio_in,

    // to provide a way to automatically disable/enable output
    // from the outside with needing a conb cell
    output	 one,
    output	 zero
);

    /* Parameters defining the bit offset of each function in the chain */
    localparam MGMT_EN = 0;
    localparam OEB = 1;
    localparam HLDH = 2;
    localparam INP_DIS = 3;
    localparam MOD_SEL = 4;
    localparam AN_EN = 5;
    localparam AN_SEL = 6;
    localparam AN_POL = 7;
    localparam SLOW = 8;
    localparam TRIP = 9;
    localparam DM = 10;

    /* Internally registered signals */
    reg	 	mgmt_ena;		// Enable management SoC to access pad
    reg	 	gpio_holdover;
    reg	 	gpio_slow_sel;
    reg	  	gpio_vtrip_sel;
    reg  	gpio_inenb;
    reg	 	gpio_ib_mode_sel;
    reg  	gpio_outenb;
    reg [2:0] 	gpio_dm;
    reg	 	gpio_ana_en;
    reg	 	gpio_ana_sel;
    reg	 	gpio_ana_pol;

    /* Derived output values */
    wire	pad_gpio_holdover;
    wire	pad_gpio_slow_sel;
    wire	pad_gpio_vtrip_sel;
    wire      	pad_gpio_inenb;
    wire       	pad_gpio_ib_mode_sel;
    wire	pad_gpio_ana_en;
    wire	pad_gpio_ana_sel;
    wire	pad_gpio_ana_pol;
    wire [2:0]  pad_gpio_dm;
    wire        pad_gpio_outenb;
    wire	pad_gpio_out;
    wire	pad_gpio_in;
    wire	one;
    wire	zero;

    wire user_gpio_in;
    wire gpio_in_unbuf;
    wire gpio_logic1;
    wire serial_data_pre;
    wire serial_data_post_1;
    wire serial_data_post_2;

    /* Serial shift for the above (latched) values */
    reg [PAD_CTRL_BITS-1:0] shift_register;

    /* Create internal reset and load signals from input reset and clock */
    assign serial_data_pre = shift_register[PAD_CTRL_BITS-1]; 

    /* Propagate the clock and reset signals so that they aren't wired	*/
    /* all over the chip, but are just wired between the blocks.	*/
    assign serial_clock_out = serial_clock;
    assign resetn_out = resetn;
    assign serial_load_out = serial_load;

    /* Serial data should be buffered again to avoid hold violations	*/
    /* Do this in two ways:  (1) Add internal delay cells, and (2)	*/
    /* add a final logic gate after that.  The logic gate is		*/
    /* synthesized and will be sized appropriately for an output buffer	*/

    sky130_fd_sc_hd__dlygate4sd2_1 data_delay_1 (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .X(serial_data_post_1),
            .A(serial_data_pre)
    );

    sky130_fd_sc_hd__dlygate4sd2_1 data_delay_2 (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .X(serial_data_post_2),
            .A(serial_data_post_1)
    );

    assign serial_data_out = serial_data_post_2 & one;

    always @(posedge serial_clock or negedge resetn) begin
	if (resetn == 1'b0) begin
	    /* Clear shift register */
	    shift_register <= 'd0;
	end else begin
	    /* Shift data in */
	    shift_register <= {shift_register[PAD_CTRL_BITS-2:0], serial_data_in};
	end
    end

    always @(posedge serial_load or negedge resetn) begin
	if (resetn == 1'b0) begin
	    /* Initial state on reset depends on applied defaults */
	    mgmt_ena <= gpio_defaults[MGMT_EN];
	    gpio_holdover <= gpio_defaults[HLDH];
	    gpio_slow_sel <= gpio_defaults[SLOW];
	    gpio_vtrip_sel <= gpio_defaults[TRIP];
            gpio_ib_mode_sel <= gpio_defaults[MOD_SEL];
	    gpio_inenb <= gpio_defaults[INP_DIS];
	    gpio_outenb <= gpio_defaults[OEB];
	    gpio_dm <= gpio_defaults[DM+2:DM];
	    gpio_ana_en <= gpio_defaults[AN_EN];
	    gpio_ana_sel <= gpio_defaults[AN_SEL];
	    gpio_ana_pol <= gpio_defaults[AN_POL];
	end else begin
	    /* Load data */
	    mgmt_ena 	     <= shift_register[MGMT_EN];
	    gpio_outenb      <= shift_register[OEB];
	    gpio_holdover    <= shift_register[HLDH]; 
	    gpio_inenb 	     <= shift_register[INP_DIS];
	    gpio_ib_mode_sel <= shift_register[MOD_SEL];
	    gpio_ana_en      <= shift_register[AN_EN];
	    gpio_ana_sel     <= shift_register[AN_SEL];
	    gpio_ana_pol     <= shift_register[AN_POL];
	    gpio_slow_sel    <= shift_register[SLOW];
	    gpio_vtrip_sel   <= shift_register[TRIP];
	    gpio_dm 	     <= shift_register[DM+2:DM];

	end
    end

    /* These pad configuration signals are static and do not change	*/
    /* after setup.							*/

    assign pad_gpio_holdover 	= gpio_holdover;
    assign pad_gpio_slow_sel 	= gpio_slow_sel;
    assign pad_gpio_vtrip_sel	= gpio_vtrip_sel;
    assign pad_gpio_ib_mode_sel	= gpio_ib_mode_sel;
    assign pad_gpio_ana_en	= gpio_ana_en;
    assign pad_gpio_ana_sel	= gpio_ana_sel;
    assign pad_gpio_ana_pol	= gpio_ana_pol;
    assign pad_gpio_dm		= gpio_dm;
    assign pad_gpio_inenb 	= gpio_inenb;

    /* Implement pad control behavior depending on state of mgmt_ena */

    assign gpio_in_unbuf = pad_gpio_in;
    assign mgmt_gpio_in = (gpio_inenb == 1'b0 && gpio_outenb == 1'b1) ?
			pad_gpio_in : 1'bz;
    assign pad_gpio_outenb = (mgmt_ena) ? ((mgmt_gpio_oeb == 1'b1) ?
			gpio_outenb : 1'b0) : user_gpio_oeb;
    assign pad_gpio_out = (mgmt_ena) ? ((mgmt_gpio_oeb == 1'b1) ?
			((gpio_dm[2:1] == 2'b01) ? ~gpio_dm[0] : mgmt_gpio_out) :
			mgmt_gpio_out) : user_gpio_out; 

    /* Buffer user_gpio_in with an enable that is set by the user domain vccd */

    gpio_logic_high gpio_logic_high (
`ifdef USE_POWER_PINS
            .vccd1(vccd1),
            .vssd1(vssd1),
`endif
            .gpio_logic1(gpio_logic1)
    );

    sky130_fd_sc_hd__einvp_8 gpio_in_buf (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .Z(user_gpio_in),
            .A(~gpio_in_unbuf),
            .TE(gpio_logic1)
    );

    sky130_fd_sc_hd__conb_1 const_source (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .HI(one),
            .LO(zero)
    );

endmodule
`default_nettype wire
