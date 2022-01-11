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
 *-------------------------------------------------------------
 *
 * openframe_analog_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the openframe analog project.
 *
 *-------------------------------------------------------------
 */

module openframe_analog_project_wrapper (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Clocks and reset
    input core_clk,
    input core_rstn,
    input core_clock2,

    // GPIO (1-pin)
    output gpio_out_pad,
    input  gpio_in_pad,
    output gpio_mode0_pad,
    output gpio_mode1_pad,
    output gpio_outenb_pad,
    output gpio_inenb_pad,

    /* GPIOs.  There are 27 GPIOs, on either side of the analog.
     * These have the following mapping to the GPIO padframe pins
     * and memory-mapped registers, since the numbering remains the
     * same as caravel but skips over the analog I/O:
     *
     * io_in/out/oeb/in_3v3 [26:14]  <--->  mprj_io[37:25]
     * io_in/out/oeb/in_3v3 [13:0]   <--->  mprj_io[13:0]	
     *
     * When the GPIOs are configured by the Management SoC for
     * user use, they have three basic bidirectional controls:
     * in, out, and oeb (output enable, sense inverted).  For
     * analog projects, a 3.3V copy of the signal input is
     * available.  out and oeb must be 1.8V signals.
     */

    input  [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] io_in,
    input  [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] io_in_3v3,
    output [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-`ANALOG_PADS-1:0] io_oeb,

    /* Analog (direct connection to GPIO pad---not for high voltage or
     * high frequency use).  The management SoC must turn off both
     * input and output buffers on these GPIOs to allow analog access.
     * These signals may drive a voltage up to the value of VDDIO
     * (3.3V typical, 5.5V maximum).
     * 
     * Note that analog I/O is not available on the 7 lowest-numbered
     * GPIO pads, and so the analog_io indexing is offset from the
     * GPIO indexing by 7, as follows:
     *
     * gpio_analog/noesd [17:7]  <--->  mprj_io[35:25]
     * gpio_analog/noesd [6:0]   <--->  mprj_io[13:7]	
     *
     */
    
    inout [`MPRJ_IO_PADS-`ANALOG_PADS-10:0] gpio_analog,
    inout [`MPRJ_IO_PADS-`ANALOG_PADS-10:0] gpio_noesd,

    /* Analog signals, direct through to pad.  These have no ESD at all,
     * so ESD protection is the responsibility of the designer.
     *
     * user_analog[10:0]  <--->  mprj_io[24:14]
     *
     */
    inout [`ANALOG_PADS-1:0] io_analog,

    /* Additional power supply ESD clamps, one per analog pad.  The
     * high side should be connected to a 3.3-5.5V power supply.
     * The low side should be connected to ground.
     *
     * clamp_high[2:0]   <--->  mprj_io[20:18]
     * clamp_low[2:0]    <--->  mprj_io[20:18]
     *
     */
    inout [2:0] io_clamp_high,
    inout [2:0] io_clamp_low,

    // Primary SPI flash controller
    output flash_csb,
    output flash_clk,
    output flash_io0_oeb,
    input  flash_io0_di,
    output flash_io0_do,
    output flash_io1_oeb,
    input  flash_io1_di,
    output flash_io1_do,
    output flash_io2_oeb,
    input  flash_io2_di,
    output flash_io2_do,
    output flash_io3_oeb,
    input  flash_io3_di,
    output flash_io3_do,

    // Exported Wishbone Bus
    output hk_clk_o,
    output hk_rst_o,
    output  hk_stb_o,
    output  hk_cyc_o,
    output  hk_we_o,
    output [3:0] hk_sel_o,
    output [31:0] hk_dat_o,
    output [31:0] hk_adr_o,
    input  hk_ack_i,
    input  [31:0] hk_dat_i,

    // IRQ
    input [2:0] irq_spi,

    // Module I/O (these may or may not be implemented)
    // UART
    output ser_tx,
    input  ser_rx,
    // SPI master
    input  spi_sdi,
    output spi_csb,
    output spi_sck,
    output spi_sdo,
    output spi_sdoenb,
    // Debug
    input  debug_in,
    output debug_out,
    output debug_oeb,

    // SRAM read-only access from housekeeping
    input sram_ro_clk,
    input sram_ro_csb,
    input [7:0] sram_ro_addr,
    output[31:0] sram_ro_data,

    // Trap status
    output trap
);

// Dummy assignment so that we can take it through the openlane flow
assign io_out = io_in;

endmodule	// user_analog_project_wrapper
