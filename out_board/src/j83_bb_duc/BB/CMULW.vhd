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
--  \   \        		Filename:             CMULW.v
--  /   /        		Date Last Modified:   11 Aug 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     CMULW
-- Purpose:         Complex multiplier module
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

use work.COMPLEX_PKG.ALL;

entity CMULW is -- LATENCY=4(5 when clipping)
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
       CLIPO:out BOOLEAN;         -- Clip out
       VO:out BOOLEAN);           -- Valid data out
--  generic(ROUNDING:BOOLEAN:=FALSE);
--  port(CLK:in STD_LOGIC;          -- System clock
--       VI:in BOOLEAN:=TRUE;       -- Valid data in
--       X:in COMPLEX(35 downto 0);              -- First complex input
--       Q:in UNSIGNED(1 downto 0); -- Quadrant for W
--       CONJ:in BOOLEAN:=FALSE;    -- Conjugate W
--       W:in COMPLEX(35 downto 0);              -- Second complex input, rotated by 180 degrees
--       VO:out BOOLEAN;            -- Valid data out
--       Y:out COMPLEX(35 downto 0));            -- Complex output
end CMULW;

architecture TEST of CMULW is
  component BDELAY
    generic(SIZE:INTEGER:=1);         -- Delay size 
    port(CLK:in STD_LOGIC;            -- System clock
         I:in BOOLEAN;                -- Boolean input
         O:out BOOLEAN);              -- Boolean output
  end component;
  
  signal Q1D:UNSIGNED(Q'range):="00";
  signal CONJ1D:BOOLEAN:=FALSE;
  signal R:SIGNED(I'length/2+W'length/2-1 downto 0);
  signal RRE2D,RIM2D:SIGNED(R'range):=(others=>'0');
  signal I1D,I2D:COMPLEX(I'range):=(others=>'0');
  signal W1D,W2D:COMPLEX(W'range):=(others=>'0');
  signal SRR1D,SRI1D,SIR2D,SII2D:BOOLEAN:=FALSE;
  signal SRR2D,SRI2D,SIR3D,SII3D:BOOLEAN:=FALSE;
  signal PRR2D,PRI2D,PIR3D,PII3D:SIGNED(I'length/2+W'length/2-1 downto 0):=(others=>'0');
  signal SRE3D,SIM3D:SIGNED(R'range):=(others=>'0');
  signal ORE4D,OIM4D:SIGNED(R'range):=(others=>'0');
-- prevent SynplifyPro from messing up port C
  attribute syn_keep:BOOLEAN;
  attribute syn_keep of R:signal is TRUE;
begin
  assert O'length>=I'length report "The length of port O cannot be shorter than the length of port I" severity error;

  process(CLK)
  begin
    if rising_edge(CLK) then
      Q1D<=Q;
      CONJ1D<=CONJ;
      case Q is
        when "00"|"11"=>SRR1D<=TRUE;
        when others=>SRR1D<=FALSE;
      end case;
      if (Q(1)='1') xnor CONJ then
        SRI1D<=TRUE;
      else
        SRI1D<=FALSE;
      end if;
      if (Q1D(1)='1') xor CONJ1D then
        SII2D<=TRUE;
      else
        SII2D<=FALSE;
      end if;
      case Q1D is
        when "00"|"11"=>SIR2D<=TRUE;
        when others=>SIR2D<=FALSE;
      end case;
      SRR2D<=SRR1D;
      SRI2D<=SRI1D;
      SIR3D<=SIR2D;
      SII3D<=SII2D;
    end if;
  end process;
-- All this maps to 4 DSP48s
--T  R<=TO_SIGNED(2**(W'length/2-2),R'length) when ROUNDING else TO_SIGNED(0,R'length);
--  R<=TO_SIGNED(2**(W'length/2-4),R'length) when ROUNDING else TO_SIGNED(0,R'length);
--?  R<=TO_SIGNED(2**(W'length/2+I'length/2-O'length/2-4),R'length) when ROUNDING else TO_SIGNED(0,R'length);
  R<=TO_SIGNED(2**(W'length/2+I'length/2-O'length/2-SCALE),R'length) when ROUNDING else TO_SIGNED(0,R'length);
  process(CLK)
  begin
    if rising_edge(CLK) then
      I1D<=I;
      W1D<=W;
      I2D<=I1D;
      W2D<=W1D;
      RRE2D<=R;
      RIM2D<=R;
      PRR2D<=RE(I1D)*RE(W1D);
      PRI2D<=RE(I1D)*IM(W1D);
      if SRR2D then
        SRE3D<=RRE2D-PRR2D;
      else
        SRE3D<=RRE2D+PRR2D;
      end if;
      if SRI2D then
        SIM3D<=RIM2D-PRI2D;
      else
        SIM3D<=RIM2D+PRI2D;
      end if;
      PII3D<=IM(I2D)*IM(W2D);
      PIR3D<=IM(I2D)*RE(W2D);
      if SII3D then
        ORE4D<=SRE3D-PII3D;
      else
        ORE4D<=SRE3D+PII3D;
      end if;
      if SIR3D then
        OIM4D<=SIM3D-PIR3D;
      else
        OIM4D<=SIM3D+PIR3D;
      end if;
    end if;
  end process;

  iw:if not CLIP generate
     begin
-- Generate valid output signal
       vd:BDELAY generic map(SIZE=>4)
                 port map(CLK=>CLK,
                          I=>VI,
                          O=>VO);
-- Truncate Wrap the (rounded) output
       O<=TO_COMPLEX(ORE4D(W'length/2+I'length/2-SCALE downto W'length/2+I'length/2-O'length/2-SCALE+1),
                     OIM4D(W'length/2+I'length/2-SCALE downto W'length/2+I'length/2-O'length/2-SCALE+1));
       CLIPO<=FALSE;
     end generate;

  ic:if CLIP generate
       signal CLIP_RE,CLIP_IM:SIGNED(O'length/2-1 downto 0):=(others=>'0');
     begin
-- Generate valid output signal
       vd:BDELAY generic map(SIZE=>5)
                 port map(CLK=>CLK,
                          I=>VI,
                          O=>VO);
-- Truncate Saturate the (rounded) output
       process(CLK)
       begin
         if rising_edge(CLK) then
           if ORE4D(ORE4D'high downto W'length/2+I'length/2-SCALE)=0 or ORE4D(ORE4D'high downto W'length/2+I'length/2-SCALE)=-1 then
             CLIP_RE<=ORE4D(W'length/2+I'length/2-SCALE downto W'length/2+I'length/2-O'length/2-SCALE+1);
             CLIPO<=FALSE;
           else
             CLIP_RE<=(CLIP_RE'high=>ORE4D(ORE4D'high),others=>not ORE4D(ORE4D'high));
             CLIPO<=TRUE;
           end if;
           if OIM4D(OIM4D'high downto W'length/2+I'length/2-SCALE)=0 or OIM4D(OIM4D'high downto W'length/2+I'length/2-SCALE)=-1 then
             CLIP_IM<=OIM4D(W'length/2+I'length/2-SCALE downto W'length/2+I'length/2-O'length/2-SCALE+1);
           else
             CLIP_IM<=(CLIP_IM'high=>OIM4D(OIM4D'high),others=>not OIM4D(OIM4D'high));
           end if;
         end if;
       end process;
       O<=TO_COMPLEX(CLIP_RE,CLIP_IM);
     end generate;
end TEST;