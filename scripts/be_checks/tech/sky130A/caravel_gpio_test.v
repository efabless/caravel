module gpio_test;

  wire clock_core;
  wire [7:0] value;
  wire flash_clk_frame;
  wire flash_clk_oeb;
  wire flash_csb_frame;
  wire flash_csb_oeb;
  wire flash_io0_di;
  wire flash_io0_do;
  wire flash_io0_ieb;
  wire flash_io0_oeb;
  wire flash_io1_di;
  wire flash_io1_do;
  wire flash_io1_ieb;
  wire flash_io1_oeb;
  wire gpio_in_core;
  wire gpio_inenb_core;
  wire gpio_mode0_core;
  wire gpio_mode1_core;
  wire gpio_out_core;
  wire gpio_outenb_core;
  wire por_l;
  wire porb_h;
  wire rstb_h;
  wire vccd;
  wire vssd;
  wire vccd1;
  wire vssd1;
  wire vssa2;
  wire vdda2;
  wire vssa1;
  wire vdda1;
  wire vssd2;
  wire vccd2;
  wire vddio;
  wire vssio;
  wire [28:0] mprj_analog_io;
  wire [37:0] mprj_io_analog_en;
  wire [37:0] mprj_io_analog_pol;
  wire [37:0] mprj_io_analog_sel;
  wire [113:0] mprj_io_dm;
  wire [37:0] mprj_io_holdover;
  wire [37:0] mprj_io_ib_mode_sel;
  wire [37:0] mprj_io_in;
  wire [37:0] mprj_io_inp_dis;
  wire [37:0] mprj_io_oeb;
  wire [37:0] mprj_io_one;
  wire [37:0] mprj_io_out;
  wire [37:0] mprj_io_slow_sel;
  wire [37:0] mprj_io_vtrip_sel;
  wire [38*13-1:0] all_gpio_defaults;

  wire [12:0] gpio_defaults [37:0];
  wire [31:0] mask_rev;

 assign vccd = 1;
 assign vssd = 0;

 genvar i;
 generate for (i = 0; i < 38; i = i+1) begin:instgpio
   assign gpio_defaults[i] = all_gpio_defaults[13*i +: 13];
 end endgenerate

  caravel_core caravel_core_0 (
    .clock_core(clock_core),
    .flash_clk_frame(flash_clk_frame),
    .flash_clk_oeb(flash_clk_oeb),
    .flash_csb_frame(flash_csb_frame),
    .flash_csb_oeb(flash_csb_oeb),
    .flash_io0_di(flash_io0_di),
    .flash_io0_do(flash_io0_do),
    .flash_io0_ieb(flash_io0_ieb),
    .flash_io0_oeb(flash_io0_oeb),
    .flash_io1_di(flash_io1_di),
    .flash_io1_do(flash_io1_do),
    .flash_io1_ieb(flash_io1_ieb),
    .flash_io1_oeb(flash_io1_oeb),
    .gpio_in_core(gpio_in_core),
    .gpio_inenb_core(gpio_inenb_core),
    .gpio_mode0_core(gpio_mode0_core),
    .gpio_mode1_core(gpio_mode1_core),
    .gpio_out_core(gpio_out_core),
    .gpio_outenb_core(gpio_outenb_core),
    .por_l(por_l),
    .porb_h(porb_h),
    .rstb_h(rstb_h),
    .vccd(vccd),
    .vssd(vssd),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .vssa2(vssa2),
    .vdda2(vdda2),
    .vssa1(vssa1),
    .vdda1(vdda1),
    .vssd2(vssd2),
    .vccd2(vccd2),
    .vddio(vddio),
    .vssio(vssio),
    .mprj_analog_io(mprj_analog_io),
    .mprj_io_analog_en(mprj_io_analog_en),
    .mprj_io_analog_pol(mprj_io_analog_pol),
    .mprj_io_analog_sel(mprj_io_analog_sel),
    .mprj_io_dm(mprj_io_dm),
    .mprj_io_holdover(mprj_io_holdover),
    .mprj_io_ib_mode_sel(mprj_io_ib_mode_sel),
    .mprj_io_in(mprj_io_in),
    .mprj_io_inp_dis(mprj_io_inp_dis),
    .mprj_io_oeb(mprj_io_oeb),
    .mprj_io_one(mprj_io_one),
    .mprj_io_out(mprj_io_out),
    .mprj_io_slow_sel(mprj_io_slow_sel),
    .mprj_io_vtrip_sel(mprj_io_vtrip_sel),
    .gpio_defaults_out(all_gpio_defaults),
    .mask_rev(mask_rev)
  );

initial begin
    #10 $monitor("Actual");
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 0, gpio_defaults[0]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 1, gpio_defaults[1]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 2, gpio_defaults[2]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 3, gpio_defaults[3]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 4, gpio_defaults[4]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 5, gpio_defaults[5]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 6, gpio_defaults[6]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 7, gpio_defaults[7]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 8, gpio_defaults[8]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 9, gpio_defaults[9]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 10, gpio_defaults[10]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 11, gpio_defaults[11]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 12, gpio_defaults[12]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 13, gpio_defaults[13]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 14, gpio_defaults[14]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 15, gpio_defaults[15]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 16, gpio_defaults[16]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 17, gpio_defaults[17]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 18, gpio_defaults[18]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 19, gpio_defaults[19]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 20, gpio_defaults[20]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 21, gpio_defaults[21]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 22, gpio_defaults[22]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 23, gpio_defaults[23]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 24, gpio_defaults[24]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 25, gpio_defaults[25]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 26, gpio_defaults[26]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 27, gpio_defaults[27]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 28, gpio_defaults[28]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 29, gpio_defaults[29]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 30, gpio_defaults[30]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 31, gpio_defaults[31]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 32, gpio_defaults[32]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 33, gpio_defaults[33]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 34, gpio_defaults[34]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 35, gpio_defaults[35]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 36, gpio_defaults[36]);
    #10 $monitor("USER_CONFIG_GPIO_%1d_INIT %h", 37, gpio_defaults[37]);
    #10 $monitor("Setting Project Chip ID to: %h", mask_rev);
    #100 $stop;
end

endmodule // gpio_test

