#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <error.h>
#include <stdint.h>
#include <sys/mman.h>

#include "../hps_0.h"

// The start address and length of the Lightweight bridge
#define HPS_TO_FPGA_LW_BASE 0xFF200000
#define HPS_TO_FPGA_LW_SPAN 0x100

void *GLOBAL_LW_BRIDGE_ADDRESS;

int main(int argc, char ** argv)
{
    uint32_t *custom_led_map = 0;

    extern void * GLOBAL_LW_BRIDGE_ADDRESS;
    int devmem_fd = 0;

    // Open up the /dev/mem device (aka, RAM)
    devmem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if(devmem_fd < 0)
    {
        perror("devmem open");
        exit(EXIT_FAILURE);
    }

    // mmap() the entire address space of the Lightweight bridge so we can access our custom module
    GLOBAL_LW_BRIDGE_ADDRESS = (uint32_t*)mmap(NULL, HPS_TO_FPGA_LW_SPAN, PROT_READ|PROT_WRITE, MAP_SHARED, devmem_fd, HPS_TO_FPGA_LW_BASE);
    if(GLOBAL_LW_BRIDGE_ADDRESS == MAP_FAILED) 
    {
        perror("devmem mmap");
        close(devmem_fd);
        exit(EXIT_FAILURE);
    }

    custom_led_map = (uint32_t*)(GLOBAL_LW_BRIDGE_ADDRESS + LEDS_PIO_0_BASE);
    *custom_led_map = 0x00;

    uint8_t leds_value = 0x00;
    uint32_t data;

    while(1)
    {
        leds_value++;
        *custom_led_map = leds_value;

        data = *( ( uint32_t *) custom_led_map );
        printf( "data = 0x%08x\n", data );

        usleep(500000);
    }
}