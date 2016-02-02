SetActiveLib -work
comp -include "e:\netDriver\works\J83\sim\J83\J83/src/J83Top.vhd" 
comp -include "$DSN\src\TestBench\j83top_TB.vhd" 
asim TESTBENCH_FOR_j83top 
wave 
wave -noreg clk
wave -noreg rst
wave -noreg ren
wave -noreg D
wave -noreg mode
wave -noreg ce
wave -noreg frame
wave -noreg IQ
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$DSN\src\TestBench\j83top_TB_tim_cfg.vhd" 
# asim TIMING_FOR_j83top 
