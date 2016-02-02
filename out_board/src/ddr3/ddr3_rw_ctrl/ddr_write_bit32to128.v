/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   ddr_write_bit32to128.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-07-15  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   ddr_write_bit32to128.v
    File tree    :   ddr_write_bit32to128.v
\************************************************************************************/

`timescale 1ns/100ps

module ddr_write_bit32to128(
    clk                         ,
    rst                         ,
    
    ts_in_data                  ,
    ts_in_valid                 ,
    ts_in_start                 ,
    ts_in_end                   ,
    
    ts_out_addr                 ,
    ts_out_data                 ,
    ts_out_valid 
    );

parameter   U_DLY                       = 1                         ;
parameter   DDR3_ADDR_WIDTH             = 28                        ;
parameter   CHNNUM_BIT_WIDTH            = 4                         ;
parameter   PROG_PER_CHAN_BITWIDTH      = 4                         ;
parameter   PROG_BIT_WIDTH              = 9                         ;
parameter   TOTAL_PROG_NUM              = 2 ** PROG_BIT_WIDTH       ;
parameter   ADDR_WIDTH                  = 20 - PROG_BIT_WIDTH       ;

input                                   clk                         ;
input                                   rst                         ;

input   [31:0]                          ts_in_data                  ;
input                                   ts_in_valid                 ;
input                                   ts_in_start                 ;
input                                   ts_in_end                   ;

output  [DDR3_ADDR_WIDTH - 1 : 0]       ts_out_addr                 ;
output  [127:0]                         ts_out_data                 ;
output                                  ts_out_valid                ;

reg     [ADDR_WIDTH - 1 : 0]            wr_addr_ch_h[TOTAL_PROG_NUM - 1 : 0];
reg     [3:0]                           wr_addr_ch_l[TOTAL_PROG_NUM - 1 : 0];

reg     [PROG_BIT_WIDTH - 1 : 0]        channel_num                 ;
reg     [1:0]                           word_cnt                    ;
reg                                     ts_out_valid                ;
reg     [127:0]                         ts_out_data                 ;
reg                                     ts_out_eop                  ;
reg                                     is_low_8ch                  ;
//reg                                     ts_out_sop                  ;
//reg                                     sop_flag                    ;

//word_cnt
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  2'b00;
    end
    else if(ts_in_start==1'b1)
    begin
        word_cnt    <=  #U_DLY 2'b01;
    end
    else if(ts_in_end==1'b1)
    begin
        word_cnt    <=  #U_DLY 2'b00;
    end
    else if(ts_in_valid==1'b1)
    begin
        word_cnt    <=  #U_DLY word_cnt + 2'b01;
    end
end

//ts_out_valid
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_out_valid    <=  1'b0;
    end
    else if((word_cnt==2'b11) && (ts_in_valid==1'b1) && (is_low_8ch==1'b1))
    begin
        ts_out_valid    <=  #U_DLY 1'b1;
    end
    else
    begin
        ts_out_valid    <=  #U_DLY 1'b0;
    end
end


//ts_out_eop
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_out_eop  <=  1'b0;
    end
    else if(ts_in_end==1'b1)
    begin
        ts_out_eop  <=  1'b1;
    end
    else
    begin
        ts_out_eop  <=  1'b0;
    end
end
        
//ts_out_data
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_out_data <=  {128{1'b0}};
    end
    else 
    begin
        case(word_cnt)
        2'b00:  
        begin
            if(ts_in_start==1'b1)
            begin
                ts_out_data[127:96] <=  #U_DLY {1'b1,ts_in_data[30:0]}; 
            end
            else
            begin
                ts_out_data[127:96] <=  #U_DLY ts_in_data;
            end
        end
        2'b01:  ts_out_data[95:64]  <=  #U_DLY ts_in_data;
        2'b10:  ts_out_data[63:32]  <=  #U_DLY ts_in_data;
        2'b11:  ts_out_data[31:0]   <=  #U_DLY ts_in_data;
        default:    ts_out_data     <=  #U_DLY {128{1'b0}};
        endcase
    end
end
       
//wr_addr_ch
generate
    genvar i;
    for(i=0;i<TOTAL_PROG_NUM;i=i+1)
    begin:INST_WR_ADDR_CH
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                wr_addr_ch_l[i]   <=  {4{1'b0}};
            end
            else if((ts_out_valid==1'b1) && (channel_num==i) && (is_low_8ch==1'b1))
            begin
                if(ts_out_eop==1'b1)
                begin
                    wr_addr_ch_l[i]   <=  #U_DLY 4'h0;
                end
                else
                begin
                    wr_addr_ch_l[i]   <=  #U_DLY wr_addr_ch_l[i] + 'h1;
                end
            end
        end
        
        always@(posedge clk or posedge rst)
        begin
            if(rst==1'b1)
            begin
                wr_addr_ch_h[i]   <=  {ADDR_WIDTH{1'b0}};
            end
            else if((ts_out_eop==1'b1) && (channel_num==i) && (is_low_8ch==1'b1))
            begin
                wr_addr_ch_h[i]   <=  #U_DLY wr_addr_ch_h[i] + 'h1;
            end
        end
    end
endgenerate

//channel_num
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        channel_num <=  {PROG_BIT_WIDTH{1'b0}};
    end
    else if(ts_in_start==1'b1)
    begin
        channel_num <=  #U_DLY {ts_in_data[CHNNUM_BIT_WIDTH - 1 : 0],ts_in_data[PROG_PER_CHAN_BITWIDTH + 3 : 4]}; //[2:0]:channel_num,[8:4]:program_num
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        is_low_8ch  <=  1'b0;
    end
    else if(ts_in_start==1'b1)
    begin
        is_low_8ch  <=  ~ts_in_data[3];
    end
    //else if(ts_in_end==1'b1)
    //begin
    //    is_low_8ch  <=  1'b0;
    //end
end

//ts_out_addr
assign  ts_out_addr =   {ts_out_eop,channel_num[PROG_BIT_WIDTH - 1 : 0],wr_addr_ch_h[channel_num],wr_addr_ch_l[channel_num],3'b000}; //8Mbit per program,(2**16)*(2**7)=2**23=8M
    
endmodule
