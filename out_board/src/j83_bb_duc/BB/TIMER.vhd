-----------------------------------------------------------------------------------------------
-- © Copyright 2010 Xilinx, Inc. All rights reserved.
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
--  \   \        		Filename:             TIMER.v
--  /   /        		Date Last Modified:   14 Otc 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     TIMER
-- Purpose:         
--
-- Revision History: 
-- Revision 1.8  2010-Jul-25  Initial release (demo)
-- Revision 2.0  2010-Oct-01  First customer release
-- Revision 2.1  2010-Oct-14  New functional features added
--
-------------------------------------------------------------------------------- 
--
-- Module Description:
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

use work.COMPLEX_PKG.ALL;

entity TIMER is -- LATENCY=2
  generic(CHANNELS:INTEGER:=16;
          WAWIDTH: INTEGER:=4;---log2(CHANNELS)
   		  DIWIDTH: INTEGER:=32;
		  PWIDTH : INTEGER:=12
  );
  port(PCLK:in STD_LOGIC;
       WA:in UNSIGNED(WAWIDTH-1 downto 0);  -- UFix_4_0
       DI:in UNSIGNED(DIWIDTH-1 downto 0); -- UFix_32_32
       WE:in BOOLEAN;
       CLK:in STD_LOGIC;
       RA:in UNSIGNED(WAWIDTH-1 downto 0);  -- UFix_4_0
       PHASE:out UNSIGNED(PWIDTH-1 downto 0);  -- UFix_12_0
       EN_SYMB,EN_SYMB_2x,IEN:out BOOLEAN);
end TIMER;

architecture TEST of TIMER is
  attribute keep_hierarchy:STRING;
  attribute keep_hierarchy of all:architecture is "yes";
  attribute syn_hier:STRING;
  attribute syn_hier of all:architecture is "hard";
 
  component UDELAY -- LATENCY=SIZE
    generic(SIZE:INTEGER:=1;
	        IWIDTH: INTEGER:=8);
    port(CLK:in STD_LOGIC;
         I:in UNSIGNED(IWIDTH-1 downto 0);
         O:out UNSIGNED(IWIDTH-1 downto 0));
  end component;

  component BDELAY
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;

  type TMEM is array(0 to CHANNELS-1) of UNSIGNED(DI'range);
  signal MEM:TMEM:=(others=>(others=>'0'));
  signal DO:UNSIGNED(DI'range):=(others=>'0');
  signal ACC:UNSIGNED(DI'length downto 0):=(others=>'0');
  signal ACC15D:UNSIGNED(DO'range);
  signal EN,EN16D:BOOLEAN;
begin
  assert WA'length=RA'length report "WA and RA ports must be the same size!" severity error;
  assert (CHANNELS<=2**WA'length) and (2**(WA'length-1)<CHANNELS) report "Inconsistent CHANNELS value and WA port size!" severity error;

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
      DO<=MEM(TO_INTEGER(RA));
    end if;
  end process;

  ud:UDELAY generic map(SIZE=>15,
                        IWIDTH=>ACC15D'length)
            port map(CLK=>CLK,
                     I=>ACC(ACC15D'range),
                     O=>ACC15D);

  process(CLK)
  begin
    if rising_edge(CLK) then
      ACC<=RESIZE(ACC15D,ACC'length)+RESIZE(SHIFT_LEFT(SHIFT_RIGHT(DO,1),1),ACC'length);
      IEN<=DO(DO'low)='1';
    end if;
  end process;
  PHASE<=ACC(ACC'high-1 downto ACC'high-PHASE'length);
  
  EN<=(ACC(ACC'high)='1') xor EN16D;
  bd:BDELAY generic map(SIZE=>16)
            port map(CLK=>CLK,
                     I=>EN,
                     O=>EN16D);

  EN_SYMB<=EN and (ACC(ACC'high)='1');
  EN_SYMB_2x<=ACC(ACC'high)='1';
end TEST;