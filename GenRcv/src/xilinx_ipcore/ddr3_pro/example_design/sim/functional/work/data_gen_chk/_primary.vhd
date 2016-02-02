library verilog;
use verilog.vl_types.all;
entity data_gen_chk is
    generic(
        C_AXI_DATA_WIDTH: integer := 32
    );
    port(
        clk             : in     vl_logic;
        data_en         : in     vl_logic;
        data_pattern    : in     vl_logic_vector(2 downto 0);
        pattern_init    : in     vl_logic;
        prbs_seed_i     : in     vl_logic_vector(31 downto 0);
        rdata           : in     vl_logic_vector;
        rdata_bvld      : in     vl_logic_vector;
        rdata_vld       : in     vl_logic;
        wrd_cntr_rst    : in     vl_logic;
        msmatch_err     : out    vl_logic;
        wrd_cntr        : out    vl_logic_vector(7 downto 0);
        data_o          : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C_AXI_DATA_WIDTH : constant is 1;
end data_gen_chk;
