library ieee;
use ieee.std_logic_1164.ALL;
use ieee.math_real.ALL;
use ieee.numeric_std.ALL;

use std.textio.all;

use work.COMPLEX_PKG.ALL;

entity bb_sym is
  generic(WAWIDTH : integer := 4);
  port(
  clk : in std_logic;
  i0  : out std_logic_vector(9 downto 0);
  i1  : out std_logic_vector(9 downto 0);
  WE0 : out BOOLEAN;
  WE1 : out BOOLEAN;
  CSET0: out std_logic;
  CSET1: out std_logic;
  WE  : out BOOLEAN;
  WA0  : out UNSIGNED(WAWIDTH-1 downto 0);	 
  WA1  : out UNSIGNED(WAWIDTH-2 downto 0);
  DI  : out UNSIGNED(31 downto 0);
  VI  : out BOOLEAN
  --WA  : out unsigned
  );
end entity;

architecture bb_sym_arch of bb_sym is	
signal LFSR0 : UNSIGNED(39 downto 0) := (0=>'0',others=>'1');  
signal LFSR1 : UNSIGNED(39 downto 0) := (1=>'0',others=>'1'); 
signal WE_TEMP : BOOLEAN:=FALSE;
signal WA_TEMP : UNSIGNED(9 downto 0):=(others=>'0');
signal DI_TEMP : UNSIGNED(31 downto 0):=(others=>'0'); 
signal VI_TEMP : BOOLEAN:=FALSE; 
signal CSET : std_logic_vector(11 downto 0):=(others=>'0');

begin 
  WE <= WE_TEMP;
  WA0 <= WA_TEMP(WAWIDTH-1 downto 0);
  WA1 <= WA_TEMP(WAWIDTH-2 downto 0);
  DI <= DI_TEMP;
  VI <= VI_TEMP;
  WE0 <= WE_TEMP and (WA_TEMP(9 downto 8)=0) and (WA_TEMP(7 downto 4)=0);
  WE1 <= WE_TEMP and (WA_TEMP(9 downto 8)=0) and (WA_TEMP(7 downto 4)=1);
  CSET0 <= CSET(0);
  CSET1 <= CSET(1);
  
  i0_gen:
  process(clk)
  begin
    if rising_edge(clk) then
      LFSR0 <=(LFSR0 and X"7FFFFFFFBB") xor SHIFT_LEFT(LFSR0,1) xor SHIFT_RIGHT(LFSR0,1);  
	  LFSR1 <=(LFSR1 and X"7FFFFFFFBB") xor SHIFT_LEFT(LFSR1,1) xor SHIFT_RIGHT(LFSR1,1);
      i0 <= std_logic_vector(LFSR0(i0'range)) or "0000100001";	
	  i1 <= std_logic_vector(LFSR1(i1'range)) or "0000100001";
    end if;
  end process;
---end bb_sym_arch;	 

  process(clk)
  begin
	if rising_edge(clk) then
	  if WE_TEMP and (WA_TEMP(9 downto 8)=3) and (WA_TEMP(7 downto 4)=9) then
         CSET<=std_logic_vector(DI_TEMP(CSET'range));
	  end if;
	end if;
  end process;
  
	  
  process
--    constant fb6:REAL:=5.360537;
--    constant fb7:REAL:=6.23; -- 6.253960
--    constant fb8:REAL:=6.952; -- 7.147383
--    constant fbh:REAL:=8.0;
    variable L:LINE;
    file F:TEXT;
    variable CH:CHARACTER;
    variable N,K:INTEGER;
    variable R,G,FO,FI:REAL;
  begin
    file_open(F,"channel1.txt",READ_MODE);
    WE_TEMP<=TRUE;
    while not ENDFILE(F) loop
      readline(F,L);
      CH:=';';
      read(L,CH);
      case CH is
        when 'B'=>read(L,N);
                  read(L,R);
                  read(L,G);
                  read(L,FI);
-- Input Rate
                  WA_TEMP<=TO_UNSIGNED(0*256+N,WA_TEMP'length);
                  DI_TEMP<=TO_UNSIGNED(INTEGER((R/12.0)*2.0**31),DI_TEMP'length-1)&"1";
                  wait until rising_edge(clk);
---- Input Gain
                  WA_TEMP<=TO_UNSIGNED(1*256+N,WA_TEMP'length);
                  DI_TEMP<=TO_UNSIGNED(INTEGER(10.0**(-G/20.0)*2.0**16-1.0),DI_TEMP'length);
                  wait until rising_edge(clk);
---- Input Mixer Frequency
                  WA_TEMP<=TO_UNSIGNED(2*256+N,WA_TEMP'length);
                  DI_TEMP<=UNSIGNED(TO_SIGNED(INTEGER(FI/24.0*2.0**DI_TEMP'length),DI_TEMP'length));
                  wait until rising_edge(clk);
        when 'S'=>read(L,K);
-- Programmable Channel Switch
                  read(L,N);
--                  read(L,G);
--                  read(L,FI);
                  WA_TEMP<=TO_UNSIGNED(3*256+(K+256) mod 256,WA_TEMP'length);
                  DI_TEMP<=TO_UNSIGNED(N+256,DI_TEMP'length);
                  wait until rising_edge(clk);
-- Input Gain
--                  WA_TEMP<=TO_UNSIGNED(1*256+(K+256) mod 256,WA_TEMP'length);
--                  DI_TEMP<=TO_UNSIGNED(INTEGER(10.0**(-G/20.0)*2.0**16-1.0),DI_TEMP'length);
--                  wait until rising_edge(clk);
-- Input Mixer Frequency
--                  WA_TEMP<=TO_UNSIGNED(2*256+(K+256) mod 256,WA_TEMP'length);
--                  DI_TEMP<=UNSIGNED(TO_SIGNED(INTEGER(FI/24.0*2.0**DI_TEMP'length),DI_TEMP'length));
--                  wait until rising_edge(clk);
        when 'C'=>read(L,N);
-- FFT scale factor
                  WA_TEMP<=TO_UNSIGNED(3*256+6*16+0,WA_TEMP'length);
                  DI_TEMP<=TO_UNSIGNED(N,DI_TEMP'length);
                  wait until rising_edge(clk);
        when 'O'=>read(L,FO);
-- Output Mixer Frequency
                  WA_TEMP<=TO_UNSIGNED(3*256+7*16+0,WA_TEMP'length);
                  DI_TEMP<=UNSIGNED(TO_SIGNED(INTEGER(FO/4608.0*2.0**DI_TEMP'length),DI_TEMP'length));
                  wait until rising_edge(clk);
        when 'A'=>read(L,N);
-- Output Amplitude
                  WA_TEMP<=TO_UNSIGNED(3*256+8*16+0,WA_TEMP'length);
                  DI_TEMP<=UNSIGNED(TO_SIGNED(N,DI_TEMP'length));
                  wait until rising_edge(clk);
        when others=>null;
      end case;
    end loop;
    WE_TEMP<=FALSE;
    DI_TEMP<=(others=>'0');
    WA_TEMP<=TO_UNSIGNED(0,WA_TEMP'length);
    VI_TEMP<=TRUE;
    wait;
--D
--    I<=(others=>(others=>'0'));
--    for K in 1 to 10 loop
--      wait until RE(0) and rising_edge(clk);
--    end loop;
--    I<=(others=>"0000001110");
--    wait until RE(0) and rising_edge(clk);
--    I<=(others=>(others=>'0'));
--D
    wait for 10 us;
    WE_TEMP<=TRUE;
    for N in 0 to 159 loop
      WA_TEMP<=TO_UNSIGNED(0*256+N,WA_TEMP'length);
      DI_TEMP<=TO_UNSIGNED(2**30,DI_TEMP'length-1)&"0";
      wait until rising_edge(clk);
    end loop;
    for K in -96 to 95 loop
      WA_TEMP<=TO_UNSIGNED(3*256+(K+256) mod 256,WA_TEMP'length);
      DI_TEMP<=TO_UNSIGNED(0,DI_TEMP'length);
      wait until rising_edge(clk);
-- Input Gain
      WA_TEMP<=TO_UNSIGNED(1*256+(K+256) mod 256,WA_TEMP'length);
      DI_TEMP<=TO_UNSIGNED(0,DI_TEMP'length);
      wait until rising_edge(clk);
-- Input Mixer Frequency
      WA_TEMP<=TO_UNSIGNED(2*256+(K+256) mod 256,WA_TEMP'length);
      DI_TEMP<=UNSIGNED(TO_SIGNED(0,DI_TEMP'length));
      wait until rising_edge(clk);
    end loop;
    WE_TEMP<=FALSE;
    wait;
  end process; 
end bb_sym_arch;

