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

`default_nettype wire

`timescale 1 ns / 1 ps

`include "__uprj_netlists.v"
`include "caravel_netlists.v"
`include "spiflash.v"

module gpio2_tb;
    // Signals declaration
    reg clock;
    reg RSTB;
    reg CSB;
    reg power1, power2;

    wire gpio;
    wire [37:0] mprj_io;

    always #12.5 clock <= (clock === 1'b0);

    initial begin
        clock = 0;
    end

    initial begin
        $dumpfile("gpio2.vcd");
        $dumpvars(0, gpio2_tb);

        // Repeat cycles of 1000 clock edges as needed to complete testbench
        repeat (150) begin
            repeat (1000) @(posedge clock);
        end
        $display("%c[1;31m",27);
        $display ("Monitor: Timeout, Test Project IO Stimulus (RTL) Failed");
        $display("%c[0m",27);
        $finish;
    end

    initial begin
        wait (mprj_io == 38'h0000000000);
        $display("Monitor: gpio2 test started");
        wait (mprj_io == 38'h0000000001);
        wait (mprj_io == 38'h0000000002);
        wait (mprj_io == 38'h0000000004);
        wait (mprj_io == 38'h0000000008);
        wait (mprj_io == 38'h0000000010);
        wait (mprj_io == 38'h0000000020);
        wait (mprj_io == 38'h0000000040);
        wait (mprj_io == 38'h0000000080);
        wait (mprj_io == 38'h0000000100);
        wait (mprj_io == 38'h0000000200);
        wait (mprj_io == 38'h0000000400);
        wait (mprj_io == 38'h0000000800);
        wait (mprj_io == 38'h0000001000);
        wait (mprj_io == 38'h0000002000);
        wait (mprj_io == 38'h0000004000);
        wait (mprj_io == 38'h0000008000);
        wait (mprj_io == 38'h0000010000);
        wait (mprj_io == 38'h0000020000);
        wait (mprj_io == 38'h0000040000);
        wait (mprj_io == 38'h0000080000);
        wait (mprj_io == 38'h0000100000);
        wait (mprj_io == 38'h0000200000);
        wait (mprj_io == 38'h0000400000);
        wait (mprj_io == 38'h0000800000);
        wait (mprj_io == 38'h0001000000);
        wait (mprj_io == 38'h0002000000);
        wait (mprj_io == 38'h0004000000);
        wait (mprj_io == 38'h0008000000);
        wait (mprj_io == 38'h0010000000);
        wait (mprj_io == 38'h0020000000);
        wait (mprj_io == 38'h0040000000);
        wait (mprj_io == 38'h0080000000);
        wait (mprj_io == 38'h0100000000);
        wait (mprj_io == 38'h0200000000);
        wait (mprj_io == 38'h0400000000);
        wait (mprj_io == 38'h0800000000);
        wait (mprj_io == 38'h1000000000);
        wait (mprj_io == 38'h2000000000);
        $display("Monitor: gpio2 test Passed");
        #10000;
        $finish;
    end

   // Reset Operation
    initial begin
        RSTB <= 1'b0;
        CSB  <= 1'b1;       // Force CSB high
        #2000;
        RSTB <= 1'b1;       // Release reset
        #170000;
        CSB = 1'b0;         // CSB can be released
    end

    initial begin		// Power-up sequence
        power1 <= 1'b0;
        power2 <= 1'b0;
        #200;
        power1 <= 1'b1;
        #200;
        power2 <= 1'b1;
    end

    wire flash_csb;
    wire flash_clk;
    wire flash_io0;
    wire flash_io1;

    wire VDD3V3 = power1;
    wire VDD1V8 = power2;
    wire VSS = 1'b0;

    caravel uut (
        .vddio	  (VDD3V3),
        .vssio	  (VSS),
        .vdda	  (VDD3V3),
        .vssa	  (VSS),
        .vccd	  (VDD1V8),
        .vssd	  (VSS),
        .vdda1    (VDD3V3),
        .vdda2    (VDD3V3),
        .vssa1	  (VSS),
        .vssa2	  (VSS),
        .vccd1	  (VDD1V8),
        .vccd2	  (VDD1V8),
        .vssd1	  (VSS),
        .vssd2	  (VSS),
        .clock	  (clock),
        .gpio     (gpio),
        .mprj_io  (mprj_io),
        .flash_csb(flash_csb),
        .flash_clk(flash_clk),
        .flash_io0(flash_io0),
        .flash_io1(flash_io1),
        .resetb	  (RSTB)
    );


    spiflash #(
        .FILENAME("gpio2.hex")
    ) spiflash (
        .csb(flash_csb),
        .clk(flash_clk),
        .io0(flash_io0),
        .io1(flash_io1),
        .io2(),         // not used
        .io3()          // not used
    );

endmodule
`default_nettype wire
