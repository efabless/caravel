v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
L 4 3370 -60 3390 -60 {}
L 4 3390 -60 3390 80 {}
L 4 3370 80 3390 80 {}
T {Current step-down mirror} 2270 140 0 0 0.4 0.4 {}
T {Charge accumulator} 2650 140 0 0 0.4 0.4 {}
T {Voltage divider} 1860 140 0 0 0.4 0.4 {}
T {Schmitt trigger} 2930 -200 0 0 0.4 0.4 {}
T {150 / 650 * 3.3V = 0.76V} 1860 180 0 0 0.4 0.4 {}
T {step down 8x} 2130 -430 0 0 0.4 0.4 {}
T {step down 7x} 2330 80 0 0 0.4 0.4 {}
T {step down 7x} 2520 -430 0 0 0.4 0.4 {}
T {1.8V domain outputs} 3400 0 0 0 0.4 0.4 {}
T {3.3V domain output} 3410 -140 0 0 0.4 0.4 {}
T {392 : 1} 2270 180 0 0 0.4 0.4 {}
T {Simple power-on-reset circuit
calibrated to 500us nominal delay
no temperature compensation} 1950 -570 0 0 0.6 0.6 {}
N 2500 -310 2500 -270 { lab=#net1}
N 2500 -210 2500 -100 { lab=#net2}
N 2300 -40 2300 20 { lab=#net3}
N 2300 80 2300 110 { lab=vss}
N 2360 110 2500 110 { lab=vss}
N 2500 80 2500 110 { lab=vss}
N 2400 50 2460 50 { lab=#net3}
N 2360 -400 2500 -400 { lab=vdd3v3}
N 2500 -400 2500 -370 { lab=vdd3v3}
N 2500 -400 2790 -400 { lab=vdd3v3}
N 2300 -10 2370 -10 { lab=#net3}
N 2370 -10 2370 50 { lab=#net3}
N 2500 -290 2570 -290 { lab=#net1}
N 2570 -340 2570 -290 { lab=#net1}
N 2540 -340 2570 -340 { lab=#net1}
N 2500 -190 2570 -190 { lab=#net2}
N 2570 -240 2570 -190 { lab=#net2}
N 2540 -240 2570 -240 { lab=#net2}
N 2240 110 2360 110 { lab=vss}
N 2500 110 2630 110 { lab=vss}
N 2500 50 2630 50 { lab=vss}
N 2110 110 2240 110 { lab=vss}
N 1930 60 1930 110 { lab=vss}
N 1930 -160 1930 0 { lab=#net4}
N 1930 -400 1930 -220 { lab=vdd3v3}
N 2110 -400 2360 -400 { lab=vdd3v3}
N 1880 -190 1910 -190 { lab=vss}
N 1880 -190 1880 110 { lab=vss}
N 1880 110 1930 110 { lab=vss}
N 1880 30 1910 30 { lab=vss}
N 2300 -310 2300 -270 { lab=#net5}
N 2300 -400 2300 -370 { lab=vdd3v3}
N 2300 -140 2300 -100 { lab=#net3}
N 2340 50 2400 50 { lab=#net3}
N 2300 -210 2300 -140 { lab=#net3}
N 2100 80 2100 110 { lab=vss}
N 2100 110 2110 110 { lab=vss}
N 2050 50 2060 50 { lab=#net4}
N 2050 -70 2050 50 { lab=#net4}
N 1930 -70 2050 -70 { lab=#net4}
N 1930 -400 2110 -400 { lab=vdd3v3}
N 2100 -400 2100 -370 { lab=vdd3v3}
N 2100 -310 2100 -270 { lab=#net6}
N 2100 -210 2100 20 { lab=#net7}
N 2100 50 2300 50 { lab=vss}
N 2200 50 2200 110 { lab=vss}
N 2140 -240 2260 -240 { lab=#net7}
N 2140 -340 2260 -340 { lab=#net6}
N 2100 -290 2180 -290 { lab=#net6}
N 2180 -340 2180 -290 { lab=#net6}
N 2100 -180 2180 -180 { lab=#net7}
N 2180 -240 2180 -180 { lab=#net7}
N 1930 -240 2100 -240 { lab=vdd3v3}
N 1930 -340 2100 -340 { lab=vdd3v3}
N 1930 110 2100 110 { lab=vss}
N 2300 -240 2500 -240 { lab=vdd3v3}
N 2300 -340 2500 -340 { lab=vdd3v3}
N 2400 -340 2400 -240 { lab=vdd3v3}
N 2400 -400 2400 -340 { lab=vdd3v3}
N 2570 -240 2650 -240 { lab=#net2}
N 2570 -340 2650 -340 { lab=#net1}
N 2690 -400 2690 -370 { lab=vdd3v3}
N 2790 -400 2790 -340 { lab=vdd3v3}
N 2690 -340 2790 -340 { lab=vdd3v3}
N 2690 -240 2790 -240 { lab=vdd3v3}
N 2790 -340 2790 -240 { lab=vdd3v3}
N 2690 -310 2690 -270 { lab=#net8}
N 2690 -210 2690 -150 { lab=#net9}
N 1830 30 1880 30 { lab=vss}
N 1810 60 1810 110 { lab=vss}
N 1810 110 1880 110 { lab=vss}
N 1810 -70 1810 0 { lab=vss}
N 1810 -70 1880 -70 { lab=vss}
N 2690 -150 2690 -70 { lab=#net9}
N 2820 -130 2820 -70 { lab=#net9}
N 2690 -130 2820 -130 { lab=#net9}
N 2630 110 2820 110 { lab=vss}
N 2820 -10 2820 110 { lab=vss}
N 2690 -10 2690 110 { lab=vss}
N 2820 -130 2980 -130 { lab=#net9}
N 3060 -130 3130 -130 { lab=#net10}
N 3090 -130 3090 60 { lab=#net10}
N 3090 60 3130 60 { lab=#net10}
N 3090 -40 3130 -40 { lab=#net10}
N 3210 -130 3300 -130 { lab=porb_h}
N 3210 -40 3300 -40 { lab=porb_l}
N 3210 60 3300 60 { lab=por_l}
N 2790 -400 2840 -400 { lab=vdd3v3}
N 2820 110 2870 110 { lab=vss}
N 2630 50 2690 50 { lab=vss}
N 2300 -100 2300 -40 { lab=#net3}
N 2500 -100 2500 -30 { lab=#net2}
N 2500 -30 2500 20 { lab=#net2}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2690 -40 0 0 {name=C1 model=cap_mim_m3_1 W=30 L=30 MF=1 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_2.sym} 2820 -40 2 1 {name=C2 model=cap_mim_m3_2 W=30 L=30 MF=1 spiceprefix=X}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2280 -240 0 0 {name=M1
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 2480 50 0 0 {name=M2
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p69.sym} 1930 -190 0 0 {name=R1
L=500
model=res_xhigh_po_0p69
spiceprefix=X
mult=1}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2280 -340 0 0 {name=M4
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 2320 50 0 1 {name=M5
L=0.8
W=14
nf=7
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p69.sym} 1930 30 0 0 {name=R2
L=150
model=res_xhigh_po_0p69
spiceprefix=X
mult=1}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2520 -240 0 1 {name=M7
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2520 -340 0 1 {name=M8
L=0.8
W=14
nf=7
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 2080 50 0 0 {name=M10
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2120 -240 0 1 {name=M9
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2120 -340 0 1 {name=M11
L=0.8
W=16
nf=8
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2670 -340 0 0 {name=M12
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 2670 -240 0 0 {name=M13
L=0.8
W=2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_0p69.sym} 1810 30 0 1 {name=R3
L=25
model=res_xhigh_po_0p69
spiceprefix=X
mult=2}
C {sky130_stdcells/buf_8.sym} 3170 -130 0 0 {name=x2 VGND=vss VNB=vss VPB=vdd3v3 VPWR=vdd3v3 prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/buf_8.sym} 3170 -40 0 0 {name=x3 VGND=vss VNB=vss VPB=vdd1v8 VPWR=vdd1v8 prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/inv_8.sym} 3170 60 0 0 {name=x4 VGND=vss VNB=vss VPB=vdd1v8 VPWR=vdd1v8 prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/buf_1.sym} 3020 -130 0 0 {name=x5 VGND=vss VNB=vss VPB=vdd3v3 VPWR=vdd3v3 prefix=sky130_fd_sc_hvl__schmitt }
C {devices/iopin.sym} 2840 -400 0 0 {name=p1 lab=vdd3v3}
C {devices/iopin.sym} 2870 110 0 0 {name=p2 lab=vss}
C {devices/opin.sym} 3300 -130 0 0 {name=p3 lab=porb_h}
C {devices/opin.sym} 3300 -40 0 0 {name=p4 lab=porb_l}
C {devices/opin.sym} 3300 60 0 0 {name=p5 lab=por_l}
C {devices/iopin.sym} 2840 -330 0 0 {name=p6 lab=vdd1v8}
