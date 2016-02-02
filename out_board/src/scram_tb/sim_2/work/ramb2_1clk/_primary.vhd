library verilog;
use verilog.vl_types.all;
entity ramb2_1clk is
    port(
        clka            : in     vl_logic;
        wea             : in     vl_logic_vector(0 downto 0);
        addra           : in     vl_logic_vector(8 downto 0);
        dina            : in     vl_logic_vector(7 downto 0);
        clkb            : in     vl_logic;
        addrb           : in     vl_logic_vector(8 downto 0);
        doutb           : out    vl_logic_vector(7 downto 0)
    );
end ramb2_1clk;
