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
`timescale 1ns / 1ps
(* core_generation_info = "aurora_8b10b_gtx1,aurora_8b10b_v8_3,{user_interface=AXI_4_Streaming,backchannel_mode=Sidebands,c_aurora_lanes=1,c_column_used=left,c_gt_clock_1=GTXQ1,c_gt_clock_2=None,c_gt_loc_1=X,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=X,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=X,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=X,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=1,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=false,c_simplex_mode=TX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=Duplex}" *)

//***************************** Entity Declaration ****************************

module aurora_8b10b_gtx1_hotplug #
(
   parameter ENABLE_HOTPLUG  =  1
)
(
    // Sym Dec Interface
    input           RX_CC,
    input           RX_SP,
    input           RX_SPA,

    // GT Wrapper Interface
    output          LINK_RESET_OUT,

    // System Interface
    input           INIT_CLK,
    input           USER_CLK,
    input           RESET
);

`define DLY #1

       
//***************************** Reg Declarations *****************************

 reg                link_reset_0;
 reg                link_reset_r;
 reg    [19:0]      count_for_reset_r;

 wire               rx_cc_comb_i;
 wire               rx_sp_comb_i;
 wire               rx_spa_comb_i;

//********************************* Main Body of Code**************************
                      
    initial
	    count_for_reset_r = 20'd0;

   // Clock domain crossing from USER_CLK to INIT_CLK
    aurora_8b10b_gtx1_cir_fifo rx_cc_cir_fifo_i
    (
      .reset      (RESET),
      .wr_clk     (USER_CLK),
      .din        (RX_CC),
      .rd_clk     (INIT_CLK),
      .dout       (rx_cc_comb_i)
    );	   

    aurora_8b10b_gtx1_cir_fifo rx_sp_cir_fifo_i
    (
      .reset      (RESET),
      .wr_clk     (USER_CLK),
      .din        (RX_SP),
      .rd_clk     (INIT_CLK),
      .dout       (rx_sp_comb_i)
    );	   

    aurora_8b10b_gtx1_cir_fifo rx_spa_cir_fifo_i
    (
      .reset      (RESET),
      .wr_clk     (USER_CLK),
      .din        (RX_SPA),
      .rd_clk     (INIT_CLK),
      .dout       (rx_spa_comb_i)
    );	   

    // Reset link if CC is not detected after 5000 clk cycles
    // Wait for sufficient number of times to allow the link recovery and CC consumption
    // This circuit for auto-recovery of the link during hot-plug scenario
    // Incoming control characters are decoded to detmine CC reception
    // RX_CC, RX_SP, RX_SPA are used as the reset for the count_for_reset_r, which would reset
    // the link after the defined time.
    // link_reset_0 is used to reset the GT & Aurora core

    always @(posedge INIT_CLK)
    begin
       if(rx_cc_comb_i || rx_sp_comb_i || rx_spa_comb_i)
	    count_for_reset_r <= `DLY 20'h0;
       else
            count_for_reset_r <= `DLY count_for_reset_r + 1'b1;
    end  

      // Wait for sufficient time : 2^20 = 1048576
      always @(posedge INIT_CLK)
      begin
        link_reset_0 <= `DLY ( (count_for_reset_r > 20'd1048560) & (count_for_reset_r < 20'd1048570) ) ? 1'b1 : 1'b0;
      end

      always @(posedge INIT_CLK)
      begin
        link_reset_r <= `DLY link_reset_0 ;
      end

generate
  if(ENABLE_HOTPLUG == 1)
    begin
      assign LINK_RESET_OUT = link_reset_r;
    end
  else
    begin
      assign LINK_RESET_OUT = 1'b0;
    end
endgenerate
endmodule

// Circular FIFO for clock domain crossing
module aurora_8b10b_gtx1_cir_fifo (

input wire reset,
input wire wr_clk,
input wire din,
input wire rd_clk,
output reg dout
);

reg [7:0] mem;
reg [2:0] wr_ptr;
reg [2:0] rd_ptr;

always @ ( posedge wr_clk  or posedge reset )
begin
   if ( reset )
   begin
      mem    <= `DLY 8'b0;
      wr_ptr <= `DLY 3'b0;
   end
   else
   begin
      mem[wr_ptr] <= `DLY din;
      wr_ptr <= `DLY wr_ptr + 1'b1;
   end
end

always @ ( posedge rd_clk or posedge reset )
begin
   if ( reset )
   begin
      rd_ptr <= `DLY 3'b100;
      dout   <= `DLY 1'b0;
   end
   else
   begin
      rd_ptr <= `DLY rd_ptr + 1'b1;
      dout   <= `DLY mem[rd_ptr];
   end
end

endmodule

