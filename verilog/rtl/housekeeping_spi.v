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
​
//`default_nettype none
​
//-----------------------------------------------------------
// SPI controller for Caravel
//-----------------------------------------------------------
// housekeeping_spi.v
//------------------------------------------------------
// General purpose SPI module for the Caravel chip
//------------------------------------------------------
// Written by Tim Edwards
// efabless, inc., September 28, 2020
//------------------------------------------------
// This file is distributed free and open source
//------------------------------------------------
​
// SCK ---   Clock input
// SDI ---   Data  input
// SDO ---   Data  output
// CSB ---   Chip  select (sense negative)
// idata --- Data from chip to transmit out, in 8 bits
// odata --- Input data to chip, in 8 bits
// addr  --- Decoded address to upstream circuits
// rdstb --- Read strobe, tells upstream circuit that data will be latched.
// wrstb --- Write strobe, tells upstream circuit to latch odata.
​
// Data format (general purpose):
// 8 bit format
// 1st byte:   Command word (see below)
// 2nd byte:   Address word (register 0 to 255)
// 3rd byte:   Data word    (value 0 to 255)
​
// Command format:
// 00000000  No operation
// 10000000  Write until CSB raised
// 01000000  Read  until CSB raised
// 11000000  Simultaneous read/write until CSB raised
// 11000100  Pass-through read/write to management area flash SPI until CSB raised
// 11000010  Pass-through read/write to user area flash SPI until CSB raised
// wrnnn000  Read/write as above, for nnn = 1 to 7 bytes, then terminate
​
// Lower three bits are reserved for future use.
// All serial bytes are read and written msb first.
​
// Fixed control and status registers
​
// Address 0 is reserved and contains flags for SPI mode.  This is
// currently undefined and is always value 0.
// Address 1 is reserved and contains manufacturer ID low 8 bits.
// Address 2 is reserved and contains manufacturer ID high 4 bits.
// Address 3 is reserved and contains product ID (8 bits).
// Addresses 4 to 7 are reserved and contain the mask ID (32 bits).
// Addresses 8 to 255 are available for general purpose use.
​
`define COMMAND  3'b000
`define ADDRESS  3'b001
`define DATA     3'b010
`define USERPASS 3'b100
`define MGMTPASS 3'b101
​
module housekeeping_spi(reset, SCK, SDI, CSB, SDO,
	sdoenb, idata, odata, oaddr, rdstb, wrstb,
	pass_thru_mgmt, pass_thru_mgmt_delay,
	pass_thru_user, pass_thru_user_delay,
	pass_thru_mgmt_reset, pass_thru_user_reset);
​
    input reset;
    input SCK;
    input SDI;
    input CSB;
    output wire SDO;
    output reg sdoenb;
    input [7:0] idata;
    output wire [7:0] odata;
    output wire [7:0] oaddr;
    output reg rdstb;
    output reg wrstb; 
    output reg pass_thru_mgmt;
    output reg pass_thru_mgmt_delay;
    output reg pass_thru_user;
    output reg pass_thru_user_delay;
    output wire pass_thru_mgmt_reset;
    output wire pass_thru_user_reset;
​
    wire hk_spi_csb;
    wire hk_spi_sck;
    wire hk_spi_sdi;
    wire rst;
​
    reg  [7:0]  addr;
    reg  [2:0]  state;
    reg  [2:0]  count;
    reg		writemode;
    reg		readmode;
    reg  [2:0]	fixed;
    reg  [6:0]  predata;
    reg  [7:0]  ldata;   
    reg		pre_pass_thru_mgmt;
    reg		pre_pass_thru_user;
​
    assign hk_spi_csb = CSB;
    assign hk_spi_sck = SCK;
    assign hk_spi_sdi = SDI;
    assign rst = reset;
​
    assign  odata = {predata, SDI};
    assign  oaddr = (state == `ADDRESS) ? {addr[6:0], SDI} : addr;
    assign SDO = ldata[7];
    assign csb_reset = CSB | reset;
    assign pass_thru_mgmt_reset = pass_thru_mgmt_delay | pre_pass_thru_mgmt;
    assign pass_thru_user_reset = pass_thru_user_delay | pre_pass_thru_user;
​
​
    reg [2:0] nstate;
    reg [2:0] byte_cnt;
    reg cmd_rd, cmd_wr, cmd_pt, cmd_pt_usr;
    reg [2:0] cmd_bytes;
    always @(count) begin
        case(state)  
            `COMMAND : begin
                if(count == 3'd7) begin
                    case({pre_pass_thru_mgmt,pre_pass_thru_user})
                        2'b00 :     nstate = `ADDRESS;
                        2'b10 :     nstate = `MGMTPASS;
                        2'b01 :     nstate = `USERPASS;
                        default:    nstate = `ADDRESS;
                    endcase
                end 
                else begin
                    nstate = `COMMAND;
                end 
            end 
            `ADDRESS : begin
                if(count == 3'd7)
                    nstate = `DATA;
                else 
                    nstate = `ADDRESS;
            end 
            `DATA : begin
                if(count == 3'd7)
                    if(byte_cnt == 3'd1)            ////////
                        nstate = `COMMAND;
                else
                    nstate = `DATA;
            end 
            `MGMTPASS : begin 
                nstate = `MGMTPASS;
            end 
            `USERPASS : begin 
                nstate = `USERPASS;
            end 
            default : begin
                nstate = `DATA;
            end 
        endcase
    end 
​
    
    always @(posedge SCK or posedge csb_reset) begin
        if (csb_reset == 1'b1) begin
            state  <= `COMMAND;
            nstate <= 3'b000;           //        
        end                
        else 
            state <= nstate;
    end
​
​
    /*always @(posedge csb_reset)begin
        if (csb_reset == 1'b1) begin
            count  <= 3'b000;  
        end   
    end */
​
    //wire [2:0] next_count = count +1;
    // incrementing bits counter at every positive edge of SCK 
    always @(posedge SCK or posedge csb_reset)    begin           //
        if (csb_reset == 1'b1) begin
            count  <= 3'b000;  
        end 
        else if (state != `USERPASS && state != `MGMTPASS) begin
            count <= count + 1;    
        end                 
    end 
    
    // Getting command from SDI and storing it in a register 
    always @(posedge SCK or posedge csb_reset) begin
        if (csb_reset == 1'b1) begin 
            cmd_wr <= 0;
            cmd_rd <= 0;
            cmd_bytes <= 0;
            pre_pass_thru_mgmt <= 0; 
            pre_pass_thru_user <= 0;  
            pass_thru_mgmt_delay <= 0; 
            pass_thru_user_delay <= 0;
        end    
        else begin 
            if(state == `COMMAND) begin 
                case (count)  
                    0: cmd_wr <= SDI;
                    1: cmd_rd <= SDI;
                    2: cmd_bytes[2] <= SDI;
                    3: cmd_bytes[1] <= SDI;
                    4: cmd_bytes[0] <= SDI;
                    5: pre_pass_thru_mgmt <= SDI; 
                    6: begin pre_pass_thru_user <= SDI;  pass_thru_mgmt_delay <= pre_pass_thru_mgmt; end
                    7: pass_thru_user_delay <= pre_pass_thru_user;
                    default: cmd_wr <= SDI;
                endcase
            end 
        end 
    end 
​
    // Getting address from SDI and storing it in a register and incrementing it. 
    always @(posedge SCK or posedge csb_reset) begin 
        if (csb_reset == 1'b1)
            addr <= 8'h00;              //
        else begin
            if(state == `ADDRESS) 
                addr <= {addr[6:0], SDI};
            else 
            if(state == `DATA)
                if(count == 3'd7)
                    addr <= addr + 1'd1;
        end 
    end 
       
    // Getting data to write from SDI and storing it in a register 
    always @(posedge SCK or posedge csb_reset) begin 
        if (csb_reset == 1'b1)
            predata <= 7'b0000000;      //
        else 
        if(state == `DATA) predata <= {predata[6:0], SDI};
    end 
​
    // Getting bytes count from SDI and decremnting it. 
    always @(posedge SCK or posedge csb_reset) begin 
        if (csb_reset == 1'b1)
            byte_cnt <= 3'b0;
        else begin           
            if(nstate == `ADDRESS)
                byte_cnt <= cmd_bytes;
            else 
            if(state == `DATA) begin 
                if(count == 3'd7)
                    if(byte_cnt != 0)    ////
                        byte_cnt <= byte_cnt - 1'b1;
            end
        end 
    end 
​
    
    // Storing read data from hk in a reg and shifting it out on SDO 
    always @(negedge SCK or posedge csb_reset) begin ////
        if (csb_reset == 1'b1)
            ldata  <= 8'b00000000;
        else begin 
            if(state == `DATA)
                if(cmd_rd == 1'b1) 
                    if(count == 3'd0)
                        ldata <= idata;
                if(count != 3'd0)
                    ldata <= {ldata[6:0], 1'b0};	// Shift out
        end                             
    end 
   
​
    // read strobe 
    always @(posedge SCK or posedge csb_reset) begin  ////
        if (csb_reset == 1'b1) 
            rdstb <= 1'b0;
        else begin 
            if(state == `ADDRESS || state == `DATA)  
                if(cmd_rd == 1'b1)
                    rdstb <= 1'b1;
                else
                    rdstb <= 1'b0; 
        end 
    end 
​
    // write strobe 
    always @(negedge SCK or posedge csb_reset) begin ////
        
        if (csb_reset == 1'b1 )begin
             wrstb <= 1'b0;
        end else begin
            if(state == `DATA) begin 
                if(count == 3'd7) begin 
                    if(cmd_wr)
                        wrstb <= 1'b1;
                    else 
                        wrstb <= 1'b0; 
                end 
                else 
                wrstb <= 1'b0;  
​
            end else begin
                wrstb <= 1'b0;  
            end
        end
    end    
    
    // sdo enable 
    always @(negedge SCK or posedge csb_reset) begin ////
        if (csb_reset == 1'b1)
            sdoenb <= 1'b1;
        else 
            if(state == `MGMTPASS || state == `USERPASS) begin
                sdoenb <= 1'b0;
                end
            else if(state == `DATA) begin 
                if(cmd_rd == 1'b1) 
                    sdoenb <= 1'b0;            
                else 
                    sdoenb <= 1'b1;
            end  
            else begin
                sdoenb <= 1'b1;
                end 
    end 
​
    always @(posedge SCK or posedge csb_reset) begin 
        if(csb_reset == 1'b1) begin 
            pass_thru_mgmt <= 1'b0;
            pass_thru_mgmt_delay <= 1'b0;
            pre_pass_thru_mgmt <= 1'b0;
        end 
        else 
            if(state == `MGMTPASS)
                pass_thru_mgmt = 1'b1;
    end 
​
    always @(posedge SCK or posedge csb_reset) begin 
        if (csb_reset == 1'b1) begin 
            pass_thru_user <= 1'b0;
            pass_thru_user_delay <= 1'b0;
            pre_pass_thru_user <= 1'b0;
        end 
        else 
            if(state == `USERPASS)
                pass_thru_user = 1;
    end     
​
    /*always @(posedge SCK) begin  ////
        if (state ==`ADDRESS)
            oaddr<= {addr[6:0], SDI};
        else 
            oaddr = addr;
    end */
​
endmodule // housekeeping_spi
`default_nettype wire
