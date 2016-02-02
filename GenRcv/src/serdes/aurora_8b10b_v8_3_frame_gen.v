/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  aurora_8b10b_v8_3_FRAME_GEN.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  aurora_8b10b_v8_3_FRAME_GEN.v
    File tree    :  aurora_8b10b_v8_3_FRAME_GEN.v                        
\************************************************************************************/

`timescale 1 ns / 1 ps
`define DLY #1

module aurora_8b10b_v8_3_FRAME_GEN
(
    // User Interface
    TX_D, 
    TX_REM,    
    TX_SOF_N,      
    TX_EOF_N,
    TX_SRC_RDY_N,
    TX_DST_RDY_N,

    // System Interface
    USER_CLK,      
    RESET,
    CHANNEL_UP
);
//*****************************Parameter Declarations****************************

//***********************************Port Declarations*******************************

   // User Interface
    output  [15:0]     TX_D;
    output             TX_REM;
    output             TX_SOF_N;
    output             TX_EOF_N;
    output             TX_SRC_RDY_N;
    input              TX_DST_RDY_N;

      // System Interface
    input              USER_CLK;
    input              RESET;
    input              CHANNEL_UP;  
 
    wire               reset_c;
    wire    [15:0]     TX_D;
	 reg		[15:0]	  TX_D_i;
	 (* KEEP = "TRUE" *)
    reg     [6:0]      word_cnt;
    reg     [3:0]      ts_cc;
    reg     [2:0]      dst_slot;
    wire    [3:0]      dst_chn;
    wire    [12:0]     ts_pid;

//*********************************Main Body of Code**********************************

  //Generate RESET signal when Aurora channel is not ready
  assign reset_c = RESET || !CHANNEL_UP;

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        word_cnt   <=  {7{1'b0}};
    end
    else if(TX_DST_RDY_N==1'b0)
    begin
        if(word_cnt>=97)  
//        if(word_cnt>=108)   //avoid master board RAM overflow
        begin
            word_cnt   <=  {7{1'b0}};
        end
        else
        begin
            word_cnt   <=  word_cnt + 1;
        end
    end
end

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        ts_cc    <=  4'h0;
    end
    else if(TX_EOF_N==1'b0)
    begin
        ts_cc    <=  ts_cc + 'h1;
    end
end

assign  ts_pid  =   {1'b0,12'h521};
assign  dst_chn =   4'h5;

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        dst_slot    <=  3'b000;
    end
    else if((TX_EOF_N==1'b0) && (ts_cc==15))
    begin
        if(dst_slot==5)
        begin
            dst_slot    <=  3'b000;
        end
        else
        begin
            dst_slot    <=  dst_slot + 'h1;
        end
    end
end
wire    [6:0]      		word_cnt_buf;    
assign  TX_REM          = 1'b1;
assign  TX_SRC_RDY_N    = ((word_cnt>=0) && (word_cnt<98) && (TX_DST_RDY_N==1'b0))   ?   1'b0 : 1'b1;
assign  TX_SOF_N        = ((word_cnt==0) && (TX_DST_RDY_N==1'b0))  ?   1'b0 : 1'b1;
assign  TX_EOF_N        = ((word_cnt==97) && (TX_DST_RDY_N==1'b0)) ?   1'b0 : 1'b1;
assign  word_cnt_buf    =  word_cnt + 'h1;
assign  TX_D				= ((word_cnt>=0) &&(word_cnt <= 97))	?	TX_D_i : 0;
always@*
begin
    if(TX_SRC_RDY_N==1'b0)
    begin
        case(word_cnt)
            //ECM PACKET
            7'd0:   TX_D_i    =   16'h8001;                                   //packet type
            7'd1:   TX_D_i    =   {{9{1'b0}},dst_slot[2:0],dst_chn[3:0]};     //{src_slot[11:8],dst_slot[7:4],chan[3:0]}
            7'd2:   TX_D_i    =   16'h00bc;                                   //packet length:188bytes
            7'd3:   TX_D_i    =   {8'h47,{3{1'b0}},ts_pid[12:8]};              //ts packet;
            7'd4:   TX_D_i    =   {ts_pid[7:0],4'h01,ts_cc[3:0]};             //1024 pid:0x100~0x4ff,only payload        
            default:TX_D_i    =   {1'b0,word_cnt_buf[6:0],1'b0,word_cnt_buf[6:0]};     //16'h0606~16'h6262
        endcase
    end
end                    

endmodule
