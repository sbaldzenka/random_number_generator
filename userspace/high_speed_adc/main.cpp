#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <socal/hps.h>
#include <unistd.h>
#include "../hps_0.h"
#include "terasic_os.h"

#define HW_REGS_BASE            (ALT_STM_OFST)
#define HW_REGS_SPAN            (0x04000000)
#define HW_REGS_MASK            (HW_REGS_SPAN - 1)

#define H2F_BASE                (0xC0000000)
#define H2F_SPAN                (0x40000000)
#define H2F_MASK                (H2F_SPAN - 1)

#define IORD(base, index)       (*(((uint32_t *)base)+index))
#define IOWR(base, index, data) (*(((uint32_t *)base)+index) = data)

// bit mask for write control
#define START_BIT_MASK          0x80000000
#define DUMMY_DATA_BIT_MASK     0x40000000

// bit mask for read status
#define DONE_BIT_MASK           0x00000001

void ADC_CAPTURE(uint32_t *controller_A, uint32_t *controller_B, int16_t *mem_base_A, int16_t *mem_base_B, int nSampleNum)
{
    uint32_t Control, status_A, status_B;
    int is_done = 0, is_timeout = 0, i;
    int16_t Value_A, Value_B;
    uint32_t Timeout;

    // start capture

    Control = nSampleNum;
    //Control |= DUMMY_DATA_BIT_MASK; for test only
    IOWR(controller_A, 0x00, Control);
    IOWR(controller_B, 0x00, Control);
    Control |= START_BIT_MASK;
    IOWR(controller_A, 0x00, Control); // rising edge to trigger
    IOWR(controller_B, 0x00, Control); // rising edge to trigger
    printf("Start Capture...\n");

    // wait done
    Timeout = OS_GetTickCount() + OS_TicksPerSecond();
    is_done = 0;

    while(is_done != 0x3 && !is_timeout)
    {
        status_A = IORD(controller_A, 0x00);

        if(status_A & DONE_BIT_MASK)
            is_done |= 0x1;

        status_B = IORD(controller_B, 0x00);

        if(status_B & DONE_BIT_MASK)
            is_done |= 0x2;
        else if (OS_GetTickCount() > Timeout)
            is_timeout = 1;
    }

    printf("Channel A status: 0x%xh\n", status_A);
    printf("Channel B status: 0x%xh\n", status_B);

    // dump adc data
    if(is_timeout)
    {
        printf("Timeout! %d\r\n", &Timeout);
    }
    else
    {
        FILE *pFile = fopen("high_speed_adc.csv", "w");
        fprintf(pFile, "t,ADC_A,ADC_B,");
        fprintf(pFile, "Channel A status: 0x%xh,Channel B status: 0x%xh\n", status_A, status_B);

        for(i = 0; i < nSampleNum; i++)
        {
            Value_A = *(mem_base_A + i);
            Value_B = *(mem_base_B + i);

            fprintf(pFile, "%d,%d,%d\n", i, Value_A, Value_B);

            if((i < 10) || (i >= (nSampleNum - 10)))
            { // only printf first 10 & last 10 sample
                printf("ADC_A[%d] = %d(%xh),\t", i, Value_A, (uint16_t) Value_A);
                printf("ADC_B[%d] = %d(%xh)\n", i, Value_B, (uint16_t) Value_B);
            }
        }

        fclose(pFile);
        printf("All data are saved to the file \"high_speed_adc.csv\".\n");
    }
}

//int main(int argc, char *argv[])
int main(void)
{

    printf("ADC!\n");

    const int nSampleNum = 50000;

    int fd;
    void *h2f_lw_virtual_base;
    void *h2f_virtual_base;
    uint32_t *ad9254_a_controller_addr = NULL;
    uint32_t *ad9254_b_controller_addr = NULL;
    int16_t *ad9254_a_data_addr = NULL;
    int16_t *ad9254_b_data_addr = NULL;

    if((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1)
    {
        printf("ERROR: could not open \"/dev/mem\"...\n");
        return (1);
    }

    h2f_lw_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);

    if(h2f_lw_virtual_base == MAP_FAILED)
    {
        printf("ERROR: mmap() failed...\n");
        close(fd);
        return (1);
    }

    h2f_virtual_base = mmap(NULL, H2F_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, H2F_BASE);

    if(h2f_virtual_base == MAP_FAILED)
    {
        printf("ERROR: axi mmap() failed...\n");
        close(fd);
        return (1);
    }

    ad9254_a_controller_addr = (uint32_t*) ((uint8_t*) h2f_virtual_base + (TERASIC_AD9254_A_BASE & H2F_MASK));
    ad9254_b_controller_addr = (uint32_t*) ((uint8_t*) h2f_virtual_base + (TERASIC_AD9254_B_BASE & H2F_MASK));

    ad9254_a_data_addr = (int16_t*) ((uint8_t*) h2f_virtual_base + (ONCHIP_MEMORY_A_BASE & H2F_MASK));
    ad9254_b_data_addr = (int16_t*) ((uint8_t*) h2f_virtual_base + (ONCHIP_MEMORY_B_BASE & H2F_MASK));

    printf("ADC START!\n");

    ADC_CAPTURE(ad9254_a_controller_addr, ad9254_b_controller_addr, ad9254_a_data_addr, ad9254_b_data_addr, nSampleNum);

    if(munmap(h2f_virtual_base, H2F_SPAN) != 0)
    {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return (1);
    }

    if(munmap(h2f_lw_virtual_base, HW_REGS_SPAN) != 0)
    {
        printf("ERROR: munmap() fggailed...\n");
        close(fd);
        return (1);
    }

    close(fd);
    return 0;
}
