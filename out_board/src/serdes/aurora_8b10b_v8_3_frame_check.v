/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  aurora_8b10b_v8_3_FRAME_CHECK.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  aurora_8b10b_v8_3_FRAME_CHECK.v
    File tree    :  aurora_8b10b_v8_3_FRAME_CHECK.v                        
\************************************************************************************/

`timescale 1 ns / 1 ps
`define DLY #1

module aurora_8b10b_v8_3_FRAME_CHECK
(
    // User Interface
    RX_D, 
    RX_REM,    
    RX_SOF_N,      
    RX_EOF_N,
    RX_SRC_RDY_N,

    // System Interface
    USER_CLK,      
    RESET,
    CHANNEL_UP,
    pkt_counter,
    gtp_err_cnt
);

//***********************************Port Declarations*******************************

parameter PKT_NUM = 100;
parameter TIME_1S = 2500000;
    // User Interface
    input   [0:15]     RX_D;
    input              RX_REM;
    input              RX_SOF_N;
    input              RX_EOF_N;
	 (* KEEP = "TRUE" *)
    input              RX_SRC_RDY_N;
    // System Interface
    input              USER_CLK;
    input              RESET;
    input              CHANNEL_UP;
    
    output  [15:0]     gtp_err_cnt;
    output  [15:0]     pkt_counter;
    
    wire               rst;
    reg     [15:0]     gtp_err_cnt;
    reg                err_flag;
	 (* KEEP = "TRUE" *)
    reg     [15:0]     check_data;
    
    reg     [9:0]      counter;
	 (* KEEP = "TRUE" *)
    reg     [6:0]      word_cnt;
    wire    [6:0]      word_cnt_buf;
    wire    [3:0]      ts_cc;
    wire    [12:0]     ts_pid;
    wire    [3:0]      dst_chn;
    reg     [15:0]     pkt_counter;
(* KEEP = "TRUE" *)
reg                start;
reg                channel_up_1dly;
reg                channel_up_2dly;
(* KEEP = "TRUE" *)
reg                neg_channel_up;
reg     [15:0]     link_err_cnt;
(* KEEP = "TRUE" *)
reg     [3:0]      ts_cc_buf;
(* KEEP = "TRUE" *)
reg                cc_error;
reg     [15:0]     p_cnt;
wire    [3:0]      temp;
reg     [31:0]     time_cnt;
(* KEEP = "TRUE" *)
reg                data_err;
 
assign rst = RESET || !CHANNEL_UP;

//check receive data
always@(posedge USER_CLK)
begin
    if(rst == 1'b1)
    begin
        data_err    <=    1'b0;
    end
    else if((RX_SRC_RDY_N==1'b0) && (check_data[15:0]!=RX_D[0:15]) && (word_cnt !=1) && (word_cnt != 4))
    begin
	     data_err    <=    1'b1;
    end
    else
        data_err    <=    1'b0;
end		  

always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        err_flag    <=  1'b0;
    end
    else if(((data_err==1'b1) || (cc_error==1'b1) || (neg_channel_up==1'b1)) && (start==1'b1))
    begin
        err_flag    <=  1'b1;
    end
    else
    begin
        err_flag    <=  1'b0;
    end
end
        
always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        gtp_err_cnt <=  {16{1'b0}};
    end
    else if(start==1'b0)
    //else if(time_cnt==TIME_1S)
    begin
        gtp_err_cnt <=  {16{1'b0}};
    end
    else if(err_flag==1'b1)
    begin
        gtp_err_cnt <=  gtp_err_cnt + 'h1;
    end
end

always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        pkt_counter <=  {16{1'b0}};
    end
    else if(start==1'b0)
    begin
        pkt_counter <=  {16{1'b0}};
    end
    else if(RX_SOF_N==1'b0)
    begin
        pkt_counter <=  pkt_counter + 'h1;
    end
end

always@(posedge USER_CLK)
begin
    if(RESET==1'b1)
    begin
        channel_up_1dly <=  1'b0;
        channel_up_2dly <=  1'b0;
        neg_channel_up  <=  1'b0;
    end
    else
    begin
        channel_up_1dly <=  CHANNEL_UP;
        channel_up_2dly <=  channel_up_1dly;
        neg_channel_up  <=  (~channel_up_1dly) & channel_up_2dly;
    end
end     

always@(posedge USER_CLK or posedge RESET)
begin
    if(RESET==1'b1)
    begin
        link_err_cnt    <=  16'h0000;
    end
    else if(neg_channel_up==1'b1)
    begin
        link_err_cnt    <=  link_err_cnt + 'h1;
    end
end

////////////////////////////////////////////////////////////////////
//check data
//////////////////////////////////////////////////////////////////// 
always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        p_cnt   <=  {16{1'b0}};
    end
    else if(time_cnt==TIME_1S)
    begin
        p_cnt   <=  {16{1'b0}};
    end
    else if(p_cnt>PKT_NUM)    
    begin
        p_cnt   <=  {16{1'b1}};
    end
    else if(RX_SOF_N==1'b0)
    begin
        p_cnt   <=  p_cnt + 'h1;
    end
end

always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        time_cnt    <=  {32{1'b0}};
    end
    else if(RX_SOF_N==1'b0)
    begin
        time_cnt    <=  32'd1;
    end
    else if(time_cnt>=TIME_1S)
    begin
        time_cnt    <=  TIME_1S;
    end
    else if(time_cnt>0)
    begin
        time_cnt    <=  time_cnt + 'h1;
    end
end

always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        start   <=  1'b0;
    end
    else if(p_cnt>PKT_NUM)
    begin
        if((RX_SOF_N==1'b0) && (time_cnt<TIME_1S))
        begin
            start   <=  1'b1;
        end
        else if(time_cnt==TIME_1S)
        begin
            start   <=  1'b0;
        end
    end
end
    
always @(posedge USER_CLK)  
begin
    if(rst==1'b1)
    begin
        ts_cc_buf   <=  4'h0;
    end
    else if((word_cnt==4) && (RX_SRC_RDY_N==1'b0))
    begin
        ts_cc_buf   <=  RX_D[12:15];
    end
end

assign  temp    =   ts_cc_buf + 4'h1;

always @(posedge USER_CLK)  
begin
    if(rst==1'b1)
    begin
        cc_error    <=  1'b0;
    end
    else if((word_cnt==4) && (RX_SRC_RDY_N==1'b0))
    begin
        if(RX_D[12:15]==temp[3:0])
        begin
            cc_error    <=  1'b0;
        end
        else
        begin
            cc_error    <=  1'b1;
        end
    end
    else
    begin
        cc_error    <=  1'b0;
    end
end
                    
always@(posedge USER_CLK)
begin
    if(rst==1'b1)
    begin
        word_cnt   <=  {7{1'b0}};
    end
    else if(RX_SOF_N==1'b0)
    begin
        word_cnt   <=  7'b000_0001;
    end
    else if(RX_EOF_N==1'b0)
    begin
        word_cnt   <=  {7{1'b0}};
    end
    else if((RX_SRC_RDY_N==1'b0) && (word_cnt>0))
    begin
        word_cnt   <=  word_cnt + 'h1;
    end
end

//always @(posedge USER_CLK)  
//begin
//    if(rst==1'b1)
//    begin
//        ts_cc    <=  4'h0;
//    end
//    else if(RX_EOF_N==1'b0)
//    begin
//        if(pkt_1st==1'b0)
//        begin
//            ts_cc   <=  ts_cc_buf + 'h1;
//        end
//        else
//        begin
//            ts_cc   <=  ts_cc + 'h1;
//        end
//    end
//end

assign  ts_cc   =   4'h0;
assign  ts_pid  =   {1'b0,12'h521};
assign  dst_chn =   4'h5;

assign  word_cnt_buf    =   word_cnt + 'h1;

always@*
begin
    if(RX_SRC_RDY_N==1'b0)
    begin
        case(word_cnt)
            //ECM PACKET
            7'd0:   check_data    =   16'h8001;                                   //packet type
            7'd1:   check_data    =   {{9{1'b0}},3'b000,dst_chn[3:0]};            //{src_slot[11:8],dst_slot[7:4],chan[3:0]}
            7'd2:   check_data    =   16'h00bc;                                   //packet length:188bytes
            7'd3:   check_data    =   {8'h47,{3{1'b0}},ts_pid[12:8]};             //ts packet;
            7'd4:   check_data    =   {ts_pid[7:0],4'h01,ts_cc[3:0]};             //1024 pid:0x100~0x4ff,only payload         
				7'd97:  check_data    =   16'h629c;
				default:check_data    =   {1'b0,word_cnt_buf[6:0],1'b0,word_cnt_buf[6:0]};     //16'h0606~16'h6262
        endcase
    end
end
        
endmodule          
