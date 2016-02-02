/*************************************************************************************\
    Copyright(c) 2014, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   Creative Center,R&D Hardware Department
    Filename     :   lane_up_detect.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2014-11-10  huangrui/1480       1.0         IPQAM2x12   Create
    ==================================================================================
    Called by    :   lane_up_detect.v
    File tree    :   lane_up_detect.v
\************************************************************************************/

`timescale 1ns/100ps

module lane_up_detect(
    sys_clk                     ,
    clk                         ,
    rst                         ,
    channel_up                  ,
    lane_up                     ,
    gtp_rst
    );

input                                   sys_clk                     ;    
input                                   clk                         ;
input                                   rst                         ;
input                                   channel_up                  ;
input                                   lane_up                     ;
output                                  gtp_rst                     ;

reg                                     dog_det_lane                ;
reg     [27:0]                          counter                     ;
reg                                     serdes_relink               ;
reg                                     serdes_rst                  ;
wire                                    gtp_rst_buf                 ;

always@(posedge sys_clk)
begin
    if(counter[26]==1'b1)   //detect every 2 seconds
    begin
        dog_det_lane    <=  1'b1;
        counter         <=  {28{1'b0}};
    end
    else 
    begin
        dog_det_lane    <=  1'b0;
        counter         <=  counter + 'h1;
    end
end

always@(posedge sys_clk)
begin
    if((lane_up==1'b1) && (channel_up==1'b1))
    begin
        serdes_relink   <=  1'b0;
    end
    else
    begin
        serdes_relink   <=  dog_det_lane;
    end
end
             
always@(posedge sys_clk)
begin
    if(serdes_relink==1'b1)
    begin
        serdes_rst  <=  1'b1;
    end
    else if(counter[14]==1'b1)
    begin
        serdes_rst  <=  1'b0;
    end
end

assign  gtp_rst_buf =   rst | serdes_rst;

rst_sync u0_gtp_rst_sync(
    .clk                                ( clk                       ),
    .enable                             ( 1'b1                      ),
    .reset_in                           ( gtp_rst_buf               ),
    .reset_out                          ( gtp_rst                   )
    ); 
        
endmodule
