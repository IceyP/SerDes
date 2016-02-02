/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   v1.0 test_ad9739a.v
	                 v2.0 j83_bb_duc
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-06-15  huangrui/1480       1.0         IPQAM       Create
	2012-08-22  yzy                 2.0         IPQAM       add j83, bb
    ==================================================================================

\************************************************************************************/

`timescale 1ns/100ps


module qam16 #(
   parameter P_BUS_ADDR_WIDTH       = 12,
   parameter P_BUS_DATA_WIDTH       = 16
)(
    rst_sys                     ,
    pll_512m_locked             ,
    clk_j83                     ,
    rst_j83                     ,
    
    dac_clk_in_p                ,                                       
    dac_clk_in_n                ,
    dac_clk_out_p               ,
    dac_clk_out_n               ,
    dac_data_out_a_p            ,
    dac_data_out_a_n            ,
    dac_data_out_b_p            ,
    dac_data_out_b_n            ,
    
    ts_data0                    ,
    ts_data1                    ,
    ts_data2                    ,
    ts_data3                    ,
    ts_data4                    ,
    ts_data5                    ,
    ts_data6                    ,
    ts_data7                    ,

    ts_ce                       ,
    ts_frame                    ,
    
    clk_cfg                     ,
    rst_cfg                     ,
    cfg_add                     ,
    cfg_data                    ,
    cfg_write                   
);

parameter       U_DLY                   = 1                         ;
parameter       NOT_ENABLE              = 1'b1                      ;
parameter       CH_ENABLE               = 1'b0                      ;
parameter       rf_lo                   = 476                       ;
parameter       TOTAL_CHNL              = 8                         ;

input                                   rst_sys                     ;
output                                  pll_512m_locked             ;
input                                   clk_j83                     ;
input                                   rst_j83                     ;

input                                   dac_clk_in_p                ;
input                                   dac_clk_in_n                ;
output                                  dac_clk_out_p               ;
output                                  dac_clk_out_n               ;
output  [13:0]                          dac_data_out_a_p            ;
output  [13:0]                          dac_data_out_a_n            ;
output  [13:0]                          dac_data_out_b_p            ;
output  [13:0]                          dac_data_out_b_n            ;

input   [7:0]                           ts_data0                    ;
input   [7:0]                           ts_data1                    ;
input   [7:0]                           ts_data2                    ;
input   [7:0]                           ts_data3                    ;
input   [7:0]                           ts_data4                    ;
input   [7:0]                           ts_data5                    ;
input   [7:0]                           ts_data6                    ;
input   [7:0]                           ts_data7                    ;

output  [TOTAL_CHNL-1:0]                ts_ce                       ;
output  [TOTAL_CHNL-1:0]                ts_frame                    ;

//qam process lbus
input                                   clk_cfg                     ;
input                                   rst_cfg                     ;  
input   [P_BUS_ADDR_WIDTH-1:0]          cfg_add                     ;
input   [P_BUS_DATA_WIDTH-1:0]          cfg_data                    ;
input                                   cfg_write                   ;       
    
reg     [13:0]                          dds_data_00                 ;
reg     [13:0]                          dds_data_01                 ;
reg     [13:0]                          dds_data_02                 ;
reg     [13:0]                          dds_data_03                 ;
reg     [13:0]                          dds_data_04                 ;
reg     [13:0]                          dds_data_05                 ;
reg     [13:0]                          dds_data_06                 ;
reg     [13:0]                          dds_data_07                 ;
reg     [13:0]                          dds_data_08                 ;
reg     [13:0]                          dds_data_09                 ;
reg     [13:0]                          dds_data_10                 ;
reg     [13:0]                          dds_data_11                 ;

wire                                    dac_div3_clk                ;
wire                                    pll_lock                    ;
wire                                    clk_10m                     ;

(* KEEP = "TRUE" *)
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

(* KEEP = "TRUE" *)
reg                                     mixbb0_vo_1dly              ;

wire    [13:0]                          iout_00                     ;
wire    [13:0]                          iout_01                     ;
wire    [13:0]                          iout_02                     ;
wire    [13:0]                          iout_03                     ;
wire    [13:0]                          iout_04                     ;
wire    [13:0]                          iout_05                     ;
wire    [13:0]                          iout_06                     ;
wire    [13:0]                          iout_07                     ;
wire    [13:0]                          iout_08                     ;
wire    [13:0]                          iout_09                     ;
wire    [13:0]                          iout_10                     ;
wire    [13:0]                          iout_11                     ;

reg     [13:0]                          iout_reg_00                 ;
reg     [13:0]                          iout_reg_02                 ;
reg     [13:0]                          iout_reg_04                 ;
reg     [13:0]                          iout_reg_06                 ;
reg     [13:0]                          iout_reg_08                 ;
reg     [13:0]                          iout_reg_10                 ;

reg     [3:0]                           j83_mode[TOTAL_CHNL-1:0]    ;
reg     [9:0]                           freq_word[TOTAL_CHNL-1:0]   ;
reg     [TOTAL_CHNL-1:0]                ch_ena[2:0]                 ;
reg     [9:0]                           rf_freq_word[11:0]          ;
wire                                    clk_102m                    ;
wire    [9:0]                           j83_iq [TOTAL_CHNL-1:0]     ;
wire    [9:0]                           j83_iq_mux                  ;
wire    [TOTAL_CHNL-1:0]                j83_ren                     ;
wire    [7:0]                           ts_data[TOTAL_CHNL-1:0]     ;
reg     [15:0]                          temp_reg                    ;
reg                                     cfg_write_1syn              ;
reg                                     cfg_write_2syn              ;
reg                                     cfg_write_3syn              ;
reg                                     lbus_wren                   ;

(* KEEP = "TRUE" *)
wire                                    rst_duc                     ;

assign ts_data[0]=ts_data0;
assign ts_data[1]=ts_data1;
assign ts_data[2]=ts_data2;
assign ts_data[3]=ts_data3;
assign ts_data[4]=ts_data4;
assign ts_data[5]=ts_data5;
assign ts_data[6]=ts_data6;
assign ts_data[7]=ts_data7;

//clock domain synchronize
always@(posedge clk_cfg or posedge rst_cfg)
begin
	if (rst_cfg==1'b1)
	begin
	    cfg_write_1syn  <=  1'b0;
	    cfg_write_2syn  <=  1'b0;
	    cfg_write_3syn  <=  1'b0;
	    lbus_wren       <=  1'b0;
	end
	else
	begin
	    cfg_write_1syn  <=  cfg_write;
	    cfg_write_2syn  <=  cfg_write_1syn;
	    cfg_write_3syn  <=  cfg_write_2syn;
	    lbus_wren       <=  cfg_write_2syn & (~cfg_write_3syn);
	end
end

/*
0x500~0x50B	RF_RFMixFreq	[15:0]	DUC_RFMix模块频率范围设置
0x511	    RF_Mix1_MUX_SET	[15:0]	DUC_Mixer1端口使能设置
0x512	    RF_Mix2_MUX_SET	[15:0]	DUC_Mixer2端口使能设置
0x513	    RF_Mix3_MUX_SET	[15:0]	DUC_Mixer3端口使能设置
*/
always@(posedge clk_cfg or posedge rst_cfg)
begin
	if (rst_cfg==1'b1)
	begin	
		bb_sym0_vi<=1'b0;
		ch_ena[0]<=16'b0;
		ch_ena[1]<=16'b0;
		ch_ena[2]<=16'b0;
		temp_reg<=16'b0;
		rf_freq_word[0]<=10'b0;
		rf_freq_word[1]<=10'b0;
		rf_freq_word[2]<=10'b0;
		rf_freq_word[3]<=10'b0;
		rf_freq_word[4]<=10'b0;
		rf_freq_word[5]<=10'b0;
		rf_freq_word[6]<=10'b0;
		rf_freq_word[7]<=10'b0;
		rf_freq_word[8]<=10'b0;
		rf_freq_word[9]<=10'b0;
		rf_freq_word[10]<=10'b0;
		rf_freq_word[11]<=10'b0;
	end
	else
	begin
		if (lbus_wren==1'b1)
		begin
			if (cfg_add==12'h511) ch_ena[0]<=cfg_data;
			if (cfg_add==12'h512) ch_ena[1]<=cfg_data;
			if (cfg_add==12'h513) ch_ena[2]<=cfg_data;
			if (cfg_add==12'h500) rf_freq_word[0]<=cfg_data[9:0];
			if (cfg_add==12'h501) rf_freq_word[1]<=cfg_data[9:0];
			if (cfg_add==12'h502) rf_freq_word[2]<=cfg_data[9:0];
			if (cfg_add==12'h503) rf_freq_word[3]<=cfg_data[9:0];
			if (cfg_add==12'h504) rf_freq_word[4]<=cfg_data[9:0];
			if (cfg_add==12'h505) rf_freq_word[5]<=cfg_data[9:0];
			if (cfg_add==12'h506) rf_freq_word[6]<=cfg_data[9:0];
			if (cfg_add==12'h507) rf_freq_word[7]<=cfg_data[9:0];
			if (cfg_add==12'h508) rf_freq_word[8]<=cfg_data[9:0];
			if (cfg_add==12'h509) rf_freq_word[9]<=cfg_data[9:0];
			if (cfg_add==12'h50a) rf_freq_word[10]<=cfg_data[9:0];
			if (cfg_add==12'h50b) rf_freq_word[11]<=cfg_data[9:0];
			if (cfg_add[11:4]==8'h40 || cfg_add[11:4]==8'h42) temp_reg<=cfg_data;
			if (cfg_add==12'h430) bb_sym0_vi<=cfg_data[0];
		end
	end
end
/*
0x520~0x52F	RF_Mixer_FreqTrans_SET	[15:0]	DUC_Mixer频率搬移模块频率字设置
0x580~0x58F	RF_QAMMode_SET	        [15:0]	J.83模块QAM模式设置
*/
genvar index;
generate
for(index=0;index<TOTAL_CHNL;index=index+1)
begin: gen_write_regs
	always @(posedge clk_cfg or posedge rst_cfg)
	begin : write_regs
		if (rst_cfg==1'b1)
		begin : write_regs_rst
			begin
				j83_mode[index]<=4'b0;
				freq_word[index]<=10'b0;
			end
		end
		else
		begin
			begin
				if (lbus_wren==1'b1 && cfg_add[3:0]==index)
				begin
					case (cfg_add[11:4])
					8'h58: j83_mode[index]<=cfg_data[3:0];
					8'h52: freq_word[index]<=cfg_data[9:0];
					default:;
					endcase
				end				
			end
		end
	end
end
endgenerate

cf_dac_if u0_dac_if(
    .rst                                ( rst_sys                   ),
    .pll_512m_locked                    ( pll_512m_locked           ),
    .clk_341m                           ( clk_341m                  ),
    .rst_duc                            ( rst_duc                   ),
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

/*
0x400~0x40F	RF_SymRate_L_SET	[15:0]	BB模块符号率低16位设置
0x480~0x48F	RF_SymRate_H_SET	[15:0]	BB模块符号率高16位设置
0x410~0x41F	RF_BBGain_SET	    [15:0]	BB模块增益设置
0x420~0x42F	RF_BBMixFreq_L_SET	[15:0]	BB模块本振低16位设置
0x4A0~0x4AF	RF_BBMixFreq_H_SET	[15:0]	BB模块本振高16位设置
*/

assign  cfg_bb0_we      =   ((lbus_wren==1'b1) && (cfg_add[11:4]==8'h48))  ?   1'b1    :   1'b0;
assign  cfg_gain0_we    =   ((lbus_wren==1'b1) && (cfg_add[11:4]==8'h41))  ?   1'b1    :   1'b0;
assign  cfg_mixbb0_we   =   ((lbus_wren==1'b1) && (cfg_add[11:4]==8'h4a))  ?   1'b1    :   1'b0;


assign j83_iq_mux = (bb0_ch[3]==1'b0)   ?   j83_iq[bb0_ch[2:0]] :   {10{1'b0}};
reg bb0_vi_sync1, bb0_vi_sync2;

always@(posedge clk_341m or posedge rst_duc)
begin
    if(rst_duc==1'b1)
    begin
        bb0_vi_sync1    <=  1'b0;
        bb0_vi_sync2    <=  1'b0;   
    end
    else
    begin
        bb0_vi_sync1    <=  bb_sym0_vi;
        bb0_vi_sync2    <=  bb0_vi_sync1;
    end
end
    
bb u0_bb(
    .PCLK                               ( clk_cfg                   ),
    .WA                                 ( cfg_add[3:0]              ),  //channel:0-15
    .DI                                 ( {cfg_data, temp_reg}      ),
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
    .PCLK                               ( clk_cfg                   ),
    .WA                                 ( cfg_add[3:0]              ),
    .WE                                 ( cfg_gain0_we              ),
    .DI                                 ( {2'b00, cfg_data}         ),
    .CLK                                ( clk_341m                  ),
    .I                                  ( bb0_doa                   ),
    .VI                                 ( bb0_voa                   ),
    .O                                  ( gain0_dout                ),
    .VO                                 ( gain0_vo                  )
    );

always@(posedge clk_341m or posedge rst_duc)
begin
    if(rst_duc==1'b1)
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
    .PCLK                               ( clk_cfg                   ),
    .WA                                 ( cfg_add[3:0]              ),
    .WE                                 ( cfg_mixbb0_we             ),
    .DI                                 ( {cfg_data, temp_reg}      ),
    .CLK                                ( clk_341m                  ),
    .I                                  ( gain0_dout_1dly           ),
    .VI                                 ( gain0_vo_1dly             ),
    .O                                  ( mixbb0_out                ),
    .VO                                 ( mixbb0_vo                 )
    );
    
always@(posedge clk_341m or posedge rst_duc)
begin
    if(rst_duc==1'b1)
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

duc_16ch_341 u0_duc(   
    .clk_1                              ( clk_341m                  ), //341MHz
    .ce_1                               ( mixbb0_vo_1dly            ),
    .din1                               ( mixbb0_out_1dly[31:16]    ), //in2 in hbf1 I part
    .din2                               ( mixbb0_out_1dly[15:0]     ), //in1 in hbf1 Q part           
    .ena_b0c0                           ( ~ch_ena[0][ 0]            ),
    .ena_b0c1                           ( ~ch_ena[0][ 1]            ),
    .ena_b0c2                           ( ~ch_ena[0][ 2]            ),
    .ena_b0c3                           ( ~ch_ena[0][ 3]            ),
    .ena_b0c4                           ( ~ch_ena[0][ 4]            ),
    .ena_b0c5                           ( ~ch_ena[0][ 5]            ),
    .ena_b0c6                           ( ~ch_ena[0][ 6]            ),
    .ena_b0c7                           ( ~ch_ena[0][ 7]            ),
    .ena_b0c8                           ( NOT_ENABLE                ),
    .ena_b0c9                           ( NOT_ENABLE                ),
    .ena_b0c10                          ( NOT_ENABLE                ),
    .ena_b0c11                          ( NOT_ENABLE                ),
    .ena_b0c12                          ( NOT_ENABLE                ),
    .ena_b0c13                          ( NOT_ENABLE                ),
    .ena_b0c14                          ( NOT_ENABLE                ),
    .ena_b0c15                          ( NOT_ENABLE                ),
         
    .ena_b1c0                           ( ~ch_ena[1][ 0]            ),
    .ena_b1c1                           ( ~ch_ena[1][ 1]            ),
    .ena_b1c2                           ( ~ch_ena[1][ 2]            ),
    .ena_b1c3                           ( ~ch_ena[1][ 3]            ),
    .ena_b1c4                           ( ~ch_ena[1][ 4]            ),
    .ena_b1c5                           ( ~ch_ena[1][ 5]            ),
    .ena_b1c6                           ( ~ch_ena[1][ 6]            ),
    .ena_b1c7                           ( ~ch_ena[1][ 7]            ),
    .ena_b1c8                           ( NOT_ENABLE                ),
    .ena_b1c9                           ( NOT_ENABLE                ),
    .ena_b1c10                          ( NOT_ENABLE                ),
    .ena_b1c11                          ( NOT_ENABLE                ),
    .ena_b1c12                          ( NOT_ENABLE                ),
    .ena_b1c13                          ( NOT_ENABLE                ),
    .ena_b1c14                          ( NOT_ENABLE                ),
    .ena_b1c15                          ( NOT_ENABLE                ),
   
    .ena_b2c0                           ( ~ch_ena[2][ 0]            ),
    .ena_b2c1                           ( ~ch_ena[2][ 1]            ),
    .ena_b2c2                           ( ~ch_ena[2][ 2]            ),
    .ena_b2c3                           ( ~ch_ena[2][ 3]            ),
    .ena_b2c4                           ( ~ch_ena[2][ 4]            ),
    .ena_b2c5                           ( ~ch_ena[2][ 5]            ),
    .ena_b2c6                           ( ~ch_ena[2][ 6]            ),
    .ena_b2c7                           ( ~ch_ena[2][ 7]            ),
    .ena_b2c8                           ( NOT_ENABLE                ),
    .ena_b2c9                           ( NOT_ENABLE                ),
    .ena_b2c10                          ( NOT_ENABLE                ),
    .ena_b2c11                          ( NOT_ENABLE                ),
    .ena_b2c12                          ( NOT_ENABLE                ),
    .ena_b2c13                          ( NOT_ENABLE                ),
    .ena_b2c14                          ( NOT_ENABLE                ),
    .ena_b2c15                          ( NOT_ENABLE                ),
     
    .freq_word0                         ( freq_word[ 0]             ),   
    .freq_word1                         ( freq_word[ 1]             ),  
    .freq_word2                         ( freq_word[ 2]             ),  
    .freq_word3                         ( freq_word[ 3]             ), 
    .freq_word4                         ( freq_word[ 4]             ),  
    .freq_word5                         ( freq_word[ 5]             ),  
    .freq_word6                         ( freq_word[ 6]             ),  
    .freq_word7                         ( freq_word[ 7]             ),  
    .freq_word8                         ( {10{1'b0}}                ),  
    .freq_word9                         ( {10{1'b0}}                ),  
    .freq_word10                        ( {10{1'b0}}                ), 
    .freq_word11                        ( {10{1'b0}}                ), 
    .freq_word12                        ( {10{1'b0}}                ), 
    .freq_word13                        ( {10{1'b0}}                ), 
    .freq_word14                        ( {10{1'b0}}                ), 
    .freq_word15                        ( {10{1'b0}}                ), 
	 
    .freq_word24                        ( rf_freq_word[0]           ), 
    .freq_word25                        ( rf_freq_word[1]           ), 
    .freq_word26                        ( rf_freq_word[2]           ),  
    .freq_word27                        ( rf_freq_word[3]           ), 
    .freq_word28                        ( rf_freq_word[4]           ), 
    .freq_word29                        ( rf_freq_word[5]           ),     
    .freq_word30                        ( rf_freq_word[6]           ), 
    .freq_word31                        ( rf_freq_word[7]           ), 
    .freq_word32                        ( rf_freq_word[8]           ), 
    .freq_word33                        ( rf_freq_word[9]           ), 
    .freq_word34                        ( rf_freq_word[10]          ), 
    .freq_word35                        ( rf_freq_word[11]          ), 
    
    .iout0                              ( iout_00                   ),       
    .iout1                              ( iout_01                   ),       
    .iout2                              ( iout_02                   ),      
    .iout3                              ( iout_03                   ),      
    .iout4                              ( iout_04                   ),       
    .iout5                              ( iout_05                   ),       
    .iout6                              ( iout_06                   ),       
    .iout7                              ( iout_07                   ),       
    .iout8                              ( iout_08                   ),       
    .iout9                              ( iout_09                   ),       
    .iout10                             ( iout_10                   ),       
    .iout11                             ( iout_11                   ),       
    .rst                                ( rst_duc                   )              
    );
    
always@(posedge clk_341m or posedge rst_duc)
begin
  if(rst_duc==1'b1)
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

always@(posedge clk_341m or posedge rst_duc)
begin
	if(rst_duc==1'b1)
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

genvar j;
generate 
for(j=0;j<TOTAL_CHNL;j=j+1)
begin: j83

assign j83_ren[j]= ((bb0_ch[2:0]==j) && (bb0_ch[3]==1'b0))? bb0_re : 1'b0;

J83Top mod
(.clk_341m(clk_341m),
.rst_341m(rst_duc),
.clk_j83(clk_j83),
.rst_j83(rst_j83),
.ren(j83_ren[j]),
.D(ts_data[j]),
.mode(j83_mode[j]),
.ce(ts_ce[j]),
.systemce(),
.frame(ts_frame[j]),
.IQ(j83_iq[j])
);

end

endgenerate
      
endmodule
