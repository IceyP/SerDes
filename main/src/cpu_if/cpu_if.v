/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  cpu_if.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  cpu_if.v
    File tree    :  cpu_if.v                        
\************************************************************************************/

`timescale 1ns/1ps

module cpu_if(
    clk                         ,
    rst                         ,
    test_rx_d0                  ,
    test_rx_d1                  ,
    test_rx_d2                  ,
    test_rx_d3                  ,
    data_err_cnt                ,
    link_err_cnt                ,
    //local bus
    lbus_addr                   ,
    lbus_data                   ,
    lbus_cs_n                   ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    lbus_int                    ,
    lbus_wait_n                 ,
    led_ctrl                    ,
    gtx_loopback
    );

input                                   clk                         ;
input                                   rst                         ;
input   [15:0]                          test_rx_d0                  ;
input   [15:0]                          test_rx_d1                  ;
input   [15:0]                          test_rx_d2                  ;
input   [15:0]                          test_rx_d3                  ;
input   [15:0]                          data_err_cnt                ;
input   [15:0]                          link_err_cnt                ;
//local bus
input   [11:0]                          lbus_addr                   ;
inout   [15:0]                          lbus_data                   ;
input                                   lbus_cs_n                   ;
input                                   lbus_oe_n                   ;
input                                   lbus_we_n                   ;
output  [2:0]                           lbus_int                    ;
output                                  lbus_wait_n                 ;
output  [15:0]                          led_ctrl                    ;
output  [2:0]                           gtx_loopback                ;

reg                                     lbus_cs_n_1dly              ;
reg                                     lbus_oe_n_1dly              ;
reg                                     lbus_we_n_1dly              ;
reg                                     lbus_cs_n_2dly              ;
reg                                     lbus_oe_n_2dly              ;
reg                                     lbus_we_n_2dly              ;
wire                                    negedge_lbus_we_n           ;
wire                                    negedge_lbus_oe_n           ;
reg     [15:0]                          wdata_test                  ;
reg     [15:0]                          lbus_rdata                  ;
reg     [15:0]                          led_ctrl                    ;
reg     [2:0]                           gtx_loopback                ;

assign  lbus_wait_n =   1'b1;
assign  lbus_int    =   3'b000;
    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        lbus_cs_n_1dly  <=  1'b1;
        lbus_oe_n_1dly  <=  1'b1;
        lbus_we_n_1dly  <=  1'b1;
        lbus_cs_n_2dly  <=  1'b1;
        lbus_oe_n_2dly  <=  1'b1;
        lbus_we_n_2dly  <=  1'b1;
    end
    else
    begin
        lbus_cs_n_1dly  <=  lbus_cs_n;
        lbus_oe_n_1dly  <=  lbus_oe_n;
        lbus_we_n_1dly  <=  lbus_we_n;
        lbus_cs_n_2dly  <=  lbus_cs_n_1dly;
        lbus_oe_n_2dly  <=  lbus_oe_n_1dly;
        lbus_we_n_2dly  <=  lbus_we_n_1dly;
    end
end

assign  negedge_lbus_we_n   =   (~lbus_we_n_1dly) & lbus_we_n_2dly;
assign  negedge_lbus_oe_n   =   (~lbus_oe_n_1dly) & lbus_oe_n_2dly;

//lbus_write
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        wdata_test  <=  16'h0000;
        led_ctrl    <=  16'h0000;
        gtx_loopback<=  3'b000;
    end
    else if(negedge_lbus_we_n==1'b1)
    begin
        case(lbus_addr)
        12'hFFF:    wdata_test  <=  lbus_data;
        12'h000:    led_ctrl    <=  lbus_data;
        12'h010:    gtx_loopback<=  lbus_data[2:0];
        default:;
        endcase
    end
end

//lbus_read       
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        lbus_rdata  <=  16'h0000;
    end
    else if(negedge_lbus_oe_n==1'b1)
    begin
        case(lbus_addr)
        12'h001:    lbus_rdata  <=  16'h55aa;
        12'h002:    lbus_rdata  <=  test_rx_d0[15:0];
        12'h003:    lbus_rdata  <=  test_rx_d1[15:0];
        12'h004:    lbus_rdata  <=  test_rx_d2[15:0];
        12'h005:    lbus_rdata  <=  test_rx_d3[15:0];
        12'h006:    lbus_rdata  <=  data_err_cnt[15:0];
        12'h007:    lbus_rdata  <=  link_err_cnt[15:0];
        12'hFFF:    lbus_rdata  <=  ~wdata_test;
        default:;
        endcase
    end
end
        
assign  lbus_data   =   ((lbus_oe_n==1'b0) && (lbus_cs_n==1'b0))   ?   lbus_rdata  :   16'hzzzz;

endmodule
