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
async def timer0_oneshot(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=1114136)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start timer0_oneshot test")   
    cocotb.log.info(f"[TEST] Configure timer as oneshot")   
    pass_list = (0x1B,0x2B,0x3B)
    fail_list = (0x1E,0x2E)
    phases_fails = 3
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
                    cocotb.log.info(f"[TEST] Pass timer0 value is decreasing")  
                elif reg1 == 0x2B:
                    cocotb.log.info(f"[TEST] Pass timer0 value reach 0")  
                elif reg1 == 0x3B:
                    cocotb.log.info(f"[TEST] Pass timer0 isn't changing after it reachs 0")   
            elif reg1 in fail_list:  # pass phase
                if reg1 == 0x1E:
                    cocotb.log.info(f"[TEST] Failed timer0 value increasing not decresing in oneshot mode")  
                elif reg1 == 0x2E:
                    cocotb.log.error(f"[TEST] Failed timer0 is changing before it reachs 0 in oneshot mode") 
            else: 
                cocotb.log.error(f"[TEST] debug register 1 has illegal value")  
        await ClockCycles(caravelEnv.clk,10) 

    if phases_fails != 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")    
        
@cocotb.test()
@repot_test
async def timer0_periodic(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=58257)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start timer0_periodic test")   
    cocotb.log.info(f"[TEST] Configure timer as periodic")   
    pass_list = (0x1B,0x2B,0x3B,0x4B)
    fail_list = (0xEE)
    phases_fails = 4
    phases_passes = 0
    reg1 =0 # buffer
    fourB_happened = False
    while True: 
        if cpu.read_debug_reg2() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()                
            if reg1 in pass_list:  # pass phase
                phases_passes +=1
                phases_fails  -=1
                if reg1 == 0x1B:
                    cocotb.log.info(f"[TEST] Pass timer0 first rollover")  
                elif reg1 == 0x2B:
                    cocotb.log.info(f"[TEST] Pass timer0 second rollover")  
                elif reg1 == 0x3B:
                    cocotb.log.info(f"[TEST] Pass timer0 third rollover")   
                elif reg1 == 0x4B:
                    if fourB_happened: # this phase happened one time before
                        phases_passes -=1
                        phases_fails  +=1 
                    else:
                        cocotb.log.info(f"[TEST] Pass timer0 counter value decreases")  
                        fourB_happened = True 
            elif reg1 in fail_list:  # pass phase
                if reg1 == 0xEE:
                    cocotb.log.info(f"[TEST] Failed timer0 value hasn't rollovered in periodic mode")  
            else: 
                cocotb.log.error(f"[TEST] debug register 1 has illegal value")  
               
        await ClockCycles(caravelEnv.clk,10) 

    if phases_fails != 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")     