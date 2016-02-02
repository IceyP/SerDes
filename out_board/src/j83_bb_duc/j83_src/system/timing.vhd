---------------------------------------------------------------------------------------------------
--
-- Title       : behave
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : timing.vhd
-- Generated   : Tue Apr 17 20:37:50 2012
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity timing is
	 port(
		 empty : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 frame8 : out STD_LOGIC;
		 frame : out STD_LOGIC;        
		 im : out STD_LOGIC;        
		 ce : out STD_LOGIC
	     );

     ----fanout constraint
     --attribute max_fanout: string;
     --attribute max_fanout of im      :signal is "4";
     --attribute max_fanout of frame   :signal is "4";

end timing;

--}} End of automatically maintained section

architecture behave of timing is 				 
	signal CEC : integer range 0 to 8 := 0;
	signal FRC : integer range 0 to 203  := 0;
	signal SFC : integer range 0 to 7 := 0;
begin

	 -- enter your statements here --
timingP : process( clk, rst )
begin
	if rst='1' then
		CEC<=0;
		FRC<=0;
		SFC<=0;
	elsif rising_edge(clk) then			 
		if CEC=8 then
			CEC<=0;	   
			if empty='1' then
				ce<='1';
				if FRC=0 then
					frame<='1';
					if SFC=0 then
						frame8<='1';
					end if;
					if SFC=7 then
						SFC<=0;
					else
						SFC<=SFC+1;
					end if;
				end if;
				if FRC=203 then
					FRC<=0;
				else
					FRC<=FRC+1;
				end if;
				if FRC<188 then
					im<='1';
				end if;
			end if;
		else
			CEC<=CEC+1;
			ce<='0';   
			im<='0';
			frame8<='0';
			frame<='0';
		end if;		 
	end if;
end process;

end behave;
