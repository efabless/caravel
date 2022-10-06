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
from cocotb.binary import BinaryValue

reg = Regs()

@cocotb.test()
@repot_test
async def gpio_all_o(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=264012)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
   
    await wait_reg1(cpu,caravelEnv,0xFF)
    cocotb.log.info("[TEST] finish configuring using bitbang")
    i= 0x20
    for j in range(5):
        await wait_reg2(cpu,caravelEnv,37-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,4))} j = {j}')
        if caravelEnv.monitor_gpio((37,4)).integer != i << 28:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,4))} instead of {bin(i << 28)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,4)).integer != 0:
            cocotb.log.error(f'[TEST] Wrong gpio output {caravelEnv.monitor_gpio((37,4))} instead of {bin(0x00000)}')
        i = i >> 1
        i |= 0x20

    i= 0x80000000
    for j in range(32):
        await wait_reg2(cpu,caravelEnv,32-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,4))} j = {j}')
        if caravelEnv.monitor_gpio((37,32)).integer != 0x3f:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,32))} instead of {bin(0x3f)} ')
        if caravelEnv.monitor_gpio((31,4)).integer != i>>4 :
            cocotb.log.error(f'[TEST] Wrong gpio low bits output {caravelEnv.monitor_gpio((31,4))} instead of {bin(i>>4)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,4)).integer != 0:
            cocotb.log.error(f'Wrong gpio output {caravelEnv.monitor_gpio((37,4))} instead of {bin(0x00000)}')

        i = i >> 1
        i |= 0x80000000


    await ClockCycles(caravelEnv.clk, 10)


@cocotb.test()
@repot_test
async def gpio_all_i(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=44980)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xAA)
    cocotb.log.info(f"[TEST] configuration finished")
    data_in = 0x8F66FD7B
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[31:0]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xBB)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[31:0]")
    data_in = 0xFFA88C5A
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[31:0]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xCC)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[31:0]")
    data_in = 0xC9536346
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[31:0]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xD1)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[31:0]")
    data_in = 0x3F
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[37:32]")
    caravelEnv.drive_gpio_in((37,32),data_in)
    await wait_reg1(cpu,caravelEnv,0xD2)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[37:32]")
    data_in = 0x0
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[37:32]")
    caravelEnv.drive_gpio_in((37,32),data_in)
    await wait_reg1(cpu,caravelEnv,0xD3)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[37:32]")
    data_in = 0x15
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[37:32]")
    caravelEnv.drive_gpio_in((37,32),data_in)
    await wait_reg1(cpu,caravelEnv,0xD4)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[37:32]")
    data_in = 0x2A
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[37:32]")
    caravelEnv.drive_gpio_in((37,32),data_in) 
    await wait_reg2(cpu,caravelEnv,0xFF) 
    cocotb.log.info(f"[TEST] finish")


@cocotb.test()
@repot_test
async def gpio_all_i_pu(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=1245464)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut

    # for i in range(200):
    #     caravelEnv.drive_gpio_in((31,0),0x0)
    #     await ClockCycles(caravelEnv.clk,10000) 
    #     caravelEnv.drive_gpio_in((31,0),0xFFFFFFFF)
    #     await ClockCycles(caravelEnv.clk,10000) 
    
    # return
    await wait_reg1(cpu,caravelEnv,0xAA)

    cocotb.log.info(f"[TEST] configuration finished")
    await wait_reg1(cpu,caravelEnv,0xB1)
    data_in = 0x0
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[31:0]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xB2)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[31:0]")
    size = 32
    data_in =  int(size) * 'z'
    data_in =  0xFFFFFFFF
    cocotb.log.info(f"[TEST] send {data_in} to gpio[31:0]")
    caravelEnv.release_gpio((31,0))
    await wait_reg1(cpu,caravelEnv,0xB3)
    cocotb.log.info(f"[TEST] data {data_in} sent successfully to gpio[31:0]")
    data_in = 0x0
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[0:16]")
    caravelEnv.drive_gpio_in((15,0),data_in)

    # await wait_reg2(cpu,caravelEnv,0xFF) 
    cocotb.log.info(f"[TEST] finish")


    await wait_reg1(cpu,caravelEnv,0xFF)



