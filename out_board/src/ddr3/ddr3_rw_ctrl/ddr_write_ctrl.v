/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   ddr_write_ctrl.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-07-15  huangrui/1480       1.0         IPQAM       Create
    2013-08-16  huangrui/1480       1.1         IPQAM
    ==================================================================================
    Called by    :   ddr_write_ctrl.v
    File tree    :   ddr_write_ctrl.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_write_ctrl(
    clk_rx                      ,
    rst_rx                      ,
    clk                         ,
    rst                         ,  
    ts_addr                     ,
    ts_data                     ,
    ts_valid                    ,
    pcr_lo_base                 ,
    pcr_correct_int_ena         ,
    
    memc_cmd_ack                ,
    memc_cmd_req                ,
    memc_cmd                    ,
    memc_cmd_addr               ,
    memc_wr_req                 ,
    memc_wr_end                 ,
    memc_wr_mask                ,
    memc_wr_data                ,
    memc_wr_ack                 ,
    memc_rd_data                ,
    memc_rd_valid               ,

    pcr_interval_data           ,
    pcr_interval_data_valid     ,
    
    drop_pkt_flag               ,
    dejitter_ms                 ,
    buf_bp
    );

parameter   U_DLY                       = 1                         ;
parameter   WAIT_CYCLE_NUM              = 60                        ;
parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   TOTAL_CHN_NUM               = 16                        ;
parameter   PROG_BIT_WIDTH              = 9                         ;
parameter   WORD_NUM_ONE_WRITE          = 84                        ;   //7 ts packets
//parameter   WORD_NUM_ONE_WRITE          = 12                        ;   //1 ts packet
parameter   DDR3_ADDR_WIDTH             = 28                        ;


parameter   DROP_PKT_THRE_H             = 2 ** PKT_ADDR_WIDTH - 100 ;
parameter   DROP_PKT_THRE_L             = 500                       ;
parameter   TEMP_BIT                    = DDR3_ADDR_WIDTH - PROG_BIT_WIDTH;
parameter   CHN_BIT_H                   = DDR3_ADDR_WIDTH - 2       ;
parameter   CHN_BIT_L                   = TEMP_BIT - 1              ;
parameter   TOTAL_PROG_NUM              = 2 ** PROG_BIT_WIDTH       ;
parameter   ADDR_WIDTH                  = TEMP_BIT - 4              ;
parameter   PROG_PER_CHAN               = TOTAL_PROG_NUM / TOTAL_CHN_NUM;
parameter   TEMP_WIDTH                  = 14 - PROG_BIT_WIDTH       ;
parameter   TS_WRITE_DATA_THRE          = WORD_NUM_ONE_WRITE + 1    ;
parameter   WR_CNT_THRE                 = WORD_NUM_ONE_WRITE - 1    ;

parameter   PKT_ADDR_WIDTH              = TEMP_BIT - 8              ;
parameter   PKT_BIT_H                   = TEMP_BIT - 2              ;
parameter   PKT_BIT_L                   = 7                         ;
parameter   SHIFT_RAM_WIDTH             = PROG_BIT_WIDTH + PKT_ADDR_WIDTH + 1;

parameter   ST_WIDTH                    = 10                        ;
parameter   ST_IDLE                     = 10'b00_0000_0001          ,
            ST_HEAD_REQ_JUDGE           = 10'b00_0000_0010          ,
            ST_HEAD_REQ_JUDGE_2         = 10'b00_0000_0100          ,
            ST_CMD_READ_HEAD            = 10'b00_0000_1000          ,
            ST_WAIT_RD_HEAD_RESULT      = 10'b00_0001_0000          ,
            ST_DATA_REQ_JUDGE           = 10'b00_0010_0000          ,
            ST_CMD_READ_DATA            = 10'b00_0100_0000          ,
            ST_RD_DATA_END              = 10'b00_1000_0000          ,
            ST_CMD_WRITE_DATA_1         = 10'b01_0000_0000          ,
            ST_CMD_WRITE_DATA_2         = 10'b10_0000_0000          ;

input                                   clk_rx                      ;
input                                   rst_rx                      ;
input                                   clk                         ;
input                                   rst                         ;
input   [DDR3_ADDR_WIDTH - 1 : 0]       ts_addr                     ;
input   [127:0]                         ts_data                     ;
input                                   ts_valid                    ;
input   [32:0]                          pcr_lo_base                 ;
input   [TOTAL_CHN_NUM - 1 : 0]         pcr_correct_int_ena         ;

input                                   memc_cmd_ack                ;
output                                  memc_cmd_req                ;
output  [2:0]                           memc_cmd                    ;
output  [DDR3_ADDR_WIDTH - 1 : 0]       memc_cmd_addr               ;

output                                  memc_wr_req                 ;
output                                  memc_wr_end                 ;
output  [15:0]                          memc_wr_mask                ;
output  [127:0]                         memc_wr_data                ;
input                                   memc_wr_ack                 ;
input   [127:0]                         memc_rd_data                ;
input                                   memc_rd_valid               ;

output  [127:0]                         pcr_interval_data           ;
output  [TOTAL_CHN_NUM - 1 : 0]         pcr_interval_data_valid     ;

output  [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag               ;
input   [10:0]                          dejitter_ms                 ;
input   [TOTAL_CHN_NUM - 1 : 0]         buf_bp                      ;

reg     [ST_WIDTH - 1 : 0]              st_curr                     ;   ///* synthesis syn_encoding = "safe,onehot" */
reg     [ST_WIDTH - 1 : 0]              st_next                     ;
reg     [PKT_ADDR_WIDTH - 1 : 0]        ddr_wr_addr_dly_ch[TOTAL_PROG_NUM - 1 : 0];
wire    [PKT_ADDR_WIDTH - 1 : 0]        ddr_word_num_ch[TOTAL_PROG_NUM - 1 : 0];
reg     [PKT_ADDR_WIDTH - 1 : 0]        ddr_rd_addr_pkt[TOTAL_PROG_NUM - 1 : 0];

reg     [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_start                ;
reg     [3:0]                           ddr_rd_addr_ch[TOTAL_PROG_NUM - 1 : 0];
reg     [PKT_ADDR_WIDTH - 1 : 0]        ddr_rd_head_addr_ch[TOTAL_PROG_NUM - 1 : 0];
wire                                    ts_addr_rden                ;
wire    [DDR3_ADDR_WIDTH - 1 : 0]       ts_addr_out                 ;
wire    [PROG_BIT_WIDTH - 1 : 0]        ddr_rd_chn_num              ;
reg     [PROG_BIT_WIDTH - 1 : 0]        ddr_rd_chn_num_buf          ;

wire    [DDR3_ADDR_WIDTH - 1 : 0]       memc_cmd_addr               ;
wire                                    memc_cmd_req                ;
wire    [2:0]                           memc_cmd                    ;

wire                                    ts_data_rden                ;
wire                                    memc_wr_req                 ;
wire                                    memc_wr_end                 ;
wire    [15:0]                          memc_wr_mask                ;
wire    [127:0]                         memc_wr_data                ;

wire    [127:0]                         ts_data_out                 ;
reg     [3:0]                           rd_cnt                      ;
reg     [6:0]                           wr_cnt                      ;
wire                                    data_almost_empty           ;
wire    [8:0]                           data_cnt                    ;
wire    [8:0]                           data_fifo_cnt               ;
reg     [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag               ;
reg     [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_head_req             ;
wire    [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_ack_ch          ;
wire    [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_ack_pkt         ;
wire    [TOTAL_PROG_NUM - 1 : 0]        ddr_rd_data_req             ;
wire                                    ddr_rd_data_ack             ;
wire                                    ddr_rd_head_ack             ;
wire                                    ddr_wr_data_ack             ;
reg     [6:0]                           wait_cnt                    ;

reg     [15:0]                          type_fifo_din               ;
reg                                     type_fifo_wren              ;
wire                                    type_fifo_rden              ;
wire    [15:0]                          type_fifo_dout              ;
wire                                    type_fifo_full              ;
wire                                    type_fifo_empty             ;
wire    [9:0]                           type_fifo_datacnt           ;
reg                                     memc_rd_valid_1dly          ;
reg     [TOTAL_PROG_NUM - 1 : 0]        memc_rd_head_valid          ;
reg     [TOTAL_CHN_NUM - 1 : 0]         memc_rd_data_valid          ;
reg                                     memc_data_head_valid        ;
wire    [1:0]                           fifo_rd_type                ;
wire    [PROG_BIT_WIDTH - 1 : 0]        fifo_rd_chn_num             ;
wire    [CHNNUM_BIT_WIDTH - 1 : 0]      fifo_rd_chn_num_buf         ;
reg     [127:0]                         memc_rd_data_1dly           ;
reg     [127:0]                         memc_out_data               ;
wire                                    has_rd_data_req             ;
wire                                    has_rd_head_req             ;
wire                                    write_state                 ;
wire    [PKT_ADDR_WIDTH - 1 : 0]        dejitter_thres              ;
(*KEEP = "TRUE"*)
wire                                    rst_fifo                    ;
reg     [SHIFT_RAM_WIDTH - 1 : 0]       shift_din                   ;
wire    [SHIFT_RAM_WIDTH - 1 : 0]       shift_dout                  ;

assign  rst_fifo            =   rst_rx | rst;
assign  has_rd_data_req     =   |ddr_rd_data_req;
assign  has_rd_head_req     =   |ddr_rd_head_req;
assign  ddr_rd_chn_num      =   ddr_rd_chn_num_buf - 'h1;
assign  write_state         =   ((st_curr==ST_CMD_WRITE_DATA_1) || (st_curr==ST_CMD_WRITE_DATA_2)) ?    1'b1    :   1'b0;
assign  ddr_rd_head_ack     =   ((st_curr==ST_CMD_READ_HEAD) && (memc_cmd_ack==1'b1))   ?   1'b1    :   1'b0;
assign  ddr_rd_data_ack     =   ((st_curr==ST_CMD_READ_DATA) && (memc_cmd_ack==1'b1))   ?   1'b1    :   1'b0;
assign  ddr_wr_data_ack     =   write_state & memc_cmd_ack;
assign  dejitter_thres      =   {{(PKT_ADDR_WIDTH-12){1'b0}}, dejitter_ms[10:0],1'b0};
        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        rd_cnt  <=  {4{1'b0}};
    end
    else if((rd_cnt>=11) && (memc_cmd_ack==1'b1))
    begin
        rd_cnt  <=  #U_DLY {4{1'b0}};
    end
    else if(ddr_rd_data_ack==1'b1)
    begin
        rd_cnt  <=  #U_DLY rd_cnt + 4'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        wr_cnt  <=  {7{1'b0}};
    end
    else if((wr_cnt>=WR_CNT_THRE) && (memc_cmd_ack==1'b1))
    begin
        wr_cnt  <=  #U_DLY {7{1'b0}};
    end
    else if(ddr_wr_data_ack==1'b1)
    begin
        wr_cnt  <=  #U_DLY wr_cnt + 'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        wait_cnt    <=  {7{1'b0}};
    end
    else if(st_curr==ST_IDLE)
    begin
        wait_cnt    <=  #U_DLY {7{1'b0}};
    end
    else if(wait_cnt>=WAIT_CYCLE_NUM)
    begin
        wait_cnt    <=  #U_DLY WAIT_CYCLE_NUM;
    end
    else if(wait_cnt>0)
    begin
        wait_cnt    <=  #U_DLY wait_cnt + 7'b000_0001;
    end
    else if(st_curr==ST_WAIT_RD_HEAD_RESULT)
    begin
        wait_cnt    <=  #U_DLY 7'b000_0001;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ddr_rd_chn_num_buf  <=  {PROG_BIT_WIDTH{1'b0}};
    end
    else if((st_curr==ST_IDLE) || (st_curr==ST_WAIT_RD_HEAD_RESULT))
    begin
        ddr_rd_chn_num_buf  <=  #U_DLY {PROG_BIT_WIDTH{1'b0}};
    end
    else if((st_curr==ST_HEAD_REQ_JUDGE) || (st_curr==ST_DATA_REQ_JUDGE) || (st_curr==ST_HEAD_REQ_JUDGE_2))
    begin
        ddr_rd_chn_num_buf  <=  #U_DLY ddr_rd_chn_num_buf + 'h1;
    end
end
 
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        st_curr <=  ST_IDLE;
    end
    else
    begin
        st_curr <=  #U_DLY st_next;
    end
end

always@*
begin
    case(st_curr)
    ST_IDLE:
    begin
        if(data_cnt<TS_WRITE_DATA_THRE)
        begin
            st_next =   ST_HEAD_REQ_JUDGE;
        end
        else
        begin
            st_next =   ST_CMD_WRITE_DATA_1;
        end
    end
    ST_HEAD_REQ_JUDGE:
    begin
        if(has_rd_head_req==1'b1)
        begin
            if(ddr_rd_head_req[ddr_rd_chn_num_buf]==1'b1)
            begin
                st_next =   ST_CMD_READ_HEAD;
            end
            else
            begin
                st_next =   ST_HEAD_REQ_JUDGE;
            end
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_CMD_READ_HEAD:
    begin
        if(memc_cmd_ack==1'b1)
        begin
            if(data_cnt<TS_WRITE_DATA_THRE)
            begin
                st_next =   ST_HEAD_REQ_JUDGE_2;
            end
            else
            begin
                st_next =   ST_CMD_WRITE_DATA_1;
            end
        end
        else
        begin
            st_next =   ST_CMD_READ_HEAD;
        end
    end
    ST_HEAD_REQ_JUDGE_2:
    begin
        if(has_rd_head_req==1'b1)
        begin
            if(ddr_rd_head_req[ddr_rd_chn_num_buf]==1'b1)
            begin
                st_next =   ST_CMD_READ_HEAD;
            end
            else
            begin
                st_next =   ST_HEAD_REQ_JUDGE_2;
            end
        end
        else
        begin
            st_next =   ST_WAIT_RD_HEAD_RESULT;
        end
    end
    ST_WAIT_RD_HEAD_RESULT:
    begin
        if(wait_cnt<WAIT_CYCLE_NUM)
        begin
            st_next =   ST_WAIT_RD_HEAD_RESULT;         
        end
        else
        begin
            if(has_rd_data_req==1'b1)
            begin
                st_next =   ST_DATA_REQ_JUDGE;
            end
            else
            begin
                st_next =   ST_IDLE;
            end
        end
    end
    ST_DATA_REQ_JUDGE:
    begin
        if(has_rd_data_req==1'b1)
        begin
            if(ddr_rd_data_req[ddr_rd_chn_num_buf]==1'b1)
            begin
                st_next =   ST_CMD_READ_DATA;
            end
            else
            begin
                st_next =   ST_DATA_REQ_JUDGE;
            end
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end          
    ST_CMD_READ_DATA:
    begin
        if(rd_cnt<11)
        begin
            st_next =   ST_CMD_READ_DATA;
        end
        else if(memc_cmd_ack==1'b1)
        begin
            if(data_cnt<TS_WRITE_DATA_THRE)
            begin
                if(has_rd_data_req==1'b1)
                begin
                    st_next =   ST_DATA_REQ_JUDGE;
                end
                else
                begin
                    st_next =   ST_RD_DATA_END;
                end
            end
            else
            begin
                st_next =   ST_CMD_WRITE_DATA_2;
            end
        end
        else
        begin
            st_next =   ST_CMD_READ_DATA;
        end
    end 
    ST_RD_DATA_END:
    begin
        st_next =   ST_IDLE;
    end      
    ST_CMD_WRITE_DATA_1:
    begin
        if(wr_cnt<WR_CNT_THRE)
        begin
            st_next =   ST_CMD_WRITE_DATA_1;
        end
        else if(memc_cmd_ack==1'b1)
        begin
            if(data_cnt<TS_WRITE_DATA_THRE)
            begin
                if(has_rd_head_req==1'b1)
                begin
                    st_next =   ST_HEAD_REQ_JUDGE_2;
                end
                else
                begin
                    if(has_rd_data_req==1'b1)
                    begin
                        st_next =   ST_WAIT_RD_HEAD_RESULT;
                    end
                    else
                    begin
                        st_next =   ST_IDLE;
                    end
                end               
            end
            else
            begin
                st_next =   ST_CMD_WRITE_DATA_1;
            end
        end
        else
        begin
            st_next =   ST_CMD_WRITE_DATA_1;
        end
    end
    ST_CMD_WRITE_DATA_2:
    begin
        if(wr_cnt<WR_CNT_THRE)
        begin
            st_next =   ST_CMD_WRITE_DATA_2;
        end
        else if(memc_cmd_ack==1'b1)
        begin
            if(data_cnt<TS_WRITE_DATA_THRE)
            begin
                if(has_rd_data_req==1'b1)
                begin
                    st_next =   ST_DATA_REQ_JUDGE;
                end
                else
                begin
                    st_next =   ST_IDLE;
                end              
            end
            else
            begin
                st_next =   ST_CMD_WRITE_DATA_2;
            end
        end
        else
        begin
            st_next =   ST_CMD_WRITE_DATA_2;
        end
    end
    default:
    begin
        st_next =   ST_IDLE;
    end
    endcase
end
        
generate
    genvar j;
    for(j=0;j<TOTAL_PROG_NUM;j=j+1)
    begin:INST_DDR_RD_ADDR
        assign  ddr_word_num_ch[j]      =   ddr_wr_addr_dly_ch[j] - ddr_rd_addr_pkt[j];
        assign  ddr_rd_data_ack_ch[j]   =   ((ddr_rd_data_ack==1'b1) && (ddr_rd_chn_num==j) && (rd_cnt==0))     ? 1'b1 : 1'b0;
        assign  ddr_rd_data_ack_pkt[j]  =   ((ddr_rd_data_ack==1'b1) && (ddr_rd_chn_num==j) && (rd_cnt==11))    ? 1'b1 : 1'b0;
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_start[j]     <=  1'b0;
            end
            else if(j[3:0]==4'h0)       //program 0 of every channel is PSI table
            begin
                if(ddr_word_num_ch[j]>0)
                begin
                    ddr_rd_start[j]     <=  #U_DLY 1'b1;
                end
                else
                begin
                    ddr_rd_start[j]     <=  #U_DLY 1'b0;
                end
            end
            else if((ddr_word_num_ch[j]==0))
            begin
                ddr_rd_start[j]     <=  #U_DLY 1'b0;
            end
            else if(ddr_word_num_ch[j]>dejitter_thres)            
            begin
                ddr_rd_start[j]     <=  #U_DLY 1'b1;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                drop_pkt_flag[j] <=  1'b0;
            end
            else if(ddr_word_num_ch[j]>DROP_PKT_THRE_H)
            begin
                drop_pkt_flag[j] <=  #U_DLY 1'b1;
            end
            else if(ddr_word_num_ch[j]<DROP_PKT_THRE_L)
            begin
                drop_pkt_flag[j] <=  #U_DLY 1'b0;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_addr_ch[j]   <=  {4{1'b0}};
            end
            else if(ddr_rd_data_ack_pkt[j]==1'b1)
            begin
                ddr_rd_addr_ch[j]   <=  {4{1'b0}};
            end
            else if((ddr_rd_data_ack==1'b1) && (ddr_rd_chn_num==j))
            begin
                ddr_rd_addr_ch[j]   <=  #U_DLY ddr_rd_addr_ch[j] + 4'h1;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_addr_pkt[j]  <=  {PKT_ADDR_WIDTH{1'b0}};
            end
            else if(ddr_rd_data_ack_pkt[j]==1'b1)
            begin
                ddr_rd_addr_pkt[j]   <=  #U_DLY ddr_rd_addr_pkt[j] + 'h1;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_head_addr_ch[j]  <=  {PKT_ADDR_WIDTH{1'b0}};
            end
            else if(ddr_rd_data_ack_pkt[j]==1'b1)
            begin
                ddr_rd_head_addr_ch[j]  <=  #U_DLY ddr_rd_head_addr_ch[j] + 'h1;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_head_req[j]  <=  1'b0;
            end
            else if((st_curr==ST_IDLE) && (ddr_rd_start[j]==1'b1) && (buf_bp[j[(PROG_BIT_WIDTH-1) : (PROG_BIT_WIDTH-CHNNUM_BIT_WIDTH)]]==1'b0))
            begin
                ddr_rd_head_req[j]  <=  #U_DLY 1'b1;
            end
            else if((ddr_rd_head_ack==1'b1) && (ddr_rd_chn_num==j))
            begin
                ddr_rd_head_req[j]  <=  #U_DLY 1'b0;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_wr_addr_dly_ch[j]   <=  {PKT_ADDR_WIDTH{1'b0}};
            end
            else if((shift_dout[SHIFT_RAM_WIDTH - 2 : PKT_ADDR_WIDTH]==j) && (shift_dout[SHIFT_RAM_WIDTH - 1]==1'b1))
            begin
                ddr_wr_addr_dly_ch[j]   <=  #U_DLY shift_dout[PKT_ADDR_WIDTH - 1 : 0] + 'h1;
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                memc_rd_head_valid[j]   <=  1'b0;
            end
            else if((memc_rd_valid_1dly==1'b1) && (fifo_rd_type==2'b01) && (fifo_rd_chn_num==j))
            begin
                memc_rd_head_valid[j]   <=  1'b1;
            end
            else
            begin
                memc_rd_head_valid[j]   <=  1'b0;
            end
        end
    end
endgenerate

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        shift_din   <=  {SHIFT_RAM_WIDTH{1'b0}};
    end
    else
    begin
        shift_din   <=  {ts_addr_out[DDR3_ADDR_WIDTH - 1],ts_addr_out[CHN_BIT_H:PKT_BIT_L]};
    end
end

assign  ts_addr_rden    =   (ddr_wr_data_ack==1'b1) ?   1'b1    :   1'b0;
//memc_cmd_addr
assign  memc_cmd_addr   =   (ddr_wr_data_ack==1'b1) ?   {1'b0,ts_addr_out[DDR3_ADDR_WIDTH - 2 : 0]} :
                            (ddr_rd_head_ack==1'b1) ?   {1'b0,ddr_rd_chn_num[PROG_BIT_WIDTH - 1:0],ddr_rd_head_addr_ch[ddr_rd_chn_num],{7{1'b0}}} :
                            (ddr_rd_data_ack==1'b1) ?   {1'b0,ddr_rd_chn_num[PROG_BIT_WIDTH - 1:0],ddr_rd_addr_pkt[ddr_rd_chn_num],ddr_rd_addr_ch[ddr_rd_chn_num],3'b000} :
                            {DDR3_ADDR_WIDTH{1'b0}};

//memc_cmd_req
assign  memc_cmd_req    =   ((write_state==1'b1) || (st_curr==ST_CMD_READ_DATA) || (st_curr==ST_CMD_READ_HEAD))  ?   1'b1    :   1'b0;

//memc_cmd,3'b000:write;3'b001:read;
assign  memc_cmd        =   ((st_curr==ST_CMD_READ_DATA) || (st_curr==ST_CMD_READ_HEAD)) ?   3'b001  :    3'b000;

assign  ts_data_rden    =   ((memc_wr_ack==1'b1) && (data_almost_empty==1'b0)) ?   1'b1    :   1'b0;

assign  memc_wr_req     =   ts_data_rden;
assign  memc_wr_data    =   ts_data_out;
assign  memc_wr_end     =   ts_data_rden;
assign  memc_wr_mask    =   16'h0000;

////////////////////////////////////////////////////////////////////
//ddr3 read type fifo,1kx16bit,read latency=1
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        type_fifo_wren  <=  1'b0;
    end
    else if((ddr_rd_head_ack==1'b1) || (ddr_rd_data_ack==1'b1))
    begin
        type_fifo_wren  <=  1'b1;
    end
    else
    begin
        type_fifo_wren  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        type_fifo_din   <=  {16{1'b0}};
    end
    else if(ddr_rd_head_ack==1'b1)
    begin
        type_fifo_din   <=  {{TEMP_WIDTH{1'b0}},2'b01,ddr_rd_chn_num[PROG_BIT_WIDTH - 1:0]};
    end
    else if(|ddr_rd_data_ack_ch==1'b1)
    begin
        type_fifo_din   <=  {{TEMP_WIDTH{1'b0}},2'b10,ddr_rd_chn_num[PROG_BIT_WIDTH - 1:0]};
    end
    else if(ddr_rd_data_ack==1'b1)
    begin
        type_fifo_din   <=  {{TEMP_WIDTH{1'b0}},2'b11,ddr_rd_chn_num[PROG_BIT_WIDTH - 1:0]};
    end
    else
    begin
        type_fifo_din   <=  {16{1'b0}};
    end
end

assign  type_fifo_rden  =   memc_rd_valid;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        memc_rd_valid_1dly  <=  1'b0;
    end
    else
    begin
        memc_rd_valid_1dly  <=  memc_rd_valid;
    end
end

generate
    genvar i;
    for(i=0;i<TOTAL_CHN_NUM;i=i+1)
    begin:INST_DDR3_RD_DAT_VAL
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                memc_rd_data_valid[i]   <=  1'b0;
            end
            else if((memc_rd_valid_1dly==1'b1) && (fifo_rd_type[1]==1'b1) && (fifo_rd_chn_num_buf==i))
            begin
                memc_rd_data_valid[i]   <=  1'b1;
            end
            else
            begin
                memc_rd_data_valid[i]   <=  1'b0;
            end
        end
    end
endgenerate

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        memc_data_head_valid    <=  1'b0;
    end
    else if((memc_rd_valid_1dly==1'b1) && (fifo_rd_type==2'b10))
    begin
        memc_data_head_valid    <=  1'b1;
    end
    else
    begin
        memc_data_head_valid    <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        memc_rd_data_1dly   <=  {128{1'b0}};
        memc_out_data       <=  {128{1'b0}};
    end
    else
    begin
        memc_rd_data_1dly   <=  memc_rd_data;
        memc_out_data       <=  memc_rd_data_1dly;
    end
end
    
assign  fifo_rd_type        =   type_fifo_dout[PROG_BIT_WIDTH + 1 : PROG_BIT_WIDTH];
assign  fifo_rd_chn_num     =   type_fifo_dout[PROG_BIT_WIDTH - 1 : 0];
assign  fifo_rd_chn_num_buf =   type_fifo_dout[PROG_BIT_WIDTH - 1 : PROG_BIT_WIDTH - CHNNUM_BIT_WIDTH];

////////////////////////////////////////////////////////////////////
//shift ram w21d128
////////////////////////////////////////////////////////////////////
shift_ram u0_shiftram(
    .clk                                ( clk                       ),
    .sclr                               ( rst                       ),
    .d                                  ( shift_din                 ),
    .q                                  ( shift_dout                )
    );

////////////////////////////////////////////////////////////////////
//pcr interval adaptation
////////////////////////////////////////////////////////////////////
pcr_interval_adapt #(
    .PROG_BIT_WIDTH                     ( PROG_BIT_WIDTH            ),
    .CHNNUM_BIT_WIDTH                   ( CHNNUM_BIT_WIDTH          ),
    .TOTAL_CHN_NUM                      ( TOTAL_CHN_NUM             )
    )
u0_pcr_interval_adapt(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .pcr_lo_base                        ( pcr_lo_base               ),
    .pcr_correct_int_ena                ( pcr_correct_int_ena       ),
    .head_val                           ( memc_rd_head_valid        ),
    .memc_data                          ( memc_out_data             ),
    .memc_data_head_valid               ( memc_data_head_valid      ),
    .memc_rd_data_valid                 ( memc_rd_data_valid        ),
    .ddr_rd_data_ack                    ( ddr_rd_data_ack_ch        ),
    .ddr_rd_data_req                    ( ddr_rd_data_req           ),
    .pcr_interval_data                  ( pcr_interval_data         ),
    .pcr_interval_data_valid            ( pcr_interval_data_valid   )
    );
    
////////////////////////////////////////////////////////////////////
//xilinx ip core instantiate
////////////////////////////////////////////////////////////////////
//width:128bit,depth:256,First-Word Fall-Through
ddr_wr_data_fifo u0_ddr_wr_data_fifo(
    .wr_clk                             ( clk_rx                    ),
    .rd_clk                             ( clk                       ),
    .rst                                ( rst_fifo                  ),
    .din                                ( ts_data                   ),
    .wr_en                              ( ts_valid                  ),
    .rd_en                              ( ts_data_rden              ),
    .dout                               ( ts_data_out               ),
    .full                               ( /*not used*/              ),
    .almost_full                        ( /*not used*/              ),
    .empty                              ( /*not used*/              ),
    .almost_empty                       ( data_almost_empty         ),
    .rd_data_count                      ( data_fifo_cnt             )
    );

//width:DDR3_ADDR_WIDTH,depth:256,First-Word Fall-Through
ddr_wr_addr_fifo u0_ddr_wr_addr_fifo(
    .wr_clk                             ( clk_rx                    ),
    .rd_clk                             ( clk                       ),
    .rst                                ( rst_fifo                  ),
    .din                                ( ts_addr                   ),
    .wr_en                              ( ts_valid                  ),
    .rd_en                              ( ts_addr_rden              ),
    .dout                               ( ts_addr_out               ),
    .full                               ( /*not used*/              ),
    .almost_full                        ( /*not used*/              ),
    .empty                              ( /*not used*/              ),
    .almost_empty                       ( /*not used*/              ),
    .rd_data_count                      ( data_cnt                  )
    );
    
//1kx16bit,read latency=1,din={{5{1'b0}},type[1:0],chn_num[8:0]}
dd3_rd_type_fifo u0_dd3_rd_type_fifo(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .din                                ( type_fifo_din             ),
    .wr_en                              ( type_fifo_wren            ),
    .rd_en                              ( type_fifo_rden            ),
    .dout                               ( type_fifo_dout            ),
    .full                               ( type_fifo_full            ),
    .empty                              ( type_fifo_empty           ),
    .data_count                         ( type_fifo_datacnt         )
    );
            
endmodule
