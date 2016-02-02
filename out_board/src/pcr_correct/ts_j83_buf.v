/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_j83_buf.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-11-08  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_j83_buf.v
    File tree    :   ts_j83_buf.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_j83_buf(
    rst                         ,
    clk                         , 
    clk_x2                      ,  
    ts_rd_valid                 ,    
    ts_i_valid                  ,
    ts_i_data                   ,
    ts_o_data
    );

parameter   RAM_WIDTH                   = 8                         ;
parameter   RAM_DEPTH_BIT               = 10                        ;

input                                   rst                         ;
input                                   clk                         ;
input                                   clk_x2                      ;

input                                   ts_rd_valid                 ;

input                                   ts_i_valid                  ;
input   [7:0]                           ts_i_data                   ;

output  [7:0]                           ts_o_data                   ;

wire    [7:0]                           ts_o_data                   ;

reg                                     ram_wren                    ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_waddr                   ;
reg     [RAM_WIDTH - 1 : 0]             ram_din                     ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_raddr                   ;
wire    [RAM_WIDTH - 1 : 0]             ram_dout                    ;

always@(posedge clk_x2 or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_wren    <=  1'b0;
        ram_din     <=  {RAM_WIDTH{1'b0}};
    end
    else
    begin
        ram_wren    <=  ts_i_valid;
        ram_din     <=  ts_i_data;
    end
end

always@(posedge clk_x2 or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_waddr   <=  751;
    end
    else if(ts_i_valid==1'b1)
    begin
        ram_waddr   <=  ram_waddr + 'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_raddr   <=  {RAM_DEPTH_BIT{1'b0}};
    end
    else if(ts_rd_valid==1'b1)
    begin
        ram_raddr   <=  ram_raddr + 'h1;
    end
end

assign  ts_o_data   =   ram_dout;

//width:8;depth:1024;read latency=2;
ts_j83_sdpram u0_ts_j83_sdpram(
    .clka                               ( clk_x2                    ),
    .wea                                ( ram_wren                  ),
    .addra                              ( ram_waddr                 ),
    .dina                               ( ram_din                   ),
    .clkb                               ( clk                       ),
    .addrb                              ( ram_raddr                 ),
    .doutb                              ( ram_dout                  )
    );
          
endmodule
