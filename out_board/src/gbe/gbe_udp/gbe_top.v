/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_top.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_top.v
    File tree    :   gbe_top.v
\************************************************************************************/

`timescale 1ns/100ps

module gbe_top(
    glbl_rst                    ,
    //clk & rst
    clk_in                      ,
    phy_resetn                  ,
    rst_cfg                     ,
    clk_cfg                     ,
    rst_rx                      ,
    clk_rx                      ,
    //phy_main
    phy_main_rgmii_txd          ,
    phy_main_rgmii_tx_ctl       ,
    phy_main_rgmii_txc          ,
    phy_main_rgmii_rxd          ,
    phy_main_rgmii_rx_ctl       ,
    phy_main_rgmii_rxc          ,
    phy_main_mdio               ,
    phy_main_mdc                ,
    //0:link up;1:link down
    phy_main_link               ,
    //phy_backup
    phy_backup_rgmii_txd        ,
    phy_backup_rgmii_tx_ctl     ,
    phy_backup_rgmii_txc        ,
    phy_backup_rgmii_rxd        ,
    phy_backup_rgmii_rx_ctl     ,
    phy_backup_rgmii_rxc        ,
    phy_backup_mdio             ,
    phy_backup_mdc              ,
    //0:link up;1:link down
    phy_backup_link             ,
    //sfp add-in:"0" add-in;"1" not-in
    sfp_main_add_in             ,
    sfp_backup_add_in           ,
    //sfp tx disable
    sfp_main_tx_disable         ,
    sfp_backup_tx_disable       ,
    //udp rx
    udp_rx_valid                ,
    udp_rx_sop                  ,
    udp_rx_eop                  ,
    udp_rx_data                 ,
    udp_rx_mod                  ,
    udp_rx_pkt_len              ,
    udp_rx_port_index           ,    
    //local bus
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_rdata                  ,
    lbus_cs_n                   ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    int_ipmatch                 ,
    lbus_wait_n                 ,
    
    s_axi_aclk                  ,
    s_axi_resetn                ,
    mboard_test                 ,
    phy_switch
    );
parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   U_DLY                       = 1                         ;
parameter   UDP_TABLE_WIDTH             = 64                        ;
parameter   UDP_TABLE_DEPTH_BIT         = 9                         ;
parameter   DATA_WIDTH                  = 32                        ;
parameter   RAM_IPMATCH_DATA_WIDTH      = 16                        ;
parameter   RAM_UDPMATCH_DEPTH_BIT      = 10                        ;
parameter   RAM_IPMATCH_DEPTH_BIT       = 11                        ;
parameter   FIFO_UDPMATCH_WIDTH         = 38                        ;
parameter   FIFO_UDPMATCH_DEPTH_BIT     = 6                         ;
parameter   FIFO_IPMATCH_WIDTH          = 23                        ;
parameter   FIFO_IPMATCH_DEPTH_BIT      = 6                         ;

input                                   glbl_rst                    ;
//clk & rst
input                                   clk_in                      ;
output                                  phy_resetn                  ;

input                                   rst_cfg                     ;
input                                   clk_cfg                     ;

output                                  rst_rx                      ;
output                                  clk_rx                      ;
//phy main
output  [3:0]                           phy_main_rgmii_txd          ;
output                                  phy_main_rgmii_tx_ctl       ;
output                                  phy_main_rgmii_txc          ;
input   [3:0]                           phy_main_rgmii_rxd          ;
input                                   phy_main_rgmii_rx_ctl       ;
input                                   phy_main_rgmii_rxc          ;
inout                                   phy_main_mdio               ;
output                                  phy_main_mdc                ;
input                                   phy_main_link               ;
//phy backup
output  [3:0]                           phy_backup_rgmii_txd        ;
output                                  phy_backup_rgmii_tx_ctl     ;
output                                  phy_backup_rgmii_txc        ;
input   [3:0]                           phy_backup_rgmii_rxd        ;
input                                   phy_backup_rgmii_rx_ctl     ;
input                                   phy_backup_rgmii_rxc        ;
inout                                   phy_backup_mdio             ;
output                                  phy_backup_mdc              ;
input                                   phy_backup_link             ;
//sfp add-in:"0" add-in;"1" not-in
input                                   sfp_main_add_in             ;
input                                   sfp_backup_add_in           ;
//sfp tx disable
output                                  sfp_main_tx_disable         ;
output                                  sfp_backup_tx_disable       ;
//udp rx
output                                  udp_rx_valid                ;
output                                  udp_rx_sop                  ;
output                                  udp_rx_eop                  ;
output  [DATA_WIDTH - 1 : 0]            udp_rx_data                 ;
output  [1:0]                           udp_rx_mod                  ;
output  [11:0]                          udp_rx_pkt_len              ;
output  [15:0]                          udp_rx_port_index           ;
//local bus
input   [P_BUS_ADDR_WIDTH-1:0]          lbus_addr                   ;
input   [P_BUS_DATA_WIDTH-1:0]          lbus_wdata                  ;
output  [P_BUS_DATA_WIDTH-1:0]          lbus_rdata                  ;
input                                   lbus_cs_n                   ;
input                                   lbus_oe_n                   ;
input                                   lbus_we_n                   ;
output                                  lbus_wait_n                 ;
output                                  int_ipmatch                 ;

output                                  s_axi_aclk                  ;
output                                  s_axi_resetn                ;
output  [1:0]                           mboard_test                 ;
output  [1:0]                           phy_switch                  ;

wire    [1:0]                           phy_switch                  ;
wire    [1:0]                           phy_link_status             ;
wire                                    mdio_cfg_finished           ;
wire                                    mdio_init_switch_flag       ;

wire    [7:0]                           mac_o_data                  ;
wire                                    mac_o_valid                 ;
wire                                    mac_o_ready                 ;
wire                                    mac_o_last                  ;

wire    [7:0]                           mac_i_data                  ;
wire                                    mac_i_valid                 ;
wire                                    mac_i_ready                 ;
wire                                    mac_i_last                  ; 

wire                                    mac_rx_sop                  ;   
wire                                    mac_rx_eop                  ;
wire                                    mac_rx_valid                ;
wire    [1:0]                           mac_rx_mod                  ; 
wire    [31:0]                          mac_rx_data                 ; 
wire    [11:0]                          mac_rx_frmlen               ;

wire                                    udp_table_is_searching      ;
wire    [UDP_TABLE_DEPTH_BIT - 1 : 0]   udp_table_raddr             ;
wire    [UDP_TABLE_WIDTH - 1 : 0]       udp_table_rdat              ;
wire                                    udp_table_wren              ;
wire    [UDP_TABLE_DEPTH_BIT - 1 : 0]   udp_table_waddr             ;
wire    [UDP_TABLE_WIDTH - 1 : 0]       udp_table_wdat              ;
wire                                    udp_table_switch            ;

wire    [31:0]                          local_ip                    ;
wire    [31:0]                          local_ip2                   ;
wire    [47:0]                          local_mac                   ;
wire    [31:0]                          filter_ip_addr1             ;
wire    [31:0]                          filter_ip_addr2             ;
wire    [31:0]                          filter_ip_addr3             ;
wire    [31:0]                          filter_ip_addr4             ;
wire    [31:0]                          filter_ip_addr5             ;
wire    [31:0]                          filter_ip_addr6             ;
wire    [31:0]                          filter_ip_addr7             ;
wire    [31:0]                          filter_ip_addr8             ;
wire    [1:0]                           filter_pkt_type_out         ;
wire    [15:0]                          udp_filter_index            ;

wire                                    datram_udpmatch_wren        ;
wire    [DATA_WIDTH - 1 : 0]            datram_udpmatch_wdat        ;
wire    [RAM_UDPMATCH_DEPTH_BIT - 1:0]  datram_udpmatch_waddr       ;
wire                                    info_fifo_udpmatch_wren     ;
wire    [FIFO_UDPMATCH_WIDTH - 1 : 0]   info_fifo_udpmatch_wdat     ;

wire                                    datram_ipmatch_wren         ;
wire    [RAM_IPMATCH_DATA_WIDTH-1:0]    datram_ipmatch_wdat         ;
wire    [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_waddr        ;
wire                                    info_fifo_ipmatch_wren      ;
wire    [FIFO_IPMATCH_WIDTH - 1 : 0]    info_fifo_ipmatch_wdat      ;
wire                                    info_fifo_ipmatch_afull     ;

wire                                    udp_rx_valid                ;
wire                                    udp_rx_sop                  ;
wire                                    udp_rx_eop                  ;
wire    [DATA_WIDTH - 1 : 0]            udp_rx_data                 ;
wire    [1:0]                           udp_rx_mod                  ;
wire    [11:0]                          udp_rx_pkt_len              ;
wire    [15:0]                          udp_rx_port_index           ;

wire                                    int_ipmatch                 ;
wire                                    info_fifo_ipmatch_rden      ;
wire    [FIFO_IPMATCH_DEPTH_BIT-1:0]    ipmatch_pkt_cnt             ;
wire    [11:0]                          ipmatch_pkt_len             ;
wire    [RAM_IPMATCH_DEPTH_BIT-1:0]     ipmatch_start_addr          ;
wire    [RAM_IPMATCH_DEPTH_BIT - 1:0]   datram_ipmatch_raddr        ;
wire    [RAM_IPMATCH_DATA_WIDTH-1:0]    datram_ipmatch_rdat         ;

wire    [31:0]                          gbe_rx_pkt_cnt              ;
wire    [31:0]                          gbe_rx_byte_cnt             ;

wire                                    mdio_i                      ;
wire                                    mdio_o                      ;
wire                                    mdio_t                      ;
wire                                    mdc_i                       ;
wire                                    lbus_wait_n                 ;
wire                                    phy_resetn                  ;
wire                                    clk_rx                      ;
wire                                    clk_tx                      ;
wire                                    rst_tx                      ;

wire    [7:0]                           txd_from_mac                ;
wire                                    tx_en_from_mac              ;
wire                                    tx_er_from_mac              ;
wire                                    tx_clk                      ;
wire                                    tx_clk90                    ;
wire                                    tx_reset                    ;

wire                                    rx_reset                    ;
wire    [7:0]                           rxd_to_mac                  ;
wire                                    rx_dv_to_mac                ;
wire                                    rx_er_to_mac                ;

(* keep = "TRUE" *)
wire                                    rx_clk                      ;

wire                                    s_axi_aclk                  ;
wire                                    s_axi_resetn                ;

wire    [7:0]                           phy_addr                    ;
wire                                    mac_filter_ena              ;

assign  phy_link_status =   ~{phy_backup_link,phy_main_link};
assign  mboard_test     =   {mac_i_last,mac_o_last};
    
gbe_phy_mux u0_gbe_phy_mux(
    .rst                                ( ~s_axi_resetn             ),
    .clk                                ( s_axi_aclk                ),
    .rx_reset                           ( rx_reset                  ),
    //tx from mac
    .txd_from_mac                       ( txd_from_mac              ),
    .tx_en_from_mac                     ( tx_en_from_mac            ),
    .tx_er_from_mac                     ( tx_er_from_mac            ),
    .tx_clk                             ( tx_clk                    ),
    .tx_clk90                           ( tx_clk90                  ),
    .tx_reset                           ( tx_reset                  ),
    //rx to mac
    .rxd_to_mac                         ( rxd_to_mac                ),
    .rx_dv_to_mac                       ( rx_dv_to_mac              ),
    .rx_er_to_mac                       ( rx_er_to_mac              ),
    .rx_clk                             ( rx_clk                    ),
    //phy_main
    .phy_main_rgmii_txd                 ( phy_main_rgmii_txd        ),
    .phy_main_rgmii_tx_ctl              ( phy_main_rgmii_tx_ctl     ),
    .phy_main_rgmii_txc                 ( phy_main_rgmii_txc        ),
    .phy_main_rgmii_rxd                 ( phy_main_rgmii_rxd        ),
    .phy_main_rgmii_rx_ctl              ( phy_main_rgmii_rx_ctl     ),
    .phy_main_rgmii_rxc                 ( phy_main_rgmii_rxc        ),
    .phy_main_mdio                      ( phy_main_mdio             ),
    .phy_main_mdc                       ( phy_main_mdc              ),
    //phy_backup
    .phy_backup_rgmii_txd               ( phy_backup_rgmii_txd      ),
    .phy_backup_rgmii_tx_ctl            ( phy_backup_rgmii_tx_ctl   ),
    .phy_backup_rgmii_txc               ( phy_backup_rgmii_txc      ),
    .phy_backup_rgmii_rxd               ( phy_backup_rgmii_rxd      ),
    .phy_backup_rgmii_rx_ctl            ( phy_backup_rgmii_rx_ctl   ),
    .phy_backup_rgmii_rxc               ( phy_backup_rgmii_rxc      ),
    .phy_backup_mdio                    ( phy_backup_mdio           ),
    .phy_backup_mdc                     ( phy_backup_mdc            ),
    //mdio
    .mdc_i                              ( mdc_i                     ),
    .mdio_i                             ( mdio_i                    ),
    .mdio_o                             ( mdio_o                    ),
    .mdio_t                             ( mdio_t                    ),
    //main backup phy switch
    .phy_switch                         ( phy_switch                ),
    .phy_addr                           ( phy_addr                  ),
    .mdio_cfg_finished                  ( mdio_cfg_finished         ),
    .mdio_init_switch_flag              ( mdio_init_switch_flag     )
    );

triple_mac_example_design u0_gbe_mac(
     // asynchronous reset
    .glbl_rst                           ( glbl_rst                  ),
    .clk_in                             ( clk_in                    ),
    .phy_addr                           ( phy_addr                  ),
    .phy_resetn                         ( phy_resetn                ),

    //mdio
    .mdc_i                              ( mdc_i                     ),
    .mdio_i                             ( mdio_i                    ),
    .mdio_o                             ( mdio_o                    ),
    .mdio_t                             ( mdio_t                    ),
    
    //other
    .tx_statistics_s                    ( /*not used*/              ),
    .rx_statistics_s                    ( /*not used*/              ),
    .pause_req_s                        ( 1'b0                      ),
    .mac_speed                          ( 2'b10                     ),
    .update_speed                       ( 1'b0                      ),
    .config_board                       ( 1'b1                      ),
    .serial_response                    ( /*not used*/              ),
    .reset_error                        ( 1'b0                      ),
    .mac_loop_cfg                       ( 2'b00                     ),  //2'b10:tx=rx;2'b11:tx=gen;2'b00,2'b01:tx=tx
    .chk_tx_data                        ( 1'b0                      ),
    .frame_error                        ( /*not used*/              ),
    .frame_errorn                       ( /*not used*/              ),
    .activity_flash                     ( /*not used*/              ),
    .activity_flashn                    ( /*not used*/              ),
    .mdio_cfg_finished                  ( mdio_cfg_finished         ),
    .mdio_init_switch_flag              ( mdio_init_switch_flag     ),
    
    //MAC Transmitter
    .mac_tx_data                        ( mac_o_data                ),
    .mac_tx_valid                       ( mac_o_valid               ),
    .mac_tx_ready                       ( mac_o_ready               ),
    .mac_tx_last                        ( mac_o_last                ),    
    //MAC Receiver
    .mac_rx_data                        ( mac_i_data                ),
    .mac_rx_valid                       ( mac_i_valid               ),
    .mac_rx_ready                       ( mac_i_ready               ),
    .mac_rx_last                        ( mac_i_last                ),
    
    //output
    .clk_rx                             ( clk_rx                    ),
    .rst_rx                             ( rst_rx                    ),
    .clk_tx                             ( clk_tx                    ),
    .rst_tx                             ( rst_tx                    ),
    
    .txd_from_mac                       ( txd_from_mac              ),  
    .tx_en_from_mac                     ( tx_en_from_mac            ),
    .tx_er_from_mac                     ( tx_er_from_mac            ),
    .tx_clk                             ( tx_clk                    ),        
    .tx_clk90                           ( tx_clk90                  ),      
    .tx_reset                           ( tx_reset                  ),
    
    .rx_reset                           ( rx_reset                  ),
    .rxd_to_mac                         ( rxd_to_mac                ),
    .rx_dv_to_mac                       ( rx_dv_to_mac              ),
    .rx_er_to_mac                       ( rx_er_to_mac              ),
    .rx_clk                             ( rx_clk                    ),
    
    .s_axi_aclk                         ( s_axi_aclk                ),
    .s_axi_resetn                       ( s_axi_resetn              ),
    .unicast_addr                       ( local_mac                 ),
    .mac_filter_ena                     ( mac_filter_ena            )
    );

mac_rx_bit8to32 #(
    .U_DLY                              ( U_DLY                     )
    )
u0_mac_rx_bit8to32(
    .rst                                ( rst_rx                    ),
    .clk                                ( clk_rx                    ),
    //input                             
    .mac_i_data                         ( mac_i_data                ),
    .mac_i_valid                        ( mac_i_valid               ),
    .mac_i_last                         ( mac_i_last                ),
    .mac_i_ready                        ( mac_i_ready               ),
    //output                            
    .mac_rx_sop                         ( mac_rx_sop                ),
    .mac_rx_eop                         ( mac_rx_eop                ),
    .mac_rx_valid                       ( mac_rx_valid              ),
    .mac_rx_mod                         ( mac_rx_mod                ),
    .mac_rx_data                        ( mac_rx_data               ),
    .mac_rx_frmlen                      ( mac_rx_frmlen             )
    );

udp_table_manager #(
    .U_DLY                              ( U_DLY                     ),
    .UDP_TABLE_DEPTH_BIT                ( UDP_TABLE_DEPTH_BIT       ),
    .UDP_TABLE_WIDTH                    ( UDP_TABLE_WIDTH           )
	)
u0_udp_table_manager(
    .clk_wr                             ( clk_cfg                   ),
    .clk_rd                             ( clk_rx                    ),
    .rst_wr                             ( rst_cfg                   ),
    .rst_rd                             ( rst_rx                    ),
    
    .wr_en                              ( udp_table_wren            ),
    .wr_addr                            ( udp_table_waddr           ),
    .wr_data                            ( udp_table_wdat            ),
    
    .rd_addr                            ( udp_table_raddr           ),
    .rd_data                            ( udp_table_rdat            ),
    
    .table_switch                       ( udp_table_switch          )   //keep '1' until is_searching=0
    );
        
gbe_rx_filter #(
    .U_DLY                              ( U_DLY                     )
    )
u0_gbe_rx_filter(
    .rst                                ( rst_rx                    ),
    .clk                                ( clk_rx                    ),
    //input
    .mac_i_data                         ( mac_i_data                ),
    .mac_i_valid                        ( mac_i_valid               ),
    .mac_i_last                         ( mac_i_last                ),
    
    //udp filter table
    .is_searching                       ( udp_table_is_searching    ),
    .table_rd_addr                      ( udp_table_raddr           ),
    .table_rd_data                      ( udp_table_rdat            ),
    
    //filter ipaddr
    .local_ip                           ( local_ip                  ),
    .local_ip2                          ( local_ip2                 ),
    .filter_ip_addr1                    ( filter_ip_addr1           ),
    .filter_ip_addr2                    ( filter_ip_addr2           ), 
    .filter_ip_addr3                    ( filter_ip_addr3           ),
    .filter_ip_addr4                    ( filter_ip_addr4           ),
    .filter_ip_addr5                    ( filter_ip_addr5           ),
    .filter_ip_addr6                    ( filter_ip_addr6           ), 
    .filter_ip_addr7                    ( filter_ip_addr7           ),
    .filter_ip_addr8                    ( filter_ip_addr8           ),
    
    //2'b01:ip_port_match;2'b10:ip_addr_filter_match;2'b11:checksum_err;2'b00:other;
    .pkt_type                           ( filter_pkt_type_out       ),
    .udp_filter_index                   ( udp_filter_index          ),
    
    .gbe_rx_pkt_cnt                     ( gbe_rx_pkt_cnt            ),
    .gbe_rx_byte_cnt                    ( gbe_rx_byte_cnt           )                
    ); 
    
gbe_rx_frmbuf #(
    .U_DLY                              ( U_DLY                     ),
    .DATA_WIDTH                         ( DATA_WIDTH                ),
    .RAM_IPMATCH_DATA_WIDTH             ( RAM_IPMATCH_DATA_WIDTH    ),
    .RAM_UDPMATCH_DEPTH_BIT             ( RAM_UDPMATCH_DEPTH_BIT    ),
    .RAM_IPMATCH_DEPTH_BIT              ( RAM_IPMATCH_DEPTH_BIT     ),
    .FIFO_UDPMATCH_WIDTH                ( FIFO_UDPMATCH_WIDTH       ),
    .FIFO_UDPMATCH_DEPTH_BIT            ( FIFO_UDPMATCH_DEPTH_BIT   ),
    .FIFO_IPMATCH_WIDTH                 ( FIFO_IPMATCH_WIDTH        ),
    .FIFO_IPMATCH_DEPTH_BIT             ( FIFO_IPMATCH_DEPTH_BIT    )
    )    
u0_gbe_rx_frmbuf(
    .rst                                ( rst_rx                    ),
    .clk                                ( clk_rx                    ),
    //input
    .mac_rx_sop                         ( mac_rx_sop                ),
    .mac_rx_eop                         ( mac_rx_eop                ),
    .mac_rx_valid                       ( mac_rx_valid              ),
    .mac_rx_mod                         ( mac_rx_mod                ),
    .mac_rx_data                        ( mac_rx_data               ),
    .mac_rx_frmlen                      ( mac_rx_frmlen             ),         
    .pkt_type                           ( filter_pkt_type_out       ),
    .udp_filter_index                   ( udp_filter_index          ),
    //udp match datram
    .datram_udpmatch_wren               ( datram_udpmatch_wren      ),
    .datram_udpmatch_wdat               ( datram_udpmatch_wdat      ),
    .datram_udpmatch_waddr              ( datram_udpmatch_waddr     ),
    //udp match infor fifo,dst_port(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
    .info_fifo_udpmatch_wren            ( info_fifo_udpmatch_wren   ),
    .info_fifo_udpmatch_wdat            ( info_fifo_udpmatch_wdat   ),
    //ip match datram
    .datram_ipmatch_wren                ( datram_ipmatch_wren       ),
    .datram_ipmatch_wdat                ( datram_ipmatch_wdat       ),
    .datram_ipmatch_waddr               ( datram_ipmatch_waddr      ),
    //ip match infor fifo,frm_len(12bit)+start_addr(11bit)
    .info_fifo_ipmatch_wren             ( info_fifo_ipmatch_wren    ),
    .info_fifo_ipmatch_wdat             ( info_fifo_ipmatch_wdat    ),
    .info_fifo_ipmatch_afull            ( info_fifo_ipmatch_afull   )    
    );

gbe_rx_matchbuf #(
    .U_DLY                              ( U_DLY                     ),
    .DATA_WIDTH                         ( DATA_WIDTH                ),
    .RAM_IPMATCH_DATA_WIDTH             ( RAM_IPMATCH_DATA_WIDTH    ),
    .RAM_UDPMATCH_DEPTH_BIT             ( RAM_UDPMATCH_DEPTH_BIT    ),
    .RAM_IPMATCH_DEPTH_BIT              ( RAM_IPMATCH_DEPTH_BIT     ),
    .FIFO_UDPMATCH_WIDTH                ( FIFO_UDPMATCH_WIDTH       ),
    .FIFO_UDPMATCH_DEPTH_BIT            ( FIFO_UDPMATCH_DEPTH_BIT   ),
    .FIFO_IPMATCH_WIDTH                 ( FIFO_IPMATCH_WIDTH        ),
    .FIFO_IPMATCH_DEPTH_BIT             ( FIFO_IPMATCH_DEPTH_BIT    )
    )
u0_gbe_rx_matchbuf(
    .rst_cfg                            ( rst_cfg                   ),
    .rst                                ( rst_rx                    ),
    .clk_cfg                            ( clk_cfg                   ),
    .clk                                ( clk_rx                    ),
    //udp match datram
    .datram_udpmatch_wren               ( datram_udpmatch_wren      ),
    .datram_udpmatch_wdat               ( datram_udpmatch_wdat      ),
    .datram_udpmatch_waddr              ( datram_udpmatch_waddr     ),
    //udp match infor fifo,dst_port(16bit)+udp_pkt_len(12bit)+start_addr(10bit)
    .info_fifo_udpmatch_wren            ( info_fifo_udpmatch_wren   ),
    .info_fifo_udpmatch_wdat            ( info_fifo_udpmatch_wdat   ),
    //ip match datram
    .datram_ipmatch_wren                ( datram_ipmatch_wren       ),
    .datram_ipmatch_wdat                ( datram_ipmatch_wdat       ),
    .datram_ipmatch_waddr               ( datram_ipmatch_waddr      ),
    //ip match infor fifo,frm_len(12bit)+start_addr(11bit)
    .info_fifo_ipmatch_wren             ( info_fifo_ipmatch_wren    ),
    .info_fifo_ipmatch_wdat             ( info_fifo_ipmatch_wdat    ),
    //udp pkt
    .udpmatch_valid                     ( udp_rx_valid              ),
    .udpmatch_sop                       ( udp_rx_sop                ),
    .udpmatch_eop                       ( udp_rx_eop                ),
    .udpmatch_data                      ( udp_rx_data               ),
    .udpmatch_mod                       ( udp_rx_mod                ),
    .udpmatch_pkt_len                   ( udp_rx_pkt_len            ),
    .udpmatch_port_index                ( udp_rx_port_index         ),
    //ip match rd,frm_len(12bit)+start_addr(11bit)
    .int_ipmatch                        ( int_ipmatch               ),
    .info_fifo_ipmatch_rden             ( info_fifo_ipmatch_rden    ),
    .ipmatch_pkt_cnt                    ( ipmatch_pkt_cnt           ),
    .ipmatch_pkt_len                    ( ipmatch_pkt_len           ),
    .ipmatch_start_addr                 ( ipmatch_start_addr        ),
    .info_fifo_ipmatch_afull            ( info_fifo_ipmatch_afull   ),
    .datram_ipmatch_raddr               ( datram_ipmatch_raddr      ),
    .datram_ipmatch_rdat                ( datram_ipmatch_rdat       )
    );  

gbe_cfg #(
    .U_DLY                              ( U_DLY                     ),
    .UDP_TABLE_DEPTH_BIT                ( UDP_TABLE_DEPTH_BIT       ),
    .UDP_TABLE_WIDTH                    ( UDP_TABLE_WIDTH           ),
    .RAM_IPMATCH_DATA_WIDTH             ( RAM_IPMATCH_DATA_WIDTH    ),
    .RAM_IPMATCH_DEPTH_BIT              ( RAM_IPMATCH_DEPTH_BIT     )
    )
u0_gbe_cfg(
    .rst_tx                             ( rst_tx                    ),
    .rst_cfg                            ( rst_cfg                   ),
    .clk_tx                             ( clk_tx                    ), 
    .clk_cfg                            ( clk_cfg                   ),  
    //local bus
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_wdata                         ( lbus_wdata                ),
    .lbus_rdata                         ( lbus_rdata                ),
    .lbus_cs_n                          ( lbus_cs_n                 ),
    .lbus_oe_n                          ( lbus_oe_n                 ),
    .lbus_we_n                          ( lbus_we_n                 ),

    .lbus_wait_n                        ( lbus_wait_n               ),
    //filter ipaddr
    .local_ip                           ( local_ip                  ),
    .local_ip2                          ( local_ip2                 ),
    .local_mac                          ( local_mac                 ),
    .mac_filter_ena                     ( mac_filter_ena            ),
    .filter_ip_addr1                    ( filter_ip_addr1           ),
    .filter_ip_addr2                    ( filter_ip_addr2           ), 
    .filter_ip_addr3                    ( filter_ip_addr3           ),
    .filter_ip_addr4                    ( filter_ip_addr4           ),
    .filter_ip_addr5                    ( filter_ip_addr5           ),
    .filter_ip_addr6                    ( filter_ip_addr6           ), 
    .filter_ip_addr7                    ( filter_ip_addr7           ),
    .filter_ip_addr8                    ( filter_ip_addr8           ),
    //phy control & status
    .phy_switch                         ( phy_switch                ),
    .phy_link_status                    ( phy_link_status           ),
    //udp_table
    .udp_table_switch                   ( udp_table_switch          ),  //keep '1' until udp_table_is_searching=0
    .udp_table_is_searching             ( udp_table_is_searching    ),
    .udp_table_wren                     ( udp_table_wren            ),
    .udp_table_waddr                    ( udp_table_waddr           ),
    .udp_table_wdat                     ( udp_table_wdat            ),
    //ipaddr filter
    .info_fifo_ipmatch_rden             ( info_fifo_ipmatch_rden    ),
    .ipmatch_pkt_cnt                    ( ipmatch_pkt_cnt           ),
    .ipmatch_pkt_len                    ( ipmatch_pkt_len           ),
    .ipmatch_start_addr                 ( ipmatch_start_addr        ),
    .datram_ipmatch_raddr               ( datram_ipmatch_raddr      ),
    .datram_ipmatch_rdat                ( datram_ipmatch_rdat       ),
    //rx_pkt_cnt & rx_byte_cnt
    .gbe_rx_pkt_cnt                     ( gbe_rx_pkt_cnt            ),
    .gbe_rx_byte_cnt                    ( gbe_rx_byte_cnt           ),
    //sfp control
    .sfp_main_add_in                    ( sfp_main_add_in           ),
    .sfp_backup_add_in                  ( sfp_backup_add_in         ),
    .sfp_main_tx_disable                ( sfp_main_tx_disable       ),
    .sfp_backup_tx_disable              ( sfp_backup_tx_disable     ),
    //mac_tx
    .mac_tx_data                        ( mac_o_data                ),
    .mac_tx_valid                       ( mac_o_valid               ),
    .mac_tx_ready                       ( mac_o_ready               ),
    .mac_tx_last                        ( mac_o_last                )
    );
            
endmodule
