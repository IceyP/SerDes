---------------------------------------------------------------------------------------------------
--
-- Title       : IL
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : IL.vhd
-- Generated   : Mon Apr  9 10:45:43 2012
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
--{entity {IL} architecture {IL}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IL is
	 port(
		 frame : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 ce : in std_logic;
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 ceo : out std_logic;
		 Q : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end IL;

--}} End of automatically maintained section

architecture IL of IL is 
signal WADDR:std_logic_vector(10 downto 0):=(others=>'0');
signal RADDR:std_logic_vector(10 downto 0):=(others=>'0');
signal ceD1:std_logic := '0';
signal ILout : std_logic_vector( 7 downto 0 ):=(others=>'0');

component blockdram2 is
	generic( 
		depth:	integer	:= 256;
		Dwidth: integer	:= 8;
		Awidth:	integer	:= 8
		);
	port(
		addra: IN std_logic_VECTOR(Awidth-1 downto 0);
		clka: IN std_logic;
		addrb: IN std_logic_VECTOR(Awidth-1 downto 0);
		clkb: IN std_logic;
		dia: IN std_logic_VECTOR(Dwidth-1 downto 0);
		wea: IN std_logic;
		reb: IN std_logic;
		dob: OUT std_logic_VECTOR(Dwidth-1 downto 0)	:= (others => '0')
		);
end component;

component ILAddr is
	 port(
		 frame : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 ce : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 addr : out STD_LOGIC_VECTOR(10 downto 0)
	     );
end component;

begin

	 -- enter your statements here --
ILRam : blockdram2 
	generic map( 
		depth => 2048,
		Dwidth => 8,
		Awidth => 11
		)
	port map(
		addra => WADDR,
		clka => clk,
		addrb => RADDR,
		clkb => clk,
		dia => D,
		wea => ce,
		reb => ce,
		dob => ILout
		);

 aADDR : ILAddr 
	 port map(
		 frame => frame,
		 clk => clk,
		 ce => ce,
		 rst => rst,
		 addr => RADDR
	     );

delay : process(clk,rst)
begin
	if rst='1' then
		WADDR<=(others => '0');
		ceD1<='0';
	elsif rising_edge(clk) then
		WADDR<=RADDR;
		ceD1<=ce; 
		if ceD1='1' then
			Q<=ILout;
		end if;
	end if;
end process;

ceo<=ceD1;	

end IL;

