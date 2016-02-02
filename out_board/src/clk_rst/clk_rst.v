/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   clk_rst.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-23  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   clk_rst.v
    File tree    :   clk_rst.v                        
\************************************************************************************/

`timescale 1ns/100ps
    
module clk_rst(
    //27MHz clock
    clk_in                      ,
    rst_in                      , 
    //output
    spi_clk                     ,
    spi_rst                     ,
    clk_27m                     ,
    rst_27m                     ,
    clk_cfg                     ,
    rst_cfg                     ,
    ddr3_ref_clk                ,
    ddr3_ref_rst
    );

parameter   U_DLY                       = 0                         ;   //Unit

input                                   clk_in                      ;
input                                   rst_in                      ;

output                                  spi_clk                     ;
output                                  spi_rst                     ;
output                                  clk_27m                     ;
output                                  rst_27m                     ;
output                                  clk_cfg                     ;
output                                  rst_cfg                     ;
output                                  ddr3_ref_clk                ;
output                                  ddr3_ref_rst                ;

pll_27m u0_pll_27m(
    .CLK_IN1                            ( clk_in                    ),                
    .CLK_OUT1                           ( spi_clk                   ),  //10M
    .CLK_OUT2                           ( clk_27m                   ),  //27M
    .CLK_OUT3                           ( clk_cfg                   ),  //100M
    .CLK_OUT4                           ( ddr3_ref_clk              ),  //200M     
    .RESET                              ( rst_in                    ),
    .LOCKED                             ( pll_27m_locked            )
    );
    
rst_sync ddr3_rst_sync(
    .clk                                ( ddr3_ref_clk              ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst_in                    ),
    .reset_out                          ( ddr3_ref_rst              )
    );    

rst_sync spi_rst_sync(
    .clk                                ( spi_clk                   ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst_in                    ),
    .reset_out                          ( spi_rst                   )
    ); 
    
rst_sync rst_27m_sync(
    .clk                                ( clk_27m                   ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst_in                    ),
    .reset_out                          ( rst_27m                   )
    );

rst_sync cfg_rst_sync(
    .clk                                ( clk_cfg                   ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst_in                    ),
    .reset_out                          ( rst_cfg                   )
    ); 
                       
endmodule
