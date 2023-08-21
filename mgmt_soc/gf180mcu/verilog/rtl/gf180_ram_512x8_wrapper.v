module gf180_ram_512x8_wrapper (
	CLK,
	CEN,
	GWEN,
	WEN,
	A,
	D,
	Q
);

input           CLK;
input           CEN;    //Chip Enable
input           GWEN;   //Global Write Enable
input   [7:0]  	WEN;    //Write Enable
input   [8:0]   A;
input   [7:0]  	D;
output	[7:0]	Q;

gf180mcu_fd_ip_sram__sram512x8m8wm1 RAM (
    .CLK(CLK), 
    .CEN(CEN), 
    .GWEN(GWEN), 
    .WEN(WEN), 
    .A(A), 
    .D(D), 
    .Q(Q), 
    .VDD(), 
    .VSS());

endmodule