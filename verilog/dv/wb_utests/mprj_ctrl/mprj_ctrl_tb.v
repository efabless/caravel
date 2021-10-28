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


`timescale 1 ns / 1 ps

`include "defines.v"
`include "housekeeping_spi.v"
`include "housekeeping.v"

module mprj_ctrl_tb;

    reg wb_clk_i;
	reg wb_rst_i;

    reg wb_stb_i;
    reg wb_cyc_i;
	reg wb_we_i;
	reg [3:0] wb_sel_i;
	reg [31:0] wb_dat_i;
	reg [31:0] wb_adr_i;

	wire wb_ack_o;
	wire [31:0] wb_dat_o;

    initial begin
        wb_clk_i = 0; 
        wb_rst_i = 0;
        wb_stb_i = 0; 
        wb_cyc_i = 0;  
        wb_sel_i = 0;  
        wb_we_i  = 0;  
        wb_dat_i = 0; 
        wb_adr_i = 0; 
    end

    always #1 wb_clk_i = ~wb_clk_i;

    // Mega Project Control Registers 
    wire [31:0] mprj_ctrl = uut.GPIO_BASE_ADR | 8'h6a;
    wire [31:0] pwr_ctrl  = uut.GPIO_BASE_ADR | 8'h6e;

    initial begin
        $dumpfile("mprj_ctrl_tb.vcd");
        $dumpvars(0, mprj_ctrl_tb);
        repeat (50) begin
            repeat (1000) @(posedge wb_clk_i);
        end
        $display("%c[1;31m",27);
        $display ("Monitor: Timeout, Test Mega-Project Control Failed");
        $display("%c[0m",27);
        $finish;
    end

    integer i;

    reg [31:0] data;

    initial begin   
        // Reset Operation
        wb_rst_i = 1;
        #2;
        wb_rst_i = 0;
        #2;

        for (i=0; i<`MPRJ_IO_PADS; i=i+1) begin
            data = $urandom_range(0, 2**(7));
            write(mprj_ctrl+i*4, data);
            #2;
            read(mprj_ctrl+i*4);
            if (wb_dat_o !== data) begin
                $display("Monitor: R/W from IO-CTRL Failed.");
                $finish;
            end
        end

        data = $urandom_range(0, 2**(`MPRJ_PWR_PADS-2));
        write(pwr_ctrl, data);
        #2;
        read(pwr_ctrl);
        if (wb_dat_o !== data) begin
            $display("Monitor: R/W from POWER-CTRL Failed.");
            $finish;
        end
    
        
        $display("Success!");
        $display ("Monitor: Test Mega-Project Control Passed");
        $finish;
    end

    task write;
        input [32:0] addr;
        input [32:0] data;
        begin 
            @(posedge wb_clk_i) begin
                wb_stb_i = 1;
                wb_cyc_i = 1;
                wb_sel_i = 4'hF; 
                wb_we_i = 1;     
                wb_adr_i = addr;
                wb_dat_i = data;
                $display("Write Cycle Started.");
            end
            // Wait for an ACK
            wait(wb_ack_o == 1);
            wait(wb_ack_o == 0);
            wb_cyc_i = 0;
            wb_stb_i = 0;
            $display("Write Cycle Ended.");
        end
    endtask
    
    task read;
        input [32:0] addr;
        begin 
            @(posedge wb_clk_i) begin
                wb_stb_i = 1;
                wb_cyc_i = 1;
                wb_we_i = 0;
                wb_adr_i = addr;
                $display("Read Cycle Started.");
            end
            // Wait for an ACK
            wait(wb_ack_o == 1);
            wait(wb_ack_o == 0);
            wb_cyc_i = 0;
            wb_stb_i = 0;
            $display("Read Cycle Ended.");
        end
    endtask

    housekeeping uut(
        .wb_clk_i(wb_clk_i),
	    .wb_rst_i(wb_rst_i),
        .wb_stb_i(wb_stb_i),
	    .wb_cyc_i(wb_cyc_i),
	    .wb_sel_i(wb_sel_i),
	    .wb_we_i(wb_we_i),
	    .wb_dat_i(wb_dat_i),
	    .wb_adr_i(wb_adr_i), 
        .wb_ack_o(wb_ack_o),
	    .wb_dat_o(wb_dat_o)
    );

endmodule
