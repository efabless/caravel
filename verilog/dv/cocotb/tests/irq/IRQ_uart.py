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

async def write_reg_spi(caravelEnv,address,data):
    await caravelEnv.enable_csb()
    await caravelEnv.hk_write_byte(0x80) # Write stream command
    await caravelEnv.hk_write_byte(address) # Address (register 19 = GPIO bit-bang control)
    await caravelEnv.hk_write_byte(data) # Data = 0x01 (enable bit-bang mode)
    await caravelEnv.disable_csb()

reg = Regs()
"""Testbench of GPIO configuration through bit-bang method using the StriVe housekeeping SPI."""
@cocotb.test()
@repot_test
async def IRQ_uart(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=318039)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start IRQ_uart test")   
    pass_list = (0x1B,0x2B)
    fail_list = (0x1E,0x2E)
    phases_fails = 2
    phases_passes = 0
    reg1 =0 # buffer
    reg2 = 0 #buffer
    while True: 
        if reg2 != cpu.read_debug_reg2():
            reg2 = cpu.read_debug_reg2()
            if reg2 == 0xFF:  # test finish 
                break
            if reg2 == 0xAA:  
                cocotb.log.info(f"[TEST] start sending through uart")  

        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()                
            if reg1 in pass_list:  # pass phase
                phases_passes +=1
                phases_fails  -=1
                if reg1 == 0x1B:
                    cocotb.log.info(f"[TEST] Pass interrupt is detected when uart is sending data")  
                elif reg1 == 0x2B:
                    cocotb.log.info(f"[TEST] Pass interrupt isn't detected when uart isnt sending data")   
            elif reg1 in fail_list:  # pass phase
                if reg1 == 0x1E:
                    cocotb.log.info(f"[TEST] Failed interrupt isn't detected uart is sending data")  
                elif reg1 == 0x2E:
                    cocotb.log.error(f"[TEST] Failed interrupt is detected uart isnt sending data") 
            else: 
                cocotb.log.error(f"[TEST] debug register 1 has illegal value")  
        await ClockCycles(caravelEnv.clk,10) 

    if phases_fails != 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")     