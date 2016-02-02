/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   temp_det.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-09-26  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   temp_det.v
    File tree    :   temp_det.v
\************************************************************************************/

`timescale 1ns/100ps

module temp_det(
    rst_cfg                     ,
    clk_cfg                     ,
    vauxp11                     ,
    vauxn11                     ,
    vauxp12                     ,
    vauxn12                     ,
    //local bus
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_rdata                  ,
    lbus_oe                     ,
    lbus_we                     ,
    lbus_wait_n                 
    );
    
parameter   CBUS_ADDR_WIDTH             = 8                         ;
parameter   CBUS_DATA_WIDTH             = 16                        ;
parameter   U_DLY                       = 1                         ;

//base address is 12'h800
parameter   XADC_TEMP_ADDR              = 8'h00                     ;   //drp addr 0x00
parameter   XADC_VCCINT_ADDR            = 8'h01                     ;   //drp addr 0x01
parameter   XADC_VCCAUX_ADDR            = 8'h02                     ;   //drp addr 0x02
parameter   XADC_VCCBRAM_ADDR           = 8'h06                     ;   //drp addr 0x06
parameter   XADC_RFPOWER_A_ADDR         = 8'h1b                     ;   //drp addr 0x1b
parameter   XADC_RFPOWER_B_ADDR         = 8'h1c                     ;   //drp addr 0x1c

input                                   rst_cfg                     ;
input                                   clk_cfg                     ;
input                                   vauxp11                     ;
input                                   vauxn11                     ;
input                                   vauxp12                     ;
input                                   vauxn12                     ;

//local bus
input   [CBUS_ADDR_WIDTH - 1 : 0]       lbus_addr                   ;
input   [CBUS_DATA_WIDTH - 1 : 0]       lbus_wdata                  ;
output  [CBUS_DATA_WIDTH - 1 : 0]       lbus_rdata                  ;
input                                   lbus_oe                     ;
input                                   lbus_we                     ;
output                                  lbus_wait_n                 ;

reg     [CBUS_DATA_WIDTH - 1 : 0]       lbus_rdata                  ;

//drp interface
wire    [6:0]                           drp_addr                    ;
wire                                    drp_en                      ;
wire    [15:0]                          drp_di                      ;
wire                                    drp_we                      ;
wire    [15:0]                          drp_do                      ;
wire                                    drp_rdy_out                 ;

assign  drp_en  =   lbus_oe;
assign  drp_we  =   1'b0;
assign  drp_addr=   lbus_addr[6:0];
assign  drp_di  =   16'h0000;

assign  lbus_wait_n =   1'b1;

//local bus read
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_rdata      <=  16'h0000;
    end
    else if(drp_rdy_out==1'b1)
    begin
        //case(lbus_addr)
        //XADC_TEMP_ADDR      :   lbus_rdata  <=  #U_DLY drp_do;
        //XADC_VCCINT_ADDR    :   lbus_rdata  <=  #U_DLY drp_do;
        //XADC_VCCAUX_ADDR    :   lbus_rdata  <=  #U_DLY drp_do;
        //XADC_VCCBRAM_ADDR   :   lbus_rdata  <=  #U_DLY drp_do;
        //default:;
        //endcase
        lbus_rdata  <=  #U_DLY drp_do;
    end
end

//xadc temprature detect
xadc u0_xadc(
    .DCLK_IN                            ( clk_cfg                   ),
    .RESET_IN                           ( rst_cfg                   ),
    .VAUXP11                            ( vauxp11                   ),
    .VAUXN11                            ( vauxn11                   ),
    .VAUXP12                            ( vauxp12                   ),
    .VAUXN12                            ( vauxn12                   ),
    .DADDR_IN                           ( drp_addr                  ),
    .DEN_IN                             ( drp_en                    ),
    .DI_IN                              ( drp_di                    ),
    .DWE_IN                             ( drp_we                    ),
    .DO_OUT                             ( drp_do                    ),
    .DRDY_OUT                           ( drp_rdy_out               ),
    .ALARM_OUT                          ( /*not used*/              ),
    .VP_IN                              ( 1'b0                      ),
    .VN_IN                              ( 1'b0                      )
    ); 
       
endmodule
