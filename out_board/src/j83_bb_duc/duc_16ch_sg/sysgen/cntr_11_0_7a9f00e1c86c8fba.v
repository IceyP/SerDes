////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.58f
//  \   \         Application: netgen
//  /   /         Filename: cntr_11_0_7a9f00e1c86c8fba.v
// /___/   /\     Timestamp: Wed Apr 24 13:58:25 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_7a9f00e1c86c8fba.ngc C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_7a9f00e1c86c8fba.v 
// Device	: 7k160tffg676-2
// Input file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_7a9f00e1c86c8fba.ngc
// Output file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_7a9f00e1c86c8fba.v
// # of Modules	: 1
// Design Name	: cntr_11_0_7a9f00e1c86c8fba
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

module cntr_11_0_7a9f00e1c86c8fba (
  clk, ce, sinit, q
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input sinit;
  output [3 : 0] q;
  
  // synthesis translate_off
  
  wire \blk00000001/sig00000013 ;
  wire \blk00000001/sig00000012 ;
  wire \blk00000001/sig00000011 ;
  wire \blk00000001/sig00000010 ;
  wire \blk00000001/sig0000000f ;
  wire \blk00000001/sig0000000e ;
  wire \blk00000001/sig0000000d ;
  wire \blk00000001/sig0000000c ;
  wire \blk00000001/sig0000000b ;
  wire \blk00000001/sig0000000a ;
  wire \blk00000001/sig00000009 ;
  wire \blk00000001/sig00000008 ;
  wire [3 : 0] NlwRenamedSig_OI_q;
  assign
    q[3] = NlwRenamedSig_OI_q[3],
    q[2] = NlwRenamedSig_OI_q[2],
    q[1] = NlwRenamedSig_OI_q[1],
    q[0] = NlwRenamedSig_OI_q[0];
  INV   \blk00000001/blk00000011  (
    .I(NlwRenamedSig_OI_q[0]),
    .O(\blk00000001/sig00000011 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \blk00000001/blk00000010  (
    .I0(NlwRenamedSig_OI_q[1]),
    .O(\blk00000001/sig00000013 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \blk00000001/blk0000000f  (
    .I0(NlwRenamedSig_OI_q[2]),
    .O(\blk00000001/sig00000012 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000e  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000000a ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000d  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000000b ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000000c ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000b  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig0000000d ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[3])
  );
  MUXCY   \blk00000001/blk0000000a  (
    .CI(\blk00000001/sig00000009 ),
    .DI(\blk00000001/sig00000008 ),
    .S(\blk00000001/sig00000011 ),
    .O(\blk00000001/sig00000010 )
  );
  XORCY   \blk00000001/blk00000009  (
    .CI(\blk00000001/sig00000009 ),
    .LI(\blk00000001/sig00000011 ),
    .O(\blk00000001/sig0000000a )
  );
  XORCY   \blk00000001/blk00000008  (
    .CI(\blk00000001/sig0000000e ),
    .LI(NlwRenamedSig_OI_q[3]),
    .O(\blk00000001/sig0000000d )
  );
  MUXCY   \blk00000001/blk00000007  (
    .CI(\blk00000001/sig00000010 ),
    .DI(\blk00000001/sig00000009 ),
    .S(\blk00000001/sig00000013 ),
    .O(\blk00000001/sig0000000f )
  );
  XORCY   \blk00000001/blk00000006  (
    .CI(\blk00000001/sig00000010 ),
    .LI(\blk00000001/sig00000013 ),
    .O(\blk00000001/sig0000000b )
  );
  MUXCY   \blk00000001/blk00000005  (
    .CI(\blk00000001/sig0000000f ),
    .DI(\blk00000001/sig00000009 ),
    .S(\blk00000001/sig00000012 ),
    .O(\blk00000001/sig0000000e )
  );
  XORCY   \blk00000001/blk00000004  (
    .CI(\blk00000001/sig0000000f ),
    .LI(\blk00000001/sig00000012 ),
    .O(\blk00000001/sig0000000c )
  );
  GND   \blk00000001/blk00000003  (
    .G(\blk00000001/sig00000009 )
  );
  VCC   \blk00000001/blk00000002  (
    .P(\blk00000001/sig00000008 )
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
