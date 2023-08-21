
`timescale 1ps/1ps
module GF180_RAM_1Kx32 (
	CLK,
	CEN,
	GWEN,
	WEN,
	A,
	D,
	Q,
	VDD,
	VSS
);

input           CLK;
input           CEN;    
input           GWEN;   
input   [3:0]  	WEN;    // Byte WEN
input   [9:0]   A;
input   [31:0] 	D;
output	[31:0]	Q;
inout		    VDD;
inout		    VSS;

wire [31: 0] Q0, Q1;

wire sel_0 = ~ A[9];
wire sel_1 =   A[9];

wire gwen_0 = ~(sel_0 & ~GWEN);
wire gwen_1 = ~(sel_1 & ~GWEN);

wire [7:0] wen_0 = {8{WEN[0]}};
wire [7:0] wen_1 = {8{WEN[1]}};
wire [7:0] wen_2 = {8{WEN[2]}};
wire [7:0] wen_3 = {8{WEN[3]}};



GF180_512x8 RAM00 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_0), .WEN(wen_0), .A(A[8:0]), .D(D[ 7: 0]), .Q(Q0[ 7: 0]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM01 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_0), .WEN(wen_1), .A(A[8:0]), .D(D[15: 8]), .Q(Q0[15: 8]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM02 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_0), .WEN(wen_2), .A(A[8:0]), .D(D[23:16]), .Q(Q0[23:16]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM03 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_0), .WEN(wen_3), .A(A[8:0]), .D(D[31:24]), .Q(Q0[31:24]), .VDD(VDD), .VSS(VSS) );

GF180_512x8 RAM10 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_1), .WEN(wen_0), .A(A[8:0]), .D(D[ 7: 0]), .Q(Q1[ 7: 0]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM11 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_1), .WEN(wen_1), .A(A[8:0]), .D(D[15: 8]), .Q(Q1[15: 8]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM12 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_1), .WEN(wen_2), .A(A[8:0]), .D(D[23:16]), .Q(Q1[23:16]), .VDD(VDD), .VSS(VSS) );
GF180_512x8 RAM13 ( .CLK(CLK), .CEN(CEN), .GWEN(gwen_1), .WEN(wen_3), .A(A[8:0]), .D(D[31:24]), .Q(Q1[31:24]), .VDD(VDD), .VSS(VSS) );

assign Q = A[9] ? Q1 : Q0;

endmodule
