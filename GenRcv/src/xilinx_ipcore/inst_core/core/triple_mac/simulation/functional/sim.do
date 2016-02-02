vlib work

vmap unisims_ver C:/Xilinx/14.3/lib/unisims_ver
vmap unimacro_ver C:/Xilinx/14.3/lib/unimacro_ver
vmap secureip C:/Xilinx/14.3/lib/secureip
vmap xilinxcorelib_ver C:/Xilinx/14.3/lib/xilinxcorelib_ver

vlog -f run.f
vsim -L unisims_ver -L unimacro_ver -t ps work.demo_tb work.glbl -voptargs="+acc+demo_tb+/demo_tb/dut+/demo_tb/dut/trimac_fifo_block"
run 100ms
quit