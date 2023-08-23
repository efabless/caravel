from migen import *
from litex.soc.interconnect import wishbone

kB = 1024


class GF180_RAM(Module):
    def __init__(self, rstn, width=32, size=2 * kB):
        self.bus = wishbone.Interface(width)

        # # #
        assert width in [32]
        assert size in [2 * kB]
        depth_cascading = size // (2 * kB)
        width_cascading = 1

        # Combine RAMs to increase Depth.
        # for d in range(depth_cascading):
        #     # Combine RAMs to increase Width.
        #     for w in range(width_cascading):
        datain = Signal(32)
        dataout = Signal(32)
        maskwren = Signal(4)
        wren_b = Signal()
        cs_b = Signal()

        # ro port signals
        self.clk1 = Signal()
        self.cs_b1 = Signal()
        self.adr1 = Signal(9)
        self.dataout1 = Signal(32)

        self.comb += [
            datain.eq(self.bus.dat_w[0:32]),
            # If(self.bus.adr[9:8+log2_int(depth_cascading)+1] == d,
            wren_b.eq(~(self.bus.we & self.bus.stb & self.bus.cyc)),
            self.bus.dat_r[0:32].eq(dataout),
            cs_b.eq(~rstn),  # rstn is normally high -> cs_b low
            # ),
            # maskwren is nibble based
            maskwren[0].eq(self.bus.sel[0]),
            maskwren[1].eq(self.bus.sel[1]),
            maskwren[2].eq(self.bus.sel[2]),
            maskwren[3].eq(self.bus.sel[3]),
        ]
        self.specials += Instance("sram",
                                  i_clk0=ClockSignal("sys"),
                                  i_addr0=self.bus.adr[:10],
                                  i_din0=datain,
                                  i_wmask0=maskwren,
                                  i_web0=wren_b,
                                  i_csb0=cs_b,
                                  o_dout0=dataout,

                                  # ro port
                                  i_clk1=self.clk1,
                                  i_addr1=self.adr1,
                                  i_csb1=self.cs_b1,
                                  o_dout1=self.dataout1
                                  )

        self.sync += self.bus.ack.eq(self.bus.stb & self.bus.cyc & ~self.bus.ack)


class OpenRAM(Module):
    def __init__(self, width=32, size=1*kB):
        self.bus = wishbone.Interface(width)

        # # #
        assert width in [32]
        assert size in [2*kB]
        depth_cascading = size//(2*kB)
        width_cascading = 1
        
        # Combine RAMs to increase Depth.
        # for d in range(depth_cascading):
        #     # Combine RAMs to increase Width.
        #     for w in range(width_cascading):
        datain   = Signal(32)
        dataout  = Signal(32)
        maskwren = Signal(4)
        wren_b   = Signal()
        cs_b     = Signal()

        # ro port signals
        self.clk1     = Signal()
        self.cs_b1    = Signal()
        self.adr1     = Signal(9)
        self.dataout1 = Signal(32)

        self.comb += [
            datain.eq(self.bus.dat_w[0:32]),
            # If(self.bus.adr[9:8+log2_int(depth_cascading)+1] == d,
            wren_b.eq(~(self.bus.we & self.bus.stb & self.bus.cyc)),
            self.bus.dat_r[0:32].eq(dataout),
            cs_b.eq(0),
            # ),
            # maskwren is nibble based
            maskwren[0].eq(self.bus.sel[0]),
            maskwren[1].eq(self.bus.sel[1]),
            maskwren[2].eq(self.bus.sel[2]),
            maskwren[3].eq(self.bus.sel[3]),
        ]
        # self.specials += Instance("sram_1rw1r_32_256_8_sky130",
        self.specials += Instance("sky130_sram_2kbyte_1rw1r_32x512_8",
            i_clk0      = ClockSignal("sys"),
            #i_STANDBY    = 0b0,
            #i_SLEEP      = 0b0,
            #i_POWEROFF   = 0b1,
            i_addr0   = self.bus.adr[:9],
            i_din0    = datain,
            i_wmask0  = maskwren,
            i_web0    = wren_b,
            i_csb0    = cs_b,
            o_dout0   = dataout,

            # ro port
            i_clk1    = self.clk1,
            i_addr1   = self.adr1,
            i_csb1    = self.cs_b1,
            o_dout1   = self.dataout1
        )

        self.sync += self.bus.ack.eq(self.bus.stb & self.bus.cyc & ~self.bus.ack)


class DFFRAM(Module):
    def __init__(self, width=32, size=1*kB):
        self.bus = wishbone.Interface(width)

        # # #
        assert width in [32]
        assert size in [1*kB]

        self.di   = Signal(32)
        self.do  = Signal(32)
        self.we   = Signal(4)
        self.en     = Signal()

        self.comb += [
            self.di.eq(self.bus.dat_w[0:32]),
            # self.we.eq((self.bus.we & self.bus.stb & self.bus.cyc)),
            self.we[0].eq(self.bus.sel[0] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[1].eq(self.bus.sel[1] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[2].eq(self.bus.sel[2] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[3].eq(self.bus.sel[3] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.bus.dat_r[0:32].eq(self.do),
            self.en.eq(self.bus.stb & self.bus.cyc),
        ]

        self.specials += Instance("RAM256",
                                  i_CLK=ClockSignal("sys"),
                                  i_A0=self.bus.adr[:8],
                                  i_Di0=self.di,
                                  i_WE0=self.we,
                                  i_EN0=self.en,
                                  o_Do0=self.do
        )

        self.sync += self.bus.ack.eq(self.bus.stb & self.bus.cyc & ~self.bus.ack)


class DFFRAM_512(Module):
    def __init__(self, width=32, size=512):
        self.bus = wishbone.Interface(width)

        # # #
        #assert width in [32]
        #assert size in [1*kB]

        self.di   = Signal(32)
        self.do  = Signal(32)
        self.we   = Signal(4)
        self.en     = Signal()

        self.comb += [
            self.di.eq(self.bus.dat_w[0:32]),
            # self.we.eq((self.bus.we & self.bus.stb & self.bus.cyc)),
            self.we[0].eq(self.bus.sel[0] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[1].eq(self.bus.sel[1] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[2].eq(self.bus.sel[2] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.we[3].eq(self.bus.sel[3] & self.bus.we & self.bus.stb & self.bus.cyc),
            self.bus.dat_r[0:32].eq(self.do),
            self.en.eq(self.bus.stb & self.bus.cyc),
        ]

        self.specials += Instance("RAM128",
                                  i_CLK=ClockSignal("sys"),
                                  i_A0=self.bus.adr[:7],
                                  i_Di0=self.di,
                                  i_WE0=self.we,
                                  i_EN0=self.en,
                                  o_Do0=self.do
        )

        self.sync += self.bus.ack.eq(self.bus.stb & self.bus.cyc & ~self.bus.ack)