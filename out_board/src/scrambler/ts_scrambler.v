/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   ts_scrambler.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-02-25  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_scrambler.v
    File tree    :   ts_scrambler.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_scrambler(
    clk                         ,
    rst                         ,
    clk_x2                      ,
    scram_clr                   ,
    j83_rdreq                   ,
    ts_i_sync                   ,
    ts_i_valid                  ,
    ts_i_data                   ,
    ts_o_valid                  ,
    ts_o_data                   ,
    sc_ctrl_pkt_d               ,
    sc_ctrl_pkt_dval            ,
    sc_ctrl_pkt_eof
    );
    
parameter   U_DLY                       = 1                         ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_x2                      ;
input                                   scram_clr                   ;
input                                   j83_rdreq                   ;
input                                   ts_i_sync                   ;
input                                   ts_i_valid                  ;
input   [7:0]                           ts_i_data                   ;
output                                  ts_o_valid                  ;
output  [7:0]                           ts_o_data                   ;
input   [15:0]                          sc_ctrl_pkt_d               ;
input                                   sc_ctrl_pkt_dval            ;
input                                   sc_ctrl_pkt_eof             ;

wire    [7:0]                           scram_i_data                ;
wire                                    scram_i_eop                 ;
wire    [63:0]                          service_key                 ;
wire    [7:0]                           not_scram_byte_cnt          ;
wire                                    buf_h                       ;
wire                                    parity_key_flag             ;
wire                                    scram_ena                   ;

wire    [8:0]                           scram_raddr                 ;
wire    [7:0]                           scram_o_waddr               ;
wire                                    scram_end                   ;
wire                                    scram_o_valid               ;
wire    [7:0]                           scram_o_data                ;
wire                                    valid_temp                  ;

assign  valid_temp = scram_end & scram_o_valid;
assign  ts_o_valid = j83_rdreq;

scram_cfg u0_scram_cfg(
    .clk                                ( clk                       ), 
    .rst                                ( rst                       ),
    .clk_x2                             ( clk_x2                    ), 
    .sc_ctrl_pkt_d                      ( sc_ctrl_pkt_d             ),
    .sc_ctrl_pkt_dval                   ( sc_ctrl_pkt_dval          ),
    .sc_ctrl_pkt_eof                    ( sc_ctrl_pkt_eof           ),
    .ts_i_sync                          ( ts_i_sync                 ),
    .ts_i_valid                         ( ts_i_valid                ),
    .ts_i_data                          ( ts_i_data                 ),
    .scram_clr                          ( scram_clr                 ),
    .scram_raddr                        ( scram_raddr               ),
    .scram_i_data                       ( scram_i_data              ),
    .scram_i_eop                        ( scram_i_eop               ),
    .scram_ena                          ( scram_ena                 ),
    .service_key                        ( service_key               ),
    .not_scram_byte_cnt                 ( not_scram_byte_cnt        ),
    .buf_h                              ( buf_h                     ),
    .parity_key_flag                    ( parity_key_flag           )
    );
                
scrambler u0_scram(
    .nrst                               ( ~rst                      ),
    .clk                                ( clk_x2                    ),
    .pb                                 ( scram_i_data              ),
    .pkt_eop                            ( scram_i_eop               ),
    .ck                                 ( service_key               ),
    .pt                                 ( not_scram_byte_cnt        ),
    .buffh                              ( buf_h                     ),
    .o_e                                ( parity_key_flag           ),
    .enc                                ( scram_ena                 ),
    
    .sb                                 ( scram_o_data              ),
    .bcradd                             ( scram_raddr               ),
    .scwadd                             ( scram_o_waddr             ),
    .scwe                               ( scram_o_valid             ),
    .scend                              ( scram_end                 )
    );

ts_j83_buf u0_ts_j83_buf(
    .rst                                ( rst                       ),
    .clk                                ( clk_x2                    ),  //( clk                       ),
    .clk_x2                             ( clk_x2                    ),  
    .ts_rd_valid                        ( j83_rdreq                 ),  
    .ts_i_valid                         ( valid_temp                ),
    .ts_i_data                          ( scram_o_data              ),   
    .ts_o_data                          ( ts_o_data                 )
    );
           
endmodule
