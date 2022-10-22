import cocotb
from tests.common_functions.test_functions import *

@cocotb.test()
@repot_test

async def helloWorld(dut):
    caravelEnv,clock = await test_configure(dut)
    cocotb.log.info("[Test] Hello world")
    caravelEnv.print_gpios_ctrl_val()
    caravelEnv.print_gpios_HW_val()