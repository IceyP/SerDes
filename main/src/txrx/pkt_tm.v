/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  pkt_tm.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-07  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  pkt_tm.v
    File tree    :  pkt_tm.v                        
\************************************************************************************/

`timescale 1ns/1ps

module pkt_tm(
    clk_156m                    ,
    rst_156m                    ,
    clk_200m                    ,
    channel_up                  ,
    
    rx_data_in0                 ,
    rx_data_in1                 ,
    rx_data_in2                 ,
    rx_data_in3                 ,
    rx_data_in4                 ,
    rx_data_in5                 ,
    rx_data_in6                 ,
    rx_data_in7                 ,
    rx_rem                      ,
    rx_sof_n                    ,
    rx_eof_n                    ,
    rx_src_rdy_n                ,
    
    tx_data_out0                ,
    tx_data_out1                ,
    tx_data_out2                ,
    tx_data_out3                ,
    tx_data_out4                ,
    tx_data_out5                ,
    tx_data_out6                ,
    tx_data_out7                ,
    tx_rem                      ,
    tx_sof_n                    ,
    tx_eof_n                    ,
    tx_src_rdy_n                ,
    tx_dst_rdy_n
    );           
parameter   RAM_DEPTH                   = 11                        ;

input   [7:0]                           clk_156m                    ;
input   [7:0]                           rst_156m                    ;
input                                   clk_200m                    ;
input   [7:0]                           channel_up                  ;

input   [0:15]                          rx_data_in0                 ;
input   [0:15]                          rx_data_in1                 ;                                           
input   [0:15]                          rx_data_in2                 ;
input   [0:15]                          rx_data_in3                 ;
input   [0:15]                          rx_data_in4                 ;
input   [0:15]                          rx_data_in5                 ;
input   [0:15]                          rx_data_in6                 ;
input   [0:15]                          rx_data_in7                 ;
input   [7:0]                           rx_rem                      ;
input   [7:0]                           rx_sof_n                    ;
input   [7:0]                           rx_eof_n                    ;
input   [7:0]                           rx_src_rdy_n                ;

output  [0:15]                          tx_data_out0                ;
output  [0:15]                          tx_data_out1                ;
output  [0:15]                          tx_data_out2                ;
output  [0:15]                          tx_data_out3                ;
output  [0:15]                          tx_data_out4                ;
output  [0:15]                          tx_data_out5                ;
output  [0:15]                          tx_data_out6                ;
output  [0:15]                          tx_data_out7                ;
output  [7:0]                           tx_rem                      ;
output  [7:0]                           tx_sof_n                    ;
output  [7:0]                           tx_eof_n                    ;
output  [7:0]                           tx_src_rdy_n                ;
input   [7:0]                           tx_dst_rdy_n                ;

wire    [0:15]                          rx_data[7:0]                ;
wire    [0:15]                          tx_data[7:0]                ;

wire    [7:0]                           fifo_rden[7:0]              ;
wire    [23:0]                          fifo_dout_out0_in[7:0]      ;
wire    [23:0]                          fifo_dout_out1_in[7:0]      ;
wire    [23:0]                          fifo_dout_out2_in[7:0]      ;
wire    [23:0]                          fifo_dout_out3_in[7:0]      ;
wire    [23:0]                          fifo_dout_out4_in[7:0]      ;
wire    [23:0]                          fifo_dout_out5_in[7:0]      ;
wire    [23:0]                          fifo_dout_out6_in[7:0]      ;
wire    [23:0]                          fifo_dout_out7_in[7:0]      ;
wire    [7:0]                           pkt_rdy_in[7:0]             ;

wire    [RAM_DEPTH - 1:0]               ram_raddr_out0_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out1_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out2_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out3_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out4_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out5_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out6_in[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_out7_in[7:0]      ;

wire    [15:0]                          ram_dout_out0_in[7:0]       ;
wire    [15:0]                          ram_dout_out1_in[7:0]       ;
wire    [15:0]                          ram_dout_out2_in[7:0]       ;
wire    [15:0]                          ram_dout_out3_in[7:0]       ;
wire    [15:0]                          ram_dout_out4_in[7:0]       ;
wire    [15:0]                          ram_dout_out5_in[7:0]       ;
wire    [15:0]                          ram_dout_out6_in[7:0]       ;
wire    [15:0]                          ram_dout_out7_in[7:0]       ;

wire    [RAM_DEPTH - 1:0]               ram_raddr_in0_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in1_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in2_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in3_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in4_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in5_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in6_out[7:0]      ;
wire    [RAM_DEPTH - 1:0]               ram_raddr_in7_out[7:0]      ;

wire    [15:0]                          ram_dout_in0_out[7:0]       ;
wire    [15:0]                          ram_dout_in1_out[7:0]       ;
wire    [15:0]                          ram_dout_in2_out[7:0]       ;
wire    [15:0]                          ram_dout_in3_out[7:0]       ;
wire    [15:0]                          ram_dout_in4_out[7:0]       ;
wire    [15:0]                          ram_dout_in5_out[7:0]       ;
wire    [15:0]                          ram_dout_in6_out[7:0]       ;
wire    [15:0]                          ram_dout_in7_out[7:0]       ;

wire    [7:0]                           tx_fifo_rden[7:0]           ;
wire    [23:0]                          fifo_dout_in0_out[7:0]      ;
wire    [23:0]                          fifo_dout_in1_out[7:0]      ;
wire    [23:0]                          fifo_dout_in2_out[7:0]      ;
wire    [23:0]                          fifo_dout_in3_out[7:0]      ;
wire    [23:0]                          fifo_dout_in4_out[7:0]      ;
wire    [23:0]                          fifo_dout_in5_out[7:0]      ;
wire    [23:0]                          fifo_dout_in6_out[7:0]      ;
wire    [23:0]                          fifo_dout_in7_out[7:0]      ;

wire    [7:0]                           pkt_rdy_out[7:0]            ;
wire    [7:0]                           rst                         ;

assign  rx_data[0]      =   rx_data_in0;
assign  rx_data[1]      =   rx_data_in1;
assign  rx_data[2]      =   rx_data_in2;
assign  rx_data[3]      =   rx_data_in3;
assign  rx_data[4]      =   rx_data_in4;
assign  rx_data[5]      =   rx_data_in5;
assign  rx_data[6]      =   rx_data_in6;
assign  rx_data[7]      =   rx_data_in7;

assign  tx_data_out0    =   tx_data[0];
assign  tx_data_out1    =   tx_data[1];
assign  tx_data_out2    =   tx_data[2];
assign  tx_data_out3    =   tx_data[3];
assign  tx_data_out4    =   tx_data[4];
assign  tx_data_out5    =   tx_data[5];
assign  tx_data_out6    =   tx_data[6];
assign  tx_data_out7    =   tx_data[7];

assign  fifo_dout_in0_out[0]    =   fifo_dout_out0_in[0];
assign  fifo_dout_in1_out[0]    =   fifo_dout_out0_in[1];
assign  fifo_dout_in2_out[0]    =   fifo_dout_out0_in[2];
assign  fifo_dout_in3_out[0]    =   fifo_dout_out0_in[3];
assign  fifo_dout_in4_out[0]    =   fifo_dout_out0_in[4];
assign  fifo_dout_in5_out[0]    =   fifo_dout_out0_in[5];
assign  fifo_dout_in6_out[0]    =   fifo_dout_out0_in[6];
assign  fifo_dout_in7_out[0]    =   fifo_dout_out0_in[7];

assign  fifo_dout_in0_out[1]    =   fifo_dout_out1_in[0];
assign  fifo_dout_in1_out[1]    =   fifo_dout_out1_in[1];
assign  fifo_dout_in2_out[1]    =   fifo_dout_out1_in[2];
assign  fifo_dout_in3_out[1]    =   fifo_dout_out1_in[3];
assign  fifo_dout_in4_out[1]    =   fifo_dout_out1_in[4];
assign  fifo_dout_in5_out[1]    =   fifo_dout_out1_in[5];
assign  fifo_dout_in6_out[1]    =   fifo_dout_out1_in[6];
assign  fifo_dout_in7_out[1]    =   fifo_dout_out1_in[7];

assign  fifo_dout_in0_out[2]    =   fifo_dout_out2_in[0];
assign  fifo_dout_in1_out[2]    =   fifo_dout_out2_in[1];
assign  fifo_dout_in2_out[2]    =   fifo_dout_out2_in[2];
assign  fifo_dout_in3_out[2]    =   fifo_dout_out2_in[3];
assign  fifo_dout_in4_out[2]    =   fifo_dout_out2_in[4];
assign  fifo_dout_in5_out[2]    =   fifo_dout_out2_in[5];
assign  fifo_dout_in6_out[2]    =   fifo_dout_out2_in[6];
assign  fifo_dout_in7_out[2]    =   fifo_dout_out2_in[7];

assign  fifo_dout_in0_out[3]    =   fifo_dout_out3_in[0];
assign  fifo_dout_in1_out[3]    =   fifo_dout_out3_in[1];
assign  fifo_dout_in2_out[3]    =   fifo_dout_out3_in[2];
assign  fifo_dout_in3_out[3]    =   fifo_dout_out3_in[3];
assign  fifo_dout_in4_out[3]    =   fifo_dout_out3_in[4];
assign  fifo_dout_in5_out[3]    =   fifo_dout_out3_in[5];
assign  fifo_dout_in6_out[3]    =   fifo_dout_out3_in[6];
assign  fifo_dout_in7_out[3]    =   fifo_dout_out3_in[7];

assign  fifo_dout_in0_out[4]    =   fifo_dout_out4_in[0];
assign  fifo_dout_in1_out[4]    =   fifo_dout_out4_in[1];
assign  fifo_dout_in2_out[4]    =   fifo_dout_out4_in[2];
assign  fifo_dout_in3_out[4]    =   fifo_dout_out4_in[3];
assign  fifo_dout_in4_out[4]    =   fifo_dout_out4_in[4];
assign  fifo_dout_in5_out[4]    =   fifo_dout_out4_in[5];
assign  fifo_dout_in6_out[4]    =   fifo_dout_out4_in[6];
assign  fifo_dout_in7_out[4]    =   fifo_dout_out4_in[7];

assign  fifo_dout_in0_out[5]    =   fifo_dout_out5_in[0];
assign  fifo_dout_in1_out[5]    =   fifo_dout_out5_in[1];
assign  fifo_dout_in2_out[5]    =   fifo_dout_out5_in[2];
assign  fifo_dout_in3_out[5]    =   fifo_dout_out5_in[3];
assign  fifo_dout_in4_out[5]    =   fifo_dout_out5_in[4];
assign  fifo_dout_in5_out[5]    =   fifo_dout_out5_in[5];
assign  fifo_dout_in6_out[5]    =   fifo_dout_out5_in[6];
assign  fifo_dout_in7_out[5]    =   fifo_dout_out5_in[7];

assign  fifo_dout_in0_out[6]    =   fifo_dout_out6_in[0];
assign  fifo_dout_in1_out[6]    =   fifo_dout_out6_in[1];
assign  fifo_dout_in2_out[6]    =   fifo_dout_out6_in[2];
assign  fifo_dout_in3_out[6]    =   fifo_dout_out6_in[3];
assign  fifo_dout_in4_out[6]    =   fifo_dout_out6_in[4];
assign  fifo_dout_in5_out[6]    =   fifo_dout_out6_in[5];
assign  fifo_dout_in6_out[6]    =   fifo_dout_out6_in[6];
assign  fifo_dout_in7_out[6]    =   fifo_dout_out6_in[7];

assign  fifo_dout_in0_out[7]    =   fifo_dout_out7_in[0];
assign  fifo_dout_in1_out[7]    =   fifo_dout_out7_in[1];
assign  fifo_dout_in2_out[7]    =   fifo_dout_out7_in[2];
assign  fifo_dout_in3_out[7]    =   fifo_dout_out7_in[3];
assign  fifo_dout_in4_out[7]    =   fifo_dout_out7_in[4];
assign  fifo_dout_in5_out[7]    =   fifo_dout_out7_in[5];
assign  fifo_dout_in6_out[7]    =   fifo_dout_out7_in[6];
assign  fifo_dout_in7_out[7]    =   fifo_dout_out7_in[7];

assign  ram_raddr_out0_in[0]    =   ram_raddr_in0_out[0];
assign  ram_raddr_out1_in[0]    =   ram_raddr_in0_out[1];
assign  ram_raddr_out2_in[0]    =   ram_raddr_in0_out[2];
assign  ram_raddr_out3_in[0]    =   ram_raddr_in0_out[3];
assign  ram_raddr_out4_in[0]    =   ram_raddr_in0_out[4];
assign  ram_raddr_out5_in[0]    =   ram_raddr_in0_out[5];
assign  ram_raddr_out6_in[0]    =   ram_raddr_in0_out[6];
assign  ram_raddr_out7_in[0]    =   ram_raddr_in0_out[7];
                                
assign  ram_raddr_out0_in[1]    =   ram_raddr_in1_out[0];
assign  ram_raddr_out1_in[1]    =   ram_raddr_in1_out[1];
assign  ram_raddr_out2_in[1]    =   ram_raddr_in1_out[2];
assign  ram_raddr_out3_in[1]    =   ram_raddr_in1_out[3];
assign  ram_raddr_out4_in[1]    =   ram_raddr_in1_out[4];
assign  ram_raddr_out5_in[1]    =   ram_raddr_in1_out[5];
assign  ram_raddr_out6_in[1]    =   ram_raddr_in1_out[6];
assign  ram_raddr_out7_in[1]    =   ram_raddr_in1_out[7];
                                
assign  ram_raddr_out0_in[2]    =   ram_raddr_in2_out[0];
assign  ram_raddr_out1_in[2]    =   ram_raddr_in2_out[1];
assign  ram_raddr_out2_in[2]    =   ram_raddr_in2_out[2];
assign  ram_raddr_out3_in[2]    =   ram_raddr_in2_out[3];
assign  ram_raddr_out4_in[2]    =   ram_raddr_in2_out[4];
assign  ram_raddr_out5_in[2]    =   ram_raddr_in2_out[5];
assign  ram_raddr_out6_in[2]    =   ram_raddr_in2_out[6];
assign  ram_raddr_out7_in[2]    =   ram_raddr_in2_out[7];
                                
assign  ram_raddr_out0_in[3]    =   ram_raddr_in3_out[0];
assign  ram_raddr_out1_in[3]    =   ram_raddr_in3_out[1];
assign  ram_raddr_out2_in[3]    =   ram_raddr_in3_out[2];
assign  ram_raddr_out3_in[3]    =   ram_raddr_in3_out[3];
assign  ram_raddr_out4_in[3]    =   ram_raddr_in3_out[4];
assign  ram_raddr_out5_in[3]    =   ram_raddr_in3_out[5];
assign  ram_raddr_out6_in[3]    =   ram_raddr_in3_out[6];
assign  ram_raddr_out7_in[3]    =   ram_raddr_in3_out[7];
                                
assign  ram_raddr_out0_in[4]    =   ram_raddr_in4_out[0];
assign  ram_raddr_out1_in[4]    =   ram_raddr_in4_out[1];
assign  ram_raddr_out2_in[4]    =   ram_raddr_in4_out[2];
assign  ram_raddr_out3_in[4]    =   ram_raddr_in4_out[3];
assign  ram_raddr_out4_in[4]    =   ram_raddr_in4_out[4];
assign  ram_raddr_out5_in[4]    =   ram_raddr_in4_out[5];
assign  ram_raddr_out6_in[4]    =   ram_raddr_in4_out[6];
assign  ram_raddr_out7_in[4]    =   ram_raddr_in4_out[7];
                                
assign  ram_raddr_out0_in[5]    =   ram_raddr_in5_out[0];
assign  ram_raddr_out1_in[5]    =   ram_raddr_in5_out[1];
assign  ram_raddr_out2_in[5]    =   ram_raddr_in5_out[2];
assign  ram_raddr_out3_in[5]    =   ram_raddr_in5_out[3];
assign  ram_raddr_out4_in[5]    =   ram_raddr_in5_out[4];
assign  ram_raddr_out5_in[5]    =   ram_raddr_in5_out[5];
assign  ram_raddr_out6_in[5]    =   ram_raddr_in5_out[6];
assign  ram_raddr_out7_in[5]    =   ram_raddr_in5_out[7];

assign  ram_raddr_out0_in[6]    =   ram_raddr_in6_out[0];
assign  ram_raddr_out1_in[6]    =   ram_raddr_in6_out[1];
assign  ram_raddr_out2_in[6]    =   ram_raddr_in6_out[2];
assign  ram_raddr_out3_in[6]    =   ram_raddr_in6_out[3];
assign  ram_raddr_out4_in[6]    =   ram_raddr_in6_out[4];
assign  ram_raddr_out5_in[6]    =   ram_raddr_in6_out[5];
assign  ram_raddr_out6_in[6]    =   ram_raddr_in6_out[6];
assign  ram_raddr_out7_in[6]    =   ram_raddr_in6_out[7];

assign  ram_raddr_out0_in[7]    =   ram_raddr_in7_out[0];
assign  ram_raddr_out1_in[7]    =   ram_raddr_in7_out[1];
assign  ram_raddr_out2_in[7]    =   ram_raddr_in7_out[2];
assign  ram_raddr_out3_in[7]    =   ram_raddr_in7_out[3];
assign  ram_raddr_out4_in[7]    =   ram_raddr_in7_out[4];
assign  ram_raddr_out5_in[7]    =   ram_raddr_in7_out[5];
assign  ram_raddr_out6_in[7]    =   ram_raddr_in7_out[6];
assign  ram_raddr_out7_in[7]    =   ram_raddr_in7_out[7];

                                
assign  ram_dout_in0_out[0]     =   ram_dout_out0_in[0];
assign  ram_dout_in1_out[0]     =   ram_dout_out0_in[1];
assign  ram_dout_in2_out[0]     =   ram_dout_out0_in[2];
assign  ram_dout_in3_out[0]     =   ram_dout_out0_in[3];
assign  ram_dout_in4_out[0]     =   ram_dout_out0_in[4];
assign  ram_dout_in5_out[0]     =   ram_dout_out0_in[5];
assign  ram_dout_in6_out[0]     =   ram_dout_out0_in[6];
assign  ram_dout_in7_out[0]     =   ram_dout_out0_in[7];
                                
assign  ram_dout_in0_out[1]     =   ram_dout_out1_in[0];
assign  ram_dout_in1_out[1]     =   ram_dout_out1_in[1];
assign  ram_dout_in2_out[1]     =   ram_dout_out1_in[2];
assign  ram_dout_in3_out[1]     =   ram_dout_out1_in[3];
assign  ram_dout_in4_out[1]     =   ram_dout_out1_in[4];
assign  ram_dout_in5_out[1]     =   ram_dout_out1_in[5];
assign  ram_dout_in6_out[1]     =   ram_dout_out1_in[6];
assign  ram_dout_in7_out[1]     =   ram_dout_out1_in[7];
                                
assign  ram_dout_in0_out[2]     =   ram_dout_out2_in[0];
assign  ram_dout_in1_out[2]     =   ram_dout_out2_in[1];
assign  ram_dout_in2_out[2]     =   ram_dout_out2_in[2];
assign  ram_dout_in3_out[2]     =   ram_dout_out2_in[3];
assign  ram_dout_in4_out[2]     =   ram_dout_out2_in[4];
assign  ram_dout_in5_out[2]     =   ram_dout_out2_in[5];
assign  ram_dout_in6_out[2]     =   ram_dout_out2_in[6];
assign  ram_dout_in7_out[2]     =   ram_dout_out2_in[7];
                                
assign  ram_dout_in0_out[3]     =   ram_dout_out3_in[0];
assign  ram_dout_in1_out[3]     =   ram_dout_out3_in[1];
assign  ram_dout_in2_out[3]     =   ram_dout_out3_in[2];
assign  ram_dout_in3_out[3]     =   ram_dout_out3_in[3];
assign  ram_dout_in4_out[3]     =   ram_dout_out3_in[4];
assign  ram_dout_in5_out[3]     =   ram_dout_out3_in[5];
assign  ram_dout_in6_out[3]     =   ram_dout_out3_in[6];
assign  ram_dout_in7_out[3]     =   ram_dout_out3_in[7];

                                
assign  ram_dout_in0_out[4]     =   ram_dout_out4_in[0];
assign  ram_dout_in1_out[4]     =   ram_dout_out4_in[1];
assign  ram_dout_in2_out[4]     =   ram_dout_out4_in[2];
assign  ram_dout_in3_out[4]     =   ram_dout_out4_in[3];
assign  ram_dout_in4_out[4]     =   ram_dout_out4_in[4];
assign  ram_dout_in5_out[4]     =   ram_dout_out4_in[5];
assign  ram_dout_in6_out[4]     =   ram_dout_out4_in[6];
assign  ram_dout_in7_out[4]     =   ram_dout_out4_in[7];
                                
assign  ram_dout_in0_out[5]     =   ram_dout_out5_in[0];
assign  ram_dout_in1_out[5]     =   ram_dout_out5_in[1];
assign  ram_dout_in2_out[5]     =   ram_dout_out5_in[2];
assign  ram_dout_in3_out[5]     =   ram_dout_out5_in[3];
assign  ram_dout_in4_out[5]     =   ram_dout_out5_in[4];
assign  ram_dout_in5_out[5]     =   ram_dout_out5_in[5];
assign  ram_dout_in6_out[5]     =   ram_dout_out5_in[6];
assign  ram_dout_in7_out[5]     =   ram_dout_out5_in[7];

assign  ram_dout_in0_out[6]     =   ram_dout_out6_in[0];
assign  ram_dout_in1_out[6]     =   ram_dout_out6_in[1];
assign  ram_dout_in2_out[6]     =   ram_dout_out6_in[2];
assign  ram_dout_in3_out[6]     =   ram_dout_out6_in[3];
assign  ram_dout_in4_out[6]     =   ram_dout_out6_in[4];
assign  ram_dout_in5_out[6]     =   ram_dout_out6_in[5];
assign  ram_dout_in6_out[6]     =   ram_dout_out6_in[6];
assign  ram_dout_in7_out[6]     =   ram_dout_out6_in[7];

assign  ram_dout_in0_out[7]     =   ram_dout_out7_in[0];
assign  ram_dout_in1_out[7]     =   ram_dout_out7_in[1];
assign  ram_dout_in2_out[7]     =   ram_dout_out7_in[2];
assign  ram_dout_in3_out[7]     =   ram_dout_out7_in[3];
assign  ram_dout_in4_out[7]     =   ram_dout_out7_in[4];
assign  ram_dout_in5_out[7]     =   ram_dout_out7_in[5];
assign  ram_dout_in6_out[7]     =   ram_dout_out7_in[6];
assign  ram_dout_in7_out[7]     =   ram_dout_out7_in[7];

generate
    genvar i;
    for(i=0;i<8;i=i+1)
    begin:INST_RX_TM
        assign  rst[i]                  =   rst_156m[i] | (~channel_up[i]);
        assign  fifo_rden[i]            =   {tx_fifo_rden[7][i],tx_fifo_rden[6][i],
                                            tx_fifo_rden[5][i],tx_fifo_rden[4][i],
                                            tx_fifo_rden[3][i],tx_fifo_rden[2][i],
                                            tx_fifo_rden[1][i],tx_fifo_rden[0][i]};
        assign  pkt_rdy_out[i]          =   {pkt_rdy_in[7][i],pkt_rdy_in[6][i],
                                            pkt_rdy_in[5][i],pkt_rdy_in[4][i],
                                            pkt_rdy_in[3][i],pkt_rdy_in[2][i],
                                            pkt_rdy_in[1][i],pkt_rdy_in[0][i]};
        
        pkt_rx_tm u0_pkt_rx_tm(
            .clk                        ( clk_156m[i]               ),
            .rst                        ( rst[i]                    ),
            .clk_out                    ( clk_200m                  ),
            
            .rx_data                    ( rx_data[i]                ),
            .rx_rem                     ( rx_rem[i]                 ),
            .rx_sof_n                   ( rx_sof_n[i]               ),
            .rx_eof_n                   ( rx_eof_n[i]               ),
            .rx_src_rdy_n               ( rx_src_rdy_n[i]           ),
            
            .fifo_rden                  ( fifo_rden[i]              ),
            .fifo_dout_out0             ( fifo_dout_out0_in[i]      ),
            .fifo_dout_out1             ( fifo_dout_out1_in[i]      ),
            .fifo_dout_out2             ( fifo_dout_out2_in[i]      ),
            .fifo_dout_out3             ( fifo_dout_out3_in[i]      ),
            .fifo_dout_out4             ( fifo_dout_out4_in[i]      ),
            .fifo_dout_out5             ( fifo_dout_out5_in[i]      ),
            .fifo_dout_out6             ( fifo_dout_out6_in[i]      ),
            .fifo_dout_out7             ( fifo_dout_out7_in[i]      ),
            .pkt_rdy                    ( pkt_rdy_in[i]             ),
            
            .ram_raddr_out0             ( ram_raddr_out0_in[i]      ),
            .ram_raddr_out1             ( ram_raddr_out1_in[i]      ),
            .ram_raddr_out2             ( ram_raddr_out2_in[i]      ),
            .ram_raddr_out3             ( ram_raddr_out3_in[i]      ),
            .ram_raddr_out4             ( ram_raddr_out4_in[i]      ),
            .ram_raddr_out5             ( ram_raddr_out5_in[i]      ),
            .ram_raddr_out6             ( ram_raddr_out6_in[i]      ),
            .ram_raddr_out7             ( ram_raddr_out7_in[i]      ),
            
            .ram_dout_out0              ( ram_dout_out0_in[i]       ),
            .ram_dout_out1              ( ram_dout_out1_in[i]       ),
            .ram_dout_out2              ( ram_dout_out2_in[i]       ),
            .ram_dout_out3              ( ram_dout_out3_in[i]       ),
            .ram_dout_out4              ( ram_dout_out4_in[i]       ),
            .ram_dout_out5              ( ram_dout_out5_in[i]       ),
            .ram_dout_out6              ( ram_dout_out6_in[i]       ),
            .ram_dout_out7              ( ram_dout_out7_in[i]       )
            );
            
        pkt_tx_tm u0_pkt_tx_tm(
            .clk                        ( clk_200m                  ),
            .rst                        ( rst[i]                    ),
            .clk_gtx                    ( clk_156m[i]               ),
            
            .fifo_rden                  ( tx_fifo_rden[i]           ),
            .fifo_dout_in0              ( fifo_dout_in0_out[i]      ),
            .fifo_dout_in1              ( fifo_dout_in1_out[i]      ),
            .fifo_dout_in2              ( fifo_dout_in2_out[i]      ),
            .fifo_dout_in3              ( fifo_dout_in3_out[i]      ),
            .fifo_dout_in4              ( fifo_dout_in4_out[i]      ),
            .fifo_dout_in5              ( fifo_dout_in5_out[i]      ),
            .fifo_dout_in6              ( fifo_dout_in6_out[i]      ),
            .fifo_dout_in7              ( fifo_dout_in7_out[i]      ),
            .pkt_rdy                    ( pkt_rdy_out[i]            ),
            
            .ram_raddr_in0              ( ram_raddr_in0_out[i]      ),
            .ram_raddr_in1              ( ram_raddr_in1_out[i]      ),
            .ram_raddr_in2              ( ram_raddr_in2_out[i]      ),
            .ram_raddr_in3              ( ram_raddr_in3_out[i]      ),
            .ram_raddr_in4              ( ram_raddr_in4_out[i]      ),
            .ram_raddr_in5              ( ram_raddr_in5_out[i]      ),
            .ram_raddr_in6              ( ram_raddr_in6_out[i]      ),
            .ram_raddr_in7              ( ram_raddr_in7_out[i]      ),
            
            .ram_dout_in0               ( ram_dout_in0_out[i]       ),
            .ram_dout_in1               ( ram_dout_in1_out[i]       ),
            .ram_dout_in2               ( ram_dout_in2_out[i]       ),
            .ram_dout_in3               ( ram_dout_in3_out[i]       ),
            .ram_dout_in4               ( ram_dout_in4_out[i]       ),
            .ram_dout_in5               ( ram_dout_in5_out[i]       ),
            .ram_dout_in6               ( ram_dout_in6_out[i]       ),
            .ram_dout_in7               ( ram_dout_in7_out[i]       ),
            
            .tx_data                    ( tx_data[i]                ),
            .tx_rem                     ( tx_rem[i]                 ),
            .tx_sof_n                   ( tx_sof_n[i]               ),
            .tx_eof_n                   ( tx_eof_n[i]               ),
            .tx_src_rdy_n               ( tx_src_rdy_n[i]           ),
            .tx_dst_rdy_n               ( tx_dst_rdy_n[i]           )
            );           
    end
endgenerate

endmodule
