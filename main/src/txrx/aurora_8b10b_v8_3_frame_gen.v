/*************************************************************************************\
    Copyright(c) 2013, China Digital TV Holding Co., Ltd,All right reserved
    Department   :  Creative Center,R&D Hardware Department
    Filename     :  aurora_8b10b_v8_3_FRAME_GEN.v
    Author       :  huangrui/1480
    ==================================================================================
    Description  :  
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-06-17  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :  aurora_8b10b_v8_3_FRAME_GEN.v
    File tree    :  aurora_8b10b_v8_3_FRAME_GEN.v                        
\************************************************************************************/

`timescale 1 ns / 1 ps
`define DLY #1

module aurora_8b10b_v8_3_FRAME_GEN
(
    // User Interface
    TX_D, 
    TX_REM,    
    TX_SOF_N,      
    TX_EOF_N,
    TX_SRC_RDY_N,
    TX_DST_RDY_N,

    // System Interface
    USER_CLK,      
    RESET,
    CHANNEL_UP
);
//*****************************Parameter Declarations****************************

//***********************************Port Declarations*******************************

   // User Interface
    output  [0:15]     TX_D;
    output             TX_REM;
    output             TX_SOF_N;
    output             TX_EOF_N;
    output             TX_SRC_RDY_N;
    input              TX_DST_RDY_N;

      // System Interface
    input              USER_CLK;
    input              RESET;
    input              CHANNEL_UP;  
 
    wire               reset_c;
    reg     [27:0]     counter;
    reg     [0:15]     TX_D;
    reg     [31:0]     delay_cnt;


//*********************************Main Body of Code**********************************

  //Generate RESET signal when Aurora channel is not ready
  assign reset_c = RESET || !CHANNEL_UP;

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        delay_cnt   <=  {32{1'b0}};
    end
    else if(delay_cnt>32'hFFFFFFF0)
    begin
        delay_cnt   <=  32'hFFFFFFF1;
    end
    else
    begin
        delay_cnt   <=  delay_cnt + 1;
    end
end

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        counter <=  `DLY {28{1'b0}};
    end
    else if((TX_DST_RDY_N==1'b0) && (delay_cnt>=32'hFFFFFFF1))
    begin
        counter <=  `DLY counter + 'h1;
    end
end

always @(posedge USER_CLK)  
begin
    if(reset_c==1'b1)
    begin
        TX_D    <=  `DLY 16'h0000;
    end
    else if((counter>=100) && (counter<=108) && (TX_DST_RDY_N==1'b0))
    begin
        TX_D    <=  `DLY TX_D + 16'h0001;
    end
end

assign  TX_REM          = 1'b1;
assign  TX_SRC_RDY_N    = ((counter>=100) && (counter<=108) && (TX_DST_RDY_N==1'b0)) ? 1'b0 : 1'b1;
assign  TX_SOF_N        = ((counter==100) && (TX_DST_RDY_N==1'b0)) ? 1'b0 : 1'b1;
assign  TX_EOF_N        = ((counter==108) && (TX_DST_RDY_N==1'b0)) ? 1'b0 : 1'b1;

               

endmodule
