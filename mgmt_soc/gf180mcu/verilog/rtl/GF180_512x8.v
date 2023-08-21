/*
 * $Id: $
 * Copyright (c) 2014 GLOBALFOUNDRIES All Rights Reserved.
 *
 * CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA of US DESIGN ENGINEERING
 * Division, GLOBALFOUNDRIES.
 *
 * This file has been provided pursuant to a License Agreecent containing
 * restrictions on its use.  This file contains valuable trade secrets and
 * proprietary information of GLOBALFOUNDRIES, and is protected by
 * U.S. and international laws and/or treaties.
 *
 * The copyright notice(s) in this file does not indicate actual or intended
 * publication of this file.
 *
 * Project:             018 5VGREEN SRAM 
 * Author:              Silfey Ching
 * Data Created:        05-06-2014
 * Revision:		0.0	
 *
 * Description:         gf180mcu_fd_ip_sram__sram512x8m8wm1 Simulation Model
 */

`timescale 1 ps / 1 ps

module GF180_512x8 (
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
input           CEN;    //Chip Enable
input           GWEN;   //Global Write Enable
input   [7:0]  	WEN;    //Write Enable
input   [8:0]   A;
input   [7:0]  	D;
output	[7:0]	Q;
inout		VDD;
inout		VSS;

reg	[7:0]	mem[511:0];
reg	[7:0]	qo_reg;

wire		cen_flag;
wire		write_flag;
wire		read_flag;

reg             ntf_Tcyc;	//notifier for clock period/low/high pulse
reg             ntf_Tckh;
reg             ntf_Tckl;

reg		ntf_tcs;	//notifier for setup time
reg		ntf_tas;
reg		ntf_tds;
reg		ntf_tws;
reg		ntf_twis;

reg             ntf_tch;	//notifier for hold time
reg             ntf_tah;
reg             ntf_tdh;
reg             ntf_twh;
reg             ntf_twih;

wire		no_st_viol;	//no setup violation
wire		no_hd_viol;	//no hold violation
wire		no_ck_viol;	//no clock related violation

reg             clk_dly;        //for read/write
reg             write_flag_dly; //for write invalidation
reg             read_flag_dly;  //for read invalidation
reg             cen_dly;
reg             cen_fell;       //detect CEN 1 -> 0 transition
reg             cen_not_rst;    //detect CEN is not reset initially

wire    [7:0]  we;       	//inversion of WEN
wire    [7:0]  cd2;
wire    [7:0]  cd4;
wire    [7:0]  cd5;
reg    	[7:0]  cdx;

reg	[8:0]	marked_a;

integer         i;

assign Q = qo_reg;

//---- for debugging
wire    [7:0]  mem_0;
wire	[7:0]  mem_1;
wire	[7:0]  mem_2;
wire	[7:0]  mem_3;
assign mem_0 = mem[0];
assign mem_1 = mem[1];
assign mem_2 = mem[2];
assign mem_3 = mem[3];

always @(CEN) cen_dly = #100 CEN;
always @(CEN or cen_dly) begin
  if (!CEN & cen_dly) cen_fell = 1'b1;
end

always @(posedge CLK) begin
  if (!CEN & !cen_fell & !cen_not_rst) cen_not_rst = 1;
end

always @(posedge cen_not_rst) begin
  $display("-------- WARNING: CEN is not reset, memory is not operational ---------");
  $display("-------- @Time %0t: scope = %m", $realtime, " ---------");
end

always @(posedge cen_fell) begin
  $display("-------- MESSAGE: CEN is just reset, memory is operational ---------");
  $display("-------- @Time %0t: scope = %m", $realtime, " ---------");
end

assign cen_flag   =  cen_fell & !CEN;
assign write_flag =  cen_fell & !CEN & !GWEN & !(&WEN);
assign read_flag  =  cen_fell & !CEN &  GWEN;

reg cen_flag_dly;
always @(cen_flag) cen_flag_dly = #100 cen_flag;

specify
  specparam Tcyc = 55600 : 55600 : 55600;
  specparam Tckh = 25000 : 25000 : 25000;
  specparam Tckl = 25000 : 25000 : 25000;

  specparam tcs  = 5000 : 5000 : 5000;
  specparam tas  = 5000 : 5000 : 5000;
  specparam tds  = 5000 : 5000 : 5000;
  specparam tws  = 5000 : 5000 : 5000;
  specparam twis = 5000 : 5000 : 5000;

  specparam tch  = 10000 : 10000 : 10000;
  specparam tah  = 10000 : 10000 : 10000;
  specparam tdh  = 10000 : 10000 : 10000;
  specparam twh  = 10000 : 10000 : 10000;
  specparam twih = 10000 : 10000 : 10000;

  specparam ta   = 45000 : 45000 : 45000;

  specparam Tdly  = 100 : 100: 100;

//---- CLK period/pulse timing
  $period (negedge CLK, Tcyc, ntf_Tcyc);
  $width  (posedge CLK, Tckh, 0, ntf_Tckh);
  $width  (negedge CLK, Tckl, 0, ntf_Tckl);

//---- CEN setup/hold timing
  $setup (negedge CEN, posedge CLK &&& cen_flag, tcs, ntf_tcs);
  $setup (posedge CEN, posedge CLK &&& cen_flag, tcs, ntf_tcs);

  $hold  (posedge CLK &&& cen_flag_dly, posedge CEN, tch, ntf_tch);
  $hold  (posedge CLK &&& cen_flag,     negedge CEN, tch, ntf_tch);

//---- GWEN setup/hold timing
  $setup (negedge GWEN,  posedge CLK &&& cen_flag, tws, ntf_tws);
  $setup (posedge GWEN,  posedge CLK &&& cen_flag, tws, ntf_tws);

  $hold  (posedge CLK &&& cen_flag, posedge GWEN, twh, ntf_twh);
  $hold  (posedge CLK &&& cen_flag, negedge GWEN, twh, ntf_twh);

//---- WEN[7:0] setup/hold timing
  $setup (negedge WEN[0],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[1],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[2],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[3],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[4],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[5],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[6],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (negedge WEN[7],  posedge CLK &&& write_flag, twis, ntf_twis);

  $setup (posedge WEN[0],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[1],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[2],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[3],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[4],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[5],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[6],  posedge CLK &&& write_flag, twis, ntf_twis);
  $setup (posedge WEN[7],  posedge CLK &&& write_flag, twis, ntf_twis);

  $hold  (posedge CLK &&& write_flag, posedge WEN[0],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[1],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[2],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[3],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[4],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[5],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[6],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, posedge WEN[7],  twih, ntf_twih);

  $hold  (posedge CLK &&& write_flag, negedge WEN[0],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[1],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[2],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[3],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[4],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[5],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[6],  twih, ntf_twih);
  $hold  (posedge CLK &&& write_flag, negedge WEN[7],  twih, ntf_twih);

//---- A[8:0] setup/hold timing
  $setup (posedge A[0],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[1],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[2],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[3],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[4],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[5],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[6],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[7],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (posedge A[8],  posedge CLK &&& cen_flag, tas, ntf_tas);

  $setup (negedge A[0],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[1],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[2],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[3],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[4],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[5],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[6],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[7],  posedge CLK &&& cen_flag, tas, ntf_tas);
  $setup (negedge A[8],  posedge CLK &&& cen_flag, tas, ntf_tas);

  $hold  (posedge CLK &&& cen_flag, negedge A[0],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[1],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[2],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[3],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[4],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[5],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[6],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[7],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, negedge A[8],  tah, ntf_tah);

  $hold  (posedge CLK &&& cen_flag, posedge A[0],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[1],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[2],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[3],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[4],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[5],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[6],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[7],  tah, ntf_tah);
  $hold  (posedge CLK &&& cen_flag, posedge A[8],  tah, ntf_tah);

//---- D[7:0] setup/hold timing
  $setup (posedge D[0],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[1],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[2],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[3],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[4],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[5],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[6],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (posedge D[7],  posedge CLK &&& write_flag, tds, ntf_tds);

  $setup (negedge D[0],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[1],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[2],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[3],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[4],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[5],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[6],  posedge CLK &&& write_flag, tds, ntf_tds);
  $setup (negedge D[7],  posedge CLK &&& write_flag, tds, ntf_tds);

  $hold  (posedge CLK &&& write_flag, negedge D[0],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[1],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[2],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[3],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[4],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[5],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[6],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, negedge D[7],  tdh, ntf_tdh);

  $hold  (posedge CLK &&& write_flag, posedge D[0],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[1],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[2],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[3],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[4],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[5],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[6],  tdh, ntf_tdh);
  $hold  (posedge CLK &&& write_flag, posedge D[7],  tdh, ntf_tdh);

//---- Output delay
// rise transition:     0->1, z->1, Ta
// fall transition:     1->0, 1->z, Ta
// turn-off transition: 0->z, 1->z, Tcqx
//if (!CEN & GWEN) (posedge CLK => (Q : 8'bx)) = (Ta, Ta, Tcqx);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[0]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[1]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[2]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[3]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[4]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[5]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[6]  : 1'bx)) = (ta, ta);
if ((CEN == 1'b0) && (GWEN == 1'b1)) (posedge CLK => (Q[7]  : 1'bx)) = (ta, ta);
endspecify

assign no_st_viol = ~(|{ntf_tcs, ntf_tas, ntf_tds, ntf_tws, ntf_twis});
assign no_hd_viol = ~(|{ntf_tch, ntf_tah, ntf_tdh, ntf_twh, ntf_twih});
assign no_ck_viol = ~(|{ntf_Tcyc, ntf_Tckh, ntf_Tckl});

always @(CLK) clk_dly        = #Tdly CLK;
always @(CLK) write_flag_dly = #200 write_flag;
always @(CLK) read_flag_dly  = #200 read_flag;

always @(posedge CLK) marked_a = A;

assign we  = ~WEN;
assign cd2 = mem[A] & WEN;	//set write bits to 0, others unchanged
assign cd4 = D & we;		//set write bits to 0/1, others = 0
assign cd5 = cd2 | cd4;		//memory content after write

always @(posedge CLK) cdx = {8{1'bx}} & we;    //latch cdx

always @(posedge clk_dly) begin
  if (write_flag) begin 	//write
    if (no_st_viol) begin 	//write, no viol
      mem[A] = cd5;
    end
    else begin                 	//write, with viol
      mem[A] = mem[A] ^ cdx;    //1^x = x
      qo_reg = qo_reg ^ cdx;
    end
  end //write
  else if (read_flag) begin     //read
    if (no_st_viol) begin 	//read, no viol
      qo_reg = mem[marked_a];
    end
    else begin                  //read, with viol
      qo_reg = 8'bx;
    end
  end //read
end 

always @(negedge clk_dly) begin         	//invalidate write/read when hold/clk viol
  if (no_hd_viol == 0 | no_ck_viol == 0) begin
    if (write_flag_dly) begin 
      if (ntf_twh) begin
        mem[marked_a] = mem[marked_a] ^ 8'bx; //GWEN can't be used to generate cdx
        qo_reg        = qo_reg ^ 8'bx;
      end
      else begin
        mem[marked_a] = mem[marked_a] ^ cdx;
        qo_reg        = qo_reg ^ cdx;
      end
    end
    else if (read_flag_dly) begin
      qo_reg = 8'bx;
    end

    #100;
    ntf_tch  = 0;
    ntf_tah  = 0;
    ntf_tdh  = 0;
    ntf_twh  = 0;
    ntf_twih = 0;

    ntf_Tcyc  = 0;
    ntf_Tckh  = 0;
    ntf_Tckl  = 0;
  end
  else begin
    #100;
    ntf_tch  = 0;
    ntf_tah  = 0;
    ntf_tdh  = 0;
    ntf_twh  = 0;
    ntf_twih = 0;

    ntf_Tcyc  = 0;
    ntf_Tckh  = 0; 
    ntf_Tckl  = 0; 
  end
end

always @(posedge ntf_tcs or posedge ntf_tas or posedge ntf_tds or
         posedge ntf_tws or posedge ntf_twis or
         posedge ntf_tch or posedge ntf_tah or posedge ntf_tdh or
         posedge ntf_twh or posedge ntf_twih or
         posedge ntf_Tcyc or posedge ntf_Tckh or posedge ntf_Tckl) begin
  if (cen_fell) begin
    #Tdly;
    if (ntf_tcs)  $display("---- ERROR: CEN setup violation! ----");
    if (ntf_tas)  $display("---- ERROR: A setup violation! ----");
    if (ntf_tds)  $display("---- ERROR: D setup violation! ----");
    if (ntf_tws)  $display("---- ERROR: GWEN setup violation! ----");
    if (ntf_twis) $display("---- ERROR: WEN setup violation! ----");

    if (ntf_tch)  $display("---- ERROR: CEN hold violation! ----");
    if (ntf_tah)  $display("---- ERROR: A hold violation! ----");
    if (ntf_tdh)  $display("---- ERROR: D hold violation! ----");
    if (ntf_twh)  $display("---- ERROR: GWEN hold violation! ----");
    if (ntf_twih) $display("---- ERROR: WEN hold violation! ----");

    if (ntf_Tcyc) $display("---- ERROR: CLK period violation! ----");
    if (ntf_Tckh) $display("---- ERROR: CLK pulse width high violation! ----");
    if (ntf_Tckl) $display("---- ERROR: CLK pulse width low violation! ----");
  end
end

always @(posedge cen_fell) begin	//reset fasle notifiers
  ntf_tcs  = 0;				//after CEN reset (CEN from 1 to 0)
  ntf_tas  = 0;
  ntf_tds  = 0;
  ntf_tws  = 0;
  ntf_twis = 0;

  ntf_tch  = 0;
  ntf_tah  = 0;
  ntf_tdh  = 0;
  ntf_twh  = 0;
  ntf_twih = 0;
end

always @(negedge clk_dly) begin	//reset setup/hold notifiers
  #100;
  ntf_tcs  = 0;
  ntf_tas  = 0;
  ntf_tds  = 0;
  ntf_tws  = 0;
  ntf_twis = 0;

  ntf_tch  = 0;
  ntf_tah  = 0;
  ntf_tdh  = 0;
  ntf_twh  = 0;
  ntf_twih = 0;
end

initial begin			//initialization
  ntf_Tcyc  = 0;
  ntf_Tckh  = 0;
  ntf_Tckl  = 0;

  ntf_tcs  = 0;
  ntf_tas  = 0;
  ntf_tds  = 0;
  ntf_tws  = 0;
  ntf_twis = 0;

  ntf_tch  = 0;
  ntf_tah  = 0;
  ntf_tdh  = 0;
  ntf_twh  = 0;
  ntf_twih = 0;
 
  marked_a = 9'd0;

  qo_reg         = 8'd0;
  clk_dly        = 0;
  write_flag_dly = 0;
  read_flag_dly  = 0;
  cen_dly        = 0;
  cen_fell       = 0;
  cen_not_rst    = 0;

  for(i=0; i<512; i=i+1) begin
    mem[i] = 8'd0;
  end
end

endmodule
