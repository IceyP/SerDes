/*************************************************************************************\
    Copyright(c) 2014, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  ebi_demux.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-11-12  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  ebi_demux.v
    File tree    :  ebi_demux.v                        
\************************************************************************************/

`timescale 1ns/1ps

module ebi_demux(
    clk                         ,
    rst                         ,
    lbus_addr                   ,
    lbus_data                   ,
    lbus_cs_n                   ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    lbus_wait_n                 ,
    
    cpu_lbus_rdata              ,
    cpu_lbus_addr               ,
    cpu_lbus_wdata              ,
    cpu_lbus_oe                 ,
    cpu_lbus_we                    
    );                          
                                
parameter   P_BUS_ADDR_WIDTH            = 12                        ;  
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   CBUS_ADDR_WIDTH             = 8                         ;
parameter   CBUS_DATA_WIDTH             = 16                        ;

parameter   BASE_ADDR_CPU               = 4'h7                      ;
    
input                                   clk                         ;
input                                   rst                         ;
input   [P_BUS_ADDR_WIDTH-1:0]          lbus_addr                   ;            
inout   [P_BUS_DATA_WIDTH-1:0]          lbus_data                   ;           
input                                   lbus_cs_n                   ;            
input                                   lbus_oe_n                   ;           
input                                   lbus_we_n                   ;            
output                                  lbus_wait_n                 ;   

input   [CBUS_DATA_WIDTH-1:0]           cpu_lbus_rdata              ;
output  [CBUS_ADDR_WIDTH-1:0]           cpu_lbus_addr               ;
output  [CBUS_DATA_WIDTH-1:0]           cpu_lbus_wdata              ;
output                                  cpu_lbus_oe                 ;
output                                  cpu_lbus_we                 ;

reg                                     lbus_oe_n_1dly              ;
reg                                     lbus_oe_n_2dly              ;
reg                                     lbus_oe_n_3dly              ;
reg                                     lbus_oe_n_4dly              ;
reg                                     lbus_we_n_1dly              ;
reg                                     lbus_we_n_2dly              ;
reg                                     lbus_we_n_3dly              ;
reg                                     lbus_we_n_4dly              ;
reg                                     lbus_cs_n_1dly              ;
reg                                     lbus_cs_n_2dly              ;

wire                                    lbus_oe_valid               ;
wire                                    lbus_we_valid               ;
reg                                     lbus_oe                     ;
reg                                     lbus_we                     ;
reg     [P_BUS_DATA_WIDTH-1:0]          lbus_data_buf               ;

reg     [CBUS_ADDR_WIDTH - 1 : 0]       cpu_lbus_addr               ;
reg     [CBUS_DATA_WIDTH - 1 : 0]       cpu_lbus_wdata              ;
reg                                     cpu_lbus_we                 ;
reg                                     cpu_lbus_oe                 ;

assign  lbus_wait_n     =   1'b1;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin 
        lbus_oe_n_1dly  <=  1'b1; 
        lbus_oe_n_2dly  <=  1'b1;   
        lbus_oe_n_3dly  <=  1'b1; 
        lbus_oe_n_4dly  <=  1'b1;            
        lbus_we_n_1dly  <=  1'b1;                 
        lbus_we_n_2dly  <=  1'b1;
        lbus_we_n_3dly  <=  1'b1;
        lbus_we_n_4dly  <=  1'b1;
        lbus_cs_n_1dly  <=  1'b1;
        lbus_cs_n_2dly  <=  1'b1;
    end  
    else 
    begin
        lbus_oe_n_1dly  <=  lbus_oe_n;
        lbus_oe_n_2dly  <=  lbus_oe_n_1dly;
        lbus_oe_n_3dly  <=  lbus_oe_n_2dly;
        lbus_oe_n_4dly  <=  lbus_oe_n_3dly;
        lbus_we_n_1dly  <=  lbus_we_n;
        lbus_we_n_2dly  <=  lbus_we_n_1dly;
        lbus_we_n_3dly  <=  lbus_we_n_2dly;
        lbus_we_n_4dly  <=  lbus_we_n_3dly;
        lbus_cs_n_1dly  <=  lbus_cs_n;
        lbus_cs_n_2dly  <=  lbus_cs_n_1dly;
    end
end

assign  lbus_oe_valid   =   (~lbus_oe_n_3dly) & lbus_oe_n_4dly & (~lbus_cs_n_2dly);
assign  lbus_we_valid   =   (~lbus_we_n_3dly) & lbus_we_n_4dly & (~lbus_cs_n_2dly);

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin 
        lbus_oe <=  1'b0;
        lbus_we <=  1'b0;
    end
    else
    begin
        lbus_oe <=  lbus_oe_valid;
        lbus_we <=  lbus_we_valid;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cpu_lbus_addr       <=  {CBUS_ADDR_WIDTH{1'b0}};
        cpu_lbus_wdata      <=  {CBUS_DATA_WIDTH{1'b0}};
        cpu_lbus_we         <=  1'b0;
        cpu_lbus_oe         <=  1'b0;
    end
    else if(lbus_we | lbus_oe==1'b1)
    begin
        cpu_lbus_we         <=  1'b0;
        cpu_lbus_oe         <=  1'b0;
        case(lbus_addr[P_BUS_ADDR_WIDTH-1 : CBUS_ADDR_WIDTH])
        BASE_ADDR_CPU,4'h0:
        begin
            cpu_lbus_addr       <=  lbus_addr[CBUS_ADDR_WIDTH - 1 : 0];
            cpu_lbus_wdata      <=  lbus_data;
            cpu_lbus_we         <=  lbus_we;
            cpu_lbus_oe         <=  lbus_oe;
        end
        default:;
        endcase
    end
    else
    begin
        cpu_lbus_we     <=  1'b0;
        cpu_lbus_oe     <=  1'b0;
    end
end
 
always@*
begin
    if((lbus_oe_n | lbus_cs_n)==1'b0)
    begin
        case(lbus_addr[11:8])
        BASE_ADDR_CPU,4'h0:      lbus_data_buf   =   cpu_lbus_rdata;
        default:            lbus_data_buf   =   {P_BUS_DATA_WIDTH{1'b0}};
        endcase
    end
    else
    begin
        lbus_data_buf   =   16'hzzzz;
    end
end

assign  lbus_data   =   lbus_data_buf;

endmodule   	   
