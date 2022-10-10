import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.spi_master.SPI_VIP import read_mem ,SPI_VIP
from interfaces.caravel import GPIO_MODE


bit_time_ns = 0
reg = Regs()


@cocotb.test()
@repot_test
async def spi_master_rd(dut):
    """ the firmware is configured to always send clk to spi so I can't insert alot of logics reading values  
    
    the method of testing used can't work if 2 addresses Consecutive have the same address
    """

    caravelEnv,clock = await test_configure(dut,timeout_cycles=214842)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info (f"[TEST] start spi_master_rd test")
    file_name = f"{os.getenv('CARAVEL_VERILOG_PATH')}/dv/cocotb/tests/spi_master/test_data"
    mem = read_mem(file_name)
    await  cocotb.start(SPI_VIP(dut.bin33_monitor,dut.bin32_monitor,dut.bin35_monitor,(dut.bin34_en,dut.bin34),mem)) # fork for SPI 

    addresses_to_read = (0x04,0x05,0x06,0x8,0x9,0xa,0xb,0xc,0xd,0xe,0xf) # the addresses that the firmware read from mem file 
    await wait_reg2(cpu,caravelEnv,0XAA) 
    cocotb.log.info (f"[TEST] GPIO configuration finished ans start reading from mememory")
    val =0
    for address in addresses_to_read:
        # await wait_reg2(cpu,caravelEnv,0x55) # value is ready to be read
        #wait until value change 
        while True:
            if val != cpu.read_debug_reg1():
                break
            await ClockCycles(caravelEnv.clk,100) 
    
        expected_val = mem[address]
        val = cpu.read_debug_reg1()
        if val == expected_val:
            cocotb.log.info(f"[TEST] correct read of value {hex(val)} from address {hex(address)} ")
        else: 
            cocotb.log.error(f"[TEST] wrong read from address {hex(address)} expected value = {hex(expected_val)} value {hex(val)}  ")
        # cpu.write_debug_reg2_backdoor(0xCC)

    await ClockCycles(caravelEnv.clk,1000) 



@cocotb.test()
@repot_test
async def spi_master_temp(dut):
    """ the firmware is configured to always send clk to spi so I can't insert alot of logics reading values  
    
    the method of testing used can't work if 2 addresses Consecutive have the same address
    """
    caravelEnv,clock = await test_configure(dut,timeout_cycles=214842)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info (f"[TEST] start spi_master_temp test")
    await FallingEdge(dut.bin33_monitor)
    await RisingEdge(dut.bin32_monitor) 
    a = ''
    b = ''
    # first value 
    for i in range(8): 
        a = a + dut.bin35_monitor.value.binstr
        await RisingEdge(dut.bin32_monitor)
    cocotb.log.info (f" [TEST] a = {a} = {int(a,2)}")

    # second val
    for i in range(8): 
        b = b + dut.bin35_monitor.value.binstr
        await RisingEdge(dut.bin32_monitor)
    cocotb.log.info (f" [TEST] b = {b} = {int(b,2)}")

    s = int(a,2) + int(b,2)
    s_bin = bin(s)[2:].zfill(8)
    cocotb.log.info (f" [TEST] sending sum of {int(a,2)} + {int(b,2)} = {s} = {s_bin}")
    for i in range(8):
        dut.bin34_en.value = 1
        dut.bin34.value = int(s_bin[i],2) # bin 
        cocotb.log.debug (f"[SPI_VIP] [SPI_op] SDO = {s_bin[i]} ")
        await FallingEdge(dut.bin32_monitor)
    dut.bin34_en.value = 0 # enable 
    while True: 
        if cpu.read_debug_reg1() == 0xBB:
            cocotb.log.info(f" [TEST] firmware recieve the right value {s}")
            break
        elif cpu.read_debug_reg1() == 0xBB: 
            cocotb.log.error(f" [TEST] firmware recieve the incorrect value {cpu.read_debug_reg2()}  instead of {s}")
            break

        await ClockCycles(caravelEnv.clk,10) 

