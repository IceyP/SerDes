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
-- \   \   \/ 			Version:              2.1
--  \   \        		Filename:             MIXBB.v
--  /   /        		Date Last Modified:   19 Oct 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     MIXBB
-- Purpose:         Top-level DDS module, Base-Band mixer, 1 output (unconstrained array ports)
--
-- Revision History: 
-- Revision 1.8  2010-Jul-25  Initial release (demo)
-- Revision 2.0  2010-Oct-01  First customer release
-- Revision 2.1  2010-Oct-19  New functional features added
--
-------------------------------------------------------------------------------- 
--
-- Module Description:
--   MIXBB is 16x overclocked (while MIX12 is 12x underclocked).
--   One input and one output port, both are 16x TDM interleaved, 16 channels.
--   The top level design has 12 instances of MIXBB to support 192 output slots.
--   MIXBB and MIX12 are similar and share some common code.
-- 
--   It is a DDS: a 16-channel phase accumulator, with noise dithering and a Sin/Cos BRAM LUT.
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.math_real.ALL;
use ieee.numeric_std.ALL;

use std.textio.all;

use work.COMPLEX_PKG.ALL;

entity MIXBB is -- LATENCY=4
  generic(CHANNELS:INTEGER:=16;
          WAWIDTH: INTEGER:=4;
          LUT_SIZE:INTEGER:=12);
  port(PCLK:in STD_LOGIC;
       WA:UNSIGNED(WAWIDTH-1 downto 0); -- UFix_4_0
       WE:in BOOLEAN;
       DI:UNSIGNED(31 downto 0); -- UFix_32_32
       CLK:in STD_LOGIC;
       I:in std_logic_vector(31 downto 0);
       VI:in BOOLEAN;
       O:out std_logic_vector(31 downto 0);
       VO:out BOOLEAN);
end MIXBB;

architecture TEST of MIXBB is
  attribute syn_hier:STRING;
  attribute syn_hier of all:architecture is "hard";
  attribute keep_hierarchy:STRING;
  attribute keep_hierarchy of all:architecture is "yes";

  component UDELAY is
  generic(SIZE:INTEGER:=4;
          IWIDTH: INTEGER:=8);
  port(CLK:in STD_LOGIC;
       I:in UNSIGNED(IWIDTH-1 downto 0);
       O:out UNSIGNED(IWIDTH-1 downto 0));
  end component;

  component TABLE -- LATENCY=3
    port(CLK:in STD_LOGIC;            -- System clock
         VI:in BOOLEAN:=TRUE;         -- Valid data in
         K:in UNSIGNED;               -- Input angle [0..2*Pi), the table holds only one quarter of a cosine period
         VO:out BOOLEAN;              -- Valid data out
         QO:out UNSIGNED(1 downto 0); -- Quadrant out
         W:out COMPLEX);              -- W=-Cos(2.0*Pi*K/N)-j*Sin(2.0*Pi*K/N), K=0..N/4-1
  end component;

  component CMULW -- LATENCY=4(5 when clipping)
    generic(ROUNDING:BOOLEAN:=TRUE;
            CLIP:BOOLEAN:=FALSE;
            SCALE:INTEGER:=4);
    port(CLK:in STD_LOGIC;          -- System clock
         I:in COMPLEX;              -- First complex input
         VI:in BOOLEAN:=TRUE;       -- Valid data in
         W:in COMPLEX;              -- Second complex input, rotated by 180 degrees
         Q:in UNSIGNED(1 downto 0); -- Quadrant for W
         CONJ:in BOOLEAN:=FALSE;    -- Conjugate W
         O:out COMPLEX;             -- Complex output
         VO:out BOOLEAN);           -- Valid data out
  end component;

  constant LHCA_SIZE:INTEGER:=10;

  type TMEM is array(0 to 2**WA'length-1) of UNSIGNED(DI'range);
  signal MEM:TMEM:=(others=>(others=>'0'));
--  signal RA:UNSIGNED(WA'range):=TO_UNSIGNED(1,WA'length);  -- UFix_4_0
  signal RA:UNSIGNED(WA'range):=TO_UNSIGNED(6,WA'length);  -- UFix_4_0

  signal F:UNSIGNED(DI'range):=(others=>'0');
  signal PH15D:UNSIGNED(DI'range);
  signal PH:UNSIGNED(DI'range):=(others=>'0');
  signal LHCA:UNSIGNED(LHCA_SIZE-1 downto 0):=(others=>'0');
  signal Q:UNSIGNED(1 downto 0);
  signal PHN:UNSIGNED(LUT_SIZE+LHCA_SIZE-1 downto 0):=(others=>'0');
  signal W,W2:COMPLEX(49 downto 0);
begin
  process(CLK)
  begin
    if rising_edge(CLK) then
      if VI then
        if RA=CHANNELS-1 then
          RA<=(others=>'0');
        else
          RA<=RA+1;
        end if;
      else
--        RA<=TO_UNSIGNED(1,RA'length);
        RA<=TO_UNSIGNED(6,RA'length);
      end if;
    end if;
  end process;

  process(PCLK)
  begin
    if rising_edge(PCLK) then
      if WE then
        MEM(TO_INTEGER(WA))<=DI;
      end if;
    end if;
  end process;

  process(CLK)
  begin
    if rising_edge(CLK) then
      F<=MEM(TO_INTEGER(RA));
    end if;
  end process;

  process(CLK)
  begin
    if rising_edge(CLK) then
      PH<=PH15D+F;
      LHCA<=SHIFT_LEFT(LHCA,1) xor SHIFT_RIGHT(LHCA,1) xor (LHCA and "1111010111") xor UNSIGNED(PH(LHCA'range));
      PHN<=PH(PH'high downto PH'high-PHN'length+1)+RESIZE(LHCA,PHN'length);
    end if;
  end process;
                     
--  ud:UDELAY generic map(SIZE=>15,IWIDTH=32)
--            port map(CLK=>CLK,
--                     I=>PH,
--                     O=>PH15D);
--                     

  inst_udelay:
  UDELAY
  generic map(
    SIZE => 15,
	 IWIDTH => 32)
  port map(
    CLK => CLK,
	 I => PH,
	 O => PH15D);
	 
  tb:TABLE port map(CLK=>CLK,
                    VI=>TRUE,
                    K=>PHN(PHN'high downto PHN'high-LUT_SIZE+1),
                    VO=>open,
                    QO=>Q,
                    W=>W);

--  W2<=SHIFT_RIGHT(W,1);
  mw:CMULW generic map(ROUNDING=>TRUE,
                       SCALE=>3)
           port map(CLK=>CLK,
                    I=>I,
                    VI=>VI,
                    W=>W,
                    Q=>Q,
                    CONJ=>FALSE,
                    O=>O,
                    VO=>VO);
end TEST;