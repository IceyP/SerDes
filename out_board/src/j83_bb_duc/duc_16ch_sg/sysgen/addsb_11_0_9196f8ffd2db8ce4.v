////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.58f
//  \   \         Application: netgen
//  /   /         Filename: addsb_11_0_9196f8ffd2db8ce4.v
// /___/   /\     Timestamp: Wed Apr 24 13:41:57 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_9196f8ffd2db8ce4.ngc C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_9196f8ffd2db8ce4.v 
// Device	: 7k160tffg676-2
// Input file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_9196f8ffd2db8ce4.ngc
// Output file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/addsb_11_0_9196f8ffd2db8ce4.v
// # of Modules	: 1
// Design Name	: addsb_11_0_9196f8ffd2db8ce4
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

module addsb_11_0_9196f8ffd2db8ce4 (
  clk, add, ce, a, b, s
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input add;
  input ce;
  input [16 : 0] a;
  input [16 : 0] b;
  output [16 : 0] s;
  
  // synthesis translate_off
  
  wire \blk00000001/sig00000069 ;
  wire \blk00000001/sig00000068 ;
  wire \blk00000001/sig00000067 ;
  wire \blk00000001/sig00000066 ;
  wire \blk00000001/sig00000065 ;
  wire \blk00000001/sig00000064 ;
  wire \blk00000001/sig00000063 ;
  wire \blk00000001/sig00000062 ;
  wire \blk00000001/sig00000061 ;
  wire \blk00000001/sig00000060 ;
  wire \blk00000001/sig0000005f ;
  wire \blk00000001/sig0000005e ;
  wire \blk00000001/sig0000005d ;
  wire \blk00000001/sig0000005c ;
  wire \blk00000001/sig0000005b ;
  wire \blk00000001/sig0000005a ;
  wire \blk00000001/sig00000059 ;
  wire \blk00000001/sig00000058 ;
  wire \blk00000001/sig00000057 ;
  wire \blk00000001/sig00000056 ;
  wire \blk00000001/sig00000055 ;
  wire \blk00000001/sig00000054 ;
  wire \blk00000001/sig00000053 ;
  wire \blk00000001/sig00000052 ;
  wire \blk00000001/sig00000051 ;
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
  INV   \blk00000001/blk00000045  (
    .I(add),
    .O(\blk00000001/sig00000069 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000044  (
    .I0(a[9]),
    .I1(b[9]),
    .I2(add),
    .O(\blk00000001/sig0000004e )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000043  (
    .I0(a[8]),
    .I1(b[8]),
    .I2(add),
    .O(\blk00000001/sig0000004f )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000042  (
    .I0(a[7]),
    .I1(b[7]),
    .I2(add),
    .O(\blk00000001/sig00000050 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000041  (
    .I0(a[6]),
    .I1(b[6]),
    .I2(add),
    .O(\blk00000001/sig00000051 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000040  (
    .I0(a[5]),
    .I1(b[5]),
    .I2(add),
    .O(\blk00000001/sig00000052 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003f  (
    .I0(a[4]),
    .I1(b[4]),
    .I2(add),
    .O(\blk00000001/sig00000053 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003e  (
    .I0(a[3]),
    .I1(b[3]),
    .I2(add),
    .O(\blk00000001/sig00000054 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003d  (
    .I0(a[2]),
    .I1(b[2]),
    .I2(add),
    .O(\blk00000001/sig00000055 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003c  (
    .I0(a[16]),
    .I1(b[16]),
    .I2(add),
    .O(\blk00000001/sig00000057 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003b  (
    .I0(a[15]),
    .I1(b[15]),
    .I2(add),
    .O(\blk00000001/sig00000048 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk0000003a  (
    .I0(a[14]),
    .I1(b[14]),
    .I2(add),
    .O(\blk00000001/sig00000049 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000039  (
    .I0(a[13]),
    .I1(b[13]),
    .I2(add),
    .O(\blk00000001/sig0000004a )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000038  (
    .I0(a[12]),
    .I1(b[12]),
    .I2(add),
    .O(\blk00000001/sig0000004b )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000037  (
    .I0(a[11]),
    .I1(b[11]),
    .I2(add),
    .O(\blk00000001/sig0000004c )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000036  (
    .I0(a[10]),
    .I1(b[10]),
    .I2(add),
    .O(\blk00000001/sig0000004d )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000035  (
    .I0(a[1]),
    .I1(b[1]),
    .I2(add),
    .O(\blk00000001/sig00000056 )
  );
  LUT3 #(
    .INIT ( 8'h69 ))
  \blk00000001/blk00000034  (
    .I0(a[0]),
    .I1(b[0]),
    .I2(add),
    .O(\blk00000001/sig00000058 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000033  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000047 ),
    .Q(s[0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000032  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000046 ),
    .Q(s[1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000031  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000045 ),
    .Q(s[2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000030  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000044 ),
    .Q(s[3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002f  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000043 ),
    .Q(s[4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002e  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000042 ),
    .Q(s[5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002d  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000041 ),
    .Q(s[6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000040 ),
    .Q(s[7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002b  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003f ),
    .Q(s[8])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000002a  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003e ),
    .Q(s[9])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000029  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003d ),
    .Q(s[10])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000028  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003c ),
    .Q(s[11])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000027  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003b ),
    .Q(s[12])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000026  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000003a ),
    .Q(s[13])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000025  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000039 ),
    .Q(s[14])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000024  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000038 ),
    .Q(s[15])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000023  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000037 ),
    .Q(s[16])
  );
  MUXCY   \blk00000001/blk00000022  (
    .CI(\blk00000001/sig00000069 ),
    .DI(a[0]),
    .S(\blk00000001/sig00000058 ),
    .O(\blk00000001/sig00000068 )
  );
  MUXCY   \blk00000001/blk00000021  (
    .CI(\blk00000001/sig00000068 ),
    .DI(a[1]),
    .S(\blk00000001/sig00000056 ),
    .O(\blk00000001/sig00000067 )
  );
  MUXCY   \blk00000001/blk00000020  (
    .CI(\blk00000001/sig00000067 ),
    .DI(a[2]),
    .S(\blk00000001/sig00000055 ),
    .O(\blk00000001/sig00000066 )
  );
  MUXCY   \blk00000001/blk0000001f  (
    .CI(\blk00000001/sig00000066 ),
    .DI(a[3]),
    .S(\blk00000001/sig00000054 ),
    .O(\blk00000001/sig00000065 )
  );
  MUXCY   \blk00000001/blk0000001e  (
    .CI(\blk00000001/sig00000065 ),
    .DI(a[4]),
    .S(\blk00000001/sig00000053 ),
    .O(\blk00000001/sig00000064 )
  );
  MUXCY   \blk00000001/blk0000001d  (
    .CI(\blk00000001/sig00000064 ),
    .DI(a[5]),
    .S(\blk00000001/sig00000052 ),
    .O(\blk00000001/sig00000063 )
  );
  MUXCY   \blk00000001/blk0000001c  (
    .CI(\blk00000001/sig00000063 ),
    .DI(a[6]),
    .S(\blk00000001/sig00000051 ),
    .O(\blk00000001/sig00000062 )
  );
  MUXCY   \blk00000001/blk0000001b  (
    .CI(\blk00000001/sig00000062 ),
    .DI(a[7]),
    .S(\blk00000001/sig00000050 ),
    .O(\blk00000001/sig00000061 )
  );
  MUXCY   \blk00000001/blk0000001a  (
    .CI(\blk00000001/sig00000061 ),
    .DI(a[8]),
    .S(\blk00000001/sig0000004f ),
    .O(\blk00000001/sig00000060 )
  );
  MUXCY   \blk00000001/blk00000019  (
    .CI(\blk00000001/sig00000060 ),
    .DI(a[9]),
    .S(\blk00000001/sig0000004e ),
    .O(\blk00000001/sig0000005f )
  );
  MUXCY   \blk00000001/blk00000018  (
    .CI(\blk00000001/sig0000005f ),
    .DI(a[10]),
    .S(\blk00000001/sig0000004d ),
    .O(\blk00000001/sig0000005e )
  );
  MUXCY   \blk00000001/blk00000017  (
    .CI(\blk00000001/sig0000005e ),
    .DI(a[11]),
    .S(\blk00000001/sig0000004c ),
    .O(\blk00000001/sig0000005d )
  );
  MUXCY   \blk00000001/blk00000016  (
    .CI(\blk00000001/sig0000005d ),
    .DI(a[12]),
    .S(\blk00000001/sig0000004b ),
    .O(\blk00000001/sig0000005c )
  );
  MUXCY   \blk00000001/blk00000015  (
    .CI(\blk00000001/sig0000005c ),
    .DI(a[13]),
    .S(\blk00000001/sig0000004a ),
    .O(\blk00000001/sig0000005b )
  );
  MUXCY   \blk00000001/blk00000014  (
    .CI(\blk00000001/sig0000005b ),
    .DI(a[14]),
    .S(\blk00000001/sig00000049 ),
    .O(\blk00000001/sig0000005a )
  );
  MUXCY   \blk00000001/blk00000013  (
    .CI(\blk00000001/sig0000005a ),
    .DI(a[15]),
    .S(\blk00000001/sig00000048 ),
    .O(\blk00000001/sig00000059 )
  );
  XORCY   \blk00000001/blk00000012  (
    .CI(\blk00000001/sig00000069 ),
    .LI(\blk00000001/sig00000058 ),
    .O(\blk00000001/sig00000047 )
  );
  XORCY   \blk00000001/blk00000011  (
    .CI(\blk00000001/sig00000068 ),
    .LI(\blk00000001/sig00000056 ),
    .O(\blk00000001/sig00000046 )
  );
  XORCY   \blk00000001/blk00000010  (
    .CI(\blk00000001/sig00000067 ),
    .LI(\blk00000001/sig00000055 ),
    .O(\blk00000001/sig00000045 )
  );
  XORCY   \blk00000001/blk0000000f  (
    .CI(\blk00000001/sig00000066 ),
    .LI(\blk00000001/sig00000054 ),
    .O(\blk00000001/sig00000044 )
  );
  XORCY   \blk00000001/blk0000000e  (
    .CI(\blk00000001/sig00000065 ),
    .LI(\blk00000001/sig00000053 ),
    .O(\blk00000001/sig00000043 )
  );
  XORCY   \blk00000001/blk0000000d  (
    .CI(\blk00000001/sig00000064 ),
    .LI(\blk00000001/sig00000052 ),
    .O(\blk00000001/sig00000042 )
  );
  XORCY   \blk00000001/blk0000000c  (
    .CI(\blk00000001/sig00000063 ),
    .LI(\blk00000001/sig00000051 ),
    .O(\blk00000001/sig00000041 )
  );
  XORCY   \blk00000001/blk0000000b  (
    .CI(\blk00000001/sig00000062 ),
    .LI(\blk00000001/sig00000050 ),
    .O(\blk00000001/sig00000040 )
  );
  XORCY   \blk00000001/blk0000000a  (
    .CI(\blk00000001/sig00000061 ),
    .LI(\blk00000001/sig0000004f ),
    .O(\blk00000001/sig0000003f )
  );
  XORCY   \blk00000001/blk00000009  (
    .CI(\blk00000001/sig00000060 ),
    .LI(\blk00000001/sig0000004e ),
    .O(\blk00000001/sig0000003e )
  );
  XORCY   \blk00000001/blk00000008  (
    .CI(\blk00000001/sig0000005f ),
    .LI(\blk00000001/sig0000004d ),
    .O(\blk00000001/sig0000003d )
  );
  XORCY   \blk00000001/blk00000007  (
    .CI(\blk00000001/sig0000005e ),
    .LI(\blk00000001/sig0000004c ),
    .O(\blk00000001/sig0000003c )
  );
  XORCY   \blk00000001/blk00000006  (
    .CI(\blk00000001/sig0000005d ),
    .LI(\blk00000001/sig0000004b ),
    .O(\blk00000001/sig0000003b )
  );
  XORCY   \blk00000001/blk00000005  (
    .CI(\blk00000001/sig0000005c ),
    .LI(\blk00000001/sig0000004a ),
    .O(\blk00000001/sig0000003a )
  );
  XORCY   \blk00000001/blk00000004  (
    .CI(\blk00000001/sig0000005b ),
    .LI(\blk00000001/sig00000049 ),
    .O(\blk00000001/sig00000039 )
  );
  XORCY   \blk00000001/blk00000003  (
    .CI(\blk00000001/sig0000005a ),
    .LI(\blk00000001/sig00000048 ),
    .O(\blk00000001/sig00000038 )
  );
  XORCY   \blk00000001/blk00000002  (
    .CI(\blk00000001/sig00000059 ),
    .LI(\blk00000001/sig00000057 ),
    .O(\blk00000001/sig00000037 )
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
