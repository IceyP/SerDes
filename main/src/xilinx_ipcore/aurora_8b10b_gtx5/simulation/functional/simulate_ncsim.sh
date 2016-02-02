#!/bin/sh
##############################################################################
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
##############################################################################
##
## SIMULATE_NCSIM.SH
##
##
## Description: A .sh file to run a simulation using the aurora_8b10b_gtx5_exdes module,
##              an example design which instantiates aurora_8b10b_gtx5.
##
##              Ensure the follwoing:
##              The library paths for UNISIMS_VER, SIMPRIMS_VER, XILINXCORELIB_VER,
##              UNISIM, SIMPRIM, XILINXCORELIB are set correctly in the cds.lib and
##              hdl.var files.
##              Variables LMC_HOME and XILINX are set
##              Define the mapping for the work library in cds.lib file.
##              DEFINE work ./work
##             
##############################################################################

# Create and map a work directory
mkdir work
# Compile common sourcesthe glbl module, used to simulate global powerup features of the FPGA
ncvlog -work work $XILINX/verilog/src/glbl.v;
# Compile testbench source
ncvlog -work work ../../simulation/aurora_8b10b_gtx5_tb.v;
# Compile the HDL for the Device Under Test
# Hotplug Module
ncvlog -work work ../../src/aurora_8b10b_gtx5_hotplug.v;
# AXI Shim modules
ncvlog -work work ../../src/aurora_8b10b_gtx5_axi_to_ll.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_ll_to_axi.v;
# Aurora Lane Modules 
ncvlog -work work ../../src/aurora_8b10b_gtx5_chbond_count_dec.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_err_detect.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_lane_init_sm.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_sym_dec.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_sym_gen.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_aurora_lane.v;
# Global Logic Modules
ncvlog -work work ../../src/aurora_8b10b_gtx5_channel_err_detect.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_channel_init_sm.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_idle_and_ver_gen.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_global_logic.v;
# TX LocalLink User Interface modules
ncvlog -work work ../../src/aurora_8b10b_gtx5_tx_ll_control.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_tx_ll_datapath.v;
ncvlog -work work ../../src/aurora_8b10b_gtx5_tx_ll.v;
# RX_LL Pdu Modules
ncvlog -work work ../../src/aurora_8b10b_gtx5_rx_ll_pdu_datapath.v;
# RX_LL top level
ncvlog -work work ../../src/aurora_8b10b_gtx5_rx_ll.v;
# Top Level Modules and wrappers
ncvlog -work work ../../example_design/clock_module/aurora_8b10b_gtx5_clock_module.v;
ncvlog -work work ../../example_design/cc_manager/aurora_8b10b_gtx5_standard_cc_module.v;
ncvlog -work work ../../example_design/gt/aurora_8b10b_gtx5_transceiver_wrapper.v;
ncvlog -work work ../../example_design/gt/aurora_8b10b_gtx5_multi_gt.v;
ncvlog -work work ../../example_design/gt/aurora_8b10b_gtx5_gt.v;
ncvlog -work work ../../../aurora_8b10b_gtx5.v;
ncvlog -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx5_frame_check.v;
ncvlog -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx5_frame_gen.v;   
ncvlog -work work ../../example_design/aurora_8b10b_gtx5_reset_logic.v;
ncvlog -work work ../../example_design/aurora_8b10b_gtx5_exdes.v;
##Elaborate Design
ncelab -TIMESCALE 1ns/1ps -ACCESS +rw work.aurora_8b10b_gtx5_TB work.glbl

##Run simulation
ncsim work.aurora_8b10b_gtx5_TB -input @"simvision -input wave_ncsim.sv"
