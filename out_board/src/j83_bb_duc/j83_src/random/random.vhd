---------------------------------------------------------------------------------------------------
--
-- Title       : behave
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : random.vhd
-- Generated   : Thu Apr 12 18:13:23 2012
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
--{entity {behave} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity random is
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 frame8 : in STD_LOGIC;
		 ce : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 frame : in STD_LOGIC;
		 Q : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end random;

--}} End of automatically maintained section

architecture behave of random is 
 
signal lsf : std_logic_vector( 14 downto 0 );

begin

	 -- enter your statements here --
	
randomGen : process( clk , rst )
begin
	if rst='1' then
		lsf<=( others=>'0' );
		Q<=( others=>'0' );
	elsif rising_edge(clk) then			 
		if ce = '1' then
			if frame8='1' then
				lsf<="010100100000011";--"000000010101001";
				Q <= not D;
			else
				lsf(14 downto 8)<=lsf( 6 downto 0 );
				lsf(7 downto 0)<=lsf(14 downto 7) xor lsf( 13 downto 6 );
				if frame='1' then
					Q<=D;
				else
					Q<=D xor lsf(7 downto 0);
				end if;
			end if;
		end if;
	end if;
end process;
end behave;
