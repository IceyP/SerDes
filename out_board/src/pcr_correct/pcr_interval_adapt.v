/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   pcr_interval_adapt.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-08-15  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   pcr_interval_adapt.v
    File tree    :   pcr_interval_adapt.v
\************************************************************************************/

`timescale 1ns/100ps

(*use_dsp48="yes"*)
module pcr_interval_adapt(
    clk                         ,
    rst                         ,
    pcr_lo_base                 ,
    pcr_correct_int_ena         ,
    head_val                    ,
    memc_data                   ,
    memc_data_head_valid        ,
    memc_rd_data_valid          ,
    ddr_rd_data_ack             ,
    ddr_rd_data_req             ,
    pcr_interval_data           ,
    pcr_interval_data_valid
    );

parameter   PROG_BIT_WIDTH              = 8                         ;
parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   TOTAL_PROG_NUM              = 2 ** PROG_BIT_WIDTH       ;
parameter   TOTAL_CHN_NUM               = 16                        ;
parameter   RAM_WIDTH                   = 112                       ;
//parameter   RAM_DEPTH_BIT               = PROG_BIT_WIDTH            ;
parameter   RAM_DEPTH_BIT               = 8                         ;
parameter   PROG_PER_CHN_BIT            = PROG_BIT_WIDTH - CHNNUM_BIT_WIDTH;
parameter   PROG_PER_CHAN               = TOTAL_PROG_NUM / TOTAL_CHN_NUM;

input                                   clk                         ;
input                                   rst                         ;
input   [32:0]                          pcr_lo_base                 ;
input   [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_int_ena         ;
input   [TOTAL_PROG_NUM - 1 : 0]        head_val                    ;
input   [127:0]                         memc_data                   ;
input                                   memc_data_head_valid        ;
input   [TOTAL_CHN_NUM - 1 : 0]         memc_rd_data_valid          ;
input   [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_ack             ;
output  [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_req             ;
output  [127:0]                         pcr_interval_data           ;
output  [TOTAL_CHN_NUM - 1 : 0]         pcr_interval_data_valid     ;

reg     [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_req             ;
reg     [127:0]                         pcr_interval_data           ;
reg     [TOTAL_CHN_NUM - 1 : 0]         pcr_interval_data_valid     ;

wire                                    d_head_flag                 ;
wire    [PROG_PER_CHN_BIT - 1 : 0]      d_program_num               ;
wire    [3:0]                           d_chn_num                   ;
wire    [7:0]                           d_ts_header                 ;
wire    [12:0]                          d_program_pid               ;
wire    [1:0]                           d_adapt_field_ctrl          ;
wire    [7:0]                           d_adapt_field_len           ;
wire                                    d_pcr_flag                  ;
wire    [32:0]                          d_pcr_base                  ;
wire    [8:0]                           d_pcr_ext                   ;
wire                                    is_pcr_pkt                  ;
wire                                    pcr_val                     ;
reg                                     pcr_val_1dly                ;
reg                                     pcr_val_2dly                ;
reg                                     ram_wren_buf                ;
wire                                    ram_wren                    ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_waddr                   ;
reg     [RAM_WIDTH - 1 : 0]             ram_wdata                   ;
wire    [RAM_WIDTH - 1 : 0]             ram_rdata                   ;
wire    [RAM_DEPTH_BIT - 1 : 0]         ram_raddr                   ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_raddr_1dly              ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_raddr_2dly              ;
wire    [32:0]                          ram_ori_base                ;
wire    [32:0]                          ram_lo_base                 ;
wire    [12:0]                          ram_pcr_pid                 ;
reg     [12:0]                          pcr_pid_reg                 ;
reg     [12:0]                          pcr_pid_curr                ;
reg     [32:0]                          pcr_lo_base_curr            ;
reg     [32:0]                          pcr_ori_base_curr_buf       ;
reg     [32:0]                          pcr_ori_base_curr           ;
wire    [32:0]                          pcr_lo_interval             ;
wire    [32:0]                          pcr_ori_interval            ;
wire                                    pcr_time_out                ;

wire    [32:0]                          ram_ori_base_adj            ;
wire    [32:0]                          pcr_ori_base_adjust         ;
wire    [32:0]                          pcr_ori_interval_temp       ;
wire                                    temp                        ;

assign  d_head_flag         =   memc_data[127];
assign  d_program_num       =   memc_data[PROG_PER_CHN_BIT + 99 : 100];
assign  d_chn_num           =   memc_data[99:96];
assign  d_ts_header         =   memc_data[95:88];
assign  d_program_pid       =   memc_data[84:72];
assign  d_adapt_field_ctrl  =   memc_data[69:68];
assign  d_adapt_field_len   =   memc_data[63:56];
assign  d_pcr_flag          =   memc_data[52];
assign  d_pcr_base          =   memc_data[47:15];
assign  d_pcr_ext           =   memc_data[8:0];
assign  is_pcr_pkt          =   ((d_head_flag==1'b1) &&                                 
                                (d_ts_header==8'h47) &&
                                (d_adapt_field_ctrl[1]==1'b1) &&
                                (|d_adapt_field_len==1'b1) && 
                                (d_pcr_flag==1'b1)) ? 
                                1'b1 : 1'b0;

assign  pcr_val             =   (|head_val) & is_pcr_pkt;
assign  ram_wren            =   ram_wren_buf & ddr_rd_data_req[ram_waddr[PROG_BIT_WIDTH - 1 : 0]];

////////////////////////////////////////////////////////////////////
//ram read and write
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_wren_buf<=  1'b0;
        ram_waddr   <=  {RAM_DEPTH_BIT{1'b0}};
        ram_wdata   <=  {RAM_WIDTH{1'b0}};
    end
    else if(pcr_val_2dly==1'b1)
    begin
        ram_wren_buf<=  1'b1;
        ram_waddr   <=  ram_raddr_2dly;
        ram_wdata   <=  {pcr_pid_curr[12:0],pcr_ori_base_curr[32:0],pcr_lo_base_curr[32:0],pcr_ori_base_adjust[32:0]};
    end
    else
    begin
        ram_wren_buf<=  1'b0;
        ram_waddr   <=  {RAM_DEPTH_BIT{1'b0}};
        ram_wdata   <=  {RAM_WIDTH{1'b0}};
    end
end

assign  ram_raddr   =   {d_chn_num[3:0],d_program_num[PROG_PER_CHN_BIT - 1 : 0]};

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_raddr_1dly  <=  {RAM_DEPTH_BIT{1'b0}};
        ram_raddr_2dly  <=  {RAM_DEPTH_BIT{1'b0}};
    end
    else
    begin
        ram_raddr_1dly  <=  ram_raddr;
        ram_raddr_2dly  <=  ram_raddr_1dly;
    end
end

////////////////////////////////////////////////////////////////////
//registers
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_val_1dly    <=  1'b0;
        pcr_val_2dly    <=  1'b0;
    end
    else
    begin
        pcr_val_1dly    <=  pcr_val;
        pcr_val_2dly    <=  pcr_val_1dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_pid_reg     <=  {13{1'b0}};
        pcr_pid_curr    <=  {13{1'b0}};
    end
    else
    begin
        pcr_pid_reg     <=  d_program_pid;
        pcr_pid_curr    <=  pcr_pid_reg;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_lo_base_curr    <=  {33{1'b0}};
    end
    else if(pcr_val_1dly==1'b1)
    begin
        pcr_lo_base_curr    <=  pcr_lo_base;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_ori_base_curr_buf   <=  {33{1'b0}};
        pcr_ori_base_curr       <=  {33{1'b0}};
    end
    else
    begin
        pcr_ori_base_curr_buf   <=  d_pcr_base;
        pcr_ori_base_curr       <=  pcr_ori_base_curr_buf;
    end
end

assign  pcr_lo_interval         =   pcr_lo_base_curr - ram_lo_base;
assign  pcr_ori_interval        =   pcr_ori_base_curr - ram_ori_base_adj;
assign  pcr_ori_interval_temp   =   pcr_ori_base_curr - ram_ori_base;
assign  pcr_ori_base_adjust     =   ((pcr_pid_curr==ram_pcr_pid) && (pcr_time_out==1'b0))       ?   (ram_ori_base_adj + pcr_lo_interval)    :   pcr_ori_base_curr;
assign  pcr_time_out            =   ((pcr_lo_interval<3600) && (pcr_ori_interval_temp<3600))    ?   1'b0    :   1'b1;
assign  temp                    =   ((pcr_lo_interval >= pcr_ori_interval) || (pcr_ori_interval>=3600))   ?   1'b1 : 1'b0;

generate
    genvar i;
    for(i=0;i<TOTAL_PROG_NUM;i=i+1)
    begin:GEN_RD_DATA_REQ   
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_data_req[i]  <=  1'b0;
            end
            else if((head_val[i]==1'b1) && (is_pcr_pkt==1'b0))
            begin
                ddr_rd_data_req[i]  <=  1'b1;
            end
            else if((pcr_val_2dly==1'b1) && (ram_raddr_2dly==i))
            begin
                if(pcr_pid_curr==ram_pcr_pid)
                begin
                    if(pcr_time_out==1'b1)
                    begin
                        ddr_rd_data_req[i]  <=  1'b1;
                    end
                    else if(pcr_correct_int_ena[i/PROG_PER_CHAN]==1'b0)
                    begin
                        ddr_rd_data_req[i]  <=  1'b1;
                    end
                    else if(temp==1'b1)
                    begin
                        ddr_rd_data_req[i]  <=  1'b1;
                    end
                end
                else
                begin
                    ddr_rd_data_req[i]  <=  1'b1;
                end
            end
            else if(ddr_rd_data_ack[i]==1'b1)
            begin
                ddr_rd_data_req[i]  <=  1'b0;
            end
        end
    end
endgenerate   

////////////////////////////////////////////////////////////////////
//pcr interval adaptation output
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_interval_data       <=  {128{1'b0}};
    end
    else if((memc_data_head_valid==1'b1) && (is_pcr_pkt==1'b1))
    begin
        pcr_interval_data       <=  {memc_data[127:13],memc_data[103:100],memc_data[8:0]};
    end
    else
    begin
        pcr_interval_data       <=  memc_data[127:0];
    end
end     

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_interval_data_valid <=  {TOTAL_CHN_NUM{1'b0}};
    end
    else
    begin
        pcr_interval_data_valid <=  memc_rd_data_valid;
    end
end
                
////////////////////////////////////////////////////////////////////
//ram width:112bit,ram_depth:256,read latency=2
//data structure:{pcr_pid[12:0],pcr_lo_base[32:0],pcr_ori_base[32:0],pcr_ori_base_adj[32:0]}
////////////////////////////////////////////////////////////////////
syncram_w112d256 u0_syncram_w112d256(
    .clka                               ( clk                       ),
    .wea                                ( ram_wren                  ),
    .addra                              ( ram_waddr                 ),
    .dina                               ( ram_wdata                 ),
    .clkb                               ( clk                       ),
    .addrb                              ( ram_raddr                 ),
    .doutb                              ( ram_rdata                 )
    );
 
assign  ram_ori_base_adj=   ram_rdata[32:0];
assign  ram_lo_base     =   ram_rdata[65:33];
assign  ram_ori_base    =   ram_rdata[98:66];
assign  ram_pcr_pid     =   ram_rdata[111:99];

endmodule
