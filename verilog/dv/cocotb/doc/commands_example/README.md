# tests commands 
## run one test in RTL
``` python3 verify_cocotb.py -t uart_tx -tag uart_tx_rtl ```

``` python3 verify_cocotb.py -t uart_tx -sim RTL -tag uart_tx_rtl ```
## run one test in GL
``` python3 verify_cocotb.py -t uart_tx -sim GL -tag uart_tx_gl ```
## run one test in more than 1 corner
``` python3 verify_cocotb.py -t uart_tx -sim RTL GL -tag uart_tx_rtl_gl ```
## run more than 1 test
``` python3 verify_cocotb.py -t uart_tx uart_rx -tag uart_tx_rx_rtl ```

``` python3 verify_cocotb.py -t uart_tx uart_rx -sim RTL GL -tag uart_tx_rx_rtl_gl ```

# Regressions commands
## running all RTl tests
``` python3 verify_cocotb.py -r r_rtl -tag all_rtl ```
## running all GL tests
``` python3 verify_cocotb.py -r r_gl -tag all_gl ```

# tests and regression 
``` python3 verify_cocotb.py -r r_rtl -t uart_tx uart_rx -sim GL -tag all_rtl_and_uart_gl ```
