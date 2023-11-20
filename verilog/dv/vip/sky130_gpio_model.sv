
module sky130_ef_io__gpiov2_pad_wrapped (IN_H, PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H,
                                 PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H, ENABLE_INP_H, OE_N,
                                 TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR, ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H,
                                 ANALOG_POL, OUT, AMUXBUS_A, AMUXBUS_B
                                 ,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO,
                                 VSSD, VSSIO_Q
                                );
input OUT;
input OE_N;
input HLD_H_N;
input ENABLE_H;
input ENABLE_INP_H;
input ENABLE_VDDA_H;
input ENABLE_VSWITCH_H;
input ENABLE_VDDIO;
input INP_DIS;
input IB_MODE_SEL;
input VTRIP_SEL;
input SLOW;
input HLD_OVR;
input ANALOG_EN;
input ANALOG_SEL;
input ANALOG_POL;
input [2:0] DM;
inout VDDIO;
input VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
input VSSIO_Q;
inout VSSIO;
inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
input AMUXBUS_A;
input AMUXBUS_B;
output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;

// V-erilator support only 2-state so it can't support pullup or pulldown as it Z and x doesn't exists
wire is_pullup = (DM == 3'b010) & ~INP_DIS & ~OE_N & `ifndef VERILATOR (PAD === 1'bz) `else 0 `endif;
wire is_pulldown = (DM == 3'b011) & ~INP_DIS & ~OE_N & `ifndef VERILATOR (PAD === 1'bz) `else 0 `endif;
wire is_pull_dm =  (DM == 3'b010) | (DM == 3'b011);

// Assign PAD value to IN when INP_DIS is not active
assign IN = (is_pullup) ? 1'b1 : (is_pulldown) ? 1'b0 : (~INP_DIS) ? PAD : 1'b0;
assign PAD = (~OE_N & ~is_pull_dm ) ? OUT : 1'bz;
endmodule




module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
                                   AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
                                   DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
                                   ,VCCD, VCCHIB, VDDA, VDDIO,VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
                                 );
output XRES_H_N;
inout AMUXBUS_A;
inout AMUXBUS_B;
input PAD;
input DISABLE_PULLUP_H;
input ENABLE_H;
input EN_VDDIO_SIG_H;
input INP_SEL_H;
input FILT_IN_H;
inout PULLUP_H;
input ENABLE_VDDIO;
input VCCD;
input VCCHIB;
input VDDA;
input VDDIO;
input VDDIO_Q;
input VSSA;
input VSSD;
input VSSIO;
input VSSIO_Q;
input VSWITCH;
inout PAD_A_ESD_H;
output TIE_HI_ESD;
output TIE_LO_ESD;
inout TIE_WEAK_HI_H;
assign XRES_H_N = PAD;
endmodule

module clkbuf (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    assign X = (VPWR & VPB & ~VGND & ~VNB) ? A: 1'bx;

endmodule

module sky130_fd_sc_hd__clkbuf_1 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule

module sky130_fd_sc_hd__clkbuf_2 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule

module sky130_fd_sc_hd__clkbuf_8 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule

module sky130_fd_sc_hd__clkbuf_16 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule

module sky130_fd_sc_hd__buf_8 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule

module sky130_fd_sc_hd__buf_16 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    clkbuf buf0(X,A,VPWR,VGND,VPB,VNB);
endmodule
module sky130_fd_sc_hd__einvp_1 (
    Z   ,
    A   ,
    TE  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Z   ;
    input  A   ;
    input  TE  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    wire A_buf;
    wire TE_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufTE(TE_buf,TE_buf,VPWR,VGND,VPB,VNB);

    assign Z = (TE_buf) ? ~A_buf : 1'bz;
endmodule

module sky130_fd_sc_hd__einvp_2 (
    Z   ,
    A   ,
    TE  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Z   ;
    input  A   ;
    input  TE  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    wire A_buf;
    wire TE_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufTE(TE_buf,TE_buf,VPWR,VGND,VPB,VNB);

    assign Z = (TE_buf) ? ~A_buf : 1'bz;
endmodule

module sky130_fd_sc_hd__einvn_4 (
    Z   ,
    A   ,
    TE_B,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Z   ;
    input  A   ;
    input  TE_B;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    wire TE_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufTE(TE_buf,TE_B,VPWR,VGND,VPB,VNB);
    assign Z = (~TE_buf) ? ~A_buf : 1'bz;
endmodule

module sky130_fd_sc_hd__einvn_8 (
    Z   ,
    A   ,
    TE_B,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Z   ;
    input  A   ;
    input  TE_B;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    wire TE_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufTE(TE_buf,TE_B,VPWR,VGND,VPB,VNB);
    assign Z = (~TE_buf) ? ~A_buf : 1'bz;
endmodule

module sky130_fd_sc_hd__inv_2 (
    Y   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    assign Y = ~A_buf;

endmodule

module sky130_fd_sc_hd__inv_8 (
    Y   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    assign Y = ~A_buf;

endmodule

module sky130_fd_sc_hd__clkinv_1 (
    Y   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    wire A_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    assign Y = ~A_buf;

endmodule

module sky130_fd_sc_hd__or2_2 (
    X   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    wire A_buf;
    wire B_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufB(B_buf,B,VPWR,VGND,VPB,VNB);
    assign X = (A_buf) | (B_buf);
endmodule

module sky130_fd_sc_hd__nor2_2 (
    Y   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    wire A_buf;
    wire B_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufB(B_buf,B,VPWR,VGND,VPB,VNB);
    assign Y = ~((A_buf) | (B_buf));
endmodule

module sky130_fd_sc_hd__nand2_4 (
    Y   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    wire B_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufB(B_buf,B,VPWR,VGND,VPB,VNB);
    assign Y = ~(A_buf & B_buf);
endmodule

module sky130_fd_sc_hd__nand2_2 (
    Y   ,
    A   ,
    B   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    wire B_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufB(B_buf,B,VPWR,VGND,VPB,VNB);
    assign Y = ~(A_buf & B_buf);
endmodule

module sky130_fd_sc_hd__conb_1 (
    HI  ,
    LO  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output HI  ;
    output LO  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    
    wire HI_buff;
    wire LO_buff;
    clkbuf bufHI(HI_buff,1,VPWR,VGND,VPB,VNB);
    clkbuf bufLO(LO_buff,0,VPWR,VGND,VPB,VNB);
    assign HI = HI_buff;
    assign LO = LO_buff;

endmodule
module sky130_fd_sc_hvl__conb_1 (
    HI  ,
    LO  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output HI  ;
    output LO  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire HI_buff;
    wire LO_buff;
    clkbuf bufHI(HI_buff,1,VPWR,VGND,VPB,VNB);
    clkbuf bufLO(LO_buff,0,VPWR,VGND,VPB,VNB);
    assign HI = HI_buff;
    assign LO = LO_buff;

endmodule

module sky130_fd_sc_hvl__lsbufhv2lv_1 (
    X    ,
    A    ,
    VPWR ,
    VGND ,
    LVPWR,
    VPB  ,
    VNB
);

    output X    ;
    input  A    ;
    input  VPWR ;
    input  VGND ;
    input  LVPWR;
    input  VPB  ;
    input  VNB  ;
    wire A_buf;
    wire A_buf2;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    clkbuf bufA2(A_buf2,A_buf,LVPWR,VGND,VPB,VNB);
    assign X = A_buf2;

endmodule

module sky130_ef_io__vddio_hvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VDDIO_PAD, VCCD,
	VSSIO, VSSD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    output VDDIO;
    inout VDDIO_PAD;
    output VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    inout VSSIO_Q;
    inout VSSIO;
    assign VDDIO = VDDIO_PAD;
    assign VDDIO_Q = VDDIO;
endmodule


module sky130_ef_io__vdda_hvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VDDA_PAD, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    output VDDA;
    inout VDDA_PAD;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    inout VSSIO_Q;
    inout VSSIO;

    assign VDDA = VDDA_PAD;
endmodule


module sky130_ef_io__vccd_lvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VCCD_PAD,
	VSSIO, VSSD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    output VCCD;
    input VCCD_PAD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    inout VSSIO_Q;
    inout VSSIO;

    assign VCCD = VCCD_PAD;
endmodule


module sky130_ef_io__vssio_hvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSIO_PAD, VSSD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    output VSSIO_Q;
    output VSSIO;
    inout VSSIO_PAD;

    assign VSSIO = VSSIO_PAD;
    assign VSSIO_Q = VSSIO;
endmodule


module sky130_ef_io__vssa_hvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VSSA_PAD, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    output VSSA;
    inout VSSA_PAD;
    inout VSSD;
    inout VSSIO_Q;
    inout VSSIO;

    assign VSSA = VSSA_PAD;
endmodule


module sky130_ef_io__vssd_lvc_clamped_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSD, VSSD_PAD, VSSIO_Q
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    output VSSD;
    inout VSSD_PAD;
    inout VSSIO_Q;
    inout VSSIO;

    assign VSSD = VSSD_PAD;

endmodule


module sky130_ef_io__vccd_lvc_clamped3_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VCCD_PAD,
	VSSIO, VSSD, VSSIO_Q, VCCD1, VSSD1
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VCCD_PAD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    inout VSSIO_Q;
    inout VSSIO;
    output VCCD1;
    inout VSSD1;
    assign VCCD1 = VCCD_PAD;

endmodule


module sky130_ef_io__vssd_lvc_clamped3_pad (AMUXBUS_A, AMUXBUS_B,
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSD, VSSD_PAD, VSSIO_Q, VCCD1, VSSD1
);
    inout AMUXBUS_A;
    inout AMUXBUS_B;

    inout VDDIO;	
    inout VDDIO_Q;	
    inout VDDA;
    inout VCCD;
    inout VSWITCH;
    inout VCCHIB;
    inout VSSA;
    inout VSSD;
    inout VSSD_PAD;
    inout VSSIO_Q;
    inout VSSIO;
    inout VCCD1;
    output VSSD1;

    assign VSSD1 = VSSD_PAD;
endmodule

module sky130_ef_io__corner_pad (AMUXBUS_A, AMUXBUS_B, 
	VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
	VSSIO, VSSD, VSSIO_Q
);
  inout AMUXBUS_A;
  inout AMUXBUS_B;

  inout VDDIO;	
  inout VDDIO_Q;	
  inout VDDA;
  inout VCCD;
  inout VSWITCH;
  inout VCCHIB;
  inout VSSA;
  inout VSSD;
  inout VSSIO_Q;
  inout VSSIO;

endmodule

module sky130_fd_sc_hd__macro_sparecell (
    LO  ,
    VGND,
    VNB ,
    VPB ,
    VPWR
);

    // Module ports
    output LO  ;
    input  VGND;
    input  VNB ;
    input  VPB ;
    input  VPWR;
    // spare cells can be empty for simulation
endmodule

module sky130_fd_sc_hd__mux2_2 (
    X   ,
    A0  ,
    A1  ,
    S   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A0  ;
    input  A1  ;
    input  S   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A0_buf;
    wire A1_buf; 
    wire S_buf;
    clkbuf bufA0(A0_buf,A0,VPWR,VGND,VPB,VNB);
    clkbuf bufA1(A1_buf,A1,VPWR,VGND,VPB,VNB);
    clkbuf bufS(S_buf,S,VPWR,VGND,VPB,VNB);
    assign X = S_buf ? A1:A0;

endmodule

module sky130_fd_sc_hd__dfbbp_1 (
    Q      ,
    Q_N    ,
    D      ,
    CLK    ,
    SET_B  ,
    RESET_B,
    VPWR   ,
    VGND   ,
    VPB    ,
    VNB
);

    output Q      ;
    output Q_N    ;
    input  D      ;
    input  CLK    ;
    input  SET_B  ;
    input  RESET_B;
    input  VPWR   ;
    input  VGND   ;
    input  VPB    ;
    input  VNB    ;
    reg out_buff; 
    always @(posedge CLK, negedge SET_B or negedge RESET_B) begin
        if (~SET_B)        // Set input has higher priority
            out_buff <= 1'b1;
        else if (~RESET_B)   // Reset input
            out_buff <= 1'b0;
        else           // Data input
            out_buff <= D;
    end
    clkbuf bufQ(Q,out_buff,VPWR,VGND,VPB,VNB);
    clkbuf bufQ_N(Q_N,~out_buff,VPWR,VGND,VPB,VNB);


endmodule

module sky130_fd_sc_hd__tapvpwrvgnd_1 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;

endmodule

module sky130_fd_sc_hd__diode_2 (
    DIODE,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    input DIODE;
    input VPWR ;
    input VGND ;
    input VPB  ;
    input VNB  ;

endmodule

module sky130_ef_sc_hd__decap_12 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;

endmodule

module sky130_fd_sc_hvl__schmittbuf_1 (
    X   ,
    A   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    wire A_buf;
    clkbuf bufA(A_buf,A,VPWR,VGND,VPB,VNB);
    assign X = A_buf;

endmodule

module sky130_fd_sc_hd__dlclkp_4 (
    GCLK,
    GATE,
    CLK ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output GCLK;
    input  GATE;
    input  CLK ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    assign GCLK = !GATE ? CLK: 1'b0;
endmodule

module sky130_ef_io__gpiov2_pad (IN_H, PAD_A_NOESD_H, PAD_A_ESD_0_H, PAD_A_ESD_1_H,
    PAD, DM, HLD_H_N, IN, INP_DIS, IB_MODE_SEL, ENABLE_H, ENABLE_VDDA_H,
    ENABLE_INP_H, OE_N, TIE_HI_ESD, TIE_LO_ESD, SLOW, VTRIP_SEL, HLD_OVR,
    ANALOG_EN, ANALOG_SEL, ENABLE_VDDIO, ENABLE_VSWITCH_H, ANALOG_POL, OUT,
    AMUXBUS_A, AMUXBUS_B, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD,
    VSSIO, VSSD, VSSIO_Q 
    );

input OUT;  		
input OE_N;  		
input HLD_H_N;		
input ENABLE_H;
input ENABLE_INP_H;	
input ENABLE_VDDA_H;	
input ENABLE_VSWITCH_H;	
input ENABLE_VDDIO;	
input INP_DIS;		
input IB_MODE_SEL;
input VTRIP_SEL;	
input SLOW;		
input HLD_OVR;		
input ANALOG_EN;	
input ANALOG_SEL;	
input ANALOG_POL;	
input [2:0] DM;		

inout VDDIO;	
inout VDDIO_Q;	
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;

inout PAD;
inout PAD_A_NOESD_H,PAD_A_ESD_0_H,PAD_A_ESD_1_H;
inout AMUXBUS_A;
inout AMUXBUS_B;

output IN;
output IN_H;
output TIE_HI_ESD, TIE_LO_ESD;
// V-erilator support only 2-state so it can't support pullup or pulldown as it Z and x doesn't exists
wire is_pullup = (DM == 3'b010) & ~INP_DIS & ~OE_N & `ifndef VERILATOR (PAD === 1'bz) `else 0 `endif;
wire is_pulldown = (DM == 3'b011) & ~INP_DIS & ~OE_N & `ifndef VERILATOR (PAD === 1'bz) `else 0 `endif;
wire is_pull_dm =  (DM == 3'b010) | (DM == 3'b011);

// Assign PAD value to IN when INP_DIS is not active
assign IN = (is_pullup) ? 1'b1 : (is_pulldown) ? 1'b0 : (~INP_DIS) ? PAD : 1'b0;
assign PAD = (~OE_N & ~is_pull_dm ) ? OUT : 1'bz;
endmodule

module sky130_ef_io__analog_pad (AMUXBUS_A, AMUXBUS_B, P_PAD, P_CORE
                                 ,VCCD, VCCHIB, VDDA, VDDIO, VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
                                );
inout AMUXBUS_A;
inout AMUXBUS_B;
inout P_PAD;
inout P_CORE;
inout VCCD;
inout VCCHIB;
inout VDDA;
inout VDDIO;
inout VDDIO_Q;
inout VSSA;
inout VSSD;
inout VSSIO;
inout VSSIO_Q;
inout VSWITCH;
wire pwr_good = VDDIO===1 && VSSIO===0;
wire pad_sw = pwr_good===1 ? 1'b1 : 1'bx;
assign P_PAD = P_CORE;
endmodule


module sky130_ef_io__top_power_hvc (AMUXBUS_A, AMUXBUS_B, DRN_HVC,
	P_CORE, P_PAD, SRC_BDY_HVC, VSSA, VDDA, VSWITCH, VDDIO_Q,
	VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
);
  inout AMUXBUS_A;
  inout AMUXBUS_B;

  inout DRN_HVC;
  inout P_CORE;
  inout P_PAD;
  inout SRC_BDY_HVC;
  inout VDDIO;	
  inout VDDIO_Q;
  inout VDDA;
  inout VCCD;
  inout VSWITCH;
  inout VCCHIB;
  inout VSSA;
  inout VSSD;
  inout VSSIO_Q;
  inout VSSIO;

assign P_CORE = P_PAD;
endmodule

module sky130_fd_sc_hd__fill_1 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;
endmodule

module sky130_fd_sc_hd__fill_2 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;
endmodule

module sky130_fd_sc_hd__decap_6 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;


endmodule
module sky130_fd_sc_hd__decap_12 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;


endmodule
module sky130_fd_sc_hd__decap_6 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;


endmodule
module sky130_fd_sc_hd__decap_4 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;


endmodule
module sky130_fd_sc_hd__decap_3 (
    VPWR,
    VGND,
    VPB ,
    VNB
);

    input VPWR;
    input VGND;
    input VPB ;
    input VNB ;


endmodule
