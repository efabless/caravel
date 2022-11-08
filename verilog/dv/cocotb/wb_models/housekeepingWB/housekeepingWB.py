import json
import cocotb
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb_bus.monitors import Monitor
from cocotb.log import SimLogFormatter, SimTimeContextFilter
from cocotb.binary import BinaryValue
from math import ceil
from wb_models.housekeepingWB.HKmonitor import HKmonitor
from wb_models.housekeepingWB.HKSPImonitor import HKSPImonitor
from wb_models.housekeepingWB.HKSPImonitor import CSBmonitor
from wb_models.housekeepingWB.HK_models import HK_models
from cocotb_bus.scoreboard import Scoreboard
import logging
import fnmatch
import copy
from cocotb.result import TestFailure
from interfaces.common import Macros


class HK_whiteBox:
    def __init__(self,dut,loggers=False,checkers=False):
        self.dut         = dut
        self.hk_hdl      = dut.uut.housekeeping
        # self.hkspi_hdl   = dut.uut.housekeeping.hkspi
        self.clk         = self.dut.uut.mprj_clock
        self.reset       = self.dut.uut.resetb
        self.logger      = loggers
        self.checkers    = checkers
        self.load_js()
        self.setupModels()
        self.Monitors()
        if self.checkers:
            cocotb.scheduler.add(self.reg_model_sb())
    """load json models"""
    def load_js(self):
        with open('wb_models/housekeepingWB/housekeepingIF.json') as f:
            self.interface = json.load(f)
        with open('wb_models/housekeepingWB/HK_regs.json') as f:
            self.reg_model = json.load(f)
        self.output_if = copy.deepcopy(self.interface['outputs'])

    """"function to add the housekeeping monitors"""
    def Monitors(self): 
        inputs = self.interface['inputs']
        outputs = self.interface['outputs']
        # wishbone 
        wishbone_mon_i = HKmonitor(f"HKinputsMonitorwishbone",self.hk_hdl,inputs['wishbone'],self.clk,self.reset,self.logger,callback=self.wb_models.wishbone_model)
        wishbone_mon_o = HKmonitor(f"HKoutputsMonitorwishbone",self.hk_hdl,outputs['wishbone'],self.clk,self.reset,self.logger)
        if self.checkers:
            wishbone_sb    = Scoreboard(SB_name("wishbone_sb"),fail_immediately=False)
            wishbone_sb.add_interface(wishbone_mon_o, self.wb_models.exp_out_wb)
        # system
        system_mon_i   = HKmonitor(f"HKinputsMonitorsystem",self.hk_hdl,inputs['system'],self.clk,self.reset,self.logger,callback=self.wb_models.system_model)
        # UART
        UART_mon_i     = HKmonitor(f"HKinputsMonitorUART",self.hk_hdl,inputs['UART'],self.clk,self.reset,self.logger,callback=self.wb_models.UART_model)
        UART_mon_o     = HKmonitor(f"HKoutputsMonitorUART",self.hk_hdl,outputs['UART'],self.clk,self.reset,self.logger)
        if self.checkers:
            UART_sb        = Scoreboard(SB_name("UART_sb"),fail_immediately=False)
            UART_sb.add_interface(UART_mon_o, self.wb_models.exp_out_uart_rx)

        # debug
        debug_mon_i     = HKmonitor(f"HKinputsMonitordebug",self.hk_hdl,inputs['debug'],self.clk,self.reset,self.logger,callback=self.wb_models.debug_model)
        debug_mon_o     = HKmonitor(f"HKoutputsMonitordebug",self.hk_hdl,outputs['debug'],self.clk,self.reset,self.logger)
        if self.checkers:
            debug_sb        = Scoreboard(SB_name("debug_sb"),fail_immediately=False)
            debug_sb.add_interface(debug_mon_o, self.wb_models.exp_out_debug)

        # SPI
        SPI_mon_i     = HKSPImonitor(f"HKinputsMonitorSPI",self.hk_hdl,inputs['SPI'],self.clk,self.reset,self.logger,callback=self.wb_models.spi_model)
        SPI_mon_o     = HKSPImonitor(f"HKoutputsMonitorSPI",self.hk_hdl,outputs['SPI'],self.clk,self.reset,self.logger,input=False)
        CSBmonitor(f"HKCSBmonitor",self.hk_hdl,outputs['SPI'],self.clk,self.reset,False,callback=self.wb_models.reset_spi_vals)
        if self.checkers:
            SPI_sb        = Scoreboard(SB_name("SPI_sb"),fail_immediately=False)
            SPI_sb.add_interface(SPI_mon_o, self.wb_models.exp_out_spi)

    """initialize all models needed"""    
    def setupModels(self):
        with open('wb_models/housekeepingWB/HK_regs.json') as f:
            self.reg_model = json.load(f)
        self.wb_models = HK_models(self.reg_model,self.output_if,self.hk_hdl)

    """scoreboard for register model check the reg model with RTL every clock"""
    async def reg_model_sb(self):
        while True:
            await RisingEdge(self.clk)
            for key,memory_block in self.reg_model.items():
                if fnmatch.fnmatch(key,  "_*"):
                    continue
                for reg_shift,reg in memory_block.items():
                    for field in reg:
                        if reg_shift == "base_addr":
                            continue
                        RTL_reg_name = field[1]
                        if RTL_reg_name == None:
                            cocotb.log.debug(f"[HK_whiteBox][reg_model_sb] register {field[1]} in {key} doesn't have a RTL register")
                            continue
                        if isinstance(field[1],list):
                            RTL_name    = field[1][0]
                            first_index = int(field[1][1])
                            second_index= int(field[1][2])
                            if RTL_name in ["serial_xfer"]: continue #TODO: change with SDF only
                            if Macros['GL']:
                                if RTL_name in ["mfgr_id","prod_id","mask_rev","mgmt_gpio_data"]: continue #TODO: change with SDF only
                            if Macros['GL']:
                                if fnmatch.fnmatch (RTL_name,"gpio_configure*"): continue #TODO: update gpio_configure and mgmt_gpio_data to get each bit in the SDF case
                            RTL_reg_path = self.hk_hdl._id(RTL_name,False)
                            size = RTL_reg_path.value.n_bits-1
                            RTL_reg_val  = RTL_reg_path.value[size-first_index:size-second_index]
                        else :
                            if field[1] in ["pwr_ctrl_out","serial_xfer"]: continue #TODO: delete when reset value is spicified
                            RTL_reg_path = self.hk_hdl._id(field[1],False)
                            RTL_reg_val  = RTL_reg_path.value
                        if (RTL_reg_val.integer != field[6]):
                            cocotb.log.error(f'[HK_whiteBox][reg_model_sb] mismatch in register {field[1]} in {key} expected val = {int(field[6])} actual val = {int(RTL_reg_val.binstr,2)} ' )
                        else:
                            cocotb.log.debug(f'[HK_whiteBox][reg_model_sb] match in register {field[1]} in {key} expected val = {field[6]} actual val = {RTL_reg_val.integer} ' )

class SB_name:
    def __init__(self,name) -> None:
        self._name=name

