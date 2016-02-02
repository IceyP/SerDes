---------------------------------------------------------------------------------------------------
--
-- Title       : ILAddr
-- Design      : J83
-- Author      : zhaom
-- Company     : Tsinghua
--
---------------------------------------------------------------------------------------------------
--
-- File        : ILAddr.vhd
-- Generated   : Fri Mar 30 17:44:06 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ILAddr} architecture {ILAddr}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--library synplify;
--use synplify.attributes.all;

entity ILAddr is
	 port(
		 frame : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 ce : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 addr : out STD_LOGIC_VECTOR(10 downto 0)
	     );
end ILAddr;

--}} End of automatically maintained section

architecture ILAddr of ILAddr is

signal counter : std_logic_vector( 7 downto 0 ) :=(others=>'0');
signal NextCounter : std_logic_vector( 7 downto 0 ):=(others=>'0');
signal state : integer range 0 to 11 := 0;
signal CADDR : std_logic_vector( 3 downto 0 ):=(others=>'0');

component dissram is
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
end component;

begin

	-- enter your statements here -- 
CADDR <= conv_std_logic_vector( state, 4 );

counterRam : dissram 
	generic map( 
		depth	=> 16,
		Dwidth	=> 8,
		Awidth	=> 4
	)
	port map(
		A	=> CADDR,
		CLK	=> clk,
		D	=> NextCounter,
		WE	=> ce,
		SPO	=> counter
	);	

addrgen : process( state, counter )
begin
	case state is
		when 0 => addr<="00000"&counter( 5 downto 0 );
		when 1 => addr<="00001" & counter( 5 downto 0 );
		when 2 => addr<="0001" & counter( 6 downto 0 );
		when 3 => addr<="0010" & counter( 6 downto 0 );
		when 4 => addr<="0011" & counter( 6 downto 0 );
		when 5 => addr<="0100" & counter( 6 downto 0 );
		when 6 => addr<="0101" & counter( 6 downto 0 );
		when 7 => addr<="011" & counter( 7 downto 0 );
		when 8 => addr<="100" & counter( 7 downto 0 );
		when 9 => addr<="101" & counter( 7 downto 0 );
		when 10 => addr<="110" & counter( 7 downto 0 );
		when 11 => addr<="111" & counter( 7 downto 0 );
		when others => addr<=( others=>'0' );
	end case;
end process;

stateProc : process( clk,rst )
begin
	if rst='1' then
		state<=0;
	elsif rising_edge(clk) then
		if ce='1' then
			if frame='1' then
				state<=1;
			elsif state=11 then
				state<=0;
			else
				state<=state+1;
			end if;
		end if;
	end if;
end process;

NextCounter <= (others=>'0') when counter=state*17 else counter+1;
	

end ILAddr;
