/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  pkt_filter.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-07-03  huangrui/1480       1.0         IPQAM       Create
    2013-08-16  huangrui/1480       1.1         IPQAM       
    ==================================================================================
    Called by    :  pkt_filter.v
    File tree    :  pkt_filter.v                        
\************************************************************************************/

`timescale 1ns/100ps

module pkt_filter(
    clk                         ,
    rst                         ,    
    ts_i_data                   ,
    ts_i_val                    ,
    ts_i_sop                    ,
    ts_i_eop                    ,
    drop_pkt_flag               ,
    ts_o_data                   ,
    ts_o_val                    ,
    ts_o_sop                    ,
    ts_o_eop 
    );

parameter   U_DLY                       = 1                         ;
parameter   PROG_BIT_WIDTH              = 9                         ;
parameter   TOTAL_PROG_NUM              = 2 ** PROG_BIT_WIDTH       ;
parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   PROG_PER_CHAN_BITWIDTH      = 4                         ;

parameter   ST_WIDTH                    = 2                         ;
parameter   ST_IDLE                     = 2'b01                     ,
            ST_NOT_DROP                 = 2'b10                     ;    

input                                   clk                         ;
input                                   rst                         ;
input   [31:0]                          ts_i_data                   ;
input                                   ts_i_val                    ;
input                                   ts_i_sop                    ;
input                                   ts_i_eop                    ;
input   [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag               ;
output  [31:0]                          ts_o_data                   ;
output                                  ts_o_val                    ;
output                                  ts_o_sop                    ;
output                                  ts_o_eop                    ;

wire    [PROG_BIT_WIDTH - 1 : 0]        channel_num                 ;
reg     [ST_WIDTH - 1 : 0]              st_curr                     ;
reg     [ST_WIDTH - 1 : 0]              st_next                     ;
reg                                     ts_o_val                    ;
reg                                     ts_o_sop                    ;
reg                                     ts_o_eop                    ;
reg     [31:0]                          ts_o_data                   ;
reg     [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag_1dly          ;
reg     [TOTAL_PROG_NUM - 1 : 0]        drop_pkt_flag_2dly          ;

assign  channel_num =   {ts_i_data[CHNNUM_BIT_WIDTH - 1 : 0],ts_i_data[PROG_PER_CHAN_BITWIDTH + 3 : 4]};

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        drop_pkt_flag_1dly  <=  {TOTAL_PROG_NUM{1'b0}};
        drop_pkt_flag_2dly  <=  {TOTAL_PROG_NUM{1'b0}};
    end
    else
    begin
        drop_pkt_flag_1dly  <=  drop_pkt_flag;
        drop_pkt_flag_2dly  <=  drop_pkt_flag_1dly;
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
        if((ts_i_sop==1'b1) && (drop_pkt_flag_2dly[channel_num]==1'b0))
        begin
            st_next =   ST_NOT_DROP;
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_NOT_DROP:
    begin
        if(ts_i_eop==1'b1)
        begin
            st_next =   ST_IDLE;
        end
        else
        begin
            st_next =   ST_NOT_DROP;
        end
    end
    default:
    begin
        st_next =   ST_IDLE;
    end
    endcase
end
    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_o_val    <=  1'b0;
        ts_o_sop    <=  1'b0;
        ts_o_eop    <=  1'b0;
        ts_o_data   <=  {32{1'b0}};
    end
    else if((st_curr==ST_NOT_DROP) ||
            ((ts_i_sop==1'b1) && (drop_pkt_flag_2dly[channel_num]==1'b0)))
    begin
        ts_o_val    <=  ts_i_val;
        ts_o_sop    <=  ts_i_sop;
        ts_o_eop    <=  ts_i_eop;
        ts_o_data   <=  ts_i_data;
    end
    else
    begin
        ts_o_val    <=  1'b0;
        ts_o_sop    <=  1'b0;
        ts_o_eop    <=  1'b0;
        ts_o_data   <=  {32{1'b0}};
    end
end

endmodule
