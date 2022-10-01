from json.encoder import INFINITY
import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from cpu import RiskV
from defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from caravel import GPIO_MODE
import json

reg = Regs()


'''randomly write then read housekeeping regs through wishbone'''
@cocotb.test()
@repot_test
async def hk_regs_wr_wb(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=237,num_error=INFINITY)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    with open('wb_models/housekeepingWB/HK_regs.json') as f:
        regs = json.load(f)
    await ClockCycles(caravelEnv.clk, 10)
    # write then read
    for i in range(random.randint(7, 20)):
        bits_num = 32 
        mem = random.choice(['GPIO'])  # can't access 'SPI' and 'sys' register from cpu / read or write
        key = random.choice(list(regs[mem].keys())) 
        if key == 'base_addr':
            continue
        key_num = int(key,16) & 0xFC
        key = generate_key_from_num(key_num)
        address = (int(key,16) + regs[mem]['base_addr'][1])
        if  address in [0x26000010,0x2600000c]: # skip testing reg_mprj_datal and reg_mprj_datah because when reading them it's getting the gpio input value
            continue
        data_in = random.getrandbits(bits_num)
        cocotb.log.info(f"[TEST] Writing {bin(data_in)} to {regs[mem][key][0][0]} address {hex(address)} through wishbone")
        await cpu.drive_data2address(address,data_in) 
        #calculate the expected value for each bit
        data_exp = ''
        keys = [generate_key_from_num(key_num+3),generate_key_from_num(key_num+2),generate_key_from_num(key_num+1),generate_key_from_num(key_num)]
        for count , k in enumerate(keys): 
            for i in range(int(bits_num/len(keys)) * (count),int(bits_num/len(keys)) * (count+1)): 
                bit_exist = False
                if k in regs[mem].keys():
                    for field in regs[mem][k]:
                        field_shift = field[2]
                        field_size  = field[3]
                        field_access  = field[4]
                        i_temp = (bits_num -1 -i) % (bits_num/4)
                        if field_shift <= i_temp and i_temp <= (field_shift + field_size-1):
                            if field_access == "RW":
                                data_exp += bin(data_in)[2:].zfill(bits_num)[i]
                                bit_exist = True
                                break
                if not bit_exist:
                    data_exp += '0'

        cocotb.log.info(f"[TEST] expected data calculated = {data_exp}")    
        data_out = await cpu.read_address(address) 
        cocotb.log.info(f"[TEST] Read {bin(data_out)} from {regs[mem][key][0][0]} address {hex(address)} through wishbone")
        if data_out != int(data_exp,2): cocotb.log.error(f"[TEST] wrong read from {regs[mem][key][0][0]} address {hex(address)} retuned val= {bin(data_out)[2:].zfill(bits_num)} expected = {data_exp}")
        else:                           cocotb.log.debug(f"[TEST] read the right value {hex(data_out)}  from {regs[mem][key][0][0]} address {address} ")

'''randomly write then read housekeeping regs through SPI'''
@cocotb.test()
@repot_test
async def hk_regs_wr_spi(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=100000,num_error=INFINITY)

    with open('wb_models/housekeepingWB/HK_regs.json') as f:
        regs = json.load(f)
    # write then read single byte 
    for i in range(random.randint(10, 40)):
        bits_num = 8 # byte testing
        mem = random.choice(['GPIO','SPI','sys'])  
        key = random.choice(list(regs[mem].keys())) 
        if key == 'base_addr':
            continue
        address = regs[mem][key][0][7]
        if  address in [0x69,0x6A,0x6B,0x6C]: # skip testing reg_mprj_datal and reg_mprj_datah because when reading them it's getting the gpio input value
            continue
        data_in = random.getrandbits(bits_num)
        cocotb.log.info(f"[TEST] Writing {bin(data_in)} to reg [{regs[mem][key][0][0]}] address {hex(address)} through SPI")
        await write_reg_spi(caravelEnv,address=address,data=data_in)
        #calculate the expected value for each bit
        data_exp = ''
        for i in range(bits_num): 
            bit_exist = False
            for field in regs[mem][key]:
                field_shift = field[2]
                field_size  = field[3]
                field_access  = field[4]
                reset_val = field[5]
                i_temp = bits_num -1 -i
                if field_shift <= i_temp and i_temp <= (field_shift + field_size-1):
                    if field_access == "RW":
                        data_exp += bin(data_in)[2:].zfill(bits_num)[i]
                        bit_exist = True
                        break
                    else : # read only get the value from reset 
                        data_exp += bin(reset_val)[2:].zfill(bits_num)[i]
            if not bit_exist:
                data_exp += '0'

        cocotb.log.info(f"[TEST] expected data calculated = {data_exp}")    
        data_out = await read_reg_spi(caravelEnv,address=address) 
        cocotb.log.info(f"[TEST] Read {bin(data_out)} from [{regs[mem][key][0][0]}] address {hex(address)} through SPI")
        if data_out != int(data_exp,2): cocotb.log.error(f"[TEST] wrong read from [{regs[mem][key][0][0]}] address {hex(address)} retuned val= {bin(data_out)[2:].zfill(bits_num)} expected = {data_exp}")
        else:                           cocotb.log.debug(f"[TEST] read the right value {hex(data_out)}  from [{regs[mem][key][0][0]}] address {address} ")

'''check reset value of house keeping register'''
@cocotb.test()
@repot_test
async def hk_regs_rst_spi(dut):
    caravelEnv = await test_configure(dut,timeout_cycles=100000,num_error=INFINITY)

    with open('wb_models/housekeepingWB/HK_regs.json') as f:
        regs = json.load(f)
    # read 
    bits_num = 8 # byte testing
    mems = ['GPIO','SPI','sys']

    for mem in mems:
        keys = [k for k in regs[mem].keys()]
        for key in keys:
            if key == 'base_addr':
                continue
            address = regs[mem][key][0][7]
            if  address in [0x69,0x6A,0x6B,0x6C,0x6D,0x1A]: # skip testing reg_mprj_datal, reg_mprj_datah and usr2_vdd_pwrgood because when reading them it's getting the gpio input value
                continue
            #calculate the expected value for each bit for reset value
            data_exp = ''
            # for i in range(bits_num): 
            bit_exist = False
            for field in regs[mem][key]:
                field_shift = field[2]
                field_size  = field[3]
                field_access  = field[4]
                reset_val = field[5]
                i_temp = bits_num -1 #-i
                # if field_shift <= i_temp and i_temp <= (field_shift + field_size-1):    
                data_exp = bin(reset_val)[2:].zfill(field_size) + data_exp
                print (f'reset = {bin(reset_val)[2:].zfill(bits_num)} data exp = {data_exp} i temp = {i_temp} shift {field_shift} size {field_size}')
                # bit_exist = True
                # break
            # if not bit_exist:
            #     data_exp += '0'

            cocotb.log.info(f"[TEST] expected reset value for [{regs[mem][key][0][0]}] is {data_exp}")    
            data_out = await read_reg_spi(caravelEnv,address=address) 
            cocotb.log.info(f"[TEST] Read {bin(data_out)} from [{regs[mem][key][0][0]}] address {hex(address)} through wishbone")
            if data_out != int(data_exp,2): cocotb.log.error(f"[TEST] wrong reset value read from [{regs[mem][key][0][0]}] address {address} retuned val= {bin(data_out)[2:].zfill(bits_num)} expected = {data_exp}")
            else:                           cocotb.log.info(f"[TEST] read the right reset value {hex(data_out)}  from [{regs[mem][key][0][0]}] address {address} ")




async def write_reg_spi(caravelEnv,address,data):
    await caravelEnv.enable_csb()
    await caravelEnv.hk_write_byte(0x80) # Write stream command
    await caravelEnv.hk_write_byte(address) # Address (register 19 = GPIO bit-bang control)
    await caravelEnv.hk_write_byte(data) # Data = 0x01 (enable bit-bang mode)
    await caravelEnv.disable_csb()


async def read_reg_spi(caravelEnv,address):
    await caravelEnv.enable_csb()
    await caravelEnv.hk_write_byte(0x40) # read stream command
    await caravelEnv.hk_write_byte(address) # Address 
    data = await caravelEnv.hk_read_byte() # Data = 0x01 (enable bit-bang mode)
    await caravelEnv.disable_csb()
    return data


def generate_key_from_num(num):
    hex_string = hex(num)
    hex_list = [i for i in hex_string]
    if len(hex_list)==3:
        hex_list.insert(2,'0')
    hex_string = "".join(hex_list)
    return hex_string




