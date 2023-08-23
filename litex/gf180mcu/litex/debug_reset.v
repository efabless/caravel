	    // ****** added to correct GL testbench failure
        dbg_uart_tx_data <= 8'd0;
        dbg_uart_tx_count <= 4'd0;
        dbg_uart_tx_tick <= 1'd0;
        dbg_uart_tx_phase <= 32'd0;
        dbg_uart_rx_tick <= 1'd0;
        dbg_uart_rx_phase <= 32'd0;
        dbg_uart_rx_rx_d <= 1'd0;
        dbg_uart_cmd <= 8'd0;
        dbg_uart_incr <= 1'd0;
        dbg_uart_address <= 32'd0;
        dbg_uart_data <= 32'd0;
        dbg_uart_bytes_count <= 2'd0;
        dbg_uart_words_count <= 8'd0;
        dbg_uart_count <= 20'd1000000;
	    // ******
