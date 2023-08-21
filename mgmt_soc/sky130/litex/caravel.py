#!/usr/bin/env python3

# Copyright (c) 2020 Antmicro <www.antmicro.com>
# Copyright (c) 2020 Florent Kermarrec <florent@enjoy-digital.fr>
# Copyright (c) 2021 Efabless <www.efaless.com>

# SPDX-License-Identifier: BSD-2-Clause

import argparse
from os import path

from migen import *
from litex.soc.cores.spi_flash import SpiFlash
from litex.soc.integration.soc_core import SoCCore
from litex.soc.integration.builder import Builder, builder_argdict, builder_args
from litex.soc.integration.soc_core import soc_core_argdict, soc_core_args
from litex.soc.integration.doc import AutoDoc
from litex.soc.integration.soc import SoCRegion, SoCIORegion
from litex.soc.integration.soc_core import *
from litex.build.generic_platform import *
from litex.soc.cores.uart import UARTWishboneBridge, UART, RS232PHY, UARTPHY
from litex.soc.cores.gpio import *
from caravel_gpio import *
from litex.soc.cores.spi import SPIMaster, SPISlave
import litex.soc.doc as lxsocdoc

from caravel_platform import Platform
from caravel_ram import *

# SoCMini.mem_map = {
#     "dff": 0x00000000,
#     "sram": 0x01000000,
#     "flash": 0x10000000,
#     "mprj": 0x30000000,
#     "hk": 0x26000000,
#     "csr": 0x20000000,
# }

# MGMTSoC
class MGMTSoC(SoCMini):

    def __init__(self, sys_clk_freq=int(10e6), **kwargs ):

        ##
        ## Uncomment cpu selection for mgmt core below
        ##
        # cpu = 'picorv32'
        # cpu = 'ibex'
        cpu = 'vexriscv'

        platform = Platform("mgmt_soc")

        # CRG --------------------------------------------------------------------------------------
        # self.submodules.crg = CRG(platform.request("core_clk"), rst=platform.request("core_rst"))
        core_rst = Signal()
        self.submodules.crg = CRG(platform.request("core_clk"), rst=core_rst)
        core_rstn = platform.request("core_rstn")
        self.comb += core_rst.eq(~core_rstn)

        if cpu == 'vexriscv':
            SoCMini.__init__(self, platform,
                             clk_freq=sys_clk_freq,
                             cpu_type="vexriscv",
                             cpu_variant="minimal+debug",
                             # cpu_variant="lite+debug",
                             # cpu_reset_address=self.mem_map["flash"],
                             cpu_reset_address=0x10000000,
                             csr_data_width=32,
                             integrated_sram_size=0,
                             integrated_rom_size=0,
                             with_uart=False,
                             # with_uart=True,
                             # uart_baudrate=9600,
                             # uart_name="serial",
                             with_timer=True,
                             **kwargs)

            self.mem_map = {
                "dff": 0x00000000,
                "dff2": 0x00000400,
                # "sram": 0x01000000,
                "flash": 0x10000000,
                "mprj": 0x30000000,
                "hk": 0x26000000,
                # "csr": 0x20000000,
                "csr": 0xf0000000,
                "vexriscv_debug": 0xf00f0000
            }

        # self.cpu.cpu_reset_address = self.mem_map["flash"]
        elif cpu == 'ibex':
            self.mem_map = {
                "dff": 0x00000000,
                "sram": 0x01000000,
                "flash": 0x10000000,
                "mprj": 0x30000000,
                "hk": 0x26000000,
                "csr": 0x20000000,
                # "csr": 0xf0000000,
            }
            SoCMini.__init__(self, platform,
                             clk_freq=sys_clk_freq,
                             cpu_type="ibex",
                             cpu_variant="standard",
                             cpu_reset_address=self.mem_map["flash"],
                             csr_data_width=32,
                             integrated_sram_size=0,
                             integrated_rom_size=0,
                             with_uart=True,
                             uart_baudrate=9600,
                             uart_name="serial",
                             with_timer=True,
                             **kwargs)

            self.cpu.cpu_params["p_RegFile"] = 0  # Reg File = FlipFlop

        elif cpu == 'picorv32':
            self.mem_map = {
                "dff": 0x00000000,
                "sram": 0x01000000,
                "flash": 0x10000000,
                "mprj": 0x30000000,
                "hk": 0x26000000,
                "csr": 0x20000000,
                # "csr": 0xf0000000,
            }
            SoCMini.__init__(self, platform,
                             clk_freq=sys_clk_freq,
                             cpu_type="picorv32",
                             cpu_variant="minimal",
                             cpu_reset_address=self.mem_map["flash"],
                             csr_data_width=32,
                             integrated_sram_size=0,
                             integrated_rom_size=0,
                             with_uart=True,
                             uart_baudrate=9600,
                             uart_name="serial",
                             with_timer=True,
                             **kwargs)

        else:
            print("ERROR - cpu value not recognized")
            exit()

        #DFFRAM
        dff_size = 1 * 1024
        dff = self.submodules.mem = DFFRAM(size=dff_size)
        self.register_mem("dff", self.mem_map["dff"], self.mem.bus, dff_size)
        # mgmt_soc_dff = platform.request("mgmt_soc_dff")
        # self.comb += mgmt_soc_dff.WE.eq(dff.we)
        # self.comb += mgmt_soc_dff.A.eq(dff.bus.adr)
        # self.comb += dff.do.eq(mgmt_soc_dff.Do)
        # self.comb += mgmt_soc_dff.Di.eq(dff.di)
        # self.comb += mgmt_soc_dff.EN.eq(dff.en)

        #DFFRAM2
        dff2_size = 512
        dff2 = self.submodules.mem2 = DFFRAM_512(size=dff2_size)
        self.register_mem("dff2", self.mem_map["dff2"], self.mem2.bus, dff2_size)

        # #OpenRAM
        # spram_size = 2 * 1024
        # sram = self.submodules.spram = OpenRAM(size=spram_size)
        # self.register_mem("sram", self.mem_map["sram"], self.spram.bus, spram_size)
        # sram_ro_ports = platform.request("sram_ro")
        # self.comb += sram_ro_ports.clk.eq(sram.clk1)
        # self.comb += sram_ro_ports.csb.eq(sram.cs_b1)
        # self.comb += sram_ro_ports.addr.eq(sram.adr1)
        # self.comb += sram_ro_ports.data.eq(sram.dataout1)

        # SPI Flash --------------------------------------------------------------------------------
        from litespi.modules import W25Q128JV
        from litespi.opcodes import SpiNorFlashOpCodes as Codes
        self.new_add_spi_flash(name="flash", mode="1x", module=W25Q128JV(Codes.READ_1_1_1), with_master=True)
        # self.new_add_spi_flash(name="flash", mode="4x", module=W25Q128JV(Codes.READ_1_1_4), with_master=True)

        # Add a master SPI controller w/ a clock divider
        spi_master = SPIMaster(
            pads=platform.request("spi"),
            data_width=8,
            sys_clk_freq=sys_clk_freq,
            spi_clk_freq=1e5,
        )
        spi_master.add_clk_divider()
        self.submodules.spi_master = spi_master
        #self.add_interrupt(interrupt_name="spi_master")
        self.comb += spi_master.pads.sdoenb.eq(~spi_master.pads.cs_n)

        # Add a wb port for external slaves user_project
        mprj_ports = platform.request("mprj")
        mprj = wishbone.Interface()
        self.bus.add_slave(name="mprj", slave=mprj, region=SoCRegion(origin=self.mem_map["mprj"], size=0x10000000))
        self.submodules.mprj_wb_iena = GPIOOut(mprj_ports.wb_iena)
        self.comb += mprj_ports.cyc_o.eq(mprj.cyc)
        self.comb += mprj_ports.stb_o.eq(mprj.stb)
        self.comb += mprj_ports.we_o.eq(mprj.we)
        self.comb += mprj_ports.sel_o.eq(mprj.sel)
        self.comb += mprj_ports.adr_o[2:32].eq(mprj.adr)
        self.comb += mprj_ports.adr_o[0:2].eq(0)
        self.comb += mprj.dat_r.eq(mprj_ports.dat_i)
        self.comb += mprj_ports.dat_o.eq(mprj.dat_w)
        self.comb += mprj.ack.eq(mprj_ports.ack_i)

        # Add a wb port for external slaves housekeeping
        hk = wishbone.Interface()
        self.bus.add_slave(name="hk", slave=hk, region=SoCRegion(origin=self.mem_map["hk"], size=0x00300000))
        hk_ports = platform.request("hk")
        self.comb += hk_ports.stb_o.eq(hk.stb)
        self.comb += hk_ports.cyc_o.eq(hk.cyc)
        self.comb += hk.dat_r.eq(hk_ports.dat_i)
        self.comb += hk.ack.eq(hk_ports.ack_i)

        # Add System UART
        sys_uart = Record([('rx', 1), ('tx', 1)])
        self.submodules.uart_phy = UARTPHY(sys_uart, sys_clk_freq, baudrate = 9600)
        self.submodules.uart = UART(self.uart_phy, tx_fifo_depth = 16, rx_fifo_depth = 16)
        self.irq.add("uart", use_loc_if_exists=True)

        # Add Debug Interface (UART)
        dbg_uart = Record([('rx',1),('tx',1)])
        self.submodules.dbg_uart = UARTWishboneBridge(dbg_uart, sys_clk_freq, baudrate=115200)
        self.add_wb_master(self.dbg_uart.wishbone)

        # Instantiate ports for debug & serial i/f
        uart_ports = platform.request("serial")
        debug_ports = platform.request("debug")
        self.submodules.debug_oeb = GPIOOut(debug_ports.oeb)
        self.comb += debug_ports.out.eq(0)
        self.submodules.debug_mode = GPIOOut(platform.request("debug_mode"))

        # Mux uart outputs to serial ports
        self.comb += If(getattr(debug_ports, 'in') == 1,
                            uart_ports.tx.eq(dbg_uart.tx),
                            dbg_uart.rx.eq(uart_ports.rx)
                        ).Else(
                            uart_ports.tx.eq(sys_uart.tx),
                            sys_uart.rx.eq(uart_ports.rx)
                        )

        # Setup uart_enabled port to be uart_enabled reg OR debug_in
        uart_enabled_o = Signal()
        self.submodules.uart_enabled = GPIOOut(uart_enabled_o)
        uart_enabled_pad = platform.request("uart_enabled")
        self.comb += uart_enabled_pad.eq(uart_enabled_o | getattr(debug_ports, 'in'))
        # self.submodules.uart_enabled = GPIOOut(platform.request("uart_enabled"))

        # NOTES RE DEBUG:
        #   mux system uart and debug uart to the current ports using debug_in as a select
        #   mux uart enabled to user controlled reg and debug_in (or logic)
        #   debug enabled will be register
        #   setup isr for interrupt irq[3] to halt processor (hk register)
        #   develop test bench to confirm functionality

        # Add a GPIO Pin
        self.submodules.gpio = GPIOASIC(platform.request("gpio"))

        # Add the logic Analyzer
        self.submodules.la = LogicAnalyzer(platform.request("la"))
        # self.submodules.la_ien = GPIOOut(platform.request("la_ien"))

        # Add the user's input control
        qspi_enabled = platform.request("qspi_enabled")
        self.comb += qspi_enabled.eq(0)
        self.submodules.spi_enabled = GPIOOut(platform.request("spi_enabled"))

        trap = platform.request("trap")
        if cpu == 'picorv32':
            self.comb += trap.eq(self.cpu.trap)
        else:
            self.comb += trap.eq(0)

        self.submodules.user_irq_ena = GPIOOut(platform.request("user_irq_ena"))
        # NOTE - these are not connected

        # Add 6 IRQ lines
        user_irq = platform.request("user_irq")
        for i in range(len(user_irq)):
            setattr(self.submodules,"user_irq_"+str(i),GPIOIn(user_irq[i], with_irq=True))
            self.irq.add("user_irq_"+str(i), use_loc_if_exists=True)

        # Pass-thru clock and reset
        clk_in = platform.request("clk_in")
        clk_out = platform.request("clk_out")
        resetn_in = platform.request("resetn_in")
        resetn_out = platform.request("resetn_out")
        self.comb += clk_out.eq(clk_in)
        self.comb += resetn_out.eq(resetn_in)

        serial_load_in = platform.request("serial_load_in")
        serial_load_out = platform.request("serial_load_out")
        self.comb += serial_load_out.eq(serial_load_in)

        serial_data_2_in = platform.request("serial_data_2_in")
        serial_data_2_out = platform.request("serial_data_2_out")
        self.comb += serial_data_2_out.eq(serial_data_2_in)

        serial_resetn_in = platform.request("serial_resetn_in")
        serial_resetn_out = platform.request("serial_resetn_out")
        self.comb += serial_resetn_out.eq(serial_resetn_in)

        serial_clock_in = platform.request("serial_clock_in")
        serial_clock_out = platform.request("serial_clock_out")
        self.comb += serial_clock_out.eq(serial_clock_in)

        rstb_l_in = platform.request("rstb_l_in")
        rstb_l_out = platform.request("rstb_l_out")
        self.comb += rstb_l_out.eq(rstb_l_in)

        por_l_in = platform.request("por_l_in")
        por_l_out = platform.request("por_l_out")
        self.comb += por_l_out.eq(por_l_in)

        porb_h_in = platform.request("porb_h_in")
        porb_h_out = platform.request("porb_h_out")
        self.comb += porb_h_out.eq(porb_h_in)

    #####################

    def new_add_spi_flash(self, name="flash", mode="4x", dummy_cycles=None, clk_freq=None, module=None, phy=None, rate="1:1", **kwargs):
        if module is None:
            # Use previous LiteX SPI Flash core with compat, will be deprecated at some point.
            from litex.compat.soc_add_spi_flash import add_spi_flash
            add_spi_flash(self, name, mode, dummy_cycles)
        # LiteSPI.
        else:
            # Imports.
            from litespi import LiteSPI
            # from litespi.phy.generic import LiteSPIPHY
            from generic import LiteSPIPHY
            from litespi.opcodes import SpiNorFlashOpCodes

            # Checks/Parameters.
            assert mode in ["1x", "4x"]
            if clk_freq is None: clk_freq = self.sys_clk_freq

            # PHY.
            spiflash_phy = phy
            if spiflash_phy is None:
                self.check_if_exists(name + "_phy")
                spiflash_pads = self.platform.request(name)
                # spiflash_pads = self.platform.request(name if mode == "1x" else name + mode)
                spiflash_phy = LiteSPIPHY(spiflash_pads, module, device=self.platform.device, default_divisor=int(self.sys_clk_freq/clk_freq), rate=rate)
                setattr(self.submodules, name + "_phy",  spiflash_phy)

            # Core.
            self.check_if_exists(name + "_mmap")
            spiflash_core = LiteSPI(spiflash_phy, mmap_endianness=self.cpu.endianness, **kwargs)
            setattr(self.submodules, name + "_core", spiflash_core)
            spiflash_region = SoCRegion(origin=self.mem_map.get(name, None), size=module.total_size)
            self.bus.add_slave(name=name, slave=spiflash_core.bus, region=spiflash_region)

            # Constants.
            self.add_constant("SPIFLASH_PHY_FREQUENCY", clk_freq)
            self.add_constant("SPIFLASH_MODULE_NAME", module.name.upper())
            self.add_constant("SPIFLASH_MODULE_TOTAL_SIZE", module.total_size)
            self.add_constant("SPIFLASH_MODULE_PAGE_SIZE", module.page_size)
            if SpiNorFlashOpCodes.READ_1_1_4 in module.supported_opcodes:
                self.add_constant("SPIFLASH_MODULE_QUAD_CAPABLE")
            if SpiNorFlashOpCodes.READ_4_4_4 in module.supported_opcodes:
                self.add_constant("SPIFLASH_MODULE_QPI_CAPABLE")

def main():
    soc     = MGMTSoC()
    builder = Builder(soc, compile_software=False)
    builder.build()

    lxsocdoc.generate_docs(soc, "build/documentation/", project_name="Caravel Management SoC", author="Efabless")

    # from migen.sim import Simulator, TopLevel
    # from migen.sim.vcd import TopLevel
    # sim = Simulator(soc, TopLevel("ledblinker.vcd"))
    # sim.run(200)


if __name__ == "__main__":
    main()