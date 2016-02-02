///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2011 Xilinx, Inc. All rights reserved.
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
////////////////////////////////////////////////////////////////////////////////
//
// Module aurora_8b10b_gtx1_GT_WRAPPER
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
(* core_generation_info = "aurora_8b10b_gtx1,aurora_8b10b_v8_3,{user_interface=AXI_4_Streaming,backchannel_mode=Sidebands,c_aurora_lanes=1,c_column_used=left,c_gt_clock_1=GTXQ1,c_gt_clock_2=None,c_gt_loc_1=X,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=X,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=X,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=X,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=1,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=false,c_simplex_mode=TX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=Duplex}" *)
module aurora_8b10b_gtx1_GT_WRAPPER #
(

   // Simulation attribute
   parameter   SIM_GTRESET_SPEEDUP    = "FALSE"    // Set to "true" to speed up sim reset

)
(

//---------------------- Loopback and Powerdown Ports ----------------------
    LOOPBACK_IN,
//--------------------- Receive Ports - 8b10b Decoder ----------------------
    RXCHARISCOMMA_OUT,
    RXCHARISK_OUT,
    RXDISPERR_OUT,
    RXNOTINTABLE_OUT,
//----------------- Receive Ports - Channel Bonding Ports -----------------
    ENCHANSYNC_IN,
    CHBONDDONE_OUT,
//----------------- Receive Ports - Clock Correction Ports -----------------
    RXBUFERR_OUT,
//------------- Receive Ports - Comma Detection and Alignment --------------
    RXREALIGN_OUT,
    ENMCOMMAALIGN_IN,
    ENPCOMMAALIGN_IN,
//----------------- Receive Ports - RX Data Path interface -----------------
    RXDATA_OUT,
    RXRESET_IN,
    RXUSRCLK_IN,
    RXUSRCLK2_IN,
//----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    RX1N_IN,
    RX1P_IN,
//--------------- Receive Ports - RX Polarity Control Ports ----------------
    RXPOLARITY_IN,
//------------------- Shared Ports - Tile and PLL Ports --------------------
    REFCLK,
    INIT_CLK_IN,
    PLL_NOT_LOCKED,
    GTRESET_IN,
    PLLLKDET_OUT,
    TX_RESETDONE_OUT,
    RX_RESETDONE_OUT,
//-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TXCHARISK_IN,
//---------------- Transmit Ports - TX Data Path interface -----------------
    TXDATA_IN,
    TXOUTCLK1_OUT,
    TXRESET_IN,
    TXUSRCLK_IN,
    TXUSRCLK2_IN,
    TXBUFERR_OUT,
//------------- Transmit Ports - TX Driver and OOB signalling --------------
    TX1N_OUT,
    TX1P_OUT,
    //-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
    DRPADDR_IN,
    DRPCLK_IN,
    DRPDI_IN,
    DRPDO_OUT,
    DRPEN_IN,
    DRPRDY_OUT,
    DRPWE_IN,
    LINK_RESET_IN,
    POWERDOWN_IN
);

`define DLY #1
//***************************** Port Declarations *****************************
//---------------------- Loopback and Powerdown Ports ----------------------
 input    [2:0]    LOOPBACK_IN;
//--------------------- Receive Ports - 8b10b Decoder ----------------------
 output  [1:0]  RXCHARISCOMMA_OUT;
 output  [1:0]  RXCHARISK_OUT;
 output  [1:0]  RXDISPERR_OUT;
 output  [1:0]  RXNOTINTABLE_OUT;
//----------------- Receive Ports - Channel Bonding Ports -----------------
 input             ENCHANSYNC_IN;
 output            CHBONDDONE_OUT;
//----------------- Receive Ports - Clock Correction Ports -----------------
 output            RXBUFERR_OUT;
//------------- Receive Ports - Comma Detection and Alignment --------------
 output            RXREALIGN_OUT;
 input             ENMCOMMAALIGN_IN;
 input             ENPCOMMAALIGN_IN;
//----------------- Receive Ports - RX Data Path interface -----------------
output  [15:0]   RXDATA_OUT;
 input             RXRESET_IN;
 input             RXUSRCLK_IN;
 input             RXUSRCLK2_IN;
//----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
 input             RX1N_IN; 
 input             RX1P_IN; 
//--------------- Receive Ports - RX Polarity Control Ports ----------------
 input             RXPOLARITY_IN;
//------------------- Shared Ports - Tile and PLL Ports --------------------
 input             REFCLK;
 input             INIT_CLK_IN;
 input             PLL_NOT_LOCKED;
 input             GTRESET_IN;
 output            PLLLKDET_OUT;
 output            TX_RESETDONE_OUT;
 output            RX_RESETDONE_OUT;
 input             POWERDOWN_IN;
 input             LINK_RESET_IN;
//-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
 input    [1:0]  TXCHARISK_IN;
//---------------- Transmit Ports - TX Data Path interface -----------------
 input    [15:0]  TXDATA_IN;
 output            TXOUTCLK1_OUT;
 input             TXRESET_IN;
 output            TXBUFERR_OUT;
 input             TXUSRCLK_IN;
 input             TXUSRCLK2_IN;
//------------- Transmit Ports - TX Driver and OOB signalling --------------
 output            TX1N_OUT;
 output            TX1P_OUT;
//-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
 input   [8:0]   DRPADDR_IN;
 input           DRPCLK_IN;
 input   [15:0]  DRPDI_IN;
 output  [15:0]  DRPDO_OUT;
 input           DRPEN_IN;
 output          DRPRDY_OUT;
 input           DRPWE_IN;

//***************************** Wire Declarations *****************************
// Ground and VCC signals
 wire               tied_to_ground_i;
 wire    [63:0]     tied_to_ground_vec_i;
 wire               tied_to_vcc_i;
 wire    [63:0]     tied_to_vcc_vec_i;

// floating input port connection signals
 wire    [1:0]      open_rxbufstatus_i;
 wire               open_txbufstatus_i;

// Channel Bonding
 wire     [4:0]    chbondi;
 wire     [4:0]    chbondo;

 wire     [4:0]    chbondi_unused_i;

 // reset logic
 wire              gt_reset_i;
 wire              gt_txbuferr_i;
 wire              gt_rxbuferr_i;
 wire              cpll_reset_i; // Combine GTRESET_IN along with LINK_RESET_IN
 wire              qpll_reset_i; // same as cpll_reset_i
 wire              gt0_txresetdone_i;
 wire              gt0_rxresetdone_i;
 reg    [7:0]      reset_counter = 8'd0;

 reg               gt_userrdy_r;
 reg               link_reset_r;
 reg               link_reset_r2;

 reg              gt0_txresetdone_r;
 reg              gt0_txresetdone_r2;
 reg              gt0_txresetdone_r3;
 reg              gt0_rxresetdone_r;
 reg              gt0_rxresetdone_r2;
 reg              gt0_rxresetdone_r3;

//********************************* Main Body of Code**************************
//-------------------------  Static signal Assigments ---------------------  
 assign tied_to_ground_i             = 1'b0;
 assign tied_to_ground_vec_i         = 64'h0000000000000000;
 assign tied_to_vcc_i                = 1'b1;
 assign tied_to_vcc_vec_i            = 64'hffffffffffffffff;

 assign chbondi_unused_i  = 5'b00000;

 assign  chbondi = chbondi_unused_i;
 assign  CHBONDDONE_OUT = 1'b1;


    //***********************************************************************//
    //                                                                       //
    //---------------------  Reset Logic  -----------------------------------//
    //                                                                       //
    //***********************************************************************//
    // Aurora core supports Sequence Mode; hence PCS and PMA resets
    // are tied to ground. In Single mode, the user needs to follow the
    // reset sequencing given in the UG476.


      assign cpll_reset_i      = GTRESET_IN || LINK_RESET_IN;
      assign qpll_reset_i      = GTRESET_IN || LINK_RESET_IN;

      always @(posedge INIT_CLK_IN)
      begin
        link_reset_r  <= `DLY  LINK_RESET_IN;
        link_reset_r2 <= `DLY  link_reset_r;
      end

      always @(posedge INIT_CLK_IN)
      begin
         if(GTRESET_IN)
           gt_userrdy_r <= `DLY 1'b0;
         else
           gt_userrdy_r <= `DLY !PLL_NOT_LOCKED && !link_reset_r2;
      end

    // Upon configuration, GTXTXRESET and GTXRXRESET must be initiated in
    // Sequential mode. If RESETOVRD and GTRESETSEL are already defaulted
    // to the above values, then all GT resets (CPLLRESET, QPLLRESET,
    // GTXTXRESET and GTXRXRESET) cannot be asserted until a minimum of 500ns
    // after GSR deassertion.

      always @(posedge INIT_CLK_IN)
      begin
         if (reset_counter[7])
            reset_counter   <=   `DLY reset_counter;
         else
            reset_counter   <=   `DLY reset_counter + 1'b1;
      end


      //TXRESETDONE for lane0
      always @ (posedge TXUSRCLK2_IN)
      begin
        gt0_txresetdone_r    <=  `DLY gt0_txresetdone_i;
        gt0_txresetdone_r2   <=  `DLY gt0_txresetdone_r;
        gt0_txresetdone_r3   <=  `DLY gt0_txresetdone_r2;
      end

      //RXRESETDONE for lane0
      always @ (posedge RXUSRCLK2_IN)
      begin
        gt0_rxresetdone_r    <=  `DLY gt0_rxresetdone_i;
        gt0_rxresetdone_r2   <=  `DLY gt0_rxresetdone_r;
        gt0_rxresetdone_r3   <=  `DLY gt0_rxresetdone_r2;
      end


      assign gt_txbuferr_i     = TXBUFERR_OUT ;
      assign gt_rxbuferr_i     = RXBUFERR_OUT ;
      assign gt_reset_i        = (!reset_counter[7]) ? 1'b0 : (!PLLLKDET_OUT || gt_txbuferr_i || gt_rxbuferr_i) ;
      assign TX_RESETDONE_OUT  = gt0_txresetdone_r3;
      assign RX_RESETDONE_OUT  = gt0_rxresetdone_r3;

//------------------------- GT Instantiations  --------------------------  
aurora_8b10b_gtx1_multi_gt #
(
    // Simulation attributes
        .WRAPPER_SIM_GTRESET_SPEEDUP    (SIM_GTRESET_SPEEDUP)
)
aurora_8b10b_gtx1_multi_gt_i 
(
        //_________________________________________________________________________
        //_________________________________________________________________________
        //GT0  
        //____________________________CHANNEL PORTS________________________________
        //-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
        .GT0_DRPADDR_IN                     (DRPADDR_IN),
        .GT0_DRPCLK_IN                      (DRPCLK_IN),
        .GT0_DRPDI_IN                       (DRPDI_IN),
        .GT0_DRPDO_OUT                      (DRPDO_OUT),
        .GT0_DRPEN_IN                       (DRPEN_IN),
        .GT0_DRPRDY_OUT                     (DRPRDY_OUT),
        .GT0_DRPWE_IN                       (DRPWE_IN),
        //----------------------- Channel - Ref Clock Ports ------------------------
        .GT0_GTREFCLK0_IN                   (REFCLK),
        //------------------------------ Channel PLL -------------------------------
        .GT0_CPLLFBCLKLOST_OUT              (),
        .GT0_CPLLLOCK_OUT                   (PLLLKDET_OUT),
        .GT0_CPLLLOCKDETCLK_IN              (tied_to_ground_i),
        .GT0_CPLLREFCLKLOST_OUT             (),
        .GT0_CPLLRESET_IN                   (cpll_reset_i),
        //----------------------------- Eye Scan Ports -----------------------------
        .GT0_EYESCANDATAERROR_OUT           (),
        //---------------------- Loopback and Powerdown Ports ----------------------
        .GT0_LOOPBACK_IN                    (LOOPBACK_IN),
        .GT0_TXPD_IN                        ({2{POWERDOWN_IN}}),
        .GT0_RXPD_IN                        ({2{POWERDOWN_IN}}),
        //----------------------------- Receive Ports ------------------------------
        .GT0_RXUSERRDY_IN                   (gt_userrdy_r),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .GT0_RXCHARISCOMMA_OUT              (RXCHARISCOMMA_OUT),
        .GT0_RXCHARISK_OUT                  (RXCHARISK_OUT),
        .GT0_RXDISPERR_OUT                  (RXDISPERR_OUT),
        .GT0_RXNOTINTABLE_OUT               (RXNOTINTABLE_OUT),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .GT0_RXCLKCORCNT_OUT                (),
        //------------- Receive Ports - Comma Detection and Alignment --------------
        .GT0_RXBYTEREALIGN_OUT              (RXREALIGN_OUT),
        .GT0_RXMCOMMAALIGNEN_IN             (ENMCOMMAALIGN_IN),
        .GT0_RXPCOMMAALIGNEN_IN             (ENPCOMMAALIGN_IN),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .GT0_GTRXRESET_IN                   (gt_reset_i),
        .GT0_RXDATA_OUT                     (RXDATA_OUT),
        .GT0_RXOUTCLK_OUT                   (),
        .GT0_RXUSRCLK_IN                    (RXUSRCLK_IN),
        .GT0_RXUSRCLK2_IN                   (RXUSRCLK2_IN),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GT0_GTXRXN_IN                      (RX1N_IN),
        .GT0_GTXRXP_IN                      (RX1P_IN),
        .GT0_RXCDRLOCK_OUT                  (),
        .GT0_RXELECIDLE_OUT                 (),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .GT0_RXBUFSTATUS_OUT                ({RXBUFERR_OUT, open_rxbufstatus_i}),
        //---------------------- Receive Ports - RX PLL Ports ----------------------
        .GT0_RXRESETDONE_OUT                (gt0_rxresetdone_i),
        //----------------------------- Transmit Ports -----------------------------
        .GT0_TXUSERRDY_IN                   (gt_userrdy_r),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GT0_TXCHARISK_IN                   (TXCHARISK_IN),
        //---------- Transmit Ports - TX Buffer and Phase Alignment Ports ----------
        .GT0_TXBUFSTATUS_OUT                ({TXBUFERR_OUT, open_txbufstatus_i}),
        //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .GT0_RXPOLARITY_IN                  (RXPOLARITY_IN),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GT0_GTTXRESET_IN                   (gt_reset_i),
        .GT0_TXDATA_IN                      (TXDATA_IN),
        .GT0_TXOUTCLK_OUT                   (TXOUTCLK1_OUT),
        .GT0_TXOUTCLKFABRIC_OUT             (),
        .GT0_TXOUTCLKPCS_OUT                (),
        .GT0_TXUSRCLK_IN                    (TXUSRCLK_IN),
        .GT0_TXUSRCLK2_IN                   (TXUSRCLK2_IN),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GT0_GTXTXN_OUT                     (TX1N_OUT),
        .GT0_GTXTXP_OUT                     (TX1P_OUT),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GT0_TXRESETDONE_OUT                (gt0_txresetdone_i),

        //-------------------- Common Block  - Ref Clock Ports ---------------------
        .GT0_GTREFCLK0_COMMON_IN             (REFCLK),
        //----------------------- Common Block - QPLL Ports ------------------------
        .GT0_QPLLLOCK_OUT                 (),
        .GT0_QPLLLOCKDETCLK_IN            (tied_to_ground_i),
        .GT0_QPLLREFCLKLOST_OUT            (),
        .GT0_QPLLRESET_IN                  (qpll_reset_i)
    );

endmodule
