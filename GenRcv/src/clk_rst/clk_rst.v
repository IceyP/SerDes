/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  clk_rst.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-29  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   clk_rst.v
    File tree    :   clk_rst.v                        
\************************************************************************************/

`timescale 1ns/100ps
    
module clk_rst(
    clk                         ,
    rst                         ,
    rst_cfg_i                   ,
    clk_cfg                     ,
    rst_cfg                     ,
    sys_clk                ,
    sys_rst
    );

parameter   U_DLY                       = 1                         ;

input                                   clk                         ;
input                                   rst                         ;
input                                   rst_cfg_i                   ;
output                                  clk_cfg                     ;
output                                  rst_cfg                     ;
output                                  sys_clk                     ;
output                                  sys_rst                     ;

wire                                    pll_27m_locked              ;

s6_pll_27m u0_pll_27m(
    .CLK_IN1                            ( clk                       ),
    .CLK_OUT1                           ( clk_cfg                   ),
    .CLK_OUT2                           ( sys_clk              ),
    .RESET                              ( rst                       ),
    .LOCKED                             ( pll_27m_locked            )
    );
     
rst_sync u0_rst_sync(
    .clk                                ( clk_cfg                   ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst_cfg_i                 ),
    .reset_out                          ( rst_cfg                   )
    );    

rst_sync u1_rst_sync(
    .clk                                ( sys_clk              ),
    .enable                             ( pll_27m_locked            ),
    .reset_in                           ( rst                       ),
    .reset_out                          ( sys_rst              )
    );
    
endmodule
