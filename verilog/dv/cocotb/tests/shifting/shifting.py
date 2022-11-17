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
async def serial_shifting_10(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=37825)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    if  Macros['CARAVAN']:
        gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]")

    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    if  Macros['CARAVAN']:
        gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")    
    
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


@cocotb.test()
@repot_test
async def serial_shifting_01(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=37825)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    if  Macros['CARAVAN']:
        gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]")

    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    if  Macros['CARAVAN']:
        gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")  

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
async def serial_shifting_0011(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=36724)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    if  Macros['CARAVAN']:
        gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]")

    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    if  Macros['CARAVAN']:
        gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")  

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
async def serial_shifting_1100(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=36734)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    uut = dut.uut
    await wait_reg1(cpu,caravelEnv,0xFF)
    gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]","gpio_control_in_1[6]","gpio_control_in_1[7]","gpio_control_in_1[8]","gpio_control_in_1[9]","gpio_control_in_1[10]")
    if  Macros['CARAVAN']:
        gpios_l = ("gpio_control_bidir_1[0]","gpio_control_bidir_1[1]","gpio_control_in_1a[0]","gpio_control_in_1a[1]","gpio_control_in_1a[2]","gpio_control_in_1a[3]","gpio_control_in_1a[4]","gpio_control_in_1a[5]","gpio_control_in_1[0]","gpio_control_in_1[1]","gpio_control_in_1[2]","gpio_control_in_1[3]","gpio_control_in_1[4]","gpio_control_in_1[5]")

    gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_in_2[10]","gpio_control_in_2[11]","gpio_control_in_2[12]","gpio_control_in_2[13]","gpio_control_in_2[14]","gpio_control_in_2[15]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")
    if  Macros['CARAVAN']:
        gpios_h= ("gpio_control_in_2[0]","gpio_control_in_2[1]","gpio_control_in_2[2]","gpio_control_in_2[3]","gpio_control_in_2[4]","gpio_control_in_2[5]","gpio_control_in_2[6]","gpio_control_in_2[7]","gpio_control_in_2[8]","gpio_control_in_2[9]","gpio_control_bidir_2[0]","gpio_control_bidir_2[1]","gpio_control_bidir_2[2]")  
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
        cocotb.log.info(f"[TEST] gpio {gpio} shift {hex(int(gpio._id(f'shift_register',False).value.binstr,2))}({gpio._id(f'shift_register',False).value.binstr}) expected {hex(int(bits,2))}({bits})")
    else :
        shift_reg =''
        for i in range(13):
            shift_reg +=  gpio._id(f"\\shift_register[{i}] ",False).value.binstr
        cocotb.log.info(f"[TEST] gpio {gpio} shift {shift_reg} expected {bits}")
    for i in range(13):
        if not Macros['GL']:
            shift_register = gpio._id(f"shift_register",False).value.binstr[i]
        else:  
            shift_register = gpio._id(f"\\shift_register[{12-i}] ",False).value.binstr
        if shift_register != bits[i]:
            fail = True
            cocotb.log.error(f"[TEST] wrong shift register {12-i} in {gpio}")
    if not fail: 
        cocotb.log.info(f"[TEST] gpio {gpio} passed")
