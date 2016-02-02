/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_rx_matchbuf.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-16  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_rx_matchbuf.v
    File tree    :   gbe_rx_matchbuf.v
\************************************************************************************/

`timescale 1ns/100ps

module gbe_rx_matchbuf(
    rst_cfg                     ,
    rst                         ,
    clk_cfg                     ,
    clk                         ,
    //udp match datram
    datram_udpmatch_wren        ,
    datram_udpmatch_wdat        ,
    datram_udpmatch_waddr       ,
    //udp match infor fifo,port_index(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
    info_fifo_udpmatch_wren     ,
    info_fifo_udpmatch_wdat     ,
    //ip match datram
    datram_ipmatch_wren         ,
    datram_ipmatch_wdat         ,
    datram_ipmatch_waddr        ,
    //ip match infor fifo,frm_len(12bit)+start_addr(11bit)
    info_fifo_ipmatch_wren      ,
    info_fifo_ipmatch_wdat      ,
    //udp pkt
    udpmatch_valid              ,
    udpmatch_sop                ,
    udpmatch_eop                ,
    udpmatch_data               ,
    udpmatch_mod                ,
    udpmatch_pkt_len            ,
    udpmatch_port_index         ,
    //ip match rd,frm_len(12bit)+start_addr(11bit)
    int_ipmatch                 ,
    info_fifo_ipmatch_rden      ,
    ipmatch_pkt_cnt             ,
    ipmatch_pkt_len             ,
    ipmatch_start_addr          ,
    info_fifo_ipmatch_afull     ,
    datram_ipmatch_raddr        ,
    datram_ipmatch_rdat
    );

parameter   U_DLY                       = 1                         ;
parameter   DATA_WIDTH                  = 32                        ;
parameter   RAM_IPMATCH_DATA_WIDTH      = 16                        ;
parameter   RAM_UDPMATCH_DEPTH_BIT      = 10                        ;
parameter   RAM_IPMATCH_DEPTH_BIT       = 11                        ;
parameter   FIFO_UDPMATCH_WIDTH         = 38                        ;
parameter   FIFO_UDPMATCH_DEPTH_BIT     = 6                         ;
parameter   FIFO_IPMATCH_WIDTH          = 23                        ;
parameter   FIFO_IPMATCH_DEPTH_BIT      = 6                         ;
                                        
parameter   ST_UDPMATCH_WIDTH           = 6                         ;
parameter   ST_UDPMATCH_IDLE            = 6'b000001                 ,
            ST_UDPMATCH_RDEN            = 6'b000010                 ,
            ST_UDPMATCH_RDWAIT          = 6'b000100                 ,
            ST_UDPMATCH_RDINFO          = 6'b001000                 ,
            ST_UDPMATCH_RD_DATA         = 6'b010000                 ,
            ST_UDPMATCH_RD_END          = 6'b100000                 ;

input                                   rst_cfg                     ;
input                                   rst                         ;
input                                   clk                         ;
input                                   clk_cfg                     ;

input                                   datram_udpmatch_wren        ;
input   [DATA_WIDTH - 1 : 0]            datram_udpmatch_wdat        ;
input   [RAM_UDPMATCH_DEPTH_BIT - 1:0]  datram_udpmatch_waddr       ;
input                                   info_fifo_udpmatch_wren     ;
input   [FIFO_UDPMATCH_WIDTH - 1 : 0]   info_fifo_udpmatch_wdat     ;
    
input                                   datram_ipmatch_wren         ;
input   [RAM_IPMATCH_DATA_WIDTH-1 : 0]  datram_ipmatch_wdat         ;
input   [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_waddr        ;
input                                   info_fifo_ipmatch_wren      ;
input   [FIFO_IPMATCH_WIDTH - 1 : 0]    info_fifo_ipmatch_wdat      ;

output                                  udpmatch_valid              ;
output                                  udpmatch_sop                ;
output                                  udpmatch_eop                ;
output  [DATA_WIDTH - 1 : 0]            udpmatch_data               ;
output  [1:0]                           udpmatch_mod                ;
output  [11:0]                          udpmatch_pkt_len            ;
output  [15:0]                          udpmatch_port_index         ;

output                                  int_ipmatch                 ;
input                                   info_fifo_ipmatch_rden      ;
output  [FIFO_IPMATCH_DEPTH_BIT-1:0]    ipmatch_pkt_cnt             ;
output  [11:0]                          ipmatch_pkt_len             ;
output  [RAM_IPMATCH_DEPTH_BIT-1:0]     ipmatch_start_addr          ;
output                                  info_fifo_ipmatch_afull     ;
input   [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_raddr        ;
output  [RAM_IPMATCH_DATA_WIDTH-1 : 0]  datram_ipmatch_rdat         ;

reg     [RAM_UDPMATCH_DEPTH_BIT - 1:0]  datram_udpmatch_raddr       ; 
wire    [DATA_WIDTH - 1 : 0]            datram_udpmatch_rdat        ;
reg                                     info_fifo_udpmatch_rden     ;
wire    [FIFO_UDPMATCH_WIDTH - 1 : 0]   info_fifo_udpmatch_rdat     ; 
wire                                    info_fifo_udpmatch_full     ;
wire                                    info_fifo_udpmatch_afull    ;
wire                                    info_fifo_udpmatch_empty    ;
wire                                    info_fifo_udpmatch_aempty   ;
wire    [FIFO_UDPMATCH_DEPTH_BIT-1:0]   info_fifo_udpmatch_datcnt   ;

wire    [RAM_IPMATCH_DATA_WIDTH-1 : 0]  datram_ipmatch_rdat         ; 
wire                                    info_fifo_ipmatch_rden      ;
wire    [FIFO_IPMATCH_WIDTH - 1 : 0]    info_fifo_ipmatch_rdat      ;
wire                                    info_fifo_ipmatch_full      ;
wire                                    info_fifo_ipmatch_afull     ;
wire                                    info_fifo_ipmatch_empty     ;
wire                                    info_fifo_ipmatch_aempty    ;
wire    [FIFO_IPMATCH_DEPTH_BIT-1:0]    info_fifo_ipmatch_datcnt    ;
reg     [FIFO_IPMATCH_DEPTH_BIT-1:0]    ipmatch_pkt_cnt             ;

reg     [ST_UDPMATCH_WIDTH - 1 : 0]     st_udpmatch_curr    /* synthesis syn_encoding = "safe,onehot" */;
reg     [ST_UDPMATCH_WIDTH - 1 : 0]     st_udpmatch_next            ;

reg     [8:0]                           udpmatch_cycle_num          ;
reg     [8:0]                           count_a                     ;
wire    [11:0]                          udp_pkt_len                 ;
wire    [15:0]                          port_index                  ;
wire    [9:0]                           udpmatch_start_addr         ;

reg                                     udpmatch_valid_reg          ;
reg                                     udpmatch_valid              ;
reg                                     udpmatch_sop                ;
reg                                     udpmatch_eop                ;
reg     [DATA_WIDTH - 1 : 0]            udpmatch_data               ;
reg     [1:0]                           udpmatch_mod                ;
reg     [11:0]                          udpmatch_pkt_len            ;
reg     [15:0]                          udpmatch_port_index         ;

reg                                     int_ipmatch                 ;
wire    [11:0]                          ipmatch_pkt_len             ;
wire    [RAM_IPMATCH_DEPTH_BIT-1:0]     ipmatch_start_addr          ;

(* keep = "TRUE" *)
wire                                    rst_ipmatch_info_fifo       ;

assign  rst_ipmatch_info_fifo   =   rst | rst_cfg;

//info_fifo_udpmatch_rden
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        info_fifo_udpmatch_rden <=  1'b0;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RDEN)
    begin
        info_fifo_udpmatch_rden <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_udpmatch_rden <=  #U_DLY 1'b0;
    end
end

assign  port_index          =   info_fifo_udpmatch_rdat[37:22];
assign  udp_pkt_len         =   info_fifo_udpmatch_rdat[21:10];
assign  udpmatch_start_addr =   info_fifo_udpmatch_rdat[9:0];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_cycle_num  <=  {9{1'b0}};
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RDINFO)
    begin
        if(udp_pkt_len[1:0]==2'b00)
        begin
            udpmatch_cycle_num   <=  #U_DLY udp_pkt_len[10:2];          //udp_pkt_len / 4;
        end
        else
        begin
            udpmatch_cycle_num   <=  #U_DLY udp_pkt_len[10:2] + 9'h1;   //udp_pkt_len / 4 + 9'h1;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        count_a <=  {9{1'b0}};
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RD_DATA)
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
        st_udpmatch_curr    <=  ST_UDPMATCH_IDLE;
    end
    else
    begin
        st_udpmatch_curr    <=  #U_DLY st_udpmatch_next;
    end
end

always@*
begin
    case(st_udpmatch_curr)
    ST_UDPMATCH_IDLE:
    begin
        if(info_fifo_udpmatch_empty==1'b1)
        begin
            st_udpmatch_next    =   ST_UDPMATCH_IDLE;
        end
        else
        begin
            st_udpmatch_next    =   ST_UDPMATCH_RDEN;
        end
    end
    ST_UDPMATCH_RDEN:
    begin
        st_udpmatch_next    =   ST_UDPMATCH_RDWAIT;
    end
    ST_UDPMATCH_RDWAIT:
    begin
        st_udpmatch_next    =   ST_UDPMATCH_RDINFO;
    end    
    ST_UDPMATCH_RDINFO:
    begin
        st_udpmatch_next    =   ST_UDPMATCH_RD_DATA;
    end
    ST_UDPMATCH_RD_DATA:
    begin
        if(udpmatch_cycle_num==count_a + 1)
        begin
            st_udpmatch_next    =   ST_UDPMATCH_RD_END;
        end
        else
        begin
            st_udpmatch_next    =   ST_UDPMATCH_RD_DATA;
        end
    end
    ST_UDPMATCH_RD_END:
    begin
        st_udpmatch_next    =   ST_UDPMATCH_IDLE;
    end
    default:
    begin
        st_udpmatch_next    =   ST_UDPMATCH_IDLE;
    end
    endcase
end    

//datram_udpmatch_raddr
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        datram_udpmatch_raddr   <=  {RAM_UDPMATCH_DEPTH_BIT{1'b0}}; 
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RDINFO)  
    begin
        datram_udpmatch_raddr   <=  #U_DLY udpmatch_start_addr;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RD_DATA)
    begin
        datram_udpmatch_raddr   <=  #U_DLY datram_udpmatch_raddr + 10'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_valid_reg  <=  1'b0;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RD_DATA)
    begin
        udpmatch_valid_reg  <=  #U_DLY 1'b1;
    end
    else
    begin
        udpmatch_valid_reg  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_valid  <=  1'b0;
    end
    else
    begin
        udpmatch_valid  <=  #U_DLY udpmatch_valid_reg;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_sop    <=  1'b0;
    end
    else if((st_udpmatch_curr==ST_UDPMATCH_RD_DATA) && (count_a==9'd1))
    begin
        udpmatch_sop    <=  #U_DLY 1'b1;
    end
    else
    begin
        udpmatch_sop    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_data   <=  {DATA_WIDTH{1'b0}};
    end
    else if(udpmatch_valid_reg==1'b1)
    begin
        udpmatch_data   <=  #U_DLY datram_udpmatch_rdat;
    end
    else
    begin
        udpmatch_data   <=  #U_DLY {DATA_WIDTH{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_eop    <=  1'b0;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RD_END)
    begin
        udpmatch_eop    <=  #U_DLY 1'b1;
    end
    else
    begin
        udpmatch_eop    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_pkt_len    <=  12'h000;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RDINFO)
    begin
        udpmatch_pkt_len    <=  #U_DLY udp_pkt_len;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_IDLE)
    begin
        udpmatch_pkt_len    <=  #U_DLY 12'h000;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_port_index <=  16'h0000;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RDINFO)
    begin
        udpmatch_port_index <=  #U_DLY port_index;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_IDLE)
    begin
        udpmatch_port_index <=  #U_DLY 16'h0000;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udpmatch_mod    <=  2'b00;
    end
    else if(st_udpmatch_curr==ST_UDPMATCH_RD_END)
    begin
        udpmatch_mod    <=  #U_DLY udp_pkt_len[1:0];
    end
    else
    begin
        udpmatch_mod    <=  #U_DLY 2'b00;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        int_ipmatch <=  1'b0;
    end
    else if(|info_fifo_ipmatch_datcnt==1'b0)
    begin
        int_ipmatch <=  #U_DLY 1'b0;
    end
    else
    begin
        int_ipmatch <=  #U_DLY 1'b1;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ipmatch_pkt_cnt <=  {FIFO_IPMATCH_DEPTH_BIT{1'b0}};
    end
    else
    begin
        ipmatch_pkt_cnt <=  #U_DLY info_fifo_ipmatch_datcnt;
    end
end

//frm_len(12bit)+start_addr(11bit)
assign  ipmatch_pkt_len     =   info_fifo_ipmatch_rdat[21:RAM_IPMATCH_DEPTH_BIT];
assign  ipmatch_start_addr  =   info_fifo_ipmatch_rdat[RAM_IPMATCH_DEPTH_BIT - 1 : 0];   

//read latency = 1;1Kx32bit;
udpmatch_datram u0_udpmatch_datram(
    .clka                               ( clk                       ),
    .wea                                ( datram_udpmatch_wren      ),
    .addra                              ( datram_udpmatch_waddr     ),
    .dina                               ( datram_udpmatch_wdat      ),
    .clkb                               ( clk                       ),
    .addrb                              ( datram_udpmatch_raddr     ),
    .doutb                              ( datram_udpmatch_rdat      )
    );

//port_index(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
udpmatch_info_fifo u0_udpmatch_info_fifo(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .din                                ( info_fifo_udpmatch_wdat   ),
    .wr_en                              ( info_fifo_udpmatch_wren   ),
    .rd_en                              ( info_fifo_udpmatch_rden   ),
    .dout                               ( info_fifo_udpmatch_rdat   ),
    .full                               ( info_fifo_udpmatch_full   ),
    .almost_full                        ( info_fifo_udpmatch_afull  ),
    .empty                              ( info_fifo_udpmatch_empty  ),
    .almost_empty                       ( info_fifo_udpmatch_aempty ),
    .data_count                         ( info_fifo_udpmatch_datcnt )
    );

//width:16bit;depth:2k;read latency=2;    
ipmatch_datram u0_ipmatch_datram(
    .clka                               ( clk                       ),
    .wea                                ( datram_ipmatch_wren       ),
    .addra                              ( datram_ipmatch_waddr      ),
    .dina                               ( datram_ipmatch_wdat       ),
    .clkb                               ( clk_cfg                   ),
    .addrb                              ( datram_ipmatch_raddr      ),
    .doutb                              ( datram_ipmatch_rdat       )
    );

//width:23bit;depth:64;output register
ipmatch_info_fifo u0_ipmatch_info_fifo(
    .rst                                ( rst_ipmatch_info_fifo     ),
    .wr_clk                             ( clk                       ),
    .rd_clk                             ( clk_cfg                   ),
    .din                                ( info_fifo_ipmatch_wdat    ),
    .wr_en                              ( info_fifo_ipmatch_wren    ),
    .rd_en                              ( info_fifo_ipmatch_rden    ),
    .dout                               ( info_fifo_ipmatch_rdat    ),
    .full                               ( info_fifo_ipmatch_full    ),
    .almost_full                        ( info_fifo_ipmatch_afull   ),
    .empty                              ( info_fifo_ipmatch_empty   ),
    .almost_empty                       ( info_fifo_ipmatch_aempty  ),
    .rd_data_count                      ( info_fifo_ipmatch_datcnt  )
    );
        
endmodule
