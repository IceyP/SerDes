library verilog;
use verilog.vl_types.all;
entity cmd_prbs_gen is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6";
        ADDR_WIDTH      : integer := 29;
        DWIDTH          : integer := 32;
        PRBS_CMD        : string  := "ADDRESS";
        PRBS_WIDTH      : integer := 64;
        SEED_WIDTH      : integer := 32;
        PRBS_EADDR_MASK_POS: vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        PRBS_SADDR_MASK_POS: integer := 8192;
        PRBS_EADDR      : integer := 8192;
        PRBS_SADDR      : integer := 8192
    );
    port(
        clk_i           : in     vl_logic;
        prbs_seed_init  : in     vl_logic;
        clk_en          : in     vl_logic;
        prbs_seed_i     : in     vl_logic_vector;
        prbs_o          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of PRBS_CMD : constant is 1;
    attribute mti_svvh_generic_type of PRBS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SEED_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of PRBS_EADDR_MASK_POS : constant is 1;
    attribute mti_svvh_generic_type of PRBS_SADDR_MASK_POS : constant is 1;
    attribute mti_svvh_generic_type of PRBS_EADDR : constant is 1;
    attribute mti_svvh_generic_type of PRBS_SADDR : constant is 1;
end cmd_prbs_gen;
