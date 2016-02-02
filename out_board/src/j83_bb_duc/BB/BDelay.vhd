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
-- \   \   \/ 			Version:              2.0
--  \   \        		Filename:             BDelay.v
--  /   /        		Date Last Modified:   08 Sept 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     BDELAY
-- Purpose:         Delay module (boolean)
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

library UNISIM;
use UNISIM.VComponents.all;

entity BDELAY is
  generic(SIZE:INTEGER:=1);
  port(CLK:in STD_LOGIC;
       I:in BOOLEAN;
       O:out BOOLEAN);
end BDELAY;

architecture TEST of BDELAY is
  attribute rloc:STRING;
  
  component BDELAY
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;
begin
  l0:if SIZE=0 generate
     begin
       O<=I;
     end generate;

  l1:if SIZE=1 generate
       signal iO:BOOLEAN:=FALSE;
     begin
       process(CLK)
       begin
         if rising_edge(CLK) then
           iO<=I;
         end if;
       end process;
       O<=iO;
     end generate;

  l17:if SIZE>=2 and SIZE<18 generate
        signal SI:STD_LOGIC;
        signal A:UNSIGNED(3 downto 0);
        signal Q:STD_LOGIC;
        signal RQ:STD_LOGIC:='0';
--        attribute rloc of sr:label is "X0Y0";
      begin
        A<=TO_UNSIGNED(SIZE-2,A'length);
        SI<='1' when I else '0';
        sr:SRL16E port map(CLK=>CLK,
                           CE=>'1',
                           A0=>A(0),
                           A1=>A(1),
                           A2=>A(2),
                           A3=>A(3),
                           D=>SI,
                           Q=>Q);
        process(CLK)
        begin
          if rising_edge(CLK) then
            RQ<=Q;
          end if;
        end process;
        O<=RQ='1';	
      end generate;

  ln:if SIZE>=18 generate
       signal IO:BOOLEAN;
     begin
       b17:BDELAY generic map(SIZE=>17)
                  port map(CLK=>CLK,
                           I=>I,
                           O=>IO);
       bn:BDELAY generic map(SIZE=>SIZE-17)
                 port map(CLK=>CLK,
                          I=>IO,
                          O=>O);
     end generate;
end TEST;