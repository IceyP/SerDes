
//--------------------------------------------------------------------------------------------------
// File          : $ psi_filter.v$
// Last modified : $Date: 2012/08/22 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------

module psi_filter #(
  parameter TS_PROCESS_BASE_ADD       = 12'h310, 
  parameter BUS_DATE_L                = 12'h30a, 
  parameter BUS_DATE_H                = 12'h30b,                
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 16,
  parameter PAYLOAD_DATA_WIDTH        = 32                       
)(
  // Receive Transport stream 
   input                                 payload_clk,
   input                                 payload_rst,
   input                                 payload_in_valid,
   input                                 payload_in_start,
   input                                 payload_in_end,
   input  [PAYLOAD_DATA_WIDTH-1:0]       payload_in_data,
 
  input                                  avalon_clk,                     // Avalon-MM register interface
  input                                  avalon_rst,
  input                                  avalon_read,
  input                                  avalon_write,
  input       [P_AVALON_ADDR_WIDTH-1:0]  avalon_address,
  input       [P_AVALON_DATA_WIDTH-1:0]  avalon_writedata,
  output reg  [P_AVALON_DATA_WIDTH-1:0]  avalon_readdata,
  output reg                             avalon_waitrequest,
  output reg                             avalon_int

);
`include "alt_clogb2.v"  
/*---------------------------int match info------------------*/
  wire                                 r_waitrequest;
//  wire       [P_AVALON_DATA_WIDTH-1:0] r_readdata;
  wire                                 search_over;
  wire       [15:0]                    t_match_listnum;
  wire                                 t_match;
  reg [alt_clogb2(P_TS_BUFFERS+1)-1:0] read_level;
      
psi_filt_rx_info u_psi_filt_rx_info(
  // Receive Transport stream 
   .payload_clk                (payload_clk),
   .payload_rst                (payload_rst),
   .payload_in_valid           (payload_in_valid),
   .payload_in_start           (payload_in_start) ,
   .payload_in_end             (payload_in_end),
   .payload_in_data            (payload_in_data),
   .search_over                (search_over),
  // Avalon-MM register interface
   .avalon_clk                 (avalon_clk) ,                    
   .avalon_rst                 (avalon_rst),
   .avalon_read                (avalon_read),
   .avalon_write               (avalon_write),
   .avalon_address             (avalon_address),
   .avalon_writedata           (avalon_writedata),
//   .avalon_readdata            (r_readdata),
   .avalon_waitrequest         (r_waitrequest),
   .t_match_listnum            (t_match_listnum),
   .t_match                    (t_match)   
);
   defparam    u_psi_filt_rx_info.TS_PROCESS_BASE_ADD   = TS_PROCESS_BASE_ADD;   
   defparam    u_psi_filt_rx_info.BUS_DATE_L            = BUS_DATE_L; 
   defparam    u_psi_filt_rx_info.BUS_DATE_H            = BUS_DATE_H;
   defparam    u_psi_filt_rx_info.P_AVALON_ADDR_WIDTH   = P_AVALON_ADDR_WIDTH; 
   defparam    u_psi_filt_rx_info.P_AVALON_DATA_WIDTH   = P_AVALON_DATA_WIDTH;
   
//--------------------------------------------------------------------------------------------------
   
// Avalon interface and control registers
//
// Address  R&W                  Use
// =======  ====                 ===
// 1        R         [15:0]  read  TS FIFO STATUS    
// 2        R                 read  ts          
// 9        W                 clear FIFO
//--------------------------------------------------------------------------------------------------

localparam  READ_FIFO_DATA =TS_PROCESS_BASE_ADD + 4;
localparam  READ_FIFO_STATUS =TS_PROCESS_BASE_ADD + 5;
localparam  CLEAR_FIFO =TS_PROCESS_BASE_ADD + 6;
//-------------------------------------------------------------
// Buffer localparam
//--------------------------------------------------------------- 
localparam   P_TS_BUFFERS =  8;  
localparam   P_TS_BUFFER_SIZE = 192;      // Buffer size in bytes
localparam   P_TS_BUFFER_RAM_SIZE = P_TS_BUFFERS * P_TS_BUFFER_SIZE;     // RAM size in bytes

//----------------------------------------------------------
// Bus control
//----------------------------------------------------------
reg         avalon_buf_read;
reg         clear_fifo_tgl;
reg  [alt_clogb2(P_TS_BUFFERS+1)-1:0] write_level;
   
reg [P_AVALON_DATA_WIDTH-1:0] buffer_read_data;
reg       avalon_buf_readdatavalid;    
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_waitrequest  <= 1'b1;
    avalon_readdata     <= 32'd0;
    avalon_buf_read     <= 1'b0;
  end
  // Process accesses
  else begin
    avalon_buf_read     <= 1'b0;
    case (avalon_address)
      READ_FIFO_DATA :  begin
        avalon_waitrequest <= 1'b1;
        if(avalon_read & avalon_waitrequest )begin
		    avalon_buf_read <= 1'b1;
        end
	    if (avalon_buf_readdatavalid) begin
            avalon_readdata <= buffer_read_data;
            avalon_buf_read <= 1'b0;
            avalon_waitrequest <= 1'b0;    
        end
      end

      READ_FIFO_STATUS : begin
        avalon_waitrequest <= 1'b1;
        if(avalon_read & avalon_waitrequest )begin
          avalon_waitrequest <= 1'b0;
          avalon_readdata[15:0] <={read_level};
        end
      end
      CLEAR_FIFO : begin
        avalon_waitrequest <= 1'b1;
        clear_fifo_tgl <= ~clear_fifo_tgl; 
      end        
      default : begin
        avalon_waitrequest <= r_waitrequest;
        //avalon_readdata <= r_readdata;
        //avalon_readdata     <= 32'd0;
      end
    endcase
  end
end
//--------------------------------
//CLear buffer
//--------------------------------------
//pclk
reg clear_fifo_tgl_d1_pclk;
reg clear_fifo_tgl_d2_pclk;
reg clear_fifo_valid_pclk;
always @ (posedge payload_clk or posedge payload_rst)
begin
  if (payload_rst) begin
    clear_fifo_tgl_d1_pclk<=1'b0;
    clear_fifo_tgl_d2_pclk<=1'b0; 
    clear_fifo_valid_pclk <=1'b0; 
  end
  else begin
    clear_fifo_tgl_d1_pclk<=clear_fifo_tgl;
    clear_fifo_tgl_d2_pclk<=clear_fifo_tgl_d1_pclk;
    if(clear_fifo_tgl_d2_pclk!=clear_fifo_tgl_d1_pclk)begin
      clear_fifo_valid_pclk <=1'b1;
    end
    else begin
      clear_fifo_valid_pclk <=1'b0;
    end
  end
end
//aclk
reg clear_fifo_tgl_d1_aclk;
reg clear_fifo_tgl_d2_aclk;
reg clear_fifo_valid_aclk;
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    clear_fifo_tgl_d1_aclk<=1'b0;
    clear_fifo_tgl_d2_aclk<=1'b0; 
    clear_fifo_valid_aclk <=1'b0; 
  end
  else begin
    clear_fifo_tgl_d1_aclk<=clear_fifo_tgl;
    clear_fifo_tgl_d2_aclk<=clear_fifo_tgl_d1_aclk;
    if(clear_fifo_tgl_d2_aclk!=clear_fifo_tgl_d1_aclk)begin
      clear_fifo_valid_aclk <=1'b1;
    end
    else begin
      clear_fifo_valid_aclk <=1'b0;
    end
  end
end
//--------------------------------------------------------------------------------------------------
// Write to the buffer
//--------------------------------------------------------------------------------------------------
   
reg buffer_write;

reg  [31:0] buffer_writedata;
reg  [alt_clogb2(P_TS_BUFFERS+1)-1:0] t_write_level;
reg  [alt_clogb2(P_TS_BUFFER_SIZE)-1:0] write_offset;
reg  [alt_clogb2(P_TS_BUFFERS)-1:0] write_entry;
wire [alt_clogb2(P_TS_BUFFER_RAM_SIZE/4)-1:0] buffer_write_address;

reg  entry_written_tgl;
reg  [alt_clogb2(P_TS_BUFFERS)-1:0] read_entry;
reg  entry_read_tgl;
reg  entry_read_tgl_d1;
reg  entry_read_tgl_d2;
reg  entry_read; 
reg  [15:0] chan_num;               
reg        [1:0] write_buffer_state;   
localparam [1:0] S_BUFFER_IDLE      = 0;
localparam [1:0] S_PAYLOAD          = 1;
localparam [1:0] S_WAIT_MATCH       = 2;
localparam [1:0] S_MATCH_END        = 3;
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
    chan_num <= 0;
  end // if (payload_rst)  
  else if(clear_fifo_valid_pclk) begin
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
    chan_num <= 0;
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
     
    buffer_write <= 1'b0;    
    buffer_writedata <= payload_in_data;
    case (write_buffer_state)
      S_BUFFER_IDLE : begin
        write_offset <= 0;
        if (payload_in_valid & payload_in_start&(write_level< P_TS_BUFFERS)) begin
            buffer_write <= 1'b1;
            write_buffer_state <= S_PAYLOAD;
            chan_num[15:0] <= payload_in_data[15:0];
        end
      end
      S_PAYLOAD : begin
        if (payload_in_valid) begin
          buffer_write <= 1'b1;
          write_offset <= write_offset + 1; 
        end
        else begin
          buffer_write<= 1'b0;
          write_offset <= write_offset + 1;
        end  
        if (payload_in_end) begin
           write_buffer_state <= S_WAIT_MATCH;
        end
      end
     S_WAIT_MATCH : begin
	     if(t_match)begin
	    	  buffer_write <= 1'b1;    
          buffer_writedata <={t_match_listnum[15:0] ,chan_num[15:0]};
          write_offset <= 0;
          write_buffer_state <= S_MATCH_END; 
       end 
       else if(search_over)begin
         write_buffer_state <= S_BUFFER_IDLE;      
       end
       else begin
		     write_buffer_state <= S_WAIT_MATCH;
       end
     end		 
     S_MATCH_END : begin
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
    endcase // case (write_buffer_state)  
    write_level <= t_write_level;
    //avalon_int <= (write_level!=0);
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
               
  .clkb    (avalon_clk),
  .addrb   (buffer_read_address),
  .doutb   (buffer_data_out)        
  );
  //--------------------------------------------------------------------------------------------------
// Read from the buffer
//--------------------------------------------------------------------------------------------------// 
 
reg [2:0] payload_out_state;
reg [alt_clogb2(P_TS_BUFFERS)-1:0] payload_out_entry;
reg entry_written_tgl_d1;
reg entry_written_tgl_d2;
reg entry_written;

reg [7:0] buffer_read_offset;

localparam S_PAYLOAD_OUT_START   = 0;
localparam S_PAYLOAD_OUT_REG     = 1;  
localparam S_PAYLOAD_OUT_HIGH    = 2;
localparam S_PAYLOAD_OUT_LOW     = 3;
localparam S_PAYLOAD_OUT_END     = 4;
   
//reg    buffer_overflow;

always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    payload_out_state <= S_PAYLOAD_OUT_START;
    entry_read_tgl <= 1'b0;
    payload_out_entry <= 0;
    entry_written_tgl_d1 <= 1'b0;
    entry_written_tgl_d2 <= 1'b0;
    entry_written <= 1'b0;
    read_level = 0; 
//    buffer_overflow <= 1'b0;
    buffer_read_offset <= 0;
    buffer_read_data <=0;
    avalon_buf_readdatavalid<=1'b0;   
  end
  else if(clear_fifo_valid_aclk)begin
  	payload_out_state <= S_PAYLOAD_OUT_START;
    entry_read_tgl <= 1'b0;
    payload_out_entry <= 0;
    entry_written_tgl_d1 <= 1'b0;
    entry_written_tgl_d2 <= 1'b0;
    entry_written <= 1'b0;
    read_level = 0; 
//    buffer_overflow <= 1'b0;
    buffer_read_offset <= 0;
    buffer_read_data <=0;
    avalon_buf_readdatavalid<=1'b0;
  end
  else begin
    entry_written_tgl_d1 <= entry_written_tgl;
    entry_written_tgl_d2 <= entry_written_tgl_d1;
    entry_written <= (entry_written_tgl_d2!=entry_written_tgl_d1);
    
    if (entry_written)
      read_level = read_level + 1;
    else 
      read_level = read_level;
      
    avalon_int <= (read_level>=5);    
    //if(read_level ==P_TS_BUFFERS)
    //  buffer_overflow <=1'b1;
    //else
    //  buffer_overflow <=1'b0;
     
    buffer_read_data <=0;
    avalon_buf_readdatavalid<=1'b0;   
    case (payload_out_state)
      S_PAYLOAD_OUT_START : begin
        if ((read_level!=0) & avalon_buf_read) begin         
           payload_out_state <= S_PAYLOAD_OUT_REG;
        end
      end
      S_PAYLOAD_OUT_REG : begin
        payload_out_state <= S_PAYLOAD_OUT_HIGH;
      end
        
      S_PAYLOAD_OUT_HIGH:begin
         buffer_read_data <=buffer_data_out[31:16];
         avalon_buf_readdatavalid<=1'b1;        
         payload_out_state <=S_PAYLOAD_OUT_LOW;
      end
      S_PAYLOAD_OUT_LOW:begin
        if(avalon_buf_read&(~avalon_buf_readdatavalid))begin
           buffer_read_data <=buffer_data_out[15:0];
           avalon_buf_readdatavalid<=1'b1;
           payload_out_state <= S_PAYLOAD_OUT_END;
        end
      end
           
      S_PAYLOAD_OUT_END : begin
        if(buffer_read_offset==(P_TS_BUFFER_SIZE/4-1))begin
          read_level = read_level - 1;
          entry_read_tgl <= ~entry_read_tgl;
          buffer_read_offset<=0;
          if(payload_out_entry==P_TS_BUFFERS-1)begin
             payload_out_entry <= 0;
          end
          else begin
             payload_out_entry <= payload_out_entry + 1;
          end
        end
        else begin
           buffer_read_offset <= buffer_read_offset + 1;
        end // else: !if(buffer_read_offset==(P_TS_BUFFER_SIZE/4-1))
        payload_out_state <= S_PAYLOAD_OUT_START;
      end // case: S_PAYLOAD_OUT_END
      default:;
    endcase    
  end
end
assign    buffer_read_address = payload_out_entry * P_TS_BUFFER_SIZE/4 + buffer_read_offset;

endmodule
