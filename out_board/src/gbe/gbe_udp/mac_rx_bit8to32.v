/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   mac_rx_bit8to32.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-13  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   mac_rx_bit8to32.v
    File tree    :   mac_rx_bit8to32.v
\************************************************************************************/
`timescale 1ns/100ps

module mac_rx_bit8to32(
    rst                         ,
    clk                         ,
    //input
    mac_i_data                  ,
    mac_i_valid                 ,
    mac_i_last                  ,
    mac_i_ready                 ,
    //output
    mac_rx_sop                  ,
    mac_rx_eop                  ,
    mac_rx_valid                ,
    mac_rx_mod                  ,
    mac_rx_data                 ,
    mac_rx_frmlen
    );

parameter   U_DLY                       = 1                         ;
parameter   ST_WIDTH                    = 3                         ;
parameter   ST_IDLE                     = 3'b001                    ,
            ST_SOP                      = 3'b010                    ,
            ST_DATA                     = 3'b100                    ;

input                                   rst                         ;
input                                   clk                         ;

input   [7:0]                           mac_i_data                  ;
input                                   mac_i_valid                 ;
input                                   mac_i_last                  ;
output                                  mac_i_ready                 ;

output                                  mac_rx_sop                  ;
output                                  mac_rx_eop                  ;
output                                  mac_rx_valid                ;
//2'b00:4bytes valid;2'b01:1byte valid;2'b10:2bytes valid;2'b11:3bytes valid
output  [1:0]                           mac_rx_mod                  ;
output  [31:0]                          mac_rx_data                 ;
output  [11:0]                          mac_rx_frmlen               ;

reg                                     mac_i_ready                 ;

reg     [ST_WIDTH - 1 : 0]              st_curr /* synthesis syn_encoding = "safe,onehot" */;   
reg     [ST_WIDTH - 1 : 0]              st_next                     ;

reg     [1:0]                           byte_cnt                    ;
reg                                     mac_rx_sop                  ;
reg                                     mac_rx_eop                  ;
reg                                     mac_rx_valid                ;
reg     [31:0]                          mac_rx_data                 ;
reg     [1:0]                           mac_rx_mod                  ;
reg     [11:0]                          mac_rx_frmlen               ;

reg     [7:0]                           data_reg3                   ;
reg     [7:0]                           data_reg2                   ;
reg     [7:0]                           data_reg1                   ;
reg     [11:0]                          mac_rx_frmlen_reg           ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_i_ready <=  1'b0;
    end
    else
    begin
        mac_i_ready <=  #U_DLY  1'b1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_frmlen_reg   <=  12'h000;
    end
    else if(mac_i_last==1'b1)
    begin
        mac_rx_frmlen_reg   <=  #U_DLY 12'h000;
    end
    else if(mac_i_valid==1'b1)
    begin
        mac_rx_frmlen_reg   <=  #U_DLY mac_rx_frmlen_reg + 12'h001;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_frmlen   <=  12'h000;
    end
    else if(mac_i_last==1'b1)
    begin
        mac_rx_frmlen   <=  #U_DLY mac_rx_frmlen_reg + 12'h001;
    end
    else
    begin
        mac_rx_frmlen   <=  #U_DLY 12'h000;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  2'b00;
    end
    else if(mac_i_last==1'b1)
    begin
        byte_cnt    <=  #U_DLY 2'b00;
    end
    else if(mac_i_valid==1'b1)
    begin
        byte_cnt    <=  #U_DLY byte_cnt + 2'b01;
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
        if(mac_i_valid==1'b1)
        begin
            st_next =   ST_SOP;
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_SOP:
    begin
        if(byte_cnt>=3)
        begin
            st_next =   ST_DATA;
        end
        else
        begin
            st_next =   ST_SOP;
        end
    end
    ST_DATA:
    begin
        if(mac_i_last==1'b1)
        begin
            st_next =   ST_IDLE;
        end
        else
        begin
            st_next =   ST_DATA;
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
        mac_rx_sop  <=  1'b0;
    end
    else if((st_curr==ST_SOP) && (byte_cnt==2'b11))
    begin
        mac_rx_sop  <=  #U_DLY 1'b1;
    end
    else
    begin
        mac_rx_sop  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_eop  <=  1'b0;
    end
    else if(mac_i_last==1'b1)
    begin
        mac_rx_eop  <=  #U_DLY 1'b1;
    end
    else
    begin
        mac_rx_eop  <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_valid    <=  1'b0;
    end
    else if((byte_cnt==2'b11) || (mac_i_last==1'b1))
    begin
        mac_rx_valid    <=  #U_DLY 1'b1;
    end
    else
    begin
        mac_rx_valid    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        data_reg3   <=  8'h00;
        data_reg2   <=  8'h00;
        data_reg1   <=  8'h00;
    end
    else
    begin
        case(byte_cnt)
        2'b00:
        begin
            data_reg3   <=  #U_DLY mac_i_data;
        end
        2'b01:
        begin
            data_reg2   <=  #U_DLY mac_i_data;
        end
        2'b10:
        begin
            data_reg1   <=  #U_DLY mac_i_data;
        end
        default:
        begin
            data_reg3   <=  #U_DLY 8'h00;
            data_reg2   <=  #U_DLY 8'h00;
            data_reg1   <=  #U_DLY 8'h00;
        end
        endcase
    end
end 
        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_data <=  {32{1'b0}};
    end
    else if(mac_i_last==1'b1)
    begin
        case(byte_cnt)
        2'b00:
        begin
            mac_rx_data <=  #U_DLY {mac_i_data,{24{1'b0}}};
        end
        2'b01:
        begin
            mac_rx_data <=  #U_DLY {data_reg3,mac_i_data,{16{1'b0}}};
        end
        2'b10:
        begin
            mac_rx_data <=  #U_DLY {data_reg3,data_reg2,mac_i_data,8'h00};
        end
        2'b11:
        begin
            mac_rx_data <=  #U_DLY {data_reg3,data_reg2,data_reg1,mac_i_data};
        end
        default:
        begin
            mac_rx_data <=  #U_DLY {32{1'b0}};
        end
        endcase
    end
    else if(byte_cnt==2'b11)
    begin
        mac_rx_data <=  #U_DLY {data_reg3,data_reg2,data_reg1,mac_i_data};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_mod  <=  2'b00;
    end
    else if(mac_i_last==1'b1)
    begin
        case(byte_cnt)
        2'b00:
        begin
            mac_rx_mod  <=  #U_DLY 2'b01;
        end
        2'b01:
        begin
            mac_rx_mod  <=  #U_DLY 2'b10;
        end
        2'b10:
        begin
            mac_rx_mod  <=  #U_DLY 2'b11;
        end
        2'b11:
        begin
            mac_rx_mod  <=  #U_DLY 2'b00;
        end
        default:
        begin
            mac_rx_mod  <=  #U_DLY 2'b00;
        end
        endcase
    end
    else
    begin
        mac_rx_mod  <=  #U_DLY 2'b00;
    end
end

endmodule
