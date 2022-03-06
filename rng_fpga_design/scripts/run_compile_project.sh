#!/bin/bash

echo "RUN!"

cd ../quartus

QUARTUS_SH=/home/sboldenko/programs/intelFPGA_lite/17.1/quartus/bin/quartus_sh

$QUARTUS_SH -t ../scripts/rng_fpga_design.tcl -project rng_fpga_design -revision first

quartus_map --read_settings_files=on --write_settings_files=off rng_fpga_design -c rng_fpga_design
quartus_fit --read_settings_files=off --write_settings_files=off rng_fpga_design -c rng_fpga_design
quartus_asm --read_settings_files=off --write_settings_files=off rng_fpga_design -c rng_fpga_design
quartus_sta rng_fpga_design -c rng_fpga_design

echo "COMPLETE!"