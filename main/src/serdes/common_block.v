/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  common_block.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  common_block.v
    File tree    :  common_block.v                        
\************************************************************************************/

`timescale 1ns/1ps

module common_block(
    GT0_GTREFCLK0_COMMON        ,
    GT0_QPLLLOCKDETCLK          ,
    GT0_QPLLRESET               ,
    GT0_QPLLLOCK                ,
    GT0_QPLLCLK_QUAD2           ,
    GT0_QPLLREFCLK_QUAD2        ,
    GT0_QPLLREFCLKLOST          ,
    GT1_GTREFCLK0_COMMON        ,
    GT1_QPLLLOCKDETCLK          ,
    GT1_QPLLRESET               ,
    GT1_QPLLLOCK                ,
    GT1_QPLLCLK_QUAD2           ,
    GT1_QPLLREFCLK_QUAD2        ,
    GT1_QPLLREFCLKLOST          
    );

parameter   QPLL_FBDIV_TOP              = 40                        ;

parameter   QPLL_FBDIV_IN               = (QPLL_FBDIV_TOP == 16)  ? 10'b0000100000 : 
				                          (QPLL_FBDIV_TOP == 20)  ? 10'b0000110000 :
				                          (QPLL_FBDIV_TOP == 32)  ? 10'b0001100000 :
				                          (QPLL_FBDIV_TOP == 40)  ? 10'b0010000000 :
				                          (QPLL_FBDIV_TOP == 64)  ? 10'b0011100000 :
				                          (QPLL_FBDIV_TOP == 66)  ? 10'b0101000000 :
				                          (QPLL_FBDIV_TOP == 80)  ? 10'b0100100000 :
				                          (QPLL_FBDIV_TOP == 100) ? 10'b0101110000 : 10'b0000000000;
				                          
parameter   QPLL_FBDIV_RATIO            = (QPLL_FBDIV_TOP == 16)  ? 1'b1 : 
				                          (QPLL_FBDIV_TOP == 20)  ? 1'b1 :
				                          (QPLL_FBDIV_TOP == 32)  ? 1'b1 :
				                          (QPLL_FBDIV_TOP == 40)  ? 1'b1 :
				                          (QPLL_FBDIV_TOP == 64)  ? 1'b1 :
				                          (QPLL_FBDIV_TOP == 66)  ? 1'b0 :
				                          (QPLL_FBDIV_TOP == 80)  ? 1'b1 :
				                          (QPLL_FBDIV_TOP == 100) ? 1'b1 : 1'b1;

input                                   GT0_GTREFCLK0_COMMON        ;
input                                   GT0_QPLLLOCKDETCLK          ;
input                                   GT0_QPLLRESET               ;
output                                  GT0_QPLLLOCK                ;
output                                  GT0_QPLLCLK_QUAD2           ;
output                                  GT0_QPLLREFCLK_QUAD2        ;
output                                  GT0_QPLLREFCLKLOST          ;
input                                   GT1_GTREFCLK0_COMMON        ;
input                                   GT1_QPLLLOCKDETCLK          ;
input                                   GT1_QPLLRESET               ;
output                                  GT1_QPLLLOCK                ;
output                                  GT1_QPLLCLK_QUAD2           ;
output                                  GT1_QPLLREFCLK_QUAD2        ;
output                                  GT1_QPLLREFCLKLOST          ;

wire    [63:0]                          tied_to_ground_vec_i        ;
wire                                    tied_to_ground_i            ;
wire                                    tied_to_vcc_i               ;

assign tied_to_ground_vec_i             = 64'h0000000000000000;
assign tied_to_ground_i                 = 1'b0;
assign tied_to_vcc_i                    = 1'b1;


//__________________________________________________________________
//__________________________________________________________________
//_________________________GTXE2_COMMON_____________________________

GTXE2_COMMON #(
    // Simulation attributes
    .SIM_RESET_SPEEDUP                  ( "TRUE"                    ),
    .SIM_QPLLREFCLK_SEL                 ( 3'b001                    ),
    .SIM_VERSION                        ( "4.0"                     ),   
    //----------------COMMON BLOCK Attributes---------------
    .BIAS_CFG                           ( 64'h0000040000001000      ),
    .COMMON_CFG                         ( 32'h00000000              ),
    .QPLL_CFG                           ( 27'h06801C1               ),
    .QPLL_CLKOUT_CFG                    ( 4'b0000                   ),
    .QPLL_COARSE_FREQ_OVRD              ( 6'b010000                 ),
    .QPLL_COARSE_FREQ_OVRD_EN           ( 1'b0                      ),
    .QPLL_CP                            ( 10'b0000011111            ),
    .QPLL_CP_MONITOR_EN                 ( 1'b0                      ),
    .QPLL_DMONITOR_SEL                  ( 1'b0                      ),
    .QPLL_FBDIV                         ( QPLL_FBDIV_IN             ),
    .QPLL_FBDIV_MONITOR_EN              ( 1'b0                      ),
    .QPLL_FBDIV_RATIO                   ( QPLL_FBDIV_RATIO          ),
    .QPLL_INIT_CFG                      ( 24'h000006                ),
    .QPLL_LOCK_CFG                      ( 16'h21E8                  ),
    .QPLL_LPF                           ( 4'b1111                   ),
    .QPLL_REFCLK_DIV                    ( 1                         )
    )
gtxe2_common_i(
    //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
    .DRPADDR                            ( tied_to_ground_vec_i[7:0] ),
    .DRPCLK                             ( tied_to_ground_i          ),
    .DRPDI                              ( tied_to_ground_vec_i[15:0]),
    .DRPDO                              ( ),
    .DRPEN                              ( tied_to_ground_i          ),
    .DRPRDY                             ( ),
    .DRPWE                              ( tied_to_ground_i          ),
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    .GTGREFCLK                          ( tied_to_ground_i          ),
    .GTNORTHREFCLK0                     ( tied_to_ground_i          ),
    .GTNORTHREFCLK1                     ( tied_to_ground_i          ),
    .GTREFCLK0                          ( GT0_GTREFCLK0_COMMON      ),
    .GTREFCLK1                          ( tied_to_ground_i          ),
    .GTSOUTHREFCLK0                     ( tied_to_ground_i          ),
    .GTSOUTHREFCLK1                     ( tied_to_ground_i          ),
    //----------------------- Common Block - QPLL Ports ------------------------
    .QPLLDMONITOR                       ( ),
    .QPLLFBCLKLOST                      ( ),
    .QPLLLOCK                           ( GT0_QPLLLOCK_OUT          ),
    .QPLLLOCKDETCLK                     ( GT0_QPLLLOCKDETCLK        ),
    .QPLLLOCKEN                         ( tied_to_vcc_i             ),
    .QPLLOUTCLK                         ( GT0_QPLLCLK_QUAD2         ),
    .QPLLOUTREFCLK                      ( GT0_QPLLREFCLK_QUAD2      ),
    .QPLLOUTRESET                       ( tied_to_ground_i          ),
        .QPLLPD                         (tied_to_vcc_i),
    .QPLLREFCLKLOST                     ( GT0_QPLLREFCLKLOST        ),
    .QPLLREFCLKSEL                      ( 3'b001                    ),
    .QPLLRESET                          ( GT0_QPLLRESET             ),
    .QPLLRSVD1                          ( 16'b0000000000000000      ),
    .QPLLRSVD2                          ( 5'b11111                  ),
    .REFCLKOUTMONITOR                   ( ),
    //--------------------------- Common Block Ports ---------------------------
    .BGBYPASSB                          ( tied_to_vcc_i             ),
    .BGMONITORENB                       ( tied_to_vcc_i             ),
    .BGPDB                              ( tied_to_vcc_i             ),
    .BGRCALOVRD                         ( 5'b00000                  ),
    .PMARSVD                            ( 8'b00000000               ),
    .RCALENB                            ( tied_to_vcc_i             )
    );

//__________________________________________________________________
//__________________________________________________________________
//_________________________GTXE2_COMMON_____________________________

GTXE2_COMMON #(
    // Simulation attributes
    .SIM_RESET_SPEEDUP                  ( "TRUE"                    ),
    .SIM_QPLLREFCLK_SEL                 ( 3'b001                    ),
    .SIM_VERSION                        ( "4.0"                     ), 
    //----------------COMMON BLOCK Attributes---------------
    .BIAS_CFG                           ( 64'h0000040000001000      ),
    .COMMON_CFG                         ( 32'h00000000              ),
    .QPLL_CFG                           ( 27'h06801C1               ),
    .QPLL_CLKOUT_CFG                    ( 4'b0000                   ),
    .QPLL_COARSE_FREQ_OVRD              ( 6'b010000                 ),
    .QPLL_COARSE_FREQ_OVRD_EN           ( 1'b0                      ),
    .QPLL_CP                            ( 10'b0000011111            ),
    .QPLL_CP_MONITOR_EN                 ( 1'b0                      ),
    .QPLL_DMONITOR_SEL                  ( 1'b0                      ),
    .QPLL_FBDIV                         ( QPLL_FBDIV_IN             ),
    .QPLL_FBDIV_MONITOR_EN              ( 1'b0                      ),
    .QPLL_FBDIV_RATIO                   ( QPLL_FBDIV_RATIO          ),
    .QPLL_INIT_CFG                      ( 24'h000006                ),
    .QPLL_LOCK_CFG                      ( 16'h21E8                  ),
    .QPLL_LPF                           ( 4'b1111                   ),
    .QPLL_REFCLK_DIV                    ( 1                         )
    )
gtxe2_common_lane1_i(
    //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
    .DRPADDR                            ( tied_to_ground_vec_i[7:0] ),
    .DRPCLK                             ( tied_to_ground_i          ),
    .DRPDI                              ( tied_to_ground_vec_i[15:0]),
    .DRPDO                              ( ),
    .DRPEN                              ( tied_to_ground_i          ),
    .DRPRDY                             ( ),
    .DRPWE                              ( tied_to_ground_i          ),
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    .GTGREFCLK                          ( tied_to_ground_i          ),
    .GTNORTHREFCLK0                     ( tied_to_ground_i          ),
    .GTNORTHREFCLK1                     ( tied_to_ground_i          ),
    .GTREFCLK0                          ( GT1_GTREFCLK0_COMMON      ),
    .GTREFCLK1                          ( tied_to_ground_i          ),
    .GTSOUTHREFCLK0                     ( tied_to_ground_i          ),
    .GTSOUTHREFCLK1                     ( tied_to_ground_i          ),
    //----------------------- Common Block - QPLL Ports ------------------------
    .QPLLDMONITOR                       ( ),
    .QPLLFBCLKLOST                      ( ),
    .QPLLLOCK                           ( GT1_QPLLLOCK              ),
    .QPLLLOCKDETCLK                     ( GT1_QPLLLOCKDETCLK        ),
    .QPLLLOCKEN                         ( tied_to_vcc_i             ),
    .QPLLOUTCLK                         ( GT1_QPLLCLK_QUAD2         ),
    .QPLLOUTREFCLK                      ( GT1_QPLLREFCLK_QUAD2      ),
    .QPLLOUTRESET                       ( tied_to_ground_i          ),
        .QPLLPD                         (tied_to_vcc_i),
    .QPLLREFCLKLOST                     ( GT1_QPLLREFCLKLOST        ),
    .QPLLREFCLKSEL                      ( 3'b001                    ),
    .QPLLRESET                          ( GT1_QPLLRESET             ),
    .QPLLRSVD1                          ( 16'b0000000000000000      ),
    .QPLLRSVD2                          ( 5'b11111                  ),
    .REFCLKOUTMONITOR                   ( ),
    //--------------------------- Common Block Ports ---------------------------
    .BGBYPASSB                          ( tied_to_vcc_i             ),
    .BGMONITORENB                       ( tied_to_vcc_i             ),
    .BGPDB                              ( tied_to_vcc_i             ),
    .BGRCALOVRD                         ( 5'b00000                  ),
    .PMARSVD                            ( 8'b00000000               ),
    .RCALENB                            ( tied_to_vcc_i             )
    );
    
endmodule
