module RAM256 #( parameter COLS=1)
(
`ifdef USE_POWER_PINS
    VPWR,
    VGND,
`endif
    CLK,
    WE0,
    EN0,
    Di0,
    Do0,
    A0
);
    localparam A_WIDTH = 8+$clog2(COLS);

    input   wire            VPWR;
    input   wire            VGND;
    input   wire            CLK;
    input   wire    [3:0]   WE0;
    input   wire            EN0;
    input   wire    [31:0]  Di0;
    output  reg     [31:0]  Do0;
    input   wire    [(A_WIDTH - 1): 0]   A0;

    reg [31:0] RAM[(256*COLS)-1 : 0];

    always @(posedge CLK)
        if(EN0) begin
            Do0 <= RAM[A0];
            if(WE0[0]) RAM[A0][ 7: 0] <= Di0[7:0];
            if(WE0[1]) RAM[A0][15:8] <= Di0[15:8];
            if(WE0[2]) RAM[A0][23:16] <= Di0[23:16];
            if(WE0[3]) RAM[A0][31:24] <= Di0[31:24];
        end
        else
            Do0 <= 32'b0;

endmodule
