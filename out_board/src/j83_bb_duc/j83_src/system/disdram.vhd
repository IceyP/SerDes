library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--library synplify;
--use synplify.attributes.all;

entity disdram is
	generic( 
		depth:	integer;
		Dwidth: integer;
		Awidth:	integer
		);
	port(
		A: IN std_logic_VECTOR(Awidth-1 downto 0);
		CLK: IN std_logic;
		D: IN std_logic_VECTOR(Dwidth-1 downto 0);
		WE: IN std_logic;
		DPRA: IN std_logic_VECTOR(Awidth-1 downto 0);
		DPO: OUT std_logic_VECTOR(Dwidth-1 downto 0);
		QDPO: OUT std_logic_VECTOR(Dwidth-1 downto 0)
		);
end disdram;

architecture arch_disdram of disdram is
	
	type ram_memtype is array (depth-1 downto 0) of std_logic_vector
	(Dwidth-1 downto 0);
	signal mem : ram_memtype	:= (others => (others => '0'));
--	attribute syn_ramstyle of mem : signal is "select_ram";
	
begin
	wr: process( clk )
	begin
		if rising_edge(clk) then
			if WE = '1' then
				mem(conv_integer(A)) <= D;
			end if;
		end if;
	end process wr;
	DPO <= mem(conv_integer(DPRA));
	
	rd	: process(clk)
	begin
		if rising_edge(clk) then
			QDPO <= mem(conv_integer(DPRA));
		end if;
	end process;
	
end arch_disdram;

