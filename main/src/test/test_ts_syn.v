module test_ts_syn(
  // Receive Transport stream 
   payload_clk,
   payload_rst,
   payload_in_valid,
   payload_in_start,
   payload_in_end,
   payload_in_data,
	 err_flag
	);
input                    payload_clk;
(* KEEP = "TRUE" *)
input                    payload_rst;
(* KEEP = "TRUE" *)
input                    payload_in_valid;
(* KEEP = "TRUE" *)
input                    payload_in_start;
(* KEEP = "TRUE" *)
input                    payload_in_end;
(* KEEP = "TRUE" *)
input  [15:0]            payload_in_data;
output                   err_flag;
parameter                DEFAULT_PID = 13'h521;

parameter                TEST_IDLE     = 0;
parameter                TEST_INT      = 1;
parameter                TEST_LEN      = 2;	
parameter                TEST_SYN      = 3;
parameter                TEST_PID      = 4;
parameter                TEST_CC       = 5;
parameter                TEST_END      = 6;

(* KEEP = "TRUE" *)
reg  [2:0]               test_state;
(* KEEP = "TRUE" *)
reg                      syn_err;
(* KEEP = "TRUE" *)
reg                      len_err;
(* KEEP = "TRUE" *)
reg                      cc_err;
(* KEEP = "TRUE" *)
reg  [7:0]               len_count;

reg  [12:0]              test_pid_reg = DEFAULT_PID;
(* KEEP = "TRUE" *)
reg  [3:0]               test_cc_reg  = 0;
(* KEEP = "TRUE" *)
reg  [12:0]              pid_reg;
(* KEEP = "TRUE" *)
reg  [4:0]               cc_reg;
always @ (posedge payload_clk or posedge payload_rst)
begin
  if(payload_rst)
  begin
    syn_err <= 0;
    len_err <= 0;
    cc_err <= 0;
	 len_count<=0;
	 test_state<=TEST_IDLE;
  end
  else begin
    case (test_state)
	  TEST_IDLE:
		begin
		  len_count<=0;
		  syn_err <= 0;
        len_err <= 0;
        cc_err <= 0;
	     if(payload_in_start & payload_in_valid)
		  begin
		    if(payload_in_data[15:0]==16'h8001)
			 begin	
			   test_state<=TEST_INT;	
			 end
			 else begin
				test_state<=TEST_IDLE;
				syn_err<=1'b1;
			 end
			 len_count<=0;
	     end
		end
		
		TEST_INT:
		begin
	    if(payload_in_valid)
		  begin
		    test_state<= TEST_LEN;
		  end 
	 end
		
		TEST_LEN:
	   begin 
		  if(payload_in_valid)
		  begin
		    if(payload_in_data[15:0]==16'h00bc)
			 begin	
			   test_state<=TEST_SYN;	
			 end
			 else begin
				test_state<=TEST_IDLE;
				len_err<=1'b1;
			 end	
		  end
		end
		
		TEST_SYN:
		begin
		  if(payload_in_valid)
		  begin
		    if(payload_in_data[15:8]!=8'h47)
			 begin	
			   syn_err<=1'b1;;	
			 end
			 pid_reg[12:8] <= payload_in_data[4:0];
			 len_count <= len_count + 1'b1; 
			 test_state<=TEST_PID;
		  end
	   end
				
		TEST_PID:
		begin
		  if(payload_in_valid)
		  begin
		    pid_reg[7:0] <= payload_in_data[15:8];
			 cc_reg[4:0] <= payload_in_data[4:0];
			 len_count <= len_count + 1'b1; 
		    test_state<=TEST_CC;
		  end		  
		end
		
		TEST_CC:
		begin
		  if(pid_reg == test_pid_reg && cc_reg[4] == 1'b1)begin
		    if(test_cc_reg[3:0] != cc_reg[3:0])
			 begin
			   cc_err <= 1'b1;
			 end
		    test_cc_reg <= cc_reg[3:0] + 1'b1;
		  end
		  
		  if(payload_in_valid)
		  begin
		    len_count <= len_count + 1'b1;
		  end
	     test_state<=TEST_END;
		end
		
		TEST_END:
		begin
		  if(payload_in_valid)
		  begin
			 if(payload_in_end == 1'b1)begin
			   if(len_count != 'd94)begin //188/2
				  len_err <= 1'b1;
			   end
			   len_count<=0;
				test_state<=TEST_IDLE;
			 end
			 else begin
			   len_count <= len_count + 1'b1; 
			 end
		  end
	   end
	   default: test_state<=TEST_IDLE;
    endcase
  end
end
assign err_flag = syn_err | len_err |cc_err;
endmodule