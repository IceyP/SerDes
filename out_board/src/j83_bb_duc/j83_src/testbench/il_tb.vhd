---------------------------------------------------------------------------------------------------
--
-- Title       : Test Bench for il
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : $DSN\src\TestBench\il_TB.vhd
-- Generated   : 2012/4/9, 11:08
-- From        : $DSN\src\IL\IL.vhd
-- By          : Active-HDL Built-in Test Bench Generator ver. 1.2s
--
---------------------------------------------------------------------------------------------------
--
-- Description : Automatically generated Test Bench for il_tb
--
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...
library simio;
use simio.SIMIO_PACKAGE.all;

entity il_tb is
end il_tb;

architecture TB_ARCHITECTURE of il_tb is
	-- Component declaration of the tested unit
	component il
	port(
		frame : in std_logic;
		clk : in std_logic;
		rst : in std_logic;
		ce : in std_logic;
		D : in std_logic_vector(7 downto 0);
		ceo : out std_logic;
		Q : out std_logic_vector(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal frame : std_logic;
	signal frameD1 : std_logic;
	signal clk : std_logic;
	signal rst : std_logic;
	signal ce : std_logic;
	signal ceD1 : std_logic;
	signal D : std_logic_vector(7 downto 0);
	signal refQ : std_logic_vector(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ceo : std_logic;
	signal Q : std_logic_vector(7 downto 0);
	
	signal CEC : integer range 0 to 7 := 0;
	signal FRC : integer range 0 to 203  := 0;
	
	shared variable ENDSIM: boolean:=false;
	constant CLK_PERIOD:time:= 10 ns;
	constant RESET_LENGTH:time:= 50 ns;	 
	constant delayCE:time:=CLK_PERIOD*8*13;
	
	signal ceRef : std_logic;
	signal delayRef : std_logic;
	signal error : std_logic;
	
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : il
		port map (
			frame => frameD1,
			clk => clk,
			rst => rst,
			ce => ceD1,
			D => D,
			ceo => ceo,
			Q => Q
		);

	-- Add your stimulus here ...
	beforeIL : ADemulator 
		generic map( AD_FILE => "../../../work/RS.txt",
	  				DATA_WIDTH => 8 )
		port map(
				clk	=> clk,
        		ce	=> ce,
				data	=> D
		);		

	afterIL : ADemulator 
		generic map( AD_FILE => "../../../work/IL.txt",
	  				DATA_WIDTH => 8 )
		port map(
				clk	=> clk,
        		ce	=> ceRef,
				data	=> refQ
		);		

clk_gen: process
begin
	if ENDSIM=false then
		clk <= '0';
		wait for CLK_PERIOD/2;
		clk <= '1';
		wait for CLK_PERIOD/2;
	else
		wait;
	end if;	
end process;

RES: process
begin
	rst<='1';  -- reset of the counter
	wait for RESET_LENGTH;
	rst<='0';
	wait;
end process;

DelayForRef: process
begin
	delayRef<='0';  -- reset of the counter
	wait for delayCE;
	delayRef<='1';
	wait;
end process;

ceRef <= delayRef and ce;

frame_gen : process(clk,rst)
begin
	if rst='1' then
		ce<='0';
		frame<='0';
		ceD1<='0';
		frameD1<='0';
	elsif rising_edge(clk) then
		if CEC=7 then
			CEC<=0;
			ce<='1';
			if FRC=0 then
				frame<='1';
			end if;
			if FRC=203 then
				FRC<=0;
			else
				FRC<=FRC+1;
			end if;
		else
			CEC<=CEC+1;
			ce<='0';
			frame<='0';
		end if;		 
		ceD1<=ce;
		frameD1<=frame;
	end if;
end process; 

compareErr:process(clk)
begin
	if rising_edge(clk) then
		if ce='1' then
			if refQ/=Q then
				error<='1';
			else
				error<='0';
			end if;
		end if;
	end if;
end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_il of il_tb is
	for TB_ARCHITECTURE
		for UUT : il
			use entity work.il(il);
		end for;
	end for;
end TESTBENCH_FOR_il;

