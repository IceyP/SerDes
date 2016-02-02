`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:42 11/03/2015 
// Design Name: 
// Module Name:    spi_cmd 
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
module spi_cmd #(
	parameter		BUS_DATA_WIDTH				        =	8
   )(
	input                                                   clk,
	input													rst,
	input			[BUS_DATA_WIDTH-1:0]        			rx_data,
	input													rx_valid,
	input													rx_start,
	input													rx_end,
	
	input													tx_ack,
	output	reg	    [BUS_DATA_WIDTH-1:0]        			tx_data,
	output	reg									        	tx_req
	);
	
	reg				[3:0]								    cmd_state;
	
	localparam		REV_START					        =	4'b0001;
	localparam		WRITE_REG					        =	4'b0010;
	localparam		TRANS_VERSION				        =	4'b0100;
	localparam		REV_END						        =	4'b1000;
	
	localparam		READ_FPGA_VERSION			        =	8'h01;
	localparam		FPGA_VERSION				        =	8'h10;
	

	always @(posedge clk or posedge rst)
	begin
		if(rst) begin
			tx_data		<=	8'h00;
			tx_req		<=  1'b0;
			cmd_state	<=	REV_START;
		end
		else begin
			if(tx_ack) begin
				tx_req	<=	1'b0;
			end
			case(cmd_state)
				REV_START : begin
					if(rx_start) begin
						cmd_state	<=	WRITE_REG;
						tx_req		<=	1'b0;
					end
				end
				WRITE_REG : begin
					if(rx_end) begin
						cmd_state	<=	REV_START;
					end
					else if(rx_valid) begin
						case(rx_data)
							READ_FPGA_VERSION : begin
								cmd_state	<=	TRANS_VERSION;
							end
							default:
							    cmd_state   <=   REV_START;
						endcase
					end
				end
				TRANS_VERSION : begin
					tx_data	    <=	FPGA_VERSION;
					tx_req	    <=	1'b1;
					cmd_state	<=	REV_END;
				end
				REV_END : begin
					tx_req	    <=	1'b0;
					cmd_state	<=	REV_START;
				end
			endcase
		end
	end
endmodule
