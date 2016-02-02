////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.58f
//  \   \         Application: netgen
//  /   /         Filename: addsb_11_0_8747e77bb511337e.v
// /___/   /\     Timestamp: Wed Apr 24 13:41:20 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_8747e77bb511337e.ngc C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_8747e77bb511337e.v 
// Device	: 7k160tffg676-2
// Input file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_8747e77bb511337e.ngc
// Output file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_8747e77bb511337e.v
// # of Modules	: 1
// Design Name	: addsb_11_0_8747e77bb511337e
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

module addsb_11_0_8747e77bb511337e (
  clk, ce, a, b, s
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input [12 : 0] a;
  input [12 : 0] b;
  output [12 : 0] s;
  
  // synthesis translate_off
  
  wire \blk00000001/sig00000050 ;
  wire \blk00000001/sig0000004f ;
  wire \blk00000001/sig0000004e ;
  wire \blk00000001/sig0000004d ;
  wire \blk00000001/sig0000004c ;
  wire \blk00000001/sig0000004b ;
  wire \blk00000001/sig0000004a ;
  wire \blk00000001/sig00000049 ;
  wire \blk00000001/sig00000048 ;
  wire \blk00000001/sig00000047 ;
  wire \blk00000001/sig00000046 ;
  wire \blk00000001/sig00000045 ;
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
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000035  (
    .I0(a[12]),
    .I1(b[12]),
    .O(\blk00000001/sig00000043 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000034  (
    .I0(a[11]),
    .I1(b[11]),
    .O(\blk00000001/sig00000038 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000033  (
    .I0(a[10]),
    .I1(b[10]),
    .O(\blk00000001/sig00000039 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000032  (
    .I0(a[9]),
    .I1(b[9]),
    .O(\blk00000001/sig0000003a )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000031  (
    .I0(a[8]),
    .I1(b[8]),
    .O(\blk00000001/sig0000003b )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000030  (
    .I0(a[7]),
    .I1(b[7]),
    .O(\blk00000001/sig0000003c )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002f  (
    .I0(a[6]),
    .I1(b[6]),
    .O(\blk00000001/sig0000003d )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002e  (
    .I0(a[5]),
    .I1(b[5]),
    .O(\blk00000001/sig0000003e )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002d  (
    .I0(a[4]),
    .I1(b[4]),
    .O(\blk00000001/sig0000003f )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002c  (
    .I0(a[3]),
    .I1(b[3]),
    .O(\blk00000001/sig00000040 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002b  (
    .I0(a[2]),
    .I1(b[2]),
    .O(\blk00000001/sig00000041 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk0000002a  (
    .I0(a[1]),
    .I1(b[1]),
    .O(\blk00000001/sig00000042 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk00000001/blk00000029  (
    .I0(a[0]),
    .I1(b[0]),
    .O(\blk00000001/sig00000044 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000028  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002b ),
    .Q(s[0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000027  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000037 ),
    .Q(s[1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000026  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000036 ),
    .Q(s[2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000025  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000035 ),
    .Q(s[3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000024  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000034 ),
    .Q(s[4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000023  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000033 ),
    .Q(s[5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000022  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000032 ),
    .Q(s[6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000021  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000031 ),
    .Q(s[7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000020  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000030 ),
    .Q(s[8])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001f  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002f ),
    .Q(s[9])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001e  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002e ),
    .Q(s[10])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001d  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002d ),
    .Q(s[11])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000002c ),
    .Q(s[12])
  );
  MUXCY   \blk00000001/blk0000001b  (
    .CI(\blk00000001/sig0000002a ),
    .DI(a[0]),
    .S(\blk00000001/sig00000044 ),
    .O(\blk00000001/sig00000050 )
  );
  MUXCY   \blk00000001/blk0000001a  (
    .CI(\blk00000001/sig00000050 ),
    .DI(a[1]),
    .S(\blk00000001/sig00000042 ),
    .O(\blk00000001/sig0000004f )
  );
  MUXCY   \blk00000001/blk00000019  (
    .CI(\blk00000001/sig0000004f ),
    .DI(a[2]),
    .S(\blk00000001/sig00000041 ),
    .O(\blk00000001/sig0000004e )
  );
  MUXCY   \blk00000001/blk00000018  (
    .CI(\blk00000001/sig0000004e ),
    .DI(a[3]),
    .S(\blk00000001/sig00000040 ),
    .O(\blk00000001/sig0000004d )
  );
  MUXCY   \blk00000001/blk00000017  (
    .CI(\blk00000001/sig0000004d ),
    .DI(a[4]),
    .S(\blk00000001/sig0000003f ),
    .O(\blk00000001/sig0000004c )
  );
  MUXCY   \blk00000001/blk00000016  (
    .CI(\blk00000001/sig0000004c ),
    .DI(a[5]),
    .S(\blk00000001/sig0000003e ),
    .O(\blk00000001/sig0000004b )
  );
  MUXCY   \blk00000001/blk00000015  (
    .CI(\blk00000001/sig0000004b ),
    .DI(a[6]),
    .S(\blk00000001/sig0000003d ),
    .O(\blk00000001/sig0000004a )
  );
  MUXCY   \blk00000001/blk00000014  (
    .CI(\blk00000001/sig0000004a ),
    .DI(a[7]),
    .S(\blk00000001/sig0000003c ),
    .O(\blk00000001/sig00000049 )
  );
  MUXCY   \blk00000001/blk00000013  (
    .CI(\blk00000001/sig00000049 ),
    .DI(a[8]),
    .S(\blk00000001/sig0000003b ),
    .O(\blk00000001/sig00000048 )
  );
  MUXCY   \blk00000001/blk00000012  (
    .CI(\blk00000001/sig00000048 ),
    .DI(a[9]),
    .S(\blk00000001/sig0000003a ),
    .O(\blk00000001/sig00000047 )
  );
  MUXCY   \blk00000001/blk00000011  (
    .CI(\blk00000001/sig00000047 ),
    .DI(a[10]),
    .S(\blk00000001/sig00000039 ),
    .O(\blk00000001/sig00000046 )
  );
  MUXCY   \blk00000001/blk00000010  (
    .CI(\blk00000001/sig00000046 ),
    .DI(a[11]),
    .S(\blk00000001/sig00000038 ),
    .O(\blk00000001/sig00000045 )
  );
  XORCY   \blk00000001/blk0000000f  (
    .CI(\blk00000001/sig00000050 ),
    .LI(\blk00000001/sig00000042 ),
    .O(\blk00000001/sig00000037 )
  );
  XORCY   \blk00000001/blk0000000e  (
    .CI(\blk00000001/sig0000004f ),
    .LI(\blk00000001/sig00000041 ),
    .O(\blk00000001/sig00000036 )
  );
  XORCY   \blk00000001/blk0000000d  (
    .CI(\blk00000001/sig0000004e ),
    .LI(\blk00000001/sig00000040 ),
    .O(\blk00000001/sig00000035 )
  );
  XORCY   \blk00000001/blk0000000c  (
    .CI(\blk00000001/sig0000004d ),
    .LI(\blk00000001/sig0000003f ),
    .O(\blk00000001/sig00000034 )
  );
  XORCY   \blk00000001/blk0000000b  (
    .CI(\blk00000001/sig0000004c ),
    .LI(\blk00000001/sig0000003e ),
    .O(\blk00000001/sig00000033 )
  );
  XORCY   \blk00000001/blk0000000a  (
    .CI(\blk00000001/sig0000004b ),
    .LI(\blk00000001/sig0000003d ),
    .O(\blk00000001/sig00000032 )
  );
  XORCY   \blk00000001/blk00000009  (
    .CI(\blk00000001/sig0000004a ),
    .LI(\blk00000001/sig0000003c ),
    .O(\blk00000001/sig00000031 )
  );
  XORCY   \blk00000001/blk00000008  (
    .CI(\blk00000001/sig00000049 ),
    .LI(\blk00000001/sig0000003b ),
    .O(\blk00000001/sig00000030 )
  );
  XORCY   \blk00000001/blk00000007  (
    .CI(\blk00000001/sig00000048 ),
    .LI(\blk00000001/sig0000003a ),
    .O(\blk00000001/sig0000002f )
  );
  XORCY   \blk00000001/blk00000006  (
    .CI(\blk00000001/sig00000047 ),
    .LI(\blk00000001/sig00000039 ),
    .O(\blk00000001/sig0000002e )
  );
  XORCY   \blk00000001/blk00000005  (
    .CI(\blk00000001/sig00000046 ),
    .LI(\blk00000001/sig00000038 ),
    .O(\blk00000001/sig0000002d )
  );
  XORCY   \blk00000001/blk00000004  (
    .CI(\blk00000001/sig00000045 ),
    .LI(\blk00000001/sig00000043 ),
    .O(\blk00000001/sig0000002c )
  );
  XORCY   \blk00000001/blk00000003  (
    .CI(\blk00000001/sig0000002a ),
    .LI(\blk00000001/sig00000044 ),
    .O(\blk00000001/sig0000002b )
  );
  GND   \blk00000001/blk00000002  (
    .G(\blk00000001/sig0000002a )
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
