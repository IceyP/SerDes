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
//  AURORA_EXAMPLE
//
//  Aurora Generator
//
//
//  Description: Sample Instantiation of a 1 2-byte lane module.
//               Only tests initialization in hardware.
//
//        
`timescale 1 ns / 1 ps
(* core_generation_info = "aurora_8b10b_gtx6,aurora_8b10b_v8_3,{user_interface=AXI_4_Streaming,backchannel_mode=Sidebands,c_aurora_lanes=1,c_column_used=left,c_gt_clock_1=GTXQ0,c_gt_clock_2=None,c_gt_loc_1=1,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=X,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=X,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=X,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=false,c_simplex_mode=TX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=Duplex}" *)
module aurora_8b10b_gtx6_exdes #
(
     parameter   USE_CHIPSCOPE        = 0,
     parameter   SIM_GTRESET_SPEEDUP  = "TRUE"
)
(
    // User IO
    RESET,
    HARD_ERR,
    SOFT_ERR,
    FRAME_ERR,
    ERR_COUNT,

    LANE_UP,
    CHANNEL_UP,

    INIT_CLK_P,
    INIT_CLK_N,
    GT_RESET_IN,
    GTXQ0_P,
    GTXQ0_N,
    // GT I/O
    RXP,
    RXN,
    TXP,
    TXN
);


//***********************************Port Declarations*******************************
    // User I/O
    input              RESET;
    input              INIT_CLK_P;
    input              INIT_CLK_N;
    input              GT_RESET_IN;
    output             HARD_ERR;
    output             SOFT_ERR;
    output             FRAME_ERR;
    output  [0:7]      ERR_COUNT;


    output             LANE_UP;
    output             CHANNEL_UP;
    // Clocks
    input              GTXQ0_P;
    input              GTXQ0_N;


    // GT Serial I/O
    input              RXP;
    input              RXN;
    output             TXP;
    output             TXN;

//**************************External Register Declarations****************************
    reg                HARD_ERR;
    reg                SOFT_ERR;
    reg                FRAME_ERR;
    reg     [0:7]      ERR_COUNT;   
    reg                LANE_UP;
    reg                CHANNEL_UP;
//********************************Wire Declarations**********************************
    // LocalLink TX Interface
    wire    [0:15]     tx_d_i;
    wire               tx_rem_i;
    wire               tx_src_rdy_n_i;
    wire               tx_sof_n_i;
    wire               tx_eof_n_i;
    wire               tx_dst_rdy_n_i;
    // LocalLink RX Interface
    wire    [0:15]     rx_d_i;
    wire               rx_rem_i;
    wire               rx_src_rdy_n_i;
    wire               rx_sof_n_i;
    wire               rx_eof_n_i;
    // GT Reference Clock Interface
    wire               GT_REFCLK1;

    // Error Detection Interface
    wire               hard_err_i;
    wire               soft_err_i;
    wire               frame_err_i;
    // Status
    wire               channel_up_i;
    wire               lane_up_i;
    // Clock Compensation Control Interface
    wire               warn_cc_i;
    wire               do_cc_i;
    // System Interface
    wire               pll_not_locked_i;
    wire               user_clk_i;
    wire               sync_clk_i;
    wire               reset_i;
    wire               power_down_i;
    wire    [2:0]      loopback_i;
    wire               tx_lock_i;
    wire               link_reset_i;
    wire               tx_resetdone_i;
    wire               rx_resetdone_i;
    (* KEEP = "TRUE" *) wire               init_clk_i;
    wire    [8:0]     daddr_in_i;
    wire              dclk_in_i;
    wire              den_in_i;
    wire    [15:0]    di_in_i;
    wire              drdy_out_unused_i;
    wire    [15:0]    drpdo_out_unused_i;
    wire              dwe_in_i;

    wire               tx_out_clk_i;

    wire               gt_reset_i;
    wire               system_reset_i;
    //Frame check signals
    wire    [0:7]      err_count_i;

    wire [35:0] icon_to_vio_i;
    wire [63:0] sync_in_i;
    wire [15:0] sync_out_i;

    wire        lane_up_i_i;
    wire        tx_lock_i_i;
    wire        lane_up_reduce_i;
    wire        rst_cc_module_i;

    wire    [0:15]     tied_to_gnd_vec_i;
    // TX AXI PDU I/F wires
    wire    [0:15]     tx_data_i;
    wire               tx_tvalid_i;
    wire               tx_tready_i;
    wire    [0:1]      tx_tkeep_i;
    wire               tx_tlast_i;

    // RX AXI PDU I/F wires
    wire    [0:15]     rx_data_i;
    wire               rx_tvalid_i;
    wire    [0:1]      rx_tkeep_i;
    wire               rx_tlast_i;
    reg               lane_up_r;
    reg               lane_up_r2;
//*********************************Main Body of Code**********************************

  //SLACK registers
  always @ (posedge user_clk_i)
  begin
    lane_up_r    <=  lane_up_i;
    lane_up_r2   <=  lane_up_r;
  end

  assign lane_up_reduce_i  = &lane_up_r2;
  assign rst_cc_module_i   = !lane_up_reduce_i;

//_______________________________Clock Buffers_________________________________
 IBUFDS_GTE2 IBUFDS_GTE2_CLK1
 (
 .I(GTXQ0_P),
 .IB(GTXQ0_N),
 .CEB(1'b0),
 .O(GT_REFCLK1),
 .ODIV2()
 );


    // Instantiate a clock module for clock division.
    aurora_8b10b_gtx6_CLOCK_MODULE clock_module_i
    (
        .GT_CLK(tx_out_clk_i),
        .GT_CLK_LOCKED(tx_lock_i),
        .USER_CLK(user_clk_i),
        .SYNC_CLK(sync_clk_i),
        .PLL_NOT_LOCKED(pll_not_locked_i)
    );

//____________________________Register User I/O___________________________________
// Register User Outputs from core.

    always @(posedge user_clk_i)
    begin
        HARD_ERR      <=  hard_err_i;
        SOFT_ERR      <=  soft_err_i;
        FRAME_ERR     <=  frame_err_i;
        ERR_COUNT       <=  err_count_i;
        LANE_UP         <=  lane_up_i;
        CHANNEL_UP      <=  channel_up_i;
    end

//____________________________Tie off unused signals_______________________________

    // System Interface
    assign  tied_to_gnd_vec_i   =   16'd0;
    assign  power_down_i        =   1'b0;
    assign  loopback_i          =   3'b000;

    assign  daddr_in_i  =  9'h0;
    assign  dclk_in_i   =  1'b0;
    assign  den_in_i    =  1'b0;
    assign  di_in_i     =  16'h0;
    assign  dwe_in_i    =  1'b0;
//___________________________Module Instantiations_________________________________
    aurora_8b10b_gtx6 #
    (
        .SIM_GTRESET_SPEEDUP(SIM_GTRESET_SPEEDUP)
    )
    aurora_module_i
    (
        // AXI TX Interface
        .S_AXI_TX_TDATA(tx_data_i),
        .S_AXI_TX_TKEEP(tx_tkeep_i),
        .S_AXI_TX_TVALID(tx_tvalid_i),
        .S_AXI_TX_TLAST(tx_tlast_i),
        .S_AXI_TX_TREADY(tx_tready_i),

        // AXI RX Interface
        .M_AXI_RX_TDATA(rx_data_i),
        .M_AXI_RX_TKEEP(rx_tkeep_i),
        .M_AXI_RX_TVALID(rx_tvalid_i),
        .M_AXI_RX_TLAST(rx_tlast_i),
        // V5 Serial I/O
        .RXP(RXP),
        .RXN(RXN),
        .TXP(TXP),
        .TXN(TXN),
        // V5 Reference Clock Interface
        .GT_REFCLK1(GT_REFCLK1),
        // Error Detection Interface
        .HARD_ERR(hard_err_i),
        .SOFT_ERR(soft_err_i),
        .FRAME_ERR(frame_err_i),


        // Status
        .CHANNEL_UP(channel_up_i),
        .LANE_UP(lane_up_i),
        // Clock Compensation Control Interface
        .WARN_CC(warn_cc_i),
        .DO_CC(do_cc_i),
        // System Interface
        .USER_CLK(user_clk_i),
        .SYNC_CLK(sync_clk_i),
        .RESET(reset_i),
        .POWER_DOWN(power_down_i),
        .LOOPBACK(loopback_i),
        .GT_RESET(gt_reset_i),
        .TX_LOCK(tx_lock_i),
        .INIT_CLK_IN(init_clk_i),
        .PLL_NOT_LOCKED(pll_not_locked_i),
	.TX_RESETDONE_OUT(tx_resetdone_i),
	.RX_RESETDONE_OUT(rx_resetdone_i),
        .LINK_RESET_OUT(link_reset_i),
        .DRPADDR_IN  (daddr_in_i),
        .DRPCLK_IN   (dclk_in_i),
        .DRPEN_IN    (den_in_i),
        .DRPDI_IN     (di_in_i),
        .DRPRDY_OUT  (drdy_out_unused_i),
        .DRPDO_OUT (drpdo_out_unused_i),
        .DRPWE_IN    (dwe_in_i),
        .TX_OUT_CLK(tx_out_clk_i)
    );

    aurora_8b10b_gtx6_STANDARD_CC_MODULE standard_cc_module_i
    (
        .RESET(rst_cc_module_i),
        // Clock Compensation Control Interface
        .WARN_CC(warn_cc_i),
        .DO_CC(do_cc_i),
        // System Interface
        .PLL_NOT_LOCKED(pll_not_locked_i),
        .USER_CLK(user_clk_i)
    );

    aurora_8b10b_gtx6_RESET_LOGIC reset_logic_i
    (
        .RESET(RESET),
        .USER_CLK(user_clk_i),
        .INIT_CLK_P(INIT_CLK_P),
        .INIT_CLK_N(INIT_CLK_N),
        .GT_RESET_IN(GT_RESET_IN),
        .TX_LOCK_IN(tx_lock_i),
        .PLL_NOT_LOCKED(pll_not_locked_i),
	.TX_RESETDONE_IN(tx_resetdone_i),
	.RX_RESETDONE_IN(rx_resetdone_i),
        .LINK_RESET_IN(link_reset_i),
        .INIT_CLK_O(init_clk_i),
        .SYSTEM_RESET(system_reset_i),
        .GT_RESET_OUT(gt_reset_i)
    );

    //_____________________________ TX AXI SHIM _______________________________
    aurora_8b10b_gtx6_LL_TO_AXI #
    (
       .DATA_WIDTH(16),
       .STRB_WIDTH(2),
       .REM_WIDTH (1)
    )

    frame_gen_ll_to_axi_pdu_i
    (
     // LocalLink input Interface
     .LL_IP_DATA(tx_d_i),
     .LL_IP_SOF_N(tx_sof_n_i),
     .LL_IP_EOF_N(tx_eof_n_i),
     .LL_IP_REM(tx_rem_i),
     .LL_IP_SRC_RDY_N(tx_src_rdy_n_i),
     .LL_OP_DST_RDY_N(tx_dst_rdy_n_i),

     // AXI4-S output signals
     .AXI4_S_OP_TVALID(tx_tvalid_i),
     .AXI4_S_OP_TDATA(tx_data_i),
     .AXI4_S_OP_TKEEP(tx_tkeep_i),
     .AXI4_S_OP_TLAST(tx_tlast_i),
     .AXI4_S_IP_TREADY(tx_tready_i)
    );

    //Connect a frame generator to the TX User interface
    aurora_8b10b_gtx6_FRAME_GEN frame_gen_i
    (
        // User Interface
        .TX_D(tx_d_i), 
        .TX_REM(tx_rem_i),    
        .TX_SOF_N(tx_sof_n_i),      
        .TX_EOF_N(tx_eof_n_i),
        .TX_SRC_RDY_N(tx_src_rdy_n_i),
        .TX_DST_RDY_N(tx_dst_rdy_n_i),


        // System Interface
        .USER_CLK(user_clk_i),      
        .RESET(reset_i),
        .CHANNEL_UP(channel_up_i)
    );
    //_____________________________ RX AXI SHIM _______________________________
    aurora_8b10b_gtx6_AXI_TO_LL #
    (
       .DATA_WIDTH(16),
       .STRB_WIDTH(2),
       .REM_WIDTH (1)
    )
    frame_chk_axi_to_ll_pdu_i
    (
     // AXI4-S input signals
     .AXI4_S_IP_TX_TVALID(rx_tvalid_i),
     .AXI4_S_IP_TX_TREADY(),
     .AXI4_S_IP_TX_TDATA(rx_data_i),
     .AXI4_S_IP_TX_TKEEP(rx_tkeep_i),
     .AXI4_S_IP_TX_TLAST(rx_tlast_i),

     // LocalLink output Interface
     .LL_OP_DATA(rx_d_i),
     .LL_OP_SOF_N(rx_sof_n_i),
     .LL_OP_EOF_N(rx_eof_n_i) ,
     .LL_OP_REM(rx_rem_i) ,
     .LL_OP_SRC_RDY_N(rx_src_rdy_n_i),
     .LL_IP_DST_RDY_N(1'b0),

     // System Interface
     .USER_CLK(user_clk_i),      
     .RESET(reset_i),
     .CHANNEL_UP(channel_up_i)
     );

    aurora_8b10b_gtx6_FRAME_CHECK frame_check_i
    (
        // User Interface
        .RX_D(rx_d_i), 
        .RX_REM(rx_rem_i),    
        .RX_SOF_N(rx_sof_n_i),      
        .RX_EOF_N(rx_eof_n_i),
        .RX_SRC_RDY_N(rx_src_rdy_n_i),

        // System Interface
        .USER_CLK(user_clk_i),      
        .RESET(reset_i),
        .CHANNEL_UP(channel_up_i),
        .ERR_COUNT(err_count_i)
    );   


generate
if (USE_CHIPSCOPE==1)
begin : chipscope1


assign lane_up_i_i = &lane_up_i;
assign tx_lock_i_i = tx_lock_i;

    // Shared VIO Inputs
        assign  sync_in_i[15:0]         =  tx_d_i;
        assign  sync_in_i[31:16]        =  rx_d_i;
        assign  sync_in_i[39:32]        =  err_count_i;
        assign  sync_in_i[56:40]        =  17'd0;
        assign  sync_in_i[57]           =  frame_err_i;
        assign  sync_in_i[58]           =  soft_err_i;
        assign  sync_in_i[59]           =  hard_err_i;
        assign  sync_in_i[60]           =  tx_lock_i_i;
        assign  sync_in_i[61]           =  pll_not_locked_i;
        assign  sync_in_i[62]           =  channel_up_i;
        assign  sync_in_i[63]           =  lane_up_i_i;

 

  //-----------------------------------------------------------------
  //  VIO core instance
  //-----------------------------------------------------------------
  v7_vio i_vio
 
    (
      .control(icon_to_vio_i),
      .clk(user_clk_i),
      .sync_in(sync_in_i),
      .sync_out(sync_out_i)
    );

  //-----------------------------------------------------------------
  //  ICON core instance
  //-----------------------------------------------------------------
  v7_icon i_icon
 
    (
      .control0(icon_to_vio_i)
    );
 
                                                                                                                                                                      
end //end USE_CHIPSCOPE=1 generate section
else
begin : no_chipscope1
                                                                                                                                                                      
    // Shared VIO Inputs
        assign  sync_in_i         =  64'h0;

end

 if (USE_CHIPSCOPE==1)
 begin : chipscope2
     // Shared VIO Outputs
 assign  reset_i =   system_reset_i | sync_out_i[0];
 end //end USE_CHIPSCOPE=1 block
 else
 begin: no_chipscope2
     assign  reset_i =   system_reset_i;
 end //end USE_CHIPSCOPE=0 block

endgenerate //End generate for USE_CHIPSCOPE

endmodule

//-------------------------------------------------------------------
//  ICON core module declaration
//-------------------------------------------------------------------
module v7_icon
  (
      control0
  );
  output [35:0] control0;
endmodule

//-------------------------------------------------------------------
//  VIO core module declaration
//-------------------------------------------------------------------
module v7_vio
  (
    control,
    clk,
    sync_in,
    sync_out
  );
  input  [35:0] control;
  input  clk;
  input  [63:0] sync_in;
  output [15:0] sync_out;
endmodule

