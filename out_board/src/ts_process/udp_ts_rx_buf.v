
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $udp_ts_rx_buf.v$
// Last modified : $Date: 2010/10/20 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------
module udp_ts_rx_buf #(
  //parameter P_INCLUDE_GEN             = 0,
  parameter TS_PROCESS_BASE_ADD       = 12'h310,
  parameter BUS_DATA_L                = 12'h180,
  parameter BUS_DATA_H                = 12'h181, 
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 32,
  parameter P_POINTERS                = 20,          // Maximum number of pointers (Frame Buffer entries) supported
  parameter P_POINTER_WIDTH           = 5,          // Bit width for pointer
  parameter P_PORT_IDX_WIDTH          = 8
)(
  input                            payload_clk,
  input                            payload_rst,

// Transport stream input
  input [P_PORT_IDX_WIDTH-1:0]      buffer_id,
  input                             payload_in_valid,
  input                             payload_in_start,
  input                             payload_in_end,
  input  [ 31:0]                    payload_in_data,
  //output wire                       payload_in_ready,
  output reg                       payload_in_ready,
  // Output request
  input                             payload_out_req,
  output  wire                      payload_out_ack,
  input  [P_POINTER_WIDTH-1:0]      payload_out_pointer,
  
 // Payload output
  input                                 payload_out_ready,
  output wire  [31:0]                   payload_out_data,
  output wire                           payload_out_valid,
  output wire                           payload_out_start,
  output wire                           payload_out_end,
  
  output wire                           overflow_flag_local, 
  // Output FIFO update
  output  wire                          output_fifo_update_req,
  input                                 output_fifo_update_ack,
  output wire [P_POINTER_WIDTH-1:0]     output_fifo_pointer,
  output wire [P_PORT_IDX_WIDTH-1:0]    output_fifo_channel,
    // Avalon-MM register interface
  input                                 avalon_clk,                     
  input                                 avalon_rst,
  input                                 avalon_read,
  input                                 avalon_write,
  input       [P_AVALON_ADDR_WIDTH-1:0] avalon_address,
  input       [31:0]                    avalon_writedata,
//  output wire [31:0]                    avalon_readdata,
  output wire                           avalon_waitrequest,
 
   // Configuration controls
  //input                                 update_avalon_settings,
  input                                 clear_overflow,
  output reg                            overflow_flag

  
  );
//--------------------------------------------------------------------------------------------------
// Local parameters
//--------------------------------------------------------------------------------------------------
 `include "alt_clogb2.v"
//localparam P_RECORD_TIMESTAMP        = 1;
localparam P_PACKS_PER_POINT         = 5;
localparam P_BUFFER_SIZE             = (P_POINTERS/P_PACKS_PER_POINT)*256;  // Buffer size in words;
localparam P_BANKS                   = P_POINTERS;
localparam P_BANK_SIZE               = P_BUFFER_SIZE/P_BANKS;
localparam P_BUFFER_PARAMETER_WORD   = P_BANK_SIZE - 1; // Location in buffer of frame parameter data (channel, length)
//localparam P_BUFFER_TIMESTAMP_WORD   = P_BANK_SIZE - 2; // Location in buffer of frame control data (timestamp)  
localparam P_BUFFER_WORDS            = P_POINTERS*P_BANK_SIZE;  // Total number of words stored by frame buffer
localparam P_BUFFER_ADDRESS_BITS     = alt_clogb2(P_BUFFER_WORDS);  // Address bits for buffer
//--------------------------------------------------------------------------------------------------
// Configuration retiming
//--------------------------------------------------------------------------------------------------
reg                              clear_overflow_tgl;
wire                             overflow_flag_pclk;
reg                              overflow_flag_metastable;


always @(posedge avalon_clk or posedge avalon_rst)
begin
   if(avalon_rst)
   begin
      clear_overflow_tgl               <= 0;
      overflow_flag_metastable         <= 0;
      overflow_flag                    <= 0;
   end
   else
   begin

      if(clear_overflow)
      begin
         clear_overflow_tgl <= !clear_overflow_tgl;
      end

      overflow_flag_metastable <= overflow_flag_pclk;
      overflow_flag <= overflow_flag_metastable;
   end
end

reg    clear_overflow_pclk;
reg    clear_overflow_tgl_pd1;
reg    clear_overflow_tgl_pd2;

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      clear_overflow_pclk              <= 0;
   end
   else
   begin
      clear_overflow_tgl_pd1 <= clear_overflow_tgl;
      clear_overflow_tgl_pd2 <= clear_overflow_tgl_pd1;
      if(clear_overflow_tgl_pd2 != clear_overflow_tgl_pd1)
      begin
         clear_overflow_pclk <=1'b1;
      end
      else begin
        clear_overflow_pclk <=1'b0;
      end
   end
end
//----------------------------------------------------------------------------------------
//  PID Match 
//-------------------------------------------------------------------------------------------
wire         w_match;
wire         info_payload_in_ready;
wire  [31:0] maped_pap;
 udp_ts_rx_info  #(
   .TS_PROCESS_BASE_ADD  (TS_PROCESS_BASE_ADD),
   //.BUS_DATA_L           (BUS_DATA_L),
  // .BUS_DATA_H           (BUS_DATA_H),
   .P_AVALON_DATA_WIDTH  (P_AVALON_DATA_WIDTH),
   .P_AVALON_ADDR_WIDTH  (P_AVALON_ADDR_WIDTH) 
   ) u_match_info(
  // Receive Transport stream 
   .payload_clk                      (payload_clk),
   .payload_rst                      (payload_rst),
   .payload_in_valid                 (payload_in_valid),
   .payload_in_start                 (payload_in_start),
   .payload_in_end                   (payload_in_end),
   .payload_in_data                  (payload_in_data),
   //.payload_in_ready                 (payload_in_ready),
	.payload_in_ready                 (info_payload_in_ready),
  // Match result
   .t_match                    (w_match), 
   .map_pap                      (maped_pap),
  // Register access
  .avalon_clk                (avalon_clk),
  .avalon_rst                (avalon_rst),
  .avalon_read               (avalon_read),
  .avalon_write              (avalon_write),
  .avalon_address            (avalon_address),
  .avalon_writedata          (avalon_writedata)
//  .avalon_readdata           (avalon_readdata)//,
  //.avalon_waitrequest        (avalon_waitrequest)
);
//--------------------------------------------------------------------------------------------------
// Transport stream byte to word conversion buffer and pipeline. We need to pipe the TS data to
// ensure that we have enough time to get the channel status.
//--------------------------------------------------------------------------------------------------
wire                             fetch;
wire [P_POINTER_WIDTH-1:0]       fetch_pointer;
wire                             fetch_ack;
wire [P_POINTER_WIDTH-1:0]        rx_pointer;
wire [P_BUFFER_ADDRESS_BITS-1:0] rx_address;
wire                             rx_write;
wire [31:0]                      rx_writedata;

wire                             buf_payload_in_ready;  //2014/5/21

 udp_ts_rx_dma #(
   //.P_PORT_IDX_WIDTH               (P_PORT_IDX_WIDTH),
   .P_POINTER_WIDTH                 (P_POINTER_WIDTH),          // Width of pointer signal
   .P_BUFFER_ADDRESS_BITS           (P_BUFFER_ADDRESS_BITS),
  // .P_RECORD_TIMESTAMP             (P_RECORD_TIMESTAMP),      // Assert to record timestamp for start of frame reception
   .P_BUFFER_PARAMETER_WORD        (P_BUFFER_PARAMETER_WORD)          // Location in buffer of frame parameter data
   //.P_BUFFER_TIMESTAMP_WORD        (P_BUFFER_TIMESTAMP_WORD)          // Location in buffer of frame control data 
)udp_ts_input(
   .clk                                     (payload_clk),
   .rst                                     (payload_rst),

   // Free pointer fetch
   .fetch                                   (fetch),
   .fetch_pointer                           (fetch_pointer),
   .fetch_ack                               (fetch_ack),

  // Receive Transport stream 

   .payload_in_valid                        (payload_in_valid),
   .payload_in_start                        (payload_in_start),
   .payload_in_end                          (payload_in_end),
   .payload_in_data                         (payload_in_data),
  
  // Interface to frame buffer 
   .buffer_pointer                          (rx_pointer),
   .buffer_address                          (rx_address),
   .buffer_write                            (rx_write),
   .buffer_writedata                        (rx_writedata),
   .buffer_waitrequest                      (1'b0),

  // Channel match status
   .rx_match                                (w_match),//w_match
   .maped_pap                               (maped_pap),
	//.match_end                               (payload_in_ready),   //pay atention 
	 .match_end                               (info_payload_in_ready),   //pay atention 
  // Receive queue load
   .load                                    (output_fifo_update_req),
   .load_pointer                            (output_fifo_pointer),
   .load_ack                                (output_fifo_update_ack),
   .frame_discard                           (),
   .payload_in_ready                        (buf_payload_in_ready)
);  
/* generate the payload_in_ready*/

always @(posedge payload_clk or posedge payload_rst)
begin
   if(payload_rst)
   begin
      payload_in_ready              <= 0;
   end
   else
   begin
      if(buf_payload_in_ready & info_payload_in_ready)
      begin
        payload_in_ready <=1'b1;
      end
      else begin
        payload_in_ready <=1'b0;
      end
   end
end
//--------------------------------------------------------------------------------------------------
// Output FIFO push request payload_ineration. 
//--------------------------------------------------------------------------------------------------
assign output_fifo_channel = buffer_id;
  
 //--------------------------------------------------------------------------------------------------
// Instantiate buffer management engine
//--------------------------------------------------------------------------------------------------
wire                       ctrl_free;
wire  [P_POINTER_WIDTH-1:0] ctrl_free_pointer;
wire                       ctrl_free_ack;


udp_ts_rx_buf_control#(
  .P_POINTERS                (P_POINTERS),       // Maximum number of pointers (Frame Buffer entries) supported
  .P_POINTER_WIDTH            (P_POINTER_WIDTH)      // Bit width for pointer
  ) u_buf_control (
   .payload_clk          (payload_clk              ),
   .payload_rst          (payload_rst              ),
   
   .pointer_out          (fetch_pointer),                                  
   .rx_free_fetch        (fetch),             
   .rx_free_fetch_ack    (fetch_ack),   
     
   .tx_release           (ctrl_free                ),
   .tx_release_pointer   (ctrl_free_pointer        ),
   .tx_release_ack       (ctrl_free_ack            ),

   .overflow_flag_local  (overflow_flag_local      ),
	
   .initialised          (                         ),
   .overflow_flag        (overflow_flag_pclk       ),
   .clear_overflow       (clear_overflow_pclk      )
   );


//--------------------------------------------------------------------------------------------------
// Infer the buffer RAM - this is a dual port RAM whose write port is clocked from the transport
// stream clock and whose read port is clocked by the payload clock.
// 32 x 256 
//--------------------------------------------------------------------------------------------------
wire  [P_BUFFER_ADDRESS_BITS-1:0] ram_read_address;
reg  [P_BUFFER_ADDRESS_BITS-1:0]  ram_write_address;
reg                               ram_write;
reg                      [31:0]   ram_write_data;
reg                      [31:0]   ram_read_data;
wire                     [31:0]   ram_read_data_out;
// write to the buffer
always @ (posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)
  begin
    ram_write_address <= 0;
    ram_write <= 0;
    ram_write_data <= 0;
    ram_read_data <= 0;//xlinx
  end
  else begin
    ram_read_data <= ram_read_data_out; 
    if (rx_write) begin
       ram_write    <= 1'b1;
       ram_write_address <= (rx_pointer*P_BANK_SIZE) + rx_address;
       ram_write_data    <= rx_writedata;
    end
    else begin
      ram_write_address <= 0;
      ram_write <= 0;
      ram_write_data <= 0;
    end
  end
end
//assign rx_waitrequest = rx_write;
//Ins an duable clock dual-port ram
 sdp_ram_d1024_w32 udp_ts_rx_buf_ram(
	.clka       (payload_clk),			    
	.addra      (ram_write_address),
  .dina       (ram_write_data),			    
	.wea        (ram_write),
				    
	.clkb       (payload_clk),				    
	.addrb      (ram_read_address),
	//.doutb      (ram_read_data)    //altera
	.doutb      (ram_read_data_out)
	);

//read from the buffer
wire  [P_POINTER_WIDTH-1:0]        tx_pointer;
wire  [P_BUFFER_ADDRESS_BITS-1:0]  tx_address;
assign    ram_read_address = (tx_pointer*P_BANK_SIZE) + tx_address;

//--------------------------------------------------------------------------------------------------
// Output payload_ineration -
// register the RAM read data for timing.
//--------------------------------------------------------------------------------------------------
 udp_ts_tx_dma #(
  .P_POINTER_WIDTH             (P_POINTER_WIDTH),          // Width of pointer signal
  .P_BUFFER_PARAMETER_WORD    (P_BUFFER_PARAMETER_WORD),  // Location in buffer of frame parameter data
  //.P_BUFFER_TIMESTAMP_WORD    (P_BUFFER_TIMESTAMP_WORD),    // Location in buffer of frame control data
  .P_BUFFER_ADDRESS_BITS       (P_BUFFER_ADDRESS_BITS )
  ) u_payload_out (

  .release_req                (ctrl_free),
  .release_pointer            (ctrl_free_pointer),
  .release_ack                (ctrl_free_ack),

  .payload_clk                (payload_clk),          // Payload clock
  .payload_rst                (payload_rst),          // Payload reset
  
  // Output request
  .payload_out_req            (payload_out_req),
  .payload_out_ack            (payload_out_ack),
  .payload_out_pointer        (payload_out_pointer),
  
  // Payload output
  .payload_out_ready          (payload_out_ready), 
  .payload_out_start          (payload_out_start),
  .payload_out_data           (payload_out_data),
  .payload_out_valid          (payload_out_valid),
  .payload_out_end            (payload_out_end),

  .buffer_read                (),                 // Read request to Frame Buffer
  .buffer_pointer             (tx_pointer),       // Pointer to entry being read
  .buffer_address             (tx_address),       // Address offset within the entry
  .buffer_readdata            (ram_read_data)     // Read data
  );
endmodule