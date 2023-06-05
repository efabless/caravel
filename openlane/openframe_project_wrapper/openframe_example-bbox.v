module openframe_example (
    `ifdef USE_POWER_PINS
    inout vdda,		// User area 0 3.3V supply
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa,		// User area 0 analog ground
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd,		// Common 1.8V supply
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd,		// Common digital ground
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
    `endif
    input  porb,		/* Power-on-reset (inverted)	 */
    input  por,			/* Power-on-reset (non-inverted) */
    input  resetb,		/* Master (pin) reset (inverted) */
    input  [31:0] mask_rev,	/* Mask revision (via programmed ROM) */
    input  [`OPENFRAME_IO_PADS-1:0] gpio_in,	/* Input from GPIO */
    output [`OPENFRAME_IO_PADS-1:0] gpio_out,	/* Output to GPIO */
    output [`OPENFRAME_IO_PADS-1:0] gpio_oeb,	/* GPIO output enable (inverted) */
    output [`OPENFRAME_IO_PADS-1:0] gpio_ieb,	/* GPIO input enable (inverted) */
    output [`OPENFRAME_IO_PADS-1:0] gpio_ib_mode_sel,	/* GPIO mode */
    output [`OPENFRAME_IO_PADS-1:0] gpio_vtrip_sel,	/* GPIO threshold */
    output [`OPENFRAME_IO_PADS-1:0] gpio_slow_sel,	/* GPIO slew rate */
    output [`OPENFRAME_IO_PADS-1:0] gpio_dm2,		/* GPIO digital mode */
    output [`OPENFRAME_IO_PADS-1:0] gpio_dm1,		/* GPIO digital mode */
    output [`OPENFRAME_IO_PADS-1:0] gpio_dm0,		/* GPIO digital mode */
    input  [`OPENFRAME_IO_PADS-1:0] gpio_loopback_one,	/* Value 1 for loopback */
    input  [`OPENFRAME_IO_PADS-1:0] gpio_loopback_zero,
    inout  [`OPENFRAME_IO_PADS-1:0] analog_io,
    inout  [`OPENFRAME_IO_PADS-1:0] analog_noesd_io,
    output [`OPENFRAME_IO_PADS-1:0] gpio_analog_en,
    output [`OPENFRAME_IO_PADS-1:0] gpio_analog_sel,
    output [`OPENFRAME_IO_PADS-1:0] gpio_analog_pol,
    output [`OPENFRAME_IO_PADS-1:0] gpio_holdover,
    output [`OPENFRAME_IO_PADS-1:0] gpio_inp_dis,
    input  [`OPENFRAME_IO_PADS-1:0] gpio_in_h,
    input	 resetb_l,	// master reset, sense inverted, 1.8V domain
    input	 resetb_h,	// master reset, sense inverted, 3.3V domain
    input	 porb_h,	// power-on reset, sense inverted, 3.3V domain
    input	 porb_l,	// power-on reset, sense inverted, 1.8V domain
    input	 por_l
);
endmodule
