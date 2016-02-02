/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_phy_mux.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_phy_mux.v
    File tree    :   gbe_phy_mux.v
\************************************************************************************/

`timescale 1ns/100ps

module gbe_phy_mux(
    rst                         ,
    clk                         ,
    rx_reset                    ,
    //tx from mac
    txd_from_mac                , 
    tx_en_from_mac              ,
    tx_er_from_mac              ,
    tx_clk                      ,
    tx_clk90                    ,
    tx_reset                    ,
    //rx to mac
    rxd_to_mac                  ,
    rx_dv_to_mac                ,
    rx_er_to_mac                ,
    rx_clk                      ,
    //phy_main
    phy_main_rgmii_txd          ,
    phy_main_rgmii_tx_ctl       ,
    phy_main_rgmii_txc          ,
    phy_main_rgmii_rxd          ,
    phy_main_rgmii_rx_ctl       ,
    phy_main_rgmii_rxc          ,
    phy_main_mdio               ,
    phy_main_mdc                ,
    //phy_backup
    phy_backup_rgmii_txd        ,
    phy_backup_rgmii_tx_ctl     ,
    phy_backup_rgmii_txc        ,
    phy_backup_rgmii_rxd        ,
    phy_backup_rgmii_rx_ctl     ,
    phy_backup_rgmii_rxc        ,
    phy_backup_mdio             ,
    phy_backup_mdc              ,
    //mdio
    mdio_i                      ,
    mdio_o                      ,
    mdio_t                      ,
    mdc_i                       ,
    //main backup phy switch,2'b00:manual;2'b01:main;2'b10:backup;
    phy_switch                  ,
    phy_addr                    ,
    mdio_cfg_finished           ,
    mdio_init_switch_flag
    );

parameter   U_DLY                       = 1                         ;
parameter   PHY_MAIN_ADDR               = 8'h06                     ;
parameter   PHY_BACKUP_ADDR             = 8'h05                     ;

input                                   rst                         ;
input                                   clk                         ;
input                                   rx_reset                    ;

input   [7:0]                           txd_from_mac                ;
input                                   tx_en_from_mac              ;
input                                   tx_er_from_mac              ;
input                                   tx_clk                      ;
input                                   tx_clk90                    ;
input                                   tx_reset                    ;

output  [7:0]                           rxd_to_mac                  ;
output                                  rx_dv_to_mac                ;
output                                  rx_er_to_mac                ;
output                                  rx_clk                      ;
    
//phy main
output  [3:0]                           phy_main_rgmii_txd          ;
output                                  phy_main_rgmii_tx_ctl       ;
output                                  phy_main_rgmii_txc          ;
input   [3:0]                           phy_main_rgmii_rxd          ;
input                                   phy_main_rgmii_rx_ctl       ;
input                                   phy_main_rgmii_rxc          ;
inout                                   phy_main_mdio               ;
output                                  phy_main_mdc                ;
//phy backup
output  [3:0]                           phy_backup_rgmii_txd        ;
output                                  phy_backup_rgmii_tx_ctl     ;
output                                  phy_backup_rgmii_txc        ;
input   [3:0]                           phy_backup_rgmii_rxd        ;
input                                   phy_backup_rgmii_rx_ctl     ;
input                                   phy_backup_rgmii_rxc        ;
inout                                   phy_backup_mdio             ;
output                                  phy_backup_mdc              ;
//mdio
output                                  mdio_i                      ;
input                                   mdio_o                      ;
input                                   mdio_t                      ;
input                                   mdc_i                       ;
//main backup phy switch
input   [1:0]                           phy_switch                  ;   //2'b00:manual;2'b01:main;2'b10:backup;
output  [7:0]                           phy_addr                    ;
input                                   mdio_cfg_finished           ;
output                                  mdio_init_switch_flag       ;

wire    [3:0]                           phy_main_rgmii_txd          ;
wire                                    phy_main_rgmii_tx_ctl       ;
wire                                    phy_main_rgmii_txc          ;
wire    [3:0]                           phy_backup_rgmii_txd        ;
wire                                    phy_backup_rgmii_tx_ctl     ;
wire                                    phy_backup_rgmii_txc        ;
wire                                    phy_main_mdc                ;
wire                                    phy_backup_mdc              ;

//mdio
wire                                    main_mdio_i                 ;
wire                                    backup_mdio_i               ;
wire                                    mdio_i                      ;
wire                                    main_mdio_o                 ;
wire                                    main_mdio_t                 ;
wire                                    backup_mdio_o               ;
wire                                    backup_mdio_t               ;

wire    [7:0]                           rxd_to_mac                  ;
wire                                    rx_dv_to_mac                ;
wire                                    rx_er_to_mac                ;
wire                                    rx_clk                      ;
wire                                    rgmii_rxclk_sel             ;

//phy main
wire                                    main_tx_er_from_mac         ;
wire                                    main_tx_en_from_mac         ;
wire    [7:0]                           main_txd_from_mac           ;
wire                                    main_rx_er_to_mac           ;
wire                                    main_rx_dv_to_mac           ;
wire    [7:0]                           main_rxd_to_mac             ;
wire                                    main_rx_clk                 ;

//phy backup
wire                                    backup_tx_er_from_mac       ;
wire                                    backup_tx_en_from_mac       ;
wire    [7:0]                           backup_txd_from_mac         ;
wire                                    backup_rx_er_to_mac         ;
wire                                    backup_rx_dv_to_mac         ;
wire    [7:0]                           backup_rxd_to_mac           ;
wire                                    backup_rx_clk               ;
wire    [7:0]                           phy_addr                    ;

reg     [1:0]                           mdio_switch                 ;
reg                                     phy_init_finished           ;
reg                                     mdio_cfg_finished_1syn      ;
reg                                     mdio_cfg_finished_2syn      ;
reg     [1:0]                           phy_switch_1syn             ;
reg     [1:0]                           phy_switch_2syn             ;
reg                                     mdio_init_switch_flag       ;
reg                                     mdio_cfg_finished_reg       ;

////////////////////////////////////////////////////////////////////
//rgmii process
////////////////////////////////////////////////////////////////////
assign  rxd_to_mac              =   (mdio_switch==2'b10)    ?   backup_rxd_to_mac   :   main_rxd_to_mac;
assign  rx_dv_to_mac            =   (mdio_switch==2'b10)    ?   backup_rx_dv_to_mac :   main_rx_dv_to_mac;
assign  rx_er_to_mac            =   (mdio_switch==2'b10)    ?   backup_rx_er_to_mac :   main_rx_er_to_mac;

assign  main_txd_from_mac       =   (mdio_switch==2'b01)    ?   txd_from_mac        :   8'h00;
assign  main_tx_en_from_mac     =   (mdio_switch==2'b01)    ?   tx_en_from_mac      :   1'b0;
assign  main_tx_er_from_mac     =   (mdio_switch==2'b01)    ?   tx_er_from_mac      :   1'b0;

assign  backup_txd_from_mac     =   (mdio_switch==2'b10)    ?   txd_from_mac        :   8'h00;
assign  backup_tx_en_from_mac   =   (mdio_switch==2'b10)    ?   tx_en_from_mac      :   1'b0;
assign  backup_tx_er_from_mac   =   (mdio_switch==2'b10)    ?   tx_er_from_mac      :   1'b0;

assign  phy_addr                =   (mdio_switch==2'b10)    ?   PHY_BACKUP_ADDR     :   PHY_MAIN_ADDR;
assign  rgmii_rxclk_sel         =   (mdio_switch==2'b10)    ?   1'b1                :   1'b0;

triple_mac_rgmii_v2_0_if main_rgmii(
    .tx_reset                           ( tx_reset                  ),
    .rx_reset                           ( rx_reset                  ),                                          
    .rgmii_txd                          ( phy_main_rgmii_txd        ),
    .rgmii_tx_ctl                       ( phy_main_rgmii_tx_ctl     ),
    .rgmii_txc                          ( phy_main_rgmii_txc        ),
    .rgmii_rxd                          ( phy_main_rgmii_rxd        ),
    .rgmii_rx_ctl                       ( phy_main_rgmii_rx_ctl     ),
    .rgmii_rxc                          ( phy_main_rgmii_rxc        ),                                         
    .txd_from_mac                       ( main_txd_from_mac         ),
    .tx_en_from_mac                     ( main_tx_en_from_mac       ),
    .tx_er_from_mac                     ( main_tx_er_from_mac       ),
    .tx_clk                             ( tx_clk                    ),
    .tx_clk90                           ( tx_clk90                  ),
    .rxd_to_mac                         ( main_rxd_to_mac           ),
    .rx_dv_to_mac                       ( main_rx_dv_to_mac         ),
    .rx_er_to_mac                       ( main_rx_er_to_mac         ),                                          
    .rx_clk                             ( main_rx_clk               )
    );

triple_mac_rgmii_v2_0_if backup_rgmii(
    .tx_reset                           ( tx_reset                  ),
    .rx_reset                           ( rx_reset                  ),                                          
    .rgmii_txd                          ( phy_backup_rgmii_txd      ),
    .rgmii_tx_ctl                       ( phy_backup_rgmii_tx_ctl   ),
    .rgmii_txc                          ( phy_backup_rgmii_txc      ),
    .rgmii_rxd                          ( phy_backup_rgmii_rxd      ),
    .rgmii_rx_ctl                       ( phy_backup_rgmii_rx_ctl   ),
    .rgmii_rxc                          ( phy_backup_rgmii_rxc      ),                                         
    .txd_from_mac                       ( backup_txd_from_mac       ),
    .tx_en_from_mac                     ( backup_tx_en_from_mac     ),
    .tx_er_from_mac                     ( backup_tx_er_from_mac     ),
    .tx_clk                             ( tx_clk                    ),
    .tx_clk90                           ( tx_clk90                  ),
    .rxd_to_mac                         ( backup_rxd_to_mac         ),
    .rx_dv_to_mac                       ( backup_rx_dv_to_mac       ),
    .rx_er_to_mac                       ( backup_rx_er_to_mac       ),                                          
    .rx_clk                             ( backup_rx_clk             )
    );

BUFGMUX u0_rgmii_rxclk_mux(
    .I0                                 ( main_rx_clk               ),
    .I1                                 ( backup_rx_clk             ),
    .S                                  ( rgmii_rxclk_sel           ),
    .O                                  ( rx_clk                    )
    );                    
    
////////////////////////////////////////////////////////////////////
//MDIO process
////////////////////////////////////////////////////////////////////
assign  phy_main_mdc            =   mdc_i;
assign  phy_backup_mdc          =   mdc_i;
assign  main_mdio_o             =   (mdio_switch==2'b01)  ?   mdio_o  :   1'b1;
assign  main_mdio_t             =   (mdio_switch==2'b01)  ?   mdio_t  :   1'b1;
assign  backup_mdio_o           =   (mdio_switch==2'b10)  ?   mdio_o  :   1'b1;
assign  backup_mdio_t           =   (mdio_switch==2'b10)  ?   mdio_t  :   1'b1;
assign  mdio_i                  =   (mdio_switch==2'b10)  ?   backup_mdio_i   :   main_mdio_i;

IOBUF main_mdio_iobuf(
     .I                                 ( main_mdio_o               ),
     .IO                                ( phy_main_mdio             ),
     .O                                 ( main_mdio_i               ),
     .T                                 ( main_mdio_t               )
  );

IOBUF backup_mdio_iobuf(
     .I                                 ( backup_mdio_o             ),
     .IO                                ( phy_backup_mdio           ),
     .O                                 ( backup_mdio_i             ),
     .T                                 ( backup_mdio_t             )
  );

////////////////////////////////////////////////////////////////////
//MDIO init cfg switch:first main then backup
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mdio_cfg_finished_1syn  <=  1'b0;
        mdio_cfg_finished_2syn  <=  1'b0;
        mdio_cfg_finished_reg   <=  1'b0;
    end
    else
    begin
        mdio_cfg_finished_1syn  <=  mdio_cfg_finished;
        mdio_cfg_finished_2syn  <=  mdio_cfg_finished_1syn;
        mdio_cfg_finished_reg   <=  (~mdio_cfg_finished_2syn) & mdio_cfg_finished_1syn;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        phy_switch_1syn  <=  2'b00;
        phy_switch_2syn  <=  2'b00;
    end
    else
    begin
        phy_switch_1syn  <=  phy_switch;
        phy_switch_2syn  <=  phy_switch_1syn;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        phy_init_finished   <=  1'b0;
    end
    else if((mdio_switch==2'b10) && (mdio_cfg_finished_reg==1'b1))
    begin
        phy_init_finished   <=  1'b1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mdio_switch <=  2'b01;
    end
    else if((mdio_switch==2'b01) && (mdio_cfg_finished_reg==1'b1))
    begin
        mdio_switch <=  2'b10;
    end
    else if(phy_init_finished==1'b1)
    begin
        mdio_switch <=  phy_switch_2syn;
    end 
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mdio_init_switch_flag   <=  1'b0;
    end
    else if((mdio_switch==2'b01) && (mdio_cfg_finished_reg==1'b1))
    begin
        mdio_init_switch_flag   <=  1'b1;  
    end
    else
    begin
        mdio_init_switch_flag   <=  1'b0;
    end
end
 
endmodule
