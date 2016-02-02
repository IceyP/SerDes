library verilog;
use verilog.vl_types.all;
entity infrastructure is
    generic(
        C_INCLK_PERIOD  : integer := 2500;
        C_RST_ACT_LOW   : integer := 1;
        C_INPUT_CLK_TYPE: string  := "DIFFERENTIAL";
        C_CLKOUT0_DIVIDE: integer := 1;
        C_CLKOUT1_DIVIDE: integer := 1;
        C_CLKOUT2_DIVIDE: integer := 16;
        C_CLKOUT3_DIVIDE: integer := 8;
        C_CLKFBOUT_MULT : integer := 2;
        C_DIVCLK_DIVIDE : integer := 1
    );
    port(
        sys_clk_p       : in     vl_logic;
        sys_clk_n       : in     vl_logic;
        sys_clk         : in     vl_logic;
        sys_rst_i       : in     vl_logic;
        clk0            : out    vl_logic;
        rst0            : out    vl_logic;
        async_rst       : out    vl_logic;
        sysclk_2x       : out    vl_logic;
        sysclk_2x_180   : out    vl_logic;
        mcb_drp_clk     : out    vl_logic;
        pll_ce_0        : out    vl_logic;
        pll_ce_90       : out    vl_logic;
        pll_lock        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C_INCLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of C_RST_ACT_LOW : constant is 1;
    attribute mti_svvh_generic_type of C_INPUT_CLK_TYPE : constant is 1;
    attribute mti_svvh_generic_type of C_CLKOUT0_DIVIDE : constant is 1;
    attribute mti_svvh_generic_type of C_CLKOUT1_DIVIDE : constant is 1;
    attribute mti_svvh_generic_type of C_CLKOUT2_DIVIDE : constant is 1;
    attribute mti_svvh_generic_type of C_CLKOUT3_DIVIDE : constant is 1;
    attribute mti_svvh_generic_type of C_CLKFBOUT_MULT : constant is 1;
    attribute mti_svvh_generic_type of C_DIVCLK_DIVIDE : constant is 1;
end infrastructure;
