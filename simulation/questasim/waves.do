
add wave -noupdate -divider testbench
add wave -noupdate -format Logic -radix HEXADECIMAL  -group {testbench} /testbench/*

add wave -noupdate -divider TERASIC_AD9254_A
add wave -noupdate -format Logic -radix HEXADECIMAL  -group {TERASIC_AD9254_A} /testbench/TERASIC_AD9254_A_inst/*

add wave -noupdate -divider TERASIC_AD9254_B
add wave -noupdate -format Logic -radix HEXADECIMAL  -group {TERASIC_AD9254_B} /testbench/TERASIC_AD9254_B_inst/*

add wave -noupdate -divider adc_interface_ctrl_a
add wave -noupdate -format Logic -radix HEXADECIMAL  -group {adc_interface_ctrl_a} /testbench/adc_interface_ctrl_a_inst/*

add wave -noupdate -divider adc_interface_ctrl_b
add wave -noupdate -format Logic -radix HEXADECIMAL  -group {adc_interface_ctrl_b} /testbench/adc_interface_ctrl_b_inst/*

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1611 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps