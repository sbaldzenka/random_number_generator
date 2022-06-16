#!/bin/bash

cd ../
mkdir generated_files
cd generated_files
mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Boot Script Name" -d boot.script u-boot.scr
