set_false_path -through [get_nets rstn_sys]
set_property LOC Y20 [get_ports rstn_sys]
set_property IOSTANDARD LVCMOS33 [get_ports rstn_sys]
set_property LOC Y23 [get_ports clk_27m]
set_property IOSTANDARD LVCMOS33 [get_ports clk_27m]

set_property LOC U24 [get_ports sfp_main_mod_def0]
set_property IOSTANDARD LVCMOS33 [get_ports sfp_main_mod_def0]
set_property LOC W25 [get_ports sfp_backup_mod_def0]
set_property IOSTANDARD LVCMOS33 [get_ports sfp_backup_mod_def0]
set_property LOC V23 [get_ports sfp_main_tx_disable]
set_property IOSTANDARD LVCMOS33 [get_ports sfp_main_tx_disable]
set_property LOC W21 [get_ports sfp_backup_tx_disable]
set_property IOSTANDARD LVCMOS33 [get_ports sfp_backup_tx_disable]

##Net sfp_main_los                LOC = V22   | IOSTANDARD = LVCMOS33;
##Net sfp_main_tx_fault           LOC = V24   | IOSTANDARD = LVCMOS33;
##Net sfp_main_mod_def2           LOC = U25   | IOSTANDARD = LVCMOS33;
##Net sfp_main_mod_def1           LOC = U26   | IOSTANDARD = LVCMOS33;
##Net sfp_backup_los              LOC = W26   | IOSTANDARD = LVCMOS33;
##Net sfp_backup_tx_fault         LOC = AA25  | IOSTANDARD = LVCMOS33;
##Net sfp_backup_mod_def2         LOC = V21   | IOSTANDARD = LVCMOS33;
##Net sfp_backup_mod_def1         LOC = AB25  | IOSTANDARD = LVCMOS33;                                              
####ADF4350
##Net adf4350_lock_det            LOC = AA23  | IOSTANDARD = LVCMOS33;
##Net adf4350_muxout              LOC = AC23  | IOSTANDARD = LVCMOS33;

set_property LOC AA22 [get_ports adf4350_ce]
set_property IOSTANDARD LVCMOS33 [get_ports adf4350_ce]
set_property LOC Y22 [get_ports adf4350_clk]
set_property IOSTANDARD LVCMOS33 [get_ports adf4350_clk]
set_property LOC AC24 [get_ports adf4350_data]
set_property IOSTANDARD LVCMOS33 [get_ports adf4350_data]
set_property LOC AB24 [get_ports adf4350_le]
set_property IOSTANDARD LVCMOS33 [get_ports adf4350_le]

set_property LOC AC21 [get_ports max2066_sp_sel]
set_property IOSTANDARD LVCMOS33 [get_ports max2066_sp_sel]
set_property LOC AD24 [get_ports {max2066_par_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {max2066_par_data[0]}]
set_property LOC AF24 [get_ports {max2066_par_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {max2066_par_data[1]}]
set_property LOC AB22 [get_ports {max2066_par_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {max2066_par_data[2]}]
set_property LOC AC22 [get_ports {max2066_par_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {max2066_par_data[3]}]
set_property LOC AD23 [get_ports {max2066_par_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {max2066_par_data[4]}]

##
####CPU IIC
##Net cpu_sda                     LOC = AD25  | IOSTANDARD = LVCMOS33;
##Net cpu_scl                     LOC = AE25  | IOSTANDARD = LVCMOS33;
##
####CPU SPI
##Net cpu_spi_cs                  LOC = AD26  | IOSTANDARD = LVCMOS33;
##Net cpu_spi_miso                LOC = AE26  | IOSTANDARD = LVCMOS33;
##Net cpu_spi_mosi                LOC = W20   | IOSTANDARD = LVCMOS33;
##Net cpu_spi_clk                 LOC = AC26  | IOSTANDARD = LVCMOS33;
##
####master control board,TEST
##Net master_board_test<0>        LOC = AE22  | IOSTANDARD = LVCMOS33;
##Net master_board_test<1>        LOC = AF22  | IOSTANDARD = LVCMOS33;

####AD9739A,spi cfg interface
##Net dac_irq                     LOC = W23   | IOSTANDARD = LVCMOS33;
##Net dac_spi_sdo                 LOC = AB26  | IOSTANDARD = LVCMOS33;

set_property LOC W24 [get_ports dac_reset]
set_property IOSTANDARD LVCMOS33 [get_ports dac_reset]
set_property LOC AF23 [get_ports dac_spi_clk]
set_property IOSTANDARD LVCMOS33 [get_ports dac_spi_clk]
set_property LOC Y25 [get_ports dac_spi_csn]
set_property IOSTANDARD LVCMOS33 [get_ports dac_spi_csn]
set_property LOC Y26 [get_ports dac_spi_sdio]
set_property IOSTANDARD LVCMOS33 [get_ports dac_spi_sdio]

############################2.5V,bank 13############################
## phy constraint
set_property LOC P23 [get_ports sys_clk_25m]
set_property IOSTANDARD LVCMOS25 [get_ports sys_clk_25m]
set_false_path -through [get_nets rstn_phymain]
set_property LOC N19 [get_ports rstn_phymain]
set_property IOSTANDARD LVCMOS25 [get_ports rstn_phymain]
set_false_path -through [get_nets rstn_phybackup]
set_property LOC P18 [get_ports rstn_phybackup]
set_property IOSTANDARD LVCMOS25 [get_ports rstn_phybackup]
set_property LOC K25 [get_ports {phy_main_rgmii_txd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_txd[0]}]
set_property LOC M21 [get_ports {phy_main_rgmii_txd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_txd[1]}]
set_property LOC K26 [get_ports {phy_main_rgmii_txd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_txd[2]}]
set_property LOC M20 [get_ports {phy_main_rgmii_txd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_txd[3]}]
set_property LOC R26 [get_ports phy_main_rgmii_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_rgmii_tx_ctl]
set_property LOC N22 [get_ports phy_main_rgmii_txc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_rgmii_txc]
set_property LOC L25 [get_ports {phy_main_rgmii_rxd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_rxd[0]}]
set_property LOC M25 [get_ports {phy_main_rgmii_rxd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_rxd[1]}]
set_property LOC N26 [get_ports {phy_main_rgmii_rxd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_rxd[2]}]
set_property LOC L24 [get_ports {phy_main_rgmii_rxd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_main_rgmii_rxd[3]}]
set_property LOC P25 [get_ports phy_main_rgmii_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_rgmii_rx_ctl]
set_property LOC N21 [get_ports phy_main_rgmii_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_rgmii_rxc]
set_property LOC M19 [get_ports phy_main_mdio]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_mdio]
set_property LOC M22 [get_ports phy_main_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_mdc]
set_property LOC N16 [get_ports phy_main_led1000]
set_property IOSTANDARD LVCMOS25 [get_ports phy_main_led1000]

set_property LOC T25 [get_ports {phy_backup_rgmii_txd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_txd[0]}]
set_property LOC P24 [get_ports {phy_backup_rgmii_txd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_txd[1]}]
set_property LOC P20 [get_ports {phy_backup_rgmii_txd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_txd[2]}]
set_property LOC P19 [get_ports {phy_backup_rgmii_txd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_txd[3]}]
set_property LOC R17 [get_ports phy_backup_rgmii_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_rgmii_tx_ctl]
set_property LOC R22 [get_ports phy_backup_rgmii_txc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_rgmii_txc]
set_property LOC U20 [get_ports {phy_backup_rgmii_rxd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_rxd[0]}]
set_property LOC R20 [get_ports {phy_backup_rgmii_rxd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_rxd[1]}]
set_property LOC T20 [get_ports {phy_backup_rgmii_rxd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_rxd[2]}]
set_property LOC T19 [get_ports {phy_backup_rgmii_rxd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {phy_backup_rgmii_rxd[3]}]
set_property LOC U17 [get_ports phy_backup_rgmii_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_rgmii_rx_ctl]
set_property LOC R21 [get_ports phy_backup_rgmii_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_rgmii_rxc]
set_property LOC T23 [get_ports phy_backup_mdio]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_mdio]
set_property LOC R18 [get_ports phy_backup_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_mdc]
set_property LOC R16 [get_ports phy_backup_led1000]
set_property IOSTANDARD LVCMOS25 [get_ports phy_backup_led1000]

##Net phy_main_int_b              LOC = N18   | IOSTANDARD = LVCMOS25;
##Net phy_main_crs                LOC = R25   | IOSTANDARD = LVCMOS25;
##Net phy_main_col                LOC = N17   | IOSTANDARD = LVCMOS25;
##Net phy_backup_int_b            LOC = T22   | IOSTANDARD = LVCMOS25;
##Net phy_backup_crs              LOC = P16   | IOSTANDARD = LVCMOS25;
##Net phy_backup_col              LOC = U16   | IOSTANDARD = LVCMOS25;

create_clock -name phy_main_rgmii_rxc -period 8.000 [get_ports phy_main_rgmii_rxc]
create_clock -name phy_backup_rgmii_rxc -period 8.000 [get_ports phy_backup_rgmii_rxc]
create_clock -name clk_27m -period 37.037 [get_ports clk_27m]

############################################################
# FIFO Clock Crossing Constraints                          #
############################################################
###set_max_delay 10.000 -from [get_cells *user_side_FIFO/tx_fifo_i/rd_addr_txfer*] -to [get_cells *user_side_FIFO/tx_fifo_i/wr_rd_addr*]
set_property SLEW FAST [get_ports {phy_main_rgmii_txd[0]}]
set_property SLEW FAST [get_ports {phy_main_rgmii_txd[1]}]
set_property SLEW FAST [get_ports {phy_main_rgmii_txd[2]}]
set_property SLEW FAST [get_ports {phy_main_rgmii_txd[3]}]
set_property SLEW FAST [get_ports phy_main_rgmii_tx_ctl]
set_property SLEW FAST [get_ports phy_main_rgmii_txc]
set_property SLEW FAST [get_ports {phy_backup_rgmii_txd[0]}]
set_property SLEW FAST [get_ports {phy_backup_rgmii_txd[1]}]
set_property SLEW FAST [get_ports {phy_backup_rgmii_txd[2]}]
set_property SLEW FAST [get_ports {phy_backup_rgmii_txd[3]}]
set_property SLEW FAST [get_ports phy_backup_rgmii_tx_ctl]
set_property SLEW FAST [get_ports phy_backup_rgmii_txc]

############################################################
# RGMII: IODELAY Constraints
############################################################
set_property IDELAY_VALUE 12 [get_cells u0_gbe_top/u0_gbe_phy_mux/main_rgmii/delay_rgmii_rx_ctl]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[3].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[2].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[1].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[0].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/delay_rgmii_rx_ctl]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[3].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[2].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[1].delay_rgmii_rxd}]
set_property IDELAY_VALUE 12 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[0].delay_rgmii_rxd}]

set_property IODELAY_GROUP grp1 [get_cells u0_gbe_top/u0_gbe_phy_mux/main_rgmii/delay_rgmii_rx_ctl]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[0].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[1].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[2].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/main_rgmii/rxdata_bus[3].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/delay_rgmii_rx_ctl]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[0].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[1].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[2].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells {u0_gbe_top/u0_gbe_phy_mux/backup_rgmii/rxdata_bus[3].delay_rgmii_rxd}]
set_property IODELAY_GROUP grp1 [get_cells u0_gbe_top/u0_gbe_mac/trimac_fifo_block/trimac_block/dlyctrl]

############################################################
# For Setup and Hold time analysis on RGMII inputs         #
############################################################
set_input_delay -clock [get_clocks phy_main_rgmii_rxc] -max 6.500 -add_delay [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]]
set_input_delay -clock [get_clocks phy_main_rgmii_rxc] -min 1.500 -add_delay [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]]
set_false_path -rise_from [get_clocks phy_main_rgmii_rxc] -through [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]] -fall_to [get_clocks phy_main_rgmii_rxc]
set_input_delay -clock [get_clocks phy_main_rgmii_rxc] -max 6.500 -add_delay [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]] -clock_fall
set_input_delay -clock [get_clocks phy_main_rgmii_rxc] -min 1.500 -add_delay [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]] -clock_fall
set_false_path -fall_from [get_clocks phy_main_rgmii_rxc] -through [get_ports [list phy_main_rgmii_rx_ctl {phy_main_rgmii_rxd[3]} {phy_main_rgmii_rxd[2]} {phy_main_rgmii_rxd[1]} {phy_main_rgmii_rxd[0]}]] -rise_to [get_clocks phy_main_rgmii_rxc]
set_input_delay -clock [get_clocks phy_backup_rgmii_rxc] -max 6.500 -add_delay [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]]
set_input_delay -clock [get_clocks phy_backup_rgmii_rxc] -min 1.500 -add_delay [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]]
set_false_path -rise_from [get_clocks phy_backup_rgmii_rxc] -through [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]] -fall_to [get_clocks phy_backup_rgmii_rxc]
set_input_delay -clock [get_clocks phy_backup_rgmii_rxc] -max 6.500 -add_delay [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]] -clock_fall
set_input_delay -clock [get_clocks phy_backup_rgmii_rxc] -min 1.500 -add_delay [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]] -clock_fall
set_false_path -fall_from [get_clocks phy_backup_rgmii_rxc] -through [get_ports [list phy_backup_rgmii_rx_ctl {phy_backup_rgmii_rxd[3]} {phy_backup_rgmii_rxd[2]} {phy_backup_rgmii_rxd[1]} {phy_backup_rgmii_rxd[0]}]] -rise_to [get_clocks phy_backup_rgmii_rxc]

############################################################
# Ignore paths to resync flops
############################################################
###set_false_path -to [get_cells */reset_sync*]
set_false_path -to [get_cells * -hierarchical -filter {NAME =~ */data_sync}]


############################3.3V,bank 14############################
####spi flash
##Net spi_flash_clk               LOC = C8    | IOSTANDARD = LVCMOS33;
##Net spi_flash_cs                LOC = C23   | IOSTANDARD = LVCMOS33;
##Net spi_flash_dq<0>             LOC = B24   | IOSTANDARD = LVCMOS33;
##Net spi_flash_dq<1>             LOC = A25   | IOSTANDARD = LVCMOS33;
##Net spi_flash_dq<2>             LOC = B22   | IOSTANDARD = LVCMOS33;
##Net spi_flash_dq<3>             LOC = A22   | IOSTANDARD = LVCMOS33;

##LOCAL BUS
set_property LOC F23 [get_ports {lbus_addr[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[0]}]
set_property LOC D25 [get_ports {lbus_addr[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[1]}]
set_property LOC E23 [get_ports {lbus_addr[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[2]}]
set_property LOC G22 [get_ports {lbus_addr[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[3]}]
set_property LOC F22 [get_ports {lbus_addr[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[4]}]
set_property LOC G26 [get_ports {lbus_addr[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[5]}]
set_property LOC F24 [get_ports {lbus_addr[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[6]}]
set_property LOC G25 [get_ports {lbus_addr[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[7]}]
set_property LOC D24 [get_ports {lbus_addr[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[8]}]
set_property LOC F25 [get_ports {lbus_addr[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[9]}]
set_property LOC E25 [get_ports {lbus_addr[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[10]}]
set_property LOC G24 [get_ports {lbus_addr[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_addr[11]}]

set_property LOC J25 [get_ports {lbus_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[0]}]
set_property LOC K22 [get_ports {lbus_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[1]}]
set_property LOC J26 [get_ports {lbus_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[2]}]
set_property LOC L22 [get_ports {lbus_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[3]}]
set_property LOC H26 [get_ports {lbus_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[4]}]
set_property LOC L23 [get_ports {lbus_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[5]}]
set_property LOC H24 [get_ports {lbus_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[6]}]
set_property LOC J21 [get_ports {lbus_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[7]}]
set_property LOC H23 [get_ports {lbus_data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[8]}]
set_property LOC J23 [get_ports {lbus_data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[9]}]
set_property LOC H22 [get_ports {lbus_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[10]}]
set_property LOC K23 [get_ports {lbus_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[11]}]
set_property LOC G21 [get_ports {lbus_data[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[12]}]
set_property LOC J24 [get_ports {lbus_data[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[13]}]
set_property LOC E26 [get_ports {lbus_data[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[14]}]
set_property LOC H21 [get_ports {lbus_data[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_data[15]}]

set_property LOC C26 [get_ports {lbus_cs_n[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_cs_n[0]}]
set_property LOC C24 [get_ports {lbus_cs_n[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_cs_n[1]}]
set_property LOC E22 [get_ports {lbus_cs_n[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_cs_n[2]}]

set_property LOC C21 [get_ports lbus_oe_n]
set_property IOSTANDARD LVCMOS33 [get_ports lbus_oe_n]
set_property LOC B21 [get_ports lbus_we_n]
set_property IOSTANDARD LVCMOS33 [get_ports lbus_we_n]
set_property LOC B20 [get_ports {lbus_int[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_int[0]}]
set_property LOC A20 [get_ports {lbus_int[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_int[1]}]
set_property LOC A24 [get_ports {lbus_int[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lbus_int[2]}]
set_property LOC E21 [get_ports lbus_wait_n]
set_property IOSTANDARD LVCMOS33 [get_ports lbus_wait_n]

##Net rsmvad                      LOC = D21   | IOSTANDARD = LVCMOS33;
##Net rsmclk                      LOC = C22   | IOSTANDARD = LVCMOS33;
##Net rsmbwait                    LOC = C26   | IOSTANDARD = LVCMOS33;
##Net nrbe0                       LOC = D23   | IOSTANDARD = LVCMOS33;
##Net nrbe1                       LOC = A23   | IOSTANDARD = LVCMOS33;
##Net s3c2416_gpio[0]             LOC = B20   | IOSTANDARD = LVCMOS33;
##Net s3c2416_gpio[1]             LOC = A20   | IOSTANDARD = LVCMOS33;
##Net s3c2416_gpio[2]             LOC = A24   | IOSTANDARD = LVCMOS33;


###set_property SLEW FAST [get_ports dac_clk_out_p]
###set_property SLEW FAST [get_ports dac_clk_out_n]
###set_property SLEW FAST [get_ports {dac_data_out_a_p[0]}]
###set_property SLEW FAST [get_ports {dac_data_out_a_n[0]}]
###set_property SLEW FAST [get_ports {dac_data_out_a_p[1]}]
###set_property SLEW FAST [get_ports {dac_data_out_a_n[1]}]
###set_property SLEW FAST [get_ports {dac_data_out_a_p[2]}]
###set_property SLEW FAST [get_ports {dac_data_out_a_n[2]}]

############################1.8V,bank 32,33,34######################
####AD9739A data interface
##NET dac_clk_in_p                LOC = AC9   | DIFF_TERM  = FALSE| IOSTANDARD = LVDS;
##NET dac_clk_in_n                LOC = AD9   | DIFF_TERM  = FALSE| IOSTANDARD = LVDS;
set_property LOC AC9 [get_ports dac_clk_in_p]
set_property IOSTANDARD LVDS [get_ports dac_clk_in_p]
set_property LOC AD9 [get_ports dac_clk_in_n]
set_property IOSTANDARD LVDS [get_ports dac_clk_in_n]
set_property LOC AB11 [get_ports dac_clk_out_p]
set_property IOSTANDARD LVDS [get_ports dac_clk_out_p]
set_property LOC AC11 [get_ports dac_clk_out_n]
set_property IOSTANDARD LVDS [get_ports dac_clk_out_n]
set_property LOC AE17 [get_ports {dac_data_out_a_p[0]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[0]}]
set_property LOC AF17 [get_ports {dac_data_out_a_n[0]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[0]}]
set_property LOC AD16 [get_ports {dac_data_out_a_p[1]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[1]}]

set_property LOC AE16 [get_ports {dac_data_out_a_n[1]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[1]}]

set_property LOC AD15 [get_ports {dac_data_out_a_p[2]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[2]}]

set_property LOC AE15 [get_ports {dac_data_out_a_n[2]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[2]}]

set_property LOC AA13 [get_ports {dac_data_out_a_p[3]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[3]}]

set_property LOC AA12 [get_ports {dac_data_out_a_n[3]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[3]}]

set_property LOC AE13 [get_ports {dac_data_out_a_p[4]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[4]}]
set_property LOC AF13 [get_ports {dac_data_out_a_n[4]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[4]}]
set_property LOC AC13 [get_ports {dac_data_out_a_p[5]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[5]}]
set_property LOC AD13 [get_ports {dac_data_out_a_n[5]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[5]}]
set_property LOC AE8 [get_ports {dac_data_out_a_p[6]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[6]}]
set_property LOC AF8 [get_ports {dac_data_out_a_n[6]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[6]}]
set_property LOC AC8 [get_ports {dac_data_out_a_p[7]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[7]}]
set_property LOC AD8 [get_ports {dac_data_out_a_n[7]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[7]}]
set_property LOC AE7 [get_ports {dac_data_out_a_p[8]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[8]}]
set_property LOC AF7 [get_ports {dac_data_out_a_n[8]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[8]}]
set_property LOC AF5 [get_ports {dac_data_out_a_p[9]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[9]}]
set_property LOC AF4 [get_ports {dac_data_out_a_n[9]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[9]}]
set_property LOC AF3 [get_ports {dac_data_out_a_p[10]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[10]}]
set_property LOC AF2 [get_ports {dac_data_out_a_n[10]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[10]}]
set_property LOC AB2 [get_ports {dac_data_out_a_p[11]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[11]}]
set_property LOC AC2 [get_ports {dac_data_out_a_n[11]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[11]}]
set_property LOC AD1 [get_ports {dac_data_out_a_p[12]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[12]}]
set_property LOC AE1 [get_ports {dac_data_out_a_n[12]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[12]}]
set_property LOC AB1 [get_ports {dac_data_out_a_p[13]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_p[13]}]
set_property LOC AC1 [get_ports {dac_data_out_a_n[13]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_a_n[13]}]
set_property LOC AB16 [get_ports {dac_data_out_b_p[0]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[0]}]
set_property LOC AC16 [get_ports {dac_data_out_b_n[0]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[0]}]
set_property LOC AE18 [get_ports {dac_data_out_b_p[1]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[1]}]
set_property LOC AF18 [get_ports {dac_data_out_b_n[1]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[1]}]
set_property LOC AF19 [get_ports {dac_data_out_b_p[2]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[2]}]
set_property LOC AF20 [get_ports {dac_data_out_b_n[2]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[2]}]
set_property LOC AC14 [get_ports {dac_data_out_b_p[3]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[3]}]
set_property LOC AD14 [get_ports {dac_data_out_b_n[3]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[3]}]
set_property LOC AF14 [get_ports {dac_data_out_b_p[4]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[4]}]
set_property LOC AF15 [get_ports {dac_data_out_b_n[4]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[4]}]
set_property LOC AB14 [get_ports {dac_data_out_b_p[5]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[5]}]
set_property LOC AB15 [get_ports {dac_data_out_b_n[5]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[5]}]
set_property LOC AE12 [get_ports {dac_data_out_b_p[6]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[6]}]
set_property LOC AF12 [get_ports {dac_data_out_b_n[6]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[6]}]
set_property LOC AD11 [get_ports {dac_data_out_b_p[7]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[7]}]
set_property LOC AE11 [get_ports {dac_data_out_b_n[7]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[7]}]
set_property LOC AF10 [get_ports {dac_data_out_b_p[8]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[8]}]
set_property LOC AF9 [get_ports {dac_data_out_b_n[8]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[8]}]
set_property LOC AD10 [get_ports {dac_data_out_b_p[9]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[9]}]
set_property LOC AE10 [get_ports {dac_data_out_b_n[9]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[9]}]
set_property LOC AB6 [get_ports {dac_data_out_b_p[10]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[10]}]
set_property LOC AC6 [get_ports {dac_data_out_b_n[10]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[10]}]
set_property LOC AD6 [get_ports {dac_data_out_b_p[11]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[11]}]
set_property LOC AD5 [get_ports {dac_data_out_b_n[11]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[11]}]
set_property LOC AD4 [get_ports {dac_data_out_b_p[12]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[12]}]
set_property LOC AD3 [get_ports {dac_data_out_b_n[12]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[12]}]
set_property LOC AA4 [get_ports {dac_data_out_b_p[13]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_p[13]}]
set_property LOC AB4 [get_ports {dac_data_out_b_n[13]}]
set_property IOSTANDARD LVDS [get_ports {dac_data_out_b_n[13]}]

##############################1.8V,bank 34############################
set_property LOC U6 [get_ports {gpio_led[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_led[0]}]
set_property LOC U5 [get_ports {gpio_led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_led[1]}]
set_property LOC U2 [get_ports {gpio_led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_led[2]}]
set_property LOC U1 [get_ports {gpio_led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_led[3]}]
set_property LOC W6 [get_ports {gpio_led[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_led[4]}]
set_property LOC W5 [get_ports {gpio_test[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_test[0]}]
set_property LOC V3 [get_ports {gpio_test[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_test[1]}]
set_property LOC W3 [get_ports {gpio_test[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_test[2]}]
set_property LOC U7 [get_ports {gpio_test[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_test[3]}]
set_property LOC V6 [get_ports {gpio_test[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {gpio_test[4]}]

##################################################################################################
## 
##  Xilinx, Inc. 2010            www.xilinx.com 
##  周二 十一月 27 14:07:07 2012
##  Generated by MIG Version 1.5
##  
##################################################################################################
##  File name :       ddr3_test.xdc
##  Details :     Constraints file
##                    FPGA Family:       KINTEX7
##                    FPGA Part:         XC7K325T-FFG676
##                    Speedgrade:        -2
##                    Design Entry:      VERILOG
##                    Frequency:         500 MHz
##                    Time Period:       2000 ps
##################################################################################################

##################################################################################################
## Controller 0
## Memory Device: DDR3_SDRAM->Components->MT41J64M16XX-15E
## Data Width: 16
## Time Period: 2000
## Data Mask: 1
##################################################################################################

##create_clock -name sys_clk_i -period 8 [get_ports sys_clk_i]
##set_propagated_clock sys_clk_i
          
##create_clock -name clk_ref_i -period 5 [get_ports clk_ref_i]
##set_propagated_clock clk_ref_i
          
# Note: the following CLOCK_DEDICATED_ROUTE constraint will cause a warning in place similar
# to the following:
#   WARNING:Place:1402 - A clock IOB / PLL clock component pair have been found that are not
#   placed at an optimal clock IOB / PLL site pair.
# This warning can be ignored.  See the Users Guide for more information.

##set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets sys_clk_i]
##set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_pins -hierarchical *pll*CLKIN1]
          

############## NET - IOSTANDARD ##################


# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[0]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[0]}]
set_property LOC B12 [get_ports {ddr3_dq[0]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[1]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[1]}]
set_property LOC B11 [get_ports {ddr3_dq[1]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[2]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[2]}]
set_property LOC B10 [get_ports {ddr3_dq[2]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[3]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[3]}]
set_property LOC A10 [get_ports {ddr3_dq[3]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[4]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[4]}]
set_property LOC B15 [get_ports {ddr3_dq[4]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[5]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[5]}]
set_property LOC A15 [get_ports {ddr3_dq[5]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[6]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[6]}]
set_property LOC A13 [get_ports {ddr3_dq[6]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dq[7]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[7]}]
set_property LOC A12 [get_ports {ddr3_dq[7]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[8]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[8]}]
set_property LOC B16 [get_ports {ddr3_dq[8]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[9]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[9]}]
set_property LOC A18 [get_ports {ddr3_dq[9]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[10]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[10]}]
set_property LOC A19 [get_ports {ddr3_dq[10]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[11]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[11]}]
set_property LOC C19 [get_ports {ddr3_dq[11]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[12]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[12]}]
set_property LOC B19 [get_ports {ddr3_dq[12]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[13]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[13]}]
set_property LOC C17 [get_ports {ddr3_dq[13]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[14]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[14]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[14]}]
set_property LOC C18 [get_ports {ddr3_dq[14]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dq[15]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dq[15]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[15]}]
set_property LOC D15 [get_ports {ddr3_dq[15]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[12]}]
set_property LOC H9 [get_ports {ddr3_addr[12]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[11]}]
set_property LOC H8 [get_ports {ddr3_addr[11]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[10]}]
set_property LOC G10 [get_ports {ddr3_addr[10]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[9]}]
set_property LOC G9 [get_ports {ddr3_addr[9]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[8]}]
set_property LOC J11 [get_ports {ddr3_addr[8]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[7]}]
set_property LOC J10 [get_ports {ddr3_addr[7]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[6]}]
set_property LOC H14 [get_ports {ddr3_addr[6]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[5]}]
set_property LOC G14 [get_ports {ddr3_addr[5]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_addr[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[4]}]
set_property LOC H12 [get_ports {ddr3_addr[4]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_addr[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[3]}]
set_property LOC F9 [get_ports {ddr3_addr[3]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_addr[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[2]}]
set_property LOC F8 [get_ports {ddr3_addr[2]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_addr[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[1]}]
set_property LOC D9 [get_ports {ddr3_addr[1]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_addr[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[0]}]
set_property LOC D8 [get_ports {ddr3_addr[0]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_ba[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[2]}]
set_property LOC A9 [get_ports {ddr3_ba[2]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_ba[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[1]}]
set_property LOC A8 [get_ports {ddr3_ba[1]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_ba[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[0]}]
set_property LOC C9 [get_ports {ddr3_ba[0]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]
set_property LOC B9 [get_ports {ddr3_ras_n}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]
set_property LOC G11 [get_ports {ddr3_cas_n}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]
set_property LOC F10 [get_ports {ddr3_we_n}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]
set_property LOC D10 [get_ports {ddr3_reset_n}]

# Bank: 16 - Byte T2
set_property SLEW FAST [get_ports {ddr3_cke[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[0]}]
set_property LOC F14 [get_ports {ddr3_cke[0]}]

# Bank: 16 - Byte T2
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
set_property LOC F13 [get_ports {ddr3_odt[0]}]

# Bank: 16 - Byte T1
set_property SLEW FAST [get_ports {ddr3_cs_n[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cs_n[0]}]
set_property LOC E10 [get_ports {ddr3_cs_n[0]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dm[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[0]}]
set_property LOC C14 [get_ports {ddr3_dm[0]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dm[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[1]}]
set_property LOC C16 [get_ports {ddr3_dm[1]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_p[0]}]
set_property LOC B14 [get_ports {ddr3_dqs_p[0]}]

# Bank: 16 - Byte T3
set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_n[0]}]
set_property LOC A14 [get_ports {ddr3_dqs_n[0]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_p[1]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_p[1]}]
set_property LOC B17 [get_ports {ddr3_dqs_p[1]}]

# Bank: 15 - Byte T0
set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
set_property IN_TERM UNTUNED_SPLIT_50 [get_ports {ddr3_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_n[1]}]
set_property LOC A17 [get_ports {ddr3_dqs_n[1]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]
set_property LOC J13 [get_ports {ddr3_ck_p[0]}]

# Bank: 16 - Byte T0
set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
set_property LOC H13 [get_ports {ddr3_ck_n[0]}]

set_property LOC PHASER_OUT_PHY_X0Y15 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_out]
set_property LOC PHASER_OUT_PHY_X0Y19 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_out]
set_property LOC PHASER_OUT_PHY_X0Y18 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_out]
set_property LOC PHASER_OUT_PHY_X0Y17 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_out]
set_property LOC PHASER_OUT_PHY_X0Y16 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_out]

set_property LOC PHASER_IN_PHY_X0Y15 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_in_gen.phaser_in]
## set_property LOC PHASER_IN_PHY_X0Y19 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_in_gen.phaser_in]
## set_property LOC PHASER_IN_PHY_X0Y18 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_in_gen.phaser_in]
## set_property LOC PHASER_IN_PHY_X0Y17 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X0Y16 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_in_gen.phaser_in]

set_property LOC OUT_FIFO_X0Y15 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/out_fifo]
set_property LOC OUT_FIFO_X0Y19 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/out_fifo]
set_property LOC OUT_FIFO_X0Y18 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/out_fifo]
set_property LOC OUT_FIFO_X0Y17 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/out_fifo]
set_property LOC OUT_FIFO_X0Y16 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/out_fifo]

set_property LOC IN_FIFO_X0Y15 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X0Y16 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/in_fifo_gen.in_fifo]

set_property LOC PHY_CONTROL_X0Y3 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/phy_control_i]
set_property LOC PHY_CONTROL_X0Y4 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/phy_control_i]

set_property LOC PHASER_REF_X0Y3 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/phaser_ref_i]
set_property LOC PHASER_REF_X0Y4 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/phaser_ref_i]

set_property LOC OLOGIC_X0Y193 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/ddr_byte_group_io/*slave_ts]
set_property LOC OLOGIC_X0Y207 [get_cells u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/ddr_byte_group_io/*slave_ts]

set_property LOC PLLE2_ADV_X0Y4 [get_cells u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/plle2_i]
set_property LOC MMCME2_ADV_X0Y4 [get_cells u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/mmcm_i]

set mig u_ddr3_test/
set_false_path -through [get_pins u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/plle2_i/CLKOUT0]
set_false_path -through [get_pins u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/plle2_i/CLKOUT1]
set_false_path -through [get_pins u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/plle2_i/CLKOUT2]
set_false_path -through [get_pins u0_ddr3_top/u_ddr3_test/u_ddr3_infrastructure/mmcm_i/CLKFBOUT]
          
set_multicycle_path -from [get_cells -hier -filter {NAME =~ */mc0/mc_read_idle_r_reg}] \
                    -to   [get_cells -hier -filter {NAME =~ */input_[?].iserdes_dq_.iserdesdq}] \
                    -setup 6

set_multicycle_path -from [get_cells -hier -filter {NAME =~ */mc0/mc_read_idle_r_reg}] \
                    -to   [get_cells -hier -filter {NAME =~ */input_[?].iserdes_dq_.iserdesdq}] \
                    -hold 5


####################################################################
####################################################################
####################################################################

set_false_path -through [get_nets u0_clk_rst/ddr3_sys_rst]
set_false_path -through [get_nets u0_gbe_top/u0_gbe_mac/gtx_resetn]
set_false_path -through [get_nets u0_gbe_top/u0_gbe_mac/glbl_rst_int]
set_false_path -through [get_nets u0_qam16/rst_duc]
set_false_path -through [get_nets u0_gbe_top/u0_gbe_mac/phy_switch_resetn]
set_false_path -through [get_nets rst_j83]
set_false_path -through [get_nets rst_27m]

set_false_path -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets u0_gbe_top/clk_tx]] -to [all_fanout -endpoints_only -flat -from [get_nets s_axi_aclk]]
set_false_path -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets s_axi_aclk]] -to [all_fanout -endpoints_only -flat -from [get_nets u0_gbe_top/clk_tx]]
set_false_path -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets s_axi_aclk]] -to [all_fanout -endpoints_only -flat -from [get_nets ddr3_user_clk]]
set_false_path -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets pll_27m]] -to [all_fanout -endpoints_only -flat -from [get_nets ddr3_user_clk]]
set_false_path -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets ddr3_user_clk]] -to [all_fanout -endpoints_only -flat -from [get_nets u0_qam16/clk_341m]]

create_clock -name dac_clk_in_p -period 1.953 [get_ports dac_clk_in_p]

# The following cross clock domain false path constraints can be uncommented in order to mimic ucf constraints behavior (see message at the beginning of this file)
# set_false_path -from [get_clocks phy_main_rgmii_rxc] -to [get_clocks [list phy_backup_rgmii_rxc clk_27m u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/iserdes_clk u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/iserdes_clk dac_clk_in_p]]
# set_false_path -from [get_clocks phy_backup_rgmii_rxc] -to [get_clocks [list phy_main_rgmii_rxc clk_27m u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/iserdes_clk u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/iserdes_clk dac_clk_in_p]]
# set_false_path -from [get_clocks clk_27m] -to [get_clocks [list phy_main_rgmii_rxc phy_backup_rgmii_rxc u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/iserdes_clk u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/iserdes_clk dac_clk_in_p]]
# set_false_path -from [get_clocks [list u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/iserdes_clk u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/iserdes_clk]] -to [get_clocks [list phy_main_rgmii_rxc phy_backup_rgmii_rxc clk_27m dac_clk_in_p]]
# set_false_path -from [get_clocks dac_clk_in_p] -to [get_clocks [list phy_main_rgmii_rxc phy_backup_rgmii_rxc clk_27m u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/iserdes_clk u0_ddr3_top/u_ddr3_test/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/iserdes_clk]]


########pcr_interval_adj module,multi-cycle constraint
###################set_max_delay 32.000 -from [all_registers -edge_triggered] -to [all_registers -edge_triggered]

set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_base_reg[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_base[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_ori_base[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_base[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/ram_rdata[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_base[*]}]]

set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_ext_reg[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_ext[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_ori_ext[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_ext[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/ram_rdata[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_sub_ext[*]}]]

set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/ram_rdata[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_base_temp[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_base_reg[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_base_temp[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_ext_reg[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_base_temp[*]}]]

set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/ram_rdata[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_ext_temp[*]}]]
set_max_delay 32.000 -from [all_fanout -endpoints_only -only_cells -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_ext_reg[*]}]] -to [all_fanout -endpoints_only -flat -from [get_nets * -hierarchical -filter {NAME =~ */u0_pcr_correct/pcr_lo_ext_temp[*]}]]

####BEGIN MODEL "u0_qam16/mod/ASysTiming"
####NET "frame" max_fanout=4;
####NET "im"    max_fanout=4;
####END;

####BEGIN MODEL "u0_qam16/mod/AByteToMTuple"
####NET "flsb" max_fanout=2;
####END;

####BEGIN MODEL "u0_ts_process/u_ts_map/u_payload_in_buf/u_match_info"
####NET "avalon_ram_address" max_fanout=4;
####NET "avalon_ram_init"    max_fanout=4;
####END;

####BEGIN MODEL "u0_ddr3_top/u0_ddr_rw_ctrl/MULTIPLE_CHANNEL_TS.u_ts_j83/u_ts_buf"
####NET "has_frame" max_fanout=4;
####END;

######spi constraint
###INST "dac_spi_sdio"                                                  		TNM = OUT_SPI_DATA; 
###INST "adf4350_data"                                               			TNM = OUT_SPI_DATA;
###TIMEGRP "OUT_SPI_DATA" OFFSET        = OUT 5 ns AFTER "u0_clk_rst/u0_pll_200m/clkout2" RISING;
