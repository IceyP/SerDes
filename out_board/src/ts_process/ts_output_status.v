

module ts_output_status #(
  parameter TS_OUT_STATUS_BASE_ADD    = 12'h330,                
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 16,
  parameter PAYLOAD_DATA_WIDTH        = 32                      
)(

   // Transport stream inputs
   payload_clk,
   payload_rst,
   payload_in_valid,
   payload_in_start,
   payload_in_end,
   payload_in_data,
   
   // Avalon slave port for configuration
   avalon_clk,
   avalon_rst,
   avalon_address,
   avalon_read,
   avalon_readdata,
   avalon_waitrequest,
   avalon_write,
   avalon_writedata

   );
`include "alt_clogb2.v"
//--------------------------------------------------------------------------------------------------
// Parameter definitions
//--------------------------------------------------------------------------------------------------

parameter P_OUT_CHANS              = 16;
parameter P_CHANS_BITS             = alt_clogb2(P_OUT_CHANS);

//--------------------------------------------------------------------------------------------------
// I/O definitions
//--------------------------------------------------------------------------------------------------

// Transport stream inputs
input                                   payload_clk;
input                                   payload_rst;    
input                                   payload_in_valid;
input                                   payload_in_start;
input                                   payload_in_end;
input  [ 31:0]                          payload_in_data;


// Avalon slave port for configuration
input                                  avalon_clk;
input                                  avalon_rst;
input  [P_AVALON_ADDR_WIDTH-1:0]       avalon_address;
input                                  avalon_read;
output [P_AVALON_DATA_WIDTH-1:0]       avalon_readdata;
output                                 avalon_waitrequest;
input                                  avalon_write;
input  [P_AVALON_DATA_WIDTH-1:0]       avalon_writedata;

reg    [P_AVALON_DATA_WIDTH-1:0]       avalon_readdata;
reg                                    avalon_waitrequest;

 //--------------------------------------------------------------------------------------------------
// Avalon interface and control registers
localparam  SELECT_CHAN = 0;

reg                            rate_read;
reg [P_CHANS_BITS-1:0]         read_port; 
reg                            read_valid;
reg  [P_AVALON_DATA_WIDTH-1:0] port_rate_readdate;
wire [P_AVALON_DATA_WIDTH-1:0] read_port_rate; 
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_waitrequest  <= 1'b1;
    avalon_readdata     <= 32'd0;
    rate_read           <= 1'b0;
  end
  // Process accesses
  else begin
    rate_read           <= 1'b0;
    avalon_waitrequest <= 1'b1;
    if(avalon_address[P_AVALON_ADDR_WIDTH-1:4]==TS_OUT_STATUS_BASE_ADD[P_AVALON_ADDR_WIDTH-1:4])begin
    	if (avalon_read & avalon_waitrequest )begin
        avalon_waitrequest <= 1'b0;
      	read_port <= avalon_address[3:0];
      	rate_read <= 1'b1;
      end
     // if(read_valid) begin
      //  avalon_readdata <= port_rate_readdate;
        avalon_readdata <= read_port_rate;
       // avalon_waitrequest <= 1'b1;
    //  end
    end
  end
end



//------------------- rate read----------------------------------//	
reg             rate_read_d;	
reg             rate_read_dd;	
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if(avalon_rst) begin
  	read_valid  <= 1'b0;
  	rate_read_d <= 1'b0;
	end
  else begin
  	rate_read_d <= rate_read;	
	  rate_read_dd <= rate_read_d;
  	if(rate_read_dd)begin
  		 read_valid <= 1'b1;
  		 port_rate_readdate <= read_port_rate;
  	end
  	else begin
  		read_valid <= 1'b0;
  	end
  end
end

//------------------- rate write----------------------------------//
reg                             rate_write;
reg                             rate_read_pre;
reg                             rate_read_pre_d;
reg [P_CHANS_BITS-1:0]          write_port;
reg [P_AVALON_DATA_WIDTH-1:0]   write_port_rate; 
wire [P_AVALON_DATA_WIDTH-1:0]  port_rate_pre;
reg                             rate_read_pre_dd;
reg                             port_rate_initial;
 
//   OUTPUT RATE STASTIC
always @(posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)begin
    rate_write <= 1'b0;
    rate_read_pre<= 1'b0;
    rate_read_pre_d<= 1'b0;
    rate_read_pre_dd <= 1'b0; 
    write_port <= 0; 
    write_port_rate <= 0;
    port_rate_initial <= 1'b1;
  end
  else if(port_rate_initial)begin
	  if(write_port==P_OUT_CHANS-1)begin
	  	rate_write <= 1'b1;
		  write_port_rate <= 0;
		  port_rate_initial <= 1'b0;
		end
	  else begin
	  	 rate_write <= 1'b1;
	  	 write_port <= write_port +1'b1;
		end
	end 
 	else begin
 	  rate_write <= 1'b0;
 	  rate_read_pre<= 1'b0;
 	  rate_read_pre_d <= rate_read_pre;
 	  rate_read_pre_dd <= rate_read_pre_d;
    if(payload_in_start & payload_in_valid)
    begin
  	  rate_read_pre<= 1'b1;
	    write_port <= payload_in_data[3:0];  
    end  
    if(rate_read_pre_dd)
    begin
      rate_write <= 1'b1;
     	write_port_rate <= port_rate_pre + 1'b1;
    end  
  end
end
//
localparam RAM_DEPTH      = 512;
localparam RAM_DEPTH_BITS = alt_clogb2(RAM_DEPTH);
ddp_ram_d512_w16 ost_ram(
    .clka    (payload_clk),
    .addra   ({{(RAM_DEPTH_BITS-P_CHANS_BITS){1'b0}},write_port}),
    .wea     (rate_write),
    .dina    (write_port_rate),
    .douta   (port_rate_pre),
    
    .clkb    (avalon_clk),
    .addrb   ({{(RAM_DEPTH_BITS-P_CHANS_BITS){1'b0}},read_port}),
    .web     (1'b0),
    .dinb    (),
    .doutb   (read_port_rate)
    );	  
endmodule
