from faulthandler import disable
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
from cocotb.binary import BinaryValue
from tests.housekeeping.housekeeping_spi.spi_access_functions import *

reg = Regs()
caravel_clock = 0
user_clock = 0
core_clock = 0
@cocotb.test()
@repot_test
async def clock_redirect(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=13052)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    error_margin = 0.1
    # calculate core clock
    await  cocotb.start(calculate_clk_period(dut.uut.clock,"core clock"))  
    await ClockCycles(caravelEnv.clk,110)
    cocotb.log.info(f"[TEST]  core clock requency = {round(1000000/core_clock,2)} MHz period = {core_clock}ps")
    await wait_reg1(cpu,caravelEnv,0xAa)
    # check clk redirect working 
    #user clock
    clock_name = "user clock"
    await write_reg_spi(caravelEnv,0x1b,0x0) # disable user clock output redirect
    await  cocotb.start(calculate_clk_period(dut.bin14_monitor,clock_name))  
    await ClockCycles(caravelEnv.clk,110)
    if user_clock  != 0:
        cocotb.log.error(f"[TEST] Error: {clock_name} is directed while clk2_output_dest is disabled")
    else: 
        cocotb.log.info(f"[TEST] Pass: {clock_name} has not directed when reg clk2_output_dest is disabled")

    await write_reg_spi(caravelEnv,0x1b,0x4) # enable user clock output redirect
    await  cocotb.start(calculate_clk_period(dut.bin14_monitor,clock_name))  
    await ClockCycles(caravelEnv.clk,110)   
    if  abs(user_clock - core_clock) > (error_margin*core_clock):
        cocotb.log.error(f"[TEST] Error: {clock_name} is directed with wrong value {clock_name} period = {user_clock} and core clock = {core_clock}")
    else: 
        cocotb.log.info(f"[TEST] Pass: {clock_name} has directed successfully")

    #caravel clock
    clock_name = "caravel clock"
    await write_reg_spi(caravelEnv,0x1b,0x0) # disable caravel clock output redirect
    await  cocotb.start(calculate_clk_period(dut.bin14_monitor,clock_name))  
    await ClockCycles(caravelEnv.clk,110)
    if caravel_clock  != 0:
        cocotb.log.error(f"[TEST] Error: {clock_name} is directed while clk2_output_dest is disabled")
    else: 
        cocotb.log.info(f"[TEST] Pass: {clock_name} has not directed when reg clk2_output_dest is disabled")

    await write_reg_spi(caravelEnv,0x1b,0x4) # enable caravel clock output redirect
    await  cocotb.start(calculate_clk_period(dut.bin15_monitor,clock_name))  
    await ClockCycles(caravelEnv.clk,110)
    if abs(caravel_clock - core_clock) > error_margin*core_clock:
        cocotb.log.error(f"[TEST] Error: {clock_name} is directed with wrong value {clock_name} period = {caravel_clock} and core clock = {core_clock}")
    else: 
        cocotb.log.info(f"[TEST] Pass: {clock_name} has directed successfully")


async def calculate_clk_period(clk,name):
    await RisingEdge(clk)
    initial_time = cocotb.simulator.get_sim_time()
    initial_time = (initial_time[0] <<32) | (initial_time[1])
    for i in range(100):
        await RisingEdge(clk)
    end_time = cocotb.simulator.get_sim_time()
    end_time = (end_time[0] <<32) | (end_time[1])
    val = (end_time - initial_time) / 100
    cocotb.log.debug(f"[TEST] clock of {name} is {val}")
    if name == "caravel clock":
        global caravel_clock
        caravel_clock = val
    elif name == "user clock":
        global user_clock
        user_clock = val 
    elif name == "core clock":
        global core_clock
        core_clock = val         
    return val


@cocotb.test()
@repot_test
async def hk_disable(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=11393)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()

    # check spi working by writing to PLL enables
    old_pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {old_pll_enable}")
    await write_reg_spi(caravelEnv,0x8,1-old_pll_enable)
    pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {pll_enable}")
    if pll_enable == 1-old_pll_enable: 
        cocotb.log.info(f"[TEST] Pass: SPI swap pll_enable value from {old_pll_enable} to {pll_enable}") 
    else: 
        cocotb.log.error(f"[TEST] Error: SPI isn't working correctly it cant change pll from {old_pll_enable} to {1-old_pll_enable}")
    old_pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {old_pll_enable}")
    await write_reg_spi(caravelEnv,0x8,1-old_pll_enable)
    pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {pll_enable}")
    if pll_enable == 1-old_pll_enable: 
        cocotb.log.info(f"[TEST] Pass: SPI swap pll_enable value from {old_pll_enable} to {pll_enable}") 
    else: 
        cocotb.log.error(f"[TEST] Error: SPI isn't working correctly it cant change pll from {old_pll_enable} to {1-old_pll_enable}")
            
    # disable Housekeeping SPIca 
    await write_reg_spi(caravelEnv,0x6f,0x1)

    # try to change pll_en 
    old_pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {old_pll_enable}")
    await write_reg_spi(caravelEnv,0x8,1-old_pll_enable)
    pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {pll_enable}")
    if pll_enable == 1-old_pll_enable: 
        cocotb.log.error(f"[TEST] Error: SPI swap pll_enable value from {old_pll_enable} to {pll_enable} while housekeeping spi is disabled") 
    else: 
        cocotb.log.info(f"[TEST] pass: SPI isn't working when SPI housekeeping is disabled")
            
    # enable SPI housekeeping through firmware 
    await wait_reg2(cpu,caravelEnv,0xBB)  # start waiting on reg1 AA
    cpu.write_debug_reg1_backdoor(0xAA) 
    await wait_reg1(cpu,caravelEnv,0xBB) # enabled the housekeeping

    old_pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {old_pll_enable}")
    await write_reg_spi(caravelEnv,0x8,1-old_pll_enable)
    pll_enable = dut.uut.housekeeping.pll_ena.value.integer
    cocotb.log.debug(f"[TEST] pll_enable = {pll_enable}")
    if pll_enable == 1-old_pll_enable: 
        cocotb.log.info(f"[TEST] Pass: Housekeeping SPI has been enabled correctly through firmware") 
    else: 
        cocotb.log.error(f"[TEST] Error: Housekeeping SPI failed to be enabled through firmware")
            