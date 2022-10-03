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
async def IRQ_timer(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=166519)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start IRQ_timer test")   
    pass_list = (0x1B,0x2B)
    fail_list = (0x1E,0x2E)
    phases_fails = 2
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
                if reg1 == 0x1B:
                    cocotb.log.info(f"[TEST] Pass interrupt is detected when timer is used")  
                elif reg1 == 0x2B:
                    cocotb.log.info(f"[TEST] Pass interrupt isn't detected when timer isnt used")   
            elif reg1 in fail_list:  # pass phase
                if reg1 == 0x1E:
                    cocotb.log.info(f"[TEST] Failed interrupt isn't detected when timer is used")  
                elif reg1 == 0x2E:
                    cocotb.log.error(f"[TEST] Failed interrupt is detected when timer isnt used") 
            else: 
                cocotb.log.error(f"[TEST] debug register 1 has illegal value")  
        await ClockCycles(caravelEnv.clk,10) 

    if phases_fails != 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")     