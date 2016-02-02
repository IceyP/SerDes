####################################################################################
## (c) Copyright 2010 - 2011 Xilinx, Inc. All rights reserved.
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
####################################################################################
##
## SIMULATE_ISIM.SH
##
##
## Description: A .sh file to run a simulation using the aurora_8b10b_gtx7_exdes module,
##              an example design which instantiates aurora_8b10b_gtx7.
##
##
##############################################################################

# Create work directory
mkdir work
# Compile common sourcesthe glbl module, used to simulate global powerup features of the FPGA
vlogcomp -work work $XILINX/verilog/src/glbl.v;
# Compile testbench source
vlogcomp -work work ../../simulation/aurora_8b10b_gtx7_tb.v;
# Compile the HDL for the Device Under Test
# Hotplug Module
vlogcomp -work work ../../src/aurora_8b10b_gtx7_hotplug.v;
# AXI Shim modules
vlogcomp -work work ../../src/aurora_8b10b_gtx7_axi_to_ll.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_ll_to_axi.v;
# Aurora Lane Modules 
vlogcomp -work work ../../src/aurora_8b10b_gtx7_chbond_count_dec.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_err_detect.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_lane_init_sm.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_sym_dec.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_sym_gen.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_aurora_lane.v;
# Global Logic Modules
vlogcomp -work work ../../src/aurora_8b10b_gtx7_channel_err_detect.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_channel_init_sm.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_idle_and_ver_gen.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_global_logic.v;
# TX LocalLink User Interface modules
vlogcomp -work work ../../src/aurora_8b10b_gtx7_tx_ll_control.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_tx_ll_datapath.v;
vlogcomp -work work ../../src/aurora_8b10b_gtx7_tx_ll.v;
# RX_LL Pdu Modules
vlogcomp -work work ../../src/aurora_8b10b_gtx7_rx_ll_pdu_datapath.v;
# RX_LL top level
vlogcomp -work work ../../src/aurora_8b10b_gtx7_rx_ll.v;
# Top Level Modules and wrappers
vlogcomp -work work ../../example_design/clock_module/aurora_8b10b_gtx7_clock_module.v;
vlogcomp -work work ../../example_design/cc_manager/aurora_8b10b_gtx7_standard_cc_module.v;
vlogcomp -work work ../../example_design/gt/aurora_8b10b_gtx7_transceiver_wrapper.v;
vlogcomp -work work ../../example_design/gt/aurora_8b10b_gtx7_multi_gt.v;
vlogcomp -work work ../../example_design/gt/aurora_8b10b_gtx7_gt.v;
vlogcomp -work work ../../../aurora_8b10b_gtx7.v;
vlogcomp -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx7_frame_check.v;
vlogcomp -work work ../../example_design/traffic_gen_check/aurora_8b10b_gtx7_frame_gen.v;   
vlogcomp -work work ../../example_design/aurora_8b10b_gtx7_reset_logic.v;
vlogcomp -work work ../../example_design/aurora_8b10b_gtx7_exdes.v;
# Begin the test
fuse work.aurora_8b10b_gtx7_TB work.glbl -L unisims_ver -L secureip -o example_tb.exe
# To run in batch mode, invoke the following command without -gui option
./example_tb.exe -gui -tclbatch wave_isim.tcl -wdb wave_isim 
