

module ts_input_status #(
  parameter TS_IN_STATUS_BASE_ADD     = 12'h320,                
  parameter P_AVALON_ADDR_WIDTH       = 12,
  parameter P_AVALON_DATA_WIDTH       = 16,
  parameter PAYLOAD_DATA_WIDTH        = 32                      
)(

   // Transport stream inputs
   payload_clk,
   payload_rst,
   payload_in_valid,
   payload_in_start,
   payload_in_end,
   payload_in_data,
   
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
parameter P_IN_CHANS              = 512;
parameter P_CHANS_BITS             = alt_clogb2(P_IN_CHANS);
parameter P_FIFO_WIDTH             = 32;
parameter P_FIFO_DEPTH             = 1024;
//parameter P_PACK_LENTH             = 48;
//parameter P_MAXUSE_DEPTH           = P_FIFO_DEPTH - P_PACK_LENTH;
parameter P_FIFO_DEPTH_BITS        = alt_clogb2(P_FIFO_DEPTH);
// State enumerations
parameter P_PUSH_STATE_WIDTH = 3;

parameter P_PUSH_IDLE             = 3'd0;
parameter P_PUSH_PORTPID_CLT      = 3'd1;
parameter P_PUSH_ASCERT           = 3'd2;
parameter P_PUSH_EXECUT           = 3'd3;


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

//--------------------------------------------------------------------------------------------------
// Signal definitions
//--------------------------------------------------------------------------------------------------
wire                                   avalon_fifo_readdatavalid;
// Push side FSM
reg  [P_PUSH_STATE_WIDTH-1:0]          push_current_state;
reg  [P_PUSH_STATE_WIDTH-1:0]          push_next_state;


// Output fifo signals
reg                                    fifo_push;
wire                                   fifo_pop;
wire                                   fifo_wfull;
wire                                   fifo_rempty;
reg  [P_FIFO_WIDTH-1:0]                fifo_write_data;
wire [P_FIFO_WIDTH-1:0]                fifo_read_data;
reg  [P_FIFO_WIDTH-1:0]                fifo_read_data_reg;
wire [P_FIFO_DEPTH_BITS-1:0]           fifo_read_count;

//wire                                   fifo_clear;
// Pop side FSM
reg  [P_POP_STATE_WIDTH-1:0]           pop_current_state;
reg  [P_POP_STATE_WIDTH-1:0]           pop_next_state;


 //--------------------------------------------------------------------------------------------------
// Avalon interface and control registers
//
// Address  R&W                  Use
// =======  ====                 ===
// 0        R         [15:0]  read  TS FIFO STATUS    
//--------------------------------------------------------------------------------------------------

 localparam  SELECT_CHAN = 0;
 localparam  READ_FIFO_DATA_L = TS_IN_STATUS_BASE_ADD+12'h0;
 localparam  READ_FIFO_DATA_H = TS_IN_STATUS_BASE_ADD+12'h1;
 localparam  READ_FIFO_STATUS = TS_IN_STATUS_BASE_ADD+12'h2;
 localparam  CONFIG_CHAN      = TS_IN_STATUS_BASE_ADD+12'h3;
 localparam  READ_REAL_TIMER  = TS_IN_STATUS_BASE_ADD+12'h4;
 localparam  WR_IST_RAM_ADD   = TS_IN_STATUS_BASE_ADD+12'h5;
 localparam  WR_IST_RAM       = TS_IN_STATUS_BASE_ADD+12'h6;
 localparam  READ_REAL_TIMER_H= TS_IN_STATUS_BASE_ADD+12'h7;
   
 reg                                      avalon_fifo_read;
 reg                                      chan_config_tgl;
 reg    [P_AVALON_ADDR_WIDTH-1:0]         config_chan_num;
 reg                                      fifo_rst;
 //reg    [P_AVALON_DATA_WIDTH-1:0]         real_timer;
 reg    [27:0]                            real_timer;
 reg    [15:0]                            real_timer_buf;
 reg                                      rate_clr;
 reg    [P_CHANS_BITS-1:0]                read_port; 
 wire   [P_AVALON_DATA_WIDTH-1:0]         read_port_rate; 
always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
    avalon_waitrequest  <= 1'b1;
    avalon_readdata     <= 32'd0;
    avalon_fifo_read    <= 1'b0;
    config_chan_num     <= 0;
    chan_config_tgl     <= 1'b0;
    fifo_rst <= 1'b0;
    rate_clr <= 1'b0;
  end
  // Process accesses
  else begin
    avalon_fifo_read     <= 1'b0;
    rate_clr <= 1'b0;
	  fifo_rst <=  1'b0;
      case (avalon_address)
        READ_FIFO_DATA_L :  begin
        	if (avalon_read & avalon_waitrequest )begin//& avalon_waitrequest_d1 & avalon_waitrequest_d2) begin
            avalon_waitrequest <= 1'b0;
            avalon_fifo_read <= 1'b1;
          end
          if (avalon_fifo_readdatavalid) begin
            avalon_readdata<= fifo_read_data_reg[15:0];
            avalon_waitrequest  <= 1'b1;
          end 
        end
        
        READ_FIFO_DATA_H :  begin
        	if (avalon_read )begin
            avalon_readdata <= fifo_read_data_reg[31:16];
          end  
        end

        READ_FIFO_STATUS : begin
        	if (avalon_read )begin
            avalon_readdata <= {{(P_AVALON_DATA_WIDTH-P_FIFO_DEPTH_BITS){1'b0}},fifo_read_count};
          end
        end
        
        WR_IST_RAM_ADD : begin
        	if (avalon_write)begin
        	  read_port <= avalon_writedata;
        	end
        end 
               
        WR_IST_RAM : begin
        	if (avalon_write)begin
        		rate_clr <= 1'b1;
          end
        	else begin
        	  avalon_readdata <= read_port_rate;
        	end
        end
        
        READ_REAL_TIMER : begin
        	if (avalon_read )begin
        	  avalon_readdata <= real_timer[15:0];
        	  real_timer_buf  <= {4'h0,real_timer[27:16]};
        	end
        end 
        READ_REAL_TIMER_H: begin
        	if (avalon_read )begin
        	  avalon_readdata <= real_timer_buf;
        	end
        end       
        default:;
    endcase
    
    case (avalon_address)
      CONFIG_CHAN :  begin
	    if (avalon_write & avalon_waitrequest )begin//& avalon_waitrequest_d1 & avalon_waitrequest_d2) begin
          avalon_waitrequest <= 1'b0;
     	    config_chan_num <= avalon_writedata;
     	    chan_config_tgl <= ~chan_config_tgl;
     	    fifo_rst <=  1'b1;
	   	end
      end
      default:;
    endcase 
  end
end

reg           chan_config_tgl_d1;
reg           chan_config_tgl_d2;
reg    [8:0]  select_chan;
always @(posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)begin
   	chan_config_tgl_d1 <= 1'b0;
    chan_config_tgl_d2 <= 1'b0;
  end
  else begin
  	chan_config_tgl_d1 <= chan_config_tgl;
  	chan_config_tgl_d2 <= chan_config_tgl_d1;
  	if(chan_config_tgl_d1!=chan_config_tgl_d2)begin
  		select_chan <= config_chan_num[8:0];
  	end
  end
end
  	
//--------------------------------------------------------------------------------------------------
// HOST read FSM
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
         if(avalon_fifo_read )
         begin
           pop_next_state = P_POP_STATE_POP;   
         end
         else
         begin
           pop_next_state = P_POP_STATE_IDLE;
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
         pop_next_state = P_POP_STATE_WAIT;
      end
      P_POP_STATE_WAIT:
      begin
         pop_next_state = P_POP_STATE_IDLE;
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
always @ (posedge avalon_clk or posedge avalon_rst)
begin
   if(avalon_rst)
   begin
      pop_current_state <= P_POP_STATE_IDLE;
   end
   else
   begin
      pop_current_state <= pop_next_state;
   end
end


assign fifo_pop = (pop_current_state == P_POP_STATE_POP);
assign avalon_fifo_readdatavalid =((pop_current_state == P_POP_STATE_DRIVE) | (pop_current_state == P_POP_STATE_WAIT) );
//--------------------------------------------------------------------------------------------------
// Output FIFO push FSM
//
// IDLE
// PUSH - Write a pointer to the output FIFO.
//--------------------------------------------------------------------------------------------------
// Next state logic
reg  [21:0] port_pid;  //9bit port ,13bit pid
reg  [21:0] port_pid_d;
reg  [8:0]  in_port;
reg  [7:0]  same_pid_count;
reg  [7:0]  same_pid_count_d;

always @(posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)begin
    fifo_push <= 1'b0;
    push_next_state <= 0;
    port_pid <= {22{1'b1}};  //9bit port ,13bit pid
    port_pid_d <= {22{1'b1}};
    same_pid_count <= 0;
    same_pid_count_d <=0;
    fifo_write_data <= 0;
    in_port <= 0;
  end
  else begin
    fifo_push <= 1'b0;
    casez(push_current_state)
      P_PUSH_IDLE:
      begin
         if(payload_in_start & payload_in_valid & (~fifo_wfull))
         begin
            in_port <=payload_in_data[8:0]; 
            push_next_state <= P_PUSH_PORTPID_CLT;
         end
         else begin
            push_next_state <= P_PUSH_IDLE;
         end
      end
      P_PUSH_PORTPID_CLT:begin
      	if(payload_in_valid)begin
      		if(select_chan==in_port)begin
            port_pid_d <= port_pid;
      		  port_pid <={in_port,payload_in_data[20:8]};
      		  push_next_state <= P_PUSH_ASCERT;
      		end
      		else begin
     			  push_next_state <= P_PUSH_IDLE;
      		end
      	end
      end
      P_PUSH_ASCERT:begin
      	if((port_pid != port_pid_d)&(port_pid_d!={22{1'b1}}))begin
      		same_pid_count_d <= same_pid_count;
      		same_pid_count <= 1;
      		push_next_state <= P_PUSH_EXECUT;
      	end 
      	else begin
      		if(same_pid_count==8'hff)begin
      			same_pid_count_d <= same_pid_count;
      			same_pid_count <= 1;
      			push_next_state <= P_PUSH_EXECUT;
      		end
      		else begin
      			same_pid_count <= same_pid_count +1'b1;
      			push_next_state <= P_PUSH_IDLE;
      		end
      	end
      end
      P_PUSH_EXECUT: begin
			  fifo_push <= 1'b1;
			  fifo_write_data <= { 2'b0,port_pid_d[21:0],same_pid_count_d[7:0]};        //    2'b0 + 9bit port + 5bit pid
			  push_next_state <= P_PUSH_IDLE;
		  end
		  
      default:
      begin
			  push_next_state <= P_PUSH_IDLE;
      end
    endcase
  end
end


always @*
begin
   if(payload_rst)
   begin
      push_current_state = P_PUSH_IDLE;
   end
   else
   begin
      push_current_state = push_next_state;
   end
end

//--------------------------------------------------------------------------------------------------
// Instantiate the output FIFO itself
//--------------------------------------------------------------------------------------------------

always @ (posedge avalon_clk or posedge avalon_rst)
begin
  if (avalon_rst) begin
  	fifo_read_data_reg <= 0;
  end
  else begin
  	fifo_read_data_reg <= fifo_read_data;
  end
end
 afifo_w32_d1024 out_state_fifo
   (
    .rst            (avalon_rst | fifo_rst),
    .rd_clk         (avalon_clk),
    .rd_en          (fifo_pop),
    .dout           (fifo_read_data),
    .rd_data_count  (fifo_read_count),
    .empty          (fifo_rempty),
	 
    .wr_clk         (payload_clk),
    .din            (fifo_write_data),
    .wr_en          (fifo_push),
    .full           (fifo_wfull)
  
    );
//defparam u_payload_in_input_fifo.P_WIDTH = P_FIFO_WIDTH;
//defparam u_payload_in_input_fifo.P_DEPTH = P_FIFO_DEPTH; 
//------------------- rate write----------------------------------//
reg                             rate_write;
reg                             rate_read_pre;
reg                             rate_read_pre_d;
reg                             rate_read_pre_dd;
reg  [P_CHANS_BITS-1:0]         write_port;
reg  [P_AVALON_DATA_WIDTH-1:0]  write_port_rate; 
wire [P_AVALON_DATA_WIDTH-1:0]  port_rate_pre;
reg                             port_rate_initial;
 
//   INTPUT RATE STASTIC
always @(posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)begin
    rate_write <= 1'b0;
    rate_read_pre<= 1'b0;
    rate_read_pre_d<= 1'b0;
    rate_read_pre_dd <=  1'b0;
    write_port <= 0; 
    write_port_rate <= 0;
    port_rate_initial <= 1'b1;
  end
  else if(port_rate_initial)begin
	  if(write_port==P_IN_CHANS-1)begin
	  	rate_write <= 1'b1;
		  write_port_rate <= 0;
		  port_rate_initial <= 1'b0;
		end
	  else begin
	  	 rate_write <= 1'b1;
	  	 write_port <= write_port +1'b1;
		end
	end 
 	else begin
 	  rate_write <= 1'b0;
 	  rate_read_pre<= 1'b0;
 	  rate_read_pre_d <= rate_read_pre;
 	  rate_read_pre_dd <= rate_read_pre_d;
    if(payload_in_start & payload_in_valid)
    begin
  	  rate_read_pre<= 1'b1;
	    write_port <= payload_in_data[P_CHANS_BITS-1:0];  
    end  
    if(rate_read_pre_dd)
    begin
      rate_write <= 1'b1;
     	write_port_rate <= port_rate_pre + 1'b1;
    end  
  end
end
//
localparam RAM_DEPTH      = 512;
localparam RAM_DEPTH_BITS = alt_clogb2(RAM_DEPTH);
ddp_ram_d512_w16 ist_ram(
    .clka    (payload_clk),
    .addra   ({{(RAM_DEPTH_BITS-P_CHANS_BITS){1'b0}},write_port}),
    .wea     (rate_write),
    .dina    (write_port_rate),
    .douta   (port_rate_pre),
    
    .clkb    (avalon_clk),
    .addrb   ({{(RAM_DEPTH_BITS-P_CHANS_BITS){1'b0}},read_port}),
    .web     (rate_clr),
    .dinb    (16'b0),
    .doutb   (read_port_rate)
    );	 
    
//*----------------16bit ms timer ------------------------*/
localparam  CLK_PERIOD     = 10;       // 1s/100m = 10ns
localparam  PER_MS_COUNT   = 1000/CLK_PERIOD;
localparam  MS_COUNT_WIDTH = alt_clogb2(PER_MS_COUNT);
reg   [MS_COUNT_WIDTH-1: 0]       ms_count;

always @ (posedge avalon_clk or posedge avalon_rst)
begin
	if (avalon_rst) begin
		 ms_count <= 0;
		 real_timer <= 0;
  end
  else begin
  	if(ms_count!= PER_MS_COUNT-1 )begin
  		ms_count <= ms_count + 'h1;
  	end
  	else begin
  		real_timer <= real_timer +'h1;
  		ms_count <= 0;
  	end 	
  end
end  

  
endmodule
