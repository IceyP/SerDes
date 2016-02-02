//--------------------------------------------------------------------------------------------------
// (c)2010 CTI Corporation. All rights reserved.

//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $udp_ts_rx_dma.v$
// Last modified : $Date: 2010/10/20 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------
//
// Control function for packet reception.
//
// 1. Fetch pointer to free location in frame buffer
// 2. Receive packet (8-bit) and write to frame buffer (32-bit)
// 3. Check match status at end of packet. If not matched, return to 2 (packet is discarded)
// 4. Write packet status (channel, length, timestamp etc) to frame buffer status words
// 5. Queue pointer to appropriate queue. Return to 1
//
// Packets received when no pointers are available are discarded (and counted).
//
// The match result must be valid before payload_in_end is seen. If rx_match is low when payload_in_end is asserted
// then the packet will be discarded.
//
//--------------------------------------------------------------------------------------------------
module udp_ts_rx_dma #(
  //parameter P_PORT_IDX_WIDTH          = 8,
  parameter P_POINTER_WIDTH             = 2,          // Width of pointer signal
  parameter P_BUFFER_ADDRESS_BITS       = 8,
 // parameter P_BIG_ENDIAN              = 0,          // Set to 1 for big endian host access to frame buffer
//  parameter P_RECORD_TIMESTAMP        = 1'b1,       // Assert to record timestamp for start of frame reception
  parameter P_BUFFER_PARAMETER_WORD     = 50        // Location in buffer of frame parameter data
  //parameter P_BUFFER_TIMESTAMP_WORD   = 62         // Location in buffer of frame control data
)(
  input                           clk,
  input                           rst,

  // Free pointer fetch
  output reg                      fetch,
  input      [P_POINTER_WIDTH-1:0] fetch_pointer,
  input                           fetch_ack,

  // Receive Transport stream 

   input                           payload_in_valid,
   input                           payload_in_start,
   input                           payload_in_end,
   input                 [31:0]    payload_in_data,

  
  // Interface to frame buffer (Avalon master)
  output reg [P_POINTER_WIDTH-1:0]       buffer_pointer,
  output reg [P_BUFFER_ADDRESS_BITS-1:0] buffer_address,
  output reg                             buffer_write,
  output reg               [31:0]        buffer_writedata,
  input                                  buffer_waitrequest,

  // Channel match status
  input                             rx_match,
  input [31:0]                      maped_pap,
  input                             match_end,


  // Receive queue load
  output reg                      load,
  output reg [P_POINTER_WIDTH-1:0] load_pointer,
  input                           load_ack,
  output reg                      frame_discard,
  //payload ready
  output reg                      payload_in_ready

);
//localparam P_WIDTH_LEFT = (8-P_PORT_IDX_WIDTH);


reg        load_pending;
reg        pointer_valid;
reg [P_POINTER_WIDTH-1:0] pointer;

reg        store_frame;
reg        payload_in_valid_d;
//reg        payload_in_end_d;
reg  [31:0]payload_in_data_d;
reg  [2:0] state;
//reg [10:0] rx_length;

localparam [2:0] S_IDLE               = 3'b000;
localparam [2:0] S_SET_BASE           = 3'b001;
localparam [2:0] S_WAIT_FOR_MATCH     = 3'b010;
localparam [2:0] S_WAIT_FOR_EOP       = 3'b011;
localparam [2:0] S_STORE_PARAMETERS   = 3'b100;
localparam [2:0] S_DISCARD            = 3'b111;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    state               <= S_IDLE;
    fetch               <= 1'b0;
    buffer_address      <= 0;
    buffer_write        <= 1'b0;
    buffer_writedata    <= 32'b0;
    load          <= 1'b0;
    load_pending  <= 1'b0;
    load_pointer  <= 0;
    pointer_valid       <= 1'b0;
    pointer             <= 0;
    store_frame         <= 1'b0;
    payload_in_valid_d <= 1'b0;
//    payload_in_end_d <= 1'b0;
    frame_discard       <= 1'b0;
    payload_in_ready    <= 1'b1;
  end
  else begin

    frame_discard       <= 1'b0;
    buffer_write <= 1'b0;
//    payload_in_end_d  <= payload_in_end;
    payload_in_valid_d <=payload_in_valid;
    payload_in_data_d <= payload_in_data;
    // Fetch pointer to free buffer
    if (~pointer_valid & ~fetch_ack) begin
      fetch <= 1'b1;
    end
    else if (fetch_ack) begin
      fetch         <= 1'b0;
      pointer_valid <= 1'b1;
      pointer       <= fetch_pointer;
      if (pointer_valid)
        $display("Error - pointer fetched when one already stored!");
    end

    // Action queue load once final buffer write is complete
    if (load_pending & ~buffer_write) begin
      load <= 1'b1;
      load_pending <= 1'b0;
    end

    // Complete queue load when ack seen
    if (load & load_ack) begin
      load <= 1'b0;
    end


    // Catch case where START received but not in idle state - shouldn't happen
    if (payload_in_valid & payload_in_start & state!=S_IDLE)
      frame_discard <= 1'b1;

    // State machine to track frame reception & match
    case (state)
      S_IDLE        : begin
                       // byte_count = 0;
                        store_frame <= 1'b0;
                        payload_in_ready    <= 1'b1;
                        // Start of frame
                        if (pointer_valid & payload_in_valid & payload_in_start) begin
                          buffer_pointer <= pointer;
                          payload_in_ready    <= 1'b0;
                          state <= S_SET_BASE;
                        end
                        else if (payload_in_valid & payload_in_start) begin
                          $display("Frame received when no buffer available - discard");
                          frame_discard <= 1'b1;
                          state <= S_DISCARD;
                        end
                      end

      S_SET_BASE      : begin 
                           store_frame <= 1'b1;
                           buffer_write <= 1'b1;
                           buffer_writedata <= payload_in_data_d;
                           buffer_address <= 0;
									state <= S_WAIT_FOR_EOP;                     
                        end
								
     S_WAIT_FOR_EOP   : begin
                           if (payload_in_valid & payload_in_end) begin   //~valid is packet over
									     state <= S_WAIT_FOR_MATCH;  
                           end 
                        end
								
      S_WAIT_FOR_MATCH : begin
                           if (rx_match) begin
                             state <= S_STORE_PARAMETERS;
                           end
                           else if (match_end) begin
                             state <= S_IDLE;
                           end
                         end


    S_STORE_PARAMETERS   : begin
                             store_frame <= 1'b0;
                             buffer_address   <= P_BUFFER_PARAMETER_WORD;
                             buffer_writedata <= maped_pap;
                             buffer_write     <= 1'b1;
                             load_pointer <= pointer;
                             load_pending <= 1'b1;
                             pointer_valid <= 1'b0;
                             state <= S_IDLE;
                             if (load)
                                 $display("Error - attempt to load queue when previous load still pending");
                             if (payload_in_valid & payload_in_start)
                               $display("Error - frame received while still processing previous one!");
                           end

      S_DISCARD        : if (payload_in_valid & payload_in_end) begin
                           state <= S_IDLE;
                         end
      default:;
    endcase
    // Store frame to buffer
    if (payload_in_valid_d & store_frame & (~buffer_waitrequest)) begin
        buffer_write <= 1'b1;
        buffer_writedata <= payload_in_data_d;
        buffer_address <= buffer_address + 1;
    end
  end
end
endmodule