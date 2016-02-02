library verilog;
use verilog.vl_types.all;
entity mcb_flow_control is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6"
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic_vector(9 downto 0);
        cmd_rdy_o       : out    vl_logic;
        cmd_valid_i     : in     vl_logic;
        cmd_i           : in     vl_logic_vector(2 downto 0);
        addr_i          : in     vl_logic_vector(31 downto 0);
        bl_i            : in     vl_logic_vector(5 downto 0);
        mcb_cmd_full    : in     vl_logic;
        cmd_o           : out    vl_logic_vector(2 downto 0);
        addr_o          : out    vl_logic_vector(31 downto 0);
        bl_o            : out    vl_logic_vector(5 downto 0);
        cmd_en_o        : out    vl_logic;
        last_word_wr_i  : in     vl_logic;
        wdp_rdy_i       : in     vl_logic;
        wdp_valid_o     : out    vl_logic;
        wdp_validB_o    : out    vl_logic;
        wdp_validC_o    : out    vl_logic;
        wr_addr_o       : out    vl_logic_vector(31 downto 0);
        wr_bl_o         : out    vl_logic_vector(5 downto 0);
        last_word_rd_i  : in     vl_logic;
        rdp_rdy_i       : in     vl_logic;
        rdp_valid_o     : out    vl_logic;
        rd_addr_o       : out    vl_logic_vector(31 downto 0);
        rd_bl_o         : out    vl_logic_vector(5 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
end mcb_flow_control;
