set_global_assignment -entity "pll_shift" -library "lib_pll_shift" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_shift" -library "lib_pll_shift" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "pll_shift" -library "lib_pll_shift" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_shift" -name SPD_FILE [file join $::quartus(sip_path) "pll_shift.spd"]

set_global_assignment -library "lib_pll_shift" -name MISC_FILE [file join $::quartus(sip_path) "pll_shift_sim/pll_shift.vo"]
