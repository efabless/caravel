

import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer
import cocotb.log
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *


#VIP for SPI 
"""
    support commands 
    00000000 -> No operation
    00000011 -> Read in streaming mode
"""
async def SPI_VIP(csb,clk,SDI,SDO,mem):
    while True:
        await FallingEdge(csb)
        cocotb.log.info (f"[SPI_VIP] CSB is asserted operation has begin ")
        op = await  cocotb.start(SPI_op(clk,SDI,SDO,mem)) 
        await csb_watcher(csb,op)
        cocotb.log.info (f"[SPI_VIP] CSB is deasserted operation has been killed")

# cocotb.scheduler.add
# watch the csb and when it's diable kill the SPI_op thread
async def csb_watcher(csb,thread): 
    cocotb.log.info (f"[csb_watcher] start CSB watching")
    await RisingEdge(csb) 
    thread.kill()            

# detect command and address and apply the command
async def SPI_op(clk,SDI,SDO,mem): 
    address =''
    command =''
    await RisingEdge(clk) 
    # command
    for i in range(8): 
        command = command + SDI.value.binstr
        await RisingEdge(clk)
    cocotb.log.info (f"[SPI_VIP] [SPI_op] command = {command}")
    # address
    address =''
    for i in range(8*3):  # address is 3 parts each part are 8 bits
        address = address + SDI.value.binstr
        if i != 23: # skip last cycle wait
            await RisingEdge(clk)
    cocotb.log.info (f"[SPI_VIP] [SPI_op] address = {address}")
    address = int(address,2)
    #data 
    if command == "10000000" and False: # not sure about the read command
        for i in range(8):
            data_in += SDI
            await RisingEdge(clk)
    elif command == "00000011":
        await FallingEdge(clk)
        while True: 
            data = bin(mem[address])[2:].zfill(8)
            for i in range(8):
                SDO[0].value = 1 # enable 
                SDO[1].value = int(data[i],2) # bin 
                cocotb.log.debug (f"[SPI_VIP] [SPI_op] SDO = {data[i]} ")
                await FallingEdge(clk)
            SDO[0].value = 0 # enable 
            
            cocotb.log.info (f"[SPI_VIP] [SPI_op] finish reading address {hex(address) } data = {hex(int(data,2))} ")
            address +=1


def read_mem (file_name): 
    with open(file_name, 'r') as file:
        lines = file.readlines()
        mem = dict()
        for line in lines:
            if line[0] == "@":
                address = int(line[1:],16) 
                cocotb.log.debug (f" found line = {line} address = {hex(address)} ")
            else:
                line_no_space = line.strip().replace(' ','')
                for i in range (0,len(line_no_space),2):
                    cocotb.log.debug (f" i = {i} ine_no_space[{i}:{i+2}] = {line_no_space[i:i+2]} address = {hex(address)}")
                    mem[address] = int(line_no_space[i:i+2],16)
                    address +=1
                cocotb.log.debug (f" found line = {line}  line_no_space = {line_no_space} size = {len(line_no_space)}")
        cocotb.log.info (f"[read_mem] SPI mem = {mem}")
        return mem

