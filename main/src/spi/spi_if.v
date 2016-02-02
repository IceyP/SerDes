`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:39 11/03/2015 
// Design Name: 
// Module Name:    spi_if 
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
module spi_if #(
    parameter		BUS_DATA_WIDTH              =   8
	 )(
	 input										    rst,
	 input										    clk,
	 
	 input										    ss_i,
	 input										    sclk_i,
	 input										    mosi_i,
	 output										    miso_o
	 );
	 
	 wire											spi_tx_req;
	 wire           [BUS_DATA_WIDTH-1:0]			spi_tx_data;
	 wire											spi_tx_ack;
	 
	 wire											spi_rx_sof;
	 wire											spi_rx_eof;
	 wire											spi_rx_valid;
	 wire           [BUS_DATA_WIDTH-1:0]			spi_rx_data;
	 
spi_slave u_spi_slave
(
	.clk                                            ( clk ),
	.rst                                            ( rst ),
	.data_i                                         ( spi_tx_data ),	
	.wr_en_i                                        ( spi_tx_req ),
	.we_ack_o                                       ( spi_tx_ack ),	
	
	.data_o                                         ( spi_rx_data ),
	.valid_o                                        ( spi_rx_valid ),
	.start_o                                        ( spi_rx_sof ),
	.end_o                                          ( spi_rx_eof ),
		
	.ss_i                                           ( ss_i ),
	.sclk_i                                         ( sclk_i ),
	.mosi_i                                         ( mosi_i ),
	.miso_o                                         ( miso_o )
);
	 
spi_cmd #(
	.BUS_DATA_WIDTH                                 ( BUS_DATA_WIDTH )
	 )
u_spi_cmd
(
	.clk                                            ( clk ),
	.rst                                            ( rst ),
	.rx_data                                        ( spi_rx_data ),
	.rx_valid                                       ( spi_rx_valid ),
	.rx_start                                       ( spi_rx_sof ),
	.rx_end                                         ( spi_rx_eof ),
	
	.tx_ack                                         ( spi_tx_ack ),
	.tx_data                                        ( spi_tx_data ),
	.tx_req                                         ( spi_tx_req )
);
endmodule
