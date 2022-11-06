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
 * user_project_la_example
 *
 * This is a user project for testing the address space only 
 *
 *-------------------------------------------------------------
 */

module user_project_addr_space_example (
    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg[31:0] wbs_dat_o

);
    // extend project for testing the user project address space 
    reg [31:0] addr; 
    reg [31:0] data; 
    always @(posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            addr <=0;
            data <=0;
            wbs_dat_o <=0;
            wbs_ack_o <=0;
        end else if (wbs_cyc_i && wbs_stb_i && wbs_we_i && !wbs_ack_o) begin 
            addr <= wbs_adr_i;
            data <= wbs_dat_i;
            wbs_ack_o <= 1;
        end else if (wbs_cyc_i && wbs_stb_i && !wbs_we_i && !wbs_ack_o) begin // read 
            addr <= wbs_adr_i;
            data <= 32'h777; // arbitrary number
            wbs_ack_o <= 1;
        end else begin 
            wbs_ack_o <= 0;
        end
    end
endmodule

`default_nettype wire
