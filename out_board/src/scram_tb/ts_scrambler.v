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
    clk_cfg                     ,
    rst_cfg                     ,
    j83_rdreq                   ,
    ts_i_sync                   ,
    ts_i_valid                  ,
    ts_i_data                   ,
    ts_o_valid                  ,
    ts_o_data                   ,
    //local bus
    channel_index               ,
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_we_n
    );
    
parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   U_DLY                       = 1                         ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_cfg                     ;
input                                   rst_cfg                     ;
input                                   j83_rdreq                   ;
input                                   ts_i_sync                   ;
input                                   ts_i_valid                  ;
input   [7:0]                           ts_i_data                   ;
output                                  ts_o_valid                  ;
output  [7:0]                           ts_o_data                   ;

//local bus
input   [3:0]                           channel_index               ;
input   [P_BUS_ADDR_WIDTH - 1 : 0]      lbus_addr                   ;
input   [P_BUS_DATA_WIDTH - 1 : 0]      lbus_wdata                  ;
input                                   lbus_we_n                   ;

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

assign  ts_o_valid = j83_rdreq;

scram_cfg u0_scram_cfg(
    .clk                                ( clk                       ), 
    .rst                                ( rst                       ),  
    .clk_cfg                            ( clk_cfg                   ), 
    .rst_cfg                            ( rst_cfg                   ),
    //local bus
    .channel_index                      ( channel_index             ),
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_wdata                         ( lbus_wdata                ),
    .lbus_we_n                          ( lbus_we_n                 ),
    //ts data in
    .ts_i_sync                          ( ts_i_sync                 ),
    .ts_i_valid                         ( ts_i_valid                ),
    .ts_i_data                          ( ts_i_data                 ),
    .scram_raddr                        ( scram_raddr               ),
    .scram_i_data                       ( scram_i_data              ),
    .scram_i_eop                        ( scram_i_eop               ),
    .scram_ena                          ( scram_ena                 ),
    .service_key                        ( service_key               ),
    .not_scram_byte_cnt                 ( not_scram_byte_cnt        ),
    .buf_h                              ( buf_h                     ),
    .parity_key_flag                    ( parity_key_flag           )
    );
            
SCRAMBLER u0_scram(
    .NRST                               ( ~rst                      ),
    .CLK                                ( clk                       ),
    .PB                                 ( scram_i_data              ),
    .PKT_EOP                            ( scram_i_eop               ),
    .CK                                 ( service_key               ),
    .PT                                 ( not_scram_byte_cnt        ),
    .BUFFH                              ( buf_h                     ),
    .O_E                                ( parity_key_flag           ),
    .ENC                                ( scram_ena                 ),
    
    .SB                                 ( scram_o_data              ),
    .BCRADD                             ( scram_raddr               ),
    .SCWADD                             ( scram_o_waddr             ),  //???????????
    .SCWE                               ( scram_o_valid             ),
    .SCEND                              ( scram_end                 )
    );

wire    valid_temp;
assign  valid_temp = scram_end & scram_o_valid;

ts_j83_buf u0_ts_j83_buf(
    .rst                                ( rst                       ),
    .clk                                ( clk                       ),
    
    .ts_rd_valid                        ( j83_rdreq                 ),
    
    .ts_i_valid                         ( valid_temp                ),
    .ts_i_data                          ( scram_o_data              ),
    
    .ts_o_data                          ( ts_o_data                 )
    );
           
endmodule
