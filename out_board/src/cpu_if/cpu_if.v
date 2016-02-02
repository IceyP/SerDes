/*************************************************************************************\
    Copyright(c) 2014, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  cpu_if.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-11-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  cpu_if.v
    File tree    :  cpu_if.v                        
\************************************************************************************/

`timescale 1ns/1ps

module cpu_if(
    clk                         ,    
    rst                         ,
    cbus_addr                   ,
    cbus_wdata                  ,
    cbus_we                     ,
    cbus_oe                     ,
 
    pkt_counter                 ,
    gtp_err_cnt                 ,
    cbus_rdata                  
    );
 
parameter   CBUS_DATA_WIDTH             = 16                        ;
parameter   CBUS_ADDR_WIDTH             = 8                         ;

parameter   FPGA_VERSION                = 16'h0401                  ;

//base address is 12'h000
parameter   ADDR_VERSION                = 8'h01                     ;
parameter   ADDR_EBI_TEST               = 8'h05                     ;
parameter   ADDR_LED_CTRL               = 8'h03                     ;
parameter   ADDR_INT_CTRL               = 8'h04                     ;
parameter   ADDR_INT_MASK               = 8'h02                     ;
parameter   ADDR_GTP_STATS              = 8'h06                     ;
parameter   ADDR_PKT_CNT                = 8'h07                     ;

input                                   clk                         ;
input                                   rst                         ;
input   [CBUS_ADDR_WIDTH - 1 : 0]       cbus_addr                   ;
inout   [CBUS_DATA_WIDTH - 1 : 0]       cbus_wdata                  ;
input                                   cbus_we                     ;
input                                   cbus_oe                     ;

input   [15:0]                          pkt_counter                 ;
input   [15:0]                          gtp_err_cnt                 ;
output  [CBUS_DATA_WIDTH - 1 : 0]       cbus_rdata                  ;

reg     [CBUS_DATA_WIDTH - 1 : 0]       cbus_rdata                  ;
reg     [CBUS_DATA_WIDTH - 1 : 0]       ebi_test                    ;

//cbus write
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ebi_test        <=  {CBUS_DATA_WIDTH{1'b0}};
    end
    else if(cbus_we)
    begin
        case(cbus_addr)
        ADDR_EBI_TEST:          ebi_test        <=  cbus_wdata;
        default:;
        endcase
    end
end

//cbus read   
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cbus_rdata  <=  {CBUS_DATA_WIDTH{1'b0}};
    end
    else if(cbus_oe==1'b1)
    begin
        case(cbus_addr)
        ADDR_VERSION:       cbus_rdata  <=  FPGA_VERSION;
        ADDR_EBI_TEST:      cbus_rdata  <=  ~ebi_test;
        ADDR_GTP_STATS:     cbus_rdata  <=  gtp_err_cnt;
        ADDR_PKT_CNT:       cbus_rdata  <=  pkt_counter;
        default:;
        endcase
    end
end
    
endmodule   	   
