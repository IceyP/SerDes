
//--------------------------------------------------------------------------------------------------
// File          : $ psi_inject_fifo.v$
// Last modified : $Date: 2012/07/16 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------

module psi_inject_fifo #(
  parameter TS_PROCESS_BASE_ADD       = 12'h310, 
  parameter BUS_DATE_L                = 12'h180, 
  parameter BUS_DATE_H                = 12'h181,                
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 16,
  parameter PAYLOAD_DATA_WIDTH        = 32                       
)(
  
  input 			       avalon_clk, // Avalon-MM register interface
  input 			       avalon_rst,
  input 			       avalon_read,
  input 			       avalon_write,
  input [P_AVALON_ADDR_WIDTH-1:0]      avalon_address,
  input [P_AVALON_DATA_WIDTH-1:0]      avalon_writedata,
  output reg [P_AVALON_DATA_WIDTH-1:0] avalon_readdata,
  output reg 			       avalon_waitrequest,

  input			             payload_clk,
	input		              payload_rst,
	
  output reg 			       payload_out_valid,
  output reg 			       payload_out_start,
  output reg 			       payload_out_end,
  output reg [PAYLOAD_DATA_WIDTH-1:0]  payload_out_data,
  
  output wire 			       payload_req_out,

  input 			            chan_out_req,
  output reg 			       chan_out_ack,
  
  output reg 			       buffer_overflow
);
`include "alt_clogb2.v"     
//--------------------------------------------------------------------------------------------------
   
// Avalon interface and control registers
//
// Address  R&W                  Use
// =======  ====                 ===
// 8       R         [15:0]   read  TS INJECT FIFO STATUS    
// 7       W                  inject  ts          
//--------------------------------------------------------------------------------------------------

localparam  WRITE_INJECT_FIFO_DATA = TS_PROCESS_BASE_ADD + 7;
localparam  READ_INJECT_FIFO_STATUS =TS_PROCESS_BASE_ADD + 8;
localparam  RESET_FIFO              = TS_PROCESS_BASE_ADD + 'hb;
//-------------------------------------------------------------
// Buffer localparam
//--------------------------------------------------------------- 
localparam   P_TS_BUFFERS =  8;  
localparam   P_TS_BUFFER_SIZE = 192;      // Buffer size in bytes
localparam   P_TS_BUFFER_RAM_SIZE = P_TS_BUFFERS * P_TS_BUFFER_SIZE;     // RAM size in bytes

reg  [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_write_address_1dly;
reg                                           avalon_buf_write_1dly;
reg  [31:0]                                   avalon_buf_writedata_1dly;

//----------------------------------------------------------
// Bus control
//----------------------------------------------------------
reg                                   avalon_buf_write;
reg [31:0]                            avalon_buf_writedata; 
reg  [alt_clogb2(P_TS_BUFFERS+1)-1:0] write_level;     
reg                                   buf_rst_tgl;  
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_waitrequest  <= 1'b1;
    avalon_readdata     <= 32'd0;
    avalon_buf_write    <= 1'b0;
    avalon_buf_writedata   <= 0;   
    buf_rst_tgl <= 0; 
  end
  // Process accesses
  else begin
    avalon_buf_write   <= 1'b0;
    avalon_waitrequest <= 1'b1;
    if (avalon_write & avalon_waitrequest) begin
      avalon_waitrequest <= 1'b0;
      case (avalon_address)
        WRITE_INJECT_FIFO_DATA :  begin
	        avalon_buf_write    <= 1'b1;
        end
        BUS_DATE_L : begin 
          avalon_buf_writedata[15:0] <= avalon_writedata[15:0];
        end
        BUS_DATE_H : begin 
          avalon_buf_writedata[31:16] <= avalon_writedata[15:0];
        end   
        RESET_FIFO : begin
          buf_rst_tgl <= ~buf_rst_tgl;  
        end
        default : begin
          avalon_waitrequest <= 1'b1;
        end
      endcase // case (avalon_address)
    end
    else if (avalon_read & avalon_waitrequest) begin
      case (avalon_address)
          READ_INJECT_FIFO_STATUS :  begin
            avalon_waitrequest <= 1'b0;
            avalon_readdata[15:0] <={P_TS_BUFFERS-write_level};
          end
	  default : begin
            avalon_waitrequest <= 1'b1;
          end
      endcase
    end   
  end
end
/*------------------buf_rst-------------------------*/
reg                      buf_rst_aclk;      
reg                      buf_rst_tgl_aclk_d;
reg                      buf_rst_tgl_aclk_dd;
always @ (posedge avalon_clk or posedge avalon_rst)
begin
	if (avalon_rst) begin
		buf_rst_aclk <= 1'b0;
	end
	else begin
		buf_rst_tgl_aclk_d <= buf_rst_tgl;
		buf_rst_tgl_aclk_dd <= buf_rst_tgl_aclk_d;
		if(buf_rst_tgl_aclk_d != buf_rst_tgl_aclk_dd)begin
			buf_rst_aclk <= 1'b1;
		end
		else begin
			buf_rst_aclk <= 1'b0;
		end
	end
end

reg                      buf_rst_pclk;
reg                      buf_rst_tgl_pclk_d;
reg                      buf_rst_tgl_pclk_dd;  
always @ (posedge payload_clk or posedge payload_rst)
begin
	if (payload_rst) begin
		buf_rst_pclk <= 1'b0;
	end
	else begin
		buf_rst_tgl_pclk_d <= buf_rst_tgl;
		buf_rst_tgl_pclk_dd <= buf_rst_tgl_pclk_d;
		if(buf_rst_tgl_pclk_d != buf_rst_tgl_pclk_dd)begin
			buf_rst_pclk <= 1'b1;
		end
		else begin
			buf_rst_pclk <= 1'b0;
		end
	end
end
//--------------------------------------------------------------------------------------------------
// Write to the buffer
//--------------------------------------------------------------------------------------------------
reg  [alt_clogb2(P_TS_BUFFERS+1)-1:0] t_write_level;
reg  [alt_clogb2(P_TS_BUFFER_SIZE)-1:0] write_offset;
reg  [alt_clogb2(P_TS_BUFFERS)-1:0] write_entry;
wire [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_write_address;

reg entry_written_tgl;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] read_entry;
reg entry_read_tgl;
reg entry_read_tgl_d1;
reg entry_read_tgl_d2;
reg entry_read;                 
reg [1:0]   write_buffer_state;
   
localparam [1:0] S_BUFFER_IDLE   = 0;
localparam [1:0] S_PAYLOAD       = 1;

always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst | buf_rst_aclk) begin
    write_buffer_state <= S_BUFFER_IDLE;
    write_entry <= 0;
    write_offset <= 0;
    write_level <= 0;
    entry_written_tgl <= 1'b0;
    read_entry  <= 0;
    entry_read_tgl_d1 <= 1'b0;
    entry_read_tgl_d2 <= 1'b0;
    entry_read <= 1'b0;
  end  
  else begin
    t_write_level = write_level;

    entry_read_tgl_d1 <= entry_read_tgl;
    entry_read_tgl_d2 <= entry_read_tgl_d1;
    entry_read <= (entry_read_tgl_d2!=entry_read_tgl_d1);

    if (entry_read & t_write_level>0) begin
      t_write_level = t_write_level - 1;
      if (read_entry==P_TS_BUFFERS-1)
        read_entry <= 0;
      else
        read_entry <= read_entry + 1;
    end
    
    case (write_buffer_state)
      S_BUFFER_IDLE : begin
        write_offset <= 0;
        if (avalon_buf_write & (write_level< P_TS_BUFFERS)) begin
	          write_offset <= write_offset + 1;
            write_buffer_state <= S_PAYLOAD;
        end
      end
      S_PAYLOAD : begin
        if(avalon_buf_write &(write_offset<P_TS_BUFFER_SIZE/4)) begin
          write_offset <= write_offset + 1; 
        end
        else if(write_offset>=(P_TS_BUFFER_SIZE/4)) begin
	        entry_written_tgl <= ~entry_written_tgl;
          t_write_level= t_write_level + 1;
          write_offset <= 0;
          if (write_entry==P_TS_BUFFERS-1)begin
             write_entry <= 0;
          end
          else begin
            write_entry <= write_entry + 1;
          end
	        write_buffer_state <= S_BUFFER_IDLE;
        end 
    end
    default:;
    endcase // case (write_buffer_state)  
    write_level <= t_write_level;
  end
end

assign buffer_write_address = write_entry * P_TS_BUFFER_SIZE/4 + write_offset;

//register ram input
always @ (posedge avalon_clk or posedge avalon_rst)
begin
    if (avalon_rst) 
    begin
        buffer_write_address_1dly   <=  0;
        avalon_buf_write_1dly       <=  1'b0;
        avalon_buf_writedata_1dly   <=  {32{1'b0}};
    end
    else
    begin
        buffer_write_address_1dly   <=  buffer_write_address;
        avalon_buf_write_1dly       <=  avalon_buf_write;
        avalon_buf_writedata_1dly   <=  avalon_buf_writedata;
    end
end
    
//--------------------------------------------------------------------------------------------------
// Buffer RAM
//--------------------------------------------------------------------------------------------------
wire  [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_read_address;
wire [31:0] buffer_data_out;
sdp_ram_d512_w32 u_ram (
  .clka    (avalon_clk),
  .addra   (buffer_write_address_1dly),
  .wea     (avalon_buf_write_1dly),
  .dina    (avalon_buf_writedata_1dly),
               
  .clkb    (payload_clk),
  .addrb   (buffer_read_address),
  .doutb   (buffer_data_out)        
  );
  //--------------------------------------------------------------------------------------------------
// Read from the buffer
//--------------------------------------------------------------------------------------------------
reg [2:0] payload_out_state;
//reg [31:0] payload_out_head;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] payload_out_entry;
reg entry_written_tgl_d1;
reg entry_written_tgl_d2;
reg entry_written;
reg [alt_clogb2(P_TS_BUFFERS+1)-1:0] read_level;
//reg buffer_read;
reg buffer_read_d;
reg [7:0] buffer_read_offset;
reg [7:0] payload_out_count;

localparam S_PAYLOAD_OUT_IDLE  = 0;
localparam S_PAYLOAD_OUT_REG   = 1;
localparam S_PAYLOAD_OUT_START = 2;
//localparam S_PAYLOAD_OUT_HEAD  = 3;
localparam S_PAYLOAD_OUT_READ  = 4;
localparam S_PAYLOAD_OUT_ACK   = 5;
localparam S_PAYLOAD_OUT_END   = 6;

always @ (posedge payload_clk or posedge payload_rst)
begin
  if (payload_rst  | buf_rst_pclk) begin
    payload_out_state <= S_PAYLOAD_OUT_IDLE;
    payload_out_valid <= 1'b0;
    entry_read_tgl <= 1'b0;
    payload_out_entry <= 0;
    entry_written_tgl_d1 <= 1'b0;
    entry_written_tgl_d2 <= 1'b0;
    entry_written <= 1'b0;
    read_level = 0;
    //buffer_read <= 1'b0;
    payload_out_start <= 1'b0;
    payload_out_end <= 1'b0;
    payload_out_data <= 0;
    payload_out_count <= 0;
    buffer_overflow <= 1'b0;
    chan_out_ack <= 1'b0;
    buffer_read_offset= 0;
  end
  else begin
    chan_out_ack <= 1'b0;
    //buffer_read <= 1'b0;
    payload_out_valid <= 0;  
    payload_out_start <= 0;
    payload_out_data <= 0;
    payload_out_end<= 1'b0;
    entry_written_tgl_d1 <= entry_written_tgl;
    entry_written_tgl_d2 <= entry_written_tgl_d1;
    entry_written <= (entry_written_tgl_d2!=entry_written_tgl_d1);
    
    if (entry_written)
      read_level = read_level + 1;
      
    if(read_level ==P_TS_BUFFERS)
      buffer_overflow <=1'b1;
    else
      buffer_overflow <=1'b0;
      
    case (payload_out_state)
      S_PAYLOAD_OUT_IDLE : begin
        buffer_read_offset = 0;
        payload_out_count <= 0;
        if ((read_level!=0) & chan_out_req) begin
          buffer_read_offset = buffer_read_offset + 1;
          //buffer_read <= 1'b1;
         // payload_out_state <= S_PAYLOAD_OUT_REG;
          payload_out_state <= S_PAYLOAD_OUT_START;
        end
      end
      /*
      S_PAYLOAD_OUT_REG : begin
        buffer_read <= 1'b1;
        buffer_read_offset = buffer_read_offset + 1;
        payload_out_state <= S_PAYLOAD_OUT_START;
      end
      */
      S_PAYLOAD_OUT_START:begin   
         //buffer_read <= 1'b1;
         buffer_read_offset = buffer_read_offset + 1;
         payload_out_start <= 1'b1; 
         payload_out_valid <= 1'b1;	
         payload_out_data <= buffer_data_out;
         payload_out_state <=S_PAYLOAD_OUT_READ;
      end
      S_PAYLOAD_OUT_READ : begin
        payload_out_valid <= 1'b1;
        payload_out_data <= buffer_data_out[31:0];
        //buffer_read <= 1'b1;
        buffer_read_offset = buffer_read_offset + 1;
        if (buffer_read_offset==(P_TS_BUFFER_SIZE/4)) begin
          read_level = read_level - 1;
          entry_read_tgl <= ~entry_read_tgl;
          payload_out_state <= S_PAYLOAD_OUT_ACK;
        end
      end
              
      S_PAYLOAD_OUT_ACK : begin
        chan_out_ack <= 1'b1;
        payload_out_valid <= 1'b1;
        payload_out_end  <= 1'b1;
        payload_out_data <= buffer_data_out[31:0];
        payload_out_state <= S_PAYLOAD_OUT_END;
      end
      S_PAYLOAD_OUT_END: begin
        if (payload_out_entry==P_TS_BUFFERS-1)begin
           payload_out_entry <= 0;
	    end
        else begin
           payload_out_entry <= payload_out_entry + 1; 
        end  
        payload_out_state <= S_PAYLOAD_OUT_IDLE; 
      end
      default:;
    endcase // case (payload_out_state)
  end
end
assign payload_req_out = (read_level!=0);
assign buffer_read_address = payload_out_entry * P_TS_BUFFER_SIZE/4 + buffer_read_offset; 
endmodule
