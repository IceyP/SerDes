library verilog;
use verilog.vl_types.all;
entity sbox_mem is
    port(
        clka            : in     vl_logic;
        addra           : in     vl_logic_vector(7 downto 0);
        douta           : out    vl_logic_vector(7 downto 0)
    );
end sbox_mem;
