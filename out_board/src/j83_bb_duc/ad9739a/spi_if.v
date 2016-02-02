/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   spi_if.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :  one spi write at least hold 4ms
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-12-24  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   spi_if.v
    File tree    :   spi_if.v
\************************************************************************************/

`timescale 1ns/100ps

module spi_if(
    rst                         ,
    clk                         ,   //10MHz clock
    
    //100MHz clock domain
    ad9739_wdata                ,
    spi_ad9739                  ,
    spi_ad9739_rd               ,
    ad9739_raddr                ,
    ad9739_rdata                ,
    ad9739_oe                   ,
    
    adf4350_wdata               ,
    spi_adf4350                 ,
    
    spi_miso                    ,
    spi_csn                     ,
    spi_mosi              
    );

parameter       U_DLY                       = 1                     ;
    
input                                   rst                         ;
input                                   clk                         ;   //10MHz
input   [15:0]                          ad9739_wdata                ;
input                                   spi_ad9739                  ;
input                                   spi_ad9739_rd               ;
input   [7:0]                           ad9739_raddr                ;
output  [7:0]                           ad9739_rdata                ;
output                                  ad9739_oe                   ;

input   [31:0]                          adf4350_wdata               ;
input                                   spi_adf4350                 ;

input                                   spi_miso                    ;                                        
output                                  spi_csn                     ;
output                                  spi_mosi                    ;

reg                                     spi_adf4350_1syn            ;
reg                                     spi_adf4350_2syn            ;
reg                                     spi_adf4350_3syn            ;
wire                                    adf4350_valid               ;
reg                                     spi_ad9739_1syn             ;
reg                                     spi_ad9739_2syn             ;
reg                                     spi_ad9739_3syn             ;
wire                                    ad9739_valid                ;
reg                                     adf4350_valid_1dly          ;
reg                                     ad9739_valid_1dly           ;
reg     [31:0]                          spi_par_data                ;
reg     [5:0]                           spi_count                   ;
reg     [1:0]                           spi_csn                     ;
reg                                     spi_mosi                    ;
reg     [31:0]                          spi_par_data_reg            ;

//100M--->27M clock domain synchronize
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_ad9739_1syn <=  1'b0;
        spi_ad9739_2syn <=  1'b0;
        spi_ad9739_3syn <=  1'b0;
    end
    else
    begin
        spi_ad9739_1syn <=  spi_ad9739;
        spi_ad9739_2syn <=  spi_ad9739_1syn;
        spi_ad9739_3syn <=  spi_ad9739_2syn;
    end
end

assign  ad9739_valid =   spi_ad9739_2syn ^ spi_ad9739_3syn;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_adf4350_1syn    <=  1'b0;
        spi_adf4350_2syn    <=  1'b0;
        spi_adf4350_3syn    <=  1'b0;
    end
    else
    begin
        spi_adf4350_1syn    <=  spi_adf4350;
        spi_adf4350_2syn    <=  spi_adf4350_1syn;
        spi_adf4350_3syn    <=  spi_adf4350_2syn;
    end
end

assign  adf4350_valid   =   spi_adf4350_2syn ^ spi_adf4350_3syn;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        adf4350_valid_1dly  <=  1'b0;
        ad9739_valid_1dly   <=  1'b0;
    end
    else
    begin
        adf4350_valid_1dly  <=  adf4350_valid;
        ad9739_valid_1dly   <=  ad9739_valid;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_par_data    <=  {32{1'b0}};
    end
    else if(ad9739_valid==1'b1)
    begin
        spi_par_data    <=  {ad9739_wdata[15:0],{16{1'b0}}};
    end
    else if(adf4350_valid==1'b1)
    begin
        spi_par_data    <=  adf4350_wdata[31:0];
    end
    else if(ad9739_rd==1'b1)
    begin
        spi_par_data    <=  {ad9739_raddr[7:0],{24{1'b0}}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_count   <=  {6{1'b0}};
    end
    else if((adf4350_valid_1dly==1'b1) || (ad9739_valid_1dly==1'b1) || (ad9739_rd_1dly==1'b1))
    begin
        spi_count   <=  6'b00_0001;
    end
    else if(spi_count>6'd31)
    begin
        spi_count   <=  {6{1'b0}};
    end
    else if(spi_count>0)
    begin
        spi_count   <=  spi_count + 6'b00_0001;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_csn[0]  <=  1'b1;
    end
    else if(spi_count>15)
    begin
        spi_csn[0]  <=  1'b1;
    end
    else if((ad9739_valid_1dly==1'b1) || (ad9739_rd_1dly==1'b1))
    begin
        spi_csn[0]  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_csn[1]  <=  1'b1;
    end
    else if(spi_count>31)
    begin
        spi_csn[1]  <=  1'b1;
    end
    else if(adf4350_valid_1dly==1'b1)
    begin
        spi_csn[1]  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_par_data_reg    <=  32'h0000_0000;
    end
    else if((adf4350_valid_1dly==1'b1) || (ad9739_valid_1dly==1'b1) || (ad9739_rd_1dly==1'b1))
    begin
        spi_par_data_reg    <=  {spi_par_data[30:0],1'b0};
    end
    else if(&spi_csn[1:0]==1'b0)
    begin
        spi_par_data_reg    <=  {spi_par_data_reg[30:0],1'b0};
    end
    else
    begin
        spi_par_data_reg    <=  32'h0000_0000;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        spi_mosi    <=  1'bz;
    end
    else if((adf4350_valid_1dly==1'b1) || (ad9739_valid_1dly==1'b1) || (ad9739_rd_1dly==1'b1))
    begin
        spi_mosi    <=  spi_par_data[31];
    end
    else if(&spi_csn[1:0]==1'b0)
    begin
        spi_mosi    <=  spi_par_data_reg[31];
    end
    else if((ad9739_oe==1'b1) && (spi_count>7))
    begin
        spi_mosi    <=  1'bz;
    end
end

////////////////////////////////////////////////////////////////////
//ad9739read
////////////////////////////////////////////////////////////////////
reg                                     ad9739_rd_1syn              ;
reg                                     ad9739_rd_2syn              ;
reg                                     ad9739_rd_3syn              ;
wire                                    ad9739_rd                   ;
reg                                     ad9739_rd_1dly              ;
reg     [7:0]                           ad9739_rdata                ;
reg                                     ad9739_oe                   ;

//100M--->10M clock domain synchronize
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ad9739_rd_1syn  <=  1'b0;
        ad9739_rd_2syn  <=  1'b0;
        ad9739_rd_3syn  <=  1'b0;
    end
    else
    begin
        ad9739_rd_1syn  <=  spi_ad9739_rd;
        ad9739_rd_2syn  <=  ad9739_rd_1syn;
        ad9739_rd_3syn  <=  ad9739_rd_2syn;
    end
end

assign  ad9739_rd   =   ad9739_rd_2syn ^ ad9739_rd_3syn;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ad9739_rd_1dly  <=  1'b0;
    end
    else
    begin
        ad9739_rd_1dly  <=  ad9739_rd;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ad9739_rdata    <=  {8{1'b0}};
    end
    else if((spi_count>8) && (spi_count<17))
    begin
        ad9739_rdata    <=  {ad9739_rdata[6:0],spi_miso};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ad9739_oe   <=  1'b0;
    end
    else if(ad9739_rd_1dly==1'b1)
    begin
        ad9739_oe   <=  1'b1;
    end
    else if(spi_count>17)
    begin
        ad9739_oe   <=  1'b0;
    end
end
    
endmodule