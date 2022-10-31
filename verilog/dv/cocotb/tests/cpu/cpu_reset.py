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
from tests.housekeeping.housekeeping_spi.spi_access_functions import *

reg = Regs()
@cocotb.test()
@repot_test
async def cpu_reset(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=34823)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start cpu_reset test")   
    # wait for CPU to write 5 at debug_reg1
    while True: 
        if cpu.read_debug_reg1() == 5:
            cocotb.log.info("[TEST] debug reg 1 = 5" )
            break
        await ClockCycles(caravelEnv.clk,1) 
    
    # put the cpu under reset using spi 
    cocotb.log.info("[TEST] asserting cpu reset register using SPI")
    await write_reg_spi(caravelEnv,0xb,1)

    await ClockCycles(caravelEnv.clk,1000) 
    if cpu.read_debug_reg1() == 0:
        cocotb.log.info("[TEST] asserting cpu reset register using SPI successfully rest the cpu")
    else: 
        cocotb.log.error("[TEST] asserting  cpu reset register using SPI successfully doesn't rest the cpu")

    cocotb.log.info("[TEST] deasserting cpu reset register using SPI")
    await write_reg_spi(caravelEnv,0xb,0)
    watchdog = 12000
    while True: 
        if cpu.read_debug_reg1() == 5:
            cocotb.log.info("[TEST] deasserting cpu reset register using SPI  wakes the cpu up" )
            break
        watchdog -=1
        if watchdog <0: 
            cocotb.log.error("[TEST] deasserting cpu reset register using SPI doesn't wake the cpu up" )
            break

        await ClockCycles(caravelEnv.clk,1) 

    cocotb.log.info("[TEST] asserting cpu reset register using firmware")
    cpu.write_debug_reg2_backdoor(0xAA)
    await ClockCycles(caravelEnv.clk,10000) 

    watchdog = 8000
    while True: 
        if cpu.read_debug_reg1() == 0:
            cocotb.log.info("[TEST] asserting cpu reset register using firmware successfully rest the cpu" )
            break
        watchdog -=1
        if watchdog <0: 
            cocotb.log.error("[TEST] asserting  cpu reset register using firmware successfully doesn't rest the cpu" )
            break

    await ClockCycles(caravelEnv.clk,100) 
