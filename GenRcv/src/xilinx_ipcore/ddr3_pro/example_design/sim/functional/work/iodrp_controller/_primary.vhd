library verilog;
use verilog.vl_types.all;
entity iodrp_controller is
    port(
        memcell_address : in     vl_logic_vector(7 downto 0);
        write_data      : in     vl_logic_vector(7 downto 0);
        read_data       : out    vl_logic_vector(7 downto 0);
        rd_not_write    : in     vl_logic;
        cmd_valid       : in     vl_logic;
        rdy_busy_n      : out    vl_logic;
        use_broadcast   : in     vl_logic;
        sync_rst        : in     vl_logic;
        DRP_CLK         : in     vl_logic;
        DRP_CS          : out    vl_logic;
        DRP_SDI         : out    vl_logic;
        DRP_ADD         : out    vl_logic;
        DRP_BKST        : out    vl_logic;
        DRP_SDO         : in     vl_logic
    );
end iodrp_controller;
