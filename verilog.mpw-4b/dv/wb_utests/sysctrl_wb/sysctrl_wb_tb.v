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

module sysctrl_wb_tb;

    reg wb_clk_i;
    reg wb_rst_i;

    reg wb_stb_i;
    reg wb_cyc_i;
    reg wb_we_i;
    reg [3:0] wb_sel_i;
    reg [31:0] wb_dat_i;
    reg [31:0] wb_adr_i;

    reg porb;

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
    
    initial begin
        $dumpfile("sysctrl_wb_tb.vcd");
        $dumpvars(0, sysctrl_wb_tb);
        repeat (50) begin
            repeat (1000) @(posedge wb_clk_i);
        end
        $display("%c[1;31m",27);
        $display ("Monitor: Timeout, Test System Control Failed");
        $display("%c[0m",27);
        $finish;
    end

    integer i;
    
    // System Control Default Register Addresses 
    wire [31:0] clk_out_adr  = uut.SYS_BASE_ADR | 8'h04;
    wire [31:0] irq_src_adr  = uut.SYS_BASE_ADR | 8'h0c;

    reg       clk1_output_dest;
    reg [1:0] clk2_output_dest;
    reg [2:0] trap_output_dest;
    reg       irq_7_inputsrc;
    reg [1:0] irq_8_inputsrc;
   
    initial begin
        // Reset Operation
	porb = 0;
        wb_rst_i = 1;
	#2;
	porb = 1;
        #2;
        wb_rst_i = 0;
        #2;
        
        clk1_output_dest   = 1'b1;
        clk2_output_dest   = 2'b10;
        trap_output_dest  = 3'b100;
        irq_7_inputsrc    = 1'b1;
        irq_8_inputsrc    = 2'b10;

        // Write to System Control Registers
        write(clk_out_adr, clk2_output_dest);
        #20;
        write(irq_src_adr,  irq_7_inputsrc);
        #20;
        read(clk_out_adr);
        if (wb_dat_o !== clk2_output_dest) begin
            $display("Error reading CLK1 output destination register.");
            $finish;
        end

        #20;
        read(irq_src_adr);
        if (wb_dat_o !== irq_7_inputsrc) begin
            $display("Error reading IRQ7 input source register.");
            $finish;
        end

        $display("Success!");
        $display ("Monitor: Test System Control Passed!");
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
                $display("Monitor: Write Cycle Started.");
            end
            // Wait for an ACK
            wait(wb_ack_o == 1);
            wait(wb_ack_o == 0);
            wb_cyc_i = 0;
            wb_stb_i = 0;
            $display("Monitor: Write Cycle Ended.");
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
                $display("Monitor: Read Cycle Started.");
            end
            // Wait for an ACK
            wait(wb_ack_o == 1);
            wait(wb_ack_o == 0);
            wb_cyc_i = 0;
            wb_stb_i = 0;
            $display("Monitor: Read Cycle Ended.");
        end
    endtask

    housekeeping uut(
	.porb(porb),
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
