import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer,Edge
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from interfaces.caravel import GPIO_MODE
from interfaces.common import Macros


bit_time_ns = 0
reg = Regs()


@cocotb.test()
@repot_test
async def user_address_space(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=17936)
    cocotb.log.info(f"[TEST] Start user_address_space test")
    ack_hdl  = caravelEnv.caravel_hdl.mprj.addr_space_testing.wbs_ack_o 
    addr_hdl  = caravelEnv.caravel_hdl.mprj.addr_space_testing.addr 
    data_hdl  = caravelEnv.caravel_hdl.mprj.addr_space_testing.data 
    addr_arr = [0x30000000,0x30000004,0x30000008,0x300FFFF8,0x300FFFFC,0x30100000,0x30044078,0x30090A94,0x3005FE2C,0x300F9F44,0x30032E58,0x300602EC,0x30100000]
    data_arr = [0x97cf0d2d,0xbc748313,0xbfda8146,0x5f5e36b1,0x0c1fe9d9,0x6d12d2b8,0xdcd244d1,0x0da37088,0x7b8e4345,0x00000777,0x00000777,0x00000777,0xFFFFFFFF]
    for addr, data in zip(addr_arr, data_arr):
        await RisingEdge(ack_hdl)
        if addr_hdl.value.integer != addr:
            cocotb.log.error(f"[TEST] seeing unexpected address {hex(addr_hdl.value.integer)} expected {hex(addr)}")
        elif data_hdl.value.integer !=  data:
            cocotb.log.error(f"[TEST] seeing unexpected data {hex(data_hdl.value.integer)} expected {hex(data)} address {hex(addr)}")
        else: 
            cocotb.log.info(f"[TEST] seeing the correct data {hex(data)} from address {hex(addr)}")


