
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $udp_ts_map.v$
// Last modified : $Date: 2012/7/17 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------
//
// This design consists of a number of input buffers and an output FIFO. One input buffer is
// required for each transport stream input. The buffers perform full conversion on each input
// port and request this circuit to push a pointer to each completed frame into the output FIFO.
// This circuit arbitrates between the various buffers to control FIFO pushes. It also pops items
// from the FIFO one by one and requests the corresponding buffer to drive the output. Finally,
// this circuit multiplexes the access to the output port between the various buffers.
//
//--------------------------------------------------------------------------------------------------

module udp_ts_map (

   // Transport stream inputs
   payload_clk,
   payload_rst,
   payload_in_valid,
   payload_in_start,
   payload_in_end,
   payload_in_data,
   payload_in_ready,  
   
   //Payload out
   payload_out_data,
   payload_out_valid,
   payload_out_start,
   payload_out_end,
   
	//buffer state
   over_flow,
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
 // Host config param

parameter P_AVALON_ADDR_WIDTH       = 12; 
parameter P_AVALON_DATA_WIDTH       = 16;

parameter TS_PROCESS_BASE_ADD       = 12'h310;
parameter BUS_DATA_L                = 12'h180;
parameter BUS_DATA_H                = 12'h181;
   
// Configurable parameters
parameter P_INCLUDE_GEN            = 0;
parameter P_NUM_OUTPUTS            = 16; // Number of transport stream ports 
//parameter PSI_INFO_CHAN               = P_NUM_OUTPUTS; //PSI anaysis chan 
//parameter IP_CHAN_STATUS           = P_NUM_OUTPUTS + 1;                       
parameter P_OUTPUT_FIFO_DEPTH      = P_NUM_OUTPUTS + 1; // The number of entries in the output FIFO
// Derived parameters
parameter P_POINTERS                = 20;          // Maximum number of pointers (Frame Buffer entries) supported
parameter P_POINTER_WIDTH          = alt_clogb2(P_POINTERS);
parameter P_PORT_IDX_WIDTH         = alt_clogb2(P_NUM_OUTPUTS);
parameter P_OUTPUT_FIFO_WIDTH      = P_PORT_IDX_WIDTH + P_POINTER_WIDTH;


// State enumerations
parameter P_PUSH_STATE_WIDTH = 1;
parameter P_PUSH_STATE_IDLE      = 1'd0;
parameter P_PUSH_STATE_PUSH      = 1'd1;

parameter P_POP_STATE_WIDTH  = 3;
parameter P_POP_STATE_IDLE       = 3'd0;
parameter P_POP_STATE_POP        = 3'd1;
parameter P_POP_STATE_REGISTER   = 3'd2;
parameter P_POP_STATE_DRIVE      = 3'd3;
parameter P_POP_STATE_WAIT       = 3'd4;



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
output                                  payload_in_ready;
//transmit data - Atlantic source

output [31:0]                          payload_out_data;
output                                 payload_out_valid;
output                                 payload_out_start;
output                                 payload_out_end;

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

output reg                             over_flow;
//--------------------------------------------------------------------------------------------------
// Signal definitions
//--------------------------------------------------------------------------------------------------

// Output FIFO update
wire [P_NUM_OUTPUTS-1:0]               output_fifo_update_req_by_port;
reg  [P_NUM_OUTPUTS-1:0]               output_fifo_update_ack_by_port;
wire [P_POINTER_WIDTH-1:0]             output_fifo_pointer_by_port [P_NUM_OUTPUTS-1:0];
wire [P_PORT_IDX_WIDTH-1:0]            output_fifo_channel_by_port [P_NUM_OUTPUTS-1:0];

wire                                   output_fifo_update_req;
wire [P_POINTER_WIDTH-1:0]             output_fifo_pointer;
wire [P_PORT_IDX_WIDTH-1:0]            output_fifo_channel;

// Output request
reg  [P_NUM_OUTPUTS-1:0]                payload_out_req;
wire [P_NUM_OUTPUTS-1:0]                payload_out_ack;
reg  [P_POINTER_WIDTH-1:0]              payload_out_pointer;

// Payload output
wire [31:0]                             payload_out_data_by_port [P_NUM_OUTPUTS-1:0];
wire [P_NUM_OUTPUTS-1:0]                payload_out_valid_by_port;
wire [P_NUM_OUTPUTS-1:0]                payload_out_start_by_port;
wire [P_NUM_OUTPUTS-1:0]                payload_out_end_by_port;

reg                                    payload_in_ready;

reg  [31:0]                            payload_out_data;
reg                                    payload_out_valid;
reg                                    payload_out_start;
reg                                    payload_out_end;

wire  [P_NUM_OUTPUTS-1:0]              overflow_flag_local_by_port;
// Configuration controls

//reg                                    gen_run [P_NUM_OUTPUTS-1:0];
//reg  [15:0]                            gen_ipg [P_NUM_OUTPUTS-1:0];
//wire                                   update_avalon_settings;

wire [P_NUM_OUTPUTS-1:0]                overflow_flag_by_port;
//reg  [P_NUM_CHANNELS-1:0]              overflow_flag_by_channel;
reg                                    clear_input_overflow;
reg                                    output_fifo_overflow_pclk;
reg                                    output_fifo_overflow_metastable;
reg                                    output_fifo_overflow_aclk;
reg                                    clear_output_overflow_tgl_aclk;
reg                                    clear_output_overflow_tgl_metastable;
reg                                    clear_output_overflow_tgl_pclk;
reg                                    clear_output_overflow_tgl_r_pclk;
wire                                   clear_output_overflow_pclk;


// Push side FSM
reg  [P_PUSH_STATE_WIDTH-1:0]          push_current_state;
reg  [P_PUSH_STATE_WIDTH-1:0]          push_next_state;

// Push muliplexor
reg  [P_PORT_IDX_WIDTH-1:0]            output_fifo_access_port_c;
reg  [P_PORT_IDX_WIDTH-1:0]            output_fifo_access_port;

// Output fifo signals
wire                                   output_fifo_push;
wire                                   output_fifo_pop;
wire                                   output_fifo_full;
wire                                   output_fifo_empty;
wire [P_AVALON_DATA_WIDTH-1:0]         output_fifo_write_data;
wire [P_AVALON_DATA_WIDTH-1:0]         output_fifo_read_data;

// Output fifo read multiplexor
reg  [P_NUM_OUTPUTS-1:0]                payload_out_port;
//wire [P_PORT_IDX_WIDTH-1:0]            output_req_channel;
//reg  [P_PORT_IDX_WIDTH-1:0]            output_req_channel_r;


// Pop side FSM
reg  [P_POP_STATE_WIDTH-1:0]           pop_current_state;
reg  [P_POP_STATE_WIDTH-1:0]           pop_next_state;

// Registered versions of output signals, used for output handshake timing
//reg                                    payload_out_ready_r;
//reg                                    payload_out_valid_r;


//--------------------------------------------------------------------------------------------------
// Registers
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// Avalon slave port control
//
// Register Map
// ============
//
// +---------+--------+----------+-----+----------+-----------------------------------------------+
// | Address | Bit(s) |  Name    | R/W | Default  | Description                                   |
// +---------+--------+----------+-----+----------+-----------------------------------------------+
// |       0 |    15:0|  Channel | R/W          0   Selects the channel to consider during        |
// |         |        |  Select  |                  accesses to channel buffer
// +---------+--------+----------+-----+----------+-----------------------------------------------+
// |         |   31:4 | Reserved |  -  |        - |                                               |
// |         |      3 | RepTest  | R/W |        0 | If set, any input on a single TS input port   |
// |         |        |          |     |          | is copied onto all channels associated with   |
// |         |        |          |     |          | that port.                                    |
// |         |        |                |          |  Indicates if there has been an input FIFO    |
// |         |      2 | PortOF   |  R  |        - | overflow on this channel. This status may be  |
// |         |        |          |     |          | cleared by writing to register 1.             |
// |       1 |        |          |     |          | OutputOF indicates if an overflow has occured |
// |         |      1 | InputOF  | R/W |        0 | in the output FIFO. InputOF indicates if an   |
// |         |      0 | OutputOF | R/W |        0 | overflow has occured on any one of the input  |
// |         |        |          |     |          | ports. Selecting each channel in turn and     |
// |         |        |          |     |          | reading PortOF will allow you to determine    |
// |         |        |          |     |          | which port has overflowed. Writing any value  |
// |         |        |          |     |          | to this register will cause the overflow      |
// |         |        |          |     |          | status to be cleared.                         |
// +---------+--------+----------+-----+----------+-----------------------------------------------+
   localparam    TS_PIDMAP_SET = TS_PROCESS_BASE_ADD;
   localparam    TS_PIDMAP_STATUS = TS_PROCESS_BASE_ADD + 1;
   localparam  OP_MAPLIST_H = BUS_DATA_H;
   localparam  OP_MAPLIST_L = BUS_DATA_L;
   //
   reg  [P_AVALON_ADDR_WIDTH-1:0] r_buffer_address;
   reg  [31:0]                    r_buffer_write_data;
   //
   reg                            r_buffer_write_req;
   reg                            r_buffer_read_req;
   reg  [P_PORT_IDX_WIDTH-1:0]    r_channel;
//   wire [P_AVALON_DATA_WIDTH-1:0] r_buffer_read_data [0:P_NUM_OUTPUTS+1];
   wire [P_NUM_OUTPUTS-1:0]       r_buffer_waitrequest;    
//   wire [P_AVALON_DATA_WIDTH-1:0] r_channel_read_data_sel;
   reg                            local_clear_overflow;
//assign r_channel_read_data_sel = r_buffer_read_data[r_channel];  
/* 
always @ (posedge avalon_clk or posedge avalon_rst)
begin: AVALON_SLAVE
  if (avalon_rst)
  begin
    avalon_waitrequest <= 1'b1;
    avalon_readdata <= 32'b0;
    r_channel <= 0;
    r_buffer_read_req <= 1'b0;
    r_buffer_write_req <= 1'b0;
    clear_input_overflow <= 0;
    clear_output_overflow_tgl_aclk <= 0;
    r_channel <= 0;

   // for(k=0; k<P_NUM_OUTPUTS; k=k+1)
   // begin
   //      gen_run[k] <= 1'b0;
   //      gen_ipg[k] <= 16'd188;
    //end
 
  end
  else begin
    local_clear_overflow  <= 0;
    avalon_readdata <= r_channel_read_data_sel;
    r_buffer_read_req <= 1'b0;
    r_buffer_write_req <= 1'b0;
   
    case (avalon_address)
      TS_PIDMAP_SET: begin
	 avalon_waitrequest <= 1'b1;
         if(avalon_write & avalon_waitrequest)begin
            avalon_waitrequest <= 1'b0;
            r_channel <= avalon_writedata[15:0];
         end
         else if(avalon_read & avalon_waitrequest )begin
            avalon_waitrequest <= 1'b0;
            avalon_readdata[15:0] <= r_channel;
         end
      end
      TS_PIDMAP_STATUS: begin
	avalon_waitrequest <= 1'b1;
        if(avalon_write & avalon_waitrequest)begin
          avalon_waitrequest <= 1'b0;
          local_clear_overflow <= 1'b1;
        end
        else if(avalon_read & avalon_waitrequest)begin
          avalon_waitrequest <= 1'b0;
          avalon_readdata[31:4] <= 0;
          avalon_readdata[2]    <= overflow_flag_by_port[r_channel];
          avalon_readdata[1]    <= |overflow_flag_by_port;
          avalon_readdata[0]    <= output_fifo_overflow_aclk; 
        end
      end
      default: begin
	 avalon_waitrequest <= r_buffer_waitrequest[r_channel];
         if(avalon_write )begin
           r_buffer_write_req <= avalon_write;
         end
         else if(avalon_read )begin
           r_buffer_read_req <= avalon_read;
         end
      end
    endcase
    clear_input_overflow <= local_clear_overflow;
    if(local_clear_overflow)
    begin
       clear_output_overflow_tgl_aclk <= !clear_output_overflow_tgl_aclk;
    end
  end
end
*/
always @ (posedge avalon_clk or posedge avalon_rst)
begin: AVALON_SLAVE
  if (avalon_rst)
  begin
    avalon_waitrequest <= 1'b1;
    avalon_readdata <= 16'b0;
    r_channel <= 0;
    r_buffer_read_req <= 1'b0;
    r_buffer_write_req <= 1'b0;
    clear_input_overflow <= 0;
    clear_output_overflow_tgl_aclk <= 0;
    r_buffer_address <= 0;
    r_buffer_write_data <= 0;
    r_channel <= 0;
  end
  else begin
    local_clear_overflow  <= 0;
    avalon_readdata <= 16'h0000;
    r_buffer_read_req <= 1'b0;
    r_buffer_write_req <= 1'b0; 
    case (avalon_address)
      TS_PIDMAP_SET: begin
	       avalon_waitrequest <= 1'b1;
         if(avalon_write & avalon_waitrequest)begin
            avalon_waitrequest <= 1'b0;
            r_buffer_write_req <= avalon_write;
            r_channel <= avalon_writedata[11:8];
            r_buffer_address <= avalon_writedata[7:0];
         end
      end
      OP_MAPLIST_L : begin 
      	 avalon_waitrequest <= 1'b1;
         if(avalon_write & avalon_waitrequest)begin
         	avalon_waitrequest <= 1'b0;
          r_buffer_write_data[15:0] <= avalon_writedata[15:0];
         end
      end
      OP_MAPLIST_H : begin 
      	 avalon_waitrequest <= 1'b1;
         if(avalon_write & avalon_waitrequest)begin
         	 avalon_waitrequest <= 1'b0;
           r_buffer_write_data[31:16] <= avalon_writedata[15:0];
         end
      end
      TS_PIDMAP_STATUS: begin
	      avalon_waitrequest <= 1'b1;
        if(avalon_write & avalon_waitrequest)begin
          avalon_waitrequest <= 1'b0;
          local_clear_overflow <= 1'b1;
        end
        else if(avalon_read & avalon_waitrequest)begin
          avalon_waitrequest <= 1'b0;
          avalon_readdata[15:4] <= 0;
          avalon_readdata[2]    <= overflow_flag_by_port[r_channel];
          avalon_readdata[1]    <= |overflow_flag_by_port;
          avalon_readdata[0]    <= output_fifo_overflow_aclk; 
        end
      end
      default: begin
	       avalon_waitrequest <= 1'b1;
      end
    endcase
    clear_input_overflow <= local_clear_overflow;
    if(local_clear_overflow)
    begin
       clear_output_overflow_tgl_aclk <= !clear_output_overflow_tgl_aclk;
    end
  end
end
//assign update_avalon_settings = avalon_write && !avalon_waitrequest && (avalon_address == 6);
//--------------------------------------------------------------------------------------------------
// Instantiate an input buffer block for each input port
//--------------------------------------------------------------------------------------------------
wire   [P_NUM_OUTPUTS-1:0]    payload_in_ready_by_port;

genvar i;
generate
   for(i=0; i<P_NUM_OUTPUTS; i=i+1)
   begin: BUFFER_GEN
      udp_ts_rx_buf  u_payload_in_buf (
         .payload_clk               (payload_clk),
         .payload_rst               (payload_rst),
         // Transport stream input
         .buffer_id                         (i[P_PORT_IDX_WIDTH-1:0]),
         .payload_in_valid                  (payload_in_valid),
         .payload_in_start                  (payload_in_start),
         .payload_in_end                    (payload_in_end),
         .payload_in_ready                  (payload_in_ready_by_port[i]),
         .payload_in_data                   (payload_in_data[31:0]),
         // Output FIFO update
         .output_fifo_update_req    (output_fifo_update_req_by_port[i]),
         .output_fifo_update_ack    (output_fifo_update_ack_by_port[i]),
         .output_fifo_pointer       (output_fifo_pointer_by_port[i]),
         .output_fifo_channel       (output_fifo_channel_by_port[i]),

         // Output request
         .payload_out_req           (payload_out_req[i]),
         .payload_out_ack           (payload_out_ack[i]),
         .payload_out_pointer       (payload_out_pointer),

         // Payload output
         .payload_out_ready         (1'b1),
         .payload_out_data          (payload_out_data_by_port[i]),
         .payload_out_valid         (payload_out_valid_by_port[i]),
         .payload_out_start         (payload_out_start_by_port[i]),
         .payload_out_end           (payload_out_end_by_port[i]),
			
         .overflow_flag_local       (overflow_flag_local_by_port[i]),
             // Avalon-MM register interface
         .avalon_clk                (avalon_clk),
         .avalon_rst                (avalon_rst),
         .avalon_read               (r_buffer_read_req & r_channel==i),
         .avalon_write              (r_buffer_write_req & r_channel==i),
         .avalon_address            (r_buffer_address),//(avalon_address),
         .avalon_writedata          (r_buffer_write_data),//(avalon_writedata),
//         .avalon_readdata           (r_buffer_read_data[i]),
         .avalon_waitrequest        (r_buffer_waitrequest[i]),

         // Configuration controls

       //  .update_avalon_settings    (update_avalon_settings),
         .clear_overflow            (clear_input_overflow),
         .overflow_flag             (overflow_flag_by_port[i])

         );

     // defparam u_payload_in_buf.P_INCLUDE_GEN        = P_INCLUDE_GEN;
      defparam u_payload_in_buf.TS_PROCESS_BASE_ADD  = TS_PROCESS_BASE_ADD;
      defparam u_payload_in_buf.BUS_DATA_L           = BUS_DATA_L;
      defparam u_payload_in_buf.BUS_DATA_H           = BUS_DATA_H;
      defparam u_payload_in_buf.P_PORT_IDX_WIDTH     = P_PORT_IDX_WIDTH; 
      defparam u_payload_in_buf.P_AVALON_ADDR_WIDTH  = P_AVALON_ADDR_WIDTH;
      defparam u_payload_in_buf.P_AVALON_DATA_WIDTH  = P_AVALON_DATA_WIDTH;
      defparam u_payload_in_buf.P_POINTERS           = P_POINTERS;         // Maximum number of pointers (Frame Buffer entries) supported
      defparam u_payload_in_buf.P_POINTER_WIDTH      = P_POINTER_WIDTH;
   end
endgenerate
reg   [1:0] flow_state;
reg   [31:0]time_over;
parameter   FLOW_IDLE = 0;
parameter   FLOW_DELAY = 1; 
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      over_flow <= 1'b1;
		time_over <= 0;
   end
   else begin
	  case(flow_state)
	  FLOW_IDLE:
	  begin
	    over_flow<=1'b1;
       if(|overflow_flag_local_by_port)begin
		   over_flow<=1'b0;
         time_over<=0;
			flow_state <= FLOW_DELAY;
       end
	  end
	  FLOW_DELAY:
	  begin
	    time_over<=time_over + 1;
		 if(time_over == 32'h2540be40)begin
		   flow_state <= FLOW_IDLE;
		 end
	  end
	default: flow_state <= FLOW_IDLE;
	endcase 
   end
end

//--------------------------------------------------------------------------------------------------
// Retime signals between the avalon clock and payload clock domains
//--------------------------------------------------------------------------------------------------
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      clear_output_overflow_tgl_metastable   <= 0;
      clear_output_overflow_tgl_pclk         <= 0;
      clear_output_overflow_tgl_r_pclk       <= 0;
   end

   else
   begin
      clear_output_overflow_tgl_metastable   <= clear_output_overflow_tgl_aclk;
      clear_output_overflow_tgl_pclk         <= clear_output_overflow_tgl_metastable;
      clear_output_overflow_tgl_r_pclk       <= clear_output_overflow_tgl_pclk;

   end
end

assign clear_output_overflow_pclk = (clear_output_overflow_tgl_pclk != clear_output_overflow_tgl_r_pclk);


always @(posedge avalon_clk or posedge avalon_rst)
begin
   if(avalon_rst)
   begin
      output_fifo_overflow_metastable  <= 0;
      output_fifo_overflow_aclk        <= 0;
   end

   else
   begin
      output_fifo_overflow_metastable  <= output_fifo_overflow_pclk;
      output_fifo_overflow_aclk        <= output_fifo_overflow_metastable;
   end
end



//--------------------------------------------------------------------------------------------------
// Multiplex FIFO write accesses based on simple priority. We can do this because it will take less
// time to process every port than the minimum duration between requests on any one port.
//--------------------------------------------------------------------------------------------------
always @*
begin : FIFO_ACCESS_MUX
   integer  j;
   reg      stop;

   output_fifo_access_port_c = 0;
   stop = 0;

   for(j=0; j<P_NUM_OUTPUTS; j=j+1)
   begin
      if(output_fifo_update_req_by_port[j] && !stop)
      begin
         output_fifo_access_port_c  = j;
         stop                       = 1;
      end
   end
end

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      output_fifo_access_port <= 0;
   end

   else if(push_current_state == P_PUSH_STATE_IDLE)
   begin
      output_fifo_access_port <= output_fifo_access_port_c;
   end
end

assign output_fifo_update_req = |output_fifo_update_req_by_port;
assign output_fifo_pointer    =  output_fifo_pointer_by_port[output_fifo_access_port];
assign output_fifo_channel    =  output_fifo_channel_by_port[output_fifo_access_port];

always @*
begin
   output_fifo_update_ack_by_port   = {P_NUM_OUTPUTS{1'b0}};

   if(push_current_state == P_PUSH_STATE_PUSH)
   begin
      output_fifo_update_ack_by_port[output_fifo_access_port] = 1;
   end
end



//--------------------------------------------------------------------------------------------------
// Output FIFO push FSM
//
// IDLE
// PUSH - Write a pointer to the output FIFO.
//--------------------------------------------------------------------------------------------------

// Next state logic
always @*
begin
   casez(push_current_state)
      P_PUSH_STATE_IDLE:
      begin
         if(output_fifo_update_req && !output_fifo_full)
         begin
            push_next_state = P_PUSH_STATE_PUSH;
         end
         else
         begin
            push_next_state = P_PUSH_STATE_IDLE;
         end
      end

      P_PUSH_STATE_PUSH:
      begin
         push_next_state = P_PUSH_STATE_IDLE;
      end

      default:
      begin
         if(!payload_rst)
         begin
            //$display("ERROR: Invalid state in auk_payload_in_input (%m, %t)", $time);
         end
      end
   endcase
end


// State registers
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      push_current_state <= P_PUSH_STATE_IDLE;
   end
   else
   begin
      push_current_state <= push_next_state;
   end
end


// Output logic
assign output_fifo_push = (push_current_state == P_PUSH_STATE_PUSH);

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      output_fifo_overflow_pclk <= 0;
   end

   else
   begin
      if((push_next_state == P_PUSH_STATE_PUSH) && output_fifo_full)
      begin
         output_fifo_overflow_pclk <= 1;
         //$display("ERROR: Output FIFO overflow (%m, %t)", $time);
      end

      else if(clear_output_overflow_pclk)
      begin
         output_fifo_overflow_pclk <= 0;
      end
   end
end


//--------------------------------------------------------------------------------------------------
// Instantiate the output FIFO itself
//--------------------------------------------------------------------------------------------------
 fifo_w16_d512 out_state_fifo
 (
   .clk     (payload_clk),
   .rst     (payload_rst),
   .din     (output_fifo_write_data),
   .wr_en   (output_fifo_push),
   .rd_en   (output_fifo_pop),
   .dout    (output_fifo_read_data),
   .empty   (output_fifo_empty),
   .full    (output_fifo_full)
 );


//defparam u_payload_in_input_fifo.P_WIDTH = P_OUTPUT_FIFO_WIDTH;
//defparam u_payload_in_input_fifo.P_DEPTH = P_OUTPUT_FIFO_DEPTH;

assign output_fifo_write_data = { {(P_AVALON_DATA_WIDTH- P_OUTPUT_FIFO_WIDTH){1'b0}},output_fifo_channel,output_fifo_pointer};


//--------------------------------------------------------------------------------------------------
// Payload output read FSM
//
// IDLE
// POP      - Pop the head pointer and channel from the output FIFO.
// REGISTER - Register parameters from the head of the output FIFO.
// DRIVE    - Wait while the corresponding buffer drives payload output for the pointer popped from
//            the head of the output FIFO.
// WAIT     - Ensures that the last output word of the buffer is driven out, even if the downsteam
//            module stops being ready at the point that the last word is output from the buffer
//            and stored in local registers.
//--------------------------------------------------------------------------------------------------

// Next state logic
always @*
begin
   casez(pop_current_state)
      P_POP_STATE_IDLE:
      begin
         if(output_fifo_empty)
         begin
            pop_next_state = P_POP_STATE_IDLE;
         end
         else
         begin
            pop_next_state = P_POP_STATE_POP;
         end
      end

      P_POP_STATE_POP:
      begin
         pop_next_state = P_POP_STATE_REGISTER;
      end

      P_POP_STATE_REGISTER:
      begin
         pop_next_state = P_POP_STATE_DRIVE;
      end

      P_POP_STATE_DRIVE:
      begin
         if(payload_out_ack[payload_out_port])
         begin
            pop_next_state = P_POP_STATE_WAIT;
         end
         else
         begin
            pop_next_state = P_POP_STATE_DRIVE;
         end
      end

      P_POP_STATE_WAIT:
      begin
        if(output_fifo_empty)
        begin
          pop_next_state = P_POP_STATE_IDLE;
        end
        else
        begin
          pop_next_state = P_POP_STATE_POP;
        end
      end

      default:
      begin
         if(!payload_rst)
         begin
            //$display("ERROR: Illegal pop state (%m, %t)", $time);
         end

         pop_next_state = P_POP_STATE_IDLE;
      end
   endcase
end


// State registers
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      pop_current_state <= P_POP_STATE_IDLE;
   end
   else
   begin
      pop_current_state <= pop_next_state;
   end
end


// Output logic
assign output_fifo_pop = (pop_current_state == P_POP_STATE_POP);
//assign output_req_channel[15:P_PORT_IDX_WIDTH]  = 0;
//assign output_req_channel[P_PORT_IDX_WIDTH-1:0] = output_req_channel_r;

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      payload_out_pointer         <= 0;
     // output_req_channel_r        <= 0;
      payload_out_port            <= 0;
   end

   else if(pop_current_state == P_POP_STATE_REGISTER)
   begin
      payload_out_pointer         <= output_fifo_read_data[P_POINTER_WIDTH-1:0];
     // output_req_channel_r        <= output_fifo_read_data[P_OUTPUT_FIFO_WIDTH-1:P_POINTER_WIDTH];
      payload_out_port            <= output_fifo_read_data[P_OUTPUT_FIFO_WIDTH-1:P_POINTER_WIDTH];
   end
end

always @*
begin
   payload_out_req = {P_NUM_OUTPUTS{1'b0}};
   payload_out_req[payload_out_port] = (pop_current_state == P_POP_STATE_DRIVE);
end


//--------------------------------------------------------------------------------------------------
// Payload output multiplexor
//--------------------------------------------------------------------------------------------------
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      payload_out_valid       <= 0; 
      payload_out_data        <= 0;
      payload_out_start       <= 0;
      payload_out_end         <= 0;
      //payload_out_error       <= 0;
      //payload_out_timestamp   <= 0;
   end
   else
   begin

     payload_out_valid       <= payload_out_valid_by_port[payload_out_port];
     payload_out_data        <= payload_out_data_by_port[payload_out_port];
     payload_out_start       <= payload_out_start_by_port[payload_out_port];
     payload_out_end         <= payload_out_end_by_port[payload_out_port];
    //payload_out_error       <= payload_out_error_by_port[payload_out_port];
    //payload_out_timestamp   <= payload_out_timestamp_by_port[payload_out_port];
   end
end
/* generate the payload_in_ready */
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      payload_in_ready <= 0;
   end
   else
   begin
      //if((&payload_in_ready_by_port)&(~output_fifo_update_req))
		if(&payload_in_ready_by_port)
      begin
        payload_in_ready <=1'b1;
      end
      else begin
        payload_in_ready <=1'b0;
      end
   end
end
    
endmodule
