/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   scrambler_ts_gen.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-03-04  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   scrambler_ts_gen.v
    File tree    :   scrambler_ts_gen.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_gen8(
    rst                         ,
    clk                         ,   
    ts_sync                     ,
    ts_valid                    ,
    ts_eop                      ,
    ts_data
    );

parameter   U_DLY                       = 1                         ;
parameter   PKT_INTERVAL                = 125000000                 ;
parameter   ADAPT_FIELD_CTRL            = 2'b01                     ;   //only payload
parameter   ADAPT_FIELD_LEN             = 8'h10                     ;

input                                   rst                         ;
input                                   clk                         ;

output                                  ts_sync                     ;
output                                  ts_valid                    ;
output                                  ts_eop                      ;
output  [7:0]                           ts_data                     ;

reg     [31:0]                          byte_cnt                    ;
wire                                    ts_sync                     ;
wire                                    ts_valid                    ;
reg     [7:0]                           ts_data                     ;
wire                                    ts_eop                      ;

reg     [3:0]                           ts_cc                       ;
reg     [7:0]                           pkt_cnt                     ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  {32{1'b0}};
    end
    else if(byte_cnt >187 + PKT_INTERVAL)
    begin
        byte_cnt    <=  {{31{1'b0}},1'b1};  
    end
    else
    begin
        byte_cnt    <=  byte_cnt + 'h1;
    end
end

assign  ts_valid    = ((byte_cnt>=1) && (byte_cnt<=188)) ? 1'b1 : 1'b0;
assign  ts_sync     = (byte_cnt==1) ? 1'b1 : 1'b0;
assign  ts_eop      = (byte_cnt==188) ? 1'b1 : 1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_cc   <=  4'h0;
    end
    else if(byte_cnt==1)
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
    else if(byte_cnt==1)
    begin
        pkt_cnt <=  pkt_cnt + 8'h01;
    end
end

always@*
begin
    if(ts_valid==1'b1)
    begin
        case(byte_cnt)
        32'd1:  ts_data =   8'h47;
        32'd2:  ts_data =   8'h00;
        32'd3:  ts_data =   8'h14;  //ts_pid
        32'd4:  ts_data =   {2'b00,ADAPT_FIELD_CTRL,ts_cc[3:0]};
        default:ts_data =   {4'h0,byte_cnt[7:0]} - 12'd4;
        endcase
    end
    else
    begin
        ts_data =   8'h00;
    end
end
 
endmodule
