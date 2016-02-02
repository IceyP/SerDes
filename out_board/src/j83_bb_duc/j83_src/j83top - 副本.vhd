---------------------------------------------------------------------------------------------------
--
-- Title       : behave
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : J83Top.vhd
-- Generated   : Sun Apr 29 15:01:39 2012
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

entity J83Top is
     generic(
         DLY_CYCLE_NUM : integer :=2
         );
	 port(
		 clk : in STD_LOGIC;
		 rst : in std_logic;				   
		 ren : in STD_LOGIC;            -------duc_rden
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 mode : in std_logic_vector( 3 downto 0 );
		 ce : out STD_LOGIC;            -------ts_valid
		 systemce : out std_logic;      
		 frame : out STD_LOGIC;         -------ts_sync
		 IQ : out STD_LOGIC_VECTOR(9 downto 0)
	     );
end J83Top;

--}} End of automatically maintained section

architecture behave of J83Top is   

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
	
	component rsenc
	port(
		reset : in std_logic;
		clk : in std_logic;
		clear : in std_logic;
		en : in std_logic;
		im : in std_logic;
		din : in std_logic_vector(7 downto 0);
		oe : out std_logic;
		dout : out std_logic_vector(7 downto 0) 
		);
	end component; 
	
	component random
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 frame8 : in STD_LOGIC;
		 ce : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 frame : in STD_LOGIC;
		 Q : out STD_LOGIC_VECTOR(7 downto 0)
	     );
	end component; 
	
	component timing
	 port(
		 empty : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 frame8 : out STD_LOGIC;
		 frame : out STD_LOGIC;
		 im : out STD_LOGIC;
		 ce : out STD_LOGIC
	     );
	end component;
	
	component QAM
	 port(
		 clk : in STD_LOGIC;
		 rst : in std_logic;				   
		 ren : in STD_LOGIC;
		 msb : in STD_LOGIC_VECTOR(1 downto 0);
		 flsb : in STD_LOGIC_VECTOR(6 downto 0);
		 ceo : out STD_LOGIC;
		 iq : out STD_LOGIC_VECTOR(9 downto 0)
	     );
	end component;
	
	component B2MT
	 port(
		 wr : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 rst : in std_logic;				   
		 rd : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 mode : in STD_LOGIC_VECTOR(3 downto 0);
		 halfEmpty : out std_logic;
		 wrbusy : out STD_LOGIC;
		 rdbusy : out STD_LOGIC;
		 msb : out STD_LOGIC_VECTOR(1 downto 0);
		 flsb : out STD_LOGIC_VECTOR(6 downto 0)
	     );
	end component;

signal ILout : std_logic_vector(7 downto 0) := (others=>'0'); 
signal msb : std_logic_vector(1 downto 0) := (others=>'0'); 
signal flsb : std_logic_vector(6 downto 0) := (others=>'0'); 
signal RSout : std_logic_vector(7 downto 0) := (others=>'0'); 
signal RNout : std_logic_vector(7 downto 0) := (others=>'0'); 
signal syce : std_logic :='0';
signal im : std_logic :='0';
signal imRS : std_logic :='0';
signal wr : std_logic :='0';
signal rd : std_logic :='0';
signal frame8 : std_logic :='0';
signal frameRN : std_logic :='0';
signal frameRS : std_logic :='0';
signal frameIL : std_logic :='0';
signal frameInt : std_logic :='0';
signal frameD1 : std_logic :='0';
signal bufhalf : std_logic :='0';
signal im_dly  : std_logic_vector(DLY_CYCLE_NUM-1 downto 0) := (others=>'0');
signal frameInt_dly  : std_logic_vector(DLY_CYCLE_NUM-1 downto 0) := (others=>'0');
signal syce_dly  : std_logic_vector(DLY_CYCLE_NUM-1 downto 0) := (others=>'0');
signal frame8_dly  : std_logic_vector(DLY_CYCLE_NUM-1 downto 0) := (others=>'0');

begin

	 -- enter your statements here --
ARandom : random
	 port map(
		 clk =>clk,
		 rst => rst,
		 frame8 => frame8_dly(DLY_CYCLE_NUM-1),
		 ce => im_dly(DLY_CYCLE_NUM-1),
		 D => D,
		 frame => frameRN,
		 Q => RNout
	     );
	
ARSencoder : rsenc
	port map(
		reset => rst,
		clk => clk,
		clear => frameRS,
		en => syce_dly(DLY_CYCLE_NUM-1),
		im => imRS,
		din => RNout,
		dout => RSout
		);			 		
		
AInterleaver : il
	port map(
		frame => frameIL,
		clk => clk,
		rst => rst,
		ce => syce_dly(DLY_CYCLE_NUM-1),
		D => RSout,
		ceo => wr,
		Q => ILout );

ASysTiming : timing
	 port map(
		 empty => bufhalf,
		 clk => clk,
		 rst => rst,
		 frame8 => frame8,
		 frame => frameInt,
		 im => im,
		 ce => syce
	     );		 	
		 
AByteToMTuple : B2MT
	 port map(
		 clk => clk,
		 rst => rst,
		 rd => rd,
		 wr => wr,
		 D => ILout,
		 mode => mode,
		 halfEmpty => bufhalf,
		 msb => msb,
		 flsb => flsb
	     );			 	   
		 
AQAMMap : QAM
	 port map(
		 clk => clk,
		 rst => rst,
		 ren => ren,
		 msb => msb,
		 flsb => flsb,
		 ceo => rd,
		 iq => iq
	     );		 	
		 
frameRN<=frameInt_dly(DLY_CYCLE_NUM-1);
frame<=frameInt;
ce<=im;
systemce<=syce;

dlyProc:process(clk,rst)
begin
	if rst='1' then
	    im_dly  <= (others=>'0');
	    frameInt_dly  <= (others=>'0');
	    syce_dly  <= (others=>'0');
	    frame8_dly  <= (others=>'0');
	elsif rising_edge(clk) then
	    im_dly <= im_dly(DLY_CYCLE_NUM-2 downto 0) & im;
	    frameInt_dly <= frameInt_dly(DLY_CYCLE_NUM-2 downto 0) & frameInt;
	    syce_dly <= syce_dly(DLY_CYCLE_NUM-2 downto 0) & syce;
	    frame8_dly <= frame8_dly(DLY_CYCLE_NUM-2 downto 0) & frame8;
	end if;
end process;

RSIMGEN:process(clk,rst)
begin
	if rst='1' then
		imRS<='0';
		frameRS<='0';
	elsif rising_edge(clk) then
		if syce_dly(DLY_CYCLE_NUM-1)='1' then
			imRS<=im_dly(DLY_CYCLE_NUM-1);
			frameD1<=frameInt_dly(DLY_CYCLE_NUM-1);
			frameIL<=frameInt_dly(DLY_CYCLE_NUM-1);		 
		end if;
		frameRS<=frameInt_dly(DLY_CYCLE_NUM-1);
	end if;
end process;

end behave;
