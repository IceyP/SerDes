/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   gtx_rxtx.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-26  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gtx_rxtx.v
    File tree    :   gtx_rxtx.v                        
\************************************************************************************/

`timescale 1ns/100ps

module gtx_rxtx(
    clk_cfg                    ,
    rst_cfg                    ,
    clk_gtp                    ,
    rst_gtp                    ,
	 
	 lane_up							 ,
    channel_up                  ,
	 link_reset_gtx             ,
    
	 gtx_rx_data                 ,
    gtx_rx_sof_n                ,
    gtx_rx_eof_n                ,
    gtx_rx_dvalid_n             ,
    
    gtx_tx_data                 ,
    gtx_tx_sof_n                ,
    gtx_tx_eof_n                ,
    gtx_tx_src_rdy_n            ,
	 gtx_tx_dst_rdy_n            ,

    gt_gtrefclk					  ,
	 gt0_qpllclk_quad2           ,
    gt0_qpllrefclk_quad2        ,
	 
    mgt_rxp                     ,
    mgt_rxn                     ,
    mgt_txp                     ,
    mgt_txn                         
    );

input                                   clk_cfg                    ;
input                                   rst_cfg                    ;
output                                  clk_gtp                    ;
output                                  rst_gtp                    ;
output											 lane_up							 ;
output                                  channel_up                 ;
output											 link_reset_gtx				 ;

output  [15:0]                          gtx_rx_data                 ;
output                                  gtx_rx_sof_n                ;
output                                  gtx_rx_eof_n                ;
output                                  gtx_rx_dvalid_n             ;
input   [15:0]                          gtx_tx_data                 ;
input                                   gtx_tx_sof_n                ;
input                                   gtx_tx_eof_n                ;
input                                   gtx_tx_src_rdy_n            ;
output                                  gtx_tx_dst_rdy_n            ;

output                                  mgt_txp                     ;
output                                  mgt_txn                     ;
input                                   mgt_rxp                     ;
input                                   mgt_rxn                     ;
input											    gt_gtrefclk					  ;
input												 gt0_qpllclk_quad2           ;
input											    gt0_qpllrefclk_quad2        ;
    
wire                                    hard_err                    ;
wire                                    soft_err                    ;
wire                                    frame_err                   ;
wire                                    clk_gtp                    ;
wire                                    rst_gtp                    ;

//gtx transceiver
aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx1_exdes(
    // User IO
    .RESET                              ( rst_cfg                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err                  ),
    .SOFT_ERR                           ( soft_err                  ),
    .FRAME_ERR                          ( frame_err                 ),
    // Status Signals
    .LANE_UP                            ( lane_up                   ),
    .CHANNEL_UP                         ( channel_up                ),
	 
    .CLK_156M                           ( clk_gtp                  ),
    .RST_156M                           ( rst_gtp                  ),
	 .LINK_RESET_GTX							 ( link_reset_gtx           ),
    //tx user interface
    .TX_D                               ( gtx_tx_data               ),
    .TX_REM                             ( gtx_tx_rem                ),
    .TX_SOF_N                           ( gtx_tx_sof_n              ),
    .TX_EOF_N                           ( gtx_tx_eof_n              ),
    .TX_SRC_RDY_N                       ( gtx_tx_src_rdy_n          ),
    .TX_DST_RDY_N                       ( gtx_tx_dst_rdy_n          ),
    //rx user interface
    .RX_D                               ( gtx_rx_data               ), 
    .RX_REM                             ( gtx_rx_rem                ),    
    .RX_SOF_N                           ( gtx_rx_sof_n              ),
    .RX_EOF_N                           ( gtx_rx_eof_n              ),
    .RX_SRC_RDY_N                       ( gtx_rx_dvalid_n           ),
    //clock & reset
    .INIT_CLK                           ( clk_cfg                   ), 
    .GT_RESET_IN                        ( rst_cfg                   ),
    // Clock Signals
	 .GT_REFCLK1								 ( gt_gtrefclk					  ),
	 .GT0_QPLLCLK_QUAD2						 ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2					 ( gt0_qpllrefclk_quad2      ),
	 // GT I/O
    .RXP                                ( mgt_rxp                   ),
    .RXN                                ( mgt_rxn                   ),
    .TXP                                ( mgt_txp                   ),
    .TXN                                ( mgt_txn                   )
	);
endmodule
