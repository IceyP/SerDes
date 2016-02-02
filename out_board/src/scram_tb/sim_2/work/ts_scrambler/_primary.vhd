library verilog;
use verilog.vl_types.all;
entity ts_scrambler is
    generic(
        P_BUS_ADDR_WIDTH: integer := 12;
        P_BUS_DATA_WIDTH: integer := 16;
        U_DLY           : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clk_cfg         : in     vl_logic;
        rst_cfg         : in     vl_logic;
        j83_rdreq       : in     vl_logic;
        ts_i_sync       : in     vl_logic;
        ts_i_valid      : in     vl_logic;
        ts_i_data       : in     vl_logic_vector(7 downto 0);
        ts_o_valid      : out    vl_logic;
        ts_o_data       : out    vl_logic_vector(7 downto 0);
        channel_index   : in     vl_logic_vector(3 downto 0);
        lbus_addr       : in     vl_logic_vector;
        lbus_wdata      : in     vl_logic_vector;
        lbus_we_n       : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of P_BUS_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of P_BUS_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of U_DLY : constant is 1;
end ts_scrambler;
