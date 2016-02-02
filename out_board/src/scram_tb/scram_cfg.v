/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   scram_cfg.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   address 12'h840:write channel number;
                     pid write addrress:12'b1000_00xx_xxxx;pid_data[14]=1:even key;pid_data[14]=0:odd key;pid_data[15]:valid;
                     service key write address:12'b1000_1xxx_xxxx,
                     even key address = odd key address + 1;
                     every service key write 4 times from low-16bit to high-16bit,
                     example:12'h840 write 1,then 12'h880 write 4 times,channel 1 the first service key;first low then high;
                             12'h840 write 1,then 12'h881 write 4 times,channel 1 the second service key;
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-02-25  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   scram_cfg.v
    File tree    :   scram_cfg.v
\************************************************************************************/

`timescale 1ns/100ps
    
module scram_cfg(
    clk                         ,
    rst                         ,
    clk_cfg                     ,
    rst_cfg                     ,
    //local bus
    channel_index               ,
    lbus_addr                   ,
    lbus_wdata                  ,
    lbus_we_n                   ,
    
    ts_i_sync                   ,
    ts_i_valid                  ,
    ts_i_data                   ,
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
parameter   P_BUS_ADDR_WIDTH            = 12                        ;
parameter   P_BUS_DATA_WIDTH            = 16                        ;
parameter   SCRAM_RAM_DEPTH_BIT         = 9                         ;
parameter   SCRAM_RAM_WIDTH             = 8                         ;
parameter   PIDRAM_DEPTH_BIT            = 6                         ;
parameter   PIDRAM_WIDTH                = 16                        ;
parameter   SKRAM_DEPTH_BIT             = PIDRAM_DEPTH_BIT + 3      ;
parameter   SKRAM_WIDTH                 = 16                        ;

input                                   clk                         ;
input                                   rst                         ;
input                                   clk_cfg                     ;
input                                   rst_cfg                     ;

//local bus
input   [3:0]                           channel_index               ;
input   [P_BUS_ADDR_WIDTH - 1 : 0]      lbus_addr                   ;
input   [P_BUS_DATA_WIDTH - 1 : 0]      lbus_wdata                  ;
input                                   lbus_we_n                   ;

input                                   ts_i_sync                   ;
input                                   ts_i_valid                  ;
input   [7:0]                           ts_i_data                   ;
input   [8:0]                           scram_raddr                 ;

output  [7:0]                           scram_i_data                ;
output                                  scram_i_eop                 ;
output                                  scram_ena                   ;
output  [63:0]                          service_key                 ;
output  [7:0]                           not_scram_byte_cnt          ;
output                                  buf_h                       ;
output                                  parity_key_flag             ;   //1:even key;0:odd key;

reg                                     lbus_we_n_1dly              ;
wire                                    negedge_lbus_we_n           ;

reg                                     buf_h                       ;
reg     [7:0]                           byte_cnt                    ;
wire                                    scram_i_eop                 ;    
wire    [SCRAM_RAM_DEPTH_BIT - 1 : 0]   scram_waddr                 ;

reg                                     pidram_wren                 ;
wire    [PIDRAM_DEPTH_BIT - 1 : 0]      pidram_waddr                ;
wire    [PIDRAM_WIDTH - 1 : 0]          pidram_wdata                ;
wire    [PIDRAM_DEPTH_BIT - 1 : 0]      pidram_raddr                ;
wire    [PIDRAM_WIDTH - 1 : 0]          pidram_rdata                ;

reg                                     skram_wren                  ;
wire    [SKRAM_DEPTH_BIT - 1 : 0]       skram_waddr                 ;
wire    [SKRAM_WIDTH - 1 : 0]           skram_wdata                 ;
wire    [SKRAM_DEPTH_BIT - 1 : 0]       skram_raddr                 ;
wire    [SKRAM_WIDTH - 1 : 0]           skram_rdata                 ;

reg     [12:0]                          ts_pid                      ;
reg     [7:0]                           byte_cnt_1dly               ;
reg     [7:0]                           byte_cnt_2dly               ;
reg                                     scram_ena                   ;
reg                                     parity_key_flag             ;   //1:even key;0:odd key;
reg     [63:0]                          service_key                 ;
reg     [1:0]                           sk_i                        ;
reg     [5:0]                           pid_index                   ;
reg                                     pid_find                    ;
reg     [2:0]                           sk_low                      ;
reg     [7:0]                           not_scram_byte_cnt          ;
reg     [7:0]                           sc_pt                       ;
reg                                     getlen                      ;
reg     [3:0]                           channel_num                 ;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        lbus_we_n_1dly  <=  1'b1;
    end
    else
    begin
        lbus_we_n_1dly  <=  lbus_we_n;
    end
end

assign  negedge_lbus_we_n    =   (~lbus_we_n) & lbus_we_n_1dly;

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        channel_num    <=  4'h0;
    end
    else if((negedge_lbus_we_n==1'b1) && (lbus_addr==12'h840))
    begin
        channel_num    <=  lbus_wdata[3:0];
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
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        pidram_wren <=  1'b0;
    end
    else if((negedge_lbus_we_n==1'b1) && 
            (lbus_addr[11:6]==6'b10_0000) &&
            (channel_num==channel_index))
    begin
        pidram_wren <=  1'b1;
    end
    else
    begin
        pidram_wren <=  1'b0;
    end
end

assign  pidram_waddr    =   lbus_addr[5:0];
assign  pidram_wdata    =   lbus_wdata[15:0];
assign  pidram_raddr    =   byte_cnt[5:0];

////////////////////////////////////////////////////////////////////
//service key ram
////////////////////////////////////////////////////////////////////
always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        skram_wren  <=  1'b0;
    end
    else if((negedge_lbus_we_n==1'b1) &&
            (lbus_addr[11:7]==5'b1_0001) &&
            (channel_num==channel_index))
    begin
        skram_wren  <=  1'b1;
    end
    else
    begin
        skram_wren  <=  1'b0;
    end
end

always@(posedge clk_cfg or posedge rst_cfg)
begin
    if(rst_cfg==1'b1)
    begin
        sk_i    <=  2'b00;
    end
    else if((negedge_lbus_we_n==1'b1) && (lbus_addr==12'h840))
    begin
        sk_i    <=  2'b00;
    end
    else if(skram_wren==1'b1)
    begin
        sk_i    <=  sk_i + 2'b01;
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
            if(pid_find==1'b1)  sk_low  <=  3'b001;
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
            service_key[15:0]   <=  skram_rdata;
        end
        3'b011:
        begin
            service_key[31:16]  <=  skram_rdata;
        end
        3'b100:
        begin
            service_key[47:32]  <=  skram_rdata;
        end
        3'b101:
        begin
            service_key[63:48]  <=  skram_rdata;
        end
        default:;
        endcase
    end
end
           
assign  skram_waddr     =   {lbus_addr[6:0],sk_i[1:0]};
assign  skram_wdata     =   lbus_wdata[15:0];
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
    .clkb                               ( clk                       ),
    .addrb                              ( scram_raddr               ),
    .doutb                              ( scram_i_data              )
    );

//pidram,d64w16,read latency=2
scram_pidram u0_scram_pidram(
    .clka                               ( clk_cfg                   ),
    .wea                                ( pidram_wren               ),
    .addra                              ( pidram_waddr              ),
    .dina                               ( pidram_wdata              ),
    .clkb                               ( clk                       ),
    .addrb                              ( pidram_raddr              ),
    .doutb                              ( pidram_rdata              )
    );

//service key ram,d512w16,read latency=2
sk_ram u0_sk_ram(
    .clka                               ( clk_cfg                   ),
    .wea                                ( skram_wren                ),
    .addra                              ( skram_waddr               ),
    .dina                               ( skram_wdata               ),
    .clkb                               ( clk                       ),
    .addrb                              ( skram_raddr               ),
    .doutb                              ( skram_rdata               )
    );
        
endmodule
