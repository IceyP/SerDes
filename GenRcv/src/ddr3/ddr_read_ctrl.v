/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   ddr_read_ctrl.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_read_ctrl.v
    File tree    :   ddr_read_ctrl.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_read_ctrl(
    clk                         ,
    rst                         ,
    
    cmd_fifo_rden               ,
    cmd_fifo_dout               ,
    cmd_fifo_rdempty            ,
    
    memc_rd_empty               ,
    memc_rd_en                  ,
    memc_rd_data                ,
    
    ecm_pkt_rdy                 ,
    ecm_fifo_rden               ,
    ecm_fifo_dout               ,
    ecm_dataram_raddr           ,
    ecm_dataram_rdata 
    );

parameter   TOTAL_INDEX                 = 1024                      ;
parameter   ECM_DATARAM_DEPTHBIT        = 9                         ;
parameter   ECM_DATARAM_WIDTH           = 16                        ;
parameter   ECM_FIFO_DEPTHBIT           = 8                         ;
parameter   ECM_FIFO_WIDTH              = 18                        ;

parameter   ST_WIDTH                    = 3                         ;
parameter   ST_WAIT_SOF                 = 3'b001                    ,
            ST_PKT_READ                 = 3'b010                    ,
            ST_PKT_END                  = 3'b100                    ;

input                                   clk                         ;
input                                   rst                         ;

output                                  cmd_fifo_rden               ;
input   [15:0]                          cmd_fifo_dout               ;
input                                   cmd_fifo_rdempty            ;

input                                   memc_rd_empty               ;
output                                  memc_rd_en                  ;
input   [127:0]                         memc_rd_data                ;

output                                  ecm_pkt_rdy                 ;
input                                   ecm_fifo_rden               ;
output  [17:0]                          ecm_fifo_dout               ;
input   [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_raddr           ;
output  [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_rdata           ;

wire                                    cmd_fifo_rden               ;
wire                                    memc_rd_en                  ;
reg     [ST_WIDTH - 1 : 0]              st_curr                     ;
reg     [ST_WIDTH - 1 : 0]              st_next                     ;
wire                                    fifo_empty                  ;
wire    [9:0]                           pid_index                   ;
reg     [8:0]                           pkt_len                     ;
reg     [4:0]                           word_cnt                    ;
reg     [3:0]                           ecm_cc[TOTAL_INDEX - 1 : 0] ;
reg     [3:0]                           byte_cnt                    ;
//ecm fifo+ram
reg     [ECM_FIFO_WIDTH - 1 : 0]        ecm_fifo_din                ;
reg                                     ecm_fifo_wren               ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_dataram_waddr           ;
wire                                    ecm_dataram_wren            ;
wire    [ECM_DATARAM_WIDTH - 1 : 0]     ecm_dataram_wdata           ;
reg     [ECM_DATARAM_DEPTHBIT - 1 : 0]  ecm_start_addr              ;
wire                                    ecm_pkt_rdy                 ;
wire                                    ecm_fifo_empty              ;

reg                                     ecm_tx_val                  ;
reg     [15:0]                          ecm_tx_data                 ;
reg                                     ecm_tx_sof                  ;
reg                                     ecm_tx_eof                  ;
reg     [127:0]                         memc_rd_data_1dly           ;
wire    [7:0]                           ecm_fifo_data_cnt           ;
wire                                    ram_full                    ;
wire                                    read_bp                     ;

assign  ram_full    =   (ecm_fifo_data_cnt>1)   ?   1'b1    :   1'b0;
assign  read_bp     =   memc_rd_empty | ram_full;
assign  fifo_empty  =   cmd_fifo_rdempty | read_bp;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin 
        st_curr <=  ST_WAIT_SOF;
    end
    else
    begin
        st_curr <=  st_next;
    end
end

always@*
begin
    case(st_curr)
    ST_WAIT_SOF:
    begin
        if(fifo_empty==1'b0)
        begin
            st_next =   ST_PKT_READ;
        end
        else
        begin
            st_next =   ST_WAIT_SOF;
        end        
    end
    ST_PKT_READ:
    begin
        if((byte_cnt==4'hf) && (word_cnt==24))
        begin
            st_next =   ST_PKT_END;
        end
        else
        begin
            st_next =   ST_PKT_READ;
        end
    end
    ST_PKT_END:
    begin
        st_next =   ST_WAIT_SOF;
    end
    default:
    begin
        st_next =   ST_WAIT_SOF;
    end
    endcase
end

assign  cmd_fifo_rden   =   ((fifo_empty==1'b0) && (st_curr==ST_WAIT_SOF))  ?   1'b1    :   1'b0; 

assign  memc_rd_en      =   ((st_curr==ST_PKT_READ) && (byte_cnt[2:0]==3'b000) && (read_bp==1'b0)) ?   1'b1    :   cmd_fifo_rden;
                                                        
assign  pid_index       =   cmd_fifo_dout[14:5];

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_len <=  {9{1'b0}};
    end
    else if(cmd_fifo_rden==1'b1)
    begin
        pkt_len <=  memc_rd_data[88:80] + 'h8;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  4'h0;
    end
    else if((word_cnt==24) && (byte_cnt==4'hf))
    begin
        byte_cnt    <=  4'h0;
    end
    else if((read_bp==1'b1) && (byte_cnt[2:0]==3'b000))
    begin
        byte_cnt[2:0]   <=  3'b000;
    end
    else if(cmd_fifo_rden==1'b1)
    begin
        byte_cnt    <=  4'h1;
    end
    else
    begin
        byte_cnt    <=  byte_cnt + 4'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  {5{1'b0}};
    end
    else if((word_cnt==24) && (byte_cnt==4'hf))
    begin
        word_cnt    <=  {5{1'b0}};
    end
    else if(cmd_fifo_rden==1'b1)
    begin
        word_cnt    <=  5'b0_0001;
    end
    else if((memc_rd_en==1'b1) && (word_cnt>0))
    begin
        word_cnt    <=  word_cnt + 'h1;
    end
end
        
generate
    genvar i;
    for(i=0;i<TOTAL_INDEX;i=i+1)
    begin:GEN_CC
//        always@(posedge clk or posedge rst)
//        begin
//            if(rst==1'b1)
//            begin
//                ecm_cc[i]   <=  4'h0;
//            end
//            else if((st_curr==ST_PKT_READ) && (byte_cnt[2:0]==3'b111) && 
//                    ((word_cnt==2) || ((word_cnt==14) && (pkt_len[8]==1'b1))) && 
//                    (pid_index==i))
//            begin
//                ecm_cc[i]   <=  ecm_cc[i] + 4'h1;
//            end
//        end
        always@(posedge clk)
        begin
            if((st_curr==ST_PKT_READ) && (byte_cnt[2:0]==3'b111) && 
                    ((word_cnt==2) || ((word_cnt==14) && (pkt_len[8]==1'b1))) && 
                    (pid_index==i))
            begin
                ecm_cc[i]   <=  ecm_cc[i] + 4'h1;
            end
        end          
    end
endgenerate

////////////////////////////////////////////////////////////////////
//ecm packet output,according tx period,modify continue counter
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_tx_val  <=  1'b0;
    end
    else if(cmd_fifo_rden==1'b1)
    begin
        ecm_tx_val  <=  1'b1;
    end
    else if((st_curr==ST_PKT_READ) && (pkt_len>0))
    begin
        if(word_cnt<13)
        begin
            if((byte_cnt[2:0]==3'b000) && (read_bp==1'b1))
            begin
                ecm_tx_val  <=  1'b0;
            end
            else
            begin
                ecm_tx_val  <=  1'b1;
            end
        end
        else if(word_cnt==13)
        begin
            if(pkt_len[8]==1'b1)     //384 bytes
            begin
                if((byte_cnt[2:0]==3'b000) && (read_bp==1'b1))
                begin
                    ecm_tx_val  <=  1'b0;
                end
                else
                begin
                    ecm_tx_val  <=  1'b1;
                end
            end
            else if(byte_cnt<2)         //196 bytes
            begin
                if((byte_cnt[2:0]==3'b000) && (read_bp==1'b1))
                begin
                    ecm_tx_val  <=  1'b0;
                end
                else
                begin
                    ecm_tx_val  <=  1'b1;
                end
            end
            else
            begin
                ecm_tx_val  <=  1'b0;
            end
        end
        else
        begin
            if(pkt_len[8]==1'b1)     //384 bytes
            begin
                if((byte_cnt[2:0]==3'b000) && (read_bp==1'b1))
                begin
                    ecm_tx_val  <=  1'b0;
                end
                else
                begin
                    ecm_tx_val  <=  1'b1;
                end
            end
            else                        //196 bytes
            begin
                ecm_tx_val  <=  1'b0;
            end
        end
    end
    else
    begin
        ecm_tx_val  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        memc_rd_data_1dly   <=  {128{1'b0}};
    end
    else if(memc_rd_en==1'b1)
    begin
        memc_rd_data_1dly   <=  memc_rd_data;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_tx_data <=  {16{1'b0}};
    end
    else if(memc_rd_en==1'b1)
    begin
        ecm_tx_data <=  memc_rd_data[127:112];
    end
    else if(st_curr==ST_PKT_READ)
    begin
        case(byte_cnt[2:0])
        3'd0:   ecm_tx_data <=  memc_rd_data_1dly[127:112];
        3'd1:   ecm_tx_data <=  memc_rd_data_1dly[111:96];
        3'd2:
        begin
            if(word_cnt==13)
            begin
                ecm_tx_data <=  {memc_rd_data_1dly[95:84],ecm_cc[pid_index]};
            end
            else
            begin
                ecm_tx_data <=  memc_rd_data_1dly[95:80];
            end          
        end
        3'd3:   ecm_tx_data <=  memc_rd_data_1dly[79:64];
        3'd4:   
        begin
            if(word_cnt==1)
            begin
                ecm_tx_data <=  {memc_rd_data_1dly[63:52],ecm_cc[pid_index]};
            end
            else
            begin
                ecm_tx_data <=  memc_rd_data_1dly[63:48];
            end
        end
        3'd5:   ecm_tx_data <=  memc_rd_data_1dly[47:32];
        3'd6:   ecm_tx_data <=  memc_rd_data_1dly[31:16];
        3'd7:   ecm_tx_data <=  memc_rd_data_1dly[15:0];
        default:ecm_tx_data <=  {16{1'b0}};
        endcase
    end
    else
    begin
        ecm_tx_data <=  {16{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_tx_sof  <=  1'b0;
    end
    else if(cmd_fifo_rden==1'b1)
    begin
        ecm_tx_sof  <=  1'b1;
    end
    else
    begin
        ecm_tx_sof  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_tx_eof  <=  1'b0;
    end
    else if(st_curr==ST_PKT_READ)
    begin
        if(pkt_len[8]==1'b1)        //384 bytes
        begin
            if((word_cnt==24) && (byte_cnt==4'hf))
            begin
                ecm_tx_eof  <=  1'b1;
            end
            else
            begin
                ecm_tx_eof  <=  1'b0;
            end
        end
        else if((word_cnt==13) && (byte_cnt[2:0]==3'd1))    //196 bytes
        begin
            ecm_tx_eof  <=  1'b1;
        end
        else
        begin
            ecm_tx_eof  <=  1'b0;
        end
    end
    else
    begin
        ecm_tx_eof  <=  1'b0;
    end
end
        
////////////////////////////////////////////////////////////////////
//fifo+ram read and write
////////////////////////////////////////////////////////////////////
assign  ecm_dataram_wdata   =   ecm_tx_data;
assign  ecm_dataram_wren    =   ecm_tx_val;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_dataram_waddr   <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if(ecm_tx_val==1'b1)
    begin
        ecm_dataram_waddr   <=  ecm_dataram_waddr + 'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_start_addr  <=  {ECM_DATARAM_DEPTHBIT{1'b0}};
    end
    else if(ecm_tx_sof==1'b1)
    begin
        ecm_start_addr  <=  ecm_dataram_waddr;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_fifo_wren   <=  1'b0;
    end
    else if(ecm_tx_eof==1'b1)
    begin
        ecm_fifo_wren   <=  1'b1;
    end
    else
    begin
        ecm_fifo_wren   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
    else if(ecm_tx_eof==1'b1)
    begin
        ecm_fifo_din    <=  {ecm_start_addr[ECM_DATARAM_DEPTHBIT - 1 : 0],pkt_len[8:0]};
    end
    else
    begin
        ecm_fifo_din    <=  {ECM_FIFO_WIDTH{1'b0}};
    end
end

assign  ecm_pkt_rdy =   ~ecm_fifo_empty;

////////////////////////////////////////////////////////////////////
//fifo+ram instantiate
////////////////////////////////////////////////////////////////////
//read latency=1,1 M9K blockRAM
syncfifo_w18d256 u0_syncfifo_w18d256(
    .rst                                ( rst                       ),
    .clk                                ( clk                       ),
    .din                                ( ecm_fifo_din              ),
    .wr_en                              ( ecm_fifo_wren             ),
    .rd_en                              ( ecm_fifo_rden             ),
    .dout                               ( ecm_fifo_dout             ),
    .full                               ( /*not used*/              ),
    .empty                              ( ecm_fifo_empty            ),
    .data_count                         ( ecm_fifo_data_cnt         )
    );

//read latency=1,1 M9K blockRAM
syncram_w16d512 u0_syncram_w16d512(
    .clka                               ( clk                       ),
    .wea                                ( ecm_dataram_wren          ),
    .addra                              ( ecm_dataram_waddr         ),
    .dina                               ( ecm_dataram_wdata         ),
    .clkb                               ( clk                       ),
    .addrb                              ( ecm_dataram_raddr         ),
    .doutb                              ( ecm_dataram_rdata         )
    ); 
        
endmodule
