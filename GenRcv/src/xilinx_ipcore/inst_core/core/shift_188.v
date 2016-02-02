////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.40xd
//  \   \         Application: netgen
//  /   /         Filename: shift_188.v
// /___/   /\     Timestamp: Tue Mar 26 18:18:33 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/huangrui/Desktop/pcr_cor/src_v1.0.9/xilinx_ipcore/inst_core/core/tmp/_cg/shift_188.ngc C:/Users/huangrui/Desktop/pcr_cor/src_v1.0.9/xilinx_ipcore/inst_core/core/tmp/_cg/shift_188.v 
// Device	: 7k325tffg676-2
// Input file	: C:/Users/huangrui/Desktop/pcr_cor/src_v1.0.9/xilinx_ipcore/inst_core/core/tmp/_cg/shift_188.ngc
// Output file	: C:/Users/huangrui/Desktop/pcr_cor/src_v1.0.9/xilinx_ipcore/inst_core/core/tmp/_cg/shift_188.v
// # of Modules	: 1
// Design Name	: shift_188
// Xilinx        : C:\Xilinx\14.3\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module shift_188 (
  clk, ce, d, q
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input [0 : 0] d;
  output [0 : 0] q;
  
  // synthesis translate_off
  
  wire \blk00000001/blk00000002/sig00000011 ;
  wire \blk00000001/blk00000002/sig00000010 ;
  wire \blk00000001/blk00000002/sig0000000f ;
  wire \blk00000001/blk00000002/sig0000000e ;
  wire \blk00000001/blk00000002/sig0000000d ;
  wire \blk00000001/blk00000002/sig0000000c ;
  wire \blk00000001/blk00000002/sig0000000b ;
  wire \blk00000001/blk00000002/sig0000000a ;
  wire \blk00000001/blk00000002/sig00000009 ;
  wire \NLW_blk00000001/blk00000002/blk0000000b_Q31_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000002/blk0000000a_Q_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000002/blk00000008_Q31_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000002/blk00000007_Q_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000002/blk00000006_Q_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000002/blk00000005_Q_UNCONNECTED ;
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000002/blk0000000c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/blk00000002/sig00000011 ),
    .Q(q[0])
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk0000000b  (
    .CLK(clk),
    .D(\blk00000001/blk00000002/sig00000010 ),
    .CE(ce),
    .Q(\blk00000001/blk00000002/sig00000011 ),
    .Q31(\NLW_blk00000001/blk00000002/blk0000000b_Q31_UNCONNECTED ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000a , 
\blk00000001/blk00000002/sig0000000a , \blk00000001/blk00000002/sig0000000b })
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk0000000a  (
    .CLK(clk),
    .D(\blk00000001/blk00000002/sig00000009 ),
    .CE(ce),
    .Q(\NLW_blk00000001/blk00000002/blk0000000a_Q_UNCONNECTED ),
    .Q31(\blk00000001/blk00000002/sig00000010 ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , 
\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b })
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000002/blk00000009  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/blk00000002/sig0000000f ),
    .Q(\blk00000001/blk00000002/sig00000009 )
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk00000008  (
    .CLK(clk),
    .D(\blk00000001/blk00000002/sig0000000e ),
    .CE(ce),
    .Q(\blk00000001/blk00000002/sig0000000f ),
    .Q31(\NLW_blk00000001/blk00000002/blk00000008_Q31_UNCONNECTED ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , 
\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b })
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk00000007  (
    .CLK(clk),
    .D(\blk00000001/blk00000002/sig0000000d ),
    .CE(ce),
    .Q(\NLW_blk00000001/blk00000002/blk00000007_Q_UNCONNECTED ),
    .Q31(\blk00000001/blk00000002/sig0000000e ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , 
\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b })
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk00000006  (
    .CLK(clk),
    .D(\blk00000001/blk00000002/sig0000000c ),
    .CE(ce),
    .Q(\NLW_blk00000001/blk00000002/blk00000006_Q_UNCONNECTED ),
    .Q31(\blk00000001/blk00000002/sig0000000d ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , 
\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b })
  );
  SRLC32E #(
    .INIT ( 32'h00000000 ))
  \blk00000001/blk00000002/blk00000005  (
    .CLK(clk),
    .D(d[0]),
    .CE(ce),
    .Q(\NLW_blk00000001/blk00000002/blk00000005_Q_UNCONNECTED ),
    .Q31(\blk00000001/blk00000002/sig0000000c ),
    .A({\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b , 
\blk00000001/blk00000002/sig0000000b , \blk00000001/blk00000002/sig0000000b })
  );
  VCC   \blk00000001/blk00000002/blk00000004  (
    .P(\blk00000001/blk00000002/sig0000000b )
  );
  GND   \blk00000001/blk00000002/blk00000003  (
    .G(\blk00000001/blk00000002/sig0000000a )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
