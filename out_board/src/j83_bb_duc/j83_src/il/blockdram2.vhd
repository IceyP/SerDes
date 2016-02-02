---------------------------------------------------------------------------------------------------
--
-- Title       : blockdram2
-- Design      : baseband
-- Author      :  
-- Company     : tsinghua
--
---------------------------------------------------------------------------------------------------
--
-- File        : blockdram2.vhd
-- Generated   : Wed Mar 24 14:55:09 2004
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : dual port block ram with output enable 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {blockdram2} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify;
--use synplify.attributes.all;

entity blockdram2 is
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
end blockdram2;

--}} End of automatically maintained section

architecture behave of blockdram2 is

	type ram_memtype is array (depth-1 downto 0) of std_logic_vector	(Dwidth-1 downto 0);
	signal mem : ram_memtype	:= (others => (others => '0'));
--	attribute syn_ramstyle of mem : signal is "block_ram,area";
	
	signal addrb_reg: std_logic_vector(Awidth-1 downto 0);
	signal wea_1dly:std_logic;
	
begin

    process(clka)
    begin
	    if rising_edge(clka) then
	        wea_1dly <= wea;
	    end if;
	end process;	    

	wr: process( clka )
	begin
		if rising_edge(clka) then
			if wea_1dly = '1' then
				mem(conv_integer(addra)) <= dia;
			end if;
		end if;
	end process wr;
	
	rd: process( clkb )
	begin
		if rising_edge(clkb) then
			if reb = '1' then
				addrb_reg <= addrb;
			end if;
		end if;
	end process rd;
	dob <= mem(conv_integer(addrb_reg));

end behave;
