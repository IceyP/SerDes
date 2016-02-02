/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   pcr_pro.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-10-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   pcr_pro.v
    File tree    :   pcr_pro.v
\************************************************************************************/

`timescale 1ns/100ps

module pcr_pro(
    rst                         ,
    clk                         ,  
    ts_sync                     ,
    ts_valid                    ,
    ts_data                     ,
    pcr_lo_data                 ,
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
input   [41:0]                          pcr_lo_data                 ;
input                                   pcr_correct_ac_ena          ;

output                                  ts_o_sync                   ;
output                                  ts_o_valid                  ;
output  [7:0]                           ts_o_data                   ;

wire    [7:0]                           ts_o_data                   ;

wire                                    ts_dly_sync                 ;
wire                                    ts_dly_valid                ;
wire    [7:0]                           ts_dly_data                 ;

wire    [41:0]                          pcr_cor_data                ;
wire                                    cor_i_sync                  ;
wire                                    cor_i_valid                 ;

assign  cor_i_sync  =   ts_sync & pcr_correct_ac_ena;
assign  cor_i_valid =   ts_valid & pcr_correct_ac_ena;

pcr_accuracy_adapt u0_pcr_accuracy_adapt(
    .rst                                ( rst                       ),
    .clk                                ( clk                       ), 
    .ts_sync                            ( cor_i_sync                ),
    .ts_valid                           ( cor_i_valid               ),
    .ts_data                            ( ts_data                   ),
    .pcr_lo_data                        ( pcr_lo_data               ),
    .pcr_cor_data                       ( pcr_cor_data              )
    );

ts_delay u0_ts_delay(
    .rst                                ( rst                       ),
    .clk                                ( clk                       ),   
    .ts_sync                            ( ts_sync                   ),
    .ts_valid                           ( ts_valid                  ),
    .ts_data                            ( ts_data                   ),
    .pcr_correct_data                   ( pcr_cor_data              ),
    .pcr_correct_ac_ena                 ( pcr_correct_ac_ena        ),
    
    .ts_o_sync                          ( ts_o_sync                 ),
    .ts_o_valid                         ( ts_o_valid                ),
    .ts_o_data                          ( ts_o_data                 )
    );
    
//ts_j83_buf u0_ts_j83_buf(
//    .rst                                ( rst                       ),
//    .clk                                ( clk                       ),
//    
//    .ts_rd_valid                        ( ts_valid                  ),
//    
//    .ts_i_valid                         ( ts_dly_valid              ),
//    .ts_i_data                          ( ts_dly_data               ), 
//    
//    .ts_o_data                          ( ts_o_data                 )
//    );
                
endmodule
