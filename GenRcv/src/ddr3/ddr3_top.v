/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  ddr3_top.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-20  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  ddr3_top.v
    File tree    :  ddr3_top.v                        
\************************************************************************************/

`timescale 1ns/1ps

module ddr3_top #(
    parameter C1_P0_MASK_SIZE           = 16,
    parameter C1_P0_DATA_PORT_SIZE      = 128,
    parameter DEBUG_EN                  = 0,       
                                          // # = 1, Enable debug signals/controls,
                                          //   = 0, Disable debug signals/controls.
    parameter C1_MEMCLK_PERIOD          = 3000,       
                                          // Memory data transfer clock period
    parameter C1_CALIB_SOFT_IP          = "TRUE",       
                                          // # = TRUE, Enables the soft calibration logic,
                                          // # = FALSE, Disables the soft calibration logic.
    parameter C1_SIMULATION             = "FALSE",       
                                          // # = TRUE, Simulating the design. Useful to reduce the simulation time,
                                          // # = FALSE, Implementing the design.
    parameter C1_RST_ACT_LOW            = 0,       
                                          // # = 1 for active low reset,
                                          // # = 0 for active high reset.
    parameter C1_INPUT_CLK_TYPE         = "SINGLE_ENDED",       
                                          // input clock type DIFFERENTIAL or SINGLE_ENDED
    parameter C1_MEM_ADDR_ORDER         = "BANK_ROW_COLUMN",       
                                          // The order in which user address is provided to the memory controller,
                                          // ROW_BANK_COLUMN or BANK_ROW_COLUMN
    parameter C1_NUM_DQ_PINS            = 16,       
                                          // External memory data width
    parameter C1_MEM_ADDR_WIDTH         = 14,       
                                          // External memory address width
    parameter C1_MEM_BANKADDR_WIDTH     = 3,        
                                          // External memory bank address width
    parameter ECM_DATARAM_DEPTHBIT      = 9,
    parameter ECM_DATARAM_WIDTH         = 16
    )	
    (
    output                              calib_done                  ,
    inout   [C1_NUM_DQ_PINS-1:0]        mcb1_dram_dq                ,
    output  [C1_MEM_ADDR_WIDTH-1:0]     mcb1_dram_a                 ,
    output  [C1_MEM_BANKADDR_WIDTH-1:0] mcb1_dram_ba                ,
    output                              mcb1_dram_ras_n             ,
    output                              mcb1_dram_cas_n             ,
    output                              mcb1_dram_we_n              ,
    output                              mcb1_dram_odt               ,
    output                              mcb1_dram_reset_n           ,
    output                              mcb1_dram_cke               ,
    output                              mcb1_dram_dm                ,
    inout                               mcb1_rzq                    ,
    inout                               mcb1_zio                    ,
    input                               c1_sys_clk                  ,
    input                               c1_sys_rst_i                ,
    input                               clk_gtp                     ,
    input                               rst_gtp                     ,
    inout                               mcb1_dram_dqs               ,
    inout                               mcb1_dram_dqs_n             ,
    
    inout                               mcb1_dram_udqs              ,
    inout                               mcb1_dram_udqs_n            ,
    output                              mcb1_dram_udm               , 
    
    output                              mcb1_dram_ck                ,
    output                              mcb1_dram_ck_n              ,
    output                              clk_ddr3                    ,
    output                              rst_ddr3                    ,                                       
    input   [9:0]                       ecm_pkt_index               ,
    input   [5:0]                       ecm_pkt_period              ,
    input                               ecm_pkt_sof                 ,
    input                               ecm_pkt_eof                 ,
    input   [15:0]                      ecm_pkt_data                ,
    input                               ecm_pkt_val                 ,
    output                              ecm_pkt_bp                  ,
    
    output  [9:0]                       ecm_inforam_raddr           ,
    input   [15:0]                      ecm_inforam_rdata           ,
    
    output                                  ecm_pkt_rdy             ,
    input                                   ecm_fifo_rden           ,
    output  [17:0]                          ecm_fifo_dout           ,
    input   [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_raddr       ,
    output  [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_rdata       
    );

wire                                    c1_clk0                     ;
wire                                    c1_rst0                     ;
wire                                    c1_p0_cmd_en                ;
wire    [2:0]                           c1_p0_cmd_instr             ;
wire    [5:0]                           c1_p0_cmd_bl                ;
wire    [29:0]                          c1_p0_cmd_byte_addr         ;
wire                                    c1_p0_cmd_empty             ;
wire                                    c1_p0_cmd_full              ;
wire                                    c1_p0_wr_en                 ;
wire    [C1_P0_MASK_SIZE - 1:0]         c1_p0_wr_mask               ;
wire    [C1_P0_DATA_PORT_SIZE - 1:0]    c1_p0_wr_data               ;
wire                                    c1_p0_wr_full               ;
wire                                    c1_p0_wr_empty              ;
wire    [6:0]                           c1_p0_wr_count              ;
wire                                    c1_p0_wr_underrun           ;
wire                                    c1_p0_wr_error              ;
wire                                    c1_p0_rd_en                 ;
wire    [C1_P0_DATA_PORT_SIZE - 1:0]    c1_p0_rd_data               ;
wire                                    c1_p0_rd_full               ;
wire                                    c1_p0_rd_empty              ;
wire    [6:0]                           c1_p0_rd_count              ;
wire                                    c1_p0_rd_overflow           ;
wire                                    c1_p0_rd_error              ;

assign  clk_ddr3    =   c1_clk0;
assign  rst_ddr3    =   c1_rst0 | (~calib_done);

ddr3_pro #(
    .C1_P0_MASK_SIZE                    ( C1_P0_MASK_SIZE           ),
    .C1_P0_DATA_PORT_SIZE               ( C1_P0_DATA_PORT_SIZE      ),
    .DEBUG_EN                           ( DEBUG_EN                  ),
    .C1_MEMCLK_PERIOD                   ( C1_MEMCLK_PERIOD          ),
    .C1_RST_ACT_LOW                     ( C1_RST_ACT_LOW            ),
    .C1_INPUT_CLK_TYPE                  ( C1_INPUT_CLK_TYPE         ),
    .C1_MEM_ADDR_ORDER                  ( C1_MEM_ADDR_ORDER         ),
    .C1_NUM_DQ_PINS                     ( C1_NUM_DQ_PINS            ),
    .C1_MEM_ADDR_WIDTH                  ( C1_MEM_ADDR_WIDTH         ),
    .C1_MEM_BANKADDR_WIDTH              ( C1_MEM_BANKADDR_WIDTH     ),
    .C1_SIMULATION                      ( C1_SIMULATION             ),
    .C1_CALIB_SOFT_IP                   ( C1_CALIB_SOFT_IP          )
    )
u0_ddr3_pro(
    .c1_sys_clk                         ( c1_sys_clk                ),
    .c1_sys_rst_i                       ( c1_sys_rst_i              ),                        
                                          
    .mcb1_dram_dq                       ( mcb1_dram_dq              ),  
    .mcb1_dram_a                        ( mcb1_dram_a               ),  
    .mcb1_dram_ba                       ( mcb1_dram_ba              ),
    .mcb1_dram_ras_n                    ( mcb1_dram_ras_n           ),                        
    .mcb1_dram_cas_n                    ( mcb1_dram_cas_n           ),                        
    .mcb1_dram_we_n                     ( mcb1_dram_we_n            ),                          
    .mcb1_dram_odt                      ( mcb1_dram_odt             ),
    .mcb1_dram_cke                      ( mcb1_dram_cke             ),                          
    .mcb1_dram_ck                       ( mcb1_dram_ck              ),                          
    .mcb1_dram_ck_n                     ( mcb1_dram_ck_n            ),       
    .mcb1_dram_dqs                      ( mcb1_dram_dqs             ),                          
    .mcb1_dram_dqs_n                    ( mcb1_dram_dqs_n           ),
    
    .mcb1_dram_udqs                     ( mcb1_dram_udqs            ),  // for X16 parts                        
    .mcb1_dram_udqs_n                   ( mcb1_dram_udqs_n          ),  // for X16 parts
    .mcb1_dram_udm                      ( mcb1_dram_udm             ),  // for X16 parts
    
    .mcb1_dram_dm                       ( mcb1_dram_dm              ),
    .mcb1_dram_reset_n                  ( mcb1_dram_reset_n         ),
    .c1_clk0		                    ( c1_clk0                   ),
    .c1_rst0		                    ( c1_rst0                   ),
    
    .c1_calib_done                      ( calib_done                ),
    .mcb1_rzq                           ( mcb1_rzq                  ),      
    .mcb1_zio                           ( mcb1_zio                  ),
  	
    .c1_p0_cmd_clk                      ( c1_clk0                   ),
    .c1_p0_cmd_en                       ( c1_p0_cmd_en              ),
    .c1_p0_cmd_instr                    ( c1_p0_cmd_instr           ),
    .c1_p0_cmd_bl                       ( c1_p0_cmd_bl              ),
    .c1_p0_cmd_byte_addr                ( c1_p0_cmd_byte_addr       ),
    .c1_p0_cmd_empty                    ( c1_p0_cmd_empty           ),
    .c1_p0_cmd_full                     ( c1_p0_cmd_full            ),
    .c1_p0_wr_clk                       ( c1_clk0                   ),
    .c1_p0_wr_en                        ( c1_p0_wr_en               ),
    .c1_p0_wr_mask                      ( c1_p0_wr_mask             ),
    .c1_p0_wr_data                      ( c1_p0_wr_data             ),
    .c1_p0_wr_full                      ( c1_p0_wr_full             ),
    .c1_p0_wr_empty                     ( c1_p0_wr_empty            ),
    .c1_p0_wr_count                     ( c1_p0_wr_count            ),
    .c1_p0_wr_underrun                  ( c1_p0_wr_underrun         ),
    .c1_p0_wr_error                     ( c1_p0_wr_error            ),
    .c1_p0_rd_clk                       ( clk_gtp                   ),
    .c1_p0_rd_en                        ( c1_p0_rd_en               ),
    .c1_p0_rd_data                      ( c1_p0_rd_data             ),
    .c1_p0_rd_full                      ( c1_p0_rd_full             ),
    .c1_p0_rd_empty                     ( c1_p0_rd_empty            ),
    .c1_p0_rd_count                     ( c1_p0_rd_count            ),
    .c1_p0_rd_overflow                  ( c1_p0_rd_overflow         ),
    .c1_p0_rd_error                     ( c1_p0_rd_error            )
    ); 

ddr_rw_ctrl #(
    .C1_SIMULATION                      ( C1_SIMULATION             )
    )
u0_ddr_rw_ctrl(
    .clk                                ( clk_ddr3                  ),
    .rst                                ( rst_ddr3                  ),
    .clk_gtp                            ( clk_gtp                   ),
    .rst_gtp                            ( rst_gtp                   ),
    
    .ecm_pkt_index                      ( ecm_pkt_index             ),
    .ecm_pkt_period                     ( ecm_pkt_period            ),
    .ecm_pkt_sof                        ( ecm_pkt_sof               ),
    .ecm_pkt_eof                        ( ecm_pkt_eof               ),
    .ecm_pkt_data                       ( ecm_pkt_data              ),
    .ecm_pkt_val                        ( ecm_pkt_val               ),
    .ecm_pkt_bp                         ( ecm_pkt_bp                ),
    
    .ecm_inforam_raddr                  ( ecm_inforam_raddr         ),
    .ecm_inforam_rdata                  ( ecm_inforam_rdata         ),
    
    .memc_cmd_ack                       ( ~c1_p0_cmd_full           ),
    .memc_cmd_req                       ( c1_p0_cmd_en              ),
    .memc_cmd                           ( c1_p0_cmd_instr           ),
    .memc_cmd_addr                      ( c1_p0_cmd_byte_addr       ),
    .memc_cmd_bl                        ( c1_p0_cmd_bl              ),
    
    .memc_wr_req                        ( c1_p0_wr_en               ),
    .memc_wr_end                        ( /*not used*/              ),  //???????????????
    .memc_wr_mask                       ( c1_p0_wr_mask             ),
    .memc_wr_data                       ( c1_p0_wr_data             ),
    .memc_wr_ack                        ( ~c1_p0_wr_full            ),
    .memc_wr_count                      ( c1_p0_wr_count            ),
    
    .memc_rd_empty                      ( c1_p0_rd_empty            ),  //input
    .memc_rd_en                         ( c1_p0_rd_en               ),  //output
    .memc_rd_data                       ( c1_p0_rd_data             ),  //input
    
    .ecm_pkt_rdy                        ( ecm_pkt_rdy               ),
    .ecm_fifo_rden                      ( ecm_fifo_rden             ),
    .ecm_fifo_dout                      ( ecm_fifo_dout             ),
    .ecm_dataram_raddr                  ( ecm_dataram_raddr         ),
    .ecm_dataram_rdata                  ( ecm_dataram_rdata         )
    );
  
endmodule
