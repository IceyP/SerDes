/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   pcr_lo_gen.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-09-05  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   pcr_lo_gen.v
    File tree    :   pcr_lo_gen.v
\************************************************************************************/

`timescale 1ns/100ps

module pcr_lo_gen(
    rst_27m                     ,
    clk_27m                     , 
    rst                         ,
    clk                         ,
    clk_rx                      , 
    pcr_lo_data                 ,
    pcr_lo_base_r
    );

input                                   rst_27m                     ;
input                                   clk_27m                     ;
input                                   rst                         ;
input                                   clk                         ;
input                                   clk_rx                      ;
output  [41:0]                          pcr_lo_data                 ;
output  [32:0]                          pcr_lo_base_r               ;

reg     [32:0]                          pcr_lo_base                 ;
reg     [8:0]                           pcr_lo_ext                  ;
reg     [32:0]                          pcr_lo_base_1dly            ;
reg     [32:0]                          pcr_lo_base_2dly            ;
reg     [8:0]                           pcr_lo_ext_1dly             ;
reg     [8:0]                           pcr_lo_ext_2dly             ;
wire    [41:0]                          pcr_lo_data                 ;
reg     [32:0]                          pcr_lo_base_1buf            ;
reg     [32:0]                          pcr_lo_base_2buf            ;

always@(posedge clk_27m or posedge rst_27m)
begin
    if(rst_27m==1'b1)
    begin
        pcr_lo_base <=  {33{1'b0}};
        pcr_lo_ext  <=  {9{1'b0}};
    end
    else if(pcr_lo_ext>=299)
    begin
        pcr_lo_base <=  pcr_lo_base + 'h1;
        pcr_lo_ext  <=  {9{1'b0}};
    end
    else
    begin
        pcr_lo_ext  <=  pcr_lo_ext + 'h1;
    end
end

//asyn clk:clk27m--->clk125m
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_lo_base_1dly    <=  {33{1'b0}};
        pcr_lo_base_2dly    <=  {33{1'b0}};
        pcr_lo_ext_1dly     <=  {9{1'b0}};
        pcr_lo_ext_2dly     <=  {9{1'b0}};
    end
    else
    begin
        pcr_lo_base_1dly    <=  pcr_lo_base;
        pcr_lo_base_2dly    <=  pcr_lo_base_1dly;
        pcr_lo_ext_1dly     <=  pcr_lo_ext;
        pcr_lo_ext_2dly     <=  pcr_lo_ext_1dly;
    end
end

always@(posedge clk_rx or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_lo_base_1buf    <=  {33{1'b0}};
        pcr_lo_base_2buf    <=  {33{1'b0}};
    end
    else
    begin
        pcr_lo_base_1buf    <=  pcr_lo_base;
        pcr_lo_base_2buf    <=  pcr_lo_base_1buf;
    end
end

assign  pcr_lo_data         =   {pcr_lo_base_2dly[32:0],pcr_lo_ext_2dly[8:0]};
assign  pcr_lo_base_r       =   pcr_lo_base_2buf[32:0];
        
endmodule
