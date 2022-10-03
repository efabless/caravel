from curses import baudrate
import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer
import cocotb.log
from cpu import RiskV
from defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from caravel import GPIO_MODE

baud_rate = 9600
number_of_bits = 8
bit_rate_ns = round((10**9)/(baud_rate*number_of_bits) )

reg = Regs()


@cocotb.test()
@repot_test
async def uart_tx(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=18613481)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    cocotb.log.info(f"[TEST] Start uart test")  
    expected_data = "Monitor: Test UART (RTL) passed"

    await wait_reg1(cpu,caravelEnv,0XAA) 
        
    cocotb.log.info (f"[TEST] start sending on uart")
    counter =0
    data_out =''
    while True:
        if counter %8 == 0: 
            if counter != 0:
                data_out = data_out+chr(int(char,2))
                cocotb.log.info (f"[TEST] msg is:'{data_out}' expected '{expected_data}'")
            if data_out == expected_data:
                cocotb.log.info (f"[TEST] Pass recieve the full expected msg '{data_out}'")
                break
            await start_of_tx(caravelEnv)
            char  = ''
        # if temp != caravelEnv.monitor_gpio((6,6))
        char = caravelEnv.monitor_gpio((6,6)).binstr + char
        cocotb.log.debug (f"[TEST] bit[{counter}] = {caravelEnv.monitor_gpio((6,6))} data out = {char} ")
        await Timer(bit_rate_ns, units='ns')  
        counter +=1
    
async def start_of_tx(caravelEnv):
    while (True): # wait for the start of the transimission it 1 then 0
        if (caravelEnv.monitor_gpio((6,6)).integer == 0):
            break
        await Timer(bit_rate_ns, units='ns')
    await Timer(bit_rate_ns, units='ns')
