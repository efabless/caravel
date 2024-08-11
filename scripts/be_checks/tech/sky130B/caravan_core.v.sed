s/.gpio_control_bidir_1.0..gpio_defaults/gpio_defaults[0]/g
s/.gpio_control_bidir_1.1..gpio_defaults/gpio_defaults[1]/g
s/.gpio_control_in_1.2..gpio_defaults/gpio_defaults[10]/g
s/.gpio_control_in_1.3..gpio_defaults/gpio_defaults[11]/g
s/.gpio_control_in_1.4..gpio_defaults/gpio_defaults[12]/g
s/.gpio_control_in_1.5..gpio_defaults/gpio_defaults[13]/g
s/.gpio_control_in_1a.0..gpio_defaults/gpio_defaults[2]/g
s/.gpio_control_in_2.0..gpio_defaults/gpio_defaults[25]/g
s/.gpio_control_in_2.1..gpio_defaults/gpio_defaults[26]/g
s/.gpio_control_in_2.2..gpio_defaults/gpio_defaults[27]/g
s/.gpio_control_in_2.3..gpio_defaults/gpio_defaults[28]/g
s/.gpio_control_in_2.4..gpio_defaults/gpio_defaults[29]/g
s/.gpio_control_in_1a.1..gpio_defaults/gpio_defaults[3]/g
s/.gpio_control_in_2.5..gpio_defaults/gpio_defaults[30]/g
s/.gpio_control_in_2.6..gpio_defaults/gpio_defaults[31]/g
s/.gpio_control_in_2.7..gpio_defaults/gpio_defaults[32]/g
s/.gpio_control_in_2.8..gpio_defaults/gpio_defaults[33]/g
s/.gpio_control_in_2.9..gpio_defaults/gpio_defaults[34]/g
s/.gpio_control_bidir_2.0..gpio_defaults/gpio_defaults[35]/g
s/.gpio_control_bidir_2.1..gpio_defaults/gpio_defaults[36]/g
s/.gpio_control_bidir_2.2..gpio_defaults/gpio_defaults[37]/g
s/.gpio_control_in_1a.2..gpio_defaults/gpio_defaults[4]/g
s/.gpio_control_in_1a.3..gpio_defaults/gpio_defaults[5]/g
s/.gpio_control_in_1a.4..gpio_defaults/gpio_defaults[6]/g
s/.gpio_control_in_1a.5..gpio_defaults/gpio_defaults[7]/g
s/.gpio_control_in_1.0..gpio_defaults/gpio_defaults[8]/g
s/.gpio_control_in_1.1..gpio_defaults/gpio_defaults[9]/g
s/\\mask_rev/mask_rev/g
/wire mask_rev/d
/wire gpio_defaults/d
s/^    user_gpio_noesd);/    user_gpio_noesd,\
    gpio_defaults_out,\
    mask_rev);/
s/^ inout .17:0. user_gpio_noesd;/ inout [17:0] user_gpio_noesd;\
 output [38*13-1:0] gpio_defaults_out;\
 output [31:0] mask_rev;\
\
 wire [12:0] gpio_defaults [37:0];\
 genvar i;\
 generate for (i = 0; i < 38; i = i+1) begin:instgpio\
   assign gpio_defaults_out[13*i +: 13] = gpio_defaults[i];\
 end endgenerate/
