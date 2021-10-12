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
module mprj_ctrl_wb #(
    parameter BASE_ADR  = 32'h 2300_0000,
    parameter XFER      = 8'h 00,
    parameter PWRDATA   = 8'h 04,
    parameter IRQDATA   = 8'h 08,
    parameter IODATA    = 8'h 0c, // One word per 32 IOs
    parameter IOCONFIG  = 8'h 24
)(
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

    // Output is to serial loader
    output serial_clock,
    output serial_resetn,
    output serial_data_out_1,
    output serial_data_out_2,

    // Pass state of OEB bit on SDO and JTAG back to the core
    // so that the function can be overridden for management output
    output sdo_oenb_state,
    output jtag_oenb_state,
    output flash_io2_oenb_state,
    output flash_io3_oenb_state,

    // Read/write data to each GPIO pad from management SoC
    input [`MPRJ_IO_PADS-1:0] mgmt_gpio_in,
    output [`MPRJ_IO_PADS-1:0] mgmt_gpio_out,
    output [`MPRJ_IO_PADS-1:0] mgmt_gpio_oeb,

    // Write data to power controls
    output [`MPRJ_PWR_PADS-1:0] pwr_ctrl_out,

    // Enable user project IRQ signals to management SoC
    output [2:0] user_irq_ena,

    // External bit-bang controls from the housekeeping SPI
    input ext_clock,
    input ext_resetn,
    input ext_data_1,
    input ext_data_2,
    input ext_enable
);
    wire resetn;
    wire valid;
    wire ready;
    wire [3:0] iomem_we;

    assign resetn = ~wb_rst_i;
    assign valid  = wb_stb_i && wb_cyc_i; 

    assign iomem_we = wb_sel_i & {4{wb_we_i}};
    assign wb_ack_o = ready;

    mprj_ctrl #(
        .BASE_ADR(BASE_ADR),
        .XFER(XFER),
	.PWRDATA(PWRDATA),
	.IRQDATA(IRQDATA),
	.IODATA(IODATA),
        .IOCONFIG(IOCONFIG)
    ) mprj_ctrl (
        .clk(wb_clk_i),
        .resetn(resetn),
        .iomem_addr(wb_adr_i),
        .iomem_valid(valid),
        .iomem_wstrb(iomem_we[1:0]),
        .iomem_wdata(wb_dat_i),
        .iomem_rdata(wb_dat_o),
        .iomem_ready(ready),

	.serial_clock(serial_clock),
	.serial_resetn(serial_resetn),
	.serial_data_out_1(serial_data_out_1),
	.serial_data_out_2(serial_data_out_2),
	.sdo_oenb_state(sdo_oenb_state),
	.jtag_oenb_state(jtag_oenb_state),
	.flash_io2_oenb_state(flash_io2_oenb_state),
	.flash_io3_oenb_state(flash_io3_oenb_state),
	// .mgmt_gpio_io(mgmt_gpio_io)
	.mgmt_gpio_in(mgmt_gpio_in),
	.mgmt_gpio_out(mgmt_gpio_out),
	.mgmt_gpio_oeb(mgmt_gpio_oeb),

    	// Write data to power controls
 	.pwr_ctrl_out(pwr_ctrl_out),
    	// Enable user project IRQ signals to management SoC
	.user_irq_ena(user_irq_ena),

	// External bit-bang control from housekeeping SPI
	.ext_clock(ext_clock),
	.ext_resetn(ext_resetn),
	.ext_data_1(ext_data_1),
	.ext_data_2(ext_data_2),
	.ext_enable(ext_enable)
    );

endmodule

module mprj_ctrl #(
    parameter BASE_ADR  = 32'h 2300_0000,
    parameter XFER      = 8'h 00,
    parameter PWRDATA   = 8'h 04,
    parameter IRQDATA   = 8'h 08,
    parameter IODATA    = 8'h 0c,
    parameter IOCONFIG  = 8'h 24,
    parameter IO_CTRL_BITS = 13
)(
    input clk,
    input resetn,

    input [31:0] iomem_addr,
    input iomem_valid,
    input [1:0] iomem_wstrb,
    input [31:0] iomem_wdata,
    output reg [31:0] iomem_rdata,
    output reg iomem_ready,

    output serial_clock,
    output serial_resetn,
    output serial_data_out_1,
    output serial_data_out_2,
    output sdo_oenb_state,
    output jtag_oenb_state,
    output flash_io2_oenb_state,
    output flash_io3_oenb_state,
    input  [`MPRJ_IO_PADS-1:0] mgmt_gpio_in,
    output [`MPRJ_IO_PADS-1:0] mgmt_gpio_out,
    output [`MPRJ_IO_PADS-1:0] mgmt_gpio_oeb,
    output [`MPRJ_PWR_PADS-1:0] pwr_ctrl_out,
    output [2:0] user_irq_ena,

    input ext_clock,
    input ext_resetn,
    input ext_data_1,
    input ext_data_2,
    input ext_enable
);

`define IDLE	2'b00
`define START	2'b01
`define XBYTE	2'b10
`define LOAD	2'b11

    localparam IO_WORDS = (`MPRJ_IO_PADS % 32 != 0) + (`MPRJ_IO_PADS / 32);

    localparam IO_BASE_ADR = (BASE_ADR | IOCONFIG);

    localparam OEB = 1;			// Offset of output enable in shift register.
    localparam INP_DIS = 3;		// Offset of input disable in shift register. 

    reg  [IO_CTRL_BITS-1:0] io_ctrl[`MPRJ_IO_PADS-1:0];  // I/O control, 1 word per gpio pad
    reg  [`MPRJ_IO_PADS-1:0] mgmt_gpio_out; 	 // I/O write data, 1 bit per gpio pad
    reg  [`MPRJ_PWR_PADS-1:0] pwr_ctrl_out;	 // Power write data, 1 bit per power pad
    reg  [2:0] user_irq_ena;		 // Enable user to raise IRQs
    reg xfer_ctrl;			 // Transfer control (1 bit)

    wire [IO_WORDS-1:0] io_data_sel;	// wishbone selects
    wire pwr_data_sel;
    wire irq_data_sel;
    wire xfer_sel;
    wire busy;
    wire selected;
    wire [`MPRJ_IO_PADS-1:0] io_ctrl_sel;
    reg [31:0] iomem_rdata_pre;

    wire [`MPRJ_IO_PADS-1:0] mgmt_gpio_in;

    wire sdo_oenb_state, jtag_oenb_state;
    wire flash_io2_oenb_state, flash_io3_oenb_state;

    // JTAG and housekeeping SDO are normally controlled by their respective
    // modules with OEB set to the default 1 value.  If configured for an
    // additional output by setting the OEB bit low, then pass this information
    // back to the core so that the default signals can be overridden.

    assign jtag_oenb_state = io_ctrl[0][OEB];
    assign sdo_oenb_state = io_ctrl[1][OEB];

    // Likewise for the flash_io2 and flash_io3, although they are configured
    // as input by default.
    assign flash_io2_oenb_state = io_ctrl[(`MPRJ_IO_PADS)-2][OEB];
    assign flash_io3_oenb_state = io_ctrl[(`MPRJ_IO_PADS)-1][OEB];

    `define wtop (((i+1)*32 > `MPRJ_IO_PADS) ? `MPRJ_IO_PADS-1 : (i+1)*32-1)
    `define wbot (i*32)
    `define rtop (`wtop - `wbot)

    genvar i;

    // Assign selection bits per address

    assign xfer_sel = (iomem_addr[7:0] == XFER);
    assign pwr_data_sel = (iomem_addr[7:0] == PWRDATA);
    assign irq_data_sel = (iomem_addr[7:0] == IRQDATA);

    generate
        for (i=0; i<IO_WORDS; i=i+1) begin
    	    assign io_data_sel[i] = (iomem_addr[7:0] == (IODATA + i*4)); 
	end

        for (i=0; i<`MPRJ_IO_PADS; i=i+1) begin
            assign io_ctrl_sel[i] = (iomem_addr[7:0] == (IO_BASE_ADR[7:0] + i*4)); 
    	    assign mgmt_gpio_oeb[i] = ~io_ctrl[i][INP_DIS];
        end
    endgenerate


    // Set selection and iomem_rdata_pre

    assign selected = xfer_sel || pwr_data_sel || irq_data_sel || (|io_data_sel) || (|io_ctrl_sel);

    wire [31:0] io_data_arr[0:IO_WORDS-1];
    wire [31:0] io_ctrl_arr[0:`MPRJ_IO_PADS-1];
    generate
            for (i=0; i<IO_WORDS; i=i+1) begin
                assign io_data_arr[i] = {{(31-`rtop){1'b0}}, mgmt_gpio_in[`wtop:`wbot]};

            end
            for (i=0; i<`MPRJ_IO_PADS; i=i+1) begin
                assign io_ctrl_arr[i] = {{(32-IO_CTRL_BITS){1'b0}}, io_ctrl[i]};
            end
    endgenerate


    integer j;
    always @ * begin
        iomem_rdata_pre = 'b0;
        if (xfer_sel) begin
            iomem_rdata_pre = {31'b0, busy};
        end else if (pwr_data_sel) begin
            iomem_rdata_pre = {{(32-`MPRJ_PWR_PADS){1'b0}}, pwr_ctrl_out};
        end else if (irq_data_sel) begin
            iomem_rdata_pre = {29'b0, user_irq_ena};
        end else if (|io_data_sel) begin
            for (j=0; j<IO_WORDS; j=j+1) begin
                if (io_data_sel[j]) begin
                    iomem_rdata_pre = io_data_arr[j];
                end
            end
        end else begin
            for (j=0; j<`MPRJ_IO_PADS; j=j+1) begin
                if (io_ctrl_sel[j]) begin
                    iomem_rdata_pre = io_ctrl_arr[j];
                end
            end
        end
    end

    // General I/O transfer

    always @(posedge clk) begin
	if (!resetn) begin
            iomem_rdata <= 0;
	    iomem_ready <= 0;
	end else begin
	    iomem_ready <= 0;
	    if (iomem_valid && !iomem_ready && iomem_addr[31:8] == BASE_ADR[31:8]) begin
		iomem_ready <= 1'b 1;

		if (selected) begin
		    iomem_rdata <= iomem_rdata_pre;
		end
	    end
	end
    end

    // I/O write of xfer bit.  Also handles iomem_ready signal and power data.

    always @(posedge clk) begin
	if (!resetn) begin
	    xfer_ctrl <= 0;
            pwr_ctrl_out <= 0;
	    user_irq_ena <= 0;
	end else begin
	    if (iomem_valid && !iomem_ready && iomem_addr[31:8] == BASE_ADR[31:8]) begin
		if (xfer_sel) begin
		    if (iomem_wstrb[0]) xfer_ctrl <= iomem_wdata[0];
		end else if (pwr_data_sel) begin
                    if (iomem_wstrb[0]) pwr_ctrl_out <= iomem_wdata[`MPRJ_PWR_PADS-1:0];
		end else if (irq_data_sel) begin
                    if (iomem_wstrb[0]) user_irq_ena <= iomem_wdata[2:0];
		end
	    end else begin
		xfer_ctrl <= 1'b0;	// Immediately self-resetting
	    end
	end
    end

    // I/O transfer of gpio data to/from user project region under management
    // SoC control

    generate 
        for (i=0; i<IO_WORDS; i=i+1) begin
	    always @(posedge clk) begin
		if (!resetn) begin
		    mgmt_gpio_out[`wtop:`wbot] <= 'd0;
		end else begin
		    if (iomem_valid && !iomem_ready && iomem_addr[31:8] ==
					BASE_ADR[31:8]) begin
			if (io_data_sel[i]) begin
			    if (iomem_wstrb[0]) begin
				mgmt_gpio_out[`wtop:`wbot] <= iomem_wdata[`rtop:0];
			    end
			end
		    end
		end
	    end
	end

        for (i=0; i<`MPRJ_IO_PADS; i=i+1) begin
             always @(posedge clk) begin
                if (!resetn) begin
		    // NOTE:  This initialization must match the defaults passed
		    // to the control blocks.  Specifically, 0x1803 is for a
		    // bidirectional pad, and 0x0403 is for a simple input pad
		    if ((i < 2) || (i >= `MPRJ_IO_PADS - 2)) begin
                    	io_ctrl[i] <= 'h1803;
		    end else begin
                    	io_ctrl[i] <= 'h0403;
		    end
                end else begin
                    if (iomem_valid && !iomem_ready &&
					iomem_addr[31:8] == BASE_ADR[31:8]) begin
                        if (io_ctrl_sel[i]) begin
			    // NOTE:  Byte-wide write to io_ctrl is prohibited
                            if (iomem_wstrb[0])
				io_ctrl[i] <= iomem_wdata[IO_CTRL_BITS-1:0];
                        end 
                    end
                end
            end
        end
    endgenerate

    reg [3:0]  xfer_count;
    reg [4:0]  pad_count_1;
    reg [5:0]  pad_count_2;
    reg [1:0]  xfer_state;
    reg	       serial_clock;
    reg	       serial_resetn;

    reg [IO_CTRL_BITS-1:0] serial_data_staging_1;
    reg [IO_CTRL_BITS-1:0] serial_data_staging_2;

    wire       serial_data_out_1;
    wire       serial_data_out_2;

    assign serial_data_out_1 = (ext_enable == 1'b1) ? ext_data_1 :
		serial_data_staging_1[IO_CTRL_BITS-1];
    assign serial_data_out_2 = (ext_enable == 1'b1) ? ext_data_2 :
		serial_data_staging_2[IO_CTRL_BITS-1];
    assign busy = (xfer_state != `IDLE);
 
    always @(posedge clk or negedge resetn) begin
	if (resetn == 1'b0) begin

	    xfer_state <= `IDLE;
	    xfer_count <= 4'd0;
	    /* NOTE:  This assumes that MPRJ_IO_PADS_1 and MPRJ_IO_PADS_2 are
	     * equal, because they get clocked the same number of cycles by
	     * the same clock signal.  pad_count_2 gates the count for both.
	     */
	    pad_count_1 <= `MPRJ_IO_PADS_1 - 1;
	    pad_count_2 <= `MPRJ_IO_PADS_1;
	    serial_resetn <= 1'b0;
	    serial_clock <= 1'b0;
	    serial_data_staging_1 <= 0;
	    serial_data_staging_2 <= 0;

	end else begin

	    if (ext_enable == 1'b1) begin
		serial_clock <= ext_clock;
		serial_resetn <= ext_resetn;
	    end else if (xfer_state == `IDLE) begin
	    	pad_count_1 <= `MPRJ_IO_PADS_1 - 1;
	    	pad_count_2 <= `MPRJ_IO_PADS_1;
	    	serial_resetn <= 1'b1;
		serial_clock <= 1'b0;
		if (xfer_ctrl == 1'b1) begin
		    xfer_state <= `START;
		end
	    end else if (xfer_state == `START) begin
	    	serial_resetn <= 1'b1;
		serial_clock <= 1'b0;
	    	xfer_count <= 6'd0;
		pad_count_1 <= pad_count_1 - 1;
		pad_count_2 <= pad_count_2 + 1;
		xfer_state <= `XBYTE;
		serial_data_staging_1 <= io_ctrl[pad_count_1];
		serial_data_staging_2 <= io_ctrl[pad_count_2];
	    end else if (xfer_state == `XBYTE) begin
	    	serial_resetn <= 1'b1;
		serial_clock <= ~serial_clock;
		if (serial_clock == 1'b0) begin
		    if (xfer_count == IO_CTRL_BITS - 1) begin
			if (pad_count_2 == `MPRJ_IO_PADS) begin
		    	    xfer_state <= `LOAD;
			end else begin
		    	    xfer_state <= `START;
			end
		    end else begin
		    	xfer_count <= xfer_count + 1;
		    end
		end else begin
		    serial_data_staging_1 <= {serial_data_staging_1[IO_CTRL_BITS-2:0], 1'b0};
		    serial_data_staging_2 <= {serial_data_staging_2[IO_CTRL_BITS-2:0], 1'b0};
		end
	    end else if (xfer_state == `LOAD) begin
		xfer_count <= xfer_count + 1;

		/* Load sequence:  Raise clock for final data shift in;
		 * Pulse reset low while clock is high
		 * Set clock back to zero.
		 * Return to idle mode.
		 */
		if (xfer_count == 4'd0) begin
		    serial_clock <= 1'b1;
		    serial_resetn <= 1'b1;
		end else if (xfer_count == 4'd1) begin
		    serial_clock <= 1'b1;
		    serial_resetn <= 1'b0;
		end else if (xfer_count == 4'd2) begin
		    serial_clock <= 1'b1;
		    serial_resetn <= 1'b1;
		end else if (xfer_count == 4'd3) begin
		    serial_resetn <= 1'b1;
		    serial_clock <= 1'b0;
		    xfer_state <= `IDLE;
		end
	    end	
	end
    end

endmodule
`default_nettype wire
