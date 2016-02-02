/*************************************************************************************\
    Copyright(c) 2014, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   convert_clk.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-07-31  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   convert_clk.v
    File tree    :   convert_clk.v
\************************************************************************************/

`timescale 1ns/100ps

module convert_clk(
    clk_j83                     ,
    clk                         ,
    rst                         ,
    sc_i_d                      ,
    sc_i_dval                   ,
    sc_i_sop                    ,
    sc_i_eop                    ,
    sc_o_d                      ,
    sc_o_dval                   ,
    sc_o_sop                    ,
    sc_o_eop                     
    );

input                                   clk_j83                     ;    
input                                   clk                         ;
input                                   rst                         ;
input   [31:0]                          sc_i_d                      ;
input                                   sc_i_dval                   ;
input                                   sc_i_sop                    ;
input                                   sc_i_eop                    ;
output  [31:0]                          sc_o_d                      ;
output                                  sc_o_dval                   ;
output                                  sc_o_sop                    ;
output                                  sc_o_eop                    ;


wire    [33:0]                          fifo_din                    ;
wire                                    sc_o_sop                    ;
wire                                    sc_o_eop                    ;
wire    [31:0]                          sc_o_d                      ;
wire    [33:0]                          fifo_dout                   ;
reg                                     fifo_rden                   ;
reg                                     sc_o_dval                   ;
reg                                     sc_o_dval_buf               ;
wire                                    fifo_empty                  ;
wire                                    fifo_almost_empty           ;
    
assign  fifo_din    =   {sc_i_sop,sc_i_eop,sc_i_d[31:0]};
assign  sc_o_sop    =   fifo_dout[33] & sc_o_dval;
assign  sc_o_eop    =   fifo_dout[32] & sc_o_dval;
assign  sc_o_d      =   fifo_dout[31:0];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_rden   <=  1'b0;
    end
    else if(fifo_almost_empty==1'b0)
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
        sc_o_dval_buf   <=  1'b0;
        sc_o_dval       <=  1'b0;
    end
    else
    begin
        sc_o_dval_buf   <=  fifo_rden;
        sc_o_dval       <=  sc_o_dval_buf;
    end
end

//width:34bit,depth:512,use 1 M18K block ram,read latency=2   
convert_fifo u_convert_fifo(
    .rst                                ( rst                       ),
    .wr_clk                             ( clk_j83                   ),
    .rd_clk                             ( clk                       ),
    .din                                ( fifo_din                  ),
    .wr_en                              ( sc_i_dval                 ),
    .rd_en                              ( fifo_rden                 ),
    .dout                               ( fifo_dout                 ),
    .full                               ( /*not used*/              ),
    .empty                              ( fifo_empty                ),
    .almost_empty                       ( fifo_almost_empty         ),
    .rd_data_count                      ( /*not used*/              )
    );
    
endmodule
