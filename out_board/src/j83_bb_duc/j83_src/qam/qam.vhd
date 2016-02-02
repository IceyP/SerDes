---------------------------------------------------------------------------------------------------
--
-- Title       : QAM
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : QAM.vhd
-- Generated   : Sun Apr 29 15:22:19 2012
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
--{entity {QAM} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

entity QAM is
	 port(
		 clk : in STD_LOGIC;
		 rst : in std_logic;				   
		 ren : in STD_LOGIC;
		 msb : in STD_LOGIC_VECTOR(1 downto 0);
		 flsb : in STD_LOGIC_VECTOR(6 downto 0);
		 ceo : out STD_LOGIC;
		 iq : out STD_LOGIC_VECTOR(9 downto 0)
	     );
end QAM;

--}} End of automatically maintained section

architecture behave of QAM is

component QAMRom is                                                     
	 port(
         clk : in STD_LOGIC;
		 rst : in std_logic;	 
		 D : in STD_LOGIC_VECTOR(6 downto 0);                            
		 I : out STD_LOGIC_VECTOR(3 downto 0);                           
		 Q : out STD_LOGIC_VECTOR(3 downto 0)                            
	     );                                                            
end component;

signal nowI,nowQ,lastI,lastQ : std_logic := '0';
signal RomI,RomQ : std_logic_vector( 3 downto 0 ) :=(others=>'0');
signal IkQk : std_logic_vector( 1 downto 0 ) :=(others=>'0');

signal PI,PQ,NI,NQ,outI,outQ : std_logic_vector( 4 downto 0 ) :=(others=>'0');
begin

	 -- enter your statements here --
rom : QAMRom                                                     
	 port map(
         clk => clk,
         rst => rst,		 
		 D => flsb,
		 I => RomI,
		 Q => RomQ
	     );       

diffEnc : process( msb, lastI, lastQ )
begin		
	case msb is
		when "00" => 
			nowI <= lastI;
			nowQ <= lastQ;
		when "01" => 
			nowI <= lastQ;
			nowQ <= not lastI;
		when "10" =>
			nowI <= not lastQ;
			nowQ <= lastI;
		when "11" =>
			nowI <= not lastI;
			nowQ <= not lastQ;
		when others =>
			nowI <= lastI;
			nowQ <= lastQ;
	end case;
end process;

ACLK : process(clk,rst)
begin
	if rst='1' then
		lastI<='0';
		lastQ<='0';
	elsif rising_edge(clk) then
		if ren='1' then
			lastI<=nowI;
			lastQ<=nowQ;
		end if;
	end if;
end process;

PI<='0'&romI;
PQ<='0'&romQ;

NI<='1'&(not romI)+1;
NQ<='1'&(not romQ)+1;

IkQk<=nowI&nowQ;

rot : process( IkQk,PI,PQ,NI,NQ )
begin		
	case IkQk is
		when "00" => 
			outI <= PI;
			outQ <= PQ;
		when "01" => 
			outI <= PQ;
			outQ <= NI;
		when "10" =>
			outI <= NQ;
			outQ <= PI;
		when "11" =>
			outI <= NI;
			outQ <= NQ;
		when others =>
			outI <= PI;
			outQ <= PQ;
	end case;
end process;
iq<=outQ&outI; --'I' at lower half
ceo<=ren;

end behave;
