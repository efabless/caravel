// VIP
`include "caravel_mgmt_soc_litex/verilog/dv/vip/tbuart.v"
`include "caravel_mgmt_soc_litex/verilog/dv/vip/spiflash.v"
`include "caravel_mgmt_soc_litex/verilog/dv/vip/wb_rw_test.v"

// DFFRAM Behavioral Model
// `include "caravel_mgmt_soc_litex/verilog/dv/vip/RAM128.v"
// `include "caravel_mgmt_soc_litex/verilog/dv/vip/RAM256.v"


// Mgmt Core Wrapper
`include "caravel/verilog/rtl/user_defines.v"		     
`include "caravel_mgmt_soc_litex/verilog/rtl/defines.v"
// `include "caravel_mgmt_soc_litex/verilog/rtl/mgmt_core.v"
`include "caravel_mgmt_soc_litex/verilog/gl/RAM128.v"
// `include "caravel_mgmt_soc_litex/verilog/gl/mgmt_core_wrapper.v"
// `include "caravel_mgmt_soc_litex/verilog/rtl/VexRiscv_MinDebugCache.v"

// Caravel

// These blocks need to stay in RTL
			
// `include "caravel/verilog/rtl/pads.v"			
`include "caravel/verilog/rtl/simple_por.v"		     

// These blocks only needed for RTL sims							     
// `include "caravel/verilog/rtl/digital_pll_controller.v" 
// `include "caravel/verilog/rtl/ring_osc2x13.v"		
// `include "caravel/verilog/rtl/clock_div.v"
					     
`include "caravel/verilog/gl/constant_block.v" 
// `include "caravel/verilog/rtl/chip_io_alt.v" 		     
`include "caravel/verilog/gl/chip_io.v" 		     
`include "caravel/verilog/gl/mprj_logic_high.v" 	     
`include "caravel/verilog/gl/mprj2_logic_high.v"	     
// `include "caravel/verilog/rtl/mgmt_protect.v"		     
`include "caravel/verilog/gl/mgmt_protect_hv.v" 	     
// `include "caravel/verilog/rtl/gpio_control_block.v"	     
`include "caravel/verilog/gl/gpio_defaults_block.v"	     
`include "caravel/verilog/gl/gpio_logic_high.v" 	     
`include "caravel/verilog/gl/xres_buf.v"		     
`include "caravel/verilog/gl/spare_logic_block.v"	     
`include "caravel/verilog/gl/housekeeping.v"		     
`include "caravel/verilog/gl/caravel_clocking.v"	     
// `include "caravel/verilog/rtl/digital_pll.v"		     

// `ifndef CARAVAN
// `include "caravel/verilog/rtl/__user_project_wrapper.v"
// `else
// `include "caravel/verilog/rtl/__user_analog_project_wrapper.v"
// `endif
`include "caravel/verilog/gl/user_id_programming.v"	     
`include "caravel/verilog/gl/mprj_io_buffer.v"	     
`include "caravel/verilog/gl/caravel_core.v" 		     
`include "caravel/verilog/gl/caravel.v" 		     
`include "caravel/verilog/gl/caravan.v" 		     

// These blocks are manually designed 		
`include "caravel/verilog/gl/gpio_defaults_block_0403.v"     
`include "caravel/verilog/gl/gpio_defaults_block_1803.v"     
`include "caravel/verilog/gl/gpio_defaults_block_0801.v"     


`include "caravel/verilog/gl/empty_macro.v" 
`include "caravel/verilog/gl/manual_power_connections.v" 
`include "caravel/verilog/gl/copyright_block.v" 
`include "caravel/verilog/gl/caravel_logo.v" 
`include "caravel/verilog/gl/caravel_motto.v" 
`include "caravel/verilog/gl/open_source.v" 
`include "caravel/verilog/gl/user_id_textblock.v" 
