vlib work
vmap work work

echo "Compiling Core Simulation Model"
vlog -work work ../../../triple_mac.v

echo "Compiling Example Design"
vlog -work work \
../../example_design/fifo/triple_mac_tx_client_fifo.v \
../../example_design/fifo/triple_mac_rx_client_fifo.v \
../../example_design/fifo/triple_mac_ten_100_1g_eth_fifo.v \
../../example_design/common/triple_mac_reset_sync.v \
../../example_design/common/triple_mac_sync_block.v \
../../example_design/pat_gen/triple_mac_address_swap.v \
../../example_design/pat_gen/triple_mac_axi_mux.v \
../../example_design/pat_gen/triple_mac_axi_pat_gen.v \
../../example_design/pat_gen/triple_mac_axi_pat_check.v \
../../example_design/pat_gen/triple_mac_axi_pipe.v \
../../example_design/pat_gen/triple_mac_basic_pat_gen.v \
../../example_design/physical/triple_mac_rgmii_v2_0_if.v \
../../example_design/axi_lite/triple_mac_axi_lite_sm.v \
../../example_design/axi_ipif/triple_mac_counter_f.v \
../../example_design/axi_ipif/triple_mac_pselect_f.v \
../../example_design/axi_ipif/triple_mac_address_decoder.v \
../../example_design/axi_ipif/triple_mac_slave_attachment.v \
../../example_design/axi_ipif/triple_mac_axi_lite_ipif.v \
../../example_design/axi_ipif/triple_mac_axi4_lite_ipif_wrapper.v \
../../example_design/triple_mac_clk_wiz.v \
../../example_design/triple_mac_block.v \
../../example_design/triple_mac_fifo_block.v \
../../example_design/triple_mac_example_design.v

echo "Compiling Test Bench"
vlog -work work ../triple_mac_frame_typ.v
vlog -work work ../demo_tb.v

echo "Starting simulation"
vsim -L unisims_ver -L unimacro_ver -t ps work.demo_tb work.glbl -voptargs="+acc+demo_tb+/demo_tb/dut+/demo_tb/dut/trimac_fifo_block"
do wave_mti.do
run -all
