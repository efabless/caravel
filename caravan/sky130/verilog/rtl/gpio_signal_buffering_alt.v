// SPDX-FileCopyrightText: 2022 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

/*
 * gpio_signal_buffering_alt ---
 *
 * This macro buffers long wires between housekeeping and the GPIO control
 * blocks at the top level of caravan.  The rule of thumb is to limit any
 * single wire length to approximately 1.3mm.  The physical (manhattan)
 * distances and required buffering are as follows:
 *
 * Breakpoints: 1.3, 2.6, 3.9, 5.2, 6.5, 7.8	(mm)
 * # buffers:     1,   2,   3,   4,   5,   6
 *
 * GPIO #    	wire length (mm)	# buffers
 *------------------------------------------------------
 * GPIO 0	0.4			0
 * GPIO 1	0.2			0
 * GPIO 2	0.0			0
 * GPIO 3	0.3			0
 * GPIO 4	0.5			0
 * GPIO 5	0.7			0
 * GPIO 6	1.0			0
 * GPIO 7	1.4			1	
 * GPIO 8	1.6			1
 * GPIO 9	1.8			1
 * GPIO 10	2.1			1
 * GPIO 11	2.3			1
 * GPIO 12	2.5			1
 * GPIO 13	2.7			2	   RHS	
 *-------------------------------------------------------
 * GPIO 25	6.1			4	   LHS
 * GPIO 26	5.9			4
 * GPIO 27	5.7			4
 * GPIO 28	5.5			4
 * GPIO 29	5.3			4
 * GPIO 30	5.1			3
 * GPIO 31	4.8			3
 * GPIO 32	4.2			3
 * GPIO 33	4.0			3
 * GPIO 34	3.8			2
 * GPIO 35	3.5			2
 * GPIO 36	3.3			2
 * GPIO 37	3.4			2
 *------------------------------------------------------
 *	       total number of buffers: 48 (x2 for input and output)
 *
 * OEB lines go to GPIO 0 and 1 (no buffers needed) and GPIO 35-37
 * (2 buffers needed), so OEB lines need 6 additional buffers.
 *
 * The assumption is that all GPIOs on the left-hand side of the chip are
 * routed by taking wires left from the housekeeping across the top of the
 * SoC to the left side, and then up to the destination.  Right-hand side
 * connections go directly up the right side from the housekeeping block.
 *
 * Note that signal names are related to the signal being passed through;
 * "in" and "out" refer to the direction of the signal relative to the
 * housekeeping block in the top level.  For this macro, unbuffered signals
 * "unbuf" are the inputs, and buffered signals "buf" are the outputs.
 */

module gpio_signal_buffering_alt (
`ifdef USE_POWER_PINS
    vccd,
    vssd,
`endif
    mgmt_io_in_unbuf,
    mgmt_io_out_unbuf,
    mgmt_io_oeb_buf,
    mgmt_io_in_buf,
    mgmt_io_out_buf,
    mgmt_io_oeb_unbuf
);

`ifdef USE_POWER_PINS
    input  vccd;
    input  vssd;
`endif

    /* NOTE:  To match the indices of the same signals in the
     * top level, add 35 to all OEB lines and add 7 to all in
     * and out lines up to 14, and add 18 to all in and out
     * lines above that.
     */
    input  [19:0] mgmt_io_in_unbuf;
    input  [19:0] mgmt_io_out_unbuf;
    input  [2:0] mgmt_io_oeb_unbuf;
    output [2:0] mgmt_io_oeb_buf;
    output [19:0] mgmt_io_in_buf;
    output [19:0] mgmt_io_out_buf;

    /* Instantiate 48 + 48 + 6 = 101 buffers of size 8 */

    wire [101:0] buf_in;
    wire [101:0] buf_out;

    sky130_fd_sc_hd__buf_8 signal_buffers [101:0] (
        `ifdef USE_POWER_PINS
	    .VPWR(vccd),
	    .VGND(vssd),
	    .VPB(vccd),
	    .VNB(vssd),
	`endif
	.A(buf_in),
	.X(buf_out)
    );

    /* Now chain them all together */

    //----------------------------------------
    // mgmt_io_in, right-hand side
    //----------------------------------------

    assign buf_in[0] = mgmt_io_in_unbuf[0];
    assign mgmt_io_in_buf[0] = buf_out[0];

    assign buf_in[1] = mgmt_io_in_unbuf[1];
    assign mgmt_io_in_buf[1] = buf_out[1];

    assign buf_in[2] = mgmt_io_in_unbuf[2];
    assign mgmt_io_in_buf[2] = buf_out[2];

    assign buf_in[3] = mgmt_io_in_unbuf[3];
    assign mgmt_io_in_buf[3] = buf_out[3];

    assign buf_in[4] = mgmt_io_in_unbuf[4];
    assign mgmt_io_in_buf[4] = buf_out[4];

    assign buf_in[5] = mgmt_io_in_unbuf[5];
    assign mgmt_io_in_buf[5] = buf_out[5];

    assign buf_in[6] = mgmt_io_in_unbuf[6];
    assign buf_in[7] = buf_out[6];
    assign mgmt_io_in_buf[6] = buf_out[7];

    //----------------------------------------
    // mgmt_io_in, left-hand side
    //----------------------------------------

    assign buf_in[8] = mgmt_io_in_unbuf[7];
    assign buf_in[9] = buf_out[8];
    assign buf_in[10] = buf_out[9];
    assign buf_in[11] = buf_out[10];
    assign mgmt_io_in_buf[7] = buf_out[11];

    assign buf_in[12] = mgmt_io_in_unbuf[8];
    assign buf_in[13] = buf_out[12];
    assign buf_in[14] = buf_out[13];
    assign buf_in[15] = buf_out[14];
    assign mgmt_io_in_buf[8] = buf_out[15];

    assign buf_in[16] = mgmt_io_in_unbuf[9];
    assign buf_in[17] = buf_out[16];
    assign buf_in[18] = buf_out[17];
    assign buf_in[19] = buf_out[18];
    assign mgmt_io_in_buf[9] = buf_out[19];

    assign buf_in[20] = mgmt_io_in_unbuf[10];
    assign buf_in[21] = buf_out[20];
    assign buf_in[22] = buf_out[21];
    assign buf_in[23] = buf_out[22];
    assign mgmt_io_in_buf[10] = buf_out[23];

    assign buf_in[24] = mgmt_io_in_unbuf[11];
    assign buf_in[25] = buf_out[24];
    assign buf_in[26] = buf_out[25];
    assign buf_in[27] = buf_out[26];
    assign mgmt_io_in_buf[11] = buf_out[27];

    assign buf_in[28] = mgmt_io_in_unbuf[12];
    assign buf_in[29] = buf_out[28];
    assign buf_in[30] = buf_out[29];
    assign mgmt_io_in_buf[12] = buf_out[30];

    assign buf_in[31] = mgmt_io_in_unbuf[13];
    assign buf_in[32] = buf_out[31];
    assign buf_in[33] = buf_out[32];
    assign mgmt_io_in_buf[13] = buf_out[33];

    assign buf_in[34] = mgmt_io_in_unbuf[14];
    assign buf_in[35] = buf_out[34];
    assign buf_in[36] = buf_out[35];
    assign mgmt_io_in_buf[14] = buf_out[36];

    assign buf_in[37] = mgmt_io_in_unbuf[15];
    assign buf_in[38] = buf_out[37];
    assign buf_in[39] = buf_out[38];
    assign mgmt_io_in_buf[15] = buf_out[39];

    assign buf_in[40] = mgmt_io_in_unbuf[16];
    assign buf_in[41] = buf_out[40];
    assign mgmt_io_in_buf[16] = buf_out[41];

    assign buf_in[42] = mgmt_io_in_unbuf[17];
    assign buf_in[43] = buf_out[42];
    assign mgmt_io_in_buf[17] = buf_out[43];

    assign buf_in[44] = mgmt_io_in_unbuf[18];
    assign buf_in[45] = buf_out[44];
    assign mgmt_io_in_buf[18] = buf_out[45];

    assign buf_in[46] = mgmt_io_in_unbuf[19];
    assign buf_in[47] = buf_out[46];
    assign mgmt_io_in_buf[19] = buf_out[47];

    //----------------------------------------
    // mgmt_io_out, right-hand side
    //----------------------------------------

    assign buf_in[48] = mgmt_io_out_unbuf[0];
    assign mgmt_io_out_buf[0] = buf_out[48];

    assign buf_in[49] = mgmt_io_out_unbuf[1];
    assign mgmt_io_out_buf[1] = buf_out[49];

    assign buf_in[50] = mgmt_io_out_unbuf[2];
    assign mgmt_io_out_buf[2] = buf_out[50];

    assign buf_in[51] = mgmt_io_out_unbuf[3];
    assign mgmt_io_out_buf[3] = buf_out[51];

    assign buf_in[52] = mgmt_io_out_unbuf[4];
    assign mgmt_io_out_buf[4] = buf_out[52];

    assign buf_in[53] = mgmt_io_out_unbuf[5];
    assign mgmt_io_out_buf[5] = buf_out[53];

    assign buf_in[54] = mgmt_io_out_unbuf[6];
    assign buf_in[55] = buf_out[54];
    assign mgmt_io_out_buf[6] = buf_out[55];

    //----------------------------------------
    // mgmt_io_out, left-hand side
    //----------------------------------------

    assign buf_in[56] = mgmt_io_out_unbuf[7];
    assign buf_in[57] = buf_out[56];
    assign buf_in[58] = buf_out[57];
    assign buf_in[59] = buf_out[58];
    assign mgmt_io_out_buf[7] = buf_out[59];

    assign buf_in[60] = mgmt_io_out_unbuf[8];
    assign buf_in[61] = buf_out[60];
    assign buf_in[62] = buf_out[61];
    assign buf_in[63] = buf_out[62];
    assign mgmt_io_out_buf[8] = buf_out[63];

    assign buf_in[64] = mgmt_io_out_unbuf[9];
    assign buf_in[65] = buf_out[64];
    assign buf_in[66] = buf_out[65];
    assign buf_in[67] = buf_out[66];
    assign mgmt_io_out_buf[9] = buf_out[67];

    assign buf_in[68] = mgmt_io_out_unbuf[10];
    assign buf_in[69] = buf_out[68];
    assign buf_in[70] = buf_out[69];
    assign buf_in[71] = buf_out[70];
    assign mgmt_io_out_buf[10] = buf_out[71];

    assign buf_in[72] = mgmt_io_out_unbuf[11];
    assign buf_in[73] = buf_out[72];
    assign buf_in[74] = buf_out[73];
    assign buf_in[75] = buf_out[74];
    assign mgmt_io_out_buf[11] = buf_out[75];

    assign buf_in[76] = mgmt_io_out_unbuf[12];
    assign buf_in[77] = buf_out[76];
    assign buf_in[78] = buf_out[77];
    assign mgmt_io_out_buf[12] = buf_out[78];

    assign buf_in[79] = mgmt_io_out_unbuf[13];
    assign buf_in[80] = buf_out[79];
    assign buf_in[81] = buf_out[80];
    assign mgmt_io_out_buf[13] = buf_out[81];

    assign buf_in[82] = mgmt_io_out_unbuf[14];
    assign buf_in[83] = buf_out[82];
    assign buf_in[84] = buf_out[83];
    assign mgmt_io_out_buf[14] = buf_out[84];

    assign buf_in[85] = mgmt_io_out_unbuf[15];
    assign buf_in[86] = buf_out[85];
    assign buf_in[87] = buf_out[86];
    assign mgmt_io_out_buf[15] = buf_out[87];

    assign buf_in[88] = mgmt_io_out_unbuf[16];
    assign buf_in[89] = buf_out[88];
    assign mgmt_io_out_buf[16] = buf_out[89];

    assign buf_in[90] = mgmt_io_out_unbuf[17];
    assign buf_in[91] = buf_out[90];
    assign mgmt_io_out_buf[17] = buf_out[91];

    assign buf_in[92] = mgmt_io_out_unbuf[18];
    assign buf_in[93] = buf_out[92];
    assign mgmt_io_out_buf[18] = buf_out[93];

    assign buf_in[94] = mgmt_io_out_unbuf[19];
    assign buf_in[95] = buf_out[94];
    assign mgmt_io_out_buf[19] = buf_out[95];

    //----------------------------------------
    // mgmt_io_oeb, left-hand side (only)
    //----------------------------------------

    assign buf_in[96] = mgmt_io_oeb_unbuf[0];
    assign buf_in[97] = buf_out[96];
    assign mgmt_io_oeb_buf[0] = buf_out[97];

    assign buf_in[98] = mgmt_io_oeb_unbuf[1];
    assign buf_in[99] = buf_out[98];
    assign mgmt_io_oeb_buf[1] = buf_out[99];

    assign buf_in[100] = mgmt_io_oeb_unbuf[2];
    assign buf_in[101] = buf_out[100];
    assign mgmt_io_oeb_buf[2] = buf_out[101];

    sky130_ef_sc_hd__decap_12 sigbuf_decaps [59:0] (
    `ifdef USE_POWER_PINS
        .VPWR(vccd),
        .VGND(vssd),
        .VPB(vccd),
        .VNB(vssd)
    `endif
    );

endmodule
