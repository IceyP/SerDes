library verilog;
use verilog.vl_types.all;
entity mcb_raw_wrapper is
    generic(
        C_MEMCLK_PERIOD : integer := 2500;
        C_PORT_ENABLE   : vl_logic_vector(0 to 5) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        C_MEM_ADDR_ORDER: string  := "BANK_ROW_COLUMN";
        C_USR_INTERFACE_MODE: string  := "NATIVE";
        C_ARB_NUM_TIME_SLOTS: integer := 12;
        C_ARB_TIME_SLOT_0: vl_logic_vector(0 to 17) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        C_ARB_TIME_SLOT_1: vl_logic_vector(0 to 17) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0);
        C_ARB_TIME_SLOT_2: vl_logic_vector(0 to 17) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        C_ARB_TIME_SLOT_3: vl_logic_vector(0 to 17) := (Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0);
        C_ARB_TIME_SLOT_4: vl_logic_vector(0 to 17) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1);
        C_ARB_TIME_SLOT_5: vl_logic_vector(0 to 17) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0);
        C_ARB_TIME_SLOT_6: vl_logic_vector(0 to 17) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        C_ARB_TIME_SLOT_7: vl_logic_vector(0 to 17) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0);
        C_ARB_TIME_SLOT_8: vl_logic_vector(0 to 17) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        C_ARB_TIME_SLOT_9: vl_logic_vector(0 to 17) := (Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0);
        C_ARB_TIME_SLOT_10: vl_logic_vector(0 to 17) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1);
        C_ARB_TIME_SLOT_11: vl_logic_vector(0 to 17) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0);
        C_PORT_CONFIG   : string  := "B128";
        C_MEM_TRAS      : integer := 45000;
        C_MEM_TRCD      : integer := 12500;
        C_MEM_TREFI     : integer := 7800;
        C_MEM_TRFC      : integer := 127500;
        C_MEM_TRP       : integer := 12500;
        C_MEM_TWR       : integer := 15000;
        C_MEM_TRTP      : integer := 7500;
        C_MEM_TWTR      : integer := 7500;
        C_NUM_DQ_PINS   : integer := 8;
        C_MEM_TYPE      : string  := "DDR3";
        C_MEM_DENSITY   : string  := "512M";
        C_MEM_BURST_LEN : integer := 8;
        C_MEM_CAS_LATENCY: integer := 4;
        C_MEM_ADDR_WIDTH: integer := 13;
        C_MEM_BANKADDR_WIDTH: integer := 3;
        C_MEM_NUM_COL_BITS: integer := 11;
        C_MEM_DDR3_CAS_LATENCY: integer := 7;
        C_MEM_MOBILE_PA_SR: string  := "FULL";
        C_MEM_DDR1_2_ODS: string  := "FULL";
        C_MEM_DDR3_ODS  : string  := "DIV6";
        C_MEM_DDR2_RTT  : string  := "50OHMS";
        C_MEM_DDR3_RTT  : string  := "DIV2";
        C_MEM_MDDR_ODS  : string  := "FULL";
        C_MEM_DDR2_DIFF_DQS_EN: string  := "YES";
        C_MEM_DDR2_3_PA_SR: string  := "OFF";
        C_MEM_DDR3_CAS_WR_LATENCY: integer := 5;
        C_MEM_DDR3_AUTO_SR: string  := "ENABLED";
        C_MEM_DDR2_3_HIGH_TEMP_SR: string  := "NORMAL";
        C_MEM_DDR3_DYN_WRT_ODT: string  := "OFF";
        C_MEM_TZQINIT_MAXCNT: vl_logic_vector(0 to 9) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        C_MC_CALIB_BYPASS: string  := "NO";
        C_MC_CALIBRATION_RA: vl_logic_vector(0 to 14) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        C_MC_CALIBRATION_BA: vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        C_CALIB_SOFT_IP : string  := "TRUE";
        C_SKIP_IN_TERM_CAL: vl_logic := Hi0;
        C_SKIP_DYNAMIC_CAL: vl_logic := Hi0;
        C_SKIP_DYN_IN_TERM: vl_logic := Hi1;
        C_SIMULATION    : string  := "FALSE";
        LDQSP_TAP_DELAY_VAL: integer := 0;
        UDQSP_TAP_DELAY_VAL: integer := 0;
        LDQSN_TAP_DELAY_VAL: integer := 0;
        UDQSN_TAP_DELAY_VAL: integer := 0;
        DQ0_TAP_DELAY_VAL: integer := 0;
        DQ1_TAP_DELAY_VAL: integer := 0;
        DQ2_TAP_DELAY_VAL: integer := 0;
        DQ3_TAP_DELAY_VAL: integer := 0;
        DQ4_TAP_DELAY_VAL: integer := 0;
        DQ5_TAP_DELAY_VAL: integer := 0;
        DQ6_TAP_DELAY_VAL: integer := 0;
        DQ7_TAP_DELAY_VAL: integer := 0;
        DQ8_TAP_DELAY_VAL: integer := 0;
        DQ9_TAP_DELAY_VAL: integer := 0;
        DQ10_TAP_DELAY_VAL: integer := 0;
        DQ11_TAP_DELAY_VAL: integer := 0;
        DQ12_TAP_DELAY_VAL: integer := 0;
        DQ13_TAP_DELAY_VAL: integer := 0;
        DQ14_TAP_DELAY_VAL: integer := 0;
        DQ15_TAP_DELAY_VAL: integer := 0;
        C_MC_CALIBRATION_CA: vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        C_MC_CALIBRATION_CLK_DIV: integer := 1;
        C_MC_CALIBRATION_MODE: string  := "CALIBRATION";
        C_MC_CALIBRATION_DELAY: string  := "HALF";
        C_P0_MASK_SIZE  : integer := 4;
        C_P0_DATA_PORT_SIZE: integer := 32;
        C_P1_MASK_SIZE  : integer := 4;
        C_P1_DATA_PORT_SIZE: integer := 32
    );
    port(
        sysclk_2x       : in     vl_logic;
        sysclk_2x_180   : in     vl_logic;
        pll_ce_0        : in     vl_logic;
        pll_ce_90       : in     vl_logic;
        pll_lock        : in     vl_logic;
        sys_rst         : in     vl_logic;
        p0_arb_en       : in     vl_logic;
        p0_cmd_clk      : in     vl_logic;
        p0_cmd_en       : in     vl_logic;
        p0_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p0_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p0_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p0_cmd_empty    : out    vl_logic;
        p0_cmd_full     : out    vl_logic;
        p0_wr_clk       : in     vl_logic;
        p0_wr_en        : in     vl_logic;
        p0_wr_mask      : in     vl_logic_vector;
        p0_wr_data      : in     vl_logic_vector;
        p0_wr_full      : out    vl_logic;
        p0_wr_empty     : out    vl_logic;
        p0_wr_count     : out    vl_logic_vector(6 downto 0);
        p0_wr_underrun  : out    vl_logic;
        p0_wr_error     : out    vl_logic;
        p0_rd_clk       : in     vl_logic;
        p0_rd_en        : in     vl_logic;
        p0_rd_data      : out    vl_logic_vector;
        p0_rd_full      : out    vl_logic;
        p0_rd_empty     : out    vl_logic;
        p0_rd_count     : out    vl_logic_vector(6 downto 0);
        p0_rd_overflow  : out    vl_logic;
        p0_rd_error     : out    vl_logic;
        p1_arb_en       : in     vl_logic;
        p1_cmd_clk      : in     vl_logic;
        p1_cmd_en       : in     vl_logic;
        p1_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p1_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p1_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p1_cmd_empty    : out    vl_logic;
        p1_cmd_full     : out    vl_logic;
        p1_wr_clk       : in     vl_logic;
        p1_wr_en        : in     vl_logic;
        p1_wr_mask      : in     vl_logic_vector;
        p1_wr_data      : in     vl_logic_vector;
        p1_wr_full      : out    vl_logic;
        p1_wr_empty     : out    vl_logic;
        p1_wr_count     : out    vl_logic_vector(6 downto 0);
        p1_wr_underrun  : out    vl_logic;
        p1_wr_error     : out    vl_logic;
        p1_rd_clk       : in     vl_logic;
        p1_rd_en        : in     vl_logic;
        p1_rd_data      : out    vl_logic_vector;
        p1_rd_full      : out    vl_logic;
        p1_rd_empty     : out    vl_logic;
        p1_rd_count     : out    vl_logic_vector(6 downto 0);
        p1_rd_overflow  : out    vl_logic;
        p1_rd_error     : out    vl_logic;
        p2_arb_en       : in     vl_logic;
        p2_cmd_clk      : in     vl_logic;
        p2_cmd_en       : in     vl_logic;
        p2_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p2_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p2_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p2_cmd_empty    : out    vl_logic;
        p2_cmd_full     : out    vl_logic;
        p2_wr_clk       : in     vl_logic;
        p2_wr_en        : in     vl_logic;
        p2_wr_mask      : in     vl_logic_vector(3 downto 0);
        p2_wr_data      : in     vl_logic_vector(31 downto 0);
        p2_wr_full      : out    vl_logic;
        p2_wr_empty     : out    vl_logic;
        p2_wr_count     : out    vl_logic_vector(6 downto 0);
        p2_wr_underrun  : out    vl_logic;
        p2_wr_error     : out    vl_logic;
        p2_rd_clk       : in     vl_logic;
        p2_rd_en        : in     vl_logic;
        p2_rd_data      : out    vl_logic_vector(31 downto 0);
        p2_rd_full      : out    vl_logic;
        p2_rd_empty     : out    vl_logic;
        p2_rd_count     : out    vl_logic_vector(6 downto 0);
        p2_rd_overflow  : out    vl_logic;
        p2_rd_error     : out    vl_logic;
        p3_arb_en       : in     vl_logic;
        p3_cmd_clk      : in     vl_logic;
        p3_cmd_en       : in     vl_logic;
        p3_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p3_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p3_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p3_cmd_empty    : out    vl_logic;
        p3_cmd_full     : out    vl_logic;
        p3_wr_clk       : in     vl_logic;
        p3_wr_en        : in     vl_logic;
        p3_wr_mask      : in     vl_logic_vector(3 downto 0);
        p3_wr_data      : in     vl_logic_vector(31 downto 0);
        p3_wr_full      : out    vl_logic;
        p3_wr_empty     : out    vl_logic;
        p3_wr_count     : out    vl_logic_vector(6 downto 0);
        p3_wr_underrun  : out    vl_logic;
        p3_wr_error     : out    vl_logic;
        p3_rd_clk       : in     vl_logic;
        p3_rd_en        : in     vl_logic;
        p3_rd_data      : out    vl_logic_vector(31 downto 0);
        p3_rd_full      : out    vl_logic;
        p3_rd_empty     : out    vl_logic;
        p3_rd_count     : out    vl_logic_vector(6 downto 0);
        p3_rd_overflow  : out    vl_logic;
        p3_rd_error     : out    vl_logic;
        p4_arb_en       : in     vl_logic;
        p4_cmd_clk      : in     vl_logic;
        p4_cmd_en       : in     vl_logic;
        p4_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p4_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p4_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p4_cmd_empty    : out    vl_logic;
        p4_cmd_full     : out    vl_logic;
        p4_wr_clk       : in     vl_logic;
        p4_wr_en        : in     vl_logic;
        p4_wr_mask      : in     vl_logic_vector(3 downto 0);
        p4_wr_data      : in     vl_logic_vector(31 downto 0);
        p4_wr_full      : out    vl_logic;
        p4_wr_empty     : out    vl_logic;
        p4_wr_count     : out    vl_logic_vector(6 downto 0);
        p4_wr_underrun  : out    vl_logic;
        p4_wr_error     : out    vl_logic;
        p4_rd_clk       : in     vl_logic;
        p4_rd_en        : in     vl_logic;
        p4_rd_data      : out    vl_logic_vector(31 downto 0);
        p4_rd_full      : out    vl_logic;
        p4_rd_empty     : out    vl_logic;
        p4_rd_count     : out    vl_logic_vector(6 downto 0);
        p4_rd_overflow  : out    vl_logic;
        p4_rd_error     : out    vl_logic;
        p5_arb_en       : in     vl_logic;
        p5_cmd_clk      : in     vl_logic;
        p5_cmd_en       : in     vl_logic;
        p5_cmd_instr    : in     vl_logic_vector(2 downto 0);
        p5_cmd_bl       : in     vl_logic_vector(5 downto 0);
        p5_cmd_byte_addr: in     vl_logic_vector(29 downto 0);
        p5_cmd_empty    : out    vl_logic;
        p5_cmd_full     : out    vl_logic;
        p5_wr_clk       : in     vl_logic;
        p5_wr_en        : in     vl_logic;
        p5_wr_mask      : in     vl_logic_vector(3 downto 0);
        p5_wr_data      : in     vl_logic_vector(31 downto 0);
        p5_wr_full      : out    vl_logic;
        p5_wr_empty     : out    vl_logic;
        p5_wr_count     : out    vl_logic_vector(6 downto 0);
        p5_wr_underrun  : out    vl_logic;
        p5_wr_error     : out    vl_logic;
        p5_rd_clk       : in     vl_logic;
        p5_rd_en        : in     vl_logic;
        p5_rd_data      : out    vl_logic_vector(31 downto 0);
        p5_rd_full      : out    vl_logic;
        p5_rd_empty     : out    vl_logic;
        p5_rd_count     : out    vl_logic_vector(6 downto 0);
        p5_rd_overflow  : out    vl_logic;
        p5_rd_error     : out    vl_logic;
        mcbx_dram_addr  : out    vl_logic_vector;
        mcbx_dram_ba    : out    vl_logic_vector;
        mcbx_dram_ras_n : out    vl_logic;
        mcbx_dram_cas_n : out    vl_logic;
        mcbx_dram_we_n  : out    vl_logic;
        mcbx_dram_cke   : out    vl_logic;
        mcbx_dram_clk   : out    vl_logic;
        mcbx_dram_clk_n : out    vl_logic;
        mcbx_dram_dq    : inout  vl_logic_vector;
        mcbx_dram_dqs   : inout  vl_logic;
        mcbx_dram_dqs_n : inout  vl_logic;
        mcbx_dram_udqs  : inout  vl_logic;
        mcbx_dram_udqs_n: inout  vl_logic;
        mcbx_dram_udm   : out    vl_logic;
        mcbx_dram_ldm   : out    vl_logic;
        mcbx_dram_odt   : out    vl_logic;
        mcbx_dram_ddr3_rst: out    vl_logic;
        calib_recal     : in     vl_logic;
        rzq             : inout  vl_logic;
        zio             : inout  vl_logic;
        ui_read         : in     vl_logic;
        ui_add          : in     vl_logic;
        ui_cs           : in     vl_logic;
        ui_clk          : in     vl_logic;
        ui_sdi          : in     vl_logic;
        ui_addr         : in     vl_logic_vector(4 downto 0);
        ui_broadcast    : in     vl_logic;
        ui_drp_update   : in     vl_logic;
        ui_done_cal     : in     vl_logic;
        ui_cmd          : in     vl_logic;
        ui_cmd_in       : in     vl_logic;
        ui_cmd_en       : in     vl_logic;
        ui_dqcount      : in     vl_logic_vector(3 downto 0);
        ui_dq_lower_dec : in     vl_logic;
        ui_dq_lower_inc : in     vl_logic;
        ui_dq_upper_dec : in     vl_logic;
        ui_dq_upper_inc : in     vl_logic;
        ui_udqs_inc     : in     vl_logic;
        ui_udqs_dec     : in     vl_logic;
        ui_ldqs_inc     : in     vl_logic;
        ui_ldqs_dec     : in     vl_logic;
        uo_data         : out    vl_logic_vector(7 downto 0);
        uo_data_valid   : out    vl_logic;
        uo_done_cal     : out    vl_logic;
        uo_cmd_ready_in : out    vl_logic;
        uo_refrsh_flag  : out    vl_logic;
        uo_cal_start    : out    vl_logic;
        uo_sdo          : out    vl_logic;
        status          : out    vl_logic_vector(31 downto 0);
        selfrefresh_enter: in     vl_logic;
        selfrefresh_mode: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C_MEMCLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of C_PORT_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_ADDR_ORDER : constant is 1;
    attribute mti_svvh_generic_type of C_USR_INTERFACE_MODE : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_NUM_TIME_SLOTS : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_0 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_1 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_2 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_3 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_4 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_5 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_6 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_7 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_8 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_9 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_10 : constant is 1;
    attribute mti_svvh_generic_type of C_ARB_TIME_SLOT_11 : constant is 1;
    attribute mti_svvh_generic_type of C_PORT_CONFIG : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TRAS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TRCD : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TREFI : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TRFC : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TRP : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TWR : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TRTP : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TWTR : constant is 1;
    attribute mti_svvh_generic_type of C_NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TYPE : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DENSITY : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_CAS_LATENCY : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_BANKADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_NUM_COL_BITS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_CAS_LATENCY : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_MOBILE_PA_SR : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR1_2_ODS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_ODS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR2_RTT : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_RTT : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_MDDR_ODS : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR2_DIFF_DQS_EN : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR2_3_PA_SR : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_CAS_WR_LATENCY : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_AUTO_SR : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR2_3_HIGH_TEMP_SR : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_DDR3_DYN_WRT_ODT : constant is 1;
    attribute mti_svvh_generic_type of C_MEM_TZQINIT_MAXCNT : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIB_BYPASS : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_RA : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_BA : constant is 1;
    attribute mti_svvh_generic_type of C_CALIB_SOFT_IP : constant is 1;
    attribute mti_svvh_generic_type of C_SKIP_IN_TERM_CAL : constant is 1;
    attribute mti_svvh_generic_type of C_SKIP_DYNAMIC_CAL : constant is 1;
    attribute mti_svvh_generic_type of C_SKIP_DYN_IN_TERM : constant is 1;
    attribute mti_svvh_generic_type of C_SIMULATION : constant is 1;
    attribute mti_svvh_generic_type of LDQSP_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of UDQSP_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of LDQSN_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of UDQSN_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ0_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ1_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ2_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ3_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ4_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ5_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ6_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ7_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ8_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ9_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ10_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ11_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ12_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ13_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ14_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQ15_TAP_DELAY_VAL : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_CA : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_CLK_DIV : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_MODE : constant is 1;
    attribute mti_svvh_generic_type of C_MC_CALIBRATION_DELAY : constant is 1;
    attribute mti_svvh_generic_type of C_P0_MASK_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C_P0_DATA_PORT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C_P1_MASK_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C_P1_DATA_PORT_SIZE : constant is 1;
end mcb_raw_wrapper;