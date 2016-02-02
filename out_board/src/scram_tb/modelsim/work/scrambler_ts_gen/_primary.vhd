library verilog;
use verilog.vl_types.all;
entity scrambler_ts_gen is
    generic(
        U_DLY           : integer := 1;
        PKT_INTERVAL    : integer := 100;
        ADAPT_FIELD_CTRL: vl_logic_vector(0 to 1) := (Hi0, Hi1);
        ADAPT_FIELD_LEN : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        ts_sync         : out    vl_logic;
        ts_valid        : out    vl_logic;
        ts_eop          : out    vl_logic;
        ts_data         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of U_DLY : constant is 1;
    attribute mti_svvh_generic_type of PKT_INTERVAL : constant is 1;
    attribute mti_svvh_generic_type of ADAPT_FIELD_CTRL : constant is 1;
    attribute mti_svvh_generic_type of ADAPT_FIELD_LEN : constant is 1;
end scrambler_ts_gen;
