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

module mprj_logic_high (
`ifdef USE_POWER_PINS
    inout	   vccd1,
    inout	   vssd1,
`endif
    output [462:0] HI
);
sky130_fd_sc_hd__conb_1 insts [462:0] (
`ifdef USE_POWER_PINS
                .VPWR(vccd1),
                .VGND(vssd1),
                .VPB(vccd1),
                .VNB(vssd1),
`endif
                .HI(HI),
                .LO()
        );
endmodule
