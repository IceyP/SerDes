library verilog;
use verilog.vl_types.all;
entity read_data_path is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "VIRTEX6";
        MEM_BURST_LEN   : integer := 8;
        ADDR_WIDTH      : integer := 32;
        CMP_DATA_PIPE_STAGES: integer := 3;
        DWIDTH          : integer := 32;
        DATA_PATTERN    : string  := "DGEN_ALL";
        NUM_DQ_PINS     : integer := 8;
        DQ_ERROR_WIDTH  : integer := 1;
        SEL_VICTIM_LINE : integer := 3;
        MEM_COL_WIDTH   : integer := 10
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic_vector(9 downto 0);
        manual_clear_error: in     vl_logic;
        cmd_rdy_o       : out    vl_logic;
        cmd_valid_i     : in     vl_logic;
        prbs_fseed_i    : in     vl_logic_vector(31 downto 0);
        data_mode_i     : in     vl_logic_vector(3 downto 0);
        cmd_sent        : in     vl_logic_vector(2 downto 0);
        bl_sent         : in     vl_logic_vector(5 downto 0);
        cmd_en_i        : in     vl_logic;
        fixed_data_i    : in     vl_logic_vector;
        addr_i          : in     vl_logic_vector(31 downto 0);
        bl_i            : in     vl_logic_vector(5 downto 0);
        data_rdy_o      : out    vl_logic;
        data_valid_i    : in     vl_logic;
        data_i          : in     vl_logic_vector;
        last_word_rd_o  : out    vl_logic;
        data_error_o    : out    vl_logic;
        cmp_data_o      : out    vl_logic_vector;
        rd_mdata_o      : out    vl_logic_vector;
        cmp_data_valid  : out    vl_logic;
        cmp_addr_o      : out    vl_logic_vector(31 downto 0);
        cmp_bl_o        : out    vl_logic_vector(5 downto 0);
        force_wrcmd_gen_o: out    vl_logic;
        rd_buff_avail_o : out    vl_logic_vector(6 downto 0);
        dq_error_bytelane_cmp: out    vl_logic_vector;
        cumlative_dq_lane_error_r: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CMP_DATA_PIPE_STAGES : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_PATTERN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DQ_PINS : constant is 1;
    attribute mti_svvh_generic_type of DQ_ERROR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SEL_VICTIM_LINE : constant is 1;
    attribute mti_svvh_generic_type of MEM_COL_WIDTH : constant is 1;
end read_data_path;
