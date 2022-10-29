`timescale 1 ns / 1 ps
`ifdef VCS
`ifndef GL
	`include "includes.v" // in case of RTL coverage is needed and it doesn't work correctly without include files by this way
`endif // ~ GL

`ifndef ENABLE_SDF
	`include "libs.ref/sky130_fd_io/verilog/sky130_fd_io.v"
	`include "libs.ref/sky130_fd_io/verilog/sky130_ef_io.v"
	`include "libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/primitives.v"
	`include "libs.ref/sky130_fd_sc_hvl/verilog/sky130_fd_sc_hvl.v"
`else
	`include "cvc-pdk/sky130_ef_io.v"
	`include "cvc-pdk/sky130_fd_io.v"
	`include "cvc-pdk/primitives_hd.v"
	`include "cvc-pdk/sky130_fd_sc_hd.v"
	`include "cvc-pdk/primitives_hvl.v"
	`include "cvc-pdk/sky130_fd_sc_hvl.v"
`endif // ~ ENABLE_SDF
`endif // VCS

module caravel_top ;

// parameter FILENAME = {"hex_files/",`TESTNAME,".hex"};
parameter FILENAME={"hex_files/",`TESTNAME,".hex"};
initial begin
	`ifdef VCS
		`ifdef ENABLE_SDF
				$vcdplusfile({`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/",`TESTNAME , `CORNER,"-",`SDF_POSTFIX, ".vpd"});
		`else
				$vcdplusfile({`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/",`TESTNAME ,".vpd"});
		`endif
		$vcdpluson();
	`else 
		$dumpfile ({"sim/",`TAG,"/",`SIM,"-",`TESTNAME,"/",`SIM,"-",`TESTNAME,".vcd"});
		$dumpvars (0, caravel_top);
	`endif
end
	`ifdef VCS
	`ifdef ENABLE_SDF
		`include "sdf_includes.v"
	`endif
	`endif // VCS
	wire vddio_tb;	// Common 3.3V padframe/ESD power
    wire vddio_2_tb;	// Common 3.3V padframe/ESD power
    wire vssio_tb;	// Common padframe/ESD ground
    wire vssio_2_tb;	// Common padframe/ESD ground
    wire vdda_tb;		// Management 3.3V power
    wire vssa_tb;		// Common analog ground
    wire vccd_tb;		// Management/Common 1.8V power
    wire vssd_tb;		// Common digital ground
    wire vdda1_tb;	// User area 1 3.3V power
    wire vdda1_2_tb;	// User area 1 3.3V power
    wire vdda2_tb;	// User area 2 3.3V power
    wire vssa1_tb;	// User area 1 analog ground
    wire vssa1_2_tb;	// User area 1 analog ground
    wire vssa2_tb;	// User area 2 analog ground
    wire vccd1_tb;	// User area 1 1.8V power
    wire vccd2_tb;	// User area 2 1.8V power
    wire vssd1_tb;	// User area 1 digital ground
    wire vssd2_tb;	// User area 2 digital ground

    wire gpio_tb;		// Used for external LDO control
    wire [38-1:0] mprj_io_tb;
    reg clock_tb;    	// CMOS core clock input; not a crystal
    wire resetb_tb;	// Reset input (sense inverted)

    // Note that only two flash data pins are dedicated to the
    // management SoC wrapper.  The management SoC exports the
    // quad SPI mode status to make use of the top two mprj_io
    // pins for io2 and io3.

    wire flash_csb_tb;
    wire flash_clk_tb;
    wire flash_io0_tb;
    wire flash_io1_tb;


`ifdef CARAVAN
caravan uut (
`else
caravel uut (
`endif
		.vddio	  (vddio_tb),
		.vddio_2  (vddio_2_tb),		
		.vssio	  (vssio_tb),
		.vssio_2  (vssio_2_tb),
		.vdda	  (vdda_tb),
		.vssa	  (vssa_tb),
		.vccd	  (vccd_tb),
		.vssd	  (vssd_tb),
		.vdda1    (vdda1_tb),
		.vdda1_2  (vdda1_2_tb),
		.vdda2    (vdda2_tb),
		.vssa1	  (vssa1_tb),
		.vssa1_2  (vssa1_2_tb),
		.vssa2	  (vssa2_tb),
		.vccd1	  (vccd1_tb),
		.vccd2	  (vccd2_tb),
		.vssd1	  (vssd1_tb),
		.vssd2	  (vssd2_tb),
		.clock	  (clock_tb),
		.gpio     (gpio_tb),
		.mprj_io  (mprj_io_tb),
		.flash_csb(flash_csb_tb),
		.flash_clk(flash_clk_tb),
		.flash_io0(flash_io0_tb),
		.flash_io1(flash_io1_tb),
		.resetb	  (resetb_tb)
	);

	spiflash #(
		FILENAME
	) spiflash (
		.csb(flash_csb_tb),
		.clk(flash_clk_tb),
		.io0(flash_io0_tb),
		.io1(flash_io1_tb),
		.io2(),			// not used
		.io3()			// not used
	);

	mac macros();


	// make speical variables for the mprj input to assign the input without writing to the output gpios
	// cocotb limitation  #2587: iverilog deal with array as 1 object not multiple of objects so can't write to only 1 element
	wire bin0;
	wire bin0_en;	
	wire bin1;
	wire bin1_en;	
	wire bin2;
	wire bin2_en;	
	wire bin3;
	wire bin3_en;	
	wire bin4;
	wire bin4_en;
	wire bin5;
	wire bin5_en;	
	wire bin6;
	wire bin6_en;	
	wire bin7;
	wire bin7_en;	
	wire bin8;
	wire bin8_en;	
	wire bin9;
	wire bin9_en;	
	wire bin10;
	wire bin10_en;	
	wire bin11;
	wire bin11_en;	
	wire bin12;
	wire bin12_en;
	wire bin13;
	wire bin13_en;	
	wire bin14;
	wire bin14_en;	
	wire bin15;
	wire bin15_en;
	wire bin16;
	wire bin16_en;	
	wire bin17;
	wire bin17_en;	
	wire bin18;
	wire bin18_en;	
	wire bin19;
	wire bin19_en;
	wire bin20;
	wire bin20_en;	
	wire bin21;
	wire bin21_en;	
	wire bin22;
	wire bin22_en;	
	wire bin23;
	wire bin23_en;	
	wire bin24;
	wire bin24_en;	
	wire bin25;
	wire bin25_en;	
	wire bin26;
	wire bin26_en;	
	wire bin27;
	wire bin27_en;
	wire bin28;
	wire bin28_en;	
	wire bin29;
	wire bin29_en;	
	wire bin30;
	wire bin30_en;	
	wire bin31;
	wire bin31_en;	
	wire bin32;
	wire bin32_en;	
	wire bin33;
	wire bin33_en;	
	wire bin34;
	wire bin34_en;	
	wire bin35;
	wire bin35_en;	
	wire bin36;
	wire bin36_en;	
	wire bin37;
	wire bin37_en;
	

	assign mprj_io_tb[0] = (bin0_en) ? bin0 : 1'bz;
	assign mprj_io_tb[1] = (bin1_en) ? bin1 : 1'bz;
	assign mprj_io_tb[2] = (bin2_en) ? bin2 : 1'bz;
	assign mprj_io_tb[3] = (bin3_en) ? bin3 : 1'bz;
	assign mprj_io_tb[4] = (bin4_en) ? bin4 : 1'bz;

	assign mprj_io_tb[5] = (bin5_en) ? bin5 : 1'bz;
	assign mprj_io_tb[6] = (bin6_en) ? bin6 : 1'bz;
	assign mprj_io_tb[7] = (bin7_en) ? bin7 : 1'bz;
	assign mprj_io_tb[8] = (bin8_en) ? bin8 : 1'bz;
	assign mprj_io_tb[9] = (bin9_en) ? bin9 : 1'bz;

	assign mprj_io_tb[10] = (bin10_en) ? bin10 : 1'bz;
	assign mprj_io_tb[11] = (bin11_en) ? bin11 : 1'bz;
	assign mprj_io_tb[12] = (bin12_en) ? bin12 : 1'bz;
	assign mprj_io_tb[13] = (bin13_en) ? bin13 : 1'bz;
	assign mprj_io_tb[14] = (bin14_en) ? bin14 : 1'bz;

	assign mprj_io_tb[15] = (bin15_en) ? bin15 : 1'bz;
	assign mprj_io_tb[16] = (bin16_en) ? bin16 : 1'bz;
	assign mprj_io_tb[17] = (bin17_en) ? bin17 : 1'bz;
	assign mprj_io_tb[18] = (bin18_en) ? bin18 : 1'bz;
	assign mprj_io_tb[19] = (bin19_en) ? bin19 : 1'bz;

	assign mprj_io_tb[20] = (bin20_en) ? bin20 : 1'bz;
	assign mprj_io_tb[21] = (bin21_en) ? bin21 : 1'bz;
	assign mprj_io_tb[22] = (bin22_en) ? bin22 : 1'bz;
	assign mprj_io_tb[23] = (bin23_en) ? bin23 : 1'bz;
	assign mprj_io_tb[24] = (bin24_en) ? bin24 : 1'bz;

	assign mprj_io_tb[25] = (bin25_en) ? bin25 : 1'bz;
	assign mprj_io_tb[26] = (bin26_en) ? bin26 : 1'bz;
	assign mprj_io_tb[27] = (bin27_en) ? bin27 : 1'bz;
	assign mprj_io_tb[28] = (bin28_en) ? bin28 : 1'bz;
	assign mprj_io_tb[29] = (bin29_en) ? bin29 : 1'bz;

	assign mprj_io_tb[30] = (bin30_en) ? bin30 : 1'bz;
	assign mprj_io_tb[31] = (bin31_en) ? bin31 : 1'bz;
	assign mprj_io_tb[32] = (bin32_en) ? bin32 : 1'bz;
	assign mprj_io_tb[33] = (bin33_en) ? bin33 : 1'bz;
	assign mprj_io_tb[34] = (bin34_en) ? bin34 : 1'bz;

	assign mprj_io_tb[35] = (bin35_en) ? bin35 : 1'bz;
	assign mprj_io_tb[36] = (bin36_en) ? bin36 : 1'bz;
	assign mprj_io_tb[37] = (bin37_en) ? bin37 : 1'bz;



	// to read from mprj array with iverilog  
	wire bin0_monitor;
	wire bin1_monitor;
	wire bin2_monitor;
	wire bin3_monitor;
	wire bin4_monitor;
	wire bin5_monitor;
	wire bin6_monitor;
	wire bin7_monitor;
	wire bin8_monitor;
	wire bin9_monitor;
	wire bin10_monitor;
	wire bin11_monitor;
	wire bin12_monitor;
	wire bin13_monitor;
	wire bin14_monitor;
	wire bin15_monitor;
	wire bin16_monitor;
	wire bin17_monitor;
	wire bin18_monitor;
	wire bin19_monitor;
	wire bin20_monitor;
	wire bin21_monitor;
	wire bin22_monitor;
	wire bin23_monitor;
	wire bin24_monitor;
	wire bin25_monitor;
	wire bin26_monitor;
	wire bin27_monitor;
	wire bin28_monitor;
	wire bin29_monitor;
	wire bin30_monitor;
	wire bin31_monitor;
	wire bin32_monitor;
	wire bin33_monitor;
	wire bin34_monitor;
	wire bin35_monitor;
	wire bin36_monitor;
	wire bin37_monitor;

	assign bin0_monitor = mprj_io_tb[0];
	assign bin1_monitor = mprj_io_tb[1];
	assign bin2_monitor = mprj_io_tb[2];
	assign bin3_monitor = mprj_io_tb[3];
	assign bin4_monitor = mprj_io_tb[4];
	assign bin5_monitor = mprj_io_tb[5];
	assign bin6_monitor = mprj_io_tb[6];
	assign bin7_monitor = mprj_io_tb[7];
	assign bin8_monitor = mprj_io_tb[8];
	assign bin9_monitor = mprj_io_tb[9];
	assign bin10_monitor = mprj_io_tb[10];
	assign bin11_monitor = mprj_io_tb[11];
	assign bin12_monitor = mprj_io_tb[12];
	assign bin13_monitor = mprj_io_tb[13];
	assign bin14_monitor = mprj_io_tb[14];
	assign bin15_monitor = mprj_io_tb[15];
	assign bin16_monitor = mprj_io_tb[16];
	assign bin17_monitor = mprj_io_tb[17];
	assign bin18_monitor = mprj_io_tb[18];
	assign bin19_monitor = mprj_io_tb[19];
	assign bin20_monitor = mprj_io_tb[20];
	assign bin21_monitor = mprj_io_tb[21];
	assign bin22_monitor = mprj_io_tb[22];
	assign bin23_monitor = mprj_io_tb[23];
	assign bin24_monitor = mprj_io_tb[24];
	assign bin25_monitor = mprj_io_tb[25];
	assign bin26_monitor = mprj_io_tb[26];
	assign bin27_monitor = mprj_io_tb[27];
	assign bin28_monitor = mprj_io_tb[28];
	assign bin29_monitor = mprj_io_tb[29];
	assign bin30_monitor = mprj_io_tb[30];
	assign bin31_monitor = mprj_io_tb[31];
	assign bin32_monitor = mprj_io_tb[32];
	assign bin33_monitor = mprj_io_tb[33];
	assign bin34_monitor = mprj_io_tb[34];
	assign bin35_monitor = mprj_io_tb[35];
	assign bin36_monitor = mprj_io_tb[36];
	assign bin37_monitor = mprj_io_tb[37];

endmodule

// module that has all needed macros by cocotb
module mac;

reg [7:0] MPRJ_IO_PADS_1  = `ifdef MPRJ_IO_PADS_1 `MPRJ_IO_PADS_1 `else 0 `endif;	/* number of user GPIO pads on user1 side */
reg [7:0] MPRJ_IO_PADS_2  = `ifdef MPRJ_IO_PADS_2 `MPRJ_IO_PADS_2 `else 0 `endif;	/* number of user GPIO pads on user2 side */
reg [7:0] MPRJ_IO_PADS    = `ifdef MPRJ_IO_PADS `MPRJ_IO_PADS `else 0 `endif;
reg [7:0] MPRJ_PWR_PADS_1 =`ifdef MPRJ_PWR_PADS_1 `MPRJ_PWR_PADS_1 `else 0 `endif;	/* vdda1, vccd1 enable/disable control */
reg [7:0] MPRJ_PWR_PADS_2 = `ifdef MPRJ_PWR_PADS_2 `MPRJ_PWR_PADS_2 `else 0 `endif;	/* vdda2, vccd2 enable/disable control */
reg [7:0] MPRJ_PWR_PADS   =`ifdef MPRJ_PWR_PADS `MPRJ_PWR_PADS `else 0 `endif;
// Analog pads are only used by the "caravan" module and associated
// modules such as user_analog_project_wrapper and chip_io_alt.
reg [7:0] ANALOG_PADS_1  = `ifdef ANALOG_PADS_1 `ANALOG_PADS_1 `else 0 `endif;
reg [7:0] ANALOG_PADS_2  = `ifdef ANALOG_PADS_2 `ANALOG_PADS_2 `else 0 `endif;
reg [7:0] ANALOG_PADS    = `ifdef ANALOG_PADS `ANALOG_PADS `else 0 `endif;

// Type and size of soc_mem
reg USE_CUSTOM_DFFRAM    = `ifdef USE_CUSTOM_DFFRAM 1 `else 0 `endif;
// don't change the following without double checking addr widths
reg [7:0] MEM_WORDS      = `ifdef MEM_WORDS `MEM_WORDS `else 0 `endif;
// Number of columns in the custom memory; takes one of three values:
// 1 column : 1 KB, 2 column: 2 KB, 4 column: 4KB
reg [7:0] DFFRAM_WSIZE   = `ifdef DFFRAM_WSIZE `DFFRAM_WSIZE `else 0 `endif;
reg [7:0] DFFRAM_USE_LATCH = `ifdef DFFRAM_USE_LATCH `DFFRAM_USE_LATCH `else 0 `endif;

// not really parameterized but just to easily keep track of the number
// of ram_block across different modules
reg [7:0] RAM_BLOCKS = `ifdef RAM_BLOCKS `RAM_BLOCKS `else 0 `endif;

// Clock divisor default value
reg [7:0] CLK_DIV = `ifdef CLK_DIV `CLK_DIV `else 0 `endif;

// GPIO control default mode and enable for most I/Os
// Most I/Os set to be user bidirectional pins on power-up.
reg [7:0] MGMT_INIT = `ifdef MGMT_INIT `MGMT_INIT `else 0 `endif;
reg [7:0] OENB_INIT = `ifdef OENB_INIT `OENB_INIT `else 0 `endif;
reg [7:0] DM_INIT = `ifdef DM_INIT `DM_INIT `else 0 `endif;

// GL

reg GL = `ifdef GL 1 `else 0 `endif;

reg CARAVAN = `ifdef CARAVAN 1 `else 0 `endif;

endmodule