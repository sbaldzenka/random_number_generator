vlib work
vmap work work

vlog ../ip/TERASIC_AD9254/TERASIC_AD9254.v
vlog ../ip/TERASIC_AD9254/AD9254_FIFO.v
vlog ../ip/pll_shift/pll_shift_sim/pll_shift.vo
vlog ../hdl/adc_interface_ctrl.v

vlog testbench.sv

vsim -t 1ps -vopt -voptargs=+acc=lprn -lib work -L work -L altera_ver -L cyclonev_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -L altera_lnsim -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver testbench

do waves.do 
view wave
run 10 us