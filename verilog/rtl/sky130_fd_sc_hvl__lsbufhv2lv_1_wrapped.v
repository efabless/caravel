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

module sky130_fd_sc_hvl__lsbufhv2lv_1_wrapped (
	X    ,
	A    ,
`ifdef USE_POWER_PINS
	VPWR ,
	VGND ,
	LVPWR,
	LVGND,
`endif
);

output X    ;
input  A    ;
`ifdef USE_POWER_PINS
inout  VPWR ;
inout  VGND ;
inout  LVPWR;
inout  LVGND;
`endif

sky130_fd_sc_hvl__lsbufhv2lv_1 lvlshiftdown (
`ifdef USE_POWER_PINS
	.VPWR(VPWR),
	.VPB(VPWR),

	.LVPWR(LVPWR),

	.VNB(VGND),
	.VGND(VGND),
`endif
	.A(A),
	.X(X)
);

endmodule
