`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:38 10/29/2015 
// Design Name: 
// Module Name:    spi_slave 
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
module spi_slave(clk,rst,data_i,wr_en_i,data_o,valid_o,start_o,end_o,we_ack_o,ss_i,sclk_i,mosi_i,miso_o
    );
	 
	input                                               clk;
	input                                               rst;
	input       [7:0]                                   data_i;
	input                                               wr_en_i;
	output      [7:0]                                   data_o;
	
	output                                              valid_o;
	output                                              start_o;
	output                                              end_o;
	output      reg                                     we_ack_o;
	
	//spi signals
	input                                               ss_i;
	input                                               sclk_i;
	input                                               mosi_i;
	output                                              miso_o;
	
	reg         [7:0]                                   tx_data;
	reg         [7:0]                                   rx_data; 
	
	reg                                                 tx_tip;
	reg                                                 rx_tip;
	
	wire                                                rx_negedge;
	wire                                                tx_negedge;
	wire        [2:0]                                   len;
	wire                                                lsb;
	
	wire                                                pos_edge;
	wire                                                neg_edge;
	
	reg                                                 s_out;
	reg                                                 s_in;
	reg         [2:0]                                   s_sel;
	reg         [2:0]                                   s_clk;
	wire                                                sel_active;	
	wire                                                rx_clk;
	wire                                                rx_lst_bit;
	reg         [2:0]                                   rx_cnt;
	wire                                                tx_clk;
	wire                                                tx_lsb_bit;
	reg         [2:0]                                   tx_cnt;

	assign      rx_negedge                          =   0;
	assign      tx_negedge                          =   1;
	assign      len                                 =   7;
	assign      lsb                                 =   0;

	assign		miso_o                              =   s_out;
	assign		valid_o                             =   rst?	1'b0	:	(!rx_tip);
	assign		data_o                              =   rst?	8'h00	:	rx_data;
	
	always @ (posedge clk)
	begin	
		s_clk <= {s_clk[1:0], sclk_i};
	end
	
	assign      pos_edge                            =   (s_clk[1:0] == 2'b01);
	assign      neg_edge                            =   (s_clk[1:0] == 2'b10);
	
	always @ (posedge clk)
	begin
		s_sel <= {s_sel[1:0], ss_i}; 
	end

	assign      sel_active                          =   ~s_sel[1];
	assign      start_o                             =   (s_sel[1:0] == 2'b10);
	assign      end_o                               =   (s_sel[2:1] == 2'b01);


	assign      rx_clk                              =   rx_negedge? neg_edge    :   pos_edge;
	assign      rx_lst_bit                          =   !(|rx_cnt);

	assign      tx_clk                              =   tx_negedge? neg_edge    :   pos_edge;
	assign      tx_lsb_bit                          =   !(|tx_cnt);


	always @(posedge clk)
	begin
		s_in	<=	mosi_i;
	end
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
			rx_cnt  <=  len;
		else begin
			if(!rx_tip || end_o || start_o)
				rx_cnt  <=  len;
			else
				rx_cnt  <=  rx_clk? (rx_cnt - 1'b1) :   rx_cnt;
		end
	end
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			rx_tip  <=  1'b0;
		else if(!rx_tip)
			rx_tip	<=  1'b1;
		else if(rx_tip && rx_lst_bit && rx_clk)
			rx_tip	<=  1'b0;
	end
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			rx_data <=  {8{1'b0}};
		else begin
			if(sel_active && rx_clk)
				rx_data <=  lsb?    {s_in,rx_data[7:1]} :   {rx_data[6:0],s_in};
		end
	end
		
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			tx_cnt	<=  len;
		else begin
			if(!tx_tip || end_o || start_o)
				tx_cnt	<=  len;
			else
				tx_cnt	<=  tx_clk? (tx_cnt-1'b1)   :   tx_cnt;
		end
	end
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			tx_tip	<=  1'b0;
		else if(wr_en_i && !tx_tip)
			tx_tip	<=  1'b1;
		else if(tx_tip && tx_lsb_bit && tx_clk)
			tx_tip	<=  1'b0;
	end
	
	always @(posedge clk or posedge rst)
	begin
		if(rst) begin
			tx_data <= 8'hff;
			we_ack_o	<=	1'b0;
		end
		else begin
			we_ack_o <= 1'b0;
			if(wr_en_i && !tx_tip) begin
				tx_data[7:0]	<=  data_i[7:0];
				we_ack_o	    <=  1'b1;
			end
			else begin
				if(sel_active && tx_clk) begin
					tx_data <=  lsb? {1'b1,tx_data[7:1]} : {tx_data[6:0],1'b1};
					s_out	<=	lsb?	tx_data[0] : tx_data[7];
				end
			end
		end
	end
			
endmodule
