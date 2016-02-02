//*****************************************************************************
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
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
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 1.9
//  \   \         Application        : MIG
//  /   /         Filename           : ddr3_top.v
// /___/   /\     Date Last Modified : $Date: 2011/06/02 08:35:03 $
// \   \  /  \    Date Created       : Tue Sept 21 2010
//  \___\/\___\
//
// Device           : 7 Series
// Design Name      : DDR3 SDRAM
// Purpose          :
//   Top-level  module. This module serves both as an example,
//   and allows the user to synthesize a self-contained design,
//   which they can be used to test their hardware.
//   In addition to the memory controller, the module instantiates:
//     1. Synthesizable testbench - used to model user's backend logic
//        and generate different traffic patterns
// Reference        :
// Revision History :
//*****************************************************************************

`timescale 1ps/1ps

module ddr3_top #(
//***************************************************************************
// Traffic Gen related parameters
//***************************************************************************
parameter BL_WIDTH              = 10,
parameter PORT_MODE             = "BI_MODE",
parameter DATA_MODE             = 4'b0010,
parameter ADDR_MODE             = 4'b0011,
parameter TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE",
parameter EYE_TEST              = "FALSE",
                                  // set EYE_TEST = "TRUE" to probe memory
                                  // signals. Traffic Generator will only
                                  // write to one single location and no
                                  // read transactions will be generated.
parameter DATA_PATTERN          = "DGEN_ALL",
                                   // For small devices, choose one only.
                                   // For large device, choose "DGEN_ALL"
                                   // "DGEN_HAMMER", "DGEN_WALKING1",
                                   // "DGEN_WALKING0","DGEN_ADDR","
                                   // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
parameter CMD_PATTERN           = "CGEN_ALL",
                                   // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                   // "CGEN_SEQUENTIAL", "CGEN_ALL"
parameter BEGIN_ADDRESS         = 32'h00000000,
parameter END_ADDRESS           = 32'h00ffffff,
   parameter MEM_ADDR_ORDER
     = "TG_TEST",
   parameter PRBS_EADDR_MASK_POS   = 32'hff000000,
   parameter CMD_WDT               = 'h3FF,
   parameter WR_WDT                = 'h1FFF,
   parameter RD_WDT                = 'h3FF,
   parameter SEL_VICTIM_LINE       = 0,

//***************************************************************************
// The following parameters refer to width of various ports
//***************************************************************************
parameter BANK_WIDTH            = 3,
                                  // # of memory Bank Address bits.
parameter CK_WIDTH              = 1,
                                  // # of CK/CK# outputs to memory.
parameter COL_WIDTH             = 10,
                                  // # of memory Column Address bits.
parameter CS_WIDTH              = 1,
                                  // # of unique CS outputs to memory.
parameter nCS_PER_RANK          = 1,
                                  // # of unique CS outputs per rank for phy
parameter CKE_WIDTH             = 1,
                                  // # of CKE outputs to memory.
parameter DATA_BUF_ADDR_WIDTH   = 5,
parameter DQ_CNT_WIDTH          = 4,
                                  // = ceil(log2(DQ_WIDTH))
parameter DQ_PER_DM             = 8,
parameter DM_WIDTH              = 2,
                                  // # of DM (data mask)
parameter DQ_WIDTH              = 16,
                                  // # of DQ (data)
parameter DQS_WIDTH             = 2,
parameter DQS_CNT_WIDTH         = 1,
                                  // = ceil(log2(DQS_WIDTH))
parameter DRAM_WIDTH            = 8,
                                  // # of DQ per DQS
parameter ECC                   = "OFF",
parameter nBANK_MACHS           = 4,
parameter RANKS                 = 1,
                                  // # of Ranks.
parameter ODT_WIDTH             = 1,
                                  // # of ODT outputs to memory.
parameter ROW_WIDTH             = 14,
                                  // # of memory Row Address bits.
parameter ADDR_WIDTH            = 28,
                                  // # = RANK_WIDTH + BANK_WIDTH
                                  //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices
parameter USE_CS_PORT          = 1,
                                  // # = 1, When Chip Select (CS#) output is enabled
                                  //   = 0, When Chip Select (CS#) output is disabled
                                  // If CS_N disabled, user must connect
                                  // DRAM CS_N input(s) to ground
parameter USE_DM_PORT           = 1,
                                  // # = 1, When Data Mask option is enabled
                                  //   = 0, When Data Mask option is disbaled
                                  // When Data Mask option is disabled in
                                  // MIG Controller Options page, the logic
                                  // related to Data Mask should not get
                                  // synthesized
parameter USE_ODT_PORT          = 1,
                                  // # = 1, When ODT output is enabled
                                  //   = 0, When ODT output is disabled
                                     // Parameter configuration for Dynamic ODT support:
                                     // USE_ODT_PORT = 0, RTT_NOM = "DISABLED", RTT_WR = "60/120".
                                     // This configuration allows to save ODT pin mapping from FPGA.
                                     // The user can tie the ODT input of DRAM to HIGH.
parameter PHY_CONTROL_MASTER_BANK = 0,
                                  // The bank index where master PHY_CONTROL resides,
                                  // equal to the PLL residing bank
   parameter MEM_DENSITY           = "2Gb",
                                     // Indicates the density of the Memory part
                                     // Added for the sake of Vivado simulations
   parameter MEM_SPEEDGRADE        = "15E",
                                     // Indicates the Speed grade of Memory Part
                                     // Added for the sake of Vivado simulations
   parameter MEM_DEVICE_WIDTH      = 16,
                                     // Indicates the device width of the Memory Part
                                     // Added for the sake of Vivado simulations

//***************************************************************************
// The following parameters are mode register settings
//***************************************************************************
parameter AL                    = "0",
                                  // DDR3 SDRAM:
                                  // Additive Latency (Mode Register 1).
                                  // # = "0", "CL-1", "CL-2".
                                  // DDR2 SDRAM:
                                  // Additive Latency (Extended Mode Register).
parameter nAL                   = 0,
                                  // # Additive Latency in number of clock
                                  // cycles.
parameter BURST_MODE            = "8",
                                  // DDR3 SDRAM:
                                  // Burst Length (Mode Register 0).
                                  // # = "8", "4", "OTF".
                                  // DDR2 SDRAM:
                                  // Burst Length (Mode Register).
                                  // # = "8", "4".
parameter BURST_TYPE            = "SEQ",
                                  // DDR3 SDRAM: Burst Type (Mode Register 0).
                                  // DDR2 SDRAM: Burst Type (Mode Register).
                                  // # = "SEQ" - (Sequential),
                                  //   = "INT" - (Interleaved).
   parameter CL                    = 5,
                                  // in number of clock cycles
                                  // DDR3 SDRAM: CAS Latency (Mode Register 0).
                                  // DDR2 SDRAM: CAS Latency (Mode Register).
   parameter CWL                   = 5,
                                  // in number of clock cycles
                                  // DDR3 SDRAM: CAS Write Latency (Mode Register 2).
                                  // DDR2 SDRAM: Can be ignored
parameter OUTPUT_DRV            = "HIGH",
                                  // Output Driver Impedance Control (Mode Register 1).
                                  // # = "HIGH" - RZQ/7,
                                  //   = "LOW" - RZQ/6.
parameter RTT_NOM               = "60",
                                  // RTT_NOM (ODT) (Mode Register 1).
                                  //   = "120" - RZQ/2,
                                  //   = "60"  - RZQ/4,
                                  //   = "40"  - RZQ/6.
parameter RTT_WR                = "OFF",
                                  // RTT_WR (ODT) (Mode Register 2).
                                  // # = "OFF" - Dynamic ODT off,
                                  //   = "120" - RZQ/2,
                                  //   = "60"  - RZQ/4,
parameter ADDR_CMD_MODE         = "1T" ,
                                  // # = "1T", "2T".
parameter REG_CTRL              = "OFF",
                                  // # = "ON" - RDIMMs,
                                  //   = "OFF" - Components, SODIMMs, UDIMMs.
parameter CA_MIRROR             = "OFF",
                                  // C/A mirror opt for DDR3 dual rank

//***************************************************************************
// The following parameters are multiplier and divisor factors for PLLE2.
// Based on the selected design frequency these parameters vary.
//***************************************************************************
parameter CLKIN_PERIOD          = 8000,
                                  // Input Clock Period
   parameter CLKFBOUT_MULT         = 10,
                                  // write PLL VCO multiplier
parameter DIVCLK_DIVIDE         = 1,
                                  // write PLL VCO divisor
   parameter CLKOUT0_PHASE         = 0.0,
                                     // Phase for PLL output clock (CLKOUT0)
parameter CLKOUT0_DIVIDE        = 2,
                                  // VCO output divisor for PLL output clock (CLKOUT0)
   parameter CLKOUT1_DIVIDE        = 4,
                                  // VCO output divisor for PLL output clock (CLKOUT1)
   parameter CLKOUT2_DIVIDE        = 64,
                                  // VCO output divisor for PLL output clock (CLKOUT2)
   parameter CLKOUT3_DIVIDE        = 16,
                                  // VCO output divisor for PLL output clock (CLKOUT3)

//***************************************************************************
// Memory Timing Parameters. These parameters varies based on the selected
// memory part.
//***************************************************************************
parameter tCKE                  = 5625,
                                  // memory tCKE paramter in pS
parameter tFAW                  = 45000,
                                  // memory tRAW paramter in pS.
parameter tRAS                  = 36000,
                                  // memory tRAS paramter in pS.
parameter tRCD                  = 13500,
                                  // memory tRCD paramter in pS.
parameter tREFI                 = 7800000,
                                  // memory tREFI paramter in pS.
parameter tRFC                  = 160000,
                                  // memory tRFC paramter in pS.
parameter tRP                   = 13500,
                                  // memory tRP paramter in pS.
parameter tRRD                  = 7500,
                                  // memory tRRD paramter in pS.
parameter tRTP                  = 7500,
                                  // memory tRTP paramter in pS.
parameter tWTR                  = 7500,
                                  // memory tWTR paramter in pS.
parameter tZQI                  = 128_000_000,
                                  // memory tZQI paramter in nS.
parameter tZQCS                 = 64,
                                  // memory tZQCS paramter in clock cycles.

//***************************************************************************
// Simulation parameters
//***************************************************************************
parameter SIM_BYPASS_INIT_CAL   = "OFF",
                                  // # = "OFF" -  Complete memory init &
                                  //              calibration sequence
                                  // # = "SKIP" - Not supported
                                  // # = "FAST" - Complete memory init & use
                                  //              abbreviated calib sequence

parameter SIMULATION            = "FALSE",
                                  // Should be TRUE during design simulations and
                                  // FALSE during implementations

//***************************************************************************
// The following parameters varies based on the pin out entered in MIG GUI.
// Do not change any of these parameters directly by editing the RTL.
// Any changes required should be done through GUI and the design regenerated.
//***************************************************************************
parameter BYTE_LANES_B0         = 4'b1111,
                                  // Byte lanes used in an IO column.
parameter BYTE_LANES_B1         = 4'b1000,
                                  // Byte lanes used in an IO column.
parameter BYTE_LANES_B2         = 4'b0000,
                                  // Byte lanes used in an IO column.
parameter BYTE_LANES_B3         = 4'b0000,
                                  // Byte lanes used in an IO column.
parameter BYTE_LANES_B4         = 4'b0000,
                                  // Byte lanes used in an IO column.
parameter DATA_CTL_B0           = 4'b0001,
                                  // Indicates Byte lane is data byte lane
                                  // or control Byte lane. '1' in a bit
                                  // position indicates a data byte lane and
                                  // a '0' indicates a control byte lane
parameter DATA_CTL_B1           = 4'b1000,
                                  // Indicates Byte lane is data byte lane
                                  // or control Byte lane. '1' in a bit
                                  // position indicates a data byte lane and
                                  // a '0' indicates a control byte lane
parameter DATA_CTL_B2           = 4'b0000,
                                  // Indicates Byte lane is data byte lane
                                  // or control Byte lane. '1' in a bit
                                  // position indicates a data byte lane and
                                  // a '0' indicates a control byte lane
parameter DATA_CTL_B3           = 4'b0000,
                                  // Indicates Byte lane is data byte lane
                                  // or control Byte lane. '1' in a bit
                                  // position indicates a data byte lane and
                                  // a '0' indicates a control byte lane
parameter DATA_CTL_B4           = 4'b0000,
                                  // Indicates Byte lane is data byte lane
                                  // or control Byte lane. '1' in a bit
                                  // position indicates a data byte lane and
                                  // a '0' indicates a control byte lane
parameter PHY_0_BITLANES        = 48'h3FE_FFE_C08_2FF,
parameter PHY_1_BITLANES        = 48'h3FE_000_000_000,
parameter PHY_2_BITLANES        = 48'h000_000_000_000,

// control/address/data pin mapping parameters
parameter CK_BYTE_MAP
    = 144'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_03,
parameter ADDR_MAP
     = 192'h000_000_013_039_038_037_036_035_034_033_032_031_029_028_027_026,
parameter BANK_MAP   = 36'h02B_02A_025,
parameter CAS_MAP    = 12'h023,
parameter CKE_ODT_BYTE_MAP = 8'h00,
parameter CKE_MAP    = 96'h000_000_000_000_000_000_000_01B,
parameter ODT_MAP    = 96'h000_000_000_000_000_000_000_01A,
parameter CS_MAP     = 120'h000_000_000_000_000_000_000_000_000_021,
parameter PARITY_MAP = 12'h000,
parameter RAS_MAP    = 12'h024,
parameter WE_MAP     = 12'h022,
parameter DQS_BYTE_MAP
  = 144'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_13_00,
parameter DATA0_MAP  = 96'h000_001_002_003_004_005_006_007,
parameter DATA1_MAP  = 96'h131_132_133_134_135_136_137_138,
parameter DATA2_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA3_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA4_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA5_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA6_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA7_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA8_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA9_MAP  = 96'h000_000_000_000_000_000_000_000,
parameter DATA10_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA11_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA12_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA13_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA14_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA15_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA16_MAP = 96'h000_000_000_000_000_000_000_000,
parameter DATA17_MAP = 96'h000_000_000_000_000_000_000_000,
parameter MASK0_MAP  = 108'h000_000_000_000_000_000_000_139_009,
parameter MASK1_MAP  = 108'h000_000_000_000_000_000_000_000_000,

parameter SLOT_0_CONFIG         = 8'b0000_0001,
                                  // Mapping of Ranks.
parameter SLOT_1_CONFIG         = 8'b0000_0000,
                                  // Mapping of Ranks.

//***************************************************************************
// IODELAY and PHY related parameters
//***************************************************************************
parameter IODELAY_HP_MODE       = "ON",
                                  // to phy_top
parameter IBUF_LPWR_MODE        = "OFF",
                                  // to phy_top
parameter DATA_IO_IDLE_PWRDWN   = "ON",
                                  // # = "ON", "OFF"
   parameter BANK_TYPE             = "HR_IO",
                                     // # = "HP_IO", "HPL_IO", "HR_IO", "HRL_IO"
parameter DATA_IO_PRIM_TYPE     = "HR_LP",
                                  // # = "HP_LP", "HR_LP", "DEFAULT"
parameter CKE_ODT_AUX           = "FALSE",
parameter USER_REFRESH          = "OFF",
parameter WRLVL                 = "ON",
                                  // # = "ON" - DDR3 SDRAM
                                  //   = "OFF" - DDR2 SDRAM.
parameter ORDERING              = "NORM",
                                  // # = "NORM", "STRICT", "RELAXED".
parameter CALIB_ROW_ADD         = 16'h0000,
                                  // Calibration row address will be used for
                                  // calibration read and write operations
parameter CALIB_COL_ADD         = 12'h000,
                                  // Calibration column address will be used for
                                  // calibration read and write operations
parameter CALIB_BA_ADD          = 3'h0,
                                  // Calibration bank address will be used for
                                  // calibration read and write operations
parameter TCQ                   = 100,
parameter IODELAY_GRP           = "IODELAY_MIG",
                                  // It is associated to a set of IODELAYs with
                                  // an IDELAYCTRL that have same IODELAY CONTROLLER
                                  // clock frequency.
   parameter SYSCLK_TYPE           = "NO_BUFFER",
                                     // System clock type DIFFERENTIAL, SINGLE_ENDED,
                                     // NO_BUFFER
   parameter REFCLK_TYPE           = "NO_BUFFER",
                                     // Reference clock type DIFFERENTIAL, SINGLE_ENDED,
                                     // NO_BUFFER, USE_SYSTEM_CLOCK
   parameter SYS_RST_PORT          = "FALSE",
                                     // "TRUE" - if pin is selected for sys_rst
                                     //          and IBUF will be instantiated.
                                     // "FALSE" - if pin is not selected for sys_rst
   
parameter DRAM_TYPE             = "DDR3",
parameter CAL_WIDTH             = "HALF",
parameter STARVE_LIMIT          = 2,
                                  // # = 2,3,4.

//***************************************************************************
// Referece clock frequency parameters
//***************************************************************************
parameter REFCLK_FREQ           = 200.0,
                                  // IODELAYCTRL reference clock frequency
parameter DIFF_TERM_REFCLK      = "TRUE",
                                  // Differential Termination for idelay
                                  // reference clock input pins
//***************************************************************************
// System clock frequency parameters
//***************************************************************************
   parameter tCK                   = 3200,
                                  // memory tCK paramter.
                                  // # = Clock Period in pS.
parameter nCK_PER_CLK           = 4,
                                  // # of memory CKs per fabric CLK
   parameter DIFF_TERM_SYSCLK      = "TRUE",
                                  // Differential Termination for System
                                  // clock input pins



//***************************************************************************
// Debug parameters
//***************************************************************************
parameter DEBUG_PORT            = "OFF",
                                  // # = "ON" Enable debug signals/controls.
                                  //   = "OFF" Disable debug signals/controls.
   
   //***************************************************************************
   // Temparature monitor parameter
   //***************************************************************************
   parameter TEMP_MON_CONTROL                          = "EXTERNAL",
                                     // # = "INTERNAL", "EXTERNAL"
parameter RST_ACT_LOW           = 1,
                                  // =1 for active low reset,
                                  // =0 for active high.
//local bus
parameter P_BUS_ADDR_WIDTH       = 12,
parameter P_BUS_DATA_WIDTH       = 16,
parameter BUF_DEPTH_BIT          = 8,
parameter CHNNUM_BIT_WIDTH       = 4,
parameter TOTAL_CHN_NUM          = 16,
parameter PROG_PER_CHAN_BITWIDTH = 4
    )
    (

    // Inouts
    inout [DQ_WIDTH-1:0]                         ddr3_dq,
    inout [DQS_WIDTH-1:0]                        ddr3_dqs_n,
    inout [DQS_WIDTH-1:0]                        ddr3_dqs_p,
    
    // Outputs
    output [ROW_WIDTH-1:0]                       ddr3_addr,
    output [BANK_WIDTH-1:0]                      ddr3_ba,
    output                                       ddr3_ras_n,
    output                                       ddr3_cas_n,
    output                                       ddr3_we_n,
    output                                       ddr3_reset_n,
    output [CK_WIDTH-1:0]                        ddr3_ck_p,
    output [CK_WIDTH-1:0]                        ddr3_ck_n,
    output [CKE_WIDTH-1:0]                       ddr3_cke,
    output [CS_WIDTH*nCS_PER_RANK-1:0]           ddr3_cs_n,
    output [DM_WIDTH-1:0]                        ddr3_dm,
    output [ODT_WIDTH-1:0]                       ddr3_odt,
    
    
    input                                        clk_rx,
    input                                        rst_rx,
    // Inputs
    // Single-ended system clock
    input                                        sys_clk_i,          //125MHz
    // Single-ended iodelayctrl clk (reference clock)
    input                                        clk_ref_i,          //200MHz           
    // System reset
    input                                        sys_rst,
    
    //
    output                                       user_clk,
    output                                       user_rst,
    output                                       tg_compare_error,
    output                                       init_calib_complete,
    
    //ts_data input
    input   [31:0]                               ts_data,
    input                                        ts_data_valid,
    input                                        ts_start,
    input                                        ts_end,
    
    //ts to j83
    input                                        clk_27m,
    input                                        rst_27m,
    output                                       clk_j83,
    input   [TOTAL_CHN_NUM - 1 : 0]              j83_ts_rd_sync,  
    input   [TOTAL_CHN_NUM - 1 : 0]              j83_ts_rd_req,  
    output  [7:0]                                ts_j83_data_ch0 ,
    output  [7:0]                                ts_j83_data_ch1 ,
    output  [7:0]                                ts_j83_data_ch2 ,
    output  [7:0]                                ts_j83_data_ch3 ,
    output  [7:0]                                ts_j83_data_ch4 ,
    output  [7:0]                                ts_j83_data_ch5 ,
    output  [7:0]                                ts_j83_data_ch6 ,
    output  [7:0]                                ts_j83_data_ch7 ,
    
    //gtx
    input                                        clk_156m       ,
    input                                        rst_156m       ,
    input                                        channel_up     ,
    input   [15:0]                               gtx_rx_data    ,
    input                                        gtx_rx_sof_n   ,
    input                                        gtx_rx_eof_n   ,
    input                                        gtx_rx_dvalid_n,
    
    output  [31:0]                               sc_data_pkt_d,
    output                                       sc_data_pkt_dval,
    output                                       sc_data_pkt_sop,
    output                                       sc_data_pkt_eop,

    //local bus
    input                                        clk_cfg    ,
    input                                        rst_cfg    ,
    input   [P_BUS_ADDR_WIDTH-1:0]               lbus_addr  ,
    input   [P_BUS_DATA_WIDTH-1:0]               lbus_wdata ,
    output  [P_BUS_DATA_WIDTH-1:0]               lbus_rdata ,
    input                                        lbus_oe_n  ,
    input                                        lbus_we_n  ,
    output                                       lbus_wait_n,
    
    output  [15:0]                               ad9739_wdata,
    output                                       spi_ad9739 ,
    output                                       spi_ad9739_rd,
    output  [7:0]                                ad9739_raddr ,
    input   [7:0]                                ad9739_rdata ,
    input                                        ad9739_oe    ,
    output                                       spi_adf4350,
    output  [31:0]                               adf4350_wdata,
    output                                       adf4350_pdbrf,
    output                                       amplifier_power_on                 
    );

function integer clogb2 (input integer size);
    begin
      size = size - 1;
      for (clogb2=1; size>1; clogb2=clogb2+1)
        size = size >> 1;
    end
  endfunction // clogb2

  function integer STR_TO_INT;
    input [7:0] in;
    begin
      if(in == "8")
        STR_TO_INT = 8;
      else if(in == "4")
        STR_TO_INT = 4;
      else
        STR_TO_INT = 0;
    end
  endfunction


  localparam CMD_PIPE_PLUS1        = "ON";
                                     // add pipeline stage between MC and PHY
  localparam DATA_WIDTH            = 16;
  localparam ECC_WIDTH = (ECC == "OFF")?
                           0 : (DATA_WIDTH <= 4)?
                            4 : (DATA_WIDTH <= 10)?
                             5 : (DATA_WIDTH <= 26)?
                              6 : (DATA_WIDTH <= 57)?
                               7 : (DATA_WIDTH <= 120)?
                                8 : (DATA_WIDTH <= 247)?
                                 9 : 10;
  localparam ECC_TEST              = "OFF";
  localparam RANK_WIDTH = clogb2(RANKS);
  localparam DATA_BUF_OFFSET_WIDTH = 1;
  localparam MC_ERR_ADDR_WIDTH = ((CS_WIDTH == 1) ? 0 : RANK_WIDTH)
                                 + BANK_WIDTH + ROW_WIDTH + COL_WIDTH
                                 + DATA_BUF_OFFSET_WIDTH;
  localparam tPRDI                 = 1_000_000;
                                     // memory tPRDI paramter in pS.
  localparam PAYLOAD_WIDTH         = (ECC_TEST == "OFF") ? DATA_WIDTH : DQ_WIDTH;
  localparam BURST_LENGTH          = STR_TO_INT(BURST_MODE);
  localparam APP_DATA_WIDTH        = 2 * nCK_PER_CLK * PAYLOAD_WIDTH;
  localparam APP_MASK_WIDTH        = APP_DATA_WIDTH / 8;

  //***************************************************************************
  // Traffic Gen related parameters (derived)
  //***************************************************************************
  localparam  TG_ADDR_WIDTH = ((CS_WIDTH == 1) ? 0 : RANK_WIDTH)
                                 + BANK_WIDTH + ROW_WIDTH + COL_WIDTH;
  localparam MASK_SIZE             = DATA_WIDTH/8;
      

  // Wire declarations
      
  wire [2*nCK_PER_CLK-1:0]              app_ecc_multiple_err;
  wire [ADDR_WIDTH-1:0]                 app_addr;
  wire [2:0]                            app_cmd;
  wire                                  app_en;
  wire                                  app_rdy;
  wire [APP_DATA_WIDTH-1:0]             app_rd_data;
  wire                                  app_rd_data_end;
  wire                                  app_rd_data_valid;
  wire [APP_DATA_WIDTH-1:0]             app_wdf_data;
  wire                                  app_wdf_end;
  wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;
  wire                                  app_wdf_rdy;
  wire                                  app_sr_req;
  wire                                  app_sr_active;
  wire                                  app_ref_req;
  wire                                  app_ref_ack;
  wire                                  app_zq_req;
  wire                                  app_zq_ack;
  wire                                  app_wdf_wren;
  wire [64 + (2*APP_DATA_WIDTH - 1):0]      error_status;
  wire [PAYLOAD_WIDTH/8 - 1:0] cumlative_dq_lane_error;
  wire                                  mem_pattern_init_done;
  wire                                  modify_enable_sel;
  wire [2:0]                            data_mode_manual_sel;
  wire [2:0]                            addr_mode_manual_sel;
  wire [APP_DATA_WIDTH-1:0]             cmp_data;
  reg [63:0]                            cmp_data_r;
  wire                                  cmp_data_valid;
  reg                                   cmp_data_valid_r;
  wire                                  cmp_error;
  wire [47:0]                           wr_data_counts;
  wire [47:0]                           rd_data_counts;
  wire [PAYLOAD_WIDTH/8-1:0]            dq_error_bytelane_cmp;

  wire                                  clk;
  wire                                  rst;

  wire                                  vio_modify_enable;
  wire [3:0]                            vio_data_mode_value;
  wire                                  vio_pause_traffic;
  wire [2:0]                            vio_addr_mode_value;
  wire [3:0]                            vio_instr_mode_value;
  wire [1:0]                            vio_bl_mode_value;
  wire [7:0]                            vio_fixed_bl_value;
  wire [2:0]                            vio_fixed_instr_value;
  wire                                  vio_data_mask_gen;
  wire [TOTAL_CHN_NUM - 1 : 0]          pcr_correct_int_ena;
  wire [TOTAL_CHN_NUM - 1 : 0]          pcr_correct_ac_ena;
  wire                                  rst_ddr3;
  wire [10:0]                           dejitter_ms;
  wire                                  scram_clr;
  wire                                  clk_j83;
  
  assign    user_clk            =   clk;
  assign    user_rst            =   rst; 
  assign    tg_compare_error    =   1'b0; 
  assign    rst_ddr3            =   (~init_calib_complete) | rst;

//***************************************************************************    
// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

ddr3_test #(     
    .TCQ                                (TCQ),
    .ADDR_CMD_MODE                      (ADDR_CMD_MODE),
    .AL                                 (AL),
    .PAYLOAD_WIDTH                      (PAYLOAD_WIDTH),
    .BANK_WIDTH                         (BANK_WIDTH),
    .BURST_MODE                         (BURST_MODE),
    .BURST_TYPE                         (BURST_TYPE),
    .CA_MIRROR                          (CA_MIRROR),
    .CK_WIDTH                           (CK_WIDTH),
    .COL_WIDTH                          (COL_WIDTH),
    .CMD_PIPE_PLUS1                     (CMD_PIPE_PLUS1),
    .CS_WIDTH                           (CS_WIDTH),
    .nCS_PER_RANK                       (nCS_PER_RANK),
    .CKE_WIDTH                          (CKE_WIDTH),
    .DATA_WIDTH                         (DATA_WIDTH),
    .DATA_BUF_ADDR_WIDTH                (DATA_BUF_ADDR_WIDTH),
    .DQ_CNT_WIDTH                       (DQ_CNT_WIDTH),
    .DQ_PER_DM                          (DQ_PER_DM),
    .DQ_WIDTH                           (DQ_WIDTH),
    .DQS_CNT_WIDTH                      (DQS_CNT_WIDTH),
    .DQS_WIDTH                          (DQS_WIDTH),
    .DRAM_WIDTH                         (DRAM_WIDTH),
    .ECC                                (ECC),
    .ECC_WIDTH                          (ECC_WIDTH),
    .ECC_TEST                           (ECC_TEST),
    .MC_ERR_ADDR_WIDTH                  (MC_ERR_ADDR_WIDTH),
    .nAL                                (nAL),
    .nBANK_MACHS                        (nBANK_MACHS),
    .CKE_ODT_AUX                        (CKE_ODT_AUX),
    .ORDERING                           (ORDERING),
    .OUTPUT_DRV                         (OUTPUT_DRV),
    .IBUF_LPWR_MODE                     (IBUF_LPWR_MODE),
    .IODELAY_HP_MODE                    (IODELAY_HP_MODE),
    .DATA_IO_IDLE_PWRDWN                (DATA_IO_IDLE_PWRDWN),
    .BANK_TYPE                          (BANK_TYPE),
    .DATA_IO_PRIM_TYPE                  (DATA_IO_PRIM_TYPE),
    .REG_CTRL                           (REG_CTRL),
    .RTT_NOM                            (RTT_NOM),
    .RTT_WR                             (RTT_WR),
    .CL                                 (CL),
    .CWL                                (CWL),
    .tCKE                               (tCKE),
    .tFAW                               (tFAW),
    .tPRDI                              (tPRDI),
    .tRAS                               (tRAS),
    .tRCD                               (tRCD),
    .tREFI                              (tREFI),
    .tRFC                               (tRFC),
    .tRP                                (tRP),
    .tRRD                               (tRRD),
    .tRTP                               (tRTP),
    .tWTR                               (tWTR),
    .tZQI                               (tZQI),
    .tZQCS                              (tZQCS),
    .USER_REFRESH                       (USER_REFRESH),
    .WRLVL                              (WRLVL),
    .DEBUG_PORT                         (DEBUG_PORT),
    .RANKS                              (RANKS),
    .ODT_WIDTH                          (ODT_WIDTH),
    .ROW_WIDTH                          (ROW_WIDTH),
    .ADDR_WIDTH                         (ADDR_WIDTH),
    .SIM_BYPASS_INIT_CAL                (SIM_BYPASS_INIT_CAL),
    .SIMULATION                         (SIMULATION),
    .BYTE_LANES_B0                      (BYTE_LANES_B0),
    .BYTE_LANES_B1                      (BYTE_LANES_B1),
    .BYTE_LANES_B2                      (BYTE_LANES_B2),
    .BYTE_LANES_B3                      (BYTE_LANES_B3),
    .BYTE_LANES_B4                      (BYTE_LANES_B4),
    .DATA_CTL_B0                        (DATA_CTL_B0),
    .DATA_CTL_B1                        (DATA_CTL_B1),
    .DATA_CTL_B2                        (DATA_CTL_B2),
    .DATA_CTL_B3                        (DATA_CTL_B3),
    .DATA_CTL_B4                        (DATA_CTL_B4),
    .PHY_0_BITLANES                     (PHY_0_BITLANES),
    .PHY_1_BITLANES                     (PHY_1_BITLANES),
    .PHY_2_BITLANES                     (PHY_2_BITLANES),
    .CK_BYTE_MAP                        (CK_BYTE_MAP),
    .ADDR_MAP                           (ADDR_MAP),
    .BANK_MAP                           (BANK_MAP),
    .CAS_MAP                            (CAS_MAP),
    .CKE_ODT_BYTE_MAP                   (CKE_ODT_BYTE_MAP),
    .CKE_MAP                            (CKE_MAP),
    .ODT_MAP                            (ODT_MAP),
    .CS_MAP                             (CS_MAP),
    .PARITY_MAP                         (PARITY_MAP),
    .RAS_MAP                            (RAS_MAP),
    .WE_MAP                             (WE_MAP),
    .DQS_BYTE_MAP                       (DQS_BYTE_MAP),
    .DATA0_MAP                          (DATA0_MAP),
    .DATA1_MAP                          (DATA1_MAP),
    .DATA2_MAP                          (DATA2_MAP),
    .DATA3_MAP                          (DATA3_MAP),
    .DATA4_MAP                          (DATA4_MAP),
    .DATA5_MAP                          (DATA5_MAP),
    .DATA6_MAP                          (DATA6_MAP),
    .DATA7_MAP                          (DATA7_MAP),
    .DATA8_MAP                          (DATA8_MAP),
    .DATA9_MAP                          (DATA9_MAP),
    .DATA10_MAP                         (DATA10_MAP),
    .DATA11_MAP                         (DATA11_MAP),
    .DATA12_MAP                         (DATA12_MAP),
    .DATA13_MAP                         (DATA13_MAP),
    .DATA14_MAP                         (DATA14_MAP),
    .DATA15_MAP                         (DATA15_MAP),
    .DATA16_MAP                         (DATA16_MAP),
    .DATA17_MAP                         (DATA17_MAP),
    .MASK0_MAP                          (MASK0_MAP),
    .MASK1_MAP                          (MASK1_MAP),
    .CALIB_ROW_ADD                      (CALIB_ROW_ADD),
    .CALIB_COL_ADD                      (CALIB_COL_ADD),
    .CALIB_BA_ADD                       (CALIB_BA_ADD),
    .SLOT_0_CONFIG                      (SLOT_0_CONFIG),
    .SLOT_1_CONFIG                      (SLOT_1_CONFIG),
    .MEM_ADDR_ORDER                     (MEM_ADDR_ORDER),
    .USE_CS_PORT                        (USE_CS_PORT),
    .USE_DM_PORT                        (USE_DM_PORT),
    .USE_ODT_PORT                       (USE_ODT_PORT),
    .PHY_CONTROL_MASTER_BANK            (PHY_CONTROL_MASTER_BANK),                                                                               
    .TEMP_MON_CONTROL                   (TEMP_MON_CONTROL),
    .DM_WIDTH                           (DM_WIDTH), 
    .nCK_PER_CLK                        (nCK_PER_CLK),
    .tCK                                (tCK),
    .DIFF_TERM_SYSCLK                   (DIFF_TERM_SYSCLK),
    .CLKIN_PERIOD                       (CLKIN_PERIOD),
    .CLKFBOUT_MULT                      (CLKFBOUT_MULT),
    .DIVCLK_DIVIDE                      (DIVCLK_DIVIDE),
    .CLKOUT0_PHASE                      (CLKOUT0_PHASE),
    .CLKOUT0_DIVIDE                     (CLKOUT0_DIVIDE),
    .CLKOUT1_DIVIDE                     (CLKOUT1_DIVIDE),
    .CLKOUT2_DIVIDE                     (CLKOUT2_DIVIDE),
    .CLKOUT3_DIVIDE                     (CLKOUT3_DIVIDE),
                                        
    .SYSCLK_TYPE                        (SYSCLK_TYPE),
    .REFCLK_TYPE                        (REFCLK_TYPE),
    .SYS_RST_PORT                       (SYS_RST_PORT),
    .REFCLK_FREQ                        (REFCLK_FREQ),
    .DIFF_TERM_REFCLK                   (DIFF_TERM_REFCLK),
    .IODELAY_GRP                        (IODELAY_GRP),
                                        
    .CAL_WIDTH                          (CAL_WIDTH),
    .STARVE_LIMIT                       (STARVE_LIMIT),
    .DRAM_TYPE                          (DRAM_TYPE),                                      
    .RST_ACT_LOW                        (RST_ACT_LOW)
    )
u_ddr3_test(     
    // Memory interface ports
    .ddr3_addr                          (ddr3_addr),
    .ddr3_ba                            (ddr3_ba),
    .ddr3_cas_n                         (ddr3_cas_n),
    .ddr3_ck_n                          (ddr3_ck_n),
    .ddr3_ck_p                          (ddr3_ck_p),
    .ddr3_cke                           (ddr3_cke),
    .ddr3_ras_n                         (ddr3_ras_n),
    .ddr3_reset_n                       (ddr3_reset_n),
    .ddr3_we_n                          (ddr3_we_n),
    .ddr3_dq                            (ddr3_dq),
    .ddr3_dqs_n                         (ddr3_dqs_n),
    .ddr3_dqs_p                         (ddr3_dqs_p),
    .init_calib_complete                (init_calib_complete),
                                        
    .ddr3_cs_n                          (ddr3_cs_n),
    .ddr3_dm                            (ddr3_dm),
    .ddr3_odt                           (ddr3_odt),
    // Application interface ports
    .app_addr                           (app_addr),
    .app_cmd                            (app_cmd),
    .app_en                             (app_en),
    .app_wdf_data                       (app_wdf_data),
    .app_wdf_end                        (app_wdf_end),
    .app_wdf_wren                       (app_wdf_wren),
    .app_rd_data                        (app_rd_data),
    .app_rd_data_end                    (app_rd_data_end),
    .app_rd_data_valid                  (app_rd_data_valid),
    .app_rdy                            (app_rdy),
    .app_wdf_rdy                        (app_wdf_rdy),
    .app_sr_req                         (1'b0),
    .app_sr_active                      (app_sr_active),
    .app_ref_req                        (1'b0),
    .app_ref_ack                        (app_ref_ack),
    .app_zq_req                         (1'b0),
    .app_zq_ack                         (app_zq_ack),
    .ui_clk                             (clk),//78.125m
    .ui_clk_sync_rst                    (rst),
                                        
    .app_wdf_mask                       (app_wdf_mask),       
    // System Clock Ports
    .sys_clk_i                          (sys_clk_i),
    // Reference Clock Ports
    .clk_ref_i                          (clk_ref_i),     
    .device_temp_i                      ({12{1'b0}}),
    .sys_rst                            (sys_rst)
    );
    // End of User Design top instance

ddr_rw_ctrl #(
    .U_DLY                              ( 0                         ),
    .BUF_DEPTH_BIT                      ( BUF_DEPTH_BIT             ),
    .DDR3_ADDR_WIDTH                    ( ADDR_WIDTH                ),
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .PROG_PER_CHAN_BITWIDTH             ( PROG_PER_CHAN_BITWIDTH    ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_ddr_rw_ctrl(
    .clk_rx                             ( clk_rx                    ),
    .rst_rx                             ( rst_rx                    ),
    .clk                                ( clk                       ),
    .rst                                ( rst_ddr3                  ),
    .clk_156m                           ( clk_156m                  ),
    .rst_156m                           ( rst_156m                  ),    
    .gtx_rx_data                        ( gtx_rx_data               ),
    .gtx_rx_sof_n                       ( gtx_rx_sof_n              ),
    .gtx_rx_eof_n                       ( gtx_rx_eof_n              ),
    .gtx_rx_dvalid_n                    ( gtx_rx_dvalid_n           ),
    .scram_clr                          ( scram_clr                 ),
    .sc_data_pkt_d                      ( sc_data_pkt_d             ),
    .sc_data_pkt_dval                   ( sc_data_pkt_dval          ),
    .sc_data_pkt_sop                    ( sc_data_pkt_sop           ),
    .sc_data_pkt_eop                    ( sc_data_pkt_eop           ),
    .ts_in_data                         ( ts_data                   ),
    .ts_in_valid                        ( ts_data_valid             ),
    .ts_in_start                        ( ts_start                  ),
    .ts_in_end                          ( ts_end                    ),
    .pcr_correct_int_ena                ( pcr_correct_int_ena       ),
    .pcr_correct_ac_ena                 ( pcr_correct_ac_ena        ),
    
    .memc_cmd_ack                       ( app_rdy                   ),
    .memc_cmd_req                       ( app_en                    ),
    .memc_cmd                           ( app_cmd                   ),
    .memc_cmd_addr                      ( app_addr                  ),
    .memc_wr_req                        ( app_wdf_wren              ),
    .memc_wr_end                        ( app_wdf_end               ),
    .memc_wr_mask                       ( app_wdf_mask              ),
    .memc_wr_data                       ( app_wdf_data              ),
    .memc_wr_ack                        ( app_wdf_rdy               ),
    .memc_rd_data                       ( app_rd_data               ),
    .memc_rd_valid                      ( app_rd_data_valid         ),
    
    .clk_27m                            ( clk_27m                   ),
    .rst_27m                            ( rst_27m                   ),
    .clk_j83                            ( clk_j83                   ),
    .j83_ts_rd_sync                     ( j83_ts_rd_sync            ),
    .j83_ts_rd_req                      ( j83_ts_rd_req             ),
    .ts_j83_data_ch0                    ( ts_j83_data_ch0           ),
    .ts_j83_data_ch1                    ( ts_j83_data_ch1           ),
    .ts_j83_data_ch2                    ( ts_j83_data_ch2           ),
    .ts_j83_data_ch3                    ( ts_j83_data_ch3           ),
    .ts_j83_data_ch4                    ( ts_j83_data_ch4           ),
    .ts_j83_data_ch5                    ( ts_j83_data_ch5           ),
    .ts_j83_data_ch6                    ( ts_j83_data_ch6           ),
    .ts_j83_data_ch7                    ( ts_j83_data_ch7           ),
    
    .dejitter_ms                        ( dejitter_ms               )
    );
    
ddr_cfg #(
    .U_DLY                              ( 0                         ),
    .P_BUS_ADDR_WIDTH                   ( P_BUS_ADDR_WIDTH          ),
    .P_BUS_DATA_WIDTH                   ( P_BUS_DATA_WIDTH          ),
    .BUF_DEPTH_BIT                      ( BUF_DEPTH_BIT             ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_ddr_cfg(
    .ui_rst                             ( rst_ddr3                  ),
    .ui_clk                             ( clk                       ),
    .rst_cfg                            ( rst_cfg                   ), 
    .clk_cfg                            ( clk_cfg                   ),  
    //local bus
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_wdata                         ( lbus_wdata                ),
    .lbus_rdata                         ( lbus_rdata                ),
    .lbus_oe_n                          ( lbus_oe_n                 ),
    .lbus_we_n                          ( lbus_we_n                 ),
    .lbus_wait_n                        ( lbus_wait_n               ),
    
    .ad9739_wdata                       ( ad9739_wdata              ),
    .spi_ad9739                         ( spi_ad9739                ),
    .spi_ad9739_rd                      ( spi_ad9739_rd             ),
    .ad9739_raddr                       ( ad9739_raddr              ),
    .ad9739_rdata                       ( ad9739_rdata              ),
    .ad9739_oe                          ( ad9739_oe                 ),
    
    .spi_adf4350                        ( spi_adf4350               ),
    .adf4350_wdata                      ( adf4350_wdata             ),
    .adf4350_pdbrf                      ( adf4350_pdbrf             ),
    .amplifier_power_on                 ( amplifier_power_on        ),
    
    .dejitter_ms                        ( dejitter_ms               ),
    .scram_clr                          ( scram_clr                 ),
    
    .pcr_correct_int_ena                ( pcr_correct_int_ena       ),
    .pcr_correct_ac_ena                 ( pcr_correct_ac_ena        )
    );

endmodule
