/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  mainboard_top.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  mainboard_top.v
    File tree    :  mainboard_top.v                        
\************************************************************************************/

`timescale 1ns/1ps

module mainboard_top(
    rst_n                       ,
    clk_27m                     ,
    
    ss_i                        ,
    sclk_i                      ,
    mosi_i                      ,
    miso_o                      ,
    
    mgt_txp                     ,
    mgt_txn                     ,
    mgt_rxp                     ,
    mgt_rxn                     ,
    mgt_refclk_p                ,
    mgt_refclk_n                ,
    sb_signal                   ,
    front_panel_led             ,
	 led_state						  ,
    led_out
    );
	 
parameter     CHAN_NUMS                 = 8                         ;             
    
input                                   rst_n                       ;
input                                   clk_27m                     ;

input												 ss_i                        ;
input												 sclk_i                      ;
input												 mosi_i                      ;
output											 miso_o                      ;

output  [CHAN_NUMS-1:0]                 mgt_txp                     ;
output  [CHAN_NUMS-1:0]                 mgt_txn                     ;
input   [CHAN_NUMS-1:0]                 mgt_rxp                     ;
input   [CHAN_NUMS-1:0]                 mgt_rxn                     ;
input                                   mgt_refclk_p                ;
input                                   mgt_refclk_n                ;
input   [11:0]                          sb_signal                   ;
output  [11:0]                          front_panel_led             ;
output  [1:0]									 led_state						  ;
output  [CHAN_NUMS-1:0]                 led_out                     ;
                                        
wire    [CHAN_NUMS-1:0]                 hard_err                    ;
wire    [CHAN_NUMS-1:0]                 soft_err                    ;
wire    [CHAN_NUMS-1:0]                 frame_err                   ;
wire    [CHAN_NUMS-1:0]                 lane_up                     ;
wire    [CHAN_NUMS-1:0]                 channel_up                  ;
wire    [CHAN_NUMS-1:0]                 clk_156m                    ;
wire    [CHAN_NUMS-1:0]                 rst_156m                    ;

//gtx tx data
(* KEEP = "TRUE" *)
wire    [0:15]                          tx_data[CHAN_NUMS-1:0]      ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 tx_rem                      ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 tx_sof_n                    ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 tx_eof_n                    ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 tx_src_rdy_n                ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 tx_dst_rdy_n                ;

//gtx rx data
(* KEEP = "TRUE" *)
wire    [0:15]                          rx_data[CHAN_NUMS-1:0]      ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 rx_rem                      ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 rx_sof_n                    ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 rx_eof_n                    ;
(* KEEP = "TRUE" *)
wire    [CHAN_NUMS-1:0]                 rx_src_rdy_n                ;

wire	  [0:15]									 tx_data_t						  ;
wire												 tx_rem_t						  ;
wire												 tx_sof_n_t                  ;
wire												 tx_eof_n_t                  ;
wire                                    tx_src_rdy_n_t              ;
wire												 tx_dst_rdy_n_t              ;

wire                                    sys_clk                     ;
wire                                    pll_27m_locked              ;
wire                                    rst                         ;
wire    [CHAN_NUMS-1:0]                 link_reset_gtx              ;
reg     [3:0]                           debounce_gt_rst_r           ;

wire                                    gt0_gtrefclk0_common        ;

wire                                    gt0_qplllockdetclk          ;
wire                                    gt0_qpllreset               ;
wire                                    gt0_qpllclk_quad2           ;
wire                                    gt0_qpllrefclk_quad2        ;
wire                                    gt1_qpllclk_quad2           ;
wire                                    gt1_qpllrefclk_quad2        ;
wire                                    clk27m_bufg                 ;
wire                                    clk27m_bufg_temp            ;
wire                                    rst_sys                     ;
wire                                    clk_200m                    ;

assign  rst 									=   rst_sys | (~pll_27m_locked);

always @(posedge sys_clk)
begin
    debounce_gt_rst_r <=  {debounce_gt_rst_r[2:0],rst};
end

assign  gt0_qpllreset   					=   (&debounce_gt_rst_r) || (|link_reset_gtx);

////////////////////////////////////////////////////////////////////
//clock and reset
////////////////////////////////////////////////////////////////////
IBUFG u0_clk27m_bufg(
    .O                                  ( clk27m_bufg_temp          ),
    .I                                  ( clk_27m                   )
    );

BUFG u0_clk27m_bg(
    .O                                  ( clk27m_bufg               ),
    .I                                  ( clk27m_bufg_temp          )
    );
        
gen_rst u0_genrst(
    .clk                                ( clk27m_bufg               ),
    .rst_i                              ( rst_n                     ),
    .rst_o                              ( rst_sys                   )
    );
        
pll_27m u0_pll_27m(
    // Clock in ports
    .CLK_IN1                            ( clk27m_bufg               ),
    // Clock out ports                    
    .CLK_OUT1                           ( sys_clk                   ),  //125MHz
    .CLK_OUT2                           ( clk_200m                  ),  //250MHz
    // Status and control signals         
    .RESET                              ( rst_sys                   ),
    .LOCKED                             ( pll_27m_locked            )
    );
////////////////////////////////////////////////////////////////////

IBUFDS_GTE2 IBUFDS_GTE2_CLK1(
    .I                                  ( mgt_refclk_p              ),
    .IB                                 ( mgt_refclk_n              ),
    .CEB                                ( 1'b0                      ),
    .O                                  ( gt0_gtrefclk0_common      ),
    .ODIV2                              ( )
    );
 
common_block u0_common_block(
    .GT0_GTREFCLK0_COMMON               ( gt0_gtrefclk0_common      ),
    .GT0_QPLLLOCKDETCLK                 ( 1'b0                      ),
    .GT0_QPLLRESET                      ( gt0_qpllreset             ),
    .GT0_QPLLLOCK                       ( ),
    .GT0_QPLLCLK_QUAD2                  ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt0_qpllrefclk_quad2      ),
    .GT0_QPLLREFCLKLOST                 ( ),
    .GT1_GTREFCLK0_COMMON               ( gt0_gtrefclk0_common      ),
    .GT1_QPLLLOCKDETCLK                 ( 1'b0                      ),
    .GT1_QPLLRESET                      ( gt0_qpllreset             ),
    .GT1_QPLLLOCK                       ( ),
    .GT1_QPLLCLK_QUAD2                  ( gt1_qpllclk_quad2         ),
    .GT1_QPLLREFCLK_QUAD2               ( gt1_qpllrefclk_quad2      ),
    .GT1_QPLLREFCLKLOST                 ( )
    );
    
aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx1_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[0]               ),
    .SOFT_ERR                           ( soft_err[0]               ),
    .FRAME_ERR                          ( frame_err[0]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[0]                ),
    .CHANNEL_UP                         ( channel_up[0]             ),
    .CLK_156M                           ( clk_156m[0]               ),
    .RST_156M                           ( rst_156m[0]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[0]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[0]                ),
    .RX_REM                             ( rx_rem[0]                 ),
    .RX_SOF_N                           ( rx_sof_n[0]               ),
    .RX_EOF_N                           ( rx_eof_n[0]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[0]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt1_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt1_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),
    // GT I/O
    .RXP                                ( mgt_rxp[0]                ),
    .RXN                                ( mgt_rxn[0]                ),
    .TXP                                ( mgt_txp[0]                ),
    .TXN                                ( mgt_txn[0]                )
    );

aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx2_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[1]               ),
    .SOFT_ERR                           ( soft_err[1]               ),
    .FRAME_ERR                          ( frame_err[1]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[1]                ),
    .CHANNEL_UP                         ( channel_up[1]             ),
    .CLK_156M                           ( clk_156m[1]               ),
    .RST_156M                           ( rst_156m[1]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[1]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[1]                ),
    .RX_REM                             ( rx_rem[1]                 ),
    .RX_SOF_N                           ( rx_sof_n[1]               ),
    .RX_EOF_N                           ( rx_eof_n[1]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[1]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt1_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt1_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),
    // GT I/O
    .RXP                                ( mgt_rxp[1]                ),
    .RXN                                ( mgt_rxn[1]                ),
    .TXP                                ( mgt_txp[1]                ),
    .TXN                                ( mgt_txn[1]                )
    );

aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx3_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[2]               ),
    .SOFT_ERR                           ( soft_err[2]               ),
    .FRAME_ERR                          ( frame_err[2]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[2]                ),
    .CHANNEL_UP                         ( channel_up[2]             ),
    .CLK_156M                           ( clk_156m[2]               ),
    .RST_156M                           ( rst_156m[2]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[2]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[2]                ),
    .RX_REM                             ( rx_rem[2]                 ),
    .RX_SOF_N                           ( rx_sof_n[2]               ),
    .RX_EOF_N                           ( rx_eof_n[2]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[2]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt1_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt1_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ), 
    // GT I/O
    .RXP                                ( mgt_rxp[2]                ),
    .RXN                                ( mgt_rxn[2]                ),
    .TXP                                ( mgt_txp[2]                ),
    .TXN                                ( mgt_txn[2]                )
    ); 

aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx4_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[3]               ),
    .SOFT_ERR                           ( soft_err[3]               ),
    .FRAME_ERR                          ( frame_err[3]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[3]                ),
    .CHANNEL_UP                         ( channel_up[3]             ),
    .CLK_156M                           ( clk_156m[3]               ),
    .RST_156M                           ( rst_156m[3]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[3]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[3]                ),
    .RX_REM                             ( rx_rem[3]                 ),
    .RX_SOF_N                           ( rx_sof_n[3]               ),
    .RX_EOF_N                           ( rx_eof_n[3]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[3]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt1_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt1_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),  
    // GT I/O
    .RXP                                ( mgt_rxp[3]                ),
    .RXN                                ( mgt_rxn[3]                ),
    .TXP                                ( mgt_txp[3]                ),
    .TXN                                ( mgt_txn[3]                )
    );
    
aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx5_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[4]               ),
    .SOFT_ERR                           ( soft_err[4]               ),
    .FRAME_ERR                          ( frame_err[4]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[4]                ),
    .CHANNEL_UP                         ( channel_up[4]             ),
    .CLK_156M                           ( clk_156m[4]               ),
    .RST_156M                           ( rst_156m[4]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[4]         ),
    //tx user interface
    .TX_D                               ( tx_data_t                ),
    .TX_REM                             ( tx_rem_t                 ),
    .TX_SOF_N                           ( tx_sof_n_t               ),
    .TX_EOF_N                           ( tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[4]                ),
    .RX_REM                             ( rx_rem[4]                 ),
    .RX_SOF_N                           ( rx_sof_n[4]               ),
    .RX_EOF_N                           ( rx_eof_n[4]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[4]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt0_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),  
    // GT I/O
    .RXP                                ( mgt_rxp[4]                ),
    .RXN                                ( mgt_rxn[4]                ),
    .TXP                                ( mgt_txp[4]                ),
    .TXN                                ( mgt_txn[4]                )
    );  

aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx6_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[5]               ),
    .SOFT_ERR                           ( soft_err[5]               ),
    .FRAME_ERR                          ( frame_err[5]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[5]                ),
    .CHANNEL_UP                         ( channel_up[5]             ),
    .CLK_156M                           ( clk_156m[5]               ),
    .RST_156M                           ( rst_156m[5]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[5]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t					  ),
    .TX_REM                             ( ),//tx_rem_t			   		  ),
    .TX_SOF_N                           ( ),//tx_sof_n_t					  ),
    .TX_EOF_N                           ( ),//tx_eof_n_t					  ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t		   	  ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t			     ),
    //rx user interface
    .RX_D                               ( rx_data[5]                ),
    .RX_REM                             ( rx_rem[5]                 ),
    .RX_SOF_N                           ( rx_sof_n[5]               ),
    .RX_EOF_N                           ( rx_eof_n[5]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[5]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt0_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),  
    // GT I/O
    .RXP                                ( mgt_rxp[5]                ),
    .RXN                                ( mgt_rxn[5]                ),
    .TXP                                ( mgt_txp[5]                ),
    .TXN                                ( mgt_txn[5]                )
    );

aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx7_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[6]               ),
    .SOFT_ERR                           ( soft_err[6]               ),
    .FRAME_ERR                          ( frame_err[6]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[6]                ),
    .CHANNEL_UP                         ( channel_up[6]             ),
    .CLK_156M                           ( clk_156m[6]               ),
    .RST_156M                           ( rst_156m[6]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[6]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[6]                ),
    .RX_REM                             ( rx_rem[6]                 ),
    .RX_SOF_N                           ( rx_sof_n[6]               ),
    .RX_EOF_N                           ( rx_eof_n[6]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[6]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt0_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),  
    // GT I/O
    .RXP                                ( mgt_rxp[6]                ),
    .RXN                                ( mgt_rxn[6]                ),
    .TXP                                ( mgt_txp[6]                ),
    .TXN                                ( mgt_txn[6]                )
    );
    
aurora_8b10b_gtx1_exdes u0_aurora_8b10b_gtx8_exdes(
    // User IO
    .RESET                              ( rst                       ),
    // Error signals from Aurora   
    .HARD_ERR                           ( hard_err[7]               ),
    .SOFT_ERR                           ( soft_err[7]               ),
    .FRAME_ERR                          ( frame_err[7]              ),
    // Status Signals
    .LANE_UP                            ( lane_up[7]                ),
    .CHANNEL_UP                         ( channel_up[7]             ),
    .CLK_156M                           ( clk_156m[7]               ),
    .RST_156M                           ( rst_156m[7]               ),
    .LINK_RESET_GTX                     ( link_reset_gtx[7]         ),
    //tx user interface
    .TX_D                               ( ),//tx_data_t                ),
    .TX_REM                             ( ),//tx_rem_t                 ),
    .TX_SOF_N                           ( ),//tx_sof_n_t               ),
    .TX_EOF_N                           ( ),//tx_eof_n_t               ),
    .TX_SRC_RDY_N                       ( ),//tx_src_rdy_n_t           ),
    .TX_DST_RDY_N                       ( ),//tx_dst_rdy_n_t           ),
    //rx user interface
    .RX_D                               ( rx_data[7]                ),
    .RX_REM                             ( rx_rem[7]                 ),
    .RX_SOF_N                           ( rx_sof_n[7]               ),
    .RX_EOF_N                           ( rx_eof_n[7]               ),
    .RX_SRC_RDY_N                       ( rx_src_rdy_n[7]           ),
    //clock & reset
    .INIT_CLK                           ( sys_clk                   ), 
    .GT_RESET_IN                        ( rst                       ),
    //common block  
    .GT0_QPLLCLK_QUAD2                  ( gt0_qpllclk_quad2         ),
    .GT0_QPLLREFCLK_QUAD2               ( gt0_qpllrefclk_quad2      ),
    // Clock Signals
    .GT_REFCLK1                         ( gt0_gtrefclk0_common      ),  
    // GT I/O
    .RXP                                ( mgt_rxp[7]                ),
    .RXN                                ( mgt_rxn[7]                ),
    .TXP                                ( mgt_txp[7]                ),
    .TXN                                ( mgt_txn[7]                )
    );
assign	tx_data_t							=	tx_data[0];
assign	tx_rem_t								=	tx_rem[0];
assign	tx_sof_n_t							=	tx_sof_n[0];
assign	tx_eof_n_t							=	tx_sof_n[0];
assign	tx_src_rdy_n_t						=	tx_src_rdy_n[0];
assign	tx_dst_rdy_n_t						=	tx_dst_rdy_n[0];
       
pkt_tm u0_pkt_tm(
    .clk_156m                           ( clk_156m                  ),
    .rst_156m                           ( rst_156m                  ),
    .clk_200m                           ( clk_200m                  ),
    .channel_up                         ( channel_up                ),
    
    .rx_data_in0                        ( rx_data[0]                ),
    .rx_data_in1                        ( rx_data[1]                ),
    .rx_data_in2                        ( rx_data[2]                ),
    .rx_data_in3                        ( rx_data[3]                ),
    .rx_data_in4                        ( rx_data[4]                ),
    .rx_data_in5                        ( rx_data[5]                ),
    .rx_data_in6                        ( rx_data[6]                ),
    .rx_data_in7                        ( rx_data[7]                ),
    .rx_rem                             ( rx_rem                    ),
    .rx_sof_n                           ( rx_sof_n                  ),
    .rx_eof_n                           ( rx_eof_n                  ),
    .rx_src_rdy_n                       ( rx_src_rdy_n              ),
    
    .tx_data_out0                       ( tx_data[0]                ),
    .tx_data_out1                       ( tx_data[1]                ),
    .tx_data_out2                       ( tx_data[2]                ),
    .tx_data_out3                       ( tx_data[3]                ),
    .tx_data_out4                       ( tx_data[4]                ),
    .tx_data_out5                       ( tx_data[5]                ),
    .tx_data_out6                       ( tx_data[6]                ),
    .tx_data_out7                       ( tx_data[7]                ),
    .tx_rem                             ( tx_rem                    ),
    .tx_sof_n                           ( tx_sof_n                  ),
    .tx_eof_n                           ( tx_eof_n                  ),
    .tx_src_rdy_n                       ( tx_src_rdy_n              ),
    .tx_dst_rdy_n                       ( tx_dst_rdy_n              )
    );

//spi
spi_if u0_spi_if(
    .clk                                ( sys_clk                   ),
    .rst                                ( rst_sys                   ),
    .ss_i                               ( ss_i                      ), 
    .sclk_i                             ( sclk_i                    ),
    .mosi_i                             ( mosi_i                    ),
    .miso_o                             ( miso_o                    )
    );   
	    
//////////////////////////////////////////////////////////////////////
////ms led test
//////////////////////////////////////////////////////////////////////
reg     [31:0]                          led_count					;
reg                                     ms_led						;
always@(posedge sys_clk or posedge rst)
begin
	if(rst==1'b1)
	begin
		led_count	<=	{32{1'b0}};
		ms_led		<=	1'b0;
	end
	else if(led_count>=31200000)
	begin
		led_count	<=	{32{1'b0}};
		ms_led		<=	~ms_led;
	end
	else
	begin
		led_count	<=	led_count + 32'b1;
	end
end

assign  led_out[0]    =  (send_err | recv_err)? 0:ms_led;
assign  led_out[1]    =  lane_up[7];
assign  led_out[2]    =  lane_up[6];
assign  led_out[3]    =  lane_up[5];                                 
assign  led_out[4]    =  lane_up[4];
assign  led_out[5]    =  lane_up[3];
assign  led_out[6]    =  lane_up[2];
assign  led_out[7]    =  lane_up[0] | lane_up[1];//


//-----------------------------------------------------
//         SEND AND RECV TEST
//---------------------------------------------------
reg    [31:0]      send_clk_count;
reg    [15:0]      send_pkts_1s;
reg    [15:0]      send_pkts_1s_reg;
reg    [15:0]      send_pkt_count;

reg    [31:0]      rcv_clk_count;
reg    [15:0]      rcv_pkts_1s;
reg    [15:0]      rcv_pkts_1s_reg;
reg    [15:0]      rcv_pkt_count;



always@(posedge clk_156m[0] or posedge rst_156m[0])
begin
	if(rst_156m[0]==1'b1)
	begin
		rcv_clk_count	<=	{32{1'b0}};
		rcv_pkt_count	<=	0;
		rcv_pkts_1s <= 0;
		rcv_pkts_1s_reg <= 0;
	end
	else begin
	  if(rcv_clk_count>=156250000)
	  begin
		 rcv_clk_count	<=	{32{1'b0}};
		 rcv_pkts_1s_reg <= rcv_pkts_1s;
		 rcv_pkts_1s		<=	rcv_pkt_count;
		 rcv_pkt_count <= 0;
	  end
	  else
	  begin
		 rcv_clk_count	<=	rcv_clk_count + 32'b1;
		 if(rx_eof_n[0] == 1'b0)begin
	      rcv_pkt_count <= rcv_pkt_count + 16'b1;
	    end
	  end
  end
end

always@(posedge clk_156m[4] or posedge rst_156m[4])
begin
	if(rst_156m[4]==1'b1)
	begin
		send_clk_count	<=	{32{1'b0}};
		send_pkt_count	<=	0;
		send_pkts_1s <= 0;
		send_pkts_1s_reg <= 0;
	end
	else begin
	  if(send_clk_count>=156250000)
	  begin
		 send_clk_count	<=	{32{1'b0}};
		 send_pkts_1s_reg <= send_pkts_1s;
		 send_pkts_1s		<=	send_pkt_count;
		 send_pkt_count <= 0;
	  end
	  else
	  begin
		 send_clk_count	<=	send_clk_count + 32'b1;
		 if(tx_eof_n[4] == 1'b0)begin
	      send_pkt_count <= send_pkt_count + 16'b1;
	    end
	  end
  end
end

/*------------------------------test ts synchronous-----------------------------*/
wire                  	recv_err;
wire   [15:0]           rx_data_inv0 = rx_data[0];
wire   [15:0]           rx_data_inv1 = rx_data[1];
wire   [15:0]           rx_data_inv2 = rx_data[2];
wire   [15:0]           rx_data_inv3 = rx_data[3];
wire   [15:0]           rx_data_inv4 = rx_data[4];
wire   [15:0]           rx_data_inv5 = rx_data[5];
wire   [15:0]           rx_data_inv6 = rx_data[6];
wire   [15:0]           rx_data_inv7 = rx_data[7];
test_ts_syn  test_recv(
  // Receive Transport stream 
   .payload_clk         (clk_156m[0]),
   .payload_rst         (rst_156m[0]),
   .payload_in_valid    (~rx_src_rdy_n[0]),
   .payload_in_start    (~rx_sof_n[0]),
   .payload_in_end      (~rx_eof_n[0]),
   .payload_in_data     (rx_data[0]),
	.err_flag            (recv_err)        
	);

wire                    send_err;
wire   [15:0]           tx_data_inv0 = tx_data[0];
wire   [15:0]           tx_data_inv1 = tx_data[1];
wire   [15:0]           tx_data_inv2 = tx_data[2];
wire   [15:0]           tx_data_inv3 = tx_data[3];
wire   [15:0]           tx_data_inv4 = tx_data[4];
wire   [15:0]           tx_data_inv5 = tx_data[5];
wire   [15:0]           tx_data_inv6 = tx_data[6];
wire   [15:0]           tx_data_inv7 = tx_data[7];
test_ts_syn  test_send(
  // Receive Transport stream 
   .payload_clk         (clk_156m[0]),
   .payload_rst         (rst_156m[0]),
   .payload_in_valid    (~tx_src_rdy_n[0]),
   .payload_in_start    (~tx_sof_n[0]),
   .payload_in_end      (~tx_eof_n[0]),
   .payload_in_data     (tx_data_inv0),
	.err_flag            (send_err)        
	);

////////////////////////////////////////////////////////////////////
//front panel led
////////////////////////////////////////////////////////////////////
//slot0
assign  front_panel_led[0] =   (&lane_up[1:0]) & sb_signal[0];
assign  front_panel_led[1] =   (&lane_up[1:0]) & sb_signal[1];
//slot1
assign  front_panel_led[2] =   (&lane_up[3:2]) & sb_signal[2];
assign  front_panel_led[3] =   (&lane_up[3:2]) & sb_signal[3];
//slot2
assign  front_panel_led[4] =   lane_up[4] & sb_signal[4];
assign  front_panel_led[5] =   lane_up[4] & sb_signal[5];
//slot3
assign  front_panel_led[6] =   lane_up[5] & sb_signal[6];
assign  front_panel_led[7] =   lane_up[5] & sb_signal[7];
//slot4
assign  front_panel_led[8] =   lane_up[6] & sb_signal[8];
assign  front_panel_led[9] =   lane_up[6] & sb_signal[9];
//slot5
assign  front_panel_led[10]=   lane_up[7] & sb_signal[10];
assign  front_panel_led[11]=   lane_up[7] & sb_signal[11];

reg     [23:0]     						send_err_cnt;
reg     [23:0]     						recv_err_cnt;

wire					 						send_error;
wire					 						recv_error;

always@(posedge clk_156m[5])
begin
    if(rst==1'b1)
    begin
        send_err_cnt <=  {24{1'b0}};
    end
    else if(send_err==1'b1)
    begin
        send_err_cnt <=  send_err_cnt + 'h1;
    end
end

assign  send_error                 	=  |(send_err_cnt[23:20]);

always@(posedge clk_156m[0])
begin
    if(rst==1'b1)
    begin
        recv_err_cnt <=  {24{1'b0}};
    end
    else if(recv_err==1'b1)
    begin
        recv_err_cnt <=  recv_err_cnt + 'h1;
    end
end

assign  recv_error                 	=  |(recv_err_cnt[23:20]);

assign  led_state[0]  					=  send_error;
assign  led_state[1]  					=  recv_error;

endmodule


