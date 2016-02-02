library ieee;
use ieee.std_logic_1164.ALL;
use ieee.math_real.ALL;
use ieee.numeric_std.ALL;

use std.textio.all;

use work.COMPLEX_PKG.ALL;

entity bb_tb is
end entity;

architecture bb_tb_arch of bb_tb is
	component bb
	generic(
		CHANNELS : INTEGER := 16;
		WAWIDTH : INTEGER := 4;
		DIWIDTH : INTEGER := 32;
		PHASE_SIZE : INTEGER := 12;
		NB_SRRC : INTEGER := 20;
		NB_FRACTINT : INTEGER := 18;
		FLOORPLAN : BOOLEAN := TRUE;
		OX : INTEGER := 0;
		OY : INTEGER := 0;
		DX : INTEGER := 0;
		DY : INTEGER := 0;
		C_SRRC_12 : REAL_VECTOR;
		C_SRRC_18 : REAL_VECTOR;
		C_FRACTINT : REAL_VECTOR);
	port(
		PCLK : in STD_LOGIC;
		WA : in UNSIGNED(WAWIDTH-1 downto 0);
		DI : in UNSIGNED(DIWIDTH-1 downto 0);
		WE : in BOOLEAN;
		CLK : in STD_LOGIC;
		CSET : in STD_LOGIC;
		RE : out BOOLEAN;
		CH : out UNSIGNED(WAWIDTH-1 downto 0);
		I : in STD_LOGIC_VECTOR(2*5-1 downto 0);
		VI : in BOOLEAN;
		O : out STD_LOGIC_VECTOR(2*16-1 downto 0);
		VO : out BOOLEAN);
	end component;	
	
	component bb_sym
	generic(
		WAWIDTH : INTEGER := 4);
	port(
		clk : in STD_LOGIC;
		i0 : out STD_LOGIC_VECTOR(9 downto 0);
		i1 : out STD_LOGIC_VECTOR(9 downto 0);
		WE0 : out BOOLEAN;
		WE1 : out BOOLEAN;
		CSET0 : out STD_LOGIC;
		CSET1 : out STD_LOGIC;
		WE : out BOOLEAN;
        WA0  : out UNSIGNED(WAWIDTH-1 downto 0);	 
        WA1  : out UNSIGNED(WAWIDTH-2 downto 0);
		DI : out UNSIGNED(31 downto 0);
		VI : out BOOLEAN);
	end component;
 
  signal clk: std_logic:='0';
  signal i0,i1: std_logic_vector(9 downto 0);
  signal we0,we1: boolean;
  signal cset0,cset1: std_logic;
  signal wa0: unsigned(3 downto 0);
  signal wa1: unsigned(2 downto 0);
  signal di : unsigned(31 downto 0);
  signal vi : boolean;	
  signal re0,re1: boolean;
  signal ch0 : unsigned(3 downto 0);	 
  signal ch1 : unsigned(2 downto 0);
  signal doa,dob: STD_LOGIC_VECTOR(2*16-1 downto 0);
  signal voa,vob: boolean;
  
  
  begin	
	 
	clk <= not clk after 5 ns;
	  
	inst_bb_sym_16: bb_sym
	generic map(
		WAWIDTH => 4
	)
	port map(
		clk => clk,
		i0 => i0,
		i1 => i1,
		WE0 => we0,
		WE1 => we1,
		CSET0 => cset0,
		CSET1 => cset1,
		WE => open,
		WA0 => wa0,	
		WA1 => wa1,
		DI => di,
		VI => vi
	);
	
	
	inst_bb_16 : bb
	generic map(
		CHANNELS => 16,
		WAWIDTH => 4,
		DIWIDTH => 32,
		PHASE_SIZE => 12,
		NB_SRRC => 20,
		NB_FRACTINT => 18,
		FLOORPLAN => TRUE,
		OX => 0,
		OY => 0,
		DX => 0,
		DY => 0,
		C_SRRC_12 => C_SRRC_12,
		C_SRRC_18 => C_SRRC_18,
		C_FRACTINT => C_FRACTINT
	)
	port map(
		PCLK => clk,
		WA => wa0,
		DI => di,
		WE => we0,
		CLK => clk,
		CSET => cset0,
		RE => re0,
		CH => ch0,
		I => i0,
		VI => vi,
		O => doa,
		VO => voa
	);
	
--	inst_bb_8 : bb
--	generic map(
--		CHANNELS => 8,
--		WAWIDTH => 3,
--		DIWIDTH => 32,
--		PHASE_SIZE => 12,
--		NB_SRRC => 20,
--		NB_FRACTINT => 18,
--		FLOORPLAN => TRUE,
--		OX => 0,
--		OY => 0,
--		DX => 0,
--		DY => 0,
--		C_SRRC_12 => C_SRRC_12,
--		C_SRRC_18 => C_SRRC_18,
--		C_FRACTINT => C_FRACTINT
--	)
--	port map(
--		PCLK => clk,
--		WA => wa1,
--		DI => di,
--		WE => we0,
--		CLK => clk,
--		CSET => cset1,
--		RE => re1,
--		CH => ch1,
--		I => i1,
--		VI => vi,
--		O => dob,
--		VO => vob
--	);
	
end bb_tb_arch;
