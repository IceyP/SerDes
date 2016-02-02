/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_rx_frmbuf.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-14  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_rx_frmbuf.v
    File tree    :   gbe_rx_frmbuf.v
\************************************************************************************/

`timescale 1ns/100ps

module gbe_rx_frmbuf(
    rst                         ,
    clk                         ,
    //input
    mac_rx_sop                  ,
    mac_rx_eop                  ,
    mac_rx_valid                ,
    mac_rx_mod                  ,
    mac_rx_data                 ,
    mac_rx_frmlen               ,
    pkt_type                    ,
    udp_filter_index            ,
    //udp match datram
    datram_udpmatch_wren        ,
    datram_udpmatch_wdat        ,
    datram_udpmatch_waddr       ,
    //udp match infor fifo,dst_port(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
    info_fifo_udpmatch_wren     ,
    info_fifo_udpmatch_wdat     ,
    //ip match datram
    datram_ipmatch_wren         ,
    datram_ipmatch_wdat         ,
    datram_ipmatch_waddr        ,
    //ip match infor fifo,frm_len(12bit)+start_addr(11bit)
    info_fifo_ipmatch_wren      ,
    info_fifo_ipmatch_wdat      ,
    info_fifo_ipmatch_afull         
    );

parameter   U_DLY                       = 1                         ;
parameter   INFO_FIFO_WIDTH             = 44                        ;
parameter   INFO_FIFO_DEPTH_BIT         = 8                         ;
parameter   DATA_WIDTH                  = 32                        ;
parameter   RAM_IPMATCH_DATA_WIDTH      = 16                        ;
parameter   RAM_UDPMATCH_DEPTH_BIT      = 10                        ;
parameter   RAM_IPMATCH_DEPTH_BIT       = 11                        ;
parameter   FIFO_UDPMATCH_WIDTH         = 38                        ;
parameter   FIFO_UDPMATCH_DEPTH_BIT     = 6                         ;
parameter   FIFO_IPMATCH_WIDTH          = 23                        ;
parameter   FIFO_IPMATCH_DEPTH_BIT      = 6                         ;
                                        
parameter   ST_INFO_WIDTH               = 8                         ;
parameter   ST_INFO_IDLE                = 8'b00000001               ;
parameter   ST_INFO_RDEN                = 8'b00000010               ;
parameter   ST_INFO_WAIT                = 8'b00000100               ;
parameter   ST_INFO_RD_DAT              = 8'b00001000               ;
parameter   ST_INFO_IPADDR_MATCH        = 8'b00010000               ;
parameter   ST_INFO_UDP_MATCH           = 8'b00100000               ;
parameter   ST_INFO_UDPMATCH_RD_END     = 8'b01000000               ;
parameter   ST_INFO_IPMATCH_RD_END      = 8'b10000000               ;

input                                   rst                         ;
input                                   clk                         ;

input                                   mac_rx_sop                  ;
input                                   mac_rx_eop                  ;
input                                   mac_rx_valid                ;
//2'b00:4bytes valid;2'b01:1byte valid;2'b10:2bytes valid;2'b11:3bytes valid
input   [1:0]                           mac_rx_mod                  ;   
input   [DATA_WIDTH - 1 : 0]            mac_rx_data                 ;
input   [11:0]                          mac_rx_frmlen               ;

//2'b01:ip_port_match;2'b10:ip_addr_filter_match;2'b11:checksum_err;2'b00:other;
input   [1:0]                           pkt_type                    ;
input   [15:0]                          udp_filter_index            ;

output                                  datram_udpmatch_wren        ;
output  [DATA_WIDTH - 1 : 0]            datram_udpmatch_wdat        ;
output  [RAM_UDPMATCH_DEPTH_BIT - 1:0]  datram_udpmatch_waddr       ;
output                                  info_fifo_udpmatch_wren     ;
output  [FIFO_UDPMATCH_WIDTH - 1 : 0]   info_fifo_udpmatch_wdat     ;

output                                  datram_ipmatch_wren         ;
output  [RAM_IPMATCH_DATA_WIDTH-1:0]    datram_ipmatch_wdat         ;
output  [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_waddr        ;
output                                  info_fifo_ipmatch_wren      ;
output  [FIFO_IPMATCH_WIDTH - 1 : 0]    info_fifo_ipmatch_wdat      ;
input                                   info_fifo_ipmatch_afull     ;

reg     [10:0]                          datram_start_addr           ;

//datram
reg     [10:0]                          datram_waddr                ;
wire                                    datram_wren                 ;
wire    [DATA_WIDTH - 1 : 0]            datram_wdat                 ;
reg     [10:0]                          datram_raddr                ;
wire    [DATA_WIDTH - 1 : 0]            datram_rdat                 ;

//info_fifo
reg     [INFO_FIFO_WIDTH - 1 : 0]       info_fifo_wdat              ;
wire    [INFO_FIFO_WIDTH - 1 : 0]       info_fifo_rdat              ;
reg                                     info_fifo_wren              ;
reg                                     info_fifo_rden              ;
wire                                    info_fifo_full              ;
wire                                    info_fifo_afull             ;
wire                                    info_fifo_empty             ;
wire                                    info_fifo_aempty            ;
wire    [INFO_FIFO_DEPTH_BIT - 1 : 0]   info_fifo_datcnt            ;

reg     [ST_INFO_WIDTH - 1 : 0]         st_info_curr    /* synthesis syn_encoding = "safe,onehot" */;
reg     [ST_INFO_WIDTH - 1 : 0]         st_info_next                ;

reg     [8:0]                           cycle_num                   ;
reg     [8:0]                           count_a                     ;
reg     [9:0]                           count_b                     ;
reg     [9:0]                           cycle_num_b                 ;

wire    [10:0]                          frm_start_addr              ;
wire    [11:0]                          frm_len                     ;
wire    [1:0]                           frm_mod                     ;
wire    [1:0]                           frm_type                    ;
wire    [15:0]                          frm_filter_index            ;

wire    [11:0]                          udp_pkt_len                 ;
reg                                     udp_match_valid             ;
reg                                     ip_match_valid              ;

reg                                     datram_udpmatch_wren        ;
wire    [DATA_WIDTH - 1 : 0]            datram_udpmatch_wdat        ;
reg     [RAM_UDPMATCH_DEPTH_BIT - 1:0]  datram_udpmatch_waddr       ;
reg                                     info_fifo_udpmatch_wren     ;
reg     [FIFO_UDPMATCH_WIDTH - 1 : 0]   info_fifo_udpmatch_wdat     ;

reg                                     datram_ipmatch_wren         ;
reg     [RAM_IPMATCH_DATA_WIDTH-1:0]    datram_ipmatch_wdat         ;
reg     [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_waddr        ;
reg                                     info_fifo_ipmatch_wren      ;
reg     [FIFO_IPMATCH_WIDTH - 1 : 0]    info_fifo_ipmatch_wdat      ;

reg     [RAM_UDPMATCH_DEPTH_BIT - 1:0]  udpmatch_start_addr         ;
reg     [RAM_IPMATCH_DEPTH_BIT - 1:0]   ipmatch_start_addr          ;

reg     [15:0]                          datram_udpmatch_wdat_l      ;
reg                                     udp_match_valid_1dly        ;
reg                                     ipmatch_afull_1syn          ;
reg                                     ipmatch_afull_2syn          ;

assign  datram_wren =   mac_rx_valid;
assign  datram_wdat =   mac_rx_data;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_waddr    <=  {11{1'b0}};
    end
    else if(mac_rx_valid==1'b1)
    begin
        datram_waddr    <=  #U_DLY datram_waddr + 11'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_start_addr   <=  {11{1'b0}};
    end
    else if(mac_rx_sop==1'b1)
    begin
        datram_start_addr   <=  #U_DLY datram_waddr;
    end
end

//generate info_fifo_wdat
//reserved  udp_filter_index   pkt_type   mac_rx_mod    mac_rx_frmlen   datram_start_address
//  [43]      [42:27]           [26:25]      [24:23]       [22:11]           [10:0]
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_wdat  <=  {INFO_FIFO_WIDTH{1'b0}};
    end
    else if(mac_rx_eop==1'b1)
    begin
        info_fifo_wdat  <=  {1'b0,udp_filter_index[15:0],pkt_type[1:0],mac_rx_mod[1:0],mac_rx_frmlen[11:0],datram_start_addr[10:0]};
    end
    else
    begin
        info_fifo_wdat  <=  #U_DLY {INFO_FIFO_WIDTH{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_wren  <=  1'b0;
    end
    else if(mac_rx_eop==1'b1)
    begin
        info_fifo_wren  <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_wren  <=  #U_DLY 1'b0;
    end
end

assign  frm_start_addr  =   info_fifo_rdat[10:0];
assign  frm_len         =   info_fifo_rdat[22:11];
assign  frm_mod         =   info_fifo_rdat[24:23];
//2'b01:ip_port_match;2'b10:ip_addr_filter_match;2'b11:checksum_err;2'b00:other;
assign  frm_type        =   info_fifo_rdat[26:25];
assign  frm_filter_index=   info_fifo_rdat[42:27];
assign  udp_pkt_len     =   frm_len - 12'd42;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cycle_num   <=  {9{1'b0}};
    end
    else if(st_info_curr==ST_INFO_RD_DAT)
    begin
        if(frm_mod==2'b00)
        begin
            cycle_num   <=  #U_DLY frm_len[10:2];                       //frm_len / 4;
        end
        else
        begin
            cycle_num   <=  #U_DLY frm_len[10:2] + 9'h1;                //frm_len / 4 + 9'h1;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cycle_num_b     <=  {10{1'b0}};
    end
    else if(st_info_curr==ST_INFO_RD_DAT)
    begin
        if(frm_len[0]==1'b0)
        begin
            cycle_num_b <=  #U_DLY frm_len[10:1];                       //frm_len / 2;
        end
        else
        begin
            cycle_num_b <=  #U_DLY frm_len[10:1] + 10'h1;               //frm_len / 2 + 10'h1;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        count_a <=  {9{1'b0}};
    end
    else if(st_info_curr==ST_INFO_UDP_MATCH)
    begin
        count_a <=  #U_DLY count_a + 9'h1;
    end
    else
    begin
        count_a <=  #U_DLY {9{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        count_b <=  {10{1'b0}};
    end
    else if(st_info_curr==ST_INFO_IPADDR_MATCH)
    begin
        count_b <=  #U_DLY count_b + 10'h1;
    end
    else
    begin
        count_b <=  #U_DLY {10{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ipmatch_afull_1syn  <=  1'b0;
        ipmatch_afull_2syn  <=  1'b0;
    end
    else
    begin
        ipmatch_afull_1syn  <=  #U_DLY info_fifo_ipmatch_afull;
        ipmatch_afull_2syn  <=  #U_DLY ipmatch_afull_1syn;
    end
end

//information fifo rd state machine
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        st_info_curr    <=  ST_INFO_IDLE;
    end
    else
    begin
        st_info_curr    <=  #U_DLY st_info_next;
    end
end

always@*
begin
    case(st_info_curr)
    ST_INFO_IDLE:
    begin
        if(info_fifo_empty==1'b0)
        begin
            st_info_next    =   ST_INFO_RDEN;
        end
        else
        begin
            st_info_next    =   ST_INFO_IDLE;
        end
    end
    ST_INFO_RDEN:
    begin
        st_info_next    =   ST_INFO_WAIT;
    end
    ST_INFO_WAIT:
    begin
        st_info_next    =   ST_INFO_RD_DAT;
    end
    ST_INFO_RD_DAT:
    begin
        if(frm_type==2'b01)
        begin
            st_info_next    =   ST_INFO_UDP_MATCH;
        end
        else if((frm_type==2'b10) && (ipmatch_afull_2syn==1'b0))
        begin
            st_info_next    =   ST_INFO_IPADDR_MATCH;
        end
        else
        begin
            st_info_next    =   ST_INFO_IDLE;
        end
    end
    ST_INFO_IPADDR_MATCH:
    begin
        if(cycle_num_b==count_b + 1)
        begin
            st_info_next    =   ST_INFO_IPMATCH_RD_END;
        end
        else
        begin
            st_info_next    =   ST_INFO_IPADDR_MATCH;
        end
    end
    ST_INFO_UDP_MATCH:
    begin
        if(cycle_num==count_a + 11)
        begin
            st_info_next    =   ST_INFO_UDPMATCH_RD_END;
        end
        else
        begin
            st_info_next    =   ST_INFO_UDP_MATCH;
        end
    end
    ST_INFO_UDPMATCH_RD_END:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    ST_INFO_IPMATCH_RD_END:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    default:
    begin
        st_info_next    =   ST_INFO_IDLE;
    end
    endcase
end

//info fifo rden
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_rden  <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_RDEN)
    begin
        info_fifo_rden  <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_rden  <=  #U_DLY 1'b0;
    end
end

//datram_raddr
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_raddr    <=  {11{1'b0}};
    end
    else if(st_info_curr==ST_INFO_RD_DAT)
    begin
        if(frm_type==2'b01)                                             //UDP match pkt
        begin
            datram_raddr    <=  #U_DLY frm_start_addr + 11'd10;
        end
        else
        begin
            datram_raddr    <=  #U_DLY frm_start_addr;
        end
    end
    else if(st_info_curr==ST_INFO_UDP_MATCH)
    begin
        datram_raddr    <=  #U_DLY datram_raddr + 11'h1;
    end
    else if((st_info_curr==ST_INFO_IPADDR_MATCH) && (count_b[0]==1'b1))
    begin
        datram_raddr    <=  #U_DLY datram_raddr + 11'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udp_match_valid <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_UDP_MATCH)
    begin
        udp_match_valid <=  #U_DLY 1'b1;
    end
    else
    begin
        udp_match_valid <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udp_match_valid_1dly    <=  1'b0;
    end
    else
    begin
        udp_match_valid_1dly    <=  #U_DLY udp_match_valid;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ip_match_valid  <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_IPADDR_MATCH)
    begin
        ip_match_valid  <=  #U_DLY 1'b1;
    end
    else
    begin
        ip_match_valid  <=  #U_DLY 1'b0;
    end
end

//udp match datram
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_udpmatch_wren    <=  1'b0;
    end
    else if(^frm_mod==1'b1)
    begin
        datram_udpmatch_wren    <=  #U_DLY udp_match_valid;
    end
    else
    begin
        datram_udpmatch_wren    <=  #U_DLY udp_match_valid | udp_match_valid_1dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_udpmatch_wdat_l  <=  {16{1'b0}};
    end
    else if(udp_match_valid==1'b1)
    begin
        datram_udpmatch_wdat_l  <=  #U_DLY datram_rdat[15:0];
    end
end

assign  datram_udpmatch_wdat    =   (datram_udpmatch_wren==1'b1)    ?   {datram_udpmatch_wdat_l[15:0],datram_rdat[31:16]}   :
                                    {DATA_WIDTH{1'b0}};
                                    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_udpmatch_waddr   <=  {RAM_UDPMATCH_DEPTH_BIT{1'b0}};
    end
    else if(datram_udpmatch_wren==1'b1)
    begin
        datram_udpmatch_waddr   <=  #U_DLY datram_udpmatch_waddr + 'h1;
    end
end

//ip match datram
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_ipmatch_wren     <=  1'b0;
    end
    else
    begin
        datram_ipmatch_wren     <=  #U_DLY ip_match_valid;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_ipmatch_wdat     <=  {RAM_IPMATCH_DATA_WIDTH{1'b0}};
    end
    else if(ip_match_valid==1'b1)
    begin
        if(count_b[0]==1'b1)
        begin
            datram_ipmatch_wdat     <=  #U_DLY datram_rdat[31:16];
        end
        else
        begin
            datram_ipmatch_wdat     <=  #U_DLY datram_rdat[15:0];
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_ipmatch_waddr    <=  {RAM_IPMATCH_DEPTH_BIT{1'b0}};
    end
    else if(datram_ipmatch_wren==1'b1)
    begin
        datram_ipmatch_waddr    <=  #U_DLY datram_ipmatch_waddr + 'h1;
    end
end

//udp match info fifo
//wren
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_udpmatch_wren <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_UDPMATCH_RD_END)
    begin
        info_fifo_udpmatch_wren <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_udpmatch_wren <=  #U_DLY 1'b0;
    end
end

//wdat,dst_port(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_udpmatch_wdat <=  {FIFO_UDPMATCH_WIDTH{1'b0}};
    end
    else if(st_info_curr==ST_INFO_UDPMATCH_RD_END)
    begin
        info_fifo_udpmatch_wdat <=  #U_DLY {frm_filter_index[15:0],udp_pkt_len[11:0],udpmatch_start_addr[RAM_UDPMATCH_DEPTH_BIT - 1 : 0]};
    end
    else
    begin
        info_fifo_udpmatch_wdat <=  #U_DLY {FIFO_UDPMATCH_WIDTH{1'b0}};
    end
end

//ip match info fifo
//ipmatch_wren
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_ipmatch_wren  <=  1'b0;
    end
    else if(st_info_curr==ST_INFO_IPMATCH_RD_END)
    begin
        info_fifo_ipmatch_wren  <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_ipmatch_wren  <=  #U_DLY 1'b0;
    end
end

//ipmatch_wdat,frm_len(12bit)+start_addr(11bit)
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_ipmatch_wdat  <=  {FIFO_IPMATCH_WIDTH{1'b0}};
    end
    else if(st_info_curr==ST_INFO_IPMATCH_RD_END)
    begin
        info_fifo_ipmatch_wdat  <=  #U_DLY {frm_len[11:0],ipmatch_start_addr[RAM_IPMATCH_DEPTH_BIT - 1 : 0]};
    end
    else
    begin
        info_fifo_ipmatch_wdat  <=  #U_DLY {FIFO_IPMATCH_WIDTH{1'b0}};
    end
end

//udpmatch_start_addr
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_start_addr <=  {RAM_UDPMATCH_DEPTH_BIT{1'b0}};
    end
    else if(st_info_curr==ST_INFO_RD_DAT)
    begin
        udpmatch_start_addr <=  #U_DLY datram_udpmatch_waddr;
    end
end

//ipmatch_start_addr
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ipmatch_start_addr  <=  {RAM_IPMATCH_DEPTH_BIT{1'b0}};
    end
    else if(st_info_curr==ST_INFO_RD_DAT)
    begin
        ipmatch_start_addr  <=  #U_DLY datram_ipmatch_waddr;
    end
end

//2Kx32bit,read latency = 1;
frmbuf_datram u0_frmbuf_datram(
    .clka                               ( clk                       ),
    .wea                                ( datram_wren               ),
    .addra                              ( datram_waddr              ),
    .dina                               ( datram_wdat               ),
    .clkb                               ( clk                       ),
    .addrb                              ( datram_raddr              ),
    .doutb                              ( datram_rdat               )
    );

frmbuf_info_fifo u0_frmbuf_info_fifo(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .din                                ( info_fifo_wdat            ),
    .wr_en                              ( info_fifo_wren            ),
    .rd_en                              ( info_fifo_rden            ),
    .dout                               ( info_fifo_rdat            ),
    .full                               ( info_fifo_full            ),
    .almost_full                        ( info_fifo_afull           ),
    .empty                              ( info_fifo_empty           ),
    .almost_empty                       ( info_fifo_aempty          ),
    .data_count                         ( info_fifo_datcnt          )
    );
            
endmodule
