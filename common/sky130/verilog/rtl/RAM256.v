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

module RAM256 #(parameter   USE_LATCH=1,
                            WSIZE=4 ) 
(
    `ifdef USE_POWER_PINS
    inout VPWR,	    /* 1.8V domain */
    inout VGND,
    `endif
    input   wire                CLK,    // FO: 2
    input   wire [WSIZE-1:0]     WE0,     // FO: 2
    input                        EN0,     // FO: 2
    input   wire [7:0]           A0,      // FO: 5
    input   wire [(WSIZE*8-1):0] Di0,     // FO: 2
    output  wire [(WSIZE*8-1):0] Do0

);

    wire [1:0]             SEL0;
    wire [(WSIZE*8-1):0]    Do0_pre[1:0]; 

    // 1x2 DEC
    // DEC1x2 DEC0 (.EN(EN0), .A(A0[7]), .SEL(SEL0));
    assign SEL0[0] = EN0 && (~A0[7]);
    assign SEL0[1] = EN0 && ( A0[7]);

    generate
        genvar i;
        for (i=0; i< 2; i=i+1) begin : BANK128
            RAM128 RAM128 (`ifdef USE_POWER_PINS .VPWR(VPWR), .VGND(VGND),  `endif .CLK(CLK), .EN0(SEL0[i]), .WE0(WE0), .Di0(Di0), .Do0(Do0_pre[i]), .A0(A0[6:0]) );        
        end
     endgenerate

    // Output MUX    
    // MUX2x1 #(.WIDTH(WSIZE*8)) Do0MUX ( .A0(Do0_pre[0]), .A1(Do0_pre[1]), .S(A0[7]), .X(Do0) );
    assign Do0 = A0[7]? Do0_pre[1]:Do0_pre[0];
    
endmodule