
import random
import cocotb
from cocotb.clock import Clock
import cocotb.log
import caravel 
from logic_analyzer import LA
from wb_models.housekeepingWB.housekeepingWB import HK_whiteBox
import common
import logging
from cpu import RiskV
from cocotb.log import SimTimeContextFilter
from cocotb.log import SimLogFormatter
from tests.common_functions.Timeout import Timeout
import os
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles

"""configure the test log file location and log verbosity 
   configure the test clock 
   configure the test timeout 
   configure whitbox models
   start up the test connecting power vdd to the design then reset and disable the CSB bit 
   return the caravel environmnet with clock and start up
"""
async def test_configure(dut,timeout_cycles=1000000,clk=12.5,timeout_precision=0.2,num_error=3):
    caravelEnv = caravel.Caravel_env(dut)
    Timeout(caravelEnv.clk,timeout_cycles,timeout_precision)
    if os.getenv('ERRORMAX') != 'None': 
        num_error = int(os.getenv('ERRORMAX'))
    cocotb.scheduler.add(max_num_error(num_error,caravelEnv.clk))
    clock = Clock(caravelEnv.clk, clk, units="ns")  # Create a 10ns period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock
    await caravelEnv.start_up()
    await ClockCycles(caravelEnv.clk, 10)
    # HK_whiteBox(dut)
    return caravelEnv
    
class CallCounted:
    """Decorator to determine number of calls for a method"""

    def __init__(self,method):
        self.method=method
        self.counter=0

    def __call__(self,*args,**kwargs):
        self.counter+=1
        return self.method(*args,**kwargs)


def repot_test(func):
    async def wrapper_func(*args, **kwargs):
        ## configure logging 
        COCOTB_ANSI_OUTPUT=0

        TestName = func.__name__
        cocotb.log.setLevel(logging.INFO)
        cocotb.log.error = CallCounted(cocotb.log.error)
        cocotb.log.critical = CallCounted(cocotb.log.critical)
        cocotb.log.warning = CallCounted(cocotb.log.warning)
        handler = logging.FileHandler(f"sim/{os.getenv('RUNTAG')}/{os.getenv('SIM')}-{TestName}/{TestName}.log",mode='w')
        handler.addFilter(SimTimeContextFilter())
        handler.setFormatter(SimLogFormatter())
        cocotb.log.addHandler(handler) 
        ## call test 
        await func(*args, **kwargs)
        ## report after finish simulation
        msg = f'with ({cocotb.log.critical.counter})criticals ({cocotb.log.error.counter})errors ({cocotb.log.warning.counter})warnings '
        if cocotb.log.error.counter > 0 or cocotb.log.critical.counter >0:
            raise cocotb.result.TestComplete(f'Test failed {msg}')
        else: 
            raise cocotb.result.TestComplete(f'Test passed {msg}')
        return retval
    return wrapper_func

async def max_num_error(num_error,clk):
    while True:
        await ClockCycles(clk,1)
        if cocotb.log.error.counter + cocotb.log.critical.counter > num_error:
            msg = f'Test failed with max number of errors {num_error} ({cocotb.log.critical.counter})criticals ({cocotb.log.error.counter})errors ({cocotb.log.warning.counter})warnings '
            raise cocotb.result.TestFailure(msg)
        

async def wait_reg1(cpu,caravelEnv,data):
    while (True):
        if cpu.read_debug_reg1() == data: 
            return
        await ClockCycles(caravelEnv.clk,10)
        
            
async def wait_reg2(cpu,caravelEnv,data):
    while (True):
        if cpu.read_debug_reg2() == data: 
            return
        await ClockCycles(caravelEnv.clk,10)
        