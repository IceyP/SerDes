/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_buf.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-14  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_buf.v
    File tree    :   ts_buf.v
                        +---asyn_fifo.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_buf(
    rst                         ,                                       //in  : reset
    clk                         ,                                       //in  : clock 125MHz
    
    ts_in                       ,
    ts_in_valid                 ,
    
    ts_rd_sync                  ,                                       //in  : from J.83,require output 0x47
    ts_rd_req                   ,                                       //in  : from J.83
    
    has_frame                   ,                                       //out : at least one packet in buf
    ts_rd_out                   ,                                       //out : to J.83
    
    //for debug,clk clock domain
    port_bp
    );

parameter   U_DLY                       = 1                         ;   //Unit
parameter   BUF_DEPTH_BIT               = 11                        ;

input                                   rst                         ;
input                                   clk                         ;

input   [7:0]                           ts_in                       ;
input                                   ts_in_valid                 ;

input                                   ts_rd_sync                  ;
input                                   ts_rd_req                   ;

output                                  has_frame                   ;
output  [7:0]                           ts_rd_out                   ;

output                                  port_bp                     ;

reg                                     fifo_wr_en                  ;
reg     [7:0]                           ts_in_1dly                  ;

reg                                     has_frame                   ;
reg                                     port_bp                     ;
reg                                     ts_rd_req_1dly              ;

wire    [7:0]                           ts_rd_out                   ;
wire    [7:0]                           fifo_din                    ;
wire    [7:0]                           fifo_dout                   ;

wire                                    fifo_full                   ;
wire    [BUF_DEPTH_BIT - 1 : 0]         data_count                  ;
reg                                     fifo_rd_en                  ;

assign  fifo_din            = ts_in_1dly[7:0];
assign  ts_rd_out           = fifo_dout[7:0];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_in_1dly          <=  8'h00;
    end
    else if(ts_in_valid==1'b1)
    begin
        ts_in_1dly          <=  #U_DLY ts_in;
    end
    else
    begin
        ts_in_1dly          <=  #U_DLY 8'h00;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_wr_en          <=  1'b0;
    end
    else if(ts_in_valid==1'b1)
    begin
        fifo_wr_en          <=  #U_DLY 1'b1;
    end
    else
    begin
        fifo_wr_en          <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_rd_req_1dly  <=  1'b0;
    end
    else
    begin
        ts_rd_req_1dly  <=  #U_DLY ts_rd_req;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        has_frame   <=  1'b0;
    end
    else if(ts_rd_sync==1'b1)
    begin
        if(data_count>=186)
        begin
            has_frame   <=  #U_DLY 1'b1;
        end
        else
        begin
            has_frame   <=  #U_DLY 1'b0;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_rd_en  <=  1'b0;
    end
    else if(has_frame==1'b1)
    begin
        fifo_rd_en  <=  #U_DLY ts_rd_req_1dly;
    end
    else
    begin
        fifo_rd_en  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        port_bp     <=  1'b0;
    end
    else if((data_count>2000) || (fifo_full==1'b1))
    begin
        port_bp     <=  #U_DLY 1'b1;
    end
    else
    begin
        port_bp     <=  #U_DLY 1'b0;
    end
end

//width:8bit,depth:2048,use 1 M18K block ram,read latency=2   
asyn_fifo u_asyn_fifo(
    .rst                                ( rst                       ),
    .clk                                ( clk                       ),
    .din                                ( fifo_din                  ),
    .wr_en                              ( fifo_wr_en                ),
    .rd_en                              ( fifo_rd_en                ),
    .dout                               ( fifo_dout                 ),
    .full                               ( fifo_full                 ),
    .empty                              ( fifo_empty                ),
    .data_count                         ( data_count                )
    );
    
endmodule
