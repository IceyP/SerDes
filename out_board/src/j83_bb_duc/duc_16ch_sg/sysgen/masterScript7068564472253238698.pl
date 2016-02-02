
open(PIDFILE, '> pidfile.txt') || die 'Couldn\'t write process ID to file.';
print PIDFILE "$$\n";
close(PIDFILE);

eval {
  # Call script(s).
  my $instrs;
  my $results = [];
$ENV{'SYSGEN'} = 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen';
  use Sg;
  $instrs = {
    'HDLCodeGenStatus' => 0.0,
    'HDL_PATH' => 'E:/Data/Design/duc_note',
    'TEMP' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp',
    'TMP' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp',
    'Temp' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp',
    'Tmp' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp',
    'base_system_period_hardware' => 2.929,
    'base_system_period_simulink' => 2.9296875E-9,
    'block_icon_display' => 'Default',
    'block_type' => 'sysgen',
    'block_version' => '',
    'ce_clr' => 0.0,
    'clock_domain' => 'default',
    'clock_loc' => '',
    'clock_wrapper' => 'Clock Enables',
    'clock_wrapper_sgadvanced' => '',
    'compilation' => 'HDL Netlist',
    'compilation_lut' => {
      'keys' => [ 'HDL Netlist', ],
      'values' => [ 'target1', ],
    },
    'compilation_target' => 'HDL Netlist',
    'core_generation' => 1.0,
    'core_generation_sgadvanced' => '',
    'core_is_deployed' => 0.0,
    'coregen_core_generation_tmpdir' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp/sysgentmp-laurengao/cg_wk/cac8229c4e901867a',
    'coregen_part_family' => 'kintex7',
    'createTestbench' => 0,
    'create_interface_document' => 'off',
    'dbl_ovrd' => -1.0,
    'dbl_ovrd_sgadvanced' => '',
    'dcm_input_clock_period' => 10.0,
    'deprecated_control' => 'off',
    'deprecated_control_sgadvanced' => '',
    'design' => 'duc_16ch_341',
    'design_full_path' => 'E:\\Data\\Design\\duc_note\\duc_16ch_341.mdl',
    'device' => 'xc7k160t-2ffg676',
    'device_speed' => '-2',
    'directory' => 'E:/Data/Design/duc_note/duc_16ch_sg',
    'dsp_cache_root_path' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp/sysgentmp-laurengao',
    'eval_field' => '0',
    'fileDeliveryDefaults' => [
      [
        '(?i)\\.vhd$',
        { 'fileName' => 'E:/Data/Design/duc_note/duc_16ch_sg/sysgen/perl_results.vhd', },
      ],
      [
        '(?i)\\.v$',
        { 'fileName' => 'E:/Data/Design/duc_note/duc_16ch_sg/sysgen/perl_results.v', },
      ],
    ],
    'force_scheduling' => 0.0,
    'fxdptinstalled' => 1.0,
    'generateUsing71FrontEnd' => 1,
    'generating_island_subsystem_handle' => 2084.8011474609375,
    'generating_subsystem_handle' => 2084.8011474609375,
    'generation_directory' => 'E:/Data/Design/duc_note/duc_16ch_sg',
    'has_advanced_control' => '0',
    'hdlDir' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl',
    'hdlKind' => 'verilog',
    'hdl_path' => 'E:/Data/Design/duc_note',
    'impl_file' => 'ISE Defaults*',
    'incr_netlist' => 'off',
    'incr_netlist_sgadvanced' => '',
    'infoedit' => ' System Generator',
    'isdeployed' => 0,
    'ise_version' => '14.5i',
    'master_sysgen_token_handle' => 2085.0003662109375,
    'matlab' => 'D:/MATLAB/MATLAB Production Server/R2012b',
    'matlab_fixedpoint' => 1.0,
    'mdlHandle' => 2084.8011474609375,
    'mdlPath' => 'E:/Data/Design/duc_note/duc_16ch_341.mdl',
    'modelDiagnostics' => [
      {
        'count' => 8029.0,
        'isMask' => 0.0,
        'type' => 'duc_16ch_341 Total blocks',
      },
      {
        'count' => 4.0,
        'isMask' => 0.0,
        'type' => 'Abs',
      },
      {
        'count' => 6.0,
        'isMask' => 0.0,
        'type' => 'Buffer',
      },
      {
        'count' => 78.0,
        'isMask' => 0.0,
        'type' => 'Constant',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'DataTypeConversion',
      },
      {
        'count' => 2.0,
        'isMask' => 0.0,
        'type' => 'DiscretePulseGenerator',
      },
      {
        'count' => 5.0,
        'isMask' => 0.0,
        'type' => 'Display',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'FrameConversion',
      },
      {
        'count' => 368.0,
        'isMask' => 0.0,
        'type' => 'From',
      },
      {
        'count' => 1.0,
        'isMask' => 0.0,
        'type' => 'Gain',
      },
      {
        'count' => 208.0,
        'isMask' => 0.0,
        'type' => 'Goto',
      },
      {
        'count' => 857.0,
        'isMask' => 0.0,
        'type' => 'Inport',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'M-S-Function',
      },
      {
        'count' => 9.0,
        'isMask' => 0.0,
        'type' => 'Math',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'Mux',
      },
      {
        'count' => 524.0,
        'isMask' => 0.0,
        'type' => 'Outport',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'Product',
      },
      {
        'count' => 16.0,
        'isMask' => 0.0,
        'type' => 'RealImagToComplex',
      },
      {
        'count' => 5537.0,
        'isMask' => 0.0,
        'type' => 'S-Function',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'SignalSpecification',
      },
      {
        'count' => 284.0,
        'isMask' => 0.0,
        'type' => 'SubSystem',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'Sum',
      },
      {
        'count' => 106.0,
        'isMask' => 0.0,
        'type' => 'Terminator',
      },
      {
        'count' => 3.0,
        'isMask' => 0.0,
        'type' => 'Unbuffer',
      },
      {
        'count' => 6.0,
        'isMask' => 1.0,
        'type' => 'Check Signal Attributes',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Digital Filter',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'FFT',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Frame Scope',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Magnitude FFT',
      },
      {
        'count' => 4.0,
        'isMask' => 1.0,
        'type' => 'Maximum',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Periodogram',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Replaceable Contents',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Spectrum Scope',
      },
      {
        'count' => 3.0,
        'isMask' => 1.0,
        'type' => 'Window Function',
      },
      {
        'count' => 16.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Accumulator Block',
      },
      {
        'count' => 738.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Adder/Subtracter Block',
      },
      {
        'count' => 524.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Binary Shift Operator Block',
      },
      {
        'count' => 370.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Bit Slice Extractor Block',
      },
      {
        'count' => 6.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Bus Concatenator Block',
      },
      {
        'count' => 64.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Bus Multiplexer Block',
      },
      {
        'count' => 277.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Constant Block Block',
      },
      {
        'count' => 25.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Counter Block',
      },
      {
        'count' => 191.0,
        'isMask' => 1.0,
        'type' => 'Xilinx DSP48E1 Block',
      },
      {
        'count' => 684.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Delay Block',
      },
      {
        'count' => 22.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Dual Port Random Access Memory Block',
      },
      {
        'count' => 6.0,
        'isMask' => 1.0,
        'type' => 'Xilinx FDATool Interface Block',
      },
      {
        'count' => 79.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Gateway In Block',
      },
      {
        'count' => 20.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Gateway Out Block',
      },
      {
        'count' => 127.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Instruction Block Block',
      },
      {
        'count' => 9.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Inverter Block',
      },
      {
        'count' => 8.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Logical Block Block',
      },
      {
        'count' => 96.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Register Block',
      },
      {
        'count' => 126.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Single Port Read-Only Memory Block',
      },
      {
        'count' => 1.0,
        'isMask' => 1.0,
        'type' => 'Xilinx System Generator Block',
      },
      {
        'count' => 1182.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Type Converter Block',
      },
      {
        'count' => 951.0,
        'isMask' => 1.0,
        'type' => 'Xilinx Type Reinterpreter Block',
      },
    ],
    'model_globals_initialized' => 1.0,
    'model_path' => 'E:/Data/Design/duc_note/duc_16ch_341.mdl',
    'myxilinx' => 'D:/Xilinx/14.5/ISE_DS/ISE',
    'ngc_files' => [ 'xlpersistentdff.ngc', ],
    'num_sim_cycles' => '27306',
    'package' => 'ffg676',
    'part' => 'xc7k160t',
    'partFamily' => 'kintex7',
    'port_data_types_enabled' => 0.0,
    'preserve_hierarchy' => 0.0,
    'proj_type' => 'Project Navigator',
    'report_true_rates' => 0.0,
    'run_coregen' => 'off',
    'run_coregen_sgadvanced' => '',
    'sample_time_colors_enabled' => 1.0,
    'sampletimecolors' => 1.0,
    'sg_blockgui_xml' => '',
    'sg_icon_stat' => '50,50,-1,-1,token,white,0,07734,right,,[ ],[ ]',
    'sg_list_contents' => '',
    'sg_mask_display' => 'fprintf(\'\',\'COMMENT: begin icon graphics\');
patch([0 50 50 0 0 ],[0 0 50 50 0 ],[1 1 1 ]);
patch([1.6375 16.81 27.31 37.81 48.31 27.31 12.1375 1.6375 ],[36.655 36.655 47.155 36.655 47.155 47.155 47.155 36.655 ],[0.933333 0.203922 0.141176 ]);
patch([12.1375 27.31 16.81 1.6375 12.1375 ],[26.155 26.155 36.655 36.655 26.155 ],[0.698039 0.0313725 0.219608 ]);
patch([1.6375 16.81 27.31 12.1375 1.6375 ],[15.655 15.655 26.155 26.155 15.655 ],[0.933333 0.203922 0.141176 ]);
patch([12.1375 48.31 37.81 27.31 16.81 1.6375 12.1375 ],[5.155 5.155 15.655 5.155 15.655 15.655 5.155 ],[0.698039 0.0313725 0.219608 ]);
fprintf(\'\',\'COMMENT: end icon graphics\');
fprintf(\'\',\'COMMENT: begin icon text\');
fprintf(\'\',\'COMMENT: end icon text\');',
    'sg_version' => '',
    'sggui_pos' => '-1,-1,-1,-1',
    'simulation_island_subsystem_handle' => 2084.8011474609375,
    'simulink_accelerator_running' => 0.0,
    'simulink_debugger_running' => 0.0,
    'simulink_period' => 2.9296875E-9,
    'speed' => '-2',
    'synth_file' => 'XST Defaults*',
    'synthesisTool' => 'XST',
    'synthesis_language' => 'verilog',
    'synthesis_tool' => 'XST',
    'synthesis_tool_sgadvanced' => '',
    'sysclk_period' => 2.929,
    'sysgen' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen',
    'sysgenRoot' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen',
    'sysgenTokenSettings' => {
      'base_system_period_hardware' => 2.929,
      'base_system_period_simulink' => 2.9296875E-9,
      'block_icon_display' => 'Default',
      'block_type' => 'sysgen',
      'block_version' => '',
      'ce_clr' => 0.0,
      'clock_loc' => '',
      'clock_wrapper' => 'Clock Enables',
      'clock_wrapper_sgadvanced' => '',
      'compilation' => 'HDL Netlist',
      'compilation_lut' => {
        'keys' => [ 'HDL Netlist', ],
        'values' => [ 'target1', ],
      },
      'core_generation' => 1.0,
      'core_generation_sgadvanced' => '',
      'coregen_part_family' => 'kintex7',
      'create_interface_document' => 'off',
      'dbl_ovrd' => -1.0,
      'dbl_ovrd_sgadvanced' => '',
      'dcm_input_clock_period' => 10.0,
      'deprecated_control' => 'off',
      'deprecated_control_sgadvanced' => '',
      'directory' => 'E:/Data/Design/duc_note/duc_16ch_sg',
      'eval_field' => '0',
      'has_advanced_control' => '0',
      'impl_file' => 'ISE Defaults*',
      'incr_netlist' => 'off',
      'incr_netlist_sgadvanced' => '',
      'infoedit' => ' System Generator',
      'master_sysgen_token_handle' => 2085.0003662109375,
      'package' => 'ffg676',
      'part' => 'xc7k160t',
      'preserve_hierarchy' => 0.0,
      'proj_type' => 'Project Navigator',
      'run_coregen' => 'off',
      'run_coregen_sgadvanced' => '',
      'sg_blockgui_xml' => '',
      'sg_icon_stat' => '50,50,-1,-1,token,white,0,07734,right,,[ ],[ ]',
      'sg_list_contents' => '',
      'sg_mask_display' => 'fprintf(\'\',\'COMMENT: begin icon graphics\');
patch([0 50 50 0 0 ],[0 0 50 50 0 ],[1 1 1 ]);
patch([1.6375 16.81 27.31 37.81 48.31 27.31 12.1375 1.6375 ],[36.655 36.655 47.155 36.655 47.155 47.155 47.155 36.655 ],[0.933333 0.203922 0.141176 ]);
patch([12.1375 27.31 16.81 1.6375 12.1375 ],[26.155 26.155 36.655 36.655 26.155 ],[0.698039 0.0313725 0.219608 ]);
patch([1.6375 16.81 27.31 12.1375 1.6375 ],[15.655 15.655 26.155 26.155 15.655 ],[0.933333 0.203922 0.141176 ]);
patch([12.1375 48.31 37.81 27.31 16.81 1.6375 12.1375 ],[5.155 5.155 15.655 5.155 15.655 15.655 5.155 ],[0.698039 0.0313725 0.219608 ]);
fprintf(\'\',\'COMMENT: end icon graphics\');
fprintf(\'\',\'COMMENT: begin icon text\');
fprintf(\'\',\'COMMENT: end icon text\');',
      'sggui_pos' => '-1,-1,-1,-1',
      'simulation_island_subsystem_handle' => 2084.8011474609375,
      'simulink_period' => 2.9296875E-9,
      'speed' => '-2',
      'synth_file' => 'XST Defaults*',
      'synthesis_language' => 'verilog',
      'synthesis_tool' => 'XST',
      'synthesis_tool_sgadvanced' => '',
      'sysclk_period' => 2.929,
      'testbench' => 0,
      'testbench_sgadvanced' => '',
      'trim_vbits' => 1.0,
      'trim_vbits_sgadvanced' => '',
      'xilinx_device' => 'xc7k160t-2ffg676',
      'xilinxfamily' => 'kintex7',
    },
    'sysgen_Root' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen',
    'systemClockPeriod' => 2.929,
    'tempdir' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp',
    'testbench' => 0,
    'testbench_sgadvanced' => '',
    'tmpDir' => 'E:/Data/Design/duc_note/duc_16ch_sg/sysgen',
    'trim_vbits' => 1.0,
    'trim_vbits_sgadvanced' => '',
    'use_strict_names' => 1,
    'user_tips_enabled' => 0.0,
    'usertemp' => 'C:/Users/LAUREN~1.COM/AppData/Local/Temp/sysgentmp-laurengao',
    'using71Netlister' => 1,
    'verilog_files' => [
      'conv_pkg.v',
      'synth_reg.v',
      'synth_reg_w_init.v',
      'convert_type.v',
    ],
    'version' => '',
    'vhdl_files' => [
      'conv_pkg.vhd',
      'synth_reg.vhd',
      'synth_reg_w_init.vhd',
    ],
    'vsimtime' => '88255.226667 ns',
    'xilinx' => 'D:/Xilinx/14.5/ISE_DS/ISE',
    'xilinx_device' => 'xc7k160t-2ffg676',
    'xilinx_family' => 'kintex7',
    'xilinx_package' => 'ffg676',
    'xilinx_part' => 'xc7k160t',
    'xilinxdevice' => 'xc7k160t-2ffg676',
    'xilinxfamily' => 'kintex7',
    'xilinxpart' => 'xc7k160t',
  };
  push(@$results, &Sg::setAttributes($instrs));
  use SgDeliverFile;
  $instrs = {
    'collaborationName' => 'conv_pkg.v',
    'sourceFile' => 'hdl/conv_pkg.v',
    'templateKeyValues' => {},
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'collaborationName' => 'synth_reg.v',
    'sourceFile' => 'hdl/synth_reg.v',
    'templateKeyValues' => {},
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'collaborationName' => 'synth_reg_w_init.v',
    'sourceFile' => 'hdl/synth_reg_w_init.v',
    'templateKeyValues' => {},
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'collaborationName' => 'convert_type.v',
    'sourceFile' => 'hdl/convert_type.v',
    'templateKeyValues' => {},
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'collaborationName' => 'xlpersistentdff.ngc',
    'sourceFile' => 'hdl/xlpersistentdff.ngc',
    'templateKeyValues' => {},
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  use SgGenerateCores;
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 20',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 20',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 20',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_cfbd5258ba626a7a',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '5bee6a10e9be4edf1d75e39787012f8d',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[19:0] A;
     input CLK;
     input CE;
     output[19:0] S;
     input[19:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_cfbd5258ba626a7a',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 27',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 27',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 27',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_315e1457f99dae5e',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '5cdef60c882d11139ef454fe2e2f032f',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[26:0] A;
     input CLK;
     input CE;
     output[26:0] S;
     input[26:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_315e1457f99dae5e',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 23',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 23',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 23',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_ccf4ef11a52a233f',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a2705b3042f65fac1c2ea8ecf818a601',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[22:0] A;
     input CLK;
     input CE;
     output[22:0] S;
     input[22:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_ccf4ef11a52a233f',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 31',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 31',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 31',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_f1b619e12671c199',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '64ed8d0e648ed3799013fb47df5ede74',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[30:0] A;
     input CLK;
     input CE;
     output[30:0] S;
     input[30:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_f1b619e12671c199',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3781cb69869878ddb4681e5a9a383933',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8b19adda93272a5f5a273f643cf6d9e5',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '495cd498a7f60cabe1fb3b84a552263b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '572d9b9aa004e9dc92ef1f9cb2b6c447',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0a92f51c1d724085d92755634235a776',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8982a28ad79956a13b2256c6a48d43b9',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a9bd19b8d4c97d23421e5d37c84f4c6c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '90544d8130e80d9eaf617e63a1b40ff4',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{2{ip_1_23[18]}}, ip_1_23[18:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_3fa2663220',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '9375095ae9894bc009e481cc74d32bd1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32\'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32\'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{2{ip_1_23[31]}}, ip_1_23[31:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_d13a4b790a',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '641edfc6c1309ac6b80318f25c1b3401',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[18]}}, ip_1_23[18:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_091db5281e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '96f2a32db16ad9bcebdb62aea529e843',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(22 - 1):0] ip,
  output [(22 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(22 - 1):0] ip_1_23;
  localparam signed [(22 - 1):0] const_value = 22\'sb0000000000000000000000;
  reg signed [(22 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 22\'b0000000000000000000000;
    end
  wire signed [(22 - 1):0] op_mem_46_20_front_din;
  wire signed [(22 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(22 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[21]}}, ip_1_23[21:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_6a42af8a02',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '762f8598c5167de6a2a6d9a239dd2901',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(26 - 1):0] ip,
  output [(26 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(26 - 1):0] ip_1_23;
  localparam signed [(26 - 1):0] const_value = 26\'sb00000000000000000000000000;
  reg signed [(26 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 26\'b00000000000000000000000000;
    end
  wire signed [(26 - 1):0] op_mem_46_20_front_din;
  wire signed [(26 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(28 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(26 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[25]}}, ip_1_23[25:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[27]}}, cast_internal_ip_27_3_rsh[27:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_860703fe20',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '40766ef3697aa878bea854fa24d63ab0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(22 - 1):0] ip,
  output [(22 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(22 - 1):0] ip_1_23;
  localparam signed [(22 - 1):0] const_value = 22\'sb0000000000000000000000;
  reg signed [(22 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 22\'b0000000000000000000000;
    end
  wire signed [(22 - 1):0] op_mem_46_20_front_din;
  wire signed [(22 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(22 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[21]}}, ip_1_23[21:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_773079a115',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '13c676b17e796698d660191e032366d2',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(30 - 1):0] ip,
  output [(30 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(30 - 1):0] ip_1_23;
  localparam signed [(30 - 1):0] const_value = 30\'sb000000000000000000000000000000;
  reg signed [(30 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 30\'b000000000000000000000000000000;
    end
  wire signed [(30 - 1):0] op_mem_46_20_front_din;
  wire signed [(30 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(32 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(30 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[29]}}, ip_1_23[29:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[31]}}, cast_internal_ip_27_3_rsh[31:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_2b728df15b',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b3fdca6c5bd33ef20b3b037080cd76d9',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(1 - 1):0] sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  localparam [(16 - 1):0] const_value = 16\'b0000000000000000;
  reg [(16 - 1):0] pipe_16_22[0:(1 - 1)];
  initial
    begin
      pipe_16_22[0] = 16\'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_16_22_front_din;
  wire [(16 - 1):0] pipe_16_22_back;
  wire pipe_16_22_push_front_pop_back_en;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign pipe_16_22_back = pipe_16_22[0];
  always @(posedge clk)
    begin:proc_pipe_16_22
      integer i;
      if (((ce == 1\'b1) && (pipe_16_22_push_front_pop_back_en == 1\'b1)))
        begin
          pipe_16_22[0] <= pipe_16_22_front_din;
        end
    end
  always @(d0_1_24 or d1_1_27 or sel_1_20)
    begin:proc_switch_6_1
      case (sel_1_20)
        1\'b0 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        default:
          begin
            unregy_join_6_1 = d1_1_27;
          end
      endcase
    end
  assign pipe_16_22_front_din = unregy_join_6_1;
  assign pipe_16_22_push_front_pop_back_en = 1\'b1;
  assign y = pipe_16_22_back;
endmodule
',
      'entity_name' => 'mux_1f6c522247',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '48a5a46513fb09ce3b6575fd8d5ebd2f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111111110101000001;
endmodule
',
      'entity_name' => 'constant_93b414a047',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '3e8d8792f6a82a1430a01e2060ea1818',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48\'b000000000000000000000000000000000000111111111111;
endmodule
',
      'entity_name' => 'constant_d1c6dff675',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'de6fe6379c83f75eb6b20620204cb181',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3f2dee98a3ab7c701b2be8edcbd9bc3b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '59fdf8b776c16a237b20acb7e89c5fe2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '073faba8dfd8d5c6771254fb0f9a3e5a',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '410379ad9dc0f03f8134e86364e37087',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '50832d7b17e41d975bfc4ff90e1e17c8',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00101000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00101;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00101000000000110101;
  assign op = 20\'b00101000000000110101;
endmodule
',
      'entity_name' => 'opmode_6481474c6d',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '14e8d6f451049614b0ff451e537ed213',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_81b71e1f8b',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '06bbe8a6497821ab5faadb72c59af65b',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] input_port,
  output [(18 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_0e0c011a4e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'add529a71db7be9d2c7d451442a0ac77',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(48 - 1):0] input_port,
  output [(48 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(48 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_5668f8e576',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '5064c7845bdfed4d1bd99ddad024f1a2',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000001001000001111;
endmodule
',
      'entity_name' => 'constant_4d353c6047',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e066d439d5ac9be1d7c8e6336e651143',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b010011011011100111;
endmodule
',
      'entity_name' => 'constant_b293d8004e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '9b7ef4c69737f2f39d92e1cbf28f70f1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] in0,
  input [(16 - 1):0] in1,
  output [(32 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(16 - 1):0] in0_1_23;
  wire [(16 - 1):0] in1_1_27;
  wire [(32 - 1):0] y_2_1_concat;
  assign in0_1_23 = in0;
  assign in1_1_27 = in1;
  assign y_2_1_concat = {in0_1_23, in1_1_27};
  assign y = y_2_1_concat;
endmodule
',
      'entity_name' => 'concat_7e18b92ffa',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '28dbd6b73312aed03ea951727c54b8a6',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 1\'b1;
endmodule
',
      'entity_name' => 'constant_5e90e4a8ec',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '053f056cebb4fcce5f014c029a109e3d',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '53b24e9a5fe1ecf998acbe24044e2a17',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 32',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 16',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = dual_port_ram',
    'CSET output_options = non_registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = false',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_903d17a1900ee539',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bb44fd54560340126ad6ae47219284aa',
    'sourceFile' => 'hdl/xldpram_dist.v',
    'templateKeyValues' => {
      'core_component_def' => ' (a, clk, d, we, dpra, spo, dpo)/* synthesis syn_black_box */;
      input [3:0] a, dpra;
      input [31:0] d;
      input clk, we;
      output [31:0] spo, dpo;',
      'core_instance_text' => '      .a(core_addra),
      .clk(a_clk),
      .d(dina),
      .we(core_we),
      .dpra(core_addrb),
      .spo(core_douta),
      .dpo(core_doutb)
',
      'core_name0' => 'dmg_72_903d17a1900ee539',
      'entityName' => 'xldpram_dist_duc_16ch_341',
      'entity_name.0' => 'xldpram_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 3, 5, 7, 9, B, D, F, 0, 2, 4, 6, 8, A, C, E, 1;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 4',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 16',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_85ef246b9b71061d',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b4284a1f899cd670b3f5a63028b42591',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_85ef246b9b71061d',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '877f86216f0b7f4500ded5c7a51f0606',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] input_port_1_40;
  wire [(16 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_2824f666f2',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c7b119821d27b13746c3d0698ec84dc0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] input_port,
  output [(16 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(16 - 1):0] input_port_1_40;
  wire signed [(16 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_dee95c6dbb',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '148929036062563c9fcb554db82680b8',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '466f5031cc21b6555d94efc4c99c5b5e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 21',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 21',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 21',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_c70c61eff7bb7aeb',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ef1018ae6767e7479b9fa595bb35424c',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[20:0] A;
     input CLK;
     input CE;
     output[20:0] S;
     input[20:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_c70c61eff7bb7aeb',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 21',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 21',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 21',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_750c6c8a22bc78ba',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '75fe0ecd2819554359749f3767f887ad',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[20:0] A;
     input CLK;
     input CE;
     output[20:0] S;
     input[20:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_750c6c8a22bc78ba',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '48841ffcdec22d7b68621bf24f15fdff',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] a,
  input [(16 - 1):0] b,
  output [(17 - 1):0] s,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] a_17_32;
  wire signed [(16 - 1):0] b_17_35;
  localparam signed [(17 - 1):0] const_value = 17\'sb00000000000000000;
  reg signed [(17 - 1):0] op_mem_91_20[0:(1 - 1)];
  initial
    begin
      op_mem_91_20[0] = 17\'b00000000000000000;
    end
  wire signed [(17 - 1):0] op_mem_91_20_front_din;
  wire signed [(17 - 1):0] op_mem_91_20_back;
  wire op_mem_91_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b0;
  reg [(1 - 1):0] cout_mem_92_22[0:(1 - 1)];
  initial
    begin
      cout_mem_92_22[0] = 1\'b0;
    end
  wire [(1 - 1):0] cout_mem_92_22_front_din;
  wire [(1 - 1):0] cout_mem_92_22_back;
  wire cout_mem_92_22_push_front_pop_back_en;
  wire [(3 - 1):0] prev_mode_93_22_next;
  wire [(3 - 1):0] prev_mode_93_22;
  wire [(3 - 1):0] prev_mode_93_22_reg_i;
  wire [(3 - 1):0] prev_mode_93_22_reg_o;
  localparam [(1 - 1):0] const_value_x_000001 = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000002 = 1\'b1;
  localparam [(1 - 1):0] const_value_x_000003 = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000004 = 1\'b0;
  wire signed [(17 - 1):0] cast_69_18;
  wire signed [(17 - 1):0] cast_69_22;
  wire signed [(17 - 1):0] internal_s_69_5_addsub;
  localparam [(1 - 1):0] const_value_x_000005 = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000006 = 1\'b0;
  localparam [(3 - 1):0] const_value_x_000007 = 3\'b000;
  assign a_17_32 = a;
  assign b_17_35 = b;
  assign op_mem_91_20_back = op_mem_91_20[0];
  always @(posedge clk)
    begin:proc_op_mem_91_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_91_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_91_20[0] <= op_mem_91_20_front_din;
        end
    end
  assign cout_mem_92_22_back = cout_mem_92_22[0];
  always @(posedge clk)
    begin:proc_cout_mem_92_22
      integer i_x_000000;
      if (((ce == 1\'b1) && (cout_mem_92_22_push_front_pop_back_en == 1\'b1)))
        begin
          cout_mem_92_22[0] <= cout_mem_92_22_front_din;
        end
    end
  assign prev_mode_93_22_reg_i = prev_mode_93_22_next;
  assign prev_mode_93_22 = prev_mode_93_22_reg_o;
  defparam prev_mode_93_22_reg_inst.init_index = 2;
  defparam prev_mode_93_22_reg_inst.init_value = 3\'b010;
  defparam prev_mode_93_22_reg_inst.latency = 1;
  defparam prev_mode_93_22_reg_inst.width = 3;
  synth_reg_w_init prev_mode_93_22_reg_inst(.ce(ce), .clk(clk), .clr(clr), .i(prev_mode_93_22_reg_i), .o(prev_mode_93_22_reg_o));
  assign cast_69_18 = {{1{a_17_32[15]}}, a_17_32[15:0]};
  assign cast_69_22 = {{1{b_17_35[15]}}, b_17_35[15:0]};
  assign internal_s_69_5_addsub = cast_69_18 + cast_69_22;
  assign op_mem_91_20_front_din = internal_s_69_5_addsub;
  assign op_mem_91_20_push_front_pop_back_en = 1\'b1;
  assign cout_mem_92_22_front_din = const_value_x_000006;
  assign cout_mem_92_22_push_front_pop_back_en = 1\'b1;
  assign prev_mode_93_22_next = const_value_x_000007;
  assign s = op_mem_91_20_back;
endmodule
',
      'entity_name' => 'addsub_f03aa9b11e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '1089480211207c7128846e22c84f71ad',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '344adf6a97b45147b8556969f7c508f3',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '95412a5911a90558a25e3c412deff594',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '5e740f0f3671d076d860d4bfd7f89443',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e7a69cf534de58b2f2a1e7e5a2da637d',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3090aae2effb8828e2354f7ea7e742de',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e8a264b141775a0d0e6d803c1cf95322',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '6102eccba28689a449acd9239a1d8c56',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Binary_Counter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ainit_value = 0',
    'CSET ce = true',
    'CSET count_mode = UP',
    'CSET fb_latency = 0',
    'CSET final_count_value = 1',
    'CSET implementation = Fabric',
    'CSET increment_value = 1',
    'CSET latency = 1',
    'CSET load = false',
    'CSET output_width = 4',
    'CSET restrict_count = false',
    'CSET sclr = false',
    'CSET sinit = true',
    'CSET sinit_value = 0',
    'CSET sset = false',
    'CSET sync_ce_priority = Sync_Overrides_CE',
    'CSET sync_threshold_output = false',
    'CSET syncctrlpriority = Reset_Overrides_Set',
    'CSET component_name = cntr_11_0_7a9f00e1c86c8fba',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '7bd6c31fe197cffdbc8a0b9bb1256f09',
    'sourceFile' => 'hdl/xlcounter_limit.v',
    'templateKeyValues' => {
      'core_instance_text' => '        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)',
      'core_name0' => 'cntr_11_0_7a9f00e1c86c8fba',
      'entityName' => 'xlcounter_limit_duc_16ch_341',
      'entity_name.0' => 'xlcounter_limit',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0cfb59a350d714d01b38ce3e0dd51541',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] rst,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire rst_1_40;
  reg [(1 - 1):0] count_reg_20_23 = 1\'b0;
  wire count_reg_20_23_rst;
  localparam [(1 - 1):0] const_value = 1\'b1;
  localparam [(2 - 1):0] const_value_x_000000 = 2\'b10;
  localparam [(1 - 1):0] const_value_x_000001 = 1\'b1;
  localparam [(1 - 1):0] const_value_x_000002 = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000003 = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000004 = 1\'b1;
  wire bool_44_4;
  reg rst_limit_join_44_1;
  reg [(2 - 1):0] count_reg_join_44_1;
  reg count_reg_join_44_1_rst;
  assign rst_1_40 = rst;
  always @(posedge clk)
    begin:proc_count_reg_20_23
      if (((ce == 1\'b1) && (count_reg_20_23_rst == 1\'b1)))
        begin
          count_reg_20_23 <= 1\'b0;
        end
      else if ((ce == 1\'b1))
        begin
          count_reg_20_23 <= count_reg_20_23 + const_value_x_000004;
        end
    end
  assign bool_44_4 = rst_1_40 || 1\'b0;
  always @(bool_44_4 or count_reg_20_23)
    begin:proc_if_44_1
      if (bool_44_4)
        begin
          count_reg_join_44_1_rst = 1\'b1;
        end
      else 
        begin
          count_reg_join_44_1_rst = 1\'b0;
        end
      if (bool_44_4)
        begin
          rst_limit_join_44_1 = 1\'b0;
        end
      else 
        begin
          rst_limit_join_44_1 = 1\'b0;
        end
    end
  assign count_reg_20_23_rst = count_reg_join_44_1_rst;
  assign op = count_reg_20_23;
endmodule
',
      'entity_name' => 'counter_5c8ee48e8f',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 29',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 29',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 29',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_45f8b994267d2451',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a65a9f5b4625681be699cd1e098f3d7b',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[28:0] A;
     input CLK;
     input CE;
     output[28:0] S;
     input[28:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_45f8b994267d2451',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 22',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 22',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 22',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_d0318fcf26b3c272',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c9cc366a14bfa271ced3a1aadc9de7f0',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[21:0] A;
     input CLK;
     input CE;
     output[21:0] S;
     input[21:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_d0318fcf26b3c272',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a7550a5448794ccd95fefb43cbd108e3',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2291060d2c72a0124d425d9bec348753',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '27bef48b50414bc2ae010154b7b02d43',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '347ba5c8538ab2395a134319d4f9ba67',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '5c1fa455c64c80ba952f4269d62d3507',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21\'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21\'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[20]}}, ip_1_23[20:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_a0dd291710',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '60fe83ee6854c85f7615cb3d746d2296',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21\'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21\'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_92fa79e61c',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '398ca3afe4063d37f349a011f9a9938f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(28 - 1):0] ip,
  output [(28 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(28 - 1):0] ip_1_23;
  localparam signed [(28 - 1):0] const_value = 28\'sb0000000000000000000000000000;
  reg signed [(28 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 28\'b0000000000000000000000000000;
    end
  wire signed [(28 - 1):0] op_mem_46_20_front_din;
  wire signed [(28 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(33 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(28 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[27]}}, ip_1_23[27:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[32]}}, cast_internal_ip_27_3_rsh[32:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_be765386ae',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e9bbe7e00e266fc96f7ea14f4aaa2cb9',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32\'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32\'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(34 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[31]}}, ip_1_23[31:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[33]}}, cast_internal_ip_27_3_rsh[33:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_58794f53f4',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 22',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 22',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 22',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_82f1c5fd59d21ea0',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '64699b327fbe2342dc216782cf8af777',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[21:0] A;
     input CLK;
     input CE;
     output[21:0] S;
     input[21:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_82f1c5fd59d21ea0',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 25',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 25',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 25',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_27308e86a0ce55d1',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '6fd4b9b18aaebfd37adbeb0f765d3cdd',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[24:0] A;
     input CLK;
     input CE;
     output[24:0] S;
     input[24:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_27308e86a0ce55d1',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e4010ef8dc9db56f25ea1fcfe57ae673',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'dcffbff561b6020953f7a5b9e7afae3e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e8ce8539d415ddf499ddc424dac26ae3',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8336eebbacbdf31f6f413fe63578dc0c',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(24 - 1):0] ip,
  output [(24 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(24 - 1):0] ip_1_23;
  localparam signed [(24 - 1):0] const_value = 24\'sb000000000000000000000000;
  reg signed [(24 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 24\'b000000000000000000000000;
    end
  wire signed [(24 - 1):0] op_mem_46_20_front_din;
  wire signed [(24 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(24 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[23]}}, ip_1_23[23:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_940a0f4802',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c75f9910af787e6b52047f47ed265596',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(27 - 1):0] ip,
  output [(27 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(27 - 1):0] ip_1_23;
  localparam signed [(27 - 1):0] const_value = 27\'sb000000000000000000000000000;
  reg signed [(27 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 27\'b000000000000000000000000000;
    end
  wire signed [(27 - 1):0] op_mem_46_20_front_din;
  wire signed [(27 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(28 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(27 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[26]}}, ip_1_23[26:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[27]}}, cast_internal_ip_27_3_rsh[27:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_cecea44c7e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 26',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 26',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 26',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_3cbd55626510ca57',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a0d23da33390bdca03a050783eb6be6f',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[25:0] A;
     input CLK;
     input CE;
     output[25:0] S;
     input[25:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_3cbd55626510ca57',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 25',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 25',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 25',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_27308e86a0ce55d1',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cbe2a28bcf5a0772eda15456e5e588d1',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[24:0] A;
     input CLK;
     input CE;
     output[24:0] S;
     input[24:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_27308e86a0ce55d1',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 33',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 33',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 33',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_fc66294023431638',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '8363318961db17ac8320635a91224953',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[32:0] A;
     input CLK;
     input CE;
     output[32:0] S;
     input[32:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_fc66294023431638',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c4830262bcabb28710953393a8383bc9',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c45a416592d68fc18a413b81f07da930',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e326f735bb5af92b8374b1a4fbdc0144',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '431af01373341aca49c7c55fbf7aa449',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '5f9fd821db621b8dfd6e1850f7ce0300',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[19]}}, ip_1_23[19:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_7d97a52cb7',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '031aadc88f0e2f11f40cb29cb7a4c1d7',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(24 - 1):0] ip,
  output [(24 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(24 - 1):0] ip_1_23;
  localparam signed [(24 - 1):0] const_value = 24\'sb000000000000000000000000;
  reg signed [(24 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 24\'b000000000000000000000000;
    end
  wire signed [(24 - 1):0] op_mem_46_20_front_din;
  wire signed [(24 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(24 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[23]}}, ip_1_23[23:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_c3b3a63c34',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '4dd05eeb0526408a63a4e01e289bbb35',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(25 - 1):0] ip,
  output [(25 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(25 - 1):0] ip_1_23;
  localparam signed [(25 - 1):0] const_value = 25\'sb0000000000000000000000000;
  reg signed [(25 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 25\'b0000000000000000000000000;
    end
  wire signed [(25 - 1):0] op_mem_46_20_front_din;
  wire signed [(25 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(25 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[24]}}, ip_1_23[24:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_0f7277fd89',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '91538a7f746d2034b2aa52e8ee5861f5',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(32 - 1):0] ip,
  output [(32 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] ip_1_23;
  localparam signed [(32 - 1):0] const_value = 32\'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 32\'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_46_20_front_din;
  wire signed [(32 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(37 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(32 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[31]}}, ip_1_23[31:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[36]}}, cast_internal_ip_27_3_rsh[36:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_a47dc9adee',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0cd88b25a25465a885ba9c1382501796',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2abf54f111bc14e3df53d0bbc9f58540',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 0, 0, 0, 0, 0, 0, 0;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 32',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 16',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = dual_port_ram',
    'CSET output_options = non_registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = false',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_1c9994abe91d1da0',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '5ab994b9b4c83181671681f73138514d',
    'sourceFile' => 'hdl/xldpram_dist.v',
    'templateKeyValues' => {
      'core_component_def' => ' (a, clk, d, we, dpra, spo, dpo)/* synthesis syn_black_box */;
      input [3:0] a, dpra;
      input [31:0] d;
      input clk, we;
      output [31:0] spo, dpo;',
      'core_instance_text' => '      .a(core_addra),
      .clk(a_clk),
      .d(dina),
      .we(core_we),
      .dpra(core_addrb),
      .spo(core_douta),
      .dpo(core_doutb)
',
      'core_name0' => 'dmg_72_1c9994abe91d1da0',
      'entityName' => 'xldpram_dist_duc_16ch_341',
      'entity_name.0' => 'xldpram_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 3, 5, 7, 0, 2, 4, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 3',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 16',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_9ec52875c6eb4958',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '04a59f9e2ec1d7a06901b77c9343eeff',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_9ec52875c6eb4958',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Binary_Counter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ainit_value = 0',
    'CSET ce = true',
    'CSET count_mode = UP',
    'CSET fb_latency = 0',
    'CSET final_count_value = 1',
    'CSET implementation = Fabric',
    'CSET increment_value = 1',
    'CSET latency = 1',
    'CSET load = false',
    'CSET output_width = 3',
    'CSET restrict_count = false',
    'CSET sclr = false',
    'CSET sinit = true',
    'CSET sinit_value = 0',
    'CSET sset = false',
    'CSET sync_ce_priority = Sync_Overrides_CE',
    'CSET sync_threshold_output = false',
    'CSET syncctrlpriority = Reset_Overrides_Set',
    'CSET component_name = cntr_11_0_6da79292a37693ee',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '3f09900ed20a46983e7aafac2f9c9b7f',
    'sourceFile' => 'hdl/xlcounter_limit.v',
    'templateKeyValues' => {
      'core_instance_text' => '        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)',
      'core_name0' => 'cntr_11_0_6da79292a37693ee',
      'entityName' => 'xlcounter_limit_duc_16ch_341',
      'entity_name.0' => 'xlcounter_limit',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '38b681415ca5a0161169b50c7914f900',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bf287f648e82e483eb6ec6a1e0ac3c45',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b010100001101100011;
endmodule
',
      'entity_name' => 'constant_d02c6ca527',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '02b2076de172df0b48dbf5337a40d5ab',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000000000100100010;
endmodule
',
      'entity_name' => 'constant_ccb8aa4d51',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '671e05822861272c20a9ec3fab4219c0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111111110100111111;
endmodule
',
      'entity_name' => 'constant_bc660b1e56',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '2ec8f9c581629a15b883d1a31e80f7d1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48\'b000000000000000000000000000001111111111111111111;
endmodule
',
      'entity_name' => 'constant_78b68b2393',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0d6add06815a011dfa9f77a58725cb86',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111111111110100011;
endmodule
',
      'entity_name' => 'constant_9ed9b075a6',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '01bd91683a65630a7d977086ed74ef19',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000000010110110010;
endmodule
',
      'entity_name' => 'constant_a3a888533e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0df29a88685c6a82fa5f7c126c6d4209',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111111010101011111;
endmodule
',
      'entity_name' => 'constant_cb858d1f75',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e889daa71727fb2ea5810ea55f6b46ae',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000001001010001101;
endmodule
',
      'entity_name' => 'constant_bd1e327723',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '70ff2d9bca3720615c608387cd870158',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111110000010110001;
endmodule
',
      'entity_name' => 'constant_2544d97e53',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '413170afc567d8dc63e686a5e74b73a1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000011010101100010;
endmodule
',
      'entity_name' => 'constant_9f55c36ec5',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a691df2283d150213a9d86b6f49d7ee8',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111001101011010100;
endmodule
',
      'entity_name' => 'constant_1807e2a2f1',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '06b0e8d13eb40d0c5d8b076e128f309c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '86e962356b327f1ae110ef6d0fe14376',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f5b4bbeea4cc3d0e8101eaa44e0387de',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '7905da8cc2c912c0e0f89a8f3c3e0fa6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '07f03a4dedb01e460dd6d2b009cb7340',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a7f0f7b18413a95e20b3dd662392f4ca',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bd194574bfecd4058a96e7ea07e7a89c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bc075a99fc465388be3f311f161df88f',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '39cb9855528688608c7e2eb7ec1ca86e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '04ac386dea5b96b8cad187970aa1d591',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b10100000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b10100;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b10100000000000110101;
  assign op = 20\'b10100000000000110101;
endmodule
',
      'entity_name' => 'opmode_de16be0052',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '547f98f80c1d08f26c2412f046bbb80a',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00100000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00100;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00100000000000010101;
  assign op = 20\'b00100000000000010101;
endmodule
',
      'entity_name' => 'opmode_96dace4a09',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '37c215522d13394a323c97413cbd72cb',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] input_port,
  output [(19 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_f67f49dab9',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b9a824148858d6d61f39564ffc7d0127',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000000100110011101;
endmodule
',
      'entity_name' => 'constant_998c05c36c',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd9b416dd307982f467de2fb2f6cff5bb',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48\'b000000000000000000000000000000001111111111111111;
endmodule
',
      'entity_name' => 'constant_ca7488d888',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0e1a6297a065754538a0f0118eceb8cd',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b111100010100100101;
endmodule
',
      'entity_name' => 'constant_23baa7aa71',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '1c0c49642cabfd07808fe2b5e8f2af13',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ab9f370c91f67b1b2a6dca2f7fded924',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00101000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00101;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00101000000000010101;
  assign op = 20\'b00101000000000010101;
endmodule
',
      'entity_name' => 'opmode_77dfa9804f',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '9200d95d70261a1f3581df92ca8eac13',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b010011000101100101;
endmodule
',
      'entity_name' => 'constant_41c9a265eb',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '69a403098263173e1b15e1c4c1029365',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '18855fb895644b0848c3f8a17535e837',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Add_Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_9196f8ffd2db8ce4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '143ee53300ce3357a15bba36ffac8f0b',
    'sourceFile' => 'hdl/xladdsubmode.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, ADD, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input ADD;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .add(add),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_9196f8ffd2db8ce4',
      'entityName' => 'xladdsubmode_duc_16ch_341',
      'entity_name.0' => 'xladdsubmode',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '412303b9acf7f38d7b870e5959c2b4c0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 16\'b0000000000000000;
endmodule
',
      'entity_name' => 'constant_281c9dad53',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '259ba10d72e5de529924de62fc2b1caf',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e0431adfe811d62e19a20fc36f54dd6c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '85147114427397e4db43f1f7d940223e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '46a24fc52194d2a0b54c31bc61556725',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(2 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  input [(16 - 1):0] d2,
  input [(16 - 1):0] d3,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(2 - 1):0] sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  wire [(16 - 1):0] d2_1_30;
  wire [(16 - 1):0] d3_1_33;
  localparam [(16 - 1):0] const_value = 16\'b0000000000000000;
  reg [(16 - 1):0] pipe_20_22[0:(1 - 1)];
  initial
    begin
      pipe_20_22[0] = 16\'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_20_22_front_din;
  wire [(16 - 1):0] pipe_20_22_back;
  wire pipe_20_22_push_front_pop_back_en;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign d3_1_33 = d3;
  assign pipe_20_22_back = pipe_20_22[0];
  always @(posedge clk)
    begin:proc_pipe_20_22
      integer i;
      if (((ce == 1\'b1) && (pipe_20_22_push_front_pop_back_en == 1\'b1)))
        begin
          pipe_20_22[0] <= pipe_20_22_front_din;
        end
    end
  always @(d0_1_24 or d1_1_27 or d2_1_30 or d3_1_33 or sel_1_20)
    begin:proc_switch_6_1
      case (sel_1_20)
        2\'b00 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        2\'b01 :
          begin
            unregy_join_6_1 = d1_1_27;
          end
        2\'b10 :
          begin
            unregy_join_6_1 = d2_1_30;
          end
        default:
          begin
            unregy_join_6_1 = d3_1_33;
          end
      endcase
    end
  assign pipe_20_22_front_din = unregy_join_6_1;
  assign pipe_20_22_push_front_pop_back_en = 1\'b1;
  assign y = pipe_20_22_back;
endmodule
',
      'entity_name' => 'mux_a6eee4b271',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_3b5cfe2278dc7df8',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c6c9ab2b14d156e906d698ac5f07b86d',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_3b5cfe2278dc7df8',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_1ae7fcb63c340449',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '18f1fcc58faa62a290ba09af4e706970',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_1ae7fcb63c340449',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '16e2d80c6b16b9fca29b112be060a959',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(17 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[16]}}, cast_internal_ip_27_3_rsh[16:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_12819d6cbe',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ccdb9a77e7efd2c67c57b87ab9daeb98',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_36_3_convert = {{1{ip_1_23[15]}}, ip_1_23[15:1]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_4108be98c5',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '9a684f8ebd8eada70f6ad58f8464d0c0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(19 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[18]}}, cast_internal_ip_27_3_rsh[18:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_5447e0aa7e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'fbeb9b9ddeed29b7ca6312f37443f7e5',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_a05534ab8e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0224ad0c0528e25f64d2e821f5172ca7',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(18 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[17]}}, cast_internal_ip_27_3_rsh[17:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_1aa26d2e4f',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'fe8fb12b7c0d21cd67a5b7f58c053d04',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e4564315fbfedcb70ff8a1a57e59ab24',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_997986a690',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f7d093d2bce4fdf31fd9b99a2c886d3f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(26 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{6{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[25]}}, cast_internal_ip_27_3_rsh[25:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_9f4e80fae7',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a25cd3a29e02c78deb42f78b141193a1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_c6a2804ac2',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Add_Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_9196f8ffd2db8ce4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b8974a3271c19f99594d963fcb1084af',
    'sourceFile' => 'hdl/xladdsubmode.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, ADD, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input ADD;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .add(add),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_9196f8ffd2db8ce4',
      'entityName' => 'xladdsubmode_duc_16ch_341',
      'entity_name.0' => 'xladdsubmode',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'aeef90f2a5fcceccd4864d11c25cdecb',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4be98e5d24ec68de5687d5a4186bcd1e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f2b6b0e25385f9fea822acf80baa3efa',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(4 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1\'b0;
      op_mem_22_20[1] = 1\'b0;
      op_mem_22_20[2] = 1\'b0;
      op_mem_22_20[3] = 1\'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(3 - 1):0] const_value = 3\'b100;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[3];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_22_20_push_front_pop_back_en == 1\'b1)))
        begin
          for (i=3; i>=1; i=i-1)
            begin
              op_mem_22_20[i] <= op_mem_22_20[i-1];
            end
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_front_din = internal_ip_12_1_bitnot;
  assign op_mem_22_20_push_front_pop_back_en = 1\'b1;
  assign op = op_mem_22_20_back;
endmodule
',
      'entity_name' => 'inverter_48d1f6b088',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '422c3e8049ea94dff1a332f519d9e55d',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2d2d46459f8df18f99ec03a501992463',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] sel,
  input [(16 - 1):0] d0,
  input [(16 - 1):0] d1,
  output [(16 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire sel_1_20;
  wire [(16 - 1):0] d0_1_24;
  wire [(16 - 1):0] d1_1_27;
  localparam [(16 - 1):0] const_value = 16\'b0000000000000000;
  reg [(16 - 1):0] pipe_16_22[0:(1 - 1)];
  initial
    begin
      pipe_16_22[0] = 16\'b0000000000000000;
    end
  wire [(16 - 1):0] pipe_16_22_front_din;
  wire [(16 - 1):0] pipe_16_22_back;
  wire pipe_16_22_push_front_pop_back_en;
  wire [(1 - 1):0] sel_internal_2_1_convert;
  reg [(16 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign pipe_16_22_back = pipe_16_22[0];
  always @(posedge clk)
    begin:proc_pipe_16_22
      integer i;
      if (((ce == 1\'b1) && (pipe_16_22_push_front_pop_back_en == 1\'b1)))
        begin
          pipe_16_22[0] <= pipe_16_22_front_din;
        end
    end
  assign sel_internal_2_1_convert = {sel_1_20};
  always @(d0_1_24 or d1_1_27 or sel_internal_2_1_convert)
    begin:proc_switch_6_1
      case (sel_internal_2_1_convert)
        1\'b0 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        default:
          begin
            unregy_join_6_1 = d1_1_27;
          end
      endcase
    end
  assign pipe_16_22_front_din = unregy_join_6_1;
  assign pipe_16_22_push_front_pop_back_en = 1\'b1;
  assign y = pipe_16_22_back;
endmodule
',
      'entity_name' => 'mux_f3921567cd',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 21',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 21',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 21',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_750c6c8a22bc78ba',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c5d74eee45de012cc2faaf108a0fb343',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[20:0] A;
     input CLK;
     input CE;
     output[20:0] S;
     input[20:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_750c6c8a22bc78ba',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 21',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 21',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 21',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_750c6c8a22bc78ba',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '2fb66773f283828b2234fb3b29e15edf',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[20:0] A;
     input CLK;
     input CE;
     output[20:0] S;
     input[20:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_750c6c8a22bc78ba',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '578c045a452a5bdc8750bb2c8ad92d54',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '882af8f4b97b7f66eb55b765cf0da383',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(21 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[20]}}, cast_internal_ip_27_3_rsh[20:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_0b767c7711',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '369d1e98eaa936900a91923c4dc16c08',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{2{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_18b87c12cf',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b08da776b2cf3b396359b21879f7740c',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_2422c3ab70',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'acc43a429e2115bef26374d3a8a2a992',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(20 - 1):0] ip,
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(20 - 1):0] ip_1_23;
  localparam signed [(20 - 1):0] const_value = 20\'sb00000000000000000000;
  reg signed [(20 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 20\'b00000000000000000000;
    end
  wire signed [(20 - 1):0] op_mem_46_20_front_din;
  wire signed [(20 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(20 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[19]}}, ip_1_23[19:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_69971e276f',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Add_Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_9196f8ffd2db8ce4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '54a2ef1a1280759cda5d25d2f5b5a24b',
    'sourceFile' => 'hdl/xladdsubmode.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, ADD, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input ADD;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .add(add),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_9196f8ffd2db8ce4',
      'entityName' => 'xladdsubmode_duc_16ch_341',
      'entity_name.0' => 'xladdsubmode',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '613b39b54860949eeebc6ffd67857247',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(5 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1\'b0;
      latency_pipe_5_26[1] = 1\'b0;
      latency_pipe_5_26[2] = 1\'b0;
      latency_pipe_5_26[3] = 1\'b0;
      latency_pipe_5_26[4] = 1\'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire bit_2_27;
  wire fully_2_1_bitnot;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[4];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1\'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1\'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              latency_pipe_5_26[i] <= latency_pipe_5_26[i-1];
            end
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign bit_2_27 = d0_1_24 ^ d1_1_27;
  assign fully_2_1_bitnot = ~bit_2_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bitnot;
  assign latency_pipe_5_26_push_front_pop_back_en = 1\'b1;
  assign y = latency_pipe_5_26_back;
endmodule
',
      'entity_name' => 'logical_06844c65fb',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '84dbf3cfe8688fc3d5fec78bc4fb9d76',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(5 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1\'b0;
      op_mem_22_20[1] = 1\'b0;
      op_mem_22_20[2] = 1\'b0;
      op_mem_22_20[3] = 1\'b0;
      op_mem_22_20[4] = 1\'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(3 - 1):0] const_value = 3\'b101;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[4];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_22_20_push_front_pop_back_en == 1\'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              op_mem_22_20[i] <= op_mem_22_20[i-1];
            end
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_front_din = internal_ip_12_1_bitnot;
  assign op_mem_22_20_push_front_pop_back_en = 1\'b1;
  assign op = op_mem_22_20_back;
endmodule
',
      'entity_name' => 'inverter_66c3795ede',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f9ea63ff34bad2f295dc8c5407c10a6f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(1 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1\'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[0];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1\'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1\'b1)))
        begin
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign fully_2_1_bit = d0_1_24 ^ d1_1_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bit;
  assign latency_pipe_5_26_push_front_pop_back_en = 1\'b1;
  assign y = latency_pipe_5_26_back;
endmodule
',
      'entity_name' => 'logical_8641388092',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ce8cb174bb666d7000972d1388542a3b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a9df897f6e2ec588227083c8774ca956',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(1 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1\'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1\'b1;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[0];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_22_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_push_front_pop_back_en = 1\'b0;
  assign op = internal_ip_12_1_bitnot;
endmodule
',
      'entity_name' => 'inverter_33a63b558a',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Binary_Counter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ainit_value = 0',
    'CSET ce = true',
    'CSET count_mode = UP',
    'CSET fb_latency = 0',
    'CSET final_count_value = 1',
    'CSET implementation = Fabric',
    'CSET increment_value = 1',
    'CSET latency = 1',
    'CSET load = false',
    'CSET output_width = 2',
    'CSET restrict_count = false',
    'CSET sclr = false',
    'CSET sinit = true',
    'CSET sinit_value = 0',
    'CSET sset = false',
    'CSET sync_ce_priority = Sync_Overrides_CE',
    'CSET sync_threshold_output = false',
    'CSET syncctrlpriority = Reset_Overrides_Set',
    'CSET component_name = cntr_11_0_76451075d188e63f',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c4d2a2c13665992b905809b85a32af44',
    'sourceFile' => 'hdl/xlcounter_free.v',
    'templateKeyValues' => {
      'core_instance_text' => '        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)',
      'core_name0' => 'cntr_11_0_76451075d188e63f',
      'entityName' => 'xlcounter_free_duc_16ch_341',
      'entity_name.0' => 'xlcounter_free',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cbec3e75eb3e24c313dfd7af576837d6',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  reg latency_pipe_5_26[0:(5 - 1)];
  initial
    begin
      latency_pipe_5_26[0] = 1\'b0;
      latency_pipe_5_26[1] = 1\'b0;
      latency_pipe_5_26[2] = 1\'b0;
      latency_pipe_5_26[3] = 1\'b0;
      latency_pipe_5_26[4] = 1\'b0;
    end
  wire latency_pipe_5_26_front_din;
  wire latency_pipe_5_26_back;
  wire latency_pipe_5_26_push_front_pop_back_en;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign latency_pipe_5_26_back = latency_pipe_5_26[4];
  always @(posedge clk)
    begin:proc_latency_pipe_5_26
      integer i;
      if (((ce == 1\'b1) && (latency_pipe_5_26_push_front_pop_back_en == 1\'b1)))
        begin
          for (i=4; i>=1; i=i-1)
            begin
              latency_pipe_5_26[i] <= latency_pipe_5_26[i-1];
            end
          latency_pipe_5_26[0] <= latency_pipe_5_26_front_din;
        end
    end
  assign fully_2_1_bit = d0_1_24 ^ d1_1_27;
  assign latency_pipe_5_26_front_din = fully_2_1_bit;
  assign latency_pipe_5_26_push_front_pop_back_en = 1\'b1;
  assign y = latency_pipe_5_26_back;
endmodule
',
      'entity_name' => 'logical_d5c14b9908',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a8a7b3064a82099cd21b288da60818fb',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(10 - 1):0] b,
  output [(10 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire [(10 - 1):0] b_17_24;
  reg [(10 - 1):0] accum_reg_41_23 = 10\'b0000000000;
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  localparam [(1 - 1):0] const_value_x_000001 = 1\'b1;
  assign b_17_24 = b;
  always @(posedge clk)
    begin:proc_accum_reg_41_23
      if ((ce == 1\'b1))
        begin
          accum_reg_41_23 <= accum_reg_41_23 + b_17_24;
        end
    end
  assign q = accum_reg_41_23;
endmodule
',
      'entity_name' => 'accum_8dccba219b',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Unsigned',
    'CSET A_Width = 11',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Unsigned',
    'CSET B_Value = 0',
    'CSET B_Width = 11',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 11',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_49467494b87e75c7',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a2b31c87413ea093758440b2556c6728',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[10:0] A;
     input CLK;
     input CE;
     output[10:0] S;
     input[10:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_49467494b87e75c7',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '05c56fa8eb50c7a8bce27c62c1bc91ff',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 1\'b0;
endmodule
',
      'entity_name' => 'constant_ae323e07fc',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '0367c3b4946ffc5e5caa0fdc39621dec',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 18\'b000000000000000000;
endmodule
',
      'entity_name' => 'constant_66f4f3b646',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '4116433b793fff7d5e4b2288e1400327',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 10\'b0100000000;
endmodule
',
      'entity_name' => 'constant_b0803b3578',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '245406ed2b7cf654da802ab6fb451e2f',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '849b51972dbfead799f20e08f191e746',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = true',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 324, 648, 96D, C91, FB5, 12D8, 15FC, 191F, 1C43, 1F65, 2288, 25AA, 28CC, 2BEE, 2F0F, 322F, 354F, 386F, 3B8E, 3EAD, 41CB, 44E8, 4804, 4B20, 4E3B, 5156, 546F, 5788, 5AA0, 5DB7, 60CE, 63E3, 66F7, 6A0B, 6D1D, 702E, 733E, 764D, 795B, 7C68, 7F73, 827E, 8587, 888F, 8B95, 8E9A, 919E, 94A0, 97A1, 9AA1, 9D9E, A09B, A396, A68F, A987, AC7D, AF71, B264, B555, B844, BB32, BE1D, C107, C3EF, C6D5, C9B9, CC9C, CF7C, D25A, D536, D810, DAE9, DDBE, E092, E364, E633, E901, EBCC, EE94, F15B, F41F, F6E1, F9A0, FC5D, FF18, 101D0, 10485, 10738, 109E9, 10C97, 10F42, 111EB, 11491, 11735, 119D6, 11C74, 11F0F, 121A8, 1243D, 126D0, 12960, 12BEE, 12E78, 130FF, 13384, 13606, 13884, 13B00, 13D78, 13FEE, 14260, 144CF, 1473B, 149A4, 14C0A, 14E6D, 150CC, 15328, 15581, 157D7, 15A29, 15C78, 15EC3, 1610B, 16350, 16592, 167CF, 16A0A, 16C41, 16E74, 170A4, 172D1, 174F9, 1771E, 17940, 17B5E, 17D78, 17F8F, 181A2, 183B1, 185BC, 187C4, 189C8, 18BC8, 18DC4, 18FBD, 191B1, 193A2, 1958F, 19778, 1995D, 19B3E, 19D1B, 19EF4, 1A0C9, 1A29A, 1A468, 1A631, 1A7F6, 1A9B6, 1AB73, 1AD2C, 1AEE0, 1B091, 1B23D, 1B3E5, 1B589, 1B728, 1B8C4, 1BA5B, 1BBED, 1BD7C, 1BF06, 1C08C, 1C20E, 1C38B, 1C504, 1C679, 1C7E9, 1C955, 1CABC, 1CC1F, 1CD7E, 1CED8, 1D02D, 1D17E, 1D2CB, 1D413, 1D557, 1D696, 1D7D1, 1D907, 1DA38, 1DB65, 1DC8D, 1DDB1, 1DED0, 1DFEB, 1E101, 1E212, 1E31F, 1E427, 1E52A, 1E629, 1E722, 1E818, 1E908, 1E9F4, 1EADB, 1EBBE, 1EC9B, 1ED74, 1EE48, 1EF18, 1EFE2, 1F0A8, 1F169, 1F225, 1F2DD, 1F38F, 1F43D, 1F4E6, 1F58A, 1F629, 1F6C4, 1F75A, 1F7EA, 1F876, 1F8FD, 1F980, 1F9FD, 1FA75, 1FAE9, 1FB58, 1FBC1, 1FC26, 1FC86, 1FCE1, 1FD38, 1FD89, 1FDD5, 1FE1D, 1FE5F, 1FE9D, 1FED6, 1FF09, 1FF38, 1FF62, 1FF87, 1FFA7, 1FFC2, 1FFD9, 1FFEA, 1FFF6, 1FFFE, 1FFFF, 1FFFE, 1FFF6, 1FFEA, 1FFD9, 1FFC2, 1FFA7, 1FF87, 1FF62, 1FF38, 1FF09, 1FED6, 1FE9D, 1FE5F, 1FE1D, 1FDD5, 1FD89, 1FD38, 1FCE1, 1FC86, 1FC26, 1FBC1, 1FB58, 1FAE9, 1FA75, 1F9FD, 1F980, 1F8FD, 1F876, 1F7EA, 1F75A, 1F6C4, 1F629, 1F58A, 1F4E6, 1F43D, 1F38F, 1F2DD, 1F225, 1F169, 1F0A8, 1EFE2, 1EF18, 1EE48, 1ED74, 1EC9B, 1EBBE, 1EADB, 1E9F4, 1E908, 1E818, 1E722, 1E629, 1E52A, 1E427, 1E31F, 1E212, 1E101, 1DFEB, 1DED0, 1DDB1, 1DC8D, 1DB65, 1DA38, 1D907, 1D7D1, 1D696, 1D557, 1D413, 1D2CB, 1D17E, 1D02D, 1CED8, 1CD7E, 1CC1F, 1CABC, 1C955, 1C7E9, 1C679, 1C504, 1C38B, 1C20E, 1C08C, 1BF06, 1BD7C, 1BBED, 1BA5B, 1B8C4, 1B728, 1B589, 1B3E5, 1B23D, 1B091, 1AEE0, 1AD2C, 1AB73, 1A9B6, 1A7F6, 1A631, 1A468, 1A29A, 1A0C9, 19EF4, 19D1B, 19B3E, 1995D, 19778, 1958F, 193A2, 191B1, 18FBD, 18DC4, 18BC8, 189C8, 187C4, 185BC, 183B1, 181A2, 17F8F, 17D78, 17B5E, 17940, 1771E, 174F9, 172D1, 170A4, 16E74, 16C41, 16A0A, 167CF, 16592, 16350, 1610B, 15EC3, 15C78, 15A29, 157D7, 15581, 15328, 150CC, 14E6D, 14C0A, 149A4, 1473B, 144CF, 14260, 13FEE, 13D78, 13B00, 13884, 13606, 13384, 130FF, 12E78, 12BEE, 12960, 126D0, 1243D, 121A8, 11F0F, 11C74, 119D6, 11735, 11491, 111EB, 10F42, 10C97, 109E9, 10738, 10485, 101D0, FF18, FC5D, F9A0, F6E1, F41F, F15B, EE94, EBCC, E901, E633, E364, E092, DDBE, DAE9, D810, D536, D25A, CF7C, CC9C, C9B9, C6D5, C3EF, C107, BE1D, BB32, B844, B555, B264, AF71, AC7D, A987, A68F, A396, A09B, 9D9E, 9AA1, 97A1, 94A0, 919E, 8E9A, 8B95, 888F, 8587, 827E, 7F73, 7C68, 795B, 764D, 733E, 702E, 6D1D, 6A0B, 66F7, 63E3, 60CE, 5DB7, 5AA0, 5788, 546F, 5156, 4E3B, 4B20, 4804, 44E8, 41CB, 3EAD, 3B8E, 386F, 354F, 322F, 2F0F, 2BEE, 28CC, 25AA, 2288, 1F65, 1C43, 191F, 15FC, 12D8, FB5, C91, 96D, 648, 324, 0, 3FCDC, 3F9B8, 3F693, 3F36F, 3F04B, 3ED28, 3EA04, 3E6E1, 3E3BD, 3E09B, 3DD78, 3DA56, 3D734, 3D412, 3D0F1, 3CDD1, 3CAB1, 3C791, 3C472, 3C153, 3BE35, 3BB18, 3B7FC, 3B4E0, 3B1C5, 3AEAA, 3AB91, 3A878, 3A560, 3A249, 39F32, 39C1D, 39909, 395F5, 392E3, 38FD2, 38CC2, 389B3, 386A5, 38398, 3808D, 37D82, 37A79, 37771, 3746B, 37166, 36E62, 36B60, 3685F, 3655F, 36262, 35F65, 35C6A, 35971, 35679, 35383, 3508F, 34D9C, 34AAB, 347BC, 344CE, 341E3, 33EF9, 33C11, 3392B, 33647, 33364, 33084, 32DA6, 32ACA, 327F0, 32517, 32242, 31F6E, 31C9C, 319CD, 316FF, 31434, 3116C, 30EA5, 30BE1, 3091F, 30660, 303A3, 300E8, 2FE30, 2FB7B, 2F8C8, 2F617, 2F369, 2F0BE, 2EE15, 2EB6F, 2E8CB, 2E62A, 2E38C, 2E0F1, 2DE58, 2DBC3, 2D930, 2D6A0, 2D412, 2D188, 2CF01, 2CC7C, 2C9FA, 2C77C, 2C500, 2C288, 2C012, 2BDA0, 2BB31, 2B8C5, 2B65C, 2B3F6, 2B193, 2AF34, 2ACD8, 2AA7F, 2A829, 2A5D7, 2A388, 2A13D, 29EF5, 29CB0, 29A6E, 29831, 295F6, 293BF, 2918C, 28F5C, 28D2F, 28B07, 288E2, 286C0, 284A2, 28288, 28071, 27E5E, 27C4F, 27A44, 2783C, 27638, 27438, 2723C, 27043, 26E4F, 26C5E, 26A71, 26888, 266A3, 264C2, 262E5, 2610C, 25F37, 25D66, 25B98, 259CF, 2580A, 2564A, 2548D, 252D4, 25120, 24F6F, 24DC3, 24C1B, 24A77, 248D8, 2473C, 245A5, 24413, 24284, 240FA, 23F74, 23DF2, 23C75, 23AFC, 23987, 23817, 236AB, 23544, 233E1, 23282, 23128, 22FD3, 22E82, 22D35, 22BED, 22AA9, 2296A, 2282F, 226F9, 225C8, 2249B, 22373, 2224F, 22130, 22015, 21EFF, 21DEE, 21CE1, 21BD9, 21AD6, 219D7, 218DE, 217E8, 216F8, 2160C, 21525, 21442, 21365, 2128C, 211B8, 210E8, 2101E, 20F58, 20E97, 20DDB, 20D23, 20C71, 20BC3, 20B1A, 20A76, 209D7, 2093C, 208A6, 20816, 2078A, 20703, 20680, 20603, 2058B, 20517, 204A8, 2043F, 203DA, 2037A, 2031F, 202C8, 20277, 2022B, 201E3, 201A1, 20163, 2012A, 200F7, 200C8, 2009E, 20079, 20059, 2003E, 20027, 20016, 2000A, 20002, 20000, 20002, 2000A, 20016, 20027, 2003E, 20059, 20079, 2009E, 200C8, 200F7, 2012A, 20163, 201A1, 201E3, 2022B, 20277, 202C8, 2031F, 2037A, 203DA, 2043F, 204A8, 20517, 2058B, 20603, 20680, 20703, 2078A, 20816, 208A6, 2093C, 209D7, 20A76, 20B1A, 20BC3, 20C71, 20D23, 20DDB, 20E97, 20F58, 2101E, 210E8, 211B8, 2128C, 21365, 21442, 21525, 2160C, 216F8, 217E8, 218DE, 219D7, 21AD6, 21BD9, 21CE1, 21DEE, 21EFF, 22015, 22130, 2224F, 22373, 2249B, 225C8, 226F9, 2282F, 2296A, 22AA9, 22BED, 22D35, 22E82, 22FD3, 23128, 23282, 233E1, 23544, 236AB, 23817, 23987, 23AFC, 23C75, 23DF2, 23F74, 240FA, 24284, 24413, 245A5, 2473C, 248D8, 24A77, 24C1B, 24DC3, 24F6F, 25120, 252D4, 2548D, 2564A, 2580A, 259CF, 25B98, 25D66, 25F37, 2610C, 262E5, 264C2, 266A3, 26888, 26A71, 26C5E, 26E4F, 27043, 2723C, 27438, 27638, 2783C, 27A44, 27C4F, 27E5E, 28071, 28288, 284A2, 286C0, 288E2, 28B07, 28D2F, 28F5C, 2918C, 293BF, 295F6, 29831, 29A6E, 29CB0, 29EF5, 2A13D, 2A388, 2A5D7, 2A829, 2AA7F, 2ACD8, 2AF34, 2B193, 2B3F6, 2B65C, 2B8C5, 2BB31, 2BDA0, 2C012, 2C288, 2C500, 2C77C, 2C9FA, 2CC7C, 2CF01, 2D188, 2D412, 2D6A0, 2D930, 2DBC3, 2DE58, 2E0F1, 2E38C, 2E62A, 2E8CB, 2EB6F, 2EE15, 2F0BE, 2F369, 2F617, 2F8C8, 2FB7B, 2FE30, 300E8, 303A3, 30660, 3091F, 30BE1, 30EA5, 3116C, 31434, 316FF, 319CD, 31C9C, 31F6E, 32242, 32517, 327F0, 32ACA, 32DA6, 33084, 33364, 33647, 3392B, 33C11, 33EF9, 341E3, 344CE, 347BC, 34AAB, 34D9C, 3508F, 35383, 35679, 35971, 35C6A, 35F65, 36262, 3655F, 3685F, 36B60, 36E62, 37166, 3746B, 37771, 37A79, 37D82, 3808D, 38398, 386A5, 389B3, 38CC2, 38FD2, 392E3, 395F5, 39909, 39C1D, 39F32, 3A249, 3A560, 3A878, 3AB91, 3AEAA, 3B1C5, 3B4E0, 3B7FC, 3BB18, 3BE35, 3C153, 3C472, 3C791, 3CAB1, 3CDD1, 3D0F1, 3D412, 3D734, 3DA56, 3DD78, 3E09B, 3E3BD, 3E6E1, 3EA04, 3ED28, 3F04B, 3F36F, 3F693, 3F9B8, 3FCDC;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Use_ENB_Pin',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = True_Dual_Port_RAM',
    'CSET operating_mode_a = NO_CHANGE',
    'CSET operating_mode_b = NO_CHANGE',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 18',
    'CSET read_width_b = 18',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = true',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 1024',
    'CSET write_width_a = 18',
    'CSET write_width_b = 18',
    'CSET component_name = bmg_72_5fc6d969158b1ced',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '7c4cfa76e6844c3c47bed88e3ec112be',
    'sourceFile' => 'hdl/xldpram.v',
    'templateKeyValues' => {
      'core_component_def' => ' (addra, clka, addrb, clkb, dina, wea, dinb, web, ena, enb, douta, doutb)/* synthesis syn_black_box */;
      input [9:0] addra;
      input [9:0] addrb;
      input [17:0] dina;
      input [17:0] dinb;
      input clka, wea, ena;
      input clkb, web, enb;
      output [17:0] douta;
      output [17:0] doutb;',
      'core_instance_text' => '      .addra(core_addra),
      .clka(a_clk),
      .addrb(core_addrb),
      .clkb(b_clk),
      .dina(core_dina),
      .wea(core_wea),
      .dinb(core_dinb),
      .web(core_web),
      .ena(core_a_ce),
      .enb(core_b_ce),
      .douta(core_douta),
      .doutb(core_doutb)',
      'core_name0' => 'bmg_72_5fc6d969158b1ced',
      'entityName' => 'xldpram_duc_16ch_341',
      'entity_name.0' => 'xldpram',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e94993d0aafa2fbbe1fc0245d282cb4c',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(25 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 25\'b0000000000000000000000000;
endmodule
',
      'entity_name' => 'constant_3660c43b3c',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '45854db9cd70c7be05c41df270a5f6b2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '627e6109c70d24e6496a48ef9af1bd7e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '17cd3b83257365a2fd3665a9a93da31c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cc6d2e21847258623974ba569ac5d2fa',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '5ffbfa75eb1884953a7a6fa57c7aa3f6',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00100000000000110101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00100;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000110101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00100000000000110101;
  assign op = 20\'b00100000000000110101;
endmodule
',
      'entity_name' => 'opmode_2a00e03ade',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '48e32612dd0b4de68600d73853db4947',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b01100000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b01100;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b01100000000000010101;
  assign op = 20\'b01100000000000010101;
endmodule
',
      'entity_name' => 'opmode_6aca2f0a6e',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '20f684e0b035ad185682b0bd99fc2f6a',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00000000000000010101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00000;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000010101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00000000000000010101;
  assign op = 20\'b00000000000000010101;
endmodule
',
      'entity_name' => 'opmode_bddb7c5c56',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a5d647964ebaf270cc71345069311c8d',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(48 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 48\'b000000000000000000000000000011111111111111111111;
endmodule
',
      'entity_name' => 'constant_34794c595f',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '801e7d5961e39b8b4ebcc1575eed26ab',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2c522e274c9586e33baaa7b9311b49ad',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '99752ce21594a21c1015daa79716a982',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 324, 648, 96D, C91, FB5, 12D8, 15FC, 191F, 1C43, 1F65, 2288, 25AA, 28CC, 2BEE, 2F0F, 322F, 354F, 386F, 3B8E, 3EAD, 41CB, 44E8, 4804, 4B20, 4E3B, 5156, 546F, 5788, 5AA0, 5DB7, 60CE, 63E3, 66F7, 6A0B, 6D1D, 702E, 733E, 764D, 795B, 7C68, 7F73, 827E, 8587, 888F, 8B95, 8E9A, 919E, 94A0, 97A1, 9AA1, 9D9E, A09B, A396, A68F, A987, AC7D, AF71, B264, B555, B844, BB32, BE1D, C107, C3EF, C6D5, C9B9, CC9C, CF7C, D25A, D536, D810, DAE9, DDBE, E092, E364, E633, E901, EBCC, EE94, F15B, F41F, F6E1, F9A0, FC5D, FF18, 101D0, 10485, 10738, 109E9, 10C97, 10F42, 111EB, 11491, 11735, 119D6, 11C74, 11F0F, 121A8, 1243D, 126D0, 12960, 12BEE, 12E78, 130FF, 13384, 13606, 13884, 13B00, 13D78, 13FEE, 14260, 144CF, 1473B, 149A4, 14C0A, 14E6D, 150CC, 15328, 15581, 157D7, 15A29, 15C78, 15EC3, 1610B, 16350, 16592, 167CF, 16A0A, 16C41, 16E74, 170A4, 172D1, 174F9, 1771E, 17940, 17B5E, 17D78, 17F8F, 181A2, 183B1, 185BC, 187C4, 189C8, 18BC8, 18DC4, 18FBD, 191B1, 193A2, 1958F, 19778, 1995D, 19B3E, 19D1B, 19EF4, 1A0C9, 1A29A, 1A468, 1A631, 1A7F6, 1A9B6, 1AB73, 1AD2C, 1AEE0, 1B091, 1B23D, 1B3E5, 1B589, 1B728, 1B8C4, 1BA5B, 1BBED, 1BD7C, 1BF06, 1C08C, 1C20E, 1C38B, 1C504, 1C679, 1C7E9, 1C955, 1CABC, 1CC1F, 1CD7E, 1CED8, 1D02D, 1D17E, 1D2CB, 1D413, 1D557, 1D696, 1D7D1, 1D907, 1DA38, 1DB65, 1DC8D, 1DDB1, 1DED0, 1DFEB, 1E101, 1E212, 1E31F, 1E427, 1E52A, 1E629, 1E722, 1E818, 1E908, 1E9F4, 1EADB, 1EBBE, 1EC9B, 1ED74, 1EE48, 1EF18, 1EFE2, 1F0A8, 1F169, 1F225, 1F2DD, 1F38F, 1F43D, 1F4E6, 1F58A, 1F629, 1F6C4, 1F75A, 1F7EA, 1F876, 1F8FD, 1F980, 1F9FD, 1FA75, 1FAE9, 1FB58, 1FBC1, 1FC26, 1FC86, 1FCE1, 1FD38, 1FD89, 1FDD5, 1FE1D, 1FE5F, 1FE9D, 1FED6, 1FF09, 1FF38, 1FF62, 1FF87, 1FFA7, 1FFC2, 1FFD9, 1FFEA, 1FFF6, 1FFFE, 1FFFF, 1FFFE, 1FFF6, 1FFEA, 1FFD9, 1FFC2, 1FFA7, 1FF87, 1FF62, 1FF38, 1FF09, 1FED6, 1FE9D, 1FE5F, 1FE1D, 1FDD5, 1FD89, 1FD38, 1FCE1, 1FC86, 1FC26, 1FBC1, 1FB58, 1FAE9, 1FA75, 1F9FD, 1F980, 1F8FD, 1F876, 1F7EA, 1F75A, 1F6C4, 1F629, 1F58A, 1F4E6, 1F43D, 1F38F, 1F2DD, 1F225, 1F169, 1F0A8, 1EFE2, 1EF18, 1EE48, 1ED74, 1EC9B, 1EBBE, 1EADB, 1E9F4, 1E908, 1E818, 1E722, 1E629, 1E52A, 1E427, 1E31F, 1E212, 1E101, 1DFEB, 1DED0, 1DDB1, 1DC8D, 1DB65, 1DA38, 1D907, 1D7D1, 1D696, 1D557, 1D413, 1D2CB, 1D17E, 1D02D, 1CED8, 1CD7E, 1CC1F, 1CABC, 1C955, 1C7E9, 1C679, 1C504, 1C38B, 1C20E, 1C08C, 1BF06, 1BD7C, 1BBED, 1BA5B, 1B8C4, 1B728, 1B589, 1B3E5, 1B23D, 1B091, 1AEE0, 1AD2C, 1AB73, 1A9B6, 1A7F6, 1A631, 1A468, 1A29A, 1A0C9, 19EF4, 19D1B, 19B3E, 1995D, 19778, 1958F, 193A2, 191B1, 18FBD, 18DC4, 18BC8, 189C8, 187C4, 185BC, 183B1, 181A2, 17F8F, 17D78, 17B5E, 17940, 1771E, 174F9, 172D1, 170A4, 16E74, 16C41, 16A0A, 167CF, 16592, 16350, 1610B, 15EC3, 15C78, 15A29, 157D7, 15581, 15328, 150CC, 14E6D, 14C0A, 149A4, 1473B, 144CF, 14260, 13FEE, 13D78, 13B00, 13884, 13606, 13384, 130FF, 12E78, 12BEE, 12960, 126D0, 1243D, 121A8, 11F0F, 11C74, 119D6, 11735, 11491, 111EB, 10F42, 10C97, 109E9, 10738, 10485, 101D0, FF18, FC5D, F9A0, F6E1, F41F, F15B, EE94, EBCC, E901, E633, E364, E092, DDBE, DAE9, D810, D536, D25A, CF7C, CC9C, C9B9, C6D5, C3EF, C107, BE1D, BB32, B844, B555, B264, AF71, AC7D, A987, A68F, A396, A09B, 9D9E, 9AA1, 97A1, 94A0, 919E, 8E9A, 8B95, 888F, 8587, 827E, 7F73, 7C68, 795B, 764D, 733E, 702E, 6D1D, 6A0B, 66F7, 63E3, 60CE, 5DB7, 5AA0, 5788, 546F, 5156, 4E3B, 4B20, 4804, 44E8, 41CB, 3EAD, 3B8E, 386F, 354F, 322F, 2F0F, 2BEE, 28CC, 25AA, 2288, 1F65, 1C43, 191F, 15FC, 12D8, FB5, C91, 96D, 648, 324, 0, 3FCDC, 3F9B8, 3F693, 3F36F, 3F04B, 3ED28, 3EA04, 3E6E1, 3E3BD, 3E09B, 3DD78, 3DA56, 3D734, 3D412, 3D0F1, 3CDD1, 3CAB1, 3C791, 3C472, 3C153, 3BE35, 3BB18, 3B7FC, 3B4E0, 3B1C5, 3AEAA, 3AB91, 3A878, 3A560, 3A249, 39F32, 39C1D, 39909, 395F5, 392E3, 38FD2, 38CC2, 389B3, 386A5, 38398, 3808D, 37D82, 37A79, 37771, 3746B, 37166, 36E62, 36B60, 3685F, 3655F, 36262, 35F65, 35C6A, 35971, 35679, 35383, 3508F, 34D9C, 34AAB, 347BC, 344CE, 341E3, 33EF9, 33C11, 3392B, 33647, 33364, 33084, 32DA6, 32ACA, 327F0, 32517, 32242, 31F6E, 31C9C, 319CD, 316FF, 31434, 3116C, 30EA5, 30BE1, 3091F, 30660, 303A3, 300E8, 2FE30, 2FB7B, 2F8C8, 2F617, 2F369, 2F0BE, 2EE15, 2EB6F, 2E8CB, 2E62A, 2E38C, 2E0F1, 2DE58, 2DBC3, 2D930, 2D6A0, 2D412, 2D188, 2CF01, 2CC7C, 2C9FA, 2C77C, 2C500, 2C288, 2C012, 2BDA0, 2BB31, 2B8C5, 2B65C, 2B3F6, 2B193, 2AF34, 2ACD8, 2AA7F, 2A829, 2A5D7, 2A388, 2A13D, 29EF5, 29CB0, 29A6E, 29831, 295F6, 293BF, 2918C, 28F5C, 28D2F, 28B07, 288E2, 286C0, 284A2, 28288, 28071, 27E5E, 27C4F, 27A44, 2783C, 27638, 27438, 2723C, 27043, 26E4F, 26C5E, 26A71, 26888, 266A3, 264C2, 262E5, 2610C, 25F37, 25D66, 25B98, 259CF, 2580A, 2564A, 2548D, 252D4, 25120, 24F6F, 24DC3, 24C1B, 24A77, 248D8, 2473C, 245A5, 24413, 24284, 240FA, 23F74, 23DF2, 23C75, 23AFC, 23987, 23817, 236AB, 23544, 233E1, 23282, 23128, 22FD3, 22E82, 22D35, 22BED, 22AA9, 2296A, 2282F, 226F9, 225C8, 2249B, 22373, 2224F, 22130, 22015, 21EFF, 21DEE, 21CE1, 21BD9, 21AD6, 219D7, 218DE, 217E8, 216F8, 2160C, 21525, 21442, 21365, 2128C, 211B8, 210E8, 2101E, 20F58, 20E97, 20DDB, 20D23, 20C71, 20BC3, 20B1A, 20A76, 209D7, 2093C, 208A6, 20816, 2078A, 20703, 20680, 20603, 2058B, 20517, 204A8, 2043F, 203DA, 2037A, 2031F, 202C8, 20277, 2022B, 201E3, 201A1, 20163, 2012A, 200F7, 200C8, 2009E, 20079, 20059, 2003E, 20027, 20016, 2000A, 20002, 20000, 20002, 2000A, 20016, 20027, 2003E, 20059, 20079, 2009E, 200C8, 200F7, 2012A, 20163, 201A1, 201E3, 2022B, 20277, 202C8, 2031F, 2037A, 203DA, 2043F, 204A8, 20517, 2058B, 20603, 20680, 20703, 2078A, 20816, 208A6, 2093C, 209D7, 20A76, 20B1A, 20BC3, 20C71, 20D23, 20DDB, 20E97, 20F58, 2101E, 210E8, 211B8, 2128C, 21365, 21442, 21525, 2160C, 216F8, 217E8, 218DE, 219D7, 21AD6, 21BD9, 21CE1, 21DEE, 21EFF, 22015, 22130, 2224F, 22373, 2249B, 225C8, 226F9, 2282F, 2296A, 22AA9, 22BED, 22D35, 22E82, 22FD3, 23128, 23282, 233E1, 23544, 236AB, 23817, 23987, 23AFC, 23C75, 23DF2, 23F74, 240FA, 24284, 24413, 245A5, 2473C, 248D8, 24A77, 24C1B, 24DC3, 24F6F, 25120, 252D4, 2548D, 2564A, 2580A, 259CF, 25B98, 25D66, 25F37, 2610C, 262E5, 264C2, 266A3, 26888, 26A71, 26C5E, 26E4F, 27043, 2723C, 27438, 27638, 2783C, 27A44, 27C4F, 27E5E, 28071, 28288, 284A2, 286C0, 288E2, 28B07, 28D2F, 28F5C, 2918C, 293BF, 295F6, 29831, 29A6E, 29CB0, 29EF5, 2A13D, 2A388, 2A5D7, 2A829, 2AA7F, 2ACD8, 2AF34, 2B193, 2B3F6, 2B65C, 2B8C5, 2BB31, 2BDA0, 2C012, 2C288, 2C500, 2C77C, 2C9FA, 2CC7C, 2CF01, 2D188, 2D412, 2D6A0, 2D930, 2DBC3, 2DE58, 2E0F1, 2E38C, 2E62A, 2E8CB, 2EB6F, 2EE15, 2F0BE, 2F369, 2F617, 2F8C8, 2FB7B, 2FE30, 300E8, 303A3, 30660, 3091F, 30BE1, 30EA5, 3116C, 31434, 316FF, 319CD, 31C9C, 31F6E, 32242, 32517, 327F0, 32ACA, 32DA6, 33084, 33364, 33647, 3392B, 33C11, 33EF9, 341E3, 344CE, 347BC, 34AAB, 34D9C, 3508F, 35383, 35679, 35971, 35C6A, 35F65, 36262, 3655F, 3685F, 36B60, 36E62, 37166, 3746B, 37771, 37A79, 37D82, 3808D, 38398, 386A5, 389B3, 38CC2, 38FD2, 392E3, 395F5, 39909, 39C1D, 39F32, 3A249, 3A560, 3A878, 3AB91, 3AEAA, 3B1C5, 3B4E0, 3B7FC, 3BB18, 3BE35, 3C153, 3C472, 3C791, 3CAB1, 3CDD1, 3D0F1, 3D412, 3D734, 3DA56, 3DD78, 3E09B, 3E3BD, 3E6E1, 3EA04, 3ED28, 3F04B, 3F36F, 3F693, 3F9B8, 3FCDC;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 18',
    'CSET read_width_b = 18',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 1024',
    'CSET write_width_a = 18',
    'CSET write_width_b = 18',
    'CSET component_name = bmg_72_c0e7027c8d56f068',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b88c906e7248a623cf2f6b398fb00afe',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_c0e7027c8d56f068',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 1FFFF, 1FFFE, 1FFF6, 1FFEA, 1FFD9, 1FFC2, 1FFA7, 1FF87, 1FF62, 1FF38, 1FF09, 1FED6, 1FE9D, 1FE5F, 1FE1D, 1FDD5, 1FD89, 1FD38, 1FCE1, 1FC86, 1FC26, 1FBC1, 1FB58, 1FAE9, 1FA75, 1F9FD, 1F980, 1F8FD, 1F876, 1F7EA, 1F75A, 1F6C4, 1F629, 1F58A, 1F4E6, 1F43D, 1F38F, 1F2DD, 1F225, 1F169, 1F0A8, 1EFE2, 1EF18, 1EE48, 1ED74, 1EC9B, 1EBBE, 1EADB, 1E9F4, 1E908, 1E818, 1E722, 1E629, 1E52A, 1E427, 1E31F, 1E212, 1E101, 1DFEB, 1DED0, 1DDB1, 1DC8D, 1DB65, 1DA38, 1D907, 1D7D1, 1D696, 1D557, 1D413, 1D2CB, 1D17E, 1D02D, 1CED8, 1CD7E, 1CC1F, 1CABC, 1C955, 1C7E9, 1C679, 1C504, 1C38B, 1C20E, 1C08C, 1BF06, 1BD7C, 1BBED, 1BA5B, 1B8C4, 1B728, 1B589, 1B3E5, 1B23D, 1B091, 1AEE0, 1AD2C, 1AB73, 1A9B6, 1A7F6, 1A631, 1A468, 1A29A, 1A0C9, 19EF4, 19D1B, 19B3E, 1995D, 19778, 1958F, 193A2, 191B1, 18FBD, 18DC4, 18BC8, 189C8, 187C4, 185BC, 183B1, 181A2, 17F8F, 17D78, 17B5E, 17940, 1771E, 174F9, 172D1, 170A4, 16E74, 16C41, 16A0A, 167CF, 16592, 16350, 1610B, 15EC3, 15C78, 15A29, 157D7, 15581, 15328, 150CC, 14E6D, 14C0A, 149A4, 1473B, 144CF, 14260, 13FEE, 13D78, 13B00, 13884, 13606, 13384, 130FF, 12E78, 12BEE, 12960, 126D0, 1243D, 121A8, 11F0F, 11C74, 119D6, 11735, 11491, 111EB, 10F42, 10C97, 109E9, 10738, 10485, 101D0, FF18, FC5D, F9A0, F6E1, F41F, F15B, EE94, EBCC, E901, E633, E364, E092, DDBE, DAE9, D810, D536, D25A, CF7C, CC9C, C9B9, C6D5, C3EF, C107, BE1D, BB32, B844, B555, B264, AF71, AC7D, A987, A68F, A396, A09B, 9D9E, 9AA1, 97A1, 94A0, 919E, 8E9A, 8B95, 888F, 8587, 827E, 7F73, 7C68, 795B, 764D, 733E, 702E, 6D1D, 6A0B, 66F7, 63E3, 60CE, 5DB7, 5AA0, 5788, 546F, 5156, 4E3B, 4B20, 4804, 44E8, 41CB, 3EAD, 3B8E, 386F, 354F, 322F, 2F0F, 2BEE, 28CC, 25AA, 2288, 1F65, 1C43, 191F, 15FC, 12D8, FB5, C91, 96D, 648, 324, 0, 3FCDC, 3F9B8, 3F693, 3F36F, 3F04B, 3ED28, 3EA04, 3E6E1, 3E3BD, 3E09B, 3DD78, 3DA56, 3D734, 3D412, 3D0F1, 3CDD1, 3CAB1, 3C791, 3C472, 3C153, 3BE35, 3BB18, 3B7FC, 3B4E0, 3B1C5, 3AEAA, 3AB91, 3A878, 3A560, 3A249, 39F32, 39C1D, 39909, 395F5, 392E3, 38FD2, 38CC2, 389B3, 386A5, 38398, 3808D, 37D82, 37A79, 37771, 3746B, 37166, 36E62, 36B60, 3685F, 3655F, 36262, 35F65, 35C6A, 35971, 35679, 35383, 3508F, 34D9C, 34AAB, 347BC, 344CE, 341E3, 33EF9, 33C11, 3392B, 33647, 33364, 33084, 32DA6, 32ACA, 327F0, 32517, 32242, 31F6E, 31C9C, 319CD, 316FF, 31434, 3116C, 30EA5, 30BE1, 3091F, 30660, 303A3, 300E8, 2FE30, 2FB7B, 2F8C8, 2F617, 2F369, 2F0BE, 2EE15, 2EB6F, 2E8CB, 2E62A, 2E38C, 2E0F1, 2DE58, 2DBC3, 2D930, 2D6A0, 2D412, 2D188, 2CF01, 2CC7C, 2C9FA, 2C77C, 2C500, 2C288, 2C012, 2BDA0, 2BB31, 2B8C5, 2B65C, 2B3F6, 2B193, 2AF34, 2ACD8, 2AA7F, 2A829, 2A5D7, 2A388, 2A13D, 29EF5, 29CB0, 29A6E, 29831, 295F6, 293BF, 2918C, 28F5C, 28D2F, 28B07, 288E2, 286C0, 284A2, 28288, 28071, 27E5E, 27C4F, 27A44, 2783C, 27638, 27438, 2723C, 27043, 26E4F, 26C5E, 26A71, 26888, 266A3, 264C2, 262E5, 2610C, 25F37, 25D66, 25B98, 259CF, 2580A, 2564A, 2548D, 252D4, 25120, 24F6F, 24DC3, 24C1B, 24A77, 248D8, 2473C, 245A5, 24413, 24284, 240FA, 23F74, 23DF2, 23C75, 23AFC, 23987, 23817, 236AB, 23544, 233E1, 23282, 23128, 22FD3, 22E82, 22D35, 22BED, 22AA9, 2296A, 2282F, 226F9, 225C8, 2249B, 22373, 2224F, 22130, 22015, 21EFF, 21DEE, 21CE1, 21BD9, 21AD6, 219D7, 218DE, 217E8, 216F8, 2160C, 21525, 21442, 21365, 2128C, 211B8, 210E8, 2101E, 20F58, 20E97, 20DDB, 20D23, 20C71, 20BC3, 20B1A, 20A76, 209D7, 2093C, 208A6, 20816, 2078A, 20703, 20680, 20603, 2058B, 20517, 204A8, 2043F, 203DA, 2037A, 2031F, 202C8, 20277, 2022B, 201E3, 201A1, 20163, 2012A, 200F7, 200C8, 2009E, 20079, 20059, 2003E, 20027, 20016, 2000A, 20002, 20000, 20002, 2000A, 20016, 20027, 2003E, 20059, 20079, 2009E, 200C8, 200F7, 2012A, 20163, 201A1, 201E3, 2022B, 20277, 202C8, 2031F, 2037A, 203DA, 2043F, 204A8, 20517, 2058B, 20603, 20680, 20703, 2078A, 20816, 208A6, 2093C, 209D7, 20A76, 20B1A, 20BC3, 20C71, 20D23, 20DDB, 20E97, 20F58, 2101E, 210E8, 211B8, 2128C, 21365, 21442, 21525, 2160C, 216F8, 217E8, 218DE, 219D7, 21AD6, 21BD9, 21CE1, 21DEE, 21EFF, 22015, 22130, 2224F, 22373, 2249B, 225C8, 226F9, 2282F, 2296A, 22AA9, 22BED, 22D35, 22E82, 22FD3, 23128, 23282, 233E1, 23544, 236AB, 23817, 23987, 23AFC, 23C75, 23DF2, 23F74, 240FA, 24284, 24413, 245A5, 2473C, 248D8, 24A77, 24C1B, 24DC3, 24F6F, 25120, 252D4, 2548D, 2564A, 2580A, 259CF, 25B98, 25D66, 25F37, 2610C, 262E5, 264C2, 266A3, 26888, 26A71, 26C5E, 26E4F, 27043, 2723C, 27438, 27638, 2783C, 27A44, 27C4F, 27E5E, 28071, 28288, 284A2, 286C0, 288E2, 28B07, 28D2F, 28F5C, 2918C, 293BF, 295F6, 29831, 29A6E, 29CB0, 29EF5, 2A13D, 2A388, 2A5D7, 2A829, 2AA7F, 2ACD8, 2AF34, 2B193, 2B3F6, 2B65C, 2B8C5, 2BB31, 2BDA0, 2C012, 2C288, 2C500, 2C77C, 2C9FA, 2CC7C, 2CF01, 2D188, 2D412, 2D6A0, 2D930, 2DBC3, 2DE58, 2E0F1, 2E38C, 2E62A, 2E8CB, 2EB6F, 2EE15, 2F0BE, 2F369, 2F617, 2F8C8, 2FB7B, 2FE30, 300E8, 303A3, 30660, 3091F, 30BE1, 30EA5, 3116C, 31434, 316FF, 319CD, 31C9C, 31F6E, 32242, 32517, 327F0, 32ACA, 32DA6, 33084, 33364, 33647, 3392B, 33C11, 33EF9, 341E3, 344CE, 347BC, 34AAB, 34D9C, 3508F, 35383, 35679, 35971, 35C6A, 35F65, 36262, 3655F, 3685F, 36B60, 36E62, 37166, 3746B, 37771, 37A79, 37D82, 3808D, 38398, 386A5, 389B3, 38CC2, 38FD2, 392E3, 395F5, 39909, 39C1D, 39F32, 3A249, 3A560, 3A878, 3AB91, 3AEAA, 3B1C5, 3B4E0, 3B7FC, 3BB18, 3BE35, 3C153, 3C472, 3C791, 3CAB1, 3CDD1, 3D0F1, 3D412, 3D734, 3DA56, 3DD78, 3E09B, 3E3BD, 3E6E1, 3EA04, 3ED28, 3F04B, 3F36F, 3F693, 3F9B8, 3FCDC, 0, 324, 648, 96D, C91, FB5, 12D8, 15FC, 191F, 1C43, 1F65, 2288, 25AA, 28CC, 2BEE, 2F0F, 322F, 354F, 386F, 3B8E, 3EAD, 41CB, 44E8, 4804, 4B20, 4E3B, 5156, 546F, 5788, 5AA0, 5DB7, 60CE, 63E3, 66F7, 6A0B, 6D1D, 702E, 733E, 764D, 795B, 7C68, 7F73, 827E, 8587, 888F, 8B95, 8E9A, 919E, 94A0, 97A1, 9AA1, 9D9E, A09B, A396, A68F, A987, AC7D, AF71, B264, B555, B844, BB32, BE1D, C107, C3EF, C6D5, C9B9, CC9C, CF7C, D25A, D536, D810, DAE9, DDBE, E092, E364, E633, E901, EBCC, EE94, F15B, F41F, F6E1, F9A0, FC5D, FF18, 101D0, 10485, 10738, 109E9, 10C97, 10F42, 111EB, 11491, 11735, 119D6, 11C74, 11F0F, 121A8, 1243D, 126D0, 12960, 12BEE, 12E78, 130FF, 13384, 13606, 13884, 13B00, 13D78, 13FEE, 14260, 144CF, 1473B, 149A4, 14C0A, 14E6D, 150CC, 15328, 15581, 157D7, 15A29, 15C78, 15EC3, 1610B, 16350, 16592, 167CF, 16A0A, 16C41, 16E74, 170A4, 172D1, 174F9, 1771E, 17940, 17B5E, 17D78, 17F8F, 181A2, 183B1, 185BC, 187C4, 189C8, 18BC8, 18DC4, 18FBD, 191B1, 193A2, 1958F, 19778, 1995D, 19B3E, 19D1B, 19EF4, 1A0C9, 1A29A, 1A468, 1A631, 1A7F6, 1A9B6, 1AB73, 1AD2C, 1AEE0, 1B091, 1B23D, 1B3E5, 1B589, 1B728, 1B8C4, 1BA5B, 1BBED, 1BD7C, 1BF06, 1C08C, 1C20E, 1C38B, 1C504, 1C679, 1C7E9, 1C955, 1CABC, 1CC1F, 1CD7E, 1CED8, 1D02D, 1D17E, 1D2CB, 1D413, 1D557, 1D696, 1D7D1, 1D907, 1DA38, 1DB65, 1DC8D, 1DDB1, 1DED0, 1DFEB, 1E101, 1E212, 1E31F, 1E427, 1E52A, 1E629, 1E722, 1E818, 1E908, 1E9F4, 1EADB, 1EBBE, 1EC9B, 1ED74, 1EE48, 1EF18, 1EFE2, 1F0A8, 1F169, 1F225, 1F2DD, 1F38F, 1F43D, 1F4E6, 1F58A, 1F629, 1F6C4, 1F75A, 1F7EA, 1F876, 1F8FD, 1F980, 1F9FD, 1FA75, 1FAE9, 1FB58, 1FBC1, 1FC26, 1FC86, 1FCE1, 1FD38, 1FD89, 1FDD5, 1FE1D, 1FE5F, 1FE9D, 1FED6, 1FF09, 1FF38, 1FF62, 1FF87, 1FFA7, 1FFC2, 1FFD9, 1FFEA, 1FFF6, 1FFFE;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 18',
    'CSET read_width_b = 18',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 1024',
    'CSET write_width_a = 18',
    'CSET write_width_b = 18',
    'CSET component_name = bmg_72_0b6075e08c22268d',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c3adfbf0a086b644d7a25971e34343d0',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_0b6075e08c22268d',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Unsigned',
    'CSET A_Width = 11',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Unsigned',
    'CSET B_Value = 0',
    'CSET B_Width = 11',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 11',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_49467494b87e75c7',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ee853059e4e098eedf51d54c73241a20',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[10:0] A;
     input CLK;
     input CE;
     output[10:0] S;
     input[10:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_49467494b87e75c7',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bbcd24d9f7c914fe679176b29cf8d189',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 10\'b0000001100;
endmodule
',
      'entity_name' => 'constant_dc846bf42d',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'fb6df9e8754b1e563896f6d1454ddc49',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '051cc3704df346c98b662067b5f214ff',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b52e98af2176d32423852301816b0cc2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4cd601ba129bae101a97a9b88a72c32f',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0ebf40e33eb9ea4446b2f7864176fd95',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldsp48e1.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f12891b9f13d29d147429ba06d9496ed',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(20 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1\'b0;
  localparam [(20 - 1):0] const_value_x_000000 = 20\'b00000000000000000101;
  localparam [(5 - 1):0] const_value_x_000001 = 5\'b00000;
  localparam [(3 - 1):0] const_value_x_000002 = 3\'b000;
  localparam [(11 - 1):0] const_value_x_000003 = 11\'b00000000101;
  localparam [(20 - 1):0] const_value_x_000004 = 20\'b00000000000000000101;
  assign op = 20\'b00000000000000000101;
endmodule
',
      'entity_name' => 'opmode_3711ab4973',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '7417d996b263ea917a85f350ce76853c',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(48 - 1):0] input_port,
  output [(48 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(48 - 1):0] input_port_1_40;
  wire [(48 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_84fa2b7df8',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 17',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 17',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 17',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_3b5cfe2278dc7df8',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '965ecfcdad43b448ca9aa71374fb63cf',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[16:0] A;
     input CLK;
     input CE;
     output[16:0] S;
     input[16:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_3b5cfe2278dc7df8',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 18',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 18',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 18',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_0e0e0a285ef7a16d',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '0a39ec5c42e543f43eea130d4d9bdadc',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[17:0] A;
     input CLK;
     input CE;
     output[17:0] S;
     input[17:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_0e0e0a285ef7a16d',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 19',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 19',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 19',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_490e4beeb7992ef4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'abef2c96f227bdf6e21aff33d5f8ac6c',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[18:0] A;
     input CLK;
     input CE;
     output[18:0] S;
     input[18:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_490e4beeb7992ef4',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 19',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 19',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 19',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_490e4beeb7992ef4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '90a12bc443f2eb2c1a1f3f4984d25b08',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[18:0] A;
     input CLK;
     input CE;
     output[18:0] S;
     input[18:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_490e4beeb7992ef4',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cd971937b7c1e68d62eafcbfb85e7a14',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlregister.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 11',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 11',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 11',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_6623adedd12a938a',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '2a3f662dd2b648e51df0503b008ea817',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[10:0] A;
     input CLK;
     input CE;
     output[10:0] S;
     input[10:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_6623adedd12a938a',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 13',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 13',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 13',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_8747e77bb511337e',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '655ca300184f20aad52656c394d39f2a',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[12:0] A;
     input CLK;
     input CE;
     output[12:0] S;
     input[12:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_8747e77bb511337e',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e6ee856fc1a2fa07a9ac9939b89c2ada',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c57459931e6301cacbdbd06cad053c57',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ab42349caf564638a3267bb406aff9f6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '816eb19cc1d1cd7504d8ffb1f544a8e2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cb64dd5b29a75f29bd24d21ffbd79ad8',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2057b14e727c502ed0fdf399d6fb1903',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '7224c550fb5443101a1db67ce3c93458',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c1f480a929443a15e63b41281238b8d6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd100782c123cbd4f665ebe63856f93d8',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b298259ff8f0c0bf38e3b613117f26e5',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 20020, 40040, 58060, 78080, 980A0, B80C0, D80E0, F8100, 110120, 130140, 150160, 170160, 190180, 1A81A0, 1C81C0, 1E81E0, 208200, 228220, 240240, 260260, 280280, 2A02A0, 2C02C0, 2E02E0, 2F8301, 318321, 338341, 358361, 378381, 3903A1, 3B03C1, 3D03E1, 3F0401, 410421, 430421, 448441, 468461, 488481, 4A84A1, 4C84C1, 4E04E1, 500501, 520521, 540541, 560561, 578581, 5985A1, 5B85C1, 5D85E1, 5F8601, 618621, 630641, 650661, 670681, 6906A1, 6B06C1, 6C86E1, 6E8701, 708701, 728721, 748741, 768761, 780781, 7A07A1, 7C07C1, 7E07E1, 800801, 818821, 838841, 858861, 878881, 8988A1, 8B08C1, 8D08E1, 8F0902, 910922, 930942, 950962, 968982, 9889A2, 9A89C2, 9C89C2, 9E89E2, A00A02, A20A22, A40A42, A60A62, A80A82, AA0AA2, AB8AC2, AD8AE2, AF8B02, B18B22, B38B42, B50B62, B70B82, B90BA2, BB0BC2, BD0BE2, BE8C02, C08C22, C28C42, C48C62, C68C82, C88C82, CA0CA2, CC0CC2, CE0CE2, D00D02, D20D22, D38D42, D58D62, D78D82, D98DA2, DB8DC2, DD8DE2, DF0E02, E10E22, E30E42, E50E62, E70E82, E88EA2, EA8EC2, EC8EE2, EE8F03, F08F23, F20F43, F40F63, F60F63, F80F83, FA0FA3, FC0FC3, FD8FE3, FF9003, 1019023, 1039043, 1059063, 1071083, 10910A3, 10B10C3, 10D10E3, 10F1103, 1111123, 1129143, 1149163, 1169183, 11891A3, 11A91C3, 11C11E3, 11E1203, 1201223, 1221223, 1241243, 1259263, 1279283, 12992A3, 12B92C3, 12D92E3, 12F9303, 1311323, 1331343, 1351363, 1371383, 13913A3, 13A93C3, 13C93E3, 13E9403, 1409423, 1429443, 1449463, 1461483, 14814A3, 14A14C3, 14C14E3, 14E14E4, 14F9504, 1519524, 1539544, 1559564, 1579584, 15915A4, 15B15C4, 15D15E4, 15F1604, 1611624, 1631644, 1649664, 1669684, 16896A4, 16A96C4, 16C96E4, 16E1704, 1701724, 1721744, 1741764, 1761784, 17817A4, 17997C4, 17B97C4, 17D97E4, 17F9804, 1819824, 1831844, 1851864, 1871884, 18918A4, 18B18C4, 18C98E4, 18E9904, 1909924, 1929944, 1949964, 1969984, 19819A4, 19A19C4, 19C19E4, 19E1A04, 1A01A24, 1A19A44, 1A39A64, 1A59A84, 1A79A84, 1A99AA4, 1AB9AC4, 1AD1AE5, 1AF1B05, 1B11B25, 1B31B45, 1B51B65, 1B69B85, 1B89BA5, 1BA9BC5, 1BC9BE5, 1BE9C05, 1C01C25, 1C21C45, 1C41C65, 1C61C85, 1C81CA5, 1CA1CC5, 1CB9CE5, 1CD9D05, 1CF9D25, 1D19D45, 1D39D45, 1D51D65, 1D71D85, 1D91DA5, 1DB1DC5, 1DD1DE5, 1DF1E05, 1E09E25, 1E29E45, 1E49E65, 1E69E85, 1E89EA5, 1EA1EC5, 1EC1EE5, 1EE1F05, 1F01F25, 1F21F45, 1F39F65, 1F59F85, 1F79FA5, 1F99FC5, 1FB9FE5, 1FDA005, 1FF2025, 2012025, 2032045, 2052065, 2072085, 208A0A5, 20AA0C5, 20CA0E6, 20EA106, 210A126, 212A146, 2142166, 2162186, 21821A6, 21A21C6, 21C21E6, 21DA206, 21FA226, 221A246, 223A266, 225A286, 22722A6, 22922C6, 22B22E6, 22D22E6, 22F2306, 2312326, 232A346, 234A366, 236A386, 238A3A6, 23AA3C6, 23C23E6, 23E2406, 2402426, 2422446, 2442466, 2462486, 247A4A6, 249A4C6, 24BA4E6, 24DA506, 24FA526, 2512546, 2532566, 2552586, 25725A6, 25925A6, 25AA5C6, 25CA5E6, 25EA606, 260A626, 262A646, 264A666, 2662686, 26826A6, 26A26C6, 26C26E7, 26E2707, 26FA727, 271A747, 273A767, 275A787, 277A7A7, 27927C7, 27B27E7, 27D2807, 27F2827, 2812847, 2832867, 284A887, 286A887, 288A8A7, 28AA8C7, 28CA8E7, 28E2907, 2902927, 2922947, 2942967, 2962987, 29829A7, 299A9C7, 29BA9E7, 29DAA07, 29FAA27, 2A1AA47, 2A32A67, 2A52A87, 2A72AA7, 2A92AC7, 2AB2AE7, 2ACAB07, 2AEAB27, 2B0AB47, 2B2AB47, 2B4AB67, 2B6AB87, 2B82BA7, 2BA2BC7, 2BC2BE7, 2BE2C07, 2C02C27, 2C1AC47, 2C3AC67, 2C5AC87, 2C7ACA7, 2C9ACC7, 2CBACE8, 2CD2D08, 2CF2D28, 2D12D48, 2D32D68, 2D52D88, 2D6ADA8, 2D8ADC8, 2DAADE8, 2DCAE08, 2DEAE08, 2E02E28, 2E22E48, 2E42E68, 2E62E88, 2E82EA8, 2EA2EC8, 2EBAEE8, 2EDAF08, 2EFAF28, 2F1AF48, 2F3AF68, 2F52F88, 2F72FA8, 2F92FC8, 2FB2FE8, 2FD3008, 2FF3028, 300B048, 302B068, 304B088, 306B0A8, 308B0C8, 30A30E8, 30C30E8, 30E3108, 3103128, 3123148, 313B168, 315B188, 317B1A8, 319B1C8, 31BB1E8, 31DB208, 31F3228, 3213248, 3233268, 3253288, 32732A8, 328B2C8, 32AB2E9, 32CB309, 32EB329, 330B349, 332B369, 3343389, 33633A9, 33833A9, 33A33C9, 33C33E9, 33DB409, 33FB429, 341B449, 343B469, 345B489, 34734A9, 34934C9, 34B34E9, 34D3509, 34F3529, 3513549, 352B569, 354B589, 356B5A9, 358B5C9, 35AB5E9, 35C3609, 35E3629, 3603649, 3623669, 3643669, 3663689, 367B6A9, 369B6C9, 36BB6E9, 36DB709, 36FB729, 3713749, 3733769, 3753789, 37737A9, 37937C9, 37AB7E9, 37CB809, 37EB829, 380B849, 382B869, 384B889, 38638A9, 38838C9, 38A38EA, 38C390A, 38E392A, 38FB94A, 391B94A, 393B96A, 395B98A, 397B9AA, 399B9CA, 39B39EA, 39D3A0A, 39F3A2A, 3A13A4A, 3A33A6A, 3A4BA8A, 3A6BAAA, 3A8BACA, 3AABAEA, 3ACBB0A, 3AE3B2A, 3B03B4A, 3B23B6A, 3B43B8A, 3B63BAA, 3B83BCA, 3B9BBEA, 3BBBC0A, 3BDBC0A, 3BFBC2A, 3C1BC4A, 3C33C6A, 3C53C8A, 3C73CAA, 3C93CCA, 3CB3CEA, 3CD3D0A, 3CEBD2A, 42FC2D6, 431C2F6, 4334316, 4354336, 4374356, 4394376, 43B4396, 43D43B6, 43EC3D6, 440C3F6, 442C416, 444C416, 446C436, 4484456, 44A4476, 44C4496, 44E44B6, 45044D6, 45244F6, 453C516, 455C536, 457C556, 459C576, 45BC596, 45D45B6, 45F45D6, 46145F6, 4634616, 4654636, 466C656, 468C676, 46AC696, 46CC6B6, 46EC6D6, 470C6D6, 47246F6, 4744716, 4764736, 4784757, 47A4777, 47BC797, 47DC7B7, 47FC7D7, 481C7F7, 483C817, 485C837, 4874857, 4894877, 48B4897, 48D48B7, 48F48D7, 490C8F7, 492C917, 494C937, 496C957, 498C977, 49A4997, 49C49B7, 49E49B7, 4A049D7, 4A249F7, 4A44A17, 4A5CA37, 4A7CA57, 4A9CA77, 4ABCA97, 4ADCAB7, 4AF4AD7, 4B14AF7, 4B34B17, 4B54B37, 4B74B57, 4B94B77, 4BACB97, 4BCCBB7, 4BECBD7, 4C0CBF7, 4C2CC17, 4C44C37, 4C64C57, 4C84C77, 4CA4C77, 4CC4C97, 4CDCCB7, 4CFCCD7, 4D1CCF7, 4D3CD17, 4D5CD37, 4D7CD58, 4D94D78, 4DB4D98, 4DD4DB8, 4DF4DD8, 4E14DF8, 4E2CE18, 4E4CE38, 4E6CE58, 4E8CE78, 4EACE98, 4ECCEB8, 4EE4ED8, 4F04EF8, 4F24F18, 4F44F38, 4F64F38, 4F7CF58, 4F9CF78, 4FBCF98, 4FDCFB8, 4FFCFD8, 5014FF8, 5035018, 5055038, 5075058, 5095078, 50B5098, 50CD0B8, 50ED0D8, 510D0F8, 512D118, 514D138, 5165158, 5185178, 51A5198, 51C51B8, 51E51D8, 52051F8, 521D218, 523D218, 525D238, 527D258, 529D278, 52B5298, 52D52B8, 52F52D8, 53152F8, 5335318, 534D338, 536D359, 538D379, 53AD399, 53CD3B9, 53ED3D9, 54053F9, 5425419, 5445439, 5465459, 5485479, 549D499, 54BD4B9, 54DD4D9, 54FD4D9, 551D4F9, 553D519, 5555539, 5575559, 5595579, 55B5599, 55D55B9, 55ED5D9, 560D5F9, 562D619, 564D639, 566D659, 5685679, 56A5699, 56C56B9, 56E56D9, 57056F9, 5725719, 573D739, 575D759, 577D779, 579D799, 57BD799, 57D57B9, 57F57D9, 58157F9, 5835819, 5855839, 5875859, 588D879, 58AD899, 58CD8B9, 58ED8D9, 590D8F9, 5925919, 5945939, 596595A, 598597A, 59A599A, 59BD9BA, 59DD9DA, 59FD9FA, 5A1DA1A, 5A3DA3A, 5A5DA5A, 5A75A7A, 5A95A7A, 5AB5A9A, 5AD5ABA, 5AF5ADA, 5B0DAFA, 5B2DB1A, 5B4DB3A, 5B6DB5A, 5B8DB7A, 5BA5B9A, 5BC5BBA, 5BE5BDA, 5C05BFA, 5C25C1A, 5C45C3A, 5C5DC5A, 5C7DC7A, 5C9DC9A, 5CBDCBA, 5CDDCDA, 5CF5CFA, 5D15D1A, 5D35D3A, 5D55D3A, 5D75D5A, 5D95D7A, 5DADD9A, 5DCDDBA, 5DEDDDA, 5E0DDFA, 5E2DE1A, 5E45E3A, 5E65E5A, 5E85E7A, 5EA5E9A, 5EC5EBA, 5EDDEDA, 5EFDEFA, 5F1DF1A, 5F3DF3A, 5F5DF5B, 5F7DF7B, 5F95F9B, 5FB5FBB, 5FD5FDB, 5FF5FFB, 6015FFB, 602E01B, 604E03B, 606E05B, 608E07B, 60AE09B, 60CE0BB, 60E60DB, 61060FB, 612611B, 614613B, 616615B, 617E17B, 619E19B, 61BE1BB, 61DE1DB, 61FE1FB, 621621B, 623623B, 625625B, 627627B, 629629B, 62B62BB, 62CE2DB, 62EE2DB, 630E2FB, 632E31B, 634E33B, 636635B, 638637B, 63A639B, 63C63BB, 63E63DB, 64063FB, 641E41B, 643E43B, 645E45B, 647E47B, 649E49B, 64B64BB, 64D64DB, 64F64FB, 651651B, 653653B, 654E55C, 656E57C, 658E59C, 65AE59C, 65CE5BC, 65EE5DC, 66065FC, 662661C, 664663C, 666665C, 668667C, 669E69C, 66BE6BC, 66DE6DC, 66FE6FC, 671E71C, 673E73C, 675675C, 677677C, 679679C, 67B67BC, 67D67DC, 67EE7FC, 680E81C, 682E83C, 684E85C, 686E85C, 688687C, 68A689C, 68C68BC, 68E68DC, 69068FC, 692691C, 693E93C, 695E95C, 697E97C, 699E99C, 69BE9BC, 69D69DC, 69F69FC, 6A16A1C, 6A36A3C, 6A56A5C, 6A76A7C, 6A8EA9C, 6AAEABC, 6ACEADC, 6AEEAFC, 6B0EB1C, 6B26B3C, 6B46B3D, 6B66B5D, 6B86B7D, 6BA6B9D, 6BBEBBD, 6BDEBDD, 6BFEBFD, 6C1EC1D, 6C3EC3D, 6C5EC5D, 6C76C7D, 6C96C9D, 6CB6CBD, 6CD6CDD, 6CF6CFD, 6D0ED1D, 6D2ED3D, 6D4ED5D, 6D6ED7D, 6D8ED9D, 6DAEDBD, 6DC6DDD, 6DE6DFD, 6E06DFD, 6E26E1D, 6E46E3D, 6E5EE5D, 6E7EE7D, 6E9EE9D, 6EBEEBD, 6EDEEDD, 6EF6EFD, 6F16F1D, 6F36F3D, 6F56F5D, 6F76F7D, 6F96F9D, 6FAEFBD, 6FCEFDD, 6FEEFFD, 700F01D, 702F03D, 704705D, 706707D, 708709D, 70A70BD, 70C70BD, 70E70DD, 70FF0FD, 711F11D, 713F13E, 715F15E, 717F17E, 719719E, 71B71BE, 71D71DE, 71F71FE, 721721E, 722F23E, 724F25E, 726F27E, 728F29E, 72AF2BE, 72CF2DE, 72E72FE, 730731E, 732733E, 734735E, 736737E, 737F39E, 739F39E, 73BF3BE, 73DF3DE, 73FF3FE, 741F41E, 743743E, 745745E, 747747E, 749749E, 74B74BE, 74CF4DE, 74EF4FE, 750F51E, 752F53E, 754F55E, 756757E, 758759E, 75A75BE, 75C75DE, 75E75FE, 760761E, 761F63E, 763F65E, 765F65E, 767F67E, 769F69E, 76B76BE, 76D76DE, 76F76FE, 771771E, 773773F, 775775F, 776F77F, 778F79F, 77AF7BF, 77CF7DF, 77EF7FF, 780781F, 782783F, 784785F, 786787F, 788789F, 789F8BF, 78BF8DF, 78DF8FF, 78FF91F, 791F91F, 793F93F, 795795F, 797797F, 799799F, 79B79BF, 79D79DF, 79EF9FF, 7A0FA1F, 7A2FA3F, 7A4FA5F, 7A6FA7F, 7A8FA9F, 7AA7ABF, 7AC7ADF, 7AE7AFF, 7B07B1F, 7B27B3F, 7B3FB5F, 7B5FB7F, 7B7FB9F, 7B9FBBF, 7BBFBDF, 7BD7BFF, 7BF7BFF, 7C17C1F, 7C37C3F, 7C57C5F, 7C77C7F, 7C8FC9F, 7CAFCBF, 7CCFCDF, 7CEFCFF, 7D0FD1F, 7D27D20, 7D47D40, 7D67D60, 7D87D80, 7DA7DA0, 7DC7DC0, 7DDFDE0, 7DFFE00, 7E1FE20, 7E3FE40, 7E5FE60, 7E77E80, 7E97EA0, 7EB7EA0, 7ED7EC0, 7EF7EE0, 7F0FF00, 7F2FF20, 7F4FF40, 7F6FF60, 7F8FF80, 7FAFFA0, 7FC7FC0, 7FE7FE0;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 27',
    'CSET read_width_b = 27',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 1024',
    'CSET write_width_a = 27',
    'CSET write_width_b = 27',
    'CSET component_name = bmg_72_88bd69a7e506f2a2',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '1a9c5757cfd9b4309116e54189d8a5a9',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_88bd69a7e506f2a2',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 40, 40, 40, 40, 40, 40, 40, 40, 41, 41, 41, 41, 41, 41, 41, 41, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 81, 81, 81, 81, 81;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 12',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 64',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_b01799b9bf71bdc0',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b343e00716019a70ef1ee4ff4339ac93',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_b01799b9bf71bdc0',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ca3c3cbd3f161b00a2a26dbe1a486036',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(5 - 1):0] input_port,
  output [(5 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(5 - 1):0] input_port_1_40;
  wire signed [(5 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_9f3848bc50',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ebbf32e6208db5f0605980988b1c9432',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(10 - 1):0] input_port,
  output [(10 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(10 - 1):0] input_port_1_40;
  wire [(10 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_b41d29f193',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '023c2e960eb7a3c1bb893b3978657cb6',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(6 - 1):0] input_port,
  output [(6 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(6 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_3f5d978749',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '9de8fc734941bd8639af71e772397e3f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(7 - 1):0] input_port,
  output [(7 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(7 - 1):0] input_port_1_40;
  wire signed [(7 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_8eee8341d8',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b498fb542267100b914ed5ef06afdcb0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(10 - 1):0] input_port,
  output [(10 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(10 - 1):0] input_port_1_40;
  wire signed [(10 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_fd8afbe046',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bc241cd6ea646953c0b75de1c311f17e',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(12 - 1):0] input_port,
  output [(12 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(12 - 1):0] input_port_1_40;
  wire signed [(12 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_94dfdafd95',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd1593eb7c25d94ea2fb8d63210c38984',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'fe843d1bdaf8b5c4702d8f403b4a426c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '69a5e11689df45f488f174a623d82bda',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '648090044d2ad9ee174c6d65efa97c35',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a5811f1aee8e969ed4ce7d785b39a767',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b7d4f6a833c247d22a1adf90fff24ee8',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(10 - 1):0] ip,
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(10 - 1):0] ip_1_23;
  localparam signed [(10 - 1):0] const_value = 10\'sb0000000000;
  reg signed [(10 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 10\'b0000000000;
    end
  wire signed [(10 - 1):0] op_mem_46_20_front_din;
  wire signed [(10 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(14 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(10 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[9]}}, ip_1_23[9:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[13]}}, cast_internal_ip_27_3_rsh[13:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_85f5a5ebd0',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '21c3c3f06052081fb37730651b4156ce',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(12 - 1):0] ip,
  output [(12 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(12 - 1):0] ip_1_23;
  localparam signed [(12 - 1):0] const_value = 12\'sb000000000000;
  reg signed [(12 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 12\'b000000000000;
    end
  wire signed [(12 - 1):0] op_mem_46_20_front_din;
  wire signed [(12 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(16 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(12 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[11]}}, ip_1_23[11:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[15]}}, cast_internal_ip_27_3_rsh[15:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_39b9422678',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '217f2c21a87304c081f2c0a23fbf07e2',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{5{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:6]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_af45bff5a0',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '597a9e7db9988506c93411d2100a14d1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_13f7182392',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b6861ce04d8729a3e9735df30fb32730',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(30 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{12{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[29]}}, cast_internal_ip_27_3_rsh[29:13]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_35e4e03aef',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 14',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 14',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 14',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_3abe85fcf1017fed',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '12d24673d2fc5a3345bc1b5afccacc7f',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[13:0] A;
     input CLK;
     input CE;
     output[13:0] S;
     input[13:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_3abe85fcf1017fed',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 16',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 16',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 16',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_f392a1f2f071bf23',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '767926c27876655f56688d13480d7371',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[15:0] A;
     input CLK;
     input CE;
     output[15:0] S;
     input[15:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_f392a1f2f071bf23',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '816ac38e646f5fd9d41d04f7e0cb8bc0',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'adfdf2142809adf1030e5537cd4f9754',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '6953a6e4fa43718101ace5328d0986ce',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'eb6f3ae0a8b47fe72a7af3a53fd624e9',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4f9576882a9b87de631eb3874bbfe03c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '446eb33a3569fd4d6510764e6c74f03a',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b905b0b577df807512941c96b922aea0',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '91f91f5d9578df873813d650cfc04321',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a9f66eb7c3b96deb7cb72e908742c072',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f6f0a320b131d9ce861a56c3cecbed76',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4aee78abfebb06ca004481ae913d1b3f',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f3a2b75d5b6df6576019c012e81685f3',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f5f197a7937800211efc498a22b1b8ba',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 680210030, D80420061, 1400628091, 1B008380C1, 2180A480F2, 2880C58122, 2F00E68152, 3601070183, 3C812801B3, 43814901E3, 4A016A0213, 50818A8244, 5781AB8274, 5E01CC82A4, 6501ED82D5, 6B820E8305, 72822F0335, 7902500366, 8002710396, 86829203C6, 8D82B303F7, 9402D38427, 9B02F48457, A183158488, A8033684B8, AF035784E8, B583780518, BC83990549, C303BA0579, CA03DB05A9, D083FB85DA, D7841C860A, DE043D863A, E5045E866B, EB847F869B, F204A006CB, F904C106FC, FF84E2072C, 1068503075C, 10D0524078D, 114054487BD, 11A856587ED, 1218586881D, 12805A7884E, 12F05C8887E, 13585E908AE, 13C060A08DF, 143062B090F, 149864C093F, 150866C8970, 157068D89A0, 15E06AE89D0, 16486CF8A01, 16B86F08A31, 17207110A61, 17907320A92, 17F87530AC2, 18687740AF2, 18D07950B22, 19387B58B53, 19A87D68B83, 1A107F78BB3, 1A808188BE4, 1AE88398C14, 1B5885A0C44, 1BC087B0C75, 1C3089C0CA5, 1C988BD0CD5, 1D088DD8D06, 1D708FE8D36, 1DD891F8D66, 1E489408D97, 1EB09618DC7, 1F209820DF7, 1F889A30E27, 1FF89C40E58, 20609E50E88, 20D0A060EB8, 2138A268EE9, 21A8A478F19, 2210A688F49, 2278A898F7A, 22E8AAA8FAA, 2350ACB0FDA, 23C0AEC100B, 2428B0D103B, 2498B2E106B, 2500B4E909C, 2570B6F90CC, 25D8B9090FC, 2648BB1912C, 26B0BD2915D, 2720BF3118D, 2788C1411BD, 27F0C3511EE, 2860C56121E, 28C8C77124E, 2938C97927F, 29A0CB892AF, 2A10CD992DF, 2A78CFA9310, 2AE8D1B9340, 2B50D3C1370, 2BC0D5D13A1, 2C28D7E13D1, 2C90D9F1401, 2D00DBF9431, 2D68DE09462, 2DD8E019492, 2E40E2294C2, 2EB0E4394F3, 2F18E641523, 2F88E851553, 2FF0EA61584, 3060EC715B4, 30C8EE815E4, 3130F089615, 31A0F299645, 3208F4A9675, 3278F6B96A6, 32E0F8C96D6, 3350FAD1706, 33B8FCE1736, 3428FEF1767, 34910101797, 350103097C7, 356905197F8, 35D10729828, 36410939858, 36A90B49889, 37190D518B9, 37810F618E9, 37F1117191A, 3859138194A, 38C9159197A, 393117999AB, 39A119A99DB, 3A091BB9A0B, 3A791DC9A3C, 3AE11FD9A6C, 3B4921E1A9C, 3BB923F1ACC, 3C212601AFD, 3C912811B2D, 3CF92A19B5D, 3D692C29B8E, 3DD12E39BBE, 3E413049BEE, 3EA93259C1F, 3F193461C4F, 3F813671C7F, 3FE93881CB0, 40593A91CE0, 40C13CA1D10, 41313EA9D41, 419940B9D71, 420942C9DA1, 427144D9DD1, 42E146E9E02, 434948F1E32, 43B94B01E62, 44214D11E93, 44894F21EC3, 44F95129EF3, 45615339F24, 45D15549F54, 46395759F84, 46A95969FB5, 47115B71FE5, 47815D82015, 47E95F92046, 485961A2076, 48C163B20A6, 493165BA0D6, 499967CA107, 4A0169DA137, 4A716BEA167, 4AD96DFA198, 4B4970021C8, 4BB172121F8, 4C217422229, 4C897632259, 4CF9783A289, 4D617A4A2BA, 4DD17C5A2EA, 4E397E6A31A, 4EA1807A34B, 4F11828237B, 4F7984923AB, 4FE986A23DB, 505188B240C, 50C18AC243C, 51298CCA46C, 51998EDA49D, 520190EA4CD, 527192FA4FD, 52D9950A52E, 5341971255E, 53B1992258E, 54199B325BF, 54899D425EF, 54F19F4A61F, 5561A15A650, 55C9A36A680, 5639A57A6B0, 56A1A78A6E0, 5711A992711, 5779ABA2741, 57E9ADB2771, 5851AFC27A2, 58B9B1D27D2, 5929B3DA802, 5991B5EA833, 5A01B7FA863, 5A69BA0A893, 5AD9BC1A8C4, 5B41BE228F4, 5BB1C032924, 5C19C242955, 5C89C452985, 5CF1C65A9B5, 5D59C86A9E5, 5DC9CA7AA16, 5E31CC8AA46, 5EA1CE9AA76, 5F09D0A2AA7, 5F79D2B2AD7, 5FE1D4C2B07, 6051D6D2B38, 60B9D8E2B68, 6129DAEAB98, 6191DCFABC9, 61F9DF0ABF9, 6269E11AC29, 62D1E32AC5A, 6341E532C8A, 63A9E742CBA, 6419E952CEA, 6481EB62D1B, 64F1ED72D4B, 6559EF7AD7B, 65C9F18ADAC, 6631F39ADDC, 66A1F5AAE0C, 6709F7B2E3D, 6771F9C2E6D, 67E1FBD2E9D, 6849FDE2ECE, 68B9FFF2EFE, 692201FAF2E, 6992040AF5F, 69FA061AF8F, 6A6A082AFBF, 6AD20A3AFEF, 6B420C43020, 945DF1B4FB0, 94C5F3C4FE0, 9535F5CD011, 959DF7DD041, 960DF9ED071, 9675FBFD0A1, 96E5FE0D0D2, 974E0015102, 97BE0225132, 98260435163, 98960645193, 98FE08551C3, 99660A5D1F4, 99D60C6D224, 9A3E0E7D254, 9AAE108D285, 9B1612952B5, 9B8614A52E5, 9BEE16B5316, 9C5E18C5346, 9CC61AD5376, 9D361CDD3A6, 9D9E1EED3D7, 9E0E20FD407, 9E76230D437, 9EDE251D468, 9F4E2725498, 9FB629354C8, A0262B454F9, A08E2D55529, A0FE2F65559, A166316D58A, A1D6337D5BA, A23E358D5EA, A2AE379D61B, A31639AD64B, A37E3BB567B, A3EE3DC56AB, A4563FD56DC, A4C641E570C, A52E43ED73C, A59E45FD76D, A606480D79D, A6764A1D7CD, A6DE4C2D7FE, A74E4E3582E, A7B6504585E, A81E525588F, A88E54658BF, A8F656758EF, A966587D920, A9CE5A8D950, AA3E5C9D980, AAA65EAD9B0, AB1660BD9E1, AB7E62C5A11, ABEE64D5A41, AC5666E5A72, ACC668F5AA2, AD2E6AFDAD2, AD966D0DB03, AE066F1DB33, AE6E712DB63, AEDE733DB94, AF467545BC4, AFB67755BF4, B01E7965C25, B08E7B75C55, B0F67D85C85, B1667F8DCB5, B1CE819DCE6, B23683ADD16, B2A685BDD46, B30E87CDD77, B37E89D5DA7, B3E68BE5DD7, B4568DF5E08, B4BE9005E38, B52E920DE68, B596941DE99, B606962DEC9, B66E983DEF9, B6D69A4DF2A, B7469C55F5A, B7AE9E65F8A, B81EA075FBA, B886A285FEB, B8F6A49601B, B95EA69E04B, B9CEA8AE07C, BA36AABE0AC, BAA6ACCE0DC, BB0EAEDE10D, BB7EB0E613D, BBE6B2F616D, BC4EB50619E, BCBEB7161CE, BD26B91E1FE, BD96BB2E22F, BDFEBD3E25F, BE6EBF4E28F, BED6C15E2BF, BF46C3662F0, BFAEC576320, C01EC786350, C086C996381, C0EECBA63B1, C15ECDAE3E1, C1C6CFBE412, C236D1CE442, C29ED3DE472, C30ED5EE4A3, C376D7F64D3, C3E6DA06503, C44EDC16534, C4BEDE26564, C526E02E594, C58EE23E5C4, C5FEE44E5F5, C666E65E625, C6D6E86E655, C73EEA76686, C7AEEC866B6, C816EE966E6, C886F0A6717, C8EEF2B6747, C95EF4BE777, C9C6F6CE7A8, CA36F8DE7D8, CA9EFAEE808, CB06FCFE839, CB76FF06869, CBDF0116899, CC4F03268CA, CCB705368FA, CD27073E92A, CD8F094E95A, CDFF0B5E98B, CE670D6E9BB, CED70F7E9EB, CF3F1186A1C, CFA71396A4C, D01715A6A7C, D07F17B6AAD, D0EF19C6ADD, D1571BCEB0D, D1C71DDEB3E, D22F1FEEB6E, D29F21FEB9E, D307240EBCF, D3772616BFF, D3DF2826C2F, D4472A36C5F, D4B72C46C90, D51F2E4ECC0, D58F305ECF0, D5F7326ED21, D667347ED51, D6CF368ED81, D73F3896DB2, D7A73AA6DE2, D8173CB6E12, D87F3EC6E43, D8E740D6E73, D95742DEEA3, D9BF44EEED4, DA2F46FEF04, DA97490EF34, DB074B1EF64, DB6F4D26F95, DBDF4F36FC5, DC475146FF5, DCB75357026, DD1F555F056, DD8F576F086, DDF7597F0B7, DE5F5B8F0E7, DECF5D9F117, DF375FA7148, DFA761B7178, E00F63C71A8, E07F65D71D9, E0E767E7209, E15769EF239, E1BF6BFF269, E22F6E0F29A, E297701F2CA, E2FF722F2FA, E36F743732B, E3D7764735B, E447785738B, E4AF7A673BC, E51F7C6F3EC, E5877E7F41C, E5F7808F44D, E65F829F47D, E6CF84AF4AD, E73786B74DE, E79F88C750E, E80F8AD753E, E8778CE756E, E8E78EF759F, E94F90FF5CF, E9BF930F5FF, EA27951F630, EA97972F660, EAFF993F690, EB6F9B476C1, EBD79D576F1, EC479F67721, ECAFA177752, ED17A37F782, ED87A58F7B2, EDEFA79F7E3, EE5FA9AF813, EEC7ABBF843, EF37ADC7873, EF9FAFD78A4, F00FB1E78D4, F077B3F7904, F0E7B607935, F14FB80F965, F1B7BA1F995, F227BC2F9C6, F28FBE3F9F6, F2FFC04FA26, F367C257A57, F3D7C467A87, F43FC677AB7, F4AFC887AE8, F517CA8FB18, F587CC9FB48, F5EFCEAFB78, F657D0BFBA9, F6C7D2CFBD9, F72FD4D7C09, F79FD6E7C3A, F807D8F7C6A, F877DB07C9A, F8DFDD17CCB, F94FDF1FCFB, F9B7E12FD2B, FA27E33FD5C, FA8FE54FD8C, FAFFE75FDBC, FB67E967DED, FBCFEB77E1D, FC3FED87E4D, FCA7EF97E7D, FD17F19FEAE, FD7FF3AFEDE, FDEFF5BFF0E, FE57F7CFF3F, FEC7F9DFF6F, FF2FFBE7F9F, FF9FFDF7FD0;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 44',
    'CSET read_width_b = 44',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 512',
    'CSET write_width_a = 44',
    'CSET write_width_b = 44',
    'CSET component_name = bmg_72_2f2b227d5258d685',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '3f2be51afb2ebf7e09ecccced8f64719',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_2f2b227d5258d685',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 40, 41, 81, 82, 20C2, 20C2, 2103, 2103, 2143, 2144, 2184, 2185, 21C5, 21C5, 4206, 4206, 4246, 4247, 4287, 4288, 42C8, 42C8, 4309, 6309, 6349, 634A, 638A, 638B, 63CB, 63CB, 640C, 640C, 644C, 844D, 848D, 84CE, 84CE, 850E, 850F, 854F, 854F, 8590, A590, A5D1, A5D1, A611, A612, A652, A652, A693, A693, A6D4, C6D4, C714, C715, C755, C756, C796, C796, C7D7, C7D7, E817, E818, E858, E859, E899, E899, E8DA, E8DA, E91A, E91B, 1095B, 1099C, 1099C, 109DC, 109DD, 10A1D, 10A1D, 10A5E, 10A5E, 12A9F, 12A9F, 12ADF, 12AE0, 12B20, 12B20, 12B61, 12B61, 12BA2, 12BA2, 14BE2, 14BE3, 14C23, 14C23, 14C64, 14C64, 14CA5, 14CA5, 14CE5, 16CE6, 16D26, 16D26, 16D67, 16D67, 16DA8, 16DA8, 16DE8, 16E29, 16E29, 18E6A, 18E6A, 18EAA, 18EAB, 18EEB, 18EEB, 18F2C, 18F2C, 18F6D, 1AF6D, 1AFAD, 1AFAE, 1AFEE, 1AFEE, 1B02F, 1B02F, 1B070, 1B070;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 17',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 128',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_2828f053f6c73e1f',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '5fdb52b89aef182e0e892f2b0186d935',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_2828f053f6c73e1f',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0dff01199d248253f574a3519e0c3f31',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(8 - 1):0] input_port,
  output [(8 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(8 - 1):0] input_port_1_40;
  wire signed [(8 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_feb184a5ad',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f38b191662f2d6ced39fa2a75e6478f4',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(9 - 1):0] input_port,
  output [(9 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(9 - 1):0] input_port_1_40;
  wire [(9 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_34f6390c19',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'afd1c765b16390b145af173621cd93d1',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(7 - 1):0] input_port,
  output [(7 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(7 - 1):0] input_port_1_40;
  assign input_port_1_40 = input_port;
  assign output_port = input_port_1_40;
endmodule
',
      'entity_name' => 'reinterpret_016d92ab20',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b79d1c057a2c722c2e4bae5583c83b90',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(15 - 1):0] input_port,
  output [(15 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(15 - 1):0] input_port_1_40;
  wire signed [(15 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_6200c8761b',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b0d51d04936c072e45e32444b951b183',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(13 - 1):0] input_port,
  output [(13 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(13 - 1):0] input_port_1_40;
  wire signed [(13 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_55833616ec',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b5e2e64ebab058e5bf30659153293b65',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '65d0656a6b2dc0ca1a46ad722967fad6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f5a6052a94d973d7a2121bb4e11b02a3',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c93291b24f1de833337d0fac22e4560a',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '403a7eacbddd5fbec338b257b60fe9e6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ceaf32e9f1e478f48a17c874ff4981cc',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4af8440ca6862fa9fdb8489a5def4059',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(15 - 1):0] ip,
  output [(15 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(15 - 1):0] ip_1_23;
  localparam signed [(15 - 1):0] const_value = 15\'sb000000000000000;
  reg signed [(15 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 15\'b000000000000000;
    end
  wire signed [(15 - 1):0] op_mem_46_20_front_din;
  wire signed [(15 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(15 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[14]}}, ip_1_23[14:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_447ff429c9',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b0ebb4bee96de3a62c4e428444bab586',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(16 - 1):0] ip,
  output [(16 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_1_23;
  localparam signed [(16 - 1):0] const_value = 16\'sb0000000000000000;
  reg signed [(16 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 16\'b0000000000000000;
    end
  wire signed [(16 - 1):0] op_mem_46_20_front_din;
  wire signed [(16 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(23 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(16 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[15]}}, ip_1_23[15:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[22]}}, cast_internal_ip_27_3_rsh[22:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_05a6d83f8c',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c99e13d476570485e8634d383a9a9f69',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(13 - 1):0] ip,
  output [(13 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(13 - 1):0] ip_1_23;
  localparam signed [(13 - 1):0] const_value = 13\'sb0000000000000;
  reg signed [(13 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 13\'b0000000000000;
    end
  wire signed [(13 - 1):0] op_mem_46_20_front_din;
  wire signed [(13 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(13 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[12]}}, ip_1_23[12:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_ed17a56c3a',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c920225c8a7339a93cddfeeb4f78a030',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(19 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[18]}}, cast_internal_ip_27_3_rsh[18:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_e2f66c8512',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b3d0c1979b2665a8734c5705982ece5c',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_e2efd1e2c2',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a1e047125db6efcfd9a35999737d2579',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(18 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{2{ip_1_23[17]}}, ip_1_23[17:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:3]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_42c206eba8',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '7f5739714aa6d25bdfce7debd7231daf',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 2801A00F, 5003401E, 7C04C02C, A406603B, CC08004A, F409A059, 11C0B4068, 1440CC076, 1700E6085, 198100094, 1C011A0A3, 1E81340B2, 21014C0C0, 2381660CF, 2641800DE, 28C19A0ED, 2B41B20FC, 2DC1CC10A, 3041E6119, 32C200128, 35821A137, 380232146, 3A824C154, 3D0266163, 3F8280172, 42029A181, 44C2B2190, 4742CC19E, 49C2E61AD, 4C43001BC, 4EC31A1CB, 5143321DA, 54034C1E8, 5683661F7, 590380206, 5B839A215, 5E03B2224, 60C3CC232, 6343E6241, 65C400250, 68441A25F, 6AC43226E, 6D444C27C, 70046628B, 72848029A, 75049A2A9, 7784B22B8, 7A04CC2C6, 7C84E62D5, 7F45002E4, 81C5182F3, 844532302, 86C54C310, 89456631F, 8BC58032E, 8E859833D, 9105B234C, 9385CC35A, 9605E6369, 988600378, 9B0618387, 9DC632396, A0464C3A4, A2C6663B3, A546803C2, A7C6983D1, AA46B23E0, AD06CC3EE, AF86E63FD, B2070040C, B4871841B, B7073242A, B9C74C438, BC4766447, BEC780456, C14798465, C3C7B2474, C647CC482, C907E6491, CB88004A0, CE08184AF, D088324BE, D3084C4CC, D588664DB, D8487E4EA, DAC8984F9, DD48B2508, DFC8CC516, E248E6525, E4C8FE534, E78918543, EA0932552, EC894C560, EF096656F, F1897E57E, F4099858D, F6C9B259C, F949CC5AA, FBC9E65B9, FE49FE5C8, 100CA185D7, 1034A325E6, 1060A4C5F4, 1088A66603, 10B0A7E612, 10D8A98621, 1100AB2630, 112CACC63E, 1154AE664D, 117CAFE65C, 11A4B1866B, 11CCB3267A, 11F4B4C688, 1220B64697, 1248B7E6A6, 1270B986B5, 1298BB26C4, 12C0BCC6D2, 12E8BE46E1, 1314BFE6F0, 133CC186FF, 1364C3270E, 138CC4C71C, 13B4C6472B, 13DCC7E73A, 1408C98749, 1430CB2758, 1458CCC766, 1480CE4775, 14A8CFE784, 14D0D18793, 14FCD327A2, 1524D4C7B0, 154CD647BF, 1574D7E7CE, 159CD987DD, 15C8DB27EC, 15F0DCC7FA, 1618DE4809, 1640DFE818, 1668E18827, 1690E32836, 16BCE4C844, 16E4E64853, 170CE7E862, 1734E98871, 175CEB2880, 1784ECA88E, 17B0EE489D, 17D8EFE8AC, 1800F188BB, 1828F328CA, 1850F4A8D8, 1878F648E7, 18A4F7E8F6, 18CCF98905, 18F4FB2914, 191CFCA922, 1944FE4931, 196CFFE940, 199901894F, 19C103295E, 19E904A96C, 1A1106497B, 1A3907E98A, 1A61098999, 1A8D0B29A8, 1AB50CA9B6, 1ADD0E49C5, 1B050FE9D4, 1B2D1189E3, 1B591329F2, 1B8114AA00, 1BA9164A0F, 1BD117EA1E, 1BF9198A2D, 1C211B0A3C, 1C4D1CAA4A, 1C751E4A59, 1C9D1FEA68, 1CC5218A77, 1CED230A86, 1D1524AA94, 1D41264AA3, 1D6927EAB2, 1D91298AC1, 1DB92B0AD0, 1DE12CAADE, 1E092E4AED, 1E352FEAFC, 1E5D318B0B, 1E85330B1A, 1EAD34AB28, 1ED5364B37, 1EFD37EB46, 1F29398B55, 1F513B0B64, 1F793CAB72, 1FA13E4B81, 1FC93FEB90, 1FF1418B9F, 201D430BAE, 204544ABBC, 206D464BCB, 209547EBDA, 20BD498BE9, 20E94B0BF8, 21114CAC06, 21394E4C15, 21614FEC24, 2189516C33, 21B1530C42, 21DD54AC50, 2205564C5F, 222D57EC6E, 2255596C7D, 227D5B0C8C, 22A55CAC9A, 22D15E4CA9, 22F95FECB8, 2321616CC7, 2349630CD6, 237164ACE4, 2399664CF3, 23C567ED02, 23ED696D11, 24156B0D20, 243D6CAD2E, 24656E4D3D, 248D6FED4C, 24B9716D5B, 24E1730D6A, 250974AD78, 2531764D87, 255977ED96, 2581796DA5, 25AD7B0DB4, 25D57CADC2, 25FD7E4DD1, 26257FEDE0, 264D816DEF, 2679830DFE, 26A184AE0C, 26C9864E1B, 26F187CE2A, 2719896E39, 27418B0E48, 276D8CAE56, 27958E4E65, 27BD8FCE74, 27E5916E83, 280D930E92, 283594AEA0, 2861964EAF, 288997CEBE, 575266B133, 577A685142, 57A269D151, 57CE6B7160, 57F66D116E, 581E6EB17D, 584670518C, 586E71D19B, 58967371AA, 58C27511B8, 58EA76B1C7, 59127851D6, 593A79D1E5, 59627B71F4, 598A7D1202, 59B67EB211, 59DE803220, 5A0681D22F, 5A2E83723E, 5A5685124C, 5A8286B25B, 5AAA88326A, 5AD289D279, 5AFA8B7288, 5B228D1296, 5B4A8EB2A5, 5B769032B4, 5B9E91D2C3, 5BC69372D2, 5BEE9512E0, 5C1696B2EF, 5C3E9832FE, 5C6A99D30D, 5C929B731C, 5CBA9D132A, 5CE29EB339, 5D0AA03348, 5D32A1D357, 5D5EA37366, 5D86A51374, 5DAEA6B383, 5DD6A83392, 5DFEA9D3A1, 5E26AB73B0, 5E52AD13BE, 5E7AAEB3CD, 5EA2B033DC, 5ECAB1D3EB, 5EF2B373FA, 5F1AB51408, 5F46B69417, 5F6EB83426, 5F96B9D435, 5FBEBB7444, 5FE6BD1452, 6012BE9461, 603AC03470, 6062C1D47F, 608AC3748E, 60B2C5149C, 60DAC694AB, 6106C834BA, 612EC9D4C9, 6156CB74D8, 617ECD14E6, 61A6CE94F5, 61CED03504, 61FAD1D513, 6222D37522, 624AD51530, 6272D6953F, 629AD8354E, 62C2D9D55D, 62EEDB756C, 6316DD157A, 633EDE9589, 6366E03598, 638EE1D5A7, 63B6E375B6, 63E2E515C4, 640AE695D3, 6432E835E2, 645AE9D5F1, 6482EB7600, 64AAECF60E, 64D6EE961D, 64FEF0362C, 6526F1D63B, 654EF3764A, 6576F4F658, 65A2F69667, 65CAF83676, 65F2F9D685, 661AFB7694, 6642FCF6A2, 666AFE96B1, 66970036C0, 66BF01D6CF, 66E70376DE, 670F04F6EC, 67370696FB, 675F08370A, 678B09D719, 67B30B7728, 67DB0CF736, 68030E9745, 682B103754, 685311D763, 687F137772, 68A714F780, 68CF16978F, 68F718379E, 691F19D7AD, 69471B57BC, 69731CF7CA, 699B1E97D9, 69C32037E8, 69EB21D7F7, 6A13235806, 6A3B24F814, 6A67269823, 6A8F283832, 6AB729D841, 6ADF2B5850, 6B072CF85E, 6B332E986D, 6B5B30387C, 6B8331D88B, 6BAB33589A, 6BD334F8A8, 6BFB3698B7, 6C273838C6, 6C4F39D8D5, 6C773B58E4, 6C9F3CF8F2, 6CC73E9901, 6CEF403910, 6D1B41D91F, 6D4343592E, 6D6B44F93C, 6D9346994B, 6DBB48395A, 6DE349D969, 6E0F4B5978, 6E374CF986, 6E5F4E9995, 6E875039A4, 6EAF51B9B3, 6ED75359C2, 6F0354F9D0, 6F2B5699DF, 6F535839EE, 6F7B59B9FD, 6FA35B5A0C, 6FCF5CFA1A, 6FF75E9A29, 701F603A38, 704761BA47, 706F635A56, 709764FA64, 70C3669A73, 70EB683A82, 711369BA91, 713B6B5AA0, 71636CFAAE, 718B6E9ABD, 71B7703ACC, 71DF71BADB, 7207735AEA, 722F74FAF8, 7257769B07, 727F783B16, 72AB79BB25, 72D37B5B34, 72FB7CFB42, 73237E9B51, 734B801B60, 737381BB6F, 739F835B7E, 73C784FB8C, 73EF869B9B, 7417881BAA, 743F89BBB9, 74678B5BC8, 74938CFBD6, 74BB8E9BE5, 74E3901BF4, 750B91BC03, 7533935C12, 755F94FC20, 7587969C2F, 75AF981C3E, 75D799BC4D, 75FF9B5C5C, 76279CFC6A, 76539E9C79, 767BA01C88, 76A3A1BC97, 76CBA35CA6, 76F3A4FCB4, 771BA69CC3, 7747A81CD2, 776FA9BCE1, 7797AB5CF0, 77BFACFCFE, 77E7AE9D0D, 780FB01D1C, 783BB1BD2B, 7863B35D3A, 788BB4FD48, 78B3B67D57, 78DBB81D66, 7903B9BD75, 792FBB5D84, 7957BCFD92, 797FBE7DA1, 79A7C01DB0, 79CFC1BDBF, 79F7C35DCE, 7A23C4FDDC, 7A4BC67DEB, 7A73C81DFA, 7A9BC9BE09, 7AC3CB5E18, 7AEFCCFE26, 7B17CE7E35, 7B3FD01E44, 7B67D1BE53, 7B8FD35E62, 7BB7D4FE70, 7BE3D67E7F, 7C0BD81E8E, 7C33D9BE9D, 7C5BDB5EAC, 7C83DCFEBA, 7CABDE7EC9, 7CD7E01ED8, 7CFFE1BEE7, 7D27E35EF6, 7D4FE4FF04, 7D77E67F13, 7D9FE81F22, 7DCBE9BF31, 7DF3EB5F40, 7E1BECDF4E, 7E43EE7F5D, 7E6BF01F6C, 7E93F1BF7B, 7EBFF35F8A, 7EE7F4DF98, 7F0FF67FA7, 7F37F81FB6, 7F5FF9BFC5, 7F87FB5FD4, 7FB3FCDFE2, 7FDBFE7FF1;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 39',
    'CSET read_width_b = 39',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 512',
    'CSET write_width_a = 39',
    'CSET write_width_b = 39',
    'CSET component_name = bmg_72_9cba7eb6526fc26f',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bf0019d4e46571242e23cd2da8a807d3',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_9cba7eb6526fc26f',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 0, 0, 0, 0, 1, 11, 111, 111, 111, 111, 111, 111, 112, 112, 112, 122, 122, 122, 222, 222, 222, 223, 223, 223, 223, 233, 233, 233, 233, 233, 234, 334, 334, 334, 334, 344, 344, 344, 345, 345, 345, 345, 345, 345, 445, 455, 455, 456, 456, 456, 456, 456, 456, 456, 456, 466, 567, 567, 567, 567, 567, 567, 567, 567, 568, 578, 578, 578, 578, 678, 678, 678, 678, 679, 679, 689, 689, 689, 689, 689, 689, 789, 78A, 78A, 78A, 79A, 79A, 79A, 79A, 79A, 79B, 79B, 79B, 79B, 89B, 8AB, 8AB, 8AB, 8AB, 8AC, 8AC, 8AC, 8AC, 8AC, 8AC, 8BC, 9BC, 9BC, 9BD, 9BD, 9BD, 9BD, 9BD, 9BD, 9BD, 9CD, 9CE, 9CE, 9CE, ACE, ACE, ACE, ACE, ACE, ACE, ADF, ADF;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 12',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 128',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_f25cd80cb6ee82df',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '119d23587d5d080b5b99e5f5d6f43b28',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_f25cd80cb6ee82df',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2b0d4f00b7fddd7858d34ca67f1bdb9b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd54fc0a325425a619b67881804397223',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b6e11856efa2e116413b63df58daae08',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '497a2d9a973773f3fbc845cf6273f604',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e76a67efa075ea04f9b46eb7154d2bf8',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b496cdda55d70c0cdd0cf48e87b3da12',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 19',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 19',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 19',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_490e4beeb7992ef4',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c9cb4b2ccd79ede2c1af739d9aa778e7',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[18:0] A;
     input CLK;
     input CE;
     output[18:0] S;
     input[18:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_490e4beeb7992ef4',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '588542f21541b83dd1bbb788d79b181b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3ac7b90af4e402ca3d038deb29efd048',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f20d16ed6de49bf770a0f39fdfc2b744',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '11209e0b8ede282620b168f61a94777d',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 6DC0135007F, DB8026A00FE, 149403A0017D, 1B6C04D501FC, 2248060A027B, 2924073F02FA, 300008750379, 36DC09AA03F8, 3DB80ADF0477, 44900C1404F6, 4B6C0D4A0575, 52480E7F05F4, 59240FB40673, 600010E906F2, 66DC121E0771, 6DB8135407F1, 749014890870, 7B6C15BE08EF, 824816F3096E, 8924182909ED, 9000195E0A6C, 96DC1A930AEB, 9DB41BC80B6A, A4901CFD0BE9, AB6C1E330C68, B2481F680CE7, B924209D0D66, C00021D20DE5, C6D823080E64, CDB4243D0EE3, D49025720F62, DB6C26A70FE1, E24827DD1060, E924291210DF, F0002A47115E, F6D82B7C11DD, FDB42CB1125C, 104902DE712DB, 10B6C2F1C135A, 11248305113D9, 1192431861458, 11FFC32BC14D7, 126D833F11556, 12DB4352615D5, 13490365B1654, 13B6C379116D4, 1424838C61753, 1492439FB17D2, 14FFC3B301851, 156D83C6518D0, 15DB43D9B194F, 164903ED019CE, 16B6C40051A4D, 17248413A1ACC, 1792042701B4B, 17FFC43A51BCA, 186D844DA1C49, 18DB4460F1CC8, 1949047441D47, 19B6C487A1DC6, 1A24449AF1E45, 1A9204AE41EC4, 1AFFC4C191F43, 1B6D84D4F1FC2, 1BDB44E842041, 1C4904FB920C0, 1CB6C50EE213F, 1D244522421BE, 1D9205359223D, 1DFFC548E22BC, 1E6D855C3233B, 1EDB456F823BA, 1F490582E2439, 1FB68596324B8, 202445A982537, 209205BCD25B7, 20FFC5D032636, 216D85E3826B5, 21DB45F6D2734, 2249060A227B3, 22B6861D82832, 23244630D28B1, 2392064422930, 23FFC657729AF, 246D866AC2A2E, 24DB467E22AAD, 2548C69172B2C, 25B686A4C2BAB, 262446B812C2A, 269206CB72CA9, 26FFC6DEC2D28, 276D86F212DA7, 27DB470562E26, 2848C718B2EA5, 28B6872C12F24, 2924473F62FA3, 29920752B3022, 29FFC766030A1, 2A6D877963120, 2ADB078CB319F, 2B48C7A00321E, 2BB687B35329D, 2C2447C6B331C, 2C9207DA0339B, 2CFFC7ED5341A, 2D6D4800A3499, 2DDB0813F3519, 2E48C82753598, 2EB6883AA3617, 2F24484DF3696, 2F92086143715, 2FFFC874A3794, 306D4887F3813, 30DB089B43892, 3148C8AE93911, 31B688C1F3990, 322448D543A0F, 329208E893A8E, 32FF88FBE3B0D, 336D490F33B8C, 33DB092293C0B, 3448C935E3C8A, 34B6894933D09, 3524495C83D88, 3592096FE3E07, 35FF898333E86, 366D499683F05, 36DB09A9D3F84, 3748C9BD24003, 37B689D084082, 382449E3D4101, 3891C9F724180, 38FF8A0A741FF, 396D4A1DD427E, 39DB0A31242FD, 3A48CA447437C, 3AB68A57C43FC, 3B244A6B2447B, 3B91CA7E744FA, 3BFF8A91C4579, 3C6D4AA5145F8, 3CDB0AB864677, 3D48CACBC46F6, 3DB68ADF14775, 3E240AF2647F4, 3E91CB05B4873, 3EFF8B19148F2, 3F6D4B2C64971, 3FDB0B3FB49F0, 4048CB5304A6F, 40B64B6654AEE, 41240B79B4B6D, 4191CB8D04BEC, 41FF8BA054C6B, 426D4BB3A4CEA, 42DB0BC704D69, 4348CBDA54DE8, 43B64BEDA4E67, 44240C00F4EE6, 4491CC1454F65, 44FF8C27A4FE4, 456D4C3AF5063, 45DB0C4E450E2, 46488C6195161, 46B64C74F51E0, 47240C884525F, 4791CC9B952DE, 47FF8CAEE535E, 486D4CC2453DD, 48DB0CD59545C, 49488CE8E54DB, 49B64CFC3555A, 4A240D0F955D9, 4A91CD22E5658, 4AFF8D36356D7, 4B6D4D4985756, 4BDACD5CD57D5, 4C488D7035854, 4CB64D83858D3, 4D240D96D5952, 4D91CDAA259D1, 4DFF8DBD85A50, 4E6D0DD0D5ACF, 4EDACDE425B4E, 4F488DF775BCD, 4FB64E0AC5C4C, 50240E1E25CCB, 5091CE3175D4A, 50FF8E44C5DC9, 516D0E5815E48, 51DACE6B75EC7, 52488E7EC5F46, 52B64E9215FC5, 53240EA566044, 5391CEB8C60C3, 53FF4ECC16142, 546D0EDF661C1, 54DACEF2B6241, 55488F06062C0, 55B64F196633F, 56240F2CB63BE, 5691CF400643D, 56FF4F53564BC, 576D0F66B653B, 57DACF7A065BA, 58488F8D56639, 58B64FA0A66B8, 59240FB406737, 59918FC7567B6, 59FF4FDAA6835, 5A6D0FEDF68B4, 5ADAD00146933, 5B489014A69B2, 5BB65027F6A31, 5C24103B46AB0, 5C91904E96B2F, 5CFF5061F6BAE, 5D6D107546C2D, 5DDAD08896CAC, 5E48909BE6D2B, 5EB650AF36DAA, 5F23D0C296E29, 5F9190D5E6EA8, 5FFF50E936F27, 606D10FC86FA6, 60DAD10FE7025, 61489123370A4, 61B6113687124, 6223D149D71A3, 6291915D37222, 62FF5170872A1, 636D1183D7320, 63DAD1972739F, 644891AA7741E, 64B611BDD749D, 6523D1D12751C, 659191E47759B, 65FF51F7C761A, 666D120B27699, 66DAD21E77718, 67485231C7797, 67B6124517816, 6823D25877895, 6891926BC7914, 68FF527F17993, 696D129267A12, 69DAD2A5B7A91, 6A4852B917B10, 6AB612CC67B8F, 6B23D2DFB7C0E, 6B9192F307C8D, 6BFF530667D0C, 6C6D1319B7D8B, 6CDA932D07E0A, 6D48534057E89, 924A2CAC680F8, 92B7ECBFB8177, 9325ACD3081F6, 93932CE658275, 9400ECF9A82F4, 946EAD0D08373, 94DC6D20583F2, 954A2D33A8471, 95B7ED46F84F0, 96256D5A5856F, 96932D6DA85EE, 9700ED80F866D, 976EAD94486EC, 97DC6DA79876B, 984A2DBAF87EA, 98B7EDCE48869, 99256DE1988E8, 99932DF4E8967, 9A00EE08489E6, 9A6EAE1B98A65, 9ADC6E2EE8AE4, 9B4A2E4238B63, 9BB7AE5598BE2, 9C256E68E8C61, 9C932E7C38CE0, 9D00EE8F88D5F, 9D6EAEA2D8DDE, 9DDC6EB638E5D, 9E4A2EC988EDC, 9EB7AEDCD8F5C, 9F256EF028FDB, 9F932F038905A, A000EF16D90D9, A06EAF2A29158, A0DC6F3D791D7, A149EF50D9256, A1B7AF64292D5, A2256F7779354, A2932F8AC93D3, A300EF9E19452, A36EAFB1794D1, A3DC2FC4C9550, A449EFD8195CF, A4B7AFEB6964E, A5256FFEC96CD, A59330121974C, A600F025697CB, A66EB038B984A, A6DC304C098C9, A749F05F69948, A7B7B072B99C7, A825708609A46, A893309959AC5, A900F0ACB9B44, A96E70C009BC3, A9DC30D359C42, AA49F0E6A9CC1, AAB7B0FA09D40, AB25710D59DBF, AB933120A9E3F, AC00F133F9EBE, AC6E714749F3D, ACDC315AA9FBC, AD49F16DFA03B, ADB7B1814A0BA, AE2571949A139, AE9331A7FA1B8, AF00B1BB4A237, AF6E71CE9A2B6, AFDC31E1EA335, B049F1F54A3B4, B0B7B2089A433, B125721BEA4B2, B193322F3A531, B200B2428A5B0, B26E7255EA62F, B2DC32693A6AE, B349F27C8A72D, B3B7B28FDA7AC, B42572A33A82B, B492F2B68A8AA, B500B2C9DA929, B56E72DD2A9A8, B5DC32F07AA27, B649F303DAAA6, B6B7B3172AB25, B725332A7ABA4, B792F33DCAC23, B800B3512ACA2, B86E73647AD22, B8DC3377CADA1, B949F38B1AE20, B9B7B39E7AE9F, BA2533B1CAF1E, BA92F3C51AF9D, BB00B3D86B01C, BB6E73EBBB09B, BBDC33FF1B11A, BC49F4126B199, BCB77425BB218, BD2534390B297, BD92F44C6B316, BE00B45FBB395, BE6E74730B414, BEDC34865B493, BF49F499BB512, BFB774AD0B591, C02534C05B610, C092F4D3AB68F, C100B4E6FB70E, C16E74FA5B78D, C1DC350DAB80C, C249B520FB88B, C2B775344B90A, C3253547AB989, C392F55AFBA08, C400B56E4BA87, C46E75819BB06, C4DBF594EBB85, C549B5A84BC04, C5B775BB9BC84, C62535CEEBD03, C692F5E23BD82, C700B5F59BE01, C76E7608EBE80, C7DBF61C3BEFF, C849B62F8BF7E, C8B77642EBFFD, C92536563C07C, C992F6698C0FB, CA00B67CDC17A, CA6E36902C1F9, CADBF6A38C278, CB49B6B6DC2F7, CBB776CA2C376, CC2536DD7C3F5, CC92F6F0DC474, CD00B7042C4F3, CD6E37177C572, CDDBF72ACC5F1, CE49B73E1C670, CEB777517C6EF, CF253764CC76E, CF92F7781C7ED, D000778B6C86C, D06E379ECC8EB, D0DBF7B21C96A, D149B7C56C9E9, D1B777D8BCA68, D22537EC1CAE7, D292F7FF6CB67, D3007812BCBE6, D36E38260CC65, D3DBF8395CCE4, D449B84CBCD63, D4B778600CDE2, D52538735CE61, D592B886ACEE0, D600789A0CF5F, D66E38AD5CFDE, D6DBF8C0AD05D, D749B8D3FD0DC, D7B778E75D15B, D824F8FAAD1DA, D892B90DFD259, D90079214D2D8, D96E39349D357, D9DBF947FD3D6, DA49B95B4D455, DAB7796E9D4D4, DB24F981ED553, DB92B9954D5D2, DC0079A89D651, DC6E39BBED6D0, DCDBF9CF3D74F, DD49B9E28D7CE, DDB739F5ED84D, DE24FA093D8CC, DE92BA1C8D94B, DF007A2FDD9CA, DF6E3A433DA49, DFDBFA568DAC9, E049BA69DDB48, E0B73A7D2DBC7, E124FA908DC46, E192BAA3DDCC5, E2007AB72DD44, E26E3ACA7DDC3, E2DBFADDCDE42, E3497AF12DEC1, E3B73B047DF40, E424FB17CDFBF, E492BB2B1E03E, E5007B3E7E0BD, E56E3B51CE13C, E5DBFB651E1BB, E6497B786E23A, E6B73B8BCE2B9, E724FB9F1E338, E792BBB26E3B7, E8007BC5BE436, E86E3BD90E4B5, E8DBBBEC6E534, E9497BFFBE5B3, E9B73C130E632, EA24FC265E6B1, EA92BC39BE730, EB007C4D0E7AF, EB6DFC605E82E, EBDBBC73AE8AD, EC497C86FE92C, ECB73C9A5E9AC, ED24FCADAEA2B, ED92BCC0FEAAA, EE007CD44EB29, EE6DFCE7AEBA8, EEDBBCFAFEC27, EF497D0E4ECA6, EFB73D219ED25, F024FD34FEDA4, F092BD484EE23, F1003D5B9EEA2, F16DFD6EEEF21, F1DBBD823EFA0, F2497D959F01F, F2B73DA8EF09E, F324FDBC3F11D, F392BDCF8F19C, F4003DE2EF21B, F46DFDF63F29A, F4DBBE098F319, F5497E1CDF398, F5B73E303F417, F624FE438F496, F6927E56DF515, F7003E6A2F594, F76DFE7D7F613, F7DBBE90DF692, F8497EA42F711, F8B73EB77F790, F924BECACF80F, F9927EDE2F88F, FA003EF17F90E, FA6DFF04CF98D, FADBBF181FA0C, FB497F2B6FA8B, FBB73F3ECFB0A, FC24BF521FB89, FC927F656FC08, FD003F78BFC87, FD6DFF8C1FD06, FDDBBF9F6FD85, FE497FB2BFE04, FEB6FFC60FE83, FF24BFD96FF02, FF927FECBFF81;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 52',
    'CSET read_width_b = 52',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 512',
    'CSET write_width_a = 52',
    'CSET write_width_b = 52',
    'CSET component_name = bmg_72_e18a8bcda58a41cd',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '3def61c02ed4b4a43e47d4534c63db83',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_e18a8bcda58a41cd',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 30101, 70282, A0383, E0504, 110605, 150706, 180887, 1B0988, 1F0B09, 220C0A, 260D8B, 290E8C, 2D0F8D, 30110E, 33120F, 371390, 3A1491, 3E1592, 411713, 451814, 481995, 4B1A96, 4F1C17, 521D18, 561E19, 591F9A, 5D209B, 60221C, 63231D, 67241E, 6A259F, 6E26A0, 712821, 752922, 782AA3, 7B2BA4, 7F2CA5, 822E26, 862F27, 8930A8, 8D31A9, 9032AA, 93342B, 97352C, 9A36AD, 9E37AE, A1392F, A53A30, A83B31, AB3CB2, AF3DB3, B23F34, B64035, B94136, BD42B7, C043B8, C34539, C7463A, CA47BB, CE48BC, D149BD, D54B3E, D84C3F, DB4DC0, DF4EC1, E24FC2, E65142, E95243, ED53C4, F054C5, F35646, F75747, FA5848, FE59C9, 1015ACA, 1055C4B, 1085D4C, 10B5E4D, 10F5FCE, 11260CF, 1166250, 1196351, 11D64D2, 12065D3, 12366D4, 1276855, 12A6956, 12E6AD7, 1316BD8, 1356CD9, 1386E5A, 13B6F5B, 13F70DC, 14271DD, 146735E, 149745F, 14D7560, 15076E1, 15377E2, 1577963, 15A7A64, 15E7B65, 1617CE6, 1657DE7, 1687F68, 16B8069, 16F816A, 17282EB, 17683EC, 179856D, 17D866E, 18087EF, 18388F0, 18789F1, 18A8B72, 18E8C73, 1918DF4, 1958EF5, 1988FF6, 19B9177, 19F9278, 1A293F9, 1A694FA, 1A9967B, 1AD977C, 1B0987D, 1B399FE;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 25',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 128',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_e9661fc0e9eb3e90',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '988346f5dc985fc8d2a05dcc3f666449',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_e9661fc0e9eb3e90',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bcc9835cd4cb27e3a067460044bad61f',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] input_port,
  output [(18 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(18 - 1):0] input_port_1_40;
  wire signed [(18 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_87da68fdf8',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '2c26b146bbc0fff3e38d00f7d14780c2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '7126dbab945df0658817a670e91a47d1',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2e5dbac9753459cb0c0f2e7b51e3c26b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '9e0cef9ecbc3a6e4e7db408b904d997e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2776d35f56340fe7ab64c1c51e55e53b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f4c6671b9580d776c38d6847261d066b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ed27ba09f298fddfcfc7520140cb25d0',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(18 - 1):0] ip,
  output [(18 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(18 - 1):0] ip_1_23;
  localparam signed [(18 - 1):0] const_value = 18\'sb000000000000000000;
  reg signed [(18 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 18\'b000000000000000000;
    end
  wire signed [(18 - 1):0] op_mem_46_20_front_din;
  wire signed [(18 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = ip_1_23;
endmodule
',
      'entity_name' => 'shift_572bccbff0',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 19',
    'CSET Add_Mode = Subtract',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 19',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 19',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_a5337ca1a964fead',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '567b011534b413fe0e09901552dbee60',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[18:0] A;
     input CLK;
     input CE;
     output[18:0] S;
     input[18:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_a5337ca1a964fead',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '71168fde110d1dac2c3582bd492a36a2',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 22',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 22',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 22',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_82f1c5fd59d21ea0',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '8c5a4ab929e08a024486936ab324a760',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[21:0] A;
     input CLK;
     input CE;
     output[21:0] S;
     input[21:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_82f1c5fd59d21ea0',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '2d06b15f9aee69d37bb7cb58a5ee5014',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '61bf3848f9a4452110be43a5b8ce879c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4da10971614d165e8fc355e7e6426feb',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21\'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21\'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(25 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{4{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[24]}}, cast_internal_ip_27_3_rsh[24:5]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_5d11edb312',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b466f3884fd9d79e445af4b2703a0b88',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(21 - 1):0] ip,
  output [(21 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(21 - 1):0] ip_1_23;
  localparam signed [(21 - 1):0] const_value = 21\'sb000000000000000000000;
  reg signed [(21 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 21\'b000000000000000000000;
    end
  wire signed [(21 - 1):0] op_mem_46_20_front_din;
  wire signed [(21 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(27 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(21 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{6{ip_1_23[20]}}, ip_1_23[20:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[26]}}, cast_internal_ip_27_3_rsh[26:7]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_e97ef80d67',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 18',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 18',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 18',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_0e0e0a285ef7a16d',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bc6d14d9186b2ba7fe00e5111d4dd8be',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[17:0] A;
     input CLK;
     input CE;
     output[17:0] S;
     input[17:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_0e0e0a285ef7a16d',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8a0979920675c15a2ad024885f03296c',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'dada6b8dc63492ea9037d01ece52d712',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8652c7db9fa18d2d7771b18ecd43ad5b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3c941147d49fa6df3308de3cc64f9216',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '465fff55f7f5b010ca93affbc72d6f62',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '880c3da716bfc773c34aa1d07cb2d653',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 12E0045802D, 25B008A805A, 38900D00087, 4B6011500B4, 5E4015A80E1, 71101A0010D, 83F01E5013A, 96D022A8167, A9A02700194, BC802B501C1, CF502FA81EE, E23033F821B, F5103850248, 107E03CA8275, 11AC040F82A2, 12D9045502CF, 1407049A02FC, 153404DF8328, 166205250355, 1790056A0382, 18BD05AF83AF, 19EB05F483DC, 1B18063A0409, 1C46067F8436, 1D7306C48463, 1EA1070A0490, 1FCF074F84BD, 20FC079484EA, 222A07DA0516, 2357081F0543, 248508648570, 25B208AA059D, 26E008EF05CA, 280E093485F7, 293B09798624, 2A6909BF0651, 2B960A04867E, 2CC40A4986AB, 2DF20A8F06D8, 2F1F0AD48704, 304D0B198731, 317A0B5F075E, 32A80BA4078B, 33D50BE987B8, 35030C2F07E5, 36310C740812, 375E0CB9883F, 388C0CFE886C, 39B90D440899, 3AE70D8988C6, 3C140DCE88F3, 3D420E14091F, 3E700E59894C, 3F9D0E9E8979, 40CB0EE409A6, 41F80F2909D3, 43260F6E8A00, 44530FB40A2D, 45810FF90A5A, 46AF103E8A87, 47DC10838AB4, 490A10C90AE1, 4A37110E8B0D, 4B6511538B3A, 4C9311990B67, 4DC011DE0B94, 4EEE12238BC1, 501B12690BEE, 514912AE0C1B, 527612F38C48, 53A413390C75, 54D2137E0CA2, 55FF13C38CCF, 572D14088CFC, 585A144E0D28, 598814938D55, 5AB514D88D82, 5BE3151E0DAF, 5D1115630DDC, 5E3E15A88E09, 5F6C15EE0E36, 609916330E63, 61C716788E90, 62F416BE0EBD, 642217030EEA, 655017488F16, 667D178D8F43, 67AB17D30F70, 68D818188F9D, 6A06185D8FCA, 6B3418A30FF7, 6C6118E81024, 6D8F192D9051, 6EBC1973107E, 6FEA19B810AB, 711719FD90D8, 72451A429104, 73731A881131, 74A01ACD915E, 75CE1B12918B, 76FB1B5811B8, 78291B9D91E5, 79561BE29212, 7A841C28123F, 7BB21C6D126C, 7CDF1CB29299, 7E0D1CF812C6, 7F3A1D3D12F3, 80681D82931F, 81961DC7934C, 82C31E0D1379, 83F11E5293A6, 851E1E9793D3, 864C1EDD1400, 87791F22942D, 88A71F67945A, 89D51FAD1487, 8B021FF214B4, 8C30203794E1, 8D5D207D150D, 8E8B20C2153A, 8FB821079567, 90E6214C9594, 9214219215C1, 934121D795EE, 946F221C961B, 959C22621648, 96CA22A79675, 97F722EC96A2, 9925233216CF, 9A53237716FC, 9B8023BC9728, 9CAE24021755, 9DDB24471782, 9F09248C97AF, A03724D197DC, A16425171809, A292255C9836, A3BF25A19863, A4ED25E71890, A61A262C18BD, A748267198EA, A87626B71916, A9A326FC1943, AAD127419970, ABFE2787199D, AD2C27CC19CA, AE59281199F7, AF8728569A24, B0B5289C1A51, B1E228E19A7E, B31029269AAB, B43D296C1AD8, B56B29B11B04, B69829F69B31, B7C62A3C1B5E, B8F42A811B8B, BA212AC69BB8, BB4F2B0C1BE5, BC7C2B511C12, BDAA2B969C3F, BED82BDB9C6C, C0052C211C99, C1332C669CC6, C2602CAB9CF3, C38E2CF11D1F, C4BB2D361D4C, C5E92D7B9D79, C7172DC11DA6, C8442E061DD3, C9722E4B9E00, CA9F2E909E2D, CBCD2ED61E5A, CCFA2F1B9E87, CE282F609EB4, CF562FA61EE1, D0832FEB9F0D, D1B130309F3A, D2DE30761F67, D40C30BB1F94, D53931009FC1, D66731461FEE, D795318B201B, D8C231D0A048, D9F03215A075, DB1D325B20A2, DC4B32A0A0CF, DD7932E5A0FC, DEA6332B2128, DFD43370A155, E10133B5A182, E22F33FB21AF, E35C344021DC, E48A3485A209, E5B834CB2236, E6E535102263, E8133555A290, E940359AA2BD, EA6E35E022EA, EB9B3625A316, ECC9366AA343, EDF736B02370, EF2436F5239D, F052373AA3CA, F17F378023F7, F2AD37C52424, F3DB380AA451, F5083850247E, F636389524AB, F76338DAA4D8, F891391FA504, F9BE39652531, FAEC39AAA55E, FC1A39EFA58B, FD473A3525B8, FE753A7A25E5, FFA23ABFA612, 100D03B05263F, 101FD3B4A266C, 1032B3B8FA699, 104593BD526C6, 105863C1A26F3, 106B43C5FA71F, 107E13CA4A74C, 1090F3CEA2779, 10A3C3D2FA7A6, 10B6A3D74A7D3, 10C983DBA2800, 10DC53DFF282D, 10EF33E44A85A, 110203E8A2887, 1114E3ECF28B4, 1127C3F14A8E1, 113A93F5A290D, 114D73F9F293A, 116043FE4A967, 117324029A994, 1185F406F29C1, 1198D40B4A9EE, 11ABB40F9AA1B, 11BE8413F2A48, 11D1641842A75, 11E4341C9AAA2, 11F71420F2ACF, 1209E42542AFC, 121CC4299AB28, 122FA42DEAB55, 1242743242B82, 125554369ABAF, 1268243AEABDC, 127B043F42C09, 128DD4439AC36, 12A0B447EAC63, 12B3944C42C90, 12C6645092CBD, 2D26CBAB1D316, 2D39ABAF75343, 2D4C7BB3C5370, 2D5F5BB81D39D, 2D723BBC6D3CA, 2D850BC0C53F7, 2D97EBC51D424, 2DAABBC96D451, 2DBD9BCDC547E, 2DD06BD21D4AB, 2DE34BD66D4D8, 2DF62BDAC5504, 2E08FBDF15531, 2E1BDBE36D55E, 2E2EABE7C558B, 2E418BEC155B8, 2E545BF06D5E5, 2E673BF4BD612, 2E7A1BF91563F, 2E8CEBFD6D66C, 2E9FCC01BD699, 2EB29C06156C6, 2EC57C0A656F3, 2ED84C0EBD71F, 2EEB2C131574C, 2EFE0C1765779, 2F10DC1BBD7A6, 2F23BC20157D3, 2F368C2465800, 2F496C28BD82D, 2F5C4C2D0D85A, 2F6F1C3165887, 2F81FC35BD8B4, 2F94CC3A0D8E1, 2FA7AC3E6590D, 2FBA7C42B593A, 2FCD5C470D967, 2FE03C4B65994, 2FF30C4FB59C1, 3005EC540D9EE, 3018BC5865A1B, 302B9C5CB5A48, 303E6C610DA75, 30514C655DAA2, 30642C69B5ACF, 3076FC6E0DAFC, 3089DC725DB28, 309CAC76B5B55, 30AF8C7B05B82, 30C25C7F5DBAF, 30D53C83B5BDC, 30E81C8805C09, 30FAEC8C5DC36, 310DCC90B5C63, 31209C9505C90, 31337C995DCBD, 31465C9DADCEA, 31592CA205D16, 316C0CA65DD43, 317EDCAAADD70, 3191BCAF05D9D, 31A48CB355DCA, 31B76CB7ADDF7, 31CA4CBC05E24, 31DD1CC055E51, 31EFFCC4ADE7E, 3202CCC8FDEAB, 3215ACCD55ED8, 32287CD1ADF04, 323B5CD5FDF31, 324E3CDA55F5E, 32610CDEADF8B, 3273ECE2FDFB8, 3286BCE755FE5, 32999CEBA6012, 32AC7CEFFE03F, 32BF4CF45606C, 32D22CF8A6099, 32E4FCFCFE0C6, 32F7DD014E0F3, 330AAD05A611F, 331D8D09FE14C, 33306D0E4E179, 33433D12A61A6, 33561D16FE1D3, 3368ED1B4E200, 337BCD1FA622D, 338E9D23F625A, 33A17D284E287, 33B45D2CA62B4, 33C72D30F62E1, 33DA0D354E30D, 33ECDD399E33A, 33FFBD3DF6367, 34128D424E394, 34256D469E3C1, 34384D4AF63EE, 344B1D4F4641B, 345DFD539E448, 3470CD57F6475, 3483AD5C464A2, 34968D609E4CF, 34A95D64F64FC, 34BC3D6946528, 34CF0D6D9E555, 34E1ED71EE582, 34F4BD76465AF, 35079D7A9E5DC, 351A7D7EEE609, 352D4D8346636, 35402D8796663, 3552FD8BEE690, 3565DD90466BD, 3578AD94966EA, 358B8D98EE716, 359E6D9D46743, 35B13DA196770, 35C41DA5EE79D, 35D6EDAA3E7CA, 35E9CDAE967F7, 35FC9DB2EE824, 360F7DB73E851, 36225DBB9687E, 36352DBFE68AB, 36480DC43E8D8, 365ADDC896904, 366DBDCCE6931, 36809DD13E95E, 36936DD58E98B, 36A64DD9E69B8, 36B91DDE3E9E5, 36CBFDE28EA12, 36DECDE6E6A3F, 36F1ADEB3EA6C, 37048DEF8EA99, 37175DF3E6AC6, 372A3DF836AF3, 373D0DFC8EB1F, 374FEE00E6B4C, 3762BE0536B79, 37759E098EBA6, 37887E0DDEBD3, 379B4E1236C00, 37AE2E168EC2D, 37C0FE1ADEC5A, 37D3DE1F36C87, 37E6AE238ECB4, 37F98E27DECE1, 380C6E2C36D0D, 381F3E3086D3A, 38321E34DED67, 3844EE3936D94, 3857CE3D86DC1, 386AAE41DEDEE, 387D7E462EE1B, 38905E4A86E48, 38A32E4EDEE75, 38B60E532EEA2, 38C8DE5786ECF, 38DBBE5BDEEFC, 38EE9E602EF28, 39016E6486F55, 39144E68D6F82, 39271E6D2EFAF, 3939FE7186FDC, 394CCE75D7009, 395FAE7A2F036, 39728E7E7F063, 39855E82D7090, 39983E872F0BD, 39AB0E8B7F0EA, 39BDEE8FD7116, 39D0CE9427143, 39E39E987F170, 39F67E9CD719D, 3A094EA1271CA, 3A1C2EA57F1F7, 3A2EFEA9D7224, 3A41DEAE27251, 3A54BEB27F27E, 3A678EB6CF2AB, 3A7A6EBB272D8, 3A8D3EBF7F304, 3AA01EC3CF331, 3AB2EEC82735E, 3AC5CECC7738B, 3AD8AED0CF3B8, 3AEB7ED5273E5, 3AFE5ED977412, 3B112EDDCF43F, 3B240EE22746C, 3B36DEE677499, 3B49BEEACF4C6, 3B5C9EEF1F4F3, 3B6F6EF37751F, 3B824EF7CF54C, 3B951EFC1F579, 3BA7FF00775A6, 3BBADF04C75D3, 3BCDAF091F600, 3BE08F0D7762D, 3BF35F11C765A, 3C063F161F687, 3C190F1A6F6B4, 3C2BEF1EC76E1, 3C3ECF231F70D, 3C519F276F73A, 3C647F2BC7767, 3C774F301F794, 3C8A2F346F7C1, 3C9CFF38C77EE, 3CAFDF3D1781B, 3CC2BF416F848, 3CD58F45C7875, 3CE86F4A178A2, 3CFB3F4E6F8CF, 3D0E1F52BF8FC, 3D20EF5717928, 3D33CF5B6F955, 3D46AF5FBF982, 3D597F64179AF, 3D6C5F686F9DC, 3D7F2F6CBFA09, 3D920F7117A36, 3DA4EF7567A63, 3DB7BF79BFA90, 3DCA9F7E17ABD, 3DDD6F8267AEA, 3DF04F86BFB16, 3E031F8B0FB43, 3E15FF8F67B70, 3E28DF93BFB9D, 3E3BAF980FBCA, 3E4E8F9C67BF7, 3E615FA0BFC24, 3E743FA50FC51, 3E870FA967C7E, 3E99EFADB7CAB, 3EACCFB20FCD8, 3EBF9FB667D04, 3ED27FBAB7D31, 3EE54FBF0FD5E, 3EF82FC35FD8B, 3F0AFFC7B7DB8, 3F1DDFCC0FDE5, 3F30BFD05FE12, 3F438FD4B7E3F, 3F566FD907E6C, 3F693FDD5FE99, 3F7C1FE1B7EC6, 3F8EFFE607EF3, 3FA1CFEA5FF1F, 3FB4AFEEB7F4C, 3FC77FF307F79, 3FDA5FF75FFA6, 3FED2FFBAFFD3;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 50',
    'CSET read_width_b = 50',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 512',
    'CSET write_width_a = 50',
    'CSET write_width_b = 50',
    'CSET component_name = bmg_72_b297e10d233cb875',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '321c51afb8a4666207ec6499276e9578',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_b297e10d233cb875',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 8040, 14081, 1C0C1, 24101, 30142, 38182, 40202, 4C243, 54283, 602C4, 68304, 70344, 7C385, 843C5, 8C405, 98446, A0486, A84C6, B4547, BC587, C45C7, D0608, D8648, E4688, EC6C9, F4709, 100749, 10878A, 1107CA, 11C80B, 12488B, 12C8CB, 13890C, 14094C, 14898C, 1549CD, 15CA0D, 168A4D, 170A8E, 178ACE, 184B0E, 18CB4F, 194BCF, 1A0C0F, 1A8C50, 1B0C90, 1BCCD0, 1C4D11, 1CCD51, 1D8D92, 1E0DD2, 1ECE12, 1F4E53, 1FCE93, 208F13, 210F54, 218F94, 224FD4, 22D015, 235055, 241095, 2490D6, 251116, 25D156, 265197, 2711D7, 279258, 281298, 28D2D8, 295319, 29D359, 2A9399, 2B13DA, 2B941A, 2C545A, 2CD49B, 2D54DB, 2E151B, 2E959C, 2F15DC, 2FD61C, 30565D, 31169D, 3196DD, 32171E, 32D75E, 33579F, 33D7DF, 34981F, 351860, 3598E0, 365920, 36D961, 3759A1, 3819E1, 389A22, 395A62, 39DAA2, 3A5AE3, 3B1B23, 3B9B63, 3C1BA4, 3CDC24, 3D5C64, 3DDCA5, 3E9CE5, 3F1D26, 3F9D66, 405DA6, 40DDE7, 419E27, 421E67, 429EA8, 435EE8, 43DF68, 445FA9, 451FE9, 45A029, 46206A, 46E0AA, 4760EA, 47E12B, 48A16B, 4921AC, 49E1EC, 4A622C, 4AE2AD;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 23',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 128',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_53c8fda674a6c63d',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '29ad86c2b758dbfa57693e05655d41f4',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_53c8fda674a6c63d',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '827818c04e67b8073938852c5c1b39ce',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(9 - 1):0] input_port,
  output [(9 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(9 - 1):0] input_port_1_40;
  wire signed [(9 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_81e883cd82',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'c8b8087b7d8a3ddc0d1041e6b8a0e9fd',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(17 - 1):0] input_port,
  output [(17 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(17 - 1):0] input_port_1_40;
  wire signed [(17 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_79f2a2c095',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cae019f2f1ff337e9f783e65b8cf7ae6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f3d108cd058cec8dfa4d9e659e09dcc8',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a956e7ae5dae36914841bd0125f8fc8b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0d3daae1a22e5555bac2019bb1c30767',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd38bf6b70f6bf2e72f42d5d69b6fd3c4',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '44931cbf97925f233aeed65a7c731d83',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '7e5edcd5233942368ccb4d05b4162013',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(17 - 1):0] ip,
  output [(17 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(17 - 1):0] ip_1_23;
  localparam signed [(17 - 1):0] const_value = 17\'sb00000000000000000;
  reg signed [(17 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 17\'b00000000000000000;
    end
  wire signed [(17 - 1):0] op_mem_46_20_front_din;
  wire signed [(17 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(24 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(17 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[16]}}, ip_1_23[16:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[23]}}, cast_internal_ip_27_3_rsh[23:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_0be5f5842d',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'bfbf5ac651e817e0f929f84094e09b6b',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(20 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{1{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[19]}}, cast_internal_ip_27_3_rsh[19:2]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_0b3d34a3d5',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd14284272d8c7ec8e66a9fa3fc4d9f31',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(22 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{3{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[21]}}, cast_internal_ip_27_3_rsh[21:4]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_bc177199ac',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = [
    'SELECT Adder_Subtracter kintex7 Xilinx,_Inc. 11.0',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET AINIT_Value = 0',
    'CSET A_Type = Signed',
    'CSET A_Width = 20',
    'CSET Add_Mode = Add',
    'CSET B_Constant = false',
    'CSET B_Type = Signed',
    'CSET B_Value = 0',
    'CSET B_Width = 20',
    'CSET Borrow_Sense = Active_Low',
    'CSET Bypass = false',
    'CSET Bypass_CE_Priority = Bypass_Overrides_CE',
    'CSET Bypass_Sense = Active_Low',
    'CSET CE = true',
    'CSET C_In = false',
    'CSET C_Out = false',
    'CSET Implementation = Fabric',
    'CSET Latency = 1',
    'CSET Out_Width = 20',
    'CSET SCLR = false',
    'CSET SINIT = false',
    'CSET SINIT_Value = 0',
    'CSET SSET = false',
    'CSET Sync_CE_Priority = Sync_Overrides_CE',
    'CSET Sync_Ctrl_Priority = Reset_Overrides_Set',
    'SET simulationfiles = Structural',
    'CSET component_name = addsb_11_0_cfbd5258ba626a7a',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '3af3530dcea33f36ff8efdd899a2426a',
    'sourceFile' => 'hdl/xladdsub.v',
    'templateKeyValues' => {
      'core_component_def' => '(A, CLK, CE, S, B) /* synthesis syn_black_box */;
      input[19:0] A;
     input CLK;
     input CE;
     output[19:0] S;
     input[19:0] B;',
      'core_instance_text' => '         .a(full_a),
         .clk(clk),
         .ce(internal_ce),
         .s(core_s),
         .b(full_b)',
      'core_name0' => 'addsb_11_0_cfbd5258ba626a7a',
      'entityName' => 'xladdsub_duc_16ch_341',
      'entity_name.0' => 'xladdsub',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '06a4231bae149b2698c7e0227a1f9411',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'deb1aa54518c93d136c1b5e943b1add7',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '4bba85e14bc18df38da7cbd1cbe7c64e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '9144b86493ff6c32d065515adff66108',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Block_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET algorithm = Minimum_Area',
    'CSET assume_synchronous_clk = false',
    'CSET byte_size = 9',
    'CSET coe_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 5DA00AA001F9, BB60154003F3, 119001FE005EC, 176A02A8007E6, 1D440352009DF, 232003FC00BD8, 28FA04A600DD2, 2ED4055000FCB, 34B005FA011C4, 3A8A06A4013BE, 4064074E015B7, 463E07F8017B1, 4C1A08A2019AA, 51F4094C01BA3, 57CE09F601D9D, 5DAA0AA001F96, 63840B4A0218F, 695E0BF402389, 6F380C9E02582, 75140D484277C, 7AEE0DF242975, 80C80E9C42B6E, 86A20F4642D68, 8C7E0FF042F61, 9258109A4315B, 9832114443354, 9E0E11EE4354D, A3E8129843747, A9C2134243940, AF9C13EC43B39, B578149643D33, BB52154043F2C, C12C15EA44126, C70816944431F, CCE2173E44518, D2BC17E844712, D89618924490B, DE72193C44B04, E44C19E644CFE, EA261A9044EF7, F0021B3A450F1, F5DC1BE4452EA, FBB61C8E454E3, 101901D38456DD, 1076C1DE2458D6, 10D461E8C45AD0, 113201F3645CC9, 118FC1FE045EC2, 11ED6208A460BC, 124B02134462B5, 12A8A21DE464AE, 130662288466A8, 136402332468A1, 13C1A23DC46A9B, 141F6248646C94, 147D0253046E8D, 14DAA25DA47087, 15384268447280, 15960272E87479, 15F3A27D887673, 1651428828786C, 16AF0292C87A66, 170CA29D687C5F, 176A42A8087E58, 17C7E2B2A88052, 1825A2BD48824B, 188342C7E88445, 18E0E2D288863E, 193E82DD288837, 199C42E7C88A31, 19F9E2F2688C2A, 1A5782FD088E23, 1AB54307A8901D, 1B12E312489216, 1B70831CE89410, 1BCE2327889609, 1C2BE332289802, 1C89833CC899FC, 1CE72347689BF5, 1D44E352089DEF, 1DA2835CA89FE8, 1E00236748A1E1, 1E5DC371E8A3DB, 1EBB837C88A5D4, 1F19238728A7CD, 1F76C391C8A9C7, 1FD4839C68ABC0, 203223A708ADBA, 208FC3B1A8AFB4, 20ED63BC48B1AC, 214B23C6E8B3A6, 21A8C3D188B5A0, 220663DC28B798, 226423E6C8B992, 22C1C3F168BB8C, 231F63FC08BD84, 237D0406A8BF7E, 23DAC4114CC178, 2438641BECC370, 249604268CC56A, 24F3C4312CC764, 2551643BCCC95C, 25AF04466CCB56, 260CA4510CCD50, 266A645BACCF48, 26C804664CD142, 2725A470ECD33C, 2783447B8CD534, 27E104862CD730, 283EA490CCD928, 289C449B6CDB20, 28FA04A60CDD1C, 2957A4B0ACDF14, 29B544BB4CE10C, 2A12E4C5ECE308, 2A70A4D08CE500, 2ACE44DB2CE6FA, 2B2BE4E5CCE8F4, 2B89A4F06CEAEC, 2BE744FB0CECE6, 2C44E505ACEEE0, 2CA285104CF0D8, 2D00451AECF2D2, 2D5DE5258CF4CC, 2DBB85302CF6C4, 2E19453ACCF8BE, 2E76E5456CFAB8, 2ED485500CFCB0, 2F32255AACFEAA, 2F8FE5654D00A4, 2FED856FED029C, 304B257A8D0496, 30A8E5852D0690, 3106858FCD0888, 3164259A6D0A82, 31C1C5A50D0C7C, 321F85AFB10E74, 327D25BA511070, 32DAC5C4F11268, 333885CF911460, 339625DA31165C, 33F3C5E4D11854, 345165EF711A4E, 34AF25FA111C48, 350CC604B11E40, 356A660F51203A, 35C80619F12234, 3625C62491242C, 3683662F312626, 36E10639D12820, 373EC644712A18, 379C664F112C12, 37FA0659B12E0C, 3857A664513004, 38B5666EF131FE, 391306799133F8, 3970A6843135F0, 39CE668ED137EA, 3A2C06997139E4, 3A89A6A4113BDC, 3AE746AEB13DD6, 3B4506B9513FD0, 3BA2A6C3F141C8, 3C0046CE9143C4, 3C5E06D93145BC, 3CBBA6E3D147B4, 3D1946EE7149B0, 3D76E6F9114BA8, 3DD4A703B14DA0, 3E32470E514F9C, 3E8FE718F15194, 3EEDA72391538E, 3F4B472E315588, 3FA8E738D15780, 40068743715978, 4064474E155B74, 40C1E758B55D6C, 411F8763555F68, 417D476DF56160, 41DAE778956358, 42388783356550, 4296278DD5674C, 42F3E798756944, 435187A3156B40, 43AF27ADB56D38, 440CE7B8556F30, 446A87C2F57128, 44C827CD957324, 4525C7D835751C, 458387E2D57718, 45E127ED757910, 463EC7F8157B08, 469C6802B57D04, 46FA280D557EFC, 4757C817F580F4, 47B568229582F0, 4813282D3584E8, 4870C837D586E0, 48CE68427588DC, 492C084D158AD4, 4989C857B58CD0, 49E76862558EC8, 4A45086CF590C0, 4AA2C8779592B8, 4B0068823594B4, 4B5E088CD596AC, 4BBBA8977598A8, 4C1968A2159AA0, 4C7708ACB59C98, 4CD4A8B7559E90, 4D3268C1F5A08C, 4D9008CC95A284, 4DEDA8D735A480, 4E4B48E1D5A678, 4EA908EC79A870, 4F06A8F719AA68, 4F644901B9AC64, 4FC2090C59AE5C, 501FA916F9B058, 507D492199B250, 50DAE92C39B448, 5138A936D9B644, 5196494179B83C, 51F3E94C19BA34, 5251A956B9BC30, 52AF496159BE28, 530CE96BF9C020, 536A897699C21C, 53C8498139C414, 5425E98BD9C610, 5483899679C808, 54E129A119CA00, 553EE9ABB9CBF8, 559C89B659CDF4, 55FA29C0F9CFEC, 5657E9CB99D1E8, 56B589D639D3E0, 571329E0D9D5D8, 5770C9EB79D7D0, 57CE89F619D9CC, 582C2A00B9DBC4, 5889CA0B59DDC0, 58E78A15F9DFB8, 59452A2099E1B0, 59A2CA2B39E3A8, 5A006A35D9E5A4, 5A5E2A4079E79C, 5ABBCA4B19E998, 5B196A55B9EB90, 5B772A6059ED88, 5BD4CA6AF9EF84, 5C326A7599F17C, 5C900A8039F374, 5CEDCA8ADDF570, 5D4B6A957DF768, A257155FE606A0, A2B4B56A860898, A3125575260A90, A370157FCA0C88, A3CDB58A6A0E80, A42B55950A1080, A488F59FAA1278, A4E6B5AA4A1470, A54455B4EA1668, A5A1F5BF8A1860, A5FFB5CA2A1A60, A65D55D4CA1C58, A6BAF5DF6A1E50, A71895EA0A2048, A77655F4AA2240, A7D3F5FF4A2438, A8319609EA2630, A88F56148A2830, A8ECF61F2A2A28, A94A9629CA2C20, A9A836346A2E18, AA05F63F0A3010, AA639649AA3210, AAC136544A3408, AB1EF65EEA3600, AB7C96698A37F8, ABDA36742A39F0, AC37D67ECA3BF0, AC9596896A3DE8, ACF336940A3FE0, AD50D69EAA41D8, ADAE76A94A43D0, AE0C36B3EA45C8, AE69D6BE8A47C0, AEC776C92A49C0, AF2536D3CA4BB8, AF82D6DE6A4DB0, AFE076E90A4FA8, B03E16F3AA51A0, B09BD6FE4A53A0, B0F97708EA5598, B15717138A5790, B1B4D71E2E5988, B2127728CE5B80, B27017336E5D78, B2CDB73E0E5F78, B32B7748AE6170, B38917534E6368, B3E6B75DEE6560, B44477688E6758, B4A217732E6950, B4FFB77DCE6B50, B55D57886E6D48, B5BB17930E6F40, B618B79DAE7138, B67657A84E7330, B6D417B2EE7530, B731B7BD8E7728, B78F57C82E7920, B7ECF7D2CE7B18, B84AB7DD6E7D10, B8A857E80E7F08, B905F7F2AE8100, B963B7FD4E8300, B9C15807EE84F8, BA1EF8128E86F0, BA7C981D2E88E8, BADA5827CE8AE0, BB37F8326E8CE0, BB95983D0E8ED8, BBF33847AE90D0, BC50F8524E92C8, BCAE985CEE94C0, BD0C38678E96B8, BD69F8722E98B8, BDC7987CCE9AB0, BE2538876E9CA8, BE82D8920E9EA0, BEE0989CAEA098, BF3E38A74EA290, BF9BD8B1EEA490, BFF998BC92A688, C05738C732A880, C0B4D8D1D2AA78, C11278DC72AC70, C17038E712AE70, C1CDD8F1B2B068, C22B78FC52B260, C2893906F2B458, C2E6D91192B650, C344791C32B848, C3A21926D2BA40, C3FFD93172BC40, C45D793C12BE38, C4BB1946B2C030, C518D95152C228, C576795BF2C420, C5D4196692C620, C631B97132C818, C68F797BD2CA10, C6ED198672CC08, C74AB99112CE00, C7A8799BB2CFF8, C80619A652D1F8, C863B9B0F2D3F0, C8C159BB92D5E8, C91F19C632D7E0, C97CB9D0D2D9D8, C9DA59DB72DBD0, CA3819E612DDD0, CA95B9F0B2DFC8, CAF359FB52E1C0, CB50FA05F2E3B8, CBAEBA1092E5B0, CC0C5A1B32E7B0, CC69FA25D2E9A8, CCC79A3072EBA0, CD255A3B12ED98, CD82FA45B2EF90, CDE09A5052F188, CE3E5A5AF6F380, CE9BFA6596F580, CEF99A7036F778, CF573A7AD6F970, CFB4FA8576FB68, D0129A9016FD60, D0703A9AB6FF60, D0CDFAA5570158, D12B9AAFF70350, D1893ABA970548, D1E6DAC5370740, D2449ACFD70938, D2A23ADA770B38, D2FFDAE5170D30, D35D9AEFB70F28, D3BB3AFA571120, D418DB04F71318, D4767B0F971510, D4D43B1A371710, D531DB24D71908, D58F7B2F771B00, D5ED3B3A171CF8, D64ADB44B71EF0, D6A87B4F5720F0, D7061B59F722E8, D763DB649724E0, D7C17B6F3726D8, D81F1B79D728D0, D87CDB84772AC8, D8DA7B8F172CC0, D9381B99B72EC0, D995BBA45730B8, D9F37BAEF732B0, DA511BB99734A8, DAAEBBC43736A0, DB0C5BCED738A0, DB6A1BD9773A98, DBC7BBE4173C90, DC255BEEB73E88, DC831BF95B4080, DCE0BC03FB4278, DD3E5C0E9B4478, DD9BFC193B4670, DDF9BC23DB4868, DE575C2E7B4A60, DEB4FC391B4C58, DF12BC43BB4E50, DF705C4E5B5050, DFCDFC58FB5248, E02B9C639B5440, E0895C6E3B5638, E0E6FC78DB5830, E1449C837B5A30, E1A25C8E1B5C28, E1FFFC98BB5E20, E25D9CA35B6018, E2BB3CADFB6210, E318FCB89B6408, E3769CC33B6600, E3D43CCDDB6800, E431FCD87B69F8, E48F9CE31B6BF0, E4ED3CEDBB6DE8, E54ADCF85B6FE0, E5A89D02FB71E0, E6063D0D9B73D8, E663DD183B75D0, E6C19D22DB77C8, E71F3D2D7B79C0, E77CDD381B7BB8, E7DA7D42BB7DB8, E8383D4D5B7FB0, E895DD57FB81A8, E8F37D629B83A0, E9511D6D3B8598, E9AEDD77DB8790, EA0C7D827B8990, EA6A1D8D1B8B88, EAC7DD97BF8D80, EB257DA25F8F78, EB831DACFF9170, EBE0BDB79F9370, EC3E7DC23F9568, EC9C1DCCDF9760, ECF9BDD77F9958, ED577DE21F9B50, EDB51DECBF9D48, EE12BDF75F9F40, EE705E01FFA140, EECE1E0C9FA338, EF2BBE173FA530, EF895E21DFA728, EFE71E2C7FA920, F044BE371FAB20, F0A25E41BFAD18, F0FFFE4C5FAF10, F15DBE56FFB108, F1BB5E619FB300, F218FE6C3FB500, F276BE76DFB6F8, F2D45E817FB8F0, F331FE8C1FBAE8, F38F9E96BFBCE0, F3ED5EA15FBED8, F44AFEABFFC0D0, F4A89EB69FC2D0, F5065EC13FC4C8, F563FECBDFC6C0, F5C19ED67FC8B8, F61F3EE11FCAB0, F67CFEEBBFCCB0, F6DA9EF65FCEA8, F7383F00FFD0A0, F795FF0B9FD298, F7F39F163FD490, F8513F20DFD688, F8AEDF2B7FD880, F90C9F3623DA80, F96A3F40C3DC78, F9C7DF4B63DE70, FA257F5603E068, FA833F60A3E260, FAE0DF6B43E460, FB3E7F75E3E658, FB9C3F8083E850, FBF9DF8B23EA48, FC577F95C3EC40, FCB51FA063EE40, FD12DFAB03F038, FD707FB5A3F230, FDCE1FC043F428, FE2BDFCAE3F620, FE897FD583F818, FEE71FE023FA10, FF44BFEAC3FC10, FFA27FF563FE08;',
    '
]',
    'CSET collision_warnings = ALL',
    'CSET disable_collision_warnings = false',
    'CSET ecc = false',
    'CSET enable_a = Use_ENA_Pin',
    'CSET enable_b = Always_Enabled',
    'CSET error_injection_type = Single_Bit_Error_Injection',
    'CSET fill_remaining_memory_locations = false',
    'CSET load_init_file = TRUE',
    'CSET memory_type = Single_Port_ROM',
    'CSET operating_mode_a = WRITE_FIRST',
    'CSET operating_mode_b = WRITE_FIRST',
    'CSET output_reset_value_a = 0',
    'CSET output_reset_value_b = 0',
    'CSET pipeline_stages = 0',
    'CSET primitive = 8kx2',
    'CSET read_width_a = 56',
    'CSET read_width_b = 56',
    'CSET register_porta_output_of_memory_core = false',
    'CSET register_porta_output_of_memory_primitives = true',
    'CSET register_portb_output_of_memory_core = false',
    'CSET register_portb_output_of_memory_primitives = false',
    'CSET remaining_memory_locations = 0',
    'CSET reset_type = SYNC',
    'CSET use_byte_write_enable = false',
    'CSET use_error_injection_pins = false',
    'CSET use_regcea_pin = false',
    'CSET use_regceb_pin = false',
    'CSET use_rsta_pin = false',
    'CSET use_rstb_pin = false',
    'CSET write_depth_a = 512',
    'CSET write_width_a = 56',
    'CSET write_width_b = 56',
    'CSET component_name = bmg_72_a3b5d83d934b45b5',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => '784428d9cb190812de50f86d52f37493',
    'sourceFile' => 'hdl/xlsprom.v',
    'templateKeyValues' => {
      'core_instance_text' => '    .addra(core_addr),
    .clka(clk),
    .ena(core_ce),
    .douta(core_data_out)',
      'core_name0' => 'bmg_72_a3b5d83d934b45b5',
      'entityName' => 'xlsprom_duc_16ch_341',
      'entity_name.0' => 'xlsprom',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = [
    'SELECT Distributed_Memory_Generator kintex7 Xilinx,_Inc. 7.2',
    '# 14.5_P.55',
    '# DEVICE kintex7',
    '# VERILOG',
    'CSET ce_overrides = sync_controls_overrides_ce',
    'CSET coefficient_file = [
',
    '  MEMORY_INITIALIZATION_RADIX = 16;',
    '  MEMORY_INITIALIZATION_VECTOR = 0, 300A04, 601608, 90200C, B82A10, E83614, 1184018, 1484A1C, 1785620, 1A86024, 1D86A27, 200742B, 230802F, 2608A33, 2909437, 2C0A03B, 2F0AA3F, 320B443, 348C047, 378CA4B, 3A8D44F, 3D8E053, 408EA57, 438F45B, 461005F, 4910A63, 4C11467, 4F11E6B, 5212A6F, 5513473, 5813E76, 5A94A7A, 5D9547E, 6095E82, 6396A86, 669748A, 6997E8E, 6C98A92, 6F19496, 7219E9A, 751AA9E, 781B4A2, 7B1BEA6, 7E1C8AA, 811D4AE, 839DEB2, 869E8B6, 899F4BA, 8C9FEBE, 8FA08C1, 92A14C5, 95A1EC9, 98228CD, 9B234D1, 9E23ED5, A1248D9, A4254DD, A725EE1, AA268E5, ACA72E9, AFA7EED, B2A88F1, B5A92F5, B8A9EF9, BBAA8FD, BE2B301, C12BF05, C42C909, C72D30C, CA2DF10, CD2E914, D02F318, D2AFF1C, D5B0920, D8B1324, DBB1D28, DEB292C, E1B3330, E4B3D34, E734938, EA3533C, ED35D40, F036944, F337348, F637D4C, F938950, FBB9354, FEB9D58, 101BA95B, 104BB35F, 107BBD63, 10ABC767, 10DBD36B, 1103DD6F, 1133E773, 1163F377, 1193FD7B, 11C4077F, 11F41383, 12241D87, 124C278B, 127C338F, 12AC3D93, 12DC4797, 130C539B, 133C5D9F, 136467A3, 139471A6, 13C47DAA, 13F487AE, 142491B2, 14549DB6, 1484A7BA, 14ACB1BE, 14DCBDC2, 150CC7C6, 153CD1CA, 156CDDCE, 159CE7D2, 15CCF1D6, 15F4FDDA, 162507DE, 165511E2, 16851BE6, 16B527EA, 16E531EE, 17153BF1, 173D47F5;',
    '
]',
    'CSET common_output_ce = false',
    'CSET common_output_clk = false',
    'CSET data_width = 29',
    'CSET default_data = 0',
    'CSET default_data_radix = 16',
    'CSET depth = 128',
    'CSET dual_port_address = non_registered',
    'CSET dual_port_output_clock_enable = false',
    'CSET input_clock_enable = false',
    'CSET input_options = non_registered',
    'CSET memory_type = rom',
    'CSET output_options = registered',
    'CSET qualify_we_with_i_ce = false',
    'CSET reset_qdpo = false',
    'CSET reset_qspo = false',
    'CSET single_port_output_clock_enable = true',
    'CSET sync_reset_qdpo = false',
    'CSET sync_reset_qspo = false',
    'CSET component_name = dmg_72_9651f078ad2c9f1b',
    'GENERATE',
  ];
  push(@$results, &SgGenerateCores::saveXcoSequence($instrs));
  $instrs = {
    'entity_declaration_hash' => 'cecd94981c854376091e7625d040223c',
    'sourceFile' => 'hdl/xlsprom_dist.v',
    'templateKeyValues' => {
      'core_instance_text' => '         .a(core_addr),
        .clk(clk),
        .qspo_ce(core_ce),
        .qspo(core_data_out)',
      'core_name0' => 'dmg_72_9651f078ad2c9f1b',
      'entityName' => 'xlsprom_dist_duc_16ch_341',
      'entity_name.0' => 'xlsprom_dist',
      'needs_core' => 1,
      'vivado_flow' => 0,
    },
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'd451469838bcf7ea9d0bfaef16a98066',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(11 - 1):0] input_port,
  output [(11 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(11 - 1):0] input_port_1_40;
  wire signed [(11 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_7fc77e4dea',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'f6e7d6b10dbeb154d5080ee43e5879c8',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] input_port,
  output [(19 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire [(19 - 1):0] input_port_1_40;
  wire signed [(19 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule
',
      'entity_name' => 'reinterpret_888f8372ca',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '856ba016d40afa851667fcda5a4413a6',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '684e44340d71372a68b5c59c08545c8f',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a899b03172b4751239e2a319cadde10e',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '7456ce73be61d5b88c95a67173b74d97',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '95372be1dae649fd02d7c490779ba903',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '3eedcd66e98f7246307db9acb5cd9785',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlslice.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'ffacac0acc21a8b0d51d55b3fce0da7b',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  wire signed [(26 - 1):0] cast_internal_ip_27_3_rsh;
  wire signed [(19 - 1):0] cast_internal_ip_36_3_convert;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign cast_internal_ip_27_3_rsh = {{7{ip_1_23[18]}}, ip_1_23[18:0]};
  assign cast_internal_ip_36_3_convert = {{1{cast_internal_ip_27_3_rsh[25]}}, cast_internal_ip_27_3_rsh[25:8]};
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = cast_internal_ip_36_3_convert;
endmodule
',
      'entity_name' => 'shift_ca62c0bb60',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => 'a53e34d33b6c035ab1220d9b5dd69253',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  input [(19 - 1):0] ip,
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(19 - 1):0] ip_1_23;
  localparam signed [(19 - 1):0] const_value = 19\'sb0000000000000000000;
  reg signed [(19 - 1):0] op_mem_46_20[0:(1 - 1)];
  initial
    begin
      op_mem_46_20[0] = 19\'b0000000000000000000;
    end
  wire signed [(19 - 1):0] op_mem_46_20_front_din;
  wire signed [(19 - 1):0] op_mem_46_20_back;
  wire op_mem_46_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1\'b1;
  assign ip_1_23 = ip;
  assign op_mem_46_20_back = op_mem_46_20[0];
  always @(posedge clk)
    begin:proc_op_mem_46_20
      integer i;
      if (((ce == 1\'b1) && (op_mem_46_20_push_front_pop_back_en == 1\'b1)))
        begin
          op_mem_46_20[0] <= op_mem_46_20_front_din;
        end
    end
  assign op_mem_46_20_push_front_pop_back_en = 1\'b0;
  assign op = ip_1_23;
endmodule
',
      'entity_name' => 'shift_c01ac94bc0',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '7933280dd7908adafc9360f2cf6431d2',
    'sourceFile' => 'hdl/xlmcode.v',
    'templateKeyValues' => {
      'crippled_module' => '(
  output [(19 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 19\'b0000000000000000011;
endmodule
',
      'entity_name' => 'constant_c3c0af03bb',
    },
  };
  push(@$results, &SgDeliverFile::deliverFile($instrs));
  $instrs = {
    'entity_declaration_hash' => '3d548a366087cc80f8ef65eb1ab1d2d5',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xlconvert.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '64ded4a438854f27b10985ac62cfebcf',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '8bb6e0bdc3d71d473e385c385bf12d51',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'e913b93500037fed754cf4dbc292c68b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '9d599fa158940a46520be6038010b8ce',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => 'b22812b73537539922af21013cd49c39',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '400639ea689db5209e73e79e38069afa',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '1b3814d19fbd5a4fbb008c9fec9ff70a',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  $instrs = {
    'entity_declaration_hash' => '0adec825bdcb92421eada9b8a5b4093b',
    'sourceFile' => 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen/hdl/xldelay.v',
  };
  push(@$results, &SgDeliverFile::saveCollaborationInfo($instrs));
  local *wrapup = $Sg::{'wrapup'};
  push(@$results, &Sg::wrapup())   if (defined(&wrapup));
  local *wrapup = $SgDeliverFile::{'wrapup'};
  push(@$results, &SgDeliverFile::wrapup())   if (defined(&wrapup));
  local *wrapup = $SgGenerateCores::{'wrapup'};
  push(@$results, &SgGenerateCores::wrapup())   if (defined(&wrapup));
  use Carp qw(croak);
  $ENV{'SYSGEN'} = 'D:/Xilinx/14.5/ISE_DS/ISE/sysgen';
  open(RESULTS, '> E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421') || 
    croak 'couldn\'t open E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421';
  binmode(RESULTS);
  print RESULTS &Sg::toString($results) . "\n";
  close(RESULTS) || 
    croak 'trouble writing E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421';
};

if ($@) {
  open(RESULTS, '> E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421') || 
    croak 'couldn\'t open E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421';
  binmode(RESULTS);
  print RESULTS $@ . "\n";
  close(RESULTS) || 
    croak 'trouble writing E:/Data/Design/duc_note/duc_16ch_sg/sysgen/script_results6049788640458741421';
  exit(1);
}

exit(0);
