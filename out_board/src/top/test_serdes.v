/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   test_serdes.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2015-04-20  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   test_serdes.v
    File tree    :   test_serdes.v                        
\************************************************************************************/
//`include    "../src/top/define.v"
 
`timescale 1ns/100ps

module test_serdes(
    //global reset
    rstn_sys                    ,
    clk_27m                     ,
    
    //gtx transceiver
    mgt_txp0                    ,
    mgt_txn0                    ,
    mgt_rxp0                    ,
    mgt_rxn0                    ,
    mgt_refclk0_p               ,
    mgt_refclk0_n               ,
    gpio_led                    
    );

input                                   rstn_sys                    ;
input                                   clk_27m                     ;

//gtx transceiver
output                                  mgt_txp0                    ;
output                                  mgt_txn0                    ;
input                                   mgt_rxp0                    ;
input                                   mgt_rxn0                    ;
input                                   mgt_refclk0_p               ;
input                                   mgt_refclk0_n               ;
    
output  [4:0]                           gpio_led                    ;
wire                                    rst_sys                     ;

//clock and reset
wire                                    clk27m_bufg                 ;
wire                                    clk_cfg                     ;
wire                                    rst_cfg                     ;

//gtx
wire                                    clk_156m                    ;
wire                                    rst_156m                    ;
(* KEEP = "TRUE" *)
wire    [15:0]                          gtx_rx_data                 ;
(* KEEP = "TRUE" *)
wire                                    gtx_rx_sof_n                ;
(* KEEP = "TRUE" *)
wire                                    gtx_rx_eof_n                ;
(* KEEP = "TRUE" *)
wire                                    gtx_rx_dvalid_n             ;
wire    [15:0]                          gtx_tx_data                 ;
wire                                    gtx_tx_sof_n                ;
wire                                    gtx_tx_eof_n                ;
wire                                    gtx_tx_src_rdy_n            ;
wire                                    gtx_tx_dst_rdy_n            ;

wire                                    channel_up                  ;
wire												 lane_up							  ;
wire                                    gtp_rst                     ;
wire    [15:0]                          gtp_err_cnt                 ;
wire    [15:0]                          pkt_counter                 ;
reg	  [23:0]									 pkt_led							  ;

// gtp clock signal
wire                                    gt0_gtrefclk0_common;
wire                                    gt0_qpllreset;
wire                                    gt0_qpllclk_quad2;
wire                                    gt0_qpllrefclk_quad2;
wire                                    gt1_qpllclk_quad2;
wire                                    gt1_qpllrefclk_quad2;
reg     [3:0]                           debounce_gt_rst_r;
wire												 pll_27m_locked;

assign  master_board_gpio = 1'b1; 

////////////////////////////////////////////////////////////////////
//lane up detect
////////////////////////////////////////////////////////////////////
lane_up_detect u0_lane_up_detect(
    .sys_clk                            ( clk27m_bufg               ),
    .clk                                ( clk_cfg                   ),
    .rst                                ( rst_cfg                   ),
    .channel_up                         ( channel_up                ),
    .lane_up                            ( 1'b1                      ),
    .gtp_rst                            ( gtp_rst	                 )
    );

////////////////////////////////////////////////////////////////////
//clock and reset
////////////////////////////////////////////////////////////////////
IBUFG u0_clk27m_bufg(
    .O                                  ( clk27m_bufg               ),
    .I                                  ( clk_27m                   )
    );
        
gen_rst u0_genrst(
    .clk                                ( clk27m_bufg               ),
    .rst_i                              ( rstn_sys                  ),
    .rst_o                              ( rst_sys                   )
    );    

pll_27m u0_pll_27m(
    .CLK_IN1                            ( clk27m_bufg               ),                
    .CLK_OUT1                           ( spi_clk                   ),  //10M
    .CLK_OUT2                           ( 		                    ),  //27M
    .CLK_OUT3                           ( clk_cfg                   ),  //100M
    .CLK_OUT4                           (                           ),  //200M     
    .RESET                              ( rst_sys                   ),
    .LOCKED                             ( pll_27m_locked            )
    );
assign	rst_cfg 								= rst_sys | (~pll_27m_locked);

always @(posedge clk_cfg)
begin
    debounce_gt_rst_r <=  {debounce_gt_rst_r[2:0],rst_cfg};
end

assign  gt0_qpllreset   					= (&debounce_gt_rst_r) || (link_reset_gtx);

IBUFDS_GTE2 IBUFDS_GTE2_CLK1(
    .I                                  ( mgt_refclk0_p              ),
    .IB                                 ( mgt_refclk0_n              ),
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
	 
gtx_rxtx u0_gtx_rxtx(
    .clk_cfg                            ( clk_cfg                   ),
    .rst_cfg									 ( gtp_rst                   ),
    .clk_gtp									 ( clk_156m                  ),
    .rst_gtp									 ( rst_156m                  ),
	 
	 .lane_up									 ( lane_up                		),
    .channel_up								 ( channel_up             		),
	 .link_reset_gtx							 ( link_reset_gtx			  		),
    
	 .gtx_rx_data								 ( gtx_rx_data					  	),
    .gtx_rx_sof_n								 ( gtx_rx_sof_n				  	),
    .gtx_rx_eof_n								 ( gtx_rx_eof_n				  	),
    .gtx_rx_dvalid_n							 ( gtx_rx_dvalid_n			  	),
    
    .gtx_tx_data								 ( 16'h0000           			),
    .gtx_tx_sof_n								 ( 1'b1          					),
    .gtx_tx_eof_n								 ( 1'b1          					),
    .gtx_tx_src_rdy_n						 ( 1'b1      						),
	 .gtx_tx_dst_rdy_n						 ( 					      		),

    .gt_gtrefclk                        ( gt0_gtrefclk0_common       ),
	 .gt0_qpllclk_quad2                  ( gt0_qpllclk_quad2          ),
    .gt0_qpllrefclk_quad2               ( gt0_qpllrefclk_quad2       ),
	 
    .mgt_rxp									 ( mgt_rxp0                ),
    .mgt_rxn									 ( mgt_rxn0                ),
    .mgt_txp									 ( mgt_txp0                ),
    .mgt_txn									 ( mgt_txn0                )
    );

aurora_8b10b_v8_3_FRAME_CHECK u0_gtp_check(
    .RX_D                               ( gtx_rx_data              ), 
    .RX_REM                             ( 1'b0                      ),    
    .RX_SOF_N                           ( gtx_rx_sof_n              ),     
    .RX_EOF_N                           ( gtx_rx_eof_n              ),
    .RX_SRC_RDY_N                       ( gtx_rx_dvalid_n           ),

    // System Interface
    .USER_CLK                           ( clk_156m                  ),      
    .RESET                              ( rst_156m                  ),
    .CHANNEL_UP                         ( channel_up                ), 
    .pkt_counter                        ( pkt_counter               ),
    .gtp_err_cnt                        ( gtp_err_cnt               )
    );
       
//led test
reg    [23:0]                           led_count                   ;
reg                                     ms_led                      ;

always@(posedge clk_cfg or posedge rst_sys)
begin
	if(rst_sys==1'b1)
	begin
		led_count	<=	{24{1'b0}};
		ms_led		<=	1'b0;
	end
	else if(led_count>=5000000)
	begin
		led_count	<=	{24{1'b0}};
		ms_led		<=	~ms_led;
	end
	else
	begin
		led_count	<=	led_count + 24'b1;
	end
end

always@(posedge clk_cfg or posedge gtp_rst)
begin
	if(gtp_rst == 1'b1)
	begin
		pkt_led	<=	{24{1'b0}};
	end
	else if(pkt_counter[15] == 1'b1) begin
		pkt_led	<=	pkt_led	+ 24'b1;
	end
end

assign  gtp_err                 =   |gtp_err_cnt;
assign  gpio_led[4:0]           =   {gtp_err,lane_up,ms_led,channel_up,pkt_led[23]};
        
endmodule
