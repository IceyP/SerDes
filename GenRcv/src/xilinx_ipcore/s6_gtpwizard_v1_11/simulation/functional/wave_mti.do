###############################################################################
## wave_mti.do
###############################################################################
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {FRAME CHECK MODULE tile0_frame_check0 }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/begin_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/track_data_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/data_error_detected_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/start_of_packet_detected_r
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/RX_DATA
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check0/ERROR_COUNT
add wave -noupdate -divider {FRAME CHECK MODULE tile0_frame_check1 }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/begin_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/track_data_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/data_error_detected_r
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/start_of_packet_detected_r
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/RX_DATA
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/tile0_frame_check1/ERROR_COUNT
add wave -noupdate -divider {TILE0_s6_gtpwizard_v1_11 }
add wave -noupdate -divider {Loopback and Powerdown Ports }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/LOOPBACK0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/LOOPBACK1_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXPOWERDOWN0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXPOWERDOWN1_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXPOWERDOWN0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXPOWERDOWN1_IN
add wave -noupdate -divider {PLL Ports }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/CLK00_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/CLK01_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/GTPRESET0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/GTPRESET1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/PLLLKDET0_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/PLLLKDET1_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RESETDONE0_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RESETDONE1_OUT
add wave -noupdate -divider {Receive Ports - 8b10b Decoder }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCHARISCOMMA0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCHARISCOMMA1_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCHARISK0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCHARISK1_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXDISPERR0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXDISPERR1_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXNOTINTABLE0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXNOTINTABLE1_OUT
add wave -noupdate -divider {Receive Ports - Clock Correction }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCLKCORCNT0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXCLKCORCNT1_OUT
add wave -noupdate -divider {Receive Ports - Comma Detection and Alignment }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXBYTEREALIGN0_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXBYTEREALIGN1_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXENMCOMMAALIGN0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXENMCOMMAALIGN1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXENPCOMMAALIGN0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXENPCOMMAALIGN1_IN
add wave -noupdate -divider {Receive Ports - RX Data Path interface }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXDATA0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXDATA1_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXRESET0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXRESET1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXUSRCLK0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXUSRCLK1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXUSRCLK20_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXUSRCLK21_IN
add wave -noupdate -divider {Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXEQMIX0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXEQMIX1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXN0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXN1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXP0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXP1_IN
add wave -noupdate -divider {Receive Ports - RX Elastic Buffer and Phase Alignment }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXBUFSTATUS0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXBUFSTATUS1_OUT
add wave -noupdate -divider {Receive Ports - RX Polarity Control }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXPOLARITY0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/RXPOLARITY1_IN
add wave -noupdate -divider {TX/RX Datapath Ports }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/GTPCLKOUT0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/GTPCLKOUT1_OUT
add wave -noupdate -divider {Transmit Ports - 8b10b Encoder Control }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXCHARISK0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXCHARISK1_IN
add wave -noupdate -divider {Transmit Ports - TX Buffer and Phase Alignment }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXBUFSTATUS0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXBUFSTATUS1_OUT
add wave -noupdate -divider {Transmit Ports - TX Data Path interface }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXDATA0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXDATA1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXRESET0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXRESET1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXUSRCLK0_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXUSRCLK1_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXUSRCLK20_IN
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXUSRCLK21_IN
add wave -noupdate -divider {Transmit Ports - TX Driver and OOB signalling }
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXN0_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXN1_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXP0_OUT
add wave -noupdate -format Logic /DEMO_TB/s6_gtpwizard_v1_11_top_i/s6_gtpwizard_v1_11_i/tile0_s6_gtpwizard_v1_11_i/TXP1_OUT

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 282
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {5236 ps}
