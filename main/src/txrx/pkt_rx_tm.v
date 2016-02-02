/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  pkt_rx_tm.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-07  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  pkt_rx_tm.v
    File tree    :  pkt_rx_tm.v                        
\************************************************************************************/

`timescale 1ns/1ps

module pkt_rx_tm(
    clk                         ,
    rst                         ,
    clk_out                     ,
    
    rx_data                     ,
    rx_rem                      ,
    rx_sof_n                    ,
    rx_eof_n                    ,
    rx_src_rdy_n                ,
    
    fifo_rden                   ,
    fifo_dout_out0              ,
    fifo_dout_out1              ,
    fifo_dout_out2              ,
    fifo_dout_out3              ,
    fifo_dout_out4              ,
    fifo_dout_out5              ,
    fifo_dout_out6              ,
    fifo_dout_out7              ,
    pkt_rdy                     ,
    
    ram_raddr_out0              ,    
    ram_raddr_out1              ,    
    ram_raddr_out2              ,    
    ram_raddr_out3              ,    
    ram_raddr_out4              ,   
    ram_raddr_out5              ,
    ram_raddr_out6              ,   
    ram_raddr_out7              ,
    
    ram_dout_out0               ,
    ram_dout_out1               ,
    ram_dout_out2               ,
    ram_dout_out3               ,
    ram_dout_out4               ,
    ram_dout_out5               ,  
    ram_dout_out6               ,
    ram_dout_out7           
    );           
parameter   CHAN_NUMS                   = 8                         ;
parameter   RAM_DEPTH                   = 11                        ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_out                     ;

input   [0:15]                          rx_data                     ;
input                                   rx_rem                      ;
input                                   rx_sof_n                    ;
input                                   rx_eof_n                    ;
input                                   rx_src_rdy_n                ;

input   [CHAN_NUMS-1:0]                 fifo_rden                   ;
output  [23:0]                          fifo_dout_out0              ;
output  [23:0]                          fifo_dout_out1              ;
output  [23:0]                          fifo_dout_out2              ;
output  [23:0]                          fifo_dout_out3              ;
output  [23:0]                          fifo_dout_out4              ;
output  [23:0]                          fifo_dout_out5              ;
output  [23:0]                          fifo_dout_out6              ;
output  [23:0]                          fifo_dout_out7              ;
output  [CHAN_NUMS-1:0]                 pkt_rdy                     ;

input   [RAM_DEPTH - 1 : 0]             ram_raddr_out0              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out1              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out2              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out3              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out4              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out5              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out6              ;
input   [RAM_DEPTH - 1 : 0]             ram_raddr_out7              ;
output  [15:0]                          ram_dout_out0               ;
output  [15:0]                          ram_dout_out1               ;
output  [15:0]                          ram_dout_out2               ;
output  [15:0]                          ram_dout_out3               ;
output  [15:0]                          ram_dout_out4               ;
output  [15:0]                          ram_dout_out5               ;
output  [15:0]                          ram_dout_out6               ;
output  [15:0]                          ram_dout_out7               ;

reg     [2:0]                           dst_slot                    ;//2015.2.3    
reg     [9:0]                           word_cnt                    ;
reg     [RAM_DEPTH - 1 : 0]             start_addr                  ;
reg     [RAM_DEPTH - 1 : 0]             ram_waddr[CHAN_NUMS-1:0]    ;
reg     [CHAN_NUMS-1:0]                 ram_wren                    ;
wire    [23:0]                          fifo_din                    ;
reg     [CHAN_NUMS-1:0]                 fifo_wren                   ;
wire    [23:0]                          fifo_dout[CHAN_NUMS-1:0]    ;
wire    [5:0]                           data_cnt[CHAN_NUMS-1:0]     ;
wire    [CHAN_NUMS-1:0]                 fifo_empty                  ;
(*keep="true"*)
wire    [CHAN_NUMS-1:0]                 fifo_full                   ;
reg     [CHAN_NUMS-1:0]                 pkt_rdy                     ;
reg     [9:0]                           pkt_len                     ;
wire    [RAM_DEPTH - 1 : 0]             ram_raddr[CHAN_NUMS-1:0]    ;
wire    [15:0]                          ram_dout[CHAN_NUMS-1:0]     ;

assign  fifo_dout_out0      =   fifo_dout[0];
assign  fifo_dout_out1      =   fifo_dout[1];
assign  fifo_dout_out2      =   fifo_dout[2];
assign  fifo_dout_out3      =   fifo_dout[3];
assign  fifo_dout_out4      =   fifo_dout[4];
assign  fifo_dout_out5      =   fifo_dout[5];
assign  fifo_dout_out6      =   fifo_dout[6];
assign  fifo_dout_out7      =   fifo_dout[7];

assign  ram_raddr[0]        =   ram_raddr_out0;
assign  ram_raddr[1]        =   ram_raddr_out1;
assign  ram_raddr[2]        =   ram_raddr_out2;
assign  ram_raddr[3]        =   ram_raddr_out3;
assign  ram_raddr[4]        =   ram_raddr_out4;
assign  ram_raddr[5]        =   ram_raddr_out5;
assign  ram_raddr[6]        =   ram_raddr_out6;
assign  ram_raddr[7]        =   ram_raddr_out7;

assign  ram_dout_out0       =   ram_dout[0];
assign  ram_dout_out1       =   ram_dout[1];
assign  ram_dout_out2       =   ram_dout[2];
assign  ram_dout_out3       =   ram_dout[3];
assign  ram_dout_out4       =   ram_dout[4];
assign  ram_dout_out5       =   ram_dout[5];
assign  ram_dout_out6       =   ram_dout[6];
assign  ram_dout_out7       =   ram_dout[7];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  {10{1'b0}};
    end
    else if(rx_src_rdy_n==1'b0)
    begin
        if(rx_sof_n==1'b0)
        begin
            word_cnt    <=  {{9{1'b0}},1'b1};
        end
        else if(rx_eof_n==1'b0)
        begin
            word_cnt    <=  {10{1'b0}};
        end
        else if(|word_cnt==1'b1)
        begin
            word_cnt    <=  word_cnt + 10'd1;
        end
    end
end
    
//always@(posedge clk or posedge rst)
//begin
//    if(rst==1'b1)
//    begin
//        dst_slot    <=  {3{1'b0}};
//    end
//    else if((rx_src_rdy_n==1'b0) && (word_cnt==10'd1))
//    begin
//        dst_slot    <=  rx_data[8:10] + 'd2;////2015.2.3  rx_data[8:11]
//    end
//end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        dst_slot    <=  {3{1'b0}};
    end
    else if((rx_src_rdy_n==1'b0) && (word_cnt==10'd1))
    begin
        if(rx_data[8:10]==3'b000)
        begin
            dst_slot    <=  3'b000;
        end
        else if(rx_data[8:10]==3'b001)
        begin
            dst_slot    <=  3'b010;
        end
        else
        begin
            dst_slot    <=  rx_data[8:10] + 'd2;////2015.2.3  rx_data[8:11]
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_len     <=  {10{1'b0}};
    end
    else if((rx_src_rdy_n==1'b0) && (rx_eof_n==1'b0))
    begin
        pkt_len     <=  word_cnt + 'h1;
    end
end

////////////////////////////////////////////////////////////////////
//fifo+ram
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        start_addr  <=  {RAM_DEPTH{1'b0}};
    end
    else if((rx_src_rdy_n==1'b0) && (word_cnt==10'd2))
    begin
        case(dst_slot)            //2015.2.3                   
        3'b000:    start_addr  <=  ram_waddr[0] - 2;
        3'b001:    start_addr  <=  ram_waddr[1] - 2;
        3'b010:    start_addr  <=  ram_waddr[2] - 2;
        3'b011:    start_addr  <=  ram_waddr[3] - 2;
        3'b100:    start_addr  <=  ram_waddr[4] - 2;
        3'b101:    start_addr  <=  ram_waddr[5] - 2;
		3'b110:    start_addr  <=  ram_waddr[6] - 2;
		3'b111:    start_addr  <=  ram_waddr[7] - 2;
        default:;
        endcase
    end
end

assign  fifo_din    =   {3'b000,pkt_len[9:0],start_addr[RAM_DEPTH - 1 : 0]};

////////////////////////////////////////////////////////////////////
//block ram:w24d16,read latency=2,wordcnt(10bit)+start_addr(12bit)
////////////////////////////////////////////////////////////////////
generate
    genvar i;
    for(i=0;i<CHAN_NUMS;i=i+1)
    begin:INST_RX_PKT_TM
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                fifo_wren[i]    <=  1'b0;
            end
            else if((rx_src_rdy_n==1'b0) && (rx_eof_n==1'b0) && (dst_slot==i))
            begin
                fifo_wren[i]    <=  1'b1;
            end
            else
            begin
                fifo_wren[i]    <=  1'b0;
            end
        end
        
        always@(posedge clk_out or posedge rst)
        begin
            if(rst==1'b1)
            begin
                pkt_rdy[i]  <=  1'b0;
            end
            else if(fifo_empty[i]==1'b0)
            begin
                pkt_rdy[i]  <=  1'b1;
            end
            else
            begin
                pkt_rdy[i]  <=  1'b0;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ram_waddr[i]    <=  {RAM_DEPTH{1'b0}};
            end
            else if(rx_src_rdy_n==1'b0)
            begin
                if((rx_sof_n==1'b0) || (word_cnt==1) ||
                    (((word_cnt>1) && (dst_slot==i))))
                begin
                    ram_waddr[i]    <=  ram_waddr[i] + 'h1;
                end
            end
        end
        
        always@*
        begin
            if(rx_src_rdy_n==1'b0)
            begin
                if((rx_sof_n==1'b0) || (word_cnt==1) ||
                    (((word_cnt>1) && (dst_slot==i))))
                begin
                    ram_wren[i] =   1'b1;
                end
                else
                begin
                    ram_wren[i] =   1'b0;
                end
            end
            else
            begin
                ram_wren[i] =   1'b0;
            end
        end
        

        ////read_latency=1
        //synram_w16d4096 u0_synram_w16d4096(
        //    .clka                       ( clk                       ),
        //    .wea                        ( ram_wren[i]               ),
        //    .addra                      ( ram_waddr[i]              ),
        //    .dina                       ( rx_data[0:15]             ),
        //    .clkb                       ( clk                       ),
        //    .addrb                      ( ram_raddr[i]              ),
        //    .doutb                      ( ram_dout[i]               )
        //    );
        //
        ////read latency=2   
        //rxpkt_fifo u0_rxpkt_fifo(
        //    .clk                        ( clk                       ),
        //    .rst                        ( rst                       ),
        //    .din                        ( fifo_din                  ),
        //    .wr_en                      ( fifo_wren[i]              ),
        //    .rd_en                      ( fifo_rden[i]              ),
        //    .dout                       ( fifo_dout[i]              ),
        //    .full                       ( /*not used*/              ),
        //    .empty                      ( /*not used*/              ),
        //    .data_count                 ( data_cnt[i]               )
        //    );
            
        //read_latency=2
        asynram_w16d2048 u0_asynram_w16d2048(
            .clka                       ( clk                       ),
            .wea                        ( ram_wren[i]               ),
            .addra                      ( ram_waddr[i]              ),
            .dina                       ( rx_data[0:15]             ),
            .clkb                       ( clk_out                   ),
            .addrb                      ( ram_raddr[i]              ),
            .doutb                      ( ram_dout[i]               )
            );
    
        //read latency=2   
        asynfifo_w24d64 u0_asynfifo_w24d64(
            .wr_clk                     ( clk                       ),
            .rd_clk                     ( clk_out                   ),
            .rst                        ( rst                       ),
            .din                        ( fifo_din                  ),
            .wr_en                      ( fifo_wren[i]              ),
            .rd_en                      ( fifo_rden[i]              ),
            .dout                       ( fifo_dout[i]              ),
            .full                       ( fifo_full[i]              ),
            .empty                      ( fifo_empty[i]             ),
            .rd_data_count              ( data_cnt[i]               )
            );
    end
endgenerate
    
endmodule
