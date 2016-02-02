library verilog;
use verilog.vl_types.all;
entity read_posted_fifo is
    generic(
        TCQ             : integer := 100;
        FAMILY          : string  := "SPARTAN6";
        MEM_BURST_LEN   : integer := 4;
        ADDR_WIDTH      : integer := 32;
        BL_WIDTH        : integer := 6
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        cmd_rdy_o       : out    vl_logic;
        cmd_valid_i     : in     vl_logic;
        data_valid_i    : in     vl_logic;
        addr_i          : in     vl_logic_vector;
        bl_i            : in     vl_logic_vector;
        user_bl_cnt_is_1: in     vl_logic;
        cmd_sent        : in     vl_logic_vector(2 downto 0);
        bl_sent         : in     vl_logic_vector(5 downto 0);
        cmd_en_i        : in     vl_logic;
        gen_rdy_i       : in     vl_logic;
        gen_valid_o     : out    vl_logic;
        gen_addr_o      : out    vl_logic_vector;
        gen_bl_o        : out    vl_logic_vector;
        rd_buff_avail_o : out    vl_logic_vector(6 downto 0);
        rd_mdata_fifo_empty: in     vl_logic;
        rd_mdata_en     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of MEM_BURST_LEN : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BL_WIDTH : constant is 1;
end read_posted_fifo;
