library verilog;
use verilog.vl_types.all;
entity afifo is
    generic(
        TCQ             : integer := 100;
        DSIZE           : integer := 32;
        FIFO_DEPTH      : integer := 16;
        ASIZE           : integer := 4;
        SYNC            : integer := 1
    );
    port(
        wr_clk          : in     vl_logic;
        rst             : in     vl_logic;
        wr_en           : in     vl_logic;
        wr_data         : in     vl_logic_vector;
        rd_en           : in     vl_logic;
        rd_clk          : in     vl_logic;
        rd_data         : out    vl_logic_vector;
        full            : out    vl_logic;
        empty           : out    vl_logic;
        almost_full     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TCQ : constant is 1;
    attribute mti_svvh_generic_type of DSIZE : constant is 1;
    attribute mti_svvh_generic_type of FIFO_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of ASIZE : constant is 1;
    attribute mti_svvh_generic_type of SYNC : constant is 1;
end afifo;
