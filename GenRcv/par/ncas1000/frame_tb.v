`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:13:46 02/01/2016
// Design Name:   aurora_8b10b_v8_3_FRAME_GEN
// Module Name:   E:/MyProjects/STV/test_0420/loop/GenRcv/par/ncas1000/frame_tb.v
// Project Name:  ncas1000
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aurora_8b10b_v8_3_FRAME_GEN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module frame_tb;

	// Inputs
	reg TX_DST_RDY_N;
	reg USER_CLK;
	reg RESET;
	reg CHANNEL_UP;

	// Outputs
	wire [15:0] TX_D;
	wire TX_REM;
	wire TX_SOF_N;
	wire TX_EOF_N;
	wire TX_SRC_RDY_N;

	// Instantiate the Unit Under Test (UUT)
	aurora_8b10b_v8_3_FRAME_GEN uut (
		.TX_D(TX_D), 
		.TX_REM(TX_REM), 
		.TX_SOF_N(TX_SOF_N), 
		.TX_EOF_N(TX_EOF_N), 
		.TX_SRC_RDY_N(TX_SRC_RDY_N), 
		.TX_DST_RDY_N(TX_DST_RDY_N), 
		.USER_CLK(USER_CLK), 
		.RESET(RESET), 
		.CHANNEL_UP(CHANNEL_UP)
	);

	initial begin
		// Initialize Inputs
		TX_DST_RDY_N = 0;
		USER_CLK = 0;
		RESET = 1;
		CHANNEL_UP = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RESET	= 0;
		CHANNEL_UP = 1;
	end
   always #5 USER_CLK = ~USER_CLK;   
endmodule

