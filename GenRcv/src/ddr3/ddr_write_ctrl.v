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
    2013-11-21  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_write_ctrl.v
    File tree    :   ddr_write_ctrl.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_write_ctrl(
    clk                         ,
    rst                         ,
    clk_gtp                     ,
    rst_gtp                     ,
      
    pkt_wr_val                  ,
    pkt_wr_eof                  ,
    pkt_wr_data                 ,
    pkt_wr_addr                 ,
    ecm_pkt_bp                  ,
    ecm_inforam_raddr           ,
    ecm_inforam_rdata           ,
    
    memc_cmd_ack                ,
    memc_cmd_req                ,
    memc_cmd                    ,
    memc_cmd_addr               ,
    memc_cmd_bl                 ,
    memc_wr_req                 ,
    memc_wr_end                 ,
    memc_wr_mask                ,
    memc_wr_data                ,
    memc_wr_ack                 ,
    memc_wr_count               ,
    
    cmd_fifo_rden               ,
    cmd_fifo_dout               ,
    cmd_fifo_rdempty
    );

parameter   TOTAL_INDEX                 = 1024                      ;
parameter   C1_SIMULATION               = "FALSE"                   ;
parameter   RD_WAIT_CYCLE               = 64                        ;

parameter   ST_WIDTH                    = 7                         ;
parameter   ST_IDLE                     = 7'b000_0001               ,
            ST_READ_REQ_JUDGE           = 7'b000_0010               ,
            ST_CMD_READ                 = 7'b000_0100               ,
            ST_CMD_WRITE_1              = 7'b000_1000               ,
            ST_CMD_WRITE_2              = 7'b001_0000               ,
            ST_FIFO_RD_1                = 7'b010_0000               ,
            ST_FIFO_RD_2                = 7'b100_0000               ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_gtp                     ;
input                                   rst_gtp                     ;

input                                   pkt_wr_val                  ;
input                                   pkt_wr_eof                  ;
input   [127:0]                         pkt_wr_data                 ;
input   [15:0]                          pkt_wr_addr                 ;
output                                  ecm_pkt_bp                  ;
output  [9:0]                           ecm_inforam_raddr           ;
input   [15:0]                          ecm_inforam_rdata           ;

input                                   memc_cmd_ack                ;   //fifo not full
output                                  memc_cmd_req                ;
output  [2:0]                           memc_cmd                    ;
output  [29:0]                          memc_cmd_addr               ;
output  [5:0]                           memc_cmd_bl                 ;

output                                  memc_wr_req                 ;
output                                  memc_wr_end                 ;
output  [15:0]                          memc_wr_mask                ;
output  [127:0]                         memc_wr_data                ;
input                                   memc_wr_ack                 ;   //fifo not full
input   [6:0]                           memc_wr_count               ;

input                                   cmd_fifo_rden               ;
output  [15:0]                          cmd_fifo_dout               ;
output                                  cmd_fifo_rdempty            ;

wire                                    pkt_addr_rden               ;
wire    [15:0]                          pkt_addr_out                ;

reg     [ST_WIDTH - 1 : 0]              st_curr                     ;
reg     [ST_WIDTH - 1 : 0]              st_next                     ;
wire                                    write_state                 ;
reg     [9:0]                           ddr_rd_chn_num              ;
wire    [9:0]                           ddr_rd_chn_num_buf          ;
wire    [TOTAL_INDEX - 1 : 0]           ddr_rd_ack                  ;
wire    [TOTAL_INDEX - 1 : 0]           ddr_rd_req                  ;
wire                                    timer_judge_finished        ;
reg                                     cmd_fifo_wren               ;
reg     [15:0]                          cmd_fifo_din                ;
reg                                     ecm_pkt_bp                  ;
wire                                    fifo_empty                  ;
reg     [7:0]                           rd_cnt                      ;
wire                                    ddr_rd_data_ack             ;

////////////////////////////////////////////////////////////////////
//write data fifo
////////////////////////////////////////////////////////////////////
assign  memc_wr_req     =   pkt_wr_val;
assign  memc_wr_data    =   pkt_wr_data;
assign  memc_wr_mask    =   {16{1'b0}};
assign  memc_wr_end     =   pkt_wr_val;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_pkt_bp  <=  1'b0;
    end
    else if(memc_wr_count>48)  ///???????????????????????????????????????
    begin
        ecm_pkt_bp  <=  1'b1;
    end
    else
    begin
        ecm_pkt_bp  <=  1'b0;
    end
end

////////////////////////////////////////////////////////////////////
//ddr3 cmd state machine
////////////////////////////////////////////////////////////////////
assign  write_state         =   ((st_curr==ST_CMD_WRITE_1) || (st_curr==ST_CMD_WRITE_2)) ?  1'b1    :   1'b0;
assign  ddr_rd_chn_num_buf  =   ddr_rd_chn_num - 10'h1;
assign  ddr_rd_data_ack     =   ((st_curr==ST_CMD_READ) && (memc_cmd_ack==1'b1) && (rd_cnt==RD_WAIT_CYCLE))   ?   1'b1    :   1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        rd_cnt  <=  {8{1'b0}};
    end
    else if(rd_cnt>=RD_WAIT_CYCLE)
    begin
        if(memc_cmd_ack==1'b1)
        begin
            rd_cnt  <=  {8{1'b0}};
        end
        else
        begin
            rd_cnt  <=  RD_WAIT_CYCLE;
        end
    end   
    else if(st_curr==ST_CMD_READ)
    begin
        rd_cnt  <=  rd_cnt + 8'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ddr_rd_chn_num  <=  {10{1'b0}};
    end
    else if(st_curr==ST_IDLE)
    begin
        ddr_rd_chn_num  <=  {10{1'b0}};
    end
    else if(st_curr==ST_READ_REQ_JUDGE)
    begin
        ddr_rd_chn_num  <=  ddr_rd_chn_num + 'h1;
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
        st_curr <=  st_next;
    end
end

always@*
begin
    case(st_curr)
    ST_IDLE:
    begin
        if(fifo_empty==1'b1)
        begin
            if((|ddr_rd_req==1'b1) && (timer_judge_finished==1'b1))
            begin
                st_next =   ST_READ_REQ_JUDGE;
            end
            else
            begin
                st_next =   ST_IDLE;
            end
        end
        else
        begin
            st_next =   ST_FIFO_RD_1;
        end
    end
    ST_FIFO_RD_1:
    begin
        st_next =   ST_CMD_WRITE_1;
    end
    ST_READ_REQ_JUDGE:
    begin
        if(|ddr_rd_req==1'b1)
        begin
            if(ddr_rd_req[ddr_rd_chn_num]==1'b1)
            begin
                st_next =   ST_CMD_READ;
            end
            else
            begin
                st_next =   ST_READ_REQ_JUDGE;
            end
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end           
    ST_CMD_READ:
    begin
        if(rd_cnt<RD_WAIT_CYCLE)   //wait,avoid read ram overflow
        begin
            st_next =   ST_CMD_READ;
        end
        else if(memc_cmd_ack==1'b1)
        begin
            if(fifo_empty==1'b1)
            begin
                if(|ddr_rd_req==1'b1)
                begin
                    st_next =   ST_READ_REQ_JUDGE;
                end
                else
                begin
                    st_next =   ST_IDLE;
                end
            end
            else
            begin
                st_next =   ST_FIFO_RD_2;
            end
        end
        else
        begin
            st_next =   ST_CMD_READ;
        end
    end
    ST_FIFO_RD_2:
    begin
        st_next =   ST_CMD_WRITE_2;
    end
    ST_CMD_WRITE_1:
    begin
        if(memc_cmd_ack==1'b1)
        begin
            if(fifo_empty==1'b1)
            begin
                st_next =   ST_IDLE;
            end
            else
            begin
                st_next =   ST_FIFO_RD_1;
            end
        end
        else
        begin
            st_next =   ST_CMD_WRITE_1;
        end
    end
    ST_CMD_WRITE_2:
    begin
        if(memc_cmd_ack==1'b1)
        begin
            if(fifo_empty==1'b1)
            begin
                if(|ddr_rd_req==1'b1)
                begin
                    st_next =   ST_READ_REQ_JUDGE;
                end
                else
                begin
                    st_next =   ST_IDLE;
                end
            end
            else
            begin
                st_next =   ST_FIFO_RD_2;
            end
        end
        else
        begin
            st_next =   ST_CMD_WRITE_2;
        end
    end
    default:
    begin
        st_next =   ST_IDLE;
    end
    endcase
end

generate
    genvar i;
    for(i=0;i<TOTAL_INDEX;i=i+1)
    begin:GEN_RDACK
        assign  ddr_rd_ack[i]   =   ((ddr_rd_data_ack==1'b1) && (ddr_rd_chn_num_buf==i))  ?   1'b1    :   1'b0;
    end
endgenerate


////////////////////////////////////////////////////////////////////
//ddr3 cmd output
////////////////////////////////////////////////////////////////////

assign  pkt_addr_rden   =   ((st_curr==ST_FIFO_RD_1) || (st_curr==ST_FIFO_RD_2)) ?   1'b1    :   1'b0;

//memc_cmd_addr                            
assign  memc_cmd_addr   =   ((memc_cmd_ack==1'b1) && (write_state==1'b1))       ?   {{11{1'b0}},pkt_addr_out[9:0],{9{1'b0}}}        :
                            (ddr_rd_data_ack==1'b1)                             ?   {{11{1'b0}},ddr_rd_chn_num_buf[9:0],{9{1'b0}}}  :
                            {30{1'b0}};

//memc_cmd_req
assign  memc_cmd_req    =   ((write_state==1'b1) || (ddr_rd_data_ack==1'b1)) ?   1'b1    :   1'b0;

//memc_cmd,3'b000:write;3'b001:read;
assign  memc_cmd        =   (ddr_rd_data_ack==1'b1) ?    3'b001  :   3'b000;

assign  memc_cmd_bl     =   (write_state==1'b1)     ?    pkt_addr_out[15:10]    :   6'd23;

////////////////////////////////////////////////////////////////////
//read cmd fifo
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cmd_fifo_wren   <=  1'b0;
    end
    else if(ddr_rd_data_ack==1'b1)
    begin
        cmd_fifo_wren   <=  1'b1;
    end
    else
    begin
        cmd_fifo_wren   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        cmd_fifo_din    <=  {16{1'b0}};
    end
    else if(ddr_rd_data_ack==1'b1)
    begin
        cmd_fifo_din    <=  memc_cmd_addr[18:3];
    end
    else
    begin
        cmd_fifo_din    <=  {16{1'b0}};
    end
end

////////////////////////////////////////////////////////////////////
//generate ddr3 read request
////////////////////////////////////////////////////////////////////
gen_ddr_rdreq #(
    .C1_SIMULATION                      ( C1_SIMULATION             )
    )
u0_gen_ddr_rdreq(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    
    .ecm_inforam_raddr                  ( ecm_inforam_raddr         ),
    .ecm_inforam_rdata                  ( ecm_inforam_rdata         ),
    
    .ddr_rd_ack                         ( ddr_rd_ack                ),
    .ddr_rd_req                         ( ddr_rd_req                ),
    .timer_judge_finished               ( timer_judge_finished      )
    );

////////////////////////////////////////////////////////////////////
//fifo instantiate
////////////////////////////////////////////////////////////////////
    
//width:16({word_num[5:0],ddr3_waddr[9:0]},depth:64,read_latency=1
synfifo_w16d64 u0_synfifo_w16d64(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .din                                ( pkt_wr_addr               ),
    .wr_en                              ( pkt_wr_eof                ),
    .rd_en                              ( pkt_addr_rden             ),
    .dout                               ( pkt_addr_out              ),
    .full                               ( /*not used*/              ),
    .empty                              ( fifo_empty                )
    );

////////////////////////////////////////////////////////////////////
//instantiate read cmd fifo
////////////////////////////////////////////////////////////////////    
//read latency=1,{pid_index(10bit),raddr(5bit)};

assign  rst_cmd_fifo    =   rst_gtp | rst;

asyncfifo_w16d256 u0_rdcmd_fifo(
    .rst                                ( rst_cmd_fifo              ),
    .wr_clk                             ( clk                       ),
    .rd_clk                             ( clk_gtp                   ),
    .din                                ( cmd_fifo_din              ),
    .wr_en                              ( cmd_fifo_wren             ),
    .rd_en                              ( cmd_fifo_rden             ),
    .dout                               ( cmd_fifo_dout             ),
    .full                               ( /*not used*/              ),
    .empty                              ( cmd_fifo_rdempty          ),
    .rd_data_count                      ( /*not used*/              )
    );
        
endmodule
