

 
 
 

 



window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /sdpram_w44d1024_tb/status
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/CLKA
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/ADDRA
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/DINA
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/WEA
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/CLKB
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/ADDRB
      waveform add -signals /sdpram_w44d1024_tb/sdpram_w44d1024_synth_inst/bmg_port/DOUTB

console submit -using simulator -wait no "run"
