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

reg = Regs()

@cocotb.test()
@repot_test
async def bitbang_no_cpu_all_o(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=9373)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_37'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_36'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_35'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_34'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_33'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_32'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_31'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_30'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_29'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_28'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_27'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_26'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_25'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_24'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_23'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_22'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_21'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_20'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_19'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_18'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_17'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_16'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_15'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_14'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_13'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_12'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_11'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_10'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_9'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_8'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_7'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_6'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_5'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_4'),GPIO_MODE.GPIO_MODE_MGMT_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_3'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_2'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_1'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_0'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_0'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 


    #Configure all as output except reg_mprj_io_3
    await clear_registers(cpu)
    await clock_in_right_o_left_o_standard(cpu,0) # 18	and 19	
    await clock_in_right_o_left_o_standard(cpu,0) # 17	and 20	
    await clock_in_right_o_left_o_standard(cpu,0) # 16	and 21	
    await clock_in_right_o_left_o_standard(cpu,0) # 15	and 22	
    await clock_in_right_o_left_o_standard(cpu,0) # 14	and 23	
    await clock_in_right_o_left_o_standard(cpu,0) # 13	and 24	
    await clock_in_right_o_left_o_standard(cpu,0) # 12	and 25	
    await clock_in_right_o_left_o_standard(cpu,0) # 11	and 26	
    await clock_in_right_o_left_o_standard(cpu,0) # 10	and 27	
    await clock_in_right_o_left_o_standard(cpu,0) # 9	and 28	
    await clock_in_right_o_left_o_standard(cpu,0) # 8	and 29	
    await clock_in_right_o_left_o_standard(cpu,0) # 7	and 30	
    await clock_in_right_o_left_o_standard(cpu,0) # 6	and 31	
    await clock_in_right_o_left_o_standard(cpu,0) # 5	and 32	
    await clock_in_right_o_left_o_standard(cpu,0) # 4	and 33	
    await clock_in_right_o_left_i_standard(cpu,0) # 3	and 34	
    await clock_in_right_o_left_i_standard(cpu,0) # 2	and 35	
    await clock_in_right_o_left_i_standard(cpu,0) # 1	and 36	
    await clock_in_end_output(cpu)		          # 0   and 37 and load

    await caravelEnv.release_csb()
    await cpu.drive_data2address(reg.get_addr('reg_mprj_datal'),0x0) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x0) 

    i= 0x20
    for j in range(5):
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),i) 
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,4))} int {caravelEnv.monitor_gpio((37,4)).integer} i = {i}')
        if caravelEnv.monitor_gpio((37,4)).integer != i << 28:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,4))} instead of {bin(i << 28)}')
        # for k in range(250):
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0) 
        if caravelEnv.monitor_gpio((37,4)).integer != 0:
            cocotb.log.error(f'[TEST] Wrong gpio output {caravelEnv.monitor_gpio((37,4))} instead of {bin(0x00000)}')

        i = i >> 1
        i |= 0x20
        await ClockCycles(caravelEnv.clk, 1)

    i= 0x80000000
    for j in range(32):
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x3f) 
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datal'),i) 
        if caravelEnv.monitor_gpio((37,32)).integer != 0x3f:
            cocotb.log.error(f'[TEST] Wrong gpio high bits output {caravelEnv.monitor_gpio((37,32))} instead of {bin(0x3f)}')
        if caravelEnv.monitor_gpio((31,4)).integer != i>>4 :
            cocotb.log.error(f'[TEST] Wrong gpio low bits output {caravelEnv.monitor_gpio((31,4))} instead of {i>>4}')
        cocotb.log.info(f'[Test] gpio out = {caravelEnv.monitor_gpio((37,4))} type {int(caravelEnv.monitor_gpio((37,4)))} i = {i}')
        await ClockCycles(caravelEnv.clk, 1)

        # await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x0) 
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x0) 
        await cpu.drive_data2address(reg.get_addr('reg_mprj_datal'),0x0) 
        await ClockCycles(caravelEnv.clk, 1)

        if caravelEnv.monitor_gpio((37,4)).integer != 0:
            cocotb.log.error(f'Wrong gpio output {caravelEnv.monitor_gpio((37,4))} instead of {bin(0x00000)}')

        i = i >> 1
        i |= 0x80000000


    await ClockCycles(caravelEnv.clk, 1000)



@cocotb.test()
@repot_test
async def bitbang_no_cpu_all_i(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=7351)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_37'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_36'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_35'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_34'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_33'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_32'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_31'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_30'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_29'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_28'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_27'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_26'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_25'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_24'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_23'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_22'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_21'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_20'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_19'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_18'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_17'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_16'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_15'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_14'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_13'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_12'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_11'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_10'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_9'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_8'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_7'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_6'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_5'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_4'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_3'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_2'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_1'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_0'),GPIO_MODE.GPIO_MODE_MGMT_STD_INPUT_NOPULL.value) 


    #Configure all as input except reg_mprj_io_3
    await clear_registers(cpu)
    await clock_in_right_i_left_i_standard(cpu,0) # 18	and 19	
    await clock_in_right_i_left_i_standard(cpu,0) # 17	and 20	
    await clock_in_right_i_left_i_standard(cpu,0) # 16	and 21	
    await clock_in_right_i_left_i_standard(cpu,0) # 15	and 22	
    await clock_in_right_i_left_i_standard(cpu,0) # 14	and 23	
    await clock_in_right_i_left_i_standard(cpu,0) # 13	and 24	
    await clock_in_right_i_left_i_standard(cpu,0) # 12	and 25	
    await clock_in_right_i_left_i_standard(cpu,0) # 11	and 26	
    await clock_in_right_i_left_i_standard(cpu,0) # 10	and 27	
    await clock_in_right_i_left_i_standard(cpu,0) # 9	and 28	
    await clock_in_right_i_left_i_standard(cpu,0) # 8	and 29	
    await clock_in_right_i_left_i_standard(cpu,0) # 7	and 30	
    await clock_in_right_i_left_i_standard(cpu,0) # 6	and 31	
    await clock_in_right_i_left_i_standard(cpu,0) # 5	and 32	
    await clock_in_right_i_left_i_standard(cpu,0) # 4	and 33	
    await clock_in_right_i_left_i_standard(cpu,0) # 3	and 34	
    await clock_in_right_i_left_i_standard(cpu,0) # 2	and 35	
    await clock_in_right_i_left_i_standard(cpu,0) # 1	and 36	
    await clock_in_right_i_left_i_standard(cpu,0) # 0	and 37	
    await load(cpu)		                          # load

    caravelEnv.drive_gpio_in((31,0),0x8F66FD7B)
    await ClockCycles(caravelEnv.clk, 100)
    reg_mprj_datal = await cpu.read_address(reg.get_addr('reg_mprj_datal')) 
    # value_masked = reg_mprj_datal & mask_input
    if reg_mprj_datal == 0x8F66FD7B:
        cocotb.log.info(f'[TEST] Passed with value 0x8F66FD7B')
    else: 
        cocotb.log.error(f'[TEST] fail with value mprj = {bin(reg_mprj_datal)} instead of {bin(0x8F66FD7B)}')
    await ClockCycles(caravelEnv.clk, 100)
    await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x1B) 
    x = caravelEnv.monitor_gpio((37,32))
    print(f"xxxxxxxx {x}")
    await ClockCycles(caravelEnv.clk, 100)

    caravelEnv.drive_gpio_in((31,0),0xFFA88C5A)
    await ClockCycles(caravelEnv.clk, 100)
    reg_mprj_datal = await cpu.read_address(reg.get_addr('reg_mprj_datal')) 
    # value_masked = reg_mprj_datal & mask_input
    if reg_mprj_datal == 0xFFA88C5A:
        cocotb.log.info(f'[TEST] Passed with value 0xFFA88C5A')
    else: 
        cocotb.log.error(f'[TEST] fail with value mprj = {bin(reg_mprj_datal)} instead of {bin(0xFFA88C5A)}')

    await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x2B) 
    await ClockCycles(caravelEnv.clk, 100)

    caravelEnv.drive_gpio_in((31,0),0xC9536346)
    await ClockCycles(caravelEnv.clk, 100)
    reg_mprj_datal = await cpu.read_address(reg.get_addr('reg_mprj_datal')) 
    # value_masked = reg_mprj_datal & mask_input
    if reg_mprj_datal == 0xC9536346:
        cocotb.log.info(f'[TEST] Passed with value 0xC9536346')
    else: 
        cocotb.log.error(f'[TEST] fail with value mprj = {bin(reg_mprj_datal)} instead of {bin(0xC9536346)}')
    await cpu.drive_data2address(reg.get_addr('reg_mprj_datah'),0x3B) 
    await ClockCycles(caravelEnv.clk, 100)




"""Testbench of GPIO configuration through bit-bang method using the  housekeeping SPI."""
@cocotb.test()
@repot_test
async def io_ports(dut):
    caravelEnv,clock = await test_configure(dut)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_0'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_1'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_2'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_3'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_4'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_5'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_6'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_io_7'),GPIO_MODE.GPIO_MODE_USER_STD_OUTPUT.value) 

    # Apply configuration 
    await cpu.drive_data2address(reg.get_addr('reg_mprj_xfer'),1) 

    while True:
        if await cpu.read_address(reg.get_addr('reg_mprj_xfer')) != 1 :
            break
