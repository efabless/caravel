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

module simple_por(
`ifdef USE_POWER_PINS
    inout VDD,
    inout VSS,
`endif
    output porb,
    output por
);

    reg inode;
    parameter PoR_DURATION = 500;
    // This is a behavioral model!  Actual circuit is a resitor dumping
    // current (slowly) from vdd3v3 onto a capacitor, and this fed into
    // two schmitt triggers for strong hysteresis/glitch tolerance.

    initial begin
        inode = 1'bx;
        @(posedge VDD); 
        inode = 1'b0; 
        #PoR_DURATION;
        inode = 1'b1; 
    end 

    // Emulate current source on capacitor as a 500ns delay either up or
    // down.  Note that this is sped way up for verilog simulation;  the
    // actual circuit is set to a 15ms delay.

    // Problem:  The GF power supplies in the I/O library are implemented
    // with "supply0" and "supply1", meaning that the power supply is tied
    // high permanently and never transitions.

    // always @(posedge VDD) begin
    // initial begin
	// #1000 inode <= 1'b1;
    // end
    // always @(negedge VDD) begin
    //	#500 inode <= 1'b0;
    // end

    // Instantiate this as a buffer. . . not a lot of choices
    assign porb = inode;

    // since this is behavioral anyway, but this should be
    // replaced by a proper inverter
    assign por = ~porb;
endmodule
`default_nettype wire
