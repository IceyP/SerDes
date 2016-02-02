library verilog;
use verilog.vl_types.all;
entity scram_cfg is
    generic(
        U_DLY           : integer := 1;
        P_BUS_ADDR_WIDTH: integer := 12;
        P_BUS_DATA_WIDTH: integer := 16;
        SCRAM_RAM_DEPTH_BIT: integer := 9;
        SCRAM_RAM_WIDTH : integer := 8;
        PIDRAM_DEPTH_BIT: integer := 6;
        PIDRAM_WIDTH    : integer := 16;
        SKRAM_DEPTH_BIT : vl_notype;
        SKRAM_WIDTH     : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clk_cfg         : in     vl_logic;
        rst_cfg         : in     vl_logic;
        channel_index   : in     vl_logic_vector(3 downto 0);
        lbus_addr       : in     vl_logic_vector;
        lbus_wdata      : in     vl_logic_vector;
        lbus_we_n       : in     vl_logic;
        ts_i_sync       : in     vl_logic;
        ts_i_valid      : in     vl_logic;
        ts_i_data       : in     vl_logic_vector(7 downto 0);
        scram_raddr     : in     vl_logic_vector(8 downto 0);
        scram_i_data    : out    vl_logic_vector(7 downto 0);
        scram_i_eop     : out    vl_logic;
        scram_ena       : out    vl_logic;
        service_key     : out    vl_logic_vector(63 downto 0);
        not_scram_byte_cnt: out    vl_logic_vector(7 downto 0);
        buf_h           : out    vl_logic;
        parity_key_flag : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of U_DLY : constant is 1;
    attribute mti_svvh_generic_type of P_BUS_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of P_BUS_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SCRAM_RAM_DEPTH_BIT : constant is 1;
    attribute mti_svvh_generic_type of SCRAM_RAM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of PIDRAM_DEPTH_BIT : constant is 1;
    attribute mti_svvh_generic_type of PIDRAM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SKRAM_DEPTH_BIT : constant is 3;
    attribute mti_svvh_generic_type of SKRAM_WIDTH : constant is 1;
end scram_cfg;
