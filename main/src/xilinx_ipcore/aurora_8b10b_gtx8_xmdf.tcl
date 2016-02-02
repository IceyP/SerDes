# The package naming convention is <core_name>_xmdf
package provide aurora_8b10b_gtx8_xmdf 1.0

# This includes some utilities that support common XMDF operations
package require utilities_xmdf

# Define a namespace for this package. The name of the name space
# is <core_name>_xmdf
namespace eval ::aurora_8b10b_gtx8_xmdf {
# Use this to define any statics
}

# Function called by client to rebuild the params and port arrays
# Optional when the use context does not require the param or ports
# arrays to be available.
proc ::aurora_8b10b_gtx8_xmdf::xmdfInit { instance } {
# Variable containg name of library into which module is compiled
# Recommendation: <module_name>
# Required
utilities_xmdf::xmdfSetData $instance Module Attributes Name aurora_8b10b_gtx8
}
# ::aurora_8b10b_gtx8_xmdf::xmdfInit

# Function called by client to fill in all the xmdf* data variables
# based on the current settings of the parameters
proc ::aurora_8b10b_gtx8_xmdf::xmdfApplyParams { instance } {

set fcount 0
# Array containing libraries that are assumed to exist
# Examples include unisim and xilinxcorelib
# Optional
# In this example, we assume that the unisim library will
# be magically
# available to the simulation and synthesis tool
utilities_xmdf::xmdfSetData $instance FileSet $fcount type logical_library
utilities_xmdf::xmdfSetData $instance FileSet $fcount logical_library unisim
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
utilities_xmdf::xmdfSetData $instance FileSet $fcount toplevel true
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/aurora_8b10b_gtx8_exdes.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/aurora_8b10b_gtx8_tb.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilogsim
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_mti.do
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_mti.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_mti.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/timing/simulate_mti.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/timing/simulate_mti.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/wave_mti.do
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_isim.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_isim.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/wave_isim.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_ncsim.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/simulation/functional/simulate_ncsim.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_axi_to_ll.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_ll_to_axi.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8_xmdf.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8.xco
utilities_xmdf::xmdfSetData $instance FileSet $fcount type xco
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8.veo
utilities_xmdf::xmdfSetData $instance FileSet $fcount type veo
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_aurora_lane.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_aurora_lane.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_aurora_lane.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/aurora_8b10b_gtx8_exdes.ucf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type ucf
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_channel_err_detect.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_channel_init_sm.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_chbond_count_dec.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_chbond_count_dec.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/clock_module/aurora_8b10b_gtx8_clock_module.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_err_detect.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_err_detect.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_err_detect.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/traffic_gen_check/aurora_8b10b_gtx8_frame_check.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/traffic_gen_check/aurora_8b10b_gtx8_frame_gen.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_global_logic.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_idle_and_ver_gen.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_lane_init_sm.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_lane_init_sm.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_lane_init_sm.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/aurora_8b10b_gtx8_reset_logic.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/gt/aurora_8b10b_gtx8_transceiver_wrapper.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/gt/aurora_8b10b_gtx8_multi_gt.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/gt/aurora_8b10b_gtx8_gt.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_rx_ll.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_rx_ll_pdu_datapath.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/cc_manager/aurora_8b10b_gtx8_standard_cc_module.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_sym_dec.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_sym_gen.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_tx_ll_control.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_tx_ll_datapath.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_tx_ll.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/src/aurora_8b10b_gtx8_hotplug.v
utilities_xmdf::xmdfSetData $instance FileSet $fcount type verilog
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/v7_icon.ngc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type ngc
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/example_design/v7_vio.ngc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type ngc
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/planAhead_ise.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/planAhead_ise.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/planAhead_ise.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/implement.sh
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/implement.bat
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/xst.prj
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path aurora_8b10b_gtx8/implement/xst.scr
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount
}
# ::gen_comp_name_xmdf::xmdfApplyParams
