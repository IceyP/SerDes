library verilog;
use verilog.vl_types.all;
entity example_top is
    generic(
        C1_P0_MASK_SIZE : integer := 16;
        C1_P0_DATA_PORT_SIZE: integer := 128;
        DEBUG_EN        : integer := 0;
        C1_MEMCLK_PERIOD: integer := 3000;
        C1_CALIB_SOFT_IP: string  := "TRUE";
        C1_SIMULATION   : string  := "FALSE";
        C1_HW_TESTING   : string  := "FALSE";
        C1_RST_ACT_LOW  : integer := 0;
        C1_INPUT_CLK_TYPE: string  := "SINGLE_ENDED";
        C1_MEM_ADDR_ORDER: string  := "BANK_ROW_COLUMN";
        C1_NUM_DQ_PINS  : integer := 16;
        C1_MEM_ADDR_WIDTH: integer := 14;
        C1_MEM_BANKADDR_WIDTH: integer := 3
    );
    port(
        calib_done      : out    vl_logic;
        error           : out    vl_logic;
        mcb1_dram_dq    : inout  vl_logic_vector;
        mcb1_dram_a     : out    vl_logic_vector;
        mcb1_dram_ba    : out    vl_logic_vector;
        mcb1_dram_ras_n : out    vl_logic;
        mcb1_dram_cas_n : out    vl_logic;
        mcb1_dram_we_n  : out    vl_logic;
        mcb1_dram_odt   : out    vl_logic;
        mcb1_dram_reset_n: out    vl_logic;
        mcb1_dram_cke   : out    vl_logic;
        mcb1_dram_dm    : out    vl_logic;
        mcb1_dram_udqs  : inout  vl_logic;
        mcb1_dram_udqs_n: inout  vl_logic;
        mcb1_rzq        : inout  vl_logic;
        mcb1_zio        : inout  vl_logic;
        mcb1_dram_udm   : out    vl_logic;
        c1_sys_clk      : in     vl_logic;
        c1_sys_rst_i    : in     vl_logic;
        mcb1_dram_dqs   : inout  vl_logic;
        mcb1_dram_dqs_n : inout  vl_logic;
        mcb1_dram_ck    : out    vl_logic;
        mcb1_dram_ck_n  : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C1_P0_MASK_SIZE : constant is 1;
    attribute mti_svvh_generic_type of C1_P0_DATA_PORT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of DEBUG_EN : constant is 1;
    attribute mti_svvh_generic_type of C1_MEMCLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of C1_CALIB_SOFT_IP : constant is 1;
    attribute mti_svvh_generic_type of C1_SIMULATION : constant is 1;
    attribute mti_svvh_generic_type of C1_HW_TESTING : constant is 1;
    attribute mti_svvh_generic_type of C1_RST_ACT_LOW : constant is 1;
    attribute mti_svvh_generic_type of C1_INPUT_CLK_TYPE : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_ADDR_ORDER : constant is 1;
    attribute mti_svvh_generic_type of C1_NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C1_MEM_BANKADDR_WIDTH : constant is 1;
end example_top;
