#
# This file is part of LiteSPI
#
# Copyright (c) 2020-2021 Antmicro <www.antmicro.com>
# Copyright (c) 2021 Florent Kermarrec <florent@enjoy-digital.fr>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *
from migen.genlib.misc import WaitTimer

from litespi.common import *
from litespi.clkgen import LiteSPIClkGen

from litex.soc.interconnect import stream
from litex.soc.interconnect.csr import *

from litex.build.io import SDROutput, SDRInput, SDRTristate

from litex.soc.integration.doc import AutoDoc

# LiteSPI PHY Core ---------------------------------------------------------------------------------

class LiteSPISDRPHYCore(Module, AutoCSR, AutoDoc):
    """LiteSPI PHY instantiator

    The ``LiteSPIPHYCore`` class provides a generic PHY that can be connected to the ``LiteSPICore``.

    It supports single/dual/quad/octal output reads from the flash chips.

    The following diagram shows how each clock configuration option relates to outputs and input sampling in DDR mode:

    .. wavedrom:: ../../doc/ddr-timing-diagram.json

    Parameters
    ----------
    pads : Object
        SPI pads description.

    flash : SpiNorFlashModule
        SpiNorFlashModule configuration object.

    device : str
        Device type for use by the ``LiteSPIClkGen``.

    default_divisor : int
        Default frequency divisor for clkgen.

    Attributes
    ----------
    source : Endpoint(spi_phy2core_layout), out
        Data stream.

    sink : Endpoint(spi_core2phy_layout), in
        Control stream.

    cs : Signal(), in
        Flash CS signal.

    clk_divisor : CSRStorage
        Register which holds a clock divisor value applied to clkgen.
    """
    def __init__(self, pads, flash, device, clock_domain, default_divisor, cs_delay):
        self.source           = source = stream.Endpoint(spi_phy2core_layout)
        self.sink             = sink   = stream.Endpoint(spi_core2phy_layout)
        self.cs               = Signal()
        self._spi_clk_divisor = spi_clk_divisor = Signal(8)

        self._default_divisor = default_divisor

        self.clk_divisor      = clk_divisor = CSRStorage(8, reset=self._default_divisor)

        # # #

        # Resynchronize CSR Clk Divisor to LiteSPI Clk Domain.
        self.submodules += ResyncReg(clk_divisor.storage, spi_clk_divisor, clock_domain)

        # Determine SPI Bus width and DQs.
        # if hasattr(pads, "mosi"):
        #     bus_width = 1
        # else:
        #     bus_width = len(pads.dq)
        # assert bus_width in [1, 2, 4, 8]

        bus_width = 1
        # bus_width = 4

        # Check if number of pads matches configured mode.
        # assert flash.check_bus_width(bus_width)

        self.addr_bits  = addr_bits  = flash.addr_bits
        self.cmd_width  = cmd_width  = flash.cmd_width
        self.addr_width = addr_width = flash.addr_width
        self.data_width = data_width = flash.bus_width
        self.ddr        = ddr        = flash.ddr

        self.command = command = flash.read_opcode.code

        # Clock Generator.
        self.submodules.clkgen = clkgen = LiteSPIClkGen(pads, device, with_ddr=ddr)
        self.comb += [
            clkgen.div.eq(spi_clk_divisor),
            clkgen.sample_cnt.eq(1),
            clkgen.update_cnt.eq(1),
        ]

        # CS control.
        cs_timer  = WaitTimer(cs_delay + 1) # Ensure cs_delay cycles between XFers.
        cs_enable = Signal()
        self.submodules += cs_timer
        self.comb += cs_timer.wait.eq(self.cs)
        self.comb += cs_enable.eq(cs_timer.done)
        self.comb += pads.cs_n.eq(~cs_enable)

        # I/Os.
        data_bits = 32
        cmd_bits  = 8

        # if hasattr(pads, "mosi"):
        if bus_width == 1:
            dq_o  = Signal()
            dq_i  = Signal(2)
            dq_oe = Signal() # Unused.
            self.specials += SDROutput(
                i = ~dq_oe,
                o = pads.io0_oeb
            )
            self.comb += pads.io1_oeb.eq(1)
            self.specials += SDROutput(
                i = dq_o,
                o = pads.io0_do
            )
            self.specials += SDRInput(
                i = pads.io1_di,
                o = dq_i[1]
            )
            self.comb += pads.io1_do.eq(0)
            self.comb += pads.io2_do.eq(0)
            self.comb += pads.io3_do.eq(0)
            self.comb += pads.io2_oeb.eq(1)
            self.comb += pads.io3_oeb.eq(1)


        else:
            dq_o  = Signal(bus_width)
            dq_i  = Signal(bus_width)
            dq_oe = Signal(bus_width)
            for i in range(bus_width):
                self.specials += SDROutput(
                    i=dq_oe[i],
                    o=getattr(pads,"io"+str(i)+"_oeb")
                )
                self.specials += SDROutput(
                    i=dq_o[i],
                    o=getattr(pads,"io"+str(i)+"_do")
                )
                self.specials += SDRInput(
                    i=getattr(pads,"io"+str(i)+"_di"),
                    o=dq_i[i]
                )
                # self.specials += SDRTristate(
                #     io = pads.dq_io[i],
                #     o  = dq_o[i],
                #     oe = dq_oe[i],
                #     i  = dq_i[i],
                # )

        # Data Shift Registers.
        sr_cnt       = Signal(8, reset_less=True)
        sr_out_load  = Signal()
        sr_out_shift = Signal()
        sr_out       = Signal(len(sink.data), reset_less=True)
        sr_in_shift  = Signal()
        sr_in        = Signal(len(sink.data), reset_less=True)

        # Data Out Generation/Load/Shift.
        self.comb += [
            dq_oe.eq(sink.mask),
            Case(sink.width, {
                1 : dq_o.eq(sr_out[-1:]),
                2 : dq_o.eq(sr_out[-2:]),
                4 : dq_o.eq(sr_out[-4:]),
                8 : dq_o.eq(sr_out[-8:]),
            })
        ]
        self.sync += If(sr_out_load,
            sr_out.eq(sink.data << (len(sink.data) - sink.len))
        )
        self.sync += If(sr_out_shift,
            Case(sink.width, {
                1 : sr_out.eq(Cat(Signal(1), sr_out)),
                2 : sr_out.eq(Cat(Signal(2), sr_out)),
                4 : sr_out.eq(Cat(Signal(4), sr_out)),
                8 : sr_out.eq(Cat(Signal(8), sr_out)),
            })
        )

        # Data In Shift.
        self.sync += If(sr_in_shift,
            Case(sink.width, {
                1 : sr_in.eq(Cat(dq_i[1], sr_in)),
                2 : sr_in.eq(Cat(dq_i[:2], sr_in)),
                4 : sr_in.eq(Cat(dq_i[:4], sr_in)),
                8 : sr_in.eq(Cat(dq_i[:8], sr_in)),
            })
        )

        # FSM.
        self.submodules.fsm = fsm = FSM(reset_state="WAIT-CMD-DATA")
        fsm.act("WAIT-CMD-DATA",
            # Wait for CS and a CMD from the Core.
            If(cs_enable & sink.valid,
                # Load Shift Register Count/Data Out.
                NextValue(sr_cnt, sink.len - sink.width),
                sr_out_load.eq(1),
                # Start XFER.
                NextState("XFER"),
            ),
        )
        fsm.act("XFER",
            # Generate Clk.
            self.clkgen.en.eq(1),

            # Data In Shift.
            If(clkgen.posedge_reg2, sr_in_shift.eq(1)),

            # Data Out Shift.
            If(clkgen.negedge, sr_out_shift.eq(1)),

            # Shift Register Count Update/Check.
            If(self.clkgen.negedge,
                NextValue(sr_cnt, sr_cnt - sink.width),
                # End XFer.
                If(sr_cnt == 0,
                    NextState("XFER-END"),
                ),
            ),

        )
        fsm.act("XFER-END",
            # Last data already captured in XFER when divisor > 0 so only capture for divisor == 0.
            If((spi_clk_divisor > 0) | clkgen.posedge_reg2,
                # Accept CMD.
                sink.ready.eq(1),
                # Capture last data (only for spi_clk_divisor == 0).
                sr_in_shift.eq(spi_clk_divisor == 0),
                # Send Status/Data to Core.
                NextState("SEND-STATUS-DATA"),
            )
        )
        self.comb += source.data.eq(sr_in)
        fsm.act("SEND-STATUS-DATA",
            # Send Data In to Core and return to WAIT when accepted.
            source.valid.eq(1),
            source.last.eq(1),
            If(source.ready,
                NextState("WAIT-CMD-DATA"),
            )
        )
