/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   idlepkt_or_data_mux.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   idlepkt_or_data_mux.v
    File tree    :   idlepkt_or_data_mux.v
\************************************************************************************/

`timescale 1ns/100ps

module idlepkt_or_data_mux(
    rst                         ,                                       //in  : reset
    clk                         ,                                       //in  : clock
    
    ts_rd_sync                  ,                                       //in  : from J.83,require output 0x47
    ts_rd_req                   ,                                       //in  : from J.83
    
    tsbuf_has_frame             ,                                       //in  : signal from ts_buf
    tsbuf_mux_data              ,                                       //in  : ts data from ts_buf
    
    ts_out                                      
    );

parameter   U_DLY                       = 1                         ;   //Unit

input                                   rst                         ;
input                                   clk                         ;

input                                   ts_rd_sync                  ;
input                                   ts_rd_req                   ;

input                                   tsbuf_has_frame             ;
input   [7:0]                           tsbuf_mux_data              ;

output  [7:0]                           ts_out                      ;

reg     [7:0]                           ts_idle_pkt                 ;
reg     [7:0]                           byte_cnt                    ;
//reg     [3:0]                           counter                     ;
reg     [7:0]                           random_d                    ;

wire    [7:0]                           ts_out                      ;

reg                                     ts_idle_pkt_sync            ;
reg                                     tsbuf_has_frame_1dly        ;
reg                                     tsbuf_has_frame_2dly        ;
reg                                     tsbuf_has_frame_3dly        ;
reg                                     ts_rd_req_1dly              ;
reg                                     ts_rd_req_2dly              ;
reg                                     ts_rd_req_3dly              ;
reg                                     ts_rd_sync_1dly             ;
reg                                     ts_rd_sync_2dly             ;
reg                                     ts_rd_sync_3dly             ;

assign  ts_out              =   (tsbuf_has_frame_3dly==1'b1) ?   tsbuf_mux_data  :   ts_idle_pkt;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        tsbuf_has_frame_1dly    <=  1'b0;
        tsbuf_has_frame_2dly    <=  1'b0;
        tsbuf_has_frame_3dly    <=  1'b0;
    end
    else
    begin
        tsbuf_has_frame_1dly    <=  #U_DLY tsbuf_has_frame;
        tsbuf_has_frame_2dly    <=  #U_DLY tsbuf_has_frame_1dly;
        tsbuf_has_frame_3dly    <=  #U_DLY tsbuf_has_frame_2dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_rd_req_1dly    <=  1'b0;
        ts_rd_req_2dly    <=  1'b0;
        ts_rd_req_3dly    <=  1'b0;
    end
    else
    begin
        ts_rd_req_1dly    <=  #U_DLY ts_rd_req;
        ts_rd_req_2dly    <=  #U_DLY ts_rd_req_1dly;
        ts_rd_req_3dly    <=  #U_DLY ts_rd_req_2dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_rd_sync_1dly    <=  1'b0;
        ts_rd_sync_2dly    <=  1'b0;
        ts_rd_sync_3dly    <=  1'b0;
    end
    else
    begin
        ts_rd_sync_1dly    <=  #U_DLY ts_rd_sync;
        ts_rd_sync_2dly    <=  #U_DLY ts_rd_sync_1dly;
        ts_rd_sync_3dly    <=  #U_DLY ts_rd_sync_2dly;
    end
end
    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_idle_pkt_sync    <=  1'b0;
    end
    else if((tsbuf_has_frame_2dly==1'b0) && (ts_rd_req_3dly==1'b1) && (byte_cnt==8'd0))
    begin
        ts_idle_pkt_sync    <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_idle_pkt_sync    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if((byte_cnt==187) && (ts_rd_req_3dly==1'b1))
    begin
        byte_cnt    <=  #U_DLY 8'h00;
    end
    else if((ts_rd_sync_3dly==1'b1) && (tsbuf_has_frame_2dly==1'b0))
    begin
        byte_cnt    <=  #U_DLY 8'h01;
    end
    else if((tsbuf_has_frame_2dly==1'b0) && (ts_rd_req_3dly==1'b1))
    begin
        byte_cnt    <=  #U_DLY byte_cnt + 8'h01;
    end
end

//always@(posedge clk or posedge rst)
//begin
//    if(rst==1'b1)
//    begin
//        counter <=  4'h0;
//    end
//    else if((tsbuf_has_frame_2dly==1'b0) && (ts_rd_req_3dly==1'b1) && (byte_cnt==8'h02))
//    begin
//        counter <=  #U_DLY counter + 4'h1;
//    end
//end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        random_d    <=  8'h5a;
    end
    else
    begin
        random_d[7:4]   <=  random_d[6:3];
        random_d[3]     <=  random_d[7] ^ random_d[2];
        random_d[2]     <=  random_d[7] ^ random_d[1];
        random_d[1]     <=  random_d[0];
        random_d[0]     <=  random_d[7];
    end
end  

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_idle_pkt <=   8'h00;
    end
    else if((tsbuf_has_frame_2dly==1'b0) && (ts_rd_req_3dly==1'b1))
    begin
        case(byte_cnt)
            8'h00:      ts_idle_pkt <=   #U_DLY 8'h47;
            8'h01:      ts_idle_pkt <=   #U_DLY 8'h1f;
            8'h02:      ts_idle_pkt <=   #U_DLY 8'hff;
            //8'h03:      ts_idle_pkt <=   #U_DLY {4'h1,counter[3:0]};
            8'h03:      ts_idle_pkt <=   #U_DLY 8'h10;
            //default:    ts_idle_pkt <=   #U_DLY 8'h00;
            default:    ts_idle_pkt <=   #U_DLY random_d[7:0];
        endcase
    end
    else
    begin
        ts_idle_pkt <=   #U_DLY 8'h00;
    end
end

endmodule
