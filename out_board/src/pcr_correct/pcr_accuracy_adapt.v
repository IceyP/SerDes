/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   pcr_accuracy_adapt.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-09-10  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   pcr_accuracy_adapt.v
    File tree    :   pcr_accuracy_adapt.v
\************************************************************************************/

`timescale 1ns/100ps

(*use_dsp48="yes"*)
module pcr_accuracy_adapt(
    rst                         ,
    clk                         , 
    ts_sync                     ,
    ts_valid                    ,
    ts_data                     ,
    pcr_lo_data                 ,
    pcr_cor_data
    );

parameter   U_DLY                       = 1                         ;
parameter   RAM_WIDTH                   = 144                       ;
parameter   RAM_DEPTH_BIT               = 4                         ;

input                                   rst                         ;
input                                   clk                         ;
input                                   ts_sync                     ;
input                                   ts_valid                    ;
input   [7:0]                           ts_data                     ;
input   [41:0]                          pcr_lo_data                 ;
output  [41:0]                          pcr_cor_data                ;

reg                                     ts_i_sync                   ;
reg                                     ts_i_valid                  ;
reg                                     ts_sync_1dly                ;
reg                                     ts_sync_2dly                ;
reg                                     ts_sync_3dly                ;
reg                                     ts_valid_1dly               ;
reg                                     ts_valid_2dly               ;
reg                                     ts_valid_3dly               ;
reg     [7:0]                           byte_cnt                    ;
reg                                     pcr_ready                   ;
reg     [12:0]                          pcr_pid                     ;
reg     [1:0]                           adapt_field_ctrl            ;
reg     [7:0]                           adapt_field_len             ;
reg                                     pcr_flag                    ;
wire                                    adapt_field_len_buf         ;
reg     [41:0]                          pcr_cor_data                ;
reg                                     pcr_ready_1dly              ;
reg                                     pcr_ready_pos               ;

wire    [32:0]                          pcr_lo_base_interval_buf    ;
wire    [32:0]                          pcr_ori_base_interval_buf   ;
wire    [8:0]                           pcr_lo_ext_interval_buf     ;
reg     [32:0]                          pcr_lo_base_interval        ;
reg     [32:0]                          pcr_ori_base_interval       ;
reg     [8:0]                           pcr_lo_ext_interval         ;
reg                                     pcr_time_out                ;
wire    [12:0]                          ram_pcr_pid                 ;
wire    [32:0]                          ram_lo_base                 ;
wire    [8:0]                           ram_lo_ext                  ;
wire    [32:0]                          ram_ori_base                ;
wire    [8:0]                           ram_ori_ext                 ;
wire    [32:0]                          ram_cor_base                ;
wire    [8:0]                           ram_cor_ext                 ;
reg                                     ram_wren                    ;
reg     [RAM_DEPTH_BIT - 1 : 0]         ram_waddr                   ;
wire    [RAM_DEPTH_BIT - 1 : 0]         ram_raddr                   ;
wire    [9:0]                           pcr_ext_lo_carry            ;
wire    [32:0]                          temp1                       ;
reg     [32:0]                          pcr_cor_base_temp           ;
reg     [9:0]                           pcr_cor_ext_temp            ;
reg     [32:0]                          pcr_cor_base_buf            ;
reg     [8:0]                           pcr_cor_ext_buf             ;
wire    [32:0]                          base_temp1                  ;
wire    [32:0]                          base_temp2                  ;
reg     [32:0]                          sub_base_temp               ;
wire                                    pcr_continue_flag           ;
reg     [32:0]                          pcr_lo_base                 ;
reg     [8:0]                           pcr_lo_ext                  ;
reg     [32:0]                          pcr_ori_base                ;
reg     [8:0]                           pcr_ori_ext                 ;
reg     [RAM_WIDTH - 1 : 0]             ram_wdata                   ;
wire    [RAM_WIDTH - 1 : 0]             ram_rdata                   ;
reg     [3:0]                           program_num                 ;
reg     [6:0]                           pcr_val_dly                 ;

assign  adapt_field_len_buf =   | adapt_field_len;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_sync_1dly    <=  1'b0;
        ts_sync_2dly    <=  1'b0;
        ts_sync_3dly    <=  1'b0;
        ts_i_sync       <=  1'b0;
        ts_valid_1dly   <=  1'b0;
        ts_valid_2dly   <=  1'b0;
        ts_valid_3dly   <=  1'b0;
        ts_i_valid      <=  1'b0;
    end
    else
    begin
        ts_sync_1dly    <=  ts_sync;
        ts_sync_2dly    <=  ts_sync_1dly;
        ts_sync_3dly    <=  ts_sync_2dly;
        ts_i_sync       <=  ts_sync_3dly;
        ts_valid_1dly   <=  ts_valid;
        ts_valid_2dly   <=  ts_valid_1dly;
        ts_valid_3dly   <=  ts_valid_2dly;
        ts_i_valid      <=  ts_valid_3dly;
    end 
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if(ts_i_sync==1'b1)
    begin
        byte_cnt    <=  8'h01;
    end
    else if((ts_i_valid==1'b1) && (byte_cnt>0))
    begin
        byte_cnt    <=  byte_cnt + 8'h01;
    end
    else if(byte_cnt>=187)
    begin
        byte_cnt    <=  8'h00;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_pid             <=  {13{1'b0}};
        adapt_field_ctrl    <=  2'b00;
        adapt_field_len     <=  8'h00;
        pcr_flag            <=  1'b0;
        pcr_ori_base        <=  {33{1'b0}};
        pcr_ori_ext         <=  {9{1'b0}};
        program_num         <=  4'h0;
    end
    else if(ts_i_valid==1'b1)
    begin
        case(byte_cnt)
            8'h01:  pcr_pid[12:8]       <=  ts_data[4:0];
            8'h02:  pcr_pid[7:0]        <=  ts_data;
            8'h03:  adapt_field_ctrl    <=  ts_data[5:4];
            8'h04:  adapt_field_len     <=  ts_data;
            8'h05:  pcr_flag            <=  ts_data[4];
            8'h06:  pcr_ori_base[32:25] <=  ts_data;
            8'h07:  pcr_ori_base[24:17] <=  ts_data;
            8'h08:  pcr_ori_base[16:9]  <=  ts_data;
            8'h09:  pcr_ori_base[8:1]   <=  ts_data;
            8'h0a:  
                begin 
                    pcr_ori_base[0]     <=  ts_data[7];
                    program_num         <=  ts_data[4:1];
                    pcr_ori_ext[8]      <=  ts_data[0];
                end
            8'h0b:  pcr_ori_ext[7:0]    <=  ts_data;
            default:;
        endcase
    end
end
       
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_ready   <=  1'b0;
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==11) &&
            (adapt_field_ctrl[1]==1'b1) &&
            (adapt_field_len_buf==1'b1) && (pcr_flag==1'b1))
    begin
        pcr_ready   <=  1'b1;
    end
    else if(ts_i_sync==1'b1)
    begin
        pcr_ready   <=  1'b0;
    end
end   

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_ready_1dly  <=  1'b0;
        pcr_ready_pos   <=  1'b0;
    end
    else
    begin
        pcr_ready_1dly  <=  pcr_ready;
        pcr_ready_pos   <=  (~pcr_ready_1dly) & pcr_ready;
    end
end
        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_lo_base <=  {33{1'b0}};
        pcr_lo_ext  <=  {9{1'b0}};
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==11) &&
            (adapt_field_ctrl[1]==1'b1) &&
            (adapt_field_len_buf==1'b1) && (pcr_flag==1'b1))
    begin
        pcr_lo_base <=  pcr_lo_data[41:9];
        pcr_lo_ext  <=  pcr_lo_data[8:0];
    end
end

////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_val_dly     <=  {7{1'b0}};
    end
    else
    begin
        pcr_val_dly     <=  {pcr_val_dly[5:0],pcr_ready_pos};
    end
end

assign  ram_raddr   =   program_num;

////////////////////////////////////////////////////////////////////
//pcr_val_dly[1]
////////////////////////////////////////////////////////////////////
assign  pcr_lo_base_interval_buf    =   (pcr_lo_ext < ram_lo_ext)   ?   (pcr_lo_base - 33'd1 - ram_lo_base)     :
                                        (pcr_lo_base - ram_lo_base);
assign  pcr_ori_base_interval_buf   =   (pcr_ori_ext < ram_ori_ext) ?   (pcr_ori_base - 33'd1 - ram_ori_base)   :
                                        (pcr_ori_base - ram_ori_base);
assign  pcr_lo_ext_interval_buf     =   (pcr_lo_ext < ram_lo_ext)   ?   ((pcr_lo_ext + 9'd300) - ram_lo_ext)    :
                                        (pcr_lo_ext - ram_lo_ext);

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_lo_base_interval    <=  {33{1'b0}};
        pcr_ori_base_interval   <=  {33{1'b0}};
        pcr_lo_ext_interval     <=  {9{1'b0}};
    end
    else if(pcr_val_dly[1]==1'b1)
    begin
        pcr_lo_base_interval    <=  pcr_lo_base_interval_buf;
        pcr_ori_base_interval   <=  pcr_ori_base_interval_buf;
        pcr_lo_ext_interval     <=  pcr_lo_ext_interval_buf;
    end
end

////////////////////////////////////////////////////////////////////
//pcr_val_dly[2]
////////////////////////////////////////////////////////////////////                                                                     
assign  pcr_ext_lo_carry        =   {1'b0,ram_cor_ext[8:0]} + {1'b0,pcr_lo_ext_interval[8:0]};
assign  temp1                   =   ram_cor_base + pcr_lo_base_interval;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_cor_base_temp   <=  {33{1'b0}};
        pcr_cor_ext_temp    <=  {9{1'b0}};
    end
    else if(pcr_val_dly[2]==1'b1)
    begin
        if(pcr_ext_lo_carry>299)
        begin
            pcr_cor_base_temp   <=  temp1 + 33'd1;
            pcr_cor_ext_temp    <=  pcr_ext_lo_carry - 10'd300;
        end
        else
        begin
            pcr_cor_base_temp   <=  temp1;
            pcr_cor_ext_temp    <=  pcr_ext_lo_carry;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_time_out    <=  1'b0;
    end
    else if(pcr_val_dly[2]==1'b1)
    begin
        if((pcr_lo_base_interval<3600) && (pcr_ori_base_interval<3600))
        begin
            pcr_time_out    <=  1'b0;
        end
        else
        begin
            pcr_time_out    <=  1'b1;
        end
    end
end

////////////////////////////////////////////////////////////////////
//pcr_val_dly[3]
////////////////////////////////////////////////////////////////////                                          
assign  pcr_continue_flag   =   ((pcr_pid==ram_pcr_pid) && (pcr_time_out==1'b0))    ?   1'b1    :   1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_cor_base_buf    <=  {33{1'b0}};
        pcr_cor_ext_buf     <=  {9{1'b0}};
    end
    else if(pcr_val_dly[3]==1'b1)
    begin
        if(pcr_continue_flag==1'b1)
        begin
            pcr_cor_base_buf    <=  pcr_cor_base_temp;
            pcr_cor_ext_buf     <=  pcr_cor_ext_temp[8:0];
        end
        else
        begin
            pcr_cor_base_buf    <=  pcr_ori_base;
            pcr_cor_ext_buf     <=  pcr_ori_ext;
        end
    end
end

////////////////////////////////////////////////////////////////////
//pcr_val_dly[4]
////////////////////////////////////////////////////////////////////
assign  base_temp1      =   pcr_ori_base - pcr_cor_base_buf;
assign  base_temp2      =   pcr_cor_base_buf - pcr_ori_base;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sub_base_temp   <=  {33{1'b0}};
    end
    else if(pcr_val_dly[4]==1'b1)
    begin
        if(base_temp1 > base_temp2)
        begin
            sub_base_temp   <=  base_temp2;
        end
        else
        begin
            sub_base_temp   <=  base_temp1;
        end
    end
end

////////////////////////////////////////////////////////////////////
//pcr_val_dly[5]
////////////////////////////////////////////////////////////////////
//>100 minutes,then reload
assign  pcr_cor_reload_flag     =   (|sub_base_temp[32:29] == 1'b1) ?   1'b1    :   1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pcr_cor_data    <=  {42{1'b0}};
    end
    else if(pcr_val_dly[5]==1'b1)
    begin
        if(pcr_cor_reload_flag==1'b1)
        begin
            pcr_cor_data    <=  {pcr_ori_base[32:0],pcr_ori_ext[8:0]};
        end
        else
        begin
            pcr_cor_data    <=  {pcr_cor_base_buf[32:0],pcr_cor_ext_buf[8:0]};
        end
    end
end

////////////////////////////////////////////////////////////////////
//pcr_val_dly[6]
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ram_wren    <=  1'b0;
        ram_waddr   <=  {RAM_DEPTH_BIT{1'b0}};
        ram_wdata   <=  {RAM_WIDTH{1'b0}};
    end
    else if(pcr_val_dly[6]==1'b1)
    begin
        ram_wren    <=  1'b1;
        ram_waddr   <=  ram_raddr;
        ram_wdata   <=  {{5{1'b0}},pcr_pid[12:0],pcr_lo_base[32:0],pcr_lo_ext[8:0],
                        pcr_ori_base[32:0],pcr_ori_ext[8:0],pcr_cor_data[41:9],pcr_cor_data[8:0]};
    end
    else
    begin
        ram_wren    <=  1'b0;
        ram_waddr   <=  {RAM_DEPTH_BIT{1'b0}};
        ram_wdata   <=  {RAM_WIDTH{1'b0}};
    end
end 
                           
////////////////////////////////////////////////////////////////////
//width:144,depth:16,read latency=2
//reserved     pcr_pid     lo_base      lo_ext     ori_base    ori_ext   cor_base    cor_ext
//[143:139]   [138:126]    [125:93]     [92:84]     [83:51]    [50:42]    [41:9]      [8:0]     
////////////////////////////////////////////////////////////////////             
pcr_lut u0_pcr_lut(
    .clka                               ( clk                       ),
    .wea                                ( ram_wren                  ),
    .addra                              ( ram_waddr                 ),
    .dina                               ( ram_wdata                 ),
    .clkb                               ( clk                       ),
    .addrb                              ( ram_raddr                 ),
    .doutb                              ( ram_rdata                 )
    );    

assign  ram_pcr_pid     =   ram_rdata[138:126];
assign  ram_lo_base     =   ram_rdata[125:93];
assign  ram_lo_ext      =   ram_rdata[92:84];
assign  ram_ori_base    =   ram_rdata[83:51];
assign  ram_ori_ext     =   ram_rdata[50:42];
assign  ram_cor_base    =   ram_rdata[41:9];
assign  ram_cor_ext     =   ram_rdata[8:0];

endmodule
