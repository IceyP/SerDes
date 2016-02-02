library verilog;
use verilog.vl_types.all;
entity ts_j83_buf is
    generic(
        RAM_WIDTH       : integer := 8;
        RAM_DEPTH_BIT   : integer := 10
    );
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        ts_rd_valid     : in     vl_logic;
        ts_i_valid      : in     vl_logic;
        ts_i_data       : in     vl_logic_vector(7 downto 0);
        ts_o_data       : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RAM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RAM_DEPTH_BIT : constant is 1;
end ts_j83_buf;
