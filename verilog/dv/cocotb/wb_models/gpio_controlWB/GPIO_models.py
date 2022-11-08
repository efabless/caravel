import cocotb
from cocotb.binary import BinaryValue
from cocotb.triggers import Timer, RisingEdge, ReadOnly
import fnmatch
from cocotb.result import TestFailure
from cocotb_coverage.coverage import *
from collections import deque
import sys
from cocotb_coverage.coverage import *
from itertools import groupby, product
from interfaces.common import GPIO_MODE

    
class GPIO_models():
    def __init__(self,name):
        self.name = name
        self.gpio_config_bins = [e.name for e in GPIO_MODE]
        pass
    """model for the serial functionality inside gpio_control_block"""
    def serial_model(self,trans):
        reset = trans["reset"]["val"]
        if reset == 0: 
            self.shift_array = deque([0]*13,  maxlen=13)
        else:
            load = trans["load"]["val"]
            
            if load == "1": 
                self.gpio_configuration =  self.shift_array
                cocotb.log.info(f"[GPIO_models][serial_model][{self.name}] loaded value = {self.gpio_configuration} string {''.join(self.gpio_configuration)} hex = {hex(int(''.join(self.gpio_configuration),2))}")
                try:
                    gpio_config = GPIO_MODE(int(''.join(self.gpio_configuration),2)).name
                except: 
                    gpio_config = ''.join(self.gpio_configuration)
                self.gpio_config_cov(gpio_config)
            else: 
                self.shift_array.append(trans["data"]["val"])
                cocotb.log.info(f"[GPIO_models][serial_model][{self.name}] shifted value = {self.shift_array}")

    """model for the default inside gpio_control_block"""
    def default_model(self,trans):
        defaults = trans["defaults"]["val"]
        self.shift_array = deque(defaults,  maxlen=13)
        self.gpio_configuration = self.shift_array
        cocotb.log.debug(f"[GPIO_models][default_model][{self.name}] default value = {self.gpio_configuration}")
        try:
            gpio_config = GPIO_MODE(int(''.join(self.gpio_configuration),2)).name
        except: 
            gpio_config = ''.join(self.gpio_configuration)
        # self.gpio_config_cov(gpio_config)
        # sys.exit()


###################### coverage ################################## 

    def gpio_config_cov(self,gpio_config):
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}", 
        xf = lambda gpio_config:(gpio_config),
        bins = self.gpio_config_bins)
        def cov(gpio_config):
            pass
        cov (gpio_config)
