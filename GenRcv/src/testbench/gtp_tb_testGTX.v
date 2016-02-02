/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gtp_tb.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-12-10  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gtp_tb.v
    File tree    :   gtp_tb.v
\************************************************************************************/

`timescale 1ns/100ps

module gtp_tb;

reg                                     rst                         ;
reg                                     clk_27m                     ;
reg                                     mgt_refclk_n_1              ;
reg                                     mgt_refclk_n_2              ;
reg                                     mgt_refclk_n_3              ;

wire                                    mgt_refclk_p_1              ;
wire                                    mgt_refclk_p_2              ;
wire                                    mgt_refclk_p_3              ;
wire                                    mgt_txp_ncas1000            ;
wire                                    mgt_txn_ncas1000            ;
wire                                    mgt_rxp_ncas1000            ;
wire                                    mgt_rxn_ncas1000            ;

wire                                    mgt_txp_ncas1001            ;
wire                                    mgt_txn_ncas1001            ;
wire                                    mgt_rxp_ncas1001            ;
wire                                    mgt_rxn_ncas1001            ;

wire    [5:0]                           mgt_txp_masterboard         ;
wire    [5:0]                           mgt_txn_masterboard         ;
wire    [5:0]                           mgt_rxp_masterboard         ;
wire    [5:0]                           mgt_rxn_masterboard         ;

wire                                    lbus_data                   ;

initial
begin
    rst =   1'b1;
    #200
    rst =   1'b0;
end

initial
    clk_27m     =   1'b0;
always
    clk_27m     =   # 19 ~clk_27m;

initial
    mgt_refclk_n_1  =   1'b0;
always
    # 8 mgt_refclk_n_1  =   ~mgt_refclk_n_1;
    
assign  mgt_refclk_p_1  =   ~mgt_refclk_n_1;

//------------------------------------------------------------------
initial
    mgt_refclk_n_2  =   1'b0;
always
    # 8 mgt_refclk_n_2  =   ~mgt_refclk_n_2;
    
assign  mgt_refclk_p_2  =   ~mgt_refclk_n_2;

//------------------------------------------------------------------
initial
    mgt_refclk_n_3  =   1'b0;
always
    # 8 mgt_refclk_n_3  =   ~mgt_refclk_n_3;
    
assign  mgt_refclk_p_3  =   ~mgt_refclk_n_3;

ncas1000_top u0_ncas1000_top(
    .rst_n                              ( ~rst                      ), 
    .clk_27m                            ( clk_27m                   ), 
    .arm_spi_miso                       ( /*not used*/              ), 
    .arm_spi_mosi                       ( 1'b0                      ), 
    .arm_spi_cs                         ( 1'b0                      ), 
    .arm_spi_clk                        ( 1'b0                      ), 
    .gpio_test                          ( /*not used*/              ), 
    .gpio_if                            ( /*not used*/              ), 
    .led_panel                          ( /*not used*/              ), 
    .io_am3359                          ( /*not used*/              ), 
    .gpio_led                           ( /*not used*/              ), 
    .phy_link                           ( 2'b00                     ), 
    .phy_act                            ( 2'b00                     ), 
    .am3359_gpmc_dir                    ( /*not used*/              ),  
    .am3359_gpmc_clk                    ( 1'b0                      ), 
    .lbus_addr                          ( 12'b0                     ), 
    .lbus_data                          ( lbus_data                 ), 
    .lbus_cs_n                          ( 1'b1                      ), 
    .lbus_oe_n                          ( 1'b1                      ), 
    .lbus_we_n                          ( 1'b1                      ), 
    .lbus_int                           ( /*not used*/              ), 
    .lbus_wait_n                        ( /*not used*/              ),
    .mgt_txp                            ( mgt_txp_ncas1000          ), 
    .mgt_txn                            ( mgt_txn_ncas1000          ), 
    .mgt_rxp                            ( mgt_rxp_ncas1000          ), 
    .mgt_rxn                            ( mgt_rxn_ncas1000          ), 
    .mgt_refclk_p                       ( mgt_refclk_p_1            ), 
    .mgt_refclk_n                       ( mgt_refclk_n_1            )
    );

mainboard_top u0_mainboard_top(
    .rst_n                              ( ~rst                      ), 
    .clk_27m                            ( clk_27m                   ), 
    .mgt_txp                            ( mgt_txp_masterboard       ), 
    .mgt_txn                            ( mgt_txn_masterboard       ), 
    .mgt_rxp                            ( mgt_rxp_masterboard       ), 
    .mgt_rxn                            ( mgt_rxn_masterboard       ), 
    .mgt_refclk_p                       ( mgt_refclk_p_2            ), 
    .mgt_refclk_n                       ( mgt_refclk_n_2            ), 
    .led_out                            ( /*not used*/              )
    );

ncas1000_top u1_ncas1000_top(
    .rst_n                              ( ~rst                      ), 
    .clk_27m                            ( clk_27m                   ), 
    .arm_spi_miso                       ( /*not used*/              ), 
    .arm_spi_mosi                       ( 1'b0                      ), 
    .arm_spi_cs                         ( 1'b0                      ), 
    .arm_spi_clk                        ( 1'b0                      ), 
    .gpio_test                          ( /*not used*/              ), 
    .gpio_if                            ( /*not used*/              ), 
    .led_panel                          ( /*not used*/              ), 
    .io_am3359                          ( /*not used*/              ), 
    .gpio_led                           ( /*not used*/              ), 
    .phy_link                           ( 2'b00                     ), 
    .phy_act                            ( 2'b00                     ), 
    .am3359_gpmc_dir                    ( /*not used*/              ),  
    .am3359_gpmc_clk                    ( 1'b0                      ), 
    .lbus_addr                          ( 12'b0                     ), 
    .lbus_data                          ( lbus_data                 ), 
    .lbus_cs_n                          ( 1'b1                      ), 
    .lbus_oe_n                          ( 1'b1                      ), 
    .lbus_we_n                          ( 1'b1                      ), 
    .lbus_int                           ( /*not used*/              ), 
    .lbus_wait_n                        ( /*not used*/              ),
    .mgt_txp                            ( mgt_txp_ncas1001          ), 
    .mgt_txn                            ( mgt_txn_ncas1001          ), 
    .mgt_rxp                            ( mgt_rxp_ncas1001          ), 
    .mgt_rxn                            ( mgt_rxn_ncas1001          ), 
    .mgt_refclk_p                       ( mgt_refclk_p_3            ), 
    .mgt_refclk_n                       ( mgt_refclk_n_3            )
    );
    
assign  mgt_rxp_ncas1000    =   mgt_txp_masterboard[0];
assign  mgt_rxn_ncas1000    =   mgt_txn_masterboard[0];
assign  mgt_rxp_ncas1001    =   mgt_txp_masterboard[3];
assign  mgt_rxn_ncas1001    =   mgt_txn_masterboard[3];

assign  mgt_rxp_masterboard =   {2'b00,mgt_txp_ncas1001,2'b00,mgt_txp_ncas1000};
assign  mgt_rxn_masterboard =   {2'b00,mgt_txn_ncas1001,2'b00,mgt_txn_ncas1000};

assign  lbus_data           =   16'hz;
                
initial begin
    $fsdbDumpfile("test_000.fsdb");
    $fsdbDumpvars;
end	

endmodule

