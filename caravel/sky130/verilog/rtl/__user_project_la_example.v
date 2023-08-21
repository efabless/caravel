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
 *-------------------------------------------------------------
 *
 * user_project_la_example
 *
 * This is a user project for testing the la only 
 *
 *-------------------------------------------------------------
 */

module user_project_la_example (
    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb
);
    // LA
    assign la_data_out[63:32]  =  la_oenb[31:0]   ?  32'hz: la_data_in[31:0]   ; // assign la0 to la1 if la0 output enable
    assign la_data_out[31:0]   =  la_oenb[63:32]  ?  32'hz: la_data_in[63:32]   ; // assign la1 to la0 if la1 output enable
    assign la_data_out[127:96] =  la_oenb[95:64]  ?  32'hz: la_data_in[95:64]   ; // assign la2 to la3 if la2 output enable
    assign la_data_out[95:64]  =  la_oenb[127:96] ?  32'hz: la_data_in[127:96]  ; // assign la3 to la2 if la3 output enable
    // // LA
    // assign la_data_out[63:32]  =  la_oenb[31:0]   ?  la_data_in[31:0]   : 32'hz ; // assign la0 to la1 if la0 output enable
    // assign la_data_out[31:0]   =  la_oenb[63:32]  ?  la_data_in[63:32]  : 32'hz ; // assign la1 to la0 if la1 output enable
    // assign la_data_out[127:96] =  la_oenb[95:64]  ?  la_data_in[95:64]  : 32'hz ; // assign la2 to la3 if la2 output enable
    // assign la_data_out[95:64]  =  la_oenb[127:96] ?  la_data_in[127:96] : 32'hz ; // assign la3 to la2 if la3 output enable
   

endmodule

`default_nettype wire
