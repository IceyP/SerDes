/*************************************************************************************\
    Copyright(c) 2012, China Digital TV Holding Co., Ltd,All right reserved
    Department   :   New Media,R&D Hardware Department
    Filename     :   gbe_rx_filter.v
    Author       :   huangrui/1480
    ==================================================================================
    Description  :   ip首部长度大于5的过滤掉；
    
    ==================================================================================
    Modification History:
    Date        By                  Rev.        Prj.        Change Description
    ----------------------------------------------------------------------------------
    2012-07-12  huangrui/1480       1.0         IPQAM       Create
    ==================================================================================
    Called by    :   gbe_rx_filter.v
    File tree    :   gbe_rx_filter.v
\************************************************************************************/
`timescale 1ns/100ps

module gbe_rx_filter(
    rst                         ,
    clk                         ,
    //input
    mac_i_data                  ,
    mac_i_valid                 ,
    mac_i_last                  ,
    
    //udp filter table
    is_searching                ,
    table_rd_addr               ,
    table_rd_data               ,
    
    //filter ipaddr
    local_ip                    ,
    local_ip2                   ,
    filter_ip_addr1             ,
    filter_ip_addr2             , 
    filter_ip_addr3             ,
    filter_ip_addr4             ,
    filter_ip_addr5             ,
    filter_ip_addr6             , 
    filter_ip_addr7             ,
    filter_ip_addr8             ,
    
    //2'b01:ip_port_match;2'b10:ip_addr_filter_match;2'b11:checksum_err;2'b00:other;
    pkt_type                    ,
    udp_filter_index            ,
    
    gbe_rx_pkt_cnt              ,
    gbe_rx_byte_cnt
    );

parameter   U_DLY                       = 1                         ;
parameter   ST_MAC_WIDTH                = 8                         ;
parameter   ST_MAC_HEAD                 = 8'b00000001               ,
            ST_IP_HEAD                  = 8'b00000010               ,
            ST_NOT_IP                   = 8'b00000100               ,
            ST_UDP_HEAD                 = 8'b00001000               ,
            ST_UDP_SEARCH               = 8'b00010000               ,
            ST_NOT_UDP                  = 8'b00100000               ,
            ST_CHECKSUM_ERR             = 8'b01000000               ,
            ST_UDP_SEARCH_END           = 8'b10000000               ;

input                                   rst                         ;
input                                   clk                         ;

input   [7:0]                           mac_i_data                  ;
input                                   mac_i_valid                 ;
input                                   mac_i_last                  ;

output                                  is_searching                ;
output  [8:0]                           table_rd_addr               ;
input   [63:0]                          table_rd_data               ;

input   [31:0]                          local_ip                    ;
input   [31:0]                          local_ip2                   ;
input   [31:0]                          filter_ip_addr1             ;
input   [31:0]                          filter_ip_addr2             ;
input   [31:0]                          filter_ip_addr3             ;
input   [31:0]                          filter_ip_addr4             ;
input   [31:0]                          filter_ip_addr5             ;
input   [31:0]                          filter_ip_addr6             ;
input   [31:0]                          filter_ip_addr7             ;
input   [31:0]                          filter_ip_addr8             ;

output  [1:0]                           pkt_type                    ;
output  [15:0]                          udp_filter_index            ;

output  [31:0]                          gbe_rx_pkt_cnt              ;
output  [31:0]                          gbe_rx_byte_cnt             ;

reg     [11:0]                          mac_rx_frmlen_reg           ;

reg     [ST_MAC_WIDTH - 1 : 0]          st_mac_curr /* synthesis syn_encoding = "safe,onehot" */;
reg     [ST_MAC_WIDTH - 1 : 0]          st_mac_next                 ;          

reg     [47:0]                          dst_mac                     ;
reg     [47:0]                          src_mac                     ;
reg     [15:0]                          eth_type                    ;
reg     [3:0]                           ip_ver                      ;
reg     [3:0]                           ip_head_length              ;
reg     [15:0]                          ip_total_len                ;
reg     [7:0]                           ip_protocol                 ;
reg     [15:0]                          ip_head_checksum            ;
reg     [31:0]                          src_ip                      ;
reg     [31:0]                          dst_ip                      ;
reg     [15:0]                          src_port                    ;
reg     [15:0]                          dst_port                    ;
reg     [15:0]                          udp_pkt_len                 ;   //udp head + udp data(bytes)
reg     [15:0]                          udp_head_checksum           ;
reg     [1:0]                           pkt_type                    ;

wire    [15:0]                          ip_chksum_result            ;
wire    [15:0]                          udp_chksum_result           ;

reg                                     is_searching                ;
reg     [8:0]                           table_rd_addr               ;
reg     [7:0]                           search_cnt                  ;
reg     [47:0]                          ip_port_data                ;
reg                                     ip_port_match               ;
reg     [3:0]                           search_num                  ;
reg                                     ip_addr_filter_ok           ;
wire                                    ip_addr_filter_ok_flag      ;

reg     [31:0]                          gbe_rx_pkt_cnt              ;
reg     [31:0]                          gbe_rx_byte_cnt             ;
reg     [15:0]                          udp_filter_index            ;
reg     [15:0]                          port_index                  ;
reg     [8:0]                           temp_data                   ;

//ip checksum
wire                                    ip_chksum_data_val          ;
wire    [15:0]                          ip_chksum_data              ;
wire                                    ip_chksum_start             ;
wire                                    ip_chksum_end               ;
wire    [31:0]                          ip_chksum_init_value        ;

//udp checksum
wire                                    udp_chksum_data_val         ;
wire    [15:0]                          udp_chksum_data             ;
wire                                    udp_chksum_start            ;
wire                                    udp_chksum_end              ;
wire    [31:0]                          udp_chksum_init_value       ;

reg     [15:0]                          ip_chksum_data_1dly         ;
reg     [15:0]                          udp_chksum_data_1dly        ;
wire    [7:0]                           ipaddr_match_t              ;

reg                                     arp_flag                    ;
reg     [31:0]                          arp_dst_ip                  ;

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        mac_rx_frmlen_reg   <=  12'h000;
    end
    else if(mac_i_last==1'b1)
    begin
        mac_rx_frmlen_reg   <=  #U_DLY 12'h000;
    end
    else if(mac_i_valid==1'b1)
    begin
        mac_rx_frmlen_reg   <=  #U_DLY mac_rx_frmlen_reg + 12'h001;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        st_mac_curr <=  ST_MAC_HEAD;
    end
    else
    begin
        st_mac_curr <=  #U_DLY st_mac_next;
    end
end

always@*
begin
    case(st_mac_curr)
    ST_MAC_HEAD:
    begin
        if((mac_i_valid==1'b1) && (mac_rx_frmlen_reg==12'd13))
        begin
            if((eth_type[15:8]==8'h08) && (mac_i_data==8'h00))
            begin
                st_mac_next =   ST_IP_HEAD;
            end
            else
            begin
                st_mac_next =   ST_NOT_IP;
            end
        end
        else
        begin
            st_mac_next =   ST_MAC_HEAD;
        end
    end
    ST_NOT_IP:
    begin
        if(mac_i_last==1'b1)
        begin
            st_mac_next =   ST_MAC_HEAD;
        end
        else
        begin
            st_mac_next =   ST_NOT_IP;
        end
    end
    ST_IP_HEAD:
    begin
        if((mac_i_valid==1'b1) && (mac_rx_frmlen_reg==12'd33))
        begin
            if((|ip_head_checksum!=1'b0) && (|ip_chksum_result != 1'b0))
            begin
                st_mac_next =   ST_CHECKSUM_ERR;
            end
            else if((ip_ver==4'h4) && (ip_head_length==4'h5) && (ip_protocol==8'h11))
            begin
                st_mac_next =   ST_UDP_HEAD;
            end
            else
            begin
                st_mac_next =   ST_NOT_UDP;
            end
        end
        else
        begin
            st_mac_next =   ST_IP_HEAD;
        end
    end
    ST_NOT_UDP:
    begin
        if(mac_i_last==1'b1)
        begin
            st_mac_next =   ST_MAC_HEAD;
        end
        else
        begin
            st_mac_next =   ST_NOT_UDP;
        end
    end
    ST_UDP_HEAD:
    begin
        if((mac_i_valid==1'b1) && (mac_rx_frmlen_reg==12'd41))
        begin
            if(udp_pkt_len < 196)   //at least one TS packet
            begin
                st_mac_next =   ST_UDP_SEARCH_END;
            end
            else
            begin
                st_mac_next =   ST_UDP_SEARCH;
            end
        end
        else
        begin
            st_mac_next =   ST_UDP_HEAD;
        end
    end
    ST_UDP_SEARCH:
    begin
        if((search_num>=4'hb) || (ip_port_match==1'b1))
        begin
            st_mac_next =   ST_UDP_SEARCH_END;
        end
        else
        begin
            st_mac_next =   ST_UDP_SEARCH;
        end
    end
    ST_UDP_SEARCH_END:
    begin
        if(mac_i_last==1'b1)
        begin
            st_mac_next =   ST_MAC_HEAD;
        end
        else
        begin
            st_mac_next =   ST_UDP_SEARCH_END;
        end
    end
    ST_CHECKSUM_ERR:
    begin
        if(mac_i_last==1'b1)
        begin
            st_mac_next =   ST_MAC_HEAD;
        end
        else
        begin
            st_mac_next =   ST_CHECKSUM_ERR;
        end
    end
    default:
    begin
        st_mac_next =   ST_MAC_HEAD;
    end
    endcase
end

//mac_head        
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        dst_mac     <=  {48{1'b0}};
        src_mac     <=  {48{1'b0}};
        eth_type    <=  {16{1'b0}};
    end
    else if(mac_i_valid==1'b1)
    begin
        if(st_mac_curr==ST_MAC_HEAD)
        begin
            case(mac_rx_frmlen_reg)
            12'd0:  dst_mac[47:40]      <=  #U_DLY mac_i_data;
            12'd1:  dst_mac[39:32]      <=  #U_DLY mac_i_data;
            12'd2:  dst_mac[31:24]      <=  #U_DLY mac_i_data;
            12'd3:  dst_mac[23:16]      <=  #U_DLY mac_i_data;
            12'd4:  dst_mac[15:8]       <=  #U_DLY mac_i_data;
            12'd5:  dst_mac[7:0]        <=  #U_DLY mac_i_data;
            12'd6:  src_mac[47:40]      <=  #U_DLY mac_i_data;
            12'd7:  src_mac[39:32]      <=  #U_DLY mac_i_data;
            12'd8:  src_mac[31:24]      <=  #U_DLY mac_i_data;
            12'd9:  src_mac[23:16]      <=  #U_DLY mac_i_data;
            12'd10: src_mac[15:8]       <=  #U_DLY mac_i_data;
            12'd11: src_mac[7:0]        <=  #U_DLY mac_i_data;
            12'd12: eth_type[15:8]      <=  #U_DLY mac_i_data;
            12'd13: eth_type[7:0]       <=  #U_DLY mac_i_data;
            default:;
            endcase
        end
        else if(mac_i_last==1'b1)
        begin
            dst_mac     <=  #U_DLY {48{1'b0}};
            src_mac     <=  #U_DLY {48{1'b0}};
            eth_type    <=  #U_DLY {16{1'b0}};
        end
    end
end

//ip head
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ip_ver          <=  4'h0;
        ip_head_length  <=  4'h0;
        ip_total_len    <=  16'h0000;
        ip_protocol     <=  8'h00;
        ip_head_checksum<=  16'h0000;
        src_ip          <=  32'h00000000;
        dst_ip          <=  32'h00000001;
    end
    else if(mac_i_valid==1'b1)
    begin
        if(st_mac_curr==ST_IP_HEAD)
        begin
            case(mac_rx_frmlen_reg)
            12'd14: 
            begin
                ip_ver                  <=  #U_DLY mac_i_data[7:4];
                ip_head_length          <=  #U_DLY mac_i_data[3:0];
            end
            12'd16: ip_total_len[15:8]  <=  #U_DLY mac_i_data;
            12'd17: ip_total_len[7:0]   <=  #U_DLY mac_i_data;   
            12'd23: ip_protocol         <=  #U_DLY mac_i_data;
            12'd24: ip_head_checksum[15:8]<=#U_DLY mac_i_data;
            12'd25: ip_head_checksum[7:0] <=#U_DLY mac_i_data;
            12'd26: src_ip[31:24]       <=  #U_DLY mac_i_data;
            12'd27: src_ip[23:16]       <=  #U_DLY mac_i_data;
            12'd28: src_ip[15:8]        <=  #U_DLY mac_i_data;
            12'd29: src_ip[7:0]         <=  #U_DLY mac_i_data;
            12'd30: dst_ip[31:24]       <=  #U_DLY mac_i_data;
            12'd31: dst_ip[23:16]       <=  #U_DLY mac_i_data;
            12'd32: dst_ip[15:8]        <=  #U_DLY mac_i_data;
            12'd33: dst_ip[7:0]         <=  #U_DLY mac_i_data;
            default:;
            endcase
        end
        else if(mac_i_last==1'b1)
        begin
            ip_ver          <=  #U_DLY 4'h0;
            ip_head_length  <=  #U_DLY 4'h0;
            ip_total_len    <=  #U_DLY 16'h0000;
            ip_protocol     <=  #U_DLY 8'h00;
            ip_head_checksum<=  #U_DLY 16'h0000;
            src_ip          <=  #U_DLY 32'h00000000;
            dst_ip          <=  #U_DLY 32'h00000001;
        end
    end
end

//udp head
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        src_port            <=  16'h0000;
        dst_port            <=  16'h0000;
        udp_pkt_len         <=  16'h0000;
        udp_head_checksum   <=  16'h0000;
    end
    else if(mac_i_valid==1'b1)
    begin
        if(st_mac_curr==ST_UDP_HEAD)
        begin
            case(mac_rx_frmlen_reg)
            12'd34: src_port[15:8]      <=  #U_DLY mac_i_data;
            12'd35: src_port[7:0]       <=  #U_DLY mac_i_data;
            12'd36: dst_port[15:8]      <=  #U_DLY mac_i_data;
            12'd37: dst_port[7:0]       <=  #U_DLY mac_i_data;
            12'd38: udp_pkt_len[15:8]   <=  #U_DLY mac_i_data;
            12'd39: udp_pkt_len[7:0]    <=  #U_DLY mac_i_data;
            12'd40: udp_head_checksum[15:8]<=#U_DLY mac_i_data;
            12'd41: udp_head_checksum[7:0] <=#U_DLY mac_i_data;
            default:;
            endcase
        end
        else if(mac_i_last==1'b1)
        begin
            src_port            <=  #U_DLY 16'h0000;
            dst_port            <=  #U_DLY 16'h0000;
            udp_pkt_len         <=  #U_DLY 16'h0000;
            udp_head_checksum   <=  #U_DLY 16'h0000;
        end
    end
end

//dst_ip & dst_port filter 
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        search_cnt  <=  8'h00;
    end
    else if(st_mac_curr==ST_UDP_SEARCH)
    begin
        search_cnt  <=  #U_DLY search_cnt + 8'h01;
    end
    else
    begin
        search_cnt  <=  #U_DLY 8'h00;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        is_searching    <=  1'b0;
    end
    else if(st_mac_curr==ST_UDP_SEARCH)
    begin
        is_searching    <=  #U_DLY 1'b1;
    end
    else
    begin
        is_searching    <=  #U_DLY 1'b0;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ip_port_data    <=  {48{1'b0}};
    end
    else
    begin
        ip_port_data    <=  {dst_port[15:0],dst_ip[31:0]};
    end
end
   
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        table_rd_addr   <=  9'd0;
        ip_port_match   <=  1'b0;
        search_num      <=  4'h0;
        port_index      <=  16'h0000;
    end
    else if(st_mac_curr==ST_MAC_HEAD)
    begin
        table_rd_addr   <=  #U_DLY 9'd0;
        ip_port_match   <=  #U_DLY 1'b0;
        search_num      <=  #U_DLY 4'h0;
        port_index      <=  #U_DLY 16'h0000;
    end
    else if(st_mac_curr==ST_UDP_SEARCH)
    begin
        if(search_cnt==8'h01)
        begin
            table_rd_addr   <=  #U_DLY  9'd255;
            search_num      <=  #U_DLY  4'h1;
        end
        else if(search_cnt==search_num * 4 + 1)
        begin
            if(table_rd_data[47:0]>ip_port_data)
            begin
                if(table_rd_addr==9'd0)
                begin
                    table_rd_addr   <=  #U_DLY 9'd0;
                end
                else
                begin
                    table_rd_addr   <=  #U_DLY table_rd_addr - temp_data;
                end
                search_num      <=  #U_DLY search_num + 4'h1;
            end
            else if(table_rd_data[47:0]<ip_port_data)
            begin
                table_rd_addr   <=  #U_DLY table_rd_addr + temp_data;
                search_num      <=  #U_DLY search_num + 4'h1;
            end
            else
            begin
                port_index      <=  #U_DLY table_rd_data[63:48];
                ip_port_match   <=  #U_DLY 1'b1;
                table_rd_addr   <=  #U_DLY 9'd0;
                search_num      <=  #U_DLY 4'h0;
            end
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
         temp_data  <=  {9{1'b0}};
    end
    else
    begin
        case(search_num)
        4'h1:   temp_data   <=  #U_DLY 9'd128;
        4'h2:   temp_data   <=  #U_DLY 9'd64;
        4'h3:   temp_data   <=  #U_DLY 9'd32;
        4'h4:   temp_data   <=  #U_DLY 9'd16;
        4'h5:   temp_data   <=  #U_DLY 9'd8;
        4'h6:   temp_data   <=  #U_DLY 9'd4;
        4'h7:   temp_data   <=  #U_DLY 9'd2;
        4'h8:   temp_data   <=  #U_DLY 9'd1;
        4'h9:   temp_data   <=  #U_DLY 9'd1;
        default:temp_data   <=  #U_DLY 9'd0;
        endcase
    end
end           

////////////////////////////////////////////////////////////////////    
//ARP pkt filter
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        arp_flag    <=  1'b0;
    end
    else if(mac_i_last==1'b1)
    begin
        arp_flag    <=  #U_DLY 1'b0;
    end
    else if((mac_i_valid==1'b1) && (mac_rx_frmlen_reg==12'd14))
    begin
        if(eth_type==16'h0806)
        begin
            arp_flag    <=  #U_DLY 1'b1;
        end
        else
        begin
            arp_flag    <=  #U_DLY 1'b0;
        end
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        arp_dst_ip  <=  {32{1'b0}};
    end
    else if(mac_i_last==1'b1)
    begin
        arp_dst_ip  <=  #U_DLY {32{1'b0}};
    end
    else if((mac_i_valid==1'b1) && (arp_flag==1'b1))
    begin
        case(mac_rx_frmlen_reg)
        12'd38: arp_dst_ip[31:24]   <=  #U_DLY mac_i_data;
        12'd39: arp_dst_ip[23:16]   <=  #U_DLY mac_i_data;
        12'd40: arp_dst_ip[15:8]    <=  #U_DLY mac_i_data;
        12'd41: arp_dst_ip[7:0]     <=  #U_DLY mac_i_data;
        default:;
        endcase
    end
end
    
assign  ipaddr_match_t[0]       =   (dst_ip==filter_ip_addr1)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[1]       =   (dst_ip==filter_ip_addr2)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[2]       =   (dst_ip==filter_ip_addr3)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[3]       =   (dst_ip==filter_ip_addr4)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[4]       =   (dst_ip==filter_ip_addr5)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[5]       =   (dst_ip==filter_ip_addr6)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[6]       =   (dst_ip==filter_ip_addr7)   ?   1'b1    :   1'b0;
assign  ipaddr_match_t[7]       =   (dst_ip==filter_ip_addr8)   ?   1'b1    :   1'b0;

assign  ip_addr_filter_ok_flag  =   |(ipaddr_match_t[7:0]);                                                     

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ip_addr_filter_ok   <=  1'b0;
    end
    else
    begin
        ip_addr_filter_ok   <=  #U_DLY ip_addr_filter_ok_flag;
    end
end

////////////////////////////////////////////////////////////////////
//pkt_type:
//          2'b01:ip_port_match;
//          2'b10:ip_addr_filter_match;
//          2'b11:checksum_err;
//          2'b00:other;
////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        pkt_type    <=  2'b00;
    end  
    else if(mac_i_last==1'b1)
    begin
        if((st_mac_curr==ST_UDP_SEARCH_END) && (|udp_head_checksum!=1'b0) && (|udp_chksum_result != 1'b0))
        begin
            pkt_type    <=  #U_DLY 2'b11;
        end
        else if((st_mac_curr==ST_UDP_SEARCH_END) && (udp_pkt_len < 196))      //at least one TS packet
        begin
            pkt_type    <=  #U_DLY 2'b00;
        end
        else if((ip_port_match==1'b1) && 
            ((|udp_head_checksum==1'b0) || 
            ((|udp_head_checksum != 1'b0) && (|udp_chksum_result==1'b0))))
        begin
            pkt_type    <=  #U_DLY 2'b01;
        end
        else if(st_mac_curr==ST_CHECKSUM_ERR)
        begin
            pkt_type    <=  #U_DLY 2'b11;
        end
        else if(((arp_flag==1'b1) && ((arp_dst_ip==local_ip) || (arp_dst_ip==local_ip2))) || 
                ((ip_addr_filter_ok==1'b1) && (st_mac_curr==ST_NOT_UDP)))
        begin
            pkt_type    <=  #U_DLY 2'b10;
        end
        else
        begin
            pkt_type    <=  #U_DLY 2'b00;
        end
    end
    else
    begin
        pkt_type    <=  #U_DLY 2'b00;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udp_filter_index    <=  16'h0000;
    end
    else if((mac_i_last==1'b1) && (ip_port_match==1'b1))
    begin
        udp_filter_index    <=  #U_DLY port_index;
    end
    else
    begin
        udp_filter_index    <=  #U_DLY 16'h0000;    
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        gbe_rx_pkt_cnt  <=  {32{1'b0}};
    end
    else if(mac_i_last==1'b1)
    begin
        gbe_rx_pkt_cnt  <=  #U_DLY gbe_rx_pkt_cnt + 32'h1;
    end
end

always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        gbe_rx_byte_cnt <=  {32{1'b0}};
    end
    else if(mac_i_valid==1'b1)
    begin
        gbe_rx_byte_cnt <=  #U_DLY gbe_rx_byte_cnt + 32'h1;
    end
end

//------------------------------------------------------------------
//ip_chksum_result
//------------------------------------------------------------------
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        ip_chksum_data_1dly <=  16'h0000;
    end
    else
    begin
        ip_chksum_data_1dly <=  #U_DLY ip_chksum_data;
    end
end

assign  ip_chksum_data_val  =   ((mac_rx_frmlen_reg[0]==1'b1) && (mac_i_valid==1'b1) && 
                                (st_mac_curr==ST_IP_HEAD)) ?   1'b1    :   1'b0;

assign  ip_chksum_data      =   (mac_rx_frmlen_reg[0]==1'b1)    ?   {ip_chksum_data_1dly[15:8],mac_i_data[7:0]}  :   
                                {mac_i_data[7:0],ip_chksum_data_1dly[7:0]};
                            
assign  ip_chksum_start     =   ((mac_i_valid==1'b1) && (st_mac_curr==ST_IP_HEAD) && 
                                (mac_rx_frmlen_reg==14))    ?   1'b1    :   1'b0;
                            
assign  ip_chksum_end       =   ((mac_i_valid==1'b1) && (st_mac_curr==ST_IP_HEAD) && 
                                (mac_rx_frmlen_reg==33))    ?   1'b1    :   1'b0;

assign  ip_chksum_init_value=   {32{1'b0}};
                            
chksum_calc #(
    .U_DLY                              ( U_DLY                     )
    )
u0_iphead_chksum(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .chk_start                          ( ip_chksum_start           ),
    .init_value                         ( ip_chksum_init_value      ),
    .data_val                           ( ip_chksum_data_val        ),
    .data_in                            ( ip_chksum_data            ),
    .chk_end                            ( ip_chksum_end             ),
    .result                             ( ip_chksum_result          )
    );

//------------------------------------------------------------------
//udp_chksum_result
//------------------------------------------------------------------
always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        udp_chksum_data_1dly    <=  16'h0000;
    end
    else
    begin
        udp_chksum_data_1dly    <=  #U_DLY udp_chksum_data;
    end
end

assign  udp_chksum_data_val =   ((mac_rx_frmlen_reg[0]==1'b1) && (mac_i_valid==1'b1) && 
                                ((st_mac_curr==ST_UDP_HEAD) || (st_mac_curr==ST_UDP_SEARCH) 
                                || (st_mac_curr==ST_UDP_SEARCH_END))) ?   1'b1    :   1'b0;

assign  udp_chksum_data     =   (mac_rx_frmlen_reg[0]==1'b1)    ?   {udp_chksum_data_1dly[15:8],mac_i_data[7:0]}  :   
                                {mac_i_data[7:0],udp_chksum_data_1dly[7:0]};

assign  udp_chksum_start    =   ((mac_i_valid==1'b1) && (st_mac_curr==ST_UDP_HEAD) && 
                                (mac_rx_frmlen_reg==34))    ?   1'b1    :   1'b0;

assign  udp_chksum_end      =   mac_i_last;

//multi-cycle:at least 4 cycle
assign  udp_chksum_init_value=  src_ip[31:16] + src_ip[15:0] + 
                                dst_ip[31:16] + dst_ip[15:0] + 
                                ip_protocol[7:0] + ip_total_len[15:0] - 
                                (ip_head_length << 2);

chksum_calc #(
    .U_DLY                              ( U_DLY                     )
    )
u0_udphead_chksum(
    .clk                                ( clk                       ),
    .rst                                ( rst                       ),
    .chk_start                          ( udp_chksum_start          ),
    .init_value                         ( udp_chksum_init_value     ),
    .data_val                           ( udp_chksum_data_val       ),
    .data_in                            ( udp_chksum_data           ),
    .chk_end                            ( udp_chksum_end            ),
    .result                             ( udp_chksum_result         )
    );
                                                                                                  
endmodule
