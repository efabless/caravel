module sram(
    `ifdef USE_POWER_PINS
    VDD,	 
    VSS,
    `endif
// Port 0: RW
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
// Port 1: R
    clk1,csb1,addr1,dout1
);

    parameter   NUM_WMASKS  = 4 ;
    parameter   DATA_WIDTH  = 32 ;
    parameter   ADDR_WIDTH  = 9 ;
    parameter   RAM_DEPTH   = 1 << ADDR_WIDTH;

    input                   clk0; // clock
    input                   csb0; // active low chip select
    input                   web0; // active low write control
    input [NUM_WMASKS-1:0]  wmask0; // write mask
    input [ADDR_WIDTH-1:0]  addr0;
    input [DATA_WIDTH-1:0]  din0;
    output [DATA_WIDTH-1:0] dout0;
    input                   clk1; // clock
    input                   csb1; // active low chip select
    input [ADDR_WIDTH-1:0]  addr1;
    output [DATA_WIDTH-1:0] dout1;
    `ifdef USE_POWER_PINS
    inout VDD;
    inout VSS;
    `endif

    GF180_RAM_512x32 ram512x32 (    
                                    `ifdef USE_POWER_PINS
                                    .VDD(VDD), 
                                    .VSS(VSS),
                                    `endif
                                    .CLK(clk0), 
                                    .CEN(csb0),
                                    .GWEN(web0), 
                                    .WEN(~wmask0), 
                                    .A(addr0), 
                                    .D(din0), 
                                    .Q(dout0)
                                );

endmodule 
