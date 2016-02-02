/*************************************************************************************\
    Copyright(c) 2014, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   ecm_emm_inject.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-04-03  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ecm_emm_inject.v
    File tree    :   ecm_emm_inject.v
\************************************************************************************/

`timescale 1ns/100ps

module ecm_emm_inject(
    ddr_user_clk                ,
    ddr_user_rst                ,
    clk                         ,
    rst                         ,  
    sc_data_pkt_d               ,
    sc_data_pkt_dval            ,
    sc_data_pkt_sop             ,
    sc_data_pkt_eop             ,
    payload_out_valid           ,
    payload_out_start           ,
    payload_out_end             ,
    payload_out_data            ,
    payload_req_out             ,
    chan_out_req                ,
    chan_out_ack                ,
    buffer_overflow
    );

parameter   RAM_DEPTH_BIT               = 10                        ;

input                                   ddr_user_clk                ;
input                                   ddr_user_rst                ;
input                                   clk                         ;
input                                   rst                         ;
input   [31:0]                          sc_data_pkt_d               ;
input                                   sc_data_pkt_dval            ;
input                                   sc_data_pkt_sop             ;
input                                   sc_data_pkt_eop             ;
output                                  payload_out_valid           ;                                   
output                                  payload_out_start           ;                                   
output                                  payload_out_end             ;                           
output  [31:0]                          payload_out_data            ;
output                                  payload_req_out             ;
input                                   chan_out_req                ;
output                                  chan_out_ack                ;
output                                  buffer_overflow             ;

reg                                     payload_req_out             ;
reg                                     payload_out_valid           ;
reg                                     payload_out_start           ;
reg                                     payload_out_end             ;
reg                                     chan_out_ack                ;

reg     [RAM_DEPTH_BIT - 1 : 0]         ram_waddr                   ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_raddr                   ;
wire    [31:0]                          ram_rdata                   ;

reg     [5:0]                           word_cnt                    ;
reg                                     buffer_overflow             ;
(* KEEP = "TRUE" *)
wire                                    rst_info_fifo               ;
reg     [RAM_DEPTH_BIT - 1 : 0]         start_addr                  ;
reg     [5:0]                           pkt_len                     ;
reg                                     info_fifo_wren              ;
reg     [15:0]                          info_fifo_wdat              ;
wire    [5:0]                           info_fifo_datcnt            ;
reg                                     info_fifo_rden              ;
wire    [15:0]                          info_fifo_rdat              ;
reg                                     info_fifo_rden_1dly         ; 
reg                                     info_fifo_rden_2dly         ;
wire    [RAM_DEPTH_BIT - 1 : 0]         pkt_start_addr              ;
wire    [5:0]                           pkt_len_buf                 ;
reg                                     chan_out_req_1dly           ;

assign  rst_info_fifo   =   ddr_user_rst | rst;

always@(posedge ddr_user_clk or posedge ddr_user_rst)
begin
    if(ddr_user_rst==1'b1)
    begin
        ram_waddr   <=  {RAM_DEPTH_BIT{1'b0}};
    end
    else if(sc_data_pkt_dval==1'b1)
    begin
        ram_waddr   <=  ram_waddr + 'h1;
    end
end

always@(posedge ddr_user_clk or posedge ddr_user_rst)
begin
    if(ddr_user_rst==1'b1)
    begin
        start_addr  <=  {RAM_DEPTH_BIT{1'b0}};
    end
    else if(sc_data_pkt_sop==1'b1)
    begin
        start_addr  <=  ram_waddr;
    end
end

always@(posedge ddr_user_clk or posedge ddr_user_rst)
begin
    if(ddr_user_rst==1'b1)
    begin
        pkt_len <=  {6{1'b0}};
    end
    else if(sc_data_pkt_sop==1'b1)
    begin
        pkt_len <=  6'b00_0010;
    end
    else if(sc_data_pkt_eop==1'b1)
    begin
        pkt_len <=  {6{1'b0}};
    end
    else if((pkt_len>0) && (sc_data_pkt_dval==1'b1))
    begin
        pkt_len <=  pkt_len + 'h1;
    end
end

always@(posedge ddr_user_clk or posedge ddr_user_rst)
begin
    if(ddr_user_rst==1'b1)
    begin
        info_fifo_wren  <=  1'b0;
    end
    else if(sc_data_pkt_eop==1'b1)
    begin
        info_fifo_wren  <=  1'b1;
    end
    else
    begin
        info_fifo_wren  <=  1'b0;
    end
end

always@(posedge ddr_user_clk or posedge ddr_user_rst)
begin
    if(ddr_user_rst==1'b1)
    begin
        info_fifo_wdat  <=  {16{1'b0}};
    end
    else if(sc_data_pkt_eop==1'b1)
    begin
        info_fifo_wdat  <=  {pkt_len[5:0],start_addr[RAM_DEPTH_BIT - 1 : 0]};
    end
    else
    begin
        info_fifo_wdat  <=  {16{1'b0}};
    end
end

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        payload_req_out <=  1'b0;
    end
    else if(info_fifo_datcnt>0)
    begin
        payload_req_out <=  1'b1;
    end
    else
    begin
        payload_req_out <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        chan_out_req_1dly   <=  1'b0;
    end
    else
    begin
        chan_out_req_1dly   <=  chan_out_req;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_rden  <=  1'b0;
    end
    else
    begin
        info_fifo_rden  <=  (~chan_out_req_1dly) & chan_out_req;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_rden_1dly <=  1'b0;
        info_fifo_rden_2dly <=  1'b0;
    end
    else
    begin
        info_fifo_rden_1dly <=  info_fifo_rden;
        info_fifo_rden_2dly <=  info_fifo_rden_1dly;
    end
end

assign  pkt_start_addr  =   info_fifo_rdat[RAM_DEPTH_BIT - 1 : 0];
assign  pkt_len_buf     =   info_fifo_rdat[15:RAM_DEPTH_BIT];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_raddr   <=  {RAM_DEPTH_BIT{1'b0}};
    end
    else if(info_fifo_rden_2dly==1'b1)
    begin
        ram_raddr   <=  pkt_start_addr;
    end
    else if(word_cnt>0)
    begin
        ram_raddr   <=  ram_raddr + 'h1;
    end
    else
    begin
        ram_raddr   <=  {RAM_DEPTH_BIT{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  {6{1'b0}};
    end
    else if(info_fifo_rden_2dly==1'b1)
    begin
        word_cnt    <=  6'b00_0001;
    end
    else if(word_cnt>49)
    begin
        word_cnt    <=  {6{1'b0}};
    end
    else if(word_cnt>0)
    begin
        word_cnt    <=  word_cnt + 'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        payload_out_valid   <=  1'b0;
    end
    else if((word_cnt>1) && (word_cnt<50))
    begin
        payload_out_valid   <=  1'b1;
    end
    else
    begin
        payload_out_valid   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        chan_out_ack    <=  1'b0;
    end
    else if(word_cnt==49)
    begin
        chan_out_ack    <=  1'b1;
    end
    else
    begin
        chan_out_ack    <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        payload_out_start   <=  1'b0;
    end
    else if(word_cnt==2)
    begin
        payload_out_start   <=  1'b1;
    end
    else
    begin
        payload_out_start   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        payload_out_end <=  1'b0;
    end
    else if(word_cnt==49)
    begin
        payload_out_end <=  1'b1;
    end
    else
    begin
        payload_out_end <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        buffer_overflow <=  1'b0;
    end
    else if(info_fifo_datcnt>60)
    begin
        buffer_overflow <=  1'b1;
    end
    else
    begin
        buffer_overflow <=  1'b0;
    end
end

assign  payload_out_data    =   ram_rdata;
       
//read_latency=2,w32d1024
asyncram_w32d1024 u0_asyncram_w32d1024(
    .clka                               ( ddr_user_clk              ),
    .wea                                ( sc_data_pkt_dval          ),
    .addra                              ( ram_waddr                 ),
    .dina                               ( sc_data_pkt_d             ),
    .clkb                               ( clk                       ),
    .addrb                              ( ram_raddr                 ),
    .doutb                              ( ram_rdata                 )
    );

//read_latency=2,w16d64
async_fifo_w16d64 u0_async_fifo_w16d64(
    .rst                                ( rst_info_fifo             ),
    .wr_clk                             ( ddr_user_clk              ),  //78.125m
    .rd_clk                             ( clk                       ),  //125m
    .din                                ( info_fifo_wdat            ),
    .wr_en                              ( info_fifo_wren            ),
    .rd_en                              ( info_fifo_rden            ),
    .dout                               ( info_fifo_rdat            ),
    .full                               ( /*not used*/              ),
    .empty                              ( /*not used*/              ),
    .rd_data_count                      ( info_fifo_datcnt          )
    );
  
endmodule
