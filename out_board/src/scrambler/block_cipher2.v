/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   block_cipher2.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-03-23  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   block_cipher2.v
    File tree    :   block_cipher2.v
\************************************************************************************/

(*use_dsp48="yes"*)
module block_cipher2(
    nrst                        ,
    clk                         ,
    pb                          ,
    pkt_eop                     ,
    ck                          ,
    pt                          ,
    buffh                       ,
    o_e                         ,
    enc                         ,           

    bcradd                      ,
    bcwadd                      ,
    bcwe                        ,
    ib                          , 
    ck_reg                      ,
    bcend                       ,
    ptr                         ,
    buffhr                      
    );

parameter   ST_WIDTH                    = 7                         ;
parameter   bc_idle                     = 7'b000_0001               ,
            bc_cpdata                   = 7'b000_0010               ,
            bc_keyschedule              = 7'b000_0100               ,
            bc_indata                   = 7'b000_1000               ,
            bc_cipher                   = 7'b001_0000               ,
            bc_outdata                  = 7'b010_0000               ,
            bc_pr                       = 7'b100_0000               ;
                
input                                   nrst                        ;
input                                   clk                         ;
input   [0:7]                           pb                          ;
input                                   pkt_eop                     ;
input   [0:63]                          ck                          ;
input   [0:7]                           pt                          ;
input                                   buffh                       ;
input                                   o_e                         ;
input                                   enc                         ;

output  [0:8]                           bcradd                      ;
output  [0:8]                           bcwadd                      ;
output                                  bcwe                        ;
output  [0:7]                           ib                          ;
output  [0:63]                          ck_reg                      ;
output                                  bcend                       ;
output  [0:7]                           ptr                         ;
output                                  buffhr                      ;

reg     [1:64]                          kb                          ;
reg     [0:5]                           ni                          ;
wire    [0:7]                           kk                          ;
reg     [0:7]                           kv                          ;
wire    [0:5]                           keyaddr                     ;
reg                                     keywe                       ;
wire    [0:7]                           key                         ;
reg     [0:63]                          r                           ;
wire    [0:7]                           perm                        ;
wire    [0:7]                           t_box                       ;
wire    [0:7]                           f_box                       ;
wire    [0:7]                           tmp                         ;
reg     [0:5]                           bc_cnt                      ;
reg     [0:2]                           rcnt                        ;
reg     [0:2]                           wcnt                        ;
reg     [0:7]                           cptr                        ;
reg                                     cpd                         ;
reg     [0:7]                           p                           ;
reg     [0:4]                           rbn                         ;
reg     [0:4]                           wbn                         ;
reg     [0:2]                           pr                          ;
reg                                     odd_reg                     ;
reg                                     enc_reg                     ;
wire                                    not_clk                     ;
reg     [0:7]                           ib                          ;
reg                                     bcend                       ;
reg                                     buffhr                      ;
reg     [0:7]                           ptr                         ;
reg     [0:63]                          ck_reg                      ;

reg     [ST_WIDTH - 1 : 0]              st_bc                       ;

assign  not_clk =   ~clk;

keybuff u0_keybuff(
    .clka                               ( clk                       ),
    .wea                                ( keywe                     ),
    .addra                              ( keyaddr                   ),
    .dina                               ( kk                        ),
    .clkb                               ( not_clk                   ),
    .addrb                              ( keyaddr                   ),
    .doutb                              ( key                       )
    );	    

assign  kk[5:7] =   kv[5:7] ^ ni[0:2];
assign  kk[0:4] =   kv[0:4];
assign  keyaddr =   (st_bc==bc_cipher)  ?   bc_cnt  :   ni;

sbox_mem u0_sbox_mem(
    .clka                               ( clk                       ),
    .addra                              ( t_box                     ),
    .douta                              ( f_box                     )
    );
    
assign  bcradd  =   {buffhr,(cptr+{rbn,rcnt})};
assign  bcwadd  =   {buffhr,(cptr+{wbn,wcnt})};
assign  bcwe    =   ((st_bc==bc_outdata) || (((st_bc==bc_cpdata) || (st_bc==bc_pr)) && (cpd==1'b1)))    ?   1'b1    :   1'b0;

always@*
begin
    case(st_bc)
        bc_cpdata:
        begin
            if((cptr==3) && (enc_reg==1'b1))
            begin
                ib  =   pb | {1'b1,odd_reg,{6{1'b0}}};
            end
            else
            begin
                ib  =   pb;
            end
        end
        bc_pr:
        begin
            ib  =   pb;
        end
        default:
        begin
            ib  =   r[0:7];
        end
    endcase
end

always@(posedge clk or negedge nrst)
begin
    if(nrst==1'b0)
    begin
        st_bc   <=  bc_idle;
        bc_cnt  <=  {6{1'b0}};
        cptr    <=  {8{1'b0}};
        rcnt    <=  {3{1'b0}};
        wcnt    <=  {3{1'b0}};
        rbn     <=  {5{1'b0}};
        wbn     <=  {5{1'b0}};
        bcend   <=  1'b0;
        buffhr  <=  1'b0;
        enc_reg <=  1'b0;
        ptr     <=  8'hBC;
    end
    else 
    begin
        case(st_bc)
        bc_idle:
        begin
            bc_cnt  <=  {6{1'b0}};
            rcnt    <=  {3{1'b0}};
            wcnt    <=  {3{1'b0}};
            bcend   <=  1'b0;
            if(pkt_eop==1'b1)
            begin
                st_bc   <=  bc_cpdata;
                cptr    <=  {8{1'b0}};
                cpd     <=  1'b0;
                ptr     <=  pt;
                buffhr  <=  buffh;
                p       <=  180 - pt;
                odd_reg <=  o_e;
                enc_reg <=  enc;
                ck_reg  <=  ck;
                r       <=  {64{1'b0}};
            end
        end
        bc_cpdata:
        begin
            cpd <=  ~cpd;
            if(cpd==1'b1)
            begin
                cptr    <=  cptr + 'h1;
            end
            
            if(ptr>=180)
            begin
                if((cptr==187) && (cpd==1'b1))
                begin
                    st_bc   <=  bc_idle;
                    bcend   <=  1'b1;
                end
            end
            else
            begin
                if(cptr==ptr)
                begin
                    st_bc   <=  bc_keyschedule;
                    cpd     <=  1'b0;
                end
            end
        end
        bc_keyschedule:
        begin
            cpd     <=  1'b1;
            rbn     <=  p[0:4];
            wbn     <=  p[0:4];
            pr      <=  p[5:7];
            if((ni==0) && (cpd==1'b1))
            begin
                st_bc   <=  bc_indata;
                rcnt    <=  3'b001;
            end
        end
        bc_indata:
        begin
            if(rcnt==0)
            begin
                st_bc   <=  bc_cipher;
                bc_cnt  <=  6'b00_0001;
                rbn     <=  rbn - 'h1;
            end
            else
            begin
                rcnt    <=  rcnt + 'h1;
            end
            
            r[0:7]      <=  r[8:15];
            r[8:15]     <=  r[16:23];
            r[16:23]    <=  r[24:31];
            r[24:31]    <=  r[32:39];
            r[32:39]    <=  r[40:47];
            r[40:47]    <=  r[48:55];
            r[48:55]    <=  r[56:63];
            r[56:63]    <=  pb[0:7];
        end
        bc_cipher:
        begin
            if(bc_cnt==56)
            begin
                st_bc   <=  bc_outdata;
                rcnt    <=  3'b001;
                wcnt    <=  3'b000;
            end
            
            bc_cnt      <=  bc_cnt + 'h1;
            r[0:7]      <=  r[8:15];
            r[8:15]     <=  r[16:23] ^ r[0:7];
            r[16:23]    <=  r[24:31] ^ r[0:7];
            r[24:31]    <=  r[32:39] ^ r[0:7];
            r[32:39]    <=  r[40:47];
            r[40:47]    <=  r[48:55] ^ perm;
            r[48:55]    <=  r[56:63];
            r[56:63]    <=  r[0:7] ^ f_box;
        end
        bc_outdata:
        begin
            if(wcnt==7)
            begin
                if(wbn==0)
                begin
                    rbn     <=  {5{1'b0}};
                    rcnt    <=  3'b000;
                    wcnt    <=  3'b000;
                    cptr    <=  188 - {{5{1'b0}},p[5:7]};
                    cpd     <=  1'b0;
                    if(p[5:7]==3'b000)
                    begin
                        st_bc   <=  bc_idle;
                        bcend   <=  1'b1;
                    end
                    else
                    begin
                        st_bc   <=  bc_pr;
                    end
                end
                else
                begin
                    rbn     <=  rbn - 'h1;
                    wbn     <=  wbn - 'h1;
                    st_bc   <=  bc_cipher;
                end
                
                bc_cnt  <=  6'b00_0001;
            end
            else
            begin
                rcnt    <=  rcnt + 'h1;
                wcnt    <=  wcnt + 'h1;
            end
            
            r[0:7]      <=  r[8:15]; 
            r[8:15]     <=  r[16:23];
            r[16:23]    <=  r[24:31];
            r[24:31]    <=  r[32:39];
            r[32:39]    <=  r[40:47];
            r[40:47]    <=  r[48:55];
            r[48:55]    <=  r[56:63];
            r[56:63]    <=  r[0:7] ^ pb[0:7];
        end
        bc_pr:
        begin
            cpd <=  ~cpd;
            if(cpd==1'b1)
            begin
                cptr    <=  cptr + 'h1;
            end
            
            if((cptr==187) && (cpd==1'b1))
            begin
                st_bc   <=  bc_idle;
                bcend   <=  1'b1;
            end
        end
        default:;
        endcase
    end
end

always@(posedge clk or negedge nrst)
begin
    if(nrst==1'b0)
    begin
        ni  <=  6'b110111;
    end
    else
    begin
        if((pkt_eop==1'b1) && (st_bc==bc_idle))
        begin
            ni      <=  6'b110111;
            kb      <=  ck;
            keywe   <=  1'b1;
        end
        else
        begin
            if((|ni)==1'b1)
            begin
                ni      <=  ni - 'h1;
            end
            else
            begin
                keywe   <=  1'b0;
            end
            
            if(ni[3:5]==3'b000)
            begin
                kb[18]  <=  kb[1];
                kb[36]  <=  kb[2];
                kb[9]   <=  kb[3];
                kb[7]   <=  kb[4];
                kb[42]  <=  kb[5];
                kb[49]  <=  kb[6];
                kb[29]  <=  kb[7];
                kb[21]  <=  kb[8];
                kb[28]  <=  kb[9];
                kb[54]  <=  kb[10];
                kb[62]  <=  kb[11];
                kb[50]  <=  kb[12];
                kb[19]  <=  kb[13];
                kb[33]  <=  kb[14];
                kb[59]  <=  kb[15];
                kb[64]  <=  kb[16];
                kb[24]  <=  kb[17];
                kb[20]  <=  kb[18];
                kb[37]  <=  kb[19];
                kb[39]  <=  kb[20];
                kb[2]   <=  kb[21];
                kb[53]  <=  kb[22];
                kb[27]  <=  kb[23];
                kb[1]   <=  kb[24];
                kb[34]  <=  kb[25];
                kb[4]   <=  kb[26];
                kb[13]  <=  kb[27];
                kb[14]  <=  kb[28];
                kb[57]  <=  kb[29];
                kb[40]  <=  kb[30];
                kb[26]  <=  kb[31];
                kb[41]  <=  kb[32];
                kb[51]  <=  kb[33];
                kb[35]  <=  kb[34];
                kb[52]  <=  kb[35];
                kb[12]  <=  kb[36];
                kb[22]  <=  kb[37];
                kb[48]  <=  kb[38];
                kb[30]  <=  kb[39];
                kb[58]  <=  kb[40];
                kb[45]  <=  kb[41];
                kb[31]  <=  kb[42];
                kb[8]   <=  kb[43];
                kb[25]  <=  kb[44];
                kb[23]  <=  kb[45];
                kb[47]  <=  kb[46];
                kb[61]  <=  kb[47];
                kb[17]  <=  kb[48];
                kb[60]  <=  kb[49];
                kb[5]   <=  kb[50];
                kb[56]  <=  kb[51];
                kb[43]  <=  kb[52];
                kb[11]  <=  kb[53];
                kb[6]   <=  kb[54];
                kb[10]  <=  kb[55];
                kb[44]  <=  kb[56];
                kb[32]  <=  kb[57];
                kb[63]  <=  kb[58];
                kb[46]  <=  kb[59];
                kb[15]  <=  kb[60];
                kb[3]   <=  kb[61];
                kb[38]  <=  kb[62];
                kb[16]  <=  kb[63];
                kb[55]  <=  kb[64];
            end
        end
    end
end

always@*
begin
    case(ni[3:5])
    3'b000:     kv  =   kb[1:8];
    3'b001:     kv  =   kb[9:16];
    3'b010:     kv  =   kb[17:24];
    3'b011:     kv  =   kb[25:32];
    3'b100:     kv  =   kb[33:40];
    3'b101:     kv  =   kb[41:48];
    3'b110:     kv  =   kb[49:56];
    3'b111:     kv  =   kb[57:64];
    default:    kv  =   {8{1'b0}};
    endcase
end

assign  tmp     =   ((st_bc==bc_indata) || (st_bc==bc_outdata)) ?   (r[0:7] ^ pb)   :   (r[0:7] ^ f_box);
assign  t_box   =   key ^ tmp;
assign  perm[4] =   f_box[0];
assign  perm[7] =   f_box[1];
assign  perm[1] =   f_box[2];
assign  perm[5] =   f_box[3];
assign  perm[3] =   f_box[4];
assign  perm[2] =   f_box[5];
assign  perm[0] =   f_box[6];
assign  perm[6] =   f_box[7];
					    	
endmodule

