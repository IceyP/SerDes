-----------------------------------------------------------------------------------------------
-- Copyright 2010 Xilinx, Inc. All rights reserved.
-- This file contains confidential and proprietary information of Xilinx, Inc. and is
-- protected under U.S. and international copyright and other intellectual property laws.
-----------------------------------------------------------------------------------------------
--
-- Disclaimer:
--		This disclaimer is not a license and does not grant any rights to the materials
--		distributed herewith. Except as otherwise provided in a valid license issued to you
--		by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE MATERIALS
--		ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
--		WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED
--		TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR
--		PURPOSE; and (2) Xilinx shall not be liable (whether in contract or tort, including
--		negligence, or under any other theory of liability) for any loss or damage of any
--		kind or nature related to, arising under or in connection with these materials,
--		including for any direct, or any indirect, special, incidental, or consequential
--		loss or damage (including loss of data, profits, goodwill, or any type of loss or
--		damage suffered as a result of any action brought by a third party) even if such
--		damage or loss was reasonably foreseeable or Xilinx had been advised of the
--		possibility of the same.
--
-- CRITICAL APPLICATIONS
--		Xilinx products are not designed or intended to be fail-safe, or for use in any
--		application requiring fail-safe performance, such as life-support or safety devices
--		or systems, Class III medical devices, nuclear facilities, applications related to
--		the deployment of airbags, or any other applications that could lead to death,
--		personal injury, or severe property or environmental damage (individually and
--		collectively, "Critical Applications"). Customer assumes the sole risk and
--		liability of any use of Xilinx products in Critical Applications, subject only to
--		applicable laws and regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES. 
--
--		Contact:    e-mail  hotline@xilinx.com        phone   + 1 800 255 7778
--   ____  ____
--  /   /\/   /
-- /___/  \  / 			Vendor:               Xilinx Inc.
-- \   \   \/ 			Version:              2.0
--  \   \        		Filename:             Table.v
--  /   /        		Date Last Modified:   14 July 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     TABLE
-- Purpose:         DDS (sinewave) lookup table values
--
-- Revision History: 
-- Revision 1.8  2010-Jul-25  Initial release (demo)
-- Revision 2.0  2010-Oct-01  First customer release
--
-------------------------------------------------------------------------------- 
--
-- Module Description:
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;

use work.COMPLEX_PKG.ALL;

--T use std.textio.all;

entity TABLE is -- LATENCY=3
  port(CLK:in STD_LOGIC;            -- System clock
       VI:in BOOLEAN:=TRUE;         -- Valid data in
       K:in UNSIGNED;               -- Input angle [0..2*Pi), the table holds only one quarter of a cosine period
       VO:out BOOLEAN;              -- Valid data out
       QO:out UNSIGNED(1 downto 0); -- Quadrant out
       W:out COMPLEX);              -- W=-Cos(2.0*Pi*K/N)-j*Sin(2.0*Pi*K/N), K=0..N/4-1
end TABLE;

architecture TEST of TABLE is
  constant N:INTEGER:=2**K'length;

  component UDELAY is
  generic(SIZE:INTEGER:=4;
          IWIDTH: INTEGER:=8);
  port(CLK:in STD_LOGIC;
       I:in UNSIGNED(IWIDTH-1 downto 0);
       O:out UNSIGNED(IWIDTH-1 downto 0));
  end component;

  component BDELAY
    generic(SIZE:INTEGER:=1);         -- Delay size 
    port(CLK:in STD_LOGIC;            -- System clock
         I:in BOOLEAN;                -- Boolean input
         O:out BOOLEAN);              -- Boolean output
  end component;
  
  component MINUS
    port(CLK:in STD_LOGIC;            -- System clock
         NEG:in BOOLEAN;              -- Negate input
         I:in UNSIGNED;               -- Unsigned data input
         O:out UNSIGNED);             -- Unsigned data output
  end component;
  
  type TLUT is array(0 to 2**(K'length-2)-1) of SIGNED(W'length/2-2 downto 0);
  function LUT_VALUE(N,SIZE:INTEGER) return TLUT is
    constant SCALE:INTEGER:=2**(SIZE-1);
    variable RESULT:TLUT;
  begin
    for J in 0 to N/4-1 loop
--      RESULT(J):=TO_SIGNED(-INTEGER(COS(-2.0*MATH_PI*REAL(J)/REAL(N))*REAL(SCALE)),SIZE);
      RESULT(J):=RESIZE(TO_SIGNED(-INTEGER(COS(-2.0*MATH_PI*REAL(J)/REAL(N))*REAL(SCALE)),SIZE+1),SIZE);
    end loop;
    return RESULT;
  end;

  signal LUT:TLUT:=LUT_VALUE(N,W'length/2-1);
  signal KC,KS:UNSIGNED(K'high-2 downto K'low);
--  signal CA,SA:UNSIGNED(K'high-2 downto K'low):=(others=>'0');
  signal MRC,MRS:SIGNED(W'length/2-2 downto 0):=(others=>'0');
  signal RC,RS:SIGNED(W'length/2-2 downto 0):=(others=>'0');
  signal KH1D,ZC,ZS,CZ,SZ:STD_LOGIC:='0';
  signal NEGC,NEGS:BOOLEAN;
-- prevent the DSP48s from swallowing the BRAM output registers
  attribute syn_keep:BOOLEAN;
--  attribute syn_keep of RC:signal is TRUE;
--  attribute syn_keep of RS:signal is TRUE;
begin
--T  process
--T    variable L: LINE;
--T    file FR: TEXT open write_mode is "table.txt";
--T  begin
--T    wait for 1.0 ns;
--T    for J in LUT'range loop
--T      Write( L, J, right, 4 ); 
--T      Write( L, TO_INTEGER("1"&LUT(J)), right, 8 ); 
--T      WriteLine( FR, L );
--T    end loop;
--T    wait;
--T  end process;

-- workaround for Synplicity bug  
--  process(CLK)
--  begin
--    if rising_edge(CLK) then
--      KC<=0-K;    -- this fails
----      KC<=K(K'high-1 downto K'low)&K(K'high);  -- this works
--    end if;  
--  end process;  
  NEGC<=K(K'high-1)='1';
  mc:MINUS port map(CLK=>CLK,
                    NEG=>NEGC,
                    I=>K(K'high-2 downto K'low),
                    O=>KC);
  NEGS<=K(K'high-1)='0';
  ms:MINUS port map(CLK=>CLK,
                    NEG=>NEGS,
                    I=>K(K'high-2 downto K'low),
                    O=>KS);
-- V4 BRAMs have a latency of 2
  process(CLK)
  begin
    if rising_edge(CLK) then
--      CA<=KC;
--      SA<=KS;
--      RC<=LUT(TO_INTEGER(CA));
--      RS<=LUT(TO_INTEGER(SA));
      MRC<=LUT(TO_INTEGER(KC));  -- cosine
      MRS<=LUT(TO_INTEGER(KS));  -- sine
      RC<=MRC;
      RS<=MRS;
    end if;  
  end process;
-- Fix the sign of S when K is 0
  process(CLK)
  begin
    if rising_edge(CLK) then
      KH1D<=K(K'high-1);
      if KC=0 then
        ZC<=not KH1D;
      else
        ZC<='1';
      end if;
      CZ<=ZC;
      if KS=0 then
        ZS<=KH1D;
      else
        ZS<='1';
      end if;
      SZ<=ZS;
    end if;
  end process;
  
  qd:UDELAY generic map(SIZE=>3,IWIDTH=>2)
            port map(CLK=>CLK,
                     I=>K(K'high downto K'high-1),
                     O=>QO);  

  vd:BDELAY generic map(SIZE=>3)
            port map(CLK=>CLK,
                     I=>VI,
                     O=>VO);  

--T  W<=TO_COMPLEX(SIGNED(CZ&RC),SIGNED(SZ&RS));
  W<=COMPLEX(SZ&SZ&STD_LOGIC_VECTOR(RS(RS'high-1 downto 0))&CZ&CZ&STD_LOGIC_VECTOR(RC(RC'high-1 downto 0)));
end TEST;