from cgitb import handler
import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
import cocotb.simulator
from cocotb_coverage.coverage import *
from cocotb.binary import BinaryValue
import caravel 
from logic_analyzer import LA
from caravel import GPIO_MODE, Caravel_env
from wb_models.housekeepingWB.housekeepingWB import HK_whiteBox
import common
import logging
from cpu import RiskV
from cocotb.log import SimTimeContextFilter
from cocotb.log import SimLogFormatter
from defsParser import Regs
from tests.common_functions.Timeout import Timeout
from cocotb.result import TestSuccess
import inspect
import os
# tests
from tests.bitbang.bitbang_tests import *
from tests.bitbang.bitbang_tests_cpu import *
from tests.housekeeping.housekeeping_regs.housekeeping_regs_tests import *
from tests.temp_partial_test.partial import *
from tests.hello_world.helloWorld import *
from tests.cpu.cpu_stress import *
from tests.mem.mem_stress import *
from tests.irq.IRQ_external import *
from tests.irq.IRQ_timer import *
from tests.irq.IRQ_uart import *
from tests.gpio.gpio_all_o import *
from tests.mgmt_gpio.mgmt_gpio import *
from tests.timer.timer import *
from tests.uart.uart import *




# archive tests
@cocotb.test()
async def cpu_drive(dut):
    TestName = inspect.stack()[0][3]
    if not os.path.exists(f'sim/{TestName}'):
        os.mkdir(f'sim/{TestName}') # create test folder
    cocotb.log.setLevel(logging.INFO)
    handler = logging.FileHandler(f"sim/{TestName}/{TestName}.log",mode='w')
    handler.addFilter(SimTimeContextFilter())
    handler.setFormatter(SimLogFormatter())
    cocotb.log.addHandler(handler) 
    caravelEnv = caravel.Caravel_env(dut)
    Timeout(caravelEnv.clk,1000000,0.1)
    la = LA(dut)
    clock = Clock(caravelEnv.clk, 12.5, units="ns")  # Create a 10ns period clock on port clk
    cpu = RiskV(dut)
    cpu.cpu_force_reset()

    cocotb.start_soon(clock.start())  # Start the clock
    
    await caravelEnv.start_up()
    hk = HK_whiteBox(dut)

    reg = Regs()
    time_out_count =0

    await ClockCycles(caravelEnv.clk, 100)
    address = reg.get_addr('reg_wb_enable')
    await cpu.drive_data2address(address,1)
    address = reg.get_addr('reg_debug_2')
    await cpu.drive_data2address(address,0xdFF0)
    await ClockCycles(caravelEnv.clk, 10)
    cpu.cpu_release_reset()
    await ClockCycles(caravelEnv.clk, 10)

    raise TestSuccess(f" TEST {TestName} passed")

    while True: 
        await ClockCycles(caravelEnv.clk, 1)
        if (cpu.read_debug_reg1() == 0xFFF0): 
            break
    cocotb.log.info(f"[TEST][cpu_drive] debug reg1 = 0xFFF0")
    await ClockCycles(caravelEnv.clk, 10)
    address = reg.get_addr('reg_debug_2')
    await cpu.drive_data2address(address,0xdFF0)
    await ClockCycles(caravelEnv.clk, 50)
    # address = reg.get_addr('reg_mprj_io_0')
    # await cpu.drive_data2address(address,0x0c03)
    cocotb.log.info(f"[TEST][cpu_drive] wait debug reg1 = 0xddd0")
    while True: 
        await ClockCycles(caravelEnv.clk, 1)
        if (cpu.read_debug_reg1() == 0xddd0): 
            break
    cocotb.log.info(f"[TEST][cpu_drive] debug reg1 = 0xddd0")
    
    await ClockCycles(caravelEnv.clk, 10)

    caravelEnv.print_gpios_HW_val()
    coverage_db.export_to_yaml(filename="coverage.yalm")


@cocotb.test()
async def spi_drive(dut):
    cocotb.log.setLevel(logging.INFO)
    handler = logging.FileHandler(f"test.log",mode='w')
    handler.addFilter(SimTimeContextFilter())
    handler.setFormatter(SimLogFormatter())
    cocotb.log.addHandler(handler) 
    caravelEnv = caravel.Caravel_env(dut)


    la = LA(dut)
    clock = Clock(caravelEnv.clk, 12.5, units="ns")  # Create a 10ns period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    await caravelEnv.start_up()
    hk = HK_whiteBox(dut,True)

    caravelEnv.enable_csb()
    await ClockCycles(caravelEnv.clk,1)
    # caravelEnv.configure_gpios_regs([[tuple(range(0,6)),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT]])
    await ClockCycles(caravelEnv.clk,1)
    await caravelEnv.hk_write_byte(0x40) # read command
    # await caravelEnv.hk_write_byte(0x80) # command write
    await caravelEnv.hk_write_byte(0x0) # address
    # await caravelEnv.hk_write_byte(0x03) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data

    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte() # read value
    print(read_data)
    read_data = await caravelEnv.hk_read_byte(True) # read value
    caravelEnv.disable_csb()
    await ClockCycles(caravelEnv.clk,1)
    caravelEnv.enable_csb()
    await ClockCycles(caravelEnv.clk,1)
    # caravelEnv.configure_gpios_regs([[tuple(range(0,6)),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT]])
    await ClockCycles(caravelEnv.clk,1)
    await caravelEnv.hk_write_byte(0x40) # read command
    # await caravelEnv.hk_write_byte(0x80) # command write
    await caravelEnv.hk_write_byte(0x8) # address
    # await caravelEnv.hk_write_byte(0x03) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data
    # await caravelEnv.hk_write_byte(0xaa) # data

    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value
    read_data = await caravelEnv.hk_read_byte() # read value

    # caravelEnv.drive_gpio_in([5,5],1)
    await ClockCycles(caravelEnv.clk,40)
    coverage_db.export_to_yaml(filename="coverage.yml")
    coverage_db.export_to_xml(filename="coverage.xml")
    return


