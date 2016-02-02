SetActiveLib -work
comp -include "e:\netDriver\works\J83\sim\J83\J83/src/RS/rsenc.vhd" 
comp -include "$DSN\src\TestBench\rsenc_TB.vhd" 
asim TESTBENCH_FOR_rsenc 
wave 
wave -noreg reset
wave -noreg clk
wave -noreg clear
wave -noreg en
wave -noreg im
wave -noreg din
wave -noreg oe
wave -noreg dout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$DSN\src\TestBench\rsenc_TB_tim_cfg.vhd" 
# asim TIMING_FOR_rsenc 
