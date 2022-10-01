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
from common import Macros

reg = Regs()

@cocotb.test()
@repot_test
async def bitbang_cpu_all_o(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=2075459)
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
async def bitbang_cpu_all_10(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=2863378)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = True # type of shifting 01 or 10
    for gpio in gpios_l:
        shift(uut._id(gpio,False),type)
        type = not type
    type = True # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        shift(uut._id(gpio,False),type)
        type = not type
       

def shift(gpio,shift_type):
    if shift_type: 
        bits = "0101010101010"
    else: 
        bits = "1010101010101"
    fail = False
    cocotb.log.info(f"[TEST] gpio {gpio} shift {gpio._id(f'shift_register',False).value} expected {bits}")
    for i in range(13):
        if gpio._id(f"shift_register",False).value.binstr[i] != bits[i]:
            fail = True
            cocotb.log.error(f"[TEST] wrong shift register {i} in {gpio}")
    if not fail: 
        cocotb.log.info(f"[TEST] gpio {gpio} passed")

@cocotb.test()
@repot_test
async def bitbang_cpu_all_01(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=2863378)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = False # type of shifting 01 or 10
    for gpio in gpios_l:
        shift(uut._id(gpio,False),type)
        type = not type
    type = False # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        shift(uut._id(gpio,False),type)
        type = not type

@cocotb.test()
@repot_test
async def bitbang_cpu_all_0011(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=5065204)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = 0 # type of shifting 01 or 10
    for gpio in gpios_l:
        shift_2(uut._id(gpio,False),type)
        type = (type + 1) %4
    type = 0 # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        shift_2(uut._id(gpio,False),type)
        type = (type + 1) %4

@cocotb.test()
@repot_test
async def bitbang_cpu_all_1100(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=10000000000)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = 2 # type of shifting 01 or 10
    for gpio in gpios_l:
        shift_2(uut._id(gpio,False),type)
        type = (type + 1) %4
    type = 2 # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        shift_2(uut._id(gpio,False),type)
        type = (type + 1) %4

def shift_2(gpio,shift_type):
    if shift_type == 0: 
        bits = "1001100110011"
    elif shift_type == 1: 
        bits = "1100110011001"
    elif shift_type == 2: 
        bits = "0110011001100"
    elif shift_type == 3: 
        bits = "0011001100110"
    fail = False
    cocotb.log.info(f"[TEST] gpio {gpio} shift {gpio._id(f'shift_register',False).value} expected {bits}")
    for i in range(13):
        if gpio._id(f"shift_register",False).value.binstr[i] != bits[i]:
            fail = True
            cocotb.log.error(f"[TEST] wrong shift register {i} in {gpio}")
    if not fail: 
        cocotb.log.info(f"[TEST] gpio {gpio} passed")


@cocotb.test()
@repot_test
async def bitbang_cpu_all_i(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=1691295)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xAA)
    cocotb.log.info(f"[TEST] configuration finished")
    data_in = 0x8F66FD7B
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[0:32]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xBB)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[0:32]")
    data_in = 0xFFA88C5A
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[0:32]")
    caravelEnv.drive_gpio_in((31,0),data_in)
    await wait_reg1(cpu,caravelEnv,0xCC)
    cocotb.log.info(f"[TEST] data {hex(data_in)} sent successfully to gpio[0:32]")
    data_in = 0xC9536346
    cocotb.log.info(f"[TEST] send {hex(data_in)} to gpio[0:32]")
    caravelEnv.drive_gpio_in((31,0),data_in)

    await wait_reg2(cpu,caravelEnv,0xFF) 
    cocotb.log.info(f"[TEST] finish")

