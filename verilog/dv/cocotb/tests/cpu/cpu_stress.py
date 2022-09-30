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
"""stress the cpu with heavy processing"""
@cocotb.test()
@repot_test
async def cpu_stress(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=1492434)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start CPU stress test")   
    pass_list = (0x1B,0x2B,0x3B,0x4B,0x5B)
    fail_list = (0x1E,0x2E,0x3E,0x4E,0x5E)
    phases_fails = 5
    phases_passes = 0
    reg1 =0 # buffer
    while True: 
        if cpu.read_debug_reg2() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                phases_passes +=1
                phases_fails  -=1
                cocotb.log.info(f"[TEST] pass phase {hex(reg1)[2]}")   
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed phase {hex(reg1)[2]}")     
        await ClockCycles(caravelEnv.clk,1) 
    
    if phases_fails > 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")        
