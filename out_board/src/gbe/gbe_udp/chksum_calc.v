/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   chksum_calc.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   16bit一组，取补码相加，再对和取补码；
                     具体实现方式为：所有字段求和，然后与最终结果的进位（高16bit）相加，
                     最后取反！
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   chksum_calc.v
    File tree    :   chksum_calc.v
\************************************************************************************/

`timescale 1ns/100ps

module chksum_calc(
    rst                         ,
    clk                         ,
    
    chk_start                   ,
    init_value                  ,
    data_val                    ,
    data_in                     ,
    chk_end                     ,
    result
    );
    
parameter   U_DLY                       = 1                         ;

input                                   rst                         ;
input                                   clk                         ;

input                                   chk_start                   ;
input   [31:0]                          init_value                  ;
input                                   data_val                    ;
input   [15:0]                          data_in                     ;
input                                   chk_end                     ;

output  [15:0]                          result                      ;

reg     [31:0]                          sum_reg                     ;
wire    [15:0]                          result                      ;
wire    [31:0]                          sum_reg2                    ;
wire    [31:0]                          sum_reg3                    ;
wire    [31:0]                          next_sum_reg                ;
wire    [15:0]                          data_reg                    ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sum_reg <=  {32{1'b0}};
    end
    else if(chk_start==1'b1)
    begin
        sum_reg <=  #U_DLY {32{1'b0}};
    end
    else if(data_val==1'b1)
    begin
        sum_reg <=  #U_DLY next_sum_reg;
    end
end

assign  data_reg        =   (data_val==1'b1)  ?   data_in[15:0]   :   16'h0000;
assign  next_sum_reg    =   {{15{1'b0}},data_reg[15:0]} + sum_reg;
assign  sum_reg2        =   next_sum_reg + init_value;
assign  sum_reg3        =   sum_reg2[31:16] + sum_reg2[15:0];
assign  result          =   (chk_end==1'b1) ?   ~sum_reg3[15:0] :   16'h0000;

endmodule
