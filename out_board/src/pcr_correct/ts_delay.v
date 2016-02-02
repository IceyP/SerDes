/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_delay.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-10-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_delay.v
    File tree    :   ts_delay.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_delay(
    rst                         ,
    clk                         ,   
    ts_sync                     ,
    ts_valid                    ,
    ts_data                     ,
    pcr_correct_data            ,
    pcr_correct_ac_ena          ,
    
    ts_o_sync                   ,
    ts_o_valid                  ,
    ts_o_data
    );

parameter   U_DLY                       = 1                         ;

input                                   rst                         ;
input                                   clk                         ;

input                                   ts_sync                     ;
input                                   ts_valid                    ;
input   [7:0]                           ts_data                     ;

input   [41:0]                          pcr_correct_data            ;
input                                   pcr_correct_ac_ena          ;

output                                  ts_o_sync                   ;
output                                  ts_o_valid                  ;
output  [7:0]                           ts_o_data                   ;

wire    [7:0]                           ts_i_data                   ;
reg                                     ts_i_sync                   ;
reg                                     ts_i_valid                  ;

reg                                     ts_sync_1dly                ;
reg                                     ts_sync_2dly                ;
reg                                     ts_sync_3dly                ;
reg                                     ts_valid_1dly               ;
reg                                     ts_valid_2dly               ;
reg                                     ts_valid_3dly               ;

wire    [8:0]                           fifo_wdata                  ;
reg                                     fifo_rden                   ;
wire    [8:0]                           fifo_dout                   ;

reg                                     fifo_rden_1dly              ;
reg                                     fifo_rden_2dly              ;

reg     [7:0]                           byte_cnt                    ;
reg     [1:0]                           adapt_field_ctrl            ;
reg     [7:0]                           adapt_field_len             ;
reg                                     pcr_flag                    ;
wire                                    is_pcr                      ;
wire                                    pcr_correct_valid           ;

reg                                     ts_o_valid                  ;
reg                                     ts_o_sync                   ;
reg     [7:0]                           ts_o_data                   ;
wire    [10:0]                          data_count                  ;

assign  ts_i_data   =   ts_data;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_sync_1dly    <=  1'b0;
        ts_sync_2dly    <=  1'b0;
        ts_sync_3dly    <=  1'b0;
        ts_i_sync       <=  1'b0;
        ts_valid_1dly   <=  1'b0;
        ts_valid_2dly   <=  1'b0;
        ts_valid_3dly   <=  1'b0;
        ts_i_valid      <=  1'b0;
    end
    else
    begin
        ts_sync_1dly    <=  ts_sync;
        ts_sync_2dly    <=  ts_sync_1dly;
        ts_sync_3dly    <=  ts_sync_2dly;
        ts_i_sync       <=  ts_sync_3dly;
        ts_valid_1dly   <=  ts_valid;
        ts_valid_2dly   <=  ts_valid_1dly;
        ts_valid_3dly   <=  ts_valid_2dly;
        ts_i_valid      <=  ts_valid_3dly;
    end 
end 

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_rden   <=  1'b0;
    end
    else if(data_count>120)
    begin
        fifo_rden   <=  1'b1;
    end
    else
    begin
        fifo_rden   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if((fifo_rden_2dly & fifo_dout[8])==1'b1)
    begin
        byte_cnt    <=  8'h01;
    end
    else if((byte_cnt>=187) && (fifo_rden_2dly==1'b1))
    begin
        byte_cnt    <=  8'h00;
    end
    else if((fifo_rden_2dly==1'b1) && (byte_cnt>0))
    begin
        byte_cnt    <=  byte_cnt + 8'h01;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        adapt_field_ctrl    <=  2'b00;
        adapt_field_len     <=  8'h00;
        pcr_flag            <=  1'b0;
    end
    else if(fifo_rden_2dly==1'b1)
    begin
        case(byte_cnt)
            8'h03:  adapt_field_ctrl<=  fifo_dout[5:4];
            8'h04:  adapt_field_len <=  fifo_dout;
            8'h05:  pcr_flag        <=  fifo_dout[4];
            default:;
        endcase
    end
end

assign  is_pcr              =   ((adapt_field_ctrl[1]==1'b1) &&
                                (|adapt_field_len==1'b1) && (pcr_flag==1'b1))    ?   1'b1    :   1'b0;
assign  pcr_correct_valid   =   ((byte_cnt>5) && (byte_cnt<12) && (is_pcr==1'b1))?   1'b1    :   1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_o_data   <=  8'h00;
    end
    else if((pcr_correct_valid==1'b1) && (pcr_correct_ac_ena==1'b1))
    begin
        case(byte_cnt)
        8'h06:      ts_o_data   <=   pcr_correct_data[41:34];
        8'h07:      ts_o_data   <=   pcr_correct_data[33:26];
        8'h08:      ts_o_data   <=   pcr_correct_data[25:18];   
        8'h09:      ts_o_data   <=   pcr_correct_data[17:10]; 
        8'h0a:      ts_o_data   <=   {pcr_correct_data[9],{6{1'b1}},pcr_correct_data[8]};
        8'h0b:      ts_o_data   <=   pcr_correct_data[7:0];   
        default:    ts_o_data   <=   8'h00;
        endcase
    end
    else
    begin
        ts_o_data   <=   fifo_dout[7:0];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_o_sync   <=  1'b0;
    end
    else
    begin
        ts_o_sync   <=  fifo_rden_2dly & fifo_dout[8];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_rden_1dly  <=  1'b0;
        fifo_rden_2dly  <=  1'b0;
        ts_o_valid      <=  1'b0;
    end
    else
    begin
        fifo_rden_1dly  <=  fifo_rden;
        fifo_rden_2dly  <=  fifo_rden_1dly;
        ts_o_valid      <=  fifo_rden_2dly;
    end
end
                
////////////////////////////////////////////////////////////////////          
assign  fifo_wdata  =   {ts_i_sync,ts_i_data[7:0]};

//width:9bit,depth:2048,output latency:2,M18K blockram:1,read latency = 2
ts_dly_fifo u0_ts_dly_fifo(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .din                                ( fifo_wdata                ),
    .wr_en                              ( ts_i_valid                ),
    .rd_en                              ( fifo_rden                 ),
    .dout                               ( fifo_dout                 ),
    .full                               ( /*not used*/              ),
    .empty                              ( /*not used*/              ),
    .data_count                         ( data_count                )
    );
          
endmodule
