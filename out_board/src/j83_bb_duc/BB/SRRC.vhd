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
--  \   \        		Filename:             SRRC.v
--  /   /        		Date Last Modified:   14 Oct 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     SRRC
-- Purpose:         Square root raised cosine (SRRC) filter
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
use ieee.math_real.ALL;
use ieee.numeric_std.ALL;

use work.COMPLEX_PKG.ALL;

entity SRRC is -- LATENCY=(C'length-1)/4+4
  generic(NB:INTEGER:=20; -- Partial Sums size is 2xFix_nb_nb-2	
          PWIDTH:INTEGER:=12;	  
          C1: REAL_VECTOR:= C_SRRC_12;
		  C2: REAL_VECTOR:= C_SRRC_18
          --C1,C2:work.COMPLEX_PKG.REAL_VECTOR
		  ); -- C1 and C2 must be symmetric and of equal length 4*K+1
  port(CLK:in STD_LOGIC;
       CSET:in STD_LOGIC:='0';
       I:in COMPLEX(2*5-1 downto 0); -- 2xFix_5_4 for QAM256
       PHI:in UNSIGNED(PWIDTH-1 downto 0);  -- UFix_12_0
       VFI,VRI:in BOOLEAN;
       O:out COMPLEX;  -- 2xFix_n+2_n
       PHO:out UNSIGNED(PWIDTH-1 downto 0);  -- UFix_12_0
       VO:out BOOLEAN);
end SRRC;

architecture TEST of SRRC is
	-- Component declaration of the "delay(test)" unit defined in
	-- file: "./src/Delay.vhd"
	component delay
	generic(
		SIZE : INTEGER := 1;
		DX : INTEGER := 0;
		DY : INTEGER := 0;
		IWIDTH : INTEGER := 4);
	port(
		CLK : in STD_LOGIC;
		I : in STD_LOGIC_VECTOR(IWIDTH-1 downto 0);
		O : out STD_LOGIC_VECTOR(IWIDTH-1 downto 0));
	end component;
	
		-- Component declaration of the "udelay(test)" unit defined in
	-- file: "./src/UDelay.vhd"
	component udelay
	generic(
		SIZE : INTEGER := 4;
		IWIDTH : INTEGER := 8);
	port(
		CLK : in STD_LOGIC;
		I : in UNSIGNED(IWIDTH-1 downto 0);
		O : out UNSIGNED(IWIDTH-1 downto 0));
	end component;
	for all: udelay use entity work.udelay(test);



  component BDELAY
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;

  type TNxC is array(0 to (C1'length-1)/4+1) of COMPLEX(I'range);
  signal F,R:TNxC:=(others=>(others=>'0'));
  type TNxB is array(0 to (C1'length-1)/4+1) of BOOLEAN;
  signal VF,VR:TNxB:=(others=>FALSE);
  type TNxS is array(0 to (C1'length-1)/4+1) of COMPLEX(2*NB-1 downto 0);
  attribute shreg_extract : string;
  signal S:TNxS:=(others=>(others=>'0'));
  attribute shreg_extract of S : signal is "no";
  signal V:BOOLEAN:=FALSE;
begin
-- the --T changes can lower the noise floor by about 10dB but must check for internal overflows  
  F(0)<=I;
  VF(0)<=VFI;
  VR(0)<=VRI;
  S(0)<=TO_COMPLEX(0,0,S(0)'length/2); -- we can do rounding here if needed
  lk:for K in 1 to (C1'length-1)/4 generate
       signal FM,RM,RM15D:COMPLEX(I'range):=(others=>'0');
       signal FM15D:COMPLEX(I'range);
       signal VF2D:BOOLEAN:=FALSE;
       signal AD:COMPLEX(I'range):=(others=>'0');
--T       type TMEM is array(-16 to 15) of SIGNED(NB-3 downto 0);
       type TMEM is array(-16 to 15) of SIGNED(NB-1 downto 0);
       function INIT(C:REAL) return TMEM is
         variable M:TMEM:=(others=>(others=>'0'));
       begin
         for K in -16 to 15 loop
--T           M(K):=TO_SIGNED(INTEGER(REAL(K)*C/16.0*2.0**(NB-3)),NB-2);
           M(K):=TO_SIGNED(INTEGER(REAL(K)*C/16.0*2.0**(NB-1)),NB);
         end loop;
         return M;
       end;
       signal MEM1F:TMEM:=INIT(C1(C1'low+2*K-2)/C1((C1'length-1)/2));
       signal MEM1R:TMEM:=INIT(C1(C1'low+2*K-1)/C1((C1'length-1)/2));
       signal MEM2F:TMEM:=INIT(C2(C2'low+2*K-2)/C2((C2'length-1)/2));
       signal MEM2R:TMEM:=INIT(C2(C2'low+2*K-1)/C2((C2'length-1)/2));
--S       signal MEM1:TMEM:=INIT(C(C'low+2*K-2));
--S       signal MEM2:TMEM:=INIT(C(C'low+2*K-1));
       attribute rom_style:STRING;
       attribute rom_style of MEM1F:signal is "distributed";
       attribute rom_style of MEM2F:signal is "distributed";
       attribute rom_style of MEM1R:signal is "distributed";
       attribute rom_style of MEM2R:signal is "distributed";
--T       signal M:COMPLEX(2*NB-5 downto 0):=(others=>'0');
       signal M:COMPLEX(2*NB-1 downto 0):=(others=>'0');
       attribute shreg_extract of M : signal is "no";
     begin
       fd:DELAY generic map(SIZE=>15,
	                        IWIDTH=>FM'length)
                port map(CLK=>CLK,
                         I=>FM,
                         O=>FM15D);
       rd:DELAY generic map(SIZE=>14,
	                        IWIDTH=>RM'length)
                port map(CLK=>CLK,
                         I=>RM,
                         O=>R(K-1));
       process(CLK)
       begin
         if rising_edge(CLK) then
           if VF(K-1) then
             FM<=F(K-1);
           else
             FM<=FM15D;
           end if;
           F(K)<=FM15D;
           RM15D<=R(K-1);
           if VR(K-1) then
             RM<=R(K);
           else
             RM<=RM15D;
           end if;
           VF2D<=VF(K);
           AD<=RESIZE(SHIFT_RIGHT(RESIZE(FM,FM'length/2+1)+RESIZE(RM,RM'length/2+1),1),AD'length/2);
           if VF2D then
             if CSET='0' then
               M<=TO_COMPLEX(MEM1F(TO_INTEGER(SIGNED(RE(AD)))),MEM1F(TO_INTEGER(SIGNED(IM(AD)))));
             else
               M<=TO_COMPLEX(MEM2F(TO_INTEGER(SIGNED(RE(AD)))),MEM2F(TO_INTEGER(SIGNED(IM(AD)))));
             end if;
           else
             if CSET='0' then
               M<=TO_COMPLEX(MEM1R(TO_INTEGER(SIGNED(RE(AD)))),MEM1R(TO_INTEGER(SIGNED(IM(AD)))));
             else
               M<=TO_COMPLEX(MEM2R(TO_INTEGER(SIGNED(RE(AD)))),MEM2R(TO_INTEGER(SIGNED(IM(AD)))));
             end if;
           end if;
           S(K)<=S(K-1)+RESIZE(M,S(K)'length/2);
           VF(K)<=VF(K-1);
           VR(K)<=VR(K-1);
         end if;
       end process;
     end generate;

  ln:block
       signal FM,FM1D:COMPLEX(I'range):=(others=>'0');
       signal FM15D:COMPLEX(I'range):=(others=>'0');
       signal VF2D:BOOLEAN:=FALSE;
       signal P:COMPLEX(2*NB-1 downto 0):=(others=>'0');
     begin
       rd:DELAY generic map(SIZE=>14,
	                        IWIDTH=>FM'length)
                port map(CLK=>CLK,
                         I=>FM,
                         O=>R(R'high-1));
       process(CLK)
       begin
         if rising_edge(CLK) then
           VF(VF'high)<=VF(VF'high-1);
           VR(VR'high)<=VR(VR'high-1);
           if VF(VF'high-1) then
             FM<=F(F'high-1);
           else
             FM<=FM15D;
           end if;
           FM15D<=R(R'high-1);
           VF2D<=VF(VF'high);
           FM1D<=FM;
           if VF2D then
--T             P<=SHIFT_LEFT(RESIZE(FM1D,P'length/2),NB-8);
             P<=SHIFT_LEFT(RESIZE(FM1D,P'length/2),NB-6);
           else
             P<=(others=>'0');
           end if;
           S(S'high)<=S(S'high-1)+P;
           V<=VF(VF'high) or VR(VR'high);
         end if;
       end process;
     end block;
  O<=S(S'high);
  
  ud:UDELAY generic map(SIZE=>(C1'length-1)/4+4,
                        IWIDTH=>PHI'length)
            port map(CLK=>CLK,
                     I=>PHI,
                     O=>PHO);

  bd:BDELAY generic map(SIZE=>2)
            port map(CLK=>CLK,
                     I=>V,
                     O=>VO);
end TEST;
