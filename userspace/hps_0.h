#ifndef _ALTERA_HPS_0_H_
#define _ALTERA_HPS_0_H_

/*
 * This file contains macros for module 'hps_0' and devices
 * connected to the following masters:
 *   h2f_axi_master
 *   h2f_lw_axi_master
 * 
 * Do not include this header file and another header file created for a
 * different module or master group at the same time.
 * Doing so may result in duplicate macro names.
 * Instead, use the system header file which has macros with unique names.
 */

/*
 * Macros for device 'sysid_qsys_0', class 'altera_avalon_sysid_qsys'
 * The macros are prefixed with 'SYSID_QSYS_0_'.
 * The prefix is the slave descriptor.
 */
#define SYSID_QSYS_0_COMPONENT_TYPE altera_avalon_sysid_qsys
#define SYSID_QSYS_0_COMPONENT_NAME sysid_qsys_0
#define SYSID_QSYS_0_BASE 0x0
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_END 0x7
#define SYSID_QSYS_0_ID 18354721
#define SYSID_QSYS_0_TIMESTAMP 1642900828

/*
 * Macros for device 'leds_pio_0', class 'altera_avalon_pio'
 * The macros are prefixed with 'LEDS_PIO_0_'.
 * The prefix is the slave descriptor.
 */
#define LEDS_PIO_0_COMPONENT_TYPE altera_avalon_pio
#define LEDS_PIO_0_COMPONENT_NAME leds_pio_0
#define LEDS_PIO_0_BASE 0x10
#define LEDS_PIO_0_SPAN 16
#define LEDS_PIO_0_END 0x1f
#define LEDS_PIO_0_BIT_CLEARING_EDGE_REGISTER 0
#define LEDS_PIO_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LEDS_PIO_0_CAPTURE 0
#define LEDS_PIO_0_DATA_WIDTH 8
#define LEDS_PIO_0_DO_TEST_BENCH_WIRING 0
#define LEDS_PIO_0_DRIVEN_SIM_VALUE 0
#define LEDS_PIO_0_EDGE_TYPE NONE
#define LEDS_PIO_0_FREQ 50000000
#define LEDS_PIO_0_HAS_IN 0
#define LEDS_PIO_0_HAS_OUT 1
#define LEDS_PIO_0_HAS_TRI 0
#define LEDS_PIO_0_IRQ_TYPE NONE
#define LEDS_PIO_0_RESET_VALUE 170

/*
 * Macros for device 'TERASIC_AD9254_A', class 'TERASIC_AD9254'
 * The macros are prefixed with 'TERASIC_AD9254_A_'.
 * The prefix is the slave descriptor.
 */
#define TERASIC_AD9254_A_COMPONENT_TYPE TERASIC_AD9254
#define TERASIC_AD9254_A_COMPONENT_NAME TERASIC_AD9254_A
#define TERASIC_AD9254_A_BASE 0x20
#define TERASIC_AD9254_A_SPAN 4
#define TERASIC_AD9254_A_END 0x23

/*
 * Macros for device 'TERASIC_AD9254_B', class 'TERASIC_AD9254'
 * The macros are prefixed with 'TERASIC_AD9254_B_'.
 * The prefix is the slave descriptor.
 */
#define TERASIC_AD9254_B_COMPONENT_TYPE TERASIC_AD9254
#define TERASIC_AD9254_B_COMPONENT_NAME TERASIC_AD9254_B
#define TERASIC_AD9254_B_BASE 0x30
#define TERASIC_AD9254_B_SPAN 4
#define TERASIC_AD9254_B_END 0x33

/*
 * Macros for device 'onchip_memory_a', class 'altera_avalon_onchip_memory2'
 * The macros are prefixed with 'ONCHIP_MEMORY_A_'.
 * The prefix is the slave descriptor.
 */
#define ONCHIP_MEMORY_A_COMPONENT_TYPE altera_avalon_onchip_memory2
#define ONCHIP_MEMORY_A_COMPONENT_NAME onchip_memory_a
#define ONCHIP_MEMORY_A_BASE 0x20000
#define ONCHIP_MEMORY_A_SPAN 100000
#define ONCHIP_MEMORY_A_END 0x3869f
#define ONCHIP_MEMORY_A_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY_A_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY_A_CONTENTS_INFO ""
#define ONCHIP_MEMORY_A_DUAL_PORT 1
#define ONCHIP_MEMORY_A_GUI_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY_A_INIT_CONTENTS_FILE system_onchip_memory_a
#define ONCHIP_MEMORY_A_INIT_MEM_CONTENT 0
#define ONCHIP_MEMORY_A_INSTANCE_ID NONE
#define ONCHIP_MEMORY_A_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY_A_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY_A_READ_DURING_WRITE_MODE DONT_CARE
#define ONCHIP_MEMORY_A_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY_A_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY_A_SIZE_VALUE 100000
#define ONCHIP_MEMORY_A_WRITABLE 1
#define ONCHIP_MEMORY_A_MEMORY_INFO_DAT_SYM_INSTALL_DIR SIM_DIR
#define ONCHIP_MEMORY_A_MEMORY_INFO_GENERATE_DAT_SYM 1
#define ONCHIP_MEMORY_A_MEMORY_INFO_GENERATE_HEX 1
#define ONCHIP_MEMORY_A_MEMORY_INFO_HAS_BYTE_LANE 0
#define ONCHIP_MEMORY_A_MEMORY_INFO_HEX_INSTALL_DIR QPF_DIR
#define ONCHIP_MEMORY_A_MEMORY_INFO_MEM_INIT_DATA_WIDTH 16
#define ONCHIP_MEMORY_A_MEMORY_INFO_MEM_INIT_FILENAME system_onchip_memory_a

/*
 * Macros for device 'onchip_memory_b', class 'altera_avalon_onchip_memory2'
 * The macros are prefixed with 'ONCHIP_MEMORY_B_'.
 * The prefix is the slave descriptor.
 */
#define ONCHIP_MEMORY_B_COMPONENT_TYPE altera_avalon_onchip_memory2
#define ONCHIP_MEMORY_B_COMPONENT_NAME onchip_memory_b
#define ONCHIP_MEMORY_B_BASE 0x40000
#define ONCHIP_MEMORY_B_SPAN 100000
#define ONCHIP_MEMORY_B_END 0x5869f
#define ONCHIP_MEMORY_B_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY_B_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY_B_CONTENTS_INFO ""
#define ONCHIP_MEMORY_B_DUAL_PORT 1
#define ONCHIP_MEMORY_B_GUI_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY_B_INIT_CONTENTS_FILE system_onchip_memory_b
#define ONCHIP_MEMORY_B_INIT_MEM_CONTENT 0
#define ONCHIP_MEMORY_B_INSTANCE_ID NONE
#define ONCHIP_MEMORY_B_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY_B_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY_B_READ_DURING_WRITE_MODE DONT_CARE
#define ONCHIP_MEMORY_B_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY_B_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY_B_SIZE_VALUE 100000
#define ONCHIP_MEMORY_B_WRITABLE 1
#define ONCHIP_MEMORY_B_MEMORY_INFO_DAT_SYM_INSTALL_DIR SIM_DIR
#define ONCHIP_MEMORY_B_MEMORY_INFO_GENERATE_DAT_SYM 1
#define ONCHIP_MEMORY_B_MEMORY_INFO_GENERATE_HEX 1
#define ONCHIP_MEMORY_B_MEMORY_INFO_HAS_BYTE_LANE 0
#define ONCHIP_MEMORY_B_MEMORY_INFO_HEX_INSTALL_DIR QPF_DIR
#define ONCHIP_MEMORY_B_MEMORY_INFO_MEM_INIT_DATA_WIDTH 16
#define ONCHIP_MEMORY_B_MEMORY_INFO_MEM_INIT_FILENAME system_onchip_memory_b


#endif /* _ALTERA_HPS_0_H_ */
