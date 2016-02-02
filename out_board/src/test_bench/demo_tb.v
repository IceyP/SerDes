/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   demo_tb.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-24  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   demo_tb.v
    File tree    :   demo_tb.v
\************************************************************************************/

`timescale 1ps/100fs

module demo_tb;

`define FRAME_TYP [8*1359+1359+1359+8*4+4+4+8*4+4+4+1:1]
`define SIMULATION
//`define DDR_SIMULATION
//assign 01005e000401_7845c401e908_0800_4500054077fe000002117c99_c0a80f6c_eb000401_1f40_1f40_052cc453
//------------------------------------------------------------------
//ddr3
//------------------------------------------------------------------
//**************************************************************************//
// Local parameters Declarations
//**************************************************************************//
parameter   DQ_WIDTH                    = 16                        ;
parameter   DQS_WIDTH                   = 2                         ;
parameter   ROW_WIDTH                   = 13                        ;
parameter   BANK_WIDTH                  = 3                         ;
parameter   CK_WIDTH                    = 1                         ;
parameter   CKE_WIDTH                   = 1                         ;
parameter   CS_WIDTH                    = 1                         ;
parameter   nCS_PER_RANK                = 1                         ;
parameter   DM_WIDTH                    = 2                         ;
parameter   ODT_WIDTH                   = 1                         ;
parameter   ECC                         = "OFF"                     ;
localparam real TPROP_DQS          = 0.00;
                                     // Delay for DQS signal during Write Operation
localparam real TPROP_DQS_RD       = 0.00;
                     // Delay for DQS signal during Read Operation
localparam real TPROP_PCB_CTRL     = 0.00;
                     // Delay for Address and Ctrl signals
localparam real TPROP_PCB_DATA     = 0.00;
                     // Delay for data signal during Write operation
localparam real TPROP_PCB_DATA_RD  = 0.00;
                     // Delay for data signal during Read operation

localparam MEMORY_WIDTH            = 16;
localparam NUM_COMP                = DQ_WIDTH/MEMORY_WIDTH;
localparam RESET_PERIOD = 200000; //in pSec

parameter   CLKIN_PERIOD                = 8000                      ;
parameter   REFCLK_FREQ                 = 200.0                     ;
localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));

parameter   SIMULATION                  = "TRUE"                    ;
parameter   SEL_VICTIM_LINE             = 11                        ;
parameter   SIM_BYPASS_INIT_CAL         = "FAST"                    ;
//------------------------------------------------------------------
  
parameter   TB_MODE                 = "DEMO"                        ;   // "BIST" , "DEMO"
parameter   TOTAL_UDP_NUM           = 16'h052c                      ;   //8+udp data(8+7*188)

//ip length ,total length:20bytes(ip head)+UDP length(8bytes udp head+udp data)
parameter   TOTAL_IP_NUM            = TOTAL_UDP_NUM + 16'h0014      ;   //28+udp data

//MAC_ADDR
parameter   DST_MAC_ADDR            = 48'hDA0203040506              ;
parameter   SRC_MAC_ADDR            = 48'h5A0203040506              ;

//type,0x0800:IP,0x0806:ARP,0x8035:RARP
parameter   TYPE_FRM0               = 16'h0800                      ;
parameter   TYPE_FRM1               = 16'h0800                      ;
parameter   TYPE_FRM2               = 16'h0800                      ;
parameter   TYPE_FRM3               = 16'h0800                      ;

//ip version & length
parameter   IP_VER_LEN              = 8'h45                         ;
parameter   RESERVED                = 8'h00                         ;

//TTL
parameter   TTL                     = 8'h80                         ;

//protocol type,0x01:ICMP,0x02:IGMP,0x04:IPv4,0x06:TCP,0x11:UDP,0x29:IPv6
parameter   PROTOCOL_TYPE_FRM0      = 8'h11                         ;  
parameter   PROTOCOL_TYPE_FRM1      = 8'h11                         ;
parameter   PROTOCOL_TYPE_FRM2      = 8'h11                         ;
parameter   PROTOCOL_TYPE_FRM3      = 8'h11                         ;

//IP header checksum
parameter   IP_CHECK_FRM0           = 16'h0000                      ;
parameter   IP_CHECK_FRM1           = 16'h0000                      ;
parameter   IP_CHECK_FRM2           = 16'h0000                      ;
parameter   IP_CHECK_FRM3           = 16'h0000                      ;

//SRC IP ADDR
parameter   SRC_IP_FRM0             = 32'hC0A80501                  ;  
parameter   SRC_IP_FRM1             = 32'hC0A80501                  ;
parameter   SRC_IP_FRM2             = 32'hC0A80501                  ;
parameter   SRC_IP_FRM3             = 32'hC0A80501                  ;

//DST IP ADDR
parameter   DST_IP_FRM0             = 32'h11220000+32'd0            ;  
parameter   DST_IP_FRM1             = 32'h11220000+32'd1            ;
parameter   DST_IP_FRM2             = 32'h11220000+32'd510          ;
parameter   DST_IP_FRM3             = 32'h11220000+32'd511          ;

//src dst port
parameter   SRC_PORT_FRM0           = 16'hF49A                      ;
parameter   SRC_PORT_FRM1           = 16'hF49A                      ;
parameter   SRC_PORT_FRM2           = 16'hF49A                      ;
parameter   SRC_PORT_FRM3           = 16'hF49A                      ;
//parameter   DST_PORT_FRM0           = 16'h8000+16'd0                ;
//parameter   DST_PORT_FRM1           = 16'h8000+16'd1                ;
parameter   DST_PORT_FRM0           = 16'h8000+16'd0                ;
parameter   DST_PORT_FRM1           = 16'h8000+16'd1                ;
parameter   DST_PORT_FRM2           = 16'h8000+16'd510              ;
parameter   DST_PORT_FRM3           = 16'h8000+16'd511              ;

//UDP checksum
parameter   UDP_CHECK_FRM0          = 16'h0000                      ;
parameter   UDP_CHECK_FRM1          = 16'h0000                      ;
parameter   UDP_CHECK_FRM2          = 16'h0000                      ;
parameter   UDP_CHECK_FRM3          = 16'h0000                      ;


//---------------------------------------------------------------------------------------------
//local bus cfg address
//---------------------------------------------------------------------------------------------
parameter   GBE_CONN_SET                = 12'h201                   ;
parameter   GBE_LINK_STATUS             = 12'h202                   ;
parameter   GBE_PKTCNT_L                = 12'h203                   ;
parameter   GBE_PKTCNT_H                = 12'h204                   ;
parameter   GBE_BYTECNT_L               = 12'h205                   ;
parameter   GBE_BYTECNT_H               = 12'h206                   ;

parameter   GBE_DST_IP_L                = 12'h220                   ;
parameter   GBE_DST_IP_H                = 12'h221                   ;
parameter   GBE_DST_PORT                = 12'h222                   ;
parameter   GBE_PORT_INDEX              = 12'h223                   ;
parameter   GBE_UDPFILTER_SET           = 12'h224                   ;
parameter   GBE_UDPFILTER_CTRL          = 12'h225                   ;

parameter   GBE_IP_FILTER_L             = 12'h210                   ;
parameter   GBE_IP_FILTER_H             = 12'h211                   ;
parameter   GBE_IPFILTER_SET            = 12'h212                   ;

parameter   GBE_IPRX_DATA               = 12'h218                   ;
parameter   GBE_IPRX_PKTLEN             = 12'h219                   ;
parameter   GBE_IPRX_PTR_RST            = 12'h21a                   ;
parameter   GBE_IPTX_DATA               = 12'h21b                   ;
parameter   GBE_IPTX_PKTLEN             = 12'h21c                   ;

triple_mac_frame_typ frame0();
triple_mac_frame_typ frame1();
triple_mac_frame_typ frame2();
triple_mac_frame_typ frame3();

triple_mac_frame_typ rx_stimulus_working_frame();
triple_mac_frame_typ tx_monitor_working_frame();
integer m;
integer n;
integer i;

initial
begin
    //-----------------------------------------------------------------------------------------
    // Frame 0
    //-----------------------------------------------------------------------------------------
    frame0.data[0]  = DST_MAC_ADDR[47:40];  frame0.valid[0]  = 1'b1;  frame0.error[0]  = 1'b0;
    frame0.data[1]  = DST_MAC_ADDR[39:32];  frame0.valid[1]  = 1'b1;  frame0.error[1]  = 1'b0;
    frame0.data[2]  = DST_MAC_ADDR[31:24];  frame0.valid[2]  = 1'b1;  frame0.error[2]  = 1'b0;
    frame0.data[3]  = DST_MAC_ADDR[23:16];  frame0.valid[3]  = 1'b1;  frame0.error[3]  = 1'b0;
    frame0.data[4]  = DST_MAC_ADDR[15:8] ;  frame0.valid[4]  = 1'b1;  frame0.error[4]  = 1'b0;
    frame0.data[5]  = DST_MAC_ADDR[7:0]  ;  frame0.valid[5]  = 1'b1;  frame0.error[5]  = 1'b0;   
    frame0.data[6]  = SRC_MAC_ADDR[47:40];  frame0.valid[6]  = 1'b1;  frame0.error[6]  = 1'b0;
    frame0.data[7]  = SRC_MAC_ADDR[39:32];  frame0.valid[7]  = 1'b1;  frame0.error[7]  = 1'b0;
    frame0.data[8]  = SRC_MAC_ADDR[31:24];  frame0.valid[8]  = 1'b1;  frame0.error[8]  = 1'b0;
    frame0.data[9]  = SRC_MAC_ADDR[23:16];  frame0.valid[9]  = 1'b1;  frame0.error[9]  = 1'b0;
    frame0.data[10] = SRC_MAC_ADDR[15:8] ;  frame0.valid[10] = 1'b1;  frame0.error[10] = 1'b0;
    frame0.data[11] = SRC_MAC_ADDR[7:0]  ;  frame0.valid[11] = 1'b1;  frame0.error[11] = 1'b0;
    frame0.data[12] = TYPE_FRM0[15:8]    ;  frame0.valid[12] = 1'b1;  frame0.error[12] = 1'b0;
    frame0.data[13] = TYPE_FRM0[7:0]     ;  frame0.valid[13] = 1'b1;  frame0.error[13] = 1'b0;
    frame0.data[14] = IP_VER_LEN         ;  frame0.valid[14] = 1'b1;  frame0.error[14] = 1'b0;
    frame0.data[15] = RESERVED           ;  frame0.valid[15] = 1'b1;  frame0.error[15] = 1'b0;        
    frame0.data[16] = TOTAL_IP_NUM[15:8] ;  frame0.valid[16] = 1'b1;  frame0.error[16] = 1'b0;
    frame0.data[17] = TOTAL_IP_NUM[7:0]  ;  frame0.valid[17] = 1'b1;  frame0.error[17] = 1'b0;        
    frame0.data[18] = 8'h00              ;  frame0.valid[18] = 1'b1;  frame0.error[18] = 1'b0;
    frame0.data[19] = 8'h7a              ;  frame0.valid[19] = 1'b1;  frame0.error[19] = 1'b0;
    frame0.data[20] = 8'h00              ;  frame0.valid[20] = 1'b1;  frame0.error[20] = 1'b0;
    frame0.data[21] = 8'h00              ;  frame0.valid[21] = 1'b1;  frame0.error[21] = 1'b0;
    frame0.data[22] = TTL                ;  frame0.valid[22] = 1'b1;  frame0.error[22] = 1'b0;
    frame0.data[23] = PROTOCOL_TYPE_FRM0 ;  frame0.valid[23] = 1'b1;  frame0.error[23] = 1'b0;
    frame0.data[24] = IP_CHECK_FRM0[15:8];  frame0.valid[24] = 1'b1;  frame0.error[24] = 1'b0;
    frame0.data[25] = IP_CHECK_FRM0[7:0] ;  frame0.valid[25] = 1'b1;  frame0.error[25] = 1'b0;
    frame0.data[26] = SRC_IP_FRM0[31:24] ;  frame0.valid[26] = 1'b1;  frame0.error[26] = 1'b0;
    frame0.data[27] = SRC_IP_FRM0[23:16] ;  frame0.valid[27] = 1'b1;  frame0.error[27] = 1'b0;
    frame0.data[28] = SRC_IP_FRM0[15:8]  ;  frame0.valid[28] = 1'b1;  frame0.error[28] = 1'b0;
    frame0.data[29] = SRC_IP_FRM0[7:0]   ;  frame0.valid[29] = 1'b1;  frame0.error[29] = 1'b0;
    frame0.data[30] = DST_IP_FRM0[31:24] ;  frame0.valid[30] = 1'b1;  frame0.error[30] = 1'b0;
    frame0.data[31] = DST_IP_FRM0[23:16] ;  frame0.valid[31] = 1'b1;  frame0.error[31] = 1'b0;
    frame0.data[32] = DST_IP_FRM0[15:8]  ;  frame0.valid[32] = 1'b1;  frame0.error[32] = 1'b0;
    frame0.data[33] = DST_IP_FRM0[7:0]   ;  frame0.valid[33] = 1'b1;  frame0.error[33] = 1'b0;
    frame0.data[34] = SRC_PORT_FRM0[15:8];  frame0.valid[34] = 1'b1;  frame0.error[34] = 1'b0;
    frame0.data[35] = SRC_PORT_FRM0[7:0] ;  frame0.valid[35] = 1'b1;  frame0.error[35] = 1'b0;
    frame0.data[36] = DST_PORT_FRM0[15:8];  frame0.valid[36] = 1'b1;  frame0.error[36] = 1'b0;
    frame0.data[37] = DST_PORT_FRM0[7:0] ;  frame0.valid[37] = 1'b1;  frame0.error[37] = 1'b0;
    frame0.data[38] = TOTAL_UDP_NUM[15:8];  frame0.valid[38] = 1'b1;  frame0.error[38] = 1'b0;
    frame0.data[39] = TOTAL_UDP_NUM[7:0] ;  frame0.valid[39] = 1'b1;  frame0.error[39] = 1'b0;
    frame0.data[40] = UDP_CHECK_FRM0[15:8]; frame0.valid[40] = 1'b1;  frame0.error[40] = 1'b0;
    frame0.data[41] = UDP_CHECK_FRM0[7:0];  frame0.valid[41] = 1'b1;  frame0.error[41] = 1'b0;   
    //UDP data   
    for(n=0;n<7;n=n+1)
    begin
        frame0.data[42+188*n] = 8'h47;      frame0.valid[42+188*n] = 1'b1;  frame0.error[42+188*n] = 1'b0;
        frame0.data[43+188*n] = n + 1;      frame0.valid[43+188*n] = 1'b1;  frame0.error[43+188*n] = 1'b0;
        for(m=44+188*n;m<230+188*n;m=m+1)
        begin
            frame0.data[m] = 8'h00;         frame0.valid[m] = 1'b1;   frame0.error[m] = 1'b0;
        end
    end    
    frame0.data[1358] = 8'h01            ;  frame0.valid[1358] = 1'b0;frame0.error[1358] = 1'b0;
    // No error in this frame
    frame0.bad_frame  = 1'b0;


    //-----------------------------------------------------------------------------------------
    // Frame 1
    //-----------------------------------------------------------------------------------------
    frame1.data[0]  = DST_MAC_ADDR[47:40];  frame1.valid[0]  = 1'b1;  frame1.error[0]  = 1'b0;
    frame1.data[1]  = DST_MAC_ADDR[39:32];  frame1.valid[1]  = 1'b1;  frame1.error[1]  = 1'b0;
    frame1.data[2]  = DST_MAC_ADDR[31:24];  frame1.valid[2]  = 1'b1;  frame1.error[2]  = 1'b0;
    frame1.data[3]  = DST_MAC_ADDR[23:16];  frame1.valid[3]  = 1'b1;  frame1.error[3]  = 1'b0;
    frame1.data[4]  = DST_MAC_ADDR[15:8] ;  frame1.valid[4]  = 1'b1;  frame1.error[4]  = 1'b0;
    frame1.data[5]  = DST_MAC_ADDR[7:0]  ;  frame1.valid[5]  = 1'b1;  frame1.error[5]  = 1'b0;   
    frame1.data[6]  = SRC_MAC_ADDR[47:40];  frame1.valid[6]  = 1'b1;  frame1.error[6]  = 1'b0;
    frame1.data[7]  = SRC_MAC_ADDR[39:32];  frame1.valid[7]  = 1'b1;  frame1.error[7]  = 1'b0;
    frame1.data[8]  = SRC_MAC_ADDR[31:24];  frame1.valid[8]  = 1'b1;  frame1.error[8]  = 1'b0;
    frame1.data[9]  = SRC_MAC_ADDR[23:16];  frame1.valid[9]  = 1'b1;  frame1.error[9]  = 1'b0;
    frame1.data[10] = SRC_MAC_ADDR[15:8] ;  frame1.valid[10] = 1'b1;  frame1.error[10] = 1'b0;
    frame1.data[11] = SRC_MAC_ADDR[7:0]  ;  frame1.valid[11] = 1'b1;  frame1.error[11] = 1'b0;
    frame1.data[12] = TYPE_FRM1[15:8]    ;  frame1.valid[12] = 1'b1;  frame1.error[12] = 1'b0;
    frame1.data[13] = TYPE_FRM1[7:0]     ;  frame1.valid[13] = 1'b1;  frame1.error[13] = 1'b0;
    frame1.data[14] = IP_VER_LEN         ;  frame1.valid[14] = 1'b1;  frame1.error[14] = 1'b0;
    frame1.data[15] = RESERVED           ;  frame1.valid[15] = 1'b1;  frame1.error[15] = 1'b0;        
    frame1.data[16] = TOTAL_IP_NUM[15:8] ;  frame1.valid[16] = 1'b1;  frame1.error[16] = 1'b0;
    frame1.data[17] = TOTAL_IP_NUM[7:0]  ;  frame1.valid[17] = 1'b1;  frame1.error[17] = 1'b0;        
    frame1.data[18] = 8'h00              ;  frame1.valid[18] = 1'b1;  frame1.error[18] = 1'b0;
    frame1.data[19] = 8'h7a              ;  frame1.valid[19] = 1'b1;  frame1.error[19] = 1'b0;
    frame1.data[20] = 8'h00              ;  frame1.valid[20] = 1'b1;  frame1.error[20] = 1'b0;
    frame1.data[21] = 8'h00              ;  frame1.valid[21] = 1'b1;  frame1.error[21] = 1'b0;
    frame1.data[22] = TTL                ;  frame1.valid[22] = 1'b1;  frame1.error[22] = 1'b0;
    frame1.data[23] = PROTOCOL_TYPE_FRM1 ;  frame1.valid[23] = 1'b1;  frame1.error[23] = 1'b0;
    frame1.data[24] = IP_CHECK_FRM1[15:8];  frame1.valid[24] = 1'b1;  frame1.error[24] = 1'b0;
    frame1.data[25] = IP_CHECK_FRM1[7:0] ;  frame1.valid[25] = 1'b1;  frame1.error[25] = 1'b0;
    frame1.data[26] = SRC_IP_FRM1[31:24] ;  frame1.valid[26] = 1'b1;  frame1.error[26] = 1'b0;
    frame1.data[27] = SRC_IP_FRM1[23:16] ;  frame1.valid[27] = 1'b1;  frame1.error[27] = 1'b0;
    frame1.data[28] = SRC_IP_FRM1[15:8]  ;  frame1.valid[28] = 1'b1;  frame1.error[28] = 1'b0;
    frame1.data[29] = SRC_IP_FRM1[7:0]   ;  frame1.valid[29] = 1'b1;  frame1.error[29] = 1'b0;
    frame1.data[30] = DST_IP_FRM1[31:24] ;  frame1.valid[30] = 1'b1;  frame1.error[30] = 1'b0;
    frame1.data[31] = DST_IP_FRM1[23:16] ;  frame1.valid[31] = 1'b1;  frame1.error[31] = 1'b0;
    frame1.data[32] = DST_IP_FRM1[15:8]  ;  frame1.valid[32] = 1'b1;  frame1.error[32] = 1'b0;
    frame1.data[33] = DST_IP_FRM1[7:0]   ;  frame1.valid[33] = 1'b1;  frame1.error[33] = 1'b0;
    frame1.data[34] = SRC_PORT_FRM1[15:8];  frame1.valid[34] = 1'b1;  frame1.error[34] = 1'b0;
    frame1.data[35] = SRC_PORT_FRM1[7:0] ;  frame1.valid[35] = 1'b1;  frame1.error[35] = 1'b0;
    frame1.data[36] = DST_PORT_FRM1[15:8];  frame1.valid[36] = 1'b1;  frame1.error[36] = 1'b0;
    frame1.data[37] = DST_PORT_FRM1[7:0] ;  frame1.valid[37] = 1'b1;  frame1.error[37] = 1'b0;
    frame1.data[38] = TOTAL_UDP_NUM[15:8];  frame1.valid[38] = 1'b1;  frame1.error[38] = 1'b0;
    frame1.data[39] = TOTAL_UDP_NUM[7:0] ;  frame1.valid[39] = 1'b1;  frame1.error[39] = 1'b0;
    frame1.data[40] = UDP_CHECK_FRM1[15:8]; frame1.valid[40] = 1'b1;  frame1.error[40] = 1'b0;
    frame1.data[41] = UDP_CHECK_FRM1[7:0];  frame1.valid[41] = 1'b1;  frame1.error[41] = 1'b0;
    for(n=0;n<7;n=n+1)
    begin
        frame1.data[42+188*n] = 8'h47;      frame1.valid[42+188*n] = 1'b1;  frame1.error[42+188*n] = 1'b0;
        frame1.data[43+188*n] = n + 1;      frame1.valid[43+188*n] = 1'b1;  frame1.error[43+188*n] = 1'b0;
        for(m=44+188*n;m<230+188*n;m=m+1)
        begin
            frame1.data[m] = 8'h11;  frame1.valid[m] = 1'b1;  frame1.error[m] = 1'b0;
        end
    end
    
    frame1.data[1358] = 8'h01;  frame1.valid[1358] = 1'b0;  frame1.error[1358] = 1'b0;

    // No error in this frame
    frame1.bad_frame  = 1'b0;
    
    

    //-----------------------------------------------------------------------------------------
    // Frame 2
    //-----------------------------------------------------------------------------------------
    frame2.data[0]  = DST_MAC_ADDR[47:40];  frame2.valid[0]  = 1'b1;  frame2.error[0]  = 1'b0;
    frame2.data[1]  = DST_MAC_ADDR[39:32];  frame2.valid[1]  = 1'b1;  frame2.error[1]  = 1'b0;
    frame2.data[2]  = DST_MAC_ADDR[31:24];  frame2.valid[2]  = 1'b1;  frame2.error[2]  = 1'b0;
    frame2.data[3]  = DST_MAC_ADDR[23:16];  frame2.valid[3]  = 1'b1;  frame2.error[3]  = 1'b0;
    frame2.data[4]  = DST_MAC_ADDR[15:8] ;  frame2.valid[4]  = 1'b1;  frame2.error[4]  = 1'b0;
    frame2.data[5]  = DST_MAC_ADDR[7:0]  ;  frame2.valid[5]  = 1'b1;  frame2.error[5]  = 1'b0;   
    frame2.data[6]  = SRC_MAC_ADDR[47:40];  frame2.valid[6]  = 1'b1;  frame2.error[6]  = 1'b0;
    frame2.data[7]  = SRC_MAC_ADDR[39:32];  frame2.valid[7]  = 1'b1;  frame2.error[7]  = 1'b0;
    frame2.data[8]  = SRC_MAC_ADDR[31:24];  frame2.valid[8]  = 1'b1;  frame2.error[8]  = 1'b0;
    frame2.data[9]  = SRC_MAC_ADDR[23:16];  frame2.valid[9]  = 1'b1;  frame2.error[9]  = 1'b0;
    frame2.data[10] = SRC_MAC_ADDR[15:8] ;  frame2.valid[10] = 1'b1;  frame2.error[10] = 1'b0;
    frame2.data[11] = SRC_MAC_ADDR[7:0]  ;  frame2.valid[11] = 1'b1;  frame2.error[11] = 1'b0;
    frame2.data[12] = TYPE_FRM2[15:8]    ;  frame2.valid[12] = 1'b1;  frame2.error[12] = 1'b0;
    frame2.data[13] = TYPE_FRM2[7:0]     ;  frame2.valid[13] = 1'b1;  frame2.error[13] = 1'b0;
    frame2.data[14] = IP_VER_LEN         ;  frame2.valid[14] = 1'b1;  frame2.error[14] = 1'b0;
    frame2.data[15] = RESERVED           ;  frame2.valid[15] = 1'b1;  frame2.error[15] = 1'b0;        
    frame2.data[16] = TOTAL_IP_NUM[15:8] ;  frame2.valid[16] = 1'b1;  frame2.error[16] = 1'b0;
    frame2.data[17] = TOTAL_IP_NUM[7:0]  ;  frame2.valid[17] = 1'b1;  frame2.error[17] = 1'b0;        
    frame2.data[18] = 8'h00              ;  frame2.valid[18] = 1'b1;  frame2.error[18] = 1'b0;
    frame2.data[19] = 8'h7a              ;  frame2.valid[19] = 1'b1;  frame2.error[19] = 1'b0;
    frame2.data[20] = 8'h00              ;  frame2.valid[20] = 1'b1;  frame2.error[20] = 1'b0;
    frame2.data[21] = 8'h00              ;  frame2.valid[21] = 1'b1;  frame2.error[21] = 1'b0;
    frame2.data[22] = TTL                ;  frame2.valid[22] = 1'b1;  frame2.error[22] = 1'b0;
    frame2.data[23] = PROTOCOL_TYPE_FRM2 ;  frame2.valid[23] = 1'b1;  frame2.error[23] = 1'b0;
    frame2.data[24] = IP_CHECK_FRM2[15:8];  frame2.valid[24] = 1'b1;  frame2.error[24] = 1'b0;
    frame2.data[25] = IP_CHECK_FRM2[7:0] ;  frame2.valid[25] = 1'b1;  frame2.error[25] = 1'b0;
    frame2.data[26] = SRC_IP_FRM2[31:24] ;  frame2.valid[26] = 1'b1;  frame2.error[26] = 1'b0;
    frame2.data[27] = SRC_IP_FRM2[23:16] ;  frame2.valid[27] = 1'b1;  frame2.error[27] = 1'b0;
    frame2.data[28] = SRC_IP_FRM2[15:8]  ;  frame2.valid[28] = 1'b1;  frame2.error[28] = 1'b0;
    frame2.data[29] = SRC_IP_FRM2[7:0]   ;  frame2.valid[29] = 1'b1;  frame2.error[29] = 1'b0;
    frame2.data[30] = DST_IP_FRM2[31:24] ;  frame2.valid[30] = 1'b1;  frame2.error[30] = 1'b0;
    frame2.data[31] = DST_IP_FRM2[23:16] ;  frame2.valid[31] = 1'b1;  frame2.error[31] = 1'b0;
    frame2.data[32] = DST_IP_FRM2[15:8]  ;  frame2.valid[32] = 1'b1;  frame2.error[32] = 1'b0;
    frame2.data[33] = DST_IP_FRM2[7:0]   ;  frame2.valid[33] = 1'b1;  frame2.error[33] = 1'b0;
    frame2.data[34] = SRC_PORT_FRM2[15:8];  frame2.valid[34] = 1'b1;  frame2.error[34] = 1'b0;
    frame2.data[35] = SRC_PORT_FRM2[7:0] ;  frame2.valid[35] = 1'b1;  frame2.error[35] = 1'b0;
    frame2.data[36] = DST_PORT_FRM2[15:8];  frame2.valid[36] = 1'b1;  frame2.error[36] = 1'b0;
    frame2.data[37] = DST_PORT_FRM2[7:0] ;  frame2.valid[37] = 1'b1;  frame2.error[37] = 1'b0;
    frame2.data[38] = TOTAL_UDP_NUM[15:8];  frame2.valid[38] = 1'b1;  frame2.error[38] = 1'b0;
    frame2.data[39] = TOTAL_UDP_NUM[7:0] ;  frame2.valid[39] = 1'b1;  frame2.error[39] = 1'b0;
    frame2.data[40] = UDP_CHECK_FRM2[15:8]; frame2.valid[40] = 1'b1;  frame2.error[40] = 1'b0;
    frame2.data[41] = UDP_CHECK_FRM2[7:0];  frame2.valid[41] = 1'b1;  frame2.error[41] = 1'b0;
    for(n=0;n<7;n=n+1)
    begin
        frame2.data[42+188*n] = 8'h47;      frame2.valid[42+188*n] = 1'b1;  frame2.error[42+188*n] = 1'b0;
        frame2.data[43+188*n] = n + 1;      frame2.valid[43+188*n] = 1'b1;  frame2.error[43+188*n] = 1'b0;
        for(m=44+188*n;m<230+188*n;m=m+1)
        begin
            frame2.data[m] = 8'h22;  frame2.valid[m] = 1'b1;  frame2.error[m] = 1'b0;
        end
    end
    
    frame2.data[1358] = 8'h01;  frame2.valid[1358] = 1'b0;  frame2.error[1358] = 1'b0;

    // No error in this frame
    frame2.bad_frame  = 1'b0;


    //-----------------------------------------------------------------------------------------
    // Frame 3
    //-----------------------------------------------------------------------------------------
    frame3.data[0]  = DST_MAC_ADDR[47:40];  frame3.valid[0]  = 1'b1;  frame3.error[0]  = 1'b0;
    frame3.data[1]  = DST_MAC_ADDR[39:32];  frame3.valid[1]  = 1'b1;  frame3.error[1]  = 1'b0;
    frame3.data[2]  = DST_MAC_ADDR[31:24];  frame3.valid[2]  = 1'b1;  frame3.error[2]  = 1'b0;
    frame3.data[3]  = DST_MAC_ADDR[23:16];  frame3.valid[3]  = 1'b1;  frame3.error[3]  = 1'b0;
    frame3.data[4]  = DST_MAC_ADDR[15:8] ;  frame3.valid[4]  = 1'b1;  frame3.error[4]  = 1'b0;
    frame3.data[5]  = DST_MAC_ADDR[7:0]  ;  frame3.valid[5]  = 1'b1;  frame3.error[5]  = 1'b0;   
    frame3.data[6]  = SRC_MAC_ADDR[47:40];  frame3.valid[6]  = 1'b1;  frame3.error[6]  = 1'b0;
    frame3.data[7]  = SRC_MAC_ADDR[39:32];  frame3.valid[7]  = 1'b1;  frame3.error[7]  = 1'b0;
    frame3.data[8]  = SRC_MAC_ADDR[31:24];  frame3.valid[8]  = 1'b1;  frame3.error[8]  = 1'b0;
    frame3.data[9]  = SRC_MAC_ADDR[23:16];  frame3.valid[9]  = 1'b1;  frame3.error[9]  = 1'b0;
    frame3.data[10] = SRC_MAC_ADDR[15:8] ;  frame3.valid[10] = 1'b1;  frame3.error[10] = 1'b0;
    frame3.data[11] = SRC_MAC_ADDR[7:0]  ;  frame3.valid[11] = 1'b1;  frame3.error[11] = 1'b0;
    frame3.data[12] = TYPE_FRM3[15:8]    ;  frame3.valid[12] = 1'b1;  frame3.error[12] = 1'b0;
    frame3.data[13] = TYPE_FRM3[7:0]     ;  frame3.valid[13] = 1'b1;  frame3.error[13] = 1'b0;
    frame3.data[14] = IP_VER_LEN         ;  frame3.valid[14] = 1'b1;  frame3.error[14] = 1'b0;
    frame3.data[15] = RESERVED           ;  frame3.valid[15] = 1'b1;  frame3.error[15] = 1'b0;        
    frame3.data[16] = TOTAL_IP_NUM[15:8] ;  frame3.valid[16] = 1'b1;  frame3.error[16] = 1'b0;
    frame3.data[17] = TOTAL_IP_NUM[7:0]  ;  frame3.valid[17] = 1'b1;  frame3.error[17] = 1'b0;        
    frame3.data[18] = 8'h00              ;  frame3.valid[18] = 1'b1;  frame3.error[18] = 1'b0;
    frame3.data[19] = 8'h7a              ;  frame3.valid[19] = 1'b1;  frame3.error[19] = 1'b0;
    frame3.data[20] = 8'h00              ;  frame3.valid[20] = 1'b1;  frame3.error[20] = 1'b0;
    frame3.data[21] = 8'h00              ;  frame3.valid[21] = 1'b1;  frame3.error[21] = 1'b0;
    frame3.data[22] = TTL                ;  frame3.valid[22] = 1'b1;  frame3.error[22] = 1'b0;
    frame3.data[23] = PROTOCOL_TYPE_FRM3 ;  frame3.valid[23] = 1'b1;  frame3.error[23] = 1'b0;
    frame3.data[24] = IP_CHECK_FRM3[15:8];  frame3.valid[24] = 1'b1;  frame3.error[24] = 1'b0;
    frame3.data[25] = IP_CHECK_FRM3[7:0] ;  frame3.valid[25] = 1'b1;  frame3.error[25] = 1'b0;
    frame3.data[26] = SRC_IP_FRM3[31:24] ;  frame3.valid[26] = 1'b1;  frame3.error[26] = 1'b0;
    frame3.data[27] = SRC_IP_FRM3[23:16] ;  frame3.valid[27] = 1'b1;  frame3.error[27] = 1'b0;
    frame3.data[28] = SRC_IP_FRM3[15:8]  ;  frame3.valid[28] = 1'b1;  frame3.error[28] = 1'b0;
    frame3.data[29] = SRC_IP_FRM3[7:0]   ;  frame3.valid[29] = 1'b1;  frame3.error[29] = 1'b0;
    frame3.data[30] = DST_IP_FRM3[31:24] ;  frame3.valid[30] = 1'b1;  frame3.error[30] = 1'b0;
    frame3.data[31] = DST_IP_FRM3[23:16] ;  frame3.valid[31] = 1'b1;  frame3.error[31] = 1'b0;
    frame3.data[32] = DST_IP_FRM3[15:8]  ;  frame3.valid[32] = 1'b1;  frame3.error[32] = 1'b0;
    frame3.data[33] = DST_IP_FRM3[7:0]   ;  frame3.valid[33] = 1'b1;  frame3.error[33] = 1'b0;
    frame3.data[34] = SRC_PORT_FRM3[15:8];  frame3.valid[34] = 1'b1;  frame3.error[34] = 1'b0;
    frame3.data[35] = SRC_PORT_FRM3[7:0] ;  frame3.valid[35] = 1'b1;  frame3.error[35] = 1'b0;
    frame3.data[36] = DST_PORT_FRM3[15:8];  frame3.valid[36] = 1'b1;  frame3.error[36] = 1'b0;
    frame3.data[37] = DST_PORT_FRM3[7:0] ;  frame3.valid[37] = 1'b1;  frame3.error[37] = 1'b0;
    frame3.data[38] = TOTAL_UDP_NUM[15:8];  frame3.valid[38] = 1'b1;  frame3.error[38] = 1'b0;
    frame3.data[39] = TOTAL_UDP_NUM[7:0] ;  frame3.valid[39] = 1'b1;  frame3.error[39] = 1'b0;
    frame3.data[40] = UDP_CHECK_FRM3[15:8]; frame3.valid[40] = 1'b1;  frame3.error[40] = 1'b0;
    frame3.data[41] = UDP_CHECK_FRM3[7:0];  frame3.valid[41] = 1'b1;  frame3.error[41] = 1'b0;
    for(n=0;n<7;n=n+1)
    begin
        frame3.data[42+188*n] = 8'h47;      frame3.valid[42+188*n] = 1'b1;  frame3.error[42+188*n] = 1'b0;
        frame3.data[43+188*n] = n + 1;      frame3.valid[43+188*n] = 1'b1;  frame3.error[43+188*n] = 1'b0;
        for(m=44+188*n;m<230+188*n;m=m+1)
        begin
            frame3.data[m] = 8'h33;  frame3.valid[m] = 1'b1;  frame3.error[m] = 1'b0;
        end
    end
    
    frame3.data[1358] = 8'h01;  frame3.valid[1358] = 1'b0;  frame3.error[1358] = 1'b0;

    // No error in this frame
    frame3.bad_frame  = 1'b0;
end


//---------------------------------------------------------------------------------------------
// CRC engine
//---------------------------------------------------------------------------------------------
task calc_crc;
    input  [7:0]  data;
    inout  [31:0] fcs;
    
    reg [31:0] crc;
    reg        crc_feedback;
    integer    I;
    begin
        crc = ~ fcs;
        for (I = 0; I < 8; I = I + 1)
        begin
            crc_feedback = crc[0] ^ data[I];
            crc[0]       = crc[1];
            crc[1]       = crc[2];
            crc[2]       = crc[3];
            crc[3]       = crc[4];
            crc[4]       = crc[5];
            crc[5]       = crc[6]  ^ crc_feedback;
            crc[6]       = crc[7];
            crc[7]       = crc[8];
            crc[8]       = crc[9]  ^ crc_feedback;
            crc[9]       = crc[10] ^ crc_feedback;
            crc[10]      = crc[11];
            crc[11]      = crc[12];
            crc[12]      = crc[13];
            crc[13]      = crc[14];
            crc[14]      = crc[15];
            crc[15]      = crc[16] ^ crc_feedback;
            crc[16]      = crc[17];
            crc[17]      = crc[18];
            crc[18]      = crc[19];
            crc[19]      = crc[20] ^ crc_feedback;
            crc[20]      = crc[21] ^ crc_feedback;
            crc[21]      = crc[22] ^ crc_feedback;
            crc[22]      = crc[23];
            crc[23]      = crc[24] ^ crc_feedback;
            crc[24]      = crc[25] ^ crc_feedback;
            crc[25]      = crc[26];
            crc[26]      = crc[27] ^ crc_feedback;
            crc[27]      = crc[28] ^ crc_feedback;
            crc[28]      = crc[29];
            crc[29]      = crc[30] ^ crc_feedback;
            crc[30]      = crc[31] ^ crc_feedback;
            crc[31]      =           crc_feedback;
        end
    // return the CRC result
    fcs = ~ crc;
    end
endtask // calc_crc




//---------------------------------------------------------------------------------------------
// Test Bench signals and constants
//---------------------------------------------------------------------------------------------

// Delay to provide setup and hold timing at the GMII/RGMII.
parameter   dly                         = 2000                      ;  // 2000 ps
parameter   gtx_period                  = 2500                      ;  // ps

// testbench signals
reg                                     clk_25m                     ;
reg                                     clk_27m                     ;
reg                                     gtx_clk                     ;
reg                                     reset                       ;
reg                                     rgmii_rxc                   ;
reg                                     rgmii_rx_ctl                ;
reg     [3:0]                           rgmii_rxd                   ;
reg     [15:0]                          lbus_addr                   ;
reg     [15:0]                          lbus_wdata                  ;
reg                                     lbus_cs_n                   ;
reg                                     lbus_oe_n                   ;
reg                                     lbus_we_n                   ;
reg     [5:0]                           mdio_count                  ;
reg                                     last_mdio                   ;
reg                                     mdio_read                   ;
reg                                     mdio_addr                   ;
reg                                     mdio_fail                   ;
reg                                     tx_monitor_finished_1G      ;
reg                                     management_config_finished  ;

wire                                    rstn_phymain                ;
wire                                    rstn_phybackup              ;
wire    [3:0]                           phy_main_rgmii_txd          ;
wire                                    phy_main_rgmii_tx_ctl       ;
wire                                    phy_main_rgmii_txc          ;
wire    [3:0]                           phy_backup_rgmii_txd        ;
wire                                    phy_backup_rgmii_tx_ctl     ;
wire                                    phy_backup_rgmii_txc        ;
wire                                    phy_main_mdc                ;
wire                                    phy_backup_mdc              ;

wire    [15:0]                          lbus_data                   ;
//wire    [15:0]                          lbus_rdata                  ;

wire                                    lbus_wait_n                 ;
wire    [3:0]                           gpio_led                    ;
wire                                    delay_rxc_lcl               ;
wire    [3:0]                           phy_main_rgmii_rxd          ;
wire                                    phy_main_rgmii_rx_ctl       ;
wire                                    phy_main_rgmii_rxc          ; 
wire    [3:0]                           phy_backup_rgmii_rxd        ;
wire                                    phy_backup_rgmii_rx_ctl     ;
wire                                    phy_backup_rgmii_rxc        ;                                        
wire                                    mdc                         ;
wire                                    mdio                        ;
wire                                    rgmii_txc                   ;
wire                                    rgmii_tx_ctl                ;
wire    [3:0]                           rgmii_txd                   ;
wire                                    clk_cfg                     ;
wire                                    rstn_cfg                    ;
wire                                    ddr3_user_clk               ;
wire                                    ddr3_user_rst               ;
reg     [15:0]                          ip_filter_pkt_len           ;
reg     [15:0]                          ip_filter_data              ;
reg     [31:0]                          gbe_rx_pktcnt               ;
reg     [31:0]                          gbe_rx_bytecnt              ;

//------------------------------------------------------------------
//ddr3
//------------------------------------------------------------------
wire                                    ddr3_reset_n                ;
wire    [DQ_WIDTH-1:0]                  ddr3_dq_fpga                ;
wire    [DQS_WIDTH-1:0]                 ddr3_dqs_p_fpga             ;
wire    [DQS_WIDTH-1:0]                 ddr3_dqs_n_fpga             ;
wire    [ROW_WIDTH-1:0]                 ddr3_addr_fpga              ;
wire    [BANK_WIDTH-1:0]                ddr3_ba_fpga                ;
wire                                    ddr3_ras_n_fpga             ;
wire                                    ddr3_cas_n_fpga             ;
wire                                    ddr3_we_n_fpga              ;
wire    [CKE_WIDTH-1:0]                 ddr3_cke_fpga               ;
wire    [CK_WIDTH-1:0]                  ddr3_ck_p_fpga              ;
wire    [CK_WIDTH-1:0]                  ddr3_ck_n_fpga              ;
wire                                    init_calib_complete         ;
wire                                    tg_compare_error            ;
wire    [(CS_WIDTH*nCS_PER_RANK)-1:0]   ddr3_cs_n_fpga              ;                                       
wire    [DM_WIDTH-1:0]                  ddr3_dm_fpga                ;                                      
wire    [ODT_WIDTH-1:0]                 ddr3_odt_fpga               ;
reg     [(CS_WIDTH*nCS_PER_RANK)-1:0]   ddr3_cs_n_sdram_tmp         ;        
reg     [DM_WIDTH-1:0]                  ddr3_dm_sdram_tmp           ;       
reg     [ODT_WIDTH-1:0]                 ddr3_odt_sdram_tmp          ;
wire    [DQ_WIDTH-1:0]                  ddr3_dq_sdram               ;
reg     [ROW_WIDTH-1:0]                 ddr3_addr_sdram             ;
reg     [BANK_WIDTH-1:0]                ddr3_ba_sdram               ;
reg                                     ddr3_ras_n_sdram            ;
reg                                     ddr3_cas_n_sdram            ;
reg                                     ddr3_we_n_sdram             ;
wire    [(CS_WIDTH*nCS_PER_RANK)-1:0]   ddr3_cs_n_sdram             ;
wire    [ODT_WIDTH-1:0]                 ddr3_odt_sdram              ;
reg     [CKE_WIDTH-1:0]                 ddr3_cke_sdram              ;
wire    [DM_WIDTH-1:0]                  ddr3_dm_sdram               ;
wire    [DQS_WIDTH-1:0]                 ddr3_dqs_p_sdram            ;
wire    [DQS_WIDTH-1:0]                 ddr3_dqs_n_sdram            ;
reg     [CK_WIDTH-1:0]                  ddr3_ck_p_sdram             ;
reg     [CK_WIDTH-1:0]                  ddr3_ck_n_sdram             ;
wire                                    sys_rst_n                   ;
reg                                     sys_clk_i                   ;
reg                                     clk_ref_i                   ;
wire                                    sys_rst                     ;
reg                                     lbus_cfg_finished           ;
  
assign          sys_rst_n               =   ~reset;
assign          sys_rst                 =   sys_rst_n;
assign          phy_main_rgmii_txd      =   rgmii_txd;
assign          phy_main_rgmii_txc      =   rgmii_txc;
assign          phy_main_rgmii_tx_ctl   =   rgmii_tx_ctl;

assign  #2000   delay_rxc_lcl           =   rgmii_rxc;

assign          phy_main_rgmii_rxc      =   (TB_MODE == "BIST") ? phy_main_rgmii_txc     : delay_rxc_lcl;
assign          phy_main_rgmii_rxd      =   (TB_MODE == "BIST") ? phy_main_rgmii_txd     : rgmii_rxd;
assign          phy_main_rgmii_rx_ctl   =   (TB_MODE == "BIST") ? phy_main_rgmii_tx_ctl  : rgmii_rx_ctl;

assign          phy_backup_rgmii_rxc    =   (TB_MODE == "BIST") ? phy_backup_rgmii_txc   : delay_rxc_lcl;
assign          phy_backup_rgmii_rxd    =   (TB_MODE == "BIST") ? phy_backup_rgmii_txd   : rgmii_rxd;
assign          phy_backup_rgmii_rx_ctl =   (TB_MODE == "BIST") ? phy_backup_rgmii_tx_ctl: rgmii_rx_ctl;

assign          mdc                     =   phy_main_mdc;

//------------------------------------------------------------------
//ddr3
//------------------------------------------------------------------
//initial 
//begin
//    sys_rst_n = 1'b0;
//    #RESET_PERIOD
//    sys_rst_n = 1'b1;
//end

initial
    sys_clk_i = 1'b0;
always
    sys_clk_i = #(CLKIN_PERIOD/2.0) ~sys_clk_i;


initial
    clk_ref_i = 1'b0;
always
    clk_ref_i = #REFCLK_PERIOD ~clk_ref_i;
       
always @( * ) begin
    ddr3_ck_p_sdram   <=  #(TPROP_PCB_CTRL) ddr3_ck_p_fpga;
    ddr3_ck_n_sdram   <=  #(TPROP_PCB_CTRL) ddr3_ck_n_fpga;
    ddr3_addr_sdram   <=  #(TPROP_PCB_CTRL) ddr3_addr_fpga;
    ddr3_ba_sdram     <=  #(TPROP_PCB_CTRL) ddr3_ba_fpga;
    ddr3_ras_n_sdram  <=  #(TPROP_PCB_CTRL) ddr3_ras_n_fpga;
    ddr3_cas_n_sdram  <=  #(TPROP_PCB_CTRL) ddr3_cas_n_fpga;
    ddr3_we_n_sdram   <=  #(TPROP_PCB_CTRL) ddr3_we_n_fpga;
    ddr3_cke_sdram    <=  #(TPROP_PCB_CTRL) ddr3_cke_fpga;
  end
    

  always @( * )
    ddr3_cs_n_sdram_tmp   <=  #(TPROP_PCB_CTRL) ddr3_cs_n_fpga;
  assign ddr3_cs_n_sdram =  ddr3_cs_n_sdram_tmp;
    

  always @( * )
    ddr3_dm_sdram_tmp <=  #(TPROP_PCB_DATA) ddr3_dm_fpga;//DM signal generation
  assign ddr3_dm_sdram = ddr3_dm_sdram_tmp;
    

  always @( * )
    ddr3_odt_sdram_tmp  <=  #(TPROP_PCB_CTRL) ddr3_odt_fpga;
  assign ddr3_odt_sdram =  ddr3_odt_sdram_tmp;
    

// Controlling the bi-directional BUS

  genvar dqwd;
  generate
    for (dqwd = 1;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g    (TPROP_PCB_DATA),
        .Delay_rd   (TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dq
       (
        .A             (ddr3_dq_fpga[dqwd]),
        .B             (ddr3_dq_sdram[dqwd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
    // For ECC ON case error is inserted on LSB bit from DRAM to FPGA
          WireDelay #
       (
        .Delay_g    (TPROP_PCB_DATA),
        .Delay_rd   (TPROP_PCB_DATA_RD),
        .ERR_INSERT (ECC)
       )
      u_delay_dq_0
       (
        .A             (ddr3_dq_fpga[0]),
        .B             (ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  endgenerate

  genvar dqswd;
  generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g    (TPROP_DQS),
        .Delay_rd   (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dqs_p
       (
        .A             (ddr3_dqs_p_fpga[dqswd]),
        .B             (ddr3_dqs_p_sdram[dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );

      WireDelay #
       (
        .Delay_g    (TPROP_DQS),
        .Delay_rd   (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dqs_n
       (
        .A             (ddr3_dqs_n_fpga[dqswd]),
        .B             (ddr3_dqs_n_sdram[dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  endgenerate

//---------------------------------------------------------------------------------------------
// A Task to reset the MAC
//---------------------------------------------------------------------------------------------
task mac_reset;
begin
    $display("** Note: Resetting core...");
    reset <= 1'b1;
    #400000
    reset <= 1'b0;
    $display("** Note: Timing checks are valid");
end
endtask // mac_reset; 

// drives gtx_clk at 200MHz
initial
begin
    gtx_clk <= 1'b0;
    #80000;
    forever
    begin
        gtx_clk <= 1'b0;
        #gtx_period;
        gtx_clk <= 1'b1;
        #gtx_period;
    end
end

//clk25m
initial
begin
    clk_25m <= 1'b0;
    #80000;
    forever
    begin
        clk_25m <= 1'b0;
        #20000;
        clk_25m <= 1'b1;
        #20000;
    end
end

//27m
initial
begin
    clk_27m <= 1'b0;
    #80000;
    forever
    begin
        clk_27m <= 1'b0;
        #18000;
        clk_27m <= 1'b1;
        #18000;
    end
end
//rgmii_rxc 125MHz
initial
begin
    rgmii_rxc <= 1'b0;
    #10000;
    forever
    begin
        rgmii_rxc <= 1'b0;
        #4000;
        rgmii_rxc <= 1'b1;
        #4000;
    end
end

//---------------------------------------------------------------------------------------------
// Simulate the MDIO - 
// respond with sensible data to mdio reads and accept writes
//---------------------------------------------------------------------------------------------
// expect mdio to try and read from reg addr 1 - return all 1's if we don't 
// want any other mdio accesses
// if any other response then mdio will write to reg_addr 9 then 4 then 0 
// (may check for expected write data?)
// finally mdio read from reg addr 1 until bit 5 is seen high 
// NOTE - do not check any other bits so could drive all high again..
  
  
// count through the mdio transfer
always @(posedge mdc or posedge reset)
begin
    if (reset) 
    begin
       mdio_count <= 0;
       last_mdio <= 1'b0;
    end
    else 
    begin
        last_mdio <= mdio;
        if (mdio_count >= 32) 
        begin
           mdio_count <= 0;
        end
        else if (mdio_count != 0) 
        begin
           mdio_count <= mdio_count + 1;
        end
        else 
        begin // only get here if mdio state is 0 - now look for a start
           if ((mdio === 1'b1) && (last_mdio === 1'b0))
              mdio_count <= 1;
        end   
    end  
end

assign mdio = (mdio_read & (mdio_count >= 14) & (mdio_count <= 31)) ? 1'b1 : 1'bz;

// only respond to phy addr 7 and reg address == 1 (PHY_STATUS)
always @(posedge mdc or posedge reset)
begin
    if (reset) 
    begin
        mdio_read <= 1'b0;  
        mdio_addr <= 1'b1; // this will go low if the address doesn't match required   
        mdio_fail <= 1'b0;
    end
    else
    begin
        if (mdio_count == 2) 
        begin
            mdio_addr <= 1'b1;    // new access so address needs to be revalidated
            if ({last_mdio,mdio} === 2'b10)
                mdio_read <= 1'b1;
            else // take a write as a default as won't drive at the wrong time
                mdio_read <= 1'b0;
        end
        else if ((mdio_count <= 12)) 
        begin
            // check address is phy addr/reg addr are correct
            if (mdio_count <= 7 & mdio_count >= 5) 
            begin
                if (mdio !== 1'b1)
                   mdio_addr <= 1'b0;
            end
            else 
            begin
                if (mdio !== 1'b0)
                   mdio_addr <= 1'b0;
            end
        end
        else if ((mdio_count == 14)) 
        begin
            if (!mdio_read & (mdio | !last_mdio)) 
            begin
                $display("FAIL : Write TA phase is incorrect at %t ps", $time);
            end
        end 
        else if ((mdio_count >= 15) & (mdio_count <= 30) & mdio_addr) 
        begin
            if (!mdio_read) 
            begin
                if (mdio_count == 20) 
                begin
                    if (mdio) 
                    begin
                        mdio_fail <= 1;
                        $display("FAIL : Expected bit 10 of mdio write data to be 0 at %t ps", $time);
                    end
                end
                else 
                begin
                    if (!mdio) 
                    begin
                        mdio_fail <= 1;
                        $display("FAIL : Expected all except bit 10 of mdio write data to be 1 at %t ps", $time);
                    end
                end
            end
        end 
    end     
end

  //-------------------------------------------------------------------------------------------
  // Management process. This process waits for setup to complete by monitoring the mdio
  // (the host always runs at gtx_clk so the setup after mdio accesses are complete
  // doesn't take long) and then allows packets to be sent
  //-------------------------------------------------------------------------------------------
initial
begin : p_management
    mac_reset;
    // check mdio
    // wait for the mdio access and remainder of setup accesses (internal)
    $display("p_management.........................................");
    wait (mdio_count == 32);
    wait (mdio_count == 0);
    if (TB_MODE == "BIST") 
    begin
        // run for a set time and then stop
        repeat (15000) @(posedge gtx_clk);
        // Our work here is done  
        $stop;
    end
    else 
    begin  
        // Signal that configuration is complete.  Other processes will now
        // be allowed to run.
        management_config_finished = 1;        
        // The stimulus process will now send 4 frames at 1Gb/s.
        //------------------------------------------------------------------       
        // Wait for 1G monitor process to complete.
        wait (tx_monitor_finished_1G == 1);
        management_config_finished = 0;
        
        // Our work here is done
        $display("** failure: Simulation Stopped");
        $stop;
    end
end // p_management



//----------------------------------------------------------------------------
// Procedure to inject a frame into the receiver at 1Gb/s
//----------------------------------------------------------------------------
task send_frame_1g;
    input   `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [31:0] fcs;
    begin
        // import the frame into scratch space
        rx_stimulus_working_frame.frombits(frame);
        
        // Reset the FCS calculation
        fcs = 32'b0;
        @(posedge rgmii_rxc);
        
        column_index = 0;
        
        // Adding the preamble field
        for (I = 0; I <= 13; I = I + 1)
        begin
            rgmii_rxd   <= 4'h5;
            rgmii_rx_ctl <= 1'b1;
            @(rgmii_rxc);
        end
        
        // Adding the Start of Frame Delimiter (SFD)
        rgmii_rxd   <= 4'h5;
        rgmii_rx_ctl <= 1'b1;
        @(rgmii_rxc)
        rgmii_rxd   <= 4'hD;
        rgmii_rx_ctl <= 1'b1;
        @(rgmii_rxc)
        // loop over columns in frame.
        while (rx_stimulus_working_frame.valid[column_index] !== 1'b0)
        begin
            // send one column of data
            rgmii_rxd    <= rx_stimulus_working_frame.data[column_index][3:0];
            rgmii_rx_ctl <= rx_stimulus_working_frame.valid[column_index];
            @(rgmii_rxc)
            rgmii_rxd    <= rx_stimulus_working_frame.data[column_index][7:4];
            rgmii_rx_ctl <= rx_stimulus_working_frame.valid[column_index] ^ rx_stimulus_working_frame.error[column_index];
            calc_crc(rx_stimulus_working_frame.data[column_index], fcs);
            
            column_index = column_index + 1;
            @(rgmii_rxc);  // wait for next clock tick
        
        end
        // Send the CRC.
        for (I = 0; I < 4; I = I + 1)
        begin
            case(I)
                0 : rgmii_rxd    <= fcs[3:0];
                1 : rgmii_rxd    <= fcs[11:8];
                2 : rgmii_rxd    <= fcs[19:16];
                3 : rgmii_rxd    <= fcs[27:24];
            endcase
            rgmii_rx_ctl <= 1'b1;
            @(rgmii_rxc)
            case(I)
                0 : rgmii_rxd    <= fcs[7:4];
                1 : rgmii_rxd    <= fcs[15:12];
                2 : rgmii_rxd    <= fcs[23:20];
                3 : rgmii_rxd    <= fcs[31:28];
            endcase
            rgmii_rx_ctl <= 1'b1;
            
            @(rgmii_rxc);  // wait for next clock tick
        end
        
        // Clear the data lines.
        rgmii_rxd       <= 4'h0;
        rgmii_rx_ctl    <= 1'b0;
        
        // Adding the minimum Interframe gap for a receiver (8 idles)
        for (I = 0; I < 16; I = I + 1)
            @(rgmii_rxc);
    end
endtask // send_frame_1g;

//----------------------------------------------------------------------------
// A Task to check a transmitted frame at 1Gb/s
//----------------------------------------------------------------------------
task check_frame_1g;
    input `FRAME_TYP frame;
    integer column_index;
    integer I;
    reg [8*4:0] string;
    reg [31:0] fcs;
    reg [7:0]  rgmii_column;
    reg [1:0]  rgmii_valid;
    begin
        // import the frame into scratch space
        tx_monitor_working_frame.frombits(frame);
        
        column_index = 0;
        
        // If the current frame had an error inserted then it would have
        // been dropped by the FIFO in the design example.  Therefore
        // exit this task and move immediately on to the next frame.
        if (tx_monitor_working_frame.bad_frame !== 1'b1)
        begin
            $display("check_frame_1g................debug0 ");
            // reset the fcs calculation
            fcs = 32'b0;
            
            // wait until the first real column of data to come out of RX client
            while (rgmii_tx_ctl !== 1'b1)
              @(rgmii_txc);
            
            // check tx_ctl has gone high at the correct edge (should be rising)
            if (!rgmii_txc)
               $display("** ERROR: tx_ctl started on incorrect phase at %t", $realtime, "ps");
            
            // Parse over the preamble field
            while (rgmii_txd === 4'h5)
              @(negedge rgmii_txc);
            
            // Parse over the SFD
            if (rgmii_txd !== 4'hd)
               $display("** ERROR: SFD not present at %t", $realtime, "ps");
            @(posedge rgmii_txc);
            
            if (TB_MODE == "DEMO") begin
                // Start comparing transmitted data to received data
                $display("** Note: Comparing Transmitted Frame with Injected Frame");
                
                // frame has started, loop over columns of frame
                while (tx_monitor_working_frame.valid[column_index] !== 1'b0)
                begin
                
                    rgmii_column[3:0] = rgmii_txd[3:0];
                    rgmii_valid[0]    = rgmii_tx_ctl;
                    @(rgmii_txc);
                    rgmii_column[7:4]= rgmii_txd[3:0];
                    rgmii_valid[1]    = rgmii_tx_ctl;
                    
                    // The transmitted Destination Address was the Source Address
                    // of the injected frame
                    if (column_index < 6)
                    begin
                    
                        if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index+6])
                            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime, "ps");
                        if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index+6])
                            $display("** ERROR: rgmii_tx_ctl incorrect during Destination Address at %t", $realtime, "ps");
                        
                        if (rgmii_column !== tx_monitor_working_frame.data[(column_index+6)])
                            $display("** ERROR: rgmii_txd incorrect during Destination Address at %t", $realtime, "ps");
                    end
                    
                    // The transmitted Source Address was the Destination Address
                    // of the injected frame
                    else if (column_index < 12)
                    begin
                    
                        if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index-6])
                            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime, "ps");
                        if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index-6])
                            $display("** ERROR: rgmii_tx_ctl incorrect during Source Address at %t", $realtime, "ps");
                        
                        if (rgmii_column !== tx_monitor_working_frame.data[(column_index-6)])
                            $display("** ERROR: rgmii_txd incorrect during Source Address at %t", $realtime, "ps");
                    end
                    
                    // check all other data in the frame
                    else
                    begin
                    
                        if (rgmii_valid[0] !== tx_monitor_working_frame.valid[column_index])
                            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime, "ps");
                        if (rgmii_valid[1] !== tx_monitor_working_frame.valid[column_index])
                            $display("** ERROR: rgmii_tx_ctl incorrect at %t", $realtime, "ps");
                        
                        if (rgmii_column !== tx_monitor_working_frame.data[(column_index)])
                            $display("** ERROR: rgmii_txd incorrect at %t", $realtime, "ps");
                    end
                    
                    // calculate expected crc for the frame
                    calc_crc(rgmii_column, fcs);
                    
                    // wait for next column of data
                    column_index = column_index + 1;
                    @(rgmii_txc);
                end
                
                // Check the FCS
                // Having checked all data columns, txd must contain FCS.
                for (I = 0; I < 4; I = I + 1)
                begin
                    rgmii_column[3:0] = rgmii_txd[3:0];
                    rgmii_valid[0]    = rgmii_tx_ctl;
                    @(rgmii_txc);
                    rgmii_column[7:4] = rgmii_txd[3:0];
                    rgmii_valid[1]    = rgmii_tx_ctl;
                    
                    if (rgmii_valid !== 2'b11)
                        $display("** ERROR: rgmii_tx_ctl incorrect during FCS field at %t", $realtime, "ps");
                    
                    case(I)
                        0 : if (rgmii_column !== fcs[7:0])
                            $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime, "ps");
                        1 :  if (rgmii_column !== fcs[15:8])
                            $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime, "ps");
                        2 :  if (rgmii_column !== fcs[23:16])
                            $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime, "ps");
                        3 :  if (rgmii_column !== fcs[31:24])
                            $display("** ERROR: rgmii_txd incorrect during FCS field at %t", $realtime, "ps");
                    endcase
                    
                    @(rgmii_txc);
                end
            end
            else begin
                // this is the BIST tb mode - want to idnetify the frame type  - VLAN or not to help with the bandwidth calc
                // check the type field and if equal to 81 then classify as vlan (could do more but that should be adequate)
                $display("check_frame_1g................debug1 ");
                string = "";
                while (rgmii_tx_ctl) 
                begin
                    rgmii_column[3:0] = rgmii_txd[3:0];
                    @(rgmii_txc);
                    rgmii_column[7:4]= rgmii_txd[3:0];
                    if (column_index == 12 & rgmii_column == 8'h81) 
                    begin
                        string = "VLAN";
                    end
                    
                    // wait for next column of data
                    column_index = column_index + 1;
                    @(rgmii_txc);  
                end     
                $display("%s Frame transmitted : Size %d", string, column_index);
            end
        end
    end
endtask // check_frame_1g


//----------------------------------------------------------------------------
// Monitor process. This process checks the data coming out of the
// transmitter to make sure that it matches that inserted into the
// receiver.
//----------------------------------------------------------------------------

initial
begin : p_tx_monitor
    tx_monitor_finished_1G    <= 0;
    
    if (TB_MODE == "DEMO") begin
        // Compare the transmitted frame to the received frames
        //      -- frame 0 = minimum length frame
        //      -- frame 1 = type frame
        //      -- frame 2 = errored frame
        //      -- frame 3 = padded frame
        // Repeated for all stated speeds.
        //-----------------------------------------------------
        
        // wait for the reset to complete before starting monitor         
        @(negedge reset);
        
        // 1 Gb/s speed
        //-----------------------------------------------------
        
        // Check the frames
        $display("check 1G framer0! ");
        
        check_frame_1g(frame0.tobits(0));
        
        $display("check 1G framer0 finished! ");
        
        check_frame_1g(frame1.tobits(0));
        check_frame_1g(frame2.tobits(0));
        check_frame_1g(frame3.tobits(0));
        
        //#200000
        #20000
        tx_monitor_finished_1G  <= 1;
    
    end
    else begin
        forever check_frame_1g(frame0.tobits(0));
    end

end // p_tx_monitor

//---------------------------cpu config--------------------//

assign lbus_data = (~lbus_we_n) ? lbus_wdata : 'hz;

task cpu_wr;
    input   [15:0]  cpu_waddr;
    input   [15:0]  cpu_wdata;
    begin
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b0;
        lbus_we_n    =   1'b0;
        lbus_addr    =   cpu_waddr;
        //lbus_wdata   =   cpu_wdata;
        lbus_wdata    =   cpu_wdata;
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b1;
        lbus_we_n    =   1'b1; 
    end
endtask

task cpu_rd;
    input   [15:0]  cpu_raddr;
    output  [15:0]  cpu_rdata;
    reg     [15:0]  cpu_rdata;
    begin
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b0;
        lbus_oe_n    =   1'b0;
        lbus_addr    =   cpu_raddr; 
        @(posedge clk_cfg);
        @(posedge clk_cfg);
        @(posedge clk_cfg);             //????????????????????????????????????????????????????see lbus timing
        @(posedge clk_cfg);             //????????????????????????????????????????????????????see lbus timing
        //while (lbus_wait_n == 1'b0)
        //    @(posedge clk_cfg);
        wait(lbus_wait_n==1'b1);
        cpu_rdata    =   lbus_data;
        @(posedge clk_cfg);
        lbus_cs_n    =   1'b1;
        lbus_oe_n    =   1'b1;
    end
endtask

initial
begin
    lbus_cfg_finished   =   1'b0;
    lbus_cs_n   =   1'b1;
    lbus_oe_n   =   1'b1;
    lbus_we_n   =   1'b1;
    lbus_addr   =   {16{1'b0}};
    lbus_wdata  =   {16{1'b0}};
    wait(rstn_cfg==1);
    //------------------------------------------------------------------------  
    //udp filter table,addr=0-511,dst_ip:32'h11220000-32'h112201ff;dst_port:16'h8000-16'h81ff
    //------------------------------------------------------------------------
    for(i=0;i<512;i=i+1)
    begin
        @(posedge clk_cfg);
        cpu_wr(GBE_DST_IP_L,i);
        @(posedge clk_cfg);
        cpu_wr(GBE_DST_IP_H,16'h1122);
        @(posedge clk_cfg);
        cpu_wr(GBE_DST_PORT,16'h8000+i);
        @(posedge clk_cfg);
        cpu_wr(GBE_PORT_INDEX,i);
        @(posedge clk_cfg);
        cpu_wr(GBE_UDPFILTER_SET,i);
    end    
    @(posedge clk_cfg);
    cpu_wr(GBE_UDPFILTER_CTRL,16'h0001);
    
    //------------------------------------------------------------------------
    //ip address filter
    //------------------------------------------------------------------------
    cpu_wr(GBE_IP_FILTER_L,16'h0000);
    cpu_wr(GBE_IP_FILTER_H,16'h1122);
    cpu_wr(GBE_IPFILTER_SET,16'h0000);
    
    cpu_wr(GBE_IP_FILTER_L,16'h0001);
    cpu_wr(GBE_IP_FILTER_H,16'h1122);
    cpu_wr(GBE_IPFILTER_SET,16'h0001);
    //--------------TSMAP--------------------------------
    for(i=0;i<7;i=i+1)
    begin
        cpu_wr(12'h308, 16'h0100+i*16'h0100);                       //input pid
        cpu_wr(12'h309, 16'h0000);                                  //input channel
        cpu_wr(12'h310, 16'h0000+i*2);
          
        cpu_wr(12'h308, 16'h0111+i*16'h0111);                       //output pid
        cpu_wr(12'h309, 16'h0000);                                  //output channel
        cpu_wr(12'h310, 16'h0001+i*2);
        //
        cpu_wr(12'h308, 16'h0111+i*16'h0100);                       //input pid
        cpu_wr(12'h309, 16'h0001);                                  //input channel
        cpu_wr(12'h310, 16'h0100+i*2);
          
        cpu_wr(12'h308, 16'h0111+i*16'h0111);                       //output pid
        cpu_wr(12'h309, 16'h0001);                                  //output channel
        cpu_wr(12'h310, 16'h0101+i*2);
        //
        cpu_wr(12'h308, 16'h0122+i*16'h0100);                       //input pid
        cpu_wr(12'h309, 16'h01fe);                                  //input channel
        cpu_wr(12'h310, 16'h0e00+i*2);
          
        cpu_wr(12'h308, 16'h0111+i*16'h0111);                       //output pid
        cpu_wr(12'h309, 16'h000e);                                  //output channel
        cpu_wr(12'h310, 16'h0e01+i*2);
        //
        cpu_wr(12'h308, 16'h0133+i*16'h0100);                       //input pid
        cpu_wr(12'h309, 16'h01ff);                                  //input channel
        cpu_wr(12'h310, 16'h0f00+i*2);
          
        cpu_wr(12'h308, 16'h0111+i*16'h0111);                       //output pid
        cpu_wr(12'h309, 16'h000f);                                  //output channel
        cpu_wr(12'h310, 16'h0f01+i*2);
    end
    
    lbus_cfg_finished   =   1'b1;
end

//----------------------------------------------------------------------------
// Stimulus process. This process will inject frames of data into the
// PHY side of the receiver.
//----------------------------------------------------------------------------
initial
begin : p_rx_stimulus

    // Initialise stimulus
    rgmii_rxd      = 4'h0;
    rgmii_rx_ctl   = 1'b0;    
    $display("sending 4 frames start........................... ");
    // 1 Gb/s speed
    //-----------------------------------------------------
    // Wait for the Management MDIO transaction to finish.
    while (management_config_finished !== 1)
    // wait for the internal resets to settle before staring to send traffic
    //#128000000;
    #128000;
    
    wait(lbus_cfg_finished==1'b1);
    
    $display("Rx Stimulus: sending 4 frames at 1G ... ");
   // while(1)
   // begin
      //send_frame_1g(frame0.tobits(0));
      //send_frame_1g(frame1.tobits(1));
      //send_frame_1g(frame2.tobits(2));
      //send_frame_1g(frame3.tobits(3));
      //send_frame_1g(frame0.tobits(0));
      //send_frame_1g(frame1.tobits(1));
      //send_frame_1g(frame2.tobits(2));
      //send_frame_1g(frame3.tobits(3));
      for(i=0;i<10;i=i+1)
      begin
        send_frame_1g(frame0.tobits(0));
        //send_frame_1g(frame1.tobits(1));
        //send_frame_1g(frame3.tobits(3));
      end
   // end
    $display("sending 4 frames at 1G finished!... ");

    //--------------------------------------------------------------------    
    //read ip rx filter data
    //--------------------------------------------------------------------
    //if(ipmatch_int==1'b1)
    cpu_rd(GBE_IPRX_PKTLEN,ip_filter_pkt_len);
    for(i=0;i<(ip_filter_pkt_len / 2);i=i+1)
    begin
        cpu_rd(GBE_IPRX_DATA,ip_filter_data);
    end
    
    //if(ipmatch_int==1'b1)
    cpu_rd(GBE_IPRX_PKTLEN,ip_filter_pkt_len);
    for(i=0;i<(ip_filter_pkt_len / 2);i=i+1)
    begin
        cpu_rd(GBE_IPRX_DATA,ip_filter_data);
    end
    
    //--------------------------------------------------------------------
    //ip tx data,first write data,then write pkt length!
    //--------------------------------------------------------------------
    for(i=0;i<65;i=i+1)
    begin
        cpu_wr(GBE_IPTX_DATA,16'h55aa);
    end
    cpu_wr(GBE_IPTX_PKTLEN,16'd130);

    //--------------------------------------------------------------------
    //ip rx statistics
    //--------------------------------------------------------------------
    cpu_rd(GBE_PKTCNT_L,gbe_rx_pktcnt[15:0]);
    cpu_rd(GBE_PKTCNT_H,gbe_rx_pktcnt[31:16]);
    cpu_rd(GBE_BYTECNT_L,gbe_rx_bytecnt[15:0]);
    cpu_rd(GBE_BYTECNT_H,gbe_rx_bytecnt[31:16]);
    
    wait (tx_monitor_finished_1G == 1);
    #10000;
end // p_rx_stimulus





    
ip_qam_top #(
    .U_DLY                              ( 0                         ),
    .SIMULATION                         ( SIMULATION                ),
    .SEL_VICTIM_LINE                    ( SEL_VICTIM_LINE           ),
    .SIM_BYPASS_INIT_CAL                ( SIM_BYPASS_INIT_CAL       )
    )
u0_ip_qam_top(
    .rstn_sys                           ( ~reset                    ),
    .clk_27m                            ( clk_27m                   ), 
    .rstn_phymain                       ( rstn_phymain              ),
    .rstn_phybackup                     ( rstn_phybackup            ),
    .phy_main_rgmii_txd                 ( phy_main_rgmii_txd        ),
    .phy_main_rgmii_tx_ctl              ( phy_main_rgmii_tx_ctl     ),
    .phy_main_rgmii_txc                 ( phy_main_rgmii_txc        ),
    .phy_main_rgmii_rxd                 ( phy_main_rgmii_rxd        ),
    .phy_main_rgmii_rx_ctl              ( phy_main_rgmii_rx_ctl     ),
    .phy_main_rgmii_rxc                 ( phy_main_rgmii_rxc        ),
    .phy_main_led1000                   ( 1'b0                      ),
    .phy_main_mdio                      ( mdio                      ),
    .phy_main_mdc                       ( phy_main_mdc              ),
    .phy_backup_rgmii_txd               ( phy_backup_rgmii_txd      ),
    .phy_backup_rgmii_tx_ctl            ( phy_backup_rgmii_tx_ctl   ),
    .phy_backup_rgmii_txc               ( phy_backup_rgmii_txc      ),
    .phy_backup_rgmii_rxd               ( phy_backup_rgmii_rxd      ),
    .phy_backup_rgmii_rx_ctl            ( phy_backup_rgmii_rx_ctl   ),
    .phy_backup_rgmii_rxc               ( phy_backup_rgmii_rxc      ),
    .phy_backup_led1000                 ( 1'b1                      ),                  
    .phy_backup_mdio                    ( mdio                      ),
    .phy_backup_mdc                     ( phy_backup_mdc            ),
    .sfp_main_mod_def0                  ( 1'b0                      ),
    .sfp_backup_mod_def0                ( 1'b0                      ),
    .sfp_main_tx_disable                ( /*not used*/              ),
    .sfp_backup_tx_disable              ( /*not used*/              ),
    
    .adf4350_ce                         ( /*not used*/              ),
    .adf4350_clk                        ( /*not used*/              ),
    .adf4350_data                       ( /*not used*/              ),
    .adf4350_le                         ( /*not used*/              ),
    .adf4350_pdbrf                      ( /*not used*/              ),
    
    .master_board_test                  ( /*not used*/              ),
    
    .dac_reset                          ( /*not used*/              ),
    .dac_spi_clk                        ( /*not used*/              ),
    .dac_spi_csn                        ( /*not used*/              ),
    .dac_spi_sdio                       ( /*not used*/              ),
    .dac_clk_in_p                       ( 1'b0                      ),
    .dac_clk_in_n                       ( 1'b0                      ),
    .dac_clk_out_p                      ( /*not used*/              ),
    .dac_clk_out_n                      ( /*not used*/              ),
    .dac_data_out_a_p                   ( /*not used*/              ),
    .dac_data_out_a_n                   ( /*not used*/              ),
    .dac_data_out_b_p                   ( /*not used*/              ),
    .dac_data_out_b_n                   ( /*not used*/              ),
    
    //ddr3
    .ddr3_dq                            ( ddr3_dq_fpga              ),
    .ddr3_dqs_n                         ( ddr3_dqs_n_fpga           ),
    .ddr3_dqs_p                         ( ddr3_dqs_p_fpga           ),
    .ddr3_addr                          ( ddr3_addr_fpga            ),
    .ddr3_ba                            ( ddr3_ba_fpga              ),
    .ddr3_ras_n                         ( ddr3_ras_n_fpga           ),
    .ddr3_cas_n                         ( ddr3_cas_n_fpga           ),
    .ddr3_we_n                          ( ddr3_we_n_fpga            ),
    .ddr3_reset_n                       ( ddr3_reset_n              ),
    .ddr3_ck_p                          ( ddr3_ck_p_fpga            ),
    .ddr3_ck_n                          ( ddr3_ck_n_fpga            ),
    .ddr3_cke                           ( ddr3_cke_fpga             ),
    .ddr3_cs_n                          ( ddr3_cs_n_fpga            ),    
    .ddr3_dm                            ( ddr3_dm_fpga              ),    
    .ddr3_odt                           ( ddr3_odt_fpga             ),
    
    `ifdef SIMULATION
    .clk_cfg                            ( clk_cfg                   ),
    .rstn_cfg                           ( rstn_cfg                  ),
    .ddr3_user_clk                      ( ddr3_user_clk             ),
    .ddr3_user_rst                      ( ddr3_user_rst             ),
    .init_calib_complete                ( init_calib_complete       ),
    .tg_compare_error                   ( tg_compare_error          ),
    `endif
    
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_data                          ( lbus_data                 ),   
    .lbus_cs_n                          ( lbus_cs_n                 ),
    .lbus_oe_n                          ( lbus_oe_n                 ),
    .lbus_we_n                          ( lbus_we_n                 ),
    .lbus_int                           ( /*not used*/              ),
    .lbus_wait_n                        ( lbus_wait_n               ),
    
    .gpio_led                           ( /*not used*/              ),
    .gpio_test                          ( /*not used*/              )
    );

`ifdef DDR_SIMULATION
//------------------------------------------------------------------
//ddr3 simulation
//------------------------------------------------------------------
wire   [31:0]                           ts_data;
wire                                    ts_data_valid;
wire                                    ts_start;
wire                                    ts_end;
wire                                    clk;
wire                                    rst;
//ts to j83
wire   [15:0]                           j83_ts_rd_sync;  
wire   [15:0]                           j83_ts_rd_req;  
wire   [7:0]                            ts_j83_data_ch0 ;
wire   [7:0]                            ts_j83_data_ch1 ;
wire   [7:0]                            ts_j83_data_ch2 ;
wire   [7:0]                            ts_j83_data_ch3 ;
wire   [7:0]                            ts_j83_data_ch4 ;
wire   [7:0]                            ts_j83_data_ch5 ;
wire   [7:0]                            ts_j83_data_ch6 ;
wire   [7:0]                            ts_j83_data_ch7 ;
wire   [7:0]                            ts_j83_data_ch8 ;
wire   [7:0]                            ts_j83_data_ch9 ;
wire   [7:0]                            ts_j83_data_ch10;
wire   [7:0]                            ts_j83_data_ch11;
wire   [7:0]                            ts_j83_data_ch12;
wire   [7:0]                            ts_j83_data_ch13;
wire   [7:0]                            ts_j83_data_ch14;
wire   [7:0]                            ts_j83_data_ch15;
wire   [15:0]                           ts_j83_data_sync;
wire   [15:0]                           ts_j83_data_last;
   
reg [15:0]  byte_cnt;
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        byte_cnt    <=  16'd0;
    end
    else if(byte_cnt>=476)
    begin
        byte_cnt    <=  16'd101;
    end
    else  
    begin
        byte_cnt    <=  byte_cnt + 16'h0001;  
    end
end

generate
    genvar j;
    for(j=0;j<16;j=j+1)
    begin:  inst_j83_rdreq
        assign  j83_ts_rd_req[j]    =   ((byte_cnt>100) && (byte_cnt%2==0)) ?   1'b1    :   1'b0;
        assign  j83_ts_rd_sync[j]   =   (byte_cnt==102) ?   1'b1    :   1'b0;
    end
endgenerate

ts_gen #(
    .U_DLY                              ( 0                         )
    )
u0_ts_gen(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .memc_init_done                     ( init_calib_complete       ),
    .ts_data                            ( ts_data                   ),
    .ts_valid                           ( ts_data_valid             ),
    .ts_start                           ( ts_start                  ),
    .ts_end                             ( ts_end                    )
    );
    
ddr3_top #(
    .SIMULATION                         ( SIMULATION                ),
    .SEL_VICTIM_LINE                    ( SEL_VICTIM_LINE           ),
    .SIM_BYPASS_INIT_CAL                ( SIM_BYPASS_INIT_CAL       )
    )
u_ddr3_top(
    .ddr3_dq                            ( ddr3_dq_fpga              ),
    .ddr3_dqs_n                         ( ddr3_dqs_n_fpga           ),
    .ddr3_dqs_p                         ( ddr3_dqs_p_fpga           ),
    .ddr3_addr                          ( ddr3_addr_fpga            ),
    .ddr3_ba                            ( ddr3_ba_fpga              ),
    .ddr3_ras_n                         ( ddr3_ras_n_fpga           ),
    .ddr3_cas_n                         ( ddr3_cas_n_fpga           ),
    .ddr3_we_n                          ( ddr3_we_n_fpga            ),
    .ddr3_reset_n                       ( ddr3_reset_n              ),
    .ddr3_ck_p                          ( ddr3_ck_p_fpga            ),
    .ddr3_ck_n                          ( ddr3_ck_n_fpga            ),
    .ddr3_cke                           ( ddr3_cke_fpga             ),
    .ddr3_cs_n                          ( ddr3_cs_n_fpga            ),    
    .ddr3_dm                            ( ddr3_dm_fpga              ),    
    .ddr3_odt                           ( ddr3_odt_fpga             ),
     
    .sys_clk_i                          ( sys_clk_i                 ),   
    .clk_ref_i                          ( clk_ref_i                 ),

    .sys_rst                            ( sys_rst                   ),
      
    `ifdef DDR_SIMULATION
    .user_clk                           ( clk                       ),
    .user_rst                           ( rst                       ),
    .init_calib_complete                ( init_calib_complete       ),
    .tg_compare_error                   ( tg_compare_error          ),
    `endif
      
    .ts_data                            ( ts_data                   ),  
    .ts_data_valid                      ( ts_data_valid             ),  
    .ts_start                           ( ts_start                  ),  
    .ts_end                             ( ts_end                    ),  
    
    .j83_ts_rd_sync                     ( j83_ts_rd_sync            ),
    .j83_ts_rd_req                      ( j83_ts_rd_req             ),
    .ts_j83_data_ch0                    ( ts_j83_data_ch0           ),
    .ts_j83_data_ch1                    ( ts_j83_data_ch1           ),
    .ts_j83_data_ch2                    ( ts_j83_data_ch2           ),
    .ts_j83_data_ch3                    ( ts_j83_data_ch3           ),
    .ts_j83_data_ch4                    ( ts_j83_data_ch4           ),
    .ts_j83_data_ch5                    ( ts_j83_data_ch5           ),
    .ts_j83_data_ch6                    ( ts_j83_data_ch6           ),
    .ts_j83_data_ch7                    ( ts_j83_data_ch7           ),
    .ts_j83_data_ch8                    ( ts_j83_data_ch8           ),
    .ts_j83_data_ch9                    ( ts_j83_data_ch9           ),
    .ts_j83_data_ch10                   ( ts_j83_data_ch10          ),
    .ts_j83_data_ch11                   ( ts_j83_data_ch11          ),
    .ts_j83_data_ch12                   ( ts_j83_data_ch12          ),
    .ts_j83_data_ch13                   ( ts_j83_data_ch13          ),
    .ts_j83_data_ch14                   ( ts_j83_data_ch14          ),
    .ts_j83_data_ch15                   ( ts_j83_data_ch15          ),
    .ts_j83_data_sync                   ( ts_j83_data_sync          ),
    .ts_j83_data_last                   ( ts_j83_data_last          )     
    );

`endif






        
  //**************************************************************************//
  // Memory Models instantiations
  //**************************************************************************//

  //genvar r,i;
  genvar r,t;
  generate
    for (r = 0; r < CS_WIDTH; r = r + 1) begin: mem_rnk
      if(DQ_WIDTH/16) begin: mem
        for (t = 0; t < NUM_COMP; t = t + 1) begin: gen_mem
          ddr3_model u_comp_ddr3
            (
             .rst_n   (ddr3_reset_n),
             .ck      (ddr3_ck_p_sdram),
             .ck_n    (ddr3_ck_n_sdram),
             .cke     (ddr3_cke_sdram[r]),
             .cs_n    (ddr3_cs_n_sdram[r]),
             .ras_n   (ddr3_ras_n_sdram),
             .cas_n   (ddr3_cas_n_sdram),
             .we_n    (ddr3_we_n_sdram),
             .dm_tdqs (ddr3_dm_sdram[(2*(t+1)-1):(2*t)]),
             .ba      (ddr3_ba_sdram),
             .addr    (ddr3_addr_sdram),
             .dq      (ddr3_dq_sdram[16*(t+1)-1:16*(t)]),
             .dqs     (ddr3_dqs_p_sdram[(2*(t+1)-1):(2*t)]),
             .dqs_n   (ddr3_dqs_n_sdram[(2*(t+1)-1):(2*t)]),
             .tdqs_n  (),
             .odt     (ddr3_odt_sdram[r])
             );
        end
      end
      if (DQ_WIDTH%16) begin: gen_mem_extrabits
        ddr3_model u_comp_ddr3
          (
           .rst_n   (ddr3_reset_n),
           .ck      (ddr3_ck_p_sdram),
           .ck_n    (ddr3_ck_n_sdram),
           .cke     (ddr3_cke_sdram[r]),
           .cs_n    (ddr3_cs_n_sdram[r]),
           .ras_n   (ddr3_ras_n_sdram),
           .cas_n   (ddr3_cas_n_sdram),
           .we_n    (ddr3_we_n_sdram),
           .dm_tdqs ({ddr3_dm_sdram[DM_WIDTH-1],ddr3_dm_sdram[DM_WIDTH-1]}),
           .ba      (ddr3_ba_sdram),
           .addr    (ddr3_addr_sdram),
           .dq      ({ddr3_dq_sdram[DQ_WIDTH-1:(DQ_WIDTH-8)],
                      ddr3_dq_sdram[DQ_WIDTH-1:(DQ_WIDTH-8)]}),
           .dqs     ({ddr3_dqs_p_sdram[DQS_WIDTH-1],
                      ddr3_dqs_p_sdram[DQS_WIDTH-1]}),
           .dqs_n   ({ddr3_dqs_n_sdram[DQS_WIDTH-1],
                      ddr3_dqs_n_sdram[DQS_WIDTH-1]}),
           .tdqs_n  (),
           .odt     (ddr3_odt_sdram[r])
           );
      end
    end
  endgenerate

  //***************************************************************************
  // Reporting the test case status
  // Status reporting logic exists both in simulation test bench (sim_tb_top)
  // and sim.do file for ModelSim. Any update in simulation run time or time out
  // in this file need to be updated in sim.do file as well.
  //***************************************************************************
  initial
  begin : Logging
     fork
        begin : calibration_done
           wait (init_calib_complete);
           $display("Calibration Done");
           #450000000;
           if (!tg_compare_error) begin
              $display("TEST PASSED");
           end
           else begin
              $display("TEST FAILED: DATA ERROR");
           end
           disable calib_not_done;
            $finish;
        end

        begin : calib_not_done
           #1000000000;
           if (!init_calib_complete) begin
              $display("TEST FAILED: INITIALIZATION DID NOT COMPLETE");
           end
           disable calibration_done;
            $finish;
        end
     join
  end
      

//initial begin
//$fsdbAutoSwitchDumpfile(100,"test.fsdb",60,"my.log");
//$fsdbDumpvars;
//$fsdbDumpon;
//#4294000000
//$finish(2);
//end

//initial begin
//    force u0_ip_qam_top.u0_ddr3_top.u0_ddr_rw_ctrl.u0_ddr_write_ctrl.ddr_rd_req_ch=16'h0000;
//    #400000000;
//    release u0_ip_qam_top.u0_ddr3_top.u0_ddr_rw_ctrl.u0_ddr_write_ctrl.ddr_rd_req_ch;
//end

initial begin
$fsdbDumpfile("test_000.fsdb");
$fsdbDumpvars;
end	

endmodule

