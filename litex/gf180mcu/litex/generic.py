#
# This file is part of LiteSPI
#
# Copyright (c) 2020 Antmicro <www.antmicro.com>
# SPDX-License-Identifier: BSD-2-Clause

from migen import *
from migen.genlib.cdc import MultiReg
from migen.genlib.misc import WaitTimer

from litespi.common import *

from litex.soc.interconnect.csr import *

from litex.soc.integration.doc import AutoDoc

# from litespi.phy.generic_sdr import LiteSPISDRPHYCore
from generic_sdr import LiteSPISDRPHYCore
from litespi.phy.generic_ddr import LiteSPIDDRPHYCore

# LiteSPI PHY --------------------------------------------------------------------------------------

class LiteSPIPHY(Module, AutoCSR, AutoDoc):
    """LiteSPI PHY instantiator

    The ``LiteSPIPHY`` class instantiate generic PHY - ``LiteSPIPHYCore`` that can be connected to the ``LiteSPICore``,
    handles optional clock domain wrapping for whole PHY and interfaces streams and CS signal from PHY logic.

    Parameters
    ----------
    pads : Object
        SPI pads description.

    flash : SpiNorFlashModule
        SpiNorFlashModule configuration object.

    device : str
        Device type for use by the ``LiteSPIClkGen``.

    clock_domain : str
        Name of LiteSPI clock domain.

    default_divisor : int (1:1 rate)
        Default frequency divisor for clkgen.

    rate : str
        Rate: 1:1 SDR, 1:2 DDR.

    extra_latency : int (1:2 rate)
        Compensate for additional DDROutput/Input latency

    Attributes
    ----------
    source : Endpoint(spi_phy2core_layout), out
        Data stream from ``LiteSPIPHYCore``.

    sink : Endpoint(spi_core2phy_layout), in
        Control stream from ``LiteSPIPHYCore``.

    cs : Signal(), in
        Flash CS signal from ``LiteSPIPHYCore``.
    """

    def __init__(self, pads, flash, device="xc7", clock_domain="sys", default_divisor=9, cs_delay=10, rate="1:1", extra_latency=0):
        assert rate in ["1:1", "1:2"]
        if rate == "1:1":
            self.phy = LiteSPISDRPHYCore(pads, flash, device, clock_domain, default_divisor, cs_delay)
        if rate == "1:2":
            self.phy = LiteSPIDDRPHYCore(pads, flash, cs_delay, extra_latency)

        self.flash = flash

        self.source = self.phy.source
        self.sink   = self.phy.sink
        self.cs     = self.phy.cs

        # # #

        if clock_domain != "sys":
            self.phy = ClockDomainsRenamer(clock_domain)(self.phy)

        self.submodules.spiflash_phy = self.phy

    def get_csrs(self):
        return self.spiflash_phy.get_csrs()
