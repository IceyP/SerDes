module   host_ts_mux  #(
  parameter TS_PROCESS_BASE_ADD       = 12'h310, 
  parameter BUS_DATE_L                = 12'h180, 
  parameter BUS_DATE_H                = 12'h181,                
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 16,
  parameter PAYLOAD_DATA_WIDTH        = 32, 			
  parameter TS_CHANS                  = 1      
) (
 
  input 			       avalon_clk, // Avalon-MM register interface
  input 			       avalon_rst,
  // host receiver 
  input 			       avalon_read,
  input 			       avalon_write,
  input [P_AVALON_ADDR_WIDTH-1:0]       avalon_address,
  input [P_AVALON_DATA_WIDTH-1:0]       avalon_writedata,
  output wire [P_AVALON_DATA_WIDTH-1:0] avalon_readdata,
  output wire 			                       avalon_waitrequest,
   
  input 			                     payload_clk,
  input 			                     payload_rst,
  input                                 ddr_user_clk,
  input                                 ddr_user_rst,
  input [31:0]                          sc_data_pkt_d,
  input                                 sc_data_pkt_dval,
  input                                 sc_data_pkt_sop,
  input                                 sc_data_pkt_eop,
  // ts receiver 
  input [TS_CHANS-1:0] 		       payload_in_valid,
  input [TS_CHANS*32-1:0] 	     payload_in_data,
  input [TS_CHANS-1:0] 		       payload_in_start,
  input [TS_CHANS-1:0] 		       payload_in_end, 
   // output wire [TS_CHANS-1:0] payload_in_ready,
   
  output reg 			       payload_out_valid,
  output reg [31:0] 		 payload_out_data,
  output reg 			       payload_out_start,
  output reg 			       payload_out_end
   
 );
 `include "alt_clogb2.v"
// Parameter Declaration(s)

localparam    ALL_CHANS     = 3;   //+HOST CHAN
localparam    HOST_CHAN_ID  = 1;
localparam    SC_DATA_ID    = 2;
localparam    CHAN_IDX_WIDTH = 2;
   
//wire [TS_CHANS-1:0]    payload_in_ready_by_chan; 

wire [31:0]             payload_out_data_by_chan [ALL_CHANS-1:0];
wire [ALL_CHANS-1:0]    payload_out_valid_by_chan;
wire [ALL_CHANS-1:0]    payload_out_start_by_chan;
wire [ALL_CHANS-1:0]    payload_out_end_by_chan;
wire [ALL_CHANS-1:0]    payload_req_out;   

reg [ALL_CHANS-1:0]     chan_out_req;
wire [ALL_CHANS-1:0]    chan_out_ack;
wire [ALL_CHANS-1:0]    buffer_overflow_by_chan;

genvar i;
generate
  for(i=0;i<TS_CHANS;i=i+1)
  begin:BUFFER_GEN
  ts_input_fifo  #(
                    .PAYLOAD_DATA_WIDTH          (PAYLOAD_DATA_WIDTH)
                  )u_ts_chan_buf(
                    .payload_clk                 (payload_clk    ),
                    .payload_rst                 (payload_rst    ),

                  // Payload input
                 //   .payload_ready    (payload_in_ready[i]),
                 //   .payload_channel  (payload_in_channel[16*i+15:16*i]),
                    .payload_in_data        (payload_in_data[32*i+31:32*i]),
                    .payload_in_valid       (payload_in_valid[i]    ),
                    .payload_in_start       (payload_in_start[i]    ),
                    .payload_in_end         (payload_in_end[i]      ),
                //    .payload_length    (payload_in_length[11*i+10:11*i]),
				   
                 // Payload output
                    .payload_out_data    (payload_out_data_by_chan[i]    ),
                    .payload_out_valid   (payload_out_valid_by_chan[i]   ),
                    .payload_out_start   (payload_out_start_by_chan[i]   ),
                    .payload_out_end     (payload_out_end_by_chan[i]     ),
                  // out req
                    .payload_req_out     (payload_req_out[i]),
                  // Output request
                    .chan_out_req        (chan_out_req[i]),     //
                    .chan_out_ack        (chan_out_ack[i]), //"0" is payloading a pacaket ,once complete a pacaket output then set  to "1"
                    .buffer_overflow     (buffer_overflow_by_chan[i])
  );
  end
endgenerate
   
psi_inject_fifo  #(
  .TS_PROCESS_BASE_ADD     (TS_PROCESS_BASE_ADD), 
  .BUS_DATE_L              (BUS_DATE_L), 
  .BUS_DATE_H              (BUS_DATE_H),                
  .P_AVALON_ADDR_WIDTH     (P_AVALON_ADDR_WIDTH), 
  .P_AVALON_DATA_WIDTH     (P_AVALON_DATA_WIDTH),
  .PAYLOAD_DATA_WIDTH      (PAYLOAD_DATA_WIDTH)                      
)u_host_chan_buf( 
 // Avalon-MM register interface
   .avalon_clk             (avalon_clk),
   .avalon_rst             (avalon_rst),
   .avalon_read            (avalon_read),
   .avalon_write           (avalon_write),
   .avalon_address         (avalon_address),
   .avalon_writedata       (avalon_writedata),
   .avalon_readdata        (avalon_readdata),
   .avalon_waitrequest     (avalon_waitrequest),

   .payload_clk            (payload_clk),
   .payload_rst            (payload_rst),
   .payload_out_valid      (payload_out_valid_by_chan[HOST_CHAN_ID]),
   .payload_out_start      (payload_out_start_by_chan[HOST_CHAN_ID]),
   .payload_out_end        (payload_out_end_by_chan[HOST_CHAN_ID]),
   .payload_out_data       (payload_out_data_by_chan[HOST_CHAN_ID]),
  
   .payload_req_out        (payload_req_out[HOST_CHAN_ID]),

   .chan_out_req           (chan_out_req[HOST_CHAN_ID]),
   .chan_out_ack           (chan_out_ack[HOST_CHAN_ID]),
  
   .buffer_overflow        (buffer_overflow_by_chan[HOST_CHAN_ID])
  );

ecm_emm_inject u0_ecm_emm_inject(
    .ddr_user_clk                       ( ddr_user_clk              ),
    .ddr_user_rst                       ( ddr_user_rst              ),
    .clk                                ( payload_clk               ),
    .rst                                ( payload_rst               ),
    
    .sc_data_pkt_d                      ( sc_data_pkt_d             ),
    .sc_data_pkt_dval                   ( sc_data_pkt_dval          ),
    .sc_data_pkt_sop                    ( sc_data_pkt_sop           ),
    .sc_data_pkt_eop                    ( sc_data_pkt_eop           ),
    
    .payload_out_valid                  ( payload_out_valid_by_chan[2]),
    .payload_out_start                  ( payload_out_start_by_chan[2]),
    .payload_out_end                    ( payload_out_end_by_chan[2]),
    .payload_out_data                   ( payload_out_data_by_chan[2]),
    
    .payload_req_out                    ( payload_req_out[2]        ),
    .chan_out_req                       ( chan_out_req[2]           ),
    .chan_out_ack                       ( chan_out_ack[2]           ),
    .buffer_overflow                    ( buffer_overflow_by_chan[2])
    );
    
//--------------------------------------------------------------------------------------------------
// Multiplex accesses based on simple priority. We can do this because it will take less
// time to process every CHANNEL than the minimum duration between requests on any one CHANNEL.
//--------------------------------------------------------------------------------------------------

// State enumerations
localparam P_OUT_STATE_WIDTH = 3;
localparam P_OUT_STATE_IDLE  = 3'd0;
localparam P_OUT_STATE_DRIVE = 3'd1;   
localparam P_OUT_STATE_NEXT  = 3'd2;

// Pop side FSM
reg  [P_OUT_STATE_WIDTH-1:0]           out_current_state;
reg  [P_OUT_STATE_WIDTH-1:0]           out_next_state;

//--------------------------------------------------------------------------------------------------
// Payload output read FSM
//--------------------------------------------------------------------------------------------------
reg  [CHAN_IDX_WIDTH-1:0]   payload_out_chan;
// Next state logic
always @*
begin
   case(out_current_state)
      P_OUT_STATE_IDLE:
      begin
         if(payload_req_out[payload_out_chan])
         begin
            out_next_state = P_OUT_STATE_DRIVE;
         end
         else 
         begin
           out_next_state = P_OUT_STATE_NEXT; 
         end
      end

      P_OUT_STATE_DRIVE:
      begin
         if(chan_out_ack[payload_out_chan])
         begin
            out_next_state = P_OUT_STATE_NEXT;
         end
         else
         begin
            out_next_state = P_OUT_STATE_DRIVE;   //wait ack
         end
      end

      P_OUT_STATE_NEXT:
      begin
         out_next_state = P_OUT_STATE_IDLE; 
      end
      default:out_next_state = P_OUT_STATE_IDLE;
   endcase
end


// State registers
always @(posedge payload_clk or posedge  payload_rst)
begin
   if( payload_rst)
   begin
      out_current_state <= P_OUT_STATE_IDLE;
   end
   else
   begin
      out_current_state <= out_next_state;
   end
end

always @(posedge  payload_clk or posedge  payload_rst)
begin
   if( payload_rst) begin
      payload_out_chan <= 0;
   end
   else begin
      if(out_current_state == P_OUT_STATE_NEXT) begin
         if(payload_out_chan==(ALL_CHANS-1))begin	   
            payload_out_chan  <= 0;
         end
	       else begin
	         payload_out_chan <= payload_out_chan + 1'b1;
	       end  
	    end   
   end
end

always @*
begin
   chan_out_req = {ALL_CHANS{1'b0}};
   chan_out_req[payload_out_chan] = (out_current_state == P_OUT_STATE_DRIVE);
end


//--------------------------------------------------------------------------------------------------
// Payload output multiplexor
//--------------------------------------------------------------------------------------------------

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
     payload_out_valid<=0;
     payload_out_data<=0;
     payload_out_start<=0;
     payload_out_end<=0;
   end
   else
   begin
     payload_out_data <= payload_out_data_by_chan[payload_out_chan];
     payload_out_valid <= payload_out_valid_by_chan[payload_out_chan];
     payload_out_start <= payload_out_start_by_chan[payload_out_chan];
     payload_out_end <= payload_out_end_by_chan[payload_out_chan];
   end
end
endmodule
