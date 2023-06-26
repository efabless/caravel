#
# This file is part of LiteX-Boards.
#
# Copyright (c) 2020 Piotr Esden-Tempski <piotr@esden.net>
# SPDX-License-Identifier: BSD-2-Clause

from litex.build.generic_platform import *
from litex.build.lattice import LatticePlatform


# IOs ----------------------------------------------------------------------------------------------
_io = [
    ("core_clk", 0, Pins(1)),
    # ("core_rst", 0, Pins(1)),
    ("core_rstn", 0, Pins(1)),

    # pass-thru pins for clock and reset
    ("clk_in", 0, Pins(1)),
    ("clk_out", 0, Pins(1)),
    ("resetn_in", 0, Pins(1)),
    ("resetn_out", 0, Pins(1)),

    ("serial_load_in", 0, Pins(1)),
    ("serial_load_out", 0, Pins(1)),
    ("serial_data_2_in", 0, Pins(1)),
    ("serial_data_2_out", 0, Pins(1)),
    ("serial_resetn_in", 0, Pins(1)),
    ("serial_resetn_out", 0, Pins(1)),
    ("serial_clock_in", 0, Pins(1)),
    ("serial_clock_out", 0, Pins(1)),
    ("rstb_l_in", 0, Pins(1)),
    ("rstb_l_out", 0, Pins(1)),
    ("por_l_in", 0, Pins(1)),
    ("por_l_out", 0, Pins(1)),
    ("porb_h_in", 0, Pins(1)),
    ("porb_h_out", 0, Pins(1)),

    # GPIO mgmt
    ("gpio", 0,
     Subsignal("out_pad", Pins(1)),
     Subsignal("in_pad", Pins(1)),
     Subsignal("outenb_pad", Pins(1)),
     Subsignal("inenb_pad", Pins(1)),
     Subsignal("mode0_pad", Pins(1)),
     Subsignal("mode1_pad", Pins(1)),
     ),

    # Logic analyzer
    ("la", 0,
     Subsignal("output", Pins(128)),
     Subsignal("input", Pins(128)),
     Subsignal("oenb", Pins(128)),
     Subsignal("iena", Pins(128)),
     ),

    # Flash memory controller (SPI master)
    ("flash", 0,
     Subsignal("cs_n", Pins(1)),
     # Subsignal("csb", Pins(1)),
     Subsignal("clk", Pins(1)),
     Subsignal("io0_oeb", Pins(1)),
     Subsignal("io1_oeb", Pins(1)),
     Subsignal("io2_oeb", Pins(1)),
     Subsignal("io3_oeb", Pins(1)),
     Subsignal("io0_do", Pins(1)),
     Subsignal("io1_do", Pins(1)),
     Subsignal("io2_do", Pins(1)),
     Subsignal("io3_do", Pins(1)),
     Subsignal("io0_di", Pins(1)),
     Subsignal("io1_di", Pins(1)),
     Subsignal("io2_di", Pins(1)),
     Subsignal("io3_di", Pins(1)),
     ),

    # Exported wishbone bus
    ("mprj", 0,
     Subsignal("wb_iena", Pins(1)),  # enable for the user wishbone return signals
     Subsignal("cyc_o", Pins(1)),
     Subsignal("stb_o", Pins(1)),
     Subsignal("we_o", Pins(1)),
     Subsignal("sel_o", Pins(4)),
     Subsignal("adr_o", Pins(32)),
     Subsignal("dat_o", Pins(32)),
     Subsignal("dat_i", Pins(32)),
     Subsignal("ack_i", Pins(1)),
     ),

    # Housekeeping
    ("hk", 0,
     Subsignal("dat_i", Pins(32)),
     Subsignal("stb_o", Pins(1)),
     Subsignal("cyc_o", Pins(1)),
     Subsignal("ack_i", Pins(1)),
     ),

    # IRQ
    ("user_irq", 0, Pins(6)),
    ("user_irq_ena", 0, Pins(3)),

    # Module status
    ("qspi_enabled", 0, Pins(1)),
    ("uart_enabled", 0, Pins(1)),
    ("spi_enabled", 0, Pins(1)),
    ("debug_mode", 0, Pins(1)),

    # Serial UART
    # muxed output between system and debug uarts
    ("serial", 0,
     Subsignal("tx", Pins(1)),
     Subsignal("rx", Pins(1)),
     ),

    # Debug interface -- only debug_in is used
    ("debug", 0,
     Subsignal("in", Pins("1")),
     Subsignal("out", Pins("1")),
     Subsignal("oeb", Pins("1")),
     ),

    # SPI master Controller
    ("spi", 0,
        Subsignal("clk",  Pins(1)),
        Subsignal("cs_n", Pins(1)),
        Subsignal("mosi", Pins(1)),
        Subsignal("miso", Pins(1)),
        Subsignal("sdoenb", Pins(1)),
    ),

    # SRAM read-only access from housekeeping
    # ("sram_ro", 0,
    #  Subsignal("clk", Pins(1)),
    #  Subsignal("csb", Pins(1)),
    #  Subsignal("addr", Pins(8)),
    #  Subsignal("data", Pins(32)),
    #  ),

    ("trap", 0, Pins(1)),

    # Memory Interface
    # ("mem", 0,
    #  Subsignal("ena", Pins(1)),
    #  Subsignal("wen", Pins(4)),
    #  Subsignal("addr", Pins(8)),
    #  Subsignal("wdata", Pins(32)),
    #  Subsignal("rdata", Pins(32)),
    #  ),
    # ("mgmt_soc_dff", 0,
    #  Subsignal("EN", Pins(1)),
    #  Subsignal("WE", Pins(4)),
    #  Subsignal("A", Pins(8)),
    #  Subsignal("Di", Pins(32)),
    #  Subsignal("Do", Pins(32)),
    #  ),

]



# Platform -----------------------------------------------------------------------------------------

class Platform(GenericPlatform):
    def __init__(self, vname=""):
        GenericPlatform.__init__(self, "", _io)
        
    def build(self, fragment, build_dir, **kwargs):
        os.makedirs(build_dir, exist_ok=True)
        os.chdir(build_dir)
        top_output = self.get_verilog(fragment, name="mgmt_core")
        top_output.write("mgmt_core.v")

    # def get_verilog(self, *args, special_overrides=dict(), **kwargs):
    #     so = dict(common.altera_special_overrides)
    #     so.update(special_overrides)
    #     return GenericPlatform.get_verilog(self, *args,
    #         special_overrides = so,
    #         attr_translate    = self.toolchain.attr_translate,
    #         **kwargs)
    #
    # def build(self, *args, **kwargs):
    #     return self.toolchain.build(self, *args, **kwargs)

    def get_verilog(self, fragment, **kwargs):
        return verilog.convert(fragment, platform=self, regular_comb=False, **kwargs)

    def _new_print_combinatorial_logic_sim(f, ns):
        r = ""
        if f.comb:
            from collections import defaultdict

            target_stmt_map = defaultdict(list)

            for statement in verilog.flat_iteration(f.comb):
                targets = verilog.list_targets(statement)
                for t in targets:
                    target_stmt_map[t].append(statement)

            groups = verilog.group_by_targets(f.comb)

            for n, (t, stmts) in enumerate(target_stmt_map.items()):
                assert isinstance(t, Signal)
                if len(stmts) == 1 and isinstance(stmts[0], verilog._Assign):
                    r += "assign " + verilog._print_node(ns, verilog._AT_BLOCKING, 0, stmts[0])
                else:
                    r += "always @(*) begin\n"
                    # r += "\t" + ns.get_name(t) + " <= " + _print_expression(ns, t.reset)[0] + ";\n"
                    # r += _print_node(ns, _AT_NONBLOCKING, 1, stmts, t)
                    r += "\t" + ns.get_name(t) + " = " + verilog._print_expression(ns, t.reset)[0] + ";\n"
                    r += verilog._print_node(ns, verilog._AT_BLOCKING, 1, stmts, t)
                    r += "end\n"
        r += "\n"
        return r

    verilog._print_combinatorial_logic_sim = _new_print_combinatorial_logic_sim

    def _new_print_module(f, ios, name, ns, attr_translate):
        sigs = verilog.list_signals(f) | verilog.list_special_ios(f, ins=True, outs=True, inouts=True)
        special_outs = verilog.list_special_ios(f, ins=False, outs=True, inouts=True)
        inouts = verilog.list_special_ios(f, ins=False, outs=False, inouts=True)
        targets = verilog.list_targets(f) | special_outs
        wires = verilog._list_comb_wires(f) | special_outs
        r = "module " + name + "(\n"
        r += "`ifdef USE_POWER_PINS\n"
        r += "    inout VPWR,	    /* 1.8V domain */\n"
        r += "    inout VGND,\n"
        r += "`endif\n"
        firstp = True
        for sig in sorted(ios, key=lambda x: x.duid):
            if not firstp:
                r += ",\n"
            firstp = False
            attr = verilog._print_attribute(sig.attr, attr_translate)
            if attr:
                r += "\t" + attr
            sig.type = "wire"
            sig.name = ns.get_name(sig)
            if sig in inouts:
                sig.direction = "inout"
                r += "\tinout wire " + verilog._print_signal(ns, sig)
            elif sig in targets:
                sig.direction = "output"
                if sig in wires:
                    r += "\toutput wire " + verilog._print_signal(ns, sig)
                else:
                    sig.type = "reg"
                    r += "\toutput reg " + verilog._print_signal(ns, sig)
            else:
                sig.direction = "input"
                r += "\tinput wire " + verilog._print_signal(ns, sig)
        r += "\n);\n\n"
        for sig in sorted(sigs - ios, key=lambda x: x.duid):
            attr = verilog._print_attribute(sig.attr, attr_translate)
            if attr:
                r += attr + " "
            if sig in wires:
                r += "wire " + verilog._print_signal(ns, sig) + ";\n"
            else:
                r += "reg " + verilog._print_signal(ns, sig) + " = " + verilog._print_expression(ns, sig.reset)[0] + ";\n"
        r += "\n"
        return r

    verilog._print_module = _new_print_module
