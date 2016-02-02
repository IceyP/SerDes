module udp_chan_buffer #(
parameter  P_TS_BUFFERS = 21
) (
  input                           clk,          // Payload clock
  input                           rst,          // Payload reset

  output reg                      payload_ready,
  input                           payload_valid,
  input                [31:0]     payload_data,
  input                [15:0]     payload_channel,
  input                [11:0]     payload_length,
  input                           payload_start,
  input                           payload_end,
  
  output reg                      payload_out_valid,
  output reg               [31:0] payload_out_data,
  output reg                      payload_out_start,
  output reg                      payload_out_end,
  
  input                           output_fifo_update_ack,
  input                           chan_out_req,
  output reg                      output_fifo_update_req, 
  output reg                      chan_out_ack,
  output reg                      buffer_overflow
  
  );
`include "alt_clogb2.v"
localparam   P_TS_BUFFER_SIZE = 192;      // Buffer size in bytes
localparam   P_TS_BUFFER_RAM_SIZE = P_TS_BUFFERS * P_TS_BUFFER_SIZE;     // RAM size in bytes
 
//--------------------------------------------------------------------------------------------------
// Write to the buffer
//--------------------------------------------------------------------------------------------------
reg buffer_write;
reg buffer_write_early;
reg [35:0] buffer_writedata;
reg [alt_clogb2(P_TS_BUFFERS+1)-1:0] write_level;
reg [alt_clogb2(P_TS_BUFFERS+1)-1:0] t_write_level;
reg [alt_clogb2(P_TS_BUFFER_SIZE)-1:0] write_offset;
reg [alt_clogb2(P_TS_BUFFER_SIZE)-1:0] write_count;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] write_entry;
wire [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_write_address;
reg [1:0] write_buffer_state;
reg entry_written_tgl;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] read_entry;
reg entry_read_tgl;
reg entry_read_tgl_d1;
reg entry_read_tgl_d2;
reg entry_read;
reg [3:0]   wait_count;
reg [8:0]  v_payload_length;
reg [31:0]  payload_data_d;
//reg         payload_valid_d;
reg         payload_end_d;                    

localparam [1:0] S_BUFFER_IDLE   = 0;
localparam [1:0] S_WAIT          = 1;
localparam [1:0] S_PAYLOAD       = 2;
localparam [1:0] S_BUFFER_WRITE_END =3;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    write_buffer_state <= S_BUFFER_IDLE;
    buffer_write <= 1'b0;
    write_entry <= P_TS_BUFFERS-1;
    write_level <= 0;
    entry_written_tgl <= 1'b0;
    read_entry  <= 0;
    entry_read_tgl_d1 <= 1'b0;
    entry_read_tgl_d2 <= 1'b0;
    entry_read <= 1'b0;
    payload_ready <= 1'b0;  
    v_payload_length <= 0;
    wait_count <=0;
    write_count <= 0;
    write_offset <= 0;
   // payload_valid_d <=0;
    payload_end_d <=0;
    buffer_writedata <=0;
    output_fifo_update_req <= 0;
  end
  else begin
    if(output_fifo_update_ack)begin
      output_fifo_update_req <= 1'b0;
    end  
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
    payload_end_d <=payload_end;
//    payload_valid_d <=payload_valid;   
    buffer_writedata <= {4'b0,payload_data};
    case (write_buffer_state)
      S_BUFFER_IDLE : begin
        write_offset <= 0;
        write_count <= 0;
         if (payload_valid & payload_start) begin
           if (payload_length==188 | payload_length==2*188 | payload_length==3*188 | payload_length==4*188 | payload_length==5*188 | payload_length==6*188 | payload_length==7*188) begin
             buffer_write <= 1'b1;
             buffer_writedata <={payload_channel[11:0],payload_data[23:0]};
             if (payload_data[31:24]!=8'h47) begin
				       write_buffer_state <= S_BUFFER_IDLE;
              $display("**** WARNING - auk_rtpts : Unexpected data (%02x) for first byte of TS packet ****", payload_data[7:0]);
              $stop;
            end
			    	else begin
				       t_write_level = t_write_level + 1;
               if (write_entry==P_TS_BUFFERS-1)begin
                  write_entry <= 0;
               end
               else begin
                  write_entry <= write_entry + 1;
               end
               v_payload_length <= payload_length/4;
               write_buffer_state <= S_PAYLOAD;
			      end
          end
          else if (payload_length==188 + 12 | payload_length==2*188+ 12 | payload_length==3*188+ 12 | payload_length==4*188+ 12 | payload_length==5*188+ 12 | payload_length==6*188+ 12 | payload_length==7*188+ 12) begin
            v_payload_length <= (payload_length-12)/4;
            wait_count <= 0;
            write_buffer_state <= S_WAIT;
          end
          else begin
              $display("**** WARNING - auk_rtpts : Unexpected packet length %d - discard ****", payload_length);
              $stop;
          end
        end
      end

      S_WAIT : begin
        if (payload_valid) begin
          wait_count <= wait_count + 1'b1;
          if (wait_count==2) begin
            buffer_write <= 1'b1;
            buffer_writedata <={payload_channel[11:0],payload_data[23:0]};
            if (payload_data[31:24]!=8'h47) begin
				      write_buffer_state <= S_BUFFER_IDLE;
              $display("**** WARNING - auk_rtpts : Unexpected data (%02x) for first byte of TS packet ****", payload_data[7:0]);
              $stop;
            end
				    else begin
				      t_write_level = t_write_level + 1;
              if (write_entry==P_TS_BUFFERS-1)begin
                write_entry <= 0;
              end
              else begin
                write_entry <= write_entry + 1;
              end
              v_payload_length <= payload_length/4;
              write_buffer_state <= S_PAYLOAD;
            end
          end				
        end
      end

      S_PAYLOAD : begin
        if (payload_valid) begin
          v_payload_length <= v_payload_length - 1;
          write_offset <= write_offset + 1;
          buffer_write<= 1'b1;
          if (write_count==(188/4)-1) begin
          	 write_count <= 0;
             write_offset <= 0;
          	 if(payload_data[31:24]==8'h47)begin
			         buffer_writedata <={payload_channel[11:0],payload_data[23:0]};
               t_write_level = t_write_level + 1;
               if (write_entry==P_TS_BUFFERS-1)begin
                  write_entry <= 0;
               end
               else begin
                 write_entry <= write_entry + 1;
               end
               output_fifo_update_req <= 1'b1;
               entry_written_tgl <= ~entry_written_tgl;
             end
          end
          else begin
            write_count <= write_count + 1;
          end

          if (payload_end | (v_payload_length==1)) begin
            output_fifo_update_req <= 1'b1;
            entry_written_tgl <= ~entry_written_tgl;
            write_buffer_state <= S_BUFFER_IDLE;
            if (write_count!=(188/4)-2)begin
				      write_buffer_state <= S_BUFFER_IDLE;
              $display("**** ERROR - payload length  is error****");
            end
          end
        end
      end
    endcase

    write_level <= t_write_level;
    payload_ready <= (t_write_level<=P_TS_BUFFERS-7);

  end
end
assign buffer_write_address = write_entry * P_TS_BUFFER_SIZE/4 + write_offset;
//--------------------------------------------------------------------------------------------------
// Buffer RAM
//--------------------------------------------------------------------------------------------------
reg  [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_read_address;
wire [35:0] p_buffer_data_out;
reg  [35:0] buffer_data_out;

sdp_ram_d1024_w36 udp_ts_rx_buf_ram(
	.clka       (clk),			    
	.addra      (buffer_write_address),
  .dina       (buffer_writedata),			    
	.wea        (buffer_write),
				    
	.clkb       (clk),				    
	.addrb      (buffer_read_address),
	.doutb      (p_buffer_data_out)
	);
	
always @ (posedge clk or posedge rst)
begin
  if (rst) begin  
  	buffer_data_out <= 0;
  end
  else begin
  	buffer_data_out <= p_buffer_data_out;
  end
end
//--------------------------------------------------------------------------------------------------
// Read from the buffer
//--------------------------------------------------------------------------------------------------
reg [2:0] payload_out_state;
reg [15:0] payload_out_channel;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] payload_out_entry;
reg entry_written_tgl_d1;
reg entry_written_tgl_d2;
reg entry_written;
reg [alt_clogb2(P_TS_BUFFERS+1)-1:0] read_level;
reg buffer_read;
reg buffer_read_d;
reg [7:0] buffer_read_offset;
reg [7:0] payload_out_count;

localparam S_PAYLOAD_OUT_IDLE  = 0;
localparam S_PAYLOAD_OUT_REG   = 1;
localparam S_PAYLOAD_OUT_START = 2;
localparam S_PAYLOAD_OUT_HEAD  = 3;
localparam S_PAYLOAD_OUT_READ  = 4;
localparam S_PAYLOAD_OUT_ACK   = 5;
localparam S_PAYLOAD_OUT_END   = 6;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    payload_out_state <= S_PAYLOAD_OUT_IDLE;
    payload_out_valid <= 1'b0;
    entry_read_tgl <= 1'b0;
    payload_out_entry <= 0;
    entry_written_tgl_d1 <= 1'b0;
    entry_written_tgl_d2 <= 1'b0;
    entry_written <= 1'b0;
    read_level = 0;
    buffer_read <= 1'b0;
    payload_out_start <= 1'b0;
    payload_out_end <= 1'b0;
    payload_out_data <= 0;
    payload_out_count <= 0;
    buffer_overflow <= 1'b0;
    chan_out_ack <= 1'b0;
    buffer_read_offset = 0;
  end
  else begin
    chan_out_ack <= 1'b0;
    buffer_read <= 1'b0;
    payload_out_valid <= 0;  
    payload_out_start <= 0;
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
        payload_out_count <= 0;
        if ((read_level!=0) & chan_out_req) begin
          buffer_read <= 1'b1;
          payload_out_state <= S_PAYLOAD_OUT_REG;
        end
      end
      
      S_PAYLOAD_OUT_REG : begin
        buffer_read <= 1'b1;
        buffer_read_offset = buffer_read_offset + 1;
        payload_out_state <= S_PAYLOAD_OUT_START;
      end
      
		S_PAYLOAD_OUT_START:begin   
         buffer_read <= 1'b1;
         buffer_read_offset = buffer_read_offset + 1;
         payload_out_start <= 1'b1; 
         payload_out_valid <= 1'b1;	
         payload_out_data <= {20'b0,buffer_data_out[35:24]};
         payload_out_state <=S_PAYLOAD_OUT_HEAD;
      end
		S_PAYLOAD_OUT_HEAD: begin
		   buffer_read <= 1'b1;
         buffer_read_offset = buffer_read_offset + 1;
         payload_out_valid <= 1'b1;	
         payload_out_data <= {8'h47,buffer_data_out[23:0]};
         payload_out_state <=S_PAYLOAD_OUT_READ;
		end
      S_PAYLOAD_OUT_READ : begin
        payload_out_valid <= 1'b1;
        payload_out_data <= buffer_data_out[31:0];
        buffer_read <= 1'b1;
        buffer_read_offset = buffer_read_offset + 1;
        payload_out_count <= payload_out_count +1;
        if (payload_out_count==((188/4)-3)) begin
          payload_out_count <= 0;
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
        if (payload_out_entry==P_TS_BUFFERS-1)begin
            payload_out_entry <= 0;
        end
        else begin
            payload_out_entry <= payload_out_entry + 1;
        end    
        payload_out_state <= S_PAYLOAD_OUT_END;
      end
      S_PAYLOAD_OUT_END: begin 
        buffer_read_offset = 0;
        payload_out_state <= S_PAYLOAD_OUT_IDLE; 
      end
    endcase

    buffer_read_address <= payload_out_entry * P_TS_BUFFER_SIZE/4 + buffer_read_offset;

  end
end


endmodule