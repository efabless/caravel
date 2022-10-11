
# from turtle import st
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from cocotb.result import SimTimeoutError
import cocotb
import time
"""class to handle timeout inside the tests. after the provided number of cycles (cycle_num) are exceeded test would fail 
    precision would determine when to log timeout warning for example if cycle_num=1000 and percision = 10% so after each 1000*10% = 100 cycle log would be printed
"""
class Timeout:
    def __init__(self,clk,cycle_num,precision=0.20):
        self.clk         = clk
        self.cycle_num   = cycle_num
        self.cycle_precision   = precision * cycle_num
        cocotb.scheduler.add(self._timeout_check())


    async def _timeout_check(self):
        number_of_cycles = 0
        for i in range(0,self.cycle_num):
            await ClockCycles(self.clk,1)
            number_of_cycles +=1
            if number_of_cycles %self.cycle_precision ==0:
                cocotb.log.warning(f"simulation are only {self.cycle_num-number_of_cycles} cycles away from TIMEOUT ")

        raise SimTimeoutError(f"simulation exceeds the max number of cycles {self.cycle_num}")
        
        pass

                 

