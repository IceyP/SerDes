library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--library synplify;
--use synplify.attributes.all;

entity dissram is
	generic( 
		depth		: integer;
		Dwidth		: integer;
		Awidth		: integer
	);
	port(
		A			: in std_logic_VECTOR(Awidth-1 downto 0);
		CLK			: in std_logic;
		D			: in std_logic_VECTOR(Dwidth-1 downto 0);
		WE			: in std_logic;
		SPO			: out std_logic_VECTOR(Dwidth-1 downto 0)
	);
end dissram;

architecture arch_dissram of dissram is

type ram_memtype is array (depth-1 downto 0) of std_logic_vector
	(Dwidth-1 downto 0);
signal mem : ram_memtype := (others=>(others=>'0'));
-- attribute syn_ramstyle of mem : signal is "select_ram";

begin
	wr: process( clk )
	begin
		if rising_edge(clk) then
			if WE = '1' then
				mem(conv_integer(A)) <= D;
			end if;
		end if;
	end process wr;
	SPO <= mem(conv_integer(A));

end arch_dissram;

