#!/bin/sh

rm -rf simv* csrc DVEfiles AN.DB

echo "Compiling Core Simulation Models"
vlogan +v2k -v2005 \
      ../../../triple_mac.v \
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
      ../../example_design/triple_mac_example_design.v \
      ../triple_mac_frame_typ.v \
      ../demo_tb.v

echo "Elaborating design"
vcs +vcs+lic+wait \
      -y unisims_ver \
      -y unimacro_ver \
      -y simprims_ver \
    -debug -PP \
    demo_tb glbl

echo "Starting simulation"
./simv -ucli -i ucli_commands.key

dve -vpd vcdplus.vpd -session vcs_session.tcl


