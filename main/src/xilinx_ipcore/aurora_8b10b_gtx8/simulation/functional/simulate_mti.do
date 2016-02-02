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
## SIMULATE_MTI.DO
##
##
## Description: A .do file to run a simulation using the aurora_8b10b_gtx8_exdes module,
##              an example design which instantiates aurora_8b10b_gtx8.
##
##              The file modelsim.ini should be set correctly to map the logical
##              library names (such as  unisim, unisims_ver, simprim, simrprims_ver
##              etc.) to the corresponding physical directories where the precompiled
##              Xilinx libraries are located.
##             
##############################################################################
# Get environment variables needed for finding ISE source code
set XILINX   $env(XILINX)

# Create and map a work directory
vlib work
vmap work work
# Compile common sourcesthe glbl module, used to simulate global powerup features of the FPGA
vlog -work work $XILINX/verilog/src/glbl.v;
# Compile testbench source
vlog -work work ../../simulation/aurora_8b10b_gtx8_tb.v;
# Compile the HDL for the Device Under Test
# Hotplug Module
vlog -work work ../../src/aurora_8b10b_gtx8_hotplug.v;
# AXI Shim modules
vlog -work work ../../src/aurora_8b10b_gtx8_axi_to_ll.v;
vlog -work work ../../src/aurora_8b10b_gtx8_ll_to_axi.v;
# Aurora Lane Modules 
vlog -work work ../../src/aurora_8b10b_gtx8_chbond_count_dec.v;
vlog -work work ../../src/aurora_8b10b_gtx8_err_detect.v;
vlog -work work ../../src/aurora_8b10b_gtx8_lane_init_sm.v;
vlog -work work ../../src/aurora_8b10b_gtx8_sym_dec.v;
vlog -work work ../../src/aurora_8b10b_gtx8_sym_gen.v;
vlog -work work ../../src/aurora_8b10b_gtx8_aurora_lane.v;
# Global Logic Modules
vlog -work work ../../src/aurora_8b10b_gtx8_channel_err_detect.v;
vlog -work work ../../src/aurora_8b10b_gtx8_channel_init_sm.v;
vlog -work work ../../src/aurora_8b10b_gtx8_idle_and_ver_gen.v;
vlog -work work ../../src/aurora_8b10b_gtx8_global_logic.v;
# TX LocalLink User Interface modules
vlog -work work ../../src/aurora_8b10b_gtx8_tx_ll_control.v;
vlog -work work ../../src/aurora_8b10b_gtx8_tx_ll_datapath.v;
vlog -work work ../../src/aurora_8b10b_gtx8_tx_ll.v;
# RX_LL Pdu Modules
vlog -work work ../../src/aurora_8b10b_gtx8_rx_ll_pdu_datapath.v;
# RX_LL top level
vlog -work work ../../src/aurora_8b10b_gtx8_rx_ll.v;
# Top Level Modules and wrappers
vlog -work work ../../example_design/clock_module/aurora_8b10b_gtx8_clock_module.v;
vlog -work work ../../example_design/cc_manager/aurora_8b10b_gtx8_standard_cc_module.v;
vlog -work work ../../example_design/gt/aurora_8b10b_gtx8_transceiver_wrapper.v;
vlog -work work ../../example_design/gt/aurora_8b10b_gtx8_multi_gt.v;
vlog -work work ../../example_design/gt/aurora_8b10b_gtx8_gt.v;
vlog -work work ../../../aurora_8b10b_gtx8.v;
vlog -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx8_frame_check.v;
vlog -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx8_frame_gen.v;   
vlog -work work ../../example_design/aurora_8b10b_gtx8_reset_logic.v;
vlog -work work ../../example_design/aurora_8b10b_gtx8_exdes.v;
# Begin the test
vsim -L secureip -L unisims_ver -t ps work.aurora_8b10b_gtx8_TB work.glbl -voptargs="+acc" -GUSE_CHIPSCOPE=0
view wave
do wave_mti.do
run -a
