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
 *---------------------------------------------------------------------
 * A simple module that generates buffered high and low outputs
 * in the 1.8V domain.
 *---------------------------------------------------------------------
 */

module constant_block (
    `ifdef USE_POWER_PINS
         inout vccd,
         inout vssd,
    `endif

    output	 one,
    output	 zero
);

    wire	one_unbuf;
    wire	zero_unbuf;

    sky130_fd_sc_hd__conb_1 const_source (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .HI(one_unbuf),
            .LO(zero_unbuf)
    );

    /* Buffer the constant outputs (could be synthesized) */
    /* NOTE:  Constant cell HI, LO outputs are connected to power	*/
    /* rails through an approximately 120 ohm resistor, which is not	*/
    /* enough to drive inputs in the I/O cells while ensuring ESD	*/
    /* requirements, without buffering.					*/

    sky130_fd_sc_hd__buf_16 const_one_buf (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .A(one_unbuf),
            .X(one)
    );

    sky130_fd_sc_hd__buf_16 const_zero_buf (
`ifdef USE_POWER_PINS
            .VPWR(vccd),
            .VGND(vssd),
            .VPB(vccd),
            .VNB(vssd),
`endif
            .A(zero_unbuf),
            .X(zero)
    );

endmodule
`default_nettype wire
