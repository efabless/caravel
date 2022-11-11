import cocotb
from cocotb.binary import BinaryValue
from cocotb.triggers import Timer, RisingEdge, ReadOnly
import fnmatch
from cocotb.result import TestFailure
from cocotb_coverage.coverage import *

class HK_models():
    def __init__(self,reg_model,expeceted_output,hk_hdl):
        self.reg_model        = reg_model
        self.expeceted_output = expeceted_output
        self.hk_hdl           = hk_hdl
        self.old_hold_val     = 1
        self.gpio_out_pre     = BinaryValue(value=0,n_bits=38,bigEndian=False)
        self.mgmt_gpio_oeb    = BinaryValue(value=0,n_bits=38,bigEndian=False)
        self.exp_out_wb       = [] # expected output for wishbone
        self.exp_out_uart_rx  = [self.expeceted_output['UART']] # expected output for uart
        self.exp_out_debug    = [self.expeceted_output['debug']] # expected output for 
        self.exp_out_spi      = [self.expeceted_output['SPI']] # expected output for
        self.reset_spi_vals(True)
        self.input_dis        =3
        self.regs_full_list() 
        self.intial_cov() 
                                                                        
    """model for the wishbone interface with housekeeping"""
    def wishbone_model(self,trans):
        clock_signal = trans["_clk"]["signal"]
        if trans["stb"]["val"] == 1 : # valid data 
            address = trans["adr"]["val"]
            data = trans["data"]["val"]
            # if ack isn't realsead don't care about the new input it must be the same as the old and the monitor checks that
            if (self.old_hold_val == 0):
                self.old_hold_val = trans["_hold"]["val"]
                return
            self.old_hold_val = trans["_hold"]["val"]
            if trans["write_en"]["val"] ==1 : # write cycle 
                cocotb.log.debug(f'[HK_models][_valid_address] write enable for address: {hex(address)} and data: {hex(data)} ')
                select = trans["sel"]["val"]
                cocotb.scheduler.add(self._write_reg_wb(address,data,select,clock_signal))
            else: #read cycle
                self.write_exp_out_wb(self._read_reg_wb(address))
        self.wishbone_last_trans = trans 

    """model for the system interface with housekeeping"""
    def system_model(self,trans):
        self.reg_model['sys']['0x00'][0][6] = trans["vdd2_good"]["val"]
        self.reg_model['sys']['0x00'][1][6] = trans["vdd1_good"]["val"]
        self.reg_model['sys']['0x00'][2][6] = trans["vcc2_good"]["val"]
        self.reg_model['sys']['0x00'][3][6] = trans["vcc1_good"]["val"]


    """model for the UART interface with housekeeping"""
    def UART_model(self,trans):
        # when transmiting TX the gpio data out should change to the tx value
        if trans["enable"]["val"]:
            self.gpio_out_pre[6]= trans["TX"]["val"].value
        else: 
            gpio_data = self._read_reg_keys(["GPIO","0x0c"]) # mgmt_gpio_data[7:0]
            self.gpio_out_pre[6]= int(gpio_data[len(gpio_data)-1 -6]) # mgmt_gpio_data[6]
        # predecting the rx output value when the value UART is enble is the value drom pin [5]
        gpio_in_size = trans["gpio_in"]["val"].n_bits -1
        output = self.expeceted_output['UART']
        output["RX"]["val"] = 0
        if trans["enable"]["val"]:
            output["RX"]["val"] = trans["gpio_in"]["val"][gpio_in_size-5] #gpio_in[5]
        self.exp_out_uart_rx.append(output)


    """model for the debug interface with housekeeping"""
    def debug_model(self,trans):
        # when debug is enable gpio out [0] should follow debug_out 
        if trans["enable"]["val"]:
            self.gpio_out_pre[0]  = trans["data"]["val"].value
            self.mgmt_gpio_oeb[0] = trans["data"]["val"].value
        else: 
            gpio_data = self._read_reg_keys(["GPIO","0x0c"])  # mgmt_gpio_data[7:0]
            self.gpio_out_pre[0]= int(gpio_data[len(gpio_data)-1 -0]) # mgmt_gpio_data[6]
            gpio_data_en = self._read_reg_keys(["GPIO","0x24"]) # gpio_configure[0][7:0]
            self.mgmt_gpio_oeb[0]= 1- int(gpio_data[len(gpio_data_en)-1 -self.input_dis]) # gpio_configure[0][3]

        # predecting the debug in signal when debug mode is enbled taking the value from pin [0]
        gpio_in_size = trans["gpio_in"]["val"].n_bits -1
        output = self.expeceted_output['debug']
        output["data"]["val"] = 0
        if trans["enable"]["val"]:
            output["data"]["val"] = trans["gpio_in"]["val"][gpio_in_size-0] # mgmt_gpio_in[0]
        self.exp_out_debug.append(output)

    """model for the SPI interface with housekeeping"""
    def spi_model(self,trans):
        output = self.expeceted_output['SPI']
        output["SDO"]["val"] = 0
        cocotb.log.debug(f'[HK_models][spi_model] spi mode {self.spi_mode[0]} bit number {self.spi_mode[1]} command = {self.command_spi} address = {self.address_spi} write = {self.write_spi} stream = {self.spi_mode[2]}')
        if self.spi_mode[0] == "command": 
            self._setCommand(trans['SDI']['val'].binstr)
            self.exp_out_spi.append(output)
        elif self.spi_mode[0] == "address":
            self._setAddress(trans['SDI']['val'].binstr)
            self.exp_out_spi.append(output)
        elif self.spi_mode[0] == "write": 
            self._setWriteData(trans['SDI']['val'].binstr)
            self.exp_out_spi.append(output)
        elif self.spi_mode[0] == "read": 
            output["SDO"]["val"] = self._getReadData()
            self.exp_out_spi.append(output)
        elif self.spi_mode[0] == "read/write": 
            output["SDO"]["val"] = self._ReadWriteMode()
            self.exp_out_spi.append(output)
        elif self.spi_mode[0] == "noOP": 
            self._setWriteData(trans['SDI']['val'].binstr)
        else: 
            raise TestFailure("[HK_models][spi_model] invalid command type")
    

    """reset the spi vals when CSB is going from low to high"""
    def reset_spi_vals(self,trans):
        cocotb.log.info(f"[HK_models][reset_spi_vals] CSB is disabled") 
        self.spi_mode         = ["command",0,0] # [mode type, bit number, stream number]
        self.command_spi      = ['0']*8
        self.address_spi      = ['0']*8
        self.write_spi        = ['0']*8
        self.read_spi         = ['0']*8

    def _setCommand(self,bit):
        if bit not in ['0','1']: 
            cocotb.log.debug(f"[HK_models][_setCommand] incorrect bit size bit = {bit}") 
        self.command_spi[self.spi_mode[1]] = bit
        self.spi_mode[1] += 1 
        self.spi_mode[2] = 0 # stream number 
        if self.spi_mode[1] >= 8: 
            self.spi_mode[0] = "address"
            self.spi_mode[1] = 0

    def _setAddress(self,bit):
        if bit not in ['0','1']: 
            cocotb.log.debug(f"[HK_models][_setAddress] incorrect bit size bit = {bit}") 
        self.address_spi[self.spi_mode[1]] = bit
        self.spi_mode[1] += 1 
        self.spi_mode[2] = 0 # stream number 
        if self.spi_mode[1] >= 8: 
            self.spi_mode[1] = 0
            if self.command_spi[0:2] == ['0','0']: 
                self.spi_mode[0] = "noOP" 
            if self.command_spi[0:2] == ['1','0']: 
                self.spi_mode[0] = "write"
            if self.command_spi[0:2] == ['0','1']: 
                self.spi_mode[0] = "read"
            if self.command_spi[0:2] == ['1','1']: 
                self.spi_mode[0] = "read/write"

    def _setWriteData(self,bit):
        if bit not in ['0','1']: 
            cocotb.log.debug(f"[HK_models][_setWriteData] incorrect bit size bit = {bit}") 
        # return if write is write n-bytes command and number of bytes exceeds the required
        if self.command_spi[2:5] != ['0','0','0']:
            self.spi_mode_cov('write-n')
            byte_num = int(''.join(self.command_spi[2:5]),2)
            if byte_num <= self.spi_mode[2]: #number of written byte <= stream number
                self.spi_mode[0] = "noOP"
                return
        else: self.spi_mode_cov('write')
        self.write_spi[self.spi_mode[1]] = bit
        self.spi_mode[1] += 1 
        if self.spi_mode[1] >= 8: 
            self.spi_mode[1] = 0
            address = int(''.join(self.address_spi),2) + self.spi_mode[2]
            data = ''.join(self.write_spi)
            data = BinaryValue(value = data, n_bits =8)
            is_valid, keys=self._valid_address_spi(address)
            if is_valid:
                self.reg_cov(keys[0],keys[1],is_read=False)
                cocotb.log.debug(f'[HK_models][_valid_address] writing {data} to memory:{keys[0]} field: {keys[1]} through housekeeping SPI address = {address}')
                self._write_fields(keys,data)
            if self.command_spi[2:5] != ['0','0','0']:self.spi_mode_cov('write-n')
            else: self.spi_mode_cov('write') 
            self.spi_mode[2] += 1 # stream number


    def _ReadWriteMode(self,bit): #TODO: add these cases expected values
        # return if write is write n-bytes command and number of bytes exceeds the required
        if self.command_spi[5:7] == ['0','0']: # Simultaneous Read/Write in streaming mode
            self._setWriteData(bit)
            return self._getReadData()
        elif self.command_spi[5:7] != ['1','0']: # Pass-through (management) Read/Write in streaming mode
            self.spi_mode_cov('Pass-m')
        elif self.spi_mode_cov == ['1','1']:
            self.spi_mode_cov('Pass-u')
        return 0

    def _getReadData(self):
        # return if write is write n-bytes command and number of bytes exceeds the required
        if self.command_spi[2:5] != ['0','0','0']:
            byte_num = int(''.join(self.command_spi[2:5]),2)
            if byte_num <= self.spi_mode[2]: #number of written byte <= stream number
                self.spi_mode[0] = "noOP"
                return
        bit_num = self.spi_mode[1]
        address = int(''.join(self.address_spi),2) + self.spi_mode[2]
        is_valid, keys=self._valid_address_spi(address)
        data = ''
        if is_valid:
            self.reg_cov(keys[0],keys[1])
            cocotb.log.info(f'[HK_models][_getReadData] reading from memory:{keys[0]} field: {keys[1]} through SPI')
            for field in self.reg_model[keys[0]][keys[1]]:
                data = str(bin(field[6])[2:]).zfill(field[3]) + data
            data = data.zfill(8)
            cocotb.log.info(f'[HK_models][_getReadData] reading from memory:{keys[0]} field: {keys[1]} through SPI data {data} bit[{7-bit_num}] = {data[bit_num]}') 

        self.spi_mode[1] += 1 
        if self.spi_mode[1] >= 8: 
            self.spi_mode[1] = 0
            self.spi_mode[2] += 1 # stream number  
            if self.command_spi[2:5] != ['0','0','0']:self.spi_mode_cov('read-n')
            else: self.spi_mode_cov('read') 
                
        if data == '':
            return 0
        return int(data[bit_num],2)
        

    def write_exp_out_wb(self,data):
        output = self.expeceted_output['wishbone']
        output['ack']['val']          = 1 
        output['_valid_cycle']['val'] = 1 
        output['data']['val']         =  BinaryValue(value = data,n_bits = 32,bigEndian=False)
        self.exp_out_wb.append(output)

    """write register through wishbone """
    async def _write_reg_wb(self,address,data,select,clk):
        old_data = self._read_reg_wb(address)
        self.write_exp_out_wb(old_data)

        if address == 0x2600000c: # mgmt_gpio_data is a special case as it got written completely at the end of the serial writing 
            for i in range(6):
                await RisingEdge(self.hk_hdl._id(clk,False))

        for i in range(3):
            await RisingEdge(self.hk_hdl._id(clk,False))

        for i,sel in enumerate(select.binstr):
            temp_addr = BinaryValue(value=(address.value +i))
            if sel is '1':
                is_valid, keys=self._valid_address(temp_addr)
                if is_valid:
                    self.reg_cov(keys[0],keys[1],is_SPI=False,is_read=False)
                    cocotb.log.debug(f'[HK_models][_valid_address] writing {data[(8*((4-i-1))):8*(4-i)-1]} to memory:{keys[0]} field: {keys[1]}')
                    temp_data = data[(8*((4-i-1))):8*(4-i)-1]
                    self._write_fields(keys,temp_data)
                cocotb.log.debug(f" [HK_models][_valid_address] address {hex(address)} used for access housekeeping memory success")
            if address != 0x2600000c:
                for i in range(2):
                    await RisingEdge(self.hk_hdl._id(clk,False))

    def _write_fields(self,keys,data):
        for field in self.reg_model[keys[0]][keys[1]]:
            if field[4] == "RW":
                shift = field[2]
                size = field[3]
                cocotb.log.debug(f'[HK_models][_write_fields] before update field : {field[1]} data = {bin(field[6])} with data {data[shift:shift+size-1]} ')
                field[6] = data[8-shift-size:8-shift-1]
                cocotb.log.debug(f'[HK_models][_write_fields] after update field : {field[1]} data = {bin(field[6])} with data {data[shift:shift+size-1]} ')
    """read register value using keys return size binary value"""
    def _read_reg_keys(self,keys:list):
        size =0
        data = ""
        for field in self.reg_model[keys[0]][keys[1]]:
            size += field[3]
            data += bin(field[6])[2:].zfill(size)
        return data
        

    """read register through wishbone """
    def _read_reg_wb(self,address):
        total_size = 32
        data_string ="0"
        data_out = list(bin(0)[2:].zfill(total_size))
        for i in range(4):
            temp_addr = BinaryValue(value=(address.value +i))
            is_valid, keys=self._valid_address(temp_addr)
            if is_valid:
                self.reg_cov(keys[0],keys[1],is_SPI=False)
                for field in self.reg_model[keys[0]][keys[1]]:
                    shift = field[2]
                    size = field[3]
                    first_index  = ((8 *(4-i))) - shift-size    
                    second_index = ((8 *(4-i))) - shift 
                    data = bin(field[6])[2:].zfill(size)
                    cocotb.log.debug(f"[HK_models][_read_reg] memory:{keys[0]} shift:{keys[1]} field:{field[0]} data:{data} ")
                    for k,j in enumerate(range(first_index, second_index, 1)):
                        data_out[j] = data[k]
                    data_string = "".join(data_out)
        cocotb.log.debug(f"[HK_models][_read_reg] register {hex(address)} has value  {hex(int(data_string,2))} ")
        return int(data_string,2)

    """return false if the address isn't exist inside housekeeping if the address exist return true and the key of address in JSON file"""    
    def _valid_address(self,address):
        size = max(len(address),32)
        address = address.binstr.zfill(size)
        for key,memory in self.reg_model.items():
            if fnmatch.fnmatch(key,  "_*") :
                continue
            # remove the first 2 element 0b and 
            base_addr= bin(memory["base_addr"][1])[2:].zfill(size) 
            cocotb.log.debug(f'[HK_models][_valid_address] base address[:13]={hex(int(base_addr[size-32:size-13],2))} target address[:13]={hex(int(address[size-32:size-13],2))} shift={"{0:#0{1}x}".format(int(address[size-12:],2),4)}')
            if base_addr[size-32:size-13] == address[size-32:size-13]:
                if "{0:#0{1}x}".format(int(address[size-12:],2),4)  in memory:
                    cocotb.log.debug(f'[HK_models][_valid_address] base address={hex(int(base_addr,2))} key {key}')
                    return True, [key,"{0:#0{1}x}".format(int(address[size-12:],2),4)]
        cocotb.log.debug(f"[HK_models][_valid_address] address {hex(int(address,2))} used for access housekeeping memory isn't valid")
        return False, None

    """return false if the address isn't exist inside housekeeping if the address exist return true and the key of address in JSON file"""    
    def _valid_address_spi(self,address):
        for key,memory in self.reg_model.items():
            if fnmatch.fnmatch(key,  "_*") :
                continue
            for key2,reg in memory.items():
                if key2 == "base_addr" :
                    continue
                for field in reg:
                    if field[7] == address: 
                        return True,[key,key2]
        cocotb.log.debug(f"[HK_models][_valid_address_spi] address {hex(address)} for SPI housekeeping isn't valid")
        return False, None


######################## coverage ############################
    def regs_full_list(self):
        bins = list()
        labels = list()
        for key,mem in self.reg_model.items():
            if fnmatch.fnmatch(key,  "_*"):
                    continue
            for key2,fields in mem.items():
                if key2=='base_addr':
                    continue
                bins.append((key,key2))
                labels.append((self.reg_model[key][key2][0][0]))
        self.reg_bins = bins
        self.reg_labels = labels
    def intial_cov(self):
        for i in [True,False]:
            for j in [True,False]:
                self.reg_cov(0,0,i,j)
        self.spi_mode_cov(0)

    def reg_cov(self,key1,key2,is_SPI=True,is_read=True):
        s=''
        if is_SPI:
            s = "spi."
        else: 
            s="wishbone."
        if is_read:
            s +="read"
        else: 
            s+= "write"
        @CoverPoint(f"top.caravel.housekeeping.regs.{s}", 
        xf = lambda key1,key2:(key1,key2),
        bins = self.reg_bins,
        bins_labels=self.reg_labels)
        def cov(key1,key2):
            pass
        cov(key1,key2)
        return (key1,key2)


    def spi_mode_cov(self,mode):
        @CoverPoint(f"top.caravel.housekeeping.spi.modes", 
        bins = ['noOP','write','read','read/write','write-n','read-n','read/write-n','Pass-m','pass-u'],
        bins_labels=['No operation','Write in streaming mode','Read in streaming mode','Simultaneous Read/Write in streaming mode','Write in n-byte mode','Read in n-byte mode','Simultaneous Read/Write in n-byte mode','Pass-through (management) Read/Write streaming mode','Pass-through (user) Read/Write in streaming mode' ])
        def cov(mode):
            pass
        cov(mode)
        return mode