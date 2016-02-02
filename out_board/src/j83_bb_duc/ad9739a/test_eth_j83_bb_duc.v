//------------------------------------------------------------------------------
// File       : kc705_ethernet_rgmii_example_design.v
// Author     : Xilinx Inc.
// -----------------------------------------------------------------------------
// (c) Copyright 2004-2009 Xilinx, Inc. All rights reserved.
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
// -----------------------------------------------------------------------------
// Description:  This is the Verilog example design for the Tri-Mode
//               Ethernet MAC core. It is intended that this example design
//               can be quickly adapted and downloaded onto an FPGA to provide
//               a real hardware test environment.
//
//               This level:
//
//               * Instantiates the FIFO Block wrapper, containing the
//                 block level wrapper and an RX and TX FIFO with an
//                 AXI-S interface;
//
//               * Instantiates a simple AXI-S example design,
//                 providing an address swap and a simple
//                 loopback function;
//
//               * Instantiates transmitter clocking circuitry
//                   -the User side of the FIFOs are clocked at gtx_clk
//                    at all times
//
//               * Instantiates a state machine which drives the AXI Lite
//                 interface to bring the TEMAC up in the correct state
//
//               * Serializes the Statistics vectors to prevent logic being
//                 optimized out
//
//               * Ties unused inputs off to reduce the number of IO
//
//               Please refer to the Datasheet, Getting Started Guide, and
//               the Tri-Mode Ethernet MAC User Gude for further information.
//
//
//    ---------------------------------------------------------------------
//    | EXAMPLE DESIGN WRAPPER                                            |
//    |           --------------------------------------------------------|
//    |           |FIFO BLOCK WRAPPER                                     |
//    |           |                                                       |
//    |           |                                                       |
//    |           |              -----------------------------------------|
//    |           |              | BLOCK LEVEL WRAPPER                    |
//    | --------  |              |                                        |
//    | |      |  |              |      -------------------               |
//    | | AXI  |--|--------------|----->|                 |               |
//    | | LITE |  |              |      | AXI4-Lite IPIF  |               |
//    | |  SM  |  |              |      |                 |               |
//    | |      |<-|--------------|------|                 |               |
//    | |      |  |              |      -------------------               |
//    | --------  |              |         |    |                         |
//    |           |              |    ---------------------               |
//    |           |              |    | ETHERNET MAC CORE |               |
//    |           |              |    |                   |               |
//    |           |              |    |                   |               |
//    |           |              |    |                   |               |
//    |           |              |    |                   |               |
//    | --------  |  ----------  |    |                   |               |
//    | |      |  |  |        |  |    |                   |  ---------    |
//    | |      |->|->|        |--|--->| Tx            Tx  |--|       |--->|
//    | |  PAT |  |  |        |  |    | AXI-S         PHY |  |       |    |
//    | |  GEN |  |  |        |  |    | I/F           I/F |  |       |    |
//    | |(ADDR |  |  |  AXI-S |  |    |                   |  | PHY   |    |
//    | | SWAP)|  |  |  FIFO  |  |    |                   |  | I/F   |    |
//    | |      |  |  |        |  |    |                   |  |       |    |
//    | |      |  |  |        |  |    | Rx            Rx  |  |       |    |
//    | |      |  |  |        |  |    | AXI-S         PHY |  |       |    |
//    | |      |<-|<-|        |<-|----| I/F           I/F |<-|       |<---|
//    | |      |  |  |        |  |    |                   |  ---------    |
//    | --------  |  ----------  |    |                   |               |
//    |           |              |    ---------------------               |
//    |           |              |                                        |
//    |           |              -----------------------------------------|
//    |           --------------------------------------------------------|
//    ---------------------------------------------------------------------
//
//------------------------------------------------------------------------------

`timescale 1 ps/1 ps


//------------------------------------------------------------------------------
// The entity declaration for the example_design level wrapper.
//------------------------------------------------------------------------------

module test_eth_j83_bb_duc
   (
      // asynchronous reset
      input         glbl_rst,

      // 200MHz clock input from board
      input         clk_in_p,
      input         clk_in_n,

      output        phy_resetn,

      // RGMII Interface
      //----------------
      output [3:0]  rgmii_txd,
      output        rgmii_tx_ctl,
      output        rgmii_txc,
      input  [3:0]  rgmii_rxd,
      input         rgmii_rx_ctl,
      input         rgmii_rxc,

      // MDIO Interface
      //---------------
      inout         mdio,
      output        mdc,

      // Serialised statistics vectors
      //------------------------------
      //output        tx_statistics_s,
      //output        rx_statistics_s,

      // Serialised Pause interface controls
      //------------------------------------
      input         pause_req_s,

      // Main example design controls
      //-----------------------------
      input  [1:0]  mac_speed,
      input         update_speed,
      //input         serial_command, // tied to pause_req_s
      input         config_board,
      //output        serial_response,
      input         gen_tx_data,
      input         chk_tx_data,
      input         reset_error,
      output        frame_error,
      output        frame_errorn,
      output        activity_flash,
      output        activity_flashn,
		
		input         dac_clk_in_p,                                       
		input         dac_clk_in_n,
      output        dac_clk_out_p,
		output        dac_clk_out_n,
      output [13:0] dac_data_out_a_p,
      output [13:0] dac_data_out_a_n,
      output [13:0] dac_data_out_b_p,
      output [13:0] dac_data_out_b_n,
    
      output [1:0]  spi_csn,
      output        spi_clk,
      output        spi_mosi,
      input         spi_miso
		

    );

   //----------------------------------------------------------------------------
   // Parameters used in this top level wrapper.
   //----------------------------------------------------------------------------
   parameter MAC_BASE_ADDR = 32'h0;

   //----------------------------------------------------------------------------
   // internal signals used in this top level wrapper.
   //----------------------------------------------------------------------------

   // example design clocks
   (* KEEP = "TRUE" *)
   wire                 gtx_clk_bufg;
   (* KEEP = "TRUE" *)
   wire                 gtx_clk90_bufg;
   (* KEEP = "TRUE" *)
   wire                 refclk_bufg;
   (* KEEP = "TRUE" *)
   wire                 s_axi_aclk;
   wire                 rx_mac_aclk;
   wire                 tx_mac_aclk;
   reg                  phy_resetn_int;
	wire                 ts_clk;

	
   // resets (and reset generation)
   wire                 s_axi_reset_int;
   reg                  s_axi_pre_resetn = 0;
   reg                  s_axi_resetn = 0;
   wire                 chk_reset_int;
   reg                  chk_pre_resetn = 0;
   reg                  chk_resetn = 0;
   wire                 gtx_clk_reset_int;
   reg                  gtx_pre_resetn = 0;
   reg                  gtx_resetn = 0;
   wire                 rx_reset;
   wire                 tx_reset;

   wire                 dcm_locked;
   wire                 glbl_rst_int;
   reg   [5:0]          phy_reset_count;
   wire                 glbl_rst_intn;


   // USER side RX AXI-S interface
   wire                 rx_fifo_clock;
   wire                 rx_fifo_resetn;
   wire  [7:0]          rx_axis_fifo_tdata;
   wire                 rx_axis_fifo_tvalid;
   wire                 rx_axis_fifo_tlast;
   wire                 rx_axis_fifo_tready;

   // USER side TX AXI-S interface
   wire                 tx_fifo_clock;
   wire                 tx_fifo_resetn;
   wire  [7:0]          tx_axis_fifo_tdata;
   wire                 tx_axis_fifo_tvalid;
   wire                 tx_axis_fifo_tlast;
   wire                 tx_axis_fifo_tready;

   // RX Statistics serialisation signals
   (* KEEP = "TRUE" *)
   wire                 rx_statistics_valid;
   reg                  rx_statistics_valid_reg;
   (* KEEP = "TRUE" *)
   wire  [27:0]         rx_statistics_vector;
   reg   [27:0]         rx_stats;
   reg                  rx_stats_toggle = 0;
   wire                 rx_stats_toggle_sync;
   reg                  rx_stats_toggle_sync_reg = 0;
   reg   [29:0]         rx_stats_shift;

   // TX Statistics serialisation signals
   (* KEEP = "TRUE" *)
   wire                 tx_statistics_valid;
   reg                  tx_statistics_valid_reg;
   (* KEEP = "TRUE" *)
   wire  [31:0]         tx_statistics_vector;
   reg   [31:0]         tx_stats;
   reg                  tx_stats_toggle = 0;
   wire                 tx_stats_toggle_sync;
   reg                  tx_stats_toggle_sync_reg = 0;
   reg   [33:0]         tx_stats_shift;
   wire                 inband_link_status;
   wire  [1:0]          inband_clock_speed;
   wire                 inband_duplex_status;

   // Pause interface DESerialisation
   reg   [18:0]         pause_shift;
   reg                  pause_req;
   reg   [15:0]         pause_val;

   // AXI-Lite interface
   (* KEEP = "TRUE" *)
   wire  [31:0]         s_axi_awaddr;
   (* KEEP = "TRUE" *)
   wire                 s_axi_awvalid;
   (* KEEP = "TRUE" *)
   wire                 s_axi_awready;
   (* KEEP = "TRUE" *)
   wire  [31:0]         s_axi_wdata;
   (* KEEP = "TRUE" *)
   wire                 s_axi_wvalid;
   (* KEEP = "TRUE" *)
   wire                 s_axi_wready;
   (* KEEP = "TRUE" *)
   wire  [1:0]          s_axi_bresp;
   (* KEEP = "TRUE" *)
   wire                 s_axi_bvalid;
   (* KEEP = "TRUE" *)
   wire                 s_axi_bready;
   (* KEEP = "TRUE" *)
   wire  [31:0]         s_axi_araddr;
   (* KEEP = "TRUE" *)
   wire                 s_axi_arvalid;
   (* KEEP = "TRUE" *)
   wire                 s_axi_arready;
   (* KEEP = "TRUE" *)
   wire  [31:0]         s_axi_rdata;
   (* KEEP = "TRUE" *)
   wire  [1:0]          s_axi_rresp;
   (* KEEP = "TRUE" *)
   wire                 s_axi_rvalid;
   (* KEEP = "TRUE" *)
   wire                 s_axi_rready;

   // set board defaults - only updated when reprogrammed
   reg                  enable_address_swap = 1;
   reg                  enable_phy_loopback = 0;

   // signal tie offs
   wire  [7:0]          tx_ifg_delay = 0;    // not used in this example

   assign frame_errorn = !frame_error;
   assign activity_flashn = !activity_flash;


  // when the config_board button is pushed capture and hold the
  // state of the gne/chek tx_data inputs.  These values will persist until the
  // board is reprogrammed or config_board is pushed again
  always @(posedge gtx_clk_bufg)
  begin
     if (config_board) begin
        enable_address_swap   <= gen_tx_data;
     end
  end

  always @(posedge s_axi_aclk)
  begin
     if (config_board) begin
        enable_phy_loopback   <= chk_tx_data;
     end
  end


  //----------------------------------------------------------------------------
  // Clock logic to generate required clocks from the 200MHz on board
  // if 125MHz is available directly this can be removed
  //----------------------------------------------------------------------------
  kc705_ethernet_rgmii_clk_wiz clock_generator
  (
      // Clock in ports
      .CLK_IN1_P     (clk_in_p),
      .CLK_IN1_N     (clk_in_n),
      // Clock out ports
      .CLK_OUT1      (gtx_clk_bufg),
      .CLK_OUT2      (s_axi_aclk),
      .CLK_OUT3      (refclk_bufg),
      .CLK_OUT4      (gtx_clk90_bufg),
      // Status and control signals
      .RESET         (glbl_rst),
      .LOCKED        (dcm_locked)
 );

  //---------------
  // global reset
   kc705_ethernet_rgmii_reset_sync glbl_reset_gen (
      .clk              (gtx_clk_bufg),
      .enable           (dcm_locked),
      .reset_in         (glbl_rst),
      .reset_out        (glbl_rst_int)
   );

   assign glbl_rst_intn = !glbl_rst_int;


  //----------------------------------------------------------------------------
  // Generate the user side clocks for the axi fifos
  //----------------------------------------------------------------------------
  //assign tx_fifo_clock = gtx_clk_bufg;
  //assign rx_fifo_clock = gtx_clk_bufg;
  assign tx_fifo_clock = ts_clk;
  assign rx_fifo_clock = ts_clk;

  //----------------------------------------------------------------------------
  // Generate resets required for the fifo side signals etc
  //----------------------------------------------------------------------------
  // in each case the async reset is first captured and then synchronised

  //---------------
  // AXI-Lite reset
   kc705_ethernet_rgmii_reset_sync axi_lite_reset_gen (
      .clk              (s_axi_aclk),
      .enable           (phy_resetn_int),
      .reset_in         (glbl_rst),
      .reset_out        (s_axi_reset_int)
   );

   // Create fully synchronous reset in the s_axi clock domain.
   always @(posedge s_axi_aclk)
   begin
     if (s_axi_reset_int) begin
       s_axi_pre_resetn <= 0;
       s_axi_resetn     <= 0;
     end
     else begin
       s_axi_pre_resetn <= 1;
       s_axi_resetn     <= s_axi_pre_resetn;
     end
   end

  //---------------
  // gtx_clk reset
   kc705_ethernet_rgmii_reset_sync gtx_reset_gen (
      .clk              (gtx_clk_bufg),
      .enable           (dcm_locked),
      .reset_in         (glbl_rst || rx_reset || tx_reset),
      .reset_out        (gtx_clk_reset_int)
   );

   // Create fully synchronous reset in the gtx_clk domain.
   always @(posedge gtx_clk_bufg)
   begin
     if (gtx_clk_reset_int) begin
       gtx_pre_resetn  <= 0;
       gtx_resetn      <= 0;
     end
     else begin
       gtx_pre_resetn  <= 1;
       gtx_resetn      <= gtx_pre_resetn;
     end
   end
	
  //---------------
  // fifo reset
	reg fifo_rstn, fifo_pre_rstn;
	wire fifo_rst_intn;
   kc705_ethernet_rgmii_reset_sync fifo_reset_gen (
      .clk              (ts_clk),
      .enable           (dcm_locked),
      .reset_in         (glbl_rst ),
      .reset_out        (fifo_rst_intn)
   );

   // Create fully synchronous reset in the ts_clk domain.
   always @(posedge ts_clk)
   begin
     if (fifo_rst_intn) begin
       fifo_pre_rstn  <= 0;
       fifo_rstn      <= 0;
     end
     else begin
       fifo_pre_rstn  <= 1;
       fifo_rstn      <= fifo_pre_rstn;
     end
   end

  //---------------
  // data check reset
   kc705_ethernet_rgmii_reset_sync chk_reset_gen (
      .clk              (gtx_clk_bufg),
      .enable           (dcm_locked),
      .reset_in         (glbl_rst || reset_error),
      .reset_out        (chk_reset_int)
   );

   // Create fully synchronous reset in the gtx_clk domain.
   always @(posedge gtx_clk_bufg)
   begin
     if (chk_reset_int) begin
       chk_pre_resetn  <= 0;
       chk_resetn      <= 0;
     end
     else begin
       chk_pre_resetn  <= 1;
       chk_resetn      <= chk_pre_resetn;
     end
   end


   //---------------
   // PHY reset
   // the phy reset output (active low) needs to be held for at least 10x25MHZ cycles
   // this is derived using the 125MHz available and a 6 bit counter
   always @(posedge gtx_clk_bufg)
   begin
      if (!glbl_rst_intn) begin
         phy_resetn_int <= 0;
         phy_reset_count <= 0;
      end
      else begin
         if (!(&phy_reset_count)) begin
            phy_reset_count <= phy_reset_count + 1;
         end
         else begin
            phy_resetn_int <= 1;
         end
      end
   end

   assign phy_resetn = phy_resetn_int;

   // generate the user side resets for the axi fifos
   assign tx_fifo_resetn = gtx_resetn;
   assign rx_fifo_resetn = gtx_resetn;

  //----------------------------------------------------------------------------
  // Serialize the stats vectors
  // This is a single bit approach, retimed onto gtx_clk
  // this code is only present to prevent code being stripped..
  //----------------------------------------------------------------------------

  // RX STATS

  // first capture the stats on the appropriate clock
  always @(posedge rx_mac_aclk)
  begin
     rx_statistics_valid_reg <= rx_statistics_valid;
     if (!rx_statistics_valid_reg & rx_statistics_valid) begin
        rx_stats <= rx_statistics_vector;
        rx_stats_toggle <= !rx_stats_toggle;
     end
  end

  kc705_ethernet_rgmii_sync_block rx_stats_sync (
     .clk              (gtx_clk_bufg),
     .data_in          (rx_stats_toggle),
     .data_out         (rx_stats_toggle_sync)
  );

  always @(posedge gtx_clk_bufg)
  begin
     rx_stats_toggle_sync_reg <= rx_stats_toggle_sync;
  end

  // when an update is rxd load shifter (plus start/stop bit)
  // shifter always runs (no power concerns as this is an example design)
  always @(posedge gtx_clk_bufg)
  begin
     if (rx_stats_toggle_sync_reg != rx_stats_toggle_sync) begin
        rx_stats_shift <= {1'b1, rx_stats, 1'b1};
     end
     else begin
        rx_stats_shift <= {rx_stats_shift[28:0], 1'b0};
     end
  end

  assign rx_statistics_s = rx_stats_shift[29];

  // TX STATS

  // first capture the stats on the appropriate clock
  always @(posedge tx_mac_aclk)
  begin
     tx_statistics_valid_reg <= tx_statistics_valid;
     if (!tx_statistics_valid_reg & tx_statistics_valid) begin
        tx_stats <= tx_statistics_vector;
        tx_stats_toggle <= !tx_stats_toggle;
     end
  end

  kc705_ethernet_rgmii_sync_block tx_stats_sync (
     .clk              (gtx_clk_bufg),
     .data_in          (tx_stats_toggle),
     .data_out         (tx_stats_toggle_sync)
  );

  always @(posedge gtx_clk_bufg)
  begin
     tx_stats_toggle_sync_reg <= tx_stats_toggle_sync;
  end

  // when an update is txd load shifter (plus start bit)
  // shifter always runs (no power concerns as this is an example design)
  always @(posedge gtx_clk_bufg)
  begin
     if (tx_stats_toggle_sync_reg != tx_stats_toggle_sync) begin
        tx_stats_shift <= {1'b1, tx_stats, 1'b1};
     end
     else begin
        tx_stats_shift <= {tx_stats_shift[32:0], 1'b0};
     end
  end

  assign tx_statistics_s = tx_stats_shift[33];

  //----------------------------------------------------------------------------
  // DESerialize the Pause interface
  // This is a single bit approachtimed on gtx_clk
  // this code is only present to prevent code being stripped..
  //----------------------------------------------------------------------------
  // the serialised pause info has a start bit followed by the quanta and a stop bit
  // capture the quanta when the start bit hits the msb and the stop bit is in the lsb
  always @(posedge gtx_clk_bufg)
  begin
     pause_shift <= {pause_shift[17:0], pause_req_s};
  end

  always @(posedge gtx_clk_bufg)
  begin
     if (pause_shift[18] === 1'b0 & pause_shift[17] === 1'b1 & pause_shift[0] === 1'b1) begin
        pause_req <= 1'b1;
        pause_val <= pause_shift[16:1];
     end
     else begin
        pause_req <= 1'b0;
        pause_val <= 0;
     end
  end

  //----------------------------------------------------------------------------
  // Instantiate the AXI-LITE Controller

   kc705_ethernet_rgmii_axi_lite_sm #(
      . MAC_BASE_ADDR               (MAC_BASE_ADDR)
   ) axi_lite_controller (
      .s_axi_aclk                   (s_axi_aclk),
      .s_axi_resetn                 (s_axi_resetn),

      .mac_speed                    (mac_speed),
      .update_speed                 (update_speed),   // may need glitch protection on this..
      .serial_command               (pause_req_s),
      .serial_response              (serial_response),
      .phy_loopback                 (enable_phy_loopback),

      .s_axi_awaddr                 (s_axi_awaddr),
      .s_axi_awvalid                (s_axi_awvalid),
      .s_axi_awready                (s_axi_awready),

      .s_axi_wdata                  (s_axi_wdata),
      .s_axi_wvalid                 (s_axi_wvalid),
      .s_axi_wready                 (s_axi_wready),

      .s_axi_bresp                  (s_axi_bresp),
      .s_axi_bvalid                 (s_axi_bvalid),
      .s_axi_bready                 (s_axi_bready),

      .s_axi_araddr                 (s_axi_araddr),
      .s_axi_arvalid                (s_axi_arvalid),
      .s_axi_arready                (s_axi_arready),

      .s_axi_rdata                  (s_axi_rdata),
      .s_axi_rresp                  (s_axi_rresp),
      .s_axi_rvalid                 (s_axi_rvalid),
      .s_axi_rready                 (s_axi_rready)
   );

  //----------------------------------------------------------------------------
  // Instantiate the TRIMAC core fifo block wrapper
  //----------------------------------------------------------------------------
  kc705_ethernet_rgmii_fifo_block #(
       .C_BASE_ADDRESS              (MAC_BASE_ADDR)
   ) trimac_fifo_block (
      .gtx_clk                      (gtx_clk_bufg),
      .gtx_clk90                    (gtx_clk90_bufg),
      // asynchronous reset
      .glbl_rstn                    (glbl_rst_intn),
      .rx_axi_rstn                  (1'b1),
      .tx_axi_rstn                  (1'b1),

      // Reference clock for IDELAYCTRL's
      .refclk                       (refclk_bufg),

      // Receiver Statistics Interface
      //---------------------------------------
      .rx_mac_aclk                  (rx_mac_aclk),
      .rx_reset                     (rx_reset),
      .rx_statistics_vector         (rx_statistics_vector),
      .rx_statistics_valid          (rx_statistics_valid),

      // Receiver (AXI-S) Interface
      //----------------------------------------
      .rx_fifo_clock                (rx_fifo_clock),
      .rx_fifo_resetn               (rx_fifo_resetn),
      .rx_axis_fifo_tdata           (rx_axis_fifo_tdata),
      .rx_axis_fifo_tvalid          (rx_axis_fifo_tvalid),
      .rx_axis_fifo_tready          (rx_axis_fifo_tready),
      .rx_axis_fifo_tlast           (rx_axis_fifo_tlast),

      // Transmitter Statistics Interface
      //------------------------------------------
      .tx_mac_aclk                  (tx_mac_aclk),
      .tx_reset                     (tx_reset),
      .tx_ifg_delay                 (tx_ifg_delay),
      .tx_statistics_vector         (tx_statistics_vector),
      .tx_statistics_valid          (tx_statistics_valid),

      // Transmitter (AXI-S) Interface
      //-------------------------------------------
      .tx_fifo_clock                (tx_fifo_clock),
      .tx_fifo_resetn               (tx_fifo_resetn),
      .tx_axis_fifo_tdata           (tx_axis_fifo_tdata),
      .tx_axis_fifo_tvalid          (tx_axis_fifo_tvalid),
      .tx_axis_fifo_tready          (tx_axis_fifo_tready),
      .tx_axis_fifo_tlast           (tx_axis_fifo_tlast),

      // MAC Control Interface
      //------------------------
      .pause_req                    (pause_req),
      .pause_val                    (pause_val),

      // RGMII Interface
      //------------------
      .rgmii_txd                    (rgmii_txd),
      .rgmii_tx_ctl                 (rgmii_tx_ctl),
      .rgmii_txc                    (rgmii_txc),
      .rgmii_rxd                    (rgmii_rxd),
      .rgmii_rx_ctl                 (rgmii_rx_ctl),
      .rgmii_rxc                    (rgmii_rxc),

      // RGMII Inband Status Registers
      //--------------------------------
      .inband_link_status           (inband_link_status),
      .inband_clock_speed           (inband_clock_speed),
      .inband_duplex_status         (inband_duplex_status),

      // MDIO Interface
      //-----------------
      .mdio                         (mdio),
      .mdc                          (mdc),

      // AXI-Lite Interface
      //---------------
      .s_axi_aclk                   (s_axi_aclk),
      .s_axi_resetn                 (s_axi_resetn),

      .s_axi_awaddr                 (s_axi_awaddr),
      .s_axi_awvalid                (s_axi_awvalid),
      .s_axi_awready                (s_axi_awready),

      .s_axi_wdata                  (s_axi_wdata),
      .s_axi_wvalid                 (s_axi_wvalid),
      .s_axi_wready                 (s_axi_wready),

      .s_axi_bresp                  (s_axi_bresp),
      .s_axi_bvalid                 (s_axi_bvalid),
      .s_axi_bready                 (s_axi_bready),

      .s_axi_araddr                 (s_axi_araddr),
      .s_axi_arvalid                (s_axi_arvalid),
      .s_axi_arready                (s_axi_arready),

      .s_axi_rdata                  (s_axi_rdata),
      .s_axi_rresp                  (s_axi_rresp),
      .s_axi_rvalid                 (s_axi_rvalid),
      .s_axi_rready                 (s_axi_rready)

   );

/*
  //----------------------------------------------------------------------------
  //  Instantiate the address swapping module and simple pattern generator
  //----------------------------------------------------------------------------
   kc705_ethernet_rgmii_basic_pat_gen basic_pat_gen_inst (
      .axi_tclk                     (tx_fifo_clock),
      .axi_tresetn                  (tx_fifo_resetn),
      .check_resetn                 (chk_resetn),

      .enable_pat_gen               (gen_tx_data),
      .enable_pat_chk               (chk_tx_data),
      .enable_address_swap          (enable_address_swap),
      .speed                        (mac_speed),

      .rx_axis_tdata                (rx_axis_fifo_tdata),
      .rx_axis_tvalid               (rx_axis_fifo_tvalid),
      .rx_axis_tlast                (rx_axis_fifo_tlast),
      .rx_axis_tuser                (1'b0), // the FIFO drops all bad frames
      .rx_axis_tready               (rx_axis_fifo_tready),

      .tx_axis_tdata                (tx_axis_fifo_tdata),
      .tx_axis_tvalid               (tx_axis_fifo_tvalid),
      .tx_axis_tlast                (tx_axis_fifo_tlast),
      .tx_axis_tready               (tx_axis_fifo_tready),

      .frame_error                  (frame_error),
      .activity_flash               (activity_flash)
   );

*/
wire [7:0] ts_data0, ts_data1, ts_data2, ts_data3, 
           ts_data4, ts_data5, ts_data6, ts_data7,
           ts_data8, ts_data9, ts_data10, ts_data11,
           ts_data12, ts_data13, ts_data14, ts_data15;

//wire [7:0] ts_data[15:0];
			  
wire [15:0] ts_ce;
wire [15:0] ts_frame;

wire [31:0] cfg_data;
wire [7:0] cfg_add;
wire cfg_write;

j83_bb_duc inst_j83_bb_duc(
    .rst                         (glbl_rst_int),
    .aclk                        (s_axi_aclk),
    
    .dac_clk_in_p                (dac_clk_in_p),                                       
    .dac_clk_in_n                (dac_clk_in_n),
    .dac_clk_out_p               (dac_clk_out_p),
    .dac_clk_out_n               (dac_clk_out_n),
    .dac_data_out_a_p            (dac_data_out_a_p),
    .dac_data_out_a_n            (dac_data_out_a_n),
    .dac_data_out_b_p            (dac_data_out_b_p),
    .dac_data_out_b_n            (dac_data_out_b_n),
    
    .spi_csn                     (spi_csn),
    .spi_clk                     (spi_clk),
    .spi_mosi                    (spi_mosi),
    .spi_miso                    (spi_miso),
	 
	 .ts_clk                      (ts_clk),
//	 .ts_data                     (ts_data),
	 
	 .ts_data0                    (ts_data0),
	 .ts_data1                    (ts_data1),
	 .ts_data2                    (ts_data2),
	 .ts_data3                    (ts_data3),
	 .ts_data4                    (ts_data4),
	 .ts_data5                    (ts_data5),
	 .ts_data6                    (ts_data6),
	 .ts_data7                    (ts_data7),
	 .ts_data8                    (ts_data8),
	 .ts_data9                    (ts_data9),
	 .ts_data10                   (ts_data10),
	 .ts_data11                   (ts_data11),
	 .ts_data12                   (ts_data12),
	 .ts_data13                   (ts_data13),
	 .ts_data14                   (ts_data14),
	 .ts_data15                   (ts_data15),
	 .ts_ce                       (ts_ce),
	 .ts_frame                    (ts_frame),
	 
	 .cfg_data                    (cfg_data),
	 .cfg_write                   (cfg_write),
	 .cfg_add                     (cfg_add),
    
    .gpio_led                    ()
    );

eth_to_ts inst_eth_to_ts
(
    .rstn                        (fifo_rstn),
	 
	 .aclk                        (s_axi_aclk),
	 .cfg_rstn                     (s_axi_resetn),
	 
	 .ts_clk                      (ts_clk),
	 .ts_data0                    (ts_data0),
	 .ts_data1                    (ts_data1),
	 .ts_data2                    (ts_data2),
	 .ts_data3                    (ts_data3),
	 .ts_data4                    (ts_data4),
	 .ts_data5                    (ts_data5),
	 .ts_data6                    (ts_data6),
	 .ts_data7                    (ts_data7),
	 .ts_data8                    (ts_data8),
	 .ts_data9                    (ts_data9),
	 .ts_data10                   (ts_data10),
	 .ts_data11                   (ts_data11),
	 .ts_data12                   (ts_data12),
	 .ts_data13                   (ts_data13),
	 .ts_data14                   (ts_data14),
	 .ts_data15                   (ts_data15),
//	 .ts_data                     (ts_data),
	 .ts_ce                       (ts_ce),
	 .ts_frame                    (ts_frame),
	 
	 .cfg_data                    (cfg_data),
	 .cfg_write                   (cfg_write),
	 .cfg_add                     (cfg_add),
	 
    .tdata                       (rx_axis_fifo_tdata),
    .tvalid                      (rx_axis_fifo_tvalid),
    .tready                      (rx_axis_fifo_tready),
    .tlast                       (rx_axis_fifo_tlast)
	
);

endmodule
