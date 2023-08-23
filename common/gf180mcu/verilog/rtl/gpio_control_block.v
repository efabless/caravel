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
 *-------------------------------------------gpio_load_2--------------------------
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
    parameter PAD_CTRL_BITS = 10
) (
    `ifdef USE_POWER_PINS
         inout VDD,
         inout VSS,
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
    output	 user_gpio_in,		// Pad to user space
    input        user_gpio_out,		// User space to pad
    input        user_gpio_oeb,		// Output enable (user)

    // Pad-facing signals (Pad GPIOv2)
    output       pad_gpio_inen,
    output       pad_gpio_outen,
    output	 pad_gpio_out,
    input	 pad_gpio_in,
    output	 pad_gpio_slew_sel,
    output	 pad_gpio_schmitt_sel,
    output [1:0] pad_gpio_drive_sel,
    output	 pad_gpio_pullup_sel,
    output	 pad_gpio_pulldown_sel,

    // to provide a way to automatically disable/enable output
    // from the outside with needing a tiehi or tielo cell
    output	 one,
    output	 zero
);

    /* Parameters defining the bit offset of each function in the chain */

    localparam MGMT_EN = 0;	/* Management/user control of GPIO */
    localparam OE_OVR = 1;	/* Output enable override */
    localparam IE = 2;		/* Input enable (sense positive) */
    localparam OE = 3;		/* Manual output enable (sense positive) */
    localparam SCHMITT = 4;	/* CMOS/Schmitt trigger select */
    localparam SLEW = 5;	/* Slew rate select */
    localparam PD = 6;		/* Pull-down select */
    localparam PU = 7;		/* Pull-up select */
    localparam DRIVE = 8;	/* Drive strength select */

    /* Internally registered signals */
    reg	 	mgmt_ena;		// Enable management SoC to access pad
    reg		gpio_oe_override;
    reg		gpio_inen;
    reg		gpio_outen;
    reg		gpio_out;
    reg		gpio_slew_sel;
    reg		gpio_schmitt_sel;
    reg [1:0]	gpio_drive_sel;
    reg		gpio_pullup_sel;
    reg		gpio_pulldown_sel;

    /* Derived output values */
    wire	pad_gpio_slew_sel;
    wire      	pad_gpio_inen;
    wire        pad_gpio_outen;
    wire	pad_gpio_out;
    wire	pad_gpio_in;
    wire [1:0]  pad_gpio_drive_sel;
    wire	pad_gpio_schmitt_sel;
    wire	pad_gpio_pullup_sel;
    wire	pad_gpio_pulldown_sel;
    wire	one;
    wire	zero;

    wire user_gpio_in;
    reg  serial_data_out;

    /* Serial shift for the above (latched) values */
    reg [PAD_CTRL_BITS-1:0] shift_register;

    /* Latch the output on the clock negative edge */
    always @(negedge serial_clock or negedge resetn) begin
	if (resetn == 1'b0) begin
	    /* Clear the shift register output */
	    serial_data_out <= 1'b0;
	end else begin
	    serial_data_out <= shift_register[PAD_CTRL_BITS-1];
	end
    end

    /* Propagate the clock and reset signals so that they aren't wired	*/
    /* all over the chip, but are just wired between the blocks.	*/
    // assign serial_clock_out = serial_clock;
    // assign resetn_out = resetn;
    // assign serial_load_out = serial_load;
    (* keep *) gf180mcu_fd_sc_mcu7t5v0__clkbuf_8 BUF[2:0] (
		`ifdef USE_POWER_PINS
			.VDD(VDD),
			.VSS(VSS),
		`endif
		.I({serial_clock, resetn, serial_load}), 
		.Z({serial_clock_out, resetn_out, serial_load_out})); 



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
            mgmt_ena 	      <= gpio_defaults[MGMT_EN];
	    gpio_oe_override  <= gpio_defaults[OE_OVR];
	    gpio_inen 	      <= gpio_defaults[IE];
	    gpio_outen        <= gpio_defaults[OE];
	    gpio_slew_sel     <= gpio_defaults[SLEW];
	    gpio_schmitt_sel  <= gpio_defaults[SCHMITT];
	    gpio_pullup_sel   <= gpio_defaults[PU];
	    gpio_pulldown_sel <= gpio_defaults[PD];
	    gpio_drive_sel    <= gpio_defaults[DRIVE+1:DRIVE];
	end else begin
	    /* Load data */
	    mgmt_ena 	      <= shift_register[MGMT_EN];
	    gpio_oe_override  <= shift_register[OE_OVR];
	    gpio_inen 	      <= shift_register[IE];
	    gpio_outen        <= shift_register[OE];
	    gpio_slew_sel     <= shift_register[SLEW];
	    gpio_schmitt_sel  <= shift_register[SCHMITT];
	    gpio_pullup_sel   <= shift_register[PU];
	    gpio_pulldown_sel <= shift_register[PD];
	    gpio_drive_sel    <= shift_register[DRIVE+1:DRIVE];
	end
    end

    /* These pad configuration signals are static and do not change	*/
    /* after setup.							*/

    assign pad_gpio_inen            =   gpio_inen;
    assign pad_gpio_slew_sel        =   gpio_slew_sel;
    assign pad_gpio_schmitt_sel     =   gpio_schmitt_sel;
    assign pad_gpio_drive_sel       =   gpio_drive_sel;
    assign pad_gpio_pullup_sel      =   gpio_pullup_sel;
    assign pad_gpio_pulldown_sel    =   gpio_pulldown_sel;

    /* Implement pad control behavior depending on state of mgmt_ena */

    assign user_gpio_in = pad_gpio_in;
    assign mgmt_gpio_in = pad_gpio_in;

    /* OE override signal takes precedence over the state of output enable
     * at the GPIO pad.  Otherwise, the OE signal comes directly from the
     * management SoC or the user project depending on the state of
     * the management enable signal.
     */
    assign pad_gpio_outen = (gpio_oe_override) ? gpio_outen :
			((mgmt_ena) ? ~mgmt_gpio_oeb  : ~user_gpio_oeb);

    assign pad_gpio_out = (mgmt_ena) ? mgmt_gpio_out : user_gpio_out;

    gf180mcu_fd_sc_mcu7t5v0__tieh const_source_one (
`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
`endif
            .Z(one)
    );

    gf180mcu_fd_sc_mcu7t5v0__tiel const_source_zero (
`ifdef USE_POWER_PINS
            .VDD(VDD),
            .VSS(VSS),
`endif
            .ZN(zero)
    );

endmodule
`default_nettype wire
