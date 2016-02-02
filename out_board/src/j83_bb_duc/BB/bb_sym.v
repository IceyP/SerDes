/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   bb_sym.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-02  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   bb_sym.v
    File tree    :   bb_sym.v
\************************************************************************************/

`timescale 1ns/100ps

module bb_sym(
    rst                         ,
    clk                         ,
    clk_cfg                     ,
    bb_sym_iq                   ,
    bb_sym_vi                   ,
    cfg_we                      ,
    cfg_wa                      ,
    cfg_di            
    );
    
parameter       U_DLY                   = 1                         ;
parameter       WAIT_NUM                = 16'd21                    ;
parameter       ST_WIDTH                = 8                         ;
parameter       ST_IDLE                 = 8'h01                     ,
                ST_CFG                  = 8'h02                     ,
                ST_DATA                 = 8'h04                     ;
                
input                                   rst                         ;
input                                   clk                         ;
input                                   clk_cfg                     ;

output  [9:0]                           bb_sym_iq                   ;
output                                  bb_sym_vi                   ;
output                                  cfg_we                      ;
output  [6:0]                           cfg_wa                      ;
output  [31:0]                          cfg_di                      ;

reg     [39:0]                          lfsr                        ;
reg                                     bb_sym_vi                   ;
wire                                    sym_vi_reg                  ;
reg                                     sym_vi_reg_1syn             ;
reg                                     sym_vi_reg_2syn             ;
reg     [9:0]                           bb_sym_iq                   ;
reg     [ST_WIDTH - 1 : 0]              st_curr                     ;
reg     [ST_WIDTH - 1 : 0]              st_next                     ;
reg     [15:0]                          wait_cnt                    ;
reg     [7:0]                           cfg_clk_num                 ;
reg                                     cfg_we                      ;
wire    [6:0]                           cfg_wa                      ;
reg     [31:0]                          cfg_di                      ;
reg     [3:0]                           cfg_wa_l                    ;
reg     [2:0]                           cfg_wa_h                    ;

assign  sym_vi_reg  =   (st_curr==ST_DATA)  ?   1'b1    :   1'b0;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sym_vi_reg_1syn <=  1'b0;
        sym_vi_reg_2syn <=  1'b0;
    end
    else
    begin
        sym_vi_reg_1syn <=  sym_vi_reg;
        sym_vi_reg_2syn <=  sym_vi_reg_1syn;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        bb_sym_vi       <=  1'b0;
    end
    else
    begin
        bb_sym_vi       <=  sym_vi_reg_2syn & (~cfg_we);
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        lfsr        <=  {40{1'b1}};
        bb_sym_iq   <=  {10{1'b1}};
    end
    else if(sym_vi_reg_2syn==1'b0)
    begin
        lfsr        <=  {40{1'b1}};
        bb_sym_iq   <=  {10{1'b1}};
    end
    else
    begin
        lfsr        <=  (lfsr & 40'h7FFFFFFFBB) ^ (lfsr << 1) ^ (lfsr >> 1);
        bb_sym_iq   <=  lfsr[9:0] | 10'b0000100001;
    end
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        wait_cnt    <=  16'h0000;
    end
    else if(wait_cnt>=WAIT_NUM)
    begin
        wait_cnt    <=  WAIT_NUM;
    end
    else
    begin
        wait_cnt    <=  wait_cnt + 16'h1;
    end
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        st_curr     <=  ST_IDLE;
    end
    else
    begin
        st_curr     <=  st_next;
    end
end

always@(*)
begin
    case(st_curr)
    ST_IDLE:
    begin
        if(wait_cnt>=WAIT_NUM)
        begin
            st_next =   ST_CFG;
        end
        else
        begin
            st_next =   ST_IDLE;
        end
    end
    ST_CFG:
    begin
        if(cfg_clk_num>=47)
        begin
            st_next =   ST_DATA;
        end
        else
        begin
            st_next =   ST_CFG;
        end
    end
    ST_DATA:
    begin
        st_next =   ST_DATA;
    end
    default:
    begin
        st_next =   ST_IDLE;
    end
    endcase
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        cfg_clk_num <=  8'h00;
    end
    else if(st_curr==ST_CFG)
    begin
        cfg_clk_num <=  cfg_clk_num + 8'h01;
    end
    else
    begin
        cfg_clk_num <=  8'h00;
    end
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        cfg_we  <=  1'b0;
    end
    else if(st_curr==ST_CFG)
    begin
        cfg_we  <=  1'b1;
    end
    else
    begin
        cfg_we  <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        cfg_wa_l    <=  4'b0000;
    end
    else if(cfg_clk_num==0)
    begin
        cfg_wa_l    <=  4'b0000;
    end
    else if(cfg_clk_num % 3 == 0)
    begin
        cfg_wa_l    <=  cfg_wa_l + 4'h1;
    end
end

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        cfg_wa_h    <=  3'b000;
    end
    else if(cfg_clk_num==0)
    begin
        cfg_wa_h    <=  3'b000;
    end
    else
    begin
        case(cfg_clk_num % 3)
        0:
        begin
            cfg_wa_h    <=  3'b000;
        end
        1:
        begin
            cfg_wa_h    <=  3'b001;
        end
        2:
        begin
            cfg_wa_h    <=  3'b010;
        end
        endcase
    end
end

assign  cfg_wa  =   {cfg_wa_h[2:0],cfg_wa_l[3:0]};

always@(posedge clk_cfg or posedge rst)
begin
    if(rst==1'b1)
    begin
        cfg_di      <=  {32{1'b0}};
    end
    else if(cfg_clk_num==0)
    begin
        cfg_di      <=  32'hA5000001;
    end
    else
    begin
        case(cfg_clk_num % 3)
        0:
        begin
            //cfg_di  <=  32'h83BD95B1;                                   //R=6.175339
				cfg_di  <=  32'hA5000001;                                   //R=6.875
        end
        1:
        begin
            //cfg_di  <=  32'h0000B53B;                                   //G=-3
				//cfg_di <= 32'h00001999;                                       //G=-20
				cfg_di <= 32'h0000FFFF;                                       //G=0
        end
        2:
        begin
            //cfg_di  <=  32'h09BA5E35;                                   //F=0.912
				cfg_di  <=  32'h0;                                   //F=0
        end
        endcase
    end
end
            
endmodule