/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   stream_cipher.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-03-23  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   stream_cipher.v
    File tree    :   stream_cipher.v
\************************************************************************************/

(*use_dsp48="yes"*)
module stream_cipher(
    nrst                        ,
    clk                         ,
    pkt_eop                     ,
    ck                          ,
    ib                          ,
    pt                          ,
    buffh                       ,          
    sb                          ,
    scradd                      ,
    scwadd                      ,
    scwe                        ,
    scend                       
    );

parameter   ST_WIDTH                    = 3                         ;
parameter   sc_idle                     = 3'b001                    ,
            sc_cpdata                   = 3'b010                    ,
            sc_cb                       = 3'b100                    ;  
              
input                                   nrst                        ;
input                                   clk                         ;
input                                   pkt_eop                     ;
input   [0:63]                          ck                          ;
input   [0:7]                           ib                          ;
input   [0:7]                           pt                          ;
input                                   buffh                       ;

output  [0:7]                           sb                          ;
output  [0:8]                           scradd                      ;
output  [0:7]                           scwadd                      ;
output                                  scwe                        ;
output                                  scend                       ;

reg     [1:40]                          a                           ;
reg     [1:40]                          b                           ;
reg     [1:4]                           x                           ;
reg     [1:4]                           y                           ;
reg     [1:4]                           z                           ;
reg     [1:4]                           d                           ;
reg     [1:4]                           e                           ;
reg     [1:4]                           f                           ;
reg                                     p                           ;
reg                                     q                           ;
reg                                     r                           ;
reg                                     init                        ;
reg                                     init_d                      ;
reg     [0:1]                           step_cnt                    ;
wire    [1:4]                           t1                          ;
wire    [1:4]                           t2                          ;
wire    [1:4]                           t3                          ;
reg     [1:5]                           t4                          ;
reg     [1:4]                           in1                         ;
reg     [1:4]                           in2                         ;
reg     [1:4]                           do                          ;
reg     [1:4]                           t2o                         ;
wire    [1:4]                           bo                          ;
reg     [1:14]                          c                           ;
wire    [1:2]                           dd                          ;
reg     [ST_WIDTH - 1 : 0]              sc_st                       ;
reg     [0:7]                           cb                          ;
reg     [0:7]                           ptr                         ;
reg     [0:7]                           add                         ;
reg                                     cpd                         ;
reg     [0:3]                           init_cnt                    ;
reg                                     buffh_reg                   ;
reg     [1:5]                           vz                          ;
reg     [1:5]                           v1                          ;
reg     [1:2]                           s1                          ;
reg     [1:5]                           v2                          ;
reg     [1:2]                           s2                          ;
reg     [1:5]                           v3                          ;
reg     [1:2]                           s3                          ;
reg     [1:5]                           v4                          ;
reg     [1:2]                           s4                          ;
reg     [1:5]                           v5                          ;
reg     [1:2]                           s5                          ;
reg     [1:5]                           v6                          ;
reg     [1:2]                           s6                          ;
reg     [1:5]                           v7                          ;
reg     [1:2]                           s7                          ;

reg                                     scend                       ;

assign  scradd  =   {buffh_reg,add};
assign  scwadd  =   add;
assign  scwe    =   (((sc_st==sc_cb) && (step_cnt==2'b01) && (init_cnt!=8)) || ((sc_st==sc_cpdata) && (cpd==1'b1)))  ?   1'b1    :   1'b0;
assign  sb      =   ((init==1'b1) || (sc_st==sc_cpdata))    ?   ib  :   (cb ^ ib);
assign  t1      =   a[37:40] ^ x ^ do ^ in1;
assign  t2      =   b[25:28] ^ b[37:40] ^ y ^ in2;
assign  bo[1]   =   b[12] ^ b[23] ^ b[26] ^ b[33];
assign  bo[2]   =   b[9] ^ b[14] ^ b[24] ^ b[31];
assign  bo[3]   =   b[16] ^ b[19] ^ b[17] ^ b[30];
assign  bo[4]   =   b[11] ^ b[21] ^ b[32] ^ b[34];
assign  t3      =   e ^ z ^ bo;
assign  dd[1]   =   d[1] ^ d[2];
assign  dd[2]   =   d[3] ^ d[4];

always@(posedge clk or negedge nrst)
begin
    if(nrst==1'b0)
    begin
        sc_st       <=  sc_idle;
        scend       <=  1'b0;
        init        <=  1'b0;
        init_cnt    <=  {4{1'b0}};
        buffh_reg   <=  1'b0;
        step_cnt    <=  2'b00;
        add         <=  {8{1'b0}};
    end
    else
    begin
        case(sc_st)
        sc_idle:
        begin
            add     <=  {8{1'b0}};      //VHDL:add<=(others=>'0');????????
            init_cnt<=  {4{1'b0}};
            step_cnt<=  2'b00;
            if(pkt_eop==1'b1)
            begin
                sc_st       <=  sc_cpdata;
                cpd         <=  1'b0;
                ptr         <=  pt;
                buffh_reg   <=  buffh;
            end
        end
        sc_cpdata:
        begin
            cpd <=  ~cpd;
            if(cpd==1'b1)
            begin
                add <=  add + 'h1;
            end
            
            if(ptr>=180)
            begin
                if((add==187) && (cpd==1'b1))
                begin
                    sc_st   <=  sc_idle;
                    scend   <=  1'b1;
                end
            end
            else
            begin
                if(add==ptr)
                begin
                    sc_st   <=  sc_cb;
                    init    <=  1'b1;
                    cpd     <=  1'b0;
                end
            end
        end 
        sc_cb:
        begin
            step_cnt    <=  step_cnt + 'h1;
            if((step_cnt==2'b10) && (init_cnt!=8))
            begin
                add <=  add + 'h1;
                if(add==187)
                begin
                    sc_st   <=  sc_idle;
                    scend   <=  1'b1;
                end
            end
            
            if(step_cnt==2'b11)
            begin
                if(init_cnt!=9)
                begin
                    init_cnt    <=  init_cnt + 'h1;
                end
                
                if(init_cnt==7)
                begin
                    init    <=  1'b0;
                end
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
        cb      <=  8'h00;
        init_d  <=  1'b0;
    end
    else
    begin
        init_d  <=  init;
        if(init_d==1'b0)
        begin
            case(step_cnt)
            2'b01:  cb[0:1] <=  dd;
            2'b10:  cb[2:3] <=  dd;
            2'b11:  cb[4:5] <=  dd;
            2'b00:  cb[6:7] <=  dd;
            default:;
            endcase
        end
    end
end

always@*
begin
    vz[1]   =   1'b0;
    vz[2:5] =   z;
    if(q==1'b0)
    begin
        t4[2:5] =   e;
        t4[1]   =   r;
    end
    else
    begin
        t4      =   vz + e + r;
    end
end

always@*
begin
    if(p==1'b0)
    begin
        t2o =  t2;
    end
    else
    begin
        t2o[1]  =  t2[2];
        t2o[2]  =  t2[3];
        t2o[3]  =  t2[4];
        t2o[4]  =  t2[1];
    end
end

always@(posedge clk or negedge nrst)
begin
    if(nrst==1'b0)
    begin
        a   <=  {40{1'b0}};
        b   <=  {40{1'b0}};
        x   <=  {4{1'b0}};
        y   <=  {4{1'b0}};
        z   <=  {4{1'b0}};
        d   <=  {4{1'b0}};
        e   <=  {4{1'b0}};
        f   <=  {4{1'b0}};
        p   <=  1'b0;
        q   <=  1'b0;
        r   <=  1'b0;
    end
    else
    begin
        if((pkt_eop==1'b1) && (sc_st==sc_idle))
        begin
            a[1:32]     <=  ck[0:31];
            a[33:40]    <=  {8{1'b0}};
            b[1:32]     <=  ck[32:63];
            b[33:40]    <=  {8{1'b0}};
            x           <=  {4{1'b0}};
            y           <=  {4{1'b0}};
            z           <=  {4{1'b0}};
            d           <=  {4{1'b0}};
            e           <=  {4{1'b0}};
            f           <=  {4{1'b0}};
            p           <=  1'b0;
            q           <=  1'b0;
            r           <=  1'b0;
        end
        else if(sc_st==sc_cb)
        begin
            a[37:40]    <=  a[33:36];
            a[33:36]    <=  a[29:32];
            a[29:32]    <=  a[25:28];
            a[25:28]    <=  a[21:24];
            a[21:24]    <=  a[17:20];
            a[17:20]    <=  a[13:16];
            a[13:16]    <=  a[9:12]; 
            a[9:12]     <=  a[5:8];  
            a[5:8]      <=  a[1:4];
            a[1:4]      <=  t1;
            
            b[37:40]    <=  b[33:36];
            b[33:36]    <=  b[29:32];
            b[29:32]    <=  b[25:28];
            b[25:28]    <=  b[21:24];
            b[21:24]    <=  b[17:20];
            b[17:20]    <=  b[13:16];
            b[13:16]    <=  b[9:12]; 
            b[9:12]     <=  b[5:8];  
            b[5:8]      <=  b[1:4];
            b[1:4]      <=  t2o;
            
            d           <=  t3;
            e           <=  f;
            f           <=  t4[2:5];
            r           <=  t4[1];
            
            x           <=  c[1:4];
            y           <=  c[5:8];
            z           <=  c[9:12];
            p           <=  c[13];
            q           <=  c[14];
        end
    end
end

always@*
begin
    if(init==1'b1)
    begin
        do  =   d;
        case(step_cnt[1])
        1'b0:
        begin
            in1 =   ib[0:3];
            in2 =   ib[4:7];
        end
        1'b1:
        begin
            in2 =   ib[0:3];
            in1 =   ib[4:7];
        end
        default:
        begin
            in1 =   {4{1'b0}};
            in2 =   {4{1'b0}};
        end
        endcase
    end
    else
    begin
        do  =   {4{1'b0}};
        in1 =   {4{1'b0}};
        in2 =   {4{1'b0}};
    end
end

//------------------------------------------------------------------
//s1
//------------------------------------------------------------------
always@*
begin
    v1[1:5] =   {a[16],a[2],a[23],a[25],a[36]};
    case(v1)
    5'd0    :   s1  =   2'b10;
    5'd1    :   s1  =   2'b00;
    5'd2    :   s1  =   2'b01;
    5'd3    :   s1  =   2'b01;
    5'd4    :   s1  =   2'b10;
    5'd5    :   s1  =   2'b11;
    5'd6    :   s1  =   2'b11;
    5'd7    :   s1  =   2'b00;
    5'd8    :   s1  =   2'b11;
    5'd9    :   s1  =   2'b10;
    5'd10   :   s1  =   2'b10;
    5'd11   :   s1  =   2'b00;
    5'd12   :   s1  =   2'b01;
    5'd13   :   s1  =   2'b01;
    5'd14   :   s1  =   2'b00;
    5'd15   :   s1  =   2'b11;
    5'd16   :   s1  =   2'b00;
    5'd17   :   s1  =   2'b11;
    5'd18   :   s1  =   2'b11;
    5'd19   :   s1  =   2'b00;
    5'd20   :   s1  =   2'b10;
    5'd21   :   s1  =   2'b10;
    5'd22   :   s1  =   2'b01;
    5'd23   :   s1  =   2'b01;
    5'd24   :   s1  =   2'b10;
    5'd25   :   s1  =   2'b10;
    5'd26   :   s1  =   2'b00;
    5'd27   :   s1  =   2'b11;
    5'd28   :   s1  =   2'b01;
    5'd29   :   s1  =   2'b01;
    5'd30   :   s1  =   2'b11;
    5'd31   :   s1  =   2'b00;
    default :   s1  =   2'b00;
    endcase
    c[4]    =   s1[1];
    c[10]   =   s1[2];
end

//------------------------------------------------------------------
//s2
//------------------------------------------------------------------
always@*
begin
    v2[1:5] =   {a[7],a[10],a[21],a[28],a[35]};
    case(v2)
    5'd0    :   s2  =   2'b11;
    5'd1    :   s2  =   2'b01;
    5'd2    :   s2  =   2'b00;
    5'd3    :   s2  =   2'b10;
    5'd4    :   s2  =   2'b10;
    5'd5    :   s2  =   2'b11;
    5'd6    :   s2  =   2'b11;
    5'd7    :   s2  =   2'b00;
    5'd8    :   s2  =   2'b01;
    5'd9    :   s2  =   2'b11;
    5'd10   :   s2  =   2'b10;
    5'd11   :   s2  =   2'b01;
    5'd12   :   s2  =   2'b00;
    5'd13   :   s2  =   2'b00;
    5'd14   :   s2  =   2'b01;
    5'd15   :   s2  =   2'b10;
    5'd16   :   s2  =   2'b11;
    5'd17   :   s2  =   2'b01;
    5'd18   :   s2  =   2'b00;
    5'd19   :   s2  =   2'b11;
    5'd20   :   s2  =   2'b11;
    5'd21   :   s2  =   2'b10;
    5'd22   :   s2  =   2'b00;
    5'd23   :   s2  =   2'b10;
    5'd24   :   s2  =   2'b00;
    5'd25   :   s2  =   2'b00;
    5'd26   :   s2  =   2'b01;
    5'd27   :   s2  =   2'b10;
    5'd28   :   s2  =   2'b10;
    5'd29   :   s2  =   2'b01;
    5'd30   :   s2  =   2'b11;
    5'd31   :   s2  =   2'b01;
    default :   s2  =   2'b00;
    endcase
    c[3]    =   s2[1];
    c[9]    =   s2[2];
end

//------------------------------------------------------------------
//s3
//------------------------------------------------------------------
always@*
begin
    v3[1:5] =   {a[1],a[8],a[19],a[17],a[22]};
    case(v3)
    5'd0    :   s3  =   2'b10;
    5'd1    :   s3  =   2'b00;
    5'd2    :   s3  =   2'b01;
    5'd3    :   s3  =   2'b10;
    5'd4    :   s3  =   2'b10;
    5'd5    :   s3  =   2'b11;
    5'd6    :   s3  =   2'b11;
    5'd7    :   s3  =   2'b01;
    5'd8    :   s3  =   2'b01;
    5'd9    :   s3  =   2'b01;
    5'd10   :   s3  =   2'b00;
    5'd11   :   s3  =   2'b11;
    5'd12   :   s3  =   2'b11;
    5'd13   :   s3  =   2'b00;
    5'd14   :   s3  =   2'b10;
    5'd15   :   s3  =   2'b00;
    5'd16   :   s3  =   2'b01;
    5'd17   :   s3  =   2'b11;
    5'd18   :   s3  =   2'b00;
    5'd19   :   s3  =   2'b01;
    5'd20   :   s3  =   2'b11;
    5'd21   :   s3  =   2'b00;
    5'd22   :   s3  =   2'b10;
    5'd23   :   s3  =   2'b10;
    5'd24   :   s3  =   2'b10;
    5'd25   :   s3  =   2'b00;
    5'd26   :   s3  =   2'b01;
    5'd27   :   s3  =   2'b10;
    5'd28   :   s3  =   2'b00;
    5'd29   :   s3  =   2'b11;
    5'd30   :   s3  =   2'b11;
    5'd31   :   s3  =   2'b01;
    default :   s3  =   2'b00;
    endcase
    c[8]    =   s3[1];
    c[2]    =   s3[2];
end

//------------------------------------------------------------------
//s4
//------------------------------------------------------------------
always@*
begin
    v4[1:5] =   {a[9],a[3],a[5],a[14],a[32]};
    case(v4)
    5'd0    :   s4  =   2'b11;
    5'd1    :   s4  =   2'b01;
    5'd2    :   s4  =   2'b10;
    5'd3    :   s4  =   2'b11;
    5'd4    :   s4  =   2'b00;
    5'd5    :   s4  =   2'b10;
    5'd6    :   s4  =   2'b01;
    5'd7    :   s4  =   2'b10;
    5'd8    :   s4  =   2'b01;
    5'd9    :   s4  =   2'b10;
    5'd10   :   s4  =   2'b00;
    5'd11   :   s4  =   2'b01;
    5'd12   :   s4  =   2'b11;
    5'd13   :   s4  =   2'b00;
    5'd14   :   s4  =   2'b00;
    5'd15   :   s4  =   2'b11;
    5'd16   :   s4  =   2'b01;
    5'd17   :   s4  =   2'b00;
    5'd18   :   s4  =   2'b11;
    5'd19   :   s4  =   2'b01;
    5'd20   :   s4  =   2'b10;
    5'd21   :   s4  =   2'b11;
    5'd22   :   s4  =   2'b00;
    5'd23   :   s4  =   2'b11;
    5'd24   :   s4  =   2'b00;
    5'd25   :   s4  =   2'b11;
    5'd26   :   s4  =   2'b10;
    5'd27   :   s4  =   2'b00;
    5'd28   :   s4  =   2'b01;
    5'd29   :   s4  =   2'b10;
    5'd30   :   s4  =   2'b10;
    5'd31   :   s4  =   2'b01;
    default :   s4  =   2'b00;
    endcase
    c[7]    =   s4[1];
    c[1]    =   s4[2];
end		
		
//------------------------------------------------------------------
//s5
//------------------------------------------------------------------
always@*
begin
    v5[1:5] =   {a[18],a[13],a[24],a[31],a[34]};
    case(v5)
    5'd0    :   s5  =   2'b10;
    5'd1    :   s5  =   2'b00;
    5'd2    :   s5  =   2'b00;
    5'd3    :   s5  =   2'b01;
    5'd4    :   s5  =   2'b11;
    5'd5    :   s5  =   2'b10;
    5'd6    :   s5  =   2'b11;
    5'd7    :   s5  =   2'b10;
    5'd8    :   s5  =   2'b00;
    5'd9    :   s5  =   2'b01;
    5'd10   :   s5  =   2'b11;
    5'd11   :   s5  =   2'b11;
    5'd12   :   s5  =   2'b01;
    5'd13   :   s5  =   2'b00;
    5'd14   :   s5  =   2'b10;
    5'd15   :   s5  =   2'b01;
    5'd16   :   s5  =   2'b10;
    5'd17   :   s5  =   2'b11;
    5'd18   :   s5  =   2'b10;
    5'd19   :   s5  =   2'b00;
    5'd20   :   s5  =   2'b00;
    5'd21   :   s5  =   2'b11;
    5'd22   :   s5  =   2'b01;
    5'd23   :   s5  =   2'b01;
    5'd24   :   s5  =   2'b01;
    5'd25   :   s5  =   2'b00;
    5'd26   :   s5  =   2'b11;
    5'd27   :   s5  =   2'b10;
    5'd28   :   s5  =   2'b11;
    5'd29   :   s5  =   2'b01;
    5'd30   :   s5  =   2'b00;
    5'd31   :   s5  =   2'b10;
    default :   s5  =   2'b00;
    endcase
    c[12]   =   s5[1];
    c[6]    =   s5[2];
end						

//------------------------------------------------------------------
//s6
//------------------------------------------------------------------
always@*
begin
    v6[1:5] =   {a[11],a[15],a[20],a[26],a[33]};
    case(v6)
    5'd0    :   s6  =   2'b00;
    5'd1    :   s6  =   2'b01;
    5'd2    :   s6  =   2'b10;
    5'd3    :   s6  =   2'b11;
    5'd4    :   s6  =   2'b01;
    5'd5    :   s6  =   2'b10;
    5'd6    :   s6  =   2'b10;
    5'd7    :   s6  =   2'b00;
    5'd8    :   s6  =   2'b00;
    5'd9    :   s6  =   2'b01;
    5'd10   :   s6  =   2'b11;
    5'd11   :   s6  =   2'b00;
    5'd12   :   s6  =   2'b10;
    5'd13   :   s6  =   2'b11;
    5'd14   :   s6  =   2'b01;
    5'd15   :   s6  =   2'b11;
    5'd16   :   s6  =   2'b10;
    5'd17   :   s6  =   2'b11;
    5'd18   :   s6  =   2'b00;
    5'd19   :   s6  =   2'b10;
    5'd20   :   s6  =   2'b11;
    5'd21   :   s6  =   2'b00;
    5'd22   :   s6  =   2'b01;
    5'd23   :   s6  =   2'b01;
    5'd24   :   s6  =   2'b10;
    5'd25   :   s6  =   2'b01;
    5'd26   :   s6  =   2'b01;
    5'd27   :   s6  =   2'b10;
    5'd28   :   s6  =   2'b00;
    5'd29   :   s6  =   2'b11;
    5'd30   :   s6  =   2'b11;
    5'd31   :   s6  =   2'b00;
    default :   s6  =   2'b00;
    endcase
    c[11]   =   s6[1];
    c[5]    =   s6[2];
end								

//------------------------------------------------------------------
//s7
//------------------------------------------------------------------
always@*
begin
    v7[1:5] =   {a[6],a[12],a[27],a[30],a[29]};
    case(v7)
    5'd0    :   s7  =   2'b00;
    5'd1    :   s7  =   2'b11;
    5'd2    :   s7  =   2'b10;
    5'd3    :   s7  =   2'b10;
    5'd4    :   s7  =   2'b11;
    5'd5    :   s7  =   2'b00;
    5'd6    :   s7  =   2'b00;
    5'd7    :   s7  =   2'b01;
    5'd8    :   s7  =   2'b11;
    5'd9    :   s7  =   2'b00;
    5'd10   :   s7  =   2'b01;
    5'd11   :   s7  =   2'b11;
    5'd12   :   s7  =   2'b01;
    5'd13   :   s7  =   2'b10;
    5'd14   :   s7  =   2'b10;
    5'd15   :   s7  =   2'b01;
    5'd16   :   s7  =   2'b01;
    5'd17   :   s7  =   2'b00;
    5'd18   :   s7  =   2'b11;
    5'd19   :   s7  =   2'b11;
    5'd20   :   s7  =   2'b00;
    5'd21   :   s7  =   2'b01;
    5'd22   :   s7  =   2'b01;
    5'd23   :   s7  =   2'b10;
    5'd24   :   s7  =   2'b10;
    5'd25   :   s7  =   2'b11;
    5'd26   :   s7  =   2'b01;
    5'd27   :   s7  =   2'b00;
    5'd28   :   s7  =   2'b10;
    5'd29   :   s7  =   2'b11;
    5'd30   :   s7  =   2'b00;
    5'd31   :   s7  =   2'b10;
    default :   s7  =   2'b00;
    endcase
    c[13]   =   s7[1];
    c[14]   =   s7[2];
end
				
endmodule

