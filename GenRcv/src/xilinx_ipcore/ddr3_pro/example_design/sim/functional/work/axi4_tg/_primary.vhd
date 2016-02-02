library verilog;
use verilog.vl_types.all;
entity axi4_tg is
    generic(
        C_AXI_ID_WIDTH  : integer := 4;
        C_AXI_ADDR_WIDTH: integer := 32;
        C_AXI_DATA_WIDTH: integer := 32;
        C_AXI_NBURST_SUPPORT: integer := 0;
        C_EN_WRAP_TRANS : integer := 0;
        C_BEGIN_ADDRESS : integer := 0;
        C_END_ADDRESS   : vl_logic_vector(31 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        DBG_WR_STS_WIDTH: integer := 32;
        DBG_RD_STS_WIDTH: integer := 32;
        ENFORCE_RD_WR   : integer := 0;
        ENFORCE_RD_WR_CMD: vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1);
        EN_UPSIZER      : integer := 0;
        ENFORCE_RD_WR_PATTERN: vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0)
    );
    port(
        aclk            : in     vl_logic;
        aresetn         : in     vl_logic;
        init_cmptd      : in     vl_logic;
        init_test       : in     vl_logic;
        wdog_mask       : in     vl_logic;
        wrap_en         : in     vl_logic;
        axi_wready      : in     vl_logic;
        axi_wid         : out    vl_logic_vector;
        axi_waddr       : out    vl_logic_vector;
        axi_wlen        : out    vl_logic_vector(7 downto 0);
        axi_wsize       : out    vl_logic_vector(2 downto 0);
        axi_wburst      : out    vl_logic_vector(1 downto 0);
        axi_wlock       : out    vl_logic_vector(1 downto 0);
        axi_wcache      : out    vl_logic_vector(3 downto 0);
        axi_wprot       : out    vl_logic_vector(2 downto 0);
        axi_wvalid      : out    vl_logic;
        axi_wd_wready   : in     vl_logic;
        axi_wd_wid      : out    vl_logic_vector;
        axi_wd_data     : out    vl_logic_vector;
        axi_wd_strb     : out    vl_logic_vector;
        axi_wd_last     : out    vl_logic;
        axi_wd_valid    : out    vl_logic;
        axi_wd_bid      : in     vl_logic_vector;
        axi_wd_bresp    : in     vl_logic_vector(1 downto 0);
        axi_wd_bvalid   : in     vl_logic;
        axi_wd_bready   : out    vl_logic;
        axi_rready      : in     vl_logic;
        axi_rid         : out    vl_logic_vector;
        axi_raddr       : out    vl_logic_vector;
        axi_rlen        : out    vl_logic_vector(7 downto 0);
        axi_rsize       : out    vl_logic_vector(2 downto 0);
        axi_rburst      : out    vl_logic_vector(1 downto 0);
        axi_rlock       : out    vl_logic_vector(1 downto 0);
        axi_rcache      : out    vl_logic_vector(3 downto 0);
        axi_rprot       : out    vl_logic_vector(2 downto 0);
        axi_rvalid      : out    vl_logic;
        axi_rd_bid      : in     vl_logic_vector;
        axi_rd_rresp    : in     vl_logic_vector(1 downto 0);
        axi_rd_rvalid   : in     vl_logic;
        axi_rd_data     : in     vl_logic_vector;
        axi_rd_last     : in     vl_logic;
        axi_rd_rready   : out    vl_logic;
        cmd_err         : out    vl_logic;
        data_msmatch_err: out    vl_logic;
        write_err       : out    vl_logic;
        read_err        : out    vl_logic;
        test_cmptd      : out    vl_logic;
        write_cmptd     : out    vl_logic;
        read_cmptd      : out    vl_logic;
        cmptd_cycle     : out    vl_logic;
        cmptd_one_wr_rd : out    vl_logic;
        dbg_wr_sts_vld  : out    vl_logic;
        dbg_wr_sts      : out    vl_logic_vector;
        dbg_rd_sts_vld  : out    vl_logic;
        dbg_rd_sts      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C_AXI_ID_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C_AXI_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C_AXI_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of C_AXI_NBURST_SUPPORT : constant is 1;
    attribute mti_svvh_generic_type of C_EN_WRAP_TRANS : constant is 1;
    attribute mti_svvh_generic_type of C_BEGIN_ADDRESS : constant is 1;
    attribute mti_svvh_generic_type of C_END_ADDRESS : constant is 1;
    attribute mti_svvh_generic_type of DBG_WR_STS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DBG_RD_STS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ENFORCE_RD_WR : constant is 1;
    attribute mti_svvh_generic_type of ENFORCE_RD_WR_CMD : constant is 1;
    attribute mti_svvh_generic_type of EN_UPSIZER : constant is 1;
    attribute mti_svvh_generic_type of ENFORCE_RD_WR_PATTERN : constant is 1;
end axi4_tg;