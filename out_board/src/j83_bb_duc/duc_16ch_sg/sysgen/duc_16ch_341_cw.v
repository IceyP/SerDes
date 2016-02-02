
//-----------------------------------------------------------------
// System Generator version 14.5 VERILOG source file.
//
// Copyright(C) 2013 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2013 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// System Generator version 14.5 VERILOG source file.
//
// Copyright(C) 2013 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2013 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
// synopsys translate_off
`ifndef simulating
  `define simulating 1
`endif
// synopsys translate_on
`ifndef simulating
  `define simulating 0
`endif
`ifndef xlUnsigned
 `define xlUnsigned 1
`endif
`ifndef xlSigned
 `define xlSigned 2
`endif
`ifndef xlFloat
 `define xlFloat 3
`endif
`ifndef xlWrap
 `define xlWrap 1
`endif
`ifndef xlSaturate
 `define xlSaturate 2
`endif
`ifndef xlTruncate
 `define xlTruncate 1
`endif
`ifndef xlRound
 `define xlRound 2
`endif
`ifndef xlRoundBanker
 `define xlRoundBanker 3
`endif
`ifndef xlAddMode
 `define xlAddMode 1
`endif
`ifndef xlSubMode
 `define xlSubMode 2
`endif
`ifndef xlConvPkgIncluded
 `define xlConvPkgIncluded 1
`endif

//-----------------------------------------------------------------
// System Generator version 14.5 VERILOG source file.
//
// Copyright(C) 2013 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2013 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
`timescale 1 ns / 10 ps
module xlclockdriver (sysclk, sysclr, sysce, clk, clr, ce, ce_logic);
   parameter signed [31:0] log_2_period = 1;
   parameter signed [31:0] period  = 2;
   parameter signed [31:0] use_bufg  = 1'b0;
   parameter signed [31:0] pipeline_regs = 5;

   input sysclk;
   input sysclr;
   input sysce;
   output clk;
   output clr;
   output ce;
   output ce_logic;
   parameter signed [31:0] max_pipeline_regs = 8;
   parameter signed [31:0] num_pipeline_regs = (max_pipeline_regs > pipeline_regs)? pipeline_regs : max_pipeline_regs;
   parameter signed [31:0] factor = num_pipeline_regs/period;
   parameter signed [31:0] rem_pipeline_regs =  num_pipeline_regs - (period * factor) + 1;
   parameter [log_2_period-1:0] trunc_period = ~period + 1;
   parameter signed [31:0] period_floor = (period>2)? period : 2;
   parameter signed [31:0] power_of_2_counter = (trunc_period == period) ? 1 : 0;
   parameter signed [31:0] cnt_width = (power_of_2_counter & (log_2_period>1)) ? (log_2_period - 1) : log_2_period;
   parameter [cnt_width-1:0] clk_for_ce_pulse_minus1 = period_floor-2;
   parameter [cnt_width-1:0] clk_for_ce_pulse_minus2 = (period-3>0)? period-3 : 0;
   parameter [cnt_width-1:0] clk_for_ce_pulse_minus_regs = ((period-rem_pipeline_regs)>0)? (period-rem_pipeline_regs) : 0;
   reg [cnt_width-1:0] clk_num;
   reg temp_ce_vec;
   (* MAX_FANOUT="REDUCE" *)wire [num_pipeline_regs:0] ce_vec /* synthesis MAX_FANOUT="REDUCE" */ ;
   (* MAX_FANOUT="REDUCE" *)wire [num_pipeline_regs:0] ce_vec_logic /* synthesis MAX_FANOUT="REDUCE" */;
   wire internal_ce;
   wire internal_ce_logic;
   reg cnt_clr;
   wire cnt_clr_dly;
   genvar index;
initial
   begin
      clk_num = 'b0;
   end
   assign clk = sysclk ;
   assign clr = sysclr ;
   always @(posedge sysclk)
     begin : cntr_gen
       if (sysce == 1'b1)
         begin:hc
           if ((cnt_clr_dly == 1'b1) || (sysclr == 1'b1))
             begin:u1
               clk_num = {cnt_width{1'b0}};
             end
           else
             begin:u2
               clk_num = clk_num + 1 ;
             end
         end
     end
   generate
      if (power_of_2_counter == 1)
        begin:clr_gen_p2
           always @(sysclr)
             begin:u1
                cnt_clr = sysclr;
             end
       end
   endgenerate
   generate
      if (power_of_2_counter == 0)
        begin:clr_gen
           always @(clk_num or sysclr)
             begin:u1
                if ( (clk_num == clk_for_ce_pulse_minus1) | (sysclr == 1'b1) )
                  begin:u2
                     cnt_clr = 1'b1 ;
                  end
                else
                  begin:u3
                     cnt_clr = 1'b0 ;
                  end
             end
       end
   endgenerate
   synth_reg_w_init #(1, 0, 'b0000, 1)
     clr_reg(.i(cnt_clr),
             .ce(sysce),
             .clr(sysclr),
             .clk(sysclk),
             .o(cnt_clr_dly));

   generate
      if (period > 1)
        begin:pipelined_ce
           always @(clk_num)
             begin:np_ce_gen
                if (clk_num == clk_for_ce_pulse_minus_regs)
                  begin
                     temp_ce_vec = 1'b1 ;
                  end
                else
                  begin
                     temp_ce_vec = 1'b0 ;
                  end
             end

           for(index=0; index<num_pipeline_regs; index=index+1)
             begin:ce_pipeline
                synth_reg_w_init #(1, ((((index+1)%period)>0)?0:1), 1'b0, 1)
                  ce_reg(.i(ce_vec[index+1]),
                         .ce(sysce),
                         .clr(sysclr),
                         .clk(sysclk),
                   .o(ce_vec[index]));
             end
         for(index=0; index<num_pipeline_regs; index=index+1)
             begin:ce_pipeline_logic
                synth_reg_w_init #(1, ((((index+1)%period)>0)?0:1), 1'b0, 1)
                      ce_reg_logic(.i(ce_vec_logic[index+1]),
                         .ce(sysce),
                         .clr(sysclr),
                         .clk(sysclk),
                     .o(ce_vec_logic[index]));
              end
          assign ce_vec_logic[num_pipeline_regs] = temp_ce_vec;
          assign ce_vec[num_pipeline_regs] = temp_ce_vec;
          assign internal_ce = ce_vec[0];
          assign internal_ce_logic = ce_vec_logic[0];
      end
   endgenerate
   generate
      if (period > 1)
        begin:period_greater_than_1
         if (use_bufg == 1'b1)
            begin:use_bufg
             BUFG ce_bufg_inst(.I(internal_ce), .O(ce));
             BUFG ce_logic_bufg_inst(.I(internal_ce_logic), .O(ce_logic));
            end
         else
           begin:no_bufg
            assign ce = internal_ce;
            assign ce_logic = internal_ce_logic;
           end
        end
    endgenerate

    generate
     if (period == 1)
       begin:period_1
         assign ce = sysce;
         assign ce_logic = sysce;
       end
    endgenerate
endmodule
(* syn_noprune = "true" *)
(* optimize_primitives = "false" *)
(* dont_touch = "true" *)
module default_clock_driver_duc_16ch_341 (
  ce_1,
  clk_1,
  sysclk,
  sysce,
  sysce_clr
);

  input  sysclk;
  input  sysce;
  input  sysce_clr;
  output  ce_1;
  output  clk_1;

  wire  sysce_clr_x0;
  wire  sysce_x0;
  wire  sysclk_x0;
  wire  xlclockdriver_1_ce;
  wire  xlclockdriver_1_clk;

  assign ce_1 = xlclockdriver_1_ce;
  assign clk_1 = xlclockdriver_1_clk;
  assign sysclk_x0 = sysclk;
  assign sysce_x0 = sysce;
  assign sysce_clr_x0 = sysce_clr;


  xlclockdriver #(

    .log_2_period(1),
    .period(1),
    .use_bufg(0))
  xlclockdriver_1 (
    .sysce(sysce_x0),
    .sysclk(sysclk_x0),
    .sysclr(sysce_clr_x0),
    .ce(xlclockdriver_1_ce),
    .clk(xlclockdriver_1_clk)
  );
endmodule
module duc_16ch_341_cw (
  clk,// clock period = 2.929 ns (341.41345168999663 Mhz)
  ce,
  din1,
  din2,
  ena_b0c0,
  ena_b0c1,
  ena_b0c10,
  ena_b0c11,
  ena_b0c12,
  ena_b0c13,
  ena_b0c14,
  ena_b0c15,
  ena_b0c2,
  ena_b0c3,
  ena_b0c4,
  ena_b0c5,
  ena_b0c6,
  ena_b0c7,
  ena_b0c8,
  ena_b0c9,
  ena_b1c0,
  ena_b1c1,
  ena_b1c10,
  ena_b1c11,
  ena_b1c12,
  ena_b1c13,
  ena_b1c14,
  ena_b1c15,
  ena_b1c2,
  ena_b1c3,
  ena_b1c4,
  ena_b1c5,
  ena_b1c6,
  ena_b1c7,
  ena_b1c8,
  ena_b1c9,
  ena_b2c0,
  ena_b2c1,
  ena_b2c10,
  ena_b2c11,
  ena_b2c12,
  ena_b2c13,
  ena_b2c14,
  ena_b2c15,
  ena_b2c2,
  ena_b2c3,
  ena_b2c4,
  ena_b2c5,
  ena_b2c6,
  ena_b2c7,
  ena_b2c8,
  ena_b2c9,
  freq_word0,
  freq_word1,
  freq_word10,
  freq_word11,
  freq_word12,
  freq_word13,
  freq_word14,
  freq_word15,
  freq_word2,
  freq_word24,
  freq_word25,
  freq_word26,
  freq_word27,
  freq_word28,
  freq_word29,
  freq_word3,
  freq_word30,
  freq_word31,
  freq_word32,
  freq_word33,
  freq_word34,
  freq_word35,
  freq_word4,
  freq_word5,
  freq_word6,
  freq_word7,
  freq_word8,
  freq_word9,
  iout0,
  iout1,
  iout10,
  iout11,
  iout2,
  iout3,
  iout4,
  iout5,
  iout6,
  iout7,
  iout8,
  iout9,
  rst
);

  input  clk;// clock period = 2.929 ns (341.41345168999663 Mhz)
  input  ce;
  input [15:0] din1;
  input [15:0] din2;
  input [0:0] ena_b0c0;
  input [0:0] ena_b0c1;
  input [0:0] ena_b0c10;
  input [0:0] ena_b0c11;
  input [0:0] ena_b0c12;
  input [0:0] ena_b0c13;
  input [0:0] ena_b0c14;
  input [0:0] ena_b0c15;
  input [0:0] ena_b0c2;
  input [0:0] ena_b0c3;
  input [0:0] ena_b0c4;
  input [0:0] ena_b0c5;
  input [0:0] ena_b0c6;
  input [0:0] ena_b0c7;
  input [0:0] ena_b0c8;
  input [0:0] ena_b0c9;
  input [0:0] ena_b1c0;
  input [0:0] ena_b1c1;
  input [0:0] ena_b1c10;
  input [0:0] ena_b1c11;
  input [0:0] ena_b1c12;
  input [0:0] ena_b1c13;
  input [0:0] ena_b1c14;
  input [0:0] ena_b1c15;
  input [0:0] ena_b1c2;
  input [0:0] ena_b1c3;
  input [0:0] ena_b1c4;
  input [0:0] ena_b1c5;
  input [0:0] ena_b1c6;
  input [0:0] ena_b1c7;
  input [0:0] ena_b1c8;
  input [0:0] ena_b1c9;
  input [0:0] ena_b2c0;
  input [0:0] ena_b2c1;
  input [0:0] ena_b2c10;
  input [0:0] ena_b2c11;
  input [0:0] ena_b2c12;
  input [0:0] ena_b2c13;
  input [0:0] ena_b2c14;
  input [0:0] ena_b2c15;
  input [0:0] ena_b2c2;
  input [0:0] ena_b2c3;
  input [0:0] ena_b2c4;
  input [0:0] ena_b2c5;
  input [0:0] ena_b2c6;
  input [0:0] ena_b2c7;
  input [0:0] ena_b2c8;
  input [0:0] ena_b2c9;
  input [9:0] freq_word0;
  input [9:0] freq_word1;
  input [9:0] freq_word10;
  input [9:0] freq_word11;
  input [9:0] freq_word12;
  input [9:0] freq_word13;
  input [9:0] freq_word14;
  input [9:0] freq_word15;
  input [9:0] freq_word2;
  input [9:0] freq_word24;
  input [9:0] freq_word25;
  input [9:0] freq_word26;
  input [9:0] freq_word27;
  input [9:0] freq_word28;
  input [9:0] freq_word29;
  input [9:0] freq_word3;
  input [9:0] freq_word30;
  input [9:0] freq_word31;
  input [9:0] freq_word32;
  input [9:0] freq_word33;
  input [9:0] freq_word34;
  input [9:0] freq_word35;
  input [9:0] freq_word4;
  input [9:0] freq_word5;
  input [9:0] freq_word6;
  input [9:0] freq_word7;
  input [9:0] freq_word8;
  input [9:0] freq_word9;
  input [0:0] rst;
  output [13:0] iout0;
  output [13:0] iout1;
  output [13:0] iout10;
  output [13:0] iout11;
  output [13:0] iout2;
  output [13:0] iout3;
  output [13:0] iout4;
  output [13:0] iout5;
  output [13:0] iout6;
  output [13:0] iout7;
  output [13:0] iout8;
  output [13:0] iout9;

(* MAX_FANOUT="REDUCE" *)  wire  ce_1_sg_x265/* synthesis MAX_FANOUT="REDUCE" */;
  wire  clkNet;
  wire  clk_1_sg_x265;
  wire [15:0] din1_net;
  wire [15:0] din2_net;
  wire [0:0] ena_b0c0_net;
  wire [0:0] ena_b0c10_net;
  wire [0:0] ena_b0c11_net;
  wire [0:0] ena_b0c12_net;
  wire [0:0] ena_b0c13_net;
  wire [0:0] ena_b0c14_net;
  wire [0:0] ena_b0c15_net;
  wire [0:0] ena_b0c1_net;
  wire [0:0] ena_b0c2_net;
  wire [0:0] ena_b0c3_net;
  wire [0:0] ena_b0c4_net;
  wire [0:0] ena_b0c5_net;
  wire [0:0] ena_b0c6_net;
  wire [0:0] ena_b0c7_net;
  wire [0:0] ena_b0c8_net;
  wire [0:0] ena_b0c9_net;
  wire [0:0] ena_b1c0_net;
  wire [0:0] ena_b1c10_net;
  wire [0:0] ena_b1c11_net;
  wire [0:0] ena_b1c12_net;
  wire [0:0] ena_b1c13_net;
  wire [0:0] ena_b1c14_net;
  wire [0:0] ena_b1c15_net;
  wire [0:0] ena_b1c1_net;
  wire [0:0] ena_b1c2_net;
  wire [0:0] ena_b1c3_net;
  wire [0:0] ena_b1c4_net;
  wire [0:0] ena_b1c5_net;
  wire [0:0] ena_b1c6_net;
  wire [0:0] ena_b1c7_net;
  wire [0:0] ena_b1c8_net;
  wire [0:0] ena_b1c9_net;
  wire [0:0] ena_b2c0_net;
  wire [0:0] ena_b2c10_net;
  wire [0:0] ena_b2c11_net;
  wire [0:0] ena_b2c12_net;
  wire [0:0] ena_b2c13_net;
  wire [0:0] ena_b2c14_net;
  wire [0:0] ena_b2c15_net;
  wire [0:0] ena_b2c1_net;
  wire [0:0] ena_b2c2_net;
  wire [0:0] ena_b2c3_net;
  wire [0:0] ena_b2c4_net;
  wire [0:0] ena_b2c5_net;
  wire [0:0] ena_b2c6_net;
  wire [0:0] ena_b2c7_net;
  wire [0:0] ena_b2c8_net;
  wire [0:0] ena_b2c9_net;
  wire [9:0] freq_word0_net;
  wire [9:0] freq_word10_net;
  wire [9:0] freq_word11_net;
  wire [9:0] freq_word12_net;
  wire [9:0] freq_word13_net;
  wire [9:0] freq_word14_net;
  wire [9:0] freq_word15_net;
  wire [9:0] freq_word1_net;
  wire [9:0] freq_word24_net;
  wire [9:0] freq_word25_net;
  wire [9:0] freq_word26_net;
  wire [9:0] freq_word27_net;
  wire [9:0] freq_word28_net;
  wire [9:0] freq_word29_net;
  wire [9:0] freq_word2_net;
  wire [9:0] freq_word30_net;
  wire [9:0] freq_word31_net;
  wire [9:0] freq_word32_net;
  wire [9:0] freq_word33_net;
  wire [9:0] freq_word34_net;
  wire [9:0] freq_word35_net;
  wire [9:0] freq_word3_net;
  wire [9:0] freq_word4_net;
  wire [9:0] freq_word5_net;
  wire [9:0] freq_word6_net;
  wire [9:0] freq_word7_net;
  wire [9:0] freq_word8_net;
  wire [9:0] freq_word9_net;
  wire [13:0] iout0_net;
  wire [13:0] iout10_net;
  wire [13:0] iout11_net;
  wire [13:0] iout1_net;
  wire [13:0] iout2_net;
  wire [13:0] iout3_net;
  wire [13:0] iout4_net;
  wire [13:0] iout5_net;
  wire [13:0] iout6_net;
  wire [13:0] iout7_net;
  wire [13:0] iout8_net;
  wire [13:0] iout9_net;
(* syn_keep="true" *)(* keep="true" *)(* preserve_signal="true" *)  wire  persistentdff_inst_q/* synthesis syn_keep=1 keep=1 preserve_signal=1 */;
  wire [0:0] rst_net;

  assign clkNet = clk;
  assign din1_net = din1;
  assign din2_net = din2;
  assign ena_b0c0_net = ena_b0c0;
  assign ena_b0c1_net = ena_b0c1;
  assign ena_b0c10_net = ena_b0c10;
  assign ena_b0c11_net = ena_b0c11;
  assign ena_b0c12_net = ena_b0c12;
  assign ena_b0c13_net = ena_b0c13;
  assign ena_b0c14_net = ena_b0c14;
  assign ena_b0c15_net = ena_b0c15;
  assign ena_b0c2_net = ena_b0c2;
  assign ena_b0c3_net = ena_b0c3;
  assign ena_b0c4_net = ena_b0c4;
  assign ena_b0c5_net = ena_b0c5;
  assign ena_b0c6_net = ena_b0c6;
  assign ena_b0c7_net = ena_b0c7;
  assign ena_b0c8_net = ena_b0c8;
  assign ena_b0c9_net = ena_b0c9;
  assign ena_b1c0_net = ena_b1c0;
  assign ena_b1c1_net = ena_b1c1;
  assign ena_b1c10_net = ena_b1c10;
  assign ena_b1c11_net = ena_b1c11;
  assign ena_b1c12_net = ena_b1c12;
  assign ena_b1c13_net = ena_b1c13;
  assign ena_b1c14_net = ena_b1c14;
  assign ena_b1c15_net = ena_b1c15;
  assign ena_b1c2_net = ena_b1c2;
  assign ena_b1c3_net = ena_b1c3;
  assign ena_b1c4_net = ena_b1c4;
  assign ena_b1c5_net = ena_b1c5;
  assign ena_b1c6_net = ena_b1c6;
  assign ena_b1c7_net = ena_b1c7;
  assign ena_b1c8_net = ena_b1c8;
  assign ena_b1c9_net = ena_b1c9;
  assign ena_b2c0_net = ena_b2c0;
  assign ena_b2c1_net = ena_b2c1;
  assign ena_b2c10_net = ena_b2c10;
  assign ena_b2c11_net = ena_b2c11;
  assign ena_b2c12_net = ena_b2c12;
  assign ena_b2c13_net = ena_b2c13;
  assign ena_b2c14_net = ena_b2c14;
  assign ena_b2c15_net = ena_b2c15;
  assign ena_b2c2_net = ena_b2c2;
  assign ena_b2c3_net = ena_b2c3;
  assign ena_b2c4_net = ena_b2c4;
  assign ena_b2c5_net = ena_b2c5;
  assign ena_b2c6_net = ena_b2c6;
  assign ena_b2c7_net = ena_b2c7;
  assign ena_b2c8_net = ena_b2c8;
  assign ena_b2c9_net = ena_b2c9;
  assign freq_word0_net = freq_word0;
  assign freq_word1_net = freq_word1;
  assign freq_word10_net = freq_word10;
  assign freq_word11_net = freq_word11;
  assign freq_word12_net = freq_word12;
  assign freq_word13_net = freq_word13;
  assign freq_word14_net = freq_word14;
  assign freq_word15_net = freq_word15;
  assign freq_word2_net = freq_word2;
  assign freq_word24_net = freq_word24;
  assign freq_word25_net = freq_word25;
  assign freq_word26_net = freq_word26;
  assign freq_word27_net = freq_word27;
  assign freq_word28_net = freq_word28;
  assign freq_word29_net = freq_word29;
  assign freq_word3_net = freq_word3;
  assign freq_word30_net = freq_word30;
  assign freq_word31_net = freq_word31;
  assign freq_word32_net = freq_word32;
  assign freq_word33_net = freq_word33;
  assign freq_word34_net = freq_word34;
  assign freq_word35_net = freq_word35;
  assign freq_word4_net = freq_word4;
  assign freq_word5_net = freq_word5;
  assign freq_word6_net = freq_word6;
  assign freq_word7_net = freq_word7;
  assign freq_word8_net = freq_word8;
  assign freq_word9_net = freq_word9;
  assign iout0 = iout0_net;
  assign iout1 = iout1_net;
  assign iout10 = iout10_net;
  assign iout11 = iout11_net;
  assign iout2 = iout2_net;
  assign iout3 = iout3_net;
  assign iout4 = iout4_net;
  assign iout5 = iout5_net;
  assign iout6 = iout6_net;
  assign iout7 = iout7_net;
  assign iout8 = iout8_net;
  assign iout9 = iout9_net;
  assign rst_net = rst;


  default_clock_driver_duc_16ch_341  default_clock_driver_duc_16ch_341_x0 (
    .sysce(1'b1),
    .sysce_clr(1'b0),
    .sysclk(clkNet),
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265)
  );

  duc_16ch_341  duc_16ch_341_x0 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .din1(din1_net),
    .din2(din2_net),
    .ena_b0c0(ena_b0c0_net),
    .ena_b0c1(ena_b0c1_net),
    .ena_b0c10(ena_b0c10_net),
    .ena_b0c11(ena_b0c11_net),
    .ena_b0c12(ena_b0c12_net),
    .ena_b0c13(ena_b0c13_net),
    .ena_b0c14(ena_b0c14_net),
    .ena_b0c15(ena_b0c15_net),
    .ena_b0c2(ena_b0c2_net),
    .ena_b0c3(ena_b0c3_net),
    .ena_b0c4(ena_b0c4_net),
    .ena_b0c5(ena_b0c5_net),
    .ena_b0c6(ena_b0c6_net),
    .ena_b0c7(ena_b0c7_net),
    .ena_b0c8(ena_b0c8_net),
    .ena_b0c9(ena_b0c9_net),
    .ena_b1c0(ena_b1c0_net),
    .ena_b1c1(ena_b1c1_net),
    .ena_b1c10(ena_b1c10_net),
    .ena_b1c11(ena_b1c11_net),
    .ena_b1c12(ena_b1c12_net),
    .ena_b1c13(ena_b1c13_net),
    .ena_b1c14(ena_b1c14_net),
    .ena_b1c15(ena_b1c15_net),
    .ena_b1c2(ena_b1c2_net),
    .ena_b1c3(ena_b1c3_net),
    .ena_b1c4(ena_b1c4_net),
    .ena_b1c5(ena_b1c5_net),
    .ena_b1c6(ena_b1c6_net),
    .ena_b1c7(ena_b1c7_net),
    .ena_b1c8(ena_b1c8_net),
    .ena_b1c9(ena_b1c9_net),
    .ena_b2c0(ena_b2c0_net),
    .ena_b2c1(ena_b2c1_net),
    .ena_b2c10(ena_b2c10_net),
    .ena_b2c11(ena_b2c11_net),
    .ena_b2c12(ena_b2c12_net),
    .ena_b2c13(ena_b2c13_net),
    .ena_b2c14(ena_b2c14_net),
    .ena_b2c15(ena_b2c15_net),
    .ena_b2c2(ena_b2c2_net),
    .ena_b2c3(ena_b2c3_net),
    .ena_b2c4(ena_b2c4_net),
    .ena_b2c5(ena_b2c5_net),
    .ena_b2c6(ena_b2c6_net),
    .ena_b2c7(ena_b2c7_net),
    .ena_b2c8(ena_b2c8_net),
    .ena_b2c9(ena_b2c9_net),
    .freq_word0(freq_word0_net),
    .freq_word1(freq_word1_net),
    .freq_word10(freq_word10_net),
    .freq_word11(freq_word11_net),
    .freq_word12(freq_word12_net),
    .freq_word13(freq_word13_net),
    .freq_word14(freq_word14_net),
    .freq_word15(freq_word15_net),
    .freq_word2(freq_word2_net),
    .freq_word24(freq_word24_net),
    .freq_word25(freq_word25_net),
    .freq_word26(freq_word26_net),
    .freq_word27(freq_word27_net),
    .freq_word28(freq_word28_net),
    .freq_word29(freq_word29_net),
    .freq_word3(freq_word3_net),
    .freq_word30(freq_word30_net),
    .freq_word31(freq_word31_net),
    .freq_word32(freq_word32_net),
    .freq_word33(freq_word33_net),
    .freq_word34(freq_word34_net),
    .freq_word35(freq_word35_net),
    .freq_word4(freq_word4_net),
    .freq_word5(freq_word5_net),
    .freq_word6(freq_word6_net),
    .freq_word7(freq_word7_net),
    .freq_word8(freq_word8_net),
    .freq_word9(freq_word9_net),
    .rst(rst_net),
    .iout0(iout0_net),
    .iout1(iout1_net),
    .iout10(iout10_net),
    .iout11(iout11_net),
    .iout2(iout2_net),
    .iout3(iout3_net),
    .iout4(iout4_net),
    .iout5(iout5_net),
    .iout6(iout6_net),
    .iout7(iout7_net),
    .iout8(iout8_net),
    .iout9(iout9_net)
  );

  xlpersistentdff  persistentdff_inst (
    .clk(clkNet),
    .d(persistentdff_inst_q),
    .q(persistentdff_inst_q)
  );
endmodule

module xlpersistentdff (
  clk,
  d,
  q
);

  input  clk;
  input  d;
  output  q;

endmodule
