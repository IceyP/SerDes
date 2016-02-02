////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.58f
//  \   \         Application: netgen
//  /   /         Filename: cntr_11_0_76451075d188e63f.v
// /___/   /\     Timestamp: Wed Apr 24 13:57:30 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_76451075d188e63f.ngc C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_76451075d188e63f.v 
// Device	: 7k160tffg676-2
// Input file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_76451075d188e63f.ngc
// Output file	: C:/Users/laurengao.COMTECH/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a/tmp/_cg/cntr_11_0_76451075d188e63f.v
// # of Modules	: 1
// Design Name	: cntr_11_0_76451075d188e63f
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

module cntr_11_0_76451075d188e63f (
  clk, ce, sinit, q
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input sinit;
  output [1 : 0] q;
  
  // synthesis translate_off
  
  wire \blk00000001/sig0000000b ;
  wire \blk00000001/sig0000000a ;
  wire \blk00000001/sig00000009 ;
  wire \blk00000001/sig00000008 ;
  wire \blk00000001/sig00000007 ;
  wire \blk00000001/sig00000006 ;
  wire [1 : 0] NlwRenamedSig_OI_q;
  assign
    q[1] = NlwRenamedSig_OI_q[1],
    q[0] = NlwRenamedSig_OI_q[0];
  INV   \blk00000001/blk00000009  (
    .I(NlwRenamedSig_OI_q[0]),
    .O(\blk00000001/sig0000000b )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000008  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000008 ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000007  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig00000009 ),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[1])
  );
  MUXCY   \blk00000001/blk00000006  (
    .CI(\blk00000001/sig00000007 ),
    .DI(\blk00000001/sig00000006 ),
    .S(\blk00000001/sig0000000b ),
    .O(\blk00000001/sig0000000a )
  );
  XORCY   \blk00000001/blk00000005  (
    .CI(\blk00000001/sig00000007 ),
    .LI(\blk00000001/sig0000000b ),
    .O(\blk00000001/sig00000008 )
  );
  XORCY   \blk00000001/blk00000004  (
    .CI(\blk00000001/sig0000000a ),
    .LI(NlwRenamedSig_OI_q[1]),
    .O(\blk00000001/sig00000009 )
  );
  GND   \blk00000001/blk00000003  (
    .G(\blk00000001/sig00000007 )
  );
  VCC   \blk00000001/blk00000002  (
    .P(\blk00000001/sig00000006 )
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
