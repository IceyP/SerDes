
###############################################################################
## wave_ncsim.sv
###############################################################################

  window new WaveWindow  -name  "Waves for Spartan-6 GTP Wizard Example Design"
  waveform  using  "Waves for Spartan-6 GTP Wizard Example Design"
  
  waveform  add  -label FRAME_CHECK_MODULE -comment tile0_frame_check0
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.begin_r
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.track_data_r
  waveform  add  -siganls  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.data_error_detected_r
  wavefrom  add  -siganls  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.start_of_packet_detected_r
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.RX_DATA
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check0.ERROR_COUNT
  waveform  add  -label FRAME_CHECK_MODULE -comment tile0_frame_check1
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.begin_r
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.track_data_r
  waveform  add  -siganls  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.data_error_detected_r
  wavefrom  add  -siganls  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.start_of_packet_detected_r
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.RX_DATA
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i+delimiter+tile0_frame_check1.ERROR_COUNT

  waveform  add  -label TILE0_s6_gtpwizard_v1_11 -comment TILE0_s6_gtpwizard_v1_11
  waveform  add  -label Loopback_and_Powerdown_Ports  -comment  Loopback_and_Powerdown_Ports
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.LOOPBACK0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.LOOPBACK1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXPOWERDOWN0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXPOWERDOWN1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXPOWERDOWN0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXPOWERDOWN1_IN
  waveform  add  -label PLL_Ports  -comment  PLL_Ports
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.CLK00_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.CLK01_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.GTPRESET0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.GTPRESET1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.PLLLKDET0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.PLLLKDET1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RESETDONE0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RESETDONE1_OUT
  waveform  add  -label Receive_Ports_-_8b10b_Decoder  -comment  Receive_Ports_-_8b10b_Decoder
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCHARISCOMMA0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCHARISCOMMA1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCHARISK0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCHARISK1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXDISPERR0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXDISPERR1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXNOTINTABLE0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXNOTINTABLE1_OUT
  waveform  add  -label Receive_Ports_-_Clock_Correction  -comment  Receive_Ports_-_Clock_Correction
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCLKCORCNT0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXCLKCORCNT1_OUT
  waveform  add  -label Receive_Ports_-_Comma_Detection_and_Alignment  -comment  Receive_Ports_-_Comma_Detection_and_Alignment
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXBYTEREALIGN0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXBYTEREALIGN1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXENMCOMMAALIGN0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXENMCOMMAALIGN1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXENPCOMMAALIGN0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXENPCOMMAALIGN1_IN
  waveform  add  -label Receive_Ports_-_RX_Data_Path_interface  -comment  Receive_Ports_-_RX_Data_Path_interface
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXDATA0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXDATA1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXRESET0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXRESET1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXUSRCLK0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXUSRCLK1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXUSRCLK20_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXUSRCLK21_IN
  waveform  add  -label Receive_Ports_-_RX_Driver,OOB_signalling,Coupling_and_Eq.,CDR  -comment  Receive_Ports_-_RX_Driver,OOB_signalling,Coupling_and_Eq.,CDR
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXEQMIX0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXEQMIX1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXN0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXN1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXP0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXP1_IN
  waveform  add  -label Receive_Ports_-_RX_Elastic_Buffer_and_Phase_Alignment  -comment  Receive_Ports_-_RX_Elastic_Buffer_and_Phase_Alignment
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXBUFSTATUS0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXBUFSTATUS1_OUT
  waveform  add  -label Receive_Ports_-_RX_Polarity_Control  -comment  Receive_Ports_-_RX_Polarity_Control
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXPOLARITY0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.RXPOLARITY1_IN
  waveform  add  -label TX/RX_Datapath_Ports  -comment  TX/RX_Datapath_Ports
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.GTPCLKOUT0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.GTPCLKOUT1_OUT
  waveform  add  -label Transmit_Ports_-_8b10b_Encoder_Control  -comment  Transmit_Ports_-_8b10b_Encoder_Control
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXCHARISK0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXCHARISK1_IN
  waveform  add  -label Transmit_Ports_-_TX_Buffer_and_Phase_Alignment  -comment  Transmit_Ports_-_TX_Buffer_and_Phase_Alignment
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXBUFSTATUS0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXBUFSTATUS1_OUT
  waveform  add  -label Transmit_Ports_-_TX_Data_Path_interface  -comment  Transmit_Ports_-_TX_Data_Path_interface
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXDATA0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXDATA1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXRESET0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXRESET1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXUSRCLK0_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXUSRCLK1_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXUSRCLK20_IN
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXUSRCLK21_IN
  waveform  add  -label Transmit_Ports_-_TX_Driver_and_OOB_signalling  -comment  Transmit_Ports_-_TX_Driver_and_OOB_signalling
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXN0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXN1_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXP0_OUT
  waveform  add  -signals  DEMO_TB.s6_gtpwizard_v1_11_top_i.s6_gtpwizard_v1_11_i.tile0_s6_gtpwizard_v1_11_i.TXP1_OUT

  console submit -using simulator -wait no "run 50 us"

