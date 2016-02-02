/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_gen.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-10-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_gen.v
    File tree    :   ts_gen.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_gen(
    rst                         ,
    clk                         ,   
    ts_sync                     ,
    ts_valid                    ,
    ts_data
    );

parameter   U_DLY                       = 1                         ;
parameter   PKT_INTERVAL                = 100                       ;
parameter   ADAPT_FIELD_CTRL            = 2'b11                     ;   //or 2'b10
parameter   ADAPT_FIELD_LEN             = 8'h10                     ;

input                                   rst                         ;
input                                   clk                         ;

output                                  ts_sync                     ;
output                                  ts_valid                    ;
output  [7:0]                           ts_data                     ;

reg     [11:0]                          byte_cnt                    ;
reg                                     ts_sync                     ;
reg                                     ts_valid                    ;
reg     [7:0]                           ts_data                     ;

reg     [3:0]                           ts_cc                       ;
reg     [7:0]                           pkt_cnt                     ;
reg     [32:0]                          pcr_base                    ;
reg     [8:0]                           pcr_ext                     ;

reg     [7:0]                           ts_data_reg                 ;
reg     [7:0]                           ts_data_reg_1dly            ;
reg     [7:0]                           ts_data_reg_2dly            ;
reg     [7:0]                           ts_data_reg_3dly            ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  12'h000;
    end
    else if((byte_cnt > PKT_INTERVAL) && (byte_cnt - PKT_INTERVAL>=375))
    begin
        byte_cnt    <=  12'h001;  
    end
    else
    begin
        byte_cnt    <=  byte_cnt + 12'h001;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_valid    <=  1'b0;
    end
    else if((byte_cnt > PKT_INTERVAL) && (byte_cnt % 2 == 1))
    begin
        ts_valid    <=  1'b1;
    end
    else
    begin
        ts_valid    <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_cc   <=  4'h0;
    end
    else if(byte_cnt==12'h001)
    begin
        ts_cc   <=  ts_cc + 4'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_cnt <=  8'h00;
    end
    else if(byte_cnt==12'h001)
    begin
        pkt_cnt <=  pkt_cnt + 8'h01;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_sync <=  1'b0;
    end
    else if(byte_cnt==PKT_INTERVAL + 1)
    begin
        ts_sync <=  1'b1;
    end
    else
    begin
        ts_sync <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_base    <=  {33{1'b0}};
        pcr_ext     <=  {9{1'b0}};
    end
    else if(pkt_cnt<17)
    begin
        pcr_base    <=  {{32{1'b0}},1'b1};
        pcr_ext     <=  {8'h00,1'b1};
    end
    else if(pkt_cnt<33)
    begin
        pcr_base    <=  33'd9;
        pcr_ext     <=  9'd9;
    end
    else if(pkt_cnt<49)
    begin
        pcr_base    <=  33'd20;
        pcr_ext     <=  9'd20;
    end
    else
    begin
        pcr_base    <=  {33{1'b1}};
        pcr_ext     <=  {9{1'b1}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_data_reg <=  8'h00;
    end
    else
    begin
        if(byte_cnt > PKT_INTERVAL)
        begin
            case(byte_cnt - PKT_INTERVAL)
                12'd1:  ts_data_reg <=  8'h47;
                12'd3:  ts_data_reg <=  8'h00;
                12'd5:  ts_data_reg <=  {4'h0,ts_cc[3:0]};                      //ts_pid
                12'd7:  ts_data_reg <=  {2'b00,ADAPT_FIELD_CTRL,ts_cc[3:0]};
                12'd9:  ts_data_reg <=  ADAPT_FIELD_LEN;
                12'd11: ts_data_reg <=  {3'b000,1'b1,4'h0};                     //pcr_flag  
                12'd13: ts_data_reg <=  pcr_base[32:25];
                12'd15: ts_data_reg <=  pcr_base[24:17];
                12'd17: ts_data_reg <=  pcr_base[16:9];
                12'd19: ts_data_reg <=  pcr_base[8:1];
                12'd21: ts_data_reg <=  {pcr_base[0],{6{1'b0}},pcr_ext[8]};
                12'd23: ts_data_reg <=  pcr_ext[7:0]; 
                default:ts_data_reg <=  8'h00;
            endcase
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_data_reg_1dly    <=  8'h00;
        ts_data_reg_1dly    <=  8'h00;
        ts_data_reg_1dly    <=  8'h00;
        ts_data             <=  8'h00;
    end
    else
    begin
        ts_data_reg_1dly    <=  ts_data_reg;
        ts_data_reg_2dly    <=  ts_data_reg_1dly;  
        ts_data_reg_3dly    <=  ts_data_reg_2dly;  
        ts_data             <=  ts_data_reg_3dly;  
    end
end
 
endmodule
