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
--  \   \        		Filename:             BB.v
--  /   /        		Date Last Modified:   14 Oct 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     BB
-- Purpose:         Base-Band block top level
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

use std.textio.all;

use work.COMPLEX_PKG.ALL;

entity BB is -- LATENCY=CHANNELS+4+(C_SRRC'length-1)/4+2+C_FRACTINT'length/2**PHASE_SIZE+4
  generic(CHANNELS:INTEGER:=16;	   
     ----*************************-----------------
	      WAWIDTH :INTEGER:=4;  --note WAWIDTH = log2(CHANNELS)	
	 	  DIWIDTH :INTEGER:=32;
     ----*************************-----------------
          PHASE_SIZE:INTEGER:=12;
          NB_SRRC:INTEGER:=20; -- SRRC output size is 2xFix_nb_nb-2
          NB_FRACTINT:INTEGER:=18; -- FRACTINT output size is 2xFix_nb_nb-2
          FLOORPLAN:BOOLEAN:=TRUE;
          OX,OY:INTEGER:=0;
          DX,DY:INTEGER:=0;
          C_SRRC_12 :REAL_VECTOR:= C_SRRC_12;
          C_SRRC_18 :REAL_VECTOR:= C_SRRC_18;
          C_FRACTINT:REAL_VECTOR:= C_FRACTINT); -- Filter coefficients
  port(PCLK:in STD_LOGIC;
       WA:in UNSIGNED(WAWIDTH-1 downto 0);  -- UFix_4_0
       DI:in UNSIGNED(DIWIDTH-1 downto 0); -- UFix_32_32
       WE:in BOOLEAN;
       CLK:in STD_LOGIC;
       CSET:in STD_LOGIC:='0';
       RE:out BOOLEAN;
       CH:out UNSIGNED(WAWIDTH-1 downto 0);  -- UFix_4_0
       I:in COMPLEX(2*5-1 downto 0); -- 2xFix_5_4 for QAM256
       VI:in BOOLEAN;
       O:out COMPLEX(2*16-1 downto 0);  -- 2xFix_16_14
       VO:out BOOLEAN);
end BB;

architecture TEST of BB is
  attribute keep_hierarchy:STRING;
  attribute keep_hierarchy of all:architecture is "yes";
  attribute syn_hier:STRING;
  attribute syn_hier of all:architecture is "hard";
 
	component udelay
	generic(
		SIZE : INTEGER := 4;
		IWIDTH : INTEGER := 8);
	port(
		CLK : in STD_LOGIC;
		I : in UNSIGNED(IWIDTH-1 downto 0);
		O : out UNSIGNED(IWIDTH-1 downto 0));
	end component;


  component BDELAY
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;

	-- Component declaration of the "timer(test)" unit defined in
	-- file: "./src/TIMER.vhd"
	component timer
	generic(
		CHANNELS : INTEGER := 16;
		WAWIDTH : INTEGER := 4;
		DIWIDTH : INTEGER := 32;
		PWIDTH : INTEGER := 12);
	port(
		PCLK : in STD_LOGIC;
		WA : in UNSIGNED(WAWIDTH-1 downto 0);
		DI : in UNSIGNED(DIWIDTH-1 downto 0);
		WE : in BOOLEAN;
		CLK : in STD_LOGIC;
		RA : in UNSIGNED(WAWIDTH-1 downto 0);
		PHASE : out UNSIGNED(PWIDTH-1 downto 0);
		EN_SYMB : out BOOLEAN;
		EN_SYMB_2x : out BOOLEAN;
		IEN : out BOOLEAN);
	end component;
	
		-- Component declaration of the "srrc(test)" unit defined in
	-- file: "./src/SRRC.vhd"
	component srrc
	generic(
		NB : INTEGER := 20;
		PWIDTH : INTEGER := 12;
		C1 : REAL_VECTOR := C_SRRC_12;
		C2 : REAL_VECTOR := C_SRRC_18);
	port(
		CLK : in STD_LOGIC;
		CSET : in STD_LOGIC;
		I : in STD_LOGIC_VECTOR(2*5-1 downto 0);
		PHI : in UNSIGNED(PWIDTH-1 downto 0);
		VFI : in BOOLEAN;
		VRI : in BOOLEAN;
		O : out STD_LOGIC_VECTOR;
		PHO : out UNSIGNED(PWIDTH-1 downto 0);
		VO : out BOOLEAN);
	end component;

	component fractint
	generic(
		NB : INTEGER := 16;
		FLOORPLAN : BOOLEAN := TRUE;
		OX : INTEGER := 0;
		OY : INTEGER := 0;
		DX : INTEGER := 0;
		DY : INTEGER := 0;
		C : REAL_VECTOR);
	port(
		CLK : in STD_LOGIC;
		IINT : in UNSIGNED;
		I : in STD_LOGIC_VECTOR;
		VI : in BOOLEAN;
		O : out STD_LOGIC_VECTOR;
		VO : out BOOLEAN);
	end component;

  signal RA:UNSIGNED(WA'range):=(others=>'0');  -- UFix_4_0
  signal EN_SYMB,EN_SYMB_2x,IEN:BOOLEAN;
  signal II:COMPLEX(I'range);
  signal PHI,PHO:UNSIGNED(PHASE_SIZE-1 downto 0);  -- UFix_12_0
  signal VF,VR,V:BOOLEAN;
  signal SO:COMPLEX(2*NB_SRRC-1 downto 0);  -- 2xFix_nb_nb-2
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
        RA<=(others=>'0');
      end if;
    end if;
  end process;

  ud:UDELAY 
  generic map(SIZE=>2,
              IWIDTH=>WAWIDTH)
  port map(CLK=>CLK,
            I=>RA,
            O=>CH);

  tm:TIMER 
  generic map(
          CHANNELS=>CHANNELS,
          WAWIDTH=>WAWIDTH,---log2(CHANNELS)
   		  DIWIDTH=>DIWIDTH,
		  PWIDTH=>PHASE_SIZE)
  port map(PCLK=>PCLK,
             WA=>WA,
             DI=>DI,
             WE=>WE,
            CLK=>CLK,
             RA=>RA,
          PHASE=>PHI,
        EN_SYMB=>EN_SYMB,
     EN_SYMB_2x=>EN_SYMB_2x,
            IEN=>IEN);

  VF<=EN_SYMB;
  VR<=EN_SYMB_2x and not EN_SYMB;
  RE<=VF;
  II<=I when IEN else (others=>'0');
  
  sr:SRRC generic map(NB=>NB_SRRC,
                      PWIDTH => PHASE_SIZE,
                      C1=>C_SRRC_12,
                      C2=>C_SRRC_18)
          port map(CLK=>CLK,
                   CSET=>CSET,
                   I=>II,
                   PHI=>PHI,
                   VFI=>VF,
                   VRI=>VR,
                   O=>SO,  -- 2xFix_nb_nb-2
                   PHO=>PHO,
                   VO=>V);
--synthesis translate_off
-- Save SO output in a text file
-- In Matlab run:
-- load srrc.txt -ascii
-- plot(20*log10(abs(fft((srrc(51:250,1)+i*srrc(51:250,2)).*window('blackman',200)))))
-- grid on
  process
    variable L:LINE;
    file F:TEXT;
  begin
    file_open(F,"SRRC.txt",WRITE_MODE);
    while TRUE loop
--      wait until (RA=14) and rising_edge(CLK);
      wait until rising_edge(CLK);
      if V then
        write(L,TO_INTEGER(work.COMPLEX_PKG.RE(SO)),RIGHT,10);
        write(L,TO_INTEGER(work.COMPLEX_PKG.IM(SO)),RIGHT,10);
        writeline(F,L);
      end if;
    end loop;
    wait;
  end process;
--synthesis translate_on
  fi:FRACTINT generic map(NB=>NB_FRACTINT,
                          FLOORPLAN=>FLOORPLAN,
                          OX=>OX,
                          OY=>OY,
                          DX=>DX,
                          DY=>DY,
                          C=>C_FRACTINT)
              port map(CLK=>CLK,
                       IINT=>PHO,
                       I=>SO,
                       VI=>V,
                       O=>O,
                       VO=>open);

--  bd:BDELAY generic map(SIZE=>CHANNELS+4+(C_SRRC'length-1)/4+2+C_FRACTINT'length/2**PHASE_SIZE+4)
  bd:BDELAY generic map(SIZE=>CHANNELS+4+(C_SRRC_12'length-1)/4+3+C_FRACTINT'length/2**PHASE_SIZE+4)
            port map(CLK=>CLK,
                     I=>VI,
                     O=>VO);
end TEST;