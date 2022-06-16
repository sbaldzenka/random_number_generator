#!/bin/bash

EMBEDDED_SHELL=/home/sboldenko/programs/intelFPGA_lite/17.1/embedded/embedded_command_shell.sh

$EMBEDDED_SHELL sopc2dts --input ../rng_fpga_design/quartus/system.sopcinfo --output ../generated_files/system.dts --type dts --board ../rng_fpga_design/quartus/hps_isw_handoff/system_hps_0/emif.xml --board ../rng_fpga_design/quartus/hps_isw_handoff/system_hps_0/hps.xml --bridge-removal all --clocks
