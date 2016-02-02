---------------------------------------------------------------------------------------------------
--
-- Title       : rsenc
-- Design      : rs
-- Author      : yanghb
-- Company     : tsinghua
--
---------------------------------------------------------------------------------------------------
--
-- File        : rsenc.vhd
-- Generated   : Sun Jul 15 15:56:34 2007
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
--{entity {rsenc} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

use work.rs_config.all;

entity rsenc is	 
	port(
		reset	: in std_logic;
		clk		: in std_logic;
		clear	: in std_logic;	  		-- clear overide en
		en		: in std_logic;		   	-- en overide im
		im		: in std_logic;			-- info data mask
		din		: in std_logic_vector(m-1 downto 0);
		oe		: out std_logic;
		dout	: out std_logic_vector(m-1 downto 0)
		);
end rsenc;

--}} End of automatically maintained section

architecture behave of rsenc is	

	signal lfsr		: symbol_array(2*t-1 downto 0)	:= (others => (others => '0'));
	signal feedback	: std_logic_vector(m-1 downto 0)	:= (others => '0');
	constant g		: symbol_array(2*t-1 downto 0)	:= polygen(t);

	signal en_d1	: std_logic			:= '0';
	
begin

	-- enter your statements here --
	
	feedback <= din xor lfsr(2*t-1); 
	
	lfsr_0	: process(reset,clk)
	begin
		if reset = '1' then
			lfsr(0) <= (others => '0');
		elsif rising_edge(clk) then
			if clear = '1' then
				lfsr(0) <= (others => '0');
			elsif en = '1' then
				if im = '1' then
					lfsr(0) <= gfmult( feedback, g(0) );
				else
					lfsr(0) <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	
	lfsr_gen	: for i in 1 to 2*t-1 generate
		lfsr_i	: process(reset,clk)
		begin	   
			if reset = '1' then
				lfsr(i) <= (others => '0');
			elsif rising_edge(clk) then
				if clear = '1' then
					lfsr(i) <= (others => '0');
				elsif en = '1' then
					if im = '1' then
						lfsr(i) <= lfsr(i-1) xor gfmult( feedback, g(i) );
					else
						lfsr(i) <= lfsr(i-1);
					end if;
				end if;
			end if;
		end process;
	end generate;
 
	GetDataOut	: process(reset,clk)
	begin
		if reset = '1' then
			dout <= (others => '0');
		elsif rising_edge(clk) then
			if en = '1' then
				if im = '1' then
					dout <= din;
				else
					dout <= lfsr(2*t-1);
				end if;
			end if;
		end if;
	end process;
	
	oe <= en_d1;
	
	Delay	: process(reset,clk)
	begin
		if reset = '1' then
			en_d1 <= '0';
		elsif rising_edge(clk) then
			en_d1 <= en;
		end if;
	end process;

end behave;
