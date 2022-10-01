import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from cpu import RiskV
from defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from caravel import GPIO_MODE

reg = Regs()
"""Testbench of GPIO configuration through bit-bang method using the StriVe housekeeping SPI."""
@cocotb.test()
@repot_test
async def temp_partial(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=70000)
    # Apply data 0x1809 (management standard output) to first block of 
    # user 1 and user 2 (GPIO 0 and 37) bits 0, 1, 9, and 12 are "1" (data go in backwards)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()

    while True: 
        if cpu.read_debug_reg2() == 0xAA: 
            break
        await ClockCycles(caravelEnv.clk,1) 
    cpu.cpu_force_reset()

    await ClockCycles(caravelEnv.clk,100) 

    await cpu.drive_data2address(reg.get_addr('reg_wb_enable'),1) 
    await cpu.drive_data2address(reg.get_addr('reg_debug_1'),0xAA) 
    # await cpu.drive_data2address(reg.get_addr('reg_debug_2'),0xBB) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_datal'),0x0) 

    # await ClockCycles(caravelEnv.clk,100) 

    cpu.cpu_release_reset()

    while True: 
        if cpu.read_debug_reg2() == 0xBB: 
            break
        await ClockCycles(caravelEnv.clk,1) 

    await ClockCycles(caravelEnv.clk,100)
    