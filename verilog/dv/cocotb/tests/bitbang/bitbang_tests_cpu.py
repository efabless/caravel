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
from interfaces.common import Macros

reg = Regs()

@cocotb.test()
@repot_test
async def bitbang_cpu_all_o(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=2075459)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
   
    await wait_reg1(cpu,caravelEnv,0xFF)
    await caravelEnv.release_csb()
    cocotb.log.info("[TEST] finish configuring using bitbang")
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


    await ClockCycles(caravelEnv.clk, 10)


@cocotb.test()
@repot_test
async def bitbang_cpu_all_10(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=1581680)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = True # type of shifting 01 or 10
    for gpio in gpios_l:
        if not Macros['GL']:
            shift(uut._id(gpio,False),type)
        else: 
            shift(uut._id(f'\\{gpio} ',False),type)
        type = not type
    type = True # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        if not Macros['GL']:
            shift(uut._id(gpio,False),type)
        else: 
            shift(uut._id(f'\\{gpio} ',False),type)
        type = not type
       

def shift(gpio,shift_type):
    if shift_type: 
        bits = "0101010101010"
    else: 
        bits = "1010101010101"
    fail = False
    if not Macros['GL']:
        cocotb.log.info(f"[TEST] gpio {gpio} shift {gpio._id(f'shift_register',False).value} expected {bits}")
    for i in range(13):
        if not Macros['GL']:
            shift_register = gpio._id(f"shift_register",False).value.binstr[i]
        else:  
            shift_register = gpio._id(f"\\shift_register[{i}] ",False).value.binstr
        if shift_register != bits[i]:
            fail = True
            cocotb.log.error(f"[TEST] wrong shift register {i} in {gpio}")
    if not fail: 
        cocotb.log.info(f"[TEST] gpio {gpio} passed")

@cocotb.test()
@repot_test
async def bitbang_cpu_all_01(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=2863378)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = False # type of shifting 01 or 10
    for gpio in gpios_l:
        if not Macros['GL']:
            shift(uut._id(gpio,False),type)
        else: 
            shift(uut._id(f'\\{gpio} ',False),type)
        type = not type
    type = False # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        if not Macros['GL']:
            shift(uut._id(gpio,False),type)
        else: 
            shift(uut._id(f'\\{gpio} ',False),type)
        type = not type

@cocotb.test()
@repot_test
async def bitbang_cpu_all_0011(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=5963970)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = 2 # type of shifting 01 or 10
    for gpio in gpios_l:
        if not Macros['GL']:
            shift_2(uut._id(gpio,False),type)
        else: 
            shift_2(uut._id(f'\\{gpio} ',False),type)
        type = (type + 1) %4
    type = 2 # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        if not Macros['GL']:
            shift_2(uut._id(gpio,False),type)
        else: 
            shift_2(uut._id(f'\\{gpio} ',False),type)
        type = (type + 1) %4

@cocotb.test()
@repot_test
async def bitbang_cpu_all_1100(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=5962067)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    
    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    type = 0 # type of shifting 01 or 10
    for gpio in gpios_l:
        if not Macros['GL']:
            shift_2(uut._id(gpio,False),type)
        else: 
            shift_2(uut._id(f'\\{gpio} ',False),type)
        type = (type + 1) %4
    type = 0 # type of shifting 01 or 10
    for gpio in reversed(gpios_h):
        if not Macros['GL']:
            shift_2(uut._id(gpio,False),type)
        else: 
            shift_2(uut._id(f'\\{gpio} ',False),type)
        type = (type + 1) %4

def shift_2(gpio,shift_type):
    if shift_type == 0: 
        bits = "0011001100110"
    elif shift_type == 1: 
        bits = "0110011001100"
    elif shift_type == 2: 
        bits = "1100110011001"
    elif shift_type == 3: 
        bits = "1001100110011"
    fail = False
    if not Macros['GL']:
        cocotb.log.info(f"[TEST] gpio {gpio} shift {gpio._id(f'shift_register',False).value.binstr[::-1]} expected {bits}")
    else :
        shift_reg =''
        for i in range(13):
            shift_reg +=  gpio._id(f"\\shift_register[{i}] ",False).value.binstr
        cocotb.log.info(f"[TEST] gpio {gpio} shift {shift_reg} expected {bits}")
    for i in range(13):
        if not Macros['GL']:
            shift_register = gpio._id(f"shift_register",False).value.binstr[12-i]
        else:  
            shift_register = gpio._id(f"\\shift_register[{i}] ",False).value.binstr
        if shift_register != bits[i]:
            fail = True
            cocotb.log.error(f"[TEST] wrong shift register {i} in {gpio}")
    if not fail: 
        cocotb.log.info(f"[TEST] gpio {gpio} passed")


@cocotb.test()
@repot_test
async def bitbang_cpu_all_i(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=1691295)
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



"""Testbench of GPIO configuration through bit-bang method using the housekeeping SPI configure all gpio as output."""
@cocotb.test()
@repot_test
async def bitbang_spi_o(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=2639757)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()

    await wait_reg1(cpu,caravelEnv,0xFF) # wait for housekeeping registers configured
    #Configure all as output except reg_mprj_io_3
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 18	and 19	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 17	and 20	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 16	and 21	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 15	and 22	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 14	and 23	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 13	and 24	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 12	and 25	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 11	and 26	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 10	and 27	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 9	and 28	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 8	and 29	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 7	and 30	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 6	and 31	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 5	and 32	
    await clock_in_right_o_left_i_standard_spi(caravelEnv,0) # 4	and 33	
    await clock_in_right_o_left_i_standard_spi(caravelEnv,0) # 3	and 34	
    await clock_in_right_o_left_i_standard_spi(caravelEnv,0) # 2	and 35	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 1	and 36	
    await clock_in_right_o_left_o_standard_spi(caravelEnv,0) # 0	and 37	
    await load_spi(caravelEnv)		                         # load

    cpu.write_debug_reg2_backdoor(0xFF)
    cocotb.log.info("[TEST] finish configuring using bitbang")
    i= 0x20
    for j in range(5):
        await wait_reg2(cpu,caravelEnv,37-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,5))} j = {j}')
        if caravelEnv.monitor_gpio((37,5)).integer != i << 27:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,5))} instead of {bin(i << 28)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,5)).integer != 0:
            cocotb.log.error(f'[TEST] Wrong gpio output {caravelEnv.monitor_gpio((37,5))} instead of {bin(0x00000)}')
        i = i >> 1
        i |= 0x20

    i= 0x80000000
    for j in range(32):
        await wait_reg2(cpu,caravelEnv,32-j)
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,5))} j = {j}')
        if caravelEnv.monitor_gpio((37,32)).integer != 0x3f:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,32))} instead of {bin(0x3f)} ')
        if caravelEnv.monitor_gpio((31,5)).integer != i>>5 :
            cocotb.log.error(f'[TEST] Wrong gpio low bits output {caravelEnv.monitor_gpio((31,4))} instead of {bin(i>>4)}')
        await wait_reg2(cpu,caravelEnv,0)
        if caravelEnv.monitor_gpio((37,5)).integer != 0:
            cocotb.log.error(f'Wrong gpio output {caravelEnv.monitor_gpio((37,5))} instead of {bin(0x00000)}')

        i = i >> 1
        i |= 0x80000000


    await ClockCycles(caravelEnv.clk, 10)


"""Testbench of GPIO configuration through bit-bang method using the housekeeping SPI configure all gpio as input."""
@cocotb.test()
@repot_test
async def bitbang_spi_i(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=11156703)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()

    await wait_reg1(cpu,caravelEnv,0xFF) # wait for housekeeping registers configured
    #Configure all as output except reg_mprj_io_3
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 18	and 19	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 17	and 20	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 16	and 21	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 15	and 22	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 14	and 23	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 13	and 24	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 12	and 25	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 11	and 26	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 10	and 27	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 9	and 28	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 8	and 29	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 7	and 30	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 6	and 31	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 5	and 32	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 4	and 33	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 3	and 34	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 2	and 35	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 1	and 36	
    await clock_in_right_i_left_i_standard_spi(caravelEnv,0) # 0	and 37	
    await load_spi(caravelEnv)		                         # load
    cpu.write_debug_reg2_backdoor(0xDD)
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