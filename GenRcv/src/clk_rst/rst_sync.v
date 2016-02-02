/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  rst_sync.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-29  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   rst_sync.v
    File tree    :   rst_sync.v                        
\************************************************************************************/

`timescale 1ps/1ps

module rst_sync #(
    parameter INITIALISE = 2'b11
    )
    (
    input                               reset_in                    ,
    input                               clk                         ,
    input                               enable                      ,
    output                              reset_out
    );

wire                                    reset_stage1                ;
wire                                    reset_stage2                ;

(* ASYNC_REG = "TRUE", RLOC = "X0Y0",  SHREG_EXTRACT = "NO", INIT = "1" *)
FDPE #(
    .INIT                               ( INITIALISE[0]             )
    ) 
reset_sync1(
    .C                                  ( clk                       ), 
    .CE                                 ( enable                    ),
    .PRE                                ( reset_in                  ),
    .D                                  ( 1'b0                      ),
    .Q                                  ( reset_stage1              ) 
    );
  
(* ASYNC_REG = "TRUE", RLOC = "X0Y0",  SHREG_EXTRACT = "NO", INIT = "1" *)
FDPE #(
    .INIT                               ( INITIALISE[1]             )
    ) 
reset_sync2 (
    .C                                  ( clk                       ), 
    .CE                                 ( enable                    ),
    .PRE                                ( reset_in                  ),
    .D                                  ( reset_stage1              ),
    .Q                                  ( reset_stage2              ) 
    );


assign  reset_out   =   reset_stage2;

endmodule
