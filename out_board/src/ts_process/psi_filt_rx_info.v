//--------------------------------------------------------------------------------------------------
// (c)2010 CTI Corporation. All righpayload_in reserved.

//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
// File          : $ psi_filt_rx_info.v$
// Last modified : $Date: 2012/8/22 $
// Author        : Z.J.K
//--------------------------------------------------------------------------------------------------

module psi_filt_rx_info #(
  parameter TS_PROCESS_BASE_ADD       = 12'h310,  
  parameter BUS_DATE_L                = 12'h180, 
  parameter BUS_DATE_H                = 12'h181,               
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
   output reg                            search_over,
 
  input                                  avalon_clk,                     // Avalon-MM register interface
  input                                  avalon_rst,
  input                                  avalon_read,
  input                                  avalon_write,
  input       [P_AVALON_ADDR_WIDTH-1:0]  avalon_address,
  input       [P_AVALON_DATA_WIDTH-1:0]  avalon_writedata,
  //output reg  [P_AVALON_DATA_WIDTH-1:0]  avalon_readdata,
  output reg                             avalon_waitrequest,
  output reg  [15:0]                     t_match_listnum,
  output reg                             t_match   
);
 
    
//--------------------------------------------------------------------------------------------------
// parameters
//parameter  IP_RECEIVE_CHANNELS = 96;
//--------------------------------------------------------------------------------------------------
`include "alt_clogb2.v" 
localparam P_MAX_SEARCH_CYCLES = 128;          // Maximum number of clock cycles allowed for socket search
localparam MAX_PID_SELECT = 128;             // Maximum number of port_and_pid search
localparam P_RAM_BANKS = 2; 
localparam P_RAM_BANK_BITS = alt_clogb2(P_RAM_BANKS);
//--------------------------------------------------------------------------------------------------
// port_and_pid RAM. Written by host processor, read by port_and_pid matcher.
// For larger channel count configurations, multiple RAM's are put in parallel to allow more than
// one channel to be checked in a single cycle by the port_and_pid matcher.
//--------------------------------------------------------------------------------------------------
//512*32=1m36k
localparam  P_RAM_DEPTH = 512;
localparam  BANK_DEPTH = P_MAX_SEARCH_CYCLES;
localparam  BANK_ADDR_BITS = alt_clogb2(BANK_DEPTH);
localparam  P_RAM_ADDR_BITS = alt_clogb2(P_RAM_DEPTH);
localparam  P_RAM_WIDTH = 32;
           
reg          [P_RAM_ADDR_BITS-1:0]  info_ram_address;
//reg                                 info_ram_write;
wire [P_RAM_WIDTH*P_RAM_BANKS-1:0]    info_ram_readdata;
//reg          [P_RAM_WIDTH-1:0]      info_ram_writedata; 

reg          [P_RAM_ADDR_BITS-1:0]  avalon_ram_address; 
wire         [P_RAM_BANK_BITS-1:0]  avalon_ram_bank    = avalon_ram_address >> BANK_ADDR_BITS;
reg                                 avalon_ram_init;     // Asserted from reset for RAM initialization process
reg                                 avalon_ram_write;
reg              [P_RAM_WIDTH-1:0]  avalon_ram_writedata;  
//wire [P_RAM_WIDTH*P_RAM_BANKS-1:0]  t_avalon_ram_readdata;
//wire             [P_RAM_WIDTH-1:0]  avalon_ram_readdata;

reg [31:0]   s_port_pid            [0:P_RAM_BANKS-1]; 
// Dual-port RAM instance. A-port for process,B-port for local logic; 
genvar i;
generate
  for (i=0; i<P_RAM_BANKS; i=i+1)
  begin : g_ram
    /*
    ddp_ram_d256_w32   map_ram (
      .clock_b        (avalon_clk),       
      .address_b      (avalon_ram_address[BANK_ADDR_BITS-1:0]),     //pay ateention the bits
      .wren_b         ((avalon_ram_write & avalon_ram_bank==i) | avalon_ram_init), 
      .data_b         (avalon_ram_writedata),
      .q_b            (t_avalon_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)]),
      
      .clock_a        (payload_clk),
      .address_a      (info_ram_address),
      .wren_a         (1'b0 ),
      .data_a         ({P_RAM_WIDTH{1'b0}}),
      .q_a            (info_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)])
      );
        */      
    sdp_ram_d512_w32 map_ram(
                .clka    (avalon_clk),
                .addra   ({{(P_RAM_ADDR_BITS-BANK_ADDR_BITS){1'b0}},avalon_ram_address[BANK_ADDR_BITS-1:0]}),
                .wea     ((avalon_ram_write & avalon_ram_bank==i) | avalon_ram_init),
                .dina    (avalon_ram_writedata),
                .clkb    (payload_clk),
                .addrb   (info_ram_address),
                .doutb   (info_ram_readdata[(i*P_RAM_WIDTH)+P_RAM_WIDTH-1:(i*P_RAM_WIDTH)])
                );
    always @ (posedge payload_clk)
    begin
        s_port_pid[i] <= info_ram_readdata[(i*P_RAM_WIDTH)+(P_RAM_WIDTH-1):(i*P_RAM_WIDTH)];
    end
  //  defparam u_ram.P_DEPTH = P_RAM_DEPTH;
  //  defparam u_ram.P_WIDTH = P_RAM_WIDTH;
  end
endgenerate 

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
//
// Address  R&W                  Use
// =======  ====                 ===
// 0        W         Write address select
// 1        W         [31:0] write port and port_and_pid match map for selected channel
//--------------------------------------------------------------------------------------------------
 localparam  TS_PIDFILTER_SET = 2 +  TS_PROCESS_BASE_ADD;
 localparam  PORT_AND_PID_MAP_LIST_LOW = BUS_DATE_L;
 localparam  PORT_AND_PID_MAP_LIST_HIGH = BUS_DATE_H;
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_waitrequest  <= 1'b1;
    //avalon_readdata     <= 32'd0;
    avalon_ram_init     <= 1'b1;
    avalon_ram_write    <= 1'b0;
    avalon_ram_writedata <= {P_RAM_WIDTH{1'b0}};
   // avalon_ram_read     <= 1'b1;
    avalon_ram_address  <= 0;
  end
  // Initialization phase to clear RAM
  else if (avalon_ram_init) begin
    avalon_waitrequest  <= 1'b1;
    //avalon_readdata     <= 32'd0;
    avalon_ram_write    <= 1'b1;
    avalon_ram_writedata <= {P_RAM_WIDTH{1'b1}};
    //avalon_ram_read     <= 1'b0;
    if (avalon_ram_address[P_RAM_ADDR_BITS-1:0]==P_RAM_DEPTH-1)
      avalon_ram_init <= 1'b0;
    else
      avalon_ram_address <= avalon_ram_address + 1;
  end
  // Process accesses
  else begin

    avalon_waitrequest  <= 1'b1;
    //avalon_readdata     <= 32'd0;
    avalon_ram_write    <= 1'b0;
    //avalon_ram_writedata <= 32'b0;
    //avalon_ram_read     <= 1'b0;
    
    if (avalon_write & avalon_waitrequest) begin
    //if (avalon_write ) begin
      case (avalon_address)
        TS_PIDFILTER_SET :  begin
          avalon_waitrequest <= 1'b0;
          avalon_ram_address <= avalon_writedata[P_RAM_ADDR_BITS-1:0];
          avalon_ram_write    <= 1'b1;
        end
        PORT_AND_PID_MAP_LIST_LOW : begin
          avalon_waitrequest <= 1'b0;
          avalon_ram_writedata[P_AVALON_DATA_WIDTH-1:0] <= avalon_writedata;
        end
        PORT_AND_PID_MAP_LIST_HIGH : begin
          avalon_waitrequest <= 1'b0;
          avalon_ram_writedata[P_RAM_WIDTH-1:P_AVALON_DATA_WIDTH] <= avalon_writedata;
        end
      endcase
    end
    /*
    else if (avalon_read & avalon_waitrequest) begin
      case (avalon_address)
          PORT_AND_PID_MAP_LIST_LOW :  begin
            avalon_waitrequest <= 1'b0;
            //avalon_ram_read <= 1'b1;
            //if (avalon_ram_readdatavalid) begin
            //  avalon_readdata <= avalon_ram_readdata[P_AVALON_DATA_WIDTH-1:0];
            //end
            //else begin
            //  avalon_waitrequest <= 1'b1;
            //end
          end
          PORT_AND_PID_MAP_LIST_HIGH :  begin
            avalon_waitrequest <= 1'b0;
            //avalon_ram_read <= 1'b1;
            //if (avalon_ram_readdatavalid) begin
            //  avalon_readdata <= avalon_ram_readdata[P_RAM_WIDTH-1:P_AVALON_DATA_WIDTH];
            //end
            //else begin
            //  avalon_waitrequest <= 1'b1;
            //end
          end
          default:;
      endcase
    end
    */
  end
end

//--------------------------------------------------------------------------------------------------
// Store port_and_pid info from receive packet  for use by matcher ;
//--------------------------------------------------------------------------------------------------
reg     [3:0]         state;
localparam            IDLE                = 0;
localparam            PAP_SAVE            = 1;    //PAP=POTR AND port_and_pid SAVE
localparam            MATCH_PAP_REG       = 2;
localparam            MATCH_PAP_MAP       = 3;
localparam            SEARCH_OVER         = 4;



reg   [31:0]                    port_and_pid;
reg   [BANK_ADDR_BITS-1:0]      bank_id;
reg                             pap_match;
integer l;
  
always @ (posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)
  begin
    state <= IDLE;
    port_and_pid<=0;
    t_match <= 1'b0;
    t_match_listnum <= 0;
    bank_id =0;
    pap_match =0;
    info_ram_address <=0; 
    search_over <=1'b1;
  end
  else 
  begin
      case(state)
        IDLE:
        begin
           if(payload_in_start & payload_in_valid)
           begin 
             search_over <=1'b0;
             info_ram_address <= 0;
             t_match_listnum <= 0;
             t_match <= 1'b0;
             pap_match = 1'b0;
             port_and_pid[31:16] <= payload_in_data[15:0];
             state<=PAP_SAVE;
           end
           else
           begin
             search_over <=1'b1;
             state<=IDLE;
           end
        end
        PAP_SAVE:
        begin
          if(payload_in_valid) 
          begin  
             info_ram_address <= info_ram_address + 1;
             port_and_pid[15:0] <= {3'b0,payload_in_data[20:8]};
             state <= MATCH_PAP_REG;
          end
        end 
        
        MATCH_PAP_REG: begin 
          if(port_and_pid[15:0]!=16'h1fff)begin
            info_ram_address <= info_ram_address + 1;
            state <= MATCH_PAP_MAP;
          end
          else begin
            state<=IDLE;
          end
        end
              
        MATCH_PAP_MAP:
        begin
          if(t_match_listnum>=P_MAX_SEARCH_CYCLES)begin
            state <= IDLE;
          end
          else begin
            for (l=0; l<P_RAM_BANKS; l=l+1) begin
              if( (~pap_match) & (port_and_pid == s_port_pid[l]))begin
              	bank_id = l;
                pap_match = 1'b1;
              end   
            end
            
            if(pap_match)begin
               state <= SEARCH_OVER;
            end
            else begin
               info_ram_address <= info_ram_address + 1;
               t_match_listnum <=  t_match_listnum + 1;
               state <= MATCH_PAP_MAP;
            end
          end 
        end    
       SEARCH_OVER:
        begin 
        	t_match_listnum <= t_match_listnum + (bank_id<<BANK_ADDR_BITS);
          t_match <= pap_match;
          state <= IDLE;
        end
      default : state <= IDLE;
      endcase
  end
end
endmodule
