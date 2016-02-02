---------------------------------------------------------------------------------------------------
--
-- Title       : Test Bench for j83top
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : $DSN\src\TestBench\j83top_TB.vhd
-- Generated   : 2012/5/6, 17:06
-- From        : $DSN\src\J83Top.vhd
-- By          : Active-HDL Built-in Test Bench Generator ver. 1.2s
--
---------------------------------------------------------------------------------------------------
--
-- Description : Automatically generated Test Bench for j83top_tb
--
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library simio;
use simio.SIMIO_PACKAGE.all;

	-- Add your library and packages declaration here ...

entity j83top_tb is
end j83top_tb;

architecture TB_ARCHITECTURE of j83top_tb is
	-- Component declaration of the tested unit
	component j83top
	port(
		clk : in std_logic;
		rst : in std_logic;
		ren : in std_logic;
		D : in std_logic_vector(7 downto 0);
		mode : in std_logic_vector(3 downto 0);
		ce : out std_logic;
		systemce : out std_logic;
		frame : out std_logic;
		IQ : out std_logic_vector(9 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic;
	signal rst : std_logic;
	signal ren : std_logic;
	signal D : std_logic_vector(7 downto 0);
	signal mode : std_logic_vector(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ce : std_logic;
	signal frame : std_logic;
	signal IQ : std_logic_vector(9 downto 0);

	signal CEC : integer range 0 to 9 := 0;

	-- Add your code here ...
	shared variable ENDSIM: boolean:=false;
	constant CLK_PERIOD:time:= 10 ns;
	constant RESET_LENGTH:time:= 50 ns;	 
	constant delayCE:time:=CLK_PERIOD*10*13;
	
	signal ceRef : std_logic;
	signal delayRef : std_logic;
	signal error : std_logic;
	signal sysce : std_logic;
	
	signal RNref : std_logic_vector(7 downto 0);
begin

	-- Unit Under Test port map
	UUT : j83top
		port map (
			clk => clk,
			rst => rst,
			ren => ren,
			D => D,
			mode => mode,
			ce => ce,
			systemce => sysce,
			frame => frame,
			IQ => IQ
		);

	-- Add your stimulus here ...
 	beforeRS : ADemulator 
		generic map( AD_FILE => "../../../work/Src.txt",
	  				DATA_WIDTH => 8 )
		port map(
				clk	=> clk,
        		ce	=> ce,
				data	=> D
		);
		
	RNrefRD : ADemulator 
		generic map( AD_FILE => "../../../work/IL.txt",
	  				DATA_WIDTH => 8 )
		port map(
				clk	=> clk,
        		ce	=> ceRef,
				data	=> RNref
		);
		
  
		
		mode<="1000";

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

ceRef <= delayRef and sysce;

frame_gen : process(clk,rst)
begin
	if rst='1' then
		ren<='0';
	elsif rising_edge(clk) then
		if CEC=9 then
			CEC<=0;
			ren<='1';
		else
			CEC<=CEC+1;
			ren<='0';
		end if;		 
	end if;
end process; 



end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_j83top of j83top_tb is
	for TB_ARCHITECTURE
		for UUT : j83top
			use entity work.j83top(behave);
		end for;
	end for;
end TESTBENCH_FOR_j83top;

