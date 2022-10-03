from operator import add
import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
import cocotb.simulator
from cocotb.handle import SimHandleBase
from cocotb.handle import Force
from cocotb_coverage.coverage import *
from cocotb.binary import BinaryValue
import enum
from cocotb.handle import (
    ConstantObject,
    HierarchyArrayObject,
    HierarchyObject,
    ModifiableObject,
    NonHierarchyIndexableObject,
    SimHandle,
)

from itertools import groupby, product

import common
from common import GPIO_MODE
from common import MASK_GPIO_CTRL
from common import Macros

class RiskV: 
    def __init__(self,dut:SimHandleBase):
        self.dut         = dut
        self.clk         = dut.clock_tb
        if not Macros['GL']:
            self.cpu_hdl     = dut.uut.soc.core.VexRiscv
        else:
            self.cpu_hdl     = dut.uut.soc.core
        self.debug_hdl   = dut.uut.mprj.debug
        self.force_reset = 0
        cocotb.scheduler.add(self.force_reset_fun())


    """  """
    async def drive_data_with_address(self,address,data,SEL=0xF): 
        self.cpu_hdl.dBusWishbone_CYC.value      = 1
        self.cpu_hdl.iBusWishbone_CYC.value      = 0
        self.cpu_hdl.dBusWishbone_STB.value      = 1
        self.cpu_hdl.dBusWishbone_WE.value       = 1
        self.cpu_hdl.dBusWishbone_SEL.value       = SEL
        self.cpu_hdl.dBusWishbone_ADR.value      = address >> 2
        self.cpu_hdl.dBusWishbone_DAT_MOSI.value = data
        await RisingEdge(self.cpu_hdl.dBusWishbone_ACK)
        await ClockCycles(self.clk, 1)
        self.cpu_hdl.dBusWishbone_CYC.value      = BinaryValue(value = 'z')
        self.cpu_hdl.iBusWishbone_CYC.value      = BinaryValue(value = 'z')
        self.cpu_hdl.dBusWishbone_STB.value      = BinaryValue(value = 'z')
        self.cpu_hdl.dBusWishbone_WE.value       = BinaryValue(value = 'z')
        self.cpu_hdl.dBusWishbone_SEL.value      = BinaryValue(value = 'zzzz')
        self.cpu_hdl.dBusWishbone_ADR.value      = common.signal_valueZ_size(self.cpu_hdl.dBusWishbone_ADR)[0]
        self.cpu_hdl.dBusWishbone_DAT_MOSI.value = common.signal_valueZ_size(self.cpu_hdl.dBusWishbone_DAT_MOSI)[0]

    """  """
    async def drive_data2address(self,address,data,SEL=0xF): 
        cocotb.log.info(f"[RiskV][drive_data2address] start driving address {hex(address)} with {hex(data)}")
        # print(dir(self.cpu_hdl)) 
        dBusWishbone_CYC      = self.cpu_hdl.dBusWishbone_CYC.value
        if not Macros['GL']:
            iBusWishbone_CYC      = self.cpu_hdl.iBusWishbone_CYC.value 
            dBusWishbone_STB      = self.cpu_hdl.dBusWishbone_STB.value 
        dBusWishbone_WE       = self.cpu_hdl.dBusWishbone_WE.value
        if not Macros['GL']:
            dBusWishbone_SEL      = self.cpu_hdl.dBusWishbone_SEL.value
        else: 
            dBusWishbone_SEL0     = self.cpu_hdl.net2121.value
            dBusWishbone_SEL1     = self.cpu_hdl.net1979.value
            dBusWishbone_SEL2     = self.cpu_hdl.net848.value
            dBusWishbone_SEL3     = self.cpu_hdl.net1956.value
        if not Macros['GL']:
            dBusWishbone_ADR      = self.cpu_hdl.dBusWishbone_ADR.value
            dBusWishbone_DAT_MOSI = self.cpu_hdl.dBusWishbone_DAT_MOSI.value
        self.cpu_hdl.dBusWishbone_CYC.value      = 1

        if not Macros['GL']:
            self.cpu_hdl.iBusWishbone_CYC.value      = 0
            self.cpu_hdl.dBusWishbone_STB.value      = 1
        self.cpu_hdl.dBusWishbone_WE.value       = 1
        if not Macros['GL']:
            self.cpu_hdl.dBusWishbone_SEL.value  = SEL
        else: 
            self.cpu_hdl.net2121.value           = (SEL >>0 ) &1
            self.cpu_hdl.net1979.value           = (SEL >>1 ) &1
            self.cpu_hdl.net848.value            = (SEL >>2 ) &1
            self.cpu_hdl.net1956.value           = (SEL >>3 ) &1

        if not Macros['GL']:
            self.cpu_hdl.dBusWishbone_ADR.value      = address >> 2
        else: 
            address_temp = address >> 2
            for i in range(30):
                self.cpu_hdl._id(f'dBusWishbone_ADR[{i}]',False).value      = (address_temp >> i) & 1
        if not Macros['GL']:      
            self.cpu_hdl.dBusWishbone_DAT_MOSI.value = data
        else: 
            for i in range(32):
                self.cpu_hdl._id(f'dBusWishbone_DAT_MOSI[{i}]',False).value      = (data >> i) & 1
        
        if not Macros['GL']:      
            await RisingEdge(self.cpu_hdl.dBusWishbone_ACK)
        else:
            # await RisingEdge(self.cpu_hdl._id("_07019_",False) & (self.cpu_hdl._id("grant[0]",False)))
            await RisingEdge(self.cpu_hdl._id("_07019_",False) )
            
        await ClockCycles(self.clk, 1)
        self.cpu_hdl.dBusWishbone_CYC.value      = dBusWishbone_CYC
        if not Macros['GL']:      
            self.cpu_hdl.dBusWishbone_ADR.value      = dBusWishbone_ADR
            self.cpu_hdl.dBusWishbone_DAT_MOSI.value = dBusWishbone_DAT_MOSI
            self.cpu_hdl.iBusWishbone_CYC.value      = iBusWishbone_CYC
            self.cpu_hdl.dBusWishbone_STB.value      = dBusWishbone_STB
        self.cpu_hdl.dBusWishbone_WE.value       = dBusWishbone_WE
        self.cpu_hdl.dBusWishbone_SEL.value      = dBusWishbone_SEL
        
        await ClockCycles(self.clk, 1)
        cocotb.log.info(f"[RiskV][drive_data2address] finish driving address {hex(address)} with {hex(data)}")

    """  """
    async def read_address(self,address,SEL=0xF): 
        cocotb.log.info(f"[RiskV][read_address] start reading address {hex(address)}")
        # print(dir(self.cpu_hdl)) 
        dBusWishbone_CYC      = self.cpu_hdl.dBusWishbone_CYC.value
        if not Macros['GL']:
            iBusWishbone_CYC      = self.cpu_hdl.iBusWishbone_CYC.value 
            dBusWishbone_STB      = self.cpu_hdl.dBusWishbone_STB.value 
        dBusWishbone_WE       = self.cpu_hdl.dBusWishbone_WE.value
        if not Macros['GL']:
            dBusWishbone_SEL      = self.cpu_hdl.dBusWishbone_SEL.value
        else: 
            dBusWishbone_SEL0     = self.cpu_hdl.net2121.value
            dBusWishbone_SEL1     = self.cpu_hdl.net1979.value
            dBusWishbone_SEL2     = self.cpu_hdl.net848.value
            dBusWishbone_SEL3     = self.cpu_hdl.net1956.value
        if not Macros['GL']:
            dBusWishbone_ADR      = self.cpu_hdl.dBusWishbone_ADR.value
            dBusWishbone_DAT_MOSI = self.cpu_hdl.dBusWishbone_DAT_MOSI.value
        self.cpu_hdl.dBusWishbone_CYC.value      = 1

        if not Macros['GL']:
            self.cpu_hdl.iBusWishbone_CYC.value  = 0
            self.cpu_hdl.dBusWishbone_STB.value  = 1
        self.cpu_hdl.dBusWishbone_WE.value       = 0
        if not Macros['GL']:
            self.cpu_hdl.dBusWishbone_SEL.value  = SEL
        else: 
            self.cpu_hdl.net2121.value           = (SEL >>0 ) &1
            self.cpu_hdl.net1979.value           = (SEL >>1 ) &1
            self.cpu_hdl.net848.value            = (SEL >>2 ) &1
            self.cpu_hdl.net1956.value           = (SEL >>3 ) &1

        if not Macros['GL']:
            self.cpu_hdl.dBusWishbone_ADR.value  = address >> 2
        else: 
            address_temp = address >> 2
            for i in range(30):
                self.cpu_hdl._id(f'dBusWishbone_ADR[{i}]',False).value      = (address_temp >> i) & 1

        
        if not Macros['GL']:      
            await RisingEdge(self.cpu_hdl.dBusWishbone_ACK)
        else:
            # await RisingEdge(self.cpu_hdl._id("_07019_",False) & (self.cpu_hdl._id("grant[0]",False)))
            await RisingEdge(self.cpu_hdl._id("_07019_",False) )
            
        await ClockCycles(self.clk, 1)
        self.cpu_hdl.dBusWishbone_CYC.value      = dBusWishbone_CYC
        if not Macros['GL']:      
            self.cpu_hdl.dBusWishbone_ADR.value      = dBusWishbone_ADR
            self.cpu_hdl.dBusWishbone_DAT_MOSI.value = dBusWishbone_DAT_MOSI
            self.cpu_hdl.iBusWishbone_CYC.value      = iBusWishbone_CYC
            self.cpu_hdl.dBusWishbone_STB.value      = dBusWishbone_STB
        self.cpu_hdl.dBusWishbone_WE.value       = dBusWishbone_WE
        self.cpu_hdl.dBusWishbone_SEL.value      = dBusWishbone_SEL
        data =  self.cpu_hdl.dBusWishbone_DAT_MISO.value
        await ClockCycles(self.clk, 1)
        cocotb.log.info(f"[RiskV][read_address] finish reading address {hex(address)} data =  {data}")
        
        # return data
        return int(str(bin(data.integer)[2:]).zfill(32),2)
        # return int(str(bin(data.integer)[2:]).zfill(32)[::-1],2)


    def read_debug_reg1(self):
        return self.debug_hdl.debug_reg_1.value.integer
    def read_debug_reg2(self):
        return self.debug_hdl.debug_reg_2.value.integer

    # writing debug registers using backdoor because in GL cpu can't be disabled for now because of different netlist names
    def write_debug_reg1_backdoor(self,data):
        self.debug_hdl.debug_reg_1.value = data
    def write_debug_reg2_backdoor(self,data):
        self.debug_hdl.debug_reg_2.value = data
    
    async def force_reset_fun(self):
        first_time_force = True
        first_time_release = True
        while True:
            if self.force_reset:
                if first_time_force: 
                    cocotb.log.info(f"[RiskV][force_reset_fun] Force CPU reset")
                    first_time_force = False
                    first_time_release = True
                self.cpu_hdl.reset.value =1
                if not Macros['GL']:      
                    common.drive_hdl(self.cpu_hdl.reset,(0,0),1)
                else:
                    common.drive_hdl(self.cpu_hdl.mgmtsoc_vexriscv_debug_reset,(0,0),1)
            else: 
                if first_time_release: 
                    first_time_force = True
                    first_time_release = False

                    if not Macros['GL']:      
                        common.drive_hdl(self.cpu_hdl.reset,(0,0),0)
                    else:
                        common.drive_hdl(self.cpu_hdl.mgmtsoc_vexriscv_debug_reset,(0,0),0)
                    cocotb.log.info(f"[RiskV][force_reset_fun] release CPU reset")

            await ClockCycles(self.clk, 1)    
    def cpu_force_reset(self):
        self.force_reset = True
    
    def cpu_release_reset(self):
        self.force_reset = False
        