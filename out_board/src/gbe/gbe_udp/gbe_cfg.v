/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_cfg.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-18  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_cfg.v
    File tree    :   gbe_cfg.v
\************************************************************************************/

`timescale 1ns/100ps

module gbe_cfg(
    rst_tx                      ,
    rst_cfg                     ,
    clk_tx                      ,
    clk_cfg                     ,
    //local bus
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_rdata                  ,
    lbus_cs_n                   ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    lbus_wait_n                 ,
    //filter ipaddr
    local_ip                    ,
    local_ip2                   ,
    local_mac                   ,
    mac_filter_ena              ,
    filter_ip_addr1             ,
    filter_ip_addr2             ,
    filter_ip_addr3             ,
    filter_ip_addr4             ,
    filter_ip_addr5             ,
    filter_ip_addr6             ,
    filter_ip_addr7             ,
    filter_ip_addr8             ,
    //phy control & status      
    phy_switch                  ,
    phy_link_status             ,
    //udp_table                 
    udp_table_switch            ,                                       //keep '1' until udp_table_is_searching=0,clk_cfg clock domain
    udp_table_is_searching      ,
    udp_table_wren              ,
    udp_table_waddr             ,
    udp_table_wdat              ,
    //ipaddr filter             
    info_fifo_ipmatch_rden      ,
    ipmatch_pkt_cnt             ,
    ipmatch_pkt_len             ,
    ipmatch_start_addr          ,
    datram_ipmatch_raddr        ,
    datram_ipmatch_rdat         ,
    //rx_pkt_cnt & rx_byte_cnt  
    gbe_rx_pkt_cnt              ,
    gbe_rx_byte_cnt             ,
    //sfp add-in:"0" add-in;"1" not-in
    sfp_main_add_in             ,
    sfp_backup_add_in           ,
    //sfp tx disable
    sfp_main_tx_disable         ,
    sfp_backup_tx_disable       ,
    //mac_tx:1122 3344 5566 7788                    
    mac_tx_data                 ,
    mac_tx_valid                ,
    mac_tx_ready                ,
    mac_tx_last                 
    );
    
parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   U_DLY                       = 1                         ;
parameter   UDP_TABLE_WIDTH             = 64                        ;
parameter   UDP_TABLE_DEPTH_BIT         = 9                         ;
parameter   RAM_IPMATCH_DATA_WIDTH      = 16                        ;
parameter   RAM_IPMATCH_DEPTH_BIT       = 11                        ;

parameter   RAM_IPTX_WIDTH              = 16                        ;
parameter   RAM_IPTX_DEPTH_BIT          = 11                        ;
//info fifo:pkt_len(12bit)+start_address(11bit)
parameter   INFO_FIFO_IPTX_WIDTH        = 23                        ;
parameter   INFO_FIFO_IPTX_DEPTH_BIT    = 6                         ;

parameter   ST_IPTX_WIDTH               = 6                         ;
parameter   ST_IPTX_IDLE                = 6'b000001                 ,
            ST_IPTX_RDEN                = 6'b000010                 ,
            ST_IPTX_WAIT                = 6'b000100                 ,
            ST_IPTX_RD_INFO             = 6'b001000                 ,
            ST_IPTX_RD_DATA             = 6'b010000                 ,
            ST_IPTX_RD_END              = 6'b100000                 ;

parameter   GBE_CONN_SET                = 12'h201                   ;
parameter   GBE_LINK_STATUS             = 12'h202                   ;
parameter   GBE_PKTCNT_L                = 12'h203                   ;
parameter   GBE_PKTCNT_H                = 12'h204                   ;
parameter   GBE_BYTECNT_L               = 12'h205                   ;
parameter   GBE_BYTECNT_H               = 12'h206                   ;

parameter   GBE_DST_IP_L                = 12'h220                   ;
parameter   GBE_DST_IP_H                = 12'h221                   ;
parameter   GBE_DST_PORT                = 12'h222                   ;
parameter   GBE_PORT_INDEX              = 12'h223                   ;
parameter   GBE_UDPFILTER_SET           = 12'h224                   ;
parameter   GBE_UDPFILTER_CTRL          = 12'h225                   ;

parameter   GBE_IP_FILTER_L             = 12'h210                   ;
parameter   GBE_IP_FILTER_H             = 12'h211                   ;
parameter   GBE_IPFILTER_SET            = 12'h212                   ;

parameter   ADDR_IPMATCH_PKTCNT         = 12'h217                   ;
parameter   GBE_IPRX_DATA               = 12'h218                   ;
parameter   GBE_IPRX_PKTLEN             = 12'h219                   ;
parameter   GBE_IPRX_PTR_RST            = 12'h21a                   ;
parameter   GBE_IPTX_DATA               = 12'h21b                   ;
parameter   GBE_IPTX_PKTLEN             = 12'h21c                   ;

parameter   GBE_IP_ADDR_L               = 12'h226                   ;
parameter   GBE_IP_ADDR_H               = 12'h227                   ;
parameter   GBE_MAC_ADDR_L              = 12'h228                   ;
parameter   GBE_MAC_ADDR_M              = 12'h229                   ;
parameter   GBE_MAC_ADDR_H              = 12'h22a                   ;
parameter   GBE_PHY_POWER_DOWN          = 12'h22b                   ;
parameter   GBE_IP_ADDR2_L              = 12'h22c                   ;
parameter   GBE_IP_ADDR2_H              = 12'h22d                   ;

input                                   rst_tx                      ;
input                                   rst_cfg                     ;
input                                   clk_tx                      ;
input                                   clk_cfg                     ;
//local bus
input   [P_BUS_ADDR_WIDTH-1:0]          lbus_addr                   ;
input   [P_BUS_DATA_WIDTH-1:0]          lbus_wdata                  ;
output  [P_BUS_DATA_WIDTH-1:0]          lbus_rdata                  ;
input                                   lbus_cs_n                   ;
input                                   lbus_oe_n                   ;
input                                   lbus_we_n                   ;
output                                  lbus_wait_n                 ;

output  [31:0]                          local_ip                    ;
output  [31:0]                          local_ip2                   ;
output  [47:0]                          local_mac                   ;
output                                  mac_filter_ena              ;
output  [31:0]                          filter_ip_addr1             ;
output  [31:0]                          filter_ip_addr2             ;
output  [31:0]                          filter_ip_addr3             ;
output  [31:0]                          filter_ip_addr4             ;
output  [31:0]                          filter_ip_addr5             ;
output  [31:0]                          filter_ip_addr6             ;
output  [31:0]                          filter_ip_addr7             ;
output  [31:0]                          filter_ip_addr8             ;

output  [1:0]                           phy_switch                  ;
input   [1:0]                           phy_link_status             ;

output                                  udp_table_switch            ;
input                                   udp_table_is_searching      ; 
output                                  udp_table_wren              ;
output  [UDP_TABLE_DEPTH_BIT - 1 : 0]   udp_table_waddr             ;
output  [UDP_TABLE_WIDTH - 1 : 0]       udp_table_wdat              ;  

output                                  info_fifo_ipmatch_rden      ;
input   [5:0]                           ipmatch_pkt_cnt             ;
input   [11:0]                          ipmatch_pkt_len             ;
input   [RAM_IPMATCH_DEPTH_BIT - 1:0]   ipmatch_start_addr          ;
output  [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_raddr        ;
input   [RAM_IPMATCH_DATA_WIDTH-1:0]    datram_ipmatch_rdat         ;

input   [31:0]                          gbe_rx_pkt_cnt              ;
input   [31:0]                          gbe_rx_byte_cnt             ;

//sfp add-in:"0" add-in;"1" not-in
input                                   sfp_main_add_in             ;
input                                   sfp_backup_add_in           ;
//sfp tx disable
output                                  sfp_main_tx_disable         ;
output                                  sfp_backup_tx_disable       ;

output  [7:0]                           mac_tx_data                 ;
output                                  mac_tx_valid                ;
input                                   mac_tx_ready                ;
output                                  mac_tx_last                 ;

reg     [1:0]                           phy_switch                  ;

reg                                     lbus_we_n_1dly              ;
wire                                    negedge_lbus_we_n           ;

reg                                     lbus_oe_n_1dly              ;
wire                                    negedge_lbus_oe_n           ;

//clk_rx clock domain
reg                                     udp_table_wren              ;
reg     [UDP_TABLE_DEPTH_BIT - 1 : 0]   udp_table_waddr             ;
reg     [UDP_TABLE_WIDTH - 1 : 0]       udp_table_wdat              ; 

reg                                     is_searching_1syn           ;
reg                                     is_searching_2syn           ;

reg                                     udp_table_switch            ;

reg     [31:0]                          filter_ip_addr              ;
reg     [31:0]                          filter_ip_addr1             ;
reg     [31:0]                          filter_ip_addr2             ;
reg     [31:0]                          filter_ip_addr3             ;
reg     [31:0]                          filter_ip_addr4             ;
reg     [31:0]                          filter_ip_addr5             ;
reg     [31:0]                          filter_ip_addr6             ;
reg     [31:0]                          filter_ip_addr7             ;
reg     [31:0]                          filter_ip_addr8             ;

reg                                     ram_iptx_wren               ;
reg     [RAM_IPTX_DEPTH_BIT - 1 : 0]    ram_iptx_waddr              ;
reg     [RAM_IPTX_WIDTH - 1 : 0]        ram_iptx_wdat               ;
reg     [RAM_IPTX_DEPTH_BIT - 1 : 0]    ram_iptx_raddr              ;
wire    [RAM_IPTX_WIDTH - 1 : 0]        ram_iptx_rdat               ;

reg                                     info_fifo_iptx_wren         ;
reg     [INFO_FIFO_IPTX_WIDTH - 1 : 0]  info_fifo_iptx_wdat         ;
reg                                     info_fifo_iptx_rden         ;
wire    [INFO_FIFO_IPTX_WIDTH - 1 : 0]  info_fifo_iptx_rdat         ;
reg     [RAM_IPTX_DEPTH_BIT - 1 : 0]    iptx_start_addr             ;

wire                                    info_fifo_iptx_full         ;
wire                                    info_fifo_iptx_afull        ;
wire                                    info_fifo_iptx_empty        ;
wire                                    info_fifo_iptx_aempty       ;
wire    [INFO_FIFO_IPTX_DEPTH_BIT-1:0]  info_fifo_iptx_rdusedw      ;

(* KEEP = "TRUE" *)
wire                                    rst_iptx_info_fifo          ;

reg     [7:0]                           mac_tx_data                 ;
reg                                     mac_tx_valid                ;
reg                                     mac_tx_last                 ;

reg     [15:0]                          lbus_rdata                  ;
wire                                    lbus_wait_n                 ;

reg     [31:0]                          gbe_rx_pkt_cnt_1syn         ;
reg     [31:0]                          gbe_rx_pkt_cnt_2syn         ;
reg     [31:0]                          gbe_rx_byte_cnt_1syn        ;
reg     [31:0]                          gbe_rx_byte_cnt_2syn        ;
reg     [1:0]                           phy_link_status_1syn        ;
reg     [1:0]                           phy_link_status_2syn        ;

reg                                     info_fifo_ipmatch_rden      ;
reg                                     info_fifo_ipmatch_rden_1dly ;
reg                                     info_fifo_ipmatch_rden_2dly ;

reg     [ST_IPTX_WIDTH - 1 : 0]         st_iptx_curr    /* synthesis syn_encoding ="safe,onehot" */;
reg     [ST_IPTX_WIDTH - 1 : 0]         st_iptx_next                ;
reg     [11:0]                          byte_cnt                    ;
wire    [11:0]                          mac_tx_pktlen               ;
wire    [10:0]                          mac_tx_start_addr           ;
reg     [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_raddr        ;
reg                                     sfp_main_add_in_1dly        ;
reg                                     sfp_main_add_in_2dly        ;
reg                                     sfp_main_add_in_3dly        ;
wire                                    negedge_sfp_main_add_in     ;
reg     [19:0]                          sfp_main_tx_dis_cnt         ;
reg                                     sfp_main_tx_disable         ;

reg                                     sfp_backup_add_in_1dly      ;
reg                                     sfp_backup_add_in_2dly      ;
reg                                     sfp_backup_add_in_3dly      ;
wire                                    negedge_sfp_backup_add_in   ;
reg     [19:0]                          sfp_backup_tx_dis_cnt       ;
reg                                     sfp_backup_tx_disable       ;
reg     [31:0]                          local_ip_addr               ;
reg     [31:0]                          local_ip_addr2              ;
reg     [47:0]                          local_mac_addr              ;
reg     [31:0]                          local_ip_addr_1syn          ;
reg     [31:0]                          local_ip                    ;
reg     [31:0]                          local_ip_addr2_1syn         ;
reg     [31:0]                          local_ip2                   ;
reg     [47:0]                          local_mac_addr_1syn         ;
reg     [47:0]                          local_mac                   ;
reg     [15:0]                          ip_addr_reg                 ;
reg     [15:0]                          ip_addr2_reg                ;
reg     [31:0]                          mac_addr_reg                ;
reg                                     mac_filter_ena              ;
reg                                     mac_filter_ena_reg          ;
reg                                     mac_filter_ena_1syn         ;
reg                                     phy_powerdown               ;

assign  rst_iptx_info_fifo  =   rst_cfg | rst_tx; 
assign  lbus_wait_n         =   1'b1;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_we_n_1dly  <=  1'b1;
    end
    else
    begin
        lbus_we_n_1dly  <=  #U_DLY lbus_we_n;
    end
end

assign  negedge_lbus_we_n    =   (~lbus_we_n) & lbus_we_n_1dly;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_oe_n_1dly  <=  1'b1;
    end
    else
    begin
        lbus_oe_n_1dly  <=  #U_DLY lbus_oe_n;
    end
end

assign  negedge_lbus_oe_n   =   (~lbus_oe_n) & lbus_oe_n_1dly;

//local bus write
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        phy_switch      <=  2'b01;
        udp_table_wdat  <=  {UDP_TABLE_WIDTH{1'b0}};
        udp_table_waddr <=  {UDP_TABLE_DEPTH_BIT{1'b0}};
        filter_ip_addr  <=  {32{1'b0}};
        filter_ip_addr1 <=  {32{1'b0}};
        filter_ip_addr2 <=  {32{1'b0}};
        filter_ip_addr3 <=  {32{1'b0}};
        filter_ip_addr4 <=  {32{1'b0}};
        filter_ip_addr5 <=  {32{1'b0}};
        filter_ip_addr6 <=  {32{1'b0}};
        filter_ip_addr7 <=  {32{1'b0}};
        filter_ip_addr8 <=  {32{1'b0}};
        local_ip_addr   <=  {32{1'b1}};
        local_ip_addr2  <=  {32{1'b1}};
        local_mac_addr  <=  {48{1'b0}};
        ip_addr_reg     <=  {16{1'b0}};
        ip_addr2_reg    <=  {16{1'b0}};
        mac_addr_reg    <=  {32{1'b0}};
        mac_filter_ena_reg<=  1'b0;
        phy_powerdown   <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1))
    begin
        case(lbus_addr)
        GBE_CONN_SET:       phy_switch              <=  #U_DLY lbus_wdata[1:0];  
        //udp filter table
        GBE_DST_IP_L:       udp_table_wdat[15:0]    <=  #U_DLY lbus_wdata;
        GBE_DST_IP_H:       udp_table_wdat[31:16]   <=  #U_DLY lbus_wdata;
        GBE_DST_PORT:       udp_table_wdat[47:32]   <=  #U_DLY lbus_wdata;
        GBE_PORT_INDEX:     udp_table_wdat[63:48]   <=  #U_DLY lbus_wdata; 
        GBE_UDPFILTER_SET:  udp_table_waddr         <=  #U_DLY lbus_wdata[8:0]; 
        //ip address filter
        GBE_IP_FILTER_L:    filter_ip_addr[15:0]    <=  #U_DLY lbus_wdata;
        GBE_IP_FILTER_H:    filter_ip_addr[31:16]   <=  #U_DLY lbus_wdata;
        GBE_IPFILTER_SET:
        begin
            case(lbus_wdata[2:0])
            3'b000: filter_ip_addr1 <=  #U_DLY filter_ip_addr;
            3'b001: filter_ip_addr2 <=  #U_DLY filter_ip_addr;
            3'b010: filter_ip_addr3 <=  #U_DLY filter_ip_addr;
            3'b011: filter_ip_addr4 <=  #U_DLY filter_ip_addr;
            3'b100: filter_ip_addr5 <=  #U_DLY filter_ip_addr;
            3'b101: filter_ip_addr6 <=  #U_DLY filter_ip_addr;
            3'b110: filter_ip_addr7 <=  #U_DLY filter_ip_addr;
            3'b111: filter_ip_addr8 <=  #U_DLY filter_ip_addr;
            default:;
            endcase
        end
        GBE_IP_ADDR_L:      ip_addr_reg[15:0]       <=  #U_DLY lbus_wdata;
        GBE_IP_ADDR_H:      local_ip_addr[31:0]     <=  #U_DLY {lbus_wdata[15:0],ip_addr_reg[15:0]};
        GBE_MAC_ADDR_L:     mac_addr_reg[15:0]      <=  #U_DLY lbus_wdata;
        GBE_MAC_ADDR_M:     mac_addr_reg[31:16]     <=  #U_DLY lbus_wdata;
        GBE_MAC_ADDR_H:     
        begin
            local_mac_addr[47:0]    <=  #U_DLY {lbus_wdata[15:0],mac_addr_reg[31:0]};
            mac_filter_ena_reg      <=  #U_DLY 1'b1;
        end
        GBE_PHY_POWER_DOWN: phy_powerdown           <=  #U_DLY lbus_wdata[0];
        GBE_IP_ADDR2_L:     ip_addr2_reg[15:0]      <=  #U_DLY lbus_wdata;
        GBE_IP_ADDR2_H:     local_ip_addr2[31:0]    <=  #U_DLY {lbus_wdata[15:0],ip_addr2_reg[15:0]};
        
        default:;
		endcase
        //GBE_IPTX_DATA:      iptx_data               <=  #U_DLY lbus_wdata;
        //GBE_IPTX_PKTLEN:    iptx_pktlen             <=  #U_DLY lbus_wdata;
    end
end

////////////////////////////////////////////////////////////////////
//clock domain sync(local_ip and local_mac)
////////////////////////////////////////////////////////////////////
always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        local_ip_addr_1syn  <=  {32{1'b1}};
        local_ip            <=  {32{1'b1}};
    end
    else
    begin
        local_ip_addr_1syn  <=  #U_DLY local_ip_addr;
        local_ip            <=  #U_DLY local_ip_addr_1syn;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        local_ip_addr2_1syn <=  {32{1'b1}};
        local_ip2           <=  {32{1'b1}};
    end
    else
    begin
        local_ip_addr2_1syn <=  #U_DLY local_ip_addr2;
        local_ip2           <=  #U_DLY local_ip_addr2_1syn;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        local_mac_addr_1syn <=  {48{1'b0}};
        local_mac           <=  {48{1'b0}};
    end
    else
    begin
        local_mac_addr_1syn <=  #U_DLY local_mac_addr;
        local_mac           <=  #U_DLY local_mac_addr_1syn;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        mac_filter_ena      <=  1'b0;
        mac_filter_ena_1syn <=  1'b0;
    end
    else
    begin
        mac_filter_ena_1syn <=  #U_DLY mac_filter_ena_reg;
        mac_filter_ena      <=  #U_DLY mac_filter_ena_1syn;
    end
end

//------------------------------------------------------------------
//clock domain sync:xxx---->clk_cfg
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        phy_link_status_1syn    <=  2'b00;
        phy_link_status_2syn    <=  2'b00;
    end
    else
    begin
        phy_link_status_1syn    <=  #U_DLY phy_link_status;
        phy_link_status_2syn    <=  #U_DLY phy_link_status_1syn;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        gbe_rx_pkt_cnt_1syn     <=  {32{1'b0}};
        gbe_rx_pkt_cnt_2syn     <=  {32{1'b0}};
    end
    else
    begin
        gbe_rx_pkt_cnt_1syn     <=  #U_DLY gbe_rx_pkt_cnt;
        gbe_rx_pkt_cnt_2syn     <=  #U_DLY gbe_rx_pkt_cnt_1syn;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        gbe_rx_byte_cnt_1syn    <=  {32{1'b0}};
        gbe_rx_byte_cnt_2syn    <=  {32{1'b0}};
    end
    else
    begin
        gbe_rx_byte_cnt_1syn    <=  #U_DLY gbe_rx_byte_cnt;
        gbe_rx_byte_cnt_2syn    <=  #U_DLY gbe_rx_byte_cnt_1syn;
    end
end
//------------------------------------------------------------------

//local bus read
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_rdata      <=  16'h0000;
    end
    else if(info_fifo_ipmatch_rden_2dly==1'b1)
    begin
        lbus_rdata  <=  #U_DLY {4'h0,ipmatch_pkt_len[11:0]};
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_oe_n==1'b1))
    begin
        case(lbus_addr)
        GBE_CONN_SET:       lbus_rdata  <=  #U_DLY {{14{1'b0}},phy_switch[1:0]};  
        GBE_LINK_STATUS:    lbus_rdata  <=  #U_DLY {{14{1'b0}},phy_link_status_2syn[1:0]};
        GBE_PKTCNT_L:       lbus_rdata  <=  #U_DLY gbe_rx_pkt_cnt_2syn[15:0];
        GBE_PKTCNT_H:       lbus_rdata  <=  #U_DLY gbe_rx_pkt_cnt_2syn[31:16];
        GBE_BYTECNT_L:      lbus_rdata  <=  #U_DLY gbe_rx_byte_cnt_2syn[15:0];
        GBE_BYTECNT_H:      lbus_rdata  <=  #U_DLY gbe_rx_byte_cnt_2syn[31:16];
        ADDR_IPMATCH_PKTCNT:lbus_rdata  <=  #U_DLY {{10{1'b0}},ipmatch_pkt_cnt[5:0]};
        GBE_IPRX_DATA:      lbus_rdata  <=  #U_DLY datram_ipmatch_rdat;
        //GBE_IPRX_PKTLEN:
        GBE_IP_ADDR_L:      lbus_rdata  <=  #U_DLY local_ip_addr[15:0];
        GBE_IP_ADDR_H:      lbus_rdata  <=  #U_DLY local_ip_addr[31:16];
        GBE_MAC_ADDR_L:     lbus_rdata  <=  #U_DLY local_mac_addr[15:0];
        GBE_MAC_ADDR_M:     lbus_rdata  <=  #U_DLY local_mac_addr[31:16];
        GBE_MAC_ADDR_H:     lbus_rdata  <=  #U_DLY local_mac_addr[47:32];
        GBE_PHY_POWER_DOWN: lbus_rdata  <=  #U_DLY {{15{1'b0}},phy_powerdown};      
        GBE_IP_ADDR2_L:     lbus_rdata  <=  #U_DLY local_ip_addr2[15:0];
        GBE_IP_ADDR2_H:     lbus_rdata  <=  #U_DLY local_ip_addr2[31:16];
        default:;
        endcase
    end
end

//------------------------------------------------------------------
//iprx
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        info_fifo_ipmatch_rden  <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_oe_n==1'b1) &&(lbus_addr==GBE_IPRX_PKTLEN))
    begin
        info_fifo_ipmatch_rden  <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_ipmatch_rden  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        info_fifo_ipmatch_rden_1dly <=  1'b0;
        info_fifo_ipmatch_rden_2dly <=  1'b0;
    end
    else
    begin
        info_fifo_ipmatch_rden_1dly <=  #U_DLY info_fifo_ipmatch_rden;
        info_fifo_ipmatch_rden_2dly <=  #U_DLY info_fifo_ipmatch_rden_1dly;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        datram_ipmatch_raddr    <=  {RAM_IPMATCH_DEPTH_BIT{1'b0}};
    end
    else if(info_fifo_ipmatch_rden_2dly==1'b1)
    begin
        datram_ipmatch_raddr    <=  #U_DLY ipmatch_start_addr;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_oe_n==1'b1) && (lbus_addr==GBE_IPRX_DATA))
    begin
		datram_ipmatch_raddr    <=  #U_DLY datram_ipmatch_raddr + 'h1;
	end
end
    
//------------------------------------------------------------------
//udp filter table
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        udp_table_wren  <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_UDPFILTER_SET))
    begin
        udp_table_wren  <=  #U_DLY 1'b1;
    end
    else
    begin
        udp_table_wren  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        is_searching_1syn   <=  1'b0;
        is_searching_2syn   <=  1'b0;
    end
    else
    begin
        is_searching_1syn   <=  #U_DLY udp_table_is_searching;
        is_searching_2syn   <=  #U_DLY is_searching_1syn;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        udp_table_switch    <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_UDPFILTER_CTRL))
    begin
        udp_table_switch    <=  #U_DLY 1'b1;
    end
    else if(is_searching_2syn==1'b0)
    begin
        udp_table_switch    <=  #U_DLY 1'b0;
    end
end

//------------------------------------------------------------------
//iptx ram
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ram_iptx_wren   <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_IPTX_DATA))
    begin
        ram_iptx_wren   <=  #U_DLY 1'b1;
    end
    else
    begin
        ram_iptx_wren   <=  #U_DLY 1'b0;
    end
end
    
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ram_iptx_waddr  <=  {RAM_IPTX_DEPTH_BIT{1'b0}};
    end
    else if(ram_iptx_wren==1'b1)
    begin
        ram_iptx_waddr  <=  #U_DLY ram_iptx_waddr + 11'h1;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ram_iptx_wdat   <=  {RAM_IPTX_WIDTH{1'b0}};
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_IPTX_DATA))
    begin
        ram_iptx_wdat   <=  #U_DLY lbus_wdata;
    end
    else
    begin
        ram_iptx_wdat   <=  {RAM_IPTX_WIDTH{1'b0}};
    end
end

//iptx infor fifo
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        info_fifo_iptx_wren <=  1'b0;
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_IPTX_PKTLEN))
    begin
        info_fifo_iptx_wren <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_iptx_wren <=  #U_DLY 1'b0;
    end
end

//pkt_len(12bit)+start_addr(11bit)
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        info_fifo_iptx_wdat <=  {INFO_FIFO_IPTX_WIDTH{1'b0}};
    end
    else if((lbus_cs_n==1'b0) && (negedge_lbus_we_n==1'b1) && (lbus_addr==GBE_IPTX_PKTLEN))
    begin
        info_fifo_iptx_wdat <=  #U_DLY {lbus_wdata[11:0],iptx_start_addr[RAM_IPTX_DEPTH_BIT - 1 : 0]};
    end
    else
    begin
        info_fifo_iptx_wdat <=  #U_DLY {INFO_FIFO_IPTX_WIDTH{1'b0}};
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        iptx_start_addr <=  {RAM_IPTX_DEPTH_BIT{1'b0}};
    end
    else if(info_fifo_iptx_wren==1'b1)
    begin
        iptx_start_addr <=  #U_DLY ram_iptx_waddr;
    end
end

//------------------------------------------------------------------
//iptx ram read
always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        st_iptx_curr    <=  ST_IPTX_IDLE;
    end
    else
    begin
        st_iptx_curr    <=  #U_DLY st_iptx_next;
    end
end

always@*
begin
    case(st_iptx_curr)
    ST_IPTX_IDLE:
    begin
        if(|info_fifo_iptx_rdusedw==1'b0)
        begin
            st_iptx_next    =   ST_IPTX_IDLE;
        end
        else if(mac_tx_ready==1'b1)
        begin
            st_iptx_next    =   ST_IPTX_RDEN;
        end
        else
        begin
            st_iptx_next    =   ST_IPTX_IDLE;
        end
    end
    ST_IPTX_RDEN:
    begin
        st_iptx_next    =   ST_IPTX_WAIT;
    end
    ST_IPTX_WAIT:
    begin
        st_iptx_next    =   ST_IPTX_RD_INFO;
    end
    ST_IPTX_RD_INFO:
    begin
        st_iptx_next    =   ST_IPTX_RD_DATA;
    end
    ST_IPTX_RD_DATA:
    begin
        if(byte_cnt==mac_tx_pktlen)
        begin
            st_iptx_next    =   ST_IPTX_RD_END;
        end
        else
        begin
            st_iptx_next    =   ST_IPTX_RD_DATA;
        end
    end
    ST_IPTX_RD_END:
    begin
        st_iptx_next    =   ST_IPTX_IDLE;
    end
    default:
    begin
        st_iptx_next    =   ST_IPTX_IDLE;
    end
    endcase
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        byte_cnt    <=  12'h000;
    end
    else if(st_iptx_curr==ST_IPTX_RD_DATA)
    begin
        byte_cnt    <=  #U_DLY byte_cnt + 12'h1;
    end
    else
    begin
        byte_cnt    <=  #U_DLY 12'h000;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        info_fifo_iptx_rden <=  1'b0;
    end
    else if(st_iptx_curr==ST_IPTX_RDEN)
    begin
        info_fifo_iptx_rden <=  #U_DLY 1'b1;
    end
    else
    begin
        info_fifo_iptx_rden <=  #U_DLY 1'b0;
    end
end

assign  mac_tx_start_addr   =   info_fifo_iptx_rdat[10:0];
assign  mac_tx_pktlen       =   info_fifo_iptx_rdat[22:11];

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        ram_iptx_raddr  <=  {RAM_IPTX_DEPTH_BIT{1'b0}};
    end
    else if(st_iptx_curr==ST_IPTX_RD_INFO)
    begin
        ram_iptx_raddr  <=  #U_DLY mac_tx_start_addr;
    end
    else if((byte_cnt[0]==1'b1) && (st_iptx_curr==ST_IPTX_RD_DATA))
    begin
        ram_iptx_raddr  <=  #U_DLY ram_iptx_raddr + 11'h1;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        mac_tx_valid    <=  1'b0;
    end
    else if((st_iptx_curr==ST_IPTX_RD_DATA) && (byte_cnt>0))
    begin
        mac_tx_valid    <=  #U_DLY 1'b1;
    end
    else
    begin
        mac_tx_valid    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        mac_tx_data <=  8'h00;
    end
    else if(byte_cnt[0]==1'b1)
    begin
        mac_tx_data <=  #U_DLY ram_iptx_rdat[15:8];
    end
    else
    begin
        mac_tx_data <=  #U_DLY ram_iptx_rdat[7:0];
    end
end

always@(posedge clk_tx or posedge rst_tx)
begin
    if(rst_tx==1'b1)
    begin
        mac_tx_last <=  1'b0;
    end
    else if((byte_cnt==mac_tx_pktlen) && (st_iptx_curr==ST_IPTX_RD_DATA))
    begin
        mac_tx_last <=  #U_DLY 1'b1;
    end
    else
    begin
        mac_tx_last <=  #U_DLY 1'b0;
    end
end

//------------------------------------------------------------------
//sfp main control
//------------------------------------------------------------------
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_main_add_in_1dly    <=  1'b1;
        sfp_main_add_in_2dly    <=  1'b1;
        sfp_main_add_in_3dly    <=  1'b1;
    end
    else
    begin
        sfp_main_add_in_1dly    <=  #U_DLY sfp_main_add_in;
        sfp_main_add_in_2dly    <=  #U_DLY sfp_main_add_in_1dly;
        sfp_main_add_in_3dly    <=  #U_DLY sfp_main_add_in_2dly;
    end
end

assign  negedge_sfp_main_add_in =   (~sfp_main_add_in_2dly) & sfp_main_add_in_3dly;

//disable 10ms
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_main_tx_dis_cnt     <=  {20{1'b0}};
    end
    else if(sfp_main_tx_dis_cnt>=1000000)
    begin
        sfp_main_tx_dis_cnt     <=  #U_DLY 1000000;
    end
    else if(negedge_sfp_main_add_in==1'b1)
    begin
        sfp_main_tx_dis_cnt     <=  #U_DLY {{19{1'b0}},1'b1};
    end
    else if(sfp_main_tx_dis_cnt>0)
    begin
        sfp_main_tx_dis_cnt     <=  #U_DLY sfp_main_tx_dis_cnt + {{19{1'b0}},1'b1};
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_main_tx_disable <=  1'b0;
    end
    else if(((sfp_main_tx_dis_cnt>0) && (sfp_main_tx_dis_cnt<1000000)) || (phy_powerdown==1'b1))
    begin
        sfp_main_tx_disable <=  #U_DLY 1'b1;
    end
    else
    begin
        sfp_main_tx_disable <=  #U_DLY 1'b0;
    end
end

//------------------------------------------------------------------
//sfp backup control
//------------------------------------------------------------------
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_backup_add_in_1dly    <=  1'b1;
        sfp_backup_add_in_2dly    <=  1'b1;
        sfp_backup_add_in_3dly    <=  1'b1;
    end
    else
    begin
        sfp_backup_add_in_1dly    <=  #U_DLY sfp_backup_add_in;
        sfp_backup_add_in_2dly    <=  #U_DLY sfp_backup_add_in_1dly;
        sfp_backup_add_in_3dly    <=  #U_DLY sfp_backup_add_in_2dly;
    end
end

assign  negedge_sfp_backup_add_in =   (~sfp_backup_add_in_2dly) & sfp_backup_add_in_3dly;

//disable 10ms
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_backup_tx_dis_cnt     <=  {20{1'b0}};
    end
    else if(sfp_backup_tx_dis_cnt>=1000000)
    begin
        sfp_backup_tx_dis_cnt     <=  #U_DLY 1000000;
    end
    else if(negedge_sfp_backup_add_in==1'b1)
    begin
        sfp_backup_tx_dis_cnt     <=  #U_DLY {{19{1'b0}},1'b1};
    end
    else if(sfp_backup_tx_dis_cnt>0)
    begin
        sfp_backup_tx_dis_cnt     <=  #U_DLY sfp_backup_tx_dis_cnt + {{19{1'b0}},1'b1};
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sfp_backup_tx_disable   <=  1'b0;
    end
    else if(((sfp_backup_tx_dis_cnt>0) && (sfp_backup_tx_dis_cnt<1000000)) || (phy_powerdown==1'b1))
    begin
        sfp_backup_tx_disable   <=  #U_DLY 1'b1;
    end
    else
    begin
        sfp_backup_tx_disable   <=  #U_DLY 1'b0;
    end
end
                
iptx_datram u0_iptx_datram(
    .clka                               ( clk_cfg                   ),
    .wea                                ( ram_iptx_wren             ),
    .addra                              ( ram_iptx_waddr            ),
    .dina                               ( ram_iptx_wdat             ),
    .clkb                               ( clk_tx                    ),
    .addrb                              ( ram_iptx_raddr            ),
    .doutb                              ( ram_iptx_rdat             )
    );

iptx_info_fifo u0_iptx_info_fifo(
    .rst                                ( rst_iptx_info_fifo        ),
    .wr_clk                             ( clk_cfg                   ),
    .rd_clk                             ( clk_tx                    ),
    .din                                ( info_fifo_iptx_wdat       ),
    .wr_en                              ( info_fifo_iptx_wren       ),
    .rd_en                              ( info_fifo_iptx_rden       ),
    .dout                               ( info_fifo_iptx_rdat       ),
    .full                               ( info_fifo_iptx_full       ),
    .almost_full                        ( info_fifo_iptx_afull      ),
    .empty                              ( info_fifo_iptx_empty      ),
    .almost_empty                       ( info_fifo_iptx_aempty     ),
    .rd_data_count                      ( info_fifo_iptx_rdusedw    )
    );

endmodule
