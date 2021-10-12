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
module sysctrl_wb #(
    parameter BASE_ADR     = 32'h2F00_0000,
    parameter PWRGOOD	   = 8'h00,
    parameter CLK_OUT      = 8'h04,
    parameter TRAP_OUT     = 8'h08,
    parameter IRQ_SRC      = 8'h0c
) (
    input wb_clk_i,
    input wb_rst_i,

    input [31:0] wb_dat_i,
    input [31:0] wb_adr_i,
    input [3:0] wb_sel_i,
    input wb_cyc_i,
    input wb_stb_i,
    input wb_we_i,

    output [31:0] wb_dat_o,
    output wb_ack_o,
    
    input  usr1_vcc_pwrgood,
    input  usr2_vcc_pwrgood,
    input  usr1_vdd_pwrgood,
    input  usr2_vdd_pwrgood,
    output clk1_output_dest,
    output clk2_output_dest,
    output trap_output_dest,
    output irq_7_inputsrc,
    output irq_8_inputsrc

);

    wire resetn;
    wire valid;
    wire ready;
    wire [3:0] iomem_we;

    assign resetn = ~wb_rst_i;
    assign valid = wb_stb_i && wb_cyc_i; 

    assign iomem_we = wb_sel_i & {4{wb_we_i}};
    assign wb_ack_o = ready;
    
    sysctrl #(
        .BASE_ADR(BASE_ADR),
        .PWRGOOD(PWRGOOD),
        .CLK_OUT(CLK_OUT),
        .TRAP_OUT(TRAP_OUT),
        .IRQ_SRC(IRQ_SRC)
    ) sysctrl (
        .clk(wb_clk_i),
        .resetn(resetn),
        
        .iomem_addr(wb_adr_i),
        .iomem_valid(valid),
        .iomem_wstrb(iomem_we),
        .iomem_wdata(wb_dat_i),
        .iomem_rdata(wb_dat_o),
        .iomem_ready(ready),
        
	.usr1_vcc_pwrgood(usr1_vcc_pwrgood),
	.usr2_vcc_pwrgood(usr2_vcc_pwrgood),
	.usr1_vdd_pwrgood(usr1_vdd_pwrgood),
	.usr2_vdd_pwrgood(usr2_vdd_pwrgood),
        .clk1_output_dest(clk1_output_dest),
        .clk2_output_dest(clk2_output_dest),
        .trap_output_dest(trap_output_dest), 
        .irq_8_inputsrc(irq_8_inputsrc),
        .irq_7_inputsrc(irq_7_inputsrc)
    );

endmodule

module sysctrl #(
    parameter BASE_ADR = 32'h2300_0000,
    parameter PWRGOOD	   = 8'h00,
    parameter CLK_OUT      = 8'h04,
    parameter TRAP_OUT     = 8'h08,
    parameter IRQ_SRC      = 8'h0c
) (
    input clk,
    input resetn,
    
    input [31:0] iomem_addr,
    input iomem_valid,
    input [3:0] iomem_wstrb,
    input [31:0] iomem_wdata,
    output reg [31:0] iomem_rdata,
    output reg iomem_ready,

    input  usr1_vcc_pwrgood,
    input  usr2_vcc_pwrgood,
    input  usr1_vdd_pwrgood,
    input  usr2_vdd_pwrgood,
    output clk1_output_dest,
    output clk2_output_dest,
    output trap_output_dest,
    output irq_7_inputsrc,
    output irq_8_inputsrc
); 

    reg clk1_output_dest;
    reg clk2_output_dest;
    reg trap_output_dest;
    reg irq_7_inputsrc;
    reg irq_8_inputsrc;

    wire usr1_vcc_pwrgood;
    wire usr2_vcc_pwrgood;
    wire usr1_vdd_pwrgood;
    wire usr2_vdd_pwrgood;

    wire pwrgood_sel;
    wire clk_out_sel;
    wire trap_out_sel;
    wire irq_sel;

    assign pwrgood_sel  = (iomem_addr[7:0] == PWRGOOD);
    assign clk_out_sel  = (iomem_addr[7:0] == CLK_OUT);
    assign trap_out_sel = (iomem_addr[7:0] == TRAP_OUT);
    assign irq_sel  = (iomem_addr[7:0] == IRQ_SRC);

    always @(posedge clk) begin
        if (!resetn) begin
            clk1_output_dest <= 0;
            clk2_output_dest <= 0;
            trap_output_dest <= 0;
            irq_7_inputsrc <= 0;
            irq_8_inputsrc <= 0;
        end else begin
            iomem_ready <= 0;
            if (iomem_valid && !iomem_ready && iomem_addr[31:8] == BASE_ADR[31:8]) begin
                iomem_ready <= 1'b 1;
                
                if (pwrgood_sel) begin
                    iomem_rdata <= {28'd0, usr2_vdd_pwrgood, usr1_vdd_pwrgood,
				usr2_vcc_pwrgood, usr1_vcc_pwrgood};
		    // These are read-only bits;  no write behavior on wstrb.

                end else if (clk_out_sel) begin
                    iomem_rdata <= {30'd0, clk2_output_dest, clk1_output_dest};
                    if (iomem_wstrb[0]) begin
                        clk1_output_dest <= iomem_wdata[0];
                        clk2_output_dest <= iomem_wdata[1];
		    end

                end else if (trap_out_sel) begin
                    iomem_rdata <= {31'd0, trap_output_dest};
                    if (iomem_wstrb[0]) 
                        trap_output_dest <= iomem_wdata[0];

                end else if (irq_sel) begin
                    iomem_rdata <= {30'd0, irq_8_inputsrc, irq_7_inputsrc};
                    if (iomem_wstrb[0]) begin
                        irq_7_inputsrc <= iomem_wdata[0];
                        irq_8_inputsrc <= iomem_wdata[1];
		    end
                end
            end
        end
    end

endmodule
`default_nettype wire
