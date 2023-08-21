def print_io_east(pad, offset_x, offset_y):
    print(f'''
    - mprj_io_in[''' + str(pad) + '''] + NET mprj_io_in[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_one[''' + str(pad) + '''] + NET mprj_io_one[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+5980), f''') N ;''')
    print(f'''
    - mprj_io_slow_sel[''' + str(pad) + '''] + NET mprj_io_slow_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+9200), f''') N ;''')
    if (pad > 6) & (pad < 36):
        print(f'''
    - user_gpio_analog[''' + str(pad-7) + '''] + NET user_gpio_analog[''' + str(pad-7) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+12420), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+1) + '''] + NET mprj_io_dm[''' + str(pad*3+1) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+18400), f''') N ;''')
    if (pad > 6):
        print(f'''
        - user_gpio_noesd[''' + str(pad-7) + '''] + NET user_gpio_noesd[''' + str(pad-7) + '''] + DIRECTION INPUT + USE SIGNAL
            + PORT
            + LAYER met3 ( -3000 -300 ) ( 3185 300 )
            + PLACED (''', str(offset_x), str(offset_y+21620), f''') N ;''')
    print(f'''
    - mprj_io_analog_en[''' + str(pad) + '''] + NET mprj_io_analog_en[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+24380), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3) + '''] + NET mprj_io_dm[''' + str(pad*3) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+27600), f''') N ;''')
    print(f'''
    - mprj_io_analog_pol[''' + str(pad) + '''] + NET mprj_io_analog_pol[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+30820), f''') N ;''')
    print(f'''
    - mprj_io_inp_dis[''' + str(pad) + '''] + NET mprj_io_inp_dis[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+33580), f''') N ;''')
    print(f'''
    - mprj_io_analog_sel[''' + str(pad) + '''] + NET mprj_io_analog_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+46000), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+2) + '''] + NET mprj_io_dm[''' + str(pad*3+2) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+49220), f''') N ;''')
    print(f'''
    - mprj_io_holdover[''' + str(pad) + '''] + NET mprj_io_holdover[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+52440), f''') N ;''')
    print(f'''
    - mprj_io_out[''' + str(pad) + '''] + NET mprj_io_out[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+55200), f''') N ;''')
    print(f'''
    - mprj_io_vtrip_sel[''' + str(pad) + '''] + NET mprj_io_vtrip_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+64400), f''') N ;''')
    print(f'''
    - mprj_io_ib_mode_sel[''' + str(pad) + '''] + NET mprj_io_ib_mode_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+67620), f''') N ;''')
    print(f'''
    - mprj_io_oeb[''' + str(pad) + '''] + NET mprj_io_oeb[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+70840), f''') N ;''')
    print(f'''
    - mprj_io_in_3v3[''' + str(pad) + '''] + NET mprj_io_in_3v3[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y+73600), f''') N ;''')

def print_io_north(pad, offset_x, offset_y):
    print(f'''
    - mprj_io_in[''' + str(pad) + '''] + NET mprj_io_in[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_one[''' + str(pad) + '''] + NET mprj_io_one[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-5980), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_slow_sel[''' + str(pad) + '''] + NET mprj_io_slow_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-9200), str(offset_y), f''') N ;''')
    if (pad > 6) & (pad < 29):
        print(f'''
    - user_gpio_analog[''' + str(pad-7) + '''] + NET user_gpio_analog[''' + str(pad-7) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-12420), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+1) + '''] + NET mprj_io_dm[''' + str(pad*3+1) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-18400), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_analog_en[''' + str(pad) + '''] + NET mprj_io_analog_en[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-24380), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3) + '''] + NET mprj_io_dm[''' + str(pad*3) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-27600), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_analog_pol[''' + str(pad) + '''] + NET mprj_io_analog_pol[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-30820), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_inp_dis[''' + str(pad) + '''] + NET mprj_io_inp_dis[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-33580), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_analog_sel[''' + str(pad) + '''] + NET mprj_io_analog_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-46000), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+2) + '''] + NET mprj_io_dm[''' + str(pad*3+2) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-49220), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_holdover[''' + str(pad) + '''] + NET mprj_io_holdover[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-52440), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_out[''' + str(pad) + '''] + NET mprj_io_out[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-55200), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_vtrip_sel[''' + str(pad) + '''] + NET mprj_io_vtrip_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-64400), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_ib_mode_sel[''' + str(pad) + '''] + NET mprj_io_ib_mode_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-67620), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_oeb[''' + str(pad) + '''] + NET mprj_io_oeb[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 2935 )
        + PLACED (''', str(offset_x-70840), str(offset_y), f''') N ;''')
    
def print_io_west(pad, offset_x, offset_y):
    print(f'''
    - mprj_io_in[''' + str(pad) + '''] + NET mprj_io_in[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y), f''') N ;''')
    print(f'''
    - mprj_io_one[''' + str(pad) + '''] + NET mprj_io_one[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-5980), f''') N ;''')
    print(f'''
    - mprj_io_slow_sel[''' + str(pad) + '''] + NET mprj_io_slow_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-9200), f''') N ;''')
    if (pad > 6) & (pad < 25):
        print(f'''
    - user_gpio_analog[''' + str(pad-7) + '''] + NET user_gpio_analog[''' + str(pad-7) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-12420), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+1) + '''] + NET mprj_io_dm[''' + str(pad*3+1) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-18400), f''') N ;''')
    if (pad > 6) & (pad < 25):
        print(f'''
    - user_gpio_noesd[''' + str(pad-7) + '''] + NET user_gpio_noesd[''' + str(pad-7) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-21620), f''') N ;''')
    print(f'''
    - mprj_io_analog_en[''' + str(pad) + '''] + NET mprj_io_analog_en[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-24380), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3) + '''] + NET mprj_io_dm[''' + str(pad*3) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-27600), f''') N ;''')
    print(f'''
    - mprj_io_analog_pol[''' + str(pad) + '''] + NET mprj_io_analog_pol[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-30820), f''') N ;''')
    print(f'''
    - mprj_io_inp_dis[''' + str(pad) + '''] + NET mprj_io_inp_dis[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-33580), f''') N ;''')
    print(f'''
    - mprj_io_analog_sel[''' + str(pad) + '''] + NET mprj_io_analog_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-46000), f''') N ;''')
    print(f'''
    - mprj_io_dm[''' + str(pad*3+2) + '''] + NET mprj_io_dm[''' + str(pad*3+2) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-49220), f''') N ;''')
    print(f'''
    - mprj_io_holdover[''' + str(pad) + '''] + NET mprj_io_holdover[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-52440), f''') N ;''')
    print(f'''
    - mprj_io_out[''' + str(pad) + '''] + NET mprj_io_out[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-55200), f''') N ;''')
    print(f'''
    - mprj_io_vtrip_sel[''' + str(pad) + '''] + NET mprj_io_vtrip_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-64400), f''') N ;''')
    print(f'''
    - mprj_io_ib_mode_sel[''' + str(pad) + '''] + NET mprj_io_ib_mode_sel[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-67620), f''') N ;''')
    print(f'''
    - mprj_io_oeb[''' + str(pad) + '''] + NET mprj_io_oeb[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3185 -300 ) ( 3000 300 )
        + PLACED (''', str(offset_x), str(offset_y-70840), f''') N ;''')
    print(f'''
    - mprj_io_in_3v3[''' + str(pad) + '''] + NET mprj_io_in_3v3[''' + str(pad) + '''] + DIRECTION INPUT + USE SIGNAL
        + PORT
        + LAYER met3 ( -3000 -300 ) ( 3185 300 )
        + PLACED (''', str(offset_x), str(offset_y-73600), f''') N ;''')


print(f'''
VERSION 5.8 ;
DIVIDERCHAR "/" ;
BUSBITCHARS "[]" ;
DESIGN caravan_core ;
UNITS DISTANCE MICRONS 1000 ;
DIEAREA ( 0 0 ) ( 3165000 4767000 ) ;
PINS 621 ;
    - clock_core + NET clock_core + DIRECTION INPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 725275 1000 ) N ;
    - flash_clk_frame + NET flash_clk_frame + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1597475 1000 ) N ;
    - flash_clk_oeb + NET flash_clk_oeb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1613115 1000 ) N ;
    - flash_csb_frame + NET flash_csb_frame + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1323475 1000 ) N ;
    - flash_csb_oeb + NET flash_csb_oeb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1339115 1000 ) N ;
    - flash_io0_di + NET flash_io0_di + DIRECTION INPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1816275 1000 ) N ;
    - flash_io0_do + NET flash_io0_do + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1871475 1000 ) N ;
    - flash_io0_ieb + NET flash_io0_ieb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1849855 1000 ) N ;
    - flash_io0_oeb + NET flash_io0_oeb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1887115 1000 ) N ;
    - flash_io1_di + NET flash_io1_di + DIRECTION INPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2090275 1000 ) N ;
    - flash_io1_do + NET flash_io1_do + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2145475 1000 ) N ;
    - flash_io1_ieb + NET flash_io1_ieb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2123855 1000 ) N ;
    - flash_io1_oeb + NET flash_io1_oeb + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2161115 1000 ) N ;
    - gpio_in_core + NET gpio_in_core + DIRECTION INPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2364275 1000 ) N ;
    - gpio_inenb_core + NET gpio_inenb_core + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2397855 1000 ) N ;
    - gpio_mode0_core + NET gpio_mode0_core + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2391875 1000 ) N ;
    - gpio_mode1_core + NET gpio_mode1_core + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2413495 1000 ) N ;
    - gpio_out_core + NET gpio_out_core + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2419475 1000 ) N ;
    - gpio_outenb_core + NET gpio_outenb_core + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 2435115 1000 ) N ;
    - por_l + NET por_l + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 758855 1000 ) N ;
    - porb_h + NET porb_h + DIRECTION OUTPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -3000 ) ( 140 3000 )
        + PLACED ( 1329915 1000 ) N ;
    - rstb_h + NET rstb_h + DIRECTION INPUT + USE SIGNAL
      + PORT
        + LAYER met2 ( -140 -11525 ) ( 140 3000 )
        + PLACED ( 496975 1000 ) N ;

    - user_analog[0] + NET user_analog[0] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -300 ) ( 1000 200 )
        + PLACED ( 3164500 4585280 ) N ;
    - user_analog[1] + NET user_analog[1] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 2966500 4767000 ) N ; 
    - user_analog[2] + NET user_analog[2] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 2451500 4767000 ) N ; 
    - user_analog[3] + NET user_analog[3] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 2194500 4767000 ) N ; 

    - user_analog[4] + NET user_analog[4] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1706500 4767000 ) N ; 
    - user_clamp_high[0] + NET user_clamp_high[0] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1756500 4767000 ) N ; 
    - user_clamp_low[0] + NET user_clamp_low[0] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1743500 4767000 ) N ; 

    - user_analog[5] + NET user_analog[5] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1287500 4767000 ) N ; 
    - user_clamp_high[1] + NET user_clamp_high[1] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1247500 4767000 ) N ; 
    - user_clamp_low[1] + NET user_clamp_low[1] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1234500 4767000 ) N ; 

    - user_analog[6] + NET user_analog[6] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 1024500 4767000 ) N ; 
    - user_clamp_high[2] + NET user_clamp_high[2] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 984500 4767000 ) N ; 
    - user_clamp_low[2] + NET user_clamp_low[2] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 971500 4767000 ) N ;        

    - user_analog[7] + NET user_analog[7] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 725500 4767000 ) N ; 
    - user_analog[8] + NET user_analog[8] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 468500 4767000 ) N ; 
    - user_analog[9] + NET user_analog[9] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( 0 -500 ) ( 500 500 )
        + PLACED ( 211500 4767000 ) N ;       
    - user_analog[10] + NET user_analog[10] + DIRECTION INOUT + USE SIGNAL
      + PORT
        + LAYER met3 ( -500 -300 ) ( 500 200 )
        + PLACED ( 0 4599000 ) N ;    
        
        ''')

## East pads
offset_x = 3164000 
offset_y = 294275
pad = 0
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 226000
pad = 1
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 2
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 226000
pad = 3
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 4
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 5
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 226000
pad = 6
print_io_east(pad, offset_x, offset_y)
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 886000
pad = 7
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 226000
pad = 8
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 9
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 226000
pad = 10
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 11
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 225000
pad = 12
print_io_east(pad, offset_x, offset_y)
offset_y = offset_y + 446000
pad = 13
print_io_east(pad, offset_x, offset_y)

## West pads
offset_x = 1000
offset_y = 4635725
offset_y = offset_y - 849000
pad = 14
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 15
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 16
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 17
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 18
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 19
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 20
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 638000
pad = 21
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 22
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 23
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 24
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 25
print_io_west(pad, offset_x, offset_y)
offset_y = offset_y - 216000
pad = 26
print_io_west(pad, offset_x, offset_y)

print(f'''
END PINS
END DESIGN''')