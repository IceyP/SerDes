
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
module srl17e (clk, ce, d, q);
    parameter width = 16;
    parameter latency = 8;
    input clk, ce;
    input [width-1:0] d;
    output [width-1:0] q;
    parameter signed [5:0] a = latency - 2;
    wire[width - 1:0] #0.2 d_delayed;
    wire[width - 1:0] srl16_out;
    genvar i;
    assign d_delayed = d ;
    generate
      for(i=0; i<width; i=i+1)
      begin:reg_array
            if (latency > 1)
                begin: has_2_latency
                 SRL16E u1 (.CLK(clk), .D(d_delayed[i]), .Q(srl16_out[i]), .CE(ce), .A0(a[0]), .A1(a[1]), .A2(a[2]), .A3(a[3]));
                end
            if (latency <= 1)
                begin: has_1_latency
                 assign srl16_out[i] = d_delayed[i];
                end
            if (latency != 0)
                begin: has_latency
                 FDE u2 (.C(clk), .D(srl16_out[i]), .Q(q[i]), .CE(ce));
                end
            if (latency == 0)
                begin:has_0_latency
                 assign q[i] = srl16_out[i];
                end
        end
    endgenerate
endmodule
module synth_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce,clr,clk;
   output[width - 1:0] o;
   parameter complete_num_srl17es = latency/17;
   parameter remaining_latency = latency%17;
   parameter temp_num_srl17es = (latency/17) + ((latency%17)?1:0);
   parameter num_srl17es = temp_num_srl17es ? temp_num_srl17es : 1;
   wire [width - 1:0] z [0:num_srl17es-1];
   genvar t;
    generate
      if (latency <= 17)
          begin:has_only_1
              srl17e #(width, latency) srl17e_array0(.clk(clk), .ce(ce), .d(i), .q(o));
          end
     endgenerate
    generate
     if (latency > 17)
        begin:has_1
             assign o = z[num_srl17es-1];
             srl17e #(width, 17) srl17e_array0(.clk(clk), .ce(ce), .d(i), .q(z[0]));
        end
   endgenerate
   generate
      if (latency > 17)
          begin:more_than_1
              for (t=1; t < complete_num_srl17es; t=t+1)
                begin:left_complete_ones
                   srl17e #(width, 17) srl17e_array(.clk(clk), .ce(ce), .d(z[t-1]), .q(z[t]));
                end
          end
   endgenerate
   generate
     if ((remaining_latency > 0) && (latency>17))
          begin:remaining_ones
             srl17e #(width, (latency%17)) last_srl17e (.clk(clk), .ce(ce), .d(z[num_srl17es-2]), .q(z[num_srl17es-1]));
          end
   endgenerate
endmodule
module synth_reg_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[width - 1:0] o;
   genvar idx;
   reg[width - 1:0] reg_bank [latency:0];
   integer j;
   initial
     begin
        for (j=0; j < latency+1; j=j+1)
          begin
             reg_bank[j] = {width{1'b0}};
          end
     end

   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
       end
   endgenerate

   always @(i)
        begin
             reg_bank[0] = i;
         end
   generate
     if (latency > 0)
        begin:more_than_1
            assign o = reg_bank[latency];
         for (idx=0; idx < latency; idx=idx+1) begin:sync_loop
            always @(posedge clk)
                begin
                 if(clr)
                    begin
                      for (j=0; j < latency+1; j=j+1)
                        begin
                          reg_bank[j] = {width{1'b0}};
                       end
                    end
                 else if (ce)
                    begin
                        reg_bank[idx+1] <= reg_bank[idx] ;
                    end
               end
        end
      end
   endgenerate
endmodule

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
module synth_reg_w_init (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter init_index  = 0;
   parameter [width-1 : 0] init_value  = 'b0000;
   parameter latency  = 1;

   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[(latency + 1) * width - 1:0] dly_i;
   wire #0.2 dly_clr;
   genvar index;

   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
        end
     else
        begin:has_latency
         assign dly_i[(latency + 1) * width - 1:latency * width] = i ;
         assign dly_clr = clr ;
         for (index=1; index<=latency; index=index+1)
           begin:fd_array
// synopsys translate_off
             defparam reg_comp_1.width = width;
             defparam reg_comp_1.init_index = init_index;
             defparam reg_comp_1.init_value = init_value;
// synopsys translate_on
             single_reg_w_init #(width, init_index, init_value)
               reg_comp_1(.clk(clk),
                          .i(dly_i[(index + 1)*width-1:index*width]),
                          .o(dly_i[index * width - 1:(index - 1) * width]),
                          .ce(ce),
                          .clr(dly_clr));
             end
        assign o = dly_i[width-1:0];
       end
   endgenerate
endmodule
module single_reg_w_init (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter init_index  = 0;
   parameter [width-1 : 0] init_value  = 8'b00000000;
   input[width - 1:0] i;
   input ce;
   input clr;
   input clk;
   output[width - 1:0] o;
   parameter [0:0] init_index_val = (init_index ==  1) ? 1'b1 : 1'b0;
   parameter [width-1:0] result = (width > 1) ? { {(width-1){1'b0}}, init_index_val } : init_index_val;
   parameter [width-1:0] init_const = (init_index > 1) ? init_value : result;
   wire[width - 1:0] o;
   genvar index;

   generate
     for (index=0;index < width; index=index+1) begin:fd_prim_array
          if (init_const[index] == 0)
            begin:rst_comp
              FDRE fdre_comp(.C(clk),
                             .D(i[index]),
                             .Q(o[index]),
                             .CE(ce),
                             .R(clr));
            end
          else
            begin:set_comp
             FDSE fdse_comp(.C(clk),
                            .D(i[index]),
                            .Q(o[index]),
                            .CE(ce),
                            .S(clr));
            end
    end
   endgenerate
endmodule

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
`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif
`ifndef xlConvertType
 `define xlConvertType
 `timescale 1 ns / 10 ps
module cast (inp, res);
    parameter signed [31:0] old_width = 4;
    parameter signed [31:0] old_bin_pt = 1;
    parameter signed [31:0] new_width = 4;
    parameter signed [31:0] new_bin_pt = 1;
    parameter signed [31:0] new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0] right_of_dp = new_bin_pt - old_bin_pt;
    wire [new_width-1:0] result;
   genvar i;
   assign res = result;
   generate
      for (i = 0; i<new_width;  i = i+1)
        begin:cast_loop
           if ((i-right_of_dp) > old_width - 1)
             begin:u0
                if (new_arith == `xlUnsigned)
                  begin:u1
                     assign result[i] = 1'b0;
                  end
                if (new_arith == `xlSigned)
                  begin:u2
                     assign result[i] = inp[old_width-1];
                  end
             end
           else if ((i-right_of_dp) >= 0)
             begin:u3
                assign result[i] = inp[i-right_of_dp];
             end
           else
             begin:u4
                assign result[i] = 1'b0;
             end
        end
      endgenerate

endmodule
module shift_division_result (quotient, fraction, res);
    parameter signed [31:0] q_width = 16;
    parameter signed [31:0] f_width = 16;
    parameter signed [31:0] fraction_width = 8;
    parameter signed [31:0] shift_value = 8;
    parameter signed [31:0] shift_dir = 0;
    parameter signed [31:0] vec_MSB = q_width + f_width - 1;
    parameter signed [31:0] result_MSB = q_width + fraction_width - 1;
    parameter signed [31:0] result_LSB = vec_MSB - result_MSB;
    input [q_width - 1 : 0] quotient;
    input [f_width - 1 : 0] fraction;
    output [result_MSB : 0] res;

    wire [vec_MSB:0] vec;
    wire [vec_MSB:0] temp;
   genvar i;
   assign res = vec[vec_MSB:result_LSB];
   assign temp = { quotient, fraction };
   generate
      if (shift_dir == 1)
      begin:left_shift_loop
         for (i = vec_MSB; i>=0;  i = i-1)
         begin:u0
            if (i < shift_value)
            begin:u1
               assign vec[i] = 1'b0;
            end
            else
            begin:u2
               assign vec[i] = temp[i-shift_value];
             end
         end
      end
      else
      begin:right_shift_loop
         for (i = 0; i <= vec_MSB; i = i+1)
         begin:u3
            if (i > vec_MSB - shift_value)
            begin:u4
               assign vec[i] = temp[vec_MSB];
            end
            else
            begin:u5
               assign vec[i] = temp[i+shift_value];
            end
         end
      end
   endgenerate

endmodule
module shift_op (inp, res);
    parameter signed [31:0] inp_width = 16;
    parameter signed [31:0] result_width = 16;
    parameter signed [31:0] shift_value = 8;
    parameter signed [31:0] shift_dir = 0;
    parameter signed [31:0] vec_MSB = inp_width - 1;
    parameter signed [31:0] result_MSB = result_width - 1;
    parameter signed [31:0] result_LSB = vec_MSB - result_MSB;
    input [vec_MSB : 0] inp;
    output [result_MSB : 0] res;

    wire [vec_MSB:0] vec;
   genvar i;
   assign res = vec[vec_MSB:result_LSB];
   generate
      if (shift_dir == 1)
      begin:left_shift_loop
         for (i = vec_MSB; i>=0;  i = i-1)
         begin:u0
            if (i < shift_value)
            begin:u1
               assign vec[i] = 1'b0;
            end
            else
            begin:u2
               assign vec[i] = inp[i-shift_value];
             end
         end
      end
      else
      begin:right_shift_loop
         for (i = 0; i <= vec_MSB; i = i+1)
         begin:u3
            if (i > vec_MSB - shift_value)
            begin:u4
               assign vec[i] = inp[vec_MSB];
            end
            else
            begin:u5
               assign vec[i] = inp[i+shift_value];
            end
         end
      end
   endgenerate

endmodule
module pad_lsb (inp, res);
   parameter signed [31:0] orig_width = 4;
   parameter signed [31:0] new_width = 2;
   input [orig_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   parameter signed [31:0] pad_pos = new_width - orig_width -1;
   wire [new_width-1:0] result;
   genvar i;
   assign  res = result;
   generate
      if (new_width >= orig_width)
        begin:u0
           assign result[new_width-1:new_width-orig_width] = inp[orig_width-1:0];
        end
   endgenerate

   generate
      if (pad_pos >= 0)
        begin:u1
           assign result[pad_pos:0] = {pad_pos{1'b0}};
        end
   endgenerate
endmodule
module zero_ext (inp, res);
   parameter signed [31:0]  old_width = 4;
   parameter signed [31:0]  new_width = 2;
   input [old_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   genvar i;
   assign res = result;
   generate
     if (new_width > old_width)
       begin:u0
          assign result = { {(new_width-old_width){1'b0}}, inp};
       end
     else
       begin:u1
          assign result[new_width-1:0] = inp[new_width-1:0];
       end
    endgenerate
endmodule
module sign_ext (inp, res);
   parameter signed [31:0]  old_width = 4;
   parameter signed [31:0]  new_width = 2;
   input [old_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   assign res = result;
   generate
     if (new_width > old_width)
       begin:u0
          assign result = { {(new_width-old_width){inp[old_width-1]}}, inp};
       end
     else
       begin:u1
          assign result[new_width-1:0] = inp[new_width-1:0];
       end
   endgenerate

endmodule
module extend_msb (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
    wire [new_width-1:0] result;
   assign res = result;
   generate
      if (new_arith ==`xlUnsigned)
        begin:u0
           zero_ext # (old_width, new_width)
             em_zero_ext (.inp(inp), .res(result));
        end
      else
        begin:u1
           sign_ext # (old_width, new_width)
             em_sign_ext (.inp(inp), .res(result));
        end
    endgenerate
endmodule
module align_input (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  delta = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
    parameter signed [31:0]  abs_delta = (delta >= 0) ? (delta) : (-delta);
    wire [new_width-1:0] result;
    wire [(old_width+abs_delta)-1:0] padded_inp;
   assign res = result;
   generate
      if (delta > 0)
        begin:u0
           pad_lsb # (old_width, old_width+delta)
             ai_pad_lsb (.inp(inp), .res(padded_inp));
           extend_msb # (old_width+delta, new_width, new_arith)
             ai_extend_msb (.inp(padded_inp), .res(result));
        end
      else
        begin:u1
           extend_msb # (old_width, new_width, new_arith)
             ai_extend_msb (.inp(inp), .res(result));
        end
   endgenerate
endmodule
module round_towards_inf (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  right_of_dp_2 = (right_of_dp >=2) ? right_of_dp-2 : 0;
   parameter signed [31:0]  right_of_dp_1 = (right_of_dp >=1) ? right_of_dp-1 : 0;
   reg [new_width-1:0] one_or_zero;
   wire [new_width-1:0] truncated_val;
   wire signed [new_width-1:0] result_signed;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   initial
     begin
        one_or_zero = {new_width{1'b0}};
     end
   generate
      if (right_of_dp >= 0)
        begin:u0
           if (new_arith ==`xlUnsigned)
             begin:u1
                zero_ext # (old_width-right_of_dp, new_width)
                  rti_zero_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
           else
             begin:u2
                sign_ext # (old_width-right_of_dp, new_width)
                  rti_sign_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
        end
      else
        begin:u3
           pad_lsb # (old_width, abs_right_of_dp+old_width)
             rti_pad_lsb (.inp(inp), .res(padded_val));
           if (new_arith ==`xlUnsigned)
             begin:u4
                zero_ext # (abs_right_of_dp+old_width, new_width)
                  rti_zero_ext1 (.inp(padded_val), .res(truncated_val));
             end
           else
             begin:u5
                sign_ext # (abs_right_of_dp+old_width, new_width)
                  rti_sign_ext1 (.inp(padded_val), .res(truncated_val));
             end
        end
   endgenerate
   generate
      if (new_arith == `xlSigned)
        begin:u6
           always @(inp)
             begin
                one_or_zero = {new_width{1'b0}};
               if (inp[old_width-1] == 1'b0)
                 begin
                    one_or_zero[0] = 1'b1;
                 end
               if ((right_of_dp >=2) && (right_of_dp <= old_width))
                 begin
                    if(|inp[right_of_dp_2:0] == 1'b1)
                       begin
                          one_or_zero[0] = 1'b1;
                       end
                 end
               if ((right_of_dp >=1) && (right_of_dp <= old_width))
                 begin
                    if(inp[right_of_dp_1] == 1'b0)
                      begin
                         one_or_zero[0] = 1'b0;
                      end
                 end
               else
                 begin
                    one_or_zero[0] = 1'b0;
                 end
             end
             assign result_signed = truncated_val + one_or_zero;
             assign res = result_signed;
        end

      else
        begin:u7
           always @(inp)
             begin
                one_or_zero = {new_width{1'b0}};
               if ((right_of_dp >=1) && (right_of_dp <= old_width))
                 begin
                    one_or_zero[0] = inp[right_of_dp_1];
                 end
             end
             assign res = truncated_val + one_or_zero;
        end
   endgenerate

endmodule
module round_towards_even (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  expected_new_width = old_width - right_of_dp + 1;
   reg [new_width-1:0] one_or_zero;
   wire signed [new_width-1:0] result_signed;
   wire [new_width-1:0] truncated_val;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   initial
     begin
      one_or_zero = { new_width{1'b0}};
     end

   generate
      if (right_of_dp >= 0)
        begin:u0
           if (new_arith == `xlUnsigned)
             begin:u1
                zero_ext # (old_width-right_of_dp, new_width)
                            rte_zero_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
           else
             begin:u2
                sign_ext # (old_width-right_of_dp, new_width)
                            rte_sign_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
        end

      else
        begin:u3
           pad_lsb # (old_width, abs_right_of_dp+old_width)
                            rte_pad_lsb (.inp(inp), .res(padded_val));
           if (new_arith == `xlUnsigned)
             begin:u4
                zero_ext # (abs_right_of_dp+old_width, new_width)
                            rte_zero_ext1 (.inp(padded_val), .res(truncated_val));
             end
           else
             begin:u5
                sign_ext # (abs_right_of_dp+old_width, new_width)
                            rte_sign_ext1 (.inp(padded_val), .res(truncated_val));
             end
        end
   endgenerate

   generate
      if ((right_of_dp ==1) && (right_of_dp <= old_width))
        begin:u6a
           always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
                if(inp[right_of_dp-1] == 1'b1)
                  begin
                     one_or_zero[0] = inp[right_of_dp];
                  end
                else
                  begin
                     one_or_zero[0] = inp[right_of_dp-1];
                  end
             end
       end
      else if ((right_of_dp >=2) && (right_of_dp <= old_width))
        begin:u6b
           always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
                if( (inp[right_of_dp-1] == 'b1) && !(|inp[right_of_dp-2:0]) )
                  begin
                     one_or_zero[0] = inp[right_of_dp];
                  end
                else
                  begin
                     one_or_zero[0] = inp[right_of_dp-1];
                  end
             end
       end
      else
        begin:u7
            always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
             end
        end
   endgenerate

   generate
      if (new_arith == `xlSigned)
        begin:u8
           assign result_signed = truncated_val + one_or_zero;
           assign res = result_signed;
        end
      else
        begin:u9
           assign res = truncated_val + one_or_zero;
        end
   endgenerate

endmodule
module trunc (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   wire [new_width-1:0] result;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   assign res = result;
   generate
      if (new_bin_pt > old_bin_pt)
        begin:tr_u2
           pad_lsb # (old_width, abs_right_of_dp+old_width)
             tr_pad_lsb (.inp(inp), .res(padded_val));
           extend_msb # (old_width+abs_right_of_dp, new_width, new_arith)
             tr_extend_msb (.inp(padded_val), .res(result));
        end
      else
        begin:tr_u1
           extend_msb # (old_width-right_of_dp, new_width, new_arith)
             tr_extend_msb (.inp(inp[old_width-1:right_of_dp]), .res(result));
        end
   endgenerate

endmodule
module saturation_arith (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  abs_width = (new_width > old_width) ? (new_width-old_width) : 1;
   parameter signed [31:0]  abs_new_width = (old_width > new_width) ? new_width : 1;
   reg overflow;
   reg [old_width-1:0] vec;
   reg [new_width-1:0] result;
   assign res = result;
   generate
      if (old_width > new_width)
        begin:sa_u0
           always @ (inp)
             begin
                vec = inp;
                overflow = 1;
                if ( (old_arith == `xlSigned) && (new_arith == `xlSigned) )
                  begin
                    if (~|inp[old_width-1:abs_new_width-1] || &inp[old_width-1:abs_new_width-1])
                     begin
                       overflow = 0;
                     end
                 end

                if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned))
                   begin
                    if (~|inp[old_width-1 : abs_new_width])
                    begin
                       overflow = 0;
                    end
                end

                if ((old_arith == `xlUnsigned) &&  (new_arith == `xlUnsigned))
                  begin
                    if (~|inp[old_width-1 : abs_new_width])
                     begin
                       overflow = 0;
                     end
                  end

               if ( (old_arith == `xlUnsigned) && (new_arith == `xlSigned))
                 begin
                  if (~|inp[old_width-1:abs_new_width-1] || &inp[old_width-1:abs_new_width-1])
                    begin
                      overflow = 0;
                    end
                 end
               if (overflow == 1)
                 begin
                   if (new_arith == `xlSigned)
                     begin
                       if (inp[old_width-1] == 'b0)
                         begin
                           result = (new_width ==1) ? 1'b0 : {1'b0, {(new_width-1){1'b1}} };
                         end
                      else
                        begin
                          result = (new_width ==1) ? 1'b1 : {1'b1, {(new_width-1){1'b0}} };
                       end
                     end
                   else
                     begin
                       if ((old_arith == `xlSigned) && (inp[old_width-1] == 'b1))
                         begin
                           result = {new_width{1'b0}};
                         end
                       else
                         begin
                           result = {new_width{1'b1}};
                         end
                     end
                 end
               else
                 begin
                    if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 'b1) )
                    begin
                      vec = {old_width{1'b0}};
                    end
                    result = vec[new_width-1:0];
                 end
             end
        end
   endgenerate
   generate
      if (new_width > old_width)
        begin:sa_u1
         always @ (inp)
           begin
            vec = inp;
            if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 1'b1) )
              begin
                vec = {old_width{1'b0}};
              end
              if (new_arith == `xlUnsigned)
                begin
                  result = { {abs_width{1'b0}}, vec};
                end
              else
                begin
                  result = { {abs_width{inp[old_width-1]}}, vec};
                end
           end
       end
   endgenerate

   generate
      if (new_width == old_width)
        begin:sa_u2
         always @ (inp)
           begin
             if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 'b1) )
               begin
                 result = {old_width{1'b0}};
               end
             else
               begin
                 result = inp;
               end
           end
        end
   endgenerate

endmodule
module wrap_arith (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  result_arith = ((old_arith==`xlSigned)&&(new_arith==`xlUnsigned))? `xlSigned : new_arith;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   cast # (old_width, old_bin_pt, new_width, new_bin_pt, result_arith)
     wrap_cast (.inp(inp), .res(result));
   assign res = result;

endmodule
module convert_type (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  quantization = `xlTruncate;
    parameter signed [31:0]  overflow = `xlWrap;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  fp_width = old_width + 2;
   parameter signed [31:0]  fp_bin_pt = old_bin_pt;
   parameter signed [31:0]  fp_arith = old_arith;
   parameter signed [31:0]  q_width = fp_width + new_bin_pt - old_bin_pt;
   parameter signed [31:0]  q_bin_pt = new_bin_pt;
   parameter signed [31:0]  q_arith = old_arith;
   wire [fp_width-1:0] full_precision_result;
   wire [new_width-1:0] result;
   wire [q_width-1:0] quantized_result;
   assign res = result;
   cast # (old_width, old_bin_pt, fp_width, fp_bin_pt, fp_arith)
     fp_cast (.inp(inp), .res(full_precision_result));
   generate
      if (quantization == `xlRound)
        begin:ct_u0
           round_towards_inf # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_rtf (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (quantization == `xlRoundBanker)
        begin:ct_u1
           round_towards_even # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_rte (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (quantization == `xlTruncate)
        begin:ct_u2
           trunc # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_tr (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (overflow == `xlSaturate)
        begin:ct_u3
           saturation_arith # (q_width, q_bin_pt, q_arith, new_width, new_bin_pt, new_arith)
            ovflo_sat (.inp(quantized_result), .res(result));
        end
   endgenerate

   generate
      if ((overflow == `xlWrap) || (overflow == 3))
        begin:ct_u4
           wrap_arith # (q_width, q_bin_pt, q_arith, new_width, new_bin_pt, new_arith)
             ovflo_wrap (.inp(quantized_result), .res(result));
        end
   endgenerate

endmodule
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
 module xladdsub_duc_16ch_341 (a, b, c_in, ce, clr, clk, rst, en, c_out, s);
parameter core_name0= "";
parameter a_width= 16;
parameter signed a_bin_pt= 4;
parameter a_arith= `xlUnsigned;
parameter c_in_width= 16;
parameter c_in_bin_pt= 4;
parameter c_in_arith= `xlUnsigned;
parameter c_out_width= 16;
parameter c_out_bin_pt= 4;
parameter c_out_arith= `xlUnsigned;
parameter b_width= 8;
parameter signed b_bin_pt= 2;
parameter b_arith= `xlUnsigned;
parameter s_width= 17;
parameter s_bin_pt= 4;
parameter s_arith= `xlUnsigned;
parameter rst_width= 1;
parameter rst_bin_pt= 0;
parameter rst_arith= `xlUnsigned;
parameter en_width= 1;
parameter en_bin_pt= 0;
parameter en_arith= `xlUnsigned;
parameter full_s_width= 17;
parameter full_s_arith= `xlUnsigned;
parameter mode= `xlAddMode;
parameter extra_registers= 0;
parameter latency= 0;
parameter quantization= `xlTruncate;
parameter overflow= `xlWrap;
parameter c_a_width= 16;
parameter c_b_width= 8;
parameter c_a_type= 1;
parameter c_b_type= 1;
parameter c_has_sclr= 0;
parameter c_has_ce= 0;
parameter c_latency= 0;
parameter c_output_width= 17;
parameter c_enable_rlocs= 1;
parameter c_has_c_in= 0;
parameter c_has_c_out= 0;
input [a_width-1:0] a;
input [b_width-1:0] b;
input c_in, ce, clr, clk, rst, en;
output c_out;
output [s_width-1:0] s;
parameter full_a_width = full_s_width;
parameter full_b_width = full_s_width;
parameter full_s_bin_pt = (a_bin_pt > b_bin_pt) ? a_bin_pt : b_bin_pt;
wire [full_a_width-1:0] full_a;
wire [full_b_width-1:0] full_b;
wire [full_s_width-1:0] full_s;
wire [full_s_width-1:0] core_s;
wire [s_width-1:0] conv_s;
wire  temp_cout;
wire  real_a,real_b,real_s;
wire  internal_clr;
wire  internal_ce;
wire  extra_reg_ce;
wire  override;
wire  logic1;
wire  temp_cin;
assign internal_clr = (clr | rst) & ce;
assign internal_ce = ce & en;
assign logic1 = 1'b1;
assign temp_cin = (c_has_c_in) ? c_in : 1'b0;
align_input # (a_width, b_bin_pt - a_bin_pt, a_arith, full_a_width)
align_inp_a(.inp(a),.res(full_a));
align_input # (b_width, a_bin_pt - b_bin_pt, b_arith, full_b_width)
align_inp_b(.inp(b),.res(full_b));
convert_type # (full_s_width, full_s_bin_pt, full_s_arith, s_width,
                s_bin_pt, s_arith, quantization, overflow)
conv_typ_s(.inp(core_s),.res(conv_s));
generate
  if (core_name0 == "addsb_11_0_cfbd5258ba626a7a")
    begin:comp0
    addsb_11_0_cfbd5258ba626a7a core_instance0 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_315e1457f99dae5e")
    begin:comp1
    addsb_11_0_315e1457f99dae5e core_instance1 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_ccf4ef11a52a233f")
    begin:comp2
    addsb_11_0_ccf4ef11a52a233f core_instance2 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_f1b619e12671c199")
    begin:comp3
    addsb_11_0_f1b619e12671c199 core_instance3 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_c70c61eff7bb7aeb")
    begin:comp4
    addsb_11_0_c70c61eff7bb7aeb core_instance4 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_750c6c8a22bc78ba")
    begin:comp5
    addsb_11_0_750c6c8a22bc78ba core_instance5 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_45f8b994267d2451")
    begin:comp6
    addsb_11_0_45f8b994267d2451 core_instance6 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_d0318fcf26b3c272")
    begin:comp7
    addsb_11_0_d0318fcf26b3c272 core_instance7 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_82f1c5fd59d21ea0")
    begin:comp8
    addsb_11_0_82f1c5fd59d21ea0 core_instance8 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_27308e86a0ce55d1")
    begin:comp9
    addsb_11_0_27308e86a0ce55d1 core_instance9 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_3cbd55626510ca57")
    begin:comp10
    addsb_11_0_3cbd55626510ca57 core_instance10 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_fc66294023431638")
    begin:comp12
    addsb_11_0_fc66294023431638 core_instance12 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_3b5cfe2278dc7df8")
    begin:comp13
    addsb_11_0_3b5cfe2278dc7df8 core_instance13 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_1ae7fcb63c340449")
    begin:comp14
    addsb_11_0_1ae7fcb63c340449 core_instance14 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_49467494b87e75c7")
    begin:comp17
    addsb_11_0_49467494b87e75c7 core_instance17 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_0e0e0a285ef7a16d")
    begin:comp20
    addsb_11_0_0e0e0a285ef7a16d core_instance20 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_490e4beeb7992ef4")
    begin:comp21
    addsb_11_0_490e4beeb7992ef4 core_instance21 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_6623adedd12a938a")
    begin:comp23
    addsb_11_0_6623adedd12a938a core_instance23 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_8747e77bb511337e")
    begin:comp24
    addsb_11_0_8747e77bb511337e core_instance24 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_3abe85fcf1017fed")
    begin:comp25
    addsb_11_0_3abe85fcf1017fed core_instance25 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_f392a1f2f071bf23")
    begin:comp26
    addsb_11_0_f392a1f2f071bf23 core_instance26 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

  if (core_name0 == "addsb_11_0_a5337ca1a964fead")
    begin:comp28
    addsb_11_0_a5337ca1a964fead core_instance28 (
         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

endgenerate
generate
  if (extra_registers > 0)
  begin:latency_test

    if (c_latency > 1)
    begin:override_test
      synth_reg # (1, c_latency)
        override_pipe (
          .i(logic1),
          .ce(internal_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(override));
      assign extra_reg_ce = ce & en & override;
    end
    if ((c_latency == 0) || (c_latency == 1))
    begin:no_override
      assign extra_reg_ce = ce & en;
    end
    synth_reg # (s_width, extra_registers)
      extra_reg (
        .i(conv_s),
        .ce(extra_reg_ce),
        .clr(internal_clr),
        .clk(clk),
        .o(s));
    if (c_has_c_out == 1)
    begin:cout_test
      synth_reg # (1, extra_registers)
        c_out_extra_reg (
          .i(temp_cout),
          .ce(extra_reg_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(c_out));
    end

  end
endgenerate
generate
  if ((latency == 0) || (extra_registers == 0))
  begin:latency_s
    assign s = conv_s;
  end
endgenerate
generate
  if (((latency == 0) || (extra_registers == 0)) &&
      (c_has_c_out == 1))
  begin:latency0
    assign c_out = temp_cout;
  end
endgenerate
generate
  if (c_has_c_out == 0)
  begin:tie_dangling_cout
    assign c_out = 0;
  end
endgenerate
endmodule

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
module xlconvert(din, clk, ce, clr, en, dout);
   parameter din_width= 16;
   parameter din_bin_pt= 4;
   parameter din_arith= `xlUnsigned;
   parameter dout_width= 8;
   parameter dout_bin_pt= 2;
   parameter dout_arith= `xlUnsigned;
   parameter en_width = 1;
   parameter en_bin_pt = 0;
   parameter en_arith = `xlUnsigned;
   parameter bool_conversion = 0;
   parameter latency = 0;
   parameter quantization= `xlTruncate;
   parameter overflow= `xlWrap;
   input [din_width-1:0] din;
   input clk, ce, clr;
   input [en_width-1:0] en;
   output [dout_width-1:0] dout;
   wire [dout_width-1:0]   result;
   wire internal_ce;
   assign internal_ce = ce & en[0];

generate
 if (bool_conversion == 1)
    begin:bool_converion_generate
       assign result = din;
    end
 else
    begin:std_conversion
       convert_type #(din_width,
                      din_bin_pt,
                      din_arith,
                              dout_width,
                      dout_bin_pt,
                      dout_arith,
                      quantization,
                      overflow)
        conv_udp (.inp(din), .res(result));
    end
endgenerate
generate
if (latency > 0)
     begin:latency_test
        synth_reg # (dout_width, latency)
          reg1 (
               .i(result),
               .ce(internal_ce),
               .clr(clr),
               .clk(clk),
               .o(dout));
     end
else
     begin:latency0
        assign dout = result;
     end
endgenerate
endmodule

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
module xldelay #(parameter width = -1, latency = -1, reg_retiming = 0, reset = 0)
  (input [width-1:0] d,
   input ce, clk, en, rst,
   output [width-1:0] q);
generate
  if ((latency == 0) || ((reg_retiming == 0) && (reset == 0)))
  begin:srl_delay
    synth_reg # (width, latency)
      reg1 (
        .i(d),
        .ce(ce & en),
        .clr(1'b0),
        .clk(clk),
        .o(q));
  end

  if ((latency>=1) && ((reg_retiming) || (reset)))
  begin:reg_delay
    synth_reg_reg # (width, latency)
      reg2 (
        .i(d),
        .ce(ce & en),
        .clr(rst),
        .clk(clk),
        .o(q));
  end
endgenerate
endmodule


module shift_3fa2663220 (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{2{ip_1_23[18]}}, ip_1_23[18:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_d13a4b790a (
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{2{ip_1_23[31]}}, ip_1_23[31:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_091db5281e (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[18]}}, ip_1_23[18:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_6a42af8a02 (
  input [(22 - 1):0] ip,
  output [(22 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(22 - 1):0] ip_1_23;
  localparam signed [(22 - 1):0] const_value = 22'sb0000000000000000000000;
  reg signed [(22 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 22'b0000000000000000000000;
    end
  wire signed [(22 - 1):0] op_mem_46_20_front_din;
  wire signed [(22 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(22 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[21]}}, ip_1_23[21:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_860703fe20 (
  input [(26 - 1):0] ip,
  output [(26 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(26 - 1):0] ip_1_23;
  localparam signed [(26 - 1):0] const_value = 26'sb00000000000000000000000000;
  reg signed [(26 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 26'b00000000000000000000000000;
    end
  wire signed [(26 - 1):0] op_mem_46_20_front_din;
  wire signed [(26 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(28 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(26 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[25]}}, ip_1_23[25:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[27]}}, cast_internal_ip_27_3_rsh[27:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_773079a115 (
  input [(22 - 1):0] ip,
  output [(22 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(22 - 1):0] ip_1_23;
  localparam signed [(22 - 1):0] const_value = 22'sb0000000000000000000000;
  reg signed [(22 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 22'b0000000000000000000000;
    end
  wire signed [(22 - 1):0] op_mem_46_20_front_din;
  wire signed [(22 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(22 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[21]}}, ip_1_23[21:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_2b728df15b (
  input [(30 - 1):0] ip,
  output [(30 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(30 - 1):0] ip_1_23;
  localparam signed [(30 - 1):0] const_value = 30'sb000000000000000000000000000000;
  reg signed [(30 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 30'b000000000000000000000000000000;
    end
  wire signed [(30 - 1):0] op_mem_46_20_front_din;
  wire signed [(30 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(32 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(30 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[29]}}, ip_1_23[29:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[31]}}, cast_internal_ip_27_3_rsh[31:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module mux_1f6c522247 (
  input [(1 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(1 - 1):0] sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  localparam [(16 - 1):0] const_value = 16'b0000000000000000;
  reg [(16 - 1):0] pipe_16_22[0:(1 - 1)];
  initial
    begin
      pipe_16_22[0] = 16'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_16_22_front_din;
  wire [(16 - 1):0] pipe_16_22_back;
  wire pipe_16_22_push_front_pop_back_en;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign pipe_16_22_back = pipe_16_22[0];
  always @(posedge clk)
    begin:proc_pipe_16_22
      integer i;
      if (((ce == 1'b1) && (pipe_16_22_push_front_pop_back_en == 1'b1)))
        begin
          pipe_16_22[0] <= pipe_16_22_front_din;
        end
    end
  always @(d0_1_24 or d1_1_27 or sel_1_20)
    begin:proc_switch_6_1
      case (sel_1_20)
        1'b0 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        default:
          begin
            unregy_join_6_1 = d1_1_27;
          end
      endcase
    end
  assign pipe_16_22_front_din = unregy_join_6_1;
  assign pipe_16_22_push_front_pop_back_en = 1'b1;
  assign y = pipe_16_22_back;
endmodule
 



module constant_93b414a047 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111111110101000001;
endmodule
 



module constant_d1c6dff675 (
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48'b000000000000000000000000000000000000111111111111;
endmodule
 


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
module  xldsp48e1  (acout, bcout, carrycascout, carryout, multsignout, overflow, underflow, patterndetect, patternbdetect, p, pcout, a, acin, alumode, b, bcin, c, carrycascin, carryin, carryinsel, cea1, cea2, cead, cealumode, ceb1, ceb2, cec, cecarryin, cectrl, ced, ceinmode, cem, cemultcarryin, cep, multsignin, op, opmode, pcin, rsta, rstcarryin, rstalumode, rstb, rstc, rstctrl, rstd, rstinmode, rstm, rstp, clk, d, inmode, en, rst, ce);
parameter integer areg= 1;
parameter a_input = "DIRECT";
parameter legacy_mode = "NONE";
parameter integer carryout_width = 4;
parameter integer breg = 1;
parameter integer acascreg = 1;
parameter integer adreg = 1;
parameter integer bcascreg = 1;
parameter integer carryinreg = 1;
parameter integer carryinselreg = 1;
parameter integer creg = 1;
parameter integer dreg = 1;
parameter integer inmodereg = 1;
parameter integer mreg = 1;
parameter integer opmodereg= 1;
parameter integer preg = 1;
parameter use_op = 0;
parameter use_c_port = 1;
parameter c_use_cea1 = 0;
parameter c_use_cea2 = 0;
parameter c_use_cead = 0;
parameter c_use_ced  = 0;
parameter c_use_ceinmode = 0;
parameter c_use_rstd = 0;
parameter c_use_rstinmode = 0;
parameter c_use_ceb1 = 0;
parameter c_use_ceb2 = 0;
parameter c_use_cemultcarryin = 0;
parameter c_use_cem = 0;
parameter c_use_cep = 0;
parameter c_use_cec = 0;
parameter c_use_cecarryin = 0;
parameter c_use_cectrl = 0;
parameter c_use_bcin = 0;
parameter c_use_a = 1;
parameter c_use_acin = 0;
parameter c_use_en = 0;
parameter c_use_rst = 0;
parameter c_use_rsta = 0;
parameter c_use_rstb = 0;
parameter c_use_rstp = 0;
parameter c_use_rstc = 0;
parameter c_use_rstcarryin = 0;
parameter c_use_rstalumode = 0;
parameter c_use_rstctrl = 0;
parameter c_use_rstm = 0;
parameter c_use_pcin = 0;
parameter c_use_b = 0;
parameter c_use_c = 0;
parameter c_use_cealumode = 0;
parameter alumodereg = 1;
parameter autoreset_pattern_detect = "NO_RESET";
parameter b_input = "DIRECT";
parameter mask = 48'h3FFFFFFFFFFF;
parameter pattern = 48'h000000000000;
parameter sel_mask = "MASK";
parameter sel_pattern = "PATTERN";
parameter use_dport = "FALSE";
parameter use_mult = "MULTIPLY";
parameter use_pattern_detect = "NO_PATDET";
parameter use_simd = "ONE48";
output [29:0] acout;
output [17:0] bcout;
output carrycascout;
output [3:0]carryout;
output multsignout;
output [47:0] p;
output patternbdetect;
output patterndetect;
output [47:0] pcout;
output underflow;
output overflow;
input [29:0] a;
input [29:0] acin;
input [3:0] alumode;
input [17:0] b;
input [17:0] bcin;
input [47:0] c;
input carrycascin;
input carryin;
input [2:0] carryinsel;
input cea1;
input cea2;
input cead;
input ceb1;
input ceb2;
input cealumode;
input cec;
input cecarryin;
input cectrl;
input ced;
input ceinmode;
input cem;
input cemultcarryin;
input cep;
input multsignin;
input [19:0] op;
input [6:0] opmode;
input [47:0] pcin;
input rsta;
input rstcarryin;
input rstalumode;
input rstb;
input rstc;
input rstctrl;
input rstd;
input rstinmode;
input rstm;
input rstp;
input clk;
input [24:0] d;
input [4:0] inmode;
input en;
input rst;
input ce;
wire internal_cea1;
wire internal_cea2;
wire internal_cead;
wire internal_ceb1;
wire internal_ceb2;
wire internal_cec;
wire internal_cep;
wire internal_cem;
wire internal_cemultcarryin;
wire internal_cecarryin;
wire internal_cectrl;
wire internal_ced;
wire internal_ceinmode;
wire internal_cealumode;
wire internal_en;
wire internal_rst;
wire internal_rsta;
wire internal_rstb;
wire internal_rstc;
wire internal_rstd;
wire internal_rstinmode;
wire internal_rstalumode;
wire internal_rstcarryin;
wire internal_rstctrl;
wire internal_rstm;
wire [47:0] internal_pcin;
wire internal_rstp;
wire [6:0] internal_opmode;
wire internal_sub;
wire internal_carryin;
wire [2:0] internal_carryin_sel;
wire [3:0] internal_alumode;
wire [29:0] internal_a;
wire [29:0] internal_acin;
wire [17:0] internal_b;
wire [17:0] internal_bcin;
wire [47:0] internal_c;
wire [3:0] internal_carryout;
wire [24:0] internal_d;
wire [4:0]  internal_inmode;
  assign internal_en = (c_use_en ? en : 1'b1);
  assign internal_cem = (ce & internal_en) & (c_use_cem ? cem : 1'b1);
  assign internal_cemultcarryin = (ce & internal_en) & (c_use_cemultcarryin ? cemultcarryin : 1'b1);
  assign internal_cep = (ce & internal_en) & (c_use_cep ? cep : 1'b1);
  assign internal_cecarryin = (ce & internal_en) & (c_use_cecarryin ? cecarryin : 1'b1);
  assign internal_cectrl = (ce & internal_en) & (c_use_cectrl ? cectrl : 1'b1);
  assign internal_ced = (ce & internal_en) & (dreg ? ced : 1'b1);
  assign internal_ceinmode = (ce & internal_en) & (c_use_ceinmode ? ceinmode :  1'b1);
  assign internal_cealumode = (ce & internal_en) & (c_use_cealumode ? cealumode : 1'b1);
  assign internal_rst = (c_use_rst ? rst : 1'b0);
  assign internal_rsta = (c_use_rsta ? rsta : 1'b0) | internal_rst;
  assign internal_rstb = (c_use_rstb ? rstb : 1'b0) | internal_rst;
  assign internal_rstcarryin = (c_use_rstcarryin ? rstcarryin : 1'b0) | internal_rst;
  assign internal_rstctrl = (c_use_rstctrl ? rstctrl : 1'b0) | internal_rst;
  assign internal_rstd = (use_dport ? rstd : 1'b0) | internal_rst;
  assign internal_rstinmode = (use_dport ? rstinmode : 1'b0) | internal_rst;
  assign internal_rstm = (c_use_rstm ? rstm : 1'b0) | internal_rst;
  assign internal_rstp = (c_use_rstp ? rstp : 1'b0) | internal_rst;
  assign internal_rstalumode = (c_use_rstalumode ? rstalumode : 1'b0) | internal_rst;
  assign internal_acin = (c_use_acin ? acin : 30'b00000000000000000000000000000);
  assign internal_bcin = (c_use_bcin ? bcin : 18'b000000000000000000);
  assign internal_a = (c_use_a ? a : 30'd0);
  assign internal_b = (c_use_b ? b : 18'd0);
  assign internal_c = (c_use_c ? c : 48'd0);
  assign internal_pcin = (c_use_pcin ? pcin : 48'd0);
  assign internal_d = (use_dport ? d : 24'd0);

generate
  if(areg == 0)
  begin: cea_0
        assign internal_cea1 = 1'b1;
        assign internal_cea2 = 1'b1;
  end
  if(areg == 1)
  begin: cea_1
        assign internal_cea1 = 1'b1;
        assign internal_cea2 = (ce & internal_en) & (c_use_cea1 ? cea1 : 1'b1);
  end

  if(areg == 2)
  begin: cea_2
       assign internal_cea1 = (ce & internal_en) & (c_use_cea1 ? cea1 : 1'b1);
       assign internal_cea2 = (ce & internal_en) & (c_use_cea2 ? cea2 : 1'b1);
  end
  if(adreg == 1)
  begin: cead_1
        assign internal_cead = (ce & internal_en) & cead;
  end
  if(adreg == 0)
  begin: cead_0
        assign internal_cead = 0;
  end
  if(breg == 0)
  begin: ceb_0
        assign internal_ceb1 = 1'b1;
        assign internal_ceb2 = 1'b1;
  end
  if(breg == 1)
  begin: ceb_1
        assign internal_ceb1 = 1'b1;
        assign internal_ceb2 = (ce & internal_en) & (c_use_ceb1 ? ceb1 : 1'b1);
  end

  if(breg == 2)
  begin: ceb_2
       assign internal_ceb1 = (ce & internal_en) & (c_use_ceb1 ? ceb1 : 1'b1);
       assign internal_ceb2 = (ce & internal_en) & (c_use_ceb2 ? ceb2 : 1'b1);
  end

  if (use_op == 0)
  begin:opmode_0
          assign internal_opmode = opmode;
          assign internal_alumode = alumode;
          assign internal_carryin = carryin;
          assign internal_carryin_sel = carryinsel;
          if(use_dport == "FALSE")
          begin:dport_0
                assign internal_inmode = 0;
          end
          if(use_dport == "TRUE")
          begin:dport_1
                assign internal_inmode = inmode;
          end
  end

  if(use_op == 1)
  begin:opmode_1
        assign internal_opmode = op [6:0];
        assign internal_alumode = op[10:7];
        assign internal_carryin = op[11];
        assign internal_carryin_sel = op[14:12];
        assign internal_inmode = op[19:15];
  end
  if (use_c_port == 1)
  begin:using_cport
    assign internal_cec = (ce & internal_en) & (c_use_cec ? cec : 1'b1);
    assign internal_rstc = (c_use_rstc ? rstc : 1'b0) | internal_rst;
  end

  if (use_c_port == 0)
  begin:not_using_cport
     assign internal_cec = 1'b1;
     assign internal_rstc = 1'b1;
  end
  if (carryout_width == 1)
  begin: carryoutwidth1
     assign carryout = internal_carryout[3];
  end
  if (carryout_width == 2)
  begin: carryoutwidth2
     assign carryout[1] = internal_carryout[3];
     assign carryout[0] = internal_carryout[1];
  end
  if (carryout_width == 4)
  begin: carryoutwidth4
     assign carryout = internal_carryout;
  end
endgenerate
   DSP48E1 dsp48_inst(.ACOUT(acout),
                    .BCOUT(bcout),
                    .CARRYCASCOUT(carrycascout),
                    .CARRYOUT(internal_carryout),
                    .MULTSIGNOUT(multsignout),
                    .OVERFLOW(overflow),
                    .P(p),
                    .PATTERNBDETECT(patternbdetect),
                    .PATTERNDETECT(patterndetect),
                    .PCOUT(pcout),
                    .UNDERFLOW(underflow),
                    .A(internal_a),
                    .ACIN(internal_acin),
                    .ALUMODE(internal_alumode),
                    .B(internal_b),
                    .BCIN(internal_bcin),
                    .C(internal_c),
                    .CARRYCASCIN(carrycascin),
                    .CARRYIN(internal_carryin),
                    .CARRYINSEL(internal_carryin_sel),
                    .CEA1(internal_cea1),
                    .CEA2(internal_cea2),
                        .CEAD(internal_cead),
                    .CEALUMODE(internal_cealumode),
                    .CEB1(internal_ceb1),
                    .CEB2(internal_ceb2),
                    .CEC(internal_cec),
                    .CECARRYIN(internal_cecarryin),
                    .CECTRL(internal_cectrl),
                        .CED(internal_ced),
                        .CEINMODE(internal_ceinmode),
                    .CEM(internal_cem),
                    .CEP(internal_cep),
                    .CLK(clk),
                        .D(internal_d),
                        .INMODE(internal_inmode),
                    .MULTSIGNIN(internal_multsignin),
                    .OPMODE(internal_opmode),
                    .PCIN(internal_pcin),
                    .RSTA(internal_rsta),
                    .RSTALLCARRYIN(internal_rstcarryin),
                    .RSTALUMODE(internal_rstalumode),
                    .RSTB(internal_rstb),
                    .RSTC(internal_rstc),
                    .RSTCTRL(internal_rstctrl),
                        .RSTD(internal_rstd),
                        .RSTINMODE(internal_rstinmode),
                    .RSTM(internal_rstm),
                    .RSTP(internal_rstp)
                        );
defparam
dsp48_inst.ACASCREG = acascreg,
dsp48_inst.ALUMODEREG = alumodereg,
dsp48_inst.AREG = areg,
dsp48_inst.ADREG = adreg,
dsp48_inst.AUTORESET_PATDET = autoreset_pattern_detect,
dsp48_inst.B_INPUT = b_input,
dsp48_inst.BREG = breg,
dsp48_inst.CARRYINREG = carryinreg,
dsp48_inst.CARRYINSELREG = carryinselreg,
dsp48_inst.CREG = creg,
dsp48_inst.DREG = dreg,
dsp48_inst.INMODEREG = inmodereg,
dsp48_inst.MREG = mreg,
dsp48_inst.OPMODEREG = opmodereg,
dsp48_inst.PREG = preg,
dsp48_inst.A_INPUT = a_input,
dsp48_inst.BCASCREG = bcascreg,
dsp48_inst.B_INPUT = b_input,
dsp48_inst.MASK = mask,
dsp48_inst.PATTERN = pattern,
dsp48_inst.SEL_MASK = sel_mask,
dsp48_inst.SEL_PATTERN = sel_pattern,
dsp48_inst.USE_DPORT = use_dport,
dsp48_inst.USE_MULT= use_mult,
dsp48_inst.USE_PATTERN_DETECT = use_pattern_detect,
dsp48_inst.USE_SIMD = use_simd;
endmodule


module opmode_6481474c6d (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00101000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00101;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00101000000000110101;
  assign op = 20'b00101000000000110101;
endmodule
 



module reinterpret_81b71e1f8b (
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module reinterpret_0e0c011a4e (
  input [(18 - 1):0] input_port,
  output [(18 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module reinterpret_5668f8e576 (
  input [(48 - 1):0] input_port,
  output [(48 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(48 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module constant_4d353c6047 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000001001000001111;
endmodule
 



module constant_b293d8004e (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b010011011011100111;
endmodule
 



module concat_7e18b92ffa (
  input [(16 - 1):0] in0,
  input [(16 - 1):0] in1,
  output [(32 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(16 - 1):0] in0_1_23;
  wire [(16 - 1):0] in1_1_27;
  wire [(32 - 1):0] y_2_1_concat;
  assign in0_1_23 = in0;
  assign in1_1_27 = in1;
  assign y_2_1_concat = {in0_1_23, in1_1_27};
  assign y = y_2_1_concat;
endmodule
 



module constant_5e90e4a8ec (
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 1'b1;
endmodule
 


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
module xldpram_dist_duc_16ch_341 (dina, addra, wea, ena, a_ce, a_clk, douta, addrb, enb, b_ce, b_clk, doutb);
parameter core_name0= "";
parameter addr_width = 12;
parameter c_width= 12;
parameter c_address_width= 4;
parameter latency= 1;
input [c_width-1:0] dina;
input [addr_width-1:0] addra;
input wea, ena, a_ce, a_clk;
output [c_width-1:0] douta;
input [addr_width-1:0] addrb;
input enb, b_ce, b_clk;
output [c_width-1:0] doutb;
wire [c_address_width-1:0] core_addra,core_addrb;
wire [c_width-1:0] core_douta,core_doutb;
wire [c_width-1:0] reg_douta,reg_doutb;
wire core_we, core_cea, core_ceb;

   assign core_addra = addra;
   assign core_addrb = addrb;
   assign douta = reg_douta;
   assign doutb = reg_doutb;
   assign core_cea = a_ce & ena;
   assign core_ceb = b_ce & enb;
   assign core_we = wea & core_cea;

generate
  if (core_name0 == "dmg_72_903d17a1900ee539")
    begin:comp0
    dmg_72_903d17a1900ee539 core_instance0 (
      .a(core_addra),
      .clk(a_clk),
      .d(dina),
      .we(core_we),
      .dpra(core_addrb),
      .spo(core_douta),
      .dpo(core_doutb)

    );
  end
  if (core_name0 == "dmg_72_1c9994abe91d1da0")
    begin:comp1
    dmg_72_1c9994abe91d1da0 core_instance1 (
      .a(core_addra),
      .clk(a_clk),
      .d(dina),
      .we(core_we),
      .dpra(core_addrb),
      .spo(core_douta),
      .dpo(core_doutb)

    );
  end
 if (latency > 0)
   begin:registered_dpram_instA
      synth_reg # (c_width, latency)
        output_regA (.i(core_douta),
                     .ce(core_cea),
                     .clr(1'b0),
                     .clk(a_clk),
                     .o(reg_douta));
   end
 if (latency > 0)
   begin:registered_dpram_instB
      synth_reg # (c_width, latency)
        output_regB (.i(core_doutb),
                     .ce(core_ceb),
                     .clr(1'b0),
                     .clk(b_clk),
                     .o(reg_doutb));
   end

   if (latency == 0)
     begin:nonregistered_ram
        assign reg_douta = core_douta;
        assign reg_doutb = core_doutb;
     end
endgenerate
endmodule

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
module xlsprom_dist_duc_16ch_341 (addr, en, ce, clk, data);
   parameter core_name0= "";
   parameter addr_width= 2;
   parameter latency= 0;
   parameter c_width= 12;
   parameter c_address_width= 4;
   input [addr_width-1:0] addr;
   input en;
   input ce;
   input clk;
   output [c_width-1:0] data;
   wire [c_width-1:0] core_data_out;
   wire [c_address_width-1:0] core_addr;
   wire  core_ce;
   assign core_addr = { {(c_address_width - addr_width) {1'b0}}, addr};
   assign core_ce = ce & en;
generate
if (core_name0 == "dmg_72_85ef246b9b71061d")
begin:comp1
dmg_72_85ef246b9b71061d core_instance0 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_9ec52875c6eb4958")
begin:comp3
dmg_72_9ec52875c6eb4958 core_instance1 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_b01799b9bf71bdc0")
begin:comp5
dmg_72_b01799b9bf71bdc0 core_instance2 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_2828f053f6c73e1f")
begin:comp7
dmg_72_2828f053f6c73e1f core_instance3 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_f25cd80cb6ee82df")
begin:comp9
dmg_72_f25cd80cb6ee82df core_instance4 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_e9661fc0e9eb3e90")
begin:comp11
dmg_72_e9661fc0e9eb3e90 core_instance5 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_53c8fda674a6c63d")
begin:comp13
dmg_72_53c8fda674a6c63d core_instance6 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
if (core_name0 == "dmg_72_9651f078ad2c9f1b")
begin:comp15
dmg_72_9651f078ad2c9f1b core_instance7 (
         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)
        );
end
   if (latency > 1)
     begin:latency_test
        synth_reg # (c_width, latency-1)
          reg1 (
               .i(core_data_out),
               .ce(core_ce),
               .clr(1'b0),
               .clk(clk),
               .o(data));
     end

   if (latency <= 1)
     begin:latency_0_or_1
        assign data = core_data_out;
     end
endgenerate
endmodule


module reinterpret_2824f666f2 (
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] input_port_1_40;
  wire [(16 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_dee95c6dbb (
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(16 - 1):0] input_port_1_40;
  wire signed [(16 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 


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
module  xlslice  (x, y);
parameter new_msb= 9;
parameter new_lsb= 1;
parameter x_width= 16;
parameter y_width= 8;
input [x_width-1:0] x;
output [y_width-1:0] y;
assign y = x[new_msb:new_lsb];
endmodule


module addsub_f03aa9b11e (
  input [(16 - 1):0] a,
  input [(16 - 1):0] b,
  output [(17 - 1):0] s,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] a_17_32;
  wire signed [(16 - 1):0] b_17_35;
  localparam signed [(17 - 1):0] const_value = 17'sb00000000000000000;
  reg signed [(17 - 1):0] op_mem_91_20[0:(1 - 1)];
  initial
    begin
      op_mem_91_20[0] = 17'b00000000000000000;
    end
  wire signed [(17 - 1):0] op_mem_91_20_front_din;
  wire signed [(17 - 1):0] op_mem_91_20_back;
  wire op_mem_91_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b0;
  reg [(1 - 1):0] cout_mem_92_22[0:(1 - 1)];
  initial
    begin
      cout_mem_92_22[0] = 1'b0;
    end
  wire [(1 - 1):0] cout_mem_92_22_front_din;
  wire [(1 - 1):0] cout_mem_92_22_back;
  wire cout_mem_92_22_push_front_pop_back_en;
  wire [(3 - 1):0] prev_mode_93_22_next;
  wire [(3 - 1):0] prev_mode_93_22;
  wire [(3 - 1):0] prev_mode_93_22_reg_i;
  wire [(3 - 1):0] prev_mode_93_22_reg_o;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000003 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000004 = 1'b0;
  wire signed [(17 - 1):0] cast_69_18;
  wire signed [(17 - 1):0] cast_69_22;
  wire signed [(17 - 1):0] internal_s_69_5_addsub;
  localparam [(1 - 1):0] const_value_x_000005 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000006 = 1'b0;
  localparam [(3 - 1):0] const_value_x_000007 = 3'b000;
  assign a_17_32 = a;
  assign b_17_35 = b;
  assign op_mem_91_20_back = op_mem_91_20[0];
  always @(posedge clk)
    begin:proc_op_mem_91_20
      integer i;
      if (((ce == 1'b1) && (op_mem_91_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_91_20[0] <= op_mem_91_20_front_din;
        end
    end
  assign cout_mem_92_22_back = cout_mem_92_22[0];
  always @(posedge clk)
    begin:proc_cout_mem_92_22
      integer i_x_000000;
      if (((ce == 1'b1) && (cout_mem_92_22_push_front_pop_back_en == 1'b1)))
        begin
          cout_mem_92_22[0] <= cout_mem_92_22_front_din;
        end
    end
  assign prev_mode_93_22_reg_i = prev_mode_93_22_next;
  assign prev_mode_93_22 = prev_mode_93_22_reg_o;
  defparam prev_mode_93_22_reg_inst.init_index = 2;
  defparam prev_mode_93_22_reg_inst.init_value = 3'b010;
  defparam prev_mode_93_22_reg_inst.latency = 1;
  defparam prev_mode_93_22_reg_inst.width = 3;
  synth_reg_w_init prev_mode_93_22_reg_inst(.ce(ce), .clk(clk), .clr(clr), .i(prev_mode_93_22_reg_i), .o(prev_mode_93_22_reg_o));
  assign cast_69_18 = {{1{a_17_32[15]}}, a_17_32[15:0]};
  assign cast_69_22 = {{1{b_17_35[15]}}, b_17_35[15:0]};
  assign internal_s_69_5_addsub = cast_69_18 + cast_69_22;
  assign op_mem_91_20_front_din = internal_s_69_5_addsub;
  assign op_mem_91_20_push_front_pop_back_en = 1'b1;
  assign cout_mem_92_22_front_din = const_value_x_000006;
  assign cout_mem_92_22_push_front_pop_back_en = 1'b1;
  assign prev_mode_93_22_next = const_value_x_000007;
  assign s = op_mem_91_20_back;
endmodule
 


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
module xlcounter_limit_duc_16ch_341 (ce, clr, clk, op, up, en, rst);
parameter core_name0= "";
parameter op_width= 5;
parameter op_arith= `xlSigned;
parameter cnt_63_48 = 0;
parameter cnt_47_32 = 0;
parameter cnt_31_16 = 0;
parameter cnt_15_0  = 0;
parameter count_limited= 0;

   input  ce, clr, clk;
   input rst, en;
   input up;
   output [op_width-1:0] op;
parameter [63:0] cnt_to = { cnt_63_48[15:0], cnt_47_32[15:0], cnt_31_16[15:0], cnt_15_0[15:0]};
parameter [(8*op_width)-1:0] oneStr = { op_width{"1"}};

reg op_thresh0;
wire core_sinit, core_ce;
wire rst_overrides_en;
wire [op_width-1:0] op_net;
   assign op = op_net;
   assign core_ce = ce & en;
   assign rst_overrides_en = rst | en;

generate
   if (count_limited == 1)
     begin :limit
        always @(op_net)
          begin:eq_cnt_to
             op_thresh0 = (op_net == cnt_to[op_width-1:0])? 1'b1 : 1'b0;
          end
        assign core_sinit = (op_thresh0 | clr | rst) & ce & rst_overrides_en;
     end
   if (count_limited == 0)
     begin :no_limit
        assign core_sinit = (clr | rst) & ce & rst_overrides_en;
     end
  if (core_name0 == "cntr_11_0_7a9f00e1c86c8fba")
    begin:comp0
    cntr_11_0_7a9f00e1c86c8fba core_instance0 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
  if (core_name0 == "cntr_11_0_6da79292a37693ee")
    begin:comp1
    cntr_11_0_6da79292a37693ee core_instance1 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
endgenerate
endmodule


module counter_5c8ee48e8f (
  input [(1 - 1):0] rst,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire rst_1_40;
  reg [(1 - 1):0] count_reg_20_23 = 1'b0;
  wire count_reg_20_23_rst;
  localparam [(1 - 1):0] const_value = 1'b1;
  localparam [(2 - 1):0] const_value_x_000000 = 2'b10;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000003 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000004 = 1'b1;
  wire bool_44_4;
  reg rst_limit_join_44_1;
  reg [(2 - 1):0] count_reg_join_44_1;
  reg count_reg_join_44_1_rst;
  assign rst_1_40 = rst;
  always @(posedge clk)
    begin:proc_count_reg_20_23
      if (((ce == 1'b1) && (count_reg_20_23_rst == 1'b1)))
        begin
          count_reg_20_23 <= 1'b0;
        end
      else if ((ce == 1'b1))
        begin
          count_reg_20_23 <= count_reg_20_23 + const_value_x_000004;
        end
    end
  assign bool_44_4 = rst_1_40 || 1'b0;
  always @(bool_44_4 or count_reg_20_23)
    begin:proc_if_44_1
      if (bool_44_4)
        begin
          count_reg_join_44_1_rst = 1'b1;
        end
      else 
        begin
          count_reg_join_44_1_rst = 1'b0;
        end
      if (bool_44_4)
        begin
          rst_limit_join_44_1 = 1'b0;
        end
      else 
        begin
          rst_limit_join_44_1 = 1'b0;
        end
    end
  assign count_reg_20_23_rst = count_reg_join_44_1_rst;
  assign op = count_reg_20_23;
endmodule
 



module shift_a0dd291710 (
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[20]}}, ip_1_23[20:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_92fa79e61c (
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_be765386ae (
  input [(28 - 1):0] ip,
  output [(28 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(28 - 1):0] ip_1_23;
  localparam signed [(28 - 1):0] const_value = 28'sb0000000000000000000000000000;
  reg signed [(28 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 28'b0000000000000000000000000000;
    end
  wire signed [(28 - 1):0] op_mem_46_20_front_din;
  wire signed [(28 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(33 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(28 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[27]}}, ip_1_23[27:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[32]}}, cast_internal_ip_27_3_rsh[32:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_58794f53f4 (
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(34 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[31]}}, ip_1_23[31:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[33]}}, cast_internal_ip_27_3_rsh[33:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_940a0f4802 (
  input [(24 - 1):0] ip,
  output [(24 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(24 - 1):0] ip_1_23;
  localparam signed [(24 - 1):0] const_value = 24'sb000000000000000000000000;
  reg signed [(24 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 24'b000000000000000000000000;
    end
  wire signed [(24 - 1):0] op_mem_46_20_front_din;
  wire signed [(24 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(24 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[23]}}, ip_1_23[23:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_cecea44c7e (
  input [(27 - 1):0] ip,
  output [(27 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(27 - 1):0] ip_1_23;
  localparam signed [(27 - 1):0] const_value = 27'sb000000000000000000000000000;
  reg signed [(27 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 27'b000000000000000000000000000;
    end
  wire signed [(27 - 1):0] op_mem_46_20_front_din;
  wire signed [(27 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(28 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(27 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[26]}}, ip_1_23[26:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[27]}}, cast_internal_ip_27_3_rsh[27:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_7d97a52cb7 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[19]}}, ip_1_23[19:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_c3b3a63c34 (
  input [(24 - 1):0] ip,
  output [(24 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(24 - 1):0] ip_1_23;
  localparam signed [(24 - 1):0] const_value = 24'sb000000000000000000000000;
  reg signed [(24 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 24'b000000000000000000000000;
    end
  wire signed [(24 - 1):0] op_mem_46_20_front_din;
  wire signed [(24 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(24 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[23]}}, ip_1_23[23:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_0f7277fd89 (
  input [(25 - 1):0] ip,
  output [(25 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(25 - 1):0] ip_1_23;
  localparam signed [(25 - 1):0] const_value = 25'sb0000000000000000000000000;
  reg signed [(25 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 25'b0000000000000000000000000;
    end
  wire signed [(25 - 1):0] op_mem_46_20_front_din;
  wire signed [(25 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(25 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[24]}}, ip_1_23[24:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_a47dc9adee (
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(37 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[31]}}, ip_1_23[31:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[36]}}, cast_internal_ip_27_3_rsh[36:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module constant_d02c6ca527 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b010100001101100011;
endmodule
 



module constant_ccb8aa4d51 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000000000100100010;
endmodule
 



module constant_bc660b1e56 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111111110100111111;
endmodule
 



module constant_78b68b2393 (
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48'b000000000000000000000000000001111111111111111111;
endmodule
 



module constant_9ed9b075a6 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111111111110100011;
endmodule
 



module constant_a3a888533e (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000000010110110010;
endmodule
 



module constant_cb858d1f75 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111111010101011111;
endmodule
 



module constant_bd1e327723 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000001001010001101;
endmodule
 



module constant_2544d97e53 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111110000010110001;
endmodule
 



module constant_9f55c36ec5 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000011010101100010;
endmodule
 



module constant_1807e2a2f1 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111001101011010100;
endmodule
 



module opmode_de16be0052 (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b10100000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b10100;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b10100000000000110101;
  assign op = 20'b10100000000000110101;
endmodule
 



module opmode_96dace4a09 (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00100000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00100;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00100000000000010101;
  assign op = 20'b00100000000000010101;
endmodule
 



module reinterpret_f67f49dab9 (
  input [(19 - 1):0] input_port,
  output [(19 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module constant_998c05c36c (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000000100110011101;
endmodule
 



module constant_ca7488d888 (
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48'b000000000000000000000000000000001111111111111111;
endmodule
 



module constant_23baa7aa71 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b111100010100100101;
endmodule
 



module opmode_77dfa9804f (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00101000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00101;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00101000000000010101;
  assign op = 20'b00101000000000010101;
endmodule
 



module constant_41c9a265eb (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b010011000101100101;
endmodule
 


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
module xladdsubmode_duc_16ch_341 (a, b, c_in, mode, ce, clr, clk, rst, en, c_out, s);
parameter core_name0= "";
parameter a_width= 16;
parameter signed a_bin_pt= 4;
parameter a_arith= `xlUnsigned;
parameter b_width= 8;
parameter signed b_bin_pt= 2;
parameter b_arith= `xlUnsigned;
parameter c_in_width= 16;
parameter c_in_bin_pt= 4;
parameter c_in_arith= `xlUnsigned;
parameter c_out_width= 16;
parameter c_out_bin_pt= 4;
parameter c_out_arith= `xlUnsigned;
parameter s_width= 17;
parameter s_bin_pt= 4;
parameter s_arith= `xlUnsigned;
parameter rst_width= 1;
parameter rst_bin_pt= 0;
parameter rst_arith= `xlUnsigned;
parameter en_width= 1;
parameter en_bin_pt= 0;
parameter en_arith= `xlUnsigned;
parameter padded_width= 16;
parameter full_s_width= 17;
parameter full_s_arith= `xlUnsigned;
parameter mode_width= 1;
parameter mode_bin_pt= 0;
parameter mode_arith= `xlUnsigned;
parameter extra_registers= 0;
parameter latency= 0;
parameter quantization= `xlTruncate;
parameter overflow= `xlWrap;
parameter c_a_width= 16;
parameter c_b_width= 8;
parameter c_a_type= 1;
parameter c_b_type= 1;
parameter c_has_sclr= 0;
parameter c_has_ce= 0;
parameter c_latency= 0;
parameter c_output_width= 17;
parameter c_enable_rlocs= 1;
parameter c_has_c_in= 0;
parameter c_has_c_out= 0;
input [a_width-1:0] a;
input [b_width-1:0] b;
input c_in;
input [mode_width-1:0] mode;
input ce, clr, clk, rst, en;
output c_out;
output [s_width-1:0] s;
parameter full_a_width = full_s_width;
parameter full_b_width = full_s_width;
parameter full_s_bin_pt = (a_bin_pt > b_bin_pt) ? a_bin_pt : b_bin_pt;
wire [full_a_width-1:0] full_a;
wire [full_b_width-1:0] full_b;
wire [full_s_width-1:0] full_s;
wire [full_s_width-1:0] core_s;
wire [s_width-1:0] conv_s;
wire  add;
wire  real_a,real_b,real_s;
wire  internal_clr;
wire  internal_ce;
wire  extra_reg_ce;
wire  override;
wire  logic1;
wire  temp_cout;
wire  temp_cin;
assign internal_clr = clr | rst & ce;
assign internal_ce = ce & en;
assign logic1 = 1'b1;
assign add = ~mode[0];
assign temp_cin = (c_has_c_in) ? c_in : 1'b0;
align_input # (a_width, b_bin_pt - a_bin_pt, a_arith, full_a_width)
align_inp_a (.inp(a),.res(full_a));
align_input # (b_width, a_bin_pt - b_bin_pt, b_arith, full_b_width)
align_inp_b (.inp(b),.res(full_b));
convert_type # (full_s_width, full_s_bin_pt, full_s_arith, s_width,
                s_bin_pt, s_arith, quantization, overflow)
conv_typ_s (.inp(core_s),.res(conv_s));
generate
  if (core_name0 == "addsb_11_0_9196f8ffd2db8ce4")
    begin:comp0
    addsb_11_0_9196f8ffd2db8ce4 core_instance0 (
         .a(full_a),
         .add(add),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)
      );
  end

endgenerate
generate
  if (extra_registers > 0)
  begin:latency_test

    if (c_latency > 1)
    begin:override_test
      synth_reg # (1, c_latency)
        override_pipe (
          .i(logic1),
          .ce(internal_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(override));
      assign extra_reg_ce = ce & en & override;
    end
    if ((c_latency == 0) || (c_latency == 1))
    begin:no_override
      assign extra_reg_ce = ce & en;
    end
    synth_reg # (s_width, extra_registers)
      extra_reg (
        .i(conv_s),
        .ce(extra_reg_ce),
        .clr(internal_clr),
        .clk(clk),
        .o(s));
    if (c_has_c_out == 1)
    begin:cout_test
      synth_reg # (1, extra_registers)
        c_out_extra_reg (
          .i(temp_cout),
          .ce(extra_reg_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(c_out));
    end

  end
  if ((latency == 0) || (extra_registers == 0))
  begin:latency_s
    assign s = conv_s;
  end
  if (((latency == 0) || (extra_registers == 0)) &&
       (c_has_c_out == 1))
  begin:latency0
    assign c_out = temp_cout;
  end
  if (c_has_c_out == 0)
  begin:tie_dangling_cout
    assign c_out = 0;
  end
endgenerate
endmodule


module constant_281c9dad53 (
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 16'b0000000000000000;
endmodule
 



module mux_a6eee4b271 (
  input [(2 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  input [(16 - 1):0] d2,
  input [(16 - 1):0] d3,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(2 - 1):0] sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  wire [(16 - 1):0] d2_1_30;
  wire [(16 - 1):0] d3_1_33;
  localparam [(16 - 1):0] const_value = 16'b0000000000000000;
  reg [(16 - 1):0] pipe_20_22[0:(1 - 1)];
  initial
    begin
      pipe_20_22[0] = 16'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_20_22_front_din;
  wire [(16 - 1):0] pipe_20_22_back;
  wire pipe_20_22_push_front_pop_back_en;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign d3_1_33 = d3;
  assign pipe_20_22_back = pipe_20_22[0];
  always @(posedge clk)
    begin:proc_pipe_20_22
      integer i;
      if (((ce == 1'b1) && (pipe_20_22_push_front_pop_back_en == 1'b1)))
        begin
          pipe_20_22[0] <= pipe_20_22_front_din;
        end
    end
  always @(d0_1_24 or d1_1_27 or d2_1_30 or d3_1_33 or sel_1_20)
    begin:proc_switch_6_1
      case (sel_1_20)
        2'b00 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        2'b01 :
          begin
            unregy_join_6_1 = d1_1_27;
          end
        2'b10 :
          begin
            unregy_join_6_1 = d2_1_30;
          end
        default:
          begin
            unregy_join_6_1 = d3_1_33;
          end
      endcase
    end
  assign pipe_20_22_front_din = unregy_join_6_1;
  assign pipe_20_22_push_front_pop_back_en = 1'b1;
  assign y = pipe_20_22_back;
endmodule
 



module shift_12819d6cbe (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(17 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[16]}}, cast_internal_ip_27_3_rsh[16:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_4108be98c5 (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[15]}}, ip_1_23[15:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_5447e0aa7e (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(19 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[18]}}, cast_internal_ip_27_3_rsh[18:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_a05534ab8e (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_1aa26d2e4f (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(18 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[17]}}, cast_internal_ip_27_3_rsh[17:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_997986a690 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_9f4e80fae7 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(26 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{6{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[25]}}, cast_internal_ip_27_3_rsh[25:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_c6a2804ac2 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module inverter_48d1f6b088 (
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(4 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1'b0;
      op_mem_22_20[1] = 1'b0;
      op_mem_22_20[2] = 1'b0;
      op_mem_22_20[3] = 1'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(3 - 1):0] const_value = 3'b100;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[3];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1'b1) && (op_mem_22_20_push_front_pop_back_en == 1'b1)))
        begin
          for (i=3; i>=1; i=i-1)
            begin
              op_mem_22_20[i] <= op_mem_22_20[i-1];
            end
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_front_din = internal_ip_12_1_bitnot;
  assign op_mem_22_20_push_front_pop_back_en = 1'b1;
  assign op = op_mem_22_20_back;
endmodule
 



module mux_f3921567cd (
  input [(1 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  localparam [(16 - 1):0] const_value = 16'b0000000000000000;
  reg [(16 - 1):0] pipe_16_22[0:(1 - 1)];
  initial
    begin
      pipe_16_22[0] = 16'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_16_22_front_din;
  wire [(16 - 1):0] pipe_16_22_back;
  wire pipe_16_22_push_front_pop_back_en;
  wire [(1 - 1):0] sel_internal_2_1_convert;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign pipe_16_22_back = pipe_16_22[0];
  always @(posedge clk)
    begin:proc_pipe_16_22
      integer i;
      if (((ce == 1'b1) && (pipe_16_22_push_front_pop_back_en == 1'b1)))
        begin
          pipe_16_22[0] <= pipe_16_22_front_din;
        end
    end
  assign sel_internal_2_1_convert = {sel_1_20};
  always @(d0_1_24 or d1_1_27 or sel_internal_2_1_convert)
    begin:proc_switch_6_1
      case (sel_internal_2_1_convert)
        1'b0 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        default:
          begin
            unregy_join_6_1 = d1_1_27;
          end
      endcase
    end
  assign pipe_16_22_front_din = unregy_join_6_1;
  assign pipe_16_22_push_front_pop_back_en = 1'b1;
  assign y = pipe_16_22_back;
endmodule
 



module shift_0b767c7711 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_18b87c12cf (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_2422c3ab70 (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_69971e276f (
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module logical_06844c65fb (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(5 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1'b0;
      latency_pipe_5_26[1] = 1'b0;
      latency_pipe_5_26[2] = 1'b0;
      latency_pipe_5_26[3] = 1'b0;
      latency_pipe_5_26[4] = 1'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire bit_2_27;
  wire fully_2_1_bitnot;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[4];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              latency_pipe_5_26[i] <= latency_pipe_5_26[i-1];
            end
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign bit_2_27 = d0_1_24 ^ d1_1_27;
  assign fully_2_1_bitnot = ~bit_2_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bitnot;
  assign latency_pipe_5_26_push_front_pop_back_en = 1'b1;
  assign y = latency_pipe_5_26_back;
endmodule
 



module inverter_66c3795ede (
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(5 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1'b0;
      op_mem_22_20[1] = 1'b0;
      op_mem_22_20[2] = 1'b0;
      op_mem_22_20[3] = 1'b0;
      op_mem_22_20[4] = 1'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(3 - 1):0] const_value = 3'b101;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[4];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1'b1) && (op_mem_22_20_push_front_pop_back_en == 1'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              op_mem_22_20[i] <= op_mem_22_20[i-1];
            end
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_front_din = internal_ip_12_1_bitnot;
  assign op_mem_22_20_push_front_pop_back_en = 1'b1;
  assign op = op_mem_22_20_back;
endmodule
 



module logical_8641388092 (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(1 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[0];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1'b1)))
        begin
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign fully_2_1_bit = d0_1_24 ^ d1_1_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bit;
  assign latency_pipe_5_26_push_front_pop_back_en = 1'b1;
  assign y = latency_pipe_5_26_back;
endmodule
 



module inverter_33a63b558a (
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(1 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[0];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1'b1) && (op_mem_22_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_push_front_pop_back_en = 1'b0;
  assign op = internal_ip_12_1_bitnot;
endmodule
 


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
module xlcounter_free_duc_16ch_341 (ce, clr, clk, op, up, load, din, en, rst);
parameter core_name0= "";
parameter op_width= 5;
parameter op_arith= `xlSigned;
input ce, clr, clk;
input up, load;
input [op_width-1:0] din;
input en, rst;
output [op_width-1:0] op;
parameter [(8*op_width)-1:0] oneStr = { op_width{"1"}};
wire  core_sinit;
wire  core_ce;
wire [op_width-1:0] op_net;
   assign core_ce = ce & en;
   assign core_sinit = (clr | rst) & ce;
   assign op = op_net;
generate
  if (core_name0 == "cntr_11_0_76451075d188e63f")
    begin:comp0
    cntr_11_0_76451075d188e63f core_instance0 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
endgenerate
endmodule


module logical_d5c14b9908 (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(5 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1'b0;
      latency_pipe_5_26[1] = 1'b0;
      latency_pipe_5_26[2] = 1'b0;
      latency_pipe_5_26[3] = 1'b0;
      latency_pipe_5_26[4] = 1'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[4];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              latency_pipe_5_26[i] <= latency_pipe_5_26[i-1];
            end
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign fully_2_1_bit = d0_1_24 ^ d1_1_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bit;
  assign latency_pipe_5_26_push_front_pop_back_en = 1'b1;
  assign y = latency_pipe_5_26_back;
endmodule
 



module accum_8dccba219b (
  input [(10 - 1):0] b,
  output [(10 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire [(10 - 1):0] b_17_24;
  reg [(10 - 1):0] accum_reg_41_23 = 10'b0000000000;
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b1;
  assign b_17_24 = b;
  always @(posedge clk)
    begin:proc_accum_reg_41_23
      if ((ce == 1'b1))
        begin
          accum_reg_41_23 <= accum_reg_41_23 + b_17_24;
        end
    end
  assign q = accum_reg_41_23;
endmodule
 



module constant_ae323e07fc (
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 1'b0;
endmodule
 



module constant_66f4f3b646 (
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18'b000000000000000000;
endmodule
 



module constant_b0803b3578 (
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 10'b0100000000;
endmodule
 


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
module xldpram_duc_16ch_341 (dina, addra, wea, a_ce, a_clk, rsta, ena, douta, dinb, addrb, web, b_ce, b_clk, rstb, enb, doutb);
parameter core_name0= "";
parameter c_width_a= 13;
parameter c_address_width_a= 4;
parameter c_width_b= 13;
parameter c_address_width_b= 4;
parameter latency= 1;

input [c_width_a-1:0] dina;
input [c_address_width_a-1:0] addra;
input wea, a_ce, a_clk, rsta, ena;
input [c_width_b-1:0] dinb;
input [c_address_width_b-1:0] addrb;
input web, b_ce, b_clk, rstb, enb;
output [c_width_a-1:0] douta;
output [c_width_b-1:0] doutb;
wire [c_address_width_a-1:0] core_addra;
wire [c_address_width_b-1:0] core_addrb;
wire [c_width_a-1:0] core_dina,core_douta,dly_douta;
wire [c_width_b-1:0] core_dinb,core_doutb,dly_doutb;
wire  core_wea,core_web;
wire  core_a_ce,core_b_ce;
wire  sinita,sinitb;
assign core_addra = addra;
assign core_dina = dina;
assign douta = dly_douta;
assign core_wea = wea;
assign core_a_ce = a_ce & ena;
assign sinita = rsta & a_ce;
assign core_addrb = addrb;
assign core_dinb = dinb;
assign doutb = dly_doutb;
assign core_web = web;
assign core_b_ce = b_ce & enb;
assign sinitb = rstb  & b_ce;
generate
  if (core_name0 == "bmg_72_5fc6d969158b1ced")
    begin:comp0
    bmg_72_5fc6d969158b1ced core_instance0 (
                              .addra(core_addra),
      .clka(a_clk),
      .addrb(core_addrb),
      .clkb(b_clk),
      .dina(core_dina),
      .wea(core_wea),
      .dinb(core_dinb),
      .web(core_web),
      .ena(core_a_ce),
      .enb(core_b_ce),
      .douta(core_douta),
      .doutb(core_doutb)
                );
  end
if (latency > 2)
  begin:latency_test_instA
   synth_reg # (c_width_a, latency-2)
   regA(
     .i(core_douta),
     .ce(core_a_ce),
     .clr(1'b0),
     .clk(a_clk),
     .o(dly_douta));
  end
if (latency > 2)
  begin:latency_test_instB
   synth_reg # (c_width_b, latency-2)
   regB(
     .i(core_doutb),
     .ce(core_b_ce),
     .clr(1'b0),
     .clk(b_clk),
     .o(dly_doutb));
  end

if (latency <= 2)
   begin:latency1
     assign dly_douta = core_douta;
     assign dly_doutb = core_doutb;
   end
endgenerate
endmodule


module constant_3660c43b3c (
  output [(25 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 25'b0000000000000000000000000;
endmodule
 



module opmode_2a00e03ade (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00100000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00100;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00100000000000110101;
  assign op = 20'b00100000000000110101;
endmodule
 



module opmode_6aca2f0a6e (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b01100000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b01100;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b01100000000000010101;
  assign op = 20'b01100000000000010101;
endmodule
 



module opmode_bddb7c5c56 (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00000000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00000;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00000000000000010101;
  assign op = 20'b00000000000000010101;
endmodule
 



module constant_34794c595f (
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48'b000000000000000000000000000011111111111111111111;
endmodule
 


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
module xlsprom_duc_16ch_341 (addr, en, rst, ce, clk, data);
   parameter core_name0= "";
   parameter latency= 1;
   parameter c_width= 12;
   parameter c_address_width= 4;
   input [c_address_width-1:0] addr;
   input en;
   input rst;
   input ce;
   input clk;
   output [c_width-1:0] data;
   wire [c_address_width-1:0] core_addr;
   wire [c_width-1:0] core_data_out;
   wire  core_ce, sinit;
   assign core_addr = addr;

   assign core_ce = ce & en;
   assign sinit = rst & ce;
generate
if (core_name0 == "bmg_72_c0e7027c8d56f068")
begin:comp1
  bmg_72_c0e7027c8d56f068 core_instance0 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_0b6075e08c22268d")
begin:comp3
  bmg_72_0b6075e08c22268d core_instance1 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_88bd69a7e506f2a2")
begin:comp5
  bmg_72_88bd69a7e506f2a2 core_instance2 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_2f2b227d5258d685")
begin:comp7
  bmg_72_2f2b227d5258d685 core_instance3 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_9cba7eb6526fc26f")
begin:comp9
  bmg_72_9cba7eb6526fc26f core_instance4 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_e18a8bcda58a41cd")
begin:comp11
  bmg_72_e18a8bcda58a41cd core_instance5 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_b297e10d233cb875")
begin:comp13
  bmg_72_b297e10d233cb875 core_instance6 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
if (core_name0 == "bmg_72_a3b5d83d934b45b5")
begin:comp15
  bmg_72_a3b5d83d934b45b5 core_instance7 (
                    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)
        );
end
 if (latency > 1)
     begin:latency_test
        synth_reg # (c_width, latency-1)
          reg1 (
               .i(core_data_out),
               .ce(core_ce),
               .clr(1'b0),
               .clk(clk),
               .o(data));
     end

   if (latency <= 1)
     begin:latency_1
        assign data = core_data_out;
     end
endgenerate
endmodule


module constant_dc846bf42d (
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 10'b0000001100;
endmodule
 



module opmode_3711ab4973 (
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20'b00000000000000000101;
  localparam [(5 - 1):0] const_value_x_000001 = 5'b00000;
  localparam [(3 - 1):0] const_value_x_000002 = 3'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11'b00000000101;
  localparam [(20 - 1):0] const_value_x_000004 = 20'b00000000000000000101;
  assign op = 20'b00000000000000000101;
endmodule
 



module reinterpret_84fa2b7df8 (
  input [(48 - 1):0] input_port,
  output [(48 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(48 - 1):0] input_port_1_40;
  wire [(48 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 


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
module xlregister (d, rst, en, ce, clk, q);
   parameter d_width = 5;
   parameter init_value = 'b0;

   input [d_width-1:0] d;
   input rst, en, ce, clk;
   output [d_width-1:0] q;
   wire internal_clr, internal_ce;
   assign internal_clr = rst & ce;
   assign internal_ce  = ce & en;

   synth_reg_w_init #(.width(d_width),
                      .init_index(2),
                      .init_value(init_value),
                      .latency(1))
   synth_reg_inst(.i(d),
                  .ce(internal_ce),
                  .clr(internal_clr),
                  .clk(clk),
                  .o(q));
endmodule


module reinterpret_9f3848bc50 (
  input [(5 - 1):0] input_port,
  output [(5 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(5 - 1):0] input_port_1_40;
  wire signed [(5 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_b41d29f193 (
  input [(10 - 1):0] input_port,
  output [(10 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(10 - 1):0] input_port_1_40;
  wire [(10 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_3f5d978749 (
  input [(6 - 1):0] input_port,
  output [(6 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(6 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module reinterpret_8eee8341d8 (
  input [(7 - 1):0] input_port,
  output [(7 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(7 - 1):0] input_port_1_40;
  wire signed [(7 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_fd8afbe046 (
  input [(10 - 1):0] input_port,
  output [(10 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(10 - 1):0] input_port_1_40;
  wire signed [(10 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_94dfdafd95 (
  input [(12 - 1):0] input_port,
  output [(12 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(12 - 1):0] input_port_1_40;
  wire signed [(12 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module shift_85f5a5ebd0 (
  input [(10 - 1):0] ip,
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(10 - 1):0] ip_1_23;
  localparam signed [(10 - 1):0] const_value = 10'sb0000000000;
  reg signed [(10 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 10'b0000000000;
    end
  wire signed [(10 - 1):0] op_mem_46_20_front_din;
  wire signed [(10 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(14 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(10 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[9]}}, ip_1_23[9:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[13]}}, cast_internal_ip_27_3_rsh[13:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_39b9422678 (
  input [(12 - 1):0] ip,
  output [(12 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(12 - 1):0] ip_1_23;
  localparam signed [(12 - 1):0] const_value = 12'sb000000000000;
  reg signed [(12 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 12'b000000000000;
    end
  wire signed [(12 - 1):0] op_mem_46_20_front_din;
  wire signed [(12 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(16 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(12 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[11]}}, ip_1_23[11:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[15]}}, cast_internal_ip_27_3_rsh[15:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_af45bff5a0 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_13f7182392 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_35e4e03aef (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(30 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{12{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[29]}}, cast_internal_ip_27_3_rsh[29:13]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module reinterpret_feb184a5ad (
  input [(8 - 1):0] input_port,
  output [(8 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(8 - 1):0] input_port_1_40;
  wire signed [(8 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_34f6390c19 (
  input [(9 - 1):0] input_port,
  output [(9 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(9 - 1):0] input_port_1_40;
  wire [(9 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_016d92ab20 (
  input [(7 - 1):0] input_port,
  output [(7 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(7 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
 



module reinterpret_6200c8761b (
  input [(15 - 1):0] input_port,
  output [(15 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(15 - 1):0] input_port_1_40;
  wire signed [(15 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_55833616ec (
  input [(13 - 1):0] input_port,
  output [(13 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(13 - 1):0] input_port_1_40;
  wire signed [(13 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module shift_447ff429c9 (
  input [(15 - 1):0] ip,
  output [(15 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(15 - 1):0] ip_1_23;
  localparam signed [(15 - 1):0] const_value = 15'sb000000000000000;
  reg signed [(15 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 15'b000000000000000;
    end
  wire signed [(15 - 1):0] op_mem_46_20_front_din;
  wire signed [(15 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(15 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[14]}}, ip_1_23[14:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_05a6d83f8c (
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_ed17a56c3a (
  input [(13 - 1):0] ip,
  output [(13 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(13 - 1):0] ip_1_23;
  localparam signed [(13 - 1):0] const_value = 13'sb0000000000000;
  reg signed [(13 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 13'b0000000000000;
    end
  wire signed [(13 - 1):0] op_mem_46_20_front_din;
  wire signed [(13 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(13 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[12]}}, ip_1_23[12:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_e2f66c8512 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(19 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[18]}}, cast_internal_ip_27_3_rsh[18:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_e2efd1e2c2 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_42c206eba8 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module reinterpret_87da68fdf8 (
  input [(18 - 1):0] input_port,
  output [(18 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(18 - 1):0] input_port_1_40;
  wire signed [(18 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module shift_572bccbff0 (
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = ip_1_23;
endmodule
 



module shift_5d11edb312 (
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_e97ef80d67 (
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{6{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module reinterpret_81e883cd82 (
  input [(9 - 1):0] input_port,
  output [(9 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(9 - 1):0] input_port_1_40;
  wire signed [(9 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_79f2a2c095 (
  input [(17 - 1):0] input_port,
  output [(17 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(17 - 1):0] input_port_1_40;
  wire signed [(17 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module shift_0be5f5842d (
  input [(17 - 1):0] ip,
  output [(17 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(17 - 1):0] ip_1_23;
  localparam signed [(17 - 1):0] const_value = 17'sb00000000000000000;
  reg signed [(17 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 17'b00000000000000000;
    end
  wire signed [(17 - 1):0] op_mem_46_20_front_din;
  wire signed [(17 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(24 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(17 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[16]}}, ip_1_23[16:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[23]}}, cast_internal_ip_27_3_rsh[23:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_0b3d34a3d5 (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_bc177199ac (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module reinterpret_7fc77e4dea (
  input [(11 - 1):0] input_port,
  output [(11 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(11 - 1):0] input_port_1_40;
  wire signed [(11 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module reinterpret_888f8372ca (
  input [(19 - 1):0] input_port,
  output [(19 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(19 - 1):0] input_port_1_40;
  wire signed [(19 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
 



module shift_ca62c0bb60 (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  wire signed [(26 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[25]}}, cast_internal_ip_27_3_rsh[25:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
 



module shift_c01ac94bc0 (
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1'b1) && (op_mem_46_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign op_mem_46_20_push_front_pop_back_en = 1'b0;
  assign op = ip_1_23;
endmodule
 



module constant_c3c0af03bb (
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 19'b0000000000000000011;
endmodule
 

