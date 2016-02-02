`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module duc_16ch_341_cw_stub
(
  ce,
  clk,// clock period = 2.929 ns (341.41345168999663 Mhz)
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

  input  ce;
  input  clk;// clock period = 2.929 ns (341.41345168999663 Mhz)
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
  input [0:0] rst;

duc_16ch_341_cw duc_16ch_341_cw_i (
  .ce(ce),
  .clk(clk),
  .din1(din1),
  .din2(din2),
  .ena_b0c0(ena_b0c0),
  .ena_b0c1(ena_b0c1),
  .ena_b0c10(ena_b0c10),
  .ena_b0c11(ena_b0c11),
  .ena_b0c12(ena_b0c12),
  .ena_b0c13(ena_b0c13),
  .ena_b0c14(ena_b0c14),
  .ena_b0c15(ena_b0c15),
  .ena_b0c2(ena_b0c2),
  .ena_b0c3(ena_b0c3),
  .ena_b0c4(ena_b0c4),
  .ena_b0c5(ena_b0c5),
  .ena_b0c6(ena_b0c6),
  .ena_b0c7(ena_b0c7),
  .ena_b0c8(ena_b0c8),
  .ena_b0c9(ena_b0c9),
  .ena_b1c0(ena_b1c0),
  .ena_b1c1(ena_b1c1),
  .ena_b1c10(ena_b1c10),
  .ena_b1c11(ena_b1c11),
  .ena_b1c12(ena_b1c12),
  .ena_b1c13(ena_b1c13),
  .ena_b1c14(ena_b1c14),
  .ena_b1c15(ena_b1c15),
  .ena_b1c2(ena_b1c2),
  .ena_b1c3(ena_b1c3),
  .ena_b1c4(ena_b1c4),
  .ena_b1c5(ena_b1c5),
  .ena_b1c6(ena_b1c6),
  .ena_b1c7(ena_b1c7),
  .ena_b1c8(ena_b1c8),
  .ena_b1c9(ena_b1c9),
  .ena_b2c0(ena_b2c0),
  .ena_b2c1(ena_b2c1),
  .ena_b2c10(ena_b2c10),
  .ena_b2c11(ena_b2c11),
  .ena_b2c12(ena_b2c12),
  .ena_b2c13(ena_b2c13),
  .ena_b2c14(ena_b2c14),
  .ena_b2c15(ena_b2c15),
  .ena_b2c2(ena_b2c2),
  .ena_b2c3(ena_b2c3),
  .ena_b2c4(ena_b2c4),
  .ena_b2c5(ena_b2c5),
  .ena_b2c6(ena_b2c6),
  .ena_b2c7(ena_b2c7),
  .ena_b2c8(ena_b2c8),
  .ena_b2c9(ena_b2c9),
  .freq_word0(freq_word0),
  .freq_word1(freq_word1),
  .freq_word10(freq_word10),
  .freq_word11(freq_word11),
  .freq_word12(freq_word12),
  .freq_word13(freq_word13),
  .freq_word14(freq_word14),
  .freq_word15(freq_word15),
  .freq_word2(freq_word2),
  .freq_word24(freq_word24),
  .freq_word25(freq_word25),
  .freq_word26(freq_word26),
  .freq_word27(freq_word27),
  .freq_word28(freq_word28),
  .freq_word29(freq_word29),
  .freq_word3(freq_word3),
  .freq_word30(freq_word30),
  .freq_word31(freq_word31),
  .freq_word32(freq_word32),
  .freq_word33(freq_word33),
  .freq_word34(freq_word34),
  .freq_word35(freq_word35),
  .freq_word4(freq_word4),
  .freq_word5(freq_word5),
  .freq_word6(freq_word6),
  .freq_word7(freq_word7),
  .freq_word8(freq_word8),
  .freq_word9(freq_word9),
  .iout0(iout0),
  .iout1(iout1),
  .iout10(iout10),
  .iout11(iout11),
  .iout2(iout2),
  .iout3(iout3),
  .iout4(iout4),
  .iout5(iout5),
  .iout6(iout6),
  .iout7(iout7),
  .iout8(iout8),
  .iout9(iout9),
  .rst(rst));

endmodule 
