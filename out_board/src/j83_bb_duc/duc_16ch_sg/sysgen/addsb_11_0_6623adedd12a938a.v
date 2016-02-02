////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.58f
//  \   \         Application: netgen
//  /   /         Filename: addsb_11_0_6623adedd12a938a.v
// /___/   /\     Timestamp: Wed Apr 24 13:39:33 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_6623adedd12a938a.ngc C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_6623adedd12a938a.v 
// Device	: 7k160tffg676-2
// Input file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_6623adedd12a938a.ngc
// Output file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_6623adedd12a938a.v
// # of Modules	: 1
// Design Name	: addsb_11_0_6623adedd12a938a
// Xilinx        : d:\xilinx\14.5\ise_ds\ise\
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

module addsb_11_0_6623adedd12a938a (
  clk, ce, a, b, s
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input [10 : 0] a;
  input [10 : 0] b;
  output [10 : 0] s;
  
  // synthesis translate_off
  
  wire \blk00000001/sig00000044 ;
  wire \blk00000001/sig00000043 ;
  wire \blk00000001/sig00000042 ;
  wire \blk00000001/sig00000041 ;
  wire \blk00000001/sig00000040 ;
  wire \blk00000001/sig0000003f ;
  wire \blk00000001/sig0000003e ;
  wire \blk00000001/sig0000003d ;
  wire \blk00000001/sig0000003c ;
  wire \blk00000001/sig0000003b ;
  wire \blk00000001/sig0000003a ;
  wire \blk00000001/sig00000039 ;
  wire \blk00000001/sig00000038 ;
  wire \blk00000001/sig00000037 ;
  wire \blk00000001/sig00000036 ;
  wire \blk00000001/sig00000035 ;
  wire \blk00000001/sig00000034 ;
  wire \blk00000001/sig00000033 ;
  wire \blk00000001/sig00000032 ;
  wire \blk00000001/sig00000031 ;
  wire \blk00000001/sig00000030 ;
  wire \blk00000001/sig0000002f ;
  wire \blk00000001/sig0000002e ;
  wire \blk00000001/sig0000002d ;
  wire \blk00000001/sig0000002c ;
  wire \blk00000001/sig0000002b ;
  wire \blk00000001/sig0000002a ;
  wire \blk00000001/sig00000029 ;
  wire \blk00000001/sig00000028 ;
  wire \blk00000001/sig00000027 ;
  wire \blk00000001/sig00000026 ;
  wire \blk00000001/sig00000025 ;
  wire \blk00000001/sig00000024 ;
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002d  (
    .I0(a[10]),
    .I1(b[10]),
    .O(\blk00000001/sig00000039 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002c  (
    .I0(a[9]),
    .I1(b[9]),
    .O(\blk00000001/sig00000030 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002b  (
    .I0(a[8]),
    .I1(b[8]),
    .O(\blk00000001/sig00000031 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002a  (
    .I0(a[7]),
    .I1(b[7]),
    .O(\blk00000001/sig00000032 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000029  (
    .I0(a[6]),
    .I1(b[6]),
    .O(\blk00000001/sig00000033 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000028  (
    .I0(a[5]),
    .I1(b[5]),
    .O(\blk00000001/sig00000034 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000027  (
    .I0(a[4]),
    .I1(b[4]),
    .O(\blk00000001/sig00000035 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000026  (
    .I0(a[3]),
    .I1(b[3]),
    .O(\blk00000001/sig00000036 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000025  (
    .I0(a[2]),
    .I1(b[2]),
    .O(\blk00000001/sig00000037 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000024  (
    .I0(a[1]),
    .I1(b[1]),
    .O(\blk00000001/sig00000038 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000023  (
    .I0(a[0]),
    .I1(b[0]),
    .O(\blk00000001/sig0000003a )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000022  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000025 ),
    .Q(s[0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000021  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002f ),
    .Q(s[1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000020  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002e ),
    .Q(s[2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001f  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002d ),
    .Q(s[3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001e  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002c ),
    .Q(s[4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001d  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002b ),
    .Q(s[5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002a ),
    .Q(s[6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001b  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000029 ),
    .Q(s[7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001a  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000028 ),
    .Q(s[8])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000019  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000027 ),
    .Q(s[9])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000018  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000026 ),
    .Q(s[10])
  );
  MUXCY   \blk00000001/blk00000017  (
    .CI(\blk00000001/sig00000024 ),
    .DI(a[0]),
    .S(\blk00000001/sig0000003a ),
    .O(\blk00000001/sig00000044 )
  );
  MUXCY   \blk00000001/blk00000016  (
    .CI(\blk00000001/sig00000044 ),
    .DI(a[1]),
    .S(\blk00000001/sig00000038 ),
    .O(\blk00000001/sig00000043 )
  );
  MUXCY   \blk00000001/blk00000015  (
    .CI(\blk00000001/sig00000043 ),
    .DI(a[2]),
    .S(\blk00000001/sig00000037 ),
    .O(\blk00000001/sig00000042 )
  );
  MUXCY   \blk00000001/blk00000014  (
    .CI(\blk00000001/sig00000042 ),
    .DI(a[3]),
    .S(\blk00000001/sig00000036 ),
    .O(\blk00000001/sig00000041 )
  );
  MUXCY   \blk00000001/blk00000013  (
    .CI(\blk00000001/sig00000041 ),
    .DI(a[4]),
    .S(\blk00000001/sig00000035 ),
    .O(\blk00000001/sig00000040 )
  );
  MUXCY   \blk00000001/blk00000012  (
    .CI(\blk00000001/sig00000040 ),
    .DI(a[5]),
    .S(\blk00000001/sig00000034 ),
    .O(\blk00000001/sig0000003f )
  );
  MUXCY   \blk00000001/blk00000011  (
    .CI(\blk00000001/sig0000003f ),
    .DI(a[6]),
    .S(\blk00000001/sig00000033 ),
    .O(\blk00000001/sig0000003e )
  );
  MUXCY   \blk00000001/blk00000010  (
    .CI(\blk00000001/sig0000003e ),
    .DI(a[7]),
    .S(\blk00000001/sig00000032 ),
    .O(\blk00000001/sig0000003d )
  );
  MUXCY   \blk00000001/blk0000000f  (
    .CI(\blk00000001/sig0000003d ),
    .DI(a[8]),
    .S(\blk00000001/sig00000031 ),
    .O(\blk00000001/sig0000003c )
  );
  MUXCY   \blk00000001/blk0000000e  (
    .CI(\blk00000001/sig0000003c ),
    .DI(a[9]),
    .S(\blk00000001/sig00000030 ),
    .O(\blk00000001/sig0000003b )
  );
  XORCY   \blk00000001/blk0000000d  (
    .CI(\blk00000001/sig00000044 ),
    .LI(\blk00000001/sig00000038 ),
    .O(\blk00000001/sig0000002f )
  );
  XORCY   \blk00000001/blk0000000c  (
    .CI(\blk00000001/sig00000043 ),
    .LI(\blk00000001/sig00000037 ),
    .O(\blk00000001/sig0000002e )
  );
  XORCY   \blk00000001/blk0000000b  (
    .CI(\blk00000001/sig00000042 ),
    .LI(\blk00000001/sig00000036 ),
    .O(\blk00000001/sig0000002d )
  );
  XORCY   \blk00000001/blk0000000a  (
    .CI(\blk00000001/sig00000041 ),
    .LI(\blk00000001/sig00000035 ),
    .O(\blk00000001/sig0000002c )
  );
  XORCY   \blk00000001/blk00000009  (
    .CI(\blk00000001/sig00000040 ),
    .LI(\blk00000001/sig00000034 ),
    .O(\blk00000001/sig0000002b )
  );
  XORCY   \blk00000001/blk00000008  (
    .CI(\blk00000001/sig0000003f ),
    .LI(\blk00000001/sig00000033 ),
    .O(\blk00000001/sig0000002a )
  );
  XORCY   \blk00000001/blk00000007  (
    .CI(\blk00000001/sig0000003e ),
    .LI(\blk00000001/sig00000032 ),
    .O(\blk00000001/sig00000029 )
  );
  XORCY   \blk00000001/blk00000006  (
    .CI(\blk00000001/sig0000003d ),
    .LI(\blk00000001/sig00000031 ),
    .O(\blk00000001/sig00000028 )
  );
  XORCY   \blk00000001/blk00000005  (
    .CI(\blk00000001/sig0000003c ),
    .LI(\blk00000001/sig00000030 ),
    .O(\blk00000001/sig00000027 )
  );
  XORCY   \blk00000001/blk00000004  (
    .CI(\blk00000001/sig0000003b ),
    .LI(\blk00000001/sig00000039 ),
    .O(\blk00000001/sig00000026 )
  );
  XORCY   \blk00000001/blk00000003  (
    .CI(\blk00000001/sig00000024 ),
    .LI(\blk00000001/sig0000003a ),
    .O(\blk00000001/sig00000025 )
  );
  GND   \blk00000001/blk00000002  (
    .G(\blk00000001/sig00000024 )
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
