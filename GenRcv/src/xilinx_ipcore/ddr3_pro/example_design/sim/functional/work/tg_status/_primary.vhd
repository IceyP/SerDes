library verilog;
use verilog.vl_types.all;
entity tg_status is
    generic(
        TCQ             : integer := 100;
        DWIDTH          : integer := 32
    );
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        manual_clear_error: in     vl_logic;
        data_error_i    : in     vl_logic;
        cmp_data_i      : in     vl_logic_vector;
        rd_data_i       : in     vl_logic_vector;
        cmp_addr_i      : in     vl_logic_vector(31 downto 0);
        cmp_bl_i        : in     vl_logic_vector(5 downto 0);
        mcb_cmd_full_i  : in     vl_logic;
        mcb_wr_full_i   : in     vl_logic;
        mcb_rd_empty_i  : in     vl_logic;
        error_status    : out    vl_logic_vector;
        error           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
end tg_status;
