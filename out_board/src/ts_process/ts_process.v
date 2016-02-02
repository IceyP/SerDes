module ts_process  #(
   parameter P_BUS_ADDR_WIDTH       = 12,
   parameter P_BUS_DATA_WIDTH       = 16

) (
  //-----------businterface------------------
  input                                   bus_clk,
  input                                   bus_rst,
  input        [P_BUS_ADDR_WIDTH-1:0]     bus_address,
  input                                   bus_read,
  input                                   bus_write,
  input        [P_BUS_DATA_WIDTH-1:0]     bus_writedata,
  output reg   [P_BUS_DATA_WIDTH-1:0]     bus_readdata,
  output reg                              bus_waitrequest,
  output wire                             bus_int,
  //-----------payload-----------------------
  input                   payload_clk,
  input                   payload_rst,
  
  input                                 ddr_user_clk,
  input                                 ddr_user_rst,
  input [31:0]                          sc_data_pkt_d,
  input                                 sc_data_pkt_dval,
  input                                 sc_data_pkt_sop,
  input                                 sc_data_pkt_eop,

  output wire             payload_in_ready,
  input                   payload_in_valid,
  input        [31:0]     payload_in_data,
  input        [15:0]     payload_in_channel,
  input        [11:0]     payload_in_length,
  input                   payload_in_start,
  input                   payload_in_end,
  
  output wire             payload_out_valid,
  output wire   [31:0]    payload_out_data,
  output wire             payload_out_start,
  output wire             payload_out_end
 );

//------------udp_chan_buffer output-----------------------//
  wire                    udp_chan_buffer_out_ready;
  wire                    udp_chan_buffer_out_valid;
  wire   [31:0]           udp_chan_buffer_out_data;
  wire                    udp_chan_buffer_out_start;
  wire                    udp_chan_buffer_out_end;
udp_chan_buffer  #(
  .P_TS_BUFFERS            (21)
) u_gbe_to_ts (
  .clk                     (payload_clk), 
  .rst                     (payload_rst),    

  .payload_ready           (payload_in_ready),
  .payload_valid           (payload_in_valid),
  .payload_data            (payload_in_data),
  .payload_channel         (payload_in_channel),
  .payload_length          (payload_in_length),
  .payload_start           (payload_in_start),
  .payload_end             (payload_in_end),
         
  .payload_out_valid       (udp_chan_buffer_out_valid),
  .payload_out_data        (udp_chan_buffer_out_data),
  .payload_out_start       (udp_chan_buffer_out_start),
  .payload_out_end         (udp_chan_buffer_out_end),
  .chan_out_req            (udp_chan_buffer_out_ready),
  .output_fifo_update_ack  (1'b0),
  .buffer_overflow         ()
 );
//-------------------  ts_map_out---------------------//
 // wire                     ts_map_out_ready;
  wire                        ts_map_out_valid;
  wire   [31:0]               ts_map_out_data;
  wire                        ts_map_out_start;
  wire                        ts_map_out_end;
  wire                        tsmap_bus_waitrequest;
  wire [P_BUS_DATA_WIDTH-1:0] tsmap_bus_readdata;
udp_ts_map #(
  .P_AVALON_DATA_WIDTH       (P_BUS_DATA_WIDTH),
  .P_AVALON_ADDR_WIDTH       (P_BUS_ADDR_WIDTH), 
  .TS_PROCESS_BASE_ADD       (12'h310),
  .BUS_DATA_L                (12'h308),
  .BUS_DATA_H                (12'h309)
) u_ts_map(
   // Transport stream inputs
  .payload_clk             (payload_clk),
  .payload_rst             (payload_rst),
  .payload_in_valid        (udp_chan_buffer_out_valid),
  .payload_in_start        (udp_chan_buffer_out_start),
  .payload_in_end          (udp_chan_buffer_out_end),
  .payload_in_data         (udp_chan_buffer_out_data),
  .payload_in_ready        (udp_chan_buffer_out_ready),  
   
   //Payload out
  .payload_out_data        (ts_map_out_data),
  .payload_out_valid       (ts_map_out_valid),
  .payload_out_start       (ts_map_out_start),
  .payload_out_end         (ts_map_out_end),
   
	//buffer state
  .over_flow               (),
   // Avalon slave port for configuration
  .avalon_clk              (bus_clk),
  .avalon_rst              (bus_rst),
  .avalon_address          (bus_address),
  .avalon_read             (bus_read),
  .avalon_write            (bus_write),
  .avalon_writedata        (bus_writedata),
  .avalon_readdata         (tsmap_bus_readdata),
  .avalon_waitrequest      (tsmap_bus_waitrequest)
   );
//----------------psi filter----------------------   
  wire  [P_BUS_DATA_WIDTH-1:0]     psifilt_bus_readdata;
  wire                             psifilt_bus_waitrequest;
  wire                             psifilt_bus_int;
 psi_filter #(
  .TS_PROCESS_BASE_ADD     (12'h310), 
  .BUS_DATE_L              (12'h30a), 
  .BUS_DATE_H              (12'h30b),                
  .P_AVALON_DATA_WIDTH     (P_BUS_DATA_WIDTH),
  .P_AVALON_ADDR_WIDTH     (P_BUS_ADDR_WIDTH), 
  .PAYLOAD_DATA_WIDTH      (32)                       
)u_psi_filter(
   // Transport stream inputs
  .payload_clk             (payload_clk),
  .payload_rst             (payload_rst),
  .payload_in_valid        (udp_chan_buffer_out_valid),
  .payload_in_start        (udp_chan_buffer_out_start),
  .payload_in_end          (udp_chan_buffer_out_end),
  .payload_in_data         (udp_chan_buffer_out_data),
 
   // Avalon slave port for configuration
  .avalon_clk              (bus_clk),
  .avalon_rst              (bus_rst),
  .avalon_address          (bus_address),
  .avalon_read             (bus_read),
  .avalon_write            (bus_write),
  .avalon_writedata        (bus_writedata),
  
  .avalon_readdata         (psifilt_bus_readdata),
  .avalon_waitrequest      (psifilt_bus_waitrequest),
  .avalon_int              (psifilt_bus_int)
  );
  //-------------psi inject -------------------
  wire                             psiinject_bus_waitrequest;
  wire  [P_BUS_DATA_WIDTH-1:0]     psiinject_bus_readdata;
host_ts_mux #(
  .TS_PROCESS_BASE_ADD     (12'h310), 
  .BUS_DATE_L              (12'h319), 
  .BUS_DATE_H              (12'h31a),                
  .P_AVALON_DATA_WIDTH     (P_BUS_DATA_WIDTH),
  .P_AVALON_ADDR_WIDTH     (P_BUS_ADDR_WIDTH), 
  .PAYLOAD_DATA_WIDTH      (32)                       
)u_host_ts_mux(
   // Transport stream inputs
  .payload_clk             (payload_clk),
  .payload_rst             (payload_rst),
  .payload_in_valid        (ts_map_out_valid),
  .payload_in_start        (ts_map_out_start),
  .payload_in_end          (ts_map_out_end),
  .payload_in_data         (ts_map_out_data),
  
  .ddr_user_clk             ( ddr_user_clk    ),
  .ddr_user_rst             ( ddr_user_rst    ),
  .sc_data_pkt_d            ( sc_data_pkt_d   ),
  .sc_data_pkt_dval         ( sc_data_pkt_dval),
  .sc_data_pkt_sop          ( sc_data_pkt_sop ),
  .sc_data_pkt_eop          ( sc_data_pkt_eop ),

     //Payload out
  .payload_out_data        (payload_out_data),
  .payload_out_valid       (payload_out_valid),
  .payload_out_start       (payload_out_start),
  .payload_out_end         (payload_out_end),
 
   // Avalon slave port for configuration
  .avalon_clk              (bus_clk),
  .avalon_rst              (bus_rst),
  .avalon_address          (bus_address),
  .avalon_read             (bus_read),
  .avalon_write            (bus_write),
  .avalon_writedata        (bus_writedata), 
  .avalon_readdata         (psiinject_bus_readdata),
  .avalon_waitrequest      (psiinject_bus_waitrequest)
  );
  //---------------ts_input_status---all_pid_stastics---
  wire  [P_BUS_DATA_WIDTH-1:0]   tsinstatus_bus_readdata;
  wire                           tsinstatus_bus_waitrequest;
ts_input_status #(
  .TS_IN_STATUS_BASE_ADD   (12'h320),                 
  .P_AVALON_DATA_WIDTH     (P_BUS_DATA_WIDTH),
  .P_AVALON_ADDR_WIDTH     (P_BUS_ADDR_WIDTH), 
  .PAYLOAD_DATA_WIDTH      (32)                       
)u_ts_input_status(
   // Transport stream inputs
  .payload_clk             (payload_clk),
  .payload_rst             (payload_rst),
  .payload_in_valid        (udp_chan_buffer_out_valid),
  .payload_in_start        (udp_chan_buffer_out_start),
  .payload_in_end          (udp_chan_buffer_out_end),
  .payload_in_data         (udp_chan_buffer_out_data),

 
   // Avalon slave port for configuration
  .avalon_clk              (bus_clk),
  .avalon_rst              (bus_rst),
  .avalon_address          (bus_address),
  .avalon_read             (bus_read),
  .avalon_write            (bus_write),
  .avalon_writedata        (bus_writedata),
  
  .avalon_readdata         (tsinstatus_bus_readdata),
  .avalon_waitrequest      (tsinstatus_bus_waitrequest)
  );
  //-------------ts_output_status--------------
  wire  [P_BUS_DATA_WIDTH-1:0]   tsoutstatus_bus_readdata;
  //wire                           tsoutstatus_bus_waitrequest;
 ts_output_status #(
  .TS_OUT_STATUS_BASE_ADD  (12'h330),                  
  .P_AVALON_DATA_WIDTH     (P_BUS_DATA_WIDTH),
  .P_AVALON_ADDR_WIDTH     (P_BUS_ADDR_WIDTH), 
  .PAYLOAD_DATA_WIDTH      (32)                       
 )u_ts_output_status(
   // Transport stream inputs
  .payload_clk             (payload_clk),
  .payload_rst             (payload_rst),
  .payload_in_valid        (payload_out_valid),
  .payload_in_start        (payload_out_start),
  .payload_in_end          (payload_out_end),
  .payload_in_data         (payload_out_data),
 
   // Avalon slave port for configuration
  .avalon_clk              (bus_clk),
  .avalon_rst              (bus_rst),
  .avalon_address          (bus_address),
  .avalon_read             (bus_read),
  .avalon_write            (bus_write),
  .avalon_writedata        (bus_writedata),
  
  .avalon_readdata         (tsoutstatus_bus_readdata),
  .avalon_waitrequest      ()
  );
  
  always @ *
  begin
 	  bus_waitrequest = 1'b1;
	  bus_readdata = 0;
  	 case (bus_address) 
  	    12'h308,12'h309,12'h310,12'h311:begin
  	       bus_waitrequest = tsmap_bus_waitrequest;
  	       bus_readdata = tsmap_bus_readdata;
 	     end
	     12'h30a,12'h30b,12'h312,12'h314,12'h315,12'h316:begin
  	       bus_waitrequest = psifilt_bus_waitrequest;
  	       bus_readdata = psifilt_bus_readdata;
	     end
	     12'h317,12'h318,12'h319,12'h31a:begin
	        bus_waitrequest = psiinject_bus_waitrequest;
	        bus_readdata = psiinject_bus_readdata;
	     end
  	    12'h320,12'h321,12'h322,12'h324,12'h326,12'h327: begin 
  	       bus_waitrequest = tsinstatus_bus_waitrequest;
  	       bus_readdata = tsinstatus_bus_readdata;
	     end
  	    12'h330,12'h331,12'h332, 12'h333,12'h334,12'h335, 12'h336,12'h337,12'h338,
  	    12'h339,12'h33a,12'h33b, 12'h33c,12'h33d,12'h33e, 12'h33f:begin
  	       bus_waitrequest = tsinstatus_bus_waitrequest;
  	       bus_readdata = tsoutstatus_bus_readdata;
	     end
  	   default: begin
  	     bus_waitrequest = 1'b1;
  	     bus_readdata = 0;
	    end
    endcase
  end
  assign bus_int = psifilt_bus_int;
endmodule