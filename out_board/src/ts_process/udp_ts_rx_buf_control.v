
//--------------------------------------------------------------------------------------------------
// File          : $ip_rx_control.v$
// Last modified : $Date: 2010/10/20 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------
// Queue system.
//
// Provides a pool of pointers to free buffers, and implements all receive and transmit queues.
//
// The queues are implemented using a linked list mechanism. The "head" and "tail" pointers and
// current depth for each queue are stored in a RAM. Pointers are linked together in a second
// RAM.
//
// To write a new pointer to a queue:
// - Read current tail pointer and depth for the queue
// - Set tail pointer to new value and increment depth
// - Link previous tail pointer to new pointer
//
// To read a pointer from a queue:
// - Read (and return) current head pointer and depth for the queue
// - Get pointer linked to current head pointer
// - Set head pointer to linked value and decrement depth
//-----------------------------------------------------------------------------------------------------
module udp_ts_rx_buf_control #(
  parameter P_POINTERS                = 4,          // Maximum number of pointers (Frame Buffer entries) supported
  parameter P_POINTER_WIDTH            = 2          // Width of pointer
)(
  input                           payload_clk,
  input                           payload_rst,
  
  output reg [P_POINTER_WIDTH-1:0] pointer_out,            // Pointer returned for fetch or queue transmit
  
  input                           rx_free_fetch,         // Free buffer fetch request from Ethernet system (hold until ack seen)
  output reg                      rx_free_fetch_ack,     // Ack - asserted to validate pointer_out
  
  input                           tx_release,            // Buffer release from tx system (hold until ack seen)
  input      [P_POINTER_WIDTH-1:0] tx_release_pointer,    // Release pointer
  output reg                      tx_release_ack,        // Ack - asserted to acknowledge release
  
  output wire                     overflow_flag_local, 
  
  output wire                     initialised,
  output reg                      overflow_flag ,
  input                           clear_overflow  
 
);
//--------------------------------------------------------------------------------------------------
// Local parameters
//--------------------------------------------------------------------------------------------------

function integer alt_clogb2;
  input [31:0] value;
  integer i;
  begin
    alt_clogb2 = 32;
    for (i=31; i>0; i=i-1) begin
      if (2**i>=value)
        alt_clogb2 = i;
    end
  end
endfunction

// Derived parameters
localparam P_FREE_LIST_BASE          = 0;
localparam P_FREE_LIST_TOP           = P_POINTERS - 1;
localparam P_CONFIG_RAM_WIDTH        = P_POINTER_WIDTH;
localparam P_CONFIG_RAM_ADDR_WIDTH   = alt_clogb2(P_POINTERS);


// RAM control and initialisation signals
reg  [P_CONFIG_RAM_WIDTH-1:0]       config_ram [P_POINTERS-1:0];
reg                                 config_ram_write_enable;
reg  [P_CONFIG_RAM_ADDR_WIDTH-1:0]  config_ram_address;
reg  [P_CONFIG_RAM_ADDR_WIDTH-1:0]  config_ram_read_address;
reg  [P_CONFIG_RAM_WIDTH-1:0]       config_ram_write_data;
wire [P_CONFIG_RAM_WIDTH-1:0]       config_ram_read_data;
reg                                 config_ram_muxed_write_enable;
reg  [P_CONFIG_RAM_ADDR_WIDTH-1:0]  config_ram_muxed_address;
reg  [P_CONFIG_RAM_WIDTH-1:0]       config_ram_muxed_write_data;
reg                                 config_ram_initialised;
reg  [P_CONFIG_RAM_ADDR_WIDTH-1:0]  config_ram_init_address;
reg  [P_CONFIG_RAM_WIDTH-1:0]       config_ram_init_data;
//--------------------------------------------------------------------------------------------------
// Control state machine
//
// IDLE
// REGISTER_CHANNEL  - Calculates channel index and writes it into local storage.
// ADD_GET_STATUS_WAIT,
// ADD_GET_STATUS    - Reads the current status of the channel from RAM.
// ADD_FREE_LIST_POP_WAIT,
// ADD_FREE_LIST_POP - Pop a buffer from the free list for storing packets for this channel.
// ADD_UPDATE_STATUS - Save the buffer index and packet count for this channel to RAM.
// CLEAR_CHANNEL     - Clears this channel so that a new buffer will be allocated for the next packet.
// FREE_LIST_PUSH    - Pushes an element onto the free-list.
// ERROR_FREE_LIST_PUSH - Pushed an element to the free list during back-off.
// ABORT             - Aborts push if the free list is empty.
//--------------------------------------------------------------------------------------------------
// State enumeration
localparam P_STATE_WIDTH = 3;
localparam P_STATE_IDLE                    = 3'd0;
localparam P_STATE_ADD_FREE_LIST_POP_WAIT  = 3'd1;
localparam P_STATE_ADD_FREE_LIST_POP       = 3'd2;
localparam P_STATE_ADD_UPDATE_STATUS       = 3'd3;
localparam P_STATE_FREE_LIST_PUSH          = 3'd4;
localparam P_STATE_ABORT                   = 3'd5;
// State variables
reg [P_STATE_WIDTH-1:0] current_state;
reg [P_STATE_WIDTH-1:0] next_state;
//------------------
// Next state logic
//------------------
always @*
begin
   casez(current_state)
      P_STATE_IDLE:
      begin
         if(config_ram_initialised && (rx_free_fetch ))
         begin
            next_state = P_STATE_ADD_FREE_LIST_POP_WAIT ;
         end
         else if(tx_release)
         begin
            next_state = P_STATE_FREE_LIST_PUSH;
         end
         else
         begin
            next_state = P_STATE_IDLE;
         end
      end


      P_STATE_ADD_FREE_LIST_POP_WAIT:
      begin
         next_state = P_STATE_ADD_FREE_LIST_POP;
      end

      P_STATE_ADD_FREE_LIST_POP:
      begin
         if(!rx_free_fetch)
         begin
           next_state = P_STATE_ABORT;
            //$display("ERROR: Invalid control signals (%m, %t)", $time);
         end
        else begin
          next_state = P_STATE_ADD_UPDATE_STATUS;
        end
      end

      P_STATE_ADD_UPDATE_STATUS:
      begin
        next_state = P_STATE_IDLE;
      end

      P_STATE_FREE_LIST_PUSH:
      begin
         next_state = P_STATE_IDLE;
      end

      P_STATE_ABORT:
      begin
         next_state = P_STATE_IDLE;
      end

      default:
      begin
         if(!payload_rst)
         begin
            //$display("ERROR: Illegal state entered (%m, %t)", $time);
         end

         next_state = P_STATE_IDLE;
      end
   endcase
end


//-----------------
// State registers
//-----------------
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      current_state <= P_STATE_IDLE;
   end
   else
   begin
      current_state <= next_state;
   end
end


//-------------------
// Output generation
//-------------------
// The head of the free list
reg  [P_CONFIG_RAM_ADDR_WIDTH-1:0]  free_list_head;
// Registered outputs
always @(posedge payload_clk or posedge payload_rst)
begin :OUTPUT_GEN
   //reg overflow_flag_local;

   if(payload_rst)
   begin
      rx_free_fetch_ack          <= 0;
      tx_release_ack             <= 0;
      pointer_out                <= 0;
      free_list_head             <= P_FREE_LIST_TOP;
      overflow_flag              <= 0;
      config_ram_write_enable    <= 0;
      config_ram_address         <= 0;
      config_ram_write_data      <= 0;
   end
   else
   begin
      //overflow_flag_local <= 1'b0;

      casez(next_state)
         P_STATE_IDLE:
         begin
            rx_free_fetch_ack          <= 0;
            tx_release_ack             <= 0;
            config_ram_write_enable    <= 0;
            config_ram_address         <= 0;
            config_ram_write_data      <= 0;
         end
         P_STATE_ADD_FREE_LIST_POP_WAIT:
         begin
            rx_free_fetch_ack          <= 0;
            tx_release_ack             <= 0;
            config_ram_write_enable    <= 0;
            config_ram_address         <= free_list_head;
            config_ram_write_data      <= 0;
         end

         P_STATE_ADD_FREE_LIST_POP:
         begin
            rx_free_fetch_ack          <= 0;
            tx_release_ack             <= 0;

            config_ram_write_enable    <= 0;
            config_ram_address         <= free_list_head;
            config_ram_write_data      <= 0;

            if(free_list_head != (P_FREE_LIST_BASE-1))
			  //if(free_list_head != (P_FREE_LIST_BASE))
            begin
               free_list_head <= free_list_head - 1;
            end
            else
            begin
               $display("Warning: Pop from empty free list (%m, %t)", $time);
              // overflow_flag_local <= 1;
            end
         end

         P_STATE_ADD_UPDATE_STATUS:
         begin
            rx_free_fetch_ack <= 1;
            tx_release_ack    <= 0;
            pointer_out    <= config_ram_read_data[P_POINTER_WIDTH-1:0];
         end
         P_STATE_FREE_LIST_PUSH:
         begin
            rx_free_fetch_ack              <= 0;
            tx_release_ack     <= 1;
            config_ram_write_data      <= tx_release_pointer;

            if(free_list_head != P_FREE_LIST_TOP)
            begin
               free_list_head          <= free_list_head + 1;
               config_ram_address      <= free_list_head + 1;
               config_ram_write_enable <= 1;
            end
            else
            begin
               //$display("ERROR: Push to full free list (%m, %t)", $time);
               config_ram_write_enable <= 0;
            end
         end
         P_STATE_ABORT:
         begin
            rx_free_fetch_ack          <= 1;
            config_ram_write_enable    <= 0;
         end
         default:;
      endcase

      if(clear_overflow)
      begin
         overflow_flag <= 0;
      end
      else if(overflow_flag_local)
      begin
         overflow_flag <= 1;
      end
   end
end

assign overflow_flag_local=(free_list_head <= 2);
assign initialised = config_ram_initialised;


//--------------------------------------------------------------------------------------------------
// Infer a single port RAM
//--------------------------------------------------------------------------------------------------
always @(posedge payload_clk)
begin
   if(config_ram_muxed_write_enable)
   begin
      config_ram[config_ram_muxed_address] <= config_ram_muxed_write_data;
   end
   config_ram_read_address <= config_ram_muxed_address;
end


assign config_ram_read_data = config_ram[config_ram_read_address];


//--------------------------------------------------------------------------------------------------
// RAM Initialisation engine
//--------------------------------------------------------------------------------------------------
always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      config_ram_init_address  <= 0;
      config_ram_initialised   <= 0;
   end
   else
   begin
      if(config_ram_init_address == P_FREE_LIST_TOP)
      begin
         config_ram_initialised  <= 1;
      end
      else begin
         config_ram_init_address <= config_ram_init_address + 1;
      end
   end
end

always @*
begin
  config_ram_init_data = config_ram_init_address - P_FREE_LIST_BASE;
end


// Ram control multiplexor
always @*
begin
   if(!config_ram_initialised)
   begin
      config_ram_muxed_write_enable = 1;
      config_ram_muxed_address      = config_ram_init_address;
      config_ram_muxed_write_data   = config_ram_init_data;
   end
   else
   begin
      config_ram_muxed_write_enable = config_ram_write_enable;
      config_ram_muxed_address      = config_ram_address;
      config_ram_muxed_write_data   = config_ram_write_data;
   end
end

endmodule