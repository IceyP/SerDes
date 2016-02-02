/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   gtx_rx_pkt_analyze.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
                    1.CW控制字包,pkt_type=16'h8000
                    |--------------|--------------------------------------|---------------|---------------|----------------|-----------|--------------|
                    |    包类型    |      源slot+目标slot号+通道号        |    包长       |    地址       |  加扰PID       | 控制字CW  |   预留       |
                    |--------------|--------------------------------------|---------------|---------------|----------------|-----------|--------------|
                    |pkt_type[15:0]|src_slot[11:8]+dst_slot[7:4]+chan[3:0]| pkt_len[15:0] | address[15:0] |scram_pid[15:0] | CW[63:0]  |reserved[15:0]|
                    |--------------|--------------------------------------|---------------|---------------|----------------|-----------|--------------|
                    
                    2.ECM数据包,pkt_type=16'h8001;EMM数据包,pkt_type=16'h8002
                    |--------------|--------------------------------------|---------------|----------------|--------------|
                    |    包类型    |      源slot+目标slot号+通道号        |    包长       | ECM,EMM数据包  |    预留      |
                    |--------------|--------------------------------------|---------------|----------------|--------------|
                    |pkt_type[15:0]|src_slot[11:8]+dst_slot[7:4]+chan[3:0]| pkt_len[15:0] | data(188字节)  |reserved[15:0]|
                    |--------------|--------------------------------------|---------------|----------------|--------------|    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-28  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gtx_rx_pkt_analyze.v
    File tree    :   gtx_rx_pkt_analyze.v                        
\************************************************************************************/

`timescale 1ns/100ps

module gtx_rx_pkt_analyze(
    clk                         ,
    rst                         ,
    clk_125m                    ,
    rst_125m                    ,
    gtx_rx_data                 ,
    gtx_rx_sof_n                ,
    gtx_rx_eof_n                ,
    gtx_rx_dvalid_n             ,
    sc_ctrl_pkt_d               ,   //(addr+scram_pid+cw)
    sc_ctrl_pkt_dval_ch         ,
    sc_ctrl_pkt_eof_ch          ,
    sc_data_pkt_d               ,   //ecm/emm ts packet(188 or 188*2 bytes)
    sc_data_pkt_dval            ,
    sc_data_pkt_sop             ,
    sc_data_pkt_eop
    );

parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   TOTAL_CHN_NUM               = 16                        ;
parameter   DATA_WIDTH                  = 16                        ;
parameter   DATA_DEPTH_BIT              = 11                        ;
parameter   INFO_FIFO_WIDTH             = 28                        ;
parameter   INFO_FIFO_DEPTH_BIT         = 6                         ;

parameter   ST_INFO_WIDTH               = 7                         ,
            ST_INFO_IDLE                = 7'b000_0001               ,
            ST_INFO_RDEN                = 7'b000_0010               ,
            ST_INFO_RD_HEADER           = 7'b000_0100               ,
            ST_RD_CTRL_PACKET           = 7'b000_1000               ,
            ST_RD_DATA_PACKET           = 7'b001_0000               ,
            ST_RD_CTRLPKT_END           = 7'b010_0000               ,
            ST_RD_DATAPKT_END           = 7'b100_0000               ;
            
input                                   clk                         ;
input                                   rst                         ;
input                                   clk_125m                    ;
input                                   rst_125m                    ;
input   [15:0]                          gtx_rx_data                 ;
input                                   gtx_rx_sof_n                ;
input                                   gtx_rx_eof_n                ;
input                                   gtx_rx_dvalid_n             ;

output  [15:0]                          sc_ctrl_pkt_d               ;
output  [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_dval_ch         ;
output  [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_eof_ch          ;
output  [31:0]                          sc_data_pkt_d               ;
output                                  sc_data_pkt_dval            ;
output                                  sc_data_pkt_sop             ;
output                                  sc_data_pkt_eop             ;

//datram
reg     [DATA_DEPTH_BIT - 1 : 0]        datram_waddr                ;
wire                                    datram_wren                 ;
wire    [DATA_WIDTH - 1 : 0]            datram_wdat                 ;
reg     [DATA_DEPTH_BIT - 1 : 0]        datram_raddr                ;
wire    [DATA_WIDTH - 1 : 0]            datram_rdat                 ;
//info_fifo
reg     [INFO_FIFO_WIDTH - 1 : 0]       info_fifo_wdat              ;
wire    [INFO_FIFO_WIDTH - 1 : 0]       info_fifo_rdat              ;
reg                                     info_fifo_wren              ;
reg                                     info_fifo_rden              ;
reg                                     info_fifo_rden_1dly         ;
reg                                     info_fifo_rden_2dly         ;
wire                                    info_fifo_full              ;
wire                                    info_fifo_afull             ;
wire                                    info_fifo_empty             ;
wire                                    info_fifo_aempty            ;
wire    [INFO_FIFO_DEPTH_BIT - 1 : 0]   info_fifo_datcnt            ;

reg     [DATA_DEPTH_BIT - 1 : 0]        pkt_start_addr              ;
reg     [1:0]                           pkt_type                    ;
reg     [7:0]                           frame_len                   ;
reg     [3:0]                           channel_num                 ;
reg     [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_dval_ch         ;
reg     [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_eof_ch          ;
reg                                     sc_data_pkt_dval            ;
reg                                     sc_data_pkt_sop             ;
reg                                     sc_data_pkt_eop             ;
reg     [TOTAL_CHN_NUM - 1 : 0]         ctrl_pkt_val                ;
reg                                     data_pkt_val                ;
reg     [ST_INFO_WIDTH - 1 : 0]         st_info_curr                ;
reg     [ST_INFO_WIDTH - 1 : 0]         st_info_next                ;
reg     [8:0]                           word_cnt                    ;
wire    [1:0]                           frm_type                    ;
wire    [8:0]                           frm_len                     ;
wire    [CHNNUM_BIT_WIDTH - 1 : 0]      frm_chan_num                ;
wire    [8:0]                           frm_len_temp                ;
wire                                    rst_info_fifo               ;
reg     [8:0]                           pkt_len                     ;
wire    [DATA_DEPTH_BIT - 1 : 0]        frm_start_addr              ;
reg     [15:0]                          sc_data_pkt_d_high          ;

assign  rst_info_fifo   =   rst | rst_125m;

////////////////////////////////////////////////////////////////////
//data ram write
////////////////////////////////////////////////////////////////////
assign  datram_wren     =   (~gtx_rx_dvalid_n) & (frame_len>2);
assign  datram_wdat     =   gtx_rx_data;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_waddr    <=  {DATA_DEPTH_BIT{1'b0}};
    end
    else if((gtx_rx_dvalid_n==1'b0) && (frame_len>2))
    begin
        datram_waddr    <=  datram_waddr + 'h1;
    end
end

////////////////////////////////////////////////////////////////////
//info_fifo write
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_start_addr  <=  {DATA_DEPTH_BIT{1'b0}};
    end
    else if(gtx_rx_sof_n==1'b0)
    begin
        pkt_start_addr  <=  datram_waddr;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        frame_len   <=  8'h00;
    end
    else if(gtx_rx_sof_n==1'b0)
    begin
        frame_len   <=  8'h01;
    end
    else if(gtx_rx_eof_n==1'b0)
    begin
        frame_len   <=  8'h00;
    end
    else if((gtx_rx_dvalid_n==1'b0) && (frame_len>0))
    begin
        frame_len   <=  frame_len + 8'h01;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        channel_num <=  4'h0;
    end
    else if((gtx_rx_dvalid_n==1'b0) && (frame_len==8'h01))
    begin
        channel_num <=  gtx_rx_data[3:0];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_type    <=  2'b00;
    end
    else if((gtx_rx_sof_n==1'b0) && (gtx_rx_dvalid_n==1'b0))
    begin
        if(gtx_rx_data==16'h8000)
        begin
            pkt_type    <=  2'b01;      //control packet
        end
        else if((gtx_rx_data==16'h8001) || (gtx_rx_data==16'h8002))
        begin
            pkt_type    <=  2'b10;      //data packet
        end
        else
        begin
            pkt_type    <=  2'b00;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_len <=  {9{1'b0}};
    end
    else if((gtx_rx_dvalid_n==1'b0) && (frame_len==8'h02))
    begin
        pkt_len <=  gtx_rx_data[8:0];
    end
end
    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_wdat  <=  {INFO_FIFO_WIDTH{1'b0}};
    end
    else if(gtx_rx_eof_n==1'b0)
    begin
        info_fifo_wdat  <=  {2'b00,channel_num[3:0],pkt_type[1:0],
                            pkt_len[8:0],pkt_start_addr[DATA_DEPTH_BIT - 1 : 0]};
    end
    else
    begin
        info_fifo_wdat  <=  {INFO_FIFO_WIDTH{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_wren  <=  1'b0;
    end
    else if(gtx_rx_eof_n==1'b0)
    begin
        info_fifo_wren  <=  1'b1;
    end
    else
    begin
        info_fifo_wren  <=  1'b0;
    end
end
 
////////////////////////////////////////////////////////////////////
//info fifo read
////////////////////////////////////////////////////////////////////
assign  frm_chan_num    =   info_fifo_rdat[DATA_DEPTH_BIT + CHNNUM_BIT_WIDTH + 10 : DATA_DEPTH_BIT + 11];
assign  frm_type        =   info_fifo_rdat[DATA_DEPTH_BIT + 10 : DATA_DEPTH_BIT + 9];
assign  frm_len         =   info_fifo_rdat[DATA_DEPTH_BIT + 8 : DATA_DEPTH_BIT];
assign  frm_start_addr  =   info_fifo_rdat[DATA_DEPTH_BIT - 1 : 0];

assign  frm_len_temp    =   {1'b0,frm_len[8:1]};

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        word_cnt    <=  {9{1'b0}};
    end
    else if((st_info_curr==ST_RD_CTRL_PACKET) || (st_info_curr==ST_RD_DATA_PACKET))
    begin
        word_cnt    <=  word_cnt + 'h1;
    end
    else
    begin
        word_cnt    <=  {9{1'b0}};
    end
end
    
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        info_fifo_rden  <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_RDEN)
    begin
        info_fifo_rden  <=  1'b1;
    end
    else
    begin
        info_fifo_rden  <=  1'b0;
    end
end

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
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

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        st_info_curr    <=  ST_INFO_IDLE;
    end
    else
    begin
        st_info_curr    <=  st_info_next;
    end
end

always@*
begin
    case(st_info_curr)
    ST_INFO_IDLE:
    begin
        if(|info_fifo_datcnt==1'b0)
        begin
            st_info_next    =   ST_INFO_IDLE;
        end
        else
        begin
            st_info_next    =   ST_INFO_RDEN;
        end
    end
    ST_INFO_RDEN:
    begin
        st_info_next    =   ST_INFO_RD_HEADER;
    end
    ST_INFO_RD_HEADER:
    begin
        if(info_fifo_rden_2dly==1'b1)
        begin
            if(frm_type==2'b01)       //control packet
            begin
                st_info_next    =   ST_RD_CTRL_PACKET;
            end
            else if(frm_type==2'b10)
            begin
                st_info_next    =   ST_RD_DATA_PACKET;
            end
            else
            begin
                st_info_next    =   ST_INFO_IDLE;
            end
        end
        else
        begin
            st_info_next    =   ST_INFO_RD_HEADER;
        end
    end
    ST_RD_CTRL_PACKET:
    begin
        if(frm_len_temp==word_cnt+1)
        begin
            st_info_next    =   ST_RD_CTRLPKT_END;
        end
        else
        begin
            st_info_next    =   ST_RD_CTRL_PACKET;
        end
    end
    ST_RD_DATA_PACKET:
    begin
        if(frm_len_temp==word_cnt+1)
        begin
            st_info_next    =   ST_RD_DATAPKT_END;
        end
        else
        begin
            st_info_next    =   ST_RD_DATA_PACKET;
        end
    end
    ST_RD_CTRLPKT_END:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    ST_RD_DATAPKT_END:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    default:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    endcase
end

////////////////////////////////////////////////////////////////////
//data ram read
////////////////////////////////////////////////////////////////////
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        datram_raddr    <=  {DATA_DEPTH_BIT{1'b0}};
    end
    else if(info_fifo_rden_2dly==1'b1)
    begin
        datram_raddr    <=  frm_start_addr;
    end
    else if((st_info_curr==ST_RD_CTRL_PACKET) || (st_info_curr==ST_RD_DATA_PACKET))
    begin
        datram_raddr    <=  datram_raddr + 'h1;
    end
end 

////////////////////////////////////////////////////////////////////
//control packet output
////////////////////////////////////////////////////////////////////
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        ctrl_pkt_val                <=  {TOTAL_CHN_NUM{1'b0}};
    end
    else if(st_info_curr==ST_RD_CTRL_PACKET)
    begin
        ctrl_pkt_val[frm_chan_num]  <=  1'b1;
    end
    else 
    begin
        ctrl_pkt_val                <=  {TOTAL_CHN_NUM{1'b0}};
    end
end

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_ctrl_pkt_dval_ch <=  {TOTAL_CHN_NUM{1'b0}};
    end
    else
    begin
        sc_ctrl_pkt_dval_ch <=  ctrl_pkt_val;
    end
end

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_ctrl_pkt_eof_ch  <=  {TOTAL_CHN_NUM{1'b0}};
    end
    else if(st_info_curr==ST_RD_CTRLPKT_END)
    begin
        sc_ctrl_pkt_eof_ch[frm_chan_num]    <=  1'b1;
    end
    else
    begin
        sc_ctrl_pkt_eof_ch  <=  {TOTAL_CHN_NUM{1'b0}};
    end
end

assign  sc_ctrl_pkt_d   =   datram_rdat;

////////////////////////////////////////////////////////////////////
//data packet output
////////////////////////////////////////////////////////////////////   
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        data_pkt_val                <=  1'b0;
    end
    else if(((st_info_curr==ST_RD_DATA_PACKET) && ((word_cnt[0]==1'b1) || (word_cnt==94))) || 
            ((info_fifo_rden_2dly==1'b1) && (frm_type==2'b10)))
    begin
        data_pkt_val                <=  1'b1;
    end
    else 
    begin
        data_pkt_val                <=  1'b0;
    end
end
 
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_data_pkt_dval    <=  1'b0;
    end
    else
    begin
        sc_data_pkt_dval    <=  data_pkt_val;
    end
end

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_data_pkt_eop <=  1'b0;
    end
    else if((st_info_curr==ST_RD_DATAPKT_END) || ((st_info_curr==ST_RD_DATA_PACKET) && (word_cnt==94)))
    begin
        sc_data_pkt_eop <=  1'b1;
    end
    else
    begin
        sc_data_pkt_eop <=  1'b0;
    end
end

always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_data_pkt_sop <=  1'b0;
    end
    else if((st_info_curr==ST_RD_DATA_PACKET) && ((word_cnt==0) || (word_cnt==95)))
    begin
        sc_data_pkt_sop <=  1'b1;
    end
    else
    begin
        sc_data_pkt_sop <=  1'b0;
    end
end
     
always@(posedge clk_125m or posedge rst_125m)
begin
    if(rst_125m==1'b1)
    begin
        sc_data_pkt_d_high  <=  {16{1'b0}};
    end
    else if((word_cnt>1) && (word_cnt[0]==1'b0))
    begin
        sc_data_pkt_d_high  <=  datram_rdat;
    end
end
       
assign  sc_data_pkt_d   =   ((word_cnt==1) || (word_cnt==96))   ?   {{29{1'b0}},frm_chan_num[CHNNUM_BIT_WIDTH - 1 : 0]}  :    
                                                                    {sc_data_pkt_d_high[15:0],datram_rdat[15:0]};

//1Kx16bit,read latency = 2;
asyncram_w16d2048 u0_asyncram_w16d2048(
    .clka                               ( clk                       ),  //125m
    .wea                                ( datram_wren               ),
    .addra                              ( datram_waddr              ),
    .dina                               ( datram_wdat               ),
    .clkb                               ( clk_125m                  ),  //78.125m 
    .addrb                              ( datram_raddr              ),
    .doutb                              ( datram_rdat               )
    );

//width:28,depth:64,read latency = 2;
//reserved   channel_num   pkt_type    pkt_length     start_addr
//[27:25]     [24:21]       [20:19]      [18:10]         [9:0]
//pkt_type=2'b01,control packet;pkt_type=2'b10,data packet;
async_fifo_w28d64 u0_async_fifo_w28d64(
    .rst                                ( rst_info_fifo             ),
    .wr_clk                             ( clk                       ),  //125m
    .rd_clk                             ( clk_125m                  ),  //78.125m
    .din                                ( info_fifo_wdat            ),
    .wr_en                              ( info_fifo_wren            ),
    .rd_en                              ( info_fifo_rden            ),
    .dout                               ( info_fifo_rdat            ),
    .full                               ( info_fifo_full            ),
    .almost_full                        ( info_fifo_afull           ),
    .empty                              ( info_fifo_empty           ),
    .almost_empty                       ( info_fifo_aempty          ),
    .rd_data_count                      ( info_fifo_datcnt          )
    );
       
endmodule
