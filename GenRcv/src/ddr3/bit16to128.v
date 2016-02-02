/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  bit16to128.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  pkt_o_val:12cycle+4bytes=196bytes or 24cycle=384bytes
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-11-20  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  bit16to128.v
    File tree    :  bit16to128.v                        
\************************************************************************************/

`timescale 1ns/1ps

module bit16to128(
    clk                         ,
    rst                         ,
    
    ecm_pkt_index               ,
    ecm_pkt_period              ,
    ecm_pkt_sof                 ,
    ecm_pkt_eof                 ,
    ecm_pkt_data                ,
    ecm_pkt_val                 ,
    
    pkt_o_data                  ,
    pkt_o_val                   ,
    pkt_o_eof                   ,
    pkt_o_addr
    );

parameter   TOTAL_ECM_NUM               = 1024                      ;

input                                   clk                         ;
input                                   rst                         ;    
input   [9:0]                           ecm_pkt_index               ;
input   [5:0]                           ecm_pkt_period              ;
input                                   ecm_pkt_sof                 ;
input                                   ecm_pkt_eof                 ;
input   [15:0]                          ecm_pkt_data                ;
input                                   ecm_pkt_val                 ;

output  [127:0]                         pkt_o_data                  ;
output                                  pkt_o_val                   ;
output                                  pkt_o_eof                   ;
output  [15:0]                          pkt_o_addr                  ;

reg     [2:0]                           word_cnt                    ;
reg                                     pkt_o_val                   ;
reg     [127:0]                         pkt_o_data                  ;
reg     [9:0]                           ecm_pkt_index_1dly          ;
reg                                     pkt_o_eof                   ;
reg     [15:0]                          pkt_o_addr                  ;
reg     [4:0]                           pkt_len                     ;

//word_cnt
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  3'b000;
    end
    else if(ecm_pkt_sof==1'b1)
    begin
        word_cnt    <=  3'b001;
    end
    else if(ecm_pkt_eof==1'b1)
    begin
        word_cnt    <=  3'b000;
    end
    else if(ecm_pkt_val==1'b1)
    begin
        word_cnt    <=  word_cnt + 3'b001;
    end
end

//pkt_len
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_len <=  {5{1'b0}};
    end
    else if(ecm_pkt_sof==1'b1)
    begin
        pkt_len <=  5'd0;
    end
    else if(pkt_o_val==1'b1)
    begin
        pkt_len <=  pkt_len + 'h1;
    end
end
        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_o_val   <=  1'b0;
    end
    else if(ecm_pkt_val==1'b1)
    begin
        if(word_cnt==3'b111)
        begin
            pkt_o_val   <=  1'b1;
        end
        else if(ecm_pkt_eof==1'b1)
        begin
            pkt_o_val   <=  1'b1;
        end
        else
        begin
            pkt_o_val   <=  1'b0;
        end
    end
    else
    begin
        pkt_o_val   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_o_data  <=  {128{1'b0}};
    end
    else if(ecm_pkt_val==1'b1)
    begin 
        case(word_cnt)
        3'b000: pkt_o_data[127:112] <=  ecm_pkt_data;
        3'b001: pkt_o_data[111:96]  <=  ecm_pkt_data;
        3'b010: pkt_o_data[95:80]   <=  ecm_pkt_data;
        3'b011: pkt_o_data[79:64]   <=  ecm_pkt_data;
        3'b100: pkt_o_data[63:48]   <=  ecm_pkt_data;
        3'b101: pkt_o_data[47:32]   <=  ecm_pkt_data;
        3'b110: pkt_o_data[31:16]   <=  ecm_pkt_data;
        3'b111: pkt_o_data[15:0]    <=  ecm_pkt_data;
        default:;
        endcase
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ecm_pkt_index_1dly  <=  {10{1'b0}};
    end
    else
    begin
        ecm_pkt_index_1dly  <=  ecm_pkt_index;
    end
end

////////////////////////////////////////////////////////////////////

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_o_eof   <=  1'b0;
    end
    else if((ecm_pkt_val==1'b1) && (ecm_pkt_eof==1'b1))
    begin
        pkt_o_eof   <=  1'b1;
    end
    else
    begin
        pkt_o_eof   <=  1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_o_addr  <=  {16{1'b0}};
    end
    else if((ecm_pkt_val==1'b1) && (ecm_pkt_eof==1'b1))
    begin
        //pkt_o_addr  <=  {{12{1'b0}},ecm_pkt_index_1dly[9:0],{8{1'b0}}};
        pkt_o_addr  <=  {1'b0,pkt_len[4:0],ecm_pkt_index_1dly[9:0]};
    end
end
    
endmodule
