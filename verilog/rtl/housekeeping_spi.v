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
//-------------------------------------
// SPI controller for Caravel (PicoSoC)
//-------------------------------------
// Written by Tim Edwards
// efabless, inc. September 27, 2020
//-------------------------------------

//-----------------------------------------------------------
// This is a standalone slave SPI for the caravel chip that is
// intended to be independent of the picosoc and independent
// of all IP blocks except the power-on-reset.  This SPI has
// register outputs controlling the functions that critically
// affect operation of the picosoc and so cannot be accessed
// from the picosoc itself.  This includes the PLL enables
// and trim, and the crystal oscillator enable.  It also has
// a general reset for the picosoc, an IRQ input, a bypass for
// the entire crystal oscillator and PLL chain, the
// manufacturer and product IDs and product revision number.
// To be independent of the 1.8V regulator, the slave SPI is
// synthesized with the 3V digital library and runs off of
// the 3V supply.
//
// This module is designed to be decoupled from the chip
// padframe and redirected to the wishbone bus under
// register control from the management SoC, such that the
// contents can be accessed from the management core via the
// SPI master.
//
//-----------------------------------------------------------

//------------------------------------------------------------
// Caravel defined registers:
// Register 0:  SPI status and control (unused & reserved)
// Register 1 and 2:  Manufacturer ID (0x0456) (readonly)
// Register 3:  Product ID (= 16) (readonly)
// Register 4-7: Mask revision (readonly) --- Externally programmed
//	with via programming.  Via programmed with a script to match
//	each customer ID.
//
// Register 8:   PLL enables (2 bits)
// Register 9:   PLL bypass (1 bit)
// Register 10:  IRQ (1 bit)
// Register 11:  reset (1 bit)
// Register 12:  trap (1 bit) (readonly)
// Register 13-16:  PLL trim (26 bits)
// Register 17:	 PLL output divider (3 bits)
// Register 18:	 PLL feedback divider (5 bits)
// Register 19:  User GPIO bit-bang control (5 bits)
// Register 20:  SRAM read-only control (2 bits)
// Register 21:  SRAM read-only address (8 bits)
// Register 22-25:  SRAM read-only data (32 bits)
//------------------------------------------------------------

module housekeeping_spi(
`ifdef USE_POWER_PINS
    vdd, vss, 
`endif
    RSTB, SCK, SDI, CSB, SDO, sdo_enb,
    pll_ena, pll_dco_ena, pll_div, pll_sel,
    pll90_sel, pll_trim, pll_bypass, irq, reset,
    gpio_clock, gpio_resetn, gpio_data_1, gpio_data_2, gpio_enable,
    sram_clk, sram_csb, sram_addr, sram_rdata,
    trap, mask_rev_in,
    pass_thru_mgmt_reset, pass_thru_user_reset,
    pass_thru_mgmt_sck, pass_thru_mgmt_csb,
    pass_thru_mgmt_sdi, pass_thru_mgmt_sdo,
    pass_thru_user_sck, pass_thru_user_csb,
    pass_thru_user_sdi, pass_thru_user_sdo
);

`ifdef USE_POWER_PINS
    inout vdd;	    // 3.3V supply
    inout vss;	    // common ground
`endif
    
    input RSTB;	    // from padframe

    input SCK;	    // from padframe
    input SDI;	    // from padframe
    input CSB;	    // from padframe
    output SDO;	    // to padframe
    output sdo_enb; // to padframe

    output pll_ena;
    output pll_dco_ena;
    output [4:0] pll_div;
    output [2:0] pll_sel;
    output [2:0] pll90_sel;
    output [25:0] pll_trim;
    output pll_bypass;
    output irq;
    output reset;
    input  trap;
    input [31:0] mask_rev_in;	// metal programmed;  3.3V domain

    // Bit-bang control of GPIO serial loader
    output gpio_enable;
    output gpio_resetn;
    output gpio_clock;
    output gpio_data_1;
    output gpio_data_2;

    // Bit-bang control of SRAM block 2nd read port
    output sram_clk;
    output sram_csb;
    output [7:0] sram_addr;
    input [31:0] sram_rdata;

    // Pass-through programming mode for management area SPI flash
    output pass_thru_mgmt_reset;
    output pass_thru_user_reset;
    output pass_thru_mgmt_sck;
    output pass_thru_mgmt_csb;
    output pass_thru_mgmt_sdi;
    input  pass_thru_mgmt_sdo;

    // Pass-through programming mode for user area SPI flash
    output pass_thru_user_sck;
    output pass_thru_user_csb;
    output pass_thru_user_sdi;
    input  pass_thru_user_sdo;

    reg [25:0] pll_trim;
    reg [4:0] pll_div;
    reg [2:0] pll_sel;
    reg [2:0] pll90_sel;
    reg pll_dco_ena;
    reg pll_ena;
    reg pll_bypass;
    reg reset_reg;
    reg irq;
    reg gpio_enable;
    reg gpio_clock;
    reg gpio_resetn;
    reg gpio_data_1;
    reg gpio_data_2;
    reg sram_clk;
    reg sram_csb;
    reg [7:0] sram_addr;

    wire [7:0] odata;
    wire [7:0] idata;
    wire [7:0] iaddr;

    wire trap;
    wire rdstb;
    wire wrstb;
    wire pass_thru_mgmt;		// Mode detected by spi_slave
    wire pass_thru_mgmt_delay;
    wire pass_thru_user;		// Mode detected by spi_slave
    wire pass_thru_user_delay;
    wire loc_sdo;

    // Pass-through mode handling.  Signals may only be applied when the
    // core processor is in reset.

    assign pass_thru_mgmt_csb = ~pass_thru_mgmt_delay;
    assign pass_thru_mgmt_sck = (pass_thru_mgmt ? SCK : 1'b0);
    assign pass_thru_mgmt_sdi = (pass_thru_mgmt_delay ? SDI : 1'b0);

    assign pass_thru_user_csb = ~pass_thru_user_delay;
    assign pass_thru_user_sck = (pass_thru_user ? SCK : 1'b0);
    assign pass_thru_user_sdi = (pass_thru_user_delay ? SDI : 1'b0);

    assign SDO = pass_thru_mgmt ? pass_thru_mgmt_sdo :
		 pass_thru_user ? pass_thru_user_sdo : loc_sdo;
    assign reset = pass_thru_mgmt_reset ? 1'b1 : reset_reg;

    // Instantiate the SPI slave module

    housekeeping_spi_slave U1 (
	.reset(~RSTB),
    	.SCK(SCK),
    	.SDI(SDI),
    	.CSB(CSB),
    	.SDO(loc_sdo),
    	.sdoenb(sdo_enb),
    	.idata(odata),
    	.odata(idata),
    	.oaddr(iaddr),
    	.rdstb(rdstb),
    	.wrstb(wrstb),
    	.pass_thru_mgmt(pass_thru_mgmt),
    	.pass_thru_mgmt_delay(pass_thru_mgmt_delay),
    	.pass_thru_user(pass_thru_user),
    	.pass_thru_user_delay(pass_thru_user_delay),
    	.pass_thru_mgmt_reset(pass_thru_mgmt_reset),
    	.pass_thru_user_reset(pass_thru_user_reset)
    );

    wire [11:0] mfgr_id;
    wire [7:0]  prod_id;
    wire [31:0] mask_rev;

    assign mfgr_id = 12'h456;		// Hard-coded
    assign prod_id = 8'h10;		// Hard-coded
    assign mask_rev = mask_rev_in;	// Copy in to out.

    // Send register contents to odata on SPI read command
    // All values are 1-4 bits and no shadow registers are required.

    assign odata = 
    (iaddr == 8'h00) ? 8'h00 :	// SPI status (fixed)
    (iaddr == 8'h01) ? {4'h0, mfgr_id[11:8]} :	// Manufacturer ID (fixed)
    (iaddr == 8'h02) ? mfgr_id[7:0] :	// Manufacturer ID (fixed)
    (iaddr == 8'h03) ? prod_id :	// Product ID (fixed)
    (iaddr == 8'h04) ? mask_rev[31:24] :	// Mask rev (metal programmed)
    (iaddr == 8'h05) ? mask_rev[23:16] :	// Mask rev (metal programmed)
    (iaddr == 8'h06) ? mask_rev[15:8] :		// Mask rev (metal programmed)
    (iaddr == 8'h07) ? mask_rev[7:0] :		// Mask rev (metal programmed)

    (iaddr == 8'h08) ? {6'b000000, pll_dco_ena, pll_ena} :
    (iaddr == 8'h09) ? {7'b0000000, pll_bypass} :
    (iaddr == 8'h0a) ? {7'b0000000, irq} :
    (iaddr == 8'h0b) ? {7'b0000000, reset} :
    (iaddr == 8'h0c) ? {7'b0000000, trap} :
    (iaddr == 8'h0d) ? pll_trim[7:0] :
    (iaddr == 8'h0e) ? pll_trim[15:8] :
    (iaddr == 8'h0f) ? pll_trim[23:16] :
    (iaddr == 8'h10) ? {6'b000000, pll_trim[25:24]} :
    (iaddr == 8'h11) ? {2'b00, pll90_sel, pll_sel} :
    (iaddr == 8'h12) ? {3'b000, pll_div} :
    (iaddr == 8'h13) ? {3'b000, gpio_data_2, gpio_data_1, gpio_clock,
			gpio_resetn, gpio_enable} :
    (iaddr == 8'h14) ? {6'b000000, sram_clk, sram_csb} :
    (iaddr == 8'h15) ? sram_addr :
    (iaddr == 8'h16) ? sram_rdata[7:0] :
    (iaddr == 8'h17) ? sram_rdata[15:8] :
    (iaddr == 8'h18) ? sram_rdata[23:16] :
    (iaddr == 8'h19) ? sram_rdata[31:24] :
               8'h00;	// Default

    // Register mapping and I/O to slave module

    always @(posedge SCK or negedge RSTB) begin
    if (RSTB == 1'b0) begin
        // Set trim for PLL at (almost) slowest rate (~90MHz).  However,
        // pll_trim[12] must be set to zero for proper startup.
        pll_trim <= 26'b11111111111110111111111111;
        pll_sel <= 3'b010;	// Default output divider divide-by-2
        pll90_sel <= 3'b010;	// Default secondary output divider divide-by-2
        pll_div <= 5'b00100;	// Default feedback divider divide-by-8
        pll_dco_ena <= 1'b1;	// Default free-running PLL
        pll_ena <= 1'b0;	// Default PLL turned off
        pll_bypass <= 1'b1;	// Default bypass mode (don't use PLL)
        irq <= 1'b0;
        reset_reg <= 1'b0;
	gpio_enable <= 1'b0;
	gpio_data_1 <= 1'b0;
	gpio_data_2 <= 1'b0;
	gpio_clock <= 1'b0;
	gpio_resetn <= 1'b0;
	sram_clk <= 1'b0;
	sram_csb <= 1'b1;
	sram_addr <= 8'd0;
    end else if (wrstb == 1'b1) begin
        case (iaddr)
        8'h08: begin
             pll_ena <= idata[0];
             pll_dco_ena <= idata[1];
               end
        8'h09: begin
             pll_bypass <= idata[0];
               end
        8'h0a: begin
             irq <= idata[0];
               end
        8'h0b: begin
             reset_reg <= idata[0];
               end
        // Register 0xc is read-only
        8'h0d: begin
              pll_trim[7:0] <= idata;
               end
        8'h0e: begin
              pll_trim[15:8] <= idata;
               end
        8'h0f: begin
              pll_trim[23:16] <= idata;
               end
        8'h10: begin
              pll_trim[25:24] <= idata[1:0];
               end
        8'h11: begin
             pll_sel <= idata[2:0];
             pll90_sel <= idata[5:3];
               end
        8'h12: begin
             pll_div <= idata[4:0];
               end
        8'h13: begin
	     gpio_enable <= idata[0];
	     gpio_resetn <= idata[1];
	     gpio_clock <= idata[2];
	     gpio_data_1 <= idata[3];
	     gpio_data_2 <= idata[4];
	       end
	8'h14: begin
	     sram_csb <= idata[0];
	     sram_clk <= idata[1];
	       end
	8'h15: begin
	     sram_addr <= idata;
	       end
	// Registers 0x16-0x19 are read-only
        endcase	// (iaddr)
    end
    end
endmodule	// housekeeping_spi

//------------------------------------------------------
// housekeeping_spi_slave.v
//------------------------------------------------------
// General purpose SPI slave module for the Caravel chip
//------------------------------------------------------
// Written by Tim Edwards
// efabless, inc., September 28, 2020
//------------------------------------------------
// This file is distributed free and open source
//------------------------------------------------

// SCK ---   Clock input
// SDI ---   Data  input
// SDO ---   Data  output
// CSB ---   Chip  select (sense negative)
// idata --- Data from chip to transmit out, in 8 bits
// odata --- Input data to chip, in 8 bits
// addr  --- Decoded address to upstream circuits
// rdstb --- Read strobe, tells upstream circuit to supply next byte to idata
// wrstb --- Write strobe, tells upstream circuit to latch odata.

// Data format (general purpose):
// 8 bit format
// 1st byte:   Command word (see below)
// 2nd byte:   Address word (register 0 to 255)
// 3rd byte:   Data word    (value 0 to 255)

// Command format:
// 00000000  No operation
// 10000000  Write until CSB raised
// 01000000  Read  until CSB raised
// 11000000  Simultaneous read/write until CSB raised
// 11000100  Pass-through read/write to management area flash SPI until CSB raised
// 11000010  Pass-through read/write to user area flash SPI until CSB raised
// wrnnn000  Read/write as above, for nnn = 1 to 7 bytes, then terminate

// Lower three bits are reserved for future use.
// All serial bytes are read and written msb first.

// Fixed control and status registers

// Address 0 is reserved and contains flags for SPI mode.  This is
// currently undefined and is always value 0.
// Address 1 is reserved and contains manufacturer ID low 8 bits.
// Address 2 is reserved and contains manufacturer ID high 4 bits.
// Address 3 is reserved and contains product ID (8 bits).
// Addresses 4 to 7 are reserved and contain the mask ID (32 bits).
// Addresses 8 to 255 are available for general purpose use.

`define COMMAND  3'b000
`define ADDRESS  3'b001
`define DATA     3'b010
`define USERPASS 3'b100
`define MGMTPASS 3'b101

module housekeeping_spi_slave(reset, SCK, SDI, CSB, SDO,
	sdoenb, idata, odata, oaddr, rdstb, wrstb,
	pass_thru_mgmt, pass_thru_mgmt_delay,
	pass_thru_user, pass_thru_user_delay,
	pass_thru_mgmt_reset, pass_thru_user_reset);

    input reset;
    input SCK;
    input SDI;
    input CSB;
    output SDO;
    output sdoenb;
    input [7:0] idata;
    output [7:0] odata;
    output [7:0] oaddr;
    output rdstb;
    output wrstb; 
    output pass_thru_mgmt;
    output pass_thru_mgmt_delay;
    output pass_thru_user;
    output pass_thru_user_delay;
    output pass_thru_mgmt_reset;
    output pass_thru_user_reset;

    reg  [7:0]  addr;
    reg		wrstb;
    reg		rdstb;
    reg		sdoenb;
    reg  [2:0]  state;
    reg  [2:0]  count;
    reg		writemode;
    reg		readmode;
    reg  [2:0]	fixed;
    wire [7:0]  odata;
    reg  [6:0]  predata;
    wire [7:0]  oaddr;
    reg  [7:0]  ldata;
    reg		pass_thru_mgmt;
    reg		pass_thru_mgmt_delay;
    reg		pre_pass_thru_mgmt;
    reg		pass_thru_user;
    reg		pass_thru_user_delay;
    reg		pre_pass_thru_user;
    wire	csb_reset;

    assign odata = {predata, SDI};
    assign oaddr = (state == `ADDRESS) ? {addr[6:0], SDI} : addr;
    assign SDO = ldata[7];
    assign csb_reset = CSB | reset;
    assign pass_thru_mgmt_reset = pass_thru_mgmt_delay | pre_pass_thru_mgmt;
    assign pass_thru_user_reset = pass_thru_user_delay | pre_pass_thru_user;

    // Readback data is captured on the falling edge of SCK so that
    // it is guaranteed valid at the next rising edge.
    always @(negedge SCK or posedge csb_reset) begin
        if (csb_reset == 1'b1) begin
            wrstb <= 1'b0;
            ldata  <= 8'b00000000;
            sdoenb <= 1'b1;
        end else begin

            // After CSB low, 1st SCK starts command

            if (state == `DATA) begin
            	if (readmode == 1'b1) begin
                    sdoenb <= 1'b0;
                    if (count == 3'b000) begin
                	ldata <= idata;
                    end else begin
                	ldata <= {ldata[6:0], 1'b0};	// Shift out
                    end
                end else begin
                    sdoenb <= 1'b1;
                end

                // Apply write strobe on SCK negative edge on the next-to-last
                // data bit so that it updates data on the rising edge of SCK
                // on the last data bit.
 
                if (count == 3'b111) begin
                    if (writemode == 1'b1) begin
                        wrstb <= 1'b1;
                    end
                end else begin
                    wrstb <= 1'b0;
                end
	    end else if (state == `MGMTPASS || state == `USERPASS) begin
		wrstb <= 1'b0;
		sdoenb <= 1'b0;
            end else begin
                wrstb <= 1'b0;
                sdoenb <= 1'b1;
            end		// ! state `DATA
        end		// ! csb_reset
    end			// always @ ~SCK

    always @(posedge SCK or posedge csb_reset) begin
        if (csb_reset == 1'b1) begin
            // Default state on reset
            addr <= 8'h00;
            rdstb <= 1'b0;
            predata <= 7'b0000000;
            state  <= `COMMAND;
            count  <= 3'b000;
            readmode <= 1'b0;
            writemode <= 1'b0;
            fixed <= 3'b000;
	    pass_thru_mgmt <= 1'b0;
	    pass_thru_mgmt_delay <= 1'b0;
	    pre_pass_thru_mgmt <= 1'b0;
	    pass_thru_user = 1'b0;
	    pass_thru_user_delay <= 1'b0;
	    pre_pass_thru_user <= 1'b0;
        end else begin
            // After csb_reset low, 1st SCK starts command
            if (state == `COMMAND) begin
                rdstb <= 1'b0;
                count <= count + 1;
        	if (count == 3'b000) begin
	            writemode <= SDI;
	        end else if (count == 3'b001) begin
	            readmode <= SDI;
	        end else if (count < 3'b101) begin
	            fixed <= {fixed[1:0], SDI}; 
	        end else if (count == 3'b101) begin
		    pre_pass_thru_mgmt <= SDI;
	        end else if (count == 3'b110) begin
		    pre_pass_thru_user <= SDI;
		    pass_thru_mgmt_delay <= pre_pass_thru_mgmt;
	        end else if (count == 3'b111) begin
		    pass_thru_user_delay <= pre_pass_thru_user;
		    if (pre_pass_thru_mgmt == 1'b1) begin
			state <= `MGMTPASS;
			pre_pass_thru_mgmt <= 1'b0;
		    end else if (pre_pass_thru_user == 1'b1) begin
			state <= `USERPASS;
			pre_pass_thru_user <= 1'b0;
		    end else begin
	                state <= `ADDRESS;
		    end
	        end
            end else if (state == `ADDRESS) begin
	        count <= count + 1;
	        addr <= {addr[6:0], SDI};
	        if (count == 3'b111) begin
	            if (readmode == 1'b1) begin
	            	rdstb <= 1'b1;
	            end
	            state <= `DATA;
	        end else begin
	            rdstb <= 1'b0;
	        end
            end else if (state == `DATA) begin
	        predata <= {predata[6:0], SDI};
	        count <= count + 1;
	        if (count == 3'b111) begin
	            if (fixed == 3'b001) begin
	                state <= `COMMAND;
	            end else if (fixed != 3'b000) begin
	                fixed <= fixed - 1;
	                addr <= addr + 1;	// Auto increment address (fixed)
	            end else begin	
	                addr <= addr + 1;	// Auto increment address (streaming)
	            end
	        end else begin
	            rdstb <= 1'b0;
	        end
	    end else if (state == `MGMTPASS) begin
		pass_thru_mgmt <= 1'b1;
	    end else if (state == `USERPASS) begin
		pass_thru_user <= 1'b1;
            end		// ! state `DATA | `MGMTPASS | `USERPASS
        end		// ! csb_reset 
    end			// always @ SCK

endmodule // housekeeping_spi_slave
`default_nettype wire
