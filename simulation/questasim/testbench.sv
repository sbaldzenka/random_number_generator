`timescale 1ns/100ps

module testbench;

    real        clk_period          = 10.000;

    reg         clk                 = 1;
    reg         reset_n             = 1;

    reg         slave_chip_select_n ;
    reg         slave_read          ;
    wire [31:0] slave_readdata      ;
    reg         slave_write         ;
    reg  [31:0] slave_writedata     ;

    wire        master_chip_select_n;
    wire [16:0] master_addr         ;
    wire        master_write        ;
    wire [15:0] master_writedata    ;
    reg         master_waitrequest_n;

    wire        AD_CLK_P_SYS            ;
    wire        AD_CLK_N_SYS            ;
    wire [13:0] AD_D_SYS                ;
    wire        AD_DCO_SYS              ;
    wire        AD_OE_SYS               ;
    wire        AD_OR_SYS               ;

    wire        AD_CLK_P                ;
    wire        AD_CLK_N                ;
    wire        AD_DCO                  ;
    wire        AD_OE                   ;
    reg         AD_OR                = 0;

    reg  [15:0] mem[0:127]              ;
    reg  [06:0] i                    = 0;
    reg  [15:0] sine                    ;

    always #(clk_period / 2) clk = ~clk;

    initial begin
        #0   reset_n = 1;
        #200 reset_n = 0;
        #500 reset_n = 1;
    end

    initial begin
        $readmemh("sine.dat", mem);
    end

    always@(posedge clk) begin
        i    <= i + 1;
        sine <= mem[i];
    end

    initial begin
        slave_chip_select_n  = 1;
        slave_read           = 0;
        slave_write          = 0;
        slave_writedata      = '0;
        master_waitrequest_n = 1;

        #1000;
        slave_chip_select_n  = 0;
        slave_write          = 1;
        slave_writedata      = 32'h800001FF;
        #clk_period;
        slave_chip_select_n  = 1;
        slave_write          = 0;
        slave_writedata      = 32'h00000000;

        #500;
        slave_chip_select_n  = 0;
        slave_read           = 1;
        #clk_period;
        slave_chip_select_n  = 1;
        slave_read           = 0;

        #5000;
        slave_chip_select_n  = 0;
        slave_read           = 1;
        #clk_period;
        slave_chip_select_n  = 1;
        slave_read           = 0;

        #500;
        slave_chip_select_n  = 0;
        slave_read           = 1;
        #clk_period;
        slave_chip_select_n  = 1;
        slave_read           = 0;
    end

    assign AD_DCO = clk;

    TERASIC_AD9254 TERASIC_AD9254_inst
    (
        .clk                  ( clk                  ),
        .reset_n              ( reset_n              ),

        .slave_chip_select_n  ( slave_chip_select_n  ),
        .slave_read           ( slave_read           ),
        .slave_readdata       ( slave_readdata       ),
        .slave_write          ( slave_write          ),
        .slave_writedata      ( slave_writedata      ),

        .master_chip_select_n ( master_chip_select_n ),
        .master_addr          ( master_addr          ),
        .master_write         ( master_write         ),
        .master_writedata     ( master_writedata     ),
        .master_waitrequest_n ( master_waitrequest_n ),

        .AD_CLK_P             ( AD_CLK_P_SYS         ),
        .AD_CLK_N             ( AD_CLK_N_SYS         ),
        .AD_D                 ( AD_D_SYS             ),
        .AD_DCO               ( AD_DCO_SYS           ),
        .AD_OE                ( AD_OE_SYS            ),
        .AD_OR                ( AD_OR_SYS            )
    );

    adc_interface_ctrl
    #(
        .P_COUNTER_ENABLE ( 1 )
    )
    adc_interface_ctrl_inst
    (
        .reset_n      ( reset_n      ),

        .AD_CLK_P_IC  ( AD_CLK_P     ),
        .AD_CLK_N_IC  ( AD_CLK_N     ),
        .AD_D_IC      ( sine[13:0]   ),
        .AD_DCO_IC    ( AD_DCO       ),
        .AD_OE_IC     ( AD_OE        ),
        .AD_OR_IC     ( AD_OR        ),

        .AD_CLK_P_SYS ( AD_CLK_P_SYS ),
        .AD_CLK_N_SYS ( AD_CLK_N_SYS ),
        .AD_D_SYS     ( AD_D_SYS     ),
        .AD_DCO_SYS   ( AD_DCO_SYS   ),
        .AD_OE_SYS    ( AD_OE_SYS    ),
        .AD_OR_SYS    ( AD_OR_SYS    )
    );

endmodule