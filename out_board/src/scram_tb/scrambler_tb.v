/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   scrambler_tb.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2013-03-04  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   scrambler_tb.v
    File tree    :   scrambler_tb.v
\************************************************************************************/

`timescale 1ns/100ps

module scrambler_tb;

reg                                     rst                         ;
reg                                     clk_27m                     ;
reg                                     clk_125m                    ;
reg                                     clk_100m                    ;

wire                                    ts_sync                     ;
wire                                    ts_valid                    ;
wire                                    ts_eop                      ;
wire    [7:0]                           ts_data                     ;
wire                                    scram_valid                 ;
wire    [7:0]                           scram_data                  ;

reg     [11:0]                          lbus_addr                   ;
reg     [15:0]                          lbus_wdata                  ;
reg                                     lbus_we_n                   ;
reg                                     lbus_cfg_finished           ;
reg                                     j83_rdreq                   ;
reg                                     rst_tsgen                   ;

initial
begin
    rst =   1'b1;
    #200
    rst =   1'b0;
end

initial
begin
    rst_tsgen =   1'b1;
    #1000
    rst_tsgen =   1'b0;
end

initial
    clk_27m     =   1'b0;
always
    clk_27m     =   # 19 ~clk_27m;
    
initial
    clk_125m    =   1'b0;
always
    clk_125m    =   # 4 ~clk_125m;
 
initial
    clk_100m    =   1'b0;
always
    clk_100m    =   # 5 ~clk_100m;

task cpu_wr;
    input   [11:0]  cpu_waddr;
    input   [15:0]  cpu_wdata;
    begin
        @(posedge clk_100m);
        lbus_we_n    =   1'b1;
        @(posedge clk_100m);
        lbus_we_n    =   1'b0;
        lbus_addr    =   cpu_waddr;
        lbus_wdata   =   cpu_wdata;
        @(posedge clk_100m);
        lbus_we_n    =   1'b1; 
    end
endtask

initial
begin
    lbus_cfg_finished   =   1'b0;
    lbus_we_n           =   1'b1;
    wait(rst==1'b0);
    //pid
    cpu_wr(12'h840,0);          //write channel number
    cpu_wr(12'h800,16'h8014);   //write pid 13'h014,odd key
    //odd key,address 0
    cpu_wr(12'h840,0);          
    cpu_wr(12'h880,16'hFFFF);
    cpu_wr(12'h880,16'hFFFF);
    cpu_wr(12'h880,16'hFFFF);
    cpu_wr(12'h880,16'hFFFF);
    //even key,address 1
    cpu_wr(12'h840,0);          
    cpu_wr(12'h881,16'hFFFF);
    cpu_wr(12'h881,16'hFFFF);
    cpu_wr(12'h881,16'hFFFF);
    cpu_wr(12'h881,16'hFFFF);    
    lbus_cfg_finished   =   1'b1;
end

//initial
//begin:  j83_rdreq_gen
//    j83_rdreq   =   1'b0;
//    wait(lbus_cfg_finished==1'b1);
//    #50000
//    j83_rdreq   =   1'b1;
//end 

reg [8191:0]    shift_reg;
always@(posedge clk_125m or posedge rst_tsgen)   
begin
    if(rst_tsgen==1'b1)
    begin
        shift_reg   <=  {8192{1'b0}};
    end
    else
    begin
        shift_reg   <=  {shift_reg[8190:0],ts_valid};
    end
end
               
scrambler_ts_gen u0_scrambler_ts_gen(
    .rst                                ( rst_tsgen                 ),
    .clk                                ( clk_125m                  ),   
    .ts_sync                            ( ts_sync                   ),
    .ts_valid                           ( ts_valid                  ),
    .ts_eop                             ( ts_eop                    ),
    .ts_data                            ( ts_data                   )
    );
        
ts_scrambler u0_scrambler(
    .clk                                ( clk_125m                  ),
    .rst                                ( rst                       ),
    .clk_cfg                            ( clk_100m                  ),
    .rst_cfg                            ( rst                       ),
    .ts_i_sync                          ( ts_sync                   ),
    .ts_i_valid                         ( ts_valid                  ),
    .ts_i_data                          ( ts_data                   ),
    .j83_rdreq                          ( shift_reg[4095]           ),
    .ts_o_valid                         ( scram_valid               ),
    .ts_o_data                          ( scram_data                ),
    .channel_index                      ( 4'h0                      ),
    .lbus_addr                          ( lbus_addr                 ),
    .lbus_wdata                         ( lbus_wdata                ),
    .lbus_we_n                          ( lbus_we_n                 )
    );
    
//assign  j83_rdreq   =
            
//initial begin
//    $fsdbDumpfile("test_000.fsdb");
//    $fsdbDumpvars;
//end	

endmodule

