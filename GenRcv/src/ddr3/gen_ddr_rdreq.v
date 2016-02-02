/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   gen_ddr_rdreq.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-22  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gen_ddr_rdreq.v
    File tree    :   gen_ddr_rdreq.v
\************************************************************************************/

`timescale 1ns/100ps

module gen_ddr_rdreq(
    clk                         ,
    rst                         ,

    ecm_inforam_raddr           ,
    ecm_inforam_rdata           ,
    
    ddr_rd_ack                  ,
    ddr_rd_req                  ,
    timer_judge_finished
    );

parameter   TOTAL_INDEX                 = 1024                      ;
parameter   C1_SIMULATION               = "FALSE"                   ;
parameter   TIMER_10MS                  = (C1_SIMULATION=="FALSE") ? 416667 : 2500;//416667

parameter   ST_TIMER_WIDTH              = 3                         ;
parameter   ST_TIMER_IDLE               = 3'b001                    ,
            ST_TIMER_JUDGE              = 3'b010                    ,
            ST_TIMER_END                = 3'b100                    ;

input                                   clk                         ;
input                                   rst                         ;
output  [9:0]                           ecm_inforam_raddr           ;
input   [15:0]                          ecm_inforam_rdata           ;
input   [TOTAL_INDEX - 1 : 0]           ddr_rd_ack                  ;
output  [TOTAL_INDEX - 1 : 0]           ddr_rd_req                  ;
output                                  timer_judge_finished        ;

reg     [ST_TIMER_WIDTH - 1 : 0]        st_timer_curr               ;
reg     [ST_TIMER_WIDTH - 1 : 0]        st_timer_next               ;
reg     [19:0]                          time_10ms_cnt               ;
reg                                     time_10ms_up                ;
reg     [10:0]                          judge_counter               ;
wire    [5:0]                           ecm_tx_period               ;
wire    [5:0]                           timer_tx_curr               ;
reg     [TOTAL_INDEX - 1 : 0]           ddr_rd_req                  ;
wire    [9:0]                           pid_index                   ;
reg                                     timer_judge_finished        ;
reg                                     timer_ram_wren              ;
reg     [9:0]                           timer_ram_waddr             ;
reg     [7:0]                           timer_ram_wdata             ;
wire    [9:0]                           timer_ram_raddr             ;
wire    [7:0]                           timer_ram_rdata             ;
wire    [10:0]                          temp_addr                   ;

////////////////////////////////////////////////////////////////////
//tx period judge
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        time_10ms_cnt   <=  {20{1'b0}};
        time_10ms_up    <=  1'b0;
    end
    else if(time_10ms_cnt>TIMER_10MS)
    begin
        time_10ms_cnt   <=  {20{1'b0}};
        time_10ms_up    <=  1'b1;
    end
    else
    begin
        time_10ms_cnt   <=  time_10ms_cnt + 'h1;
        time_10ms_up    <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        judge_counter   <=  {11{1'b0}};
    end
    else if(st_timer_curr==ST_TIMER_JUDGE)
    begin
        judge_counter   <=  judge_counter + 'h1;
    end
    else
    begin
        judge_counter   <=  {11{1'b0}};
    end
end
        
generate
    genvar i;
    for(i=0;i<TOTAL_INDEX;i=i+1)
    begin:GEN_RDREQ
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ddr_rd_req[i]   <=  1'b0;
            end              
            else if((st_timer_curr==ST_TIMER_JUDGE) && (judge_counter>1) &&
                    (ecm_tx_period>0) && (ecm_tx_period==timer_tx_curr+1) && 
                    (judge_counter==i+2))
            begin
                ddr_rd_req[i]   <=  1'b1;
            end
            else if(ddr_rd_ack[i]==1'b1)
            begin
                ddr_rd_req[i]   <=  1'b0;
            end
        end
    end
endgenerate

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        timer_ram_wren  <=  1'b0;
    end
    else if((st_timer_curr==ST_TIMER_JUDGE) && (judge_counter>1))
    begin
        timer_ram_wren  <=  1'b1;
    end
    else
    begin
        timer_ram_wren  <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        timer_ram_wdata <=  {8{1'b0}};
    end
    else if((st_timer_curr==ST_TIMER_JUDGE) && (judge_counter>1))
    begin
        if(ecm_tx_period>0)
        begin
            if(ecm_tx_period==timer_tx_curr+1)
            begin
                timer_ram_wdata <=  {8{1'b0}};
            end
            else
            begin
                timer_ram_wdata <=  {2'b00,timer_tx_curr[5:0]} + 'h1;
            end
        end
        else
        begin
            timer_ram_wdata <=  {8{1'b0}};
        end
    end
    else
    begin
        timer_ram_wdata <=  {8{1'b0}};
    end
end

assign  temp_addr   =   judge_counter - 11'd2;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        timer_ram_waddr <=  {10{1'b0}};
    end
    else if((st_timer_curr==ST_TIMER_JUDGE) && (judge_counter>1))
    begin
        timer_ram_waddr <=  temp_addr[9:0];
    end
    else
    begin
        timer_ram_waddr <=  {10{1'b0}};
    end
end           
        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        st_timer_curr   <=  ST_TIMER_IDLE;
    end
    else
    begin
        st_timer_curr   <=  st_timer_next;
    end
end

always@*
begin
    case(st_timer_curr)
    ST_TIMER_IDLE:
    begin
        if(time_10ms_up==1'b1)
        begin
            st_timer_next   =   ST_TIMER_JUDGE;
        end
        else
        begin
            st_timer_next   =   ST_TIMER_IDLE;
        end
    end
    ST_TIMER_JUDGE:
    begin
        if((judge_counter[10]==1'b1) && (judge_counter[0]==1'b1))
        begin
            st_timer_next   =   ST_TIMER_END;
        end
        else
        begin
            st_timer_next   =   ST_TIMER_JUDGE;
        end
    end
    ST_TIMER_END:
    begin
        st_timer_next   =   ST_TIMER_IDLE;
    end
    default:
    begin
        st_timer_next   =   ST_TIMER_IDLE;
    end
    endcase
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        timer_judge_finished    <=  1'b0;
    end
    else if(st_timer_curr==ST_TIMER_END)
    begin
        timer_judge_finished    <=  1'b1;
    end
    else
    begin
        timer_judge_finished    <=  1'b0;
    end
end    

assign  timer_ram_raddr     =   judge_counter[9:0];
assign  ecm_inforam_raddr   =   judge_counter[9:0];
assign  ecm_tx_period       =   ecm_inforam_rdata[5:0];
assign  pid_index           =   ecm_inforam_rdata[15:6];
assign  timer_tx_curr       =   timer_ram_rdata[5:0];

////////////////////////////////////////////////////////////////////
//timer RAM
////////////////////////////////////////////////////////////////////
//read latency=2
syncram_w8d1024 u0_syncram_w8d1024(
    .clka                               ( clk                       ),
    .wea                                ( timer_ram_wren            ),
    .addra                              ( timer_ram_waddr           ),
    .dina                               ( timer_ram_wdata           ),
    .clkb                               ( clk                       ),
    .addrb                              ( timer_ram_raddr           ),
    .doutb                              ( timer_ram_rdata           )
    );
                
endmodule
