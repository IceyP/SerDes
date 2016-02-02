####################################################################################
## (c) Copyright 2008 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
##
####################################################################################
##
## WAVE_NCSIM.SV
##
##
## Description: This file is a wave file used for simulations with aurora_8b10b_gtx3_TB and
##              the frame generator and checker.
##

window new WaveWindow  -name  "Waves for aurora_8b10b_gtx3 Example Design"
waveform  using  "Waves for aurora_8b10b_gtx3 Example Design"



waveform  add  -label aurora_8b10b_gtx3 Core 1 -comment aurora_8b10b_gtx3 Core 1
waveform  add  -label Core 1 Framing TX Interface -comment Core 1 Framing TX Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:S_AXI_TX_TDATA
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:S_AXI_TX_TKEEP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:S_AXI_TX_TVALID
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:S_AXI_TX_TLAST
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:S_AXI_TX_TREADY
waveform  add  -label Core 1 Framing RX Interface -comment Core 1 Framing RX Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:M_AXI_RX_TDATA
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:M_AXI_RX_TKEEP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:M_AXI_RX_TVALID
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:M_AXI_RX_TLAST
waveform  add  -label Core 1 Error Detection Interface -comment Core 1 Error Detection Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:HARD_ERR
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:SOFT_ERR
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:FRAME_ERR
waveform  add  -label Core 1 Status Interface -comment Core 1 Status Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:CHANNEL_UP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:LANE_UP
waveform  add  -label Core 1 Clock Compensation Interface -comment Core 1 Clock Compensation Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:WARN_CC
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:DO_CC
waveform  add  -label Core 1 System Interface -comment Core 1 System Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:clock_module_i:PLL_NOT_LOCKED
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:RESET
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:POWER_DOWN
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:aurora_module_i:TX_OUT_CLK
waveform  add  -label Frame Checker Error Count for Core 1  -comment Frame Checker Error Count for Core 1
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_1_i:ERR_COUNT



waveform  add  -label aurora_8b10b_gtx3 Core 2 -comment aurora_8b10b_gtx3 Core 2
waveform  add  -label Core 2 Framing TX Interface -comment Core 2 Framing TX Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:S_AXI_TX_TDATA
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:S_AXI_TX_TKEEP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:S_AXI_TX_TVALID
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:S_AXI_TX_TLAST
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:S_AXI_TX_TREADY
waveform  add  -label Core 2 Framing RX Interface -comment Core 2 Framing RX Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:M_AXI_RX_TDATA
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:M_AXI_RX_TKEEP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:M_AXI_RX_TVALID
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:M_AXI_RX_TLAST
waveform  add  -label Core 2 Error Detection Interface -comment Core 2 Error Detection Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:HARD_ERR
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:SOFT_ERR
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:FRAME_ERR
waveform  add  -label Core 2 Status Interface -comment Core 2 Status Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:CHANNEL_UP
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:LANE_UP
waveform  add  -label Core 2 Clock Compensation Interface -comment Core 2 Clock Compensation Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:WARN_CC
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:DO_CC
waveform  add  -label Core 2 System Interface -comment Core 2 System Interface
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:USER_CLK
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:clock_module_i:PLL_NOT_LOCKED
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:RESET
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:POWER_DOWN
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:aurora_module_i:TX_OUT_CLK
waveform  add  -label Frame Checker Error Count for Core 2  -comment Frame Checker Error Count for Core 2
waveform  add  -signals :aurora_8b10b_gtx3_TB:example_design_2_i:ERR_COUNT



console submit -using simulator -wait no "run 950 us"
