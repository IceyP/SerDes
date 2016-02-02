/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  cpu_if.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-15  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  cpu_if.v
    File tree    :  cpu_if.v                        
\************************************************************************************/

`timescale 1ns/1ps

module cpu_if(
    clk_cfg                     ,
    rst_cfg                     ,
    clk_gtp                     ,
    rst_gtp                     ,
    clk_ddr3                    ,
    rst_ddr3                    ,
    phy_link                    ,
    
    emm_pkt_rdy                 ,
    emm_fifo_rden               ,
    emm_fifo_dout               ,
    emm_dataram_raddr           ,
    emm_dataram_rdata           ,
    
    ecm_pkt_index               ,
    ecm_pkt_period              ,
    ecm_pkt_sof                 ,
    ecm_pkt_eof                 ,
    ecm_pkt_data                ,
    ecm_pkt_val                 ,
    ecm_pkt_bp                  ,
    
    ecm_inforam_raddr           ,
    ecm_inforam_rdata           ,
    
    //local bus
    lbus_addr                   ,
    lbus_data                   ,
    lbus_cs_n                   ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    lbus_int                    ,
    lbus_wait_n                 ,
    led_ctrl                    ,
    gtp_test                    ,
    gtp_loopback
    );

parameter   ECM_DATARAM_DEPTHBIT        = 9                         ;
parameter   ECM_DATARAM_WIDTH           = 16                        ;
parameter   ECM_FIFO_DEPTHBIT           = 8                         ;
parameter   ECM_FIFO_WIDTH              = 34                        ;
parameter   ECM_INFORAM_DEPTHBIT        = 10                        ;
parameter   ECM_INFORAM_WIDTH           = 16                        ;

parameter   FPGA_VER                    = 16'h0106                  ;
parameter   ADDR_FPGA_VER               = 12'h001                   ;
parameter   ADDR_EBI_TEST               = 12'h002                   ;
parameter   ADDR_LED_CTRL               = 12'h003                   ;
parameter   ADDR_GTP_LOOPBACK           = 12'h004                   ;
parameter   ADDR_LINK_STATE             = 12'h005                   ;
parameter   ADDR_GTP_TEST               = 12'h006                   ;

parameter   ADDR_EMM_PKT_DATA           = 12'h100                   ;
parameter   ADDR_EMM_PKT_LEN            = 12'h101                   ;
parameter   ADDR_ECM_PKT_DATA           = 12'h102                   ;
parameter   ADDR_ECM_PID_INDEX          = 12'h103                   ;
parameter   ADDR_ECM_TX_PERIOD          = 12'h104                   ;
parameter   ADDR_RANDOM_DATA            = 12'h105                   ;

parameter   ADDR_ECM_WPKT_NUM           = 12'h201                   ;
parameter   ADDR_ECM_RPKT_NUM           = 12'h202                   ;
parameter   ADDR_SCRAMBLER_ENA          = 12'h203                   ;

parameter   ST_ECM_WIDTH                = 4                         ;
parameter   ST_ECM_IDLE                 = 4'b0001                   ,
            ST_ECM_READ_FIFO            = 4'b0010                   ,
            ST_ECM_READ_WAIT            = 4'b0100                   ,
            ST_ECM_READ_DATA            = 4'b1000                   ;

input                                   clk_cfg                     ;
input                                   rst_cfg                     ;
input                                   clk_gtp                     ;
input                                   rst_gtp                     ;
input                                   clk_ddr3                    ;
input                                   rst_ddr3                    ;
input   [1:0]                           phy_link                    ;

output                                  emm_pkt_rdy                 ;
input                                   emm_fifo_rden               ;
output  [17:0]                          emm_fifo_dout               ;
input   [ECM_DATARAM_DEPTHBIT - 1 : 0]  emm_dataram_raddr           ;
output  [ECM_DATARAM_WIDTH - 1 : 0]     emm_dataram_rdata           ;

output  [9:0]                           ecm_pkt_index               ;
output  [5:0]                           ecm_pkt_period              ;
output                                  ecm_pkt_sof                 ;
output                                  ecm_pkt_eof                 ;
output  [ECM_DATARAM_WIDTH - 1 : 0]     ecm_pkt_data                ;
output                                  ecm_pkt_val                 ;
input                                   ecm_pkt_bp                  ;

input   [ECM_INFORAM_DEPTHBIT - 1 : 0]  ecm_inforam_raddr           ;
output  [ECM_INFORAM_WIDTH - 1 : 0]     ecm_inforam_rdata           ;

//local bus
input   [11:0]                          lbus_addr                   ;
inout   [15:0]                          lbus_data                   ;
input                                   lbus_cs_n                   ;
input                                   lbus_oe_n                   ;
input                                   lbus_we_n                   ;
output                                  lbus_int                    ;
output                                  lbus_wait_n                 ;
output  [4:0]                           led_ctrl                    ;
output                                  gtp_test                    ;
output  [2:0]                           gtp_loopback                ;

reg                                     lbus_cs_n_1dly              ;
reg                                     lbus_oe_n_1dly              ;
reg                                     lbus_we_n_1dly              ;
reg                                     lbus_cs_n_2dly              ;
reg                                     lbus_oe_n_2dly              ;
reg                                     lbus_we_n_2dly              ;
reg                                     lbus_oe_n_3dly              ;
reg                                     lbus_we_n_3dly              ;
wire                                    negedge_lbus_we_n           ;
wire                                    negedge_lbus_oe_n           ;
(*KEEP = "TRUE"*)
wire                                    rst_ecm                     ;
(*KEEP = "TRUE"*)
wire                                    rst_emm                     ;
wire                                    ebi_wren                    ;
reg     [15:0]                          lbus_rdata                  ;
reg     [4:0]                           led_ctrl                    ;
reg     [2:0]                           gtp_loopback                ;
reg     [15:0]                          ebi_test                    ;
reg     [9:0]                           ecm_pid_index               ;
reg     [5:0]                           ecm_tx_period               ;
reg     [8:0]                           ecm_pkt_len                 ;
reg     [8:0]                           emm_pkt_len                 ;
reg     [15:0]                          random_data                 ;
//ecm fifo+ram
reg     [ECM_FIFO_WIDTH - 1 : 0]        ecm_fifo_din                ;
wire    [ECM_FIFO_DEPTHBIT - 1 : 0]     ecm_fifo_num                ;
reg                                     ecm_fifo_wren               ;
wire    [ECM_FIFO_WIDTH - 1 : 0]        ecm_fifo_dout               ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_waddr           ;
reg                                     ecm_dataram_wren            ;
reg     [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_wdata           ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_raddr           ;
wire    [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_rdata           ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_start_addr              ;
//ecm infoRAM
wire    [ECM_INFORAM_DEPTHBIT - 1 : 0]  ecm_inforam_waddr           ;
wire                                    ecm_inforam_wren            ;
reg     [ECM_INFORAM_WIDTH - 1 : 0]     ecm_inforam_wdata           ;
wire    [ECM_INFORAM_WIDTH - 1 : 0]     ecm_inforam_rdata           ;
//emm fifo+ram
reg     [ECM_FIFO_WIDTH - 1 : 0]        emm_fifo_din                ;
wire    [ECM_FIFO_DEPTHBIT - 1 : 0]     emm_fifo_num                ;
reg                                     emm_fifo_wren               ;
wire    [ECM_FIFO_WIDTH - 1 : 0]        emm_fifo_dout_buf           ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  emm_dataram_waddr           ;
reg                                     emm_dataram_wren            ;
reg     [ECM_DATARAM_WIDTH - 1 : 0]     emm_dataram_wdata           ;
wire    [ECM_DATARAM_DEPTHBIT - 1 : 0]  emm_dataram_raddr           ;
wire    [ECM_DATARAM_WIDTH - 1 : 0]     emm_dataram_rdata           ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  emm_start_addr              ;
reg                                     emm_pkt_rdy                 ;
//ecm read output
reg     [ST_ECM_WIDTH - 1 : 0]          st_ecm_curr                 ;
reg     [ST_ECM_WIDTH - 1 : 0]          st_ecm_next                 ;
reg                                     wait_cnt                    ;
reg                                     ecm_fifo_rden               ;
reg     [7:0]                           ecm_len_buf                 ;
reg     [7:0]                           rd_cnt                      ;
reg     [9:0]                           ecm_pkt_index               ;
reg     [5:0]                           ecm_pkt_period              ;
reg                                     ecm_pkt_sof                 ;
reg                                     ecm_pkt_eof                 ;
wire                                    ecm_pkt_val                 ;
wire    [ECM_DATARAM_WIDTH - 1 : 0]     ecm_pkt_data                ;
reg     [7:0]                           ecm_word_cnt                ;
reg     [9:0]                           emm_word_cnt                ;
reg     [15:0]                          ecm_wr_pkt_num              ;
reg     [15:0]                          ecm_rd_pkt_num              ;
reg     [15:0]                          ecm_rd_pkt_num_buf          ;
reg     [15:0]                          ecm_rd_pkt_num_buf_1dly     ;
reg                                     scrambler_off               ;
reg     [10:0]                          init_cnt                    ;
reg                                     ram_init                    ;
reg                                     scramble_ena                ;
wire                                    emm_flag                    ;
reg                                     gtp_test                    ;

assign  lbus_wait_n     =   1'b1;
assign  lbus_int        =   1'b0;
assign  rst_ecm         =   rst_cfg | rst_ddr3;
assign  rst_emm         =   rst_cfg | rst_gtp;
assign  ebi_wren        =   negedge_lbus_we_n & (~lbus_cs_n_2dly);
assign  emm_fifo_dout   =   emm_fifo_dout_buf[17:0];
 
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_cs_n_1dly  <=  1'b1;
        lbus_oe_n_1dly  <=  1'b1;
        lbus_we_n_1dly  <=  1'b1;
        lbus_cs_n_2dly  <=  1'b1;
        lbus_oe_n_2dly  <=  1'b1;
        lbus_we_n_2dly  <=  1'b1;
        lbus_oe_n_3dly  <=  1'b1;
        lbus_we_n_3dly  <=  1'b1;
    end
    else
    begin
        lbus_cs_n_1dly  <=  lbus_cs_n;
        lbus_oe_n_1dly  <=  lbus_oe_n;
        lbus_we_n_1dly  <=  lbus_we_n;
        lbus_cs_n_2dly  <=  lbus_cs_n_1dly;
        lbus_oe_n_2dly  <=  lbus_oe_n_1dly;
        lbus_we_n_2dly  <=  lbus_we_n_1dly;
        lbus_oe_n_3dly  <=  lbus_oe_n_2dly;
        lbus_we_n_3dly  <=  lbus_we_n_2dly;
    end
end

assign  negedge_lbus_we_n   =   (~lbus_we_n_2dly) & lbus_we_n_3dly;
assign  negedge_lbus_oe_n   =   (~lbus_oe_n_2dly) & lbus_oe_n_3dly;

////////////////////////////////////////////////////////////////////
//ebi bus read and write
////////////////////////////////////////////////////////////////////
//lbus_write
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ebi_test            <=  16'h0000;
        led_ctrl            <=  {5{1'b0}};
        gtp_loopback        <=  3'b000;
        ecm_dataram_wdata   <=  {ECM_DATARAM_WIDTH{1'b0}};
        ecm_pid_index       <=  {10{1'b0}};
        ecm_tx_period       <=  {6{1'b0}};
        scramble_ena        <=  1'b1;
        gtp_test            <=  1'b0;
    end
    else if(ebi_wren==1'b1)
    begin
        case(lbus_addr)
        ADDR_EBI_TEST:      ebi_test            <=  lbus_data;
        ADDR_LED_CTRL:      led_ctrl            <=  lbus_data[4:0];
        ADDR_GTP_LOOPBACK:  gtp_loopback        <=  lbus_data[2:0];
        ADDR_EMM_PKT_DATA:  emm_dataram_wdata   <=  lbus_data;
        ADDR_EMM_PKT_LEN:   emm_pkt_len         <=  lbus_data[8:0];
        ADDR_ECM_PKT_DATA:  ecm_dataram_wdata   <=  lbus_data;
        ADDR_ECM_PID_INDEX: ecm_pid_index       <=  lbus_data[9:0];
        ADDR_ECM_TX_PERIOD: ecm_tx_period       <=  lbus_data[5:0];
        ADDR_SCRAMBLER_ENA: scramble_ena        <=  lbus_data[0];
        ADDR_GTP_TEST:      gtp_test            <=  lbus_data[0];
        default:;
        endcase
    end
end

////////////////////////////////////////////////////////////////////
//scrambler off
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        scrambler_off   <=  1'b0;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_SCRAMBLER_ENA) && (lbus_data[0]==1'b0))
    begin
        scrambler_off   <=  1'b1;
    end
    else
    begin
        scrambler_off   <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ram_init    <=  1'b0;
    end
    else if(scrambler_off==1'b1)
    begin
        ram_init    <=  1'b1;
    end
    else if(init_cnt[10]==1'b1)
    begin
        ram_init    <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        init_cnt    <=  {11{1'b0}};
    end
    else if(scrambler_off==1'b1)
    begin
        init_cnt    <=  {{10{1'b0}},1'b1};
    end
    else if(init_cnt[10]==1'b1)
    begin
        init_cnt    <=  {11{1'b0}};
    end
    else if(init_cnt>0)
    begin
        init_cnt    <=  init_cnt + 'h1;
    end
end
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_word_cnt    <=  8'h00;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_ECM_PKT_DATA))
    begin
        ecm_word_cnt    <=  ecm_word_cnt + 'h1;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_ECM_TX_PERIOD))
    begin
        ecm_word_cnt    <=  8'h00;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_word_cnt    <=  {10{1'b0}};
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_EMM_PKT_DATA))
    begin
        emm_word_cnt    <=  emm_word_cnt + 'h1;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_EMM_PKT_LEN))
    begin
        emm_word_cnt    <=  {10{1'b0}};
    end
end
        
//lbus_read       
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_rdata  <=  16'h0000;
        random_data <=  {16{1'b0}};
    end
    else if((negedge_lbus_oe_n==1'b1) && (lbus_cs_n_2dly==1'b0))
    begin
        case(lbus_addr)
        ADDR_FPGA_VER:      lbus_rdata  <=  FPGA_VER;
        ADDR_EBI_TEST:      lbus_rdata  <=  ~ebi_test;
        ADDR_LED_CTRL:      lbus_rdata  <=  {{11{1'b0}},led_ctrl[4:0]};
        ADDR_GTP_LOOPBACK:  lbus_rdata  <=  {{13{1'b0}},gtp_loopback[2:0]};
        ADDR_RANDOM_DATA:   
        begin
            random_data <=  random_data + 'h1;
            lbus_rdata  <=  random_data;
        end
        ADDR_ECM_WPKT_NUM:  lbus_rdata  <=  ecm_wr_pkt_num;
        ADDR_ECM_RPKT_NUM:  lbus_rdata  <=  ecm_rd_pkt_num;
        ADDR_LINK_STATE:    lbus_rdata  <=  {{14{1'b0}},phy_link[1:0]};
        default:;
        endcase
    end
end
        
assign  lbus_data   =   ((lbus_oe_n==1'b0) && (lbus_cs_n==1'b0))   ?   lbus_rdata  :   16'hzzzz;

////////////////////////////////////////////////////////////////////
//ecm fifo+ram read and write
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_dataram_waddr   <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if(ecm_dataram_wren==1'b1)
    begin
        ecm_dataram_waddr   <=  ecm_dataram_waddr + 'h1;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_dataram_wren    <=  1'b0;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_ECM_PKT_DATA))
    begin
        ecm_dataram_wren    <=  1'b1;
    end
    else
    begin
        ecm_dataram_wren    <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_fifo_wren   <=  1'b0;
    end
    else if((ebi_wren==1'b1) && (scramble_ena==1'b1) &&
            (lbus_addr==ADDR_ECM_TX_PERIOD) && (ecm_pkt_len>0) && 
            ((ecm_word_cnt==98) || (ecm_word_cnt==192)))
    begin
        ecm_fifo_wren   <=  1'b1;
    end
    else
    begin
        ecm_fifo_wren   <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_start_addr  <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if((ebi_wren==1'b1) && 
            (lbus_addr==ADDR_ECM_TX_PERIOD) && (ecm_pkt_len>0) &&
            ((ecm_word_cnt==98) || (ecm_word_cnt==192)))
    begin
        ecm_start_addr  <=  ecm_dataram_waddr;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_pkt_len <=  {9{1'b0}};
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_ECM_PKT_DATA))
    begin
        ecm_pkt_len <=  ecm_pkt_len + 'h2;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_ECM_TX_PERIOD))
    begin
        ecm_pkt_len <=  {9{1'b0}};
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
    else if((ebi_wren==1'b1) && 
            (lbus_addr==ADDR_ECM_TX_PERIOD) && (ecm_pkt_len>0) &&
            ((ecm_word_cnt==98) || (ecm_word_cnt==192)))
    begin
        ecm_fifo_din    <=  {ecm_pid_index[9:0],lbus_data[5:0],ecm_pkt_len[8:0],ecm_start_addr[ECM_DATARAM_DEPTHBIT - 1 : 0]};
    end
    else
    begin
        ecm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
end
  
////////////////////////////////////////////////////////////////////
//ecm infoRAM read and write
////////////////////////////////////////////////////////////////////
assign  ecm_inforam_wren    =   ram_init | ecm_fifo_wren;
assign  ecm_inforam_waddr   =   (ram_init==1'b1)    ?   (init_cnt[9:0] - 10'h1)   :   ecm_pid_index;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_inforam_wdata   <=  {ECM_INFORAM_WIDTH{1'b0}};
    end
    else if((ram_init==1'b1) || (scrambler_off==1'b1))
    begin
        ecm_inforam_wdata   <=  {ECM_INFORAM_WIDTH{1'b0}};
    end
    else if((ebi_wren==1'b1) && 
            (lbus_addr==ADDR_ECM_TX_PERIOD) && (ecm_pkt_len>0) &&
            ((ecm_word_cnt==98) || (ecm_word_cnt==192)))
    begin
        ecm_inforam_wdata   <=  {ecm_pid_index[9:0],lbus_data[5:0]};
    end
    else
    begin
        ecm_inforam_wdata   <=  {ECM_INFORAM_WIDTH{1'b0}};
    end
end

////////////////////////////////////////////////////////////////////
//emm fifo+ram read and write
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_dataram_waddr   <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if(emm_dataram_wren==1'b1)
    begin
        emm_dataram_waddr   <=  emm_dataram_waddr + 'h1;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_dataram_wren    <=  1'b0;
    end
    else if((ebi_wren==1'b1) && (lbus_addr==ADDR_EMM_PKT_DATA))
    begin
        emm_dataram_wren    <=  1'b1;
    end
    else
    begin
        emm_dataram_wren    <=  1'b0;
    end
end

assign  emm_flag    =   ((emm_word_cnt==98) || (emm_word_cnt==192) || 
                        (emm_word_cnt==286) || (emm_word_cnt==380) ||
                        (emm_word_cnt==474) || (emm_word_cnt==568) ||
                        (emm_word_cnt==662) || (emm_word_cnt==756)) ?   1'b1    :   1'b0;
                        
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_fifo_wren   <=  1'b0;
    end
    else if((ebi_wren==1'b1) && (scramble_ena==1'b1) &&
            (lbus_addr==ADDR_EMM_PKT_LEN) && ((|lbus_data[8:0])==1'b1) &&
            ((emm_word_cnt==10) || (emm_flag==1'b1)))
    begin
        emm_fifo_wren   <=  1'b1;
    end
    else
    begin
        emm_fifo_wren   <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_start_addr  <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if((ebi_wren==1'b1) && 
            (lbus_addr==ADDR_EMM_PKT_LEN) && ((|lbus_data[8:0])==1'b1) && 
            ((emm_word_cnt==10) || (emm_flag==1'b1)))
    begin
        emm_start_addr  <=  emm_dataram_waddr;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        emm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
    else if((ebi_wren==1'b1) && 
            (lbus_addr==ADDR_EMM_PKT_LEN) && ((|lbus_data[8:0])==1'b1) &&
            ((emm_word_cnt==10) || (emm_flag==1'b1)))
    begin
        emm_fifo_din    <=  {{16{1'b0}},lbus_data[8:0],emm_start_addr[ECM_DATARAM_DEPTHBIT - 1 : 0]};
    end
    else
    begin
        emm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
end

always@(posedge clk_gtp or posedge rst_gtp)
begin
    if(rst_gtp==1'b1)
    begin
        emm_pkt_rdy <=  1'b0;
    end
    else if(emm_fifo_num>0)
    begin
        emm_pkt_rdy <=  1'b1;
    end
    else
    begin
        emm_pkt_rdy <=  1'b0;
    end
end 

////////////////////////////////////////////////////////////////////
//ecm packet read
////////////////////////////////////////////////////////////////////
always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        st_ecm_curr <=  ST_ECM_IDLE;
    end
    else
    begin
        st_ecm_curr <=  st_ecm_next;
    end
end         
            
always@*
begin
    case(st_ecm_curr)
    ST_ECM_IDLE:
    begin
        if((ecm_fifo_num>0) && (ecm_pkt_bp==1'b0))
        begin
            st_ecm_next =   ST_ECM_READ_FIFO;
        end
        else
        begin
            st_ecm_next =   ST_ECM_IDLE;
        end
    end
    ST_ECM_READ_FIFO:
    begin
        st_ecm_next =   ST_ECM_READ_WAIT;
    end
    ST_ECM_READ_WAIT:
    begin
        if(wait_cnt==1'b1)
        begin
            st_ecm_next =   ST_ECM_READ_DATA;
        end
        else
        begin
            st_ecm_next =   ST_ECM_READ_WAIT;
        end
    end
    ST_ECM_READ_DATA:
    begin
        if(rd_cnt>ecm_len_buf)
        begin
            st_ecm_next =   ST_ECM_IDLE;
        end
        else
        begin
            st_ecm_next =   ST_ECM_READ_DATA;
        end
    end
    default:
    begin
        st_ecm_next =   ST_ECM_IDLE;
    end
    endcase
end 

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        wait_cnt    <=  1'b0;
    end
    else if(st_ecm_curr==ST_ECM_READ_WAIT)
    begin
        wait_cnt    <=  ~wait_cnt;
    end
    else
    begin
        wait_cnt    <=  1'b0;
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_fifo_rden   <=  1'b0;
    end
    else if(st_ecm_curr==ST_ECM_READ_FIFO)
    begin
        ecm_fifo_rden   <=  1'b1;
    end
    else
    begin
        ecm_fifo_rden   <=  1'b0;
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_dataram_raddr   <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if((st_ecm_curr==ST_ECM_READ_WAIT) && (wait_cnt==1'b1))
    begin
        ecm_dataram_raddr   <=  ecm_fifo_dout[8:0];
    end
    else if(st_ecm_curr==ST_ECM_READ_DATA)
    begin
        ecm_dataram_raddr   <=  ecm_dataram_raddr + 'h1;
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_len_buf <=  {8{1'b0}};
    end
    else if((st_ecm_curr==ST_ECM_READ_WAIT) && (wait_cnt==1'b1))
    begin
        ecm_len_buf <=  ecm_fifo_dout[17:10];
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        rd_cnt  <=  {8{1'b0}};
    end
    else if(st_ecm_curr==ST_ECM_READ_DATA)
    begin
        rd_cnt  <=  rd_cnt + 'h1;
    end
    else
    begin
        rd_cnt  <=  {8{1'b0}};
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_pkt_index   <=  {10{1'b0}};
    end
    else if((st_ecm_curr==ST_ECM_READ_WAIT) && (wait_cnt==1'b1))
    begin
        ecm_pkt_index   <=  ecm_fifo_dout[33:24];
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_pkt_period  <=  {6{1'b0}};
    end
    else if((st_ecm_curr==ST_ECM_READ_WAIT) && (wait_cnt==1'b1))
    begin
        ecm_pkt_period  <=  ecm_fifo_dout[23:18];
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_pkt_sof <=  1'b0;
    end
    else if((st_ecm_curr==ST_ECM_READ_DATA) && (rd_cnt==1))
    begin
        ecm_pkt_sof <=  1'b1;
    end
    else
    begin
        ecm_pkt_sof <=  1'b0;
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_pkt_eof <=  1'b0;
    end
    else if((st_ecm_curr==ST_ECM_READ_DATA) && (rd_cnt==ecm_len_buf))
    begin
        ecm_pkt_eof <=  1'b1;
    end
    else
    begin
        ecm_pkt_eof <=  1'b0;
    end
end

assign  ecm_pkt_val     =   ((st_ecm_curr==ST_ECM_READ_DATA) && (rd_cnt>1)) ?   1'b1    :   1'b0;
assign  ecm_pkt_data    =   ecm_dataram_rdata;   

////////////////////////////////////////////////////////////////////
//debug
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_wr_pkt_num  <=  {16{1'b0}};
    end
    else if(ecm_fifo_wren==1'b1)
    begin
        ecm_wr_pkt_num  <=  ecm_wr_pkt_num + 'h1;
    end
end

always@(posedge clk_ddr3 or posedge rst_ddr3)
begin
    if(rst_ddr3==1'b1)
    begin
        ecm_rd_pkt_num_buf  <=  {16{1'b0}};
    end
    else if(ecm_fifo_rden==1'b1)
    begin
        ecm_rd_pkt_num_buf  <=  ecm_rd_pkt_num_buf + 'h1;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ecm_rd_pkt_num          <=  {16{1'b0}};
        ecm_rd_pkt_num_buf_1dly <=  {16{1'b0}};
    end
    else
    begin
        ecm_rd_pkt_num_buf_1dly <=  ecm_rd_pkt_num_buf;
        ecm_rd_pkt_num          <=  ecm_rd_pkt_num_buf_1dly;
    end
end        
    
////////////////////////////////////////////////////////////////////
//ecm packet fifo+ram
////////////////////////////////////////////////////////////////////
//read latency=1
//din={ecm_pid_index[9:0],ecm_tx_period[5:0],ecm_pkt_len[8:0],ecm_start_addr[8:0]}
//1 M9K blockRAM
//
//asynfifo_w34d256 u0_asynfifo_w34d256(
//    .rst                                ( rst_ecm                   ),
//    .wr_clk                             ( clk_cfg                   ),
//    .rd_clk                             ( clk_ddr3                  ),
//    .din                                ( ecm_fifo_din              ),
//    .wr_en                              ( ecm_fifo_wren             ),
//    .rd_en                              ( ecm_fifo_rden             ),
//    .dout                               ( ecm_fifo_dout             ),
//    .full                               ( /*not used*/              ),
//    .empty                              ( /*not used*/              ),
//    .rd_data_count                      ( ecm_fifo_num              )
//    );
//
////read latency=2,1 M9K blockRAM
//asynram_w16d512 u0_asynram_w16d512(
//    .clka                               ( clk_cfg                   ),
//    .wea                                ( ecm_dataram_wren          ),
//    .addra                              ( ecm_dataram_waddr         ),
//    .dina                               ( ecm_dataram_wdata         ),
//    .clkb                               ( clk_ddr3                  ),
//    .addrb                              ( ecm_dataram_raddr         ),
//    .doutb                              ( ecm_dataram_rdata         )
//    );
//
//////////////////////////////////////////////////////////////////////
////ecm infoRAM,1 M18K blockRAM
//////////////////////////////////////////////////////////////////////
////read latency = 2
////ram_din={ecm_pid_index[9:0],ecm_tx_period[5:0]}
//asynram_w16d1024 u0_asynram_w16d1024(
//    .clka                               ( clk_cfg                   ),
//    .wea                                ( ecm_inforam_wren          ),
//    .addra                              ( ecm_inforam_waddr         ),
//    .dina                               ( ecm_inforam_wdata         ),
//    .clkb                               ( clk_ddr3                  ),
//    .addrb                              ( ecm_inforam_raddr         ),
//    .doutb                              ( ecm_inforam_rdata         )
//    );
//
//////////////////////////////////////////////////////////////////////
////emm and scram pid contorl packet:fifo+ram
//////////////////////////////////////////////////////////////////////   
////read latency=1
////din={{16{1'b0}},emm_pkt_len[8:0],emm_start_addr[8:0]}
////1 M9K blockRAM
//asynfifo_w34d256 u1_asynfifo_w34d256(
//    .rst                                ( rst_emm                   ),
//    .wr_clk                             ( clk_cfg                   ),
//    .rd_clk                             ( clk_gtp                   ),
//    .din                                ( emm_fifo_din              ),
//    .wr_en                              ( emm_fifo_wren             ),
//    .rd_en                              ( emm_fifo_rden             ),
//    .dout                               ( emm_fifo_dout_buf         ),
//    .full                               ( /*not used*/              ),
//    .empty                              ( /*not used*/              ),
//    .rd_data_count                      ( emm_fifo_num              )
//    );
//
////read latency=1,1 M9K blockRAM
//emmdatram_w16d512 u0_emmdatram_w16d512(
//    .clka                               ( clk_cfg                   ),
//    .wea                                ( emm_dataram_wren          ),
//    .addra                              ( emm_dataram_waddr         ),
//    .dina                               ( emm_dataram_wdata         ),
//    .clkb                               ( clk_gtp                   ),
//    .addrb                              ( emm_dataram_raddr         ),
//    .doutb                              ( emm_dataram_rdata         )
//    ); 
                             
endmodule
