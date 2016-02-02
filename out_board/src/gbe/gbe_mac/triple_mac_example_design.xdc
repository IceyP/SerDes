
# PART is kintex7 xc7k325tffg676

#
####
#######
##########
#############
#################
## System level constraints

########## NO LOC CONSTRAINTS AS PART NOT ON SUPPORTED BOARD ##########
set_property IOSTANDARD LVDS  [get_ports clk_in_p]
set_property IOSTANDARD LVDS  [get_ports clk_in_n]

set_property IOSTANDARD LVCMOS15 [get_ports glbl_rst]
set_false_path -from [get_ports glbl_rst]

#### Module LEDs_8Bit constraints
set_property IOSTANDARD LVCMOS15 [get_ports activity_flash]
set_property IOSTANDARD LVCMOS15 [get_ports activity_flashn]
set_property IOSTANDARD LVCMOS15 [get_ports frame_error]
set_property IOSTANDARD LVCMOS15 [get_ports frame_errorn]

#### Module Push_Buttons_4Bit constraints
set_property IOSTANDARD LVCMOS15 [get_ports update_speed]  
set_property IOSTANDARD LVCMOS15 [get_ports config_board]
set_property IOSTANDARD LVCMOS15 [get_ports pause_req_s]  
set_property IOSTANDARD LVCMOS15 [get_ports reset_error]  

#### Module DIP_Switches_4Bit constraints
set_property IOSTANDARD LVCMOS15 [get_ports mac_speed[0]]
set_property IOSTANDARD LVCMOS15 [get_ports mac_speed[1]]
set_property IOSTANDARD LVCMOS15 [get_ports gen_tx_data]
set_property IOSTANDARD LVCMOS15 [get_ports chk_tx_data]

set_property IOSTANDARD LVCMOS15 [get_ports phy_resetn]

set_property IOSTANDARD LVCMOS15 [get_ports serial_response]
set_property IOSTANDARD LVCMOS15 [get_ports tx_statistics_s]
set_property IOSTANDARD LVCMOS15 [get_ports rx_statistics_s]

set_property IOSTANDARD LVCMOS15 [get_ports mdc]
set_property IOSTANDARD LVCMOS15 [get_ports mdio]

set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxd[3]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxd[2]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxd[1]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxd[0]]

set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txd[3]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txd[2]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txd[1]]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txd[0]]

set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_tx_ctl]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txc]

set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rx_ctl]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxc]



#
####
#######
##########
#############
#################
#EXAMPLE DESIGN CONSTRAINTS

############################################################
# Clock Period Constraints                                 #
############################################################

############################################################
# RX Clock period Constraints                              #
############################################################
# Receiver clock period constraints: please do not relax
create_clock -name rx_clk -period 8 [get_ports rgmii_rxc]

############################################################
# TX Clock period Constraints                              #
############################################################
# Transmitter clock period constraints: please do not relax
create_clock -name clk_in_p -period 5.000 [get_ports clk_in_p]
set_input_jitter clk_in_p 0.050

#set to use clock backbone - this uses a long route to allow the MMCM to be placed in the other half of the device
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets -hier -filter {name =~ */clkin1}]



############################################################
# AXI-Lite Clock period Constraints                        #
############################################################

############################################################
# Define clock relationships                               #
############################################################

############################################################
# Input Delay constraints
############################################################
# these inputs are alll from either dip switchs or push buttons 
# and therefore have no timing associated with them
set_false_path -from [get_ports update_speed]
set_false_path -from [get_ports config_board]
set_false_path -from [get_ports pause_req_s]
set_false_path -from [get_ports reset_error]
set_false_path -from [get_ports mac_speed[0]]
set_false_path -from [get_ports mac_speed[1]]
set_false_path -from [get_ports gen_tx_data]
set_false_path -from [get_ports chk_tx_data]

set_input_delay -clock clkout1 5 [get_ports mdio]

# Ignore pause deserialiser as only present to prevent logic stripping
set_false_path -from [get_ports pause_req*]
set_false_path -from [get_cells pause_req*]
set_false_path -from [get_cells pause_val*]


############################################################
# Output Delay constraints
############################################################

set_false_path -to [get_ports frame_error]
set_false_path -to [get_ports frame_errorn]
set_false_path -to [get_ports serial_response]
set_false_path -to [get_ports tx_statistics_s]
set_false_path -to [get_ports rx_statistics_s]
set_output_delay -clock clkout1 1 [get_ports mdc]

# no timing associated with output
set_false_path -from [get_cells -hier -filter {name =~ *phy_resetn*}] -to [get_ports phy_resetn]

############################################################
# Example design Clock Crossing Constraints                          #
############################################################
set_false_path -from [get_cells -hier -filter {name =~ *phy_resetn*}] -to [get_cells -hier -filter {name =~ *axi_lite_reset_gen*}]


# control signal is synched over clock boundary separately
set_false_path -from [get_cells -hier -filter {name =~ rx_stats_reg*}] -to [get_cells -hier -filter {name =~ rx_stats_shift_reg*}]


#
####
#######
##########
#############
#################
#FIFO BLOCK CONSTRAINTS

############################################################
# FIFO Clock Crossing Constraints                          #
############################################################

# control signal is synched separately so this is a false path
set_false_path -from [get_cells -hier -filter {name =~ *rd_addr*}] -to [get_cells -hier -filter {name =~ *fifo*wr_rd_addr*}]


# constraints above here should be example design specific (includes FIFO)
#  /\    /\    /\    /\    /\    /\   
####################################
#  \/    \/    \/    \/    \/    \/
# constraints below here should be applicable only to the block level


#
####
#######
##########
#############
#################
#BLOCK CONSTRAINTS

############################################################
# The following are required to maximise setup/hold        #
############################################################

set rgmii_tx_pins [get_ports -filter {name =~ rgmii_txd[*] || name =~ rgmii_tx_ct*}]
lappend rgmii_tx_pins [get_ports -filter {name =~ rgmii_txc}]

set_property SLEW FAST $rgmii_tx_pins


############################################################
# RGMII: IODELAY Constraints
############################################################
# Please modify the value of the IDELAY_VALUE/ODELAY_VALUE
# according to your design.
# For more information on IDELAYCTRL and IODELAY, please refer to
# refer to the Series-7 User Guide.
#
# For this example UCF, the IODELAY component has been placed.
# This is to provide a similiar Clock Path and Data Path delay
# at the RGMII IDDRs.
set rx_delay_cells [get_cells -hier -filter {name =~ */rgmii_interface*delay_rgmii_rx*}]

# apply the same IDELAY_VALUE to all GMII RX inputs
set_property IDELAY_VALUE 16 $rx_delay_cells


# Group IODELAY and IDELAYCTRL components to aid placement
set_property IODELAY_GROUP grp1 $rx_delay_cells
set_property IODELAY_GROUP grp1 [get_cells  -hier -filter {name =~ *trimac_fifo_block/trimac_block/dlyctrl}]



############################################################
# For Setup and Hold time analysis on RGMII inputs         #
############################################################

# Identify RGMII Rx Pads only.  
# This prevents setup/hold analysis being performed on false inputs,
# eg, the configuration_vector inputs.

# Due to the early nature of speed files for this family this constraint has been relaxed
# Rising edge
 
# define a virtual clock to simplify the timing constraints
create_clock -name rgmii_rx_clk -period 8

set_input_delay -clock rgmii_rx_clk -max -1.3 [get_ports -filter {name =~ rgmii_rxd[*] || name =~ gmii_rx_ctl}]
set_input_delay -clock rgmii_rx_clk -min -2.9 [get_ports -filter {name =~ rgmii_rxd[*] || name =~ gmii_rx_ctl}]
set_input_delay -clock rgmii_rx_clk -clock_fall -max -1.3 -add_delay [get_ports -filter {name =~ rgmii_rxd[*] || name =~ rgmii_rx_ctl}]
set_input_delay -clock rgmii_rx_clk -clock_fall -min -2.9 -add_delay [get_ports -filter {name =~ rgmii_rxd[*] || name =~ rgmii_rx_ctl}]

set_false_path -rise_from rgmii_rx_clk -fall_to rx_clk -setup
set_false_path -fall_from rgmii_rx_clk -rise_to rx_clk -setup
set_false_path -rise_from rgmii_rx_clk -rise_to rx_clk -hold
set_false_path -fall_from rgmii_rx_clk -fall_to rx_clk -hold

set_multicycle_path -from rgmii_rx_clk -to rx_clk -setup 0
set_multicycle_path -from rgmii_rx_clk -to rx_clk -hold -1

############################################################
# For Setup and Hold time analysis on RGMII outputs        #
############################################################

#output timing for rgmii - derated slightly due to pessimism in the tools
create_generated_clock -name rgmii_tx_clk -divide_by 1 -source [get_pins -hier -filter {name =~ *rgmii_interface*rgmii_txc*/C}] [get_ports rgmii_txc]

set_false_path -rise_from clkout0 -fall_to rgmii_tx_clk -setup
set_false_path -fall_from clkout0 -rise_to rgmii_tx_clk -setup
set_false_path -rise_from clkout0 -rise_to rgmii_tx_clk -hold
set_false_path -fall_from clkout0 -fall_to rgmii_tx_clk -hold

set_output_delay 0.75 -max -clock rgmii_tx_clk [get_ports -filter {name =~ rgmii_txd[*] || name =~ rgmii_tx_ctl}]
set_output_delay -0.7 -min -clock rgmii_tx_clk [get_ports -filter {name =~ rgmii_txd[*] || name =~ rgmii_tx_ctl}]
set_output_delay 0.75 -max -clock rgmii_tx_clk [get_ports -filter {name =~ rgmii_txd[*] || name =~ rgmii_tx_ctl}] -clock_fall -add_delay
set_output_delay -0.7 -min -clock rgmii_tx_clk [get_ports -filter {name =~ rgmii_txd[*] || name =~ rgmii_tx_ctl}] -clock_fall -add_delay


############################################################
# Crossing of Clock Domain Constraints
############################################################

# set a false path for the IPIF
set_false_path -from [get_cells -hier -filter {name =~ *axi_lite_top*bus2ip_addr*}] -to [get_clocks clkout0]

#
####
#######
##########
#############
#################
#CORE CONSTRAINTS



############################################################
# Crossing of Clock Domain Constraints: please do not edit #
############################################################

# control signal is synched separately so this is a false path
set_false_path -from [get_cells -hier -filter {name =~ *FLOW*RX_PAUSE*PAUSE*TO_TX*}] -to [get_cells -hier -filter {name =~ *TX_PAUSE*COUNT_SET*}]
set_false_path -from [get_cells -hier -filter {name =~ *FLOW*RX_PAUSE*PAUSE*TO_TX*}] -to [get_cells -hier -filter {name =~ *TX_PAUSE*PAUSE_COUNT*}]

# set a false path for the static config registers
set_false_path -from [get_cells -hier -filter {name =~ *MANAGEN/CONF/INT_*}] -to [get_clocks clkout0]
set_false_path -from [get_cells -hier -filter {name =~ *MANAGEN/CONF/INT_*}] -to [get_clocks rx_clk]




############################################################
# Ignore paths to resync flops
############################################################
set_false_path -to [get_pins * -hier -filter {NAME =~ */reset_sync*/PRE}]
set_false_path -to [get_pins * -hier -filter {NAME =~ */R1*/PRE}]
set_false_path -to [get_pins * -hier -filter {NAME =~ */R2*/PRE}]
set_false_path -to [get_pins * -hier -filter {NAME =~ */data_sync/D}]


# the mdio interface is clocked from the axi clock but the clock is so slow is can be considered to be data
# the data related outputs are output on the falling edge of the MDC output so both can simply be considered to be multicycle paths
set_multicycle_path 10 -setup -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*MIIM_CLK_INT*}] -to [get_ports mdc]
set_multicycle_path 9 -hold -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*MIIM_CLK_INT*}] -to [get_ports mdc]
set_multicycle_path 10 -setup -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*ENABLE_REG*}] -to [get_ports mdc]
set_multicycle_path 9 -hold -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*ENABLE_REG*}] -to [get_ports mdc]
set_multicycle_path 10 -setup -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*MDIO*}] -to [get_ports mdio]
set_multicycle_path 9 -hold -from [get_cells -hier -filter {name =~ *trimac_top*MANAGEN*MDIO*}] -to [get_ports mdio]




