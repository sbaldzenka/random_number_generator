
module rng_fpga_design_top
(
    input         CLK_50,
    // GPIO
    output [07:0] LEDS,
    // SD
    output        HPS_SD_CLK,
    inout         HPS_SD_CMD,
    inout  [03:0] HPS_SD_DATA,
    // UART
    input         HPS_UART_RX,
    output        HPS_UART_TX, 
    // DDR3
    output [14:0] HPS_DDR3_ADDR,
    output [02:0] HPS_DDR3_BA,
    output        HPS_DDR3_CAS_N,
    output        HPS_DDR3_CKE,
    output        HPS_DDR3_CK_N,
    output        HPS_DDR3_CK_P,
    output        HPS_DDR3_CS_N,
    output [03:0] HPS_DDR3_DM,
    inout  [31:0] HPS_DDR3_DQ,
    inout  [03:0] HPS_DDR3_DQS_N,
    inout  [03:0] HPS_DDR3_DQS_P,
    output        HPS_DDR3_ODT,
    output        HPS_DDR3_RAS_N,
    output        HPS_DDR3_RESET_N,
    input         HPS_DDR3_RZQ,
    output        HPS_DDR3_WE_N,
    // Ethernet
    output        HPS_ENET_TX_CLK,
    inout         HPS_ENET_INT_N,
    output        HPS_ENET_MDC,
    inout         HPS_ENET_MDIO,
    input         HPS_ENET_RX_CLK,
    input  [03:0] HPS_ENET_RX_DATA,
    input         HPS_ENET_RX_DV,
    output [03:0] HPS_ENET_TX_DATA,
    output        HPS_ENET_TX_EN,
    // AD9254_A
    output        ADA_CLK_P,
    output        ADA_CLK_N,
    input  [13:0] ADA_D,
    input         ADA_DCO,
    output        ADA_OE,
    input         ADA_OR,
    // AD9254_B
    output        ADB_CLK_P,
    output        ADB_CLK_N,
    input  [13:0] ADB_D,
    input         ADB_DCO,
    output        ADB_OE,
    input         ADB_OR,
    // AD9254 control
    inout         AD_SCLK,
    inout         AD_SDIO,
    output        ADA_SPI_CS,
    output        ADB_SPI_CS
);

    wire hps_fpga_reset_n;

    system system_inst
    (
        .clk_clk                               ( CLK_50              ),
        .reset_reset_n                         ( hps_fpga_reset_n    ),
        .hps_0_h2f_reset_reset_n               ( hps_fpga_reset_n    ),

        .hps_io_hps_io_uart0_inst_RX           ( HPS_UART_RX         ),
        .hps_io_hps_io_uart0_inst_TX           ( HPS_UART_TX         ),

        .hps_io_hps_io_sdio_inst_CLK           ( HPS_SD_CLK          ),
        .hps_io_hps_io_sdio_inst_CMD           ( HPS_SD_CMD          ),
        .hps_io_hps_io_sdio_inst_D0            ( HPS_SD_DATA[0]      ),
        .hps_io_hps_io_sdio_inst_D1            ( HPS_SD_DATA[1]      ),
        .hps_io_hps_io_sdio_inst_D2            ( HPS_SD_DATA[2]      ),
        .hps_io_hps_io_sdio_inst_D3            ( HPS_SD_DATA[3]      ),

        .hps_io_hps_io_emac1_inst_TX_CLK       ( HPS_ENET_TX_CLK     ),
        .hps_io_hps_io_emac1_inst_TXD0         ( HPS_ENET_TX_DATA[0] ),
        .hps_io_hps_io_emac1_inst_TXD1         ( HPS_ENET_TX_DATA[1] ),
        .hps_io_hps_io_emac1_inst_TXD2         ( HPS_ENET_TX_DATA[2] ),
        .hps_io_hps_io_emac1_inst_TXD3         ( HPS_ENET_TX_DATA[3] ),
        .hps_io_hps_io_emac1_inst_RXD0         ( HPS_ENET_RX_DATA[0] ),
        .hps_io_hps_io_emac1_inst_MDIO         ( HPS_ENET_MDIO       ),
        .hps_io_hps_io_emac1_inst_MDC          ( HPS_ENET_MDC        ),
        .hps_io_hps_io_emac1_inst_RX_CTL       ( HPS_ENET_RX_DV      ),
        .hps_io_hps_io_emac1_inst_TX_CTL       ( HPS_ENET_TX_EN      ),
        .hps_io_hps_io_emac1_inst_RX_CLK       ( HPS_ENET_RX_CLK     ),
        .hps_io_hps_io_emac1_inst_RXD1         ( HPS_ENET_RX_DATA[1] ),
        .hps_io_hps_io_emac1_inst_RXD2         ( HPS_ENET_RX_DATA[2] ),
        .hps_io_hps_io_emac1_inst_RXD3         ( HPS_ENET_RX_DATA[3] ),

        .memory_mem_a                          ( HPS_DDR3_ADDR       ),
        .memory_mem_ba                         ( HPS_DDR3_BA         ),
        .memory_mem_ck                         ( HPS_DDR3_CK_P       ),
        .memory_mem_ck_n                       ( HPS_DDR3_CK_N       ),
        .memory_mem_cke                        ( HPS_DDR3_CKE        ),
        .memory_mem_cs_n                       ( HPS_DDR3_CS_N       ),
        .memory_mem_ras_n                      ( HPS_DDR3_RAS_N      ),
        .memory_mem_cas_n                      ( HPS_DDR3_CAS_N      ),
        .memory_mem_we_n                       ( HPS_DDR3_WE_N       ),
        .memory_mem_reset_n                    ( HPS_DDR3_RESET_N    ),
        .memory_mem_dq                         ( HPS_DDR3_DQ         ),
        .memory_mem_dqs                        ( HPS_DDR3_DQS_P      ),
        .memory_mem_dqs_n                      ( HPS_DDR3_DQS_N      ),
        .memory_mem_odt                        ( HPS_DDR3_ODT        ),
        .memory_mem_dm                         ( HPS_DDR3_DM         ),
        .memory_oct_rzqin                      ( HPS_DDR3_RZQ        ),

        .terasic_ad9254_b_conduit_end_ad_clk_p ( ADB_CLK_P           ),
        .terasic_ad9254_b_conduit_end_ad_clk_n ( ADB_CLK_N           ),
        .terasic_ad9254_b_conduit_end_ad_d     ( ADB_D               ),
        .terasic_ad9254_b_conduit_end_ad_dco   ( ADB_DCO             ),
        .terasic_ad9254_b_conduit_end_ad_oe    ( ADB_OE              ),
        .terasic_ad9254_b_conduit_end_ad_or    ( ADB_OR              ),

        .terasic_ad9254_a_conduit_end_ad_clk_p ( ADA_CLK_P           ),
        .terasic_ad9254_a_conduit_end_ad_clk_n ( ADA_CLK_N           ),
        .terasic_ad9254_a_conduit_end_ad_d     ( ADA_D               ),
        .terasic_ad9254_a_conduit_end_ad_dco   ( ADA_DCO             ),
        .terasic_ad9254_a_conduit_end_ad_oe    ( ADA_OE              ),
        .terasic_ad9254_a_conduit_end_ad_or    ( ADA_OR              ),

        .hps_0_f2h_stm_hw_events_stm_hwevents  (                     ),
        .leds_pio_0_external_connection_export ( LEDS                )
    );

    assign  AD_SCLK    = 1;                // (DFS)Data Format Select
    assign  AD_SDIO    = 0;                // (DCS)Duty Cycle Stabilizer Select
    assign  ADA_SPI_CS = 1'b1;             // disable ADA_SPI_CS (CSB)
    assign  ADB_SPI_CS = 1'b1;             // disable ADB_SPI_CS (CSB)

endmodule