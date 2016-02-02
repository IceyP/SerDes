/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_j83.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_j83.v
    File tree    :   ts_j83.v
                        +---ts_sync.v
                        +---ts_buf.v
                            +---asyn_fifo.v
                        +---idlepkt_or_data_mux.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_j83(
    rst_125m                    ,                                       //in  : reset
    clk_125m                    ,
    
    ts_in                       ,                                       //in  : from triple_ethernet
    ts_in_valid                 ,                                       //in  : from triple_ethernet
    
    ts_rd_sync                  ,                                       //in  : from j.83
    ts_rd_req                   ,                                       //in  : from j.83
    
    ts_out                      ,                                       //out : to j.83
    
    tsbuf_port_bp                     
    );

parameter   U_DLY                       = 1                         ;   //Unit

input                                   rst_125m                    ;
input                                   clk_125m                    ;

input   [7:0]                           ts_in                       ;
input                                   ts_in_valid                 ;

input                                   ts_rd_sync                  ;
input                                   ts_rd_req                   ;

output  [7:0]                           ts_out                      ;

output                                  tsbuf_port_bp               ;

wire                                    tsbuf_has_frame             ;
wire    [7:0]                           tsbuf_out                   ;           

//ts_buf debug signals
wire                                    tsbuf_port_bp               ; 
wire                                    ts_sync_out_valid           ;
wire    [7:0]                           ts_sync_out                 ;

//ts_sync #(
//    .U_DLY                              ( U_DLY                     )
//    )
//u_ts_sync(
//    .rst                                ( rst_125m                  ),
//    .clk                                ( clk_125m                  ),          
//                                        
//    .ts_in                              ( ts_in                     ),              
//    .ts_in_valid                        ( ts_in_valid               ),          
//                                        
//    .ts_out                             ( ts_sync_out               ),              
//    .ts_out_valid                       ( ts_sync_out_valid         ),              
//    .ts_out_sync                        ( /*not used*/              ),          
//    .ts_out_last                        ( /*not used*/              )
//    );
	
ts_buf #(
    .U_DLY                              ( U_DLY                     )
    )
u_ts_buf(
    .rst                                ( rst_125m                  ),
    .clk                                ( clk_125m                  ),
    
    .ts_in                              ( ts_in                     ),
    .ts_in_valid                        ( ts_in_valid               ),
    
    .ts_rd_sync                         ( ts_rd_sync                ),                                      
    .ts_rd_req                          ( ts_rd_req                 ),  
    
    .has_frame                          ( tsbuf_has_frame           ),                                      
    .ts_rd_out                          ( tsbuf_out                 ),
    
    //for debug,clk_rd clock domain
    .port_bp                            ( tsbuf_port_bp             )
    );
    
idlepkt_or_data_mux #(
    .U_DLY                              ( U_DLY                     )
    )
u_idlepkt_or_data_mux(
    .rst                                ( rst_125m                  ),
    .clk                                ( clk_125m                  ),
                                        
    .ts_rd_sync                         ( ts_rd_sync                ),
    .ts_rd_req                          ( ts_rd_req                 ),
                                        
    .tsbuf_has_frame                    ( tsbuf_has_frame           ),
    .tsbuf_mux_data                     ( tsbuf_out                 ),
                                        
    .ts_out                             ( ts_out                    )
    );

endmodule
