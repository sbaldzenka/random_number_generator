module TERASIC_AD9254
(
    input  wire        clk                 ,
    input  wire        reset_n             ,
    // avalon slave port
    input  wire        slave_chip_select_n ,
    input  wire        slave_read          ,
    output reg  [31:0] slave_readdata      ,
    input  wire        slave_write         ,
    input  wire [31:0] slave_writedata     ,
    // avalon master port
    output wire        master_chip_select_n,
    output wire [16:0] master_addr         ,// byte addresss
    output wire        master_write        ,
    output wire [15:0] master_writedata    ,
    input  wire        master_waitrequest_n,
    // export
    output wire        AD_CLK_P            ,
    output wire        AD_CLK_N            ,
    input  wire [13:0] AD_D                ,
    input  wire        AD_DCO              ,
    output wire        AD_OE               ,
    input  wire        AD_OR                // out of range
);

    // register
    // addr 0 write:
    //          bit 0: capture flag. rising trigger
    //          bit 1~31: capture number (<= 50000)
    // addr 0 read:
    //          bit 0: done flag

    ////////////////
    // avalon slave
    reg        flag_done/*synthesis noprune*/;
    reg        flag_capture/*synthesis noprune*/;
    reg [19:0] flag_capture_num/*synthesis noprune*/;
    reg        flag_dummy_data/*synthesis noprune*/;

    //wire reading_adc;
    wire        read_more;
    wire        write_more;
    wire        write_last_sample;
    reg         flag_out_of_range;
    reg         flag_overflow;
    reg  [16:0] read_cnt/*synthesis noprune*/;
    reg  [16:0] write_cnt/*synthesis noprune*/;
    reg         wait_last_write_done;

    ////////////////
    // gen start capture signal
    wire start_capture/* synthesis keep */;
    reg  pre_flag_capture/*synthesis noprune */;

    ////////////////
    // state
    `define STATE_STANDYBY  2'd0
    `define STATE_INIT      2'd1
    `define STATE_CAPTURE   2'd2
    `define STATE_DONE      2'd3

    wire       state_capturing;
    reg  [1:0] state /*synthesis noprune*/;

    //////////////////////////
    // write ADC data to fifo
    // ADC --> FIFO
    reg         fifo_aclr;
    wire [13:0] fifo_data;
    wire        fifo_wrreq;
    wire        fifo_rdreq;
    wire        fifo_rdempty;
    wire        fifo_wrfull;
    wire [13:0] fifo_q;

    assign AD_CLK_P = clk;
    assign AD_CLK_N = ~clk;
    assign AD_OE    = 1'b0;// enable

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            flag_capture     <= 1'b0;
            flag_capture_num <= 0;
            flag_dummy_data  <= 1'b0;
        end else if (~slave_chip_select_n & slave_read)
            slave_readdata   <= {29'b0, flag_out_of_range, flag_overflow, flag_done};
        else if (~slave_chip_select_n & slave_write) begin
            flag_capture_num <= slave_writedata[19:0];
            flag_dummy_data  <= slave_writedata[30];
            flag_capture     <= slave_writedata[31];
        end
    end

    assign start_capture = ~pre_flag_capture & flag_capture;

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n)
            pre_flag_capture <= 1'b0;
        else
            pre_flag_capture <= flag_capture;
    end

    assign state_capturing = (state == `STATE_CAPTURE) ? 1'b1 : 1'b0;

    assign read_more         = (read_cnt < flag_capture_num) ? 1'b1 : 1'b0;
    assign write_last_sample = ((write_cnt + 1) == flag_capture_num) ? 1'b1 : 1'b0;
    assign write_more        = (write_cnt < flag_capture_num) ? 1'b1 : 1'b0;

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            state             <= `STATE_STANDYBY;
            flag_out_of_range <= 1'b0;
            flag_overflow     <= 1'b0;
            flag_done         <= 1'b0;
            fifo_aclr         <= 1'b0;
        end else if (start_capture) begin
            state                <= `STATE_INIT;
            read_cnt             <= 0;
            write_cnt            <= 0;
            flag_out_of_range    <= 1'b0;
            flag_overflow        <= 1'b0;
            wait_last_write_done <= 1'b0;
            flag_done            <= 1'b0;
            fifo_aclr            <= 1'b1;
        end else begin
            case(state)
                `STATE_STANDYBY: begin
                    state <= `STATE_STANDYBY;
                end
                
                `STATE_INIT: begin
                    fifo_aclr <= 1'b0;
                    
                    if (~fifo_wrfull & fifo_rdempty) // clear done
                        state <= `STATE_CAPTURE;
                end
                
                `STATE_CAPTURE: begin
                    // reading
                    if (read_more) begin
                        read_cnt <= read_cnt + 1; // continued read
                        
                        if (AD_OR)
                            flag_out_of_range <= 1'b1;
                            
                        if (fifo_wrfull)
                            flag_overflow <= 1'b1;
                    end
                    
                    // writing
                    if (wait_last_write_done) begin
                        if (master_waitrequest_n)
                            state <= `STATE_DONE;
                    end else if (write_more & master_write) begin
                        write_cnt <= write_cnt + 1;
                        
                        if (write_last_sample)
                            wait_last_write_done <= 1'b1;
                    end
                end
            
                `STATE_DONE: begin
                    flag_done <= 1'b1;
                    state     <= `STATE_STANDYBY;
                end
            endcase
        end
    end

    assign fifo_wrreq = state_capturing & read_more;
    assign fifo_data  = flag_dummy_data ? read_cnt[13:0] : AD_D;

    AD9254_FIFO fifo_inst
    (
        .aclr    ( fifo_aclr    ),
        .data    ( fifo_data    ),
        .rdclk   ( clk          ),
        .rdreq   ( fifo_rdreq   ),
        .wrclk   ( AD_DCO       ),
        .wrreq   ( fifo_wrreq   ),
        .q       ( fifo_q       ),
        .rdempty ( fifo_rdempty ),
        .wrfull  ( fifo_wrfull  )
    );

    //////////////////////////
    // write FIFO data to Memory (MM Master Port)
    // FIFO ---> Memory (MM Master Port)
    assign master_chip_select_n = fifo_rdempty & state_capturing;
    assign master_write         = ~fifo_rdempty & state_capturing;
    assign master_writedata     = {fifo_q, 2'b00};
    assign fifo_rdreq           = master_write & master_waitrequest_n;
    assign master_addr          = write_cnt << 1;// one word = 2 bytes

endmodule