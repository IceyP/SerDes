/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  pkt_tx_tm.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  SERDES TX MAX_RATE=3.125G*(8/10)*(98/(98+7))=2.33Gbps
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-08  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  pkt_tx_tm.v
    File tree    :  pkt_tx_tm.v                        
\************************************************************************************/

`timescale 1ns/1ps

module pkt_tx_tm(
    clk                         ,
    rst                         ,
    
    fifo_rden                   ,
    fifo_dout_in0               ,
    fifo_dout_in1               ,
    fifo_dout_in2               ,
    fifo_dout_in3               ,
    fifo_dout_in4               ,
    fifo_dout_in5               ,
    fifo_dout_in6               ,
    fifo_dout_in7               ,
    pkt_rdy                     ,
    
    ram_raddr_in0               ,   
    ram_raddr_in1               ,    
    ram_raddr_in2               ,  
    ram_raddr_in3               ,    
    ram_raddr_in4               ,    
    ram_raddr_in5               ,
    ram_raddr_in6               ,    
    ram_raddr_in7               ,    
    ram_dout_in0                ,
    ram_dout_in1                ,
    ram_dout_in2                ,
    ram_dout_in3                ,
    ram_dout_in4                ,
    ram_dout_in5                ,
    ram_dout_in6                ,
    ram_dout_in7                ,
    tx_data                     ,
    tx_rem                      ,
    tx_sof_n                    ,
    tx_eof_n                    ,
    tx_src_rdy_n                ,
    tx_dst_rdy_n
    );           
parameter   CHAN_NUMS                  = 8                          ;
parameter   RAM_DEPTH                  = 11                         ;
parameter   ST_WIDTH                   = 4                          ;
parameter   ST_IDLE                    = 4'b0001                    ,
            ST_READ_ACK                = 4'b0010                    ,
            ST_READ_INFO               = 4'b0100                    ,
            ST_READ_DATA               = 4'b1000                    ;           
                                                                    
input                                  clk                          ;
input                                  rst                          ;
                                                                    
output  [CHAN_NUMS-1:0]                fifo_rden                    ;
input   [23:0]                         fifo_dout_in0                ;
input   [23:0]                         fifo_dout_in1                ;
input   [23:0]                         fifo_dout_in2                ;
input   [23:0]                         fifo_dout_in3                ;
input   [23:0]                         fifo_dout_in4                ;
input   [23:0]                         fifo_dout_in5                ;
input   [23:0]                         fifo_dout_in6                ;
input   [23:0]                         fifo_dout_in7                ;
input   [CHAN_NUMS-1:0]                pkt_rdy                      ;
                                                                    
output  [RAM_DEPTH-1:0]                ram_raddr_in0                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in1                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in2                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in3                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in4                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in5                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in6                ;
output  [RAM_DEPTH-1:0]                ram_raddr_in7                ;
                                                                    
input   [15:0]                         ram_dout_in0                 ;
input   [15:0]                         ram_dout_in1                 ;
input   [15:0]                         ram_dout_in2                 ;
input   [15:0]                         ram_dout_in3                 ;
input   [15:0]                         ram_dout_in4                 ;
input   [15:0]                         ram_dout_in5                 ;
input   [15:0]                         ram_dout_in6                 ;
input   [15:0]                         ram_dout_in7                 ;
                                                                    
output  [0:15]                         tx_data                      ;
output                                 tx_rem                       ;
output                                 tx_sof_n                     ;
output                                 tx_eof_n                     ;
output                                 tx_src_rdy_n                 ;
input                                  tx_dst_rdy_n                 ;   //current cycle is valid and data
                                                                    
reg     [ST_WIDTH - 1 : 0]             st_curr                      ;
reg     [ST_WIDTH - 1 : 0]             st_next                      ;
reg                                    ack                          ;
reg     [2:0]                          read_info_cnt                ;
wire    [CHAN_NUMS-1:0]                fifo_rden                    ;
reg     [CHAN_NUMS-1:0]                fifo_rden_1dly               ;
reg     [CHAN_NUMS-1:0]                fifo_rden_2dly               ;
reg     [23:0]                         fifo_dout                    ;
reg     [9:0]                          pkt_len                      ;
reg     [RAM_DEPTH-1:0]                ram_raddr[CHAN_NUMS-1:0]     ;
reg     [RAM_DEPTH-1:0]                ram_raddr_1dly[CHAN_NUMS-1:0];
reg     [RAM_DEPTH-1:0]                ram_raddr_2dly[CHAN_NUMS-1:0];
reg     [RAM_DEPTH-1:0]                raddr_tmp[CHAN_NUMS-1:0]     ;
wire                                   pos_tx_dst_rdy_n             ;
wire                                   neg_tx_dst_rdy_n             ;
reg                                    tx_dst_rdy_n_1dly            ;
                                                                    
reg     [9:0]                          data_cycle_cnt               ;
reg     [2:0]                          in_slot                      ;
                                                                    
wire                                   tx_sof_n                     ;
wire                                   tx_eof_n                     ;
wire                                   tx_src_rdy_n                 ;
            
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
        if(|pkt_rdy==1'b1)
        begin
            st_next =   ST_READ_ACK;
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_READ_ACK:
    begin
        st_next =   ST_READ_INFO;
    end
    ST_READ_INFO:
    begin
        if((read_info_cnt==4) && (tx_dst_rdy_n==1'b0))
        begin
            st_next =   ST_READ_DATA;
        end
        else
        begin
            st_next =   ST_READ_INFO;
        end
    end
    ST_READ_DATA:
    begin
        if((data_cycle_cnt==pkt_len-1) && (tx_dst_rdy_n==1'b0))
        begin
            st_next =   ST_IDLE;
        end
        else
        begin
            st_next =   ST_READ_DATA;
        end
    end
    default:    st_next =   ST_IDLE;
    endcase
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ack <=  1'b0;
    end
    else if(st_curr==ST_READ_ACK)
    begin
        ack <=  1'b1;
    end
    else
    begin
        ack <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        read_info_cnt   <=  {3{1'b0}};
    end
    else if((st_curr==ST_READ_INFO) && (read_info_cnt>3))
    begin
        read_info_cnt   <=  3'b100;
    end
    else if(st_curr==ST_READ_INFO)
    begin
        read_info_cnt   <=  read_info_cnt + 3'b001;
    end
    else
    begin
        read_info_cnt   <=  3'b000;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        data_cycle_cnt  <=  {10{1'b0}};
    end
    else if(st_curr==ST_READ_DATA)
    begin
        if(tx_dst_rdy_n==1'b0)
        begin
            data_cycle_cnt  <=  data_cycle_cnt + 'h1;
        end
    end
    else
    begin
        data_cycle_cnt  <=  {10{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_rden_1dly  <=  1'b0;
        fifo_rden_2dly  <=  1'b0;
    end
    else
    begin
        fifo_rden_1dly  <=  fifo_rden;
        fifo_rden_2dly  <=  fifo_rden_1dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        fifo_dout   <=  {24{1'b0}};
        in_slot     <=  3'b000;
    end
    else
    begin
        case(fifo_rden_2dly)
        8'b0000_0001: begin   fifo_dout   <=  fifo_dout_in0;    in_slot <=  3'b000; end
        8'b0000_0010: begin   fifo_dout   <=  fifo_dout_in1;    in_slot <=  3'b001; end
        8'b0000_0100: begin   fifo_dout   <=  fifo_dout_in2;    in_slot <=  3'b010; end
        8'b0000_1000: begin   fifo_dout   <=  fifo_dout_in3;    in_slot <=  3'b011; end
        8'b0001_0000: begin   fifo_dout   <=  fifo_dout_in4;    in_slot <=  3'b100; end
        8'b0010_0000: begin   fifo_dout   <=  fifo_dout_in5;    in_slot <=  3'b101; end
        8'b0100_0000: begin   fifo_dout   <=  fifo_dout_in6;    in_slot <=  3'b110; end
        8'b1000_0000: begin   fifo_dout   <=  fifo_dout_in7;    in_slot <=  3'b111; end
        default:;
        endcase
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_len <=  {10{1'b0}};
    end
    else if((st_curr==ST_READ_INFO) && (read_info_cnt==4))
    begin
        pkt_len <=  fifo_dout[RAM_DEPTH+9:RAM_DEPTH];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        tx_dst_rdy_n_1dly   <=  1'b1;
    end
    else
    begin
        tx_dst_rdy_n_1dly   <=  tx_dst_rdy_n;
    end
end

assign  pos_tx_dst_rdy_n    =   (~tx_dst_rdy_n_1dly) & tx_dst_rdy_n;
assign  neg_tx_dst_rdy_n    =   tx_dst_rdy_n_1dly & (~tx_dst_rdy_n);

generate
    genvar  i;
    for(i=0;i<CHAN_NUMS;i=i+1)
    begin:INST_INRAM_RD 
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ram_raddr_1dly[i]   <=  {RAM_DEPTH{1'b0}};
            end
            else if(in_slot==i)
            begin
                if(((st_curr==ST_READ_DATA) || ((st_curr==ST_READ_INFO) && (read_info_cnt==4))) && (tx_dst_rdy_n==1'b0))
                begin
                    ram_raddr_1dly[i]   <=  ram_raddr[i] + 'h1;
                end
                else
                begin
                    ram_raddr_1dly[i]   <=  ram_raddr[i];
                end
            end
        end
                                      
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                raddr_tmp[i]    <=  {RAM_DEPTH{1'b0}};
            end
            else if((in_slot==i) && (pos_tx_dst_rdy_n==1'b1))
            begin
                raddr_tmp[i]    <=  ram_raddr[i] + 'h1;
            end
        end
    
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                ram_raddr_2dly[i]   <=  {RAM_DEPTH{1'b0}};
            end
            else if(in_slot==i)
            begin
                if((st_curr==ST_READ_INFO) && (read_info_cnt==4) && (tx_dst_rdy_n==1'b0))
                begin
                    ram_raddr_2dly[i]   <=  ram_raddr[i];
                end
                else
                begin
                    ram_raddr_2dly[i]   <=  ram_raddr_1dly[i];
                end
            end
        end

        always@*
        begin
            if(in_slot==i)
            begin
                if((st_curr==ST_READ_INFO) && (read_info_cnt==4) && (tx_dst_rdy_n==1'b0))
                begin
                    ram_raddr[i]    =   fifo_dout[RAM_DEPTH-1:0];
                end
                else if((pos_tx_dst_rdy_n==1'b1) && (st_curr==ST_READ_DATA))
                begin
                    ram_raddr[i]    =   ram_raddr_2dly[i];
                end
                else if((neg_tx_dst_rdy_n==1'b1) && (st_curr==ST_READ_DATA))
                begin
                    ram_raddr[i]    =   raddr_tmp[i];
                end
                else
                begin
                    ram_raddr[i]    =   ram_raddr_1dly[i];
                end
            end
            else
            begin
                ram_raddr[i]    =   ram_raddr_1dly[i];
            end
        end
    end
endgenerate

assign  ram_raddr_in0   =   ram_raddr[0];
assign  ram_raddr_in1   =   ram_raddr[1];
assign  ram_raddr_in2   =   ram_raddr[2];
assign  ram_raddr_in3   =   ram_raddr[3];
assign  ram_raddr_in4   =   ram_raddr[4];
assign  ram_raddr_in5   =   ram_raddr[5];
assign  ram_raddr_in6   =   ram_raddr[6];
assign  ram_raddr_in7   =   ram_raddr[7];
////////////////////////////////////////////////////////////////////
//tx
////////////////////////////////////////////////////////////////////
assign  tx_sof_n        =   ((st_curr==ST_READ_DATA) && (data_cycle_cnt==0) && 
                            (tx_dst_rdy_n==1'b0))    ?   1'b0    :   1'b1;
assign  tx_eof_n        =   ((st_curr==ST_READ_DATA) && (data_cycle_cnt==pkt_len-1) &&
                            (tx_dst_rdy_n==1'b0))    ?   1'b0    :   1'b1;
                            
assign  tx_src_rdy_n    =   ((st_curr==ST_READ_DATA) && (tx_dst_rdy_n==1'b0))   ?   1'b0    :   1'b1;

assign  tx_data         =   (in_slot==3'b000)   ?   ram_dout_in0[15:0]  :
                            (in_slot==3'b001)   ?   ram_dout_in1[15:0]  :
                            (in_slot==3'b010)   ?   ram_dout_in2[15:0]  :
                            (in_slot==3'b011)   ?   ram_dout_in3[15:0]  :
                            (in_slot==3'b100)   ?   ram_dout_in4[15:0]  :
                            (in_slot==3'b101)   ?   ram_dout_in5[15:0]  :
                            (in_slot==3'b110)   ?   ram_dout_in6[15:0]  :
                            (in_slot==3'b111)   ?   ram_dout_in7[15:0]  :
                            {16{1'b0}};
                            
assign  tx_rem          =   1'b1;

////////////////////////////////////////////////////////////////////
//round_robin_arbiter
////////////////////////////////////////////////////////////////////
round_robin_arbiter u0_rr_arbiter(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .req                                ( pkt_rdy                   ),
    .ack                                ( ack                       ),
    .grant                              ( fifo_rden                 )
    );
                    
endmodule
