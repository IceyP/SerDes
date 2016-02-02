#
# Created by System Generator     Wed Apr 24 14:03:56 2013
#
# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator.
#

namespace eval ::xilinx::dsptool::iseproject::param {
    set SynthStrategyName {XST Defaults*}
    set ImplStrategyName {ISE Defaults*}
    set Compilation {HDL Netlist}
    set Project {duc_16ch_341_cw}
    set DSPFamily {Kintex7}
    set DSPDevice {xc7k160t}
    set DSPPackage {ffg676}
    set DSPSpeed {-2}
    set HDLLanguage {verilog}
    set SynthesisTool {XST}
    set Simulator {Modelsim-SE}
    set ReadCores {False}
    set MapEffortLevel {High}
    set ParEffortLevel {High}
    set Frequency {341.413451689997}
    set CreateInterfaceDocument {off}
    set NewXSTParser {1}
	if { [ string equal $Compilation {IP Packager} ] == 1 } {
		set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
		set IP_Library_Text {SysGen}
		set IP_Vendor_Text {Xilinx}
		set IP_Version_Text {1.0}
		set IP_Categories_Text {System Generator for DSP}
		set IP_Common_Repos {0}
		set IP_Dir {}
		set IP_LifeCycle_Menu {1}
		set IP_Description    {}
		
	}
    set ProjectFiles {
        {{duc_16ch_341_cw.v} -view All}
        {{duc_16ch_341.v} -view All}
        {{duc_16ch_341_cw.ucf}}
        {{duc_16ch_341_cw.xdc}}
        {{bmg_72_0b6075e08c22268d.mif}}
        {{bmg_72_2f2b227d5258d685.mif}}
        {{bmg_72_5fc6d969158b1ced.mif}}
        {{bmg_72_88bd69a7e506f2a2.mif}}
        {{bmg_72_9cba7eb6526fc26f.mif}}
        {{bmg_72_a3b5d83d934b45b5.mif}}
        {{bmg_72_b297e10d233cb875.mif}}
        {{bmg_72_c0e7027c8d56f068.mif}}
        {{bmg_72_e18a8bcda58a41cd.mif}}
        {{dmg_72_1c9994abe91d1da0.mif}}
        {{dmg_72_2828f053f6c73e1f.mif}}
        {{dmg_72_53c8fda674a6c63d.mif}}
        {{dmg_72_85ef246b9b71061d.mif}}
        {{dmg_72_903d17a1900ee539.mif}}
        {{dmg_72_9651f078ad2c9f1b.mif}}
        {{dmg_72_9ec52875c6eb4958.mif}}
        {{dmg_72_b01799b9bf71bdc0.mif}}
        {{dmg_72_e9661fc0e9eb3e90.mif}}
        {{dmg_72_f25cd80cb6ee82df.mif}}
        {{E:\Data\Design\duc_note\duc_16ch_341.mdl}}
    }
    set TopLevelModule {duc_16ch_341_cw}
    set SynthesisConstraintsFile {duc_16ch_341_cw.xcf}
    set ImplementationStopView {Structural}
    set ProjectGenerator {SysgenDSP}
}
    source SgIseProject.tcl
    ::xilinx::dsptool::iseproject::create
