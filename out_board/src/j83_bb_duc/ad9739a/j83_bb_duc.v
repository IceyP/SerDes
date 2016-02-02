/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   test_ad9739a.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-06-15  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   test_ad9739a.v
    File tree    :   test_ad9739a.v
\************************************************************************************/

`timescale 1ns/100ps


module j83_bb_duc(
    rst                         ,
    
    aclk                        ,    
    dac_clk_in_p                ,                                       
    dac_clk_in_n                ,
    dac_clk_out_p               ,
    dac_clk_out_n               ,
    dac_data_out_a_p            ,
    dac_data_out_a_n            ,
    dac_data_out_b_p            ,
    dac_data_out_b_n            ,
    
    spi_csn                     ,
    spi_clk                     ,
    spi_mosi                    ,
    spi_miso                    ,
	 
	 ts_clk                      ,
//	 ts_data                     ,
	 ts_data0                    ,
    ts_data1                    ,
    ts_data2                    ,
    ts_data3                    ,
    ts_data4                    ,
    ts_data5                    ,
    ts_data6                    ,
    ts_data7                    ,
    ts_data8                    ,
    ts_data9                    ,
    ts_data10                   ,
    ts_data11                   ,
    ts_data12                   ,
    ts_data13                   ,
    ts_data14                   ,
    ts_data15                   , 

	 ts_ce                       ,
	 ts_frame                    ,
	 
	 cfg_data                    ,
	 cfg_write                   ,
	 cfg_add                     ,
    
    gpio_led
    );

parameter       U_DLY                       = 1                     ;
parameter       NOT_ENABLE                  = 1'b1                  ;
parameter       CH_ENABLE                   = 1'b0                  ;
parameter       rf_lo =476;
parameter       TOTAL_CHNL                  = 16                    ;

input                                   rst                         ;
input                                   aclk                        ;

input                                   dac_clk_in_p                ;
input                                   dac_clk_in_n                ;
output                                  dac_clk_out_p               ;
output                                  dac_clk_out_n               ;
output  [13:0]                          dac_data_out_a_p            ;
output  [13:0]                          dac_data_out_a_n            ;
output  [13:0]                          dac_data_out_b_p            ;
output  [13:0]                          dac_data_out_b_n            ;
                                        
output  [1:0]                           spi_csn                     ;   //spi_csn[0]:AD9739a;spi_csn[1]:ADF4350
output                                  spi_clk                     ;
output                                  spi_mosi                    ;
input                                   spi_miso                    ;

output  [3:0]                           gpio_led                    ;

output                                  ts_clk                      ;
input   [7:0]                           ts_data0                    ;
input   [7:0]                           ts_data1                    ;
input   [7:0]                           ts_data2                    ;
input   [7:0]                           ts_data3                    ;
input   [7:0]                           ts_data4                    ;
input   [7:0]                           ts_data5                    ;
input   [7:0]                           ts_data6                    ;
input   [7:0]                           ts_data7                    ;
input   [7:0]                           ts_data8                    ;
input   [7:0]                           ts_data9                    ;
input   [7:0]                           ts_data10                   ;
input   [7:0]                           ts_data11                   ;
input   [7:0]                           ts_data12                   ;
input   [7:0]                           ts_data13                   ;
input   [7:0]                           ts_data14                   ;
input   [7:0]                           ts_data15                   ;

output  [TOTAL_CHNL-1:0]                ts_ce                       ;
output  [TOTAL_CHNL-1:0]                ts_frame                    ;

input   [31:0]                          cfg_data                    ;
input                                   cfg_write                   ;
input   [7:0]                           cfg_add                     ;

    
reg    [13:0]                          dds_data_00                 ;
reg    [13:0]                          dds_data_01                 ;
reg    [13:0]                          dds_data_02                 ;
reg    [13:0]                          dds_data_03                 ;
reg    [13:0]                          dds_data_04                 ;
reg    [13:0]                          dds_data_05                 ;
reg    [13:0]                          dds_data_06                 ;
reg    [13:0]                          dds_data_07                 ;
reg    [13:0]                          dds_data_08                 ;
reg    [13:0]                          dds_data_09                 ;
reg    [13:0]                          dds_data_10                 ;
reg    [13:0]                          dds_data_11                 ;


wire                                    dac_div3_clk                ;

wire                                    spi_clk                     ;   //10M
wire                                    pll_lock                    ;
wire                                    clk_10m                     ;
wire                                    clk_341m                    ;

wire                                    cfg_bb0_we                  ;
wire                                    cfg_gain0_we                ;
wire                                    cfg_mixbb0_we               ;

wire    [9:0]                           bb_sym0_iq                  ;
reg                                     bb_sym0_vi                  ;

wire                                    bb0_re                      ;
wire    [3:0]                           bb0_ch                      ;
wire    [31:0]                          bb0_doa                     ;
wire                                    bb0_voa                     ;

wire    [31:0]                          gain0_dout                  ;
wire                                    gain0_vout                  ;
reg     [31:0]                          gain0_dout_1dly             ;
reg                                     gain0_vo_1dly               ;

wire    [31:0]                          mixbb0_out                  ;
wire                                    mixbb0_vo                   ;
reg     [31:0]                          mixbb0_out_1dly             ;
reg                                     mixbb0_vo_1dly              ;

wire    [13:0]                          iout_00                 ;
wire    [13:0]                          iout_01                 ;
wire    [13:0]                          iout_02                 ;
wire    [13:0]                          iout_03                 ;
wire    [13:0]                          iout_04                 ;
wire    [13:0]                          iout_05                 ;
wire    [13:0]                          iout_06                 ;
wire    [13:0]                          iout_07                 ;
wire    [13:0]                          iout_08                 ;
wire    [13:0]                          iout_09                 ;
wire    [13:0]                          iout_10                 ;
wire    [13:0]                          iout_11                 ;


reg     [13:0]                          iout_reg_00;
reg     [13:0]                          iout_reg_02;
reg     [13:0]                          iout_reg_04;
reg     [13:0]                          iout_reg_06;
reg     [13:0]                          iout_reg_08;
reg     [13:0]                          iout_reg_10;

reg     [4*TOTAL_CHNL-1:0]              j83_mode;
reg     [10*TOTAL_CHNL-1:0]             freq_word;
reg     [3*TOTAL_CHNL-1:0]              ch_ena;


wire                                    clk_102m                    ;

wire [9:0] j83_iq [TOTAL_CHNL-1:0] /*mark_debug=1*/ ;
wire [9:0] j83_iq_mux;

wire [TOTAL_CHNL-1:0] j83_ren;
wire    [7:0]                           ts_data[TOTAL_CHNL-1:0]     ;

reg [3:0] clk_div;

assign ts_data[0]=ts_data0;
assign ts_data[1]=ts_data1;
assign ts_data[2]=ts_data2;
assign ts_data[3]=ts_data3;
assign ts_data[4]=ts_data4;
assign ts_data[5]=ts_data5;
assign ts_data[6]=ts_data6;
assign ts_data[7]=ts_data7;
assign ts_data[8]=ts_data8;
assign ts_data[9]=ts_data9;
assign ts_data[10]=ts_data10;
assign ts_data[11]=ts_data11;
assign ts_data[12]=ts_data12;
assign ts_data[13]=ts_data13;
assign ts_data[14]=ts_data14;
assign ts_data[15]=ts_data15;


always@(posedge aclk or posedge aclk)
begin
	if (rst==1'b1) 
		clk_div<=4'b0;
	else
		clk_div<=clk_div+1;
end


assign  spi_clk =  clk_div[3]; //// alk/16

assign  ts_clk = clk_341m;

always@(posedge aclk or posedge rst)
begin
	if (rst==1'b1) 
		bb_sym0_vi<=1'b0;
	else
		if (cfg_write==1'b1 && cfg_add[7:4]==4'd6)
			bb_sym0_vi<=cfg_data[0];
			
end

genvar index;
generate
for(index=0;index<16;index=index+1)
begin: gen_write_regs
	always @(posedge aclk or posedge rst)
	begin : write_regs
		if (rst==1'b1)
		begin : write_regs_rst
			begin
				j83_mode[(index+1)*4-1:index*4]<=4'b0;
				freq_word[(index+1)*10-1:index*10]<=10'b0;
				ch_ena[(index+1)*3-1:index*3]<=3'b111;
			end
		end
		else
		begin
			begin
				if (cfg_write==1'b1 && cfg_add[3:0]==index)
				begin
					case (cfg_add[7:4])
					4'd0: j83_mode[(index+1)*4-1:index*4]<=cfg_data[3:0];
					4'd1: freq_word[(index+1)*10-1:index*10]<=cfg_data[9:0];
					4'd2: ch_ena[(index+1)*3-1:index*3]<=cfg_data[2:0];
					default:;
					endcase
				end
				
			end
		end
	end
end
endgenerate

spi_if u0_spi_if(
    .rst                                ( rst                       ),
    .clk                                ( spi_clk                   ),
    .spi_miso                           ( spi_miso                  ),
    .spi_csn                            ( spi_csn                   ),
    .spi_mosi                           ( spi_mosi                  )    
    );
     
cf_dac_if u0_dac_if(
    .rst                                ( rst                       ),
    .clk_341m                           ( clk_341m                  ),
    .clk_102m                           ( clk_102m                  ),
    
    .dac_clk_in_p                       ( dac_clk_in_p              ),
    .dac_clk_in_n                       ( dac_clk_in_n              ),
    .dac_clk_out_p                      ( dac_clk_out_p             ),
    .dac_clk_out_n                      ( dac_clk_out_n             ),
    .dac_data_out_a_p                   ( dac_data_out_a_p          ),
    .dac_data_out_a_n                   ( dac_data_out_a_n          ),
    .dac_data_out_b_p                   ( dac_data_out_b_p          ),
    .dac_data_out_b_n                   ( dac_data_out_b_n          ),
    
    .dac_div3_clk                       ( dac_div3_clk              ),
    .dds_data_00                        ( dds_data_00               ),
    .dds_data_01                        ( dds_data_01               ),
    .dds_data_02                        ( dds_data_02               ),
    .dds_data_03                        ( dds_data_03               ),
    .dds_data_04                        ( dds_data_04               ),
    .dds_data_05                        ( dds_data_05               ),
    .dds_data_06                        ( dds_data_06               ),
    .dds_data_07                        ( dds_data_07               ),
    .dds_data_08                        ( dds_data_08               ),
    .dds_data_09                        ( dds_data_09               ),
    .dds_data_10                        ( dds_data_10               ),
    .dds_data_11                        ( dds_data_11               ),
    
    .up_dds_enable                      ( 1'b1                      )
    );

assign  cfg_bb0_we      =   ((cfg_write==1'b1) && (cfg_add[7:4]==4'd3))  ?   1'b1    :   1'b0;
assign  cfg_gain0_we    =   ((cfg_write==1'b1) && (cfg_add[7:4]==4'd4))  ?   1'b1    :   1'b0;
assign  cfg_mixbb0_we   =   ((cfg_write==1'b1) && (cfg_add[7:4]==4'd5))  ?   1'b1    :   1'b0;


assign j83_iq_mux = j83_iq[bb0_ch];
reg bb0_vi_sync1, bb0_vi_sync2;

always@(clk_341m)
begin
	bb0_vi_sync1<=bb_sym0_vi;
	bb0_vi_sync2<=bb0_vi_sync1;
end
    
bb u0_bb(
    .PCLK                               ( aclk                      ),
    .WA                                 ( cfg_add[3:0]               ),  //channel:0-15
    .DI                                 ( cfg_data                  ),
    .WE                                 ( cfg_bb0_we                ),
    .CLK                                ( clk_341m                  ),
    .CSET                               ( 1'b0                      ),
    .RE                                 ( bb0_re                    ),
    .CH                                 ( bb0_ch                    ),
    .I                                  ( j83_iq_mux                ),
    .VI                                 ( bb0_vi_sync2              ),
    .O                                  ( bb0_doa                   ),
    .VO                                 ( bb0_voa                   )
    );		

GAIN #(
    .CHANNELS                           ( 16                        ),
    .WAWIDTH                            ( 4                         )
    )
u0_gain(
    .PCLK                               ( aclk                      ),
    .WA                                 ( cfg_add[3:0]               ),
    .WE                                 ( cfg_gain0_we              ),
    .DI                                 ( cfg_data[17:0]            ),
    .CLK                                ( clk_341m                  ),
    .I                                  ( bb0_doa                   ),
    .VI                                 ( bb0_voa                   ),
    .O                                  ( gain0_dout                ),
    .VO                                 ( gain0_vo                  )
    );

always@(posedge clk_341m or posedge rst)
begin
    if(rst==1'b1)
    begin
        gain0_dout_1dly <=  {32{1'b0}};
        gain0_vo_1dly   <=  1'b0;
    end
    else
    begin
        gain0_dout_1dly <=  gain0_dout;
        gain0_vo_1dly   <=  gain0_vo;
    end
end

MIXBB #(
    .CHANNELS                           ( 16                        ),
    .LUT_SIZE                           ( 12                        ),
    .WAWIDTH                            ( 4                         )
    )
u0_mixbb(
    .PCLK                               ( aclk                      ),
    .WA                                 ( cfg_add[3:0]               ),
    .WE                                 ( cfg_mixbb0_we             ),
    .DI                                 ( cfg_data                  ),
    .CLK                                ( clk_341m                  ),
    .I                                  ( gain0_dout_1dly           ),
    .VI                                 ( gain0_vo_1dly             ),
    .O                                  ( mixbb0_out                ),
    .VO                                 ( mixbb0_vo                 )
    );
    

always@(posedge clk_341m or posedge rst)
begin
    if(rst==1'b1)
    begin
        mixbb0_out_1dly <=  {32{1'b0}};
        mixbb0_vo_1dly  <=  1'b0;
    end
    else
    begin
        mixbb0_out_1dly <=  mixbb0_out;
        mixbb0_vo_1dly  <=  mixbb0_vo;
    end
end

  	          
duc_341mhz u0_duc(   
    .clk_1                              ( clk_341m                     ), //341MHz        
    .ce_1                               ( mixbb0_vo_1dly               ), 

    .din2                               ( 16'h0000                     ), //in3 in hbf1
    .din1                               ( mixbb0_out_1dly[31:16]       ), //in2 in hbf1 Q part
    .din5                               ( mixbb0_out_1dly[15:0]        ), //in1 in hbf1 I part

            
    .ena_b0c0                           ( ch_ena[ 0]                ),
    .ena_b0c1                           ( ch_ena[ 3]                ),
    .ena_b0c2                           ( ch_ena[ 6]                ),
    .ena_b0c3                           ( ch_ena[ 9]                ),
    .ena_b0c4                           ( ch_ena[12]                ),
    .ena_b0c5                           ( ch_ena[15]                ),
    .ena_b0c6                           ( ch_ena[18]                ),
    .ena_b0c7                           ( ch_ena[21]                ),
    .ena_b0c8                           ( ch_ena[24]                ),
    .ena_b0c9                           ( ch_ena[27]                ),
    .ena_b0c10                          ( ch_ena[30]                ),
    .ena_b0c11                          ( ch_ena[33]                ),
    .ena_b0c12                          ( ch_ena[36]                ),
    .ena_b0c13                          ( ch_ena[39]                ),
    .ena_b0c14                          ( ch_ena[42]                ),
    .ena_b0c15                          ( ch_ena[45]                ),
    .ena_b0c16                          ( NOT_ENABLE                   ),
    .ena_b0c17                          ( NOT_ENABLE                   ),
    .ena_b0c18                          ( NOT_ENABLE                   ),
    .ena_b0c19                          ( NOT_ENABLE                   ),
    .ena_b0c20                          ( NOT_ENABLE                   ),
    .ena_b0c21                          ( NOT_ENABLE                   ),
    .ena_b0c22                          ( NOT_ENABLE                   ),
    .ena_b0c23                          ( NOT_ENABLE                   ),
       
    .ena_b1c0                           ( ch_ena[ 1]                ),
    .ena_b1c1                           ( ch_ena[ 4]                ),
    .ena_b1c2                           ( ch_ena[ 7]                ),
    .ena_b1c3                           ( ch_ena[10]                ),
    .ena_b1c4                           ( ch_ena[13]                ),
    .ena_b1c5                           ( ch_ena[16]                ),
    .ena_b1c6                           ( ch_ena[19]                ),
    .ena_b1c7                           ( ch_ena[22]                ),
    .ena_b1c8                           ( ch_ena[25]                ),
    .ena_b1c9                           ( ch_ena[28]                ),
    .ena_b1c10                          ( ch_ena[31]                ),
    .ena_b1c11                          ( ch_ena[34]                ),
    .ena_b1c12                          ( ch_ena[37]                ),
    .ena_b1c13                          ( ch_ena[40]                ),
    .ena_b1c14                          ( ch_ena[43]                ),
    .ena_b1c15                          ( ch_ena[46]                ),
    .ena_b1c16                          ( NOT_ENABLE                   ),
    .ena_b1c17                          ( NOT_ENABLE                   ),
    .ena_b1c18                          ( NOT_ENABLE                   ),
    .ena_b1c19                          ( NOT_ENABLE                   ),
    .ena_b1c20                          ( NOT_ENABLE                   ),
    .ena_b1c21                          ( NOT_ENABLE                   ),
    .ena_b1c22                          ( NOT_ENABLE                   ),
    .ena_b1c23                          ( NOT_ENABLE                   ),
    
    .ena_b2c0                           ( ch_ena[ 2]                ),
    .ena_b2c1                           ( ch_ena[ 5]                ),
    .ena_b2c2                           ( ch_ena[ 8]                ),
    .ena_b2c3                           ( ch_ena[11]                ),
    .ena_b2c4                           ( ch_ena[14]                ),
    .ena_b2c5                           ( ch_ena[17]                ),
    .ena_b2c6                           ( ch_ena[20]                ),
    .ena_b2c7                           ( ch_ena[23]                ),
    .ena_b2c8                           ( ch_ena[26]                ),
    .ena_b2c9                           ( ch_ena[29]                ),
    .ena_b2c10                          ( ch_ena[32]                ),
    .ena_b2c11                          ( ch_ena[35]                ),
    .ena_b2c12                          ( ch_ena[38]                ),
    .ena_b2c13                          ( ch_ena[41]                ),
    .ena_b2c14                          ( ch_ena[44]                ),
    .ena_b2c15                          ( ch_ena[47]                ),
    .ena_b2c16                          ( NOT_ENABLE                   ),
    .ena_b2c17                          ( NOT_ENABLE                   ),
    .ena_b2c18                          ( NOT_ENABLE                   ),
    .ena_b2c19                          ( NOT_ENABLE                   ),
    .ena_b2c20                          ( NOT_ENABLE                   ),
    .ena_b2c21                          ( NOT_ENABLE                   ),
    .ena_b2c22                          ( NOT_ENABLE                   ),
    .ena_b2c23                          ( NOT_ENABLE                   ),
     
    .freq_word0                         ( freq_word[ 9: 0]                     ),   
    .freq_word1                         ( freq_word[19:10]                     ),  
    .freq_word2                         ( freq_word[29:20]                     ),  
    .freq_word3                         ( freq_word[39:30]                     ), 
    .freq_word4                         ( freq_word[49:40]                     ),  
    .freq_word5                         ( freq_word[59:50]                     ),  
    .freq_word6                         ( freq_word[69:60]                     ),  
    .freq_word7                         ( freq_word[79:70]                     ),  
    .freq_word8                         ( freq_word[89:80]                     ),  
    .freq_word9                         ( freq_word[99:90]                     ),  
    .freq_word10                        ( freq_word[109:100]                     ), 
    .freq_word11                        ( freq_word[119:110]                     ), 
    .freq_word12                        ( freq_word[129:120]                     ), 
    .freq_word13                        ( freq_word[139:130]                     ), 
    .freq_word14                        ( freq_word[149:140]                     ), 
    .freq_word15                        ( freq_word[159:150]                     ), 
	 
    .freq_word16                        ( 10'd0                     ), 
    .freq_word17                        ( 10'd0                     ), 
    .freq_word18                        ( 10'd0                     ), 
    .freq_word19                        ( 10'd0                     ),       
    .freq_word20                        ( 10'd0                     ), 
    .freq_word21                        ( 10'd0                     ), 
    .freq_word22                        ( 10'd0                     ), 
    .freq_word23                        ( 10'd0                     ), 

    .freq_word24                        ( rf_lo/4                   ), //1
    .freq_word25                        ( rf_lo/4*9                 ), //10
    .freq_word26                        ( rf_lo/4*10%1024           ), //11 
    .freq_word27                        ( rf_lo/4*11%1024           ), //12
    .freq_word28                        ( rf_lo/4                   ), //2
    .freq_word29                        ( rf_lo/4*2%1024            ), //3    
    .freq_word30                        ( rf_lo/4*3%1024            ), //4
    .freq_word31                        ( rf_lo/4*4%1024            ), //5
    .freq_word32                        ( rf_lo/4*5%1024            ), //6
    .freq_word33                        ( rf_lo/4*6%1024            ), //7
    .freq_word34                        ( rf_lo/4*7%1024            ), //8
    .freq_word35                        ( rf_lo/4*8%1024            ), //9
    
    .iout0                              ( iout_00               ),       
    .iout1                              ( iout_01               ),       
    .iout2                              ( iout_02               ),      
    .iout3                              ( iout_03               ),      
    .iout4                              ( iout_04               ),       
    .iout5                              ( iout_05               ),       
    .iout6                              ( iout_06               ),       
    .iout7                              ( iout_07               ),       
    .iout8                              ( iout_08               ),       
    .iout9                              ( iout_09               ),       
    .iout10                             ( iout_10               ),       
    .iout11                             ( iout_11               ),       
    .rst                                ( rst                       )              
    );  

reg [31:0]  clk_cnt;
reg         ms_led;
always@(posedge spi_clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        clk_cnt <=  {32{1'b0}};
    end
    else if(clk_cnt>=5000000)
    begin
        clk_cnt <=  {32{1'b0}};
    end
    else
    begin
        clk_cnt <=  clk_cnt + 32'h1;
    end
end

always@(posedge spi_clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ms_led  <=  1'b0;
    end
    else if(clk_cnt>=5000000)
    begin
        ms_led  <=  ~ms_led;
    end
end

always@(posedge clk_341m or posedge rst)
begin
  if(rst==1'b1)
    begin
      iout_reg_00<=14'b0;
      iout_reg_02<=14'b0;
      iout_reg_04<=14'b0;
      iout_reg_06<=14'b0;
      iout_reg_08<=14'b0;
      iout_reg_10<=14'b0;
    end
  else 
    begin
      iout_reg_00<=iout_00;
      iout_reg_02<=iout_02;
      iout_reg_04<=iout_04;
      iout_reg_06<=iout_06;
      iout_reg_08<=iout_08;
      iout_reg_10<=iout_10;
    end
end


reg ld_dds_data;

always@(posedge clk_341m or posedge rst)
begin
	if(rst==1'b1)
		ld_dds_data<=1'b0;
	else
	begin
		ld_dds_data<=~ld_dds_data;
		if (ld_dds_data==1'b1 )
		begin

			dds_data_00<=iout_reg_00;
			dds_data_01<=iout_reg_02;
			dds_data_02<=iout_reg_04;
			dds_data_03<=iout_reg_06;
			dds_data_04<=iout_reg_08;
			dds_data_05<=iout_reg_10;
			dds_data_06<=iout_00;
			dds_data_07<=iout_02;
			dds_data_08<=iout_04;
			dds_data_09<=iout_06;
			dds_data_10<=iout_08;
			dds_data_11<=iout_10;
		end
	end
end 

assign  gpio_led    =   {pll_lock,ms_led,1'b1,1'b0};



genvar j;
generate 

for(j=0;j<TOTAL_CHNL;j=j+1)
begin: j83

assign j83_ren[j]= bb0_ch==j ? bb0_re : 0;

J83Top mod
(.clk(clk_341m),
.rst(rst),
.ren(j83_ren[j]),
.D(ts_data[j]),
.mode(j83_mode[(j+1)*4-1:j*4]),
.ce(ts_ce[j]),
.systemce(),
.frame(ts_frame[j]),
.IQ(j83_iq[j])
);

end

endgenerate
      
endmodule