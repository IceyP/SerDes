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

//ddr3
parameter   DQ_WIDTH                    = 16                        ;
parameter   DQS_WIDTH                   = 1                         ;
parameter   ROW_WIDTH                   = 14                        ;   //1G DDR3:13;2G DDR3:14;
parameter   DDR3_ADDR_WIDTH             = 28                        ;   //1G DDR3:27;2G DDR3:28;
parameter   BANK_WIDTH                  = 3                         ;
parameter   CK_WIDTH                    = 1                         ;
parameter   CKE_WIDTH                   = 1                         ;
parameter   CS_WIDTH                    = 1                         ;
parameter   nCS_PER_RANK                = 1                         ;
parameter   DM_WIDTH                    = 1                         ;
parameter   ODT_WIDTH                   = 1                         ;
parameter   C1_SIMULATION               = "TRUE"                    ;

reg                                     rst                         ;
reg                                     clk_27m                     ;
//reg                                     clk_cfg                     ;
reg                                     mgt_refclk_n_1              ;
reg                                     mgt_refclk_n_2              ;
reg                                     mgt_refclk_n_3              ;

reg     [15:0]                          lbus_addr                   ;
reg     [15:0]                          lbus_wdata                  ;
reg                                     lbus_cs_n                   ;
reg                                     lbus_oe_n                   ;
reg                                     lbus_we_n                   ;
reg                                     lbus_cfg_finished           ;

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

wire    [15:0]                          lbus_data                   ;
wire                                    lbus_wait_n                 ;
wire                                    clk_cfg                     ;
wire                                    rst_cfg                     ;
wire    [15:0]                          lbus_data2                  ;
wire    [15:0]                          lbus_data3                  ;
wire                                    channel_up                  ;


wire    [DQ_WIDTH-1:0]                  ddr3_dq                     ;
wire                                    ddr3_dqs_n                  ;
wire                                    ddr3_dqs_p                  ;
wire                                    ddr3_udqs_n                 ;
wire                                    ddr3_udqs_p                 ;
wire    [ROW_WIDTH-1:0]                 ddr3_addr                   ;
wire    [BANK_WIDTH-1:0]                ddr3_ba                     ;
wire                                    ddr3_ras_n                  ;
wire                                    ddr3_cas_n                  ;
wire                                    ddr3_we_n                   ;
wire                                    ddr3_reset_n                ;
wire                                    ddr3_ck_p                   ;
wire                                    ddr3_ck_n                   ;
wire                                    ddr3_cke                    ;
//wire    [CS_WIDTH*nCS_PER_RANK-1:0]     ddr3_cs_n                   ;
wire                                    ddr3_dm                     ;
wire                                    ddr3_udm                    ;
wire                                    ddr3_odt                    ;
wire                                    ddr3_rzq                    ;
wire                                    ddr3_zio                    ;

wire                                    calib_done                  ;

integer i;

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

//initial
//    clk_cfg     =   1'b0;
//always
//    clk_cfg     =   # 5 ~clk_cfg;

initial
    mgt_refclk_n_1  =   1'b0;
always
    # 4 mgt_refclk_n_1  =   ~mgt_refclk_n_1;
    
assign  mgt_refclk_p_1  =   ~mgt_refclk_n_1;

//------------------------------------------------------------------
initial
    mgt_refclk_n_2  =   1'b0;
always
    # 4 mgt_refclk_n_2  =   ~mgt_refclk_n_2;
    
assign  mgt_refclk_p_2  =   ~mgt_refclk_n_2;

//------------------------------------------------------------------
initial
    mgt_refclk_n_3  =   1'b0;
always
    # 4 mgt_refclk_n_3  =   ~mgt_refclk_n_3;
    
assign  mgt_refclk_p_3  =   ~mgt_refclk_n_3;


//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//---------------------------cpu config---------------------------//
parameter   FPGA_VER                    = 16'h0001                  ;
parameter   ADDR_FPGA_VER               = 12'h001                   ;
parameter   ADDR_EBI_TEST               = 12'h002                   ;
parameter   ADDR_LED_CTRL               = 12'h003                   ;
parameter   ADDR_GTP_LOOPBACK           = 12'h004                   ;

parameter   ADDR_EMM_PKT_DATA           = 12'h100                   ;
parameter   ADDR_EMM_PKT_LEN            = 12'h101                   ;
parameter   ADDR_ECM_PKT_DATA           = 12'h102                   ;
parameter   ADDR_ECM_PID_INDEX          = 12'h103                   ;
parameter   ADDR_ECM_TX_PERIOD          = 12'h104                   ;
parameter   ADDR_RANDOM_DATA            = 12'h105                   ;

assign lbus_data = (~lbus_we_n) ? lbus_wdata : 16'hz;

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
    lbus_cfg_finished   =   1'b0;
    lbus_cs_n   =   1'b1;
    lbus_oe_n   =   1'b1;
    lbus_we_n   =   1'b1;
    lbus_addr   =   {16{1'b0}};
    lbus_wdata  =   {16{1'b0}};
    wait(calib_done==1);
    #7000;
    //scrambling control packet
    cpu_wr(ADDR_EMM_PKT_DATA,16'h8000);//packet type
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0030);//{src_slot[11:8],dst_slot[7:4],chan[3:0]}
    cpu_wr(ADDR_EMM_PKT_DATA,16'h000c);//packet length:12bytes
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0000);//index
    cpu_wr(ADDR_EMM_PKT_DATA,16'h1fff);//scramble pid
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0123);//cw[63:48]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h4567);//cw[47:32]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h89ab);//cw[31:16]
    cpu_wr(ADDR_EMM_PKT_DATA,16'hcdef);//cw[15:0]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h5555);//CRC
    
    cpu_wr(ADDR_EMM_PKT_LEN,16'h0010);//packet length:12+4
    
    #1000;
    
    //ECM packet1
    cpu_wr(ADDR_ECM_PKT_DATA,16'h8001);//packet type
    cpu_wr(ADDR_ECM_PKT_DATA,16'h0030);//{src_slot[11:8],dst_slot[7:4],chan[3:0]}
    cpu_wr(ADDR_ECM_PKT_DATA,16'h00bc);//packet length:188bytes
    cpu_wr(ADDR_ECM_PKT_DATA,16'h4701);//packet data
    for(i=0;i<93;i=i+1)
    begin
        cpu_wr(ADDR_ECM_PKT_DATA,i);//packet data
    end
    cpu_wr(ADDR_ECM_PKT_DATA,16'haaaa);//CRC
    
    cpu_wr(ADDR_ECM_PID_INDEX,16'h03ff);//ECM_PID_INDEX
    cpu_wr(ADDR_ECM_TX_PERIOD,16'h0002);//ECM_TX_PERIOD 20ms
    #1000;
    
    //ECM packet2
    cpu_wr(ADDR_ECM_PKT_DATA,16'h8001);//packet type
    cpu_wr(ADDR_ECM_PKT_DATA,16'h0030);//{src_slot[11:8],dst_slot[7:4],chan[3:0]}
    cpu_wr(ADDR_ECM_PKT_DATA,16'h0178);//packet length:376bytes
    cpu_wr(ADDR_ECM_PKT_DATA,16'h4701);//packet data
    for(i=0;i<187;i=i+1)
    begin
        cpu_wr(ADDR_ECM_PKT_DATA,i);//packet data
    end
    cpu_wr(ADDR_ECM_PKT_DATA,16'haaaa);//CRC
    
    cpu_wr(ADDR_ECM_PID_INDEX,16'h0000);//ECM_PID_INDEX
    cpu_wr(ADDR_ECM_TX_PERIOD,16'h0003);//ECM_TX_PERIOD 30ms
    #1000;
    
    //scrambling control packet
    cpu_wr(ADDR_EMM_PKT_DATA,16'h8000);//packet type
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0030);//{src_slot[11:8],dst_slot[7:4],chan[3:0]}
    cpu_wr(ADDR_EMM_PKT_DATA,16'h000c);//packet length:12bytes
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0000);//index
    cpu_wr(ADDR_EMM_PKT_DATA,16'h1fff);//scramble pid
    cpu_wr(ADDR_EMM_PKT_DATA,16'h0123);//cw[63:48]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h4567);//cw[47:32]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h89ab);//cw[31:16]
    cpu_wr(ADDR_EMM_PKT_DATA,16'hcdef);//cw[15:0]
    cpu_wr(ADDR_EMM_PKT_DATA,16'h5555);//CRC
    
    cpu_wr(ADDR_EMM_PKT_LEN,16'h0010);//packet length:12+4
    
    lbus_cfg_finished   =   1'b1;
end
    
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------

PULLDOWN zio_pulldown1 (.O(ddr3_zio));
PULLDOWN rzq_pulldown1 (.O(ddr3_rzq));

ncas1000_top #(
    .C1_SIMULATION                      ( C1_SIMULATION             )
    )
u0_ncas1000_top(
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
    .lbus_addr                          ( lbus_addr[11:0]           ),  //( {12{1'b0}}                ),  // 
    .lbus_data                          ( lbus_data                 ),  //( lbus_data3                ),  // 
    .lbus_cs_n                          ( lbus_cs_n                 ),  //( 1'b1                      ),  // 
    .lbus_oe_n                          ( lbus_oe_n                 ),  //( 1'b1                      ),  // 
    .lbus_we_n                          ( lbus_we_n                 ),  //( 1'b1                      ),  // 
    .lbus_int                           ( /*not used*/              ), 
    .lbus_wait_n                        ( lbus_wait_n               ),
    .clk_cfg                            ( clk_cfg                   ),
    .rst_cfg                            ( rst_cfg                   ),
    .channel_up                         ( channel_up                ),
    //ddr3
    .ddr3_dq                            ( ddr3_dq                   ),
    .ddr3_dqs_n                         ( ddr3_dqs_n                ),
    .ddr3_dqs_p                         ( ddr3_dqs_p                ),
    .ddr3_udqs_n                        ( ddr3_udqs_n               ),
    .ddr3_udqs_p                        ( ddr3_udqs_p               ),
    .ddr3_addr                          ( ddr3_addr                 ),
    .ddr3_ba                            ( ddr3_ba                   ),
    .ddr3_ras_n                         ( ddr3_ras_n                ),
    .ddr3_cas_n                         ( ddr3_cas_n                ),
    .ddr3_we_n                          ( ddr3_we_n                 ),
    .ddr3_reset_n                       ( ddr3_reset_n              ),
    .ddr3_ck_p                          ( ddr3_ck_p                 ),
    .ddr3_ck_n                          ( ddr3_ck_n                 ),
    .ddr3_cke                           ( ddr3_cke                  ),
//    .ddr3_cs_n                          ( ddr3_cs_n                 ),
    .ddr3_dm                            ( ddr3_dm                   ),
    .ddr3_udm                           ( ddr3_udm                  ),
    .ddr3_odt                           ( ddr3_odt                  ),
    .ddr3_rzq                           ( ddr3_rzq                  ),
    .ddr3_zio                           ( ddr3_zio                  ),
    .calib_done                         ( calib_done                ),
    
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
    .lbus_addr                          ( {12{1'b0}}                ), 
    .lbus_data                          ( lbus_data2                ), 
    .lbus_cs_n                          ( 1'b1                      ), 
    .lbus_oe_n                          ( 1'b1                      ), 
    .lbus_we_n                          ( 1'b1                      ), 
    .lbus_int                           ( /*not used*/              ), 
    .lbus_wait_n                        ( /*not used*/              ),
    .clk_cfg                            ( /*not used*/              ),
    .rst_cfg                            ( /*not used*/              ),
    .channel_up                         ( /*not used*/              ),
    .mgt_txp                            ( mgt_txp_ncas1001          ), 
    .mgt_txn                            ( mgt_txn_ncas1001          ), 
    .mgt_rxp                            ( mgt_rxp_ncas1001          ), 
    .mgt_rxn                            ( mgt_rxn_ncas1001          ), 
    .mgt_refclk_p                       ( mgt_refclk_p_3            ), 
    .mgt_refclk_n                       ( mgt_refclk_n_3            )
    );


ddr3_model_c1 u_mem_c1(
    .ck                                 ( ddr3_ck_p                 ),
    .ck_n                               ( ddr3_ck_n                 ),
    .cke                                ( ddr3_cke                  ),
    .cs_n                               ( 1'b0),
    .ras_n                              ( ddr3_ras_n                ),
    .cas_n                              ( ddr3_cas_n                ),
    .we_n                               ( ddr3_we_n                 ),
    .dm_tdqs                            ( {ddr3_udm,ddr3_dm}        ),
    .ba                                 ( ddr3_ba                   ),
    .addr                               ( ddr3_addr                 ),
    .dq                                 ( ddr3_dq                   ),
    .dqs                                ( {ddr3_udqs_p,ddr3_dqs_p}  ),
    .dqs_n                              ( {ddr3_udqs_n,ddr3_dqs_n}  ),
    .tdqs_n                             ( /*not used*/              ),
    .odt                                ( ddr3_odt                  ),
    .rst_n                              ( ddr3_reset_n              )
    );
      
          
assign  mgt_rxp_ncas1000    =   mgt_txp_masterboard[0];
assign  mgt_rxn_ncas1000    =   mgt_txn_masterboard[0];
assign  mgt_rxp_ncas1001    =   mgt_txp_masterboard[3];
assign  mgt_rxn_ncas1001    =   mgt_txn_masterboard[3];

assign  mgt_rxp_masterboard =   {2'b00,mgt_txp_ncas1001,2'b00,mgt_txp_ncas1000};
assign  mgt_rxn_masterboard =   {2'b00,mgt_txn_ncas1001,2'b00,mgt_txn_ncas1000};

assign  lbus_data2           =   16'hz;
//assign  lbus_data3           =   16'hz;

// ========================================================================== //
// Reporting the test case status 
// ========================================================================== //
   initial
   begin : Logging
      fork
         begin : calibration_done
            wait (calib_done);
            $display("Calibration Done");
            #50000000;
            $display("TEST PASSED");
            disable calib_not_done;
	    $finish;
         end	 
         
         begin : calib_not_done
            #200000000;
            if (!calib_done) begin
               $display("TEST FAILED: INITIALIZATION DID NOT COMPLETE");
            end
            disable calibration_done;
	    $finish;
         end
      join	 
   end      

                
initial begin
    $fsdbDumpfile("test_000.fsdb");
    $fsdbDumpvars;
end	

endmodule

