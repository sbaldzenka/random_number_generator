`timescale 1ns/100ps

module testbench;

    real        clk_period          = 10.000;

    reg         clk                 = 1;
    wire        clk_shift              ;
    reg         reset_n             = 1;

    reg         slave_chip_select_n_a ;
    reg         slave_read_a          ;
    wire [31:0] slave_readdata_a      ;
    reg         slave_write_a         ;
    reg  [31:0] slave_writedata_a     ;

    wire        master_chip_select_n_a;
    wire [16:0] master_addr_a         ;
    wire        master_write_a        ;
    wire [15:0] master_writedata_a    ;
    reg         master_waitrequest_n_a;

    reg         slave_chip_select_n_b ;
    reg         slave_read_b          ;
    wire [31:0] slave_readdata_b      ;
    reg         slave_write_b         ;
    reg  [31:0] slave_writedata_b     ;

    wire        master_chip_select_n_b;
    wire [16:0] master_addr_b         ;
    wire        master_write_b        ;
    wire [15:0] master_writedata_b    ;
    reg         master_waitrequest_n_b;

    wire        AD_CLK_P_SYS_A            ;
    wire        AD_CLK_N_SYS_A            ;
    wire [13:0] AD_D_SYS_A                ;
    wire        AD_DCO_SYS_A              ;
    wire        AD_OE_SYS_A               ;
    wire        AD_OR_SYS_A               ;

    wire        AD_CLK_P_A                ;
    wire        AD_CLK_N_A                ;
    wire        AD_DCO_A                  ;
    wire        AD_OE_A                   ;
    reg         AD_OR_A                = 0;

    wire        AD_CLK_P_SYS_B            ;
    wire        AD_CLK_N_SYS_B            ;
    wire [13:0] AD_D_SYS_B                ;
    wire        AD_DCO_SYS_B              ;
    wire        AD_OE_SYS_B               ;
    wire        AD_OR_SYS_B               ;

    wire        AD_CLK_P_B                ;
    wire        AD_CLK_N_B                ;
    wire        AD_DCO_B                  ;
    wire        AD_OE_B                   ;
    reg         AD_OR_B                = 0;

    reg  [15:0] mem_a[0:127]              ;
    reg  [06:0] i                      = 0;
    reg  [15:0] sine_a                    ;

    reg  [15:0] mem_b[0:127]              ;
    reg  [06:0] j                      = 0;
    reg  [15:0] sine_b                    ;

    always #(clk_period / 2) clk = ~clk;

    initial begin
        #0   reset_n = 1;
        #200 reset_n = 0;
        #500 reset_n = 1;
    end

    initial begin
        $readmemh("sine.dat", mem_a);
        $readmemh("sine.dat", mem_b);
    end

    always@(posedge AD_DCO_A) begin
        i      <= i + 1;
        sine_a <= mem_a[i];
    end

    always@(posedge AD_DCO_B) begin
        j      <= j + 1;
        sine_b <= mem_b[j];
    end

    initial begin
        slave_chip_select_n_a  = 1;
        slave_read_a           = 0;
        slave_write_a          = 0;
        slave_writedata_a      = '0;
        master_waitrequest_n_a = 1;

        slave_chip_select_n_b  = 1;
        slave_read_b           = 0;
        slave_write_b          = 0;
        slave_writedata_b      = '0;
        master_waitrequest_n_b = 1;

        #1000;
        slave_chip_select_n_a  = 0;
        slave_write_a          = 1;
        slave_writedata_a      = 32'h800001FF;

        slave_chip_select_n_b  = 0;
        slave_write_b          = 1;
        slave_writedata_b      = 32'h800001FF;

        #clk_period;
        slave_chip_select_n_a  = 1;
        slave_write_a          = 0;
        slave_writedata_a      = 32'h00000000;

        slave_chip_select_n_b  = 1;
        slave_write_b          = 0;
        slave_writedata_b      = 32'h00000000;

        #500;
        slave_chip_select_n_a  = 0;
        slave_read_a           = 1;

        slave_chip_select_n_b  = 0;
        slave_read_b           = 1;

        #clk_period;
        slave_chip_select_n_a  = 1;
        slave_read_a           = 0;

        slave_chip_select_n_b  = 1;
        slave_read_b           = 0;

        #5000;
        slave_chip_select_n_a  = 0;
        slave_read_a           = 1;

        slave_chip_select_n_b  = 0;
        slave_read_b           = 1;

        #clk_period;
        slave_chip_select_n_a  = 1;
        slave_read_a           = 0;

        slave_chip_select_n_b  = 1;
        slave_read_b           = 0;

        #500;
        slave_chip_select_n_a  = 0;
        slave_read_a           = 1;

        slave_chip_select_n_b  = 0;
        slave_read_b           = 1;

        #clk_period;
        slave_chip_select_n_a  = 1;
        slave_read_a           = 0;

        slave_chip_select_n_b  = 1;
        slave_read_b           = 0;
    end

    assign AD_DCO_A = clk;
    assign AD_DCO_B = clk_shift;

    TERASIC_AD9254 TERASIC_AD9254_A_inst
    (
        .clk                  ( clk                    ),
        .reset_n              ( reset_n                ),

        .slave_chip_select_n  ( slave_chip_select_n_a  ),
        .slave_read           ( slave_read_a           ),
        .slave_readdata       ( slave_readdata_a       ),
        .slave_write          ( slave_write_a          ),
        .slave_writedata      ( slave_writedata_a      ),

        .master_chip_select_n ( master_chip_select_n_a ),
        .master_addr          ( master_addr_a          ),
        .master_write         ( master_write_a         ),
        .master_writedata     ( master_writedata_a     ),
        .master_waitrequest_n ( master_waitrequest_n_a ),

        .AD_CLK_P             ( AD_CLK_P_SYS_A         ),
        .AD_CLK_N             ( AD_CLK_N_SYS_A         ),
        .AD_D                 ( AD_D_SYS_A             ),
        .AD_DCO               ( AD_DCO_SYS_A           ),
        .AD_OE                ( AD_OE_SYS_A            ),
        .AD_OR                ( AD_OR_SYS_A            )
    );

    TERASIC_AD9254 TERASIC_AD9254_B_inst
    (
        .clk                  ( clk                    ),
        .reset_n              ( reset_n                ),

        .slave_chip_select_n  ( slave_chip_select_n_b  ),
        .slave_read           ( slave_read_b           ),
        .slave_readdata       ( slave_readdata_b       ),
        .slave_write          ( slave_write_b          ),
        .slave_writedata      ( slave_writedata_b      ),

        .master_chip_select_n ( master_chip_select_n_b ),
        .master_addr          ( master_addr_b          ),
        .master_write         ( master_write_b         ),
        .master_writedata     ( master_writedata_b     ),
        .master_waitrequest_n ( master_waitrequest_n_b ),

        .AD_CLK_P             ( AD_CLK_P_SYS_B         ),
        .AD_CLK_N             ( AD_CLK_N_SYS_B         ),
        .AD_D                 ( AD_D_SYS_B             ),
        .AD_DCO               ( AD_DCO_SYS_B           ),
        .AD_OE                ( AD_OE_SYS_B            ),
        .AD_OR                ( AD_OR_SYS_B            )
    );

    adc_interface_ctrl
    #(
        .P_COUNTER_ENABLE ( 0 )
    )
    adc_interface_ctrl_a_inst
    (
        .reset_n      ( reset_n        ),

        .AD_CLK_P_IC  ( AD_CLK_P_A     ),
        .AD_CLK_N_IC  ( AD_CLK_N_A     ),
        .AD_D_IC      ( sine_a[13:0]   ),
        .AD_DCO_IC    ( AD_DCO_A       ),
        .AD_OE_IC     ( AD_OE_A        ),
        .AD_OR_IC     ( AD_OR_A        ),

        .AD_CLK_P_SYS ( AD_CLK_P_SYS_A ),
        .AD_CLK_N_SYS ( AD_CLK_N_SYS_A ),
        .AD_D_SYS     ( AD_D_SYS_A     ),
        .AD_DCO_SYS   ( AD_DCO_SYS_A   ),
        .AD_OE_SYS    ( AD_OE_SYS_A    ),
        .AD_OR_SYS    ( AD_OR_SYS_A    )
    );

    adc_interface_ctrl
    #(
        .P_COUNTER_ENABLE ( 0 )
    )
    adc_interface_ctrl_b_inst
    (
        .reset_n      ( reset_n        ),

        .AD_CLK_P_IC  ( AD_CLK_P_B     ),
        .AD_CLK_N_IC  ( AD_CLK_N_B     ),
        .AD_D_IC      ( sine_b[13:0]   ),
        .AD_DCO_IC    ( AD_DCO_B       ),
        .AD_OE_IC     ( AD_OE_B        ),
        .AD_OR_IC     ( AD_OR_B        ),

        .AD_CLK_P_SYS ( AD_CLK_P_SYS_B ),
        .AD_CLK_N_SYS ( AD_CLK_N_SYS_B ),
        .AD_D_SYS     ( AD_D_SYS_B     ),
        .AD_DCO_SYS   ( AD_DCO_SYS_B   ),
        .AD_OE_SYS    ( AD_OE_SYS_B    ),
        .AD_OR_SYS    ( AD_OR_SYS_B    )
    );

    pll_shift pll_shift_inst
    (
        .refclk   ( AD_CLK_P_B ), // refclk.clk
        .rst      ( 'b0        ), // reset.reset
        .outclk_0 ( clk_shift  )  // outclk0.clk
    );

endmodule