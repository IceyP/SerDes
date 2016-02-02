/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gen_rst.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-05-05  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gen_rst.v
    File tree    :   gen_rst.v                        
\************************************************************************************/

`timescale 1ns/100ps
    
module gen_rst(
    clk                         ,
    rst_i                       , 
    rst_o                      
    );

parameter   SIMULATION                  = "FALSE"                   ;
parameter   TIME_100ms                  = (SIMULATION=="FALSE") ?   270000  :   100;

input                                   clk                         ;
input                                   rst_i                       ;
output                                  rst_o                       ;

reg     [23:0]                          counter                     ;
reg                                     rst_o                       ;

assign  rst =   ~rst_i;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        counter <=  {24{1'b0}};
    end
    else if(counter<TIME_100ms)
    begin
        counter <=  counter + 'h1;
    end
end

//power on reset 100ms
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        rst_o   <=  1'b1;
    end
    else if(counter<TIME_100ms)
    begin
        rst_o   <=  1'b1;
    end
    else
    begin
        rst_o   <=  1'b0;
    end
end
                    
endmodule
