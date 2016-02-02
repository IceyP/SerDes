/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   udp_table_manager.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   udp_table_manager.v
    File tree    :   udp_table_manager.v
\************************************************************************************/
`timescale 1ns/100ps

module udp_table_manager(
    clk_wr                      ,
    clk_rd                      ,
    rst_wr                      ,
    rst_rd                      ,
    //reserved(16bit)+dst_ip(32bit)+dst_port(16bit)
    wr_en                       ,
    wr_addr                     ,
    wr_data                     ,
    
    rd_addr                     ,
    rd_data                     ,
    
    table_switch                                                        //keep '1' until is_searching=0,clk_cfg clock domain
    );

parameter   U_DLY                       = 1                         ;
parameter   UDP_TABLE_WIDTH             = 64                        ;
parameter   UDP_TABLE_DEPTH_BIT         = 9                         ;

input                                   clk_wr                      ;
input                                   clk_rd                      ;
input                                   rst_wr                      ;
input                                   rst_rd                      ;

input                                   wr_en                       ;
input   [UDP_TABLE_DEPTH_BIT - 1 : 0]   wr_addr                     ;
input   [UDP_TABLE_WIDTH - 1 : 0]       wr_data                     ;

input   [UDP_TABLE_DEPTH_BIT - 1 : 0]   rd_addr                     ;
output  [UDP_TABLE_WIDTH - 1 : 0]       rd_data                     ;

input                                   table_switch                ;

reg                                     table_switch_1dly           ;
reg                                     table_switch_2dly           ;
wire                                    negdge_table_switch_wr      ;

reg                                     table_switch_1syn           ;
reg                                     table_switch_2syn           ;
wire                                    negdge_table_switch_rd      ;

reg                                     table1_can_read             ;
reg                                     table1_can_write            ;
reg                                     table2_can_read             ;
reg                                     table2_can_write            ;

reg                                     table1_wr_en                ;
reg     [UDP_TABLE_DEPTH_BIT - 1 : 0]   table1_wr_addr              ;
reg     [UDP_TABLE_WIDTH - 1 : 0]       table1_wr_data              ;
reg     [UDP_TABLE_DEPTH_BIT - 1 : 0]   table1_rd_addr              ;
wire    [UDP_TABLE_WIDTH - 1 : 0]       table1_rd_data              ;

reg                                     table2_wr_en                ;
reg     [UDP_TABLE_DEPTH_BIT - 1 : 0]   table2_wr_addr              ;
reg     [UDP_TABLE_WIDTH - 1 : 0]       table2_wr_data              ;
reg     [UDP_TABLE_DEPTH_BIT - 1 : 0]   table2_rd_addr              ;
reg     [UDP_TABLE_WIDTH - 1 : 0]       rd_data                     ;
wire    [UDP_TABLE_WIDTH - 1 : 0]       table2_rd_data              ;

//wr
always@(posedge clk_wr or posedge rst_wr)
begin
    if(rst_wr==1'b1)
    begin
        table_switch_1dly   <=  1'b0;
        table_switch_2dly   <=  1'b0;
    end
    else
    begin
        table_switch_1dly   <=  #U_DLY table_switch;
        table_switch_2dly   <=  #U_DLY table_switch_1dly;
    end
end

assign  negdge_table_switch_wr =   table_switch_2dly & (~table_switch_1dly);

always@(posedge clk_wr or posedge rst_wr)
begin
    if(rst_wr==1'b1)
    begin
        table1_can_write    <=  1'b1;
        table2_can_write    <=  1'b0;
    end
    else if(negdge_table_switch_wr==1'b1)
    begin
        table1_can_write    <=  #U_DLY ~table1_can_write;
        table2_can_write    <=  #U_DLY table1_can_write;
    end
end

always@(posedge clk_wr or posedge rst_wr)
begin
    if(rst_wr==1'b1)
    begin
        table1_wr_en    <=  1'b0;
        table1_wr_addr  <=  {UDP_TABLE_DEPTH_BIT{1'b0}};
        table1_wr_data  <=  {UDP_TABLE_WIDTH{1'b0}};         
    end
    else if(table1_can_write==1'b1)
    begin
        table1_wr_en    <=  #U_DLY wr_en;
        table1_wr_addr  <=  #U_DLY wr_addr;
        table1_wr_data  <=  #U_DLY wr_data;
    end
    else
    begin
        table1_wr_en    <=  #U_DLY 1'b0;
        table1_wr_addr  <=  #U_DLY {UDP_TABLE_DEPTH_BIT{1'b0}};
        table1_wr_data  <=  #U_DLY {UDP_TABLE_WIDTH{1'b0}};
    end
end

always@(posedge clk_wr or posedge rst_wr)
begin
    if(rst_wr==1'b1)
    begin
        table2_wr_en    <=  1'b0;
        table2_wr_addr  <=  {UDP_TABLE_DEPTH_BIT{1'b0}};
        table2_wr_data  <=  {UDP_TABLE_WIDTH{1'b0}}; 
    end
    else if(table2_can_write==1'b1)
    begin
        table2_wr_en    <=  #U_DLY wr_en;
        table2_wr_addr  <=  #U_DLY wr_addr;
        table2_wr_data  <=  #U_DLY wr_data;
    end
    else
    begin
        table2_wr_en    <=  #U_DLY 1'b0;
        table2_wr_addr  <=  #U_DLY {UDP_TABLE_DEPTH_BIT{1'b0}};
        table2_wr_data  <=  #U_DLY {UDP_TABLE_WIDTH{1'b0}}; 
    end
end

//-----------------------------------------------------------------------------
//rd
always@(posedge clk_rd or posedge rst_rd)
begin
    if(rst_rd==1'b1)
    begin
        table_switch_1syn   <=  1'b0;
        table_switch_2syn   <=  1'b0;
    end
    else
    begin
        table_switch_1syn   <=  #U_DLY table_switch;
        table_switch_2syn   <=  #U_DLY table_switch_1syn;
    end
end

assign  negdge_table_switch_rd =   table_switch_2syn & (~table_switch_1syn);

always@(posedge clk_rd or posedge rst_rd)
begin
    if(rst_rd==1'b1)
    begin
        table1_can_read     <=  1'b0;
        table2_can_read     <=  1'b0;
    end
    else if(negdge_table_switch_rd==1'b1)
    begin
        table1_can_read     <=  #U_DLY ~table1_can_read;
        table2_can_read     <=  #U_DLY table1_can_read;
    end
end

always@(posedge clk_rd or posedge rst_rd)
begin
    if(rst_rd==1'b1)
    begin
        table1_rd_addr  <=  {UDP_TABLE_DEPTH_BIT{1'b0}};
    end
    else if(table1_can_read==1'b1)
    begin
        table1_rd_addr  <=  #U_DLY rd_addr;
    end
    else
    begin
        table1_rd_addr  <=  #U_DLY {UDP_TABLE_DEPTH_BIT{1'b0}};
    end
end

always@(posedge clk_rd or posedge rst_rd)
begin
    if(rst_rd==1'b1)
    begin
        table2_rd_addr  <=  {UDP_TABLE_DEPTH_BIT{1'b0}};
    end
    else if(table2_can_read==1'b1)
    begin
        table2_rd_addr  <=  #U_DLY rd_addr;
    end
    else
    begin
        table2_rd_addr  <=  #U_DLY {UDP_TABLE_DEPTH_BIT{1'b0}};
    end
end

always@(posedge clk_rd or posedge rst_rd)
begin
    if(rst_rd==1'b1)
    begin
        rd_data <=  {UDP_TABLE_WIDTH{1'b0}};
    end
    else if(table1_can_read==1'b1)
    begin
        rd_data <=  #U_DLY table1_rd_data;
    end
    else if(table2_can_read==1'b1)
    begin
        rd_data <=  #U_DLY table2_rd_data;
    end
    else
    begin
        rd_data <=  #U_DLY {UDP_TABLE_WIDTH{1'b0}};
    end
end

udp_filter_table u1_udp_filter_table(
    .clka                               ( clk_wr                    ),
    .wea                                ( table1_wr_en              ),
    .addra                              ( table1_wr_addr            ),
    .dina                               ( table1_wr_data            ),
    .clkb                               ( clk_rd                    ),
    .addrb                              ( table1_rd_addr            ), 
    .doutb                              ( table1_rd_data            )
    );
    
udp_filter_table u2_udp_filter_table(
    .clka                               ( clk_wr                    ),
    .wea                                ( table2_wr_en              ),
    .addra                              ( table2_wr_addr            ),
    .dina                               ( table2_wr_data            ),
    .clkb                               ( clk_rd                    ),
    .addrb                              ( table2_rd_addr            ), 
    .doutb                              ( table2_rd_data            )
    );
            
endmodule
