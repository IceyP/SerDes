
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $udp_ts_tx_dma.v$
// Last modified : $Date: 2012/7/17 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------
//
// Payload output module.
//
// 1. Wait for output request, checking payload_out_ready is asserted
// 2. Read frame status information from frame buffer
// 3. Determine the offset of the payload data in the frame (noting that it might not be on a word boundary)
// 4. Read the payload from the frame buffer and output, responding to payload_out_ready negation
// 5. release_req the pointer. Return to 1
//
// The design is written to assume that payload_clk and system_clk are unrelated.
//
///--------------------------------------------------------------------------------------------------
module udp_ts_tx_dma #(
  parameter P_POINTER_WIDTH          = 2,          // Width of pointer signal
  parameter P_BUFFER_PARAMETER_WORD   = 50,        // Location in buffer of frame parameter data
  parameter P_BUFFER_ADDRESS_BITS   = 8
  )(

  output reg                       release_req,
  output wire [P_POINTER_WIDTH-1:0] release_pointer,
  input                            release_ack,

  input                            payload_clk,          // Payload clock
  input                            payload_rst,          // Payload reset
  
  // Output request
  input                            payload_out_req,
  output reg                       payload_out_ack,
  input  [P_POINTER_WIDTH-1:0]      payload_out_pointer,
 // input  [15:0]                  payload_out_channel,
 // input                            payload_out_dont_flush,

  
  // Payload output
  input                            payload_out_ready,
  output reg [31:0]                payload_out_data,
  output reg                       payload_out_valid,
 // output reg [10:0]                payload_out_length,
  output reg                       payload_out_start,
  output reg                       payload_out_end,



  output reg                              buffer_read,          // Read request to Frame Buffer
  output reg [P_POINTER_WIDTH-1:0]         buffer_pointer,       // Pointer to entry being read
  output reg [P_BUFFER_ADDRESS_BITS-1:0]  buffer_address,       // Address offset within the entry
  input      [31:0]                       buffer_readdata      // Read data
  );

localparam  P_LENTH_188 = 188;
localparam  PCR_FLAG = 3'b101;//2012.3.23
//--------------------------------------------------------------------------------------------------
// Read data from frame buffer and send to output
//--------------------------------------------------------------------------------------------------

reg [2:0]   dma_state;
reg [7:0]   dma_count;
reg [31:0]  store_param;
reg sop_pending;
reg eop_pending;
reg eop_pending_d1;
reg eop_pending_d2;
reg buffer_read_d1;
reg buffer_read_d2;
reg [P_BUFFER_ADDRESS_BITS-1:0]  buffer_address_d1;
//reg [P_BUFFER_ADDRESS_BITS-1:0]  buffer_address_d2;
reg payload_out_ready_d;

localparam S_DMA_IDLE = 0;
localparam S_DMA_GET_PARAM = 1;
localparam S_DMA_CHANNEL_MAP =2;
localparam S_DMA_REPLACE_PID =3;
localparam S_DMA_READ = 4;
localparam S_DMA_END = 5;
localparam S_DMA_FREE =6;
localparam S_DMA_FREE_ACK =7;
always @ (posedge payload_clk or posedge payload_rst)
begin
  if (payload_rst) begin
    dma_state           <= S_DMA_IDLE;
    dma_count           <= 0;
    store_param         <= 0;
    buffer_read         <= 1'b0;
    buffer_read_d1      <= 1'b0;
    buffer_read_d2      <= 1'b0;
    buffer_pointer      <= 0;
    buffer_address      <= 0;
    buffer_address_d1    <= 0;
   // buffer_address_d2    <= 0;
    payload_out_valid   <= 1'b0;
    payload_out_data    <= 32'b0;
   // payload_out_length  <= 11'b0;
    payload_out_start   <= 1'b0;
    payload_out_end     <= 1'b0;
    payload_out_ack     <= 1'b0;
    payload_out_ready_d <= 1'b0;
    release_req         <= 1'b0;
    sop_pending         <= 1'b0;
    eop_pending         <= 1'b0;
    eop_pending_d1      <= 1'b0;
    eop_pending_d2      <= 1'b0;
  end
  else begin

    // Defaults
    
    buffer_read    <= 1'b0;
    buffer_read_d1 <= buffer_read;
    buffer_read_d2 <= buffer_read_d1;
    buffer_address <= buffer_address_d1;
    eop_pending    <= 1'b0;
    eop_pending_d1 <= eop_pending;
    eop_pending_d2 <= eop_pending_d1;

    payload_out_ready_d <= payload_out_ready;

    // Payload output
    payload_out_valid <= 1'b0;
    payload_out_start <= 1'b0;
    payload_out_end   <= 1'b0;
    payload_out_ack   <= 1'b0;
    if (payload_out_ready) begin
      payload_out_start <= sop_pending;
      sop_pending       <= 1'b0;
      if (eop_pending_d2)
        payload_out_end <= 1'b1;
    end
    payload_out_data  <= 0;
    payload_out_valid <= 0;
    // Transfer state machine
    case (dma_state)

      // Wait for request. Ensure output is ready.
      S_DMA_IDLE : begin
        if (payload_out_req & payload_out_ready) begin
          dma_count   <= 0;
          buffer_pointer  <= payload_out_pointer;
          // Read the parameter word first to get length, channel etc
          buffer_read     <= 1'b1;
          buffer_address  <= P_BUFFER_PARAMETER_WORD;
          buffer_address_d1<= 0; 
         // buffer_address_d2<= 0;   
          dma_state       <= S_DMA_GET_PARAM;
        end
      end

      // Store parameter data then start main data DMA
      S_DMA_GET_PARAM : begin
         dma_count   <= dma_count + 4;
         buffer_read <= 1'b1;
         buffer_address_d1 <= buffer_address_d1 + 1;
        if (buffer_read_d2) begin
         // payload_out_length  <= buffer_readdata[23]? P_LENTH_204 : P_LENTH_188; 
          store_param <= buffer_readdata;
          dma_state   <= S_DMA_CHANNEL_MAP;
        end
      end
      S_DMA_CHANNEL_MAP: begin
        if (payload_out_ready)begin
          buffer_read <= 1'b1;
          buffer_address_d1 <= buffer_address_d1 + 1;
          payload_out_data  <={ 16'b0,store_param[31:16]}; //2012.3.23
          payload_out_valid <= 1'b1;
          payload_out_start <= 1'b1;
          dma_count   <= dma_count + 4;
          dma_state   <= S_DMA_REPLACE_PID;
        end
        else begin
           dma_state   <= S_DMA_IDLE;
        end
      end
      S_DMA_REPLACE_PID: begin  
         if (payload_out_ready) begin
           buffer_read <= 1'b1;
           buffer_address_d1 <= buffer_address_d1 + 1;
           payload_out_data <={buffer_readdata[31:21],store_param[12:0],buffer_readdata[7:0]};
           payload_out_valid <= 1'b1;
           dma_count   <= dma_count + 4;
           dma_state   <= S_DMA_READ;
         end
         else begin
           dma_state   <= S_DMA_IDLE;
         end
      end
      // Read packet from buffer RAM
      S_DMA_READ : begin
        if (payload_out_ready) begin 
          payload_out_data <=buffer_readdata;
          payload_out_valid <= 1'b1;
          buffer_read    <= 1'b1;
          buffer_address <= buffer_address + 1;
          dma_count <= dma_count + 4;
          if (dma_count>=P_LENTH_188) begin
            eop_pending <= 1'b1;
            dma_state <= S_DMA_END;
          end
        end
        // Jump back 3 words if ready goes low and cancel pending reads to compensate for output pipeline
        else if (payload_out_ready_d) begin
          buffer_read    <= 1'b0;
          buffer_read_d1 <= 1'b0;
          buffer_read_d2 <= 1'b0;
          buffer_address <= buffer_address - 3;
          dma_count <= dma_count - 12;
        end
      end

      // Wait for end of packet output. Need to jump back and reread if payload_out_ready gets negated before end has gone
      S_DMA_END : begin
        if (payload_out_end) begin
          dma_state <= S_DMA_FREE;
          release_req <= 1'b1;
          payload_out_ack  <= 1'b1;
        end
        else if (payload_out_ready) begin
          payload_out_data <=buffer_readdata;
          payload_out_valid <= 1'b1;
        end 
        else begin
          buffer_read <= 1'b0;
          buffer_read_d1 <= 1'b0;
          buffer_read_d2 <= 1'b0;
          buffer_address <= buffer_address - 3;
          dma_count <= dma_count - 12;
          dma_state <= S_DMA_READ;
        end
      end
      S_DMA_FREE : begin
        if(release_ack)
        begin
          release_req <= 1'b0;
          dma_state <=S_DMA_FREE_ACK; 
        end 
        else begin
          dma_state <=S_DMA_FREE;
         end 
      end
      S_DMA_FREE_ACK  :begin
        dma_state <= S_DMA_IDLE;
      end
    endcase

  end
end
assign release_pointer = payload_out_pointer;
endmodule