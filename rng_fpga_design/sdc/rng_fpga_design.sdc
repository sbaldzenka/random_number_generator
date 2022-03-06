create_clock -name system_clk  -period 20 [get_ports CLK_50]
create_clock -name ada_dco_clk -period 10 [get_ports ADA_DCO]
create_clock -name adb_dco_clk -period 10 [get_ports ADB_DCO]

derive_pll_clocks
derive_clock_uncertainty

set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[0]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[1]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[2]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[3]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[4]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[5]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[6]]
set_false_path -from [get_clocks system_clk] -to [get_ports LEDS[7]]
