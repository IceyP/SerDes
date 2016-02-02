/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ddr_rw_ctrl.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-07  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_rw_ctrl.v
    File tree    :   ddr_rw_ctrl.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_rw_ctrl(
    clk_rx                      ,
    rst_rx                      ,
    clk                         ,
    rst                         ,
    clk_156m                    ,
    rst_156m                    ,
    
    gtx_rx_data                 ,
    gtx_rx_sof_n                ,
    gtx_rx_eof_n                ,
    gtx_rx_dvalid_n             ,
    
    sc_data_pkt_d               ,
    sc_data_pkt_dval            ,
    sc_data_pkt_sop             ,
    sc_data_pkt_eop             ,
    scram_clr                   ,
    
    ts_in_data                  ,
    ts_in_valid                 ,
    ts_in_start                 ,
    ts_in_end                   ,
    pcr_correct_int_ena         ,
    pcr_correct_ac_ena          ,
     
    memc_cmd_ack                ,
    memc_cmd_req                ,
    memc_cmd                    ,
    memc_cmd_addr               ,
    memc_wr_req                 ,
    memc_wr_end                 ,
    memc_wr_mask                ,
    memc_wr_data                ,
    memc_wr_ack                 ,
    memc_rd_data                ,
    memc_rd_valid               ,
    
    clk_27m                     ,
    rst_27m                     ,
    clk_j83                     ,
    j83_ts_rd_sync              ,
    j83_ts_rd_req               ,
    ts_j83_data_ch0             ,
    ts_j83_data_ch1             ,
    ts_j83_data_ch2             ,
    ts_j83_data_ch3             ,
    ts_j83_data_ch4             ,
    ts_j83_data_ch5             ,
    ts_j83_data_ch6             ,
    ts_j83_data_ch7             ,
    
    dejitter_ms                 
    );

parameter   U_DLY                       = 1                         ;
parameter   BUF_DEPTH_BIT               = 7                         ;
parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   PROG_PER_CHAN_BITWIDTH      = 4                         ;

parameter   TOTAL_CHN_NUM               = 16                        ;
parameter   PROG_BIT_WIDTH              = CHNNUM_BIT_WIDTH + PROG_PER_CHAN_BITWIDTH;
parameter   TOTAL_PROG_NUM              = 2 ** PROG_BIT_WIDTH       ;
parameter   DDR3_ADDR_WIDTH             = 28                        ;

input                                   clk_rx                      ;
input                                   rst_rx                      ;
input                                   clk                         ;
input                                   rst                         ;
input                                   clk_156m                    ;
input                                   rst_156m                    ;

input   [15:0]                          gtx_rx_data                 ;
input                                   gtx_rx_sof_n                ;
input                                   gtx_rx_eof_n                ;
input                                   gtx_rx_dvalid_n             ;
input                                   scram_clr                   ;
output  [31:0]                          sc_data_pkt_d               ;
output                                  sc_data_pkt_dval            ;
output                                  sc_data_pkt_sop             ;
output                                  sc_data_pkt_eop             ;

input   [31:0]                          ts_in_data                  ;
input                                   ts_in_valid                 ;
input                                   ts_in_start                 ;
input                                   ts_in_end                   ;
input   [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_int_ena         ;
input   [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_ac_ena          ;

input                                   memc_cmd_ack                ;
output                                  memc_cmd_req                ;
output  [2:0]                           memc_cmd                    ;   //3'b000:write;3'b001:read
output  [DDR3_ADDR_WIDTH - 1 : 0]       memc_cmd_addr               ;

output                                  memc_wr_req                 ;
output                                  memc_wr_end                 ;
output  [15:0]                          memc_wr_mask                ;
output  [127:0]                         memc_wr_data                ;
input                                   memc_wr_ack                 ;

input   [127:0]                         memc_rd_data                ;
input                                   memc_rd_valid               ;

input                                   clk_27m                     ;
input                                   rst_27m                     ;
output                                  clk_j83                     ;
input   [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_sync              ;  
input   [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_req               ;  
output  [7:0]                           ts_j83_data_ch0             ;
output  [7:0]                           ts_j83_data_ch1             ;
output  [7:0]                           ts_j83_data_ch2             ;
output  [7:0]                           ts_j83_data_ch3             ;
output  [7:0]                           ts_j83_data_ch4             ;
output  [7:0]                           ts_j83_data_ch5             ;
output  [7:0]                           ts_j83_data_ch6             ;
output  [7:0]                           ts_j83_data_ch7             ;

input   [10:0]                          dejitter_ms                 ;

wire    [DDR3_ADDR_WIDTH - 1 : 0]       ts_wr_addr                  ;
wire    [127:0]                         ts_wr_data                  ;
wire                                    ts_wr_valid                 ;
wire    [TOTAL_CHN_NUM - 1 : 0]         buf_bp                      ;
wire    [TOTAL_CHN_NUM - 1 : 0]         ch_valid                    ;
wire    [7:0]                           ch_data[TOTAL_CHN_NUM - 1 : 0];
wire    [TOTAL_CHN_NUM - 1 : 0]         port_bp                     ;
wire    [7:0]                           ts_j83_data_ch0             ;
wire    [7:0]                           ts_j83_data_ch1             ;
wire    [7:0]                           ts_j83_data_ch2             ;
wire    [7:0]                           ts_j83_data_ch3             ;
wire    [7:0]                           ts_j83_data_ch4             ;
wire    [7:0]                           ts_j83_data_ch5             ;
wire    [7:0]                           ts_j83_data_ch6             ;
wire    [7:0]                           ts_j83_data_ch7             ;
wire    [7:0]                           ts_j83_data_ch[TOTAL_CHN_NUM - 1 : 0];

wire    [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_sync                ;
wire    [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_valid               ;
wire    [7:0]                           pcr_cor_data[TOTAL_CHN_NUM - 1 : 0];
wire    [31:0]                          ts_filter_data              ;
wire                                    ts_filter_val               ;
wire                                    ts_filter_sop               ;
wire                                    ts_filter_eop               ;
wire    [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag               ;
wire    [TOTAL_CHN_NUM - 1 : 0]         pcr_interval_data_valid     ;
wire    [127:0]                         pcr_interval_data           ;
wire    [41:0]                          pcr_lo_data                 ;
wire    [32:0]                          pcr_lo_base                 ;

wire    [TOTAL_CHN_NUM - 1 : 0]         scram_valid                 ;
wire    [7:0]                           scram_data[TOTAL_CHN_NUM - 1 : 0];
wire    [15:0]                          sc_ctrl_pkt_d               ;
wire    [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_dval_ch         ;
wire    [TOTAL_CHN_NUM - 1 : 0]         sc_ctrl_pkt_eof_ch          ;
wire                                    clk_j83                     ;

wire    [31:0]                          sc_data_pkt_d_buf           ;
wire                                    sc_data_pkt_dval_buf        ;
wire                                    sc_data_pkt_sop_buf         ;
wire                                    sc_data_pkt_eop_buf         ;

reg     [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_sync_1dly         ;  
reg     [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_req_1dly          ;
wire    [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_sync_buf          ;  
wire    [TOTAL_CHN_NUM - 1 : 0]         j83_ts_rd_req_buf           ;

assign  ts_j83_data_ch0     =   scram_data[0];
assign  ts_j83_data_ch1     =   scram_data[1];
assign  ts_j83_data_ch2     =   scram_data[2];
assign  ts_j83_data_ch3     =   scram_data[3];
assign  ts_j83_data_ch4     =   scram_data[4];
assign  ts_j83_data_ch5     =   scram_data[5];
assign  ts_j83_data_ch6     =   scram_data[6];
assign  ts_j83_data_ch7     =   scram_data[7];

pkt_filter #(
    .PROG_BIT_WIDTH                     ( PROG_BIT_WIDTH            ),
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .PROG_PER_CHAN_BITWIDTH             ( PROG_PER_CHAN_BITWIDTH    )
    )
u0_pkt_filter(
    .clk                                ( clk_rx                    ),
    .rst                                ( rst_rx                    ),
    .ts_i_data                          ( ts_in_data                ),
    .ts_i_val                           ( ts_in_valid               ),
    .ts_i_sop                           ( ts_in_start               ),
    .ts_i_eop                           ( ts_in_end                 ),
    .drop_pkt_flag                      ( drop_pkt_flag             ),
    .ts_o_data                          ( ts_filter_data            ),
    .ts_o_val                           ( ts_filter_val             ),
    .ts_o_sop                           ( ts_filter_sop             ),
    .ts_o_eop                           ( ts_filter_eop             )
    );    
    
ddr_write_bit32to128 #(
    .U_DLY                              ( U_DLY                     ),
    .PROG_BIT_WIDTH                     ( PROG_BIT_WIDTH            ),
    .DDR3_ADDR_WIDTH                    ( DDR3_ADDR_WIDTH           ),
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .PROG_PER_CHAN_BITWIDTH             ( PROG_PER_CHAN_BITWIDTH    )
    )
u0_ddr_write_bit32to128(
    .clk                                ( clk_rx                    ),
    .rst                                ( rst_rx                    ),
    
    .ts_in_data                         ( ts_filter_data            ),
    .ts_in_valid                        ( ts_filter_val             ),
    .ts_in_start                        ( ts_filter_sop             ),
    .ts_in_end                          ( ts_filter_eop             ),
    
    .ts_out_addr                        ( ts_wr_addr                ),
    .ts_out_data                        ( ts_wr_data                ),
    .ts_out_valid                       ( ts_wr_valid               )
    );

ddr_write_ctrl #(
    .U_DLY                              ( U_DLY                     ),
    .PROG_BIT_WIDTH                     ( PROG_BIT_WIDTH            ),
    .DDR3_ADDR_WIDTH                    ( DDR3_ADDR_WIDTH           ),
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_ddr_write_ctrl(
    .clk_rx                             ( clk_rx                    ),
    .rst_rx                             ( rst_rx                    ),
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),  
    .ts_addr                            ( ts_wr_addr                ),
    .ts_data                            ( ts_wr_data                ),
    .ts_valid                           ( ts_wr_valid               ),
    .pcr_lo_base                        ( pcr_lo_base               ),
    .pcr_correct_int_ena                ( pcr_correct_int_ena       ),  
    
    .memc_cmd_ack                       ( memc_cmd_ack              ),
    .memc_cmd_req                       ( memc_cmd_req              ),
    .memc_cmd                           ( memc_cmd                  ),
    .memc_cmd_addr                      ( memc_cmd_addr             ),
    .memc_wr_req                        ( memc_wr_req               ),
    .memc_wr_end                        ( memc_wr_end               ),
    .memc_wr_mask                       ( memc_wr_mask              ),
    .memc_wr_data                       ( memc_wr_data              ),
    .memc_wr_ack                        ( memc_wr_ack               ),
    .memc_rd_data                       ( memc_rd_data              ),
    .memc_rd_valid                      ( memc_rd_valid             ),
    
    .pcr_interval_data                  ( pcr_interval_data         ),
    .pcr_interval_data_valid            ( pcr_interval_data_valid   ),
    .drop_pkt_flag                      ( drop_pkt_flag             ),
    .dejitter_ms                        ( dejitter_ms               ),
    .buf_bp                             ( buf_bp                    )
    );                           

ddr_read_ctrl #(
    .U_DLY                              ( U_DLY                     ),
    .BUF_DEPTH_BIT                      ( BUF_DEPTH_BIT             ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_ddr_read_ctrl(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .clk_j83                            ( clk_j83                   ),
    
    .memc_rd_data                       ( pcr_interval_data         ),
    .memc_rd_valid                      ( pcr_interval_data_valid   ),
    
    .ch0_data                           ( ch_data[0]                ),
    .ch1_data                           ( ch_data[1]                ),
    .ch2_data                           ( ch_data[2]                ),
    .ch3_data                           ( ch_data[3]                ),
    .ch4_data                           ( ch_data[4]                ),
    .ch5_data                           ( ch_data[5]                ),
    .ch6_data                           ( ch_data[6]                ),
    .ch7_data                           ( ch_data[7]                ),
    .ch_valid                           ( ch_valid                  ),

    .port_bp                            ( port_bp                   ),
    .buf_bp                             ( buf_bp                    )
    );

//for timing,reduce fanout
gtx_rx_pkt_analyze #(
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_gtx_rx_pkt_analyze(
    .clk                                ( clk_156m                  ),
    .rst                                ( rst_156m                  ),
    .clk_125m                           ( clk_j83                   ),
    .rst_125m                           ( rst                       ),
    .gtx_rx_data                        ( gtx_rx_data               ),
    .gtx_rx_sof_n                       ( gtx_rx_sof_n              ),
    .gtx_rx_eof_n                       ( gtx_rx_eof_n              ),
    .gtx_rx_dvalid_n                    ( gtx_rx_dvalid_n           ),
    //control packet
    .sc_ctrl_pkt_d                      ( sc_ctrl_pkt_d             ),
    .sc_ctrl_pkt_dval_ch                ( sc_ctrl_pkt_dval_ch       ),
    .sc_ctrl_pkt_eof_ch                 ( sc_ctrl_pkt_eof_ch        ),
    //data packet
    .sc_data_pkt_d                      ( sc_data_pkt_d_buf         ),
    .sc_data_pkt_dval                   ( sc_data_pkt_dval_buf      ),
    .sc_data_pkt_sop                    ( sc_data_pkt_sop_buf       ),
    .sc_data_pkt_eop                    ( sc_data_pkt_eop_buf       )
    );

convert_clk u0_convert_clk(
    .clk_j83                            ( clk_j83                   ),
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    
    .sc_i_d                             ( sc_data_pkt_d_buf         ),
    .sc_i_dval                          ( sc_data_pkt_dval_buf      ),
    .sc_i_sop                           ( sc_data_pkt_sop_buf       ),
    .sc_i_eop                           ( sc_data_pkt_eop_buf       ),
    
    .sc_o_d                             ( sc_data_pkt_d             ),
    .sc_o_dval                          ( sc_data_pkt_dval          ),
    .sc_o_sop                           ( sc_data_pkt_sop           ),
    .sc_o_eop                           ( sc_data_pkt_eop           )
    );
    
pcr_lo_gen u0_pcr_lo_gen(
    .rst_27m                            ( rst_27m                   ),
    .clk_27m                            ( clk_27m                   ), 
    .rst                                ( rst                       ),
    .clk                                ( clk_j83                   ),
    .clk_rx                             ( clk                       ), 
    .pcr_lo_data                        ( pcr_lo_data               ),
    .pcr_lo_base_r                      ( pcr_lo_base               )
    );

pll_x2 u0_pll_x2(
    .CLK_IN1                            ( clk                       ),  //78.125MHz            
    .CLK_OUT1                           ( clk_j83                   ),  //39.0625MHz
    .RESET                              ( rst                       ),
    .LOCKED                             ( /*not used*/              )
    );

//change clock domain  
always@(posedge clk  or posedge rst)
begin
    if(rst==1'b1)
    begin
        j83_ts_rd_sync_1dly <=  1'b0;
        j83_ts_rd_req_1dly  <=  1'b0;
    end
    else 
    begin
        j83_ts_rd_sync_1dly <=  j83_ts_rd_sync;
        j83_ts_rd_req_1dly  <=  j83_ts_rd_req;
    end
end

assign  j83_ts_rd_sync_buf  =   j83_ts_rd_sync | j83_ts_rd_sync_1dly;
assign  j83_ts_rd_req_buf   =   j83_ts_rd_req | j83_ts_rd_req_1dly;
           
generate
    genvar j;
    for(j=0;j<TOTAL_CHN_NUM;j=j+1)
    begin:  MULTIPLE_CHANNEL_TS
        ts_j83 #(
            .U_DLY                      ( U_DLY                     )
            )
        u_ts_j83(
            .rst_125m                   ( rst                       ),
            .clk_125m                   ( clk_j83                   ),
            
            .ts_in                      ( ch_data[j]                ),
            .ts_in_valid                ( ch_valid[j]               ),
            
            .ts_rd_sync                 ( j83_ts_rd_sync_buf[j]     ),
            .ts_rd_req                  ( j83_ts_rd_req_buf[j]      ),
            
            .ts_out                     ( ts_j83_data_ch[j]         ),
            
            .tsbuf_port_bp              ( port_bp[j]                ) 
            );
        
        pcr_pro u0_pcr_pro(
            .rst                        ( rst                       ),
            .clk                        ( clk_j83                   ),  
            .ts_sync                    ( j83_ts_rd_sync_buf[j]     ),
            .ts_valid                   ( j83_ts_rd_req_buf[j]      ),
            .ts_data                    ( ts_j83_data_ch[j]         ),
            .pcr_lo_data                ( pcr_lo_data               ),
            .pcr_correct_ac_ena         ( pcr_correct_ac_ena[j]     ),
            
            .ts_o_sync                  ( pcr_cor_sync[j]           ),
            .ts_o_valid                 ( pcr_cor_valid[j]          ),
            .ts_o_data                  ( pcr_cor_data[j]           )
            );
            
        ts_scrambler u0_scrambler(
           .clk                         ( clk_j83                   ),
           .rst                         ( rst                       ),
           .clk_x2                      ( clk                       ),  //clkx2
           .scram_clr                   ( scram_clr                 ),
           .ts_i_sync                   ( pcr_cor_sync[j]           ),
           .ts_i_valid                  ( pcr_cor_valid[j]          ),
           .ts_i_data                   ( pcr_cor_data[j]           ),
           .j83_rdreq                   ( j83_ts_rd_req[j]          ),
           .ts_o_valid                  ( scram_valid[j]            ),
           .ts_o_data                   ( scram_data[j]             ),
           .sc_ctrl_pkt_d               ( sc_ctrl_pkt_d             ),
           .sc_ctrl_pkt_dval            ( sc_ctrl_pkt_dval_ch[j]    ),
           .sc_ctrl_pkt_eof             ( sc_ctrl_pkt_eof_ch[j]     )
           );
    end
endgenerate

endmodule
