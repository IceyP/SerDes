///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//
///////////////////////////////////////////////////////////////////////////////
//
//  aurora_8b10b_v8_3
//
//
//  Description: This is the top level module for a 1 2-byte lane Aurora
//               reference design module. This module supports the following features:
//
//


`timescale 1 ns / 1 ps
(* core_generation_info = "aurora_8b10b_v8_3,aurora_8b10b_v8_3,{user_interface=AXI_4_Streaming,backchannel_mode=Sidebands,c_aurora_lanes=1,c_column_used=left,c_gt_clock_1=GTXQ1,c_gt_clock_2=None,c_gt_loc_1=X,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=X,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=X,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=X,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=1,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=false,c_simplex_mode=TX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=Duplex}" *)
module aurora_8b10b_v8_3 #
(
     parameter   SIM_GTRESET_SPEEDUP=   "FALSE"      // Set to 'TRUE' to speed up sim reset
)
(
    // AXI TX Interface
    S_AXI_TX_TDATA,
    S_AXI_TX_TKEEP,
    S_AXI_TX_TVALID,
    S_AXI_TX_TLAST,
    S_AXI_TX_TREADY,

    // AXI RX Interface
    M_AXI_RX_TDATA,
    M_AXI_RX_TKEEP,
    M_AXI_RX_TVALID,
    M_AXI_RX_TLAST,

    // GT Serial I/O
    RXP,
    RXN,
    TXP,
    TXN,

    // GT Reference Clock Interface
    GT_REFCLK1,

    // Error Detection Interface
    HARD_ERR,
    SOFT_ERR,
    FRAME_ERR,

    // Status
    CHANNEL_UP,
    LANE_UP,

    // Clock Compensation Control Interface
    WARN_CC,
    DO_CC,

    // System Interface
    USER_CLK,
    SYNC_CLK,
    RESET,
    POWER_DOWN,
    LOOPBACK,
    GT_RESET,
    LINK_RESET_OUT,
    INIT_CLK_IN,
    PLL_NOT_LOCKED,
    TX_RESETDONE_OUT,
    RX_RESETDONE_OUT,
    DRPADDR_IN,
    DRPCLK_IN,
    DRPDI_IN,
    DRPDO_OUT,
    DRPEN_IN,
    DRPRDY_OUT,
    DRPWE_IN,
    TX_OUT_CLK,
    TX_LOCK
);


`define DLY #1

//***********************************Port Declarations*******************************

    // AXI TX Interface
    input   [0:15]     S_AXI_TX_TDATA;
    input   [0:1]      S_AXI_TX_TKEEP;
    input              S_AXI_TX_TVALID;
    input              S_AXI_TX_TLAST;

    output             S_AXI_TX_TREADY;

    // AXI RX Interface
    output  [0:15]     M_AXI_RX_TDATA;
    output  [0:1]      M_AXI_RX_TKEEP;
    output             M_AXI_RX_TVALID;
    output             M_AXI_RX_TLAST;



    // GT Serial I/O
    input              RXP;
    input              RXN;

    output             TXP;
    output             TXN;

    // GT Reference Clock Interface
    input              GT_REFCLK1;

    // Error Detection Interface
    output             HARD_ERR;
    output             SOFT_ERR;
    output             FRAME_ERR;

    // Status
    output             CHANNEL_UP;
    output             LANE_UP;

    // Clock Compensation Control Interface
    input              WARN_CC;
    input              DO_CC;

    // System Interface
    input              USER_CLK;
    input              SYNC_CLK;
    input              RESET;
    input              POWER_DOWN;
    input   [2:0]      LOOPBACK;
    input              GT_RESET;
    output             TX_LOCK;
    output             TX_OUT_CLK;
    input              INIT_CLK_IN;
    input              PLL_NOT_LOCKED;
    output             TX_RESETDONE_OUT;
    output             RX_RESETDONE_OUT;
    output             LINK_RESET_OUT;

    //DRP Ports
    input   [8:0]     DRPADDR_IN; 
    input             DRPCLK_IN; 
    input             DRPEN_IN; 
    input   [15:0]    DRPDI_IN; 
    output            DRPRDY_OUT; 
    output  [15:0]    DRPDO_OUT; 
    input             DRPWE_IN; 
//*********************************Wire Declarations**********************************

    wire    [15:0]     open_i;

    wire               TX1N_OUT_unused;
    wire               TX1P_OUT_unused;
    wire               RX1N_IN_unused;
    wire               RX1P_IN_unused;
    wire               rx_buf_err_i_unused;
    wire    [1:0]      rx_char_is_comma_i_unused;
    wire    [1:0]      rx_char_is_k_i_unused;
    wire    [15:0]     rx_data_i_unused;
    wire    [1:0]      rx_disp_err_i_unused;
    wire    [1:0]      rx_not_in_table_i_unused;
    wire               rx_realign_i_unused;
    wire               tx_buf_err_i_unused;
    wire               ch_bond_done_i_unused;

    wire               ch_bond_done_i;
    reg                ch_bond_done_r1;
    reg                ch_bond_done_r2;
    wire               channel_bond_load_i;
    wire               channel_up_i;
    wire               en_chan_sync_i;
    wire               ena_comma_align_i;
    wire               gen_a_i;
    wire               gen_cc_i;
    wire               gen_ecp_i;
    wire    [0:1]      gen_k_i;
    wire               gen_pad_i;
    wire    [0:1]      gen_r_i;
    wire               gen_scp_i;
    wire    [0:1]      gen_v_i;
    wire    [0:1]      got_a_i;
    wire               got_v_i;
    wire               hard_err_i;
    wire               lane_up_i;
    wire               open_rx_rec1_clk_i;
    wire               open_rx_rec2_clk_i;
    wire          link_reset_lane0_i;
    wire          link_reset_i;
    wire               raw_tx_out_clk_i;
    wire               reset_lanes_i;
    wire               rx_buf_err_i;
    wire    [1:0]      rx_char_is_comma_i;
    wire    [1:0]      rx_char_is_k_i;
    wire    [2:0]      rx_clk_cor_cnt_i;
    wire    [15:0]     rx_data_i;
    wire    [1:0]      rx_disp_err_i;
    wire               rx_ecp_i;
    wire    [1:0]      rx_not_in_table_i;
    wire               rx_pad_i;
    wire    [0:15]     rx_pe_data_i;
    wire               rx_pe_data_v_i;
    wire               rx_polarity_i;
    wire               rx_realign_i;
    wire               rx_reset_i;
    wire               rx_scp_i;
    wire               soft_err_i;
    wire               start_rx_i;
    wire               tied_to_ground_i;
    wire    [47:0]     tied_to_ground_vec_i;
    wire               tied_to_vcc_i;
    wire               tx_buf_err_i;
    wire    [1:0]      tx_char_is_k_i;
    wire    [15:0]     tx_data_i;
    wire               tx_lock_i;
    wire    [0:15]     tx_pe_data_i;
    wire               tx_pe_data_v_i;
    wire               tx_reset_i;

   

    wire    [0:15]     tied_to_gnd_vec_i;
    // TX AXI PDU I/F wires
    wire    [0:15]     tx_data;
    wire               tx_rem;
    wire               tx_src_rdy;
    wire               tx_sof;
    wire               tx_eof;
    wire               tx_dst_rdy;

    // RX AXI PDU I/F wires
    wire    [0:15]     rx_data;
    wire               rx_rem;
    wire               rx_src_rdy;
    wire               rx_sof;
    wire               rx_eof;

//*********************************Main Body of Code**********************************

    // Tie off top level constants
    assign          tied_to_gnd_vec_i       = 16'd0;
    assign          tied_to_ground_vec_i    = 64'd0;
    assign          tied_to_ground_i        = 1'b0;
    assign          tied_to_vcc_i           = 1'b1;

    // Connect top level logic
    assign          CHANNEL_UP  =   channel_up_i;

    //Connect the TXOUTCLK of lane 0 to TX_OUT_CLK
    assign  TX_OUT_CLK  =   raw_tx_out_clk_i;
 

    // Connect TX_LOCK to tx_lock_i from lane 0
    assign  TX_LOCK   =   &tx_lock_i;

    assign  link_reset_i   = link_reset_lane0_i;
    assign  LINK_RESET_OUT = link_reset_i;

    //_________________________Instantiate Lane 0______________________________


    assign          LANE_UP =   lane_up_i;

    aurora_8b10b_v8_3_AURORA_LANE aurora_lane_0_i
    (
        // GT Interface
        .RX_DATA(rx_data_i[15:0]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[1:0]),
        .RX_DISP_ERR(rx_disp_err_i[1:0]),
        .RX_CHAR_IS_K(rx_char_is_k_i[1:0]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[1:0]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i),
        .RX_BUF_ERR(rx_buf_err_i),
        .RX_REALIGN(rx_realign_i),
        .RX_POLARITY(rx_polarity_i),
        .RX_RESET(rx_reset_i),
        .TX_CHAR_IS_K(tx_char_is_k_i[1:0]),
        .TX_DATA(tx_data_i[15:0]),
        .TX_RESET(tx_reset_i),
        .INIT_CLK(INIT_CLK_IN),
        .LINK_RESET_OUT(link_reset_lane0_i),

        // Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i),

        // TX_LL Interface
        .GEN_SCP(gen_scp_i),
        .GEN_ECP(gen_ecp_i),
        .GEN_PAD(gen_pad_i),
        .TX_PE_DATA(tx_pe_data_i[0:15]),
        .TX_PE_DATA_V(tx_pe_data_v_i),
        .GEN_CC(gen_cc_i),

        // RX_LL Interface
        .RX_PAD(rx_pad_i),
        .RX_PE_DATA(rx_pe_data_i[0:15]),
        .RX_PE_DATA_V(rx_pe_data_v_i),
        .RX_SCP(rx_scp_i),
        .RX_ECP(rx_ecp_i),

        // Global Logic Interface
        .GEN_A(gen_a_i),
        .GEN_K(gen_k_i[0:1]),
        .GEN_R(gen_r_i[0:1]),
        .GEN_V(gen_v_i[0:1]),
        .LANE_UP(lane_up_i),
        .SOFT_ERR(soft_err_i),
        .HARD_ERR(hard_err_i),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[0:1]),
        .GOT_V(got_v_i),
	.CHANNEL_UP(channel_up_i),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i)
    );


    //_________________________Instantiate GT Wrapper ______________________________
    aurora_8b10b_v8_3_GT_WRAPPER #
    (
         .SIM_GTRESET_SPEEDUP(SIM_GTRESET_SPEEDUP)
    )

    gt_wrapper_i
    (
        // DRP I/F
        .DRPADDR_IN                     (DRPADDR_IN),
        .DRPCLK_IN                      (DRPCLK_IN),
        .DRPDI_IN                       (DRPDI_IN),
        .DRPDO_OUT                      (DRPDO_OUT),
        .DRPEN_IN                       (DRPEN_IN),
        .DRPRDY_OUT                     (DRPRDY_OUT),
        .DRPWE_IN                       (DRPWE_IN),

        .INIT_CLK_IN                    (INIT_CLK_IN),   
	.PLL_NOT_LOCKED                 (PLL_NOT_LOCKED),
	.TX_RESETDONE_OUT               (TX_RESETDONE_OUT),
	.RX_RESETDONE_OUT               (RX_RESETDONE_OUT),
        // Aurora Lane Interface
        .RXPOLARITY_IN(rx_polarity_i),
        .RXRESET_IN(rx_reset_i),
        .TXCHARISK_IN(tx_char_is_k_i[1:0]),
        .TXDATA_IN(tx_data_i[15:0]),
        .TXRESET_IN(tx_reset_i),
        .RXDATA_OUT(rx_data_i[15:0]),
        .RXNOTINTABLE_OUT(rx_not_in_table_i[1:0]),
        .RXDISPERR_OUT(rx_disp_err_i[1:0]),
        .RXCHARISK_OUT(rx_char_is_k_i[1:0]),

        .RXCHARISCOMMA_OUT(rx_char_is_comma_i[1:0]),
        .RXREALIGN_OUT(rx_realign_i),
        .RXBUFERR_OUT(rx_buf_err_i),
        .TXBUFERR_OUT(tx_buf_err_i),

        // reset for hot plug
        .LINK_RESET_IN(link_reset_i),

        // Phase Align Interface
        .ENMCOMMAALIGN_IN(ena_comma_align_i),
        .ENPCOMMAALIGN_IN(ena_comma_align_i),

        // Global Logic Interface
        .ENCHANSYNC_IN(en_chan_sync_i),
        .CHBONDDONE_OUT(ch_bond_done_i),

        // Serial IO
        .RX1N_IN(RXN),
        .RX1P_IN(RXP),
        .TX1N_OUT(TXN),
        .TX1P_OUT(TXP),

        // Clocks and Clock Status
        .RXUSRCLK_IN(SYNC_CLK),
        .RXUSRCLK2_IN(USER_CLK),
        .TXUSRCLK_IN(SYNC_CLK),
        .TXUSRCLK2_IN(USER_CLK),
        .REFCLK(GT_REFCLK1),

        .TXOUTCLK1_OUT(raw_tx_out_clk_i),

        .PLLLKDET_OUT(tx_lock_i),
        // System Interface
        .GTRESET_IN(GT_RESET),
        .LOOPBACK_IN(LOOPBACK),
        .POWERDOWN_IN(POWER_DOWN)
 );

    //__________Instantiate Global Logic to combine Lanes into a Channel_____


aurora_8b10b_v8_3_GLOBAL_LOGIC    global_logic_i
    (
        //GTP Interface
        .CH_BOND_DONE(ch_bond_done_i),
        .EN_CHAN_SYNC(en_chan_sync_i),

        // Aurora Lane Interface
        .LANE_UP(lane_up_i),
        .SOFT_ERR(soft_err_i),
        .HARD_ERR(hard_err_i),
        .CHANNEL_BOND_LOAD(ch_bond_done_i),
        .GOT_A(got_a_i),
        .GOT_V(got_v_i),
        .GEN_A(gen_a_i),
        .GEN_K(gen_k_i),
        .GEN_R(gen_r_i),
        .GEN_V(gen_v_i),
        .RESET_LANES(reset_lanes_i),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET),
        .POWER_DOWN(POWER_DOWN),
        .CHANNEL_UP(channel_up_i),
        .START_RX(start_rx_i),
        .CHANNEL_SOFT_ERR(SOFT_ERR),
        .CHANNEL_HARD_ERR(HARD_ERR)
    );

    //_____________________________ TX AXI SHIM _______________________________
    aurora_8b10b_v8_3_AXI_TO_LL #
    (
       .DATA_WIDTH(16),
       .STRB_WIDTH(2),
       .REM_WIDTH (1)
    )

    axi_to_ll_pdu_i
    (
     .AXI4_S_IP_TX_TVALID(S_AXI_TX_TVALID),
     .AXI4_S_IP_TX_TREADY(S_AXI_TX_TREADY),
     .AXI4_S_IP_TX_TDATA(S_AXI_TX_TDATA),
     .AXI4_S_IP_TX_TKEEP(S_AXI_TX_TKEEP),
     .AXI4_S_IP_TX_TLAST(S_AXI_TX_TLAST),

     .LL_OP_DATA(tx_data),
     .LL_OP_SOF_N(tx_sof),
     .LL_OP_EOF_N(tx_eof),
     .LL_OP_REM(tx_rem),
     .LL_OP_SRC_RDY_N(tx_src_rdy),
     .LL_IP_DST_RDY_N(tx_dst_rdy),

     // System Interface
     .USER_CLK(USER_CLK),
     .RESET(RESET), 
     .CHANNEL_UP(channel_up_i)
    );


    //_____________________________Instantiate TX_LL___________________________


    aurora_8b10b_v8_3_TX_LL tx_ll_i
    (
        // AXI PDU Interface
        .TX_D(tx_data),
        .TX_REM(tx_rem),
        .TX_SRC_RDY_N(tx_src_rdy),
        .TX_SOF_N(tx_sof),
        .TX_EOF_N(tx_eof),
        .TX_DST_RDY_N(tx_dst_rdy),

        // Clock Compenstaion Interface
        .WARN_CC(WARN_CC),
        .DO_CC(DO_CC),

        // Global Logic Interface
        .CHANNEL_UP(channel_up_i),

        // Aurora Lane Interface
        .GEN_SCP(gen_scp_i),
        .GEN_ECP(gen_ecp_i),
        .TX_PE_DATA_V(tx_pe_data_v_i),
        .GEN_PAD(gen_pad_i),
        .TX_PE_DATA(tx_pe_data_i),
        .GEN_CC(gen_cc_i),

        // System Interface
        .USER_CLK(USER_CLK)
    );

    //_____________________________ RX AXI SHIM _______________________________
    aurora_8b10b_v8_3_LL_TO_AXI #
    (
       .DATA_WIDTH(16),
       .STRB_WIDTH(2),
       .REM_WIDTH (1)
    )

    ll_to_axi_pdu_i
    (
     .LL_IP_DATA(rx_data),
     .LL_IP_SOF_N(rx_sof),
     .LL_IP_EOF_N(rx_eof),
     .LL_IP_REM(rx_rem),
     .LL_IP_SRC_RDY_N(rx_src_rdy),
     .LL_OP_DST_RDY_N(),

     .AXI4_S_OP_TVALID(M_AXI_RX_TVALID),
     .AXI4_S_OP_TDATA(M_AXI_RX_TDATA),
     .AXI4_S_OP_TKEEP(M_AXI_RX_TKEEP),
     .AXI4_S_OP_TLAST(M_AXI_RX_TLAST),
     .AXI4_S_IP_TREADY()

    );


    //______________________________________Instantiate RX_LL__________________________________

    aurora_8b10b_v8_3_RX_LL   rx_ll_i
    (
        // AXI PDU Interface
        .RX_D(rx_data),
        .RX_REM(rx_rem),
        .RX_SRC_RDY_N(rx_src_rdy),
        .RX_SOF_N(rx_sof),
        .RX_EOF_N(rx_eof),

        // Global Logic Interface
        .START_RX(start_rx_i),

        // Aurora Lane Interface
        .RX_PAD(rx_pad_i),
        .RX_PE_DATA(rx_pe_data_i),
        .RX_PE_DATA_V(rx_pe_data_v_i),
        .RX_SCP(rx_scp_i),
        .RX_ECP(rx_ecp_i),

        // Error Interface
        .FRAME_ERR(FRAME_ERR),

        // System Interface
        .USER_CLK(USER_CLK)
    );

endmodule
