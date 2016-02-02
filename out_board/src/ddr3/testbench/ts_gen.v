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
    2012-08-10  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_gen.v
    File tree    :   ts_gen.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_gen(
    clk                         ,
    rst                         ,
    memc_init_done              , 
    ts_data                     ,
    ts_valid                    ,
    ts_start                    ,
    ts_end                    
    );

parameter   U_DLY                       = 1                         ;

input                                   clk                         ;
input                                   rst                         ;
input                                   memc_init_done              ;
output   [31:0]                         ts_data                     ;
output                                  ts_valid                    ;
output                                  ts_start                    ;
output                                  ts_end                      ;

wire                                    sys_rst                     ;

reg      [31:0]                         ts_data                     ;
reg                                     ts_valid                    ;
reg                                     ts_start                    ;
reg                                     ts_end                      ;

reg     [7:0]                           byte_cnt                    ;
reg     [3:0]                           channel_num                 ;
reg     [7:0]                           data_cnt                    ;
reg     [7:0]                           pkt_num                     ;
wire    [7:0]                           data_reg0                   ;
wire    [7:0]                           data_reg1                   ;
wire    [7:0]                           data_reg2                   ;
wire    [7:0]                           data_reg3                   ;

assign  data_reg0   =   (data_cnt[7:0]-8'h01)*4-8'h01;
assign  data_reg1   =   (data_cnt[7:0]-8'h01)*4;
assign  data_reg2   =   (data_cnt[7:0]-8'h01)*4+8'h01;
assign  data_reg3   =   (data_cnt[7:0]-8'h01)*4+8'h02;


assign  sys_rst =   ~memc_init_done | rst;

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if(byte_cnt>=48)
    begin
        byte_cnt    <=  #U_DLY 8'h01;
    end
    else 
    begin
        byte_cnt    <=  #U_DLY byte_cnt + 8'h01;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        ts_data <=  {32{1'b0}};
    end
    else
    begin
        case(byte_cnt)
        8'h01:      ts_data <=  #U_DLY {{28{1'b0}},channel_num[3:0]};
        8'h02:      ts_data <=  #U_DLY {8'h47,pkt_num[7:0],8'h01,8'h02};
        default:    ts_data <=  #U_DLY {data_reg0[7:0],data_reg1[7:0],data_reg2[7:0],data_reg3[7:0]};
        endcase
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        ts_valid    <=  1'b0;
    end
    else if(byte_cnt>0)
    begin
        ts_valid    <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_valid    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        ts_start    <=  1'b0;
    end
    else if(byte_cnt==1)
    begin
        ts_start    <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_start    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        ts_end      <=  1'b0;
    end
    else if(byte_cnt==48)
    begin
        ts_end      <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_end      <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        channel_num <=  4'h5;
    end
    else if(byte_cnt>=48)
    begin
        channel_num <=  #U_DLY channel_num + 4'h1;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        data_cnt    <=  8'h00;
    end
    else if(byte_cnt==1)
    begin
        data_cnt    <=  #U_DLY 8'h01;
    end
    else if(byte_cnt>0)
    begin
        data_cnt    <=  #U_DLY data_cnt + 8'h01;
    end
end

always@(posedge clk or posedge sys_rst)
begin
    if(sys_rst==1'b1)
    begin
        pkt_num     <=  8'h00;
    end
    else if(byte_cnt==1)
    begin
        pkt_num     <=  #U_DLY pkt_num + 8'h01;
    end
end

endmodule
