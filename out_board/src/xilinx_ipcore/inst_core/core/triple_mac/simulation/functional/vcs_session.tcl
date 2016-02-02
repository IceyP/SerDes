gui_open_window Wave
gui_list_select -id Hier.1 { glbl demo_tb }
gui_sg_create TEMAC_Group
gui_list_add_group -id Wave.1 {TEMAC_Group}
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Configuration_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { MDIO_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Rx_RGMII_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Tx_RGMII_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Tx_FIFO_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Rx_FIFO_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Flow_Control }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Rx_Statistics_Vector }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Rx_MAC_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Tx_Statistics_Vector }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { Tx_MAC_Interface }
gui_list_add_divider -id Wave.1 -after TEMAC_Group { System_Signals }

gui_list_add -id Wave.1 -after System_Signals { {demo_tb.reset}  {demo_tb.gtx_clk}}
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_mac_tuser }
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_mac_tlast }
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_mac_tready }
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_mac_tdata }
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_mac_tvalid }
gui_list_add -id Wave.1 -after Tx_MAC_Interface { demo_tb.dut.trimac_fifo_block.tx_mac_resetn }
gui_list_add -id Wave.1 -after Tx_Statistics_Vector { demo_tb.dut.tx_statistics_valid }
gui_list_add -id Wave.1 -after Tx_Statistics_Vector { demo_tb.dut.tx_statistics_vector }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_mac_tuser }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_mac_tlast }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_mac_tdata }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_mac_tvalid }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_mac_resetn }
gui_list_add -id Wave.1 -after Rx_MAC_Interface { demo_tb.dut.trimac_fifo_block.rx_mac_aclk }
gui_list_add -id Wave.1 -after Rx_Statistics_Vector { demo_tb.dut.rx_statistics_valid }
gui_list_add -id Wave.1 -after Rx_Statistics_Vector { demo_tb.dut.rx_statistics_vector }
gui_list_add -id Wave.1 -after Flow_Control { demo_tb.dut.pause_req }
gui_list_add -id Wave.1 -after Flow_Control { demo_tb.dut.pause_val }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tvalid }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tready }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tlast }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_axis_fifo_tdata }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_fifo_resetn }
gui_list_add -id Wave.1 -after Rx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.rx_fifo_clock }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tvalid }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tready }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tlast }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_axis_fifo_tdata }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_fifo_resetn }
gui_list_add -id Wave.1 -after Tx_FIFO_Interface { demo_tb.dut.trimac_fifo_block.tx_fifo_clock }
gui_list_add -id Wave.1 -after Tx_RGMII_Interface { demo_tb.rgmii_txd }
gui_list_add -id Wave.1 -after Tx_RGMII_Interface { demo_tb.rgmii_tx_ctl }
gui_list_add -id Wave.1 -after Tx_RGMII_Interface { demo_tb.rgmii_txc }
gui_list_add -id Wave.1 -after Rx_RGMII_Interface { demo_tb.rgmii_rxd }
gui_list_add -id Wave.1 -after Rx_RGMII_Interface { demo_tb.rgmii_rx_ctl }
gui_list_add -id Wave.1 -after Rx_RGMII_Interface { demo_tb.rgmii_rxc }
gui_list_add -id Wave.1 -after MDIO_Interface { demo_tb.mdio }
gui_list_add -id Wave.1 -after MDIO_Interface { demo_tb.mdc }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_rready  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_rvalid  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_rresp   }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_rdata   }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_arready }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_arvalid }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_araddr  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_bready  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_bvalid  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_bresp   }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_wready  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_wvalid  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_wdata   }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_awready }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_awvalid }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_awaddr  }
gui_list_add -id Wave.1 -after Configuration_Interface { demo_tb.dut.s_axi_aclk }

gui_zoom -window Wave.1 -full
