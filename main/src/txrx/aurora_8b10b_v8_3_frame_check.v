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
    test_rx_d0,
    test_rx_d1,
    test_rx_d2,
    test_rx_d3,
    data_err_cnt,
    link_err_cnt
);

//***********************************Port Declarations*******************************

    // User Interface
    input   [0:15]     RX_D;
    input              RX_REM;
    input              RX_SOF_N;
    input              RX_EOF_N;
    input              RX_SRC_RDY_N;
    // System Interface
    input              USER_CLK;
    input              RESET;
    input              CHANNEL_UP;
    
    output  [15:0]     test_rx_d0;
    output  [15:0]     test_rx_d1;
    output  [15:0]     test_rx_d2;
    output  [15:0]     test_rx_d3;
    output  [15:0]     data_err_cnt;
    output  [15:0]     link_err_cnt;
    
    wire               rst;
    reg     [15:0]     test_rx_d0;
    reg     [15:0]     test_rx_d1;
    reg     [15:0]     test_rx_d2;
    reg     [15:0]     test_rx_d3;
    reg     [7:0]      count;
    reg     [15:0]     check_data;
    reg     [15:0]     data_err_cnt;
    reg                channel_up_1dly;
    reg                channel_up_2dly;
    reg                neg_channel_up;
    reg     [15:0]     link_err_cnt;

assign rst = RESET || !CHANNEL_UP;

always@(posedge USER_CLK or posedge rst)
begin
    if(rst==1'b1)
    begin
        count   <=  8'h00;
    end
    else if(RX_SOF_N==1'b0)
    begin
        count   <=  8'h01;
    end
    else if(RX_EOF_N==1'b0)
    begin
        count   <=  8'h00;
    end
    else if((RX_SRC_RDY_N==1'b0) && (count>0))
    begin
        count   <=  count + 'h1;
    end
end

always@(posedge USER_CLK or posedge rst)
begin
    if(rst==1'b1)
    begin
        test_rx_d0  <=  16'h0000;
        test_rx_d1  <=  16'h0000;
        test_rx_d2  <=  16'h0000;
        test_rx_d3  <=  16'h0000;
    end
    else if(RX_SRC_RDY_N==1'b0)
    begin
        case(count)
        8'h00:  test_rx_d0  <=  RX_D[0:15];
        8'h01:  test_rx_d1  <=  RX_D[0:15];
        8'h02:  test_rx_d2  <=  RX_D[0:15];
        8'h03:  test_rx_d3  <=  RX_D[0:15];
        default:;
        endcase
    end
end

always@(posedge USER_CLK or posedge rst)
begin
    if(rst==1'b1)
    begin
        check_data  <=  16'h0000;
    end
    else if(RX_SRC_RDY_N==1'b0)
    begin
        check_data  <=  check_data + 'h1;
    end
end

always@(posedge USER_CLK or posedge rst)
begin
    if(rst==1'b1)
    begin    
        data_err_cnt    <=  16'h0000;
    end
    else if((RX_SRC_RDY_N==1'b0) && (RX_D!=check_data))
    begin
        data_err_cnt    <=  data_err_cnt + 'h1;
    end
end

always@(posedge USER_CLK or posedge RESET)
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

endmodule          
