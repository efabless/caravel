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

def gpio_mode(gpios_values:list):
    gpios=[]
    for array in gpios_values:
        gpio_value = GPIO_MODE(array[1]).name
        for gpio in array[0]:
            gpios.append((gpio,gpio_value))
    cocotb.log.info(f'[caravel][gpio_mode] gpios {gpios}')
    return gpios

Carvel_Coverage = coverage_section (

  CoverPoint("top.caravel.gpio", vname="gpios mode", xf = lambda gpio ,gpio_mode: (gpio,gpio_mode) ,
  bins = list(product(range(38),[e.name for e in GPIO_MODE])))

)

class Caravel_env:
    def __init__(self,dut:SimHandleBase):
        self.dut         = dut
        self.clk         = dut.clock_tb
        self.caravel_hdl = dut.uut
        self.hk_hdl      = dut.uut.housekeeping

    """start carvel by insert power then reset"""
    async def start_up(self):
        await self.power_up()
        # await self.disable_csb() # no need for this anymore as default for gpio3 is now pullup
        await self.reset()
        await self.disable_bins()
        common.fill_macros(self.dut.macros) # get macros value

    async def disable_bins(self):
        for i in range(38):
            common.drive_hdl(self.dut._id(f"bin{i}_en",False),(0,0),0) 

    """setup the vdd and vcc power bins"""
    async def power_up(self):
        cocotb.log.info(f' [caravel] start powering up')
        self.set_vdd(0)
        self.set_vcc(0)
        await ClockCycles(self.clk, 10)
        cocotb.log.info(f' [caravel] power up -> connect vdd' )
        self.set_vdd(1)
        # await ClockCycles(self.clk, 10)
        cocotb.log.info(f' [caravel] power up -> connect vcc' )
        self.set_vcc(1)
        await ClockCycles(self.clk, 10)

    """"reset caravel"""
    async def reset(self):
        cocotb.log.info(f' [caravel] start resetting')
        self.dut.resetb_tb.value = 0
        await ClockCycles(self.clk, 20)
        self.dut.resetb_tb.value = 1
        await ClockCycles(self.clk, 1)
        cocotb.log.info(f' [caravel] finish resetting')


    def set_vdd(self,value:bool):
        self.dut.vddio_tb.value   = value
        self.dut.vssio_tb.value   = 0
        self.dut.vddio_2_tb.value = value
        self.dut.vssio_2_tb.value = 0
        self.dut.vdda_tb.value    = value
        self.dut.vssa_tb.value    = 0
        self.dut.vdda1_tb.value   = value
        self.dut.vssa1_tb.value   = 0
        self.dut.vdda1_2_tb.value = value
        self.dut.vssa1_2_tb.value = 0
        self.dut.vdda2_tb.value   = value
        self.dut.vssa2_tb.value   = 0

    def set_vcc(self , value:bool):
        self.dut.vccd_tb.value    = value
        self.dut.vssd_tb.value    = 0
        self.dut.vccd1_tb.value   = value
        self.dut.vssd1_tb.value   = 0
        self.dut.vccd2_tb.value   = value
        self.dut.vssd2_tb.value   = 0

    """drive csb signal bin E8 mprj[3]"""
    async def drive_csb(self,bit): 
        self.drive_gpio_in((3,3),bit)
        self.drive_gpio_in((2,2),0)
        await ClockCycles(self.clk, 1)


    """set the spi vsb signal high to disable housekeeping spi transmission bin E8 mprj[3]"""
    async def disable_csb(self ):
        cocotb.log.info(f' [caravel] disable housekeeping spi transmission')
        await self.drive_csb(1)

    """set the spi vsb signal high impedance """
    async def release_csb(self ):
        cocotb.log.info(f' [caravel] release housekeeping spi transmission')
        self.release_gpio(3)
        self.release_gpio(2)
        await ClockCycles(self.clk, 1)

    """set the spi vsb signal low to enable housekeeping spi transmission bin E8 mprj[3]"""
    async def enable_csb(self ):
        cocotb.log.info(f' [caravel] enable housekeeping spi transmission')
        await self.drive_csb(0)
        

    """return the value of mprj in bits used tp monitor the output gpios value"""
    def monitor_gpio(self,bits:tuple):
        mprj = self.dut.mprj_io_tb.value
        size =mprj.n_bits -1 #size of bins array
        mprj_out= self.dut.mprj_io_tb.value[size - bits[0]:size - bits[1]]
        if(mprj_out.is_resolvable):
            cocotb.log.debug(f' [caravel] Monitor : mprj[{bits[0]}:{bits[1]}] = {hex(mprj_out)}')
        else:
            cocotb.log.debug(f' [caravel] Monitor : mprj[{bits[0]}:{bits[1]}] = {mprj_out}')
        return mprj_out

    """return the value of management gpio"""
    def monitor_mgmt_gpio(self):
        data = self.dut.gpio_tb.value
        cocotb.log.debug(f' [caravel] Monitor mgmt gpio = {data}')
        return data

    """change the configration of the gpios by overwrite their defaults value then reset
        need to take at least 1 cycle for reset """
        ### dont use back door accessing 
    async def configure_gpio_defaults(self,gpios_values: list):
        gpio_defaults = self.caravel_hdl.gpio_defaults.value
        cocotb.log.info(f' [caravel] start cofigure gpio gpios ')
        size = gpio_defaults.n_bits -1 #number of bins in gpio_defaults
        # list example [[(gpios),value],[(gpios),value],[(gpios),value]]
        for array in gpios_values:
            gpio_value = array[1]
            for gpio in array[0]:
                self.cov_configure_gpios(gpio,gpio_value.name)
                gpio_defaults[size - (gpio*13 + 12): size -gpio*13] = gpio_value.value
                #cocotb.log.info(f' [caravel] gpio_defaults[{size - (gpio*13 + 12)}:{size -gpio*13}] = {gpio_value.value} ')
        self.caravel_hdl.gpio_defaults.value = gpio_defaults
        #reset
        self.caravel_hdl.gpio_resetn_1_shifted.value = 0
        self.caravel_hdl.gpio_resetn_2_shifted.value = 0
        await ClockCycles(self.clk, 1)
        self.caravel_hdl.gpio_resetn_1_shifted.value = 1
        self.caravel_hdl.gpio_resetn_2_shifted.value = 1
        cocotb.log.info(f' [caravel] finish configuring gpios, the curret gpios value: ')
        self.print_gpios_ctrl_val()    
        
    """change the configration of the gpios by overwrite the register value 
        in control registers and housekeeping regs, don't consume simulation cycles"""
        ### dont use back door accessing 
    def configure_gpios_regs(self,gpios_values: list):
        cocotb.log.info(f' [caravel] start cofigure gpio gpios ')
        control_modules = self.control_blocks_paths()
        # list example [[(gpios),value],[(gpios),value],[(gpios),value]]
        for array in gpios_values:
            gpio_value = array[1]
            for gpio in array[0]:
                self.cov_configure_gpios(gpio,gpio_value.name)
                self.gpio_control_reg_write(control_modules[gpio],gpio_value.value) # for control blocks regs
                self.caravel_hdl.housekeeping.gpio_configure[gpio].value = gpio_value.value # for house keeping regs
        cocotb.log.info(f' [caravel] finish configuring gpios, the curret gpios value: ')
        self.print_gpios_ctrl_val()    
        self.print_gpios_HW_val()

    """dummy function for coverage sampling"""
    @Carvel_Coverage
    def cov_configure_gpios(self,gpio,gpio_mode):
        cocotb.log.debug(f' [caravel] gpio [{gpio}] = {gpio_mode} ')
        pass

    def print_gpios_default_val(self,print=1):
        gpio_defaults = self.caravel_hdl.gpio_defaults.value
        size = gpio_defaults.n_bits -1 #number of bins in gpio_defaults
        gpios = []
        for gpio in range(Macros['MPRJ_IO_PADS']):
            gpio_value = gpio_defaults[size - (gpio*13 + 12): size -gpio*13]
            gpio_enum = GPIO_MODE(gpio_value.integer)
            gpios.append((gpio,gpio_enum))
        group_bins = groupby(gpios,key=lambda x: x[1])
        for key,value in group_bins:
            gpios=[]
            for gpio in list(value):
                gpios.append(gpio[0])
            if (print):
                cocotb.log.info(f' [caravel] gpios[{gpios}] are  {key} ')
        return gpios

    """print the values return in the gpio of control block mode in GPIO Mode format"""
    def print_gpios_ctrl_val(self, print=1):
        control_modules = self.control_blocks_paths()
        gpios = []
        for i , gpio in enumerate(control_modules):
            gpios.append((i,self.gpio_control_reg_read(gpio)))
        group_bins = groupby(gpios,key=lambda x: x[1])
        for key,value in group_bins:
            gpios=[]
            for gpio in list(value):
                gpios.append(gpio[0])
            if (print):
                cocotb.log.info(f' [caravel] gpios[{gpios}] are  {key} ')
        return gpios

    def _check_gpio_ctrl_eq_HW(self):
        assert self.print_gpios_ctrl_val(1) == self.print_gpios_HW_val(1), f'there is an issue while configuration the control block register value isn\'t the same as the house keeping gpio register' 

    """print the values return in the gpio of housekeeping block mode in GPIO Mode format"""
    def print_gpios_HW_val(self,print=1):
        gpios = []
        for pin  in range(Macros['MPRJ_IO_PADS']):
            gpios.append((pin,GPIO_MODE(self.caravel_hdl.housekeeping.gpio_configure[pin].value)))
        group_bins = groupby(gpios,key=lambda x: x[1])
        for key,value in group_bins:
            gpios=[]
            for gpio in list(value):
                gpios.append(gpio[0])
            if (print):
                cocotb.log.info(f' [caravel] gpios[{gpios}] are  {key} ')
        return gpios

            
    """return the paths of the control blocks"""
    def control_blocks_paths(self)-> list:
        car = self.caravel_hdl
        control_modules =[car._id("gpio_control_bidir_1[0]",False),car._id("gpio_control_bidir_1[1]",False)]
        #add gpio_control_in_1a (GPIO 2 to 7)
        for i in range(6):
            control_modules.append(car._id(f'gpio_control_in_1a[{i}]',False))
        #add gpio_control_in_1 (GPIO 8 to 18)
        for i in range(Macros['MPRJ_IO_PADS_1']-9+1):
            control_modules.append(car._id(f'gpio_control_in_1[{i}]',False))        
        #add gpio_control_in_2 (GPIO 19 to 34)
        for i in range(Macros['MPRJ_IO_PADS_2']-4+1):
            control_modules.append(car._id(f'gpio_control_in_2[{i}]',False))
        # Last three GPIOs (spi_sdo, flash_io2, and flash_io3) gpio_control_bidir_2
        for i in range(3):
            control_modules.append(car._id(f'gpio_control_bidir_2[{i}]',False))
        return control_modules

    """read the control register and return a GPIO Mode it takes the path to the control reg"""
    def gpio_control_reg_read(self,path:SimHandleBase) -> GPIO_MODE:
        gpio_mgmt_en     = path.mgmt_ena.value          << MASK_GPIO_CTRL.MASK_GPIO_CTRL_MGMT_EN.value
        gpio_out_dis     = path.gpio_outenb.value       << MASK_GPIO_CTRL.MASK_GPIO_CTRL_OUT_DIS.value
        gpio_holdover    = path.gpio_holdover.value     << MASK_GPIO_CTRL.MASK_GPIO_CTRL_OVERRIDE.value
        gpio_in_dis      = path.gpio_inenb.value        << MASK_GPIO_CTRL.MASK_GPIO_CTRL_INP_DIS.value
        gpio_mode_sel    = path.gpio_ib_mode_sel.value  << MASK_GPIO_CTRL.MASK_GPIO_CTRL_MOD_SEL.value
        gpio_anlg_en     = path.gpio_ana_en.value       << MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_EN.value
        gpio_anlg_sel    = path.gpio_ana_sel.value      << MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_SEL.value
        gpio_anlg_pol    = path.gpio_ana_pol.value      << MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_POL.value
        gpio_slow_sel    = path.gpio_slow_sel.value     << MASK_GPIO_CTRL.MASK_GPIO_CTRL_SLOW.value
        gpio_vtrip_sel   = path.gpio_vtrip_sel.value    << MASK_GPIO_CTRL.MASK_GPIO_CTRL_TRIP.value
        gpio_dgtl_mode   = path.gpio_dm.value           << MASK_GPIO_CTRL.MASK_GPIO_CTRL_DGTL_MODE.value
        control_reg = (gpio_mgmt_en | gpio_out_dis | gpio_holdover| gpio_in_dis | gpio_mode_sel | gpio_anlg_en
        |gpio_anlg_sel|gpio_anlg_pol|gpio_slow_sel|gpio_vtrip_sel|gpio_dgtl_mode)
        return(GPIO_MODE(control_reg))
        
    """read the control register and return a GPIO Mode it takes the path to the control reg"""
    def gpio_control_reg_write(self,path:SimHandleBase,data) :
        bits =common.int_to_bin_list(data,14)
        path.mgmt_ena.value          = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_MGMT_EN.value]
        path.gpio_outenb.value       = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_OUT_DIS.value]
        path.gpio_holdover.value     = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_OVERRIDE.value]
        path.gpio_inenb.value        = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_INP_DIS.value]
        path.gpio_ib_mode_sel.value  = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_MOD_SEL.value]
        path.gpio_ana_en.value       = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_EN.value]
        path.gpio_ana_sel.value      = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_SEL.value]
        path.gpio_ana_pol.value      = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_ANLG_POL.value]
        path.gpio_slow_sel.value     = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_SLOW.value]
        path.gpio_vtrip_sel.value    = bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_TRIP.value]
        gpio_dm   =bits[MASK_GPIO_CTRL.MASK_GPIO_CTRL_DGTL_MODE.value:MASK_GPIO_CTRL.MASK_GPIO_CTRL_DGTL_MODE.value+3]        
        gpio_dm   =sum(d * 2**i for i, d in enumerate(gpio_dm)) # convert list to binary int
        path.gpio_dm.value           = gpio_dm
        
    # """drive the value of mprj bits with spicific data from input pad at the top"""
    # def release_gpio(self):
    #     io = self.caravel_hdl.padframe.mprj_pads.io
    #     mprj , n_bits = common.signal_valueZ_size(io)
    #     io.value  =  mprj
    #     cocotb.log.info(f' [caravel] drive_gpio_in pad mprj with {mprj}')          

    """drive the value of mprj bits with spicific data from input pad at the top"""
    def drive_gpio_in(self,bits,data):
        # io = self.caravel_hdl.padframe.mprj_pads.io
        # mprj , n_bits = common.signal_value_size(io)
        # cocotb.log.debug(f' [caravel] before mprj with {mprj} and data = {data} bit [{n_bits-1-bits[0]}]:[{n_bits-1-bits[1]}]')
        # mprj[n_bits-1-bits[0]:n_bits-1-bits[1]] = data
        # io.value  =  mprj
        # cocotb.log.info(f' [caravel] drive_gpio_in pad mprj with {mprj}')  
        data_bits = []
        is_list  = isinstance(bits, (list,tuple)) 
        if is_list : 
            cocotb.log.debug(f'[caravel] [drive_gpio_in] start bits[1] = {bits[1]} bits[0]= {bits[0]}')
            data_bits = BinaryValue(value = data, n_bits =bits[0]-bits[1]+1 ,bigEndian=(bits[0]<bits[1]))
            for i,bits2 in enumerate(range(bits[1],bits[0]+1)):
                self.dut._id(f"bin{bits2}",False).value = data_bits[i]
                self.dut._id(f"bin{bits2}_en",False).value = 1
                cocotb.log.debug(f'[caravel] [drive_gpio_in] drive bin{bits2} with {data_bits[i]} and bin{bits2}_en with 1')
        else:
            self.dut._id(f'bin{bits}',False).value = data
            self.dut._id(f'bin{bits}_en',False).value = 1
            cocotb.log.debug(f'[caravel] [drive_gpio_in] drive bin{bits} with {data} and bin{bits}_en with 1')

    """ release driving the value of mprj bits """
    def release_gpio(self,bits):
        data_bits = []
        is_list  = isinstance(bits, (list,tuple)) 
        if is_list : 
            cocotb.log.debug(f'[caravel] [drive_gpio_disable] start bits[1] = {bits[1]} bits[0]= {bits[0]}')
            for i,bits2 in enumerate(range(bits[1],bits[0]+1)):
                self.dut._id(f"bin{bits2}_en",False).value = 0
                cocotb.log.debug(f'[caravel] [drive_gpio_disable] release driving bin{bits2}')
        else:
            self.dut._id(f'bin{bits}_en',False).value = 0
            cocotb.log.debug(f'[caravel] [drive_gpio_disable] release driving bin{bits}')


    """drive the value of  gpio management"""
    def drive_mgmt_gpio(self,data):
        mgmt_io = self.dut.gpio_tb
        mgmt_io.value  =  data
        cocotb.log.info(f' [caravel] drive_mgmt_gpio through management area mprj with {data}')

    """update the value of mprj bits with spicific data then after certain number of cycle drive z to free the signal"""
    async def drive_gpio_in_with_cycles(self,bits,data,num_cycles):
        self.drive_gpio_in(bits,data)
        cocotb.log.info(f' [caravel] wait {num_cycles} cycles')
        await cocotb.start(self.wait_then_undrive(bits,num_cycles))
        cocotb.log.info(f' [caravel] finish drive_gpio_with_in_cycles ')

    """drive the value of mprj bits with spicific data from management area then after certain number of cycle drive z to free the signal"""
    async def drive_mgmt_gpio_with_cycles(self,bits,data,num_cycles):
        self.drive_mgmt_gpio(bits,data)
        cocotb.log.info(f' [caravel] wait {num_cycles} cycles')
        await cocotb.start(self.wait_then_undrive(bits,num_cycles))
        cocotb.log.info(f' [caravel] finish drive_gpio_with_in_cycles ') 

    async def wait_then_undrive(self,bits,num_cycles):
        await ClockCycles(self.clk, num_cycles)
        n_bits = bits[0]-bits[1]+1
        self.drive_gpio_in(bits, (n_bits)* 'z')
        cocotb.log.info(f' [caravel] finish wait_then_drive ')

    async def hk_write_byte(self, data):
        self.path = self.dut.mprj_io_tb
        data_bit = BinaryValue(value = data , n_bits = 8,bigEndian=False)
        for i in range(7,-1,-1):
            await FallingEdge(self.clk)
            #common.drive_hdl(self.path,[(4,4),(2,2)],[0,int(data_bit[i])]) # 2 = SDI 4 = SCK
            self.drive_gpio_in((2,2),int(data_bit[i]))
            self.drive_gpio_in((4,4),0)

            await RisingEdge(self.clk)
            self.drive_gpio_in((4,4),1)
        await FallingEdge(self.clk)
        
    """ read byte using housekeeping spi 
        when writing to SCK we can't use mprj[4] as there is a limitation in cocotb for accessing pack array #2587
        so use back door access to write the clock then read the output from the SDO mprj[1] value"""
    async def hk_read_byte(self,last_read= False):
        read_data =''
        for i in range(8,0,-1):
            self.drive_gpio_in((4,4),1)# SCK
            await FallingEdge(self.clk)
            self.drive_gpio_in((4,4),0)# SCK
            await RisingEdge(self.clk)
            read_data= f'{read_data}{self.dut.mprj_io_tb.value[37-1]}'
        await FallingEdge(self.clk)
        self.drive_gpio_in((4,4),0) # SCK
        # if (last_read):
        #     common.drive_hdl(self.dut.bin4_en,(0,0),'z') #4 = SCK
        #     common.drive_hdl(self.path,[(1,1)],'z') 

        return int(read_data,2)
        
    """write to the house keeping registers by back door no need for commands and waiting for the data to show on mprj"""    
    async def hk_write_backdoor(self,addr, data):
        await RisingEdge(self.dut.wb_clk_i)
        self.hk_hdl.wb_stb_i.value = 1
        self.hk_hdl.wb_cyc_i.value = 1
        self.hk_hdl.wb_sel_i.value = 0xF
        self.hk_hdl.wb_we_i.value = 1
        self.hk_hdl.wb_adr_i.value = addr
        self.hk_hdl.wb_dat_i.value = data
        cocotb.log.info(f'Monitor: Start Writing to {hex(addr)} -> {data}')
        await FallingEdge(self.dut.wb_ack_o) # wait for acknowledge
        self.hk_hdl.wb_stb_i.value = 0
        self.hk_hdl.wb_cyc_i.value = 0
        cocotb.log.info(f'Monitor: End writing {hex(addr)} -> {data}')


    """read from the house keeping registers by back door no need for commands and waiting for the data to show on mprj"""    
    async def hk_read_backdoor(self,addr):
        await RisingEdge(self.clk)
        self.hk_hdl.wb_stb_i.value = 1
        self.hk_hdl.wb_cyc_i.value = 1
        self.hk_hdl.wb_sel_i.value = 0
        self.hk_hdl.wb_we_i.value = 0
        self.hk_hdl.wb_adr_i.value = addr
        cocotb.log.info(f' [housekeeping] Monitor: Start reading from {hex(addr)}')
        await FallingEdge(self.hk_hdl.wb_ack_o)
        self.hk_hdl.wb_stb_i.value = 0
        self.hk_hdl.wb_cyc_i.value = 0
        cocotb.log.info(f' [housekeeping] Monitor: read from {hex(addr)} value {(self.hk_hdl.wb_dat_o.value)}')
        return self.hk_hdl.wb_dat_o.value



