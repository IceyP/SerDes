/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   demo_tb.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-24  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   demo_tb.v
    File tree    :   demo_tb.v
\************************************************************************************/

`timescale 1ns/100ps

module demo_tb;

parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;

parameter   XADC_TEMP_ADDR              = 12'h800                   ;   //drp addr 0x00
parameter   XADC_VCCINT_ADDR            = 12'h801                   ;   //drp addr 0x01
parameter   XADC_VCCAUX_ADDR            = 12'h802                   ;   //drp addr 0x02

reg                                     clk_cfg                     ;
reg                                     rstn_cfg                    ;
reg     [15:0]                          lbus_addr                   ;
reg     [15:0]                          lbus_wdata                  ;
reg                                     lbus_cs_n                   ;
reg                                     lbus_oe_n                   ;
reg                                     lbus_we_n                   ;

wire    [15:0]                          lbus_data                   ;
wire                                    lbus_wait_n                 ;
reg     [15:0]                          temp_reg                    ;
reg     [15:0]                          vccint_reg                  ;

//xadc local bus
wire    [P_BUS_ADDR_WIDTH-1:0]          xadc_lbus_addr              ;
wire    [P_BUS_DATA_WIDTH-1:0]          xadc_lbus_wdata             ;
wire    [P_BUS_DATA_WIDTH-1:0]          xadc_lbus_rdata             ;
wire                                    xadc_lbus_oe_n              ;
wire                                    xadc_lbus_we_n              ;
wire                                    xadc_lbus_wait_n            ;

initial
begin
    rstn_cfg    =   1'b0;
    #200
    rstn_cfg    =   1'b1;
end

initial
    clk_cfg =   1'b0;
always
    clk_cfg =   # 5 ~clk_cfg;
    
assign lbus_data = (~lbus_we_n) ? lbus_wdata : 'hz;

task cpu_wr;
    input   [15:0]  cpu_waddr;
    input   [15:0]  cpu_wdata;
    begin
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b0;
        lbus_we_n    =   1'b0;
        lbus_addr    =   cpu_waddr;
        //lbus_wdata   =   cpu_wdata;
        lbus_wdata    =   cpu_wdata;
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b1;
        lbus_we_n    =   1'b1; 
    end
endtask

task cpu_rd;
    input   [15:0]  cpu_raddr;
    output  [15:0]  cpu_rdata;
    reg     [15:0]  cpu_rdata;
    begin
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b0;
        lbus_oe_n    =   1'b0;
        lbus_addr    =   cpu_raddr; 
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);             //????????????????????????????????????????????????????see lbus timing
        @(posedge clk_cfg);             //????????????????????????????????????????????????????see lbus timing
        //while (lbus_wait_n == 1'b0)
        //    @(posedge clk_cfg);
        wait(lbus_wait_n==1'b1);
        cpu_rdata    =   lbus_data;
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b1;
        lbus_oe_n    =   1'b1;
    end
endtask

initial
begin
    lbus_cs_n   =   1'b1;
    lbus_oe_n   =   1'b1;
    lbus_we_n   =   1'b1;
    lbus_addr   =   {16{1'b0}};
    lbus_wdata  =   {16{1'b0}};
    #500
    cpu_rd(XADC_TEMP_ADDR,temp_reg);
    cpu_rd(XADC_VCCINT_ADDR,vccint_reg);
end

ebi_interface #(
    .P_BUS_ADDR_WIDTH                   ( P_BUS_ADDR_WIDTH          ),
    .P_BUS_DATA_WIDTH                   ( P_BUS_DATA_WIDTH          )
    ) 
u0_cpu_if(
    //Bus port for configuration
    .lbus_clk                           ( clk_cfg                   ),
    .lbus_rst                           ( rstn_cfg                  ),
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_data                          ( lbus_data                 ),
    .lbus_cs_n                          ( lbus_cs_n                 ),
    .lbus_oe_n                          ( lbus_oe_n                 ),
    .lbus_we_n                          ( lbus_we_n                 ),
    .lbus_int                           (                           ),
    .lbus_wait_n                        ( lbus_wait_n               ),
    //gbe cbus 
    .gbe_lbus_addr                      (                           ),
    .gbe_lbus_wdata                     (                           ),
    .gbe_lbus_rdata                     ( 16'h0000                  ),
    .gbe_lbus_wait_n                    ( 1'b1                      ),
    .gbe_lbus_int                       ( 1'b0                      ),
    .gbe_lbus_we_n                      (                           ),
    .gbe_lbus_oe_n                      (                           ),
    //ddr cbus
    .ddr_lbus_addr                      (                           ),
    .ddr_lbus_wdata                     (                           ),
    .ddr_lbus_rdata                     ( 16'h0000                  ),
    .ddr_lbus_wait_n                    ( 1'b0                      ),
    .ddr_lbus_we_n                      (                           ),
    .ddr_lbus_oe_n                      (                           ),
    //ts process cbus                     
    .ts_lbus_addr                       (                           ),
    .ts_lbus_wdata                      (                           ),
    .ts_lbus_rdata                      ( 16'h0000                  ),
    .ts_lbus_wait_n                     ( 1'b1                      ),
    .ts_lbus_int                        ( 1'b0                      ),
    .ts_lbus_we_n                       (                           ),
    .ts_lbus_oe_n                       (                           ),
    //xadc cbus
    .xadc_lbus_addr                     ( xadc_lbus_addr            ),
    .xadc_lbus_wdata                    ( xadc_lbus_wdata           ),
    .xadc_lbus_rdata                    ( xadc_lbus_rdata           ),
    .xadc_lbus_wait_n                   ( xadc_lbus_wait_n          ),
    .xadc_lbus_we_n                     ( xadc_lbus_we_n            ),
    .xadc_lbus_oe_n                     ( xadc_lbus_oe_n            )
    );

temp_det #(
    .P_BUS_ADDR_WIDTH                   ( P_BUS_ADDR_WIDTH          ),
    .P_BUS_DATA_WIDTH                   ( P_BUS_DATA_WIDTH          )
    )
u0_temp_det(
    .clk_cfg                            ( clk_cfg                   ),
    .rst_cfg                            ( ~rstn_cfg                 ),
    //xadc cbus
    .lbus_addr                          ( xadc_lbus_addr            ),
    .lbus_wdata                         ( xadc_lbus_wdata           ),
    .lbus_rdata                         ( xadc_lbus_rdata           ),
    .lbus_oe_n                          ( xadc_lbus_oe_n            ),
    .lbus_we_n                          ( xadc_lbus_we_n            ),
    .lbus_wait_n                        ( xadc_lbus_wait_n          )
    );
    
initial begin
$fsdbDumpfile("test_000.fsdb");
$fsdbDumpvars;
end	

endmodule

