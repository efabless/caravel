# gpio
### gpio_all_i 
```configure all gpios as mgmt input using automatic approach firmware and check them``` 
### gpio_all_i_caravan 
```configure all gpios as mgmt input using automatic approach firmware and check them for caravan``` 
### gpio_all_i_user 
```configure all gpios as user input using automatic approach firmware and check them``` 
### gpio_all_i_pu 
```configure all gpios as mgmt input pull up using automatic approach firmware and check them``` 
### gpio_all_i_pu_caravan 
```configure all gpios as mgmt input pull up using automatic approach firmware and check them for caravan``` 
### gpio_all_i_pu_user 
```configure all gpios as user input pull up using automatic approach firmware and check them``` 
### gpio_all_i_pd 
```configure all gpios as mgmt input pull down using automatic approach firmware and check them``` 
### gpio_all_i_pd_caravan 
```configure all gpios as mgmt input pull down using automatic approach firmware and check them for caravan``` 
### gpio_all_i_pd_user 
```configure all gpios as user input pull down using automatic approach firmware and check them``` 
### gpio_all_bidir_user 
```configure all gpios as user bidir  using automatic approach firmware and check them``` 
### gpio_all_o 
```configure all gpios as mgmt output using automatic approach firmware and check them``` 
### gpio_all_o_caravan 
```configure all gpios as mgmt output using automatic approach firmware and check them for caravan``` 
### gpio_all_o_user 
```configure all gpios as user output using automatic approach firmware and check them``` 
### mgmt_gpio_out 
```tests blinking of mgmt gpio bit as an output``` 
### mgmt_gpio_in 
```tests blinking of mgmt gpio bit as an output``` 
### mgmt_gpio_bidir 
```send random number of blinks through mgmt_gpio and expect to recieve the same number back ``` 
# housekeeping
### hk_disable 
```check Housekeeping SPI disable register is working``` 
### hk_regs_rst_spi 
```check reset value of house keeping registers by reading them trough the spi housekeeping``` 
### hk_regs_wr_wb_cpu 
```bit bash test for housekeeping registers``` 
### hk_regs_wr_spi 
```write then read(the written value) from random housekeeping registers through the SPI housekeeping``` 
### hk_regs_wr_wb 
```write then read (the written value) from random housekeeping registers through the firmware but without using CPU, the SPI and system regs can't be read using firmware so the test only GPIO regs inside housekeeping ``` 
# uart
### uart_rx 
```test uart reception``` 
### uart_loopback 
```test uart in loopback mode input and output is shorted``` 
### uart_tx 
```test uart transmit``` 
# irq
### IRQ_timer 
```test timer0 interrupt``` 
### IRQ_external 
```test external interrupt by mprj 7``` 
### IRQ_uart 
```test timer0 interrupt``` 
# bitbang
### bitbang_cpu_all_i 
``` configure gpio[0:37] as mgmt input using bitbang and check them``` 
### bitbang_spi_o 
```Same as bitbang_cpu_all but configure the gpio using the SPI not the firmware``` 
### bitbang_spi_i 
```Same as bitbang_cpu_all_i but configure the gpio using the SPI not the firmware``` 
### bitbang_cpu_all_o 
```configure all gpios as mgmt output using bitbang and check them``` 
### bitbang_no_cpu_all_o 
```test disable CPU and control the wishbone to configure gpio[4:37] as mgmt output using bitbang and check them``` 
### bitbang_no_cpu_all_i 
```test disable CPU and control the wishbone to configure gpio[0:31] as mgmt input using bitbang and check them``` 
# timer
### timer0_oneshot 
```check timer0 oneshot mode``` 
### timer0_periodic 
```check timer0 periodic mode``` 
# general
### debug 
```use caravel in debug mode and check reading and writing from dff2 RAM``` 
### clock_redirect 
```check clock redirect is working as expected``` 
### mem_dff_W 
```Memory stress for all space of dff``` 
### mem_dff2_W 
```Memory stress for all space of dff2``` 
### helloWorld 
```hello world test``` 
### user_address_space 
```test cpu reset register inside the housekeeping ``` 
### mem_dff2_HW 
```Memory stress for all space of dff2 half word access``` 
### mem_dff_HW 
```Memory stress for all space of dff half word access``` 
### mem_dff2_B 
```Memory stress for all space of dff2 byte access``` 
### mem_dff_B 
```Memory stress for all space of dff byte access``` 
# housekeeping_spi
### spi_master_rd 
```using SPI master for reading from external memory``` 
### user_pass_thru_rd 
```use the housekeeping spi in user pass thru mode to read from external mem``` 
### spi_master_temp 
```To be deleted``` 
### spi_rd_wr_nbyte 
```try housekeeping spi Write and Read in n-byte mode ``` 
# la
### la 
```check logic analyzer input and output enable``` 
# pll
### pll 
```Check pll diffrent configuration``` 
# shifting
### serial_shifting_01 
```shift all the register with 01``` 
### serial_shifting_10 
```shift all the register with 10``` 
### serial_shifting_1100 
```shift all the register with 1100``` 
### serial_shifting_0011 
```shift all the register with 0011``` 
# cpu
### cpu_stress 
```stress the cpu with heavy processing``` 
### cpu_reset 
```test cpu reset register inside the housekeeping ``` 
