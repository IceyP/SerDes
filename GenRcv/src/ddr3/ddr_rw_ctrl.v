/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  ddr_rw_ctrl.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-20  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  ddr_rw_ctrl.v
    File tree    :  ddr_rw_ctrl.v                        
\************************************************************************************/

`timescale 1ns/100ps

module ddr_rw_ctrl(
    clk                         ,
    rst                         ,
    clk_gtp                     ,
    rst_gtp                     ,
    
    ecm_pkt_index               ,
    ecm_pkt_period              ,
    ecm_pkt_sof                 ,
    ecm_pkt_eof                 ,
    ecm_pkt_data                ,
    ecm_pkt_val                 ,
    ecm_pkt_bp                  ,
    
    ecm_inforam_raddr           ,
    ecm_inforam_rdata           ,
    
    memc_cmd_ack                ,
    memc_cmd_req                ,
    memc_cmd                    ,
    memc_cmd_addr               ,
    memc_cmd_bl                 ,
    memc_wr_req                 ,
    memc_wr_end                 ,
    memc_wr_mask                ,
    memc_wr_data                ,
    memc_wr_ack                 ,
    memc_wr_count               ,
    
    memc_rd_empty               ,
    memc_rd_en                  ,
    memc_rd_data                ,
    
    ecm_pkt_rdy                 ,
    ecm_fifo_rden               ,
    ecm_fifo_dout               ,
    ecm_dataram_raddr           ,
    ecm_dataram_rdata 
    );

parameter   ECM_DATARAM_DEPTHBIT        = 9                         ;
parameter   ECM_DATARAM_WIDTH           = 16                        ;
parameter   C1_SIMULATION               = "FALSE"                   ;
    
input                                   clk                         ;
input                                   rst                         ;
input                                   clk_gtp                     ;
input                                   rst_gtp                     ;

input   [9:0]                           ecm_pkt_index               ;
input   [5:0]                           ecm_pkt_period              ;
input                                   ecm_pkt_sof                 ;
input                                   ecm_pkt_eof                 ;
input   [15:0]                          ecm_pkt_data                ;
input                                   ecm_pkt_val                 ;
output                                  ecm_pkt_bp                  ;

output  [9:0]                           ecm_inforam_raddr           ;
input   [15:0]                          ecm_inforam_rdata           ;

input                                   memc_cmd_ack                ;
output                                  memc_cmd_req                ;
output  [2:0]                           memc_cmd                    ;   //3'b000:write;3'b001:read
output  [29:0]                          memc_cmd_addr               ;
output  [5:0]                           memc_cmd_bl                 ;

output                                  memc_wr_req                 ;
output                                  memc_wr_end                 ;
output  [15:0]                          memc_wr_mask                ;
output  [127:0]                         memc_wr_data                ;
input                                   memc_wr_ack                 ;
input   [6:0]                           memc_wr_count               ;

input                                   memc_rd_empty               ;
output                                  memc_rd_en                  ;
input   [127:0]                         memc_rd_data                ;

output                                  ecm_pkt_rdy                 ;
input                                   ecm_fifo_rden               ;
output  [17:0]                          ecm_fifo_dout               ;
input   [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_raddr           ;
output  [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_rdata           ;

wire                                    pkt_wr_val                  ;
wire    [127:0]                         pkt_wr_data                 ;
wire    [15:0]                          pkt_wr_addr                 ;

wire                                    cmd_fifo_rden               ;
wire    [15:0]                          cmd_fifo_dout               ;
wire                                    cmd_fifo_rdempty            ;
wire                                    pkt_wr_eof                  ;

bit16to128 u0_bit16to128(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .ecm_pkt_index                      ( ecm_pkt_index             ),
    .ecm_pkt_period                     ( ecm_pkt_period            ),
    .ecm_pkt_sof                        ( ecm_pkt_sof               ),
    .ecm_pkt_eof                        ( ecm_pkt_eof               ),
    .ecm_pkt_data                       ( ecm_pkt_data              ),
    .ecm_pkt_val                        ( ecm_pkt_val               ),
    
    .pkt_o_val                          ( pkt_wr_val                ),
    .pkt_o_data                         ( pkt_wr_data               ),
    .pkt_o_eof                          ( pkt_wr_eof                ),
    .pkt_o_addr                         ( pkt_wr_addr               )
    ); 

ddr_write_ctrl #(
    .C1_SIMULATION                      ( C1_SIMULATION             )
    )
u0_ddr_write_ctrl(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .clk_gtp                            ( clk_gtp                   ),
    .rst_gtp                            ( rst_gtp                   ),
    
    .pkt_wr_val                         ( pkt_wr_val                ),
    .pkt_wr_eof                         ( pkt_wr_eof                ),
    .pkt_wr_data                        ( pkt_wr_data               ),
    .pkt_wr_addr                        ( pkt_wr_addr               ),
    .ecm_pkt_bp                         ( ecm_pkt_bp                ),
    .ecm_inforam_raddr                  ( ecm_inforam_raddr         ),
    .ecm_inforam_rdata                  ( ecm_inforam_rdata         ),
    
    .memc_cmd_ack                       ( memc_cmd_ack              ),
    .memc_cmd_req                       ( memc_cmd_req              ),
    .memc_cmd                           ( memc_cmd                  ),
    .memc_cmd_addr                      ( memc_cmd_addr             ),
    .memc_cmd_bl                        ( memc_cmd_bl               ),
    .memc_wr_req                        ( memc_wr_req               ),
    .memc_wr_end                        ( memc_wr_end               ),
    .memc_wr_mask                       ( memc_wr_mask              ),
    .memc_wr_data                       ( memc_wr_data              ),
    .memc_wr_ack                        ( memc_wr_ack               ),
    .memc_wr_count                      ( memc_wr_count             ),
    
    .cmd_fifo_rden                      ( cmd_fifo_rden             ),
    .cmd_fifo_dout                      ( cmd_fifo_dout             ),
    .cmd_fifo_rdempty                   ( cmd_fifo_rdempty          )
    );

ddr_read_ctrl #(
    .ECM_DATARAM_DEPTHBIT               ( ECM_DATARAM_DEPTHBIT      ),
    .ECM_DATARAM_WIDTH                  ( ECM_DATARAM_WIDTH         )
    )
u0_ddr_read_ctrl(
    .clk                                ( clk_gtp                   ),
    .rst                                ( rst_gtp                   ),
    
    .cmd_fifo_rden                      ( cmd_fifo_rden             ),
    .cmd_fifo_dout                      ( cmd_fifo_dout             ),
    .cmd_fifo_rdempty                   ( cmd_fifo_rdempty          ),
    
    .memc_rd_empty                      ( memc_rd_empty             ),
    .memc_rd_en                         ( memc_rd_en                ),
    .memc_rd_data                       ( memc_rd_data              ),
    
    .ecm_pkt_rdy                        ( ecm_pkt_rdy               ),
    .ecm_fifo_rden                      ( ecm_fifo_rden             ),
    .ecm_fifo_dout                      ( ecm_fifo_dout             ),
    .ecm_dataram_raddr                  ( ecm_dataram_raddr         ),
    .ecm_dataram_rdata                  ( ecm_dataram_rdata         )
    );
    
    
endmodule
