import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.spi_master.SPI_VIP import read_mem ,SPI_VIP
from tests.housekeeping.housekeeping_spi.spi_access_functions import *


bit_time_ns = 0
reg = Regs()


@cocotb.test()
@repot_test
async def user_pass_thru_rd(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=14833)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info (f"[TEST] start spi_master_rd test")
    file_name = f"{os.getenv('CARAVEL_VERILOG_PATH')}/dv/cocotb/tests/housekeeping/housekeeping_spi/test_data"
    mem = read_mem(file_name)
    await  cocotb.start(SPI_VIP(dut.bin8_monitor,dut.bin9_monitor,dut.bin10_monitor,(dut.bin11_en,dut.bin11),mem)) # fork for SPI 
    await wait_reg1(cpu,caravelEnv,0XAA) 
    cocotb.log.info (f"[TEST] Configuration finished")
    #The SPI flash may need to be reset
    # 0xff and 0xAB commands are suppose to have functionality in the future but for now they would do nothing
    await write_reg_spi(caravelEnv,0xc2,0xff) # 0xc2 is for appling user pass-thru command to housekeeping SPI   
    await write_reg_spi(caravelEnv,0xc2,0xab) # 0xc2 is for appling user pass-thru command to housekeeping SPI   

    # start reading from memory
    address = 0x0
    await reg_spi_user_pass_thru(caravelEnv,command = 0x3,address=address) # read command
    for i in range(8):
        val = await reg_spi_user_pass_thru_read(caravelEnv)
        if val  != mem[address]:
            cocotb.log.error(f"[TEST] reading incorrect value from address {hex(address)} expected = {hex(mem[address])} returened = {val}")
        else:
            cocotb.log.info(f"[TEST] reading correct value {hex(val)} from address {hex(address)} ")
        address +=1
   
    await caravelEnv.disable_csb()

    # Wait for processor to restart 
    await wait_reg1(cpu,caravelEnv,0xBB) 
    cocotb.log.info(f"[TEST] processor has restarted successfully")
