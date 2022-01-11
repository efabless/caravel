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
 * openframe_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the openframe project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module openframe_project_wrapper (
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

    // User maskable interrupt signals
    output [2:0] irq_spi,

    // Exported Wishbone Bus
    output hk_clk_o,
    output hk_rst_o,
    output hk_stb_o,
    input hk_we_o,
    output [3:0] hk_sel_i,
    output [31:0] hk_dat_i,
    output [31:0] hk_adr_i,
    input hk_ack_o,
    input [31:0] hk_dat_o,

    // GPIO (1 pin)
    input  gpio_in_pad,
    output gpio_out_pad,
    output gpio_mode0_pad,
    output gpio_mode1_pad,
    output gpio_outenb_pad,
    output gpio_inenb_pad,

    // GPIO pad 3-pin interface
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

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

    // Module status (these may or may not be implemented)
    output qspi_enabled,
    output uart_enabled,
    output spi_enabled,
    output debug_mode,

    // Module I/O (these may or may not be implemented)
    output ser_tx,
    input  ser_rx
    // SPI master
    input spi_sdi,
    output spi_csb,
    output spi_sck,
    output spi_sdo,
    output spi_sdoenb,
    // Debug
    input debug_in,
    output debug_out,
    output debug_oeb,

    // SRAM Read-only access to housekeeping
    input sram_ro_clk,
    input sram_ro_csb,
    input [7:0] sram_ro_addr,
    output [31:0] sram_ro_data,

    // Trap status
    output trap
);

// Dummy assignments so that we can take it through the openlane flow
`ifdef SIM
// Needed for running GL simulation
assign io_out = 0;
assign io_oeb = 0;
`else
assign io_out = io_in;
`endif

endmodule	// openframe_project_wrapper
