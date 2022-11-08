import json
import cocotb
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb_bus.monitors import Monitor
from cocotb.log import SimLogFormatter, SimTimeContextFilter
from cocotb.binary import BinaryValue
from math import ceil
from cocotb_bus.scoreboard import Scoreboard
import fnmatch
import copy
from cocotb.result import TestFailure
from interfaces.common import Macros
from wb_models.gpio_controlWB.GPIO_models import GPIO_models
from wb_models.gpio_controlWB.monitors import DefaultMonitor
from wb_models.gpio_controlWB.monitors import SerialMonitor


class GPIO_ctrlWB:
    def __init__(self,dut,gpio_num,loggers=False,checkers=False):
        self.dut         = dut
        self.caravel_hdl = dut.uut
        self.clk         = self.dut.uut.mprj_clock
        self.reset       = self.dut.uut.resetb
        self.gpio_num    = gpio_num
        self.logger      = loggers
        self.checkers    = checkers
        self.load_js()
        self.setupModels()
        self.Monitors()
        if self.checkers:
            cocotb.scheduler.add(self.reg_model_sb())

    """load json models"""
    def load_js(self):
        with open('wb_models/gpio_controlWB/gpio.json') as f:
            json_f = json.load(f)
            mapping = json_f["mapping"]
            self.gpio_name = f'GPIO{self.gpio_num}'
            self.gpio_hdl = self.caravel_hdl._id(mapping[f'{self.gpio_num}'],False)
            self.serial_if = json_f["serial_if"]
            self.default_if = json_f["default_if"]
            # print (mapping)
            print (self.serial_if)
            print (self.gpio_name)
            print (self.gpio_name)
            print (self.gpio_name)
    
    """initialize all models needed"""    
    def setupModels(self):
        self.gpio_model = GPIO_models(f"{self.gpio_name}")

    """"function to add the housekeeping monitors"""
    def Monitors(self):
        DefaultMonitor(f"{self.gpio_name}",self.gpio_hdl,self.default_if["inputs"],self.clk,self.reset,callback=self.gpio_model.default_model) 
        SerialMonitor(f"{self.gpio_name}",self.gpio_hdl,self.serial_if["inputs"],self.clk,self.reset,callback=self.gpio_model.serial_model) 
        pass


class GPIOs_ctrlWB:
     
    def __init__(self,dut,is_caravan=False,loggers=False,checkers=False):
        self.dut         = dut
        self.caravel_hdl = dut.uut
        self.clk         = self.dut.uut.mprj_clock
        self.reset       = self.dut.uut.resetb
        self.logger      = loggers
        self.checkers    = checkers
        if is_caravan: 
            self.caravan_gpios()
        else: 
            self.caravel_gpios()

    def caravel_gpios(self):
        for i in range(38):
            GPIO_ctrlWB(self.dut,i)
       


    def caravan_gpios(self):
        pass