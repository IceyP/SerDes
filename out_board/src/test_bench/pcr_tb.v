/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   pcr_tb.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-10-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   pcr_tb.v
    File tree    :   pcr_tb.v
\************************************************************************************/

`timescale 1ns/100ps

module pcr_tb;

reg                                     rst                         ;
reg                                     clk_27m                     ;
reg                                     clk_341m                    ;

wire                                    ts_sync                     ;
wire                                    ts_valid                    ;
wire    [7:0]                           ts_data                     ;
wire                                    pcr_cor_sync                ;
wire                                    pcr_cor_valid               ;
wire    [7:0]                           pcr_cor_data                ;

initial
begin
    rst =   1'b1;
    #200
    rst =   1'b0;
end

initial
    clk_27m     =   1'b0;
always
    clk_27m     =   # 19 ~clk_27m;
    
initial
    clk_341m    =   1'b0;
always
    clk_341m    =   # 3 ~clk_341m;
    
ts_gen u0_ts_gen(
    .rst                                ( rst                       ),
    .clk                                ( clk_341m                  ),   
    .ts_sync                            ( ts_sync                   ),
    .ts_valid                           ( ts_valid                  ),
    .ts_data                            ( ts_data                   )
    );

pcr_pro u0_pcr_pro(
    .rst_27m                            ( rst                       ),
    .clk_27m                            ( clk_27m                   ),
    .rst_341m                           ( rst                       ),
    .clk_341m                           ( clk_341m                  ),   
    .ts_sync                            ( ts_sync                   ),
    .ts_valid                           ( ts_valid                  ),
    .ts_data                            ( ts_data                   ),
                                        
    .pcr_correct_ena                    ( 1'b1                      ),
                                        
    .ts_o_sync                          ( pcr_cor_sync              ),
    .ts_o_valid                         ( pcr_cor_valid             ),
    .ts_o_data                          ( pcr_cor_data              )
    );
            
initial begin
    $fsdbDumpfile("test_000.fsdb");
    $fsdbDumpvars;
end	

endmodule

