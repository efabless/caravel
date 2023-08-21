module \$_ALDFF_PN_ (D, C, L, AD, Q);
input D, C, L, AD;
output reg Q;

wire RN, SN;
wire L_N;

\$_OR_ R_NAND ( .Y(RN), .A(L), .B(AD) );
\$_NOT_ NAND_NOT ( .A(L), .Y(L_N));
\$_NAND_ S_NAND ( .Y(SN), .A(L_N), .B(AD) );

\$_DFFSR_PNN_ SRFF (.C(C), 
    .S(SN), 
    .R(RN), 
    .D(D), 
    .Q(Q)
);

endmodule

module \$_MUX_ (
    output Y,
    input A,
    input B,
    input S
    );
  sky130_fd_sc_hd__mux2_2 _TECHMAP_MUX (
      .X(Y),
      .A0(A),
      .A1(B),
      .S(S)
  );
endmodule