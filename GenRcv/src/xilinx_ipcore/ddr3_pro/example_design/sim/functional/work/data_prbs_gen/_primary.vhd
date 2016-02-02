library verilog;
use verilog.vl_types.all;
entity data_prbs_gen is
    generic(
        TCQ             : integer := 100;
        EYE_TEST        : string  := "FALSE";
        PRBS_WIDTH      : integer := 32;
        SEED_WIDTH      : integer := 32
    );
    port(
        clk_i           : in     vl_logic;
        clk_en          : in     vl_logic;
        rst_i           : in     vl_logic;
        prbs_fseed_i    : in     vl_logic_vector(31 downto 0);
        prbs_seed_init  : in     vl_logic;
        prbs_seed_i     : in     vl_logic_vector;
        prbs_o          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of EYE_TEST : constant is 1;
    attribute mti_svvh_generic_type of PRBS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SEED_WIDTH : constant is 1;
end data_prbs_gen;
