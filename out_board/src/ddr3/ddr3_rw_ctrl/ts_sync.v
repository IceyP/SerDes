/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   ts_sync.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-08-10  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ts_sync.v
    File tree    :   ts_sync.v
\************************************************************************************/

`timescale 1ns/100ps

module ts_sync(
    rst                         ,                                       //in  : reset
    clk                         ,                                       //in  : clock 125MHz
    
    ts_in                       ,                                       //in  : udp rx data
    ts_in_valid                 ,                                       //in  : udp rx valid
    
    ts_out                      ,                                       //out : ts sync out data
    ts_out_valid                ,                                       //out : ts sync out valid
    ts_out_sync                 ,                                       //out : frame head(0x47)
    ts_out_last             
    );

parameter       U_DLY                       = 1                     ;   //Unit
parameter       SYNC_WORD                   = 8'h47                 ;

parameter       ST_WIDTH                    = 3                     ;
parameter       ST_IDLE                     = 3'b001                ;
parameter       ST_PRE_SYNC                 = 3'b010                ;
parameter       ST_SYNC                     = 3'b100                ;

input                                   rst                         ;
input                                   clk                         ;

input   [7:0]                           ts_in                       ;
input                                   ts_in_valid                 ;

output  [7:0]                           ts_out                      ;
output                                  ts_out_valid                ;
output                                  ts_out_sync                 ;
output                                  ts_out_last                 ;

reg     [7:0]                           ts_in_1dly                  ;
reg                                     ts_in_valid_1dly            ;
reg     [7:0]                           ts_in_2dly                  ;
reg                                     ts_in_valid_2dly            ;

reg     [ST_WIDTH - 1 : 0]              st_curr                     ;
reg     [ST_WIDTH - 1 : 0]              st_next                     ;   

reg     [2:0]                           sync_count                  ;
reg     [7:0]                           byte_cnt                    ;

reg     [7:0]                           ts_out                      ;
reg                                     ts_out_valid                ;
reg                                     ts_out_sync                 ;
reg                                     ts_out_last                 ;

wire                                    sync_word_found             ;  
//wire                                    pre_sync_valid              ;
reg     [187:0]                         shift188_reg                ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_in_1dly          <=  8'h00;
        ts_in_valid_1dly    <=  1'b0;
        
        ts_in_2dly          <=  8'h00;
        ts_in_valid_2dly    <=  1'b0;
    end
    else
    begin
        ts_in_1dly          <=  #U_DLY ts_in;
        ts_in_valid_1dly    <=  #U_DLY ts_in_valid;
        
        ts_in_2dly          <=  #U_DLY ts_in_1dly;
        ts_in_valid_2dly    <=  #U_DLY ts_in_valid_1dly;
    end
end

assign  sync_word_found =   ((ts_in_valid_1dly==1'b1) && (ts_in_1dly==SYNC_WORD)) ? 1'b1 : 1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        shift188_reg    <=  {188{1'b0}};
    end
    else if(ts_in_valid_1dly==1'b1)
    begin
        shift188_reg    <=  #U_DLY {shift188_reg[186:0],sync_word_found};
    end
end

//shift_188 u0_shift188(
//    .clk                                ( clk                       ),
//    .ce                                 ( ts_in_valid_1dly          ),
//    .d                                  ( sync_word_found           ), 
//    .q                                  ( pre_sync_valid            )
//    );


always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sync_count  <=  3'b000;
    end
    else if(st_curr==ST_IDLE)
    begin
        sync_count  <=  #U_DLY 3'b000;
    end
    else if((st_curr==ST_PRE_SYNC) && (byte_cnt==187) && (sync_word_found==1'b1))
    begin
        sync_count  <=  #U_DLY sync_count + 'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if(st_curr==ST_IDLE)
    begin
        byte_cnt    <=  #U_DLY 8'h00;
    end
    else if((byte_cnt>=187) && (ts_in_valid_1dly==1'b1))
    begin
        byte_cnt    <=  #U_DLY 8'h00;
    end
    else if(((st_curr==ST_PRE_SYNC) || (st_curr==ST_SYNC)) && (ts_in_valid_1dly==1'b1))
    begin
        byte_cnt    <=  #U_DLY byte_cnt + 'h1;
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
        if((sync_word_found==1'b1) && (shift188_reg[187]==1'b1))
//        if((sync_word_found==1'b1) && (pre_sync_valid==1'b1))        
        begin
            st_next =   ST_PRE_SYNC;
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_PRE_SYNC:
    begin
        if((sync_count==3'h2) && (byte_cnt==187) && (sync_word_found==1'b1))
        begin
            st_next =   ST_SYNC;
        end
        else if((byte_cnt==187) && (ts_in_valid_1dly==1'b1) && (ts_in_1dly!=SYNC_WORD))
        begin
            st_next =   ST_IDLE;
        end
        else
        begin
            st_next =   ST_PRE_SYNC;
        end
    end
    ST_SYNC:
    begin
        if((byte_cnt==187) && (ts_in_valid_1dly==1'b1) && (ts_in_1dly!=SYNC_WORD))
        begin
            st_next =   ST_IDLE;
        end
        else
        begin
            st_next =   ST_SYNC;
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
        ts_out          <=  8'h00;
        ts_out_valid    <=  1'b0;   
    end
    else if(st_curr==ST_SYNC)
    begin
        ts_out          <=  #U_DLY ts_in_2dly;
        ts_out_valid    <=  #U_DLY ts_in_valid_2dly;
    end
    else
    begin
        ts_out          <=  #U_DLY 8'h00;
        ts_out_valid    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_out_sync     <=  1'b0;
    end
    else if((st_curr==ST_SYNC) && (byte_cnt==0) && (ts_in_valid_2dly==1'b1))
    begin
        ts_out_sync     <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_out_sync     <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_out_last     <=  1'b0;
    end
    else if((st_curr==ST_SYNC) && (byte_cnt==187) && (ts_in_valid_2dly==1'b1))
    begin
        ts_out_last     <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_out_last     <=  #U_DLY 1'b0;
    end
end
        
endmodule
                        