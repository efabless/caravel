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

reg = Regs()

@cocotb.test()
@repot_test
async def gpio_all_o_user(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=585321)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
   
    await wait_reg1(cpu,caravelEnv,0xAA)
    cocotb.log.info("[TEST] finish configuring as user output")
    i= 0x20
    for j in range(5):
        await wait_reg2(cpu,caravelEnv,37-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,0))} j = {j}')
        if caravelEnv.monitor_gpio((37,0)).integer != i<<32:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,0))} instead of {bin(i<<32)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,0)).integer != 0:
            cocotb.log.error(f'[TEST] Wrong gpio output {caravelEnv.monitor_gpio((37,0))} instead of {bin(0x00000)}')
        i = i >> 1
        i |= 0x20

    i= 0x80000000
    for j in range(32):
        await wait_reg2(cpu,caravelEnv,32-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,0))} j = {j}')
        if caravelEnv.monitor_gpio((37,32)).integer != 0x3f:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,32))} instead of {bin(0x3f)} ')
        if caravelEnv.monitor_gpio((31,0)).integer != i :
            cocotb.log.error(f'[TEST] Wrong gpio low bits output {caravelEnv.monitor_gpio((31,0))} instead of {bin(i)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,0)).integer != 0:
            cocotb.log.error(f'Wrong gpio output {caravelEnv.monitor_gpio((37,0))} instead of {bin(0x00000)}')

        i = i >> 1
        i |= 0x80000000

    await wait_reg1(cpu,caravelEnv,0XBB)
    data_in = 0x8F66FD7B
    cocotb.log.info(f"[TEST] try send {hex(data_in)} to gpio[31:0]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    reg2 =0
    await wait_reg1(cpu,caravelEnv,0XFF)
    try:
        reg2 =cpu.read_debug_reg2()
        if reg2 == data_in:
            cocotb.log.error(f"[TEST] Error: data {hex(data_in)} driven on gpio[31:0]  is seen by firmware while gpios are configured as output")
        else: 
            cocotb.log.info(f"[TEST] driven data {hex(data_in)} sent can't be sent to gpio[31:0] when it configure as output it can see {reg2}")
    except Exception as e:
        cocotb.log.info(f"[TEST] driven data {hex(data_in)} sent can't be sent to gpio[31:0] when it configure as output")
        return
    
   
    await ClockCycles(caravelEnv.clk, 10)
