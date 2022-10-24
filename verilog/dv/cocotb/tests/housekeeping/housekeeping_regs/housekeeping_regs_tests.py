from json.encoder import INFINITY
import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from interfaces.caravel import GPIO_MODE
from tests.housekeeping.housekeeping_spi.spi_access_functions import *
import json
reg = Regs()


'''randomly write then read housekeeping regs through wishbone'''
@cocotb.test()
@repot_test
async def hk_regs_wr_wb(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=611,num_error=INFINITY)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    with open('wb_models/housekeepingWB/HK_regs.json') as f:
        regs = json.load(f)
    await ClockCycles(caravelEnv.clk, 10)
    # write then read
    for i in range(random.randint(7, 20)):
        bits_num = 32 
        mem = random.choice(['GPIO'])  # can't access 'SPI' and 'sys' register from interfaces.cpu / read or write
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
        await ClockCycles(caravelEnv.clk,10) 

        cocotb.log.info(f"[TEST] expected data calculated = {data_exp}")    
        data_out = await cpu.read_address(address) 
        cocotb.log.info(f"[TEST] Read {bin(data_out)} from {regs[mem][key][0][0]} address {hex(address)} through wishbone")
        if data_out != int(data_exp,2): cocotb.log.error(f"[TEST] wrong read from {regs[mem][key][0][0]} address {hex(address)} retuned val= {bin(data_out)[2:].zfill(bits_num)} expected = {data_exp}")
        else:                           cocotb.log.info(f"[TEST] read the right value {hex(data_out)}  from {regs[mem][key][0][0]} address {hex(address)} ")

'''randomly write then read housekeeping regs through wishbone'''
@cocotb.test()
@repot_test
async def hk_regs_wr_wb_cpu(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=182983,num_error=INFINITY)    
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    reg1 =0 # buffer
    reg2 =0
    regs_list = ("reg_hkspi_status","reg_hkspi_chip_id","reg_hkspi_user_id", "reg_hkspi_pll_ena","reg_hkspi_pll_bypass","reg_hkspi_irq","reg_hkspi_trap","reg_hkspi_pll_trim","reg_hkspi_pll_source","reg_hkspi_pll_divide","reg_clk_out_des","reg_hkspi_disable")
    while True: 
        if cpu.read_debug_reg2() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()  
            if reg1 < 38:              
                cocotb.log.error(f"[TEST] error while writing 0xFFFFFFFF to reg_mprj_io_{reg1-1}")
            else: 
                cocotb.log.error(f"[TEST] error while writing 0xFFFFFFFF to {regs_list[reg1-39]}")
        if reg2 != cpu.read_debug_reg2():
            reg2 = cpu.read_debug_reg2()                
            if reg1 < 38:              
                cocotb.log.error(f"[TEST] error while writing 0x0 to reg_mprj_io_{reg2-1}") 
            else: 
                cocotb.log.error(f"[TEST] error while writing 0x0 to {regs_list[reg1-39]}")      
        await ClockCycles(caravelEnv.clk,1) 

'''randomly write then read housekeeping regs through SPI'''
@cocotb.test()
@repot_test
async def hk_regs_wr_spi(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=1851,num_error=INFINITY)

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
        if address in [111,36,10]: # 111 is for Housekeeping SPI disable, writing 1 to this address will disable the SPI and 36 is for mprj_io[03] changing bit 3 of this register would disable the spi by deassert spi_is_enabled and 10 0xa cpu irq is self resetting 
            continue
        # address = int(key,16)
        if  address in [0x69,0x6A,0x6B,0x6C,0x6D]: # skip testing reg_mprj_datal and reg_mprj_datah because when reading them it's getting the gpio input value
            continue
        data_in = random.getrandbits(bits_num)
        cocotb.log.info(f"[TEST] Writing {bin(data_in)} to reg [{regs[mem][key][0][0]}] address {hex(address)} through SPI")
        await write_reg_spi(caravelEnv,address=address,data=data_in)
        #calculate the expected value for each bit
        is_unknown = False
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
                        bit_exist = True
                        break
                if field_access == "NA": # that mean the value is unknown as the register value can change by hardware mostly the reg value is input to the housekeeping from other blocks 
                    is_unknown = True
                    break
            if not bit_exist:
                data_exp += '0'
        if is_unknown:# that mean the value is unknown as the register value can change by hardware mostly the reg value is input to the housekeeping from other blocks 
            continue

        await ClockCycles(caravelEnv.clk,10) 
        cocotb.log.info(f"[TEST] expected data calculated = {data_exp}")    
        data_out = await read_reg_spi(caravelEnv,address=address) 
        cocotb.log.info(f"[TEST] Read {bin(data_out)} from [{regs[mem][key][0][0]}] address {hex(address)} through SPI")
        if data_out != int(data_exp,2): cocotb.log.error(f"[TEST] wrong read from [{regs[mem][key][0][0]}] address {hex(address)} retuned val= {bin(data_out)[2:].zfill(bits_num)} expected = {data_exp}")
        else:                           cocotb.log.info(f"[TEST] read the right value {hex(data_out)}  from [{regs[mem][key][0][0]}] address {address} ")

'''check reset value of house keeping register'''
@cocotb.test()
@repot_test
async def hk_regs_rst_spi(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=2879,num_error=INFINITY)

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




def generate_key_from_num(num):
    hex_string = hex(num)
    hex_list = [i for i in hex_string]
    if len(hex_list)==3:
        hex_list.insert(2,'0')
    hex_string = "".join(hex_list)
    return hex_string




