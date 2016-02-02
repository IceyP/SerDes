`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:51:10 08/21/2012 
// Design Name: 
// Module Name:    duc_341mhz_s 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module duc_341mhz (
  ce_1,
  clk_1,
  din1,
  din2,
  din5,
  ena_b0c0,
  ena_b0c1,
  ena_b0c10,
  ena_b0c11,
  ena_b0c12,
  ena_b0c13,
  ena_b0c14,
  ena_b0c15,
  ena_b0c16,
  ena_b0c17,
  ena_b0c18,
  ena_b0c19,
  ena_b0c2,
  ena_b0c20,
  ena_b0c21,
  ena_b0c22,
  ena_b0c23,
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
  ena_b1c16,
  ena_b1c17,
  ena_b1c18,
  ena_b1c19,
  ena_b1c2,
  ena_b1c20,
  ena_b1c21,
  ena_b1c22,
  ena_b1c23,
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
  ena_b2c16,
  ena_b2c17,
  ena_b2c18,
  ena_b2c19,
  ena_b2c2,
  ena_b2c20,
  ena_b2c21,
  ena_b2c22,
  ena_b2c23,
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
  freq_word16,
  freq_word17,
  freq_word18,
  freq_word19,
  freq_word2,
  freq_word20,
  freq_word21,
  freq_word22,
  freq_word23,
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
  input [15:0] din5;
  input [0:0] ena_b0c0;
  input [0:0] ena_b0c1;
  input [0:0] ena_b0c10;
  input [0:0] ena_b0c11;
  input [0:0] ena_b0c12;
  input [0:0] ena_b0c13;
  input [0:0] ena_b0c14;
  input [0:0] ena_b0c15;
  input [0:0] ena_b0c16;
  input [0:0] ena_b0c17;
  input [0:0] ena_b0c18;
  input [0:0] ena_b0c19;
  input [0:0] ena_b0c2;
  input [0:0] ena_b0c20;
  input [0:0] ena_b0c21;
  input [0:0] ena_b0c22;
  input [0:0] ena_b0c23;
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
  input [0:0] ena_b1c16;
  input [0:0] ena_b1c17;
  input [0:0] ena_b1c18;
  input [0:0] ena_b1c19;
  input [0:0] ena_b1c2;
  input [0:0] ena_b1c20;
  input [0:0] ena_b1c21;
  input [0:0] ena_b1c22;
  input [0:0] ena_b1c23;
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
  input [0:0] ena_b2c16;
  input [0:0] ena_b2c17;
  input [0:0] ena_b2c18;
  input [0:0] ena_b2c19;
  input [0:0] ena_b2c2;
  input [0:0] ena_b2c20;
  input [0:0] ena_b2c21;
  input [0:0] ena_b2c22;
  input [0:0] ena_b2c23;
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
  input [9:0] freq_word16;
  input [9:0] freq_word17;
  input [9:0] freq_word18;
  input [9:0] freq_word19;
  input [9:0] freq_word2;
  input [9:0] freq_word20;
  input [9:0] freq_word21;
  input [9:0] freq_word22;
  input [9:0] freq_word23;
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
  
  assign iout0=din1[13:0];
  assign iout1=din2[13:0];
  assign iout2=din5[13:0];
  assign iout3={4'b0, freq_word0};
  assign iout4={4'b0, freq_word1};
  assign iout5={4'b0, freq_word2};
  assign iout6={4'b0, freq_word3};
  assign iout7={4'b0, freq_word4};
  assign iout8={4'b0, freq_word5};
  assign iout9={4'b0, freq_word6};
  assign iout10={4'b0, freq_word7};
  assign iout11={4'b0, freq_word8};
  assign iout12={4'b0, freq_word9};
endmodule
