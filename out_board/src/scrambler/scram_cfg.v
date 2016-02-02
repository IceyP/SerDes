/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   scram_cfg.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   control packet format:{address[15:0],scram_pid[15:0],cw[63:0]};
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-27  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   scram_cfg.v
    File tree    :   scram_cfg.v
\************************************************************************************/

`timescale 1ns/100ps
    
module scram_cfg(
    clk                         ,
    rst                         ,
    clk_x2                      ,
    sc_ctrl_pkt_d               ,
    sc_ctrl_pkt_dval            ,
    sc_ctrl_pkt_eof             ,
    
    ts_i_sync                   ,
    ts_i_valid                  ,
    ts_i_data                   ,
    scram_clr                   ,
    scram_raddr                 ,
    
    scram_i_data                ,
    scram_i_eop                 ,
    scram_ena                   ,
    service_key                 ,
    not_scram_byte_cnt          ,
    buf_h                       ,
    parity_key_flag
    );

parameter   U_DLY                       = 1                         ;    
parameter   SCRAM_RAM_DEPTH_BIT         = 9                         ;
parameter   SCRAM_RAM_WIDTH             = 8                         ;
parameter   PIDRAM_DEPTH_BIT            = 6                         ;
parameter   PIDRAM_WIDTH                = 16                        ;
parameter   SKRAM_DEPTH_BIT             = PIDRAM_DEPTH_BIT + 3      ;
parameter   SKRAM_WIDTH                 = 16                        ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_x2                      ;
input   [15:0]                          sc_ctrl_pkt_d               ;
input                                   sc_ctrl_pkt_dval            ;
input                                   sc_ctrl_pkt_eof             ;

input                                   ts_i_sync                   ;
input                                   ts_i_valid                  ;
input   [7:0]                           ts_i_data                   ;
input                                   scram_clr                   ;
input   [8:0]                           scram_raddr                 ;

output  [7:0]                           scram_i_data                ;
output                                  scram_i_eop                 ;
output                                  scram_ena                   ;
output  [63:0]                          service_key                 ;
output  [7:0]                           not_scram_byte_cnt          ;
output                                  buf_h                       ;
output                                  parity_key_flag             ;   //1:even key;0:odd key;

reg                                     buf_h                       ;
reg     [7:0]                           byte_cnt                    ;
wire                                    scram_i_eop                 ;    
wire    [SCRAM_RAM_DEPTH_BIT - 1 : 0]   scram_waddr                 ;
reg                                     pidram_wren                 ;
reg     [PIDRAM_DEPTH_BIT - 1 : 0]      pidram_waddr                ;
reg     [PIDRAM_WIDTH - 1 : 0]          pidram_wdata                ;
wire    [PIDRAM_DEPTH_BIT - 1 : 0]      pidram_raddr                ;
wire    [PIDRAM_WIDTH - 1 : 0]          pidram_rdata                ;
reg                                     skram_wren                  ;
reg     [SKRAM_DEPTH_BIT - 1 : 0]       skram_waddr                 ;
reg     [SKRAM_WIDTH - 1 : 0]           skram_wdata                 ;
wire    [SKRAM_DEPTH_BIT - 1 : 0]       skram_raddr                 ;
wire    [SKRAM_WIDTH - 1 : 0]           skram_rdata                 ;
reg     [12:0]                          ts_pid                      ;
reg     [7:0]                           byte_cnt_1dly               ;
reg     [7:0]                           byte_cnt_2dly               ;
reg                                     scram_ena                   ;
reg                                     parity_key_flag             ;   //1:even key;0:odd key;
reg     [63:0]                          service_key                 ;
reg     [5:0]                           pid_index                   ;
reg                                     pid_find                    ;
reg     [2:0]                           sk_low                      ;
reg     [7:0]                           not_scram_byte_cnt          ;
reg     [7:0]                           sc_pt                       ;
reg                                     getlen                      ;
reg     [3:0]                           channel_num                 ;
reg     [3:0]                           word_cnt                    ;
reg     [5:0]                           addr_reg                    ;
reg                                     current_cw_sel              ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        word_cnt    <=  {4{1'b0}};
    end
    else if(sc_ctrl_pkt_eof==1'b1)
    begin
        word_cnt    <=  {4{1'b0}};
    end
    else if(sc_ctrl_pkt_dval==1'b1)
    begin
        word_cnt    <=  word_cnt + 4'd1;
    end
end

////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////
assign  scram_i_eop =   ts_i_valid & (byte_cnt==187);

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if(ts_i_sync==1'b1)
    begin
        byte_cnt    <=  8'h01;
    end
    else if(scram_i_eop==1'b1)
    begin
        byte_cnt    <=  8'h00;
    end
    else if((ts_i_valid==1'b1) && (byte_cnt>0))
    begin
        byte_cnt    <=  byte_cnt + 8'h01;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt_1dly   <=  8'h00;
        byte_cnt_2dly   <=  8'h00;
    end
    else 
    begin
        byte_cnt_1dly   <=  byte_cnt;
        byte_cnt_2dly   <=  byte_cnt_1dly;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ts_pid      <=  {13{1'b0}};
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==1))
    begin
        ts_pid[12:8]<=  ts_i_data[4:0];
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==2))
    begin
        ts_pid[7:0] <=  ts_i_data[7:0];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sc_pt   <=  8'hBC;
        getlen  <=  1'b0;
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==3))
    begin
        if(ts_i_data[4]==1'b0)      //"10" adaptation_field only or "00" illegal
        begin
            sc_pt   <=  8'hBC;
            getlen  <=  1'b0;
        end
        else if(ts_i_data[5]==1'b0) //only payload
        begin
            sc_pt   <=  8'h04;
            getlen  <=  1'b0;
        end
        else                        //adaptation_field followed by payload
        begin
            getlen  <=  1'b1;
        end
    end
    else if((ts_i_valid==1'b1) && (byte_cnt==4) && (getlen==1'b1))
    begin
        sc_pt   <=  ts_i_data + 8'h05;
    end
end
                    
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        not_scram_byte_cnt  <=  8'hBC;
    end
    else if(pid_find==1'b0)
    begin
        not_scram_byte_cnt  <=  8'hBC;
    end
    else
    begin
        not_scram_byte_cnt  <=  sc_pt;
    end
end
        
////////////////////////////////////////////////////////////////////
//ts dataram
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        buf_h   <=  1'b0;
    end
    else if(scram_i_eop==1'b1)
    begin
        buf_h   <=  ~buf_h;
    end
end

assign  scram_waddr =   {buf_h,byte_cnt[7:0]};

////////////////////////////////////////////////////////////////////
//pid ram
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        addr_reg    <=  {6{1'b0}};
    end
    else if((word_cnt==4'h0) && (sc_ctrl_pkt_dval==1'b1))
    begin
        addr_reg    <=  sc_ctrl_pkt_d[5:0];
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pidram_wren     <=  1'b0;
        pidram_waddr    <=  {6{1'b0}};
        pidram_wdata    <=  {16{1'b0}};
        current_cw_sel  <=  1'b0;
    end
    else if(scram_clr==1'b1)
    begin
        pidram_wren     <=  1'b1;
        pidram_waddr    <=  pidram_waddr + 'h1;
        pidram_wdata    <=  {16{1'b0}};
    end
    else if((word_cnt==4'h1) && (sc_ctrl_pkt_dval==1'b1))
    begin
        pidram_wren     <=  1'b1;
        pidram_waddr    <=  addr_reg;
        pidram_wdata    <=  sc_ctrl_pkt_d;
        current_cw_sel  <=  sc_ctrl_pkt_d[14];
    end
    else
    begin
        pidram_wren     <=  1'b0;
        pidram_waddr    <=  {6{1'b0}};
        pidram_wdata    <=  {16{1'b0}};
    end
end

assign  pidram_raddr    =   byte_cnt[5:0];

////////////////////////////////////////////////////////////////////
//service key ram
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        skram_wren  <=  1'b0;
        skram_waddr <=  {9{1'b0}};
        skram_wdata <=  {16{1'b0}};
    end
    else if((word_cnt>4'h1) && (word_cnt<4'h6) && (sc_ctrl_pkt_dval==1'b1))
    begin
        skram_wren  <=  1'b1;
        skram_waddr <=  {addr_reg[5:0],3'b000} + {{6{1'b0}},current_cw_sel,2'b00} + ({{5{1'b0}},word_cnt[3:0]} - 9'd2);
        skram_wdata <=  sc_ctrl_pkt_d;
    end
    else
    begin
        skram_wren  <=  1'b0;
        skram_waddr <=  {9{1'b0}};
        skram_wdata <=  {16{1'b0}};
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pid_index       <=  {6{1'b0}};
        pid_find        <=  1'b0;
        scram_ena       <=  1'b0;
        parity_key_flag <=  1'b0;
    end
    else if(scram_i_eop==1'b1)
    begin
        pid_find        <=  1'b0;
        scram_ena       <=  1'b0;
    end
    else if(byte_cnt_2dly[7:6]==2'b01)
    begin
        if((pidram_rdata[12:0]==ts_pid[12:0]) && (pidram_rdata[15]==1'b1))
        begin
            pid_index       <=  byte_cnt_2dly[5:0];
            pid_find        <=  1'b1;
            scram_ena       <=  1'b1;
            parity_key_flag <=  pidram_rdata[14];
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        sk_low  <=  3'b000;
    end
    else 
    begin
        case(sk_low)
        3'b000:
        begin
            if(pid_find==1'b1)      sk_low  <=  3'b001;
        end
        3'b111:
        begin
            if(scram_i_eop==1'b1)   sk_low  <=  3'b000;
        end
        default:    
        begin
            sk_low  <=  sk_low + 3'b001;
        end
        endcase
    end
end 

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        service_key <=  {64{1'b0}};
    end
    else
    begin
        case(sk_low)
        3'b010:
        begin
            service_key[63:48]  <=  skram_rdata;
        end
        3'b011:
        begin
            service_key[47:32]  <=  skram_rdata;
        end
        3'b100:
        begin
            service_key[31:16]  <=  skram_rdata;
        end
        3'b101:
        begin
            service_key[15:0]   <=  skram_rdata;
        end
        default:;
        endcase
    end
end
           
assign  skram_raddr     =   {pid_index[5:0],parity_key_flag,sk_low[1:0]};

////////////////////////////////////////////////////////////////////
//ip core instantiate
////////////////////////////////////////////////////////////////////
//scram dataram,d512w8,no register,read latency=1
scram_datram u0_scram_datram(
    .clka                               ( clk                       ),
    .wea                                ( ts_i_valid                ),
    .addra                              ( scram_waddr               ),
    .dina                               ( ts_i_data                 ),
    .clkb                               ( clk_x2                    ),
    .addrb                              ( scram_raddr               ),
    .doutb                              ( scram_i_data              )
    );

//pidram,d64w16,read latency=2,content:scram_pid[15:0]
scram_pidram u0_scram_pidram(
    .clka                               ( clk                       ),
    .wea                                ( pidram_wren               ),
    .addra                              ( pidram_waddr              ),
    .dina                               ( pidram_wdata              ),
    .clkb                               ( clk                       ),
    .addrb                              ( pidram_raddr              ),
    .doutb                              ( pidram_rdata              )
    );

//service key ram,d512w16,read latency=2
sk_ram u0_sk_ram(
    .clka                               ( clk                       ),
    .wea                                ( skram_wren                ),
    .addra                              ( skram_waddr               ),
    .dina                               ( skram_wdata               ),
    .clkb                               ( clk                       ),
    .addrb                              ( skram_raddr               ),
    .doutb                              ( skram_rdata               )
    );
        
endmodule
