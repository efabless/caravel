
from fnmatch import fnmatch
import cocotb
from cocotb.triggers import Timer, FallingEdge,RisingEdge, ReadOnly
from cocotb_bus.monitors import Monitor
from cocotb.log import SimLogFormatter, SimTimeContextFilter
from cocotb.binary import BinaryValue
from cocotb.result import TestFailure
from math import ceil
import copy
import logging
from wb_models.housekeepingWB.HKmonitor import HKmonitor
from common import Macros


class HKSPImonitor(Monitor):
    """Observes single input """
    def __init__(self, name, block_path,interfaces, clock,reset,is_logger = False, input=True, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.input = input
        self.setup_logger()
        Monitor.__init__(self, callback, event)


    async def _monitor_recv(self):
        old_trans_hold = None
        old_trans_no_valid = None
        while True:
            if Macros['GL']:
                await RisingEdge(self.block_path.clknet_0_mgmt_gpio_in) # the main reason for doing all this can't use mgmt_gpio_in[4] as signal 
            else :
                await RisingEdge(self.block_path.hkspi.SCK) # the main reason for doing all this can't use mgmt_gpio_in[4] as signal 
            cocotb.log.debug(f'reset {self.reset.value.binstr }')
            
            if self.reset.value.binstr == '0':
                continue

            mgmt_gpio_in = self.block_path.mgmt_gpio_in.value
            gpio_size = mgmt_gpio_in.n_bits-1
            CSB = mgmt_gpio_in[gpio_size-3]
            if CSB.binstr == '1':
                continue
            SCK = mgmt_gpio_in[gpio_size-4]
            SDI = mgmt_gpio_in[gpio_size-2]
            SDO = self.block_path.mgmt_gpio_out.value[gpio_size-1]
            if not self.input: 
                if self.block_path.hkspi.SCK.value.binstr != '0':
                    continue
            # update signal
            self.interfaces['CSB']['val'] = CSB
            self.interfaces['SCK']['val'] = SCK

            if self.input:
                self.interfaces['SDI']['val'] = SDI
            else : 
                self.interfaces['SDO']['val'] = SDO

            # logger
            self.logger.debug(f' ')
            self.handler.terminator = ""
            self.handler.setFormatter(SimLogFormatter())
            self.logger.debug(f'')
            self.handler.setFormatter(logging.Formatter('%(message)s'))
            for key2,signal in self.interfaces.items():
                if fnmatch(key2,"_*"):
                    continue
                if signal['val'].is_resolvable:
                    length = self.lengths[key2] - (len(hex(signal['val'].integer)))
                    self.logger.debug(f" {hex(signal['val'].integer)}{' '*length}|")
                    # signal['val'] = self.block_path._id(signal['signal'],False).value.integer
                else: 
                    length = self.lengths[key2] - (len('x'))
                    self.logger.debug(f" x{' '*length}|")
            self.handler.terminator = "\n"
            self._recv(self.interfaces)


        
    
    """method for setting up logger for WB model"""
    def setup_logger(self):
        self.logger = logging.getLogger(f'HouseKeeping{self.name}')
        self.logger.setLevel(logging.DEBUG)
        if not self.is_logger:
            self.logger.setLevel(logging.INFO)
            self.handler = logging.StreamHandler()
            # return
        else :
            self.handler = logging.FileHandler(f"{self.name}.log",mode='w')
            self.handler.addFilter(SimTimeContextFilter())
            self.logger.addHandler(self.handler) 
        # get the sizes of signals
        #for key,interface in self.interfaces.items():
        for key,signal in self.interfaces.items():
            if fnmatch(key,"_*"):
                continue
            signal['val'] = BinaryValue(value=0,n_bits=1)
            size  = signal['val'].n_bits
            signal['val'] = BinaryValue(value = int(size) * '1',n_bits=size)
        # set the logger file header
        # set first line
        self.handler.terminator = ""
        self.logger.debug(f'   timestamp level  ')
        length =0
        for key2,signal in self.interfaces.items():
            if fnmatch(key2,"_*"):
                    continue
            length += max(ceil(signal['val'].n_bits/4)+2 , len(key2)) +3
        length -= len(key)+1
        self.logger.debug(f'| signals{" "*int(length)}')
        self.handler.terminator = "\n"  
        self.logger.debug(f' ')
        # set second line
        self.handler.terminator = ""
        self.logger.debug(f'{" "*20}|')
        length =0
        self.lengths = dict() 
        for key2,signal in self.interfaces.items():
            if fnmatch(key2,"_*"):
                    continue
            self.lengths[key2] = max((len(hex(signal['val'].integer))),len(key2)) +1
            length = self.lengths[key2] - len(key2)
            self.logger.debug(f'{key2}{" "*length}  ')
        self.handler.terminator = "\n" 



class CSBmonitor(Monitor):
    """Observes single input """
    def __init__(self, name, block_path,interfaces, clock,reset,is_logger = False, input=True, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.input = input
        Monitor.__init__(self, callback, event)


    async def _monitor_recv(self):

        while True:
            if Macros['GL']:
                await RisingEdge(self.block_path.net67)
            else:
                await RisingEdge(self.block_path.hkspi.CSB)

            self._recv(True)


        