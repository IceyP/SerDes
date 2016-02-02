
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $ udp_ts_rx_info.v$
// Last modified : $Date: 2012/7/20 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------

module udp_ts_rx_info #(
  parameter TS_PROCESS_BASE_ADD       = 12'h310,  
  //parameter BUS_DATE_L                = 12'h180, 
  //parameter BUS_DATE_H                = 12'h181,   
  parameter P_AVALON_ADDR_WIDTH       = 8,
  parameter P_AVALON_DATA_WIDTH       = 16
)(
  // Receive Transport stream 
   input             payload_clk,
   input             payload_rst,
   input             payload_in_valid,
   input             payload_in_start,
   input             payload_in_end,
   input  [31:0]     payload_in_data,
   output reg        payload_in_ready,
  // input             payload_in_channel;
 
  input               avalon_clk,                     // Avalon-MM register interface
  input               avalon_rst,
  input               avalon_read,
  input               avalon_write,
  input  [P_AVALON_ADDR_WIDTH-1:0]   avalon_address,
  input       [31:0]  avalon_writedata,
  //output reg  [31:0]  avalon_readdata,
  //output reg          avalon_waitrequest,
  output reg          t_match,   
  output reg  [31:0]  map_pap 
);
 
    
//--------------------------------------------------------------------------------------------------
// parameters
//parameter  IP_RECEIVE_CHANNELS = 96;
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

localparam P_MAX_SEARCH_CYCLES = 128;          // Maximum number of clock cycles allowed for socket search
localparam MAX_PID_SELECT      = 128;             // Maximum number of port_and_pid search
//localparam MAX_PID_ADD_BITS = alt_clogb2(MAX_PID_SELECT); 
localparam P_RAM_BANKS = 1; //43*3=129>128 MAX_PID_SELECT/P_MAX_SEARCH_CYCLES + (MAX_PID_SELECT%P_MAX_SEARCH_CYCLES==0)? 0:1;  
localparam P_RAM_BANK_BITS = alt_clogb2(P_RAM_BANKS);
//--------------------------------------------------------------------------------------------------
// port_and_pid RAM. Written by host processor, read by port_and_pid matcher.
// For larger channel count configurations, multiple RAM's are put in parallel to allow more than
// one channel to be checked in a single cycle by the port_and_pid matcher.
//--------------------------------------------------------------------------------------------------
//512*32=1m36k
localparam  P_RAM_DEPTH = 512;
localparam  BANK_DEPTH = P_MAX_SEARCH_CYCLES*2;
localparam  BANK_ADDR_BITS = alt_clogb2(BANK_DEPTH);
localparam  P_RAM_ADDR_BITS = alt_clogb2(P_RAM_DEPTH);
localparam  P_RAM_WIDTH = 32;

reg [31:0]   s_port_pid            [0:P_RAM_BANKS-1]; 
reg [31:0]   d_port_pid            [0:P_RAM_BANKS-1]; 
           
reg          [P_RAM_ADDR_BITS-1:0]  info_ram_address;
//reg                                 info_ram_write;
//wire [P_RAM_WIDTH*P_RAM_BANKS-1:0]  info_ram_readdata;
reg  [P_RAM_WIDTH*P_RAM_BANKS-1:0]  info_ram_readdata;
wire [P_RAM_WIDTH*P_RAM_BANKS-1:0]  info_ram_readdata_out;

reg          [P_RAM_WIDTH-1:0]      info_ram_writedata; 

reg          [P_RAM_ADDR_BITS-1:0]  avalon_ram_address;
 
wire         [P_RAM_BANK_BITS-1:0]  avalon_ram_bank    = avalon_ram_address >> BANK_ADDR_BITS;

reg                                 avalon_ram_init;     // Asserted from reset for RAM initialization process

reg                                 avalon_ram_write;
reg              [P_RAM_WIDTH-1:0]  avalon_ram_writedata;  
//wire [P_RAM_WIDTH*P_RAM_BANKS-1:0]  t_avalon_ram_readdata;
//wire             [P_RAM_WIDTH-1:0]  avalon_ram_readdata;
reg [8:0]   ram_waddr;
reg [31:0]  ram_wdata;
reg         ram_wen;

// Pipeline address to pap_match read data

reg [P_RAM_ADDR_BITS-1:0] info_ram_address_d1;
always @ (posedge payload_clk)
begin
  info_ram_address_d1 <= info_ram_address;
end

always @ (posedge avalon_clk or posedge avalon_rst)
begin
    if (avalon_rst) 
    begin
        ram_waddr   <=  {9{1'b0}};
        ram_wdata   <=  {32{1'b0}};
        ram_wen     <=  1'b0;
    end
    else
    begin
	    ram_waddr   <=  {{(P_RAM_ADDR_BITS-BANK_ADDR_BITS){1'b0}},avalon_ram_address[BANK_ADDR_BITS-1:0]};
	    ram_wdata   <=  avalon_ram_writedata;
	    ram_wen     <=  avalon_ram_write | avalon_ram_init;
	end
end

sdp_ram_d512_w32 map_ram(
                .clka    (avalon_clk),
                .addra   (ram_waddr),
                .wea     (ram_wen),
                .dina    (ram_wdata),
                .clkb    (payload_clk),
                .addrb   (info_ram_address),
                .doutb   (info_ram_readdata_out[P_RAM_WIDTH-1 : 0])
                );

always @ (posedge payload_clk)
    begin
      info_ram_readdata <= info_ram_readdata_out; //   xlinx 2012/7/18
      if (info_ram_address_d1[0]) begin
        d_port_pid[0] <= info_ram_readdata[P_RAM_WIDTH-1:0];
      end
      else begin
        s_port_pid[0] <= info_ram_readdata[P_RAM_WIDTH-1:0];
      end
    end
                    
////// Dual-port RAM instance. A-port for process,B-port for local logic; 
////genvar i;
////generate
////  for (i=0; i<P_RAM_BANKS; i=i+1)
////  begin : g_ram
////    /*
////    ddp_ram_d256_w32   map_ram (
////      .clock_b        (avalon_clk),       
////      .address_b      (avalon_ram_address[BANK_ADDR_BITS-1:0]),     //pay ateention the bits
////      .wren_b         ((avalon_ram_write & avalon_ram_bank==i) | avalon_ram_init), 
////      .data_b         (avalon_ram_writedata),
////      .q_b            (t_avalon_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)]),
////      
////      .clock_a        (payload_clk),
////      .address_a      (info_ram_address),
////      .wren_a         (1'b0 ),
////      .data_a         ({P_RAM_WIDTH{1'b0}}),
////      .q_a            (info_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)])
////      );
////	*/
////	
////      sdp_ram_d512_w32 map_ram(
////                .clka    (avalon_clk),
////                .addra   ({{(P_RAM_ADDR_BITS-BANK_ADDR_BITS){1'b0}},avalon_ram_address[BANK_ADDR_BITS-1:0]}),
////                .wea     ((avalon_ram_write & avalon_ram_bank==i) | avalon_ram_init),
////                .dina    (avalon_ram_writedata),
////                .clkb    (payload_clk),
////                .addrb   (info_ram_address),
////                .doutb   (info_ram_readdata_out[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)])
////               // .doutb   (info_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)])
////                );
////                

////    always @ (posedge payload_clk)
////    begin
////      info_ram_readdata <= info_ram_readdata_out; //   xlinx 2012/7/18
////      if (info_ram_address_d1[0]) begin
////        d_port_pid[i] <= info_ram_readdata[(i*P_RAM_WIDTH)+(P_RAM_WIDTH-1):(i*P_RAM_WIDTH)];
////      end
////      else begin
////        s_port_pid[i] <= info_ram_readdata[(i*P_RAM_WIDTH)+(P_RAM_WIDTH-1):(i*P_RAM_WIDTH)];
////      end
////    end
////  end
////endgenerate 

// Demux the Avalon read
//assign avalon_ram_readdata = t_avalon_ram_readdata >> (avalon_ram_bank*P_RAM_WIDTH); 

//reg avalon_ram_read;
//reg avalon_ram_readdatavalid;
//always @ (posedge avalon_clk or posedge avalon_rst)
//begin
//  if (avalon_rst) begin
//    avalon_ram_readdatavalid <= 1'b0;
//  end
//  else begin
//    avalon_ram_readdatavalid <= avalon_ram_read;
//  end
//end

 //--------------------------------------------------------------------------------------------------
// Avalon interface and control registers
//--------------------------------------------------------------------------------------------------

always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_ram_init     <= 1'b1;
    avalon_ram_write    <= 1'b0;
    avalon_ram_writedata <= {P_RAM_WIDTH{1'b0}};
    avalon_ram_address  <= 0;
      // Initialization phase to clear RAM
  end
  else if (avalon_ram_init) begin
//    avalon_readdata     <= 32'd0;
    avalon_ram_write    <= 1'b1;
    avalon_ram_writedata <= {P_RAM_WIDTH{1'b1}};
    if (avalon_ram_address[P_RAM_ADDR_BITS-1:0]==P_RAM_DEPTH-1)
      avalon_ram_init <= 1'b0;
    else
      avalon_ram_address <= avalon_ram_address + 1;
  end
  else begin
   	avalon_ram_write    <= avalon_write;
    avalon_ram_writedata <= avalon_writedata;
    avalon_ram_address  <= avalon_address[P_RAM_ADDR_BITS-1:0];
  end
end
 
//--------------------------------------------------------------------------------------------------
// //Store port_and_pid info from receive packet  for use by matcher ;
////   The s_port_pid data struct
////  //|--------------------------------------------------------------------------------
////  //|  7bit     |  9bit        | 3bit              | 13 bit 
////  //|-------------------------------------------------------------------------------
////  //|  reserved | udp index    | pid_transfer mode | PID
////  //|           |              | b'000- pid map    | 
////  //|           |              | b'001- pid block  |   
////  //|           |              | b'000- pid bypass |        
////  //|---------------------------------------------------------------------------------

////   The d_port_pid data struct
////  //|--------------------------------------------------------------------------------
////  //|  7bit     |   5bit             |  4bit        | 3bit     | 13 bit 
////  //|-------------------------------------------------------------------------------
////  //|  reserved |pcr_index(pcr CRECT)|  qam channel | reserved | PID
////  //|---------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
localparam            PID_MAP             = 3'b000;
localparam            PID_BLOCK           = 3'b001;
localparam            PID_BYPASS          = 3'b010; 

reg     [3:0]         state;
localparam            IDLE                = 0;
localparam            PAP_SAVE            = 1;    //PAP=POTR AND port_and_pid SAVE
localparam            MATCH_PAP_REG       = 2;
localparam            MATCH_PAP_MAP       = 3;
localparam            WAIT_MATCH_PAP_MAP  = 4;
localparam            READ_DESTPAP_REG    = 5;  
localparam            WAIT_READ_DESTPAP   = 6;
localparam            WAIT_READ_DESTPAP_D = 7;   
localparam            READ_DESTPAP        = 8;
localparam            MATCH_OVER          = 9;

reg   [31:0]                    port_and_pid;
reg   [BANK_ADDR_BITS-1:0]      bank_id;
reg   [P_RAM_ADDR_BITS-1:0]     d_info_ram_address;
reg                             pap_match;
reg   [2:0]                     pid_trsf_mod;
integer l;
  
always @ (posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)
  begin
    state <= IDLE;
    port_and_pid<=0;
    map_pap<=0;  
    t_match <= 1'b0;
    pap_match =0;
    bank_id =0; 
    info_ram_address <=0; 
    d_info_ram_address<=0; 
//    info_ram_write <=0;    
    info_ram_writedata <=0;
    payload_in_ready <=1'b1;
    pid_trsf_mod <= 0;
  end
  else 
  begin
//    info_ram_write <=1'b0; 
    case(state)
      IDLE:
      begin
         if(payload_in_start & payload_in_valid)
         begin 
           payload_in_ready <=1'b0;
           info_ram_address <= 0;
           d_info_ram_address<= 1;
           t_match <= 1'b0;
           pap_match = 1'b0;
           pid_trsf_mod <= 0;
           map_pap <= 0;
           port_and_pid[31:16] <= payload_in_data[15:0];
           state<=PAP_SAVE;
         end
         else
         begin
           payload_in_ready <=1'b1;
           state<=IDLE;
         end
      end
      PAP_SAVE:
      begin
        if(payload_in_valid) 
        begin  
          info_ram_address <= info_ram_address + 2;
          port_and_pid[15:0] <={3'b0,payload_in_data[20:8]};
          state <= MATCH_PAP_REG;
        end
      end 
      
      MATCH_PAP_REG: begin 
	  //    if(port_and_pid[15:0]!=16'h1fff)begin     //2012.5.15
          info_ram_address <= info_ram_address + 2;
          state <= WAIT_MATCH_PAP_MAP;
	  //   end
	  //   else begin
	  //    state<=IDLE;
	  //   end
      end
      
      WAIT_MATCH_PAP_MAP: begin
         info_ram_address <= info_ram_address + 2;
         state <= MATCH_PAP_MAP;
      end
      
      MATCH_PAP_MAP:
      begin
        if(info_ram_address>=(BANK_DEPTH+6))begin
          state <= IDLE;
        end
        else begin
          for (l=0; l<P_RAM_BANKS; l=l+1) begin
            if( (~pap_match) & (port_and_pid[12:0] == s_port_pid[l][12:0])& (port_and_pid[31:16] == s_port_pid[l][31:16]))begin
                pap_match = 1'b1;
                bank_id = l;
                pid_trsf_mod <= s_port_pid[l][15:13];
            end 
            else if((~pap_match) & (port_and_pid[31:16] == s_port_pid[l][31:16])& (s_port_pid[l][15:13] == PID_BYPASS)) begin
            		pap_match = 1'b1;
                bank_id = l;
                pid_trsf_mod <= PID_BYPASS;	
            end 
          end
          
          if(pap_match)begin
             info_ram_address <= d_info_ram_address;
             state <= READ_DESTPAP_REG;
          end
          else begin
             info_ram_address <= info_ram_address + 2;
             d_info_ram_address <= d_info_ram_address + 2;
             state <= MATCH_PAP_MAP;
          end
        end 
      end 
      
      READ_DESTPAP_REG:
      begin
        state <= WAIT_READ_DESTPAP;
      end
      
      WAIT_READ_DESTPAP:
      begin
        state <= WAIT_READ_DESTPAP_D;
      end
      
      WAIT_READ_DESTPAP_D:
      begin
        state <= READ_DESTPAP;
      end
      
      READ_DESTPAP:
      begin
      	case(pid_trsf_mod) 
          PID_MAP: begin      
            map_pap <= d_port_pid[bank_id];
            t_match <= 1'b1;
          end
          PID_BLOCK:begin
          	t_match <= 1'b0;
          end
          PID_BYPASS:begin
        	  map_pap <= {d_port_pid[bank_id][31:13], port_and_pid[12:0]};
        	  t_match <= 1'b1;
        	end
        	default : t_match <= 1'b0;
        endcase  
        state <= IDLE;              
      end
    default : state <= IDLE;
    endcase
  end
end
endmodule

