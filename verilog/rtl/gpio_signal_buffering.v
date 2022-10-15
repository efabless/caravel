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
 * gpio_signal_buffering ---
 *
 * This macro buffers long wires between housekeeping and the GPIO control
 * blocks at the top level of caravel.  The rule of thumb is to limit any
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
 * GPIO 13	2.7			2		
 * GPIO 14	3.6			2		
 * GPIO 15	4.5			3		
 * GPIO 16	4.7			3		
 * GPIO 17	5.1			3		
 * GPIO 18	5.4			4	   RHS
 *-------------------------------------------------------
 * GPIO 19	8.4			6	   LHS
 * GPIO 20	8.2			6
 * GPIO 21	7.9			6
 * GPIO 22	7.7			5
 * GPIO 23	7.4			5
 * GPIO 24	6.4			4
 * GPIO 25	6.1			4
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
 *	       total number of buffers: 95 (x2 for input and output)
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

module gpio_signal_buffering (
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

    input  [`MPRJ_IO_PADS-1:0] mgmt_io_in_unbuf;
    input  [`MPRJ_IO_PADS-1:0] mgmt_io_out_unbuf;
    input  [`MPRJ_IO_PADS-1:0] mgmt_io_oeb_unbuf;
    output [`MPRJ_IO_PADS-1:0] mgmt_io_oeb_buf;
    output [`MPRJ_IO_PADS-1:0] mgmt_io_in_buf;
    output [`MPRJ_IO_PADS-1:0] mgmt_io_out_buf;

    /* Instantiate 95 + 95 + 6 = 196 buffers of size 8 */

    wire [195:0] buf_in;
    wire [195:0] buf_out;

    sky130_fd_sc_hd__buf_8 signal_buffers [195:0] (
	`ifdef USE_POWER_PINS
	    .VPWR(vccd),
	    .VGND(vssd),
	    .VPB(vccd),
	    .VNB(vssd),
	`endif
	.A(buf_in),
	.X(buf_out)
    );

    /* First 7 GPIOs have no buffering, so just connect with assignments */

    assign mgmt_io_in_buf[6:0] = mgmt_io_in_unbuf[6:0];
    assign mgmt_io_out_buf[6:0] = mgmt_io_out_unbuf[6:0];

    /* Only the last two OEB lines have buffering.  All the rest are either	*/
    /* unbuffered or else unrouted (no-connects at housekeeping)		*/ 
    assign mgmt_io_oeb_buf[34:0] = mgmt_io_oeb_unbuf[34:0];

    /* Now chain them all together */

    //----------------------------------------
    // mgmt_io_in, right-hand side
    //----------------------------------------

    assign buf_in[0] = mgmt_io_in_unbuf[7];
    assign mgmt_io_in_buf[7] = buf_out[0];

    assign buf_in[1] = mgmt_io_in_unbuf[8];
    assign mgmt_io_in_buf[8] = buf_out[1];

    assign buf_in[2] = mgmt_io_in_unbuf[9];
    assign mgmt_io_in_buf[9] = buf_out[2];

    assign buf_in[3] = mgmt_io_in_unbuf[10];
    assign mgmt_io_in_buf[10] = buf_out[3];

    assign buf_in[4] = mgmt_io_in_unbuf[11];
    assign mgmt_io_in_buf[11] = buf_out[4];

    assign buf_in[5] = mgmt_io_in_unbuf[12];
    assign mgmt_io_in_buf[12] = buf_out[5];

    assign buf_in[6] = mgmt_io_in_unbuf[13];
    assign buf_in[7] = buf_out[6];
    assign mgmt_io_in_buf[13] = buf_out[7];

    assign buf_in[8] = mgmt_io_in_unbuf[14];
    assign buf_in[9] = buf_out[8];
    assign mgmt_io_in_buf[14] = buf_out[9];

    assign buf_in[10] = mgmt_io_in_unbuf[15];
    assign buf_in[11] = buf_out[10];
    assign buf_in[12] = buf_out[11];
    assign mgmt_io_in_buf[15] = buf_out[12];

    assign buf_in[13] = mgmt_io_in_unbuf[16];
    assign buf_in[14] = buf_out[13];
    assign buf_in[15] = buf_out[14];
    assign mgmt_io_in_buf[16] = buf_out[15];

    assign buf_in[16] = mgmt_io_in_unbuf[17];
    assign buf_in[17] = buf_out[16];
    assign buf_in[18] = buf_out[17];
    assign mgmt_io_in_buf[17] = buf_out[18];

    assign buf_in[19] = mgmt_io_in_unbuf[18];
    assign buf_in[20] = buf_out[19];
    assign buf_in[21] = buf_out[20];
    assign buf_in[22] = buf_out[21];
    assign mgmt_io_in_buf[18] = buf_out[22];

    //----------------------------------------
    // mgmt_io_in, left-hand side
    //----------------------------------------

    assign buf_in[23] = mgmt_io_in_unbuf[19];
    assign buf_in[24] = buf_out[23];
    assign buf_in[25] = buf_out[24];
    assign buf_in[26] = buf_out[25];
    assign buf_in[27] = buf_out[26];
    assign buf_in[28] = buf_out[27];
    assign mgmt_io_in_buf[19] = buf_out[28];

    assign buf_in[29] = mgmt_io_in_unbuf[20];
    assign buf_in[30] = buf_out[29];
    assign buf_in[31] = buf_out[30];
    assign buf_in[32] = buf_out[31];
    assign buf_in[33] = buf_out[32];
    assign buf_in[34] = buf_out[33];
    assign mgmt_io_in_buf[20] = buf_out[34];

    assign buf_in[35] = mgmt_io_in_unbuf[21];
    assign buf_in[36] = buf_out[35];
    assign buf_in[37] = buf_out[36];
    assign buf_in[38] = buf_out[37];
    assign buf_in[39] = buf_out[38];
    assign buf_in[40] = buf_out[39];
    assign mgmt_io_in_buf[21] = buf_out[40];

    assign buf_in[41] = mgmt_io_in_unbuf[22];
    assign buf_in[42] = buf_out[41];
    assign buf_in[43] = buf_out[42];
    assign buf_in[44] = buf_out[43];
    assign buf_in[45] = buf_out[44];
    assign mgmt_io_in_buf[22] = buf_out[45];

    assign buf_in[46] = mgmt_io_in_unbuf[23];
    assign buf_in[47] = buf_out[46];
    assign buf_in[48] = buf_out[47];
    assign buf_in[49] = buf_out[48];
    assign buf_in[50] = buf_out[49];
    assign mgmt_io_in_buf[23] = buf_out[50];

    assign buf_in[51] = mgmt_io_in_unbuf[24];
    assign buf_in[52] = buf_out[51];
    assign buf_in[53] = buf_out[52];
    assign buf_in[54] = buf_out[53];
    assign mgmt_io_in_buf[24] = buf_out[54];

    assign buf_in[55] = mgmt_io_in_unbuf[25];
    assign buf_in[56] = buf_out[55];
    assign buf_in[57] = buf_out[56];
    assign buf_in[58] = buf_out[57];
    assign mgmt_io_in_buf[25] = buf_out[58];

    assign buf_in[59] = mgmt_io_in_unbuf[26];
    assign buf_in[60] = buf_out[59];
    assign buf_in[61] = buf_out[60];
    assign buf_in[62] = buf_out[61];
    assign mgmt_io_in_buf[26] = buf_out[62];

    assign buf_in[63] = mgmt_io_in_unbuf[27];
    assign buf_in[64] = buf_out[63];
    assign buf_in[65] = buf_out[64];
    assign buf_in[66] = buf_out[65];
    assign mgmt_io_in_buf[27] = buf_out[66];

    assign buf_in[67] = mgmt_io_in_unbuf[28];
    assign buf_in[68] = buf_out[67];
    assign buf_in[69] = buf_out[68];
    assign buf_in[70] = buf_out[69];
    assign mgmt_io_in_buf[28] = buf_out[70];

    assign buf_in[71] = mgmt_io_in_unbuf[29];
    assign buf_in[72] = buf_out[71];
    assign buf_in[73] = buf_out[72];
    assign buf_in[74] = buf_out[73];
    assign mgmt_io_in_buf[29] = buf_out[74];

    assign buf_in[75] = mgmt_io_in_unbuf[30];
    assign buf_in[76] = buf_out[75];
    assign buf_in[77] = buf_out[76];
    assign mgmt_io_in_buf[30] = buf_out[77];

    assign buf_in[78] = mgmt_io_in_unbuf[31];
    assign buf_in[79] = buf_out[78];
    assign buf_in[80] = buf_out[79];
    assign mgmt_io_in_buf[31] = buf_out[80];

    assign buf_in[81] = mgmt_io_in_unbuf[32];
    assign buf_in[82] = buf_out[81];
    assign buf_in[83] = buf_out[82];
    assign mgmt_io_in_buf[32] = buf_out[83];

    assign buf_in[84] = mgmt_io_in_unbuf[33];
    assign buf_in[85] = buf_out[84];
    assign buf_in[86] = buf_out[85];
    assign mgmt_io_in_buf[33] = buf_out[86];

    assign buf_in[87] = mgmt_io_in_unbuf[34];
    assign buf_in[88] = buf_out[87];
    assign mgmt_io_in_buf[34] = buf_out[88];

    assign buf_in[89] = mgmt_io_in_unbuf[35];
    assign buf_in[90] = buf_out[89];
    assign mgmt_io_in_buf[35] = buf_out[90];

    assign buf_in[91] = mgmt_io_in_unbuf[36];
    assign buf_in[92] = buf_out[91];
    assign mgmt_io_in_buf[36] = buf_out[92];

    assign buf_in[93] = mgmt_io_in_unbuf[37];
    assign buf_in[94] = buf_out[93];
    assign mgmt_io_in_buf[37] = buf_out[94];

    //----------------------------------------
    // mgmt_io_out, right-hand side
    //----------------------------------------

    assign buf_in[95] = mgmt_io_out_unbuf[7];
    assign mgmt_io_out_buf[7] = buf_out[95];

    assign buf_in[96] = mgmt_io_out_unbuf[8];
    assign mgmt_io_out_buf[8] = buf_out[96];

    assign buf_in[97] = mgmt_io_out_unbuf[9];
    assign mgmt_io_out_buf[9] = buf_out[97];

    assign buf_in[98] = mgmt_io_out_unbuf[10];
    assign mgmt_io_out_buf[10] = buf_out[98];

    assign buf_in[99] = mgmt_io_out_unbuf[11];
    assign mgmt_io_out_buf[11] = buf_out[99];

    assign buf_in[100] = mgmt_io_out_unbuf[12];
    assign mgmt_io_out_buf[12] = buf_out[100];

    assign buf_in[101] = mgmt_io_out_unbuf[13];
    assign buf_in[102] = buf_out[101];
    assign mgmt_io_out_buf[13] = buf_out[102];

    assign buf_in[103] = mgmt_io_out_unbuf[14];
    assign buf_in[104] = buf_out[103];
    assign mgmt_io_out_buf[14] = buf_out[104];

    assign buf_in[105] = mgmt_io_out_unbuf[15];
    assign buf_in[106] = buf_out[105];
    assign buf_in[107] = buf_out[106];
    assign mgmt_io_out_buf[15] = buf_out[107];

    assign buf_in[108] = mgmt_io_out_unbuf[16];
    assign buf_in[109] = buf_out[108];
    assign buf_in[110] = buf_out[109];
    assign mgmt_io_out_buf[16] = buf_out[110];

    assign buf_in[111] = mgmt_io_out_unbuf[17];
    assign buf_in[112] = buf_out[111];
    assign buf_in[113] = buf_out[112];
    assign mgmt_io_out_buf[17] = buf_out[113];

    assign buf_in[114] = mgmt_io_out_unbuf[18];
    assign buf_in[115] = buf_out[114];
    assign buf_in[116] = buf_out[115];
    assign buf_in[117] = buf_out[116];
    assign mgmt_io_out_buf[18] = buf_out[117];

    //----------------------------------------
    // mgmt_io_out, left-hand side
    //----------------------------------------

    assign buf_in[118] = mgmt_io_out_unbuf[19];
    assign buf_in[119] = buf_out[118];
    assign buf_in[120] = buf_out[119];
    assign buf_in[121] = buf_out[120];
    assign buf_in[122] = buf_out[121];
    assign buf_in[123] = buf_out[122];
    assign mgmt_io_out_buf[19] = buf_out[123];

    assign buf_in[124] = mgmt_io_out_unbuf[20];
    assign buf_in[125] = buf_out[124];
    assign buf_in[126] = buf_out[125];
    assign buf_in[127] = buf_out[126];
    assign buf_in[128] = buf_out[127];
    assign buf_in[129] = buf_out[128];
    assign mgmt_io_out_buf[20] = buf_out[129];

    assign buf_in[130] = mgmt_io_out_unbuf[21];
    assign buf_in[131] = buf_out[130];
    assign buf_in[132] = buf_out[131];
    assign buf_in[133] = buf_out[132];
    assign buf_in[134] = buf_out[133];
    assign buf_in[135] = buf_out[134];
    assign mgmt_io_out_buf[21] = buf_out[135];

    assign buf_in[136] = mgmt_io_out_unbuf[22];
    assign buf_in[137] = buf_out[136];
    assign buf_in[138] = buf_out[137];
    assign buf_in[139] = buf_out[138];
    assign buf_in[140] = buf_out[139];
    assign mgmt_io_out_buf[22] = buf_out[140];

    assign buf_in[141] = mgmt_io_out_unbuf[23];
    assign buf_in[142] = buf_out[141];
    assign buf_in[143] = buf_out[142];
    assign buf_in[144] = buf_out[143];
    assign buf_in[145] = buf_out[144];
    assign mgmt_io_out_buf[23] = buf_out[145];

    assign buf_in[146] = mgmt_io_out_unbuf[24];
    assign buf_in[147] = buf_out[146];
    assign buf_in[148] = buf_out[147];
    assign buf_in[149] = buf_out[148];
    assign mgmt_io_out_buf[24] = buf_out[149];

    assign buf_in[150] = mgmt_io_out_unbuf[25];
    assign buf_in[151] = buf_out[150];
    assign buf_in[152] = buf_out[151];
    assign buf_in[153] = buf_out[152];
    assign mgmt_io_out_buf[25] = buf_out[153];

    assign buf_in[154] = mgmt_io_out_unbuf[26];
    assign buf_in[155] = buf_out[154];
    assign buf_in[156] = buf_out[155];
    assign buf_in[157] = buf_out[156];
    assign mgmt_io_out_buf[26] = buf_out[157];

    assign buf_in[158] = mgmt_io_out_unbuf[27];
    assign buf_in[159] = buf_out[158];
    assign buf_in[160] = buf_out[159];
    assign buf_in[161] = buf_out[160];
    assign mgmt_io_out_buf[27] = buf_out[161];

    assign buf_in[162] = mgmt_io_out_unbuf[28];
    assign buf_in[163] = buf_out[162];
    assign buf_in[164] = buf_out[163];
    assign buf_in[165] = buf_out[164];
    assign mgmt_io_out_buf[28] = buf_out[165];

    assign buf_in[166] = mgmt_io_out_unbuf[29];
    assign buf_in[167] = buf_out[166];
    assign buf_in[168] = buf_out[167];
    assign buf_in[169] = buf_out[168];
    assign mgmt_io_out_buf[29] = buf_out[169];

    assign buf_in[170] = mgmt_io_out_unbuf[30];
    assign buf_in[171] = buf_out[170];
    assign buf_in[172] = buf_out[171];
    assign mgmt_io_out_buf[30] = buf_out[172];

    assign buf_in[173] = mgmt_io_out_unbuf[31];
    assign buf_in[174] = buf_out[173];
    assign buf_in[175] = buf_out[174];
    assign mgmt_io_out_buf[31] = buf_out[175];

    assign buf_in[176] = mgmt_io_out_unbuf[32];
    assign buf_in[177] = buf_out[176];
    assign buf_in[178] = buf_out[177];
    assign mgmt_io_out_buf[32] = buf_out[178];

    assign buf_in[179] = mgmt_io_out_unbuf[33];
    assign buf_in[180] = buf_out[179];
    assign buf_in[181] = buf_out[180];
    assign mgmt_io_out_buf[33] = buf_out[181];

    assign buf_in[182] = mgmt_io_out_unbuf[34];
    assign buf_in[183] = buf_out[182];
    assign mgmt_io_out_buf[34] = buf_out[183];

    assign buf_in[184] = mgmt_io_out_unbuf[35];
    assign buf_in[185] = buf_out[184];
    assign mgmt_io_out_buf[35] = buf_out[185];

    assign buf_in[186] = mgmt_io_out_unbuf[36];
    assign buf_in[187] = buf_out[186];
    assign mgmt_io_out_buf[36] = buf_out[187];

    assign buf_in[188] = mgmt_io_out_unbuf[37];
    assign buf_in[189] = buf_out[188];
    assign mgmt_io_out_buf[37] = buf_out[189];

    //----------------------------------------
    // mgmt_io_oeb, left-hand side (only)
    //----------------------------------------

    assign buf_in[190] = mgmt_io_oeb_unbuf[35];
    assign buf_in[191] = buf_out[190];
    assign mgmt_io_oeb_buf[35] = buf_out[191];

    assign buf_in[192] = mgmt_io_oeb_unbuf[36];
    assign buf_in[193] = buf_out[192];
    assign mgmt_io_oeb_buf[36] = buf_out[193];

    assign buf_in[194] = mgmt_io_oeb_unbuf[37];
    assign buf_in[195] = buf_out[194];
    assign mgmt_io_oeb_buf[37] = buf_out[195];

endmodule
