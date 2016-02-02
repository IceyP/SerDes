/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ddr_cfg.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-09-21  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_cfg.v
    File tree    :   ddr_cfg.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_cfg(
    ui_clk                      ,
    ui_rst                      ,
    rst_cfg                     ,
    clk_cfg                     ,
    //local bus
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_rdata                  ,
    lbus_oe_n                   ,
    lbus_we_n                   ,
    lbus_wait_n                 ,
    
    ad9739_wdata                ,
    spi_ad9739                  ,
    spi_ad9739_rd               ,
    ad9739_raddr                ,
    ad9739_rdata                ,
    ad9739_oe                   ,
    spi_adf4350                 ,
    adf4350_wdata               ,
    adf4350_pdbrf               ,
    amplifier_power_on          ,
    
    dejitter_ms                 ,
    scram_clr                   ,

    pcr_correct_int_ena         ,
    pcr_correct_ac_ena
    );
    
parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   U_DLY                       = 1                         ;
parameter   BUF_DEPTH_BIT               = 8                         ;
parameter   TOTAL_CHN_NUM               = 16                        ;
parameter   PAUSE_TIME                  = 100000000                 ;

//parameter   DDR_THRE_H                  = 12'h700                   ;
//parameter   DDR_THRE_L                  = 12'h701                   ;
parameter   ADDR_PCR_INT_EN             = 12'h702                   ;   //PCR间隔校正使能
parameter   ADDR_ADF4350_CFG_L          = 12'h703                   ;
parameter   ADDR_ADF4350_CFG_H          = 12'h704                   ;
parameter   ADDR_LBUS_TEST              = 12'h705                   ;
//parameter   ADDR_STREAM_CHANGED         = 12'h706                   ;   
//parameter   ADDR_PCR_PAUSE              = 12'h707                   ; 
//parameter   ADDR_PCR_RELOAD_TIME        = 12'h708                   ;
parameter   ADDR_ADF4350_RFMUTE         = 12'h709                   ;
parameter   ADDR_AMP_POWER_ON           = 12'h70a                   ;
parameter   ADDR_PCR_AC_EN              = 12'h70b                   ;   //PCR精度校正使能
//parameter   DDR_WORD_NUM_CHL1           = 12'h70c                   ;
parameter   ADDR_DEJITTER_MS            = 12'h70d                   ;
parameter   ADDR_AD9739_RDATA           = 12'h70e                   ;
parameter   ADDR_SCRAM_CLR              = 12'h70f                   ;

input                                   ui_clk                      ;
input                                   ui_rst                      ;
input                                   rst_cfg                     ;
input                                   clk_cfg                     ;
//local bus
input   [P_BUS_ADDR_WIDTH - 1 : 0]      lbus_addr                   ;
input   [P_BUS_DATA_WIDTH - 1 : 0]      lbus_wdata                  ;
output  [P_BUS_DATA_WIDTH - 1 : 0]      lbus_rdata                  ;
input                                   lbus_oe_n                   ;
input                                   lbus_we_n                   ;
output                                  lbus_wait_n                 ;

output  [15:0]                          ad9739_wdata                ;
output                                  spi_ad9739                  ;
output                                  spi_ad9739_rd               ;
output  [7:0]                           ad9739_raddr                ;
input   [7:0]                           ad9739_rdata                ;
input                                   ad9739_oe                   ;

output                                  spi_adf4350                 ;
output  [31:0]                          adf4350_wdata               ;
output                                  adf4350_pdbrf               ;
output                                  amplifier_power_on          ;

output  [10:0]                          dejitter_ms                 ;
output                                  scram_clr                   ;

output  [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_int_ena         ;
output  [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_ac_ena          ;

reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_int_ena         ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_int_ena             ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_int_ena_1syn        ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_ac_ena          ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_ac_ena              ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_cor_ac_ena_1syn         ;


reg                                     lbus_we_n_1dly              ;
wire                                    negedge_lbus_we_n           ;
reg                                     lbus_oe_n_1dly              ;
wire                                    negedge_lbus_oe_n           ;

reg     [P_BUS_DATA_WIDTH - 1 : 0]      lbus_rdata                  ;

reg     [15:0]                          ad9739_wdata                ;
reg                                     spi_ad9739                  ;
reg                                     spi_adf4350                 ;
reg     [31:0]                          adf4350_wdata               ;
reg     [15:0]                          lbus_test                   ;
reg                                     adf4350_pdbrf               ;
reg                                     amplifier_power_on          ;
reg     [10:0]                          dejitter_ms_buf             ;
reg     [10:0]                          dejitter_ms_buf_1dly        ;
reg     [10:0]                          dejitter_ms                 ;
reg                                     scram_clr                   ;
reg                                     scram_clr_buf               ;
reg                                     scram_clr_buf_1dly          ;

assign  lbus_wait_n =   1'b1;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_we_n_1dly  <=  1'b1;
    end
    else
    begin
        lbus_we_n_1dly  <=  #U_DLY lbus_we_n;
    end
end

assign  negedge_lbus_we_n    =   (~lbus_we_n) & lbus_we_n_1dly;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_oe_n_1dly  <=  1'b1;
    end
    else
    begin
        lbus_oe_n_1dly  <=  #U_DLY lbus_oe_n;
    end
end

assign  negedge_lbus_oe_n   =   (~lbus_oe_n) & lbus_oe_n_1dly;

//local bus write
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        pcr_cor_int_ena     <=  {TOTAL_CHN_NUM{1'b1}};
        pcr_cor_ac_ena      <=  {TOTAL_CHN_NUM{1'b1}};
        adf4350_wdata       <=  {32{1'b0}};
        spi_adf4350         <=  1'b0;
        lbus_test           <=  {16{1'b0}};
        adf4350_pdbrf       <=  1'b0;
        amplifier_power_on  <=  1'b0;
        dejitter_ms_buf     <=  11'd40;
    end
    else if(negedge_lbus_we_n==1'b1)
    begin
        case(lbus_addr)
        ADDR_PCR_INT_EN:    pcr_cor_int_ena     <=  #U_DLY lbus_wdata[TOTAL_CHN_NUM - 1 : 0];
        ADDR_ADF4350_CFG_L: adf4350_wdata[15:0] <=  #U_DLY lbus_wdata[15:0];
        ADDR_ADF4350_CFG_H: 
        begin
            adf4350_wdata[31:16]    <=  #U_DLY lbus_wdata[15:0];
            spi_adf4350             <=  #U_DLY ~spi_adf4350;
        end
        ADDR_LBUS_TEST:     lbus_test           <=  #U_DLY lbus_wdata;
        ADDR_ADF4350_RFMUTE:adf4350_pdbrf       <=  #U_DLY lbus_wdata[0];
        ADDR_AMP_POWER_ON:  amplifier_power_on  <=  #U_DLY lbus_wdata[0];
        ADDR_PCR_AC_EN:     pcr_cor_ac_ena      <=  #U_DLY lbus_wdata[TOTAL_CHN_NUM - 1 : 0];
        ADDR_DEJITTER_MS:   dejitter_ms_buf     <=  #U_DLY lbus_wdata[10:0];
        ADDR_SCRAM_CLR:     scram_clr_buf       <=  #U_DLY lbus_wdata[0];
        default:;
		endcase
    end
end
                
//local bus read
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_rdata      <=  16'h0000;
    end
    else if(negedge_lbus_oe_n==1'b1)
    begin
        case(lbus_addr)
        ADDR_PCR_INT_EN:    lbus_rdata  <=  #U_DLY pcr_cor_int_ena[TOTAL_CHN_NUM - 1 : 0];
        ADDR_ADF4350_CFG_L: lbus_rdata  <=  #U_DLY adf4350_wdata[15:0];
        ADDR_ADF4350_CFG_H: lbus_rdata  <=  #U_DLY adf4350_wdata[31:16];
        ADDR_LBUS_TEST:     lbus_rdata  <=  #U_DLY ~lbus_test[15:0];
        ADDR_ADF4350_RFMUTE:lbus_rdata  <=  #U_DLY {{15{1'b0}},adf4350_pdbrf};
        ADDR_AMP_POWER_ON:  lbus_rdata  <=  #U_DLY {{15{1'b0}},amplifier_power_on};
        ADDR_PCR_AC_EN:     lbus_rdata  <=  #U_DLY pcr_cor_ac_ena[TOTAL_CHN_NUM - 1 : 0];
        ADDR_DEJITTER_MS:   lbus_rdata  <=  #U_DLY {{5{1'b0}},dejitter_ms_buf[10:0]};
        ADDR_AD9739_RDATA:  lbus_rdata  <=  {{8{1'b0}},ad9739_rdata[7:0]};
        ADDR_SCRAM_CLR:     lbus_rdata  <=  #U_DLY {{15{1'b0}},scram_clr_buf};
        default:;
        endcase
    end
end

always@(posedge ui_clk or posedge ui_rst)
begin
    if(ui_rst==1'b1)
    begin
        pcr_cor_int_ena_1syn    <=  {TOTAL_CHN_NUM{1'b1}};
        pcr_correct_int_ena     <=  {TOTAL_CHN_NUM{1'b1}};
    end
    else
    begin
        pcr_cor_int_ena_1syn    <=  #U_DLY pcr_cor_int_ena;
        pcr_correct_int_ena     <=  #U_DLY pcr_cor_int_ena_1syn;
    end
end

always@(posedge ui_clk or posedge ui_rst)
begin
    if(ui_rst==1'b1)
    begin
        pcr_cor_ac_ena_1syn     <=  {TOTAL_CHN_NUM{1'b1}};
        pcr_correct_ac_ena      <=  {TOTAL_CHN_NUM{1'b1}};
    end
    else
    begin
        pcr_cor_ac_ena_1syn     <=  #U_DLY pcr_cor_ac_ena;
        pcr_correct_ac_ena      <=  #U_DLY pcr_cor_ac_ena_1syn;
    end
end

always@(posedge ui_clk or posedge ui_rst)
begin
    if(ui_rst==1'b1)
    begin
        dejitter_ms_buf_1dly    <=  11'd40;
        dejitter_ms             <=  11'd40;
    end
    else
    begin
        dejitter_ms_buf_1dly    <=  #U_DLY dejitter_ms_buf;
        dejitter_ms             <=  #U_DLY dejitter_ms_buf_1dly;
    end
end     

always@(posedge ui_clk or posedge ui_rst)
begin
    if(ui_rst==1'b1)
    begin
        scram_clr_buf_1dly  <=  1'b0;
        scram_clr           <=  1'b0;
    end
    else
    begin
        scram_clr_buf_1dly  <=  #U_DLY scram_clr_buf;
        scram_clr           <=  #U_DLY scram_clr_buf_1dly;  
    end
end
              
////////////////////////////////////////////////////////////////////
//spi_cfg
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        spi_ad9739      <=  1'b0;
        ad9739_wdata    <=  16'h0000;
    end
    else if(negedge_lbus_we_n==1'b1)
    begin
        if(lbus_addr[11:7]==5'b0_1111)
        begin
            spi_ad9739      <=  #U_DLY ~spi_ad9739;
            ad9739_wdata    <=  #U_DLY {1'b0,lbus_addr[6:0],lbus_wdata[7:0]};
        end     
    end
end

////////////////////////////////////////////////////////////////////
//rd
////////////////////////////////////////////////////////////////////
wire                                    ad9739_rd_flag              ;
reg                                     spi_ad9739_rd               ;
reg     [7:0]                           ad9739_raddr                ;
reg                                     ad9739_oe_1syn              ;
reg                                     ad9739_oe_2syn              ;
reg                                     ad9739_oe_3syn              ;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        spi_ad9739_rd   <=  1'b0;
        ad9739_raddr    <=  8'h00;       
    end
    else if(negedge_lbus_oe_n==1'b1)
    begin
        if(lbus_addr[11:7]==5'b0_1111)
        begin
            spi_ad9739_rd   <=  #U_DLY ~spi_ad9739_rd;
            ad9739_raddr    <=  {1'b1,lbus_addr[6:0]};
        end     
    end
end

//ad9739_rd_flag
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        ad9739_oe_1syn  <=  1'b0;
        ad9739_oe_2syn  <=  1'b0;
        ad9739_oe_3syn  <=  1'b0;
    end
    else
    begin
        ad9739_oe_1syn  <=  ad9739_oe;
        ad9739_oe_2syn  <=  ad9739_oe_1syn;
        ad9739_oe_3syn  <=  ad9739_oe_2syn;
    end
end

assign  ad9739_rd_flag  =  (~ad9739_oe_2syn) & ad9739_oe_3syn;
        
endmodule
