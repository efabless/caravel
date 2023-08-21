/*
 *  SPDX-FileCopyrightText: 2015 Clifford Wolf
 *  PicoSoC - A simple example SoC using PicoRV32
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  Revision 1,  July 2019:  Added signals to drive flash_clk and flash_csb
 *  output enable (inverted), tied to reset so that the flash is completely
 *  isolated from the processor when the processor is in reset.
 *
 *  Also: Made ram_wenb a 4-bit bus so that the memory access can be made
 *  byte-wide for byte-wide instructions.
 *
 *  SPDX-License-Identifier: ISC
 */


`default_nettype none

`ifndef _MGMT_CORE_WRAPPER_
`define _MGMT_CORE_WRAPPER_

/* Wrapper module around management SoC core for pin compatibility	*/
/* with the Caravel harness chip. */	

/* 
    Updated for GF180 Caravel with teh following :
    - Remove the DFFRAM; the wrapper contains only the SoC
    - Remove the SRAM RO Port (HKSPI)
    - Reduced the number of LA probes to 64
*/
module mgmt_core_wrapper #(parameter LA_WIDTH = 64)(
`ifdef USE_POWER_PINS
    inout           VDD,	    /* 5.0V domain */
    inout           VSS,
`endif
    // Clock and reset
    input           core_clk,
    input           core_rstn,

    // GPIO (one pin)
    output          gpio_out_pad,	// Connect to out on gpio pad
    input           gpio_in_pad,		// Connect to in on gpio pad
    output          gpio_mode0_pad,	// Connect to dm[0] on gpio pad
    output          gpio_mode1_pad,	// Connect to dm[2] on gpio pad
    output          gpio_outenb_pad,	// Connect to oe_n on gpio pad
    output          gpio_inenb_pad,	// Connect to inp_dis on gpio pad

    // Logic analyzer signals
    input  [LA_WIDTH-1:0]  la_input,            // From user project to CPU
    output [LA_WIDTH-1:0]  la_output,           // From CPU to user project
    output [LA_WIDTH-1:0]  la_oenb,             // Logic analyzer output enable
    output [LA_WIDTH-1:0]  la_iena,             // Logic analyzer input enable

    // Flash memory control (SPI master)
    output          flash_csb,
    output          flash_clk,

    output          flash_io0_oeb,
    output          flash_io1_oeb,
    output          flash_io2_oeb,
    output          flash_io3_oeb,

    output          flash_io0_do,
    output          flash_io1_do,
    output          flash_io2_do,
    output          flash_io3_do,

    input           flash_io0_di,
    input           flash_io1_di,
    input           flash_io2_di,
    input           flash_io3_di,

    // Exported Wishboned bus
    output	        mprj_wb_iena,	// Enable for the user wishbone return signals
    output 	        mprj_cyc_o,
    output 	        mprj_stb_o,
    output 	        mprj_we_o,
    output [ 3:0]   mprj_sel_o,
    output [31:0]   mprj_adr_o,
    output [31:0]   mprj_dat_o,
    input  	        mprj_ack_i,
    input  [31:0]   mprj_dat_i,

    output 	        hk_cyc_o,
    output 	        hk_stb_o,
    input  [31:0]   hk_dat_i,
    input  	        hk_ack_i,

    // IRQ
    input  [5:0]    irq,		// IRQ from SPI and user project
    output [2:0]    user_irq_ena,	// Enables for user project IRQ

    // Module status
    output          qspi_enabled,
    output          uart_enabled,
    output          spi_enabled,
    output          debug_mode,

    // Module I/O
    output          ser_tx,
    input           ser_rx,
    output          spi_csb,
    output          spi_sck,
    output          spi_sdo,
    output          spi_sdoenb,
    input           spi_sdi,
    input           debug_in,
    output          debug_out,
    output          debug_oeb,
/*
    // SRAM read-only access from housekeeping
    input           sram_ro_clk,
    input           sram_ro_csb,
    input [7:0]     sram_ro_addr,
    output [31:0]   sram_ro_data,
*/
    // Trap state from CPU
    output          trap
);

    // Memory Interface 
    wire mgmt_soc_dff_EN;
    wire [3:0] mgmt_soc_dff_WE;
    wire [7:0] mgmt_soc_dff_A;
    wire [31:0] mgmt_soc_dff_Di;
    wire [31:0] mgmt_soc_dff_Do;

// Signals below are sram_ro ports that left no_connect
// as they are tied down inside mgmt_core

    wire no_connect1 ;
    wire no_connect2 ;
    wire [7:0] no_connect3 ;


    /* Implement the PicoSoC core */

    mgmt_core core (
	`ifdef USE_POWER_PINS
	    .VDD(VDD),	    /* 1.8V domain */
	    .VSS(VSS),
	`endif
    	.core_clk(core_clk),
    	.core_rstn(core_rstn),

    	// Trap state from CPU
    	.trap(trap),

    	// GPIO (one pin)
    	.gpio_out_pad(gpio_out_pad),		// Connect to out on gpio pad
    	.gpio_in_pad(gpio_in_pad),		// Connect to in on gpio pad
    	.gpio_mode0_pad(gpio_mode0_pad),	// Connect to dm[0] on gpio pad
    	.gpio_mode1_pad(gpio_mode1_pad),	// Connect to dm[2] on gpio pad
    	.gpio_outenb_pad(gpio_outenb_pad),	// Connect to oe_n on gpio pad
    	.gpio_inenb_pad(gpio_inenb_pad),	// Connect to inp_dis on gpio pad

        .la_input(la_input),			// From user project to CPU
        .la_output(la_output),			// From CPU to user project
        .la_oenb(la_oenb),			// Logic analyzer output enable
        .la_iena(la_iena),			// Logic analyzer input enable

        // IRQ
        .user_irq(irq),		// IRQ from SPI and user project
	    .user_irq_ena(user_irq_ena),

        // Flash memory control (SPI master)
        .flash_cs_n(flash_csb),
        .flash_clk(flash_clk),

        .flash_io0_oeb(flash_io0_oeb),
        .flash_io1_oeb(flash_io1_oeb),
        .flash_io2_oeb(flash_io2_oeb),
        .flash_io3_oeb(flash_io3_oeb),

        .flash_io0_do(flash_io0_do),
        .flash_io1_do(flash_io1_do),
        .flash_io2_do(flash_io2_do),
        .flash_io3_do(flash_io3_do),

        .flash_io0_di(flash_io0_di),
        .flash_io1_di(flash_io1_di),
        .flash_io2_di(flash_io2_di),
        .flash_io3_di(flash_io3_di),

        // Exported wishbone bus (User project)
	    .mprj_wb_iena(mprj_wb_iena),
        .mprj_ack_i(mprj_ack_i),
        .mprj_dat_i(mprj_dat_i),
        .mprj_cyc_o(mprj_cyc_o),
        .mprj_stb_o(mprj_stb_o),
        .mprj_we_o(mprj_we_o),
        .mprj_sel_o(mprj_sel_o),
        .mprj_adr_o(mprj_adr_o),
        .mprj_dat_o(mprj_dat_o),

        .hk_cyc_o(hk_cyc_o),
        .hk_stb_o(hk_stb_o),
        .hk_dat_i(hk_dat_i),
        .hk_ack_i(hk_ack_i),

    	// Module status
    	.qspi_enabled(qspi_enabled),
    	.uart_enabled(uart_enabled),
    	.spi_enabled(spi_enabled),
    	.debug_mode(debug_mode),

    	// Module I/O
//    	.ser_tx(ser_tx),
//    	.ser_rx(ser_rx),
        .serial_tx(ser_tx),
    	.serial_rx(ser_rx),
    	.spi_cs_n(spi_csb),
    	.spi_clk(spi_sck),
    	.spi_miso(spi_sdi),
    	.spi_sdoenb(spi_sdoenb),
    	.spi_mosi(spi_sdo),
    	.debug_in(debug_in),
    	.debug_out(debug_out),
    	.debug_oeb(debug_oeb)

    );

/*
    // DFFRAM
    DFFRAM DFFRAM_0 (
    `ifdef USE_POWER_PINS
        .VDD(VDD),
        .VSS(VSS),
    `endif
        .CLK(core_clk),
        .WE(mgmt_soc_dff_WE),
        .EN(mgmt_soc_dff_EN),
        .Di(mgmt_soc_dff_Di),
        .Do(mgmt_soc_dff_Do),
        .A(mgmt_soc_dff_A)   // 8-bit address if using the default custom DFF RAM
    );
*/
endmodule
`default_nettype wire

`endif