from curses import baudrate
import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles,Timer,Edge
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from interfaces.caravel import GPIO_MODE
from interfaces.common import Macros


bit_time_ns = 0
reg = Regs()


@cocotb.test()
@repot_test
async def debug(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=33840)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    # calculate bit time
    clk = clock.period/1000
    global bit_time_ns
    bit_time_ns = round(10**5 * clk / (1152))
    cocotb.log.info(f"[TEST] bit time in nano second = {bit_time_ns}")  
    caravelEnv.drive_gpio_in((0,0),1) # IO[0] affects the uart selecting btw system and debug
    caravelEnv.drive_gpio_in((5,5),1)
    # wait for start of sending
    await wait_reg1(cpu,caravelEnv,0XAA) 
    # caravelEnv.drive_gpio_in((0,0),1) # IO[0] affects the uart selecting btw system and debug
    cocotb.log.info(f"[TEST] Start debug test")  
    # send random data to address 30'h00400024 and expect to recieve the same data back it back
    dff_address = random.randint(0x00000400, 0x00000600) & 0xFFFFFFFC
    data = random.getrandbits(32)
    address = dff_address >>2 # address has to be shifted
    # data = 0xFFFFFFF0
    cocotb.log.info (f"[TEST] Executing DFF2 write address={hex(dff_address)} data = {hex(data)}")
    await wb_write(caravelEnv,address,data)
    receieved_data = await wb_read(caravelEnv,address)
    if data != receieved_data: 
        cocotb.log.error(f"[TEST] DFF2 reading failed from address {hex(address)} expected data = {hex(data)} recieved data = {hex(receieved_data)}")
    else: 
        cocotb.log.info(f"[TEST] PASS: DFF2 reading right value {hex(data)} from {hex(address)} ")

    
async def start_of_tx(caravelEnv):
    while (True): # wait for the start of the transimission it 1 then 0
        if (caravelEnv.monitor_gpio((6,6)).integer == 0):
            break
        await Timer(bit_time_ns, units='ns')
    await Timer(bit_time_ns, units='ns')
        
async def uart_send_char(caravelEnv,char):
    cocotb.log.info (f"[uart_send_char] start sending on uart {char}")
    #send start bit
    caravelEnv.drive_gpio_in((5,5),0)
    await Timer(bit_time_ns, units='ns')
    #send bits 
    for i in range(8):
        caravelEnv.drive_gpio_in((5,5),char[i])
        await Timer(bit_time_ns, units='ns')

    # stop of frame
    caravelEnv.drive_gpio_in((5,5),1)
    await Timer(bit_time_ns, units='ns')
    
async def uart_get_char(caravelEnv):
    await start_of_tx(caravelEnv)
    char  = ''
    for i in range (8):
        char =  caravelEnv.monitor_gpio((6,6)).binstr  + char 
        await Timer(bit_time_ns, units='ns')  
    cocotb.log.info (f"[uart_get_char] recieving {char} from uart")
    
    return char

async def wb_write(caravelEnv,addr,data):
    addr_bits = bin(addr)[2:].zfill(32)[::-1]
    data_bits = bin(data)[2:].zfill(32)[::-1]
    cocotb.log.debug(f"[TEST] address bits = {addr_bits} {type(addr_bits)}")
    await uart_send_char(caravelEnv, '10000000') # write cmd
    await uart_send_char(caravelEnv, '10000000') # size
    await uart_send_char(caravelEnv, addr_bits[24:32]) 
    await uart_send_char(caravelEnv, addr_bits[16:24])
    await uart_send_char(caravelEnv, addr_bits[8:16])
    await uart_send_char(caravelEnv, addr_bits[0:8])
    await uart_send_char(caravelEnv, data_bits[24:32])
    await uart_send_char(caravelEnv, data_bits[16:24])
    await uart_send_char(caravelEnv, data_bits[8:16])
    await uart_send_char(caravelEnv, data_bits[0:8])


async def wb_read(caravelEnv,addr):
    addr_bits = bin(addr)[2:].zfill(32)[::-1]
    await uart_send_char(caravelEnv, '01000000') # read cmd
    await uart_send_char(caravelEnv, '10000000') # size
    await uart_send_char(caravelEnv, addr_bits[24:32])
    await uart_send_char(caravelEnv, addr_bits[16:24])
    await uart_send_char(caravelEnv, addr_bits[8:16])
    await uart_send_char(caravelEnv, addr_bits[0:8])
    data_bits = await uart_get_char(caravelEnv) 
    data_bits += await uart_get_char(caravelEnv)
    data_bits += await uart_get_char(caravelEnv) 
    data_bits += await uart_get_char(caravelEnv) 
    return int(data_bits,2)
