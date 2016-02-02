/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ddr_read_ctrl.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-09  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_read_ctrl.v
    File tree    :   ddr_read_ctrl.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_read_ctrl(
    clk                         ,
    rst                         ,
    clk_j83                     ,

    memc_rd_data                ,
    memc_rd_valid               ,
    
    ch0_data                    ,
    ch1_data                    ,
    ch2_data                    ,
    ch3_data                    ,
    ch4_data                    ,
    ch5_data                    ,
    ch6_data                    ,
    ch7_data                    ,
    ch_valid                    ,
    
    port_bp                     ,
    buf_bp                                        
    );

parameter   U_DLY                       = 1                         ;
parameter   BUF_DEPTH_BIT               = 9                         ;
parameter   TOTAL_CHN_NUM               = 16                        ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_j83                     ;

input   [127:0]                         memc_rd_data                ;
input   [TOTAL_CHN_NUM - 1 : 0]         memc_rd_valid               ;

output  [7:0]                           ch0_data                    ;
output  [7:0]                           ch1_data                    ;
output  [7:0]                           ch2_data                    ;
output  [7:0]                           ch3_data                    ;
output  [7:0]                           ch4_data                    ;
output  [7:0]                           ch5_data                    ;
output  [7:0]                           ch6_data                    ;
output  [7:0]                           ch7_data                    ;
output  [TOTAL_CHN_NUM - 1 : 0]         ch_valid                    ;

input   [TOTAL_CHN_NUM - 1 : 0]         port_bp                     ;
output  [TOTAL_CHN_NUM - 1 : 0]         buf_bp                      ;

wire    [BUF_DEPTH_BIT - 1 : 0]         datacnt_ch[TOTAL_CHN_NUM - 1 : 0];
reg     [127:0]                         wr_data                     ;
reg     [TOTAL_CHN_NUM - 1 : 0]         wr_en_ch                    ;
reg     [4:0]                           byte_cnt[TOTAL_CHN_NUM - 1 : 0];
reg     [TOTAL_CHN_NUM - 1 : 0]         rd_en_ch                    ;
reg     [7:0]                           data_ch[TOTAL_CHN_NUM - 1 : 0];
wire    [127:0]                         dout_ch[TOTAL_CHN_NUM - 1 : 0];
reg     [TOTAL_CHN_NUM - 1 : 0]         ch_valid                    ;
reg     [TOTAL_CHN_NUM - 1 : 0]         buf_bp                      ;
wire    [TOTAL_CHN_NUM - 1 : 0]         buf_almost_full             ;
wire    [TOTAL_CHN_NUM - 1 : 0]         buf_empty                   ;
reg     [7:0]                           counter[TOTAL_CHN_NUM - 1 : 0];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        wr_data     <=  {128{1'b0}};
        wr_en_ch    <=  {TOTAL_CHN_NUM{1'b0}};
    end
    else
    begin
        wr_data     <=  #U_DLY memc_rd_data;
        wr_en_ch    <=  #U_DLY memc_rd_valid;
    end
end

generate
    genvar j;
    for(j=0;j<TOTAL_CHN_NUM;j=j+1)
    begin:INST_RD_BUF
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                byte_cnt[j]    <=  5'h0;
            end
            else if(rd_en_ch[j]==1'b1)
            begin
                byte_cnt[j]    <=  #U_DLY 5'h1;
            end
            else if(byte_cnt[j]==16)
            begin
                byte_cnt[j]    <=  #U_DLY 5'h0;
            end
            else if(byte_cnt[j]>0)
            begin
                byte_cnt[j]    <=  #U_DLY byte_cnt[j] + 5'h1;
            end
        end
                
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                rd_en_ch[j] <=  1'b0;
            end
            else if(rd_en_ch[j]==1'b1)
            begin
                rd_en_ch[j] <=  #U_DLY 1'b0;
            end
            else if(((byte_cnt[j]==15) || (byte_cnt[j]==0)) &&
                    (buf_empty[j]==1'b0) && (port_bp[j]==1'b0))
            begin
                rd_en_ch[j] <=  #U_DLY 1'b1;
            end
            else
            begin
                rd_en_ch[j] <=  #U_DLY 1'b0;
            end
        end
        
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                counter[j]  <=  8'h00;
            end
            else if(counter[j]>=191)
            begin
                counter[j]  <=  #U_DLY 8'h00;
            end
            else if(byte_cnt[j]>0)
            begin
                counter[j]  <=  #U_DLY counter[j] + 8'h01;
            end
        end
            
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ch_valid[j] <=  1'b0;
            end
            else if((byte_cnt[j]>0) && (counter[j]>3))
            begin
                ch_valid[j] <=  #U_DLY 1'b1;
            end
            else
            begin
                ch_valid[j] <=  #U_DLY 1'b0;
            end
        end
        
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                buf_bp[j]   <=  1'b0;
            end
            else if((datacnt_ch[j]>128) || (buf_almost_full[j]==1'b1))
            begin
                buf_bp[j]   <=  #U_DLY 1'b1;
            end
            else if(datacnt_ch[j]<104)
            begin
                buf_bp[j]   <=  #U_DLY 1'b0;
            end
        end
        
        always@(posedge clk_j83 or posedge rst)
        begin
            if(rst==1'b1)
            begin
                data_ch[j]  <=  8'h00;
            end
            else
            begin
                case(byte_cnt[j])
                5'd1:       data_ch[j]  <=  #U_DLY dout_ch[j][127:120];
                5'd2:       data_ch[j]  <=  #U_DLY dout_ch[j][119:112];
                5'd3:       data_ch[j]  <=  #U_DLY dout_ch[j][111:104];
                5'd4:       data_ch[j]  <=  #U_DLY dout_ch[j][103:96];
                5'd5:       data_ch[j]  <=  #U_DLY dout_ch[j][95:88];
                5'd6:       data_ch[j]  <=  #U_DLY dout_ch[j][87:80];
                5'd7:       data_ch[j]  <=  #U_DLY dout_ch[j][79:72];
                5'd8:       data_ch[j]  <=  #U_DLY dout_ch[j][71:64];
                5'd9:       data_ch[j]  <=  #U_DLY dout_ch[j][63:56];
                5'd10:      data_ch[j]  <=  #U_DLY dout_ch[j][55:48];
                5'd11:      data_ch[j]  <=  #U_DLY dout_ch[j][47:40];
                5'd12:      data_ch[j]  <=  #U_DLY dout_ch[j][39:32];
                5'd13:      data_ch[j]  <=  #U_DLY dout_ch[j][31:24];
                5'd14:      data_ch[j]  <=  #U_DLY dout_ch[j][23:16];
                5'd15:      data_ch[j]  <=  #U_DLY dout_ch[j][15:8];
                5'd16:      data_ch[j]  <=  #U_DLY dout_ch[j][7:0];
                default:    data_ch[j]  <=  #U_DLY 8'h00;
                endcase
            end
        end
        
        //width:128bit;depth:512
        rd_buf u_rd_buf(
            .wr_clk                     ( clk                       ),
            .rd_clk                     ( clk_j83                   ),
            .rst                        ( rst                       ),
            .din                        ( wr_data                   ),
            .wr_en                      ( wr_en_ch[j]               ),
            .rd_en                      ( rd_en_ch[j]               ),
            .dout                       ( dout_ch[j]                ),
            .full                       ( /*not used*/              ),
            .almost_full                ( buf_almost_full[j]        ),
            .empty                      ( buf_empty[j]              ),
            .almost_empty               ( /*not used*/              ),
            .rd_data_count              ( datacnt_ch[j]             )
            );
    end
endgenerate    

assign  ch0_data    =   data_ch[0];
assign  ch1_data    =   data_ch[1];
assign  ch2_data    =   data_ch[2];
assign  ch3_data    =   data_ch[3];
assign  ch4_data    =   data_ch[4];
assign  ch5_data    =   data_ch[5];
assign  ch6_data    =   data_ch[6];
assign  ch7_data    =   data_ch[7];
   
endmodule
