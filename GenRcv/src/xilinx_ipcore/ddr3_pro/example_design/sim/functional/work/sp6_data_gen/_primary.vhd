library verilog;
use verilog.vl_types.all;
entity sp6_data_gen is
    generic(
        TCQ             : integer := 100;
        ADDR_WIDTH      : integer := 32;
        BL_WIDTH        : integer := 6;
        DWIDTH          : integer := 32;
        DATA_PATTERN    : string  := "DGEN_ALL";
        NUM_DQ_PINS     : integer := 8;
        COLUMN_WIDTH    : integer := 10
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
        fixed_data_i    : in     vl_logic_vector;
        addr_i          : in     vl_logic_vector;
        user_burst_cnt  : in     vl_logic_vector(6 downto 0);
        fifo_rdy_i      : in     vl_logic;
        data_o          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of COLUMN_WIDTH : constant is 1;
end sp6_data_gen;
