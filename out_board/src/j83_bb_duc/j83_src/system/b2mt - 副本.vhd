---------------------------------------------------------------------------------------------------
--
-- Title       : B2MT
-- Design      : J83
-- Author      : Microsoft
-- Company     : Microsoft
--
---------------------------------------------------------------------------------------------------
--
-- File        : B2MT.vhd
-- Generated   : Sun Apr 29 15:17:29 2012
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
--{entity {B2MT} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

entity B2MT is
	 port(
		 clk : in STD_LOGIC;
		 rst : in std_logic;				   
		 wr : in STD_LOGIC;
		 rd : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(7 downto 0);
		 mode : in STD_LOGIC_VECTOR(3 downto 0);
		 wrbusy : out STD_LOGIC;
		 rdbusy : out STD_LOGIC;
		 halfEmpty : out std_logic;
		 msb : out STD_LOGIC_VECTOR(1 downto 0);
		 flsb : out STD_LOGIC_VECTOR(6 downto 0)
	     );
	----fanout constraint
	--attribute max_fanout: string;
    --attribute max_fanout of flsb    :signal is "2";
end B2MT;

--}} End of automatically maintained section

architecture behave of B2MT is	 

signal fifowe,fiford,empty,full : std_logic;
signal din,dout : std_logic_vector(1 downto 0);
signal dn : std_logic_vector(5 downto 0);		-- data number

signal mtuple: std_logic_vector( 7 downto 0 );
signal bits : std_logic_vector( 7 downto 0 );

signal rdState : integer range 0 to 7;
signal wrState : integer range 0 to 7;
signal fifo_rd_d : std_logic;
signal b_cnt : std_logic_vector(3 downto 0);

component fifo is
	generic(
		DEPTH		: natural;
		AWIDTH		: natural;
		DWIDTH		: natural;
		RAM_TYPE	: string	  			-- "BLOCK_RAM" or "DIS_RAM"
		);
	port(
		reset	: in std_logic;
		clk		: in std_logic;
		clr		: in std_logic;
		we		: in std_logic;
		din		: in std_logic_vector(DWIDTH - 1 downto 0);
		rd		: in std_logic;
		dout	: out std_logic_vector(DWIDTH - 1 downto 0); 
		empty	: out std_logic;
		full	: out std_logic;
		dn		: out std_logic_vector(AWIDTH -1 downto 0)		-- data number
		);
end component;
begin

	 -- enter your statements here --
AFIFO : fifo 
	generic map(
		DEPTH => 64,
		AWIDTH => 6,
		DWIDTH => 2,
		RAM_TYPE =>"DIS_RAM"
		)
	port map(
		reset	=> rst,
		clk	=>clk,
		clr	=>'0',
		we	=> fifowe,
		din	=> din,
		rd	=> fiford,
		dout => dout,
		empty => empty,
		full => full,
		dn	=> dn
		); 
		
halfEmpty<=not dn(5);
FLSBP:process( clk,rst )
begin				  
	if rst='1' then
		flsb<=(others=>'0');
		msb<=(others=>'0');
	elsif rising_edge(clk) then
		if rd='1' then
			case mode is
				when "0100" => 
					flsb<="00001"&mtuple( 1 downto 0 );
					msb<=mtuple( 3 downto 2 );
				when "0101" => 
					flsb<="0001"&mtuple( 2 downto 0 );
					msb<=mtuple( 4 downto 3 );
				when "0110" => 
					flsb<="001"&mtuple( 3 downto 0 );
					msb<=mtuple( 5 downto 4 );
				when "0111" => 
					flsb<="01"&mtuple( 4 downto 0 );
					msb<=mtuple( 6 downto 5 );
				when "1000" => 
					flsb<="1"&mtuple( 5 downto 0 );	
					msb<=mtuple( 7 downto 6 );
				when others => 
					flsb<="001"&mode; --for single freq test mode 
					msb<=(others=>'0');
			end case;
		end if;
	end if;
end process;

wrP : process( clk, rst )
begin
	if rst='1' then
		bits<=(others=>'0');
		b_cnt<="0000";
	elsif rising_edge(clk) then
		if wr='1' then
		  if b_cnt=conv_integer(mode)-1 then
		    b_cnt<="0000";
		  else
		     b_cnt<=b_cnt+1;
		  end if;
			bits( 7 downto 0 )<=D;
		end if;
		
		if wr='1' then
			wrState<=7;		   
			fifowe<='1';
		elsif wrState/=0 then
			wrState<=wrState-1;
			fifowe<='1';
		else
			fifowe<='0';
		end if;
	end if;
end process;

din(0)<=bits( wrState );
din(1)<= '1' when b_cnt=conv_integer( mode )-1 and wrState=7 else '0';

rdP : process( clk, rst )
begin
	if rst='1' then
		mtuple<=(others=>'0');
		fifo_rd_d<='0';
	elsif rising_edge(clk) then
	  fifo_rd_d<=fiford;
		if rd='1' then
			rdState<=0;		   
			fiford<='1';
		elsif rdState>1 and dout(1)='1' and fifo_rd_d='1' then
		  rdState<=2;
		  fiford<='1';
		elsif rdState/=conv_integer( mode )-1 then
			rdState<=rdState+1;
			fiford<='1';
		else
			fiford<='0';
		end if;
		if fifo_rd_d='1' then
			mtuple<=mtuple(6 downto 0) & dout(0);
		end if;	 
	end if;
end process;
end behave;

