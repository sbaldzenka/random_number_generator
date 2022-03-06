#!/bin/bash

cd ../
mkdir generated_files

QUARTUS_CPF=/home/sboldenko/programs/intelFPGA_lite/17.1/quartus/bin/quartus_cpf

$QUARTUS_CPF -c -o bitstream_compression=on quartus/output_files/rng_fpga_design.sof generated_files/system.rbf