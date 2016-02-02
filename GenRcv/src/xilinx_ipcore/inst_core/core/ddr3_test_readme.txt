
The design files are located at
C:/Users/huangrui/Desktop/0530/nCAS1000_FPGA/debug_scram/src_v4.1.0_scram_duc16ch_ddr78m/xilinx_ipcore/inst_core/core:

   - ddr3_test.veo:
        veo template file containing code that can be used as a model
        for instantiating a CORE Generator module in a HDL design.

   - ddr3_test.xco:
       CORE Generator input file containing the parameters used to
       regenerate a core.

   - ddr3_test_flist.txt:
        Text file listing all of the output files produced when a customized
        core was generated in the CORE Generator.

   - ddr3_test_readme.txt:
        Text file indicating the files generated and how they are used.

   - ddr3_test_xmdf.tcl:
        ISE Project Navigator interface file. ISE uses this file to determine
        how the files output by CORE Generator for the core can be integrated
        into your ISE project.

   - ddr3_test.csv:
        Includes the pin out information which is used as support file
        for PlanAhead.

   - ddr3_test.gise and ddr3_test.xise:
        ISE Project Navigator support files. These are generated files and
        should not be edited directly.

   - ddr3_test directory.

In the ddr3_test directory, three folders are created:
   - docs:
        This folder contains MIG user guide.

   - example_design:
        This folder includes script files to implement and simulate the design.
        This includes the traffic generator RTL modules and example_top module.

   - user_design:
        This folder includes the all RTL modules of controller, phy and
        user interface RTL modules. UCF file is provided.

The example_design and user_design folders contain several other folders
and files. All these output folders are discussed in more detail in
MIG user guide (ug586_7Series_MIS.pdf) located in docs folder.
    