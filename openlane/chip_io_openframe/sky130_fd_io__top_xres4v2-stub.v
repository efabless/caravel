module sky130_fd_io__top_xres4v2 ( TIE_WEAK_HI_H,  XRES_H_N, TIE_HI_ESD, TIE_LO_ESD,
    AMUXBUS_A, AMUXBUS_B, PAD, PAD_A_ESD_H, ENABLE_H, EN_VDDIO_SIG_H, INP_SEL_H, FILT_IN_H,
    DISABLE_PULLUP_H, PULLUP_H, ENABLE_VDDIO
    ,VCCD, VCCHIB, VDDA, VDDIO,VDDIO_Q, VSSA, VSSD, VSSIO, VSSIO_Q, VSWITCH
     );
    output XRES_H_N;
    inout AMUXBUS_A;
    inout AMUXBUS_B;
    inout PAD;
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
endmodule

