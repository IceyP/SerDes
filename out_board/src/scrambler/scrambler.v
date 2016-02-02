/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   scrambler.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-03-23  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   scrambler.v
    File tree    :   scrambler.v
\************************************************************************************/

module scrambler(
    nrst                        ,
    clk                         ,
    pb                          ,
    pkt_eop                     ,
    ck                          ,
    pt                          ,
    buffh                       ,
    o_e                         ,
    enc                         ,           
    sb                          ,
    bcradd                      ,
    scwadd                      ,
    scwe                        ,
    scend                       
    );
    
input                                   nrst                        ;
input                                   clk                         ;
input   [0:7]                           pb                          ;
input                                   pkt_eop                     ;
input   [0:63]                          ck                          ;
input   [0:7]                           pt                          ;
input                                   buffh                       ;
input                                   o_e                         ;
input                                   enc                         ;
output  [0:7]                           sb                          ;
output  [0:8]                           bcradd                      ;
output  [0:7]                           scwadd                      ;
output                                  scwe                        ;
output                                  scend                       ;

wire    [0:63]                          ck_reg                      ;
wire                                    bcend                       ;
wire                                    scend_s                     ;
wire                                    buffhr                      ;
wire                                    bcwe                        ;
wire    [0:7]                           ib                          ;
wire    [0:7]                           ibout                       ;
wire    [0:7]                           ptr                         ;
wire    [0:8]                           bcwadd                      ;
wire    [0:8]                           scradd                      ;

block_cipher2 u0_block_cipher2(
    .nrst                               ( nrst                      ),
    .clk                                ( clk                       ),
    .pkt_eop                            ( pkt_eop                   ),
    .ck                                 ( ck                        ),
    .pb                                 ( pb                        ),
    .pt                                 ( pt                        ),
    .buffh                              ( buffh                     ),
    .o_e                                ( o_e                       ),
    .enc                                ( enc                       ),
    .bcradd                             ( bcradd                    ),
    .bcwadd                             ( bcwadd                    ),
    .bcwe                               ( bcwe                      ),
    .ib                                 ( ib                        ),
    .ck_reg                             ( ck_reg                    ),
    .bcend                              ( bcend                     ),
    .ptr                                ( ptr                       ),
    .buffhr                             ( buffhr                    )
    );

ramb2_1clk u0_ramb2_1clk(
    .clka                               ( clk                       ),
    .wea                                ( bcwe                      ),
    .addra                              ( bcwadd                    ),
    .dina                               ( ib                        ),
    .clkb                               ( clk                       ),
    .addrb                              ( scradd                    ),
    .doutb                              ( ibout                     )
    );
    
stream_cipher u0_stream_cipher(
    .nrst                               ( nrst                      ),
    .clk                                ( clk                       ),
    .pkt_eop                            ( pkt_eop                   ),
    .ck                                 ( ck_reg                    ),
    .ib                                 ( ibout                     ),
    .pt                                 ( ptr                       ),
    .buffh                              ( buffhr                    ),
    .sb                                 ( sb                        ),
    .scwadd                             ( scwadd                    ),
    .scradd                             ( scradd                    ),
    .scwe                               ( scwe                      ),
    .scend                              ( scend_s                   )
    );

assign  scend   =   scend_s;

endmodule

