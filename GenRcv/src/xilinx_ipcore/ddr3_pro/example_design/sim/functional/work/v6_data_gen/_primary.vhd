library verilog;
use verilog.vl_types.all;
entity v6_data_gen is
    generic(
        TCQ             : integer := 100;
        EYE_TEST        : string  := "FALSE";
        ADDR_WIDTH      : integer := 32;
        MEM_BURST_LEN   : integer := 8;
        BL_WIDTH        : integer := 6;
        DWIDTH          : integer := 32;
        DATA_PATTERN    : string  := "DGEN_ALL";
        NUM_DQ_PINS     : integer := 8;
        COLUMN_WIDTH    : integer := 10;
        SEL_VICTIM_LINE : integer := 3
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        prbs_fseed_i    : in     vl_logic_vector(31 downto 0);
        data_mode_i     : in     vl_logic_vector(3 downto 0);
        data_rdy_i      : in     vl_logic;
        cmd_startA      : in     vl_logic;
        cmd_startB      : in     vl_logic;
        cmd_startC      : in     vl_logic;
        cmd_startD      : in     vl_logic;
        cmd_startE      : in     vl_logic;
        m_addr_i        : in     vl_logic_vector;
        fixed_data_i    : in     vl_logic_vector;
        addr_i          : in     vl_logic_vector;
        user_burst_cnt  : in     vl_logic_vector(6 downto 0);
        fifo_rdy_i      : in     vl_logic;
        data_o          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of EYE_TEST : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of BL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of COLUMN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SEL_VICTIM_LINE : constant is 1;
end v6_data_gen;
