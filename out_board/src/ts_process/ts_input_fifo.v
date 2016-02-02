
//--------------------------------------------------------------------------------------------------
// File          : $ ts_input_fifo.v$
// Last modified : $Date: 2012/07/20 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------

module ts_input_fifo #(
  parameter PAYLOAD_DATA_WIDTH        = 32                       
)(
  
  // Receive Transport stream 
   input 			       payload_clk,
   input 			       payload_rst,
  
   input 			       payload_in_valid,
   input 			       payload_in_start,
   input 			       payload_in_end,
   input [PAYLOAD_DATA_WIDTH-1:0]      payload_in_data,
  
   output reg 			       payload_out_valid,
   output reg 			       payload_out_start,
   output reg 			       payload_out_end,
   output reg [PAYLOAD_DATA_WIDTH-1:0] payload_out_data,

   output wire 			       payload_req_out,
   
   input 			       chan_out_req,
   output reg 			       chan_out_ack,
   output reg                          buffer_overflow
);
`include "alt_clogb2.v"     

//-------------------------------------------------------------
// Buffer localparam
//--------------------------------------------------------------- 
localparam   P_TS_BUFFERS =  8;  
localparam   P_TS_BUFFER_SIZE = 192;      // Buffer size in bytes
localparam   P_TS_BUFFER_RAM_SIZE = P_TS_BUFFERS * P_TS_BUFFER_SIZE;     // RAM size in bytes

//--------------------------------------------------------------------------------------------------
// Write to the buffer
//--------------------------------------------------------------------------------------------------
   
reg buffer_write;

reg  [31:0] buffer_writedata;
reg  [alt_clogb2(P_TS_BUFFERS+1)-1:0] write_level;
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
localparam [1:0] S_PAYLOAD_OVER    = 2;

always @ (posedge payload_clk or posedge payload_rst)
begin
  if (payload_rst) begin
    write_buffer_state <= S_BUFFER_IDLE;
    buffer_write <= 1'b0;
    write_entry <= 0;
    write_offset <= 0;
    write_level <= 0;
    entry_written_tgl <= 1'b0;
    read_entry  <= 0;
    entry_read_tgl_d1 <= 1'b0;
    entry_read_tgl_d2 <= 1'b0;
    entry_read <= 1'b0;
    buffer_writedata <=0; 
  end // if (payload_rst)  
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
     
    buffer_write <= 1'b0;    
    buffer_writedata <= payload_in_data;
    case (write_buffer_state)
      S_BUFFER_IDLE : begin
        write_offset <= 0;
        if (payload_in_valid & payload_in_start&(write_level< P_TS_BUFFERS)) begin
            buffer_write <= 1'b1;
            write_buffer_state <= S_PAYLOAD;
        end
      end
      S_PAYLOAD : begin
        if (payload_in_valid) begin
          buffer_write <= 1'b1;
          write_offset <= write_offset + 1; 
        end
        else begin
          buffer_write<= 1'b0;
        end  
        if (payload_in_end) begin
           write_buffer_state <= S_PAYLOAD_OVER;
        end
      end
     S_PAYLOAD_OVER : begin
       entry_written_tgl <= ~entry_written_tgl;
       t_write_level= t_write_level + 1;
       if (write_entry==P_TS_BUFFERS-1)begin
          write_entry <= 0;
       end
       else begin
         write_entry <= write_entry + 1;
       end
       write_buffer_state <= S_BUFFER_IDLE;		 
    end 
    default:;  
    endcase // case (write_buffer_state)
    write_level <= t_write_level;
  end
end

assign buffer_write_address = write_entry * P_TS_BUFFER_SIZE/4 + write_offset;
//--------------------------------------------------------------------------------------------------
// Buffer RAM
//--------------------------------------------------------------------------------------------------
wire  [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_read_address;
wire [31:0] buffer_data_out;
sdp_ram_d512_w32 u_ram (
  .clka    (payload_clk),
  .addra   (buffer_write_address),
  .wea     (buffer_write),
  .dina    (buffer_writedata),
               
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
localparam S_PAYLOAD_OUT_READ  = 4;
localparam S_PAYLOAD_OUT_ACK   = 5;
localparam S_PAYLOAD_OUT_END   = 6;

always @ (posedge payload_clk or posedge payload_rst)
begin
  if (payload_rst) begin
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
