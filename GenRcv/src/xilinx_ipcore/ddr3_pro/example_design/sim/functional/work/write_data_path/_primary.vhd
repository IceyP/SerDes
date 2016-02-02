library verilog;
use verilog.vl_types.all;
entity write_data_path is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6";
        ADDR_WIDTH      : integer := 32;
        MEM_BURST_LEN   : integer := 8;
        DWIDTH          : integer := 32;
        DATA_PATTERN    : string  := "DGEN_ALL";
        NUM_DQ_PINS     : integer := 8;
        SEL_VICTIM_LINE : integer := 3;
        MEM_COL_WIDTH   : integer := 10;
        EYE_TEST        : string  := "FALSE"
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic_vector(9 downto 0);
        cmd_rdy_o       : out    vl_logic;
        cmd_valid_i     : in     vl_logic;
        cmd_validB_i    : in     vl_logic;
        cmd_validC_i    : in     vl_logic;
        prbs_fseed_i    : in     vl_logic_vector(31 downto 0);
        data_mode_i     : in     vl_logic_vector(3 downto 0);
        fixed_data_i    : in     vl_logic_vector;
        addr_i          : in     vl_logic_vector(31 downto 0);
        bl_i            : in     vl_logic_vector(5 downto 0);
        data_rdy_i      : in     vl_logic;
        data_valid_o    : out    vl_logic;
        last_word_wr_o  : out    vl_logic;
        data_o          : out    vl_logic_vector;
        data_mask_o     : out    vl_logic_vector;
        data_wr_end_o   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of SEL_VICTIM_LINE : constant is 1;
    attribute mti_svvh_generic_type of MEM_COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of EYE_TEST : constant is 1;
end write_data_path;
