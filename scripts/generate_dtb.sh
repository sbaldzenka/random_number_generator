#!/bin/bash

dtc -I dts -O dtb -o ../generated_files/system.dtb ../generated_files/system.dts
