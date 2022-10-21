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
async def spi_rd_wr_nbyte(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=14833)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info (f"[TEST] start spi_rd_wr_nbyte test")
    nbytes_limits= 8
    #  writing to the random number(1 to 8) of bits after 0x1E (gpio_configure[4]) address  avoid changing gpio 3 
    for j in range(3):
        address = random.randint(0x26 , 0x67-nbytes_limits)
        n_bytes = random.randint(1,nbytes_limits)
        await write_reg_spi_nbytes(caravelEnv,address,[0x1F,0x1F,0x1F,0x1F,0x1F,0x1F,0x1F,0x1F],nbytes_limits)
        await write_reg_spi_nbytes(caravelEnv,address,[0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0],n_bytes)
        data = await read_reg_spi_nbytes(caravelEnv,address,nbytes_limits)
        for i in range(nbytes_limits):
            if i >= n_bytes: 
                if data[i] != 0x1F:
                    cocotb.log.error(f"[TEST] register {i} has returned value {data[i]} while it should return value 0x1F n_bytes = {n_bytes}")
                else: cocotb.log.info(f"[TEST] successful read 0 from register {i} n_bytes = {n_bytes}")
            else: 
                if data[i] != 0: 
                    cocotb.log.error(f"[TEST] register number {i} has returned value {data[i]} > 0 while it should return value == 0 n_bytes = {n_bytes}")
                else: cocotb.log.info(f"[TEST] successful read {data[i]} from register {i} n_bytes = {n_bytes}")    
    await ClockCycles(caravelEnv.clk,200)