
import cocotb
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb_bus.monitors import Monitor
from cocotb.log import SimLogFormatter, SimTimeContextFilter
from cocotb.binary import BinaryValue
from cocotb.result import TestFailure
from math import ceil
import copy
import logging
from fnmatch import fnmatch

        
class HKmonitor(Monitor):
    """Observes single input """
    def __init__(self, name, block_path,interfaces, clock,reset,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.setup_logger()
        Monitor.__init__(self, callback, event)


    async def _monitor_recv(self):
        old_trans_hold = None
        old_trans_no_valid = None
        while True:
            # Capture signal at rising edge of clock
            if "_clk" in self.interfaces: # for interfaces with own clock
                signal = self.block_path._id(self.interfaces['_clk']['signal'],False)
                await RisingEdge(signal)
            else:
                await RisingEdge(self.clock)

                                    
            # if self.reset.value.binstr == '0':
            #     continue

            if "_valid_cycle" in self.interfaces: # for interfaces with valid signal
                signal = self.block_path._id(self.interfaces['_valid_cycle']['signal'],False).value.binstr
                if signal is not '1':
                    continue

            if "_valid_cycle_n" in self.interfaces: # for interfaces with valid signal
                signal = self.block_path._id(self.interfaces['_valid_cycle']['signal'],False).value.binstr
                if signal is not '0':
                    continue
            
            # update signal
            for key2,signal in self.interfaces.items():
                # if fnmatch(key2,"_*"):
                #     continue
                signal['val'] = self.block_path._id(signal['signal'],False).value

            # if no_valid signal exist trans didn't change so monitor will not monitor anything 
            # no_valid means if the signal didn't change no addition action would needed
            if "_no_valid" in self.interfaces:
                if old_trans_no_valid is None: 
                    old_trans_no_valid = copy.deepcopy(self.interfaces)
                elif  (old_trans_no_valid == self.interfaces):
                    return
                else:
                    old_trans_no_valid = copy.deepcopy(self.interfaces)

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

            # special case in HKoutputsMonitorwishbone when writing to reg_mprj_datal(because it uses _buf) the data out is x's 
            # and in this case scoreboard raise obejection that the value is unresolved
            if self.name == "HKoutputsMonitorwishbone": 
                if not self.interfaces['data']['val'].is_resolvable: 
                    self.interfaces['data']['val'] = BinaryValue(value=0,n_bits=self.interfaces['data']['val'].n_bits)
            cocotb.log.debug(f'[HKmonitor][_monitor_recv] interface at monitor {self.name} self.interfaces {self.interfaces}')
            self._recv(self.interfaces)

            ## assertion that the values can't change until hold is released
            if "_hold" in self.interfaces:
                if old_trans_hold is None: 
                    skip = False
                    old_trans_hold = copy.deepcopy(self.interfaces)
                elif self.interfaces['_hold']['val'] == BinaryValue(value=1):
                    skip = True
                elif skip:
                    old_trans_hold = copy.deepcopy(self.interfaces)
                    skip = False
                else: 
                    if old_trans_hold != self.interfaces: 
                        cocotb.log.error(f'[HKmonitor][_monitor_recv] interface at monitor {self.name} change value before hold value is asserted \nold value {old_trans_hold} \nnew value {self.interfaces}')
                        raise TestFailure

            
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
            signal['val'] = self.block_path._id(signal['signal'],False).value
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
        self.logger.debug(f'| signals {" "*int(length)}')
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

                
class color:
   PURPLE = '\033[95m'
   CYAN = '\033[96m'
   DARKCYAN = '\033[36m'
   BLUE = '\033[94m'
   GREEN = '\033[92m'
   YELLOW = '\033[93m'
   RED = '\033[91m'
   BOLD = '\033[1m'
   UNDERLINE = '\033[4m'
   END = '\033[0m'