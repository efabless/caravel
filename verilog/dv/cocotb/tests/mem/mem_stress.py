import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from interfaces.caravel import GPIO_MODE

reg = Regs()
@cocotb.test()
@repot_test
async def mem_dff2_W(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=1803911)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff2 word access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if cpu.read_debug_reg1() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff2 memory ")   
                break
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x00000400 + cpu.read_debug_reg2())}")     
                break
        await ClockCycles(caravelEnv.clk,1000) 

@cocotb.test()
@repot_test
async def mem_dff2_HW(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=3589591)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff2 half word access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if cpu.read_debug_reg1() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff2 memory ")   
                break
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x00000400 + cpu.read_debug_reg2())}")     
                break
        await ClockCycles(caravelEnv.clk,1000) 


@cocotb.test()
@repot_test
async def mem_dff2_B(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=4883401)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff2 Byte access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if cpu.read_debug_reg1() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff2 memory ")   
                break
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x00000400 + cpu.read_debug_reg2())}")     
                break
        await ClockCycles(caravelEnv.clk,1000) 


@cocotb.test()
@repot_test
async def mem_dff_W(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=3591611)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff word access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff memory ")  
                break 
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x0000000 + cpu.read_debug_reg2())}")     
                break 
        await ClockCycles(caravelEnv.clk,1000) 
    

@cocotb.test()
@repot_test
async def mem_dff_HW(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=7161961)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff half word access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff memory ")  
                break 
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x0000000 + cpu.read_debug_reg2())}")     
                break 
        await ClockCycles(caravelEnv.clk,1000) 
    
   
@cocotb.test()
@repot_test
async def mem_dff_B(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=9752611)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start mem dff Byte access stress test")   
    pass_list = [0x1B]
    fail_list = [0x1E]
    reg1 =0 # buffer
    while True: 
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()
            if reg1 in pass_list:  # pass phase
                cocotb.log.info(f"[TEST] pass writing and reading all dff memory ")  
                break 
            elif reg1 in fail_list:  # pass phase
                cocotb.log.error(f"[TEST] failed access address {hex(0x0000000 + cpu.read_debug_reg2())}")     
                break 
        await ClockCycles(caravelEnv.clk,1000) 
    
   