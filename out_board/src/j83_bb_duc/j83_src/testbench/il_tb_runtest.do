SetActiveLib -work
comp -include "e:\netDriver\works\J83\sim\J83\J83/src/IL/IL.vhd" 
comp -include "$DSN\src\TestBench\il_TB.vhd" 
asim TESTBENCH_FOR_il 
wave 
wave -noreg frame
wave -noreg clk
wave -noreg rst
wave -noreg ce
wave -noreg D
wave -noreg ceo
wave -noreg Q
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$DSN\src\TestBench\il_TB_tim_cfg.vhd" 
# asim TIMING_FOR_il 
