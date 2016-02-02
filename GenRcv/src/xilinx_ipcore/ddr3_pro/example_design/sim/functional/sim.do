vlib work

vmap unisims_ver C:/Xilinx/14.7/lib/unisims_ver
vmap unimacro_ver C:/Xilinx/14.7/lib/unimacro_ver
vmap secureip C:/Xilinx/14.7/lib/secureip
vmap xilinxcorelib_ver C:/Xilinx/14.7/lib/xilinxcorelib_ver

vlog  +incdir+. +define+x2Gb +define+sg15E +define+x16 ddr3_model_c1.v
vlog  -f run.f

vsim -t ps -novopt +notimingchecks -L unisims_ver -L secureip work.sim_tb_top glbl

run 40ms
quit