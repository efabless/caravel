
import cocotb
from cocotb.triggers import ClockCycles, RisingEdge, Edge,Timer
from cocotb_bus.monitors import Monitor
from cocotb.log import SimLogFormatter, SimTimeContextFilter
from cocotb.binary import BinaryValue
from cocotb.result import TestFailure
from math import ceil
import copy
import logging
from fnmatch import fnmatch
        
class DefaultMonitor(Monitor):
    def __init__(self, name, block_path,interfaces,clock,reset,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        await RisingEdge(self.clock)
        for key2,signal in self.interfaces.items():
                signal['val'] = list(self.block_path._id(signal['signal'],False).value.binstr)
        cocotb.log.debug(f"[Defaultmonitor][{self.name}] interface = {self.interfaces}")
        self._recv(self.interfaces)
        
class SerialMonitor(Monitor):
    def __init__(self, name, block_path,interfaces,clock,reset,is_output=False,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.is_output = is_output
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True: 
            # wait on Rising edge of clock and load
            self.edgeDetcted = False
            seial_clock = self.block_path._id(self.interfaces["clock"]["signal"],False)
            load = self.block_path._id(self.interfaces["load"]["signal"],False)
            clock_wait = await  cocotb.start(self.wait_clock_load(seial_clock))
            load_wait = await  cocotb.start(self.wait_clock_load(load))
            while not self.edgeDetcted: 
                await ClockCycles(self.clock, 1)
                pass
            clock_wait.kill()
            load_wait.kill()

            for key2,signal in self.interfaces.items():
                    signal['val'] = self.block_path._id(signal['signal'],False).value.binstr
            cocotb.log.debug(f"[{__class__.__name__}][{self.name}] interface = {self.interfaces}")
            if self.is_output:
                await Timer(1,'ns')
            self._recv(self.interfaces)

    async def wait_clock_load(self,signal):
        await RisingEdge(signal)
        self.edgeDetcted = True

class PadMonitor(Monitor):
    def __init__(self, name, block_path,interfaces,clock,reset,is_output=False,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.is_output = is_output
        self.pad_name = "pad"
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True: 
            # wait on Rising edge of clock and load
            signal = self.block_path._id(self.interfaces[f"{self.pad_name}"]["signal"],False)
            await Edge(signal)
            for key2,signal in self.interfaces.items():
                    signal['val'] = self.block_path._id(signal['signal'],False).value.binstr
            cocotb.log.debug(f"[{__class__.__name__}][{self.name}] interface = {self.interfaces}")
            if self.is_output:
                await Timer(1,'ns')
            self._recv(self.interfaces)


class MgmtGpioMonitor(PadMonitor):
    def __init__(self, name, block_path,interfaces,clock,reset,is_output=False,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.is_output = is_output
        self.pad_name = "mgmt"
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True: 
            # wait on Rising edge of clock and load
            signal = self.block_path._id(self.interfaces[f"{self.pad_name}"]["signal"],False)
            await Edge(signal)
            for key2,signal in self.interfaces.items():
                    signal['val'] = self.block_path._id(signal['signal'],False).value.binstr
            cocotb.log.debug(f"[{__class__.__name__}][{self.name}] interface = {self.interfaces}")
            if self.is_output:
                await Timer(1,'ns')
            self._recv(self.interfaces)

class UserGpioMonitor(PadMonitor):
    def __init__(self, name, block_path,interfaces,clock,reset,is_output=False,is_logger = False, callback=None, event=None):
        self.name = name
        self.interfaces = interfaces
        self.clock = clock
        self.reset = reset
        self.block_path = block_path
        self.is_logger = is_logger
        self.is_output = is_output
        self.pad_name = "user"
        Monitor.__init__(self, callback, event)

    async def _monitor_recv(self):
        while True: 
            # wait on Rising edge of clock and load
            signal = self.block_path._id(self.interfaces[f"{self.pad_name}"]["signal"],False)
            await Edge(signal)
            for key2,signal in self.interfaces.items():
                    signal['val'] = self.block_path._id(signal['signal'],False).value.binstr
            cocotb.log.debug(f"[{__class__.__name__}][{self.name}] interface = {self.interfaces}")
            if self.is_output:
                await Timer(1,'ns')
            self._recv(self.interfaces)
