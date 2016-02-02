/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   round_robin_arbiter.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-07-18  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   round_robin_arbiter.v
    File tree    :   round_robin_arbiter.v                        
\************************************************************************************/

`timescale 1ns/100ps

module round_robin_arbiter(
    clk                         ,
    rst                         ,
    req                         ,
    ack                         ,
    grant
    );
    
parameter   CHN_NUM                     = 8                         ;

input                                   clk                         ;
input                                   rst                         ;
input   [CHN_NUM - 1 : 0]               req                         ;
input                                   ack                         ;
output  [CHN_NUM - 1 : 0]               grant                       ;

reg     [CHN_NUM - 1 : 0]               mask                        ;
wire    [CHN_NUM - 1 : 0]               grant_buf                   ;
reg     [CHN_NUM - 1 : 0]               grant                       ;
wire    [CHN_NUM - 1 : 0]               grant_tmp                   ;
wire                                    flag                        ;

assign  flag   =   |grant_buf;

generate
    genvar i;
    for(i=0;i<CHN_NUM;i=i+1)
    begin:GEN_GRANT_BUF
        assign  grant_tmp[i]    =   req[i] & ack;
        assign  grant_buf[i]    =   grant_tmp[i] & mask[i];
    end
endgenerate

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mask    <=  {CHN_NUM{1'b1}};
    end
    else 
    begin
        if((grant_buf[0]==1'b1) || ((flag==1'b0) && (grant_tmp[0]==1'b1)))  mask <=  {{(CHN_NUM - 1){1'b1}},{1{1'b0}}}; else
        if((grant_buf[1]==1'b1) || ((flag==1'b0) && (grant_tmp[1]==1'b1)))  mask <=  {{(CHN_NUM - 2){1'b1}},{2{1'b0}}}; else
        if((grant_buf[2]==1'b1) || ((flag==1'b0) && (grant_tmp[2]==1'b1)))  mask <=  {{(CHN_NUM - 3){1'b1}},{3{1'b0}}}; else
        if((grant_buf[3]==1'b1) || ((flag==1'b0) && (grant_tmp[3]==1'b1)))  mask <=  {{(CHN_NUM - 4){1'b1}},{4{1'b0}}}; else
        if((grant_buf[4]==1'b1) || ((flag==1'b0) && (grant_tmp[4]==1'b1)))  mask <=  {{(CHN_NUM - 5){1'b1}},{5{1'b0}}}; else
        if((grant_buf[5]==1'b1) || ((flag==1'b0) && (grant_tmp[5]==1'b1)))  mask <=  {{(CHN_NUM - 6){1'b1}},{6{1'b0}}}; else
        if((grant_buf[6]==1'b1) || ((flag==1'b0) && (grant_tmp[6]==1'b1)))  mask <=  {{(CHN_NUM - 7){1'b1}},{7{1'b0}}}; else
        if(grant_buf[CHN_NUM - 1]==1'b1)    mask <=  {CHN_NUM{1'b1}};
    end
end
   
always@*
begin
    if((grant_buf[0]==1'b1) || ((flag==1'b0) && (grant_tmp[0]==1'b1)))  grant = {{(CHN_NUM - 1){1'b0}},1'b1,{0{1'b0}}}; else
    if((grant_buf[1]==1'b1) || ((flag==1'b0) && (grant_tmp[1]==1'b1)))  grant = {{(CHN_NUM - 2){1'b0}},1'b1,{1{1'b0}}}; else
    if((grant_buf[2]==1'b1) || ((flag==1'b0) && (grant_tmp[2]==1'b1)))  grant = {{(CHN_NUM - 3){1'b0}},1'b1,{2{1'b0}}}; else
    if((grant_buf[3]==1'b1) || ((flag==1'b0) && (grant_tmp[3]==1'b1)))  grant = {{(CHN_NUM - 4){1'b0}},1'b1,{3{1'b0}}}; else
    if((grant_buf[4]==1'b1) || ((flag==1'b0) && (grant_tmp[4]==1'b1)))  grant = {{(CHN_NUM - 5){1'b0}},1'b1,{4{1'b0}}}; else
    if((grant_buf[5]==1'b1) || ((flag==1'b0) && (grant_tmp[5]==1'b1)))  grant = {{(CHN_NUM - 6){1'b0}},1'b1,{5{1'b0}}}; else
    if((grant_buf[6]==1'b1) || ((flag==1'b0) && (grant_tmp[6]==1'b1)))  grant = {{(CHN_NUM - 7){1'b0}},1'b1,{6{1'b0}}}; else
    if(grant_buf[CHN_NUM - 1]==1'b1)                                    grant = {1'b1,{(CHN_NUM - 1){1'b0}}};           else
                                                                        grant = {CHN_NUM{1'b0}};
end

endmodule
