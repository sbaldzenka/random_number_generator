module adc_interface_ctrl
#(
    parameter P_COUNTER_ENABLE = 0
)
(
    input wire reset_n              ,

    output wire        AD_CLK_P_IC  ,
    output wire        AD_CLK_N_IC  ,
    input  wire [13:0] AD_D_IC      ,
    input  wire        AD_DCO_IC    ,
    output wire        AD_OE_IC     ,
    input  wire        AD_OR_IC     ,

    input  wire        AD_CLK_P_SYS ,
    input  wire        AD_CLK_N_SYS ,
    output wire [13:0] AD_D_SYS     ,
    output wire        AD_DCO_SYS   ,
    input  wire        AD_OE_SYS    ,
    output wire        AD_OR_SYS
);

    reg [13:0] counter;

    always@(posedge AD_CLK_P_SYS) begin
        if (!reset_n)
            counter <= 14'b0;
        else
            counter <= counter + 1'b1;
    end

    assign AD_CLK_P_IC = (P_COUNTER_ENABLE == 0) ? AD_CLK_P_SYS : 1'b0;
    assign AD_CLK_N_IC = (P_COUNTER_ENABLE == 0) ? AD_CLK_N_SYS : 1'b0;
    assign AD_D_SYS    = (P_COUNTER_ENABLE == 0) ? AD_D_IC : counter;
    assign AD_DCO_SYS  = (P_COUNTER_ENABLE == 0) ? AD_DCO_IC : AD_CLK_P_SYS;
    assign AD_OE_IC    = (P_COUNTER_ENABLE == 0) ? AD_OE_SYS : 1'b0;
    assign AD_OR_SYS   = (P_COUNTER_ENABLE == 0) ? AD_OR_IC : 1'b0;

endmodule