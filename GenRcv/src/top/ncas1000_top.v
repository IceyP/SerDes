/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  ncas1000_top.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  ncas1000 fpga top module;
                    1.communicate with CPU through EBI interface;
                    2.gtp tx to masterboard,including:ecm,emm,scrambling control word;
                    3.generate random data;
                    4.ddr3 operation(transmit ecm according to ecm tx period);
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-28  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  ncas1000_top.v
    File tree    :  ncas1000_top.v                        
\************************************************************************************/

`timescale 1ns/1ps

module ncas1000_top(
    rst_n,
    clk_27m,
    gpio_led,

    //gtx    
    mgt_txp,
    mgt_txn,
    mgt_rxp,
    mgt_rxn,
    mgt_refclk_p,
    mgt_refclk_n
    );
	 
input                                   rst_n;
input                                   clk_27m;
output  [4:0]                           gpio_led;

output   [1:0]                          mgt_txp;
output   [1:0]                          mgt_txn;
input		[1:0]                          mgt_rxp;
input    [1:0]                          mgt_rxn;
input                                   mgt_refclk_p;
input                                   mgt_refclk_n;

//gtp
wire      [1:0]                         clk_gtp;
wire      [1:0]                         rst_gtp;
(*KEEP = "TRUE"*)
wire                                    clk_cfg;
(*KEEP = "TRUE"*)
wire                                    clk_125m;
wire                                    rst;
wire                                    rst_sys;
wire                                    clk27m_bufg;

wire                                    run_led;
wire    [1:0]                           channel_up;
wire	  [1:0]									 lane_up;
(* KEEP = "TRUE" *)
wire    [1:0]                 			 link_reset_gtx;

reg                                     dog_det_lane;
reg     [27:0]                          counter;
reg                                     serdes_relink;
reg                                     serdes_rst;
wire                                    rst_buf_n;

// gtp signal
(* KEEP = "TRUE" *)
wire		[15:0]								gtp0_rx_data;
wire												gtp0_rx_sof_n;
wire												gtp0_rx_eof_n;
wire												gtp0_rx_dvalid_n;

(* KEEP = "TRUE" *)
wire		[15:0]								gtp1_rx_data;
wire												gtp1_rx_sof_n;
wire												gtp1_rx_eof_n;
wire												gtp1_rx_dvalid_n;

(* KEEP = "TRUE" *)
wire    [15:0]                          gtp0_tx_data_buf;
(* KEEP = "TRUE" *)
wire                                    gtp0_tx_sof_n_buf;
(* KEEP = "TRUE" *)
wire                                    gtp0_tx_eof_n_buf;
(* KEEP = "TRUE" *)
wire                                    gtp0_tx_src_rdy_n_buf;
(* KEEP = "TRUE" *)
wire                                    gtp0_tx_dst_rdy_n_buf;

wire    [15:0]                          gtp1_tx_data_buf;
wire                                    gtp1_tx_sof_n_buf;
wire                                    gtp1_tx_eof_n_buf;
wire                                    gtp1_tx_src_rdy_n_buf;
wire                                    gtp1_tx_dst_rdy_n_buf;

// gtp clock signal
(* KEEP = "TRUE" *)
wire                                    gt0_gtrefclk0_common;
wire                                    gt0_qpllreset;
wire                                    gt0_qpllclk_quad2;
wire                                    gt0_qpllrefclk_quad2;
wire                                    gt1_qpllclk_quad2;
wire                                    gt1_qpllrefclk_quad2;
reg     [3:0]                           debounce_gt_rst_r;
wire												 pll_27m_locked;

wire	[15:0]									pkt_counter;
wire	[15:0]									gtp_err_cnt;

////////////////////////////////////////////////////////////////////
//lane up reset
////////////////////////////////////////////////////////////////////
always@(posedge clk27m_bufg)
begin
    if(counter[26]==1'b1)   //detect every 2 seconds
    begin
        dog_det_lane    <=  1'b1;
        counter         <=  {28{1'b0}};
    end
    else 
    begin
        dog_det_lane    <=  1'b0;
        counter         <=  counter + 'h1;
    end
end

always@(posedge clk27m_bufg)
begin
    if((lane_up==1'b1) && (channel_up==1'b1))
    begin
        serdes_relink   <=  1'b0;
    end
    else
    begin
        serdes_relink   <=  dog_det_lane;
    end
end
             
always@(posedge clk27m_bufg)
begin
    if(serdes_relink==1'b1)
    begin
        serdes_rst  <=  1'b1;
    end
    else if(counter[14]==1'b1)
    begin
        serdes_rst  <=  1'b0;
    end
end


////////////////////////////////////////////////////////////////////
//clock and reset
////////////////////////////////////////////////////////////////////
IBUFG u0_clk27m_bufg(
    .O                                  ( clk27m_bufg               ),
    .I                                  ( clk_27m                   )
    );
    
gen_rst u0_genrst(
    .clk                                ( clk27m_bufg               ),
    .rst_i                              ( rst_n		                 ),
    .rst_o                              ( rst_sys                   )
    );

s6_pll_27m u0_pll_27m(
    .CLK_IN1                            ( clk27m_bufg               ),
    .CLK_OUT1                           ( clk_cfg                   ),
    .CLK_OUT2                           ( clk_125m 	              ),
    .RESET                              ( rst_sys                   ),
    .LOCKED                             ( pll_27m_locked            )
    ); 

assign	rst = rst_sys | (~pll_27m_locked);

always @(posedge clk_125m)
begin
    debounce_gt_rst_r <=  {debounce_gt_rst_r[2:0],rst};
end

assign  gt0_qpllreset   =   (&debounce_gt_rst_r) || (|link_reset_gtx);

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
	  
////////////////////////////////////////////////////////////////////    
//gtp transceiver
////////////////////////////////////////////////////////////////////
gtx_rxtx u0_gtx_rxtx(
    .clk_cfg                            ( clk_cfg                   ),
    .rst_cfg									 ( rst                       ),
    .clk_gtp									 ( clk_gtp[0]                ),
    .rst_gtp									 ( rst_gtp[0]                ),
	 
	 .lane_up									 ( lane_up[0]                ),
    .channel_up								 ( channel_up[0]             ),
	 .link_reset_gtx							 ( link_reset_gtx[0]			  ),
    
	 .gtx_rx_data								 ( gtp0_rx_data				  ),
    .gtx_rx_sof_n								 ( gtp0_rx_sof_n				  ),
    .gtx_rx_eof_n								 ( gtp0_rx_eof_n				  ),
    .gtx_rx_dvalid_n							 ( gtp0_rx_dvalid_n			  ),
    
    .gtx_tx_data								 ( gtp0_tx_data_buf           ),
    .gtx_tx_sof_n								 ( gtp0_tx_sof_n_buf          ),
    .gtx_tx_eof_n								 ( gtp0_tx_eof_n_buf          ),
    .gtx_tx_src_rdy_n						 ( gtp0_tx_src_rdy_n_buf      ),
	 .gtx_tx_dst_rdy_n						 ( gtp0_tx_dst_rdy_n_buf      ),

    .gt_gtrefclk                        ( gt0_gtrefclk0_common       ),
	 .gt0_qpllclk_quad2                  ( gt0_qpllclk_quad2         ),
    .gt0_qpllrefclk_quad2               ( gt0_qpllrefclk_quad2      ),
	 
    .mgt_rxp									 ( mgt_rxp[0]                ),
    .mgt_rxn									 ( mgt_rxn[0]                ),
    .mgt_txp									 ( mgt_txp[0]                ),
    .mgt_txn									 ( mgt_txn[0]                )
    );	

gtx_rxtx u1_gtx_rxtx(
    .clk_cfg                            ( clk_cfg                   ),
    .rst_cfg									 ( rst                       ),
    .clk_gtp									 ( clk_gtp[1]                ),
    .rst_gtp									 ( rst_gtp[1]                ),
	 
	 .lane_up									 ( lane_up[1]                ),
    .channel_up								 ( channel_up[1]             ),
	 .link_reset_gtx							 ( link_reset_gtx[1]			  ),
    
	 .gtx_rx_data								 ( gtp1_rx_data					),
    .gtx_rx_sof_n								 ( gtp1_rx_sof_n					),
    .gtx_rx_eof_n								 ( gtp1_rx_eof_n					),
    .gtx_rx_dvalid_n							 ( gtp1_rx_dvalid_n				),
    
    .gtx_tx_data								 ( gtp1_tx_data_buf           ),
    .gtx_tx_sof_n								 ( gtp1_tx_sof_n_buf          ),
    .gtx_tx_eof_n								 ( gtp1_tx_eof_n_buf          ),
    .gtx_tx_src_rdy_n						 ( gtp1_tx_src_rdy_n_buf      ),
	 .gtx_tx_dst_rdy_n						 ( gtp1_tx_dst_rdy_n_buf      ),

    .gt_gtrefclk                        ( gt0_gtrefclk0_common      ),
	 .gt0_qpllclk_quad2                  ( gt0_qpllclk_quad2         ),
    .gt0_qpllrefclk_quad2               ( gt0_qpllrefclk_quad2      ),
	 
    .mgt_rxp									 ( mgt_rxp[1]                ),
    .mgt_rxn									 ( mgt_rxn[1]                ),
    .mgt_txp									 ( mgt_txp[1]                ),
    .mgt_txn									 ( mgt_txn[1]                )
    );
wire												frame_channel_up;
assign	frame_channel_up	=	(channel_up[0] );//| channel_up[1]);	 
aurora_8b10b_v8_3_FRAME_GEN frame_gen_i(
    // User Interface
    .TX_D                               ( gtp0_tx_data_buf             ),
    .TX_REM                             ( /*not used*/              ),
    .TX_SOF_N                           ( gtp0_tx_sof_n_buf            ),
    .TX_EOF_N                           ( gtp0_tx_eof_n_buf            ),
    .TX_SRC_RDY_N                       ( gtp0_tx_src_rdy_n_buf        ),
    .TX_DST_RDY_N                       ( gtp0_tx_dst_rdy_n_buf        ),      
    // System Interface
    .USER_CLK                           ( clk_gtp[0]                   ),      
    .RESET                              ( rst_gtp[0]                   ),
    .CHANNEL_UP                         ( frame_channel_up          )
    );
/*
aurora_8b10b_v8_3_FRAME_CHECK u0_gtp_check(
	 .RX_D										( gtp1_rx_data						),
	 .RX_REM										( 1'b0								),
	 .RX_SOF_N									( gtp1_rx_sof_n					),
	 .RX_EOF_N									( gtp1_rx_eof_n					),
	 .RX_SRC_RDY_N								( gtp1_src_rdy_n					),
	 
	 .USER_CLK									( clk_gtp[1]						),
	 .RESET										( rst_gtp[1]						),
	 .CHANNEL_UP								( channel_up[1]					),
	 .pkt_counter								( pkt_counter						),
	 .gtp_err_cnt								( gtp_err_cnt						)
	 );
*/
wire												channel_up0_err;
wire												channel_up1_err;
reg	[23:0]									channel_up0_cnt;
reg	[23:0]									channel_up1_cnt;

always@(posedge clk_gtp[0] or posedge rst_gtp[0])
begin
	if(rst_gtp[0] == 1'b1)
	begin
		channel_up0_cnt	<=	{24{1'b0}};
	end
	else if(channel_up[0] == 1'b0)
	begin
		channel_up0_cnt	<=	channel_up0_cnt	+ 24'b1;
	end
end

always@(posedge clk_gtp[1] or posedge rst_gtp[1])
begin
	if(rst_gtp[1] == 1'b1)
	begin
		channel_up1_cnt	<=	{24{1'b0}};
	end
	else if(channel_up[1] == 1'b0)
	begin
		channel_up1_cnt	<=	channel_up1_cnt	+ 24'b1;
	end
end

(* KEEP = "TRUE" *)
assign	channel_up0_err				=	|channel_up0_cnt;
(* KEEP = "TRUE" *)
assign	channel_up1_err				=	|channel_up1_cnt;

assign  gpio_led							=   {channel_up[1],channel_up[0],run_led,channel_up1_err,channel_up0_err};
/*
assign  gtp1_tx_data_buf     				=   gtp_tx_data_t;
assign  gtp1_tx_sof_n_buf    				=   gtp_tx_sof_n_t;
assign  gtp1_tx_eof_n_buf    				=   gtp_tx_eof_n_t;
assign  gtp1_tx_src_rdy_n_buf				=   gtp_tx_src_rdy_n_t;
assign  gtp1_tx_dst_rdy_n_buf				=	 gtp_tx_dst_rdy_n_t;
*/
////////////////////////////////////////////////////////////////////
//run led
////////////////////////////////////////////////////////////////////
reg     [25:0]                          led_cnt                     ;

always@(posedge clk_gtp[0] or posedge rst_gtp[0])
begin
    if(rst_gtp[0]==1'b1)
    begin
        led_cnt <=  {26{1'b0}};
    end
    else
    begin
        led_cnt <=  led_cnt + 'h1;
    end
end

assign  run_led =   led_cnt[25];
    
endmodule
