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
--  \   \        		Filename:             GAIN.v
--  /   /        		Date Last Modified:   09 Sept 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     GAIN
-- Purpose:         Input gain control module
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
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.math_real.ALL;
use ieee.numeric_std.ALL;

use std.textio.all;

use work.COMPLEX_PKG.ALL;

entity GAIN is -- LATENCY=3
  generic(CHANNELS:INTEGER:=16;
          WAWIDTH: INTEGER:=4);
  port(PCLK:in STD_LOGIC;
       WA:UNSIGNED(WAWIDTH-1 downto 0); -- UFix_4_0
       WE:in BOOLEAN;
       DI:UNSIGNED(17 downto 0); -- UFix_16_16
       CLK:in STD_LOGIC;
       I:in std_logic_vector(31 downto 0);
       VI:in BOOLEAN;
       O:out std_logic_vector(31 downto 0);
       VO:out BOOLEAN);
end GAIN;

architecture TEST of GAIN is
  attribute syn_hier:STRING;
  attribute syn_hier of all:architecture is "hard";
  attribute keep:STRING;
  attribute keep_hierarchy:STRING;
  attribute keep_hierarchy of all:architecture is "yes";

  component BDELAY -- LATENCY=SIZE
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;

  constant LHCA_SIZE:INTEGER:=10;
  constant LUT_SIZE:INTEGER:=12;

  type TMEM is array(0 to 2**WA'length-1) of UNSIGNED(DI'range);
  signal MEM:TMEM:=(others=>(others=>'0'));
  signal RA:UNSIGNED(WA'range):=TO_UNSIGNED(1,WA'length);  -- UFix_4_0

  signal G:UNSIGNED(DI'range):=(others=>'0');
  attribute keep of G : signal is "yes";
--  signal A:COMPLEX(I'range):=(others=>'0');
--  signal B:SIGNED(17 downto 0):=(others=>'0');
--  signal C:COMPLEX(95 downto 0):=TO_COMPLEX(2**(DI'length-1),2**(DI'length-1),48);
--  signal M:COMPLEX(A'length+2*B'length-1 downto 0):=(others=>'0');
--  signal P:COMPLEX(95 downto 0):=(others=>'0');
  signal ORE,OIM:SIGNED(47 downto 0):=(others=>'0');
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
        RA<=TO_UNSIGNED(1,RA'length);
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
      G<=MEM(TO_INTEGER(RA));
    end if;
  end process;

--  process(CLK)
--  begin
--    if rising_edge(CLK) then
--      A<=I;
--      B<=SIGNED(RESIZE(G,B'length));
--      M<=A*B;
--      P<=C+RESIZE(M,P'length/2);
--    end if;
--  end process;
--  O<=RESIZE(SHIFT_RIGHT(TO_COMPLEX(ORE,OIM),DI'length),O'length/2);
  dspi:block
         signal A:SIGNED(I'length/2-1 downto 0):=(others=>'0');
         signal B:SIGNED(17 downto 0):=(others=>'0');
--18         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length-1),48);
--         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length+1),48);
         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length-3),48);
         signal M:SIGNED(A'length+B'length-1 downto 0):=(others=>'0');
         signal P:SIGNED(47 downto 0):=(others=>'0');
       begin
         process(CLK)
         begin
           if rising_edge(CLK) then
             A<=RE(I);
             B<=SIGNED(RESIZE(G ,B'length)); --6db
             M<=A*B;
             P<=C+RESIZE(M,P'length);
           end if;
         end process;
         ORE<=P;
       end block;
  dspq:block
         signal A:SIGNED(I'length/2-1 downto 0):=(others=>'0');
         signal B:SIGNED(17 downto 0):=(others=>'0');
--18         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length-1),48);
--         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length+1),48);
         signal C:SIGNED(47 downto 0):=TO_SIGNED(2**(DI'length-3),48);
         signal M:SIGNED(A'length+B'length-1 downto 0):=(others=>'0');
         signal P:SIGNED(47 downto 0):=(others=>'0');
       begin
         process(CLK)
         begin
           if rising_edge(CLK) then
             A<=IM(I);
             B<=SIGNED(RESIZE(G ,B'length)); --6db
             M<=A*B;
             P<=C+RESIZE(M,P'length);
           end if;
         end process;
         OIM<=P;
       end block;
--18  O<=RESIZE(SHIFT_RIGHT(TO_COMPLEX(ORE,OIM),DI'length),O'length/2);
--  O<=RESIZE(SHIFT_RIGHT(TO_COMPLEX(ORE,OIM),DI'length+2),O'length/2);
  O<=RESIZE(SHIFT_RIGHT(TO_COMPLEX(ORE,OIM),DI'length-2),O'length/2);

  bd:BDELAY generic map(SIZE=>3)
            port map(CLK=>CLK,
                     I=>VI,
                     O=>VO);

end TEST;
