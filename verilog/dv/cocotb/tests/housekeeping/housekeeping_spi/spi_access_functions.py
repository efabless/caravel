

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


async def reg_spi_user_pass_thru(caravelEnv,command,address):
    await caravelEnv.enable_csb()
    await caravelEnv.hk_write_byte(0xc2) # Apply user pass-thru command to housekeeping SPI
    await caravelEnv.hk_write_byte(command) # read command
    address = address.to_bytes(3,'big')
    await caravelEnv.hk_write_byte(address[0]) # high byte 
    await caravelEnv.hk_write_byte(address[1]) # middle byte 
    await caravelEnv.hk_write_byte(address[2]) # low byte 
    
async def reg_spi_user_pass_thru_read(caravelEnv):
    data = await caravelEnv.hk_read_byte() 
    return data

# use for configure in mgmt pass thru or user pass thru
async def reg_spi_op(caravelEnv,command,address):
    await caravelEnv.enable_csb()
    await caravelEnv.hk_write_byte(command) # command
    await caravelEnv.hk_write_byte(address) # Address 
    await caravelEnv.disable_csb()
