// Generated from Simulink block "duc_16ch_341/HBF1 Filter/0.137184776786555_1"

module x0_137184776786555_1_module_b0b8561fd5 (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [16:0] in_x0;
  output [19:0] out_x0;

  wire [18:0] addsub1_s_net;
  wire [25:0] addsub2_s_net;
  wire [16:0] addsub2_s_net_x1;
  wire [21:0] addsub3_s_net;
  wire [29:0] addsub4_s_net;
  wire [0:0] ce_1_sg_x0;
  wire [0:0] clk_1_sg_x0;
  wire [21:0] convert2_dout_net;
  wire [18:0] convert3_dout_net;
  wire [25:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [31:0] convert6_dout_net;
  wire [19:0] convert7_dout_net_x0;
  wire [18:0] delay_q_net;
  wire [18:0] shift1_op_net;
  wire [31:0] shift2_op_net;
  wire [18:0] shift3_op_net;
  wire [18:0] shift4_op_net;
  wire [21:0] shift5_op_net;
  wire [25:0] shift6_op_net;
  wire [21:0] shift7_op_net;
  wire [29:0] shift9_op_net;

  assign ce_1_sg_x0 = ce_1;
  assign clk_1_sg_x0 = clk_1;
  assign addsub2_s_net_x1 = in_x0;
  assign out_x0 = convert7_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(19))
  addsub1 (
    .a(shift1_op_net),
    .b(shift4_op_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(24),
    .a_width(26),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(27),
    .core_name0("addsb_11_0_315e1457f99dae5e"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(27),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(24),
    .s_width(26))
  addsub2 (
    .a(shift6_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(20),
    .a_width(22),
    .b_arith(`xlSigned),
    .b_bin_pt(20),
    .b_width(22),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(23),
    .core_name0("addsb_11_0_ccf4ef11a52a233f"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(23),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(20),
    .s_width(22))
  addsub3 (
    .a(shift7_op_net),
    .b(shift5_op_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(28),
    .a_width(30),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(31),
    .core_name0("addsb_11_0_f1b619e12671c199"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(31),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(28),
    .s_width(30))
  addsub4 (
    .a(shift9_op_net),
    .b(delay_q_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(20),
    .dout_width(22),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(addsub2_s_net_x1),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(addsub2_s_net_x1),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(20),
    .din_width(22),
    .dout_arith(2),
    .dout_bin_pt(24),
    .dout_width(26),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(24),
    .din_width(26),
    .dout_arith(2),
    .dout_bin_pt(28),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(28),
    .din_width(30),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(addsub4_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .din(shift2_op_net),
    .en(1'b1),
    .dout(convert7_dout_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .d(shift3_op_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  shift_3fa2663220  shift1 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift1_op_net)
  );

  shift_d13a4b790a  shift2 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift2_op_net)
  );

  shift_091db5281e  shift3 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_091db5281e  shift4 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift4_op_net)
  );

  shift_6a42af8a02  shift5 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift5_op_net)
  );

  shift_860703fe20  shift6 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift6_op_net)
  );

  shift_773079a115  shift7 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift7_op_net)
  );

  shift_2b728df15b  shift9 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift9_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter/TDM"

module tdm_module_a307bb0ec5 (
  ce_1,
  clk_1,
  in1,
  in2,
  out_x0,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  input [0:0] sel;
  output [15:0] out_x0;

  wire [0:0] ce_1_sg_x2;
  wire [0:0] clk_1_sg_x2;
  wire [15:0] delay14_q_net_x0;
  wire [15:0] delay6_q_net_x0;
  wire [15:0] mux1_y_net_x0;
  wire [0:0] sel_counter_op_net_x0;

  assign ce_1_sg_x2 = ce_1;
  assign clk_1_sg_x2 = clk_1;
  assign delay14_q_net_x0 = in1;
  assign delay6_q_net_x0 = in2;
  assign out_x0 = mux1_y_net_x0;
  assign sel_counter_op_net_x0 = sel;


  mux_1f6c522247  mux1 (
    .ce(ce_1_sg_x2),
    .clk(clk_1_sg_x2),
    .clr(1'b0),
    .d0(delay14_q_net_x0),
    .d1(delay6_q_net_x0),
    .sel(sel_counter_op_net_x0),
    .y(mux1_y_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter/coef1_1"

module coef1_1_module_2a9b771d42 (
  a,
  ce_1,
  clk_1,
  d,
  out_x0
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  output [19:0] out_x0;

  wire [0:0] ce_1_sg_x6;
  wire [0:0] clk_1_sg_x6;
  wire [47:0] constant1_op_net;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [19:0] convert3_dout_net_x0;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay30_q_net_x0;
  wire [15:0] delay7_q_net_x0;
  wire [47:0] dsp48e1_4_p_net;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [47:0] reinterpret2_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay30_q_net_x0 = a;
  assign ce_1_sg_x6 = ce_1;
  assign clk_1_sg_x6 = clk_1;
  assign delay7_q_net_x0 = d;
  assign out_x0 = convert3_dout_net_x0;


  constant_d1c6dff675  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_93b414a047  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .c(constant1_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x6),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x6),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  opmode_6481474c6d  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay30_q_net_x0),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay7_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter/coef3_1"

module coef3_1_module_92f65502bd (
  a,
  ce_1,
  clk_1,
  d,
  out_x0
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  output [19:0] out_x0;

  wire [0:0] ce_1_sg_x8;
  wire [0:0] clk_1_sg_x8;
  wire [47:0] constant1_op_net;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [19:0] convert3_dout_net_x0;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay5_q_net_x0;
  wire [15:0] delay_q_net_x0;
  wire [47:0] dsp48e1_4_p_net;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [47:0] reinterpret2_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay5_q_net_x0 = a;
  assign ce_1_sg_x8 = ce_1;
  assign clk_1_sg_x8 = clk_1;
  assign delay_q_net_x0 = d;
  assign out_x0 = convert3_dout_net_x0;


  constant_d1c6dff675  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_4d353c6047  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x8),
    .clk(clk_1_sg_x8),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x8),
    .clk(clk_1_sg_x8),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x8),
    .clk(clk_1_sg_x8),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x8),
    .clk(clk_1_sg_x8),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .c(constant1_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x8),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x8),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  opmode_6481474c6d  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay5_q_net_x0),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter/coef3_2"

module coef3_2_module_a7db674f46 (
  a,
  ce_1,
  clk_1,
  d,
  out_x0
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  output [19:0] out_x0;

  wire [0:0] ce_1_sg_x9;
  wire [0:0] clk_1_sg_x9;
  wire [47:0] constant1_op_net;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [19:0] convert3_dout_net_x0;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay2_q_net_x0;
  wire [15:0] delay3_q_net_x0;
  wire [47:0] dsp48e1_4_p_net;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [47:0] reinterpret2_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay3_q_net_x0 = a;
  assign ce_1_sg_x9 = ce_1;
  assign clk_1_sg_x9 = clk_1;
  assign delay2_q_net_x0 = d;
  assign out_x0 = convert3_dout_net_x0;


  constant_d1c6dff675  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_b293d8004e  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .c(constant1_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x9),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x9),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  opmode_6481474c6d  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay3_q_net_x0),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter/reorder1"

module reorder1_module_772391b4f3 (
  addr,
  ce_1,
  clk_1,
  in1,
  in2,
  out1,
  out2
);

  input [3:0] addr;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  output [15:0] out1;
  output [15:0] out2;

  wire [3:0] addr_counter_op_net_x0;
  wire [0:0] ce_1_sg_x12;
  wire [0:0] clk_1_sg_x12;
  wire [31:0] concat_y_net;
  wire [0:0] constant4_op_net;
  wire [15:0] delay1_q_net_x0;
  wire [3:0] delay2_q_net;
  wire [15:0] delay_q_net_x0;
  wire [31:0] dual_port_ram_doutb_net;
  wire [15:0] mux1_y_net_x2;
  wire [15:0] mux1_y_net_x3;
  wire [15:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret8_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [15:0] reinterpret_output_port_net;
  wire [3:0] rom_data_net;
  wire [15:0] slice4_y_net;
  wire [15:0] slice5_y_net;

  assign addr_counter_op_net_x0 = addr;
  assign ce_1_sg_x12 = ce_1;
  assign clk_1_sg_x12 = clk_1;
  assign mux1_y_net_x2 = in1;
  assign mux1_y_net_x3 = in2;
  assign out1 = delay_q_net_x0;
  assign out2 = delay1_q_net_x0;


  concat_7e18b92ffa  concat (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .in0(reinterpret_output_port_net),
    .in1(reinterpret1_output_port_net),
    .y(concat_y_net)
  );

  constant_5e90e4a8ec  constant4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant4_op_net)
  );

  xldelay #(

    .latency(6),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x12),
    .clk(clk_1_sg_x12),
    .d(reinterpret8_output_port_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x0)
  );

  xldelay #(

    .latency(6),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x12),
    .clk(clk_1_sg_x12),
    .d(reinterpret9_output_port_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(4))
  delay2 (
    .ce(ce_1_sg_x12),
    .clk(clk_1_sg_x12),
    .d(addr_counter_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldpram_dist_duc_16ch_341 #(

    .addr_width(4),
    .c_address_width(4),
    .c_width(32),
    .core_name0("dmg_72_903d17a1900ee539"),
    .latency(1))
  dual_port_ram (
    .a_ce(ce_1_sg_x12),
    .a_clk(clk_1_sg_x12),
    .addra(delay2_q_net),
    .addrb(rom_data_net),
    .b_ce(ce_1_sg_x12),
    .b_clk(clk_1_sg_x12),
    .dina(concat_y_net),
    .ena(1'b1),
    .enb(1'b1),
    .wea(constant4_op_net),
    .doutb(dual_port_ram_doutb_net)
  );

  reinterpret_2824f666f2  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(mux1_y_net_x2),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_2824f666f2  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(mux1_y_net_x3),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice4_y_net),
    .output_port(reinterpret8_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice5_y_net),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(4),
    .c_address_width(4),
    .c_width(4),
    .core_name0("dmg_72_85ef246b9b71061d"),
    .latency(1))
  rom (
    .addr(delay2_q_net),
    .ce(ce_1_sg_x12),
    .clk(clk_1_sg_x12),
    .en(1'b1),
    .data(rom_data_net)
  );

  xlslice #(

    .new_lsb(16),
    .new_msb(31),
    .x_width(32),
    .y_width(16))
  slice4 (
    .x(dual_port_ram_doutb_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(15),
    .x_width(32),
    .y_width(16))
  slice5 (
    .x(dual_port_ram_doutb_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF1 Filter"

module hbf1_filter_module_9817535529 (
  ce_1,
  clk_1,
  in1,
  in2,
  out1,
  out2,
  out3,
  out4,
  rst,
  valid_out
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  input [0:0] rst;
  output [15:0] out1;
  output [15:0] out2;
  output [15:0] out3;
  output [15:0] out4;
  output [0:0] valid_out;

  wire [3:0] addr_counter_op_net_x1;
  wire [19:0] addsub10_s_net;
  wire [19:0] addsub11_s_net;
  wire [16:0] addsub2_s_net_x1;
  wire [19:0] addsub4_s_net;
  wire [19:0] addsub5_s_net;
  wire [19:0] addsub6_s_net;
  wire [16:0] addsub8_s_net_x0;
  wire [19:0] addsub9_s_net;
  wire [0:0] ce_1_sg_x14;
  wire [0:0] clk_1_sg_x14;
  wire [15:0] convert1_dout_net;
  wire [15:0] convert3_dout_net_x0;
  wire [19:0] convert3_dout_net_x1;
  wire [19:0] convert3_dout_net_x2;
  wire [19:0] convert3_dout_net_x3;
  wire [19:0] convert3_dout_net_x4;
  wire [19:0] convert3_dout_net_x5;
  wire [19:0] convert3_dout_net_x6;
  wire [15:0] convert4_dout_net_x0;
  wire [19:0] convert7_dout_net_x0;
  wire [19:0] convert7_dout_net_x1;
  wire [15:0] convert_dout_net;
  wire [15:0] delay10_q_net_x0;
  wire [15:0] delay11_q_net_x0;
  wire [15:0] delay12_q_net_x0;
  wire [15:0] delay13_q_net_x0;
  wire [15:0] delay14_q_net_x0;
  wire [15:0] delay15_q_net_x0;
  wire [15:0] delay16_q_net;
  wire [15:0] delay17_q_net_x0;
  wire [15:0] delay18_q_net_x0;
  wire [15:0] delay19_q_net_x0;
  wire [15:0] delay1_q_net;
  wire [15:0] delay1_q_net_x2;
  wire [15:0] delay1_q_net_x3;
  wire [15:0] delay2_q_net_x0;
  wire [15:0] delay30_q_net_x0;
  wire [15:0] delay31_q_net_x0;
  wire [0:0] delay33_q_net;
  wire [0:0] delay34_q_net_x0;
  wire [15:0] delay3_q_net_x0;
  wire [15:0] delay4_q_net;
  wire [15:0] delay5_q_net_x0;
  wire [15:0] delay6_q_net_x0;
  wire [15:0] delay7_q_net_x0;
  wire [15:0] delay8_q_net_x0;
  wire [15:0] delay9_q_net;
  wire [15:0] delay_q_net_x0;
  wire [15:0] delay_q_net_x3;
  wire [15:0] delay_q_net_x4;
  wire [15:0] din1_net_x0;
  wire [15:0] din2_net_x0;
  wire [15:0] mux1_y_net_x2;
  wire [15:0] mux1_y_net_x3;
  wire [15:0] mux1_y_net_x4;
  wire [15:0] mux1_y_net_x5;
  wire [0:0] rst_net_x0;
  wire [0:0] sel_counter1_op_net_x1;
  wire [0:0] sel_counter_op_net_x1;

  assign ce_1_sg_x14 = ce_1;
  assign clk_1_sg_x14 = clk_1;
  assign din1_net_x0 = in1;
  assign din2_net_x0 = in2;
  assign out1 = delay_q_net_x3;
  assign out2 = delay1_q_net_x2;
  assign out3 = delay_q_net_x4;
  assign out4 = delay1_q_net_x3;
  assign rst_net_x0 = rst;
  assign valid_out = delay34_q_net_x0;


  xlcounter_limit_duc_16ch_341 #(

    .cnt_15_0(15),
    .cnt_31_16(0),
    .cnt_47_32(0),
    .cnt_63_48(0),
    .core_name0("cntr_11_0_7a9f00e1c86c8fba"),
    .count_limited(0),
    .op_arith(`xlUnsigned),
    .op_width(4))
  addr_counter (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .rst(delay33_q_net),
    .op(addr_counter_op_net_x1)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_c70c61eff7bb7aeb"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub10 (
    .a(convert3_dout_net_x6),
    .b(convert7_dout_net_x1),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub10_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub11 (
    .a(addsub9_s_net),
    .b(addsub10_s_net),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub11_s_net)
  );

  addsub_f03aa9b11e  addsub2 (
    .a(delay4_q_net),
    .b(delay1_q_net),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .s(addsub2_s_net_x1)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub4 (
    .a(convert3_dout_net_x3),
    .b(convert3_dout_net_x1),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_c70c61eff7bb7aeb"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub5 (
    .a(convert3_dout_net_x4),
    .b(convert7_dout_net_x0),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub6 (
    .a(addsub4_s_net),
    .b(addsub5_s_net),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  addsub_f03aa9b11e  addsub8 (
    .a(delay16_q_net),
    .b(delay9_q_net),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .s(addsub8_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub9 (
    .a(convert3_dout_net_x5),
    .b(convert3_dout_net_x2),
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net)
  );

  coef1_1_module_2a9b771d42  coef1_1_2a9b771d42 (
    .a(delay30_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay7_q_net_x0),
    .out_x0(convert3_dout_net_x1)
  );

  coef1_1_module_2a9b771d42  coef1_2_19226c47f8 (
    .a(delay31_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay19_q_net_x0),
    .out_x0(convert3_dout_net_x2)
  );

  coef3_1_module_92f65502bd  coef3_1_92f65502bd (
    .a(delay5_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay_q_net_x0),
    .out_x0(convert3_dout_net_x3)
  );

  coef3_2_module_a7db674f46  coef3_2_a7db674f46 (
    .a(delay3_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay2_q_net_x0),
    .out_x0(convert3_dout_net_x4)
  );

  coef3_1_module_92f65502bd  coef3_3_2851081f1f (
    .a(delay17_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay8_q_net_x0),
    .out_x0(convert3_dout_net_x5)
  );

  coef3_2_module_a7db674f46  coef3_4_c7be4d4f45 (
    .a(delay13_q_net_x0),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .d(delay12_q_net_x0),
    .out_x0(convert3_dout_net_x6)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .din(addsub6_s_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert1 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .din(addsub11_s_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .din(delay3_q_net_x0),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .din(delay13_q_net_x0),
    .en(1'b1),
    .dout(convert4_dout_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay30_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(9),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay10 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert1_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay11 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert1_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay12 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay9_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay13 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay12_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net_x0)
  );

  xldelay #(

    .latency(9),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay14 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay15 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay16 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay13_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay16_q_net)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay17 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay16_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay17_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay18 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert4_dout_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay18_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay19 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay17_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay19_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay2 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay1_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay2_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay30 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(din1_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay30_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay31 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(din2_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay31_q_net_x0)
  );

  xldelay #(

    .latency(32),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay33 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(rst_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay33_q_net)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay34 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay33_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay34_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay3_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay4_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay6 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(convert3_dout_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay7 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay5_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay8 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay31_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net_x0)
  );

  xldelay #(

    .latency(16),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay9 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .d(delay8_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net)
  );

  reorder1_module_772391b4f3  reorder1_772391b4f3 (
    .addr(addr_counter_op_net_x1),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(mux1_y_net_x2),
    .in2(mux1_y_net_x3),
    .out1(delay_q_net_x3),
    .out2(delay1_q_net_x2)
  );

  reorder1_module_772391b4f3  reorder2_19d70213ea (
    .addr(addr_counter_op_net_x1),
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(mux1_y_net_x4),
    .in2(mux1_y_net_x5),
    .out1(delay_q_net_x4),
    .out2(delay1_q_net_x3)
  );

  counter_5c8ee48e8f  sel_counter (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .rst(delay33_q_net),
    .op(sel_counter_op_net_x1)
  );

  counter_5c8ee48e8f  sel_counter1 (
    .ce(ce_1_sg_x14),
    .clk(clk_1_sg_x14),
    .clr(1'b0),
    .rst(delay33_q_net),
    .op(sel_counter1_op_net_x1)
  );

  tdm_module_a307bb0ec5  tdm1_e0a3577fe6 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(delay15_q_net_x0),
    .in2(convert3_dout_net_x0),
    .sel(sel_counter_op_net_x1),
    .out_x0(mux1_y_net_x3)
  );

  tdm_module_a307bb0ec5  tdm2_7e75c2fb58 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(delay10_q_net_x0),
    .in2(delay18_q_net_x0),
    .sel(sel_counter1_op_net_x1),
    .out_x0(mux1_y_net_x4)
  );

  tdm_module_a307bb0ec5  tdm3_efaf16cb31 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(delay11_q_net_x0),
    .in2(convert4_dout_net_x0),
    .sel(sel_counter1_op_net_x1),
    .out_x0(mux1_y_net_x5)
  );

  tdm_module_a307bb0ec5  tdm_a307bb0ec5 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in1(delay14_q_net_x0),
    .in2(delay6_q_net_x0),
    .sel(sel_counter_op_net_x1),
    .out_x0(mux1_y_net_x2)
  );

  x0_137184776786555_1_module_b0b8561fd5  x0_137184776786555_1_b0b8561fd5 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert7_dout_net_x0)
  );

  x0_137184776786555_1_module_b0b8561fd5  x0_137184776786555_2_68bbefbd75 (
    .ce_1(ce_1_sg_x14),
    .clk_1(clk_1_sg_x14),
    .in_x0(addsub8_s_net_x0),
    .out_x0(convert7_dout_net_x1)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter/0.013453762122151"

module x0_013453762122151_module_ee73fab64c (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [16:0] in_x0;
  output [19:0] out_x0;

  wire [27:0] addsub2_s_net;
  wire [20:0] addsub3_s_net;
  wire [16:0] addsub_s_net_x0;
  wire [0:0] ce_1_sg_x15;
  wire [0:0] clk_1_sg_x15;
  wire [19:0] convert1_dout_net_x0;
  wire [27:0] convert2_dout_net;
  wire [20:0] convert3_dout_net;
  wire [21:0] convert4_dout_net;
  wire [31:0] convert5_dout_net;
  wire [20:0] shift3_op_net;
  wire [20:0] shift4_op_net;
  wire [27:0] shift5_op_net;
  wire [21:0] shift6_op_net;
  wire [31:0] shift9_op_net;

  assign ce_1_sg_x15 = ce_1;
  assign clk_1_sg_x15 = clk_1;
  assign addsub_s_net_x0 = in_x0;
  assign out_x0 = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(20),
    .a_width(22),
    .b_arith(`xlSigned),
    .b_bin_pt(26),
    .b_width(28),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(29),
    .core_name0("addsb_11_0_45f8b994267d2451"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(29),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(26),
    .s_width(28))
  addsub2 (
    .a(shift6_op_net),
    .b(shift5_op_net),
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(21),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(21),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(22),
    .core_name0("addsb_11_0_d0318fcf26b3c272"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(22),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(21))
  addsub3 (
    .a(shift3_op_net),
    .b(shift4_op_net),
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .din(shift9_op_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(21),
    .dout_arith(2),
    .dout_bin_pt(26),
    .dout_width(28),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(21),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .din(addsub_s_net_x0),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(21),
    .dout_arith(2),
    .dout_bin_pt(20),
    .dout_width(22),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(26),
    .din_width(28),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  shift_a0dd291710  shift3 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_92fa79e61c  shift4 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift4_op_net)
  );

  shift_be765386ae  shift5 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift5_op_net)
  );

  shift_773079a115  shift6 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift6_op_net)
  );

  shift_58794f53f4  shift9 (
    .ce(ce_1_sg_x15),
    .clk(clk_1_sg_x15),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift9_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter/0.102575973038173"

module x0_102575973038173_module_0cd5b13937 (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [16:0] in_x0;
  output [19:0] out_x0;

  wire [20:0] addsub1_s_net;
  wire [16:0] addsub1_s_net_x1;
  wire [23:0] addsub2_s_net;
  wire [18:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x17;
  wire [0:0] clk_1_sg_x17;
  wire [19:0] convert1_dout_net_x0;
  wire [23:0] convert2_dout_net;
  wire [18:0] convert3_dout_net;
  wire [26:0] convert5_dout_net;
  wire [20:0] convert6_dout_net;
  wire [20:0] shift1_op_net;
  wire [20:0] shift2_op_net;
  wire [18:0] shift3_op_net;
  wire [18:0] shift4_op_net;
  wire [23:0] shift5_op_net;
  wire [26:0] shift9_op_net;

  assign ce_1_sg_x17 = ce_1;
  assign clk_1_sg_x17 = clk_1;
  assign addsub1_s_net_x1 = in_x0;
  assign out_x0 = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(21),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(21),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(22),
    .core_name0("addsb_11_0_82f1c5fd59d21ea0"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(22),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(21))
  addsub1 (
    .a(shift2_op_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(22),
    .a_width(24),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(25),
    .core_name0("addsb_11_0_27308e86a0ce55d1"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(25),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(22),
    .s_width(24))
  addsub2 (
    .a(shift5_op_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(19))
  addsub3 (
    .a(shift4_op_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(25),
    .din_width(27),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .din(shift9_op_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(21),
    .dout_arith(2),
    .dout_bin_pt(22),
    .dout_width(24),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .din(addsub1_s_net_x1),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(22),
    .din_width(24),
    .dout_arith(2),
    .dout_bin_pt(25),
    .dout_width(27),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(21),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .din(addsub1_s_net_x1),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  shift_a0dd291710  shift1 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift1_op_net)
  );

  shift_92fa79e61c  shift2 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift2_op_net)
  );

  shift_091db5281e  shift3 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_3fa2663220  shift4 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift4_op_net)
  );

  shift_940a0f4802  shift5 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift5_op_net)
  );

  shift_cecea44c7e  shift9 (
    .ce(ce_1_sg_x17),
    .clk(clk_1_sg_x17),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift9_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter/0.589129026142142"

module x0_589129026142142_module_4ad800e375 (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [16:0] in_x0;
  output [19:0] out_x0;

  wire [20:0] addsub1_s_net;
  wire [24:0] addsub2_s_net;
  wire [16:0] addsub2_s_net_x1;
  wire [18:0] addsub3_s_net;
  wire [23:0] addsub4_s_net;
  wire [31:0] addsub6_s_net;
  wire [0:0] ce_1_sg_x19;
  wire [0:0] clk_1_sg_x19;
  wire [19:0] convert1_dout_net_x0;
  wire [24:0] convert2_dout_net;
  wire [18:0] convert3_dout_net;
  wire [19:0] convert4_dout_net;
  wire [31:0] convert5_dout_net;
  wire [20:0] convert6_dout_net;
  wire [23:0] convert7_dout_net;
  wire [19:0] shift11_op_net;
  wire [23:0] shift12_op_net;
  wire [20:0] shift1_op_net;
  wire [20:0] shift2_op_net;
  wire [18:0] shift3_op_net;
  wire [18:0] shift4_op_net;
  wire [24:0] shift5_op_net;
  wire [31:0] shift6_op_net;

  assign ce_1_sg_x19 = ce_1;
  assign clk_1_sg_x19 = clk_1;
  assign addsub2_s_net_x1 = in_x0;
  assign out_x0 = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(21),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(21),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(22),
    .core_name0("addsb_11_0_82f1c5fd59d21ea0"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(22),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(21))
  addsub1 (
    .a(shift2_op_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(23),
    .a_width(25),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(26),
    .core_name0("addsb_11_0_3cbd55626510ca57"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(26),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(23),
    .s_width(25))
  addsub2 (
    .a(shift5_op_net),
    .b(shift11_op_net),
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(19))
  addsub3 (
    .a(shift4_op_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(22),
    .a_width(24),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(21),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(25),
    .core_name0("addsb_11_0_27308e86a0ce55d1"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(25),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(22),
    .s_width(24))
  addsub4 (
    .a(shift12_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(30),
    .a_width(32),
    .b_arith(`xlSigned),
    .b_bin_pt(22),
    .b_width(24),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(33),
    .core_name0("addsb_11_0_fc66294023431638"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(33),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(30),
    .s_width(32))
  addsub6 (
    .a(shift6_op_net),
    .b(addsub4_s_net),
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub6_s_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(21),
    .dout_arith(2),
    .dout_bin_pt(23),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub2_s_net_x1),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(23),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(21),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub2_s_net_x1),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(22),
    .dout_width(24),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  shift_a0dd291710  shift1 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift1_op_net)
  );

  shift_7d97a52cb7  shift11 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift11_op_net)
  );

  shift_c3b3a63c34  shift12 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert7_dout_net),
    .op(shift12_op_net)
  );

  shift_92fa79e61c  shift2 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift2_op_net)
  );

  shift_091db5281e  shift3 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_3fa2663220  shift4 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift4_op_net)
  );

  shift_0f7277fd89  shift5 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift5_op_net)
  );

  shift_a47dc9adee  shift6 (
    .ce(ce_1_sg_x19),
    .clk(clk_1_sg_x19),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift6_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter/TDM"

module tdm_module_d4ee23f649 (
  ce_1,
  clk_1,
  in1,
  in2,
  out1,
  rst
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  input [0:0] rst;
  output [15:0] out1;

  wire [0:0] ce_1_sg_x21;
  wire [0:0] clk_1_sg_x21;
  wire [0:0] counter1_op_net;
  wire [15:0] delay14_q_net_x0;
  wire [0:0] delay16_q_net_x0;
  wire [15:0] delay6_q_net_x0;
  wire [15:0] mux1_y_net_x0;

  assign ce_1_sg_x21 = ce_1;
  assign clk_1_sg_x21 = clk_1;
  assign delay14_q_net_x0 = in1;
  assign delay6_q_net_x0 = in2;
  assign out1 = mux1_y_net_x0;
  assign delay16_q_net_x0 = rst;


  counter_5c8ee48e8f  counter1 (
    .ce(ce_1_sg_x21),
    .clk(clk_1_sg_x21),
    .clr(1'b0),
    .rst(delay16_q_net_x0),
    .op(counter1_op_net)
  );

  mux_1f6c522247  mux1 (
    .ce(ce_1_sg_x21),
    .clk(clk_1_sg_x21),
    .clr(1'b0),
    .d0(delay14_q_net_x0),
    .d1(delay6_q_net_x0),
    .sel(counter1_op_net),
    .y(mux1_y_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter/reorder1"

module reorder1_module_7a6296d7aa (
  addr,
  ce_1,
  clk_1,
  in1,
  in2,
  out1,
  out2
);

  input [2:0] addr;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  output [15:0] out1;
  output [15:0] out2;

  wire [0:0] ce_1_sg_x25;
  wire [0:0] clk_1_sg_x25;
  wire [31:0] concat_y_net;
  wire [0:0] constant4_op_net;
  wire [2:0] counter_op_net_x0;
  wire [15:0] delay1_q_net_x0;
  wire [2:0] delay2_q_net;
  wire [15:0] delay_q_net_x0;
  wire [31:0] dual_port_ram_doutb_net;
  wire [15:0] mux1_y_net_x2;
  wire [15:0] mux1_y_net_x3;
  wire [15:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret8_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [15:0] reinterpret_output_port_net;
  wire [2:0] rom_data_net;
  wire [15:0] slice4_y_net;
  wire [15:0] slice5_y_net;

  assign counter_op_net_x0 = addr;
  assign ce_1_sg_x25 = ce_1;
  assign clk_1_sg_x25 = clk_1;
  assign mux1_y_net_x2 = in1;
  assign mux1_y_net_x3 = in2;
  assign out1 = delay_q_net_x0;
  assign out2 = delay1_q_net_x0;


  concat_7e18b92ffa  concat (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .in0(reinterpret_output_port_net),
    .in1(reinterpret1_output_port_net),
    .y(concat_y_net)
  );

  constant_5e90e4a8ec  constant4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant4_op_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x25),
    .clk(clk_1_sg_x25),
    .d(reinterpret8_output_port_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x25),
    .clk(clk_1_sg_x25),
    .d(reinterpret9_output_port_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(3))
  delay2 (
    .ce(ce_1_sg_x25),
    .clk(clk_1_sg_x25),
    .d(counter_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldpram_dist_duc_16ch_341 #(

    .addr_width(3),
    .c_address_width(4),
    .c_width(32),
    .core_name0("dmg_72_1c9994abe91d1da0"),
    .latency(1))
  dual_port_ram (
    .a_ce(ce_1_sg_x25),
    .a_clk(clk_1_sg_x25),
    .addra(delay2_q_net),
    .addrb(rom_data_net),
    .b_ce(ce_1_sg_x25),
    .b_clk(clk_1_sg_x25),
    .dina(concat_y_net),
    .ena(1'b1),
    .enb(1'b1),
    .wea(constant4_op_net),
    .doutb(dual_port_ram_doutb_net)
  );

  reinterpret_2824f666f2  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(mux1_y_net_x2),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_2824f666f2  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(mux1_y_net_x3),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice4_y_net),
    .output_port(reinterpret8_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice5_y_net),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(3),
    .c_address_width(4),
    .c_width(3),
    .core_name0("dmg_72_9ec52875c6eb4958"),
    .latency(1))
  rom (
    .addr(delay2_q_net),
    .ce(ce_1_sg_x25),
    .clk(clk_1_sg_x25),
    .en(1'b1),
    .data(rom_data_net)
  );

  xlslice #(

    .new_lsb(16),
    .new_msb(31),
    .x_width(32),
    .y_width(16))
  slice4 (
    .x(dual_port_ram_doutb_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(15),
    .x_width(32),
    .y_width(16))
  slice5 (
    .x(dual_port_ram_doutb_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF2 Filter"

module hbf2_filter_module_d8198f572c (
  ce_1,
  clk_1,
  in1,
  in2,
  out1,
  out2,
  out3,
  out4,
  valid_in,
  valid_out
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [15:0] in2;
  input [0:0] valid_in;
  output [15:0] out1;
  output [15:0] out2;
  output [15:0] out3;
  output [15:0] out4;
  output [0:0] valid_out;

  wire [16:0] addsub1_s_net_x1;
  wire [16:0] addsub2_s_net_x1;
  wire [16:0] addsub3_s_net_x1;
  wire [19:0] addsub4_s_net;
  wire [16:0] addsub5_s_net_x0;
  wire [19:0] addsub6_s_net;
  wire [16:0] addsub7_s_net_x0;
  wire [19:0] addsub8_s_net;
  wire [19:0] addsub9_s_net;
  wire [16:0] addsub_s_net_x0;
  wire [0:0] ce_1_sg_x27;
  wire [0:0] clk_1_sg_x27;
  wire [19:0] convert1_dout_net_x0;
  wire [19:0] convert1_dout_net_x1;
  wire [19:0] convert1_dout_net_x2;
  wire [19:0] convert1_dout_net_x3;
  wire [19:0] convert1_dout_net_x4;
  wire [19:0] convert1_dout_net_x5;
  wire [15:0] convert1_dout_net_x6;
  wire [15:0] convert2_dout_net;
  wire [15:0] convert3_dout_net;
  wire [15:0] convert_dout_net_x0;
  wire [2:0] counter_op_net_x1;
  wire [15:0] delay10_q_net_x0;
  wire [15:0] delay11_q_net_x0;
  wire [15:0] delay12_q_net;
  wire [15:0] delay13_q_net;
  wire [15:0] delay14_q_net_x0;
  wire [15:0] delay15_q_net_x0;
  wire [0:0] delay16_q_net_x3;
  wire [0:0] delay17_q_net_x0;
  wire [15:0] delay1_q_net;
  wire [15:0] delay1_q_net_x3;
  wire [15:0] delay1_q_net_x4;
  wire [15:0] delay1_q_net_x5;
  wire [15:0] delay2_q_net;
  wire [0:0] delay34_q_net_x1;
  wire [15:0] delay3_q_net;
  wire [15:0] delay4_q_net;
  wire [15:0] delay5_q_net;
  wire [15:0] delay6_q_net_x0;
  wire [15:0] delay7_q_net;
  wire [15:0] delay8_q_net;
  wire [15:0] delay9_q_net_x0;
  wire [15:0] delay_q_net;
  wire [15:0] delay_q_net_x5;
  wire [15:0] delay_q_net_x6;
  wire [15:0] delay_q_net_x7;
  wire [15:0] mux1_y_net_x2;
  wire [15:0] mux1_y_net_x3;
  wire [15:0] mux1_y_net_x4;
  wire [15:0] mux1_y_net_x5;

  assign ce_1_sg_x27 = ce_1;
  assign clk_1_sg_x27 = clk_1;
  assign delay_q_net_x5 = in1;
  assign delay1_q_net_x3 = in2;
  assign out1 = delay_q_net_x6;
  assign out2 = delay1_q_net_x4;
  assign out3 = delay_q_net_x7;
  assign out4 = delay1_q_net_x5;
  assign delay34_q_net_x1 = valid_in;
  assign valid_out = delay17_q_net_x0;


  addsub_f03aa9b11e  addsub (
    .a(delay_q_net_x5),
    .b(delay4_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub_s_net_x0)
  );

  addsub_f03aa9b11e  addsub1 (
    .a(delay3_q_net),
    .b(delay_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub1_s_net_x1)
  );

  addsub_f03aa9b11e  addsub2 (
    .a(delay1_q_net),
    .b(delay2_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub2_s_net_x1)
  );

  addsub_f03aa9b11e  addsub3 (
    .a(delay1_q_net_x3),
    .b(delay13_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub3_s_net_x1)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_c70c61eff7bb7aeb"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub4 (
    .a(convert1_dout_net_x0),
    .b(convert1_dout_net_x2),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  addsub_f03aa9b11e  addsub5 (
    .a(delay12_q_net),
    .b(delay5_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub5_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub6 (
    .a(addsub4_s_net),
    .b(convert1_dout_net_x4),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  addsub_f03aa9b11e  addsub7 (
    .a(delay7_q_net),
    .b(delay8_q_net),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .s(addsub7_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub8 (
    .a(addsub9_s_net),
    .b(convert1_dout_net_x5),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub8_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_c70c61eff7bb7aeb"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub9 (
    .a(convert1_dout_net_x1),
    .b(convert1_dout_net_x3),
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .din(delay2_q_net),
    .en(1'b1),
    .dout(convert_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .din(delay8_q_net),
    .en(1'b1),
    .dout(convert1_dout_net_x6)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert2 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .din(addsub6_s_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert3 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .din(addsub8_s_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlcounter_limit_duc_16ch_341 #(

    .cnt_15_0(7),
    .cnt_31_16(0),
    .cnt_47_32(0),
    .cnt_63_48(0),
    .core_name0("cntr_11_0_6da79292a37693ee"),
    .count_limited(0),
    .op_arith(`xlUnsigned),
    .op_width(3))
  counter (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .clr(1'b0),
    .en(1'b1),
    .rst(delay16_q_net_x3),
    .op(counter_op_net_x1)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay10 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert3_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay11 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert1_dout_net_x6),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay12 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay8_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay13 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay12_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay14 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert2_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay15 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert2_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay16 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay34_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay16_q_net_x3)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay17 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay16_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay17_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay2 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay1_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay2_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay3_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay1_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay6 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert_dout_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay7 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay5_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay8 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(delay7_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay9 (
    .ce(ce_1_sg_x27),
    .clk(clk_1_sg_x27),
    .d(convert3_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net_x0)
  );

  reorder1_module_7a6296d7aa  reorder1_7a6296d7aa (
    .addr(counter_op_net_x1),
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(mux1_y_net_x2),
    .in2(mux1_y_net_x3),
    .out1(delay_q_net_x6),
    .out2(delay1_q_net_x4)
  );

  reorder1_module_7a6296d7aa  reorder2_42361934be (
    .addr(counter_op_net_x1),
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(mux1_y_net_x4),
    .in2(mux1_y_net_x5),
    .out1(delay_q_net_x7),
    .out2(delay1_q_net_x5)
  );

  tdm_module_d4ee23f649  tdm1_53364c688e (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(delay15_q_net_x0),
    .in2(convert_dout_net_x0),
    .rst(delay16_q_net_x3),
    .out1(mux1_y_net_x3)
  );

  tdm_module_d4ee23f649  tdm2_75d13b88d2 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(delay9_q_net_x0),
    .in2(delay11_q_net_x0),
    .rst(delay16_q_net_x3),
    .out1(mux1_y_net_x4)
  );

  tdm_module_d4ee23f649  tdm3_b5507c25e0 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(delay10_q_net_x0),
    .in2(convert1_dout_net_x6),
    .rst(delay16_q_net_x3),
    .out1(mux1_y_net_x5)
  );

  tdm_module_d4ee23f649  tdm_d4ee23f649 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in1(delay14_q_net_x0),
    .in2(delay6_q_net_x0),
    .rst(delay16_q_net_x3),
    .out1(mux1_y_net_x2)
  );

  x0_013453762122151_module_ee73fab64c  x0_013453762122151_1_2ec56dd3b2 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub3_s_net_x1),
    .out_x0(convert1_dout_net_x1)
  );

  x0_013453762122151_module_ee73fab64c  x0_013453762122151_ee73fab64c (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub_s_net_x0),
    .out_x0(convert1_dout_net_x0)
  );

  x0_102575973038173_module_0cd5b13937  x0_102575973038173_0cd5b13937 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub1_s_net_x1),
    .out_x0(convert1_dout_net_x2)
  );

  x0_102575973038173_module_0cd5b13937  x0_102575973038173_1_dc4eb46459 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub5_s_net_x0),
    .out_x0(convert1_dout_net_x3)
  );

  x0_589129026142142_module_4ad800e375  x0_589129026142142_1_bfe5722bfd (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub7_s_net_x0),
    .out_x0(convert1_dout_net_x5)
  );

  x0_589129026142142_module_4ad800e375  x0_589129026142142_4ad800e375 (
    .ce_1(ce_1_sg_x27),
    .clk_1(clk_1_sg_x27),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert1_dout_net_x4)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF3 Filter"

module hbf3_filter_module_bbc5cff1b4 (
  ce_1,
  clk_1,
  xn,
  y1,
  y2
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [18:0] xn;
  output [15:0] y1;
  output [15:0] y2;

  wire [0:0] ce_1_sg_x41;
  wire [0:0] clk_1_sg_x41;
  wire [17:0] constant1_op_net;
  wire [17:0] constant2_op_net;
  wire [47:0] constant32_op_net;
  wire [17:0] constant33_op_net;
  wire [17:0] constant3_op_net;
  wire [17:0] constant4_op_net;
  wire [17:0] constant5_op_net;
  wire [17:0] constant6_op_net;
  wire [17:0] constant7_op_net;
  wire [17:0] constant8_op_net;
  wire [17:0] constant9_op_net;
  wire [24:0] convert10_dout_net;
  wire [17:0] convert11_dout_net;
  wire [24:0] convert12_dout_net;
  wire [17:0] convert13_dout_net;
  wire [24:0] convert14_dout_net;
  wire [24:0] convert15_dout_net;
  wire [17:0] convert16_dout_net;
  wire [17:0] convert17_dout_net;
  wire [17:0] convert18_dout_net;
  wire [17:0] convert19_dout_net;
  wire [24:0] convert1_dout_net;
  wire [24:0] convert20_dout_net;
  wire [17:0] convert21_dout_net;
  wire [24:0] convert2_dout_net;
  wire [15:0] convert3_dout_net_x0;
  wire [24:0] convert4_dout_net;
  wire [17:0] convert5_dout_net;
  wire [15:0] convert64_dout_net;
  wire [24:0] convert6_dout_net;
  wire [17:0] convert7_dout_net;
  wire [17:0] convert8_dout_net;
  wire [24:0] convert9_dout_net;
  wire [29:0] convert_dout_net;
  wire [18:0] delay13_q_net;
  wire [15:0] delay1_q_net_x0;
  wire [18:0] delay2_q_net;
  wire [18:0] delay3_q_net;
  wire [18:0] delay4_q_net;
  wire [18:0] delay_q_net;
  wire [29:0] dsp48e1_16_acout_net;
  wire [47:0] dsp48e1_16_pcout_net;
  wire [29:0] dsp48e1_17_acout_net;
  wire [47:0] dsp48e1_17_pcout_net;
  wire [29:0] dsp48e1_18_acout_net;
  wire [47:0] dsp48e1_18_pcout_net;
  wire [29:0] dsp48e1_19_acout_net;
  wire [47:0] dsp48e1_19_pcout_net;
  wire [47:0] dsp48e1_1_p_net;
  wire [29:0] dsp48e1_2_acout_net;
  wire [47:0] dsp48e1_2_pcout_net;
  wire [29:0] dsp48e1_4_acout_net;
  wire [47:0] dsp48e1_4_pcout_net;
  wire [29:0] dsp48e1_5_acout_net;
  wire [47:0] dsp48e1_5_pcout_net;
  wire [29:0] dsp48e1_6_acout_net;
  wire [47:0] dsp48e1_6_pcout_net;
  wire [29:0] dsp48e1_acout_net;
  wire [47:0] dsp48e1_pcout_net;
  wire [19:0] opmode1_op_net;
  wire [19:0] opmode_op_net;
  wire [17:0] reinterpret10_output_port_net;
  wire [18:0] reinterpret12_output_port_net;
  wire [17:0] reinterpret13_output_port_net;
  wire [18:0] reinterpret14_output_port_net;
  wire [17:0] reinterpret15_output_port_net;
  wire [18:0] reinterpret17_output_port_net;
  wire [18:0] reinterpret18_output_port_net;
  wire [18:0] reinterpret1_output_port_net;
  wire [17:0] reinterpret21_output_port_net;
  wire [18:0] reinterpret22_output_port_net;
  wire [17:0] reinterpret23_output_port_net;
  wire [18:0] reinterpret24_output_port_net;
  wire [17:0] reinterpret2_output_port_net;
  wire [17:0] reinterpret3_output_port_net;
  wire [17:0] reinterpret4_output_port_net;
  wire [18:0] reinterpret5_output_port_net;
  wire [18:0] reinterpret5_output_port_net_x1;
  wire [18:0] reinterpret6_output_port_net;
  wire [18:0] reinterpret7_output_port_net;
  wire [18:0] reinterpret8_output_port_net;
  wire [47:0] reinterpret96_output_port_net;
  wire [17:0] reinterpret9_output_port_net;
  wire [17:0] reinterpret_output_port_net;

  assign ce_1_sg_x41 = ce_1;
  assign clk_1_sg_x41 = clk_1;
  assign reinterpret5_output_port_net_x1 = xn;
  assign y1 = delay1_q_net_x0;
  assign y2 = convert3_dout_net_x0;


  constant_d02c6ca527  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_ccb8aa4d51  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  constant_bc660b1e56  constant3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant3_op_net)
  );

  constant_78b68b2393  constant32 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant32_op_net)
  );

  constant_9ed9b075a6  constant33 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant33_op_net)
  );

  constant_a3a888533e  constant4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant4_op_net)
  );

  constant_cb858d1f75  constant5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant5_op_net)
  );

  constant_bd1e327723  constant6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant6_op_net)
  );

  constant_2544d97e53  constant7 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant7_op_net)
  );

  constant_9f55c36ec5  constant8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant8_op_net)
  );

  constant_1807e2a2f1  constant9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant9_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret6_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret24_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert10 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret5_output_port_net),
    .en(1'b1),
    .dout(convert10_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert11 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert11_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert12 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret8_output_port_net),
    .en(1'b1),
    .dout(convert12_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert13 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret15_output_port_net),
    .en(1'b1),
    .dout(convert13_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert14 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret17_output_port_net),
    .en(1'b1),
    .dout(convert14_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert15 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret18_output_port_net),
    .en(1'b1),
    .dout(convert15_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert16 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert16_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert17 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret21_output_port_net),
    .en(1'b1),
    .dout(convert17_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert18 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret23_output_port_net),
    .en(1'b1),
    .dout(convert18_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert19 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert19_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert20 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret7_output_port_net),
    .en(1'b1),
    .dout(convert20_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert21 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret10_output_port_net),
    .en(1'b1),
    .dout(convert21_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert3 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(delay13_q_net),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret14_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret22_output_port_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(35),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert64 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret96_output_port_net),
    .en(1'b1),
    .dout(convert64_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret13_output_port_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .clr(1'b0),
    .din(reinterpret12_output_port_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(17),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(reinterpret5_output_port_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(convert64_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x0)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay13 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(delay3_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay2 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay3 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay4 (
    .ce(ce_1_sg_x41),
    .clk(clk_1_sg_x41),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(1),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1 (
    .a(convert_dout_net),
    .alumode(4'b0000),
    .b(convert5_dout_net),
    .c(constant32_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert1_dout_net),
    .en(1'b1),
    .op(opmode_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_acout_net),
    .pcout(dsp48e1_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_1 (
    .acin(dsp48e1_2_acout_net),
    .alumode(4'b0000),
    .b(convert19_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert2_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_2_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_1_p_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_16 (
    .acin(dsp48e1_6_acout_net),
    .alumode(4'b0000),
    .b(convert13_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert12_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_6_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_16_acout_net),
    .pcout(dsp48e1_16_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_17 (
    .acin(dsp48e1_18_acout_net),
    .alumode(4'b0000),
    .b(convert17_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert14_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_18_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_17_acout_net),
    .pcout(dsp48e1_17_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_18 (
    .acin(dsp48e1_16_acout_net),
    .alumode(4'b0000),
    .b(convert16_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert6_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_16_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_18_acout_net),
    .pcout(dsp48e1_18_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_19 (
    .acin(dsp48e1_17_acout_net),
    .alumode(4'b0000),
    .b(convert18_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert15_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_17_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_19_acout_net),
    .pcout(dsp48e1_19_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_2 (
    .acin(dsp48e1_19_acout_net),
    .alumode(4'b0000),
    .b(convert21_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert20_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_19_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_2_acout_net),
    .pcout(dsp48e1_2_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(1),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .acin(dsp48e1_acout_net),
    .alumode(4'b0000),
    .b(convert7_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert9_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_4_acout_net),
    .pcout(dsp48e1_4_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_5 (
    .acin(dsp48e1_4_acout_net),
    .alumode(4'b0000),
    .b(convert8_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert10_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_4_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_5_acout_net),
    .pcout(dsp48e1_5_pcout_net)
  );

  xldsp48e1 #(

    .a_input("CASCADE"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(0),
    .c_use_acin(1),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_6 (
    .acin(dsp48e1_5_acout_net),
    .alumode(4'b0000),
    .b(convert11_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x41),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x41),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_5_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .acout(dsp48e1_6_acout_net),
    .pcout(dsp48e1_6_pcout_net)
  );

  opmode_de16be0052  opmode (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode_op_net)
  );

  opmode_96dace4a09  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_0e0c011a4e  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant33_op_net),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay3_q_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant9_op_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret12 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net),
    .output_port(reinterpret12_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret13 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant3_op_net),
    .output_port(reinterpret13_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret14 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay4_q_net),
    .output_port(reinterpret14_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret15 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant5_op_net),
    .output_port(reinterpret15_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret17 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay3_q_net),
    .output_port(reinterpret17_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret18 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay3_q_net),
    .output_port(reinterpret18_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant1_op_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret21 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant7_op_net),
    .output_port(reinterpret21_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret22 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay4_q_net),
    .output_port(reinterpret22_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret23 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant8_op_net),
    .output_port(reinterpret23_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret24 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net),
    .output_port(reinterpret24_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant4_op_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant2_op_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(reinterpret5_output_port_net_x1),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret7 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay3_q_net),
    .output_port(reinterpret7_output_port_net)
  );

  reinterpret_f67f49dab9  reinterpret8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay4_q_net),
    .output_port(reinterpret8_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant6_op_net),
    .output_port(reinterpret9_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret96 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_1_p_net),
    .output_port(reinterpret96_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF4 Filter/coef1_1"

module coef1_1_module_2d3e4c1d9b (
  a,
  ce_1,
  clk_1,
  d,
  pcout
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  output [47:0] pcout;

  wire [0:0] ce_1_sg_x47;
  wire [0:0] clk_1_sg_x47;
  wire [47:0] constant1_op_net;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay1_q_net_x1;
  wire [15:0] delay5_q_net_x0;
  wire [47:0] dsp48e1_4_pcout_net_x0;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay1_q_net_x1 = a;
  assign ce_1_sg_x47 = ce_1;
  assign clk_1_sg_x47 = clk_1;
  assign delay5_q_net_x0 = d;
  assign pcout = dsp48e1_4_pcout_net_x0;


  constant_ca7488d888  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_998c05c36c  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x47),
    .clk(clk_1_sg_x47),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x47),
    .clk(clk_1_sg_x47),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x47),
    .clk(clk_1_sg_x47),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .c(constant1_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x47),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x47),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .pcout(dsp48e1_4_pcout_net_x0)
  );

  opmode_6481474c6d  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net_x1),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay5_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF4 Filter/coef3_1"

module coef3_1_module_3dc424542e (
  a,
  ce_1,
  clk_1,
  d,
  pcin,
  pcout
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  input [47:0] pcin;
  output [47:0] pcout;

  wire [0:0] ce_1_sg_x49;
  wire [0:0] clk_1_sg_x49;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay8_q_net_x0;
  wire [15:0] delay9_q_net_x0;
  wire [47:0] dsp48e1_4_pcout_net_x1;
  wire [47:0] dsp48e1_4_pcout_net_x2;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay8_q_net_x0 = a;
  assign ce_1_sg_x49 = ce_1;
  assign clk_1_sg_x49 = clk_1;
  assign delay9_q_net_x0 = d;
  assign dsp48e1_4_pcout_net_x1 = pcin;
  assign pcout = dsp48e1_4_pcout_net_x2;


  constant_23baa7aa71  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x49),
    .clk(clk_1_sg_x49),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x49),
    .clk(clk_1_sg_x49),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x49),
    .clk(clk_1_sg_x49),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x49),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x49),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_4_pcout_net_x1),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .pcout(dsp48e1_4_pcout_net_x2)
  );

  opmode_77dfa9804f  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay8_q_net_x0),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay9_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF4 Filter/coef3_2"

module coef3_2_module_55d714494c (
  a,
  ce_1,
  clk_1,
  d,
  out_x0,
  pcin
);

  input [15:0] a;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] d;
  input [47:0] pcin;
  output [15:0] out_x0;

  wire [0:0] ce_1_sg_x50;
  wire [0:0] clk_1_sg_x50;
  wire [17:0] constant_op_net;
  wire [17:0] convert1_dout_net;
  wire [24:0] convert2_dout_net;
  wire [15:0] convert3_dout_net_x0;
  wire [24:0] convert4_dout_net;
  wire [29:0] convert5_dout_net;
  wire [15:0] delay10_q_net_x0;
  wire [15:0] delay11_q_net_x0;
  wire [47:0] dsp48e1_4_p_net;
  wire [47:0] dsp48e1_4_pcout_net_x3;
  wire [19:0] opmode1_op_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [47:0] reinterpret2_output_port_net;
  wire [15:0] reinterpret3_output_port_net;
  wire [15:0] reinterpret_output_port_net;

  assign delay10_q_net_x0 = a;
  assign ce_1_sg_x50 = ce_1;
  assign clk_1_sg_x50 = clk_1;
  assign delay11_q_net_x0 = d;
  assign out_x0 = convert3_dout_net_x0;
  assign dsp48e1_4_pcout_net_x3 = pcin;


  constant_41c9a265eb  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(1'b1),
    .clk(1'b1),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x50),
    .clk(clk_1_sg_x50),
    .clr(1'b0),
    .din(reinterpret_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x50),
    .clk(clk_1_sg_x50),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(25),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x50),
    .clk(clk_1_sg_x50),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(25),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x50),
    .clk(clk_1_sg_x50),
    .clr(1'b0),
    .din(convert2_dout_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(1),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert5_dout_net),
    .alumode(4'b0000),
    .b(convert1_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x50),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x50),
    .d(convert4_dout_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_4_pcout_net_x3),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  opmode_77dfa9804f  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_81b71e1f8b  reinterpret (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay10_q_net_x0),
    .output_port(reinterpret_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(constant_op_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay11_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/HBF4 Filter"

module hbf4_filter_module_40c93c6ad9 (
  ce_1,
  clk_1,
  x1,
  x2,
  y1,
  y2,
  y3,
  y4
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] x1;
  input [15:0] x2;
  output [15:0] y1;
  output [15:0] y2;
  output [15:0] y3;
  output [15:0] y4;

  wire [0:0] ce_1_sg_x53;
  wire [0:0] clk_1_sg_x53;
  wire [15:0] convert3_dout_net_x0;
  wire [15:0] convert3_dout_net_x2;
  wire [15:0] convert3_dout_net_x3;
  wire [15:0] delay10_q_net_x0;
  wire [15:0] delay11_q_net_x0;
  wire [15:0] delay12_q_net_x0;
  wire [15:0] delay13_q_net_x0;
  wire [15:0] delay14_q_net_x0;
  wire [15:0] delay15_q_net_x0;
  wire [15:0] delay16_q_net_x0;
  wire [15:0] delay1_q_net_x0;
  wire [15:0] delay1_q_net_x2;
  wire [15:0] delay2_q_net;
  wire [15:0] delay3_q_net_x0;
  wire [15:0] delay4_q_net;
  wire [15:0] delay5_q_net_x0;
  wire [15:0] delay6_q_net_x0;
  wire [15:0] delay7_q_net_x0;
  wire [15:0] delay8_q_net_x0;
  wire [15:0] delay9_q_net_x0;
  wire [15:0] delay_q_net;
  wire [47:0] dsp48e1_4_pcout_net_x1;
  wire [47:0] dsp48e1_4_pcout_net_x2;
  wire [47:0] dsp48e1_4_pcout_net_x3;
  wire [47:0] dsp48e1_4_pcout_net_x4;

  assign ce_1_sg_x53 = ce_1;
  assign clk_1_sg_x53 = clk_1;
  assign delay1_q_net_x2 = x1;
  assign convert3_dout_net_x3 = x2;
  assign y1 = delay7_q_net_x0;
  assign y2 = delay3_q_net_x0;
  assign y3 = delay16_q_net_x0;
  assign y4 = delay15_q_net_x0;


  coef1_1_module_2d3e4c1d9b  coef1_1_2d3e4c1d9b (
    .a(delay1_q_net_x2),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay5_q_net_x0),
    .pcout(dsp48e1_4_pcout_net_x1)
  );

  coef1_1_module_2d3e4c1d9b  coef1_2_02a8fae733 (
    .a(convert3_dout_net_x3),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay1_q_net_x0),
    .pcout(dsp48e1_4_pcout_net_x2)
  );

  coef3_1_module_3dc424542e  coef3_1_3dc424542e (
    .a(delay8_q_net_x0),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay9_q_net_x0),
    .pcin(dsp48e1_4_pcout_net_x1),
    .pcout(dsp48e1_4_pcout_net_x3)
  );

  coef3_2_module_55d714494c  coef3_2_55d714494c (
    .a(delay10_q_net_x0),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay11_q_net_x0),
    .pcin(dsp48e1_4_pcout_net_x3),
    .out_x0(convert3_dout_net_x0)
  );

  coef3_1_module_3dc424542e  coef3_3_53ceda67d9 (
    .a(delay6_q_net_x0),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay12_q_net_x0),
    .pcin(dsp48e1_4_pcout_net_x2),
    .pcout(dsp48e1_4_pcout_net_x4)
  );

  coef3_2_module_55d714494c  coef3_4_6258555681 (
    .a(delay13_q_net_x0),
    .ce_1(ce_1_sg_x53),
    .clk_1(clk_1_sg_x53),
    .d(delay14_q_net_x0),
    .pcin(dsp48e1_4_pcout_net_x4),
    .out_x0(convert3_dout_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay1_q_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay10 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay11 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay4_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay12 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay4_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay13 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay2_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay14 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x0)
  );

  xldelay #(

    .latency(7),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay15 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay2_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay16 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(convert3_dout_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay16_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay2 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(convert3_dout_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(7),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay2_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay4_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay6 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay1_q_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay7 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(convert3_dout_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay8 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay2_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay9 (
    .ce(ce_1_sg_x53),
    .clk(clk_1_sg_x53),
    .d(delay1_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I0_calc"

module i0_calc_module_a2c44e32af (
  ce_1,
  clk_1,
  i,
  out1,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out1;

  wire [15:0] addsub1_s_net_x0;
  wire [0:0] ce_1_sg_x89;
  wire [0:0] clk_1_sg_x89;
  wire [15:0] constant1_op_net;
  wire [1:0] counter2_op_net_x0;
  wire [1:0] delay1_q_net;
  wire [15:0] delay24_q_net_x0;
  wire [15:0] delay28_q_net_x0;
  wire [0:0] delay_q_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux_y_net;

  assign ce_1_sg_x89 = ce_1;
  assign clk_1_sg_x89 = clk_1;
  assign delay24_q_net_x0 = i;
  assign out1 = addsub1_s_net_x0;
  assign delay28_q_net_x0 = q;
  assign counter2_op_net_x0 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(4),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(5),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(constant1_op_net),
    .b(mux_y_net),
    .ce(ce_1_sg_x89),
    .clk(clk_1_sg_x89),
    .clr(1'b0),
    .en(1'b1),
    .mode(delay_q_net),
    .s(addsub1_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay (
    .ce(ce_1_sg_x89),
    .clk(clk_1_sg_x89),
    .d(msb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x89),
    .clk(clk_1_sg_x89),
    .d(counter2_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_a6eee4b271  mux (
    .ce(ce_1_sg_x89),
    .clk(clk_1_sg_x89),
    .clr(1'b0),
    .d0(delay24_q_net_x0),
    .d1(delay28_q_net_x0),
    .d2(delay24_q_net_x0),
    .d3(delay28_q_net_x0),
    .sel(delay1_q_net),
    .y(mux_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I1_calc/sin(2*pi*3/16)"

module x16_module_681a9d9f15 (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in_x0;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub2_s_net;
  wire [15:0] addsub3_s_net;
  wire [15:0] addsub4_s_net_x0;
  wire [15:0] addsub5_s_net;
  wire [0:0] ce_1_sg_x90;
  wire [0:0] clk_1_sg_x90;
  wire [15:0] mux3_y_net_x0;
  wire [15:0] shift1_op_net;
  wire [15:0] shift2_op_net;
  wire [15:0] shift3_op_net;
  wire [15:0] shift4_op_net;
  wire [15:0] shift5_op_net;
  wire [15:0] shift6_op_net;
  wire [15:0] shift_op_net;

  assign ce_1_sg_x90 = ce_1;
  assign clk_1_sg_x90 = clk_1;
  assign mux3_y_net_x0 = in_x0;
  assign out_x0 = addsub4_s_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(shift_op_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub2 (
    .a(shift2_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_1ae7fcb63c340449"),
    .extra_registers(1),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(2),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(mux3_y_net_x0),
    .b(shift5_op_net),
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub4 (
    .a(shift6_op_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub5 (
    .a(shift4_op_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  shift_12819d6cbe  shift (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(mux3_y_net_x0),
    .op(shift_op_net)
  );

  shift_4108be98c5  shift1 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(mux3_y_net_x0),
    .op(shift1_op_net)
  );

  shift_5447e0aa7e  shift2 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(addsub5_s_net),
    .op(shift2_op_net)
  );

  shift_4108be98c5  shift3 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(mux3_y_net_x0),
    .op(shift3_op_net)
  );

  shift_a05534ab8e  shift4 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(mux3_y_net_x0),
    .op(shift4_op_net)
  );

  shift_1aa26d2e4f  shift5 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(mux3_y_net_x0),
    .op(shift5_op_net)
  );

  shift_5447e0aa7e  shift6 (
    .ce(ce_1_sg_x90),
    .clk(clk_1_sg_x90),
    .clr(1'b0),
    .ip(addsub2_s_net),
    .op(shift6_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I1_calc/sin(2*pi/16)"

module x16_module_c081224c5f (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in_x0;
  output [15:0] out_x0;

  wire [19:0] addsub1_s_net;
  wire [19:0] addsub2_s_net;
  wire [19:0] addsub_s_net;
  wire [0:0] ce_1_sg_x91;
  wire [0:0] clk_1_sg_x91;
  wire [15:0] convert1_dout_net_x0;
  wire [19:0] convert_dout_net;
  wire [15:0] mux2_y_net_x0;
  wire [19:0] shift1_op_net;
  wire [19:0] shift2_op_net;
  wire [19:0] shift3_op_net;
  wire [19:0] shift4_op_net;
  wire [19:0] shift6_op_net;
  wire [19:0] shift_op_net;

  assign ce_1_sg_x91 = ce_1;
  assign clk_1_sg_x91 = clk_1;
  assign mux2_y_net_x0 = in_x0;
  assign out_x0 = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub (
    .a(shift1_op_net),
    .b(shift_op_net),
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_c70c61eff7bb7aeb"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub1 (
    .a(shift3_op_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub2 (
    .a(shift6_op_net),
    .b(shift4_op_net),
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(19),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .din(mux2_y_net_x0),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert1 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  shift_997986a690  shift (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift_op_net)
  );

  shift_7d97a52cb7  shift1 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift1_op_net)
  );

  shift_9f4e80fae7  shift2 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift2_op_net)
  );

  shift_7d97a52cb7  shift3 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift3_op_net)
  );

  shift_c6a2804ac2  shift4 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(addsub1_s_net),
    .op(shift4_op_net)
  );

  shift_7d97a52cb7  shift6 (
    .ce(ce_1_sg_x91),
    .clk(clk_1_sg_x91),
    .clr(1'b0),
    .ip(addsub_s_net),
    .op(shift6_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I1_calc"

module i1_calc_module_f51c2984a1 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x92;
  wire [0:0] clk_1_sg_x92;
  wire [15:0] constant1_op_net;
  wire [0:0] convert1_dout_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter2_op_net_x1;
  wire [1:0] delay1_q_net;
  wire [15:0] delay25_q_net_x0;
  wire [15:0] delay29_q_net_x0;
  wire [0:0] delay2_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x92 = ce_1;
  assign clk_1_sg_x92 = clk_1;
  assign delay25_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay29_q_net_x0 = q;
  assign counter2_op_net_x1 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(convert1_dout_net_x0),
    .b(addsub4_s_net_x0),
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert1_dout_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .din(inverter_op_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .din(delay2_q_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .d(counter2_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(5),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay2 (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .d(msb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  inverter_48d1f6b088  inverter (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .ip(lsb_y_net),
    .op(inverter_op_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .d0(delay25_q_net_x0),
    .d1(delay29_q_net_x0),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x92),
    .clk(clk_1_sg_x92),
    .clr(1'b0),
    .d0(delay29_q_net_x0),
    .d1(delay25_q_net_x0),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_681a9d9f15  x16_681a9d9f15 (
    .ce_1(ce_1_sg_x92),
    .clk_1(clk_1_sg_x92),
    .in_x0(mux3_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );

  x16_module_c081224c5f  x16_c081224c5f (
    .ce_1(ce_1_sg_x92),
    .clk_1(clk_1_sg_x92),
    .in_x0(mux2_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I2_calc/cos(2*pi*2/16)"

module x16_module_365070a8a8 (
  ce_1,
  clk_1,
  in_x0,
  out_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [16:0] in_x0;
  output [15:0] out_x0;

  wire [19:0] addsub1_s_net;
  wire [19:0] addsub2_s_net_x0;
  wire [16:0] addsub2_s_net_x1;
  wire [19:0] addsub3_s_net;
  wire [19:0] addsub4_s_net;
  wire [19:0] addsub5_s_net;
  wire [0:0] ce_1_sg_x93;
  wire [0:0] clk_1_sg_x93;
  wire [15:0] convert1_dout_net_x0;
  wire [19:0] convert_dout_net;
  wire [19:0] shift1_op_net;
  wire [19:0] shift2_op_net;
  wire [19:0] shift3_op_net;
  wire [19:0] shift4_op_net;
  wire [19:0] shift5_op_net;
  wire [19:0] shift6_op_net;
  wire [19:0] shift8_op_net;
  wire [19:0] shift_op_net;

  assign ce_1_sg_x93 = ce_1;
  assign clk_1_sg_x93 = clk_1;
  assign addsub2_s_net_x1 = in_x0;
  assign out_x0 = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub1 (
    .a(shift4_op_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub2 (
    .a(shift6_op_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub3 (
    .a(shift_op_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(19),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(19),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub4 (
    .a(shift8_op_net),
    .b(addsub5_s_net),
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(20),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(20),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(21),
    .core_name0("addsb_11_0_750c6c8a22bc78ba"),
    .extra_registers(1),
    .full_s_arith(2),
    .full_s_width(21),
    .latency(2),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(19),
    .s_width(20))
  addsub5 (
    .a(shift2_op_net),
    .b(shift5_op_net),
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(20),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .din(addsub2_s_net_x1),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(19),
    .din_width(20),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert1 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .din(addsub4_s_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  shift_0b767c7711  shift (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift_op_net)
  );

  shift_7d97a52cb7  shift1 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift1_op_net)
  );

  shift_0b767c7711  shift2 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift2_op_net)
  );

  shift_7d97a52cb7  shift3 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift3_op_net)
  );

  shift_18b87c12cf  shift4 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift4_op_net)
  );

  shift_7d97a52cb7  shift5 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift5_op_net)
  );

  shift_2422c3ab70  shift6 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(addsub1_s_net),
    .op(shift6_op_net)
  );

  shift_69971e276f  shift8 (
    .ce(ce_1_sg_x93),
    .clk(clk_1_sg_x93),
    .clr(1'b0),
    .ip(addsub2_s_net_x0),
    .op(shift8_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I2_calc"

module i2_calc_module_5456b0a482 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [16:0] addsub2_s_net_x1;
  wire [15:0] addsub3_s_net_x0;
  wire [0:0] ce_1_sg_x94;
  wire [0:0] clk_1_sg_x94;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [1:0] counter2_op_net_x2;
  wire [1:0] delay1_q_net;
  wire [15:0] delay26_q_net_x0;
  wire [15:0] delay30_q_net_x0;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;

  assign ce_1_sg_x94 = ce_1;
  assign clk_1_sg_x94 = clk_1;
  assign delay26_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay30_q_net_x0 = q;
  assign counter2_op_net_x2 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub2 (
    .a(delay26_q_net_x0),
    .b(delay30_q_net_x0),
    .ce(ce_1_sg_x94),
    .clk(clk_1_sg_x94),
    .clr(1'b0),
    .en(1'b1),
    .mode(lsb_y_net),
    .s(addsub2_s_net_x1)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x94),
    .clk(clk_1_sg_x94),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x94),
    .clk(clk_1_sg_x94),
    .d(counter2_op_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  logical_06844c65fb  logical (
    .ce(ce_1_sg_x94),
    .clk(clk_1_sg_x94),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  x16_module_365070a8a8  x16_365070a8a8 (
    .ce_1(ce_1_sg_x94),
    .clk_1(clk_1_sg_x94),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/I3_calc"

module i3_calc_module_649a65238e (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x97;
  wire [0:0] clk_1_sg_x97;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter2_op_net_x3;
  wire [1:0] delay1_q_net;
  wire [15:0] delay27_q_net_x0;
  wire [15:0] delay31_q_net_x0;
  wire [0:0] inverter1_op_net;
  wire [0:0] inverter_op_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x97 = ce_1;
  assign clk_1_sg_x97 = clk_1;
  assign delay27_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay31_q_net_x0 = q;
  assign counter2_op_net_x3 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(addsub4_s_net_x0),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .en(1'b1),
    .mode(inverter1_op_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .din(inverter_op_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .d(counter2_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_48d1f6b088  inverter (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .ip(lsb_y_net),
    .op(inverter_op_net)
  );

  inverter_66c3795ede  inverter1 (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .ip(msb_y_net),
    .op(inverter1_op_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .d0(delay27_q_net_x0),
    .d1(delay31_q_net_x0),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x97),
    .clk(clk_1_sg_x97),
    .clr(1'b0),
    .d0(delay31_q_net_x0),
    .d1(delay27_q_net_x0),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_681a9d9f15  x16_1404caed42 (
    .ce_1(ce_1_sg_x97),
    .clk_1(clk_1_sg_x97),
    .in_x0(mux2_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );

  x16_module_c081224c5f  x16_fd68391f97 (
    .ce_1(ce_1_sg_x97),
    .clk_1(clk_1_sg_x97),
    .in_x0(mux3_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/Q0_calc"

module q0_calc_module_1270d7fd6f (
  ce_1,
  clk_1,
  i,
  out1,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out1;

  wire [15:0] addsub1_s_net_x0;
  wire [0:0] ce_1_sg_x98;
  wire [0:0] clk_1_sg_x98;
  wire [15:0] constant1_op_net;
  wire [1:0] counter1_op_net_x0;
  wire [1:0] delay1_q_net;
  wire [15:0] delay24_q_net_x1;
  wire [15:0] delay28_q_net_x1;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux_y_net;

  assign ce_1_sg_x98 = ce_1;
  assign clk_1_sg_x98 = clk_1;
  assign delay24_q_net_x1 = i;
  assign out1 = addsub1_s_net_x0;
  assign delay28_q_net_x1 = q;
  assign counter1_op_net_x0 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(4),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(5),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(constant1_op_net),
    .b(mux_y_net),
    .ce(ce_1_sg_x98),
    .clk(clk_1_sg_x98),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub1_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x98),
    .clk(clk_1_sg_x98),
    .d(counter1_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  logical_8641388092  logical (
    .ce(ce_1_sg_x98),
    .clk(clk_1_sg_x98),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_a6eee4b271  mux (
    .ce(ce_1_sg_x98),
    .clk(clk_1_sg_x98),
    .clr(1'b0),
    .d0(delay28_q_net_x1),
    .d1(delay24_q_net_x1),
    .d2(delay28_q_net_x1),
    .d3(delay24_q_net_x1),
    .sel(delay1_q_net),
    .y(mux_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/Q1_calc"

module q1_calc_module_db65938a6d (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x101;
  wire [0:0] clk_1_sg_x101;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [1:0] counter1_op_net_x1;
  wire [1:0] delay1_q_net;
  wire [15:0] delay25_q_net_x1;
  wire [15:0] delay29_q_net_x1;
  wire [0:0] delay2_q_net;
  wire [0:0] delay_q_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x101 = ce_1;
  assign clk_1_sg_x101 = clk_1;
  assign delay25_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay29_q_net_x1 = q;
  assign counter1_op_net_x1 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(addsub4_s_net_x0),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .clr(1'b0),
    .en(1'b1),
    .mode(delay_q_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .clr(1'b0),
    .en(1'b1),
    .mode(delay2_q_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay (
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .d(lsb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .d(counter1_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(5),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay2 (
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .d(msb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .clr(1'b0),
    .d0(delay25_q_net_x1),
    .d1(delay29_q_net_x1),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x101),
    .clk(clk_1_sg_x101),
    .clr(1'b0),
    .d0(delay29_q_net_x1),
    .d1(delay25_q_net_x1),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_c081224c5f  x16_0a3b1f6c6a (
    .ce_1(ce_1_sg_x101),
    .clk_1(clk_1_sg_x101),
    .in_x0(mux3_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );

  x16_module_681a9d9f15  x16_f1fdee6d25 (
    .ce_1(ce_1_sg_x101),
    .clk_1(clk_1_sg_x101),
    .in_x0(mux2_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/Q2_calc"

module q2_calc_module_b8fd2bc030 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [16:0] addsub2_s_net_x1;
  wire [15:0] addsub3_s_net_x0;
  wire [0:0] ce_1_sg_x103;
  wire [0:0] clk_1_sg_x103;
  wire [15:0] constant1_op_net;
  wire [0:0] convert1_dout_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter1_op_net_x2;
  wire [1:0] delay1_q_net;
  wire [15:0] delay26_q_net_x1;
  wire [15:0] delay30_q_net_x1;
  wire [0:0] delay_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;

  assign ce_1_sg_x103 = ce_1;
  assign clk_1_sg_x103 = clk_1;
  assign delay26_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay30_q_net_x1 = q;
  assign counter1_op_net_x2 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub2 (
    .a(delay26_q_net_x1),
    .b(delay30_q_net_x1),
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert1_dout_net),
    .s(addsub2_s_net_x1)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .clr(1'b0),
    .din(delay_q_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .clr(1'b0),
    .din(inverter_op_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xldelay #(

    .latency(5),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay (
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .d(msb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .d(counter1_op_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_33a63b558a  inverter (
    .ce(ce_1_sg_x103),
    .clk(clk_1_sg_x103),
    .clr(1'b0),
    .ip(lsb_y_net),
    .op(inverter_op_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  x16_module_365070a8a8  x16_6f9b371588 (
    .ce_1(ce_1_sg_x103),
    .clk_1(clk_1_sg_x103),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3/Q3_calc"

module q3_calc_module_32a39245d1 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x106;
  wire [0:0] clk_1_sg_x106;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter1_op_net_x3;
  wire [1:0] delay1_q_net;
  wire [15:0] delay27_q_net_x1;
  wire [15:0] delay31_q_net_x1;
  wire [0:0] delay_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x106 = ce_1;
  assign clk_1_sg_x106 = clk_1;
  assign delay27_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay31_q_net_x1 = q;
  assign counter1_op_net_x3 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(convert1_dout_net_x0),
    .b(addsub4_s_net_x0),
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .en(1'b1),
    .mode(delay_q_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .en(1'b1),
    .mode(inverter_op_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .din(lsb_y_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .d(convert_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .d(counter1_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_66c3795ede  inverter (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .ip(msb_y_net),
    .op(inverter_op_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .d0(delay27_q_net_x1),
    .d1(delay31_q_net_x1),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x106),
    .clk(clk_1_sg_x106),
    .clr(1'b0),
    .d0(delay31_q_net_x1),
    .d1(delay27_q_net_x1),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_c081224c5f  x16_d58306cfb6 (
    .ce_1(ce_1_sg_x106),
    .clk_1(clk_1_sg_x106),
    .in_x0(mux2_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );

  x16_module_681a9d9f15  x16_ef42a64175 (
    .ce_1(ce_1_sg_x106),
    .clk_1(clk_1_sg_x106),
    .in_x0(mux3_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_band3"

module mixer1536_band3_module_8c4b7efa2b (
  ce_1,
  clk_1,
  i0,
  i0_out,
  i1,
  i1_out,
  i2,
  i2_out,
  i3,
  i3_out,
  q0,
  q0_out,
  q1,
  q1_out,
  q2,
  q2_out,
  q3,
  q3_out
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i0;
  input [15:0] i1;
  input [15:0] i2;
  input [15:0] i3;
  input [15:0] q0;
  input [15:0] q1;
  input [15:0] q2;
  input [15:0] q3;
  output [15:0] i0_out;
  output [15:0] i1_out;
  output [15:0] i2_out;
  output [15:0] i3_out;
  output [15:0] q0_out;
  output [15:0] q1_out;
  output [15:0] q2_out;
  output [15:0] q3_out;

  wire [15:0] addsub1_s_net_x2;
  wire [15:0] addsub1_s_net_x3;
  wire [15:0] addsub3_s_net_x10;
  wire [15:0] addsub3_s_net_x11;
  wire [15:0] addsub3_s_net_x6;
  wire [15:0] addsub3_s_net_x7;
  wire [15:0] addsub3_s_net_x8;
  wire [15:0] addsub3_s_net_x9;
  wire [0:0] ce_1_sg_x107;
  wire [0:0] clk_1_sg_x107;
  wire [1:0] counter1_op_net_x3;
  wire [1:0] counter2_op_net_x3;
  wire [15:0] delay24_q_net_x2;
  wire [15:0] delay25_q_net_x2;
  wire [15:0] delay26_q_net_x2;
  wire [15:0] delay27_q_net_x2;
  wire [15:0] delay28_q_net_x2;
  wire [15:0] delay29_q_net_x2;
  wire [15:0] delay30_q_net_x2;
  wire [15:0] delay31_q_net_x2;

  assign ce_1_sg_x107 = ce_1;
  assign clk_1_sg_x107 = clk_1;
  assign delay24_q_net_x2 = i0;
  assign i0_out = addsub1_s_net_x2;
  assign delay25_q_net_x2 = i1;
  assign i1_out = addsub3_s_net_x6;
  assign delay26_q_net_x2 = i2;
  assign i2_out = addsub3_s_net_x7;
  assign delay27_q_net_x2 = i3;
  assign i3_out = addsub3_s_net_x8;
  assign delay28_q_net_x2 = q0;
  assign q0_out = addsub1_s_net_x3;
  assign delay29_q_net_x2 = q1;
  assign q1_out = addsub3_s_net_x9;
  assign delay30_q_net_x2 = q2;
  assign q2_out = addsub3_s_net_x10;
  assign delay31_q_net_x2 = q3;
  assign q3_out = addsub3_s_net_x11;


  xlcounter_free_duc_16ch_341 #(

    .core_name0("cntr_11_0_76451075d188e63f"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter1 (
    .ce(ce_1_sg_x107),
    .clk(clk_1_sg_x107),
    .clr(1'b0),
    .en(1'b1),
    .rst(1'b0),
    .op(counter1_op_net_x3)
  );

  xlcounter_free_duc_16ch_341 #(

    .core_name0("cntr_11_0_76451075d188e63f"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter2 (
    .ce(ce_1_sg_x107),
    .clk(clk_1_sg_x107),
    .clr(1'b0),
    .en(1'b1),
    .rst(1'b0),
    .op(counter2_op_net_x3)
  );

  i0_calc_module_a2c44e32af  i0_calc_a2c44e32af (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay24_q_net_x2),
    .q(delay28_q_net_x2),
    .sel(counter2_op_net_x3),
    .out1(addsub1_s_net_x2)
  );

  i1_calc_module_f51c2984a1  i1_calc_f51c2984a1 (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay25_q_net_x2),
    .q(delay29_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x6)
  );

  i2_calc_module_5456b0a482  i2_calc_5456b0a482 (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay26_q_net_x2),
    .q(delay30_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x7)
  );

  i3_calc_module_649a65238e  i3_calc_649a65238e (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay27_q_net_x2),
    .q(delay31_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x8)
  );

  q0_calc_module_1270d7fd6f  q0_calc_1270d7fd6f (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay24_q_net_x2),
    .q(delay28_q_net_x2),
    .sel(counter1_op_net_x3),
    .out1(addsub1_s_net_x3)
  );

  q1_calc_module_db65938a6d  q1_calc_db65938a6d (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay25_q_net_x2),
    .q(delay29_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x9)
  );

  q2_calc_module_b8fd2bc030  q2_calc_b8fd2bc030 (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay26_q_net_x2),
    .q(delay30_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x10)
  );

  q3_calc_module_32a39245d1  q3_calc_32a39245d1 (
    .ce_1(ce_1_sg_x107),
    .clk_1(clk_1_sg_x107),
    .i(delay27_q_net_x2),
    .q(delay31_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x11)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/I0_calc"

module i0_calc_module_ffcbd4a114 (
  ce_1,
  clk_1,
  i,
  out1,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out1;

  wire [15:0] addsub1_s_net_x0;
  wire [0:0] ce_1_sg_x108;
  wire [0:0] clk_1_sg_x108;
  wire [15:0] constant1_op_net;
  wire [1:0] counter2_op_net_x0;
  wire [15:0] delay12_q_net_x0;
  wire [1:0] delay1_q_net;
  wire [15:0] delay8_q_net_x0;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux_y_net;

  assign ce_1_sg_x108 = ce_1;
  assign clk_1_sg_x108 = clk_1;
  assign delay8_q_net_x0 = i;
  assign out1 = addsub1_s_net_x0;
  assign delay12_q_net_x0 = q;
  assign counter2_op_net_x0 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(4),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(5),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(constant1_op_net),
    .b(mux_y_net),
    .ce(ce_1_sg_x108),
    .clk(clk_1_sg_x108),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub1_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x108),
    .clk(clk_1_sg_x108),
    .d(counter2_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  logical_8641388092  logical (
    .ce(ce_1_sg_x108),
    .clk(clk_1_sg_x108),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_a6eee4b271  mux (
    .ce(ce_1_sg_x108),
    .clk(clk_1_sg_x108),
    .clr(1'b0),
    .d0(delay8_q_net_x0),
    .d1(delay12_q_net_x0),
    .d2(delay8_q_net_x0),
    .d3(delay12_q_net_x0),
    .sel(delay1_q_net),
    .y(mux_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/I1_calc"

module i1_calc_module_79974815da (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x111;
  wire [0:0] clk_1_sg_x111;
  wire [15:0] constant1_op_net;
  wire [0:0] convert1_dout_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter2_op_net_x1;
  wire [15:0] delay13_q_net_x0;
  wire [1:0] delay1_q_net;
  wire [0:0] delay3_q_net;
  wire [15:0] delay9_q_net_x0;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x111 = ce_1;
  assign clk_1_sg_x111 = clk_1;
  assign delay9_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay13_q_net_x0 = q;
  assign counter2_op_net_x1 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(convert1_dout_net_x0),
    .b(addsub4_s_net_x0),
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert1_dout_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .din(delay3_q_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .din(logical_y_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .d(counter2_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay3 (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .d(lsb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  logical_d5c14b9908  logical (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .d0(delay9_q_net_x0),
    .d1(delay13_q_net_x0),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x111),
    .clk(clk_1_sg_x111),
    .clr(1'b0),
    .d0(delay13_q_net_x0),
    .d1(delay9_q_net_x0),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_681a9d9f15  x16_9899f4440d (
    .ce_1(ce_1_sg_x111),
    .clk_1(clk_1_sg_x111),
    .in_x0(mux3_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );

  x16_module_c081224c5f  x16_c2a953ad65 (
    .ce_1(ce_1_sg_x111),
    .clk_1(clk_1_sg_x111),
    .in_x0(mux2_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/I2_calc"

module i2_calc_module_5295d3b23d (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [16:0] addsub2_s_net_x1;
  wire [15:0] addsub3_s_net_x0;
  wire [0:0] ce_1_sg_x113;
  wire [0:0] clk_1_sg_x113;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [1:0] counter2_op_net_x2;
  wire [15:0] delay10_q_net_x0;
  wire [15:0] delay14_q_net_x0;
  wire [1:0] delay1_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;

  assign ce_1_sg_x113 = ce_1;
  assign clk_1_sg_x113 = clk_1;
  assign delay10_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay14_q_net_x0 = q;
  assign counter2_op_net_x2 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub2 (
    .a(delay10_q_net_x0),
    .b(delay14_q_net_x0),
    .ce(ce_1_sg_x113),
    .clk(clk_1_sg_x113),
    .clr(1'b0),
    .en(1'b1),
    .mode(inverter_op_net),
    .s(addsub2_s_net_x1)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x113),
    .clk(clk_1_sg_x113),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x113),
    .clk(clk_1_sg_x113),
    .d(counter2_op_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_33a63b558a  inverter (
    .ce(ce_1_sg_x113),
    .clk(clk_1_sg_x113),
    .clr(1'b0),
    .ip(lsb_y_net),
    .op(inverter_op_net)
  );

  logical_06844c65fb  logical (
    .ce(ce_1_sg_x113),
    .clk(clk_1_sg_x113),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  x16_module_365070a8a8  x16_a6b3f56e07 (
    .ce_1(ce_1_sg_x113),
    .clk_1(clk_1_sg_x113),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/I3_calc"

module i3_calc_module_00bbf7ce0b (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x116;
  wire [0:0] clk_1_sg_x116;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter2_op_net_x3;
  wire [15:0] delay11_q_net_x0;
  wire [15:0] delay15_q_net_x0;
  wire [1:0] delay1_q_net;
  wire [0:0] delay2_q_net;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x116 = ce_1;
  assign clk_1_sg_x116 = clk_1;
  assign delay11_q_net_x0 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay15_q_net_x0 = q;
  assign counter2_op_net_x3 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(addsub4_s_net_x0),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .din(delay2_q_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .d(counter2_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay2 (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .d(lsb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  logical_06844c65fb  logical (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .d0(delay11_q_net_x0),
    .d1(delay15_q_net_x0),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x116),
    .clk(clk_1_sg_x116),
    .clr(1'b0),
    .d0(delay15_q_net_x0),
    .d1(delay11_q_net_x0),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_c081224c5f  x16_96f3d075bd (
    .ce_1(ce_1_sg_x116),
    .clk_1(clk_1_sg_x116),
    .in_x0(mux3_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );

  x16_module_681a9d9f15  x16_ba2398a5be (
    .ce_1(ce_1_sg_x116),
    .clk_1(clk_1_sg_x116),
    .in_x0(mux2_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/Q0_calc"

module q0_calc_module_2a94af247f (
  ce_1,
  clk_1,
  i,
  out1,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out1;

  wire [15:0] addsub1_s_net_x0;
  wire [0:0] ce_1_sg_x117;
  wire [0:0] clk_1_sg_x117;
  wire [15:0] constant1_op_net;
  wire [1:0] counter1_op_net_x0;
  wire [15:0] delay12_q_net_x1;
  wire [1:0] delay1_q_net;
  wire [0:0] delay2_q_net;
  wire [15:0] delay8_q_net_x1;
  wire [0:0] msb_y_net;
  wire [15:0] mux_y_net;

  assign ce_1_sg_x117 = ce_1;
  assign clk_1_sg_x117 = clk_1;
  assign delay8_q_net_x1 = i;
  assign out1 = addsub1_s_net_x0;
  assign delay12_q_net_x1 = q;
  assign counter1_op_net_x0 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(4),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(5),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(constant1_op_net),
    .b(mux_y_net),
    .ce(ce_1_sg_x117),
    .clk(clk_1_sg_x117),
    .clr(1'b0),
    .en(1'b1),
    .mode(delay2_q_net),
    .s(addsub1_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x117),
    .clk(clk_1_sg_x117),
    .d(counter1_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay2 (
    .ce(ce_1_sg_x117),
    .clk(clk_1_sg_x117),
    .d(msb_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_a6eee4b271  mux (
    .ce(ce_1_sg_x117),
    .clk(clk_1_sg_x117),
    .clr(1'b0),
    .d0(delay12_q_net_x1),
    .d1(delay8_q_net_x1),
    .d2(delay12_q_net_x1),
    .d3(delay8_q_net_x1),
    .sel(delay1_q_net),
    .y(mux_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/Q1_calc"

module q1_calc_module_354b9e542c (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x120;
  wire [0:0] clk_1_sg_x120;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [1:0] counter1_op_net_x1;
  wire [15:0] delay13_q_net_x1;
  wire [1:0] delay1_q_net;
  wire [15:0] delay9_q_net_x1;
  wire [0:0] inverter1_op_net;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x120 = ce_1;
  assign clk_1_sg_x120 = clk_1;
  assign delay9_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay13_q_net_x1 = q;
  assign counter1_op_net_x1 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(addsub4_s_net_x0),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .en(1'b1),
    .mode(inverter1_op_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .d(counter1_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_48d1f6b088  inverter1 (
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .ip(lsb_y_net),
    .op(inverter1_op_net)
  );

  logical_06844c65fb  logical (
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .d0(delay9_q_net_x1),
    .d1(delay13_q_net_x1),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x120),
    .clk(clk_1_sg_x120),
    .clr(1'b0),
    .d0(delay13_q_net_x1),
    .d1(delay9_q_net_x1),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_681a9d9f15  x16_5461a6a8eb (
    .ce_1(ce_1_sg_x120),
    .clk_1(clk_1_sg_x120),
    .in_x0(mux2_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );

  x16_module_c081224c5f  x16_b1e7bb6fbc (
    .ce_1(ce_1_sg_x120),
    .clk_1(clk_1_sg_x120),
    .in_x0(mux3_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/Q2_calc"

module q2_calc_module_a02a261660 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [16:0] addsub2_s_net_x1;
  wire [15:0] addsub3_s_net_x0;
  wire [0:0] ce_1_sg_x122;
  wire [0:0] clk_1_sg_x122;
  wire [15:0] constant1_op_net;
  wire [0:0] convert1_dout_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter1_op_net_x2;
  wire [15:0] delay10_q_net_x1;
  wire [15:0] delay14_q_net_x1;
  wire [1:0] delay1_q_net;
  wire [0:0] inverter1_op_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;

  assign ce_1_sg_x122 = ce_1;
  assign clk_1_sg_x122 = clk_1;
  assign delay10_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay14_q_net_x1 = q;
  assign counter1_op_net_x2 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub2 (
    .a(delay10_q_net_x1),
    .b(delay14_q_net_x1),
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert1_dout_net),
    .s(addsub2_s_net_x1)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .clr(1'b0),
    .en(1'b1),
    .mode(convert_dout_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .clr(1'b0),
    .din(inverter1_op_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .clr(1'b0),
    .din(lsb_y_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .d(counter1_op_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_66c3795ede  inverter1 (
    .ce(ce_1_sg_x122),
    .clk(clk_1_sg_x122),
    .clr(1'b0),
    .ip(msb_y_net),
    .op(inverter1_op_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  x16_module_365070a8a8  x16_a63c2c6cf8 (
    .ce_1(ce_1_sg_x122),
    .clk_1(clk_1_sg_x122),
    .in_x0(addsub2_s_net_x1),
    .out_x0(convert1_dout_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3/Q3_calc"

module q3_calc_module_1b185a0572 (
  ce_1,
  clk_1,
  i,
  out_x0,
  q,
  sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i;
  input [15:0] q;
  input [1:0] sel;
  output [15:0] out_x0;

  wire [15:0] addsub1_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub4_s_net_x0;
  wire [0:0] ce_1_sg_x125;
  wire [0:0] clk_1_sg_x125;
  wire [15:0] constant1_op_net;
  wire [15:0] convert1_dout_net_x0;
  wire [0:0] convert_dout_net;
  wire [1:0] counter1_op_net_x3;
  wire [15:0] delay11_q_net_x1;
  wire [15:0] delay15_q_net_x1;
  wire [1:0] delay1_q_net;
  wire [0:0] inverter2_op_net;
  wire [0:0] logical_y_net;
  wire [0:0] lsb_y_net;
  wire [0:0] msb_y_net;
  wire [15:0] mux2_y_net_x0;
  wire [15:0] mux3_y_net_x0;

  assign ce_1_sg_x125 = ce_1;
  assign clk_1_sg_x125 = clk_1;
  assign delay11_q_net_x1 = i;
  assign out_x0 = addsub3_s_net_x0;
  assign delay15_q_net_x1 = q;
  assign counter1_op_net_x3 = sel;


  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(convert1_dout_net_x0),
    .b(addsub4_s_net_x0),
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .en(1'b1),
    .mode(inverter2_op_net),
    .s(addsub1_s_net)
  );

  xladdsubmode_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_9196f8ffd2db8ce4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .mode_arith(`xlUnsigned),
    .mode_bin_pt(0),
    .mode_width(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(constant1_op_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .en(1'b1),
    .mode(logical_y_net),
    .s(addsub3_s_net_x0)
  );

  constant_281c9dad53  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  xlconvert #(

    .bool_conversion(1),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(1),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .din(lsb_y_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay1 (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .d(counter1_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  inverter_48d1f6b088  inverter2 (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(inverter2_op_net)
  );

  logical_d5c14b9908  logical (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .d0(msb_y_net),
    .d1(lsb_y_net),
    .y(logical_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(0),
    .x_width(2),
    .y_width(1))
  lsb (
    .x(delay1_q_net),
    .y(lsb_y_net)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  msb (
    .x(delay1_q_net),
    .y(msb_y_net)
  );

  mux_f3921567cd  mux2 (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .d0(delay11_q_net_x1),
    .d1(delay15_q_net_x1),
    .sel(lsb_y_net),
    .y(mux2_y_net_x0)
  );

  mux_f3921567cd  mux3 (
    .ce(ce_1_sg_x125),
    .clk(clk_1_sg_x125),
    .clr(1'b0),
    .d0(delay15_q_net_x1),
    .d1(delay11_q_net_x1),
    .sel(lsb_y_net),
    .y(mux3_y_net_x0)
  );

  x16_module_c081224c5f  x16_319e56cd9b (
    .ce_1(ce_1_sg_x125),
    .clk_1(clk_1_sg_x125),
    .in_x0(mux2_y_net_x0),
    .out_x0(convert1_dout_net_x0)
  );

  x16_module_681a9d9f15  x16_739067c3fd (
    .ce_1(ce_1_sg_x125),
    .clk_1(clk_1_sg_x125),
    .in_x0(mux3_y_net_x0),
    .out_x0(addsub4_s_net_x0)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/MIXER1536_minus_band3"

module mixer1536_minus_band3_module_42ab45e797 (
  ce_1,
  clk_1,
  i0,
  i0_out,
  i1,
  i1_out,
  i2,
  i2_out,
  i3,
  i3_out,
  q0,
  q0_out,
  q1,
  q1_out,
  q2,
  q2_out,
  q3,
  q3_out
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] i0;
  input [15:0] i1;
  input [15:0] i2;
  input [15:0] i3;
  input [15:0] q0;
  input [15:0] q1;
  input [15:0] q2;
  input [15:0] q3;
  output [15:0] i0_out;
  output [15:0] i1_out;
  output [15:0] i2_out;
  output [15:0] i3_out;
  output [15:0] q0_out;
  output [15:0] q1_out;
  output [15:0] q2_out;
  output [15:0] q3_out;

  wire [15:0] addsub1_s_net_x2;
  wire [15:0] addsub1_s_net_x3;
  wire [15:0] addsub3_s_net_x10;
  wire [15:0] addsub3_s_net_x11;
  wire [15:0] addsub3_s_net_x6;
  wire [15:0] addsub3_s_net_x7;
  wire [15:0] addsub3_s_net_x8;
  wire [15:0] addsub3_s_net_x9;
  wire [0:0] ce_1_sg_x126;
  wire [0:0] clk_1_sg_x126;
  wire [1:0] counter1_op_net_x3;
  wire [1:0] counter2_op_net_x3;
  wire [15:0] delay10_q_net_x2;
  wire [15:0] delay11_q_net_x2;
  wire [15:0] delay12_q_net_x2;
  wire [15:0] delay13_q_net_x2;
  wire [15:0] delay14_q_net_x2;
  wire [15:0] delay15_q_net_x2;
  wire [15:0] delay8_q_net_x2;
  wire [15:0] delay9_q_net_x2;

  assign ce_1_sg_x126 = ce_1;
  assign clk_1_sg_x126 = clk_1;
  assign delay8_q_net_x2 = i0;
  assign i0_out = addsub1_s_net_x2;
  assign delay9_q_net_x2 = i1;
  assign i1_out = addsub3_s_net_x6;
  assign delay10_q_net_x2 = i2;
  assign i2_out = addsub3_s_net_x7;
  assign delay11_q_net_x2 = i3;
  assign i3_out = addsub3_s_net_x8;
  assign delay12_q_net_x2 = q0;
  assign q0_out = addsub1_s_net_x3;
  assign delay13_q_net_x2 = q1;
  assign q1_out = addsub3_s_net_x9;
  assign delay14_q_net_x2 = q2;
  assign q2_out = addsub3_s_net_x10;
  assign delay15_q_net_x2 = q3;
  assign q3_out = addsub3_s_net_x11;


  xlcounter_free_duc_16ch_341 #(

    .core_name0("cntr_11_0_76451075d188e63f"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter1 (
    .ce(ce_1_sg_x126),
    .clk(clk_1_sg_x126),
    .clr(1'b0),
    .en(1'b1),
    .rst(1'b0),
    .op(counter1_op_net_x3)
  );

  xlcounter_free_duc_16ch_341 #(

    .core_name0("cntr_11_0_76451075d188e63f"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter2 (
    .ce(ce_1_sg_x126),
    .clk(clk_1_sg_x126),
    .clr(1'b0),
    .en(1'b1),
    .rst(1'b0),
    .op(counter2_op_net_x3)
  );

  i0_calc_module_ffcbd4a114  i0_calc_ffcbd4a114 (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay8_q_net_x2),
    .q(delay12_q_net_x2),
    .sel(counter2_op_net_x3),
    .out1(addsub1_s_net_x2)
  );

  i1_calc_module_79974815da  i1_calc_79974815da (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay9_q_net_x2),
    .q(delay13_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x6)
  );

  i2_calc_module_5295d3b23d  i2_calc_5295d3b23d (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay10_q_net_x2),
    .q(delay14_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x7)
  );

  i3_calc_module_00bbf7ce0b  i3_calc_00bbf7ce0b (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay11_q_net_x2),
    .q(delay15_q_net_x2),
    .sel(counter2_op_net_x3),
    .out_x0(addsub3_s_net_x8)
  );

  q0_calc_module_2a94af247f  q0_calc_2a94af247f (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay8_q_net_x2),
    .q(delay12_q_net_x2),
    .sel(counter1_op_net_x3),
    .out1(addsub1_s_net_x3)
  );

  q1_calc_module_354b9e542c  q1_calc_354b9e542c (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay9_q_net_x2),
    .q(delay13_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x9)
  );

  q2_calc_module_a02a261660  q2_calc_a02a261660 (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay10_q_net_x2),
    .q(delay14_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x10)
  );

  q3_calc_module_1b185a0572  q3_calc_1b185a0572 (
    .ce_1(ce_1_sg_x126),
    .clk_1(clk_1_sg_x126),
    .i(delay11_q_net_x2),
    .q(delay15_q_net_x2),
    .sel(counter1_op_net_x3),
    .out_x0(addsub3_s_net_x11)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/Mixer1/LO"

module lo_module_eb8216eae9 (
  ce_1,
  clk_1,
  cos,
  freq_word,
  sin
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [9:0] freq_word;
  output [17:0] cos;
  output [17:0] sin;

  wire [9:0] accumulator_q_net;
  wire [9:0] addsub_s_net;
  wire [0:0] ce_1_sg_x127;
  wire [0:0] clk_1_sg_x127;
  wire [17:0] constant1_op_net;
  wire [9:0] constant2_op_net;
  wire [0:0] constant_op_net;
  wire [17:0] delay1_q_net_x0;
  wire [17:0] delay2_q_net_x0;
  wire [9:0] delay_q_net;
  wire [17:0] dual_port_ram_douta_net;
  wire [17:0] dual_port_ram_doutb_net;
  wire [9:0] freq_word1_net_x0;

  assign ce_1_sg_x127 = ce_1;
  assign clk_1_sg_x127 = clk_1;
  assign cos = delay2_q_net_x0;
  assign freq_word1_net_x0 = freq_word;
  assign sin = delay1_q_net_x0;


  accum_8dccba219b  accumulator (
    .b(freq_word1_net_x0),
    .ce(ce_1_sg_x127),
    .clk(clk_1_sg_x127),
    .clr(1'b0),
    .q(accumulator_q_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(10))
  addsub (
    .a(accumulator_q_net),
    .b(constant2_op_net),
    .ce(ce_1_sg_x127),
    .clk(clk_1_sg_x127),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  constant_66f4f3b646  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_b0803b3578  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  constant_ae323e07fc  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay (
    .ce(ce_1_sg_x127),
    .clk(clk_1_sg_x127),
    .d(accumulator_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay1 (
    .ce(ce_1_sg_x127),
    .clk(clk_1_sg_x127),
    .d(dual_port_ram_douta_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay2 (
    .ce(ce_1_sg_x127),
    .clk(clk_1_sg_x127),
    .d(dual_port_ram_doutb_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net_x0)
  );

  xldpram_duc_16ch_341 #(

    .c_address_width_a(10),
    .c_address_width_b(10),
    .c_width_a(18),
    .c_width_b(18),
    .core_name0("bmg_72_5fc6d969158b1ced"),
    .latency(2))
  dual_port_ram (
    .a_ce(ce_1_sg_x127),
    .a_clk(clk_1_sg_x127),
    .addra(delay_q_net),
    .addrb(addsub_s_net),
    .b_ce(ce_1_sg_x127),
    .b_clk(clk_1_sg_x127),
    .dina(constant1_op_net),
    .dinb(constant1_op_net),
    .ena(1'b1),
    .enb(1'b1),
    .rsta(1'b0),
    .rstb(1'b0),
    .wea(constant_op_net),
    .web(constant_op_net),
    .douta(dual_port_ram_douta_net),
    .doutb(dual_port_ram_doutb_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/Mixer1"

module mixer1_module_08be5a3870 (
  ce_1,
  clk_1,
  freq_word,
  i,
  iout,
  q,
  qout
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [9:0] freq_word;
  input [15:0] i;
  input [15:0] q;
  output [15:0] iout;
  output [15:0] qout;

  wire [0:0] ce_1_sg_x128;
  wire [0:0] clk_1_sg_x128;
  wire [47:0] constant1_op_net;
  wire [47:0] constant2_op_net;
  wire [24:0] constant_op_net;
  wire [17:0] convert10_dout_net;
  wire [29:0] convert11_dout_net;
  wire [29:0] convert2_dout_net;
  wire [29:0] convert3_dout_net;
  wire [15:0] convert4_dout_net_x0;
  wire [15:0] convert5_dout_net_x0;
  wire [29:0] convert6_dout_net;
  wire [17:0] convert7_dout_net;
  wire [17:0] convert8_dout_net;
  wire [17:0] convert9_dout_net;
  wire [15:0] delay15_q_net_x1;
  wire [15:0] delay15_q_net_x2;
  wire [17:0] delay1_q_net_x0;
  wire [17:0] delay2_q_net_x0;
  wire [47:0] dsp48e1_1_pcout_net;
  wire [47:0] dsp48e1_2_p_net;
  wire [47:0] dsp48e1_4_p_net;
  wire [47:0] dsp48e1_pcout_net;
  wire [9:0] freq_word1_net_x1;
  wire [19:0] opmode1_op_net;
  wire [19:0] opmode2_op_net;
  wire [19:0] opmode_op_net;
  wire [15:0] reinterpret10_output_port_net;
  wire [17:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret2_output_port_net;
  wire [17:0] reinterpret3_output_port_net;
  wire [17:0] reinterpret4_output_port_net;
  wire [15:0] reinterpret5_output_port_net;
  wire [17:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret7_output_port_net;
  wire [47:0] reinterpret8_output_port_net;
  wire [47:0] reinterpret9_output_port_net;

  assign ce_1_sg_x128 = ce_1;
  assign clk_1_sg_x128 = clk_1;
  assign freq_word1_net_x1 = freq_word;
  assign delay15_q_net_x1 = i;
  assign iout = convert4_dout_net_x0;
  assign delay15_q_net_x2 = q;
  assign qout = convert5_dout_net_x0;


  constant_ca7488d888  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_ca7488d888  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  constant_3660c43b3c  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert10 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret6_output_port_net),
    .en(1'b1),
    .dout(convert10_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert11 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret10_output_port_net),
    .en(1'b1),
    .dout(convert11_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret7_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret5_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret8_output_port_net),
    .en(1'b1),
    .dout(convert4_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(32),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert5_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret2_output_port_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x128),
    .clk(clk_1_sg_x128),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(0),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(1),
    .breg(1),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(0),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("FALSE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1 (
    .a(convert11_dout_net),
    .alumode(4'b0000),
    .b(convert10_dout_net),
    .c(constant2_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x128),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x128),
    .en(1'b1),
    .op(opmode_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .pcout(dsp48e1_pcout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(0),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(1),
    .breg(1),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(0),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("FALSE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_1 (
    .a(convert2_dout_net),
    .alumode(4'b0000),
    .b(convert8_dout_net),
    .c(constant1_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x128),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x128),
    .en(1'b1),
    .op(opmode_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .pcout(dsp48e1_1_pcout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(0),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(0),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("FALSE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_2 (
    .a(convert3_dout_net),
    .alumode(4'b0000),
    .b(convert9_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x128),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x128),
    .en(1'b1),
    .op(opmode2_op_net),
    .pcin(dsp48e1_1_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_2_p_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(1),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert6_dout_net),
    .alumode(4'b0000),
    .b(convert7_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x128),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x128),
    .d(constant_op_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  lo_module_eb8216eae9  lo_eb8216eae9 (
    .ce_1(ce_1_sg_x128),
    .clk_1(clk_1_sg_x128),
    .freq_word(freq_word1_net_x1),
    .cos(delay2_q_net_x0),
    .sin(delay1_q_net_x0)
  );

  opmode_2a00e03ade  opmode (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode_op_net)
  );

  opmode_6aca2f0a6e  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  opmode_bddb7c5c56  opmode2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode2_op_net)
  );

  reinterpret_0e0c011a4e  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net_x0),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay15_q_net_x1),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay15_q_net_x2),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net_x0),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay15_q_net_x2),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay2_q_net_x0),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret7 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay15_q_net_x1),
    .output_port(reinterpret7_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret8_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_2_p_net),
    .output_port(reinterpret9_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/RF_mixer/Mixer4096_0"

module mixer4096_0_module_76fbba13a8 (
  addr,
  ce_1,
  clk_1,
  i,
  iout,
  q
);

  input [9:0] addr;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [17:0] i;
  input [17:0] q;
  output [13:0] iout;

  wire [17:0] addsub5_s_net_x1;
  wire [17:0] addsub5_s_net_x2;
  wire [0:0] ce_1_sg_x159;
  wire [0:0] clk_1_sg_x159;
  wire [47:0] constant2_op_net;
  wire [24:0] constant_op_net;
  wire [17:0] convert10_dout_net;
  wire [29:0] convert11_dout_net;
  wire [13:0] convert2_dout_net;
  wire [29:0] convert3_dout_net;
  wire [17:0] convert5_dout_net;
  wire [17:0] delay1_q_net;
  wire [13:0] delay2_q_net_x0;
  wire [17:0] delay_q_net_x0;
  wire [9:0] delay_q_net_x1;
  wire [47:0] dsp48e1_4_p_net;
  wire [47:0] dsp48e1_pcout_net;
  wire [19:0] opmode1_op_net;
  wire [19:0] opmode_op_net;
  wire [17:0] reinterpret10_output_port_net;
  wire [17:0] reinterpret3_output_port_net;
  wire [17:0] reinterpret4_output_port_net;
  wire [17:0] reinterpret5_output_port_net;
  wire [47:0] reinterpret7_output_port_net;
  wire [17:0] sin_lut1_data_net;
  wire [17:0] sin_lut_data_net;

  assign delay_q_net_x1 = addr;
  assign ce_1_sg_x159 = ce_1;
  assign clk_1_sg_x159 = clk_1;
  assign addsub5_s_net_x1 = i;
  assign iout = delay2_q_net_x0;
  assign addsub5_s_net_x2 = q;


  constant_34794c595f  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  constant_3660c43b3c  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert10 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .clr(1'b0),
    .din(reinterpret5_output_port_net),
    .en(1'b1),
    .dout(convert10_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert11 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .clr(1'b0),
    .din(reinterpret10_output_port_net),
    .en(1'b1),
    .dout(convert11_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(34),
    .din_width(48),
    .dout_arith(2),
    .dout_bin_pt(13),
    .dout_width(14),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .clr(1'b0),
    .din(reinterpret7_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(0),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .d(sin_lut_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay1 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .d(sin_lut1_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(14))
  delay2 (
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .d(convert2_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net_x0)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(0),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(1),
    .breg(1),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(1),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(1),
    .dreg(0),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(1),
    .use_dport("FALSE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1 (
    .a(convert11_dout_net),
    .alumode(4'b0000),
    .b(convert10_dout_net),
    .c(constant2_op_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x159),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x159),
    .en(1'b1),
    .op(opmode_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .pcout(dsp48e1_pcout_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(1),
    .adreg(1),
    .alumodereg(1),
    .areg(1),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(1),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(1),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("TRUE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1_4 (
    .a(convert3_dout_net),
    .alumode(4'b0000),
    .b(convert5_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x159),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x159),
    .d(constant_op_net),
    .en(1'b1),
    .op(opmode1_op_net),
    .pcin(dsp48e1_pcout_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_4_p_net)
  );

  opmode_2a00e03ade  opmode (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode_op_net)
  );

  opmode_6aca2f0a6e  opmode1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode1_op_net)
  );

  reinterpret_0e0c011a4e  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(addsub5_s_net_x1),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay_q_net_x0),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(addsub5_s_net_x2),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_0e0c011a4e  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_5668f8e576  reinterpret7 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_4_p_net),
    .output_port(reinterpret7_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(10),
    .c_width(18),
    .core_name0("bmg_72_c0e7027c8d56f068"),
    .latency(1))
  sin_lut (
    .addr(delay_q_net_x1),
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .en(1'b1),
    .rst(1'b0),
    .data(sin_lut_data_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(10),
    .c_width(18),
    .core_name0("bmg_72_0b6075e08c22268d"),
    .latency(1))
  sin_lut1 (
    .addr(delay_q_net_x1),
    .ce(ce_1_sg_x159),
    .clk(clk_1_sg_x159),
    .en(1'b1),
    .rst(1'b0),
    .data(sin_lut1_data_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/RF_mixer"

module rf_mixer_module_666360da93 (
  ce_1,
  clk_1,
  freq_word1,
  freq_word10,
  freq_word11,
  freq_word12,
  freq_word2,
  freq_word3,
  freq_word4,
  freq_word5,
  freq_word6,
  freq_word7,
  freq_word8,
  freq_word9,
  i1,
  i10,
  i11,
  i12,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  out1,
  out10,
  out11,
  out12,
  out2,
  out3,
  out4,
  out5,
  out6,
  out7,
  out8,
  out9,
  q1,
  q10,
  q11,
  q12,
  q2,
  q3,
  q4,
  q5,
  q6,
  q7,
  q8,
  q9
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [9:0] freq_word1;
  input [9:0] freq_word10;
  input [9:0] freq_word11;
  input [9:0] freq_word12;
  input [9:0] freq_word2;
  input [9:0] freq_word3;
  input [9:0] freq_word4;
  input [9:0] freq_word5;
  input [9:0] freq_word6;
  input [9:0] freq_word7;
  input [9:0] freq_word8;
  input [9:0] freq_word9;
  input [17:0] i1;
  input [17:0] i10;
  input [17:0] i11;
  input [17:0] i12;
  input [17:0] i2;
  input [17:0] i3;
  input [17:0] i4;
  input [17:0] i5;
  input [17:0] i6;
  input [17:0] i7;
  input [17:0] i8;
  input [17:0] i9;
  input [17:0] q1;
  input [17:0] q10;
  input [17:0] q11;
  input [17:0] q12;
  input [17:0] q2;
  input [17:0] q3;
  input [17:0] q4;
  input [17:0] q5;
  input [17:0] q6;
  input [17:0] q7;
  input [17:0] q8;
  input [17:0] q9;
  output [13:0] out1;
  output [13:0] out10;
  output [13:0] out11;
  output [13:0] out12;
  output [13:0] out2;
  output [13:0] out3;
  output [13:0] out4;
  output [13:0] out5;
  output [13:0] out6;
  output [13:0] out7;
  output [13:0] out8;
  output [13:0] out9;

  wire [10:0] addsub10_s_net;
  wire [10:0] addsub11_s_net;
  wire [10:0] addsub12_s_net;
  wire [9:0] addsub1_s_net;
  wire [10:0] addsub2_s_net;
  wire [10:0] addsub3_s_net;
  wire [10:0] addsub4_s_net;
  wire [10:0] addsub5_s_net;
  wire [17:0] addsub5_s_net_x25;
  wire [17:0] addsub5_s_net_x26;
  wire [17:0] addsub5_s_net_x27;
  wire [17:0] addsub5_s_net_x28;
  wire [17:0] addsub5_s_net_x29;
  wire [17:0] addsub5_s_net_x30;
  wire [17:0] addsub5_s_net_x31;
  wire [17:0] addsub5_s_net_x32;
  wire [17:0] addsub5_s_net_x33;
  wire [17:0] addsub5_s_net_x34;
  wire [17:0] addsub5_s_net_x35;
  wire [17:0] addsub5_s_net_x36;
  wire [17:0] addsub5_s_net_x37;
  wire [17:0] addsub5_s_net_x38;
  wire [17:0] addsub5_s_net_x39;
  wire [17:0] addsub5_s_net_x40;
  wire [17:0] addsub5_s_net_x41;
  wire [17:0] addsub5_s_net_x42;
  wire [17:0] addsub5_s_net_x43;
  wire [17:0] addsub5_s_net_x44;
  wire [17:0] addsub5_s_net_x45;
  wire [17:0] addsub5_s_net_x46;
  wire [17:0] addsub5_s_net_x47;
  wire [17:0] addsub5_s_net_x48;
  wire [10:0] addsub6_s_net;
  wire [10:0] addsub7_s_net;
  wire [10:0] addsub8_s_net;
  wire [10:0] addsub9_s_net;
  wire [0:0] ce_1_sg_x171;
  wire [0:0] clk_1_sg_x171;
  wire [9:0] constant2_op_net;
  wire [9:0] convert10_dout_net_x1;
  wire [9:0] convert11_dout_net_x1;
  wire [9:0] convert12_dout_net_x0;
  wire [9:0] convert13_dout_net_x0;
  wire [29:0] convert14_dout_net;
  wire [17:0] convert15_dout_net;
  wire [9:0] convert16_dout_net;
  wire [9:0] convert3_dout_net_x1;
  wire [9:0] convert4_dout_net_x0;
  wire [9:0] convert5_dout_net_x1;
  wire [9:0] convert6_dout_net_x0;
  wire [9:0] convert7_dout_net_x0;
  wire [9:0] convert8_dout_net_x0;
  wire [9:0] convert9_dout_net_x0;
  wire [9:0] delay1_q_net;
  wire [9:0] delay2_q_net;
  wire [13:0] delay2_q_net_x12;
  wire [13:0] delay2_q_net_x13;
  wire [13:0] delay2_q_net_x14;
  wire [13:0] delay2_q_net_x15;
  wire [13:0] delay2_q_net_x16;
  wire [13:0] delay2_q_net_x17;
  wire [13:0] delay2_q_net_x18;
  wire [13:0] delay2_q_net_x19;
  wire [13:0] delay2_q_net_x20;
  wire [13:0] delay2_q_net_x21;
  wire [13:0] delay2_q_net_x22;
  wire [13:0] delay2_q_net_x23;
  wire [9:0] delay3_q_net;
  wire [9:0] delay4_q_net;
  wire [9:0] delay_q_net_x1;
  wire [47:0] dsp48e1_p_net;
  wire [9:0] freq_word24_net_x0;
  wire [9:0] freq_word25_net_x0;
  wire [9:0] freq_word26_net_x0;
  wire [9:0] freq_word27_net_x0;
  wire [9:0] freq_word28_net_x0;
  wire [9:0] freq_word29_net_x0;
  wire [9:0] freq_word30_net_x0;
  wire [9:0] freq_word31_net_x0;
  wire [9:0] freq_word32_net_x0;
  wire [9:0] freq_word33_net_x0;
  wire [9:0] freq_word34_net_x0;
  wire [9:0] freq_word35_net_x0;
  wire [19:0] opmode_op_net;
  wire [47:0] reinterpret1_output_port_net;

  assign ce_1_sg_x171 = ce_1;
  assign clk_1_sg_x171 = clk_1;
  assign freq_word24_net_x0 = freq_word1;
  assign freq_word33_net_x0 = freq_word10;
  assign freq_word34_net_x0 = freq_word11;
  assign freq_word35_net_x0 = freq_word12;
  assign freq_word25_net_x0 = freq_word2;
  assign freq_word26_net_x0 = freq_word3;
  assign freq_word27_net_x0 = freq_word4;
  assign freq_word28_net_x0 = freq_word5;
  assign freq_word29_net_x0 = freq_word6;
  assign freq_word30_net_x0 = freq_word7;
  assign freq_word31_net_x0 = freq_word8;
  assign freq_word32_net_x0 = freq_word9;
  assign addsub5_s_net_x25 = i1;
  assign addsub5_s_net_x28 = i10;
  assign addsub5_s_net_x35 = i11;
  assign addsub5_s_net_x36 = i12;
  assign addsub5_s_net_x29 = i2;
  assign addsub5_s_net_x30 = i3;
  assign addsub5_s_net_x26 = i4;
  assign addsub5_s_net_x31 = i5;
  assign addsub5_s_net_x32 = i6;
  assign addsub5_s_net_x27 = i7;
  assign addsub5_s_net_x33 = i8;
  assign addsub5_s_net_x34 = i9;
  assign out1 = delay2_q_net_x12;
  assign out10 = delay2_q_net_x23;
  assign out11 = delay2_q_net_x14;
  assign out12 = delay2_q_net_x15;
  assign out2 = delay2_q_net_x13;
  assign out3 = delay2_q_net_x16;
  assign out4 = delay2_q_net_x17;
  assign out5 = delay2_q_net_x18;
  assign out6 = delay2_q_net_x19;
  assign out7 = delay2_q_net_x20;
  assign out8 = delay2_q_net_x21;
  assign out9 = delay2_q_net_x22;
  assign addsub5_s_net_x37 = q1;
  assign addsub5_s_net_x40 = q10;
  assign addsub5_s_net_x47 = q11;
  assign addsub5_s_net_x48 = q12;
  assign addsub5_s_net_x41 = q2;
  assign addsub5_s_net_x42 = q3;
  assign addsub5_s_net_x38 = q4;
  assign addsub5_s_net_x43 = q5;
  assign addsub5_s_net_x44 = q6;
  assign addsub5_s_net_x39 = q7;
  assign addsub5_s_net_x45 = q8;
  assign addsub5_s_net_x46 = q9;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(10))
  addsub1 (
    .a(addsub1_s_net),
    .b(constant2_op_net),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub10 (
    .a(delay3_q_net),
    .b(freq_word33_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub10_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub11 (
    .a(delay3_q_net),
    .b(freq_word34_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub11_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub12 (
    .a(delay3_q_net),
    .b(freq_word35_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub12_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub2 (
    .a(delay1_q_net),
    .b(freq_word25_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub3 (
    .a(delay1_q_net),
    .b(freq_word26_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub4 (
    .a(delay2_q_net),
    .b(freq_word27_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub5 (
    .a(delay2_q_net),
    .b(freq_word28_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub6 (
    .a(delay2_q_net),
    .b(freq_word29_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub7 (
    .a(delay4_q_net),
    .b(freq_word30_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub7_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub8 (
    .a(delay4_q_net),
    .b(freq_word31_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub8_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_49467494b87e75c7"),
    .extra_registers(0),
    .full_s_arith(1),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(11))
  addsub9 (
    .a(delay4_q_net),
    .b(freq_word32_net_x0),
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net)
  );

  constant_dc846bf42d  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert10 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub8_s_net),
    .en(1'b1),
    .dout(convert10_dout_net_x1)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert11 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub10_s_net),
    .en(1'b1),
    .dout(convert11_dout_net_x1)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert12 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub11_s_net),
    .en(1'b1),
    .dout(convert12_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert13 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub12_s_net),
    .en(1'b1),
    .dout(convert13_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(30),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert14 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert14_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert15 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(freq_word24_net_x0),
    .en(1'b1),
    .dout(convert15_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(48),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert16 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert16_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert3_dout_net_x1)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert4_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub5_s_net),
    .en(1'b1),
    .dout(convert5_dout_net_x1)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub4_s_net),
    .en(1'b1),
    .dout(convert6_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub7_s_net),
    .en(1'b1),
    .dout(convert7_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub6_s_net),
    .en(1'b1),
    .dout(convert8_dout_net_x0)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(11),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .clr(1'b0),
    .din(addsub9_s_net),
    .en(1'b1),
    .dout(convert9_dout_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .d(delay1_q_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay1 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .d(convert16_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay2 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .d(convert16_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay3 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .d(convert16_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(10))
  delay4 (
    .ce(ce_1_sg_x171),
    .clk(clk_1_sg_x171),
    .d(convert16_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldsp48e1 #(

    .a_input("DIRECT"),
    .acascreg(2),
    .adreg(0),
    .alumodereg(1),
    .areg(2),
    .autoreset_pattern_detect("NO_RESET"),
    .b_input("DIRECT"),
    .bcascreg(2),
    .breg(2),
    .c_use_a(1),
    .c_use_acin(0),
    .c_use_b(1),
    .c_use_bcin(0),
    .c_use_c(0),
    .c_use_cea1(0),
    .c_use_cea2(0),
    .c_use_cead(0),
    .c_use_cealumode(0),
    .c_use_ceb1(0),
    .c_use_ceb2(0),
    .c_use_cec(0),
    .c_use_cecarryin(0),
    .c_use_cectrl(0),
    .c_use_ced(0),
    .c_use_ceinmode(0),
    .c_use_cem(0),
    .c_use_cemultcarryin(0),
    .c_use_cep(0),
    .c_use_en(0),
    .c_use_pcin(0),
    .c_use_rst(0),
    .c_use_rsta(0),
    .c_use_rstalumode(0),
    .c_use_rstb(0),
    .c_use_rstc(0),
    .c_use_rstcarryin(0),
    .c_use_rstctrl(0),
    .c_use_rstd(0),
    .c_use_rstinmode(0),
    .c_use_rstm(0),
    .c_use_rstp(0),
    .carryinreg(1),
    .carryinselreg(1),
    .carryout_width(4),
    .creg(0),
    .dreg(0),
    .inmodereg(0),
    .mreg(1),
    .opmodereg(1),
    .preg(1),
    .sel_mask("C"),
    .sel_pattern("C"),
    .use_c_port(0),
    .use_dport("FALSE"),
    .use_mult("MULTIPLY"),
    .use_op(1),
    .use_pattern_detect("NO_PATDET"),
    .use_simd("ONE48"))
  dsp48e1 (
    .a(convert14_dout_net),
    .alumode(4'b0000),
    .b(convert15_dout_net),
    .carryin(1'b0),
    .ce(ce_1_sg_x171),
    .cea1(1'b1),
    .cea2(1'b1),
    .cead(1'b1),
    .cealumode(1'b1),
    .ceb1(1'b1),
    .ceb2(1'b1),
    .cec(1'b1),
    .cecarryin(1'b1),
    .cectrl(1'b1),
    .ced(1'b1),
    .ceinmode(1'b1),
    .cem(1'b1),
    .cemultcarryin(1'b1),
    .cep(1'b1),
    .clk(clk_1_sg_x171),
    .en(1'b1),
    .op(opmode_op_net),
    .rst(1'b0),
    .rsta(1'b0),
    .rstalumode(1'b0),
    .rstb(1'b0),
    .rstc(1'b0),
    .rstcarryin(1'b0),
    .rstctrl(1'b0),
    .rstd(1'b0),
    .rstinmode(1'b0),
    .rstm(1'b0),
    .rstp(1'b0),
    .p(dsp48e1_p_net)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_0_76fbba13a8 (
    .addr(delay_q_net_x1),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x25),
    .q(addsub5_s_net_x37),
    .iout(delay2_q_net_x12)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_10_7dd6339ca6 (
    .addr(convert12_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x35),
    .q(addsub5_s_net_x47),
    .iout(delay2_q_net_x14)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_11_59bedc3dd5 (
    .addr(convert13_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x36),
    .q(addsub5_s_net_x48),
    .iout(delay2_q_net_x15)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_1_8a4d76ae40 (
    .addr(convert4_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x29),
    .q(addsub5_s_net_x41),
    .iout(delay2_q_net_x13)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_2_b18923aa34 (
    .addr(convert3_dout_net_x1),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x30),
    .q(addsub5_s_net_x42),
    .iout(delay2_q_net_x16)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_3_40e32fcd25 (
    .addr(convert6_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x26),
    .q(addsub5_s_net_x38),
    .iout(delay2_q_net_x17)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_4_1c313be717 (
    .addr(convert5_dout_net_x1),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x31),
    .q(addsub5_s_net_x43),
    .iout(delay2_q_net_x18)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_5_aa351e18f6 (
    .addr(convert8_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x32),
    .q(addsub5_s_net_x44),
    .iout(delay2_q_net_x19)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_6_bd25f7ca2f (
    .addr(convert7_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x27),
    .q(addsub5_s_net_x39),
    .iout(delay2_q_net_x20)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_7_fea2e626f1 (
    .addr(convert10_dout_net_x1),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x33),
    .q(addsub5_s_net_x45),
    .iout(delay2_q_net_x21)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_8_f5b80f6881 (
    .addr(convert9_dout_net_x0),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x34),
    .q(addsub5_s_net_x46),
    .iout(delay2_q_net_x22)
  );

  mixer4096_0_module_76fbba13a8  mixer4096_9_f139d35ed5 (
    .addr(convert11_dout_net_x1),
    .ce_1(ce_1_sg_x171),
    .clk_1(clk_1_sg_x171),
    .i(addsub5_s_net_x28),
    .q(addsub5_s_net_x40),
    .iout(delay2_q_net_x23)
  );

  opmode_3711ab4973  opmode (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(opmode_op_net)
  );

  reinterpret_84fa2b7df8  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(dsp48e1_p_net),
    .output_port(reinterpret1_output_port_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/Subsystem"

module subsystem_module_251f158845 (
  ce_1,
  clk_1,
  ena_c0,
  ena_c1,
  ena_c10,
  ena_c11,
  ena_c12,
  ena_c13,
  ena_c14,
  ena_c15,
  ena_c2,
  ena_c3,
  ena_c4,
  ena_c5,
  ena_c6,
  ena_c7,
  ena_c8,
  ena_c9,
  i0,
  i1,
  i10,
  i11,
  i12,
  i13,
  i14,
  i15,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  out1,
  out2,
  q0,
  q1,
  q10,
  q11,
  q12,
  q13,
  q14,
  q15,
  q2,
  q3,
  q4,
  q5,
  q6,
  q7,
  q8,
  q9
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] ena_c0;
  input [0:0] ena_c1;
  input [0:0] ena_c10;
  input [0:0] ena_c11;
  input [0:0] ena_c12;
  input [0:0] ena_c13;
  input [0:0] ena_c14;
  input [0:0] ena_c15;
  input [0:0] ena_c2;
  input [0:0] ena_c3;
  input [0:0] ena_c4;
  input [0:0] ena_c5;
  input [0:0] ena_c6;
  input [0:0] ena_c7;
  input [0:0] ena_c8;
  input [0:0] ena_c9;
  input [15:0] i0;
  input [15:0] i1;
  input [15:0] i10;
  input [15:0] i11;
  input [15:0] i12;
  input [15:0] i13;
  input [15:0] i14;
  input [15:0] i15;
  input [15:0] i2;
  input [15:0] i3;
  input [15:0] i4;
  input [15:0] i5;
  input [15:0] i6;
  input [15:0] i7;
  input [15:0] i8;
  input [15:0] i9;
  input [15:0] q0;
  input [15:0] q1;
  input [15:0] q10;
  input [15:0] q11;
  input [15:0] q12;
  input [15:0] q13;
  input [15:0] q14;
  input [15:0] q15;
  input [15:0] q2;
  input [15:0] q3;
  input [15:0] q4;
  input [15:0] q5;
  input [15:0] q6;
  input [15:0] q7;
  input [15:0] q8;
  input [15:0] q9;
  output [18:0] out1;
  output [18:0] out2;

  wire [16:0] addsub10_s_net;
  wire [17:0] addsub11_s_net;
  wire [17:0] addsub12_s_net;
  wire [17:0] addsub13_s_net;
  wire [16:0] addsub14_s_net;
  wire [17:0] addsub15_s_net;
  wire [17:0] addsub16_s_net;
  wire [16:0] addsub17_s_net;
  wire [16:0] addsub18_s_net;
  wire [16:0] addsub19_s_net;
  wire [16:0] addsub1_s_net;
  wire [16:0] addsub20_s_net;
  wire [17:0] addsub21_s_net;
  wire [16:0] addsub22_s_net;
  wire [17:0] addsub24_s_net;
  wire [17:0] addsub25_s_net;
  wire [17:0] addsub26_s_net;
  wire [17:0] addsub28_s_net;
  wire [17:0] addsub29_s_net;
  wire [16:0] addsub2_s_net;
  wire [16:0] addsub3_s_net;
  wire [18:0] addsub42_s_net_x0;
  wire [18:0] addsub43_s_net_x0;
  wire [16:0] addsub4_s_net;
  wire [16:0] addsub5_s_net;
  wire [16:0] addsub6_s_net;
  wire [17:0] addsub7_s_net;
  wire [16:0] addsub8_s_net;
  wire [16:0] addsub9_s_net;
  wire [16:0] addsub_s_net;
  wire [0:0] ce_1_sg_x172;
  wire [0:0] clk_1_sg_x172;
  wire [15:0] convert4_dout_net_x16;
  wire [15:0] convert4_dout_net_x17;
  wire [15:0] convert4_dout_net_x18;
  wire [15:0] convert4_dout_net_x19;
  wire [15:0] convert4_dout_net_x20;
  wire [15:0] convert4_dout_net_x21;
  wire [15:0] convert4_dout_net_x22;
  wire [15:0] convert4_dout_net_x23;
  wire [15:0] convert4_dout_net_x24;
  wire [15:0] convert4_dout_net_x25;
  wire [15:0] convert4_dout_net_x26;
  wire [15:0] convert4_dout_net_x27;
  wire [15:0] convert4_dout_net_x28;
  wire [15:0] convert4_dout_net_x29;
  wire [15:0] convert4_dout_net_x30;
  wire [15:0] convert4_dout_net_x31;
  wire [15:0] convert5_dout_net_x16;
  wire [15:0] convert5_dout_net_x17;
  wire [15:0] convert5_dout_net_x18;
  wire [15:0] convert5_dout_net_x19;
  wire [15:0] convert5_dout_net_x20;
  wire [15:0] convert5_dout_net_x21;
  wire [15:0] convert5_dout_net_x22;
  wire [15:0] convert5_dout_net_x23;
  wire [15:0] convert5_dout_net_x24;
  wire [15:0] convert5_dout_net_x25;
  wire [15:0] convert5_dout_net_x26;
  wire [15:0] convert5_dout_net_x27;
  wire [15:0] convert5_dout_net_x28;
  wire [15:0] convert5_dout_net_x29;
  wire [15:0] convert5_dout_net_x30;
  wire [15:0] convert5_dout_net_x31;
  wire [0:0] ena_b0c0_net_x0;
  wire [0:0] ena_b0c10_net_x0;
  wire [0:0] ena_b0c11_net_x0;
  wire [0:0] ena_b0c12_net_x0;
  wire [0:0] ena_b0c13_net_x0;
  wire [0:0] ena_b0c14_net_x0;
  wire [0:0] ena_b0c15_net_x0;
  wire [0:0] ena_b0c1_net_x0;
  wire [0:0] ena_b0c2_net_x0;
  wire [0:0] ena_b0c3_net_x0;
  wire [0:0] ena_b0c4_net_x0;
  wire [0:0] ena_b0c5_net_x0;
  wire [0:0] ena_b0c6_net_x0;
  wire [0:0] ena_b0c7_net_x0;
  wire [0:0] ena_b0c8_net_x0;
  wire [0:0] ena_b0c9_net_x0;
  wire [15:0] register10_q_net;
  wire [15:0] register11_q_net;
  wire [15:0] register12_q_net;
  wire [15:0] register13_q_net;
  wire [15:0] register14_q_net;
  wire [15:0] register15_q_net;
  wire [15:0] register16_q_net;
  wire [15:0] register17_q_net;
  wire [15:0] register18_q_net;
  wire [15:0] register19_q_net;
  wire [15:0] register1_q_net;
  wire [15:0] register20_q_net;
  wire [15:0] register21_q_net;
  wire [15:0] register22_q_net;
  wire [15:0] register23_q_net;
  wire [15:0] register24_q_net;
  wire [15:0] register25_q_net;
  wire [15:0] register26_q_net;
  wire [15:0] register27_q_net;
  wire [15:0] register28_q_net;
  wire [15:0] register29_q_net;
  wire [15:0] register2_q_net;
  wire [15:0] register30_q_net;
  wire [15:0] register31_q_net;
  wire [15:0] register3_q_net;
  wire [15:0] register4_q_net;
  wire [15:0] register5_q_net;
  wire [15:0] register6_q_net;
  wire [15:0] register7_q_net;
  wire [15:0] register8_q_net;
  wire [15:0] register9_q_net;
  wire [15:0] register_q_net;

  assign ce_1_sg_x172 = ce_1;
  assign clk_1_sg_x172 = clk_1;
  assign ena_b0c0_net_x0 = ena_c0;
  assign ena_b0c1_net_x0 = ena_c1;
  assign ena_b0c10_net_x0 = ena_c10;
  assign ena_b0c11_net_x0 = ena_c11;
  assign ena_b0c12_net_x0 = ena_c12;
  assign ena_b0c13_net_x0 = ena_c13;
  assign ena_b0c14_net_x0 = ena_c14;
  assign ena_b0c15_net_x0 = ena_c15;
  assign ena_b0c2_net_x0 = ena_c2;
  assign ena_b0c3_net_x0 = ena_c3;
  assign ena_b0c4_net_x0 = ena_c4;
  assign ena_b0c5_net_x0 = ena_c5;
  assign ena_b0c6_net_x0 = ena_c6;
  assign ena_b0c7_net_x0 = ena_c7;
  assign ena_b0c8_net_x0 = ena_c8;
  assign ena_b0c9_net_x0 = ena_c9;
  assign convert4_dout_net_x25 = i0;
  assign convert4_dout_net_x16 = i1;
  assign convert4_dout_net_x17 = i10;
  assign convert4_dout_net_x18 = i11;
  assign convert4_dout_net_x19 = i12;
  assign convert4_dout_net_x20 = i13;
  assign convert4_dout_net_x21 = i14;
  assign convert4_dout_net_x22 = i15;
  assign convert4_dout_net_x23 = i2;
  assign convert4_dout_net_x24 = i3;
  assign convert4_dout_net_x26 = i4;
  assign convert4_dout_net_x27 = i5;
  assign convert4_dout_net_x28 = i6;
  assign convert4_dout_net_x29 = i7;
  assign convert4_dout_net_x30 = i8;
  assign convert4_dout_net_x31 = i9;
  assign out1 = addsub42_s_net_x0;
  assign out2 = addsub43_s_net_x0;
  assign convert5_dout_net_x25 = q0;
  assign convert5_dout_net_x16 = q1;
  assign convert5_dout_net_x17 = q10;
  assign convert5_dout_net_x18 = q11;
  assign convert5_dout_net_x19 = q12;
  assign convert5_dout_net_x20 = q13;
  assign convert5_dout_net_x21 = q14;
  assign convert5_dout_net_x22 = q15;
  assign convert5_dout_net_x23 = q2;
  assign convert5_dout_net_x24 = q3;
  assign convert5_dout_net_x26 = q4;
  assign convert5_dout_net_x27 = q5;
  assign convert5_dout_net_x28 = q6;
  assign convert5_dout_net_x29 = q7;
  assign convert5_dout_net_x30 = q8;
  assign convert5_dout_net_x31 = q9;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub (
    .a(register_q_net),
    .b(register2_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub1 (
    .a(register4_q_net),
    .b(register6_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub10 (
    .a(register17_q_net),
    .b(register25_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub10_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub11 (
    .a(addsub9_s_net),
    .b(addsub14_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub11_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub12 (
    .a(addsub10_s_net),
    .b(addsub17_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub12_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub13 (
    .a(addsub19_s_net),
    .b(addsub22_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub13_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub14 (
    .a(register26_q_net),
    .b(register28_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub14_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub15 (
    .a(addsub11_s_net),
    .b(addsub21_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub15_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub16 (
    .a(addsub12_s_net),
    .b(addsub13_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub16_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub17 (
    .a(register27_q_net),
    .b(register29_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub17_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub18 (
    .a(register30_q_net),
    .b(register18_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub18_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub19 (
    .a(register31_q_net),
    .b(register19_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub19_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub2 (
    .a(register1_q_net),
    .b(register3_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub20 (
    .a(register20_q_net),
    .b(register22_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub20_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub21 (
    .a(addsub18_s_net),
    .b(addsub20_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub21_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub22 (
    .a(register21_q_net),
    .b(register23_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub22_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub24 (
    .a(addsub_s_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub24_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub25 (
    .a(addsub2_s_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub25_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub26 (
    .a(addsub5_s_net),
    .b(addsub8_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub26_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub28 (
    .a(addsub24_s_net),
    .b(addsub7_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub28_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub29 (
    .a(addsub25_s_net),
    .b(addsub26_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub29_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub3 (
    .a(register5_q_net),
    .b(register7_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub4 (
    .a(register8_q_net),
    .b(register10_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(19))
  addsub42 (
    .a(addsub28_s_net),
    .b(addsub15_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub42_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(19))
  addsub43 (
    .a(addsub29_s_net),
    .b(addsub16_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub43_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub5 (
    .a(register9_q_net),
    .b(register11_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub6 (
    .a(register12_q_net),
    .b(register14_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(18))
  addsub7 (
    .a(addsub4_s_net),
    .b(addsub6_s_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub7_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub8 (
    .a(register13_q_net),
    .b(register15_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub8_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(17))
  addsub9 (
    .a(register16_q_net),
    .b(register24_q_net),
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register1 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x25),
    .en(1'b1),
    .rst(ena_b0c0_net_x0),
    .q(register1_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register10 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x27),
    .en(1'b1),
    .rst(ena_b0c5_net_x0),
    .q(register10_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register11 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x27),
    .en(1'b1),
    .rst(ena_b0c5_net_x0),
    .q(register11_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register12 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x28),
    .en(1'b1),
    .rst(ena_b0c6_net_x0),
    .q(register12_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register13 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x28),
    .en(1'b1),
    .rst(ena_b0c6_net_x0),
    .q(register13_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register14 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x29),
    .en(1'b1),
    .rst(ena_b0c7_net_x0),
    .q(register14_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register15 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x29),
    .en(1'b1),
    .rst(ena_b0c7_net_x0),
    .q(register15_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register16 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x30),
    .en(1'b1),
    .rst(ena_b0c8_net_x0),
    .q(register16_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register17 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x30),
    .en(1'b1),
    .rst(ena_b0c8_net_x0),
    .q(register17_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register18 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x20),
    .en(1'b1),
    .rst(ena_b0c13_net_x0),
    .q(register18_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register19 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x20),
    .en(1'b1),
    .rst(ena_b0c13_net_x0),
    .q(register19_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register2 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x16),
    .en(1'b1),
    .rst(ena_b0c1_net_x0),
    .q(register2_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register20 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x21),
    .en(1'b1),
    .rst(ena_b0c14_net_x0),
    .q(register20_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register21 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x21),
    .en(1'b1),
    .rst(ena_b0c14_net_x0),
    .q(register21_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register22 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x22),
    .en(1'b1),
    .rst(ena_b0c15_net_x0),
    .q(register22_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register23 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x22),
    .en(1'b1),
    .rst(ena_b0c15_net_x0),
    .q(register23_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register24 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x31),
    .en(1'b1),
    .rst(ena_b0c9_net_x0),
    .q(register24_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register25 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x31),
    .en(1'b1),
    .rst(ena_b0c9_net_x0),
    .q(register25_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register26 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x17),
    .en(1'b1),
    .rst(ena_b0c10_net_x0),
    .q(register26_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register27 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x17),
    .en(1'b1),
    .rst(ena_b0c10_net_x0),
    .q(register27_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register28 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x18),
    .en(1'b1),
    .rst(ena_b0c11_net_x0),
    .q(register28_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register29 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x18),
    .en(1'b1),
    .rst(ena_b0c11_net_x0),
    .q(register29_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register3 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x16),
    .en(1'b1),
    .rst(ena_b0c1_net_x0),
    .q(register3_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register30 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x19),
    .en(1'b1),
    .rst(ena_b0c12_net_x0),
    .q(register30_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register31 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x19),
    .en(1'b1),
    .rst(ena_b0c12_net_x0),
    .q(register31_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register4 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x23),
    .en(1'b1),
    .rst(ena_b0c2_net_x0),
    .q(register4_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register5 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x23),
    .en(1'b1),
    .rst(ena_b0c2_net_x0),
    .q(register5_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register6 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x24),
    .en(1'b1),
    .rst(ena_b0c3_net_x0),
    .q(register6_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register7 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x24),
    .en(1'b1),
    .rst(ena_b0c3_net_x0),
    .q(register7_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register8 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x26),
    .en(1'b1),
    .rst(ena_b0c4_net_x0),
    .q(register8_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register9 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert5_dout_net_x26),
    .en(1'b1),
    .rst(ena_b0c4_net_x0),
    .q(register9_q_net)
  );

  xlregister #(

    .d_width(16),
    .init_value(16'b0000000000000000))
  register_x0 (
    .ce(ce_1_sg_x172),
    .clk(clk_1_sg_x172),
    .d(convert4_dout_net_x25),
    .en(1'b1),
    .rst(ena_b0c0_net_x0),
    .q(register_q_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/X3FIR_dedicate"

module x3fir_dedicate_module_b957602124 (
  c0_x,
  c1_x,
  c2_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [17:0] c0_x;
  output [17:0] c1_x;
  output [17:0] c2_x;

  wire [9:0] addsub1_s_net;
  wire [11:0] addsub2_s_net;
  wire [0:0] ce_1_sg_x175;
  wire [0:0] clk_1_sg_x175;
  wire [9:0] convert1_dout_net;
  wire [11:0] convert3_dout_net;
  wire [17:0] convert4_dout_net;
  wire [17:0] convert5_dout_net;
  wire [17:0] convert6_dout_net;
  wire [9:0] convert_dout_net;
  wire [26:0] delay1_q_net;
  wire [11:0] delay2_q_net;
  wire [15:0] delay4_q_net_x0;
  wire [4:0] delay_q_net;
  wire [5:0] lsb1_y_net;
  wire [9:0] reinterpret10_output_port_net;
  wire [5:0] reinterpret11_output_port_net;
  wire [4:0] reinterpret1_output_port_net;
  wire [4:0] reinterpret2_output_port_net;
  wire [6:0] reinterpret4_output_port_net;
  wire [9:0] reinterpret5_output_port_net;
  wire [11:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [11:0] rom3_data_net;
  wire [26:0] rom_data_net;
  wire [9:0] shift2_op_net;
  wire [11:0] shift3_op_net;
  wire [17:0] shift5_op_net_x0;
  wire [17:0] shift6_op_net_x0;
  wire [17:0] shift8_op_net_x0;
  wire [9:0] slice2_y_net;
  wire [11:0] slice3_y_net;
  wire [4:0] slice4_y_net;
  wire [6:0] slice5_y_net;
  wire [4:0] slice_y_net;

  assign c0_x = shift8_op_net_x0;
  assign c1_x = shift6_op_net_x0;
  assign c2_x = shift5_op_net_x0;
  assign ce_1_sg_x175 = ce_1;
  assign clk_1_sg_x175 = clk_1;
  assign delay4_q_net_x0 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(9),
    .a_width(10),
    .b_arith(`xlSigned),
    .b_bin_pt(9),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(11),
    .core_name0("addsb_11_0_6623adedd12a938a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(11),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(9),
    .s_width(10))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(11),
    .a_width(12),
    .b_arith(`xlSigned),
    .b_bin_pt(11),
    .b_width(12),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(13),
    .core_name0("addsb_11_0_8747e77bb511337e"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(13),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(11),
    .s_width(12))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(6),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(9),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(6),
    .din_width(7),
    .dout_arith(2),
    .dout_bin_pt(11),
    .dout_width(12),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(delay_q_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(9),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(11),
    .din_width(12),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(5))
  delay (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .d(reinterpret2_output_port_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(27))
  delay1 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .d(rom_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(12))
  delay2 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(5),
    .x_width(16),
    .y_width(6))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_9f3848bc50  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice4_y_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_b41d29f193  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_3f5d978749  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_9f3848bc50  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_8eee8341d8  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice5_y_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_fd8afbe046  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_94dfdafd95  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay4_q_net_x0),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(10),
    .c_width(27),
    .core_name0("bmg_72_88bd69a7e506f2a2"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(6),
    .c_address_width(6),
    .c_width(12),
    .core_name0("dmg_72_b01799b9bf71bdc0"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_85f5a5ebd0  shift2 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_39b9422678  shift3 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_af45bff5a0  shift5 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_13f7182392  shift6 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift6_op_net_x0)
  );

  shift_35e4e03aef  shift8 (
    .ce(ce_1_sg_x175),
    .clk(clk_1_sg_x175),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(4),
    .x_width(27),
    .y_width(5))
  slice (
    .x(delay1_q_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(5),
    .new_msb(14),
    .x_width(27),
    .y_width(10))
  slice2 (
    .x(delay1_q_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(15),
    .new_msb(26),
    .x_width(27),
    .y_width(12))
  slice3 (
    .x(delay1_q_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(4),
    .x_width(12),
    .y_width(5))
  slice4 (
    .x(delay2_q_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(5),
    .new_msb(11),
    .x_width(12),
    .y_width(7))
  slice5 (
    .x(delay2_q_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/X3FIR_general1"

module x3fir_general1_module_3881a267b3 (
  c6_x,
  c7_x,
  c8_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [17:0] c6_x;
  output [17:0] c7_x;
  output [17:0] c8_x;

  wire [15:0] addsub1_s_net;
  wire [12:0] addsub2_s_net;
  wire [14:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x179;
  wire [0:0] clk_1_sg_x179;
  wire [15:0] convert1_dout_net;
  wire [14:0] convert2_dout_net;
  wire [12:0] convert3_dout_net;
  wire [17:0] convert4_dout_net;
  wire [17:0] convert5_dout_net;
  wire [17:0] convert6_dout_net;
  wire [6:0] convert7_dout_net;
  wire [7:0] convert8_dout_net;
  wire [4:0] convert9_dout_net;
  wire [8:0] convert_dout_net;
  wire [43:0] delay1_q_net;
  wire [15:0] delay26_q_net_x0;
  wire [16:0] delay_q_net;
  wire [6:0] lsb1_y_net;
  wire [8:0] reinterpret10_output_port_net;
  wire [6:0] reinterpret11_output_port_net;
  wire [7:0] reinterpret1_output_port_net;
  wire [14:0] reinterpret2_output_port_net;
  wire [6:0] reinterpret3_output_port_net;
  wire [4:0] reinterpret4_output_port_net;
  wire [15:0] reinterpret5_output_port_net;
  wire [12:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [16:0] rom3_data_net;
  wire [43:0] rom_data_net;
  wire [14:0] shift1_op_net;
  wire [15:0] shift2_op_net;
  wire [12:0] shift3_op_net;
  wire [17:0] shift4_op_net_x0;
  wire [17:0] shift5_op_net_x0;
  wire [17:0] shift8_op_net_x0;
  wire [5:0] slice1_y_net;
  wire [15:0] slice2_y_net;
  wire [12:0] slice3_y_net;
  wire [6:0] slice4_y_net;
  wire [3:0] slice5_y_net;
  wire [14:0] slice_y_net;

  assign c6_x = shift8_op_net_x0;
  assign c7_x = shift4_op_net_x0;
  assign c8_x = shift5_op_net_x0;
  assign ce_1_sg_x179 = ce_1;
  assign clk_1_sg_x179 = clk_1;
  assign delay26_q_net_x0 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(12),
    .a_width(13),
    .b_arith(`xlSigned),
    .b_bin_pt(12),
    .b_width(13),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(14),
    .core_name0("addsb_11_0_3abe85fcf1017fed"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(14),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(12),
    .s_width(13))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(14),
    .a_width(15),
    .b_arith(`xlSigned),
    .b_bin_pt(14),
    .b_width(15),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(16),
    .core_name0("addsb_11_0_f392a1f2f071bf23"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(16),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(14),
    .s_width(15))
  addsub3 (
    .a(reinterpret2_output_port_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(8),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(6),
    .din_width(7),
    .dout_arith(2),
    .dout_bin_pt(14),
    .dout_width(15),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(12),
    .dout_width(13),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(14),
    .din_width(15),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(12),
    .din_width(13),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(6),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(7),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(slice1_y_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(7),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(8),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(slice4_y_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(4),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(5),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .din(slice5_y_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(17))
  delay (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(44))
  delay1 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .d(rom_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(16),
    .y_width(7))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_feb184a5ad  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert8_dout_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_34f6390c19  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_016d92ab20  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_6200c8761b  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_8eee8341d8  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert7_dout_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_9f3848bc50  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert9_dout_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_55833616ec  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay26_q_net_x0),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(9),
    .c_width(44),
    .core_name0("bmg_72_2f2b227d5258d685"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(7),
    .c_address_width(7),
    .c_width(17),
    .core_name0("dmg_72_2828f053f6c73e1f"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_447ff429c9  shift1 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift1_op_net)
  );

  shift_05a6d83f8c  shift2 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_ed17a56c3a  shift3 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_e2f66c8512  shift4 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift4_op_net_x0)
  );

  shift_e2efd1e2c2  shift5 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_42c206eba8  shift8 (
    .ce(ce_1_sg_x179),
    .clk(clk_1_sg_x179),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(14),
    .x_width(44),
    .y_width(15))
  slice (
    .x(delay1_q_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(5),
    .x_width(17),
    .y_width(6))
  slice1 (
    .x(delay_q_net),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(15),
    .new_msb(30),
    .x_width(44),
    .y_width(16))
  slice2 (
    .x(delay1_q_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(31),
    .new_msb(43),
    .x_width(44),
    .y_width(13))
  slice3 (
    .x(delay1_q_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(6),
    .new_msb(12),
    .x_width(17),
    .y_width(7))
  slice4 (
    .x(delay_q_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(13),
    .new_msb(16),
    .x_width(17),
    .y_width(4))
  slice5 (
    .x(delay_q_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/X3FIR_general11"

module x3fir_general11_module_8a262408cd (
  c3_x,
  c4_x,
  c5_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [17:0] c3_x;
  output [17:0] c4_x;
  output [17:0] c5_x;

  wire [12:0] addsub1_s_net;
  wire [12:0] addsub2_s_net;
  wire [12:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x181;
  wire [0:0] clk_1_sg_x181;
  wire [12:0] convert1_dout_net;
  wire [12:0] convert2_dout_net;
  wire [12:0] convert3_dout_net;
  wire [17:0] convert4_dout_net;
  wire [17:0] convert5_dout_net;
  wire [17:0] convert6_dout_net;
  wire [4:0] convert7_dout_net;
  wire [4:0] convert8_dout_net;
  wire [4:0] convert9_dout_net;
  wire [8:0] convert_dout_net;
  wire [38:0] delay1_q_net;
  wire [15:0] delay1_q_net_x2;
  wire [11:0] delay_q_net;
  wire [6:0] lsb1_y_net;
  wire [8:0] reinterpret10_output_port_net;
  wire [6:0] reinterpret11_output_port_net;
  wire [4:0] reinterpret1_output_port_net;
  wire [12:0] reinterpret2_output_port_net;
  wire [4:0] reinterpret3_output_port_net;
  wire [4:0] reinterpret4_output_port_net;
  wire [12:0] reinterpret5_output_port_net;
  wire [12:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [11:0] rom3_data_net;
  wire [38:0] rom_data_net;
  wire [12:0] shift1_op_net;
  wire [12:0] shift2_op_net;
  wire [12:0] shift3_op_net;
  wire [17:0] shift4_op_net_x0;
  wire [17:0] shift5_op_net_x0;
  wire [17:0] shift8_op_net_x0;
  wire [3:0] slice1_y_net;
  wire [12:0] slice2_y_net;
  wire [12:0] slice3_y_net;
  wire [3:0] slice4_y_net;
  wire [3:0] slice5_y_net;
  wire [12:0] slice_y_net;

  assign c3_x = shift8_op_net_x0;
  assign c4_x = shift4_op_net_x0;
  assign c5_x = shift5_op_net_x0;
  assign ce_1_sg_x181 = ce_1;
  assign clk_1_sg_x181 = clk_1;
  assign delay1_q_net_x2 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(12),
    .a_width(13),
    .b_arith(`xlSigned),
    .b_bin_pt(12),
    .b_width(13),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(14),
    .core_name0("addsb_11_0_3abe85fcf1017fed"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(14),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(12),
    .s_width(13))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(12),
    .a_width(13),
    .b_arith(`xlSigned),
    .b_bin_pt(12),
    .b_width(13),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(14),
    .core_name0("addsb_11_0_3abe85fcf1017fed"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(14),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(12),
    .s_width(13))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(12),
    .a_width(13),
    .b_arith(`xlSigned),
    .b_bin_pt(12),
    .b_width(13),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(14),
    .core_name0("addsb_11_0_3abe85fcf1017fed"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(14),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(12),
    .s_width(13))
  addsub3 (
    .a(reinterpret2_output_port_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(12),
    .dout_width(13),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(12),
    .dout_width(13),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(4),
    .din_width(5),
    .dout_arith(2),
    .dout_bin_pt(12),
    .dout_width(13),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(12),
    .din_width(13),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(12),
    .din_width(13),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(12),
    .din_width(13),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(4),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(5),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(slice1_y_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(4),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(5),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(slice4_y_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(4),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(5),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .din(slice5_y_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(12))
  delay (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(39))
  delay1 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .d(rom_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(16),
    .y_width(7))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_9f3848bc50  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert8_dout_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_34f6390c19  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_016d92ab20  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_55833616ec  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_9f3848bc50  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert7_dout_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_9f3848bc50  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert9_dout_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_55833616ec  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_55833616ec  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net_x2),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(9),
    .c_width(39),
    .core_name0("bmg_72_9cba7eb6526fc26f"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(7),
    .c_address_width(7),
    .c_width(12),
    .core_name0("dmg_72_f25cd80cb6ee82df"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_ed17a56c3a  shift1 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift1_op_net)
  );

  shift_ed17a56c3a  shift2 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_ed17a56c3a  shift3 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_e2efd1e2c2  shift4 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift4_op_net_x0)
  );

  shift_e2efd1e2c2  shift5 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_e2efd1e2c2  shift8 (
    .ce(ce_1_sg_x181),
    .clk(clk_1_sg_x181),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(12),
    .x_width(39),
    .y_width(13))
  slice (
    .x(delay1_q_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(3),
    .x_width(12),
    .y_width(4))
  slice1 (
    .x(delay_q_net),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(13),
    .new_msb(25),
    .x_width(39),
    .y_width(13))
  slice2 (
    .x(delay1_q_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(26),
    .new_msb(38),
    .x_width(39),
    .y_width(13))
  slice3 (
    .x(delay1_q_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(4),
    .new_msb(7),
    .x_width(12),
    .y_width(4))
  slice4 (
    .x(delay_q_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(8),
    .new_msb(11),
    .x_width(12),
    .y_width(4))
  slice5 (
    .x(delay_q_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/X3FIR_general12"

module x3fir_general12_module_68607ba614 (
  c10_x,
  c11_x,
  c9_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [17:0] c10_x;
  output [17:0] c11_x;
  output [17:0] c9_x;

  wire [17:0] addsub1_s_net;
  wire [17:0] addsub2_s_net;
  wire [15:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x182;
  wire [0:0] clk_1_sg_x182;
  wire [17:0] convert1_dout_net;
  wire [15:0] convert2_dout_net;
  wire [17:0] convert3_dout_net;
  wire [17:0] convert4_dout_net;
  wire [17:0] convert5_dout_net;
  wire [17:0] convert6_dout_net;
  wire [7:0] convert7_dout_net;
  wire [9:0] convert8_dout_net;
  wire [9:0] convert9_dout_net;
  wire [8:0] convert_dout_net;
  wire [51:0] delay1_q_net;
  wire [15:0] delay1_q_net_x3;
  wire [24:0] delay_q_net;
  wire [6:0] lsb1_y_net;
  wire [8:0] reinterpret10_output_port_net;
  wire [6:0] reinterpret11_output_port_net;
  wire [9:0] reinterpret1_output_port_net;
  wire [15:0] reinterpret2_output_port_net;
  wire [7:0] reinterpret3_output_port_net;
  wire [9:0] reinterpret4_output_port_net;
  wire [17:0] reinterpret5_output_port_net;
  wire [17:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [24:0] rom3_data_net;
  wire [51:0] rom_data_net;
  wire [15:0] shift1_op_net;
  wire [17:0] shift2_op_net;
  wire [17:0] shift3_op_net;
  wire [17:0] shift4_op_net_x0;
  wire [17:0] shift5_op_net_x0;
  wire [17:0] shift8_op_net_x0;
  wire [6:0] slice1_y_net;
  wire [17:0] slice2_y_net;
  wire [17:0] slice3_y_net;
  wire [8:0] slice4_y_net;
  wire [8:0] slice5_y_net;
  wire [15:0] slice_y_net;

  assign c10_x = shift4_op_net_x0;
  assign c11_x = shift5_op_net_x0;
  assign c9_x = shift8_op_net_x0;
  assign ce_1_sg_x182 = ce_1;
  assign clk_1_sg_x182 = clk_1;
  assign delay1_q_net_x3 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(reinterpret2_output_port_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(9),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(8),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(9),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(7),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(8),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(slice1_y_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(9),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(slice4_y_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(9),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .din(slice5_y_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(25))
  delay (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(52))
  delay1 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .d(rom_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(16),
    .y_width(7))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_fd8afbe046  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert8_dout_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_34f6390c19  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_016d92ab20  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_dee95c6dbb  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_feb184a5ad  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert7_dout_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_fd8afbe046  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert9_dout_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_87da68fdf8  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_87da68fdf8  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay1_q_net_x3),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(9),
    .c_width(52),
    .core_name0("bmg_72_e18a8bcda58a41cd"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(7),
    .c_address_width(7),
    .c_width(25),
    .core_name0("dmg_72_e9661fc0e9eb3e90"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_05a6d83f8c  shift1 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift1_op_net)
  );

  shift_13f7182392  shift2 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_13f7182392  shift3 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_572bccbff0  shift4 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift4_op_net_x0)
  );

  shift_572bccbff0  shift5 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_e2f66c8512  shift8 (
    .ce(ce_1_sg_x182),
    .clk(clk_1_sg_x182),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(15),
    .x_width(52),
    .y_width(16))
  slice (
    .x(delay1_q_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(25),
    .y_width(7))
  slice1 (
    .x(delay_q_net),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(16),
    .new_msb(33),
    .x_width(52),
    .y_width(18))
  slice2 (
    .x(delay1_q_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(34),
    .new_msb(51),
    .x_width(52),
    .y_width(18))
  slice3 (
    .x(delay1_q_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(7),
    .new_msb(15),
    .x_width(25),
    .y_width(9))
  slice4 (
    .x(delay_q_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(16),
    .new_msb(24),
    .x_width(25),
    .y_width(9))
  slice5 (
    .x(delay_q_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/y1_calc"

module y1_calc_module_7b010a4b16 (
  ce_1,
  clk_1,
  in1,
  in2,
  in3,
  in4,
  in5,
  in6,
  in7,
  in8,
  out1
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [17:0] in1;
  input [17:0] in2;
  input [17:0] in3;
  input [17:0] in4;
  input [17:0] in5;
  input [17:0] in6;
  input [17:0] in7;
  input [17:0] in8;
  output [17:0] out1;

  wire [17:0] addsub1_s_net;
  wire [17:0] addsub2_s_net;
  wire [17:0] addsub3_s_net;
  wire [17:0] addsub4_s_net;
  wire [17:0] addsub5_s_net_x26;
  wire [17:0] addsub6_s_net;
  wire [17:0] addsub_s_net;
  wire [0:0] ce_1_sg_x191;
  wire [0:0] clk_1_sg_x191;
  wire [17:0] delay10_q_net_x0;
  wire [17:0] delay7_q_net_x0;
  wire [17:0] delay8_q_net_x0;
  wire [17:0] delay9_q_net_x0;
  wire [17:0] shift8_op_net_x4;
  wire [17:0] shift8_op_net_x5;
  wire [17:0] shift8_op_net_x6;
  wire [17:0] shift8_op_net_x7;

  assign ce_1_sg_x191 = ce_1;
  assign clk_1_sg_x191 = clk_1;
  assign shift8_op_net_x4 = in1;
  assign shift8_op_net_x5 = in2;
  assign shift8_op_net_x7 = in3;
  assign shift8_op_net_x6 = in4;
  assign delay8_q_net_x0 = in5;
  assign delay7_q_net_x0 = in6;
  assign delay9_q_net_x0 = in7;
  assign delay10_q_net_x0 = in8;
  assign out1 = addsub5_s_net_x26;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub (
    .a(shift8_op_net_x4),
    .b(shift8_op_net_x5),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub1 (
    .a(shift8_op_net_x6),
    .b(shift8_op_net_x7),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub2 (
    .a(delay8_q_net_x0),
    .b(delay7_q_net_x0),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub3 (
    .a(delay10_q_net_x0),
    .b(delay9_q_net_x0),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub4 (
    .a(addsub_s_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub5 (
    .a(addsub4_s_net),
    .b(addsub6_s_net),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net_x26)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub6 (
    .a(addsub2_s_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x191),
    .clk(clk_1_sg_x191),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/y2_calc"

module y2_calc_module_fb831e70d6 (
  ce_1,
  clk_1,
  in1,
  in2,
  in3,
  in4,
  in5,
  in6,
  in7,
  in8,
  out1
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [17:0] in1;
  input [17:0] in2;
  input [17:0] in3;
  input [17:0] in4;
  input [17:0] in5;
  input [17:0] in6;
  input [17:0] in7;
  input [17:0] in8;
  output [17:0] out1;

  wire [17:0] addsub1_s_net;
  wire [17:0] addsub2_s_net;
  wire [17:0] addsub3_s_net;
  wire [17:0] addsub4_s_net;
  wire [17:0] addsub5_s_net_x30;
  wire [17:0] addsub6_s_net;
  wire [17:0] addsub_s_net;
  wire [0:0] ce_1_sg_x195;
  wire [0:0] clk_1_sg_x195;
  wire [17:0] delay11_q_net_x0;
  wire [17:0] delay12_q_net_x0;
  wire [17:0] delay13_q_net_x0;
  wire [17:0] delay14_q_net_x0;
  wire [17:0] shift4_op_net_x3;
  wire [17:0] shift4_op_net_x4;
  wire [17:0] shift4_op_net_x5;
  wire [17:0] shift6_op_net_x1;

  assign ce_1_sg_x195 = ce_1;
  assign clk_1_sg_x195 = clk_1;
  assign shift6_op_net_x1 = in1;
  assign shift4_op_net_x3 = in2;
  assign shift4_op_net_x5 = in3;
  assign shift4_op_net_x4 = in4;
  assign delay13_q_net_x0 = in5;
  assign delay12_q_net_x0 = in6;
  assign delay14_q_net_x0 = in7;
  assign delay11_q_net_x0 = in8;
  assign out1 = addsub5_s_net_x30;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub (
    .a(shift6_op_net_x1),
    .b(shift4_op_net_x3),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub1 (
    .a(shift4_op_net_x4),
    .b(shift4_op_net_x5),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub2 (
    .a(delay13_q_net_x0),
    .b(delay12_q_net_x0),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub3 (
    .a(delay14_q_net_x0),
    .b(delay11_q_net_x0),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub4 (
    .a(addsub_s_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub5 (
    .a(addsub4_s_net),
    .b(addsub6_s_net),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net_x30)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub6 (
    .a(addsub2_s_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x195),
    .clk(clk_1_sg_x195),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter/y2_calc1"

module y2_calc1_module_b9fe7ab17a (
  ce_1,
  clk_1,
  in1,
  in2,
  in3,
  in4,
  in5,
  in6,
  in7,
  in8,
  out1
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [17:0] in1;
  input [17:0] in2;
  input [17:0] in3;
  input [17:0] in4;
  input [17:0] in5;
  input [17:0] in6;
  input [17:0] in7;
  input [17:0] in8;
  output [17:0] out1;

  wire [17:0] addsub1_s_net;
  wire [17:0] addsub2_s_net;
  wire [17:0] addsub3_s_net;
  wire [17:0] addsub4_s_net;
  wire [17:0] addsub5_s_net_x31;
  wire [17:0] addsub6_s_net;
  wire [17:0] addsub_s_net;
  wire [0:0] ce_1_sg_x196;
  wire [0:0] clk_1_sg_x196;
  wire [17:0] delay15_q_net_x0;
  wire [17:0] delay16_q_net_x0;
  wire [17:0] delay17_q_net_x0;
  wire [17:0] delay18_q_net_x0;
  wire [17:0] shift5_op_net_x4;
  wire [17:0] shift5_op_net_x5;
  wire [17:0] shift5_op_net_x6;
  wire [17:0] shift5_op_net_x7;

  assign ce_1_sg_x196 = ce_1;
  assign clk_1_sg_x196 = clk_1;
  assign shift5_op_net_x4 = in1;
  assign shift5_op_net_x5 = in2;
  assign shift5_op_net_x7 = in3;
  assign shift5_op_net_x6 = in4;
  assign delay17_q_net_x0 = in5;
  assign delay16_q_net_x0 = in6;
  assign delay18_q_net_x0 = in7;
  assign delay15_q_net_x0 = in8;
  assign out1 = addsub5_s_net_x31;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub (
    .a(shift5_op_net_x4),
    .b(shift5_op_net_x5),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub1 (
    .a(shift5_op_net_x6),
    .b(shift5_op_net_x7),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_a5337ca1a964fead"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub2 (
    .a(delay17_q_net_x0),
    .b(delay16_q_net_x0),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub3 (
    .a(delay18_q_net_x0),
    .b(delay15_q_net_x0),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub4 (
    .a(addsub_s_net),
    .b(addsub1_s_net),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub5 (
    .a(addsub4_s_net),
    .b(addsub6_s_net),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net_x31)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub6 (
    .a(addsub2_s_net),
    .b(addsub3_s_net),
    .ce(ce_1_sg_x196),
    .clk(clk_1_sg_x196),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X3FIR Filter"

module x3fir_filter_module_4b5604b66f (
  ce_1,
  clk_1,
  x1,
  x2,
  x3,
  x4,
  y1,
  y10,
  y11,
  y12,
  y2,
  y3,
  y4,
  y5,
  y6,
  y7,
  y8,
  y9
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] x1;
  input [15:0] x2;
  input [15:0] x3;
  input [15:0] x4;
  output [17:0] y1;
  output [17:0] y10;
  output [17:0] y11;
  output [17:0] y12;
  output [17:0] y2;
  output [17:0] y3;
  output [17:0] y4;
  output [17:0] y5;
  output [17:0] y6;
  output [17:0] y7;
  output [17:0] y8;
  output [17:0] y9;

  wire [15:0] addsub1_s_net_x0;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub5_s_net_x0;
  wire [17:0] addsub5_s_net_x38;
  wire [17:0] addsub5_s_net_x39;
  wire [17:0] addsub5_s_net_x40;
  wire [17:0] addsub5_s_net_x41;
  wire [17:0] addsub5_s_net_x42;
  wire [17:0] addsub5_s_net_x43;
  wire [17:0] addsub5_s_net_x44;
  wire [17:0] addsub5_s_net_x45;
  wire [17:0] addsub5_s_net_x46;
  wire [17:0] addsub5_s_net_x47;
  wire [17:0] addsub5_s_net_x48;
  wire [17:0] addsub5_s_net_x49;
  wire [15:0] addsub7_s_net_x0;
  wire [0:0] ce_1_sg_x203;
  wire [0:0] clk_1_sg_x203;
  wire [17:0] delay10_q_net_x0;
  wire [17:0] delay11_q_net_x0;
  wire [17:0] delay12_q_net_x0;
  wire [17:0] delay13_q_net_x0;
  wire [17:0] delay14_q_net_x0;
  wire [17:0] delay15_q_net_x0;
  wire [17:0] delay16_q_net_x0;
  wire [17:0] delay17_q_net_x0;
  wire [17:0] delay18_q_net_x0;
  wire [17:0] delay19_q_net_x0;
  wire [15:0] delay1_q_net_x3;
  wire [17:0] delay20_q_net_x0;
  wire [17:0] delay21_q_net_x0;
  wire [15:0] delay22_q_net_x0;
  wire [17:0] delay23_q_net_x0;
  wire [17:0] delay24_q_net_x0;
  wire [17:0] delay25_q_net_x0;
  wire [15:0] delay26_q_net_x1;
  wire [17:0] delay27_q_net_x0;
  wire [17:0] delay28_q_net_x0;
  wire [15:0] delay29_q_net_x0;
  wire [15:0] delay2_q_net_x1;
  wire [17:0] delay30_q_net_x0;
  wire [17:0] delay31_q_net_x0;
  wire [17:0] delay32_q_net_x0;
  wire [17:0] delay33_q_net_x0;
  wire [17:0] delay35_q_net_x0;
  wire [17:0] delay36_q_net_x0;
  wire [17:0] delay37_q_net_x0;
  wire [17:0] delay39_q_net_x0;
  wire [15:0] delay3_q_net_x0;
  wire [17:0] delay40_q_net_x0;
  wire [17:0] delay42_q_net_x0;
  wire [17:0] delay43_q_net_x0;
  wire [17:0] delay44_q_net_x0;
  wire [17:0] delay47_q_net_x0;
  wire [17:0] delay48_q_net_x0;
  wire [15:0] delay4_q_net_x1;
  wire [17:0] delay51_q_net_x0;
  wire [17:0] delay54_q_net_x0;
  wire [15:0] delay5_q_net_x1;
  wire [15:0] delay6_q_net_x1;
  wire [17:0] delay7_q_net_x0;
  wire [17:0] delay8_q_net_x0;
  wire [17:0] delay9_q_net_x0;
  wire [17:0] shift4_op_net_x10;
  wire [17:0] shift4_op_net_x11;
  wire [17:0] shift4_op_net_x12;
  wire [17:0] shift4_op_net_x13;
  wire [17:0] shift4_op_net_x14;
  wire [17:0] shift4_op_net_x15;
  wire [17:0] shift4_op_net_x16;
  wire [17:0] shift4_op_net_x3;
  wire [17:0] shift4_op_net_x4;
  wire [17:0] shift4_op_net_x5;
  wire [17:0] shift4_op_net_x6;
  wire [17:0] shift4_op_net_x8;
  wire [17:0] shift5_op_net_x10;
  wire [17:0] shift5_op_net_x11;
  wire [17:0] shift5_op_net_x12;
  wire [17:0] shift5_op_net_x13;
  wire [17:0] shift5_op_net_x14;
  wire [17:0] shift5_op_net_x15;
  wire [17:0] shift5_op_net_x16;
  wire [17:0] shift5_op_net_x17;
  wire [17:0] shift5_op_net_x18;
  wire [17:0] shift5_op_net_x19;
  wire [17:0] shift5_op_net_x4;
  wire [17:0] shift5_op_net_x5;
  wire [17:0] shift5_op_net_x6;
  wire [17:0] shift5_op_net_x7;
  wire [17:0] shift5_op_net_x8;
  wire [17:0] shift5_op_net_x9;
  wire [17:0] shift6_op_net_x1;
  wire [17:0] shift6_op_net_x2;
  wire [17:0] shift6_op_net_x3;
  wire [17:0] shift6_op_net_x4;
  wire [17:0] shift8_op_net_x10;
  wire [17:0] shift8_op_net_x11;
  wire [17:0] shift8_op_net_x12;
  wire [17:0] shift8_op_net_x13;
  wire [17:0] shift8_op_net_x14;
  wire [17:0] shift8_op_net_x15;
  wire [17:0] shift8_op_net_x16;
  wire [17:0] shift8_op_net_x17;
  wire [17:0] shift8_op_net_x18;
  wire [17:0] shift8_op_net_x19;
  wire [17:0] shift8_op_net_x4;
  wire [17:0] shift8_op_net_x5;
  wire [17:0] shift8_op_net_x6;
  wire [17:0] shift8_op_net_x7;
  wire [17:0] shift8_op_net_x8;
  wire [17:0] shift8_op_net_x9;

  assign ce_1_sg_x203 = ce_1;
  assign clk_1_sg_x203 = clk_1;
  assign addsub1_s_net_x0 = x1;
  assign addsub3_s_net_x0 = x2;
  assign addsub5_s_net_x0 = x3;
  assign addsub7_s_net_x0 = x4;
  assign y1 = addsub5_s_net_x38;
  assign y10 = addsub5_s_net_x41;
  assign y11 = addsub5_s_net_x48;
  assign y12 = addsub5_s_net_x49;
  assign y2 = addsub5_s_net_x42;
  assign y3 = addsub5_s_net_x43;
  assign y4 = addsub5_s_net_x39;
  assign y5 = addsub5_s_net_x44;
  assign y6 = addsub5_s_net_x45;
  assign y7 = addsub5_s_net_x40;
  assign y8 = addsub5_s_net_x46;
  assign y9 = addsub5_s_net_x47;


  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(delay22_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net_x3)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay10 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay11 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift6_op_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay12 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay13 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x11),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay14 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x15),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay15 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay16 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x9),
    .en(1'b1),
    .rst(1'b1),
    .q(delay16_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay17 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x13),
    .en(1'b1),
    .rst(1'b1),
    .q(delay17_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay18 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x18),
    .en(1'b1),
    .rst(1'b1),
    .q(delay18_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay19 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x6),
    .en(1'b1),
    .rst(1'b1),
    .q(delay19_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay2 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(delay6_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net_x1)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay20 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift6_op_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay20_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay21 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x8),
    .en(1'b1),
    .rst(1'b1),
    .q(delay21_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay22 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub7_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay22_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay23 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay23_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay24 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x6),
    .en(1'b1),
    .rst(1'b1),
    .q(delay24_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay25 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x8),
    .en(1'b1),
    .rst(1'b1),
    .q(delay25_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay26 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub1_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay26_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay27 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x10),
    .en(1'b1),
    .rst(1'b1),
    .q(delay27_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay28 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x8),
    .en(1'b1),
    .rst(1'b1),
    .q(delay28_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay29 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub3_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay29_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(delay29_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay30 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x10),
    .en(1'b1),
    .rst(1'b1),
    .q(delay30_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay31 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x7),
    .en(1'b1),
    .rst(1'b1),
    .q(delay31_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay32 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift6_op_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay32_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay33 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x12),
    .en(1'b1),
    .rst(1'b1),
    .q(delay33_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay35 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay35_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay36 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x7),
    .en(1'b1),
    .rst(1'b1),
    .q(delay36_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay37 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x14),
    .en(1'b1),
    .rst(1'b1),
    .q(delay37_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay39 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x12),
    .en(1'b1),
    .rst(1'b1),
    .q(delay39_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub1_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay40 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x14),
    .en(1'b1),
    .rst(1'b1),
    .q(delay40_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay42 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x12),
    .en(1'b1),
    .rst(1'b1),
    .q(delay42_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay43 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay43_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay44 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift6_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay44_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay47 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift4_op_net_x13),
    .en(1'b1),
    .rst(1'b1),
    .q(delay47_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay48 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay48_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub3_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay51 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift8_op_net_x15),
    .en(1'b1),
    .rst(1'b1),
    .q(delay51_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay54 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x15),
    .en(1'b1),
    .rst(1'b1),
    .q(delay54_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay6 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(addsub5_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay7 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x9),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay8 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x13),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net_x0)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(18))
  delay9 (
    .ce(ce_1_sg_x203),
    .clk(clk_1_sg_x203),
    .d(shift5_op_net_x18),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net_x0)
  );

  x3fir_dedicate_module_b957602124  x3fir_dedicate1_2ddc76f782 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay5_q_net_x1),
    .c0_x(shift8_op_net_x5),
    .c1_x(shift6_op_net_x2),
    .c2_x(shift5_op_net_x5)
  );

  x3fir_dedicate_module_b957602124  x3fir_dedicate2_e4a6e28cb0 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay6_q_net_x1),
    .c0_x(shift8_op_net_x6),
    .c1_x(shift6_op_net_x3),
    .c2_x(shift5_op_net_x6)
  );

  x3fir_dedicate_module_b957602124  x3fir_dedicate3_f224cb2059 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay22_q_net_x0),
    .c0_x(shift8_op_net_x7),
    .c1_x(shift6_op_net_x4),
    .c2_x(shift5_op_net_x7)
  );

  x3fir_dedicate_module_b957602124  x3fir_dedicate_b957602124 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay4_q_net_x1),
    .c0_x(shift8_op_net_x4),
    .c1_x(shift6_op_net_x1),
    .c2_x(shift5_op_net_x4)
  );

  x3fir_general1_module_3881a267b3  x3fir_general10_1af98aaff3 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay1_q_net_x3),
    .c6_x(shift8_op_net_x9),
    .c7_x(shift4_op_net_x3),
    .c8_x(shift5_op_net_x9)
  );

  x3fir_general11_module_8a262408cd  x3fir_general11_8a262408cd (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay1_q_net_x3),
    .c3_x(shift8_op_net_x10),
    .c4_x(shift4_op_net_x4),
    .c5_x(shift5_op_net_x10)
  );

  x3fir_general12_module_68607ba614  x3fir_general12_68607ba614 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay1_q_net_x3),
    .c10_x(shift4_op_net_x10),
    .c11_x(shift5_op_net_x11),
    .c9_x(shift8_op_net_x11)
  );

  x3fir_general1_module_3881a267b3  x3fir_general1_3881a267b3 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay26_q_net_x1),
    .c6_x(shift8_op_net_x8),
    .c7_x(shift4_op_net_x8),
    .c8_x(shift5_op_net_x8)
  );

  x3fir_general11_module_8a262408cd  x3fir_general2_5130d92ff3 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay4_q_net_x1),
    .c3_x(shift8_op_net_x12),
    .c4_x(shift4_op_net_x5),
    .c5_x(shift5_op_net_x12)
  );

  x3fir_general12_module_68607ba614  x3fir_general3_9bfb713100 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay26_q_net_x1),
    .c10_x(shift4_op_net_x11),
    .c11_x(shift5_op_net_x13),
    .c9_x(shift8_op_net_x13)
  );

  x3fir_general1_module_3881a267b3  x3fir_general4_ddf07acc00 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay29_q_net_x0),
    .c6_x(shift8_op_net_x14),
    .c7_x(shift4_op_net_x12),
    .c8_x(shift5_op_net_x14)
  );

  x3fir_general11_module_8a262408cd  x3fir_general5_181a272465 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay5_q_net_x1),
    .c3_x(shift8_op_net_x15),
    .c4_x(shift4_op_net_x13),
    .c5_x(shift5_op_net_x15)
  );

  x3fir_general12_module_68607ba614  x3fir_general6_77bad28deb (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay3_q_net_x0),
    .c10_x(shift4_op_net_x6),
    .c11_x(shift5_op_net_x16),
    .c9_x(shift8_op_net_x16)
  );

  x3fir_general1_module_3881a267b3  x3fir_general7_6d7e9753aa (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay2_q_net_x1),
    .c6_x(shift8_op_net_x17),
    .c7_x(shift4_op_net_x14),
    .c8_x(shift5_op_net_x17)
  );

  x3fir_general11_module_8a262408cd  x3fir_general8_bb1db526ce (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay6_q_net_x1),
    .c3_x(shift8_op_net_x18),
    .c4_x(shift4_op_net_x15),
    .c5_x(shift5_op_net_x18)
  );

  x3fir_general12_module_68607ba614  x3fir_general9_a32ac56924 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .din(delay2_q_net_x1),
    .c10_x(shift4_op_net_x16),
    .c11_x(shift5_op_net_x19),
    .c9_x(shift8_op_net_x19)
  );

  y1_calc_module_7b010a4b16  y1_calc1_c38c16551b (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift8_op_net_x5),
    .in2(shift8_op_net_x12),
    .in3(shift8_op_net_x9),
    .in4(shift8_op_net_x19),
    .in5(shift5_op_net_x16),
    .in6(delay28_q_net_x0),
    .in7(delay30_q_net_x0),
    .in8(delay19_q_net_x0),
    .out1(addsub5_s_net_x39)
  );

  y1_calc_module_7b010a4b16  y1_calc2_0fa734b752 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift8_op_net_x6),
    .in2(shift8_op_net_x15),
    .in3(shift8_op_net_x8),
    .in4(shift8_op_net_x11),
    .in5(shift5_op_net_x19),
    .in6(delay40_q_net_x0),
    .in7(delay42_q_net_x0),
    .in8(delay31_q_net_x0),
    .out1(addsub5_s_net_x40)
  );

  y1_calc_module_7b010a4b16  y1_calc3_840a0928b0 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift8_op_net_x7),
    .in2(shift8_op_net_x18),
    .in3(shift8_op_net_x14),
    .in4(shift8_op_net_x13),
    .in5(shift5_op_net_x11),
    .in6(shift5_op_net_x17),
    .in7(delay54_q_net_x0),
    .in8(delay43_q_net_x0),
    .out1(addsub5_s_net_x41)
  );

  y1_calc_module_7b010a4b16  y1_calc_7b010a4b16 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift8_op_net_x4),
    .in2(shift8_op_net_x10),
    .in3(shift8_op_net_x17),
    .in4(shift8_op_net_x16),
    .in5(delay8_q_net_x0),
    .in6(delay7_q_net_x0),
    .in7(delay9_q_net_x0),
    .in8(delay10_q_net_x0),
    .out1(addsub5_s_net_x38)
  );

  y2_calc1_module_b9fe7ab17a  y2_calc1_b9fe7ab17a (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift5_op_net_x4),
    .in2(shift5_op_net_x10),
    .in3(shift5_op_net_x17),
    .in4(shift5_op_net_x16),
    .in5(delay17_q_net_x0),
    .in6(delay16_q_net_x0),
    .in7(delay18_q_net_x0),
    .in8(delay15_q_net_x0),
    .out1(addsub5_s_net_x43)
  );

  y2_calc_module_fb831e70d6  y2_calc2_78a6a49599 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift6_op_net_x2),
    .in2(shift4_op_net_x5),
    .in3(shift4_op_net_x3),
    .in4(shift4_op_net_x16),
    .in5(shift4_op_net_x6),
    .in6(delay21_q_net_x0),
    .in7(delay23_q_net_x0),
    .in8(delay20_q_net_x0),
    .out1(addsub5_s_net_x44)
  );

  y2_calc1_module_b9fe7ab17a  y2_calc3_e3b355d95c (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift5_op_net_x5),
    .in2(shift5_op_net_x12),
    .in3(shift5_op_net_x9),
    .in4(shift5_op_net_x19),
    .in5(shift8_op_net_x16),
    .in6(delay25_q_net_x0),
    .in7(delay27_q_net_x0),
    .in8(delay24_q_net_x0),
    .out1(addsub5_s_net_x45)
  );

  y2_calc_module_fb831e70d6  y2_calc4_ae003392a6 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift6_op_net_x3),
    .in2(shift4_op_net_x13),
    .in3(shift4_op_net_x8),
    .in4(shift4_op_net_x10),
    .in5(shift4_op_net_x16),
    .in6(delay33_q_net_x0),
    .in7(delay35_q_net_x0),
    .in8(delay32_q_net_x0),
    .out1(addsub5_s_net_x46)
  );

  y2_calc1_module_b9fe7ab17a  y2_calc5_c4371dd778 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift5_op_net_x6),
    .in2(shift5_op_net_x15),
    .in3(shift5_op_net_x8),
    .in4(shift5_op_net_x11),
    .in5(shift8_op_net_x19),
    .in6(delay37_q_net_x0),
    .in7(delay39_q_net_x0),
    .in8(delay36_q_net_x0),
    .out1(addsub5_s_net_x47)
  );

  y2_calc_module_fb831e70d6  y2_calc6_d85b7019e5 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift6_op_net_x4),
    .in2(shift4_op_net_x15),
    .in3(shift4_op_net_x12),
    .in4(shift4_op_net_x11),
    .in5(shift4_op_net_x10),
    .in6(shift4_op_net_x14),
    .in7(delay47_q_net_x0),
    .in8(delay44_q_net_x0),
    .out1(addsub5_s_net_x48)
  );

  y2_calc1_module_b9fe7ab17a  y2_calc7_848d279d30 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift5_op_net_x7),
    .in2(shift5_op_net_x18),
    .in3(shift5_op_net_x14),
    .in4(shift5_op_net_x13),
    .in5(shift8_op_net_x11),
    .in6(shift8_op_net_x17),
    .in7(delay51_q_net_x0),
    .in8(delay48_q_net_x0),
    .out1(addsub5_s_net_x49)
  );

  y2_calc_module_fb831e70d6  y2_calc_fb831e70d6 (
    .ce_1(ce_1_sg_x203),
    .clk_1(clk_1_sg_x203),
    .in1(shift6_op_net_x1),
    .in2(shift4_op_net_x4),
    .in3(shift4_op_net_x14),
    .in4(shift4_op_net_x6),
    .in5(delay13_q_net_x0),
    .in6(delay12_q_net_x0),
    .in7(delay14_q_net_x0),
    .in8(delay11_q_net_x0),
    .out1(addsub5_s_net_x42)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X4FIR Filter1/c0"

module c0_module_8c7fb17193 (
  ce_1,
  clk_1,
  din,
  dout
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [18:0] dout;

  wire [20:0] addsub_s_net;
  wire [0:0] ce_1_sg_x233;
  wire [0:0] clk_1_sg_x233;
  wire [18:0] convert1_dout_net_x0;
  wire [20:0] convert_dout_net;
  wire [15:0] delay9_q_net_x0;
  wire [15:0] delay_q_net;
  wire [20:0] shift1_op_net;
  wire [20:0] shift2_op_net;

  assign ce_1_sg_x233 = ce_1;
  assign clk_1_sg_x233 = clk_1;
  assign delay9_q_net_x0 = din;
  assign dout = convert1_dout_net_x0;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(20),
    .a_width(21),
    .b_arith(`xlSigned),
    .b_bin_pt(20),
    .b_width(21),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(22),
    .core_name0("addsb_11_0_82f1c5fd59d21ea0"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(22),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(20),
    .s_width(21))
  addsub (
    .a(convert_dout_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(20),
    .dout_width(21),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .clr(1'b0),
    .din(delay_q_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(20),
    .din_width(21),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlRound))
  convert1 (
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .clr(1'b0),
    .din(shift2_op_net),
    .en(1'b1),
    .dout(convert1_dout_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .d(delay9_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  shift_5d11edb312  shift1 (
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .clr(1'b0),
    .ip(convert_dout_net),
    .op(shift1_op_net)
  );

  shift_e97ef80d67  shift2 (
    .ce(ce_1_sg_x233),
    .clk(clk_1_sg_x233),
    .clr(1'b0),
    .ip(addsub_s_net),
    .op(shift2_op_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X4FIR Filter1/mult_general"

module mult_general_module_9393106193 (
  c1_x,
  c2_x,
  c3_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [18:0] c1_x;
  output [18:0] c2_x;
  output [18:0] c3_x;

  wire [16:0] addsub1_s_net;
  wire [17:0] addsub2_s_net;
  wire [14:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x234;
  wire [0:0] clk_1_sg_x234;
  wire [16:0] convert1_dout_net;
  wire [14:0] convert2_dout_net;
  wire [17:0] convert3_dout_net;
  wire [18:0] convert4_dout_net;
  wire [18:0] convert5_dout_net;
  wire [18:0] convert6_dout_net;
  wire [6:0] convert7_dout_net;
  wire [8:0] convert8_dout_net;
  wire [9:0] convert9_dout_net;
  wire [8:0] convert_dout_net;
  wire [15:0] delay9_q_net_x1;
  wire [22:0] delay_q_net;
  wire [6:0] lsb1_y_net;
  wire [8:0] reinterpret10_output_port_net;
  wire [6:0] reinterpret11_output_port_net;
  wire [8:0] reinterpret1_output_port_net;
  wire [14:0] reinterpret2_output_port_net;
  wire [6:0] reinterpret3_output_port_net;
  wire [9:0] reinterpret4_output_port_net;
  wire [16:0] reinterpret5_output_port_net;
  wire [17:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [22:0] rom3_data_net;
  wire [49:0] rom_data_net;
  wire [14:0] shift1_op_net;
  wire [16:0] shift2_op_net;
  wire [17:0] shift3_op_net;
  wire [18:0] shift4_op_net_x0;
  wire [18:0] shift5_op_net_x0;
  wire [18:0] shift8_op_net_x0;
  wire [5:0] slice1_y_net;
  wire [16:0] slice2_y_net;
  wire [17:0] slice3_y_net;
  wire [7:0] slice4_y_net;
  wire [8:0] slice5_y_net;
  wire [14:0] slice_y_net;

  assign c1_x = shift8_op_net_x0;
  assign c2_x = shift4_op_net_x0;
  assign c3_x = shift5_op_net_x0;
  assign ce_1_sg_x234 = ce_1;
  assign clk_1_sg_x234 = clk_1;
  assign delay9_q_net_x1 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(16),
    .a_width(17),
    .b_arith(`xlSigned),
    .b_bin_pt(16),
    .b_width(17),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(18),
    .core_name0("addsb_11_0_0e0e0a285ef7a16d"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(18),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(16),
    .s_width(17))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(14),
    .a_width(15),
    .b_arith(`xlSigned),
    .b_bin_pt(14),
    .b_width(15),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(16),
    .core_name0("addsb_11_0_f392a1f2f071bf23"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(16),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(14),
    .s_width(15))
  addsub3 (
    .a(reinterpret2_output_port_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(8),
    .din_width(9),
    .dout_arith(2),
    .dout_bin_pt(16),
    .dout_width(17),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(6),
    .din_width(7),
    .dout_arith(2),
    .dout_bin_pt(14),
    .dout_width(15),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(9),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(14),
    .din_width(15),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(16),
    .din_width(17),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(6),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(7),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(slice1_y_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(8),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(slice4_y_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(9),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .din(slice5_y_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(23))
  delay (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(16),
    .y_width(7))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_81e883cd82  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert8_dout_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_34f6390c19  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_016d92ab20  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_6200c8761b  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_8eee8341d8  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert7_dout_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_fd8afbe046  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert9_dout_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_79f2a2c095  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_87da68fdf8  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay9_q_net_x1),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(9),
    .c_width(50),
    .core_name0("bmg_72_b297e10d233cb875"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(7),
    .c_address_width(7),
    .c_width(23),
    .core_name0("dmg_72_53c8fda674a6c63d"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_447ff429c9  shift1 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift1_op_net)
  );

  shift_0be5f5842d  shift2 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_13f7182392  shift3 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_0b3d34a3d5  shift4 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift4_op_net_x0)
  );

  shift_091db5281e  shift5 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_bc177199ac  shift8 (
    .ce(ce_1_sg_x234),
    .clk(clk_1_sg_x234),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(14),
    .x_width(50),
    .y_width(15))
  slice (
    .x(rom_data_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(5),
    .x_width(23),
    .y_width(6))
  slice1 (
    .x(delay_q_net),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(15),
    .new_msb(31),
    .x_width(50),
    .y_width(17))
  slice2 (
    .x(rom_data_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(32),
    .new_msb(49),
    .x_width(50),
    .y_width(18))
  slice3 (
    .x(rom_data_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(6),
    .new_msb(13),
    .x_width(23),
    .y_width(8))
  slice4 (
    .x(delay_q_net),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(14),
    .new_msb(22),
    .x_width(23),
    .y_width(9))
  slice5 (
    .x(delay_q_net),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X4FIR Filter1/mult_general1"

module mult_general1_module_f0d6a56532 (
  c4_x,
  c5_x,
  c6_x,
  ce_1,
  clk_1,
  din
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] din;
  output [18:0] c4_x;
  output [18:0] c5_x;
  output [18:0] c6_x;

  wire [18:0] addsub1_s_net;
  wire [18:0] addsub2_s_net;
  wire [17:0] addsub3_s_net;
  wire [0:0] ce_1_sg_x235;
  wire [0:0] clk_1_sg_x235;
  wire [18:0] convert1_dout_net;
  wire [17:0] convert2_dout_net;
  wire [18:0] convert3_dout_net;
  wire [18:0] convert4_dout_net;
  wire [18:0] convert5_dout_net;
  wire [18:0] convert6_dout_net;
  wire [9:0] convert7_dout_net;
  wire [10:0] convert8_dout_net;
  wire [10:0] convert9_dout_net;
  wire [8:0] convert_dout_net;
  wire [28:0] delay_q_net_x0;
  wire [15:0] delay_q_net_x1;
  wire [6:0] lsb1_y_net;
  wire [8:0] reinterpret10_output_port_net;
  wire [6:0] reinterpret11_output_port_net;
  wire [10:0] reinterpret1_output_port_net;
  wire [17:0] reinterpret2_output_port_net;
  wire [9:0] reinterpret3_output_port_net;
  wire [10:0] reinterpret4_output_port_net;
  wire [18:0] reinterpret5_output_port_net;
  wire [18:0] reinterpret6_output_port_net;
  wire [15:0] reinterpret9_output_port_net;
  wire [28:0] rom3_data_net;
  wire [55:0] rom_data_net;
  wire [17:0] shift1_op_net;
  wire [18:0] shift2_op_net;
  wire [18:0] shift3_op_net;
  wire [18:0] shift4_op_net_x0;
  wire [18:0] shift5_op_net_x0;
  wire [18:0] shift8_op_net_x0;
  wire [8:0] slice1_y_net;
  wire [18:0] slice2_y_net;
  wire [18:0] slice3_y_net;
  wire [9:0] slice4_y_net;
  wire [9:0] slice5_y_net;
  wire [17:0] slice_y_net;

  assign c4_x = shift8_op_net_x0;
  assign c5_x = shift4_op_net_x0;
  assign c6_x = shift5_op_net_x0;
  assign ce_1_sg_x235 = ce_1;
  assign clk_1_sg_x235 = clk_1;
  assign delay_q_net_x1 = din;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub1 (
    .a(reinterpret5_output_port_net),
    .b(shift2_op_net),
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub2 (
    .a(reinterpret6_output_port_net),
    .b(shift3_op_net),
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(17),
    .a_width(18),
    .b_arith(`xlSigned),
    .b_bin_pt(17),
    .b_width(18),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(19),
    .core_name0("addsb_11_0_490e4beeb7992ef4"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(19),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(17),
    .s_width(18))
  addsub3 (
    .a(reinterpret2_output_port_net),
    .b(shift1_op_net),
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(7),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(0),
    .dout_width(9),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(reinterpret9_output_port_net),
    .en(1'b1),
    .dout(convert_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(10),
    .din_width(11),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(reinterpret1_output_port_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(9),
    .din_width(10),
    .dout_arith(2),
    .dout_bin_pt(17),
    .dout_width(18),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(reinterpret3_output_port_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(10),
    .din_width(11),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(reinterpret4_output_port_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(17),
    .din_width(18),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(addsub3_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert5 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(addsub1_s_net),
    .en(1'b1),
    .dout(convert5_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(18),
    .dout_width(19),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert6 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(addsub2_s_net),
    .en(1'b1),
    .dout(convert6_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(9),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(10),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert7 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(slice1_y_net),
    .en(1'b1),
    .dout(convert7_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(10),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(11),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert8 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(slice4_y_net),
    .en(1'b1),
    .dout(convert8_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(10),
    .dout_arith(1),
    .dout_bin_pt(0),
    .dout_width(11),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert9 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .din(slice5_y_net),
    .en(1'b1),
    .dout(convert9_dout_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(29))
  delay (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .d(rom3_data_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(6),
    .x_width(16),
    .y_width(7))
  lsb1 (
    .x(reinterpret9_output_port_net),
    .y(lsb1_y_net)
  );

  reinterpret_7fc77e4dea  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert8_dout_net),
    .output_port(reinterpret1_output_port_net)
  );

  reinterpret_34f6390c19  reinterpret10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert_dout_net),
    .output_port(reinterpret10_output_port_net)
  );

  reinterpret_016d92ab20  reinterpret11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(lsb1_y_net),
    .output_port(reinterpret11_output_port_net)
  );

  reinterpret_87da68fdf8  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice_y_net),
    .output_port(reinterpret2_output_port_net)
  );

  reinterpret_fd8afbe046  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert7_dout_net),
    .output_port(reinterpret3_output_port_net)
  );

  reinterpret_7fc77e4dea  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(convert9_dout_net),
    .output_port(reinterpret4_output_port_net)
  );

  reinterpret_888f8372ca  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice2_y_net),
    .output_port(reinterpret5_output_port_net)
  );

  reinterpret_888f8372ca  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(slice3_y_net),
    .output_port(reinterpret6_output_port_net)
  );

  reinterpret_81b71e1f8b  reinterpret9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay_q_net_x1),
    .output_port(reinterpret9_output_port_net)
  );

  xlsprom_duc_16ch_341 #(

    .c_address_width(9),
    .c_width(56),
    .core_name0("bmg_72_a3b5d83d934b45b5"),
    .latency(1))
  rom (
    .addr(reinterpret10_output_port_net),
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .en(1'b1),
    .rst(1'b0),
    .data(rom_data_net)
  );

  xlsprom_dist_duc_16ch_341 #(

    .addr_width(7),
    .c_address_width(7),
    .c_width(29),
    .core_name0("dmg_72_9651f078ad2c9f1b"),
    .latency(1))
  rom3 (
    .addr(reinterpret11_output_port_net),
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .en(1'b1),
    .data(rom3_data_net)
  );

  shift_13f7182392  shift1 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert2_dout_net),
    .op(shift1_op_net)
  );

  shift_ca62c0bb60  shift2 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert1_dout_net),
    .op(shift2_op_net)
  );

  shift_ca62c0bb60  shift3 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert3_dout_net),
    .op(shift3_op_net)
  );

  shift_c01ac94bc0  shift4 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert5_dout_net),
    .op(shift4_op_net_x0)
  );

  shift_c01ac94bc0  shift5 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert6_dout_net),
    .op(shift5_op_net_x0)
  );

  shift_091db5281e  shift8 (
    .ce(ce_1_sg_x235),
    .clk(clk_1_sg_x235),
    .clr(1'b0),
    .ip(convert4_dout_net),
    .op(shift8_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(17),
    .x_width(56),
    .y_width(18))
  slice (
    .x(rom_data_net),
    .y(slice_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(8),
    .x_width(29),
    .y_width(9))
  slice1 (
    .x(delay_q_net_x0),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(18),
    .new_msb(36),
    .x_width(56),
    .y_width(19))
  slice2 (
    .x(rom_data_net),
    .y(slice2_y_net)
  );

  xlslice #(

    .new_lsb(37),
    .new_msb(55),
    .x_width(56),
    .y_width(19))
  slice3 (
    .x(rom_data_net),
    .y(slice3_y_net)
  );

  xlslice #(

    .new_lsb(9),
    .new_msb(18),
    .x_width(29),
    .y_width(10))
  slice4 (
    .x(delay_q_net_x0),
    .y(slice4_y_net)
  );

  xlslice #(

    .new_lsb(19),
    .new_msb(28),
    .x_width(29),
    .y_width(10))
  slice5 (
    .x(delay_q_net_x0),
    .y(slice5_y_net)
  );
endmodule
// Generated from Simulink block "duc_16ch_341/X4FIR Filter1"

module x4fir_filter1_module_d5db126e54 (
  ce_1,
  clk_1,
  in1,
  out1,
  out2,
  out3,
  out4,
  valid_in
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [15:0] in1;
  input [0:0] valid_in;
  output [15:0] out1;
  output [15:0] out2;
  output [15:0] out3;
  output [15:0] out4;

  wire [18:0] addsub10_s_net;
  wire [18:0] addsub11_s_net;
  wire [18:0] addsub12_s_net;
  wire [18:0] addsub13_s_net;
  wire [18:0] addsub1_s_net;
  wire [18:0] addsub2_s_net;
  wire [18:0] addsub3_s_net;
  wire [18:0] addsub4_s_net;
  wire [18:0] addsub5_s_net;
  wire [18:0] addsub6_s_net;
  wire [18:0] addsub7_s_net;
  wire [18:0] addsub8_s_net;
  wire [18:0] addsub9_s_net;
  wire [0:0] ce_1_sg_x236;
  wire [0:0] clk_1_sg_x236;
  wire [18:0] constant_op_net;
  wire [15:0] convert1_dout_net;
  wire [18:0] convert1_dout_net_x0;
  wire [15:0] convert2_dout_net;
  wire [15:0] convert3_dout_net;
  wire [15:0] convert4_dout_net;
  wire [1:0] counter_op_net;
  wire [1:0] delay10_q_net;
  wire [1:0] delay11_q_net;
  wire [1:0] delay12_q_net;
  wire [15:0] delay13_q_net_x2;
  wire [15:0] delay14_q_net_x2;
  wire [15:0] delay15_q_net_x2;
  wire [18:0] delay16_q_net;
  wire [0:0] delay17_q_net_x1;
  wire [0:0] delay1_q_net;
  wire [15:0] delay1_q_net_x5;
  wire [18:0] delay2_q_net;
  wire [15:0] delay3_q_net;
  wire [15:0] delay4_q_net;
  wire [15:0] delay5_q_net;
  wire [18:0] delay6_q_net;
  wire [18:0] delay7_q_net;
  wire [18:0] delay8_q_net;
  wire [15:0] delay9_q_net_x1;
  wire [15:0] delay_q_net_x1;
  wire [15:0] mux1_y_net;
  wire [15:0] mux2_y_net;
  wire [15:0] mux3_y_net_x2;
  wire [15:0] mux_y_net;
  wire [18:0] shift4_op_net_x0;
  wire [18:0] shift4_op_net_x1;
  wire [18:0] shift5_op_net_x0;
  wire [18:0] shift5_op_net_x1;
  wire [18:0] shift8_op_net_x0;
  wire [18:0] shift8_op_net_x1;

  assign ce_1_sg_x236 = ce_1;
  assign clk_1_sg_x236 = clk_1;
  assign delay1_q_net_x5 = in1;
  assign out1 = delay15_q_net_x2;
  assign out2 = delay14_q_net_x2;
  assign out3 = delay13_q_net_x2;
  assign out4 = mux3_y_net_x2;
  assign delay17_q_net_x1 = valid_in;


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub1 (
    .a(delay16_q_net),
    .b(shift4_op_net_x1),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub10 (
    .a(addsub9_s_net),
    .b(constant_op_net),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub10_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub11 (
    .a(addsub13_s_net),
    .b(constant_op_net),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub11_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub12 (
    .a(addsub2_s_net),
    .b(convert1_dout_net_x0),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub12_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub13 (
    .a(addsub1_s_net),
    .b(shift5_op_net_x0),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub13_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub2 (
    .a(addsub5_s_net),
    .b(shift8_op_net_x1),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub3 (
    .a(delay7_q_net),
    .b(shift4_op_net_x1),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub4 (
    .a(addsub3_s_net),
    .b(shift8_op_net_x0),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub5 (
    .a(delay6_q_net),
    .b(delay2_q_net),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub6 (
    .a(delay8_q_net),
    .b(shift5_op_net_x1),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub7 (
    .a(addsub12_s_net),
    .b(constant_op_net),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub7_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub8 (
    .a(addsub4_s_net),
    .b(constant_op_net),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub8_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(18),
    .a_width(19),
    .b_arith(`xlSigned),
    .b_bin_pt(18),
    .b_width(19),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(20),
    .core_name0("addsb_11_0_cfbd5258ba626a7a"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(20),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(18),
    .s_width(19))
  addsub9 (
    .a(addsub6_s_net),
    .b(shift4_op_net_x0),
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net)
  );

  c0_module_8c7fb17193  c0_8c7fb17193 (
    .ce_1(ce_1_sg_x236),
    .clk_1(clk_1_sg_x236),
    .din(delay9_q_net_x1),
    .dout(convert1_dout_net_x0)
  );

  constant_c3c0af03bb  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert1 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .din(addsub7_s_net),
    .en(1'b1),
    .dout(convert1_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert2 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .din(addsub10_s_net),
    .en(1'b1),
    .dout(convert2_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert3 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .din(addsub11_s_net),
    .en(1'b1),
    .dout(convert3_dout_net)
  );

  xlconvert #(

    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(18),
    .din_width(19),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate))
  convert4 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .din(addsub8_s_net),
    .en(1'b1),
    .dout(convert4_dout_net)
  );

  xlcounter_free_duc_16ch_341 #(

    .core_name0("cntr_11_0_76451075d188e63f"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .en(1'b1),
    .rst(delay1_q_net),
    .op(counter_op_net)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(delay9_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net_x1)
  );

  xldelay #(

    .latency(20),
    .reg_retiming(0),
    .reset(0),
    .width(1))
  delay1 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(delay17_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay10 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(counter_op_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay11 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(counter_op_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(2))
  delay12 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(counter_op_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay13 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(mux2_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net_x2)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay14 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(mux1_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x2)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay15 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(mux_y_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x2)
  );

  xldelay #(

    .latency(7),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay16 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(shift8_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay16_q_net)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay2 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(shift8_op_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(convert4_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  xldelay #(

    .latency(2),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(convert2_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(convert3_dout_net),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net)
  );

  xldelay #(

    .latency(10),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay6 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(convert1_dout_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net)
  );

  xldelay #(

    .latency(7),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay7 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(shift5_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net)
  );

  xldelay #(

    .latency(7),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay8 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(shift4_op_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net)
  );

  xldelay #(

    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay9 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .d(delay1_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net_x1)
  );

  mult_general1_module_f0d6a56532  mult_general1_f0d6a56532 (
    .ce_1(ce_1_sg_x236),
    .clk_1(clk_1_sg_x236),
    .din(delay_q_net_x1),
    .c4_x(shift8_op_net_x1),
    .c5_x(shift4_op_net_x1),
    .c6_x(shift5_op_net_x1)
  );

  mult_general_module_9393106193  mult_general_9393106193 (
    .ce_1(ce_1_sg_x236),
    .clk_1(clk_1_sg_x236),
    .din(delay9_q_net_x1),
    .c1_x(shift8_op_net_x0),
    .c2_x(shift4_op_net_x0),
    .c3_x(shift5_op_net_x0)
  );

  mux_a6eee4b271  mux (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .d0(convert1_dout_net),
    .d1(delay3_q_net),
    .d2(delay4_q_net),
    .d3(delay5_q_net),
    .sel(counter_op_net),
    .y(mux_y_net)
  );

  mux_a6eee4b271  mux1 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .d0(convert1_dout_net),
    .d1(delay3_q_net),
    .d2(delay4_q_net),
    .d3(delay5_q_net),
    .sel(delay12_q_net),
    .y(mux1_y_net)
  );

  mux_a6eee4b271  mux2 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .d0(convert1_dout_net),
    .d1(delay3_q_net),
    .d2(delay4_q_net),
    .d3(delay5_q_net),
    .sel(delay10_q_net),
    .y(mux2_y_net)
  );

  mux_a6eee4b271  mux3 (
    .ce(ce_1_sg_x236),
    .clk(clk_1_sg_x236),
    .clr(1'b0),
    .d0(convert1_dout_net),
    .d1(delay3_q_net),
    .d2(delay4_q_net),
    .d3(delay5_q_net),
    .sel(delay11_q_net),
    .y(mux3_y_net_x2)
  );
endmodule
// Generated from Simulink block "duc_16ch_341"

(* core_generation_info = "duc_16ch_341,sysgen_core,{clock_period=2.92900000,clocking=Clock_Enables,compilation=HDL_Netlist,sample_periods=1.00000000000,testbench=0,total_blocks=8029,xilinx_accumulator_block=16,xilinx_adder_subtracter_block=738,xilinx_binary_shift_operator_block=524,xilinx_bit_slice_extractor_block=370,xilinx_bus_concatenator_block=6,xilinx_bus_multiplexer_block=64,xilinx_constant_block_block=277,xilinx_counter_block=25,xilinx_delay_block=684,xilinx_dsp48e1_block=191,xilinx_dual_port_random_access_memory_block=22,xilinx_fdatool_interface_block=6,xilinx_gateway_in_block=79,xilinx_gateway_out_block=20,xilinx_instruction_block_block=127,xilinx_inverter_block=9,xilinx_logical_block_block=8,xilinx_register_block=96,xilinx_single_port_read_only_memory_block=126,xilinx_system_generator_block=1,xilinx_type_converter_block=1182,xilinx_type_reinterpreter_block=951,}" *)
module duc_16ch_341 (
  ce_1,
  clk_1,
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

  input [0:0] ce_1;
  input [0:0] clk_1;
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

  wire [15:0] addsub10_s_net;
  wire [15:0] addsub11_s_net_x0;
  wire [15:0] addsub12_s_net;
  wire [15:0] addsub13_s_net_x0;
  wire [15:0] addsub14_s_net;
  wire [15:0] addsub15_s_net_x0;
  wire [15:0] addsub1_s_net_x0;
  wire [15:0] addsub1_s_net_x2;
  wire [15:0] addsub1_s_net_x3;
  wire [15:0] addsub1_s_net_x4;
  wire [15:0] addsub1_s_net_x5;
  wire [15:0] addsub2_s_net;
  wire [15:0] addsub3_s_net_x0;
  wire [15:0] addsub3_s_net_x10;
  wire [15:0] addsub3_s_net_x11;
  wire [15:0] addsub3_s_net_x12;
  wire [15:0] addsub3_s_net_x13;
  wire [15:0] addsub3_s_net_x14;
  wire [15:0] addsub3_s_net_x15;
  wire [15:0] addsub3_s_net_x16;
  wire [15:0] addsub3_s_net_x17;
  wire [15:0] addsub3_s_net_x6;
  wire [15:0] addsub3_s_net_x7;
  wire [15:0] addsub3_s_net_x8;
  wire [15:0] addsub3_s_net_x9;
  wire [18:0] addsub42_s_net_x0;
  wire [18:0] addsub42_s_net_x1;
  wire [18:0] addsub42_s_net_x2;
  wire [18:0] addsub43_s_net_x0;
  wire [18:0] addsub43_s_net_x1;
  wire [18:0] addsub43_s_net_x2;
  wire [15:0] addsub4_s_net;
  wire [15:0] addsub5_s_net_x0;
  wire [17:0] addsub5_s_net_x38;
  wire [17:0] addsub5_s_net_x39;
  wire [17:0] addsub5_s_net_x40;
  wire [17:0] addsub5_s_net_x41;
  wire [17:0] addsub5_s_net_x42;
  wire [17:0] addsub5_s_net_x43;
  wire [17:0] addsub5_s_net_x44;
  wire [17:0] addsub5_s_net_x45;
  wire [17:0] addsub5_s_net_x46;
  wire [17:0] addsub5_s_net_x47;
  wire [17:0] addsub5_s_net_x48;
  wire [17:0] addsub5_s_net_x49;
  wire [17:0] addsub5_s_net_x50;
  wire [17:0] addsub5_s_net_x51;
  wire [17:0] addsub5_s_net_x52;
  wire [17:0] addsub5_s_net_x53;
  wire [17:0] addsub5_s_net_x54;
  wire [17:0] addsub5_s_net_x55;
  wire [17:0] addsub5_s_net_x56;
  wire [17:0] addsub5_s_net_x57;
  wire [17:0] addsub5_s_net_x58;
  wire [17:0] addsub5_s_net_x59;
  wire [17:0] addsub5_s_net_x60;
  wire [17:0] addsub5_s_net_x61;
  wire [15:0] addsub6_s_net;
  wire [15:0] addsub7_s_net_x0;
  wire [15:0] addsub8_s_net;
  wire [15:0] addsub9_s_net_x0;
  wire [15:0] addsub_s_net;
  wire [0:0] ce_1_sg_x265;
  wire [0:0] clk_1_sg_x265;
  wire [15:0] convert3_dout_net_x3;
  wire [15:0] convert3_dout_net_x4;
  wire [15:0] convert3_dout_net_x5;
  wire [15:0] convert3_dout_net_x6;
  wire [15:0] convert3_dout_net_x7;
  wire [15:0] convert3_dout_net_x8;
  wire [15:0] convert4_dout_net_x48;
  wire [15:0] convert4_dout_net_x49;
  wire [15:0] convert4_dout_net_x50;
  wire [15:0] convert4_dout_net_x51;
  wire [15:0] convert4_dout_net_x52;
  wire [15:0] convert4_dout_net_x53;
  wire [15:0] convert4_dout_net_x54;
  wire [15:0] convert4_dout_net_x55;
  wire [15:0] convert4_dout_net_x56;
  wire [15:0] convert4_dout_net_x57;
  wire [15:0] convert4_dout_net_x58;
  wire [15:0] convert4_dout_net_x59;
  wire [15:0] convert4_dout_net_x60;
  wire [15:0] convert4_dout_net_x61;
  wire [15:0] convert4_dout_net_x62;
  wire [15:0] convert4_dout_net_x63;
  wire [15:0] convert5_dout_net_x48;
  wire [15:0] convert5_dout_net_x49;
  wire [15:0] convert5_dout_net_x50;
  wire [15:0] convert5_dout_net_x51;
  wire [15:0] convert5_dout_net_x52;
  wire [15:0] convert5_dout_net_x53;
  wire [15:0] convert5_dout_net_x54;
  wire [15:0] convert5_dout_net_x55;
  wire [15:0] convert5_dout_net_x56;
  wire [15:0] convert5_dout_net_x57;
  wire [15:0] convert5_dout_net_x58;
  wire [15:0] convert5_dout_net_x59;
  wire [15:0] convert5_dout_net_x60;
  wire [15:0] convert5_dout_net_x61;
  wire [15:0] convert5_dout_net_x62;
  wire [15:0] convert5_dout_net_x63;
  wire [15:0] delay10_q_net_x2;
  wire [15:0] delay11_q_net_x2;
  wire [15:0] delay12_q_net_x2;
  wire [15:0] delay13_q_net_x10;
  wire [15:0] delay13_q_net_x2;
  wire [15:0] delay13_q_net_x3;
  wire [15:0] delay13_q_net_x4;
  wire [15:0] delay13_q_net_x5;
  wire [15:0] delay13_q_net_x6;
  wire [15:0] delay13_q_net_x7;
  wire [15:0] delay13_q_net_x8;
  wire [15:0] delay13_q_net_x9;
  wire [15:0] delay14_q_net_x10;
  wire [15:0] delay14_q_net_x2;
  wire [15:0] delay14_q_net_x3;
  wire [15:0] delay14_q_net_x4;
  wire [15:0] delay14_q_net_x5;
  wire [15:0] delay14_q_net_x6;
  wire [15:0] delay14_q_net_x7;
  wire [15:0] delay14_q_net_x8;
  wire [15:0] delay14_q_net_x9;
  wire [15:0] delay15_q_net_x0;
  wire [15:0] delay15_q_net_x1;
  wire [15:0] delay15_q_net_x10;
  wire [15:0] delay15_q_net_x11;
  wire [15:0] delay15_q_net_x12;
  wire [15:0] delay15_q_net_x13;
  wire [15:0] delay15_q_net_x14;
  wire [15:0] delay15_q_net_x2;
  wire [15:0] delay15_q_net_x3;
  wire [15:0] delay15_q_net_x4;
  wire [15:0] delay15_q_net_x5;
  wire [15:0] delay15_q_net_x6;
  wire [15:0] delay15_q_net_x7;
  wire [15:0] delay15_q_net_x8;
  wire [15:0] delay15_q_net_x9;
  wire [15:0] delay16_q_net_x0;
  wire [15:0] delay16_q_net_x1;
  wire [15:0] delay16_q_net_x2;
  wire [15:0] delay16_q_net_x3;
  wire [15:0] delay16_q_net_x4;
  wire [15:0] delay16_q_net_x5;
  wire [0:0] delay17_q_net_x4;
  wire [0:0] delay17_q_net_x5;
  wire [15:0] delay1_q_net;
  wire [15:0] delay1_q_net_x10;
  wire [15:0] delay1_q_net_x11;
  wire [15:0] delay1_q_net_x12;
  wire [15:0] delay1_q_net_x13;
  wire [15:0] delay1_q_net_x14;
  wire [15:0] delay1_q_net_x2;
  wire [15:0] delay1_q_net_x3;
  wire [15:0] delay1_q_net_x5;
  wire [15:0] delay1_q_net_x6;
  wire [15:0] delay1_q_net_x7;
  wire [15:0] delay1_q_net_x8;
  wire [15:0] delay1_q_net_x9;
  wire [15:0] delay24_q_net_x2;
  wire [15:0] delay25_q_net_x2;
  wire [15:0] delay26_q_net_x2;
  wire [15:0] delay27_q_net_x2;
  wire [15:0] delay28_q_net_x2;
  wire [15:0] delay29_q_net_x2;
  wire [15:0] delay2_q_net;
  wire [15:0] delay30_q_net_x2;
  wire [15:0] delay31_q_net_x2;
  wire [0:0] delay34_q_net_x2;
  wire [15:0] delay3_q_net;
  wire [15:0] delay3_q_net_x0;
  wire [15:0] delay3_q_net_x1;
  wire [15:0] delay3_q_net_x2;
  wire [15:0] delay3_q_net_x3;
  wire [15:0] delay3_q_net_x4;
  wire [15:0] delay3_q_net_x5;
  wire [18:0] delay45_q_net;
  wire [18:0] delay46_q_net;
  wire [18:0] delay47_q_net;
  wire [18:0] delay48_q_net;
  wire [18:0] delay49_q_net;
  wire [15:0] delay4_q_net;
  wire [18:0] delay50_q_net;
  wire [15:0] delay5_q_net;
  wire [15:0] delay6_q_net;
  wire [15:0] delay7_q_net;
  wire [15:0] delay7_q_net_x0;
  wire [15:0] delay7_q_net_x1;
  wire [15:0] delay7_q_net_x2;
  wire [15:0] delay7_q_net_x3;
  wire [15:0] delay7_q_net_x4;
  wire [15:0] delay7_q_net_x5;
  wire [15:0] delay8_q_net_x2;
  wire [15:0] delay9_q_net_x2;
  wire [15:0] delay_q_net;
  wire [15:0] delay_q_net_x3;
  wire [15:0] delay_q_net_x5;
  wire [15:0] delay_q_net_x6;
  wire [15:0] delay_q_net_x7;
  wire [15:0] delay_q_net_x8;
  wire [15:0] delay_q_net_x9;
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
  wire [15:0] mux3_y_net_x2;
  wire [15:0] mux3_y_net_x3;
  wire [15:0] mux3_y_net_x4;
  wire [15:0] mux3_y_net_x5;
  wire [15:0] mux3_y_net_x6;
  wire [15:0] mux3_y_net_x7;
  wire [15:0] mux3_y_net_x8;
  wire [15:0] mux3_y_net_x9;
  wire [18:0] reinterpret1_output_port_net_x1;
  wire [18:0] reinterpret2_output_port_net_x1;
  wire [18:0] reinterpret3_output_port_net_x1;
  wire [18:0] reinterpret4_output_port_net_x1;
  wire [18:0] reinterpret5_output_port_net_x1;
  wire [18:0] reinterpret6_output_port_net_x1;
  wire [0:0] rst_net;

  assign ce_1_sg_x265 = ce_1;
  assign clk_1_sg_x265 = clk_1;
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


  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub (
    .a(addsub1_s_net_x4),
    .b(addsub1_s_net_x2),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub1 (
    .a(addsub_s_net),
    .b(delay_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub1_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub10 (
    .a(addsub3_s_net_x15),
    .b(addsub3_s_net_x9),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub10_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub11 (
    .a(addsub10_s_net),
    .b(delay5_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub11_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub12 (
    .a(addsub3_s_net_x16),
    .b(addsub3_s_net_x10),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub12_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub13 (
    .a(addsub12_s_net),
    .b(delay6_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub13_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub14 (
    .a(addsub3_s_net_x17),
    .b(addsub3_s_net_x11),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub14_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub15 (
    .a(addsub14_s_net),
    .b(delay7_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub15_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub2 (
    .a(addsub3_s_net_x12),
    .b(addsub3_s_net_x6),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub2_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub3 (
    .a(addsub2_s_net),
    .b(delay1_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub3_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub4 (
    .a(addsub3_s_net_x13),
    .b(addsub3_s_net_x7),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub4_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub5 (
    .a(addsub4_s_net),
    .b(delay2_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub5_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub6 (
    .a(addsub3_s_net_x14),
    .b(addsub3_s_net_x8),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub6_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub7 (
    .a(addsub6_s_net),
    .b(delay3_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub7_s_net_x0)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub8 (
    .a(addsub1_s_net_x5),
    .b(addsub1_s_net_x3),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub8_s_net)
  );

  xladdsub_duc_16ch_341 #(

    .a_arith(`xlSigned),
    .a_bin_pt(15),
    .a_width(16),
    .b_arith(`xlSigned),
    .b_bin_pt(15),
    .b_width(16),
    .c_has_c_out(0),
    .c_latency(1),
    .c_output_width(17),
    .core_name0("addsb_11_0_3b5cfe2278dc7df8"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(17),
    .latency(1),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlSigned),
    .s_bin_pt(15),
    .s_width(16))
  addsub9 (
    .a(addsub8_s_net),
    .b(delay4_q_net),
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub9_s_net_x0)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay1 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay1_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay10 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay10_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay11 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay11_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay12 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay12_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay13 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay13_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay14 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay14_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay15 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay15_q_net_x2)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay2 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay24 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay24_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay25 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay25_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay26 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay26_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay27 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay27_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay28 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay28_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay29 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay29_q_net_x2)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay3 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x4),
    .en(1'b1),
    .rst(1'b1),
    .q(delay3_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay30 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x5),
    .en(1'b1),
    .rst(1'b1),
    .q(delay30_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay31 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x6),
    .en(1'b1),
    .rst(1'b1),
    .q(delay31_q_net_x2)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay4 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay4_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay45 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub42_s_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay45_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay46 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub43_s_net_x1),
    .en(1'b1),
    .rst(1'b1),
    .q(delay46_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay47 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub42_s_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay47_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay48 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub43_s_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay48_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay49 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub42_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay49_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay5 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay5_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(19))
  delay50 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(addsub43_s_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay50_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay6 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay16_q_net_x2),
    .en(1'b1),
    .rst(1'b1),
    .q(delay6_q_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay7 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay15_q_net_x3),
    .en(1'b1),
    .rst(1'b1),
    .q(delay7_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay8 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay7_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay8_q_net_x2)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(16))
  delay9 (
    .ce(ce_1_sg_x265),
    .clk(clk_1_sg_x265),
    .d(delay3_q_net_x0),
    .en(1'b1),
    .rst(1'b1),
    .q(delay9_q_net_x2)
  );

  hbf1_filter_module_9817535529  hbf1_filter_9817535529 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(din1_net),
    .in2(din2_net),
    .rst(rst_net),
    .out1(delay_q_net_x5),
    .out2(delay1_q_net_x3),
    .out3(delay_q_net_x6),
    .out4(delay1_q_net_x5),
    .valid_out(delay34_q_net_x2)
  );

  hbf2_filter_module_d8198f572c  hbf2_filter2_f2a48c83ea (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x6),
    .in2(delay1_q_net_x5),
    .valid_in(delay34_q_net_x2),
    .out1(delay_q_net_x3),
    .out2(delay1_q_net_x8),
    .out3(delay_q_net_x9),
    .out4(delay1_q_net_x9),
    .valid_out(delay17_q_net_x5)
  );

  hbf2_filter_module_d8198f572c  hbf2_filter_d8198f572c (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x5),
    .in2(delay1_q_net_x3),
    .valid_in(delay34_q_net_x2),
    .out1(delay_q_net_x7),
    .out2(delay1_q_net_x6),
    .out3(delay_q_net_x8),
    .out4(delay1_q_net_x7),
    .valid_out(delay17_q_net_x4)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter1_f2a845dab1 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret4_output_port_net_x1),
    .y1(delay1_q_net_x10),
    .y2(convert3_dout_net_x4)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter2_167001775c (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret6_output_port_net_x1),
    .y1(delay1_q_net_x11),
    .y2(convert3_dout_net_x5)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter3_9d76a0560f (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret1_output_port_net_x1),
    .y1(delay1_q_net_x12),
    .y2(convert3_dout_net_x6)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter4_adbfeadc22 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret2_output_port_net_x1),
    .y1(delay1_q_net_x13),
    .y2(convert3_dout_net_x7)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter5_42cb15d699 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret3_output_port_net_x1),
    .y1(delay1_q_net_x14),
    .y2(convert3_dout_net_x8)
  );

  hbf3_filter_module_bbc5cff1b4  hbf3_filter_bbc5cff1b4 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .xn(reinterpret5_output_port_net_x1),
    .y1(delay1_q_net_x2),
    .y2(convert3_dout_net_x3)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter1_b92763b168 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x13),
    .x2(convert3_dout_net_x7),
    .y1(delay7_q_net_x1),
    .y2(delay3_q_net_x1),
    .y3(delay16_q_net_x1),
    .y4(delay15_q_net_x1)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter2_2651e20170 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x12),
    .x2(convert3_dout_net_x6),
    .y1(delay7_q_net_x2),
    .y2(delay3_q_net_x2),
    .y3(delay16_q_net_x2),
    .y4(delay15_q_net_x3)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter3_f05b81a80b (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x11),
    .x2(convert3_dout_net_x5),
    .y1(delay7_q_net_x3),
    .y2(delay3_q_net_x3),
    .y3(delay16_q_net_x3),
    .y4(delay15_q_net_x4)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter4_9b831ca212 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x10),
    .x2(convert3_dout_net_x4),
    .y1(delay7_q_net_x4),
    .y2(delay3_q_net_x4),
    .y3(delay16_q_net_x4),
    .y4(delay15_q_net_x5)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter5_2751400e66 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x14),
    .x2(convert3_dout_net_x8),
    .y1(delay7_q_net_x5),
    .y2(delay3_q_net_x5),
    .y3(delay16_q_net_x5),
    .y4(delay15_q_net_x6)
  );

  hbf4_filter_module_40c93c6ad9  hbf4_filter_40c93c6ad9 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(delay1_q_net_x2),
    .x2(convert3_dout_net_x3),
    .y1(delay7_q_net_x0),
    .y2(delay3_q_net_x0),
    .y3(delay16_q_net_x0),
    .y4(delay15_q_net_x0)
  );

  mixer1_module_08be5a3870  mixer10_1f73079556 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word10_net),
    .i(delay13_q_net_x3),
    .q(delay13_q_net_x8),
    .iout(convert4_dout_net_x49),
    .qout(convert5_dout_net_x49)
  );

  mixer1_module_08be5a3870  mixer11_b1c2b229bf (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word11_net),
    .i(delay13_q_net_x6),
    .q(delay13_q_net_x10),
    .iout(convert4_dout_net_x50),
    .qout(convert5_dout_net_x50)
  );

  mixer1_module_08be5a3870  mixer12_8a3bd84b6b (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word12_net),
    .i(mux3_y_net_x3),
    .q(mux3_y_net_x6),
    .iout(convert4_dout_net_x51),
    .qout(convert5_dout_net_x51)
  );

  mixer1_module_08be5a3870  mixer13_789f5a6249 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word13_net),
    .i(mux3_y_net_x4),
    .q(mux3_y_net_x8),
    .iout(convert4_dout_net_x52),
    .qout(convert5_dout_net_x52)
  );

  mixer1_module_08be5a3870  mixer14_7405cea9ee (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word14_net),
    .i(mux3_y_net_x2),
    .q(mux3_y_net_x7),
    .iout(convert4_dout_net_x53),
    .qout(convert5_dout_net_x53)
  );

  mixer1536_band3_module_8c4b7efa2b  mixer1536_band3_8c4b7efa2b (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .i0(delay24_q_net_x2),
    .i1(delay25_q_net_x2),
    .i2(delay26_q_net_x2),
    .i3(delay27_q_net_x2),
    .q0(delay28_q_net_x2),
    .q1(delay29_q_net_x2),
    .q2(delay30_q_net_x2),
    .q3(delay31_q_net_x2),
    .i0_out(addsub1_s_net_x2),
    .i1_out(addsub3_s_net_x6),
    .i2_out(addsub3_s_net_x7),
    .i3_out(addsub3_s_net_x8),
    .q0_out(addsub1_s_net_x3),
    .q1_out(addsub3_s_net_x9),
    .q2_out(addsub3_s_net_x10),
    .q3_out(addsub3_s_net_x11)
  );

  mixer1536_minus_band3_module_42ab45e797  mixer1536_minus_band3_42ab45e797 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .i0(delay8_q_net_x2),
    .i1(delay9_q_net_x2),
    .i2(delay10_q_net_x2),
    .i3(delay11_q_net_x2),
    .q0(delay12_q_net_x2),
    .q1(delay13_q_net_x2),
    .q2(delay14_q_net_x2),
    .q3(delay15_q_net_x2),
    .i0_out(addsub1_s_net_x4),
    .i1_out(addsub3_s_net_x12),
    .i2_out(addsub3_s_net_x13),
    .i3_out(addsub3_s_net_x14),
    .q0_out(addsub1_s_net_x5),
    .q1_out(addsub3_s_net_x15),
    .q2_out(addsub3_s_net_x16),
    .q3_out(addsub3_s_net_x17)
  );

  mixer1_module_08be5a3870  mixer15_06c4305ed4 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word15_net),
    .i(mux3_y_net_x5),
    .q(mux3_y_net_x9),
    .iout(convert4_dout_net_x54),
    .qout(convert5_dout_net_x54)
  );

  mixer1_module_08be5a3870  mixer1_08be5a3870 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word1_net),
    .i(delay15_q_net_x9),
    .q(delay15_q_net_x13),
    .iout(convert4_dout_net_x48),
    .qout(convert5_dout_net_x48)
  );

  mixer1_module_08be5a3870  mixer2_2fa2933348 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word2_net),
    .i(delay15_q_net_x7),
    .q(delay15_q_net_x12),
    .iout(convert4_dout_net_x55),
    .qout(convert5_dout_net_x55)
  );

  mixer1_module_08be5a3870  mixer384_4fc6bef267 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word0_net),
    .i(delay15_q_net_x8),
    .q(delay15_q_net_x11),
    .iout(convert4_dout_net_x57),
    .qout(convert5_dout_net_x57)
  );

  mixer1_module_08be5a3870  mixer3_9e177c9074 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word3_net),
    .i(delay15_q_net_x10),
    .q(delay15_q_net_x14),
    .iout(convert4_dout_net_x56),
    .qout(convert5_dout_net_x56)
  );

  mixer1_module_08be5a3870  mixer4_5785191862 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word4_net),
    .i(delay14_q_net_x4),
    .q(delay14_q_net_x7),
    .iout(convert4_dout_net_x58),
    .qout(convert5_dout_net_x58)
  );

  mixer1_module_08be5a3870  mixer5_ff75501c94 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word5_net),
    .i(delay14_q_net_x5),
    .q(delay14_q_net_x9),
    .iout(convert4_dout_net_x59),
    .qout(convert5_dout_net_x59)
  );

  mixer1_module_08be5a3870  mixer6_fd55ddbb80 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word6_net),
    .i(delay14_q_net_x3),
    .q(delay14_q_net_x8),
    .iout(convert4_dout_net_x60),
    .qout(convert5_dout_net_x60)
  );

  mixer1_module_08be5a3870  mixer7_389d9cef38 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word7_net),
    .i(delay14_q_net_x6),
    .q(delay14_q_net_x10),
    .iout(convert4_dout_net_x61),
    .qout(convert5_dout_net_x61)
  );

  mixer1_module_08be5a3870  mixer8_9e29205e6e (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word8_net),
    .i(delay13_q_net_x4),
    .q(delay13_q_net_x7),
    .iout(convert4_dout_net_x62),
    .qout(convert5_dout_net_x62)
  );

  mixer1_module_08be5a3870  mixer9_17a8b95971 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word(freq_word9_net),
    .i(delay13_q_net_x5),
    .q(delay13_q_net_x9),
    .iout(convert4_dout_net_x63),
    .qout(convert5_dout_net_x63)
  );

  reinterpret_f67f49dab9  reinterpret1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay46_q_net),
    .output_port(reinterpret1_output_port_net_x1)
  );

  reinterpret_f67f49dab9  reinterpret2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay47_q_net),
    .output_port(reinterpret2_output_port_net_x1)
  );

  reinterpret_f67f49dab9  reinterpret3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay48_q_net),
    .output_port(reinterpret3_output_port_net_x1)
  );

  reinterpret_f67f49dab9  reinterpret4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay50_q_net),
    .output_port(reinterpret4_output_port_net_x1)
  );

  reinterpret_f67f49dab9  reinterpret5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay49_q_net),
    .output_port(reinterpret5_output_port_net_x1)
  );

  reinterpret_f67f49dab9  reinterpret6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .input_port(delay45_q_net),
    .output_port(reinterpret6_output_port_net_x1)
  );

  rf_mixer_module_666360da93  rf_mixer_666360da93 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .freq_word1(freq_word24_net),
    .freq_word10(freq_word33_net),
    .freq_word11(freq_word34_net),
    .freq_word12(freq_word35_net),
    .freq_word2(freq_word25_net),
    .freq_word3(freq_word26_net),
    .freq_word4(freq_word27_net),
    .freq_word5(freq_word28_net),
    .freq_word6(freq_word29_net),
    .freq_word7(freq_word30_net),
    .freq_word8(freq_word31_net),
    .freq_word9(freq_word32_net),
    .i1(addsub5_s_net_x38),
    .i10(addsub5_s_net_x41),
    .i11(addsub5_s_net_x48),
    .i12(addsub5_s_net_x49),
    .i2(addsub5_s_net_x42),
    .i3(addsub5_s_net_x43),
    .i4(addsub5_s_net_x39),
    .i5(addsub5_s_net_x44),
    .i6(addsub5_s_net_x45),
    .i7(addsub5_s_net_x40),
    .i8(addsub5_s_net_x46),
    .i9(addsub5_s_net_x47),
    .q1(addsub5_s_net_x50),
    .q10(addsub5_s_net_x53),
    .q11(addsub5_s_net_x60),
    .q12(addsub5_s_net_x61),
    .q2(addsub5_s_net_x54),
    .q3(addsub5_s_net_x55),
    .q4(addsub5_s_net_x51),
    .q5(addsub5_s_net_x56),
    .q6(addsub5_s_net_x57),
    .q7(addsub5_s_net_x52),
    .q8(addsub5_s_net_x58),
    .q9(addsub5_s_net_x59),
    .out1(iout0_net),
    .out10(iout9_net),
    .out11(iout10_net),
    .out12(iout11_net),
    .out2(iout1_net),
    .out3(iout2_net),
    .out4(iout3_net),
    .out5(iout4_net),
    .out6(iout5_net),
    .out7(iout6_net),
    .out8(iout7_net),
    .out9(iout8_net)
  );

  subsystem_module_251f158845  subsystem1_f9b003eb4b (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .ena_c0(ena_b1c0_net),
    .ena_c1(ena_b1c1_net),
    .ena_c10(ena_b1c10_net),
    .ena_c11(ena_b1c11_net),
    .ena_c12(ena_b1c12_net),
    .ena_c13(ena_b1c13_net),
    .ena_c14(ena_b1c14_net),
    .ena_c15(ena_b1c15_net),
    .ena_c2(ena_b1c2_net),
    .ena_c3(ena_b1c3_net),
    .ena_c4(ena_b1c4_net),
    .ena_c5(ena_b1c5_net),
    .ena_c6(ena_b1c6_net),
    .ena_c7(ena_b1c7_net),
    .ena_c8(ena_b1c8_net),
    .ena_c9(ena_b1c9_net),
    .i0(convert4_dout_net_x57),
    .i1(convert4_dout_net_x48),
    .i10(convert4_dout_net_x49),
    .i11(convert4_dout_net_x50),
    .i12(convert4_dout_net_x51),
    .i13(convert4_dout_net_x52),
    .i14(convert4_dout_net_x53),
    .i15(convert4_dout_net_x54),
    .i2(convert4_dout_net_x55),
    .i3(convert4_dout_net_x56),
    .i4(convert4_dout_net_x58),
    .i5(convert4_dout_net_x59),
    .i6(convert4_dout_net_x60),
    .i7(convert4_dout_net_x61),
    .i8(convert4_dout_net_x62),
    .i9(convert4_dout_net_x63),
    .q0(convert5_dout_net_x57),
    .q1(convert5_dout_net_x48),
    .q10(convert5_dout_net_x49),
    .q11(convert5_dout_net_x50),
    .q12(convert5_dout_net_x51),
    .q13(convert5_dout_net_x52),
    .q14(convert5_dout_net_x53),
    .q15(convert5_dout_net_x54),
    .q2(convert5_dout_net_x55),
    .q3(convert5_dout_net_x56),
    .q4(convert5_dout_net_x58),
    .q5(convert5_dout_net_x59),
    .q6(convert5_dout_net_x60),
    .q7(convert5_dout_net_x61),
    .q8(convert5_dout_net_x62),
    .q9(convert5_dout_net_x63),
    .out1(addsub42_s_net_x1),
    .out2(addsub43_s_net_x1)
  );

  subsystem_module_251f158845  subsystem2_40c0cc3ff2 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .ena_c0(ena_b2c0_net),
    .ena_c1(ena_b2c1_net),
    .ena_c10(ena_b2c10_net),
    .ena_c11(ena_b2c11_net),
    .ena_c12(ena_b2c12_net),
    .ena_c13(ena_b2c13_net),
    .ena_c14(ena_b2c14_net),
    .ena_c15(ena_b2c15_net),
    .ena_c2(ena_b2c2_net),
    .ena_c3(ena_b2c3_net),
    .ena_c4(ena_b2c4_net),
    .ena_c5(ena_b2c5_net),
    .ena_c6(ena_b2c6_net),
    .ena_c7(ena_b2c7_net),
    .ena_c8(ena_b2c8_net),
    .ena_c9(ena_b2c9_net),
    .i0(convert4_dout_net_x57),
    .i1(convert4_dout_net_x48),
    .i10(convert4_dout_net_x49),
    .i11(convert4_dout_net_x50),
    .i12(convert4_dout_net_x51),
    .i13(convert4_dout_net_x52),
    .i14(convert4_dout_net_x53),
    .i15(convert4_dout_net_x54),
    .i2(convert4_dout_net_x55),
    .i3(convert4_dout_net_x56),
    .i4(convert4_dout_net_x58),
    .i5(convert4_dout_net_x59),
    .i6(convert4_dout_net_x60),
    .i7(convert4_dout_net_x61),
    .i8(convert4_dout_net_x62),
    .i9(convert4_dout_net_x63),
    .q0(convert5_dout_net_x57),
    .q1(convert5_dout_net_x48),
    .q10(convert5_dout_net_x49),
    .q11(convert5_dout_net_x50),
    .q12(convert5_dout_net_x51),
    .q13(convert5_dout_net_x52),
    .q14(convert5_dout_net_x53),
    .q15(convert5_dout_net_x54),
    .q2(convert5_dout_net_x55),
    .q3(convert5_dout_net_x56),
    .q4(convert5_dout_net_x58),
    .q5(convert5_dout_net_x59),
    .q6(convert5_dout_net_x60),
    .q7(convert5_dout_net_x61),
    .q8(convert5_dout_net_x62),
    .q9(convert5_dout_net_x63),
    .out1(addsub42_s_net_x2),
    .out2(addsub43_s_net_x2)
  );

  subsystem_module_251f158845  subsystem_251f158845 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .ena_c0(ena_b0c0_net),
    .ena_c1(ena_b0c1_net),
    .ena_c10(ena_b0c10_net),
    .ena_c11(ena_b0c11_net),
    .ena_c12(ena_b0c12_net),
    .ena_c13(ena_b0c13_net),
    .ena_c14(ena_b0c14_net),
    .ena_c15(ena_b0c15_net),
    .ena_c2(ena_b0c2_net),
    .ena_c3(ena_b0c3_net),
    .ena_c4(ena_b0c4_net),
    .ena_c5(ena_b0c5_net),
    .ena_c6(ena_b0c6_net),
    .ena_c7(ena_b0c7_net),
    .ena_c8(ena_b0c8_net),
    .ena_c9(ena_b0c9_net),
    .i0(convert4_dout_net_x57),
    .i1(convert4_dout_net_x48),
    .i10(convert4_dout_net_x49),
    .i11(convert4_dout_net_x50),
    .i12(convert4_dout_net_x51),
    .i13(convert4_dout_net_x52),
    .i14(convert4_dout_net_x53),
    .i15(convert4_dout_net_x54),
    .i2(convert4_dout_net_x55),
    .i3(convert4_dout_net_x56),
    .i4(convert4_dout_net_x58),
    .i5(convert4_dout_net_x59),
    .i6(convert4_dout_net_x60),
    .i7(convert4_dout_net_x61),
    .i8(convert4_dout_net_x62),
    .i9(convert4_dout_net_x63),
    .q0(convert5_dout_net_x57),
    .q1(convert5_dout_net_x48),
    .q10(convert5_dout_net_x49),
    .q11(convert5_dout_net_x50),
    .q12(convert5_dout_net_x51),
    .q13(convert5_dout_net_x52),
    .q14(convert5_dout_net_x53),
    .q15(convert5_dout_net_x54),
    .q2(convert5_dout_net_x55),
    .q3(convert5_dout_net_x56),
    .q4(convert5_dout_net_x58),
    .q5(convert5_dout_net_x59),
    .q6(convert5_dout_net_x60),
    .q7(convert5_dout_net_x61),
    .q8(convert5_dout_net_x62),
    .q9(convert5_dout_net_x63),
    .out1(addsub42_s_net_x0),
    .out2(addsub43_s_net_x0)
  );

  x3fir_filter_module_4b5604b66f  x3fir_filter1_8956af56a7 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(addsub9_s_net_x0),
    .x2(addsub11_s_net_x0),
    .x3(addsub13_s_net_x0),
    .x4(addsub15_s_net_x0),
    .y1(addsub5_s_net_x50),
    .y10(addsub5_s_net_x53),
    .y11(addsub5_s_net_x60),
    .y12(addsub5_s_net_x61),
    .y2(addsub5_s_net_x54),
    .y3(addsub5_s_net_x55),
    .y4(addsub5_s_net_x51),
    .y5(addsub5_s_net_x56),
    .y6(addsub5_s_net_x57),
    .y7(addsub5_s_net_x52),
    .y8(addsub5_s_net_x58),
    .y9(addsub5_s_net_x59)
  );

  x3fir_filter_module_4b5604b66f  x3fir_filter_4b5604b66f (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .x1(addsub1_s_net_x0),
    .x2(addsub3_s_net_x0),
    .x3(addsub5_s_net_x0),
    .x4(addsub7_s_net_x0),
    .y1(addsub5_s_net_x38),
    .y10(addsub5_s_net_x41),
    .y11(addsub5_s_net_x48),
    .y12(addsub5_s_net_x49),
    .y2(addsub5_s_net_x42),
    .y3(addsub5_s_net_x43),
    .y4(addsub5_s_net_x39),
    .y5(addsub5_s_net_x44),
    .y6(addsub5_s_net_x45),
    .y7(addsub5_s_net_x40),
    .y8(addsub5_s_net_x46),
    .y9(addsub5_s_net_x47)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter12_9c05668081 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x7),
    .valid_in(delay17_q_net_x4),
    .out1(delay15_q_net_x8),
    .out2(delay14_q_net_x4),
    .out3(delay13_q_net_x4),
    .out4(mux3_y_net_x3)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter1_d5db126e54 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay1_q_net_x6),
    .valid_in(delay17_q_net_x4),
    .out1(delay15_q_net_x7),
    .out2(delay14_q_net_x3),
    .out3(delay13_q_net_x3),
    .out4(mux3_y_net_x2)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter2_f02d614ce8 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x8),
    .valid_in(delay17_q_net_x4),
    .out1(delay15_q_net_x9),
    .out2(delay14_q_net_x5),
    .out3(delay13_q_net_x5),
    .out4(mux3_y_net_x4)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter3_13a55d9964 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay1_q_net_x7),
    .valid_in(delay17_q_net_x4),
    .out1(delay15_q_net_x10),
    .out2(delay14_q_net_x6),
    .out3(delay13_q_net_x6),
    .out4(mux3_y_net_x5)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter4_34dc3dc03a (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x3),
    .valid_in(delay17_q_net_x5),
    .out1(delay15_q_net_x11),
    .out2(delay14_q_net_x7),
    .out3(delay13_q_net_x7),
    .out4(mux3_y_net_x6)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter5_36d53b1ca2 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay1_q_net_x8),
    .valid_in(delay17_q_net_x5),
    .out1(delay15_q_net_x12),
    .out2(delay14_q_net_x8),
    .out3(delay13_q_net_x8),
    .out4(mux3_y_net_x7)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter6_cb948493ef (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay_q_net_x9),
    .valid_in(delay17_q_net_x5),
    .out1(delay15_q_net_x13),
    .out2(delay14_q_net_x9),
    .out3(delay13_q_net_x9),
    .out4(mux3_y_net_x8)
  );

  x4fir_filter1_module_d5db126e54  x4fir_filter7_9460589eb2 (
    .ce_1(ce_1_sg_x265),
    .clk_1(clk_1_sg_x265),
    .in1(delay1_q_net_x9),
    .valid_in(delay17_q_net_x5),
    .out1(delay15_q_net_x14),
    .out2(delay14_q_net_x10),
    .out3(delay13_q_net_x10),
    .out4(mux3_y_net_x9)
  );
endmodule
