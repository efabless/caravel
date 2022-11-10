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
    def __init__(self,name,serial_out_if,checkers):
        self.name = name
        self.gpio_config_bins = [e.name for e in GPIO_MODE]
        self.checkers = checkers
        if self.checkers:
            self.serial_out_if = serial_out_if
            self.exp_serial_out = []
        
    """model for the serial functionality inside gpio_control_block"""
    def serial_model(self,trans):
        reset = trans["reset"]["val"]
        load = trans["load"]["val"]
        if reset == 0: 
            self.shift_array = deque([0]*13,  maxlen=13)
        else:
            if load == "1": 
                self.gpio_configuration =  self.shift_array
                cocotb.log.debug(f"[GPIO_models][serial_model][{self.name}] loaded value = {self.gpio_configuration} string {''.join(self.gpio_configuration)} hex = {hex(int(''.join(self.gpio_configuration),2))}")
                
                self.gpio_config_cov(self.gpio_configuration)
            else: 
                self.shift_arr_deleted_val = self.shift_array[0]
                self.shift_array.append(trans["data"]["val"])
                cocotb.log.debug(f"[GPIO_models][serial_model][{self.name}] shifted value = {self.shift_array}")
        if self.checkers: # expect the serial output 
            self.serial_out_if["reset"]["val"] = reset
            self.serial_out_if["clock"]["val"] = trans["clock"]["val"]
            self.serial_out_if["load"]["val"] = load
            self.serial_out_if["data"]["val"] = f'{self.shift_arr_deleted_val}'  # data is being moved in negative edge that's why taking the old deleted val in the postive edge
            if load == "1":
                self.serial_out_if["data"]["val"] = "0"  # data is being moved in negative edge that's why taking the old deleted val in the postive edge

            self.exp_serial_out.append(self.serial_out_if)

    """model for the default inside gpio_control_block"""
    def default_model(self,trans):
        defaults = trans["defaults"]["val"]
        self.shift_array = deque([0]*13,  maxlen=13)
        self.gpio_configuration = deque(defaults,  maxlen=13)
        cocotb.log.debug(f"[GPIO_models][default_model][{self.name}] default value = {self.gpio_configuration}")
        # self.gpio_config_cov(self.gpio_configuration)
        # sys.exit()

    def pad_in_model(self,trans):
        pad_input = trans["pad"]["val"]

    def pad_out_model(self,trans):
        pad_input = trans["pad"]["val"]

    def mgmt_gpio_model(self,trans):
        mgmt_gpio = trans["mgmt"]["val"]
        self.gpio_config_cov(self.gpio_configuration,mgmt_gpio=True)

    def gpio_mgmt_model(self,trans):
        gpio_mgmt = trans["mgmt"]["val"]
        self.gpio_config_cov(self.gpio_configuration,gpio_mgmt=True)

    def user_gpio_model(self,trans):
        user_gpio = trans["user"]["val"]
        self.gpio_config_cov(self.gpio_configuration,user_gpio=True)

    def gpio_user_model(self,trans):
        gpio_user = trans["user"]["val"]
        self.gpio_config_cov(self.gpio_configuration,gpio_user=True)

###################### coverage ################################## 

    def gpio_config_cov(self,gpio_config,gpio_mgmt=False,mgmt_gpio=False,gpio_user=False,user_gpio=False):
        try:
            gpio_config = GPIO_MODE(int(''.join(gpio_config),2)).name
        except: 
            gpio_config = ''.join(gpio_config)
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}.config", 
        xf = lambda gpio_config:(gpio_config),
        bins = self.gpio_config_bins)
        def cov_config(gpio_config):
            pass
        cov_config(gpio_config)
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}.data_transfer.mgmt_gpio", 
        xf = lambda mgmt_gpio:mgmt_gpio,
        bins = [True],
        bins_labels = ["mgmt_to_pad_data_transfer"])
        def cov_mgmt_pad(mgmt_gpio):
            pass
        cov_mgmt_pad(mgmt_gpio)
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}.data_transfer.gpio_mgmt", 
        xf = lambda gpio_mgmt:gpio_mgmt,
        bins = [True],
        bins_labels = ["pad_mgmt_data_transfer"])
        def cov_mgmt_pad(gpio_mgmt):
            pass
        cov_mgmt_pad(gpio_mgmt)
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}.data_transfer.user_gpio", 
        xf = lambda user_gpio:user_gpio,
        bins = [True],
        bins_labels = ["user_to_pad_data_transfer"])
        def cov_user_pad(user_gpio):
            pass
        cov_user_pad(user_gpio)
        @CoverPoint(f"top.caravel.gpio_controls.{self.name}.data_transfer.gpio_user", 
        xf = lambda gpio_user:gpio_user,
        bins = [True],
        bins_labels = ["pad_user_data_transfer"])
        def cov_user_pad(gpio_user):
            pass
        cov_user_pad(gpio_user)
        @CoverCross(
        f"top.caravel.gpio_controls.{self.name}.configs_gpio_mgmt",
        items = [f"top.caravel.gpio_controls.{self.name}.config", f"top.caravel.gpio_controls.{self.name}.data_transfer.gpio_mgmt"])
        def cov_configs_pad_mgmt():
            pass
        cov_configs_pad_mgmt()
        @CoverCross(
        f"top.caravel.gpio_controls.{self.name}.configs_mgmt_gpio",
        items = [f"top.caravel.gpio_controls.{self.name}.config", f"top.caravel.gpio_controls.{self.name}.data_transfer.mgmt_gpio"])
        def cov_configs_mgmt_pad():
            pass
        cov_configs_mgmt_pad()
        @CoverCross(
        f"top.caravel.gpio_controls.{self.name}.configs_gpio_user",
        items = [f"top.caravel.gpio_controls.{self.name}.config", f"top.caravel.gpio_controls.{self.name}.data_transfer.gpio_user"])
        def cov_configs_pad_user():
            pass
        cov_configs_pad_user()
        @CoverCross(
        f"top.caravel.gpio_controls.{self.name}.configs_user_gpio",
        items = [f"top.caravel.gpio_controls.{self.name}.config", f"top.caravel.gpio_controls.{self.name}.data_transfer.user_gpio"])
        def cov_configs_user_pad():
            pass
        cov_configs_user_pad()