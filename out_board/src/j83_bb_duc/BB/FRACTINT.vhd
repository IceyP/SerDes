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
--  \   \        		Filename:             FRACTINT.v
--  /   /        		Date Last Modified:   23 Sept 2010
-- /___/   /\    		Date Created:            June 2010
-- \   \  /  \
--  \___\/\___\
-- 
-- Device:          Virtex-6
-- Author:          Catalin Baetoniu
-- Entity Name:     FRACTINT
-- Purpose:         Fractional interpolator module
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

library UNISIM;
use UNISIM.vcomponents.all;

use work.COMPLEX_PKG.ALL;

entity FRACTINT is -- LATENCY=C_FRACTINT'length/2**PHASE_SIZE+4
  generic(NB:INTEGER:=16; -- Output size is 2xFix_nb_nb-2
          FLOORPLAN:BOOLEAN:=TRUE;
          OX,OY:INTEGER:=0;
          DX,DY:INTEGER:=0;
          C:work.COMPLEX_PKG.REAL_VECTOR); -- C length must be a multiple of 2**IINT'length
  port(CLK:in STD_LOGIC;
       IINT:in UNSIGNED;  -- UFix_12_0
       I:in COMPLEX; -- 2xFix_20_18
       VI:in BOOLEAN;
       O:out COMPLEX; -- 2xFix_16_14
       VO:out BOOLEAN);
end FRACTINT;

architecture TEST of FRACTINT is
  attribute loc:STRING;

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



  component BDELAY
    generic(SIZE:INTEGER:=1);
    port(CLK:in STD_LOGIC;
         I:in BOOLEAN;
         O:out BOOLEAN);
  end component;

  constant TAPS:INTEGER:=C'length/2**IINT'length;
  type TNxD is array(0 to TAPS) of COMPLEX(I'range);
--D  type TNxD is array(0 to TAPS) of COMPLEX(I'length-5 downto 0);
  signal D:TNxD:=(others=>(others=>'0'));
  type TNxINT is array(0 to TAPS) of UNSIGNED(IINT'range);
  signal INT:TNxINT:=(others=>(others=>'0'));
  type TNxPC is array(0 to TAPS) of COMPLEX(2*48-1 downto 0);
  signal PC:TNxPC:=(others=>(others=>'0'));
  type TNxPC48 is array(0 to TAPS) of STD_LOGIC_VECTOR(47 downto 0);
  signal PCRE,PCIM:TNxPC48;
  signal V:work.COMPLEX_PKG.BOOLEAN_VECTOR(0 to TAPS):=(others=>FALSE);
begin
  assert C'length/2**IINT'length*2**IINT'length=C'length report "Inconsistent C and IINT sizes!" severity error;
  
  process(CLK)
  begin
    if rising_edge(CLK) then
      D(0)<=I;
--    D  D(0)<=RESIZE(SHIFT_RIGHT(I,2),D(0)'length/2);
      V(0)<=VI;
    end if;
  end process;
  
  INT(0)<=IINT;
  PC(0)<=TO_COMPLEX(2**(16+I'length/2-O'length/2),2**(16+I'length/2-O'length/2),PC(0)'length/2); -- we do rounding here
--D  PC(0)<=TO_COMPLEX(2**(14+I'length/2-O'length/2),2**(14+I'length/2-O'length/2),PC(0)'length/2); -- we do rounding here
  PCRE(0)<=(others=>'0');
  PCIM(0)<=(others=>'0');
  lk:for K in 1 to TAPS generate
       signal DM:COMPLEX(I'range):=(others=>'0');
       signal DM15D:COMPLEX(I'range);
--D       signal DM:COMPLEX(I'length-5 downto 0):=(others=>'0');
--D       signal DM15D:COMPLEX(I'length-5 downto 0);
--       signal A1,A2:COMPLEX(I'range):=(others=>'0');
       signal ADDR:UNSIGNED(IINT'range):=(others=>'0');
--       signal DO,CO,B:SIGNED(17 downto 0):=(others=>'0');
       signal DO,CO:SIGNED(17 downto 0):=(others=>'0');
       type TMEM is array(0 to 2**IINT'length-1) of SIGNED(17 downto 0);
--C       type TMEM is array(0 to 2**(IINT'length-1)-1) of SIGNED(17 downto 0);
       function INIT(C:work.COMPLEX_PKG.REAL_VECTOR) return TMEM is
         variable M:TMEM:=(others=>(others=>'0'));
       begin
         for K in 0 to C'length-1 loop
           M(K):=TO_SIGNED(INTEGER(C(C'low+K)*0.9*2.0**(18-1+12)),18); -- Fix_18_17
--C         for K in 0 to C'length/2-1 loop
--C           M(K):=TO_SIGNED(INTEGER(C(C'low+2*K)*0.99*2.0**(18-1+12)),18); -- Fix_18_17
         end loop;
         return M;
       end;
       signal MEM:TMEM:=INIT(C(C'low+(K-1)*2**IINT'length to C'low+K*2**IINT'length-1));
--       signal M:COMPLEX(A2'length+2*B'length-1 downto 0):=(others=>'0');
       signal PRE,PIM:SIGNED(47 downto 0);
       signal COD:SIGNED(17 downto 0):=(others=>'0');
       attribute keep:STRING;
       function COD_KEEP(K:INTEGER) return STRING is
       begin
         if K mod 2=0 then
           return "no";
         else
           return "yes";
         end if;
       end;
------
-- Xilinx:jjb - need to eliminate the keep in order to pull CO into BRAM as output register
--       attribute keep of CO:signal is "yes";
------
       attribute keep of COD:signal is COD_KEEP(K);
     begin
       fd:DELAY generic map(SIZE=>15,
	                        IWIDTH=>DM'length)
                port map(CLK=>CLK,
                         I=>DM,
                         O=>DM15D);
       process(CLK)
       begin
         if rising_edge(CLK) then
           if V(K-1) then
             DM<=D(K-1);
           else
             DM<=DM15D;
           end if;
           D(K)<=DM15D;
--           ADDR<=INT(K-1);
--           CO<=MEM(TO_INTEGER(ADDR));
           DO<=MEM(TO_INTEGER(INT(K-1)));
--C           DO<=MEM(TO_INTEGER(INT(K-1)(11 downto 1)));
           CO<=DO;
           COD<=CO;
--           A1<=DM;  -- Fix_20_18
--           A2<=A1;
--           B<=CO;  -- Fix_18_17
--           M<=A2*B; -- Fix_38_35
--           PC(K)<=PC(K-1)+RESIZE(M,48); -- Fix_48_35
           INT(K)<=INT(K-1);
           V(K)<=V(K-1);
         end if;
       end process;
       dspi:if not FLOORPLAN generate
              signal A1,A2:SIGNED(I'length/2-1 downto 0):=(others=>'0');
--D              signal A1,A2:SIGNED(I'length/2-3 downto 0):=(others=>'0');
              signal B:SIGNED(17 downto 0):=(others=>'0');
              signal M:SIGNED(A2'length+B'length-1 downto 0):=(others=>'0');
              signal P:SIGNED(47 downto 0):=(others=>'0');
            begin
              process(CLK)
              begin
                if rising_edge(CLK) then
                  A1<=RE(DM);
                  A2<=A1;
--                  B<=CO;
                  B<=COD;
                  M<=A2*B;
                  P<=RE(PC(K-1))+RESIZE(M,P'length);
                end if;
              end process;
              PRE<=P;
            end generate;
       di:if FLOORPLAN generate
            signal ALUMODE:STD_LOGIC_VECTOR(3 downto 0);
            signal INMODE:STD_LOGIC_VECTOR(4 downto 0);
            signal OPMODE:STD_LOGIC_VECTOR(6 downto 0);
            signal A:STD_LOGIC_VECTOR(29 downto 0);
            signal B:STD_LOGIC_VECTOR(17 downto 0);
            signal C,P:STD_LOGIC_VECTOR(47 downto 0);
            attribute loc of dspi:label is "DSP48_X"&INTEGER'image(OX)&"Y"&INTEGER'image(OY+K-1);
          begin
            A<=STD_LOGIC_VECTOR(RESIZE(RE(DM),A'length));
--            B<=STD_LOGIC_VECTOR(RESIZE(CO,B'length));
            B<=STD_LOGIC_VECTOR(RESIZE(COD,B'length));
            C<=STD_LOGIC_VECTOR(TO_SIGNED(2**(16+I'length/2-O'length/2),C'length)) when K=1 else (others=>'0'); -- we do rounding here
--D            C<=STD_LOGIC_VECTOR(TO_SIGNED(2**(14+I'length/2-O'length/2),C'length)) when K=1 else (others=>'0'); -- we do rounding here
            ALUMODE<="0000";
            INMODE<="10000";
            OPMODE<="0110101" when K=1 else "0010101";
            dspi:DSP48E1 generic map(ACASCREG => 1,                         -- Number of pipeline registers between A/ACIN input and ACOUT output,
                                                                            -- 0, 1, or 2
                                     ADREG => 1,                            -- Number of pipeline registers on pre-adder output, 0 or 1
                                     ALUMODEREG => 1,                       -- Number of pipeline registers on ALUMODE input, 0 or 1
                                     AREG => 2,                             -- Number of pipeline registers on the A input, 0, 1 or 2
                                     AUTORESET_PATDET => "NO_RESET",        -- NO_RESET, RESET_MATCH, RESET_NOT_MATCH
                                     A_INPUT => "DIRECT",                   -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
                                     BCASCREG => 1,                         -- Number of pipeline registers between B/BCIN input and BCOUT output,
                                                                            -- 0, 1, or 2
                                     BREG => 1,                             -- Number of pipeline registers on the B input, 0, 1 or 2
                                     B_INPUT => "DIRECT",                   -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
                                     CARRYINREG => 1,                       -- Number of pipeline registers for the CARRYIN input, 0 or 1
                                     CARRYINSELREG => 1,                    -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
                                     CREG => 1,                             -- Number of pipeline registers on the C input, 0 or 1
                                     DREG => 1,                             -- Number of pipeline registers on the D input, 0 or 1
                                     INMODEREG => 1,                        -- Number of pipeline registers on INMODE input, 0 or 1
                                     MASK => X"3fffffffffff",               -- 48-bit Mask value for pattern detect
                                     MREG => 1,                             -- Number of multiplier pipeline registers, 0 or 1
                                     OPMODEREG => 1,                        -- Number of pipeline registers on OPMODE input, 0 or 1
                                     PATTERN => X"000000000000",            -- 48-bit Pattern match for pattern detect
                                     PREG => 1,                             -- Number of pipeline registers on the P output, 0 or 1
                                     SEL_MASK => "MASK",                    -- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
                                     SEL_PATTERN => "PATTERN",              -- Select pattern value between the "PATTERN" value or the value on
                                                                            -- the "C" port
                                     USE_DPORT => FALSE,                    -- Select D port usage, TRUE or FALSE
                                     USE_MULT => "MULTIPLY",                -- Select multiplier usage, "MULTIPLY", "DYNAMIC", or "NONE" (no
                                                                            -- multiplier)
                                     USE_PATTERN_DETECT => "NO_PATDET",     -- Enable pattern detect, "PATDET", "NO_PATDET" 
                                     USE_SIMD => "ONE48")                   -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
                         port map(-- Cascade: 30-bit (each) Cascade
                                  ACIN => "000000000000000000000000000000", -- 30-bit A cascade data input
                                  BCIN => "000000000000000000",             -- 18-bit B cascade input
                                  CARRYCASCIN => '0',                       -- 1-bit cascade carry input
                                  MULTSIGNIN => '0',                        -- 1-bit multiplier sign input
                                  PCIN => PCRE(K-1),                        -- 48-bit P cascade input
                                  -- Control: 4-bit (each) Control
                                  ALUMODE => ALUMODE,                       -- 4-bit ALU control input
                                  CARRYINSEL => "000",                      -- 3-bit carry select input
                                  CEINMODE => '1',                          -- 1-bit active high clock enable input for INMODE registers
                                  CLK => CLK,                               -- 1-bit Clock input
                                  INMODE => INMODE,                         -- 5-bit INMODE control input
                                  OPMODE => OPMODE,                         -- 7-bit operation mode input
                                  RSTINMODE => '0',                         -- 1-bit reset input for INMODE pipeline registers
                                  -- Data: 30-bit (each) Data
                                  A => A,                                   -- 30-bit A data input
                                  B => B,                                   -- 18-bit B data input
                                  C => C,                                   -- 48-bit C data input
                                  CARRYIN => '0',                           -- 1-bit carry input signal
                                  D => "0000000000000000000000000",         -- 25-bit D data input
                                  -- Reset/Clock Enable: 1-bit (each) Reset/Clock Enable
                                  CEA1 => '1',                              -- 1-bit active high clock enable input for 1st stage A registers
                                  CEA2 => '1',                              -- 1-bit active high clock enable input for 2nd stage A registers
                                  CEAD => '1',                              -- 1-bit active high clock enable input for pre-adder output registers
                                  CEALUMODE => '1',                         -- 1-bit active high clock enable input for ALUMODE registers
                                  CEB1 => '1',                              -- 1-bit active high clock enable input for 1st stage B registers
                                  CEB2 => '1',                              -- 1-bit active high clock enable input for 2nd stage B registers
                                  CEC => '1',                               -- 1-bit active high clock enable input for C registers
                                  CECARRYIN => '1',                         -- 1-bit active high clock enable input for CARRYIN register
                                  CECTRL => '1',                            -- 1-bit active high clock enable input for OPMODE and carry registers
                                  CED => '1',                               -- 1-bit active high clock enable input for D registers
                                  CEM => '1',                               -- 1-bit active high clock enable input for multiplier registers
                                  CEP => '1',                               -- 1-bit active high clock enable input for P registers
                                  RSTA => '0',                              -- 1-bit reset input for A pipeline registers
                                  RSTALLCARRYIN => '0',                     -- 1-bit reset input for carry pipeline registers
                                  RSTALUMODE => '0',                        -- 1-bit reset input for ALUMODE pipeline registers
                                  RSTB => '0',                              -- 1-bit reset input for B pipeline registers
                                  RSTC => '0',                              -- 1-bit reset input for C pipeline registers
                                  RSTCTRL => '0',                           -- 1-bit reset input for OPMODE pipeline registers
                                  RSTD => '0',                              -- 1-bit reset input for D pipeline registers
                                  RSTM => '0',                              -- 1-bit reset input for multiplier registers
                                  RSTP => '0',                              -- 1-bit reset input for P pipeline registers
                                  -- Cascade: 30-bit (each) Cascade
                                  ACOUT => open,                            -- 30-bit A port cascade output
                                  BCOUT => open,                            -- 18-bit B port cascade output
                                  CARRYCASCOUT => open,                     -- 1-bit cascade carry output
                                  MULTSIGNOUT => open,                      -- 1-bit multiplier sign cascade output
                                  PCOUT => PCRE(K),                         -- 48-bit cascade output
                                  -- Control: 1-bit (each) Control
                                  OVERFLOW => open,                         -- 1-bit overflow in add/acc output
                                  PATTERNBDETECT => open,                   -- 1-bit active high pattern bar detect output
                                  PATTERNDETECT => open,                    -- 1-bit active high pattern detect output
                                  UNDERFLOW => open,                        -- 1-bit active high underflow in add/acc output
                                  -- Data: 4-bit (each) Data
                                  CARRYOUT => open,                         -- 4-bit carry output
                                  P => P);                                  -- 48-bit output
            PRE<=RESIZE(SIGNED(P),PRE'length);
          end generate;
       dspq:if not FLOORPLAN generate
              signal A1,A2:SIGNED(I'length/2-1 downto 0):=(others=>'0');
--D              signal A1,A2:SIGNED(I'length/2-3 downto 0):=(others=>'0');
              signal B:SIGNED(17 downto 0):=(others=>'0');
              signal M:SIGNED(A2'length+B'length-1 downto 0):=(others=>'0');
              signal P:SIGNED(47 downto 0):=(others=>'0');
            begin
              process(CLK)
              begin
                if rising_edge(CLK) then
                  A1<=IM(DM);
                  A2<=A1;
--                  B<=CO;
                  B<=COD;
                  M<=A2*B;
                  P<=IM(PC(K-1))+RESIZE(M,P'length);
                end if;
              end process;
              PIM<=P;
            end generate;
       dq:if FLOORPLAN generate
            signal ALUMODE:STD_LOGIC_VECTOR(3 downto 0);
            signal INMODE:STD_LOGIC_VECTOR(4 downto 0);
            signal OPMODE:STD_LOGIC_VECTOR(6 downto 0);
            signal A:STD_LOGIC_VECTOR(29 downto 0);
            signal B:STD_LOGIC_VECTOR(17 downto 0);
            signal C,P:STD_LOGIC_VECTOR(47 downto 0);
--            attribute loc of dspq:label is "DSP48_X"&INTEGER'image(OX+DX)&"Y"&INTEGER'image(OY+K-1+DY);
          begin
            A<=STD_LOGIC_VECTOR(RESIZE(IM(DM),A'length));
--            B<=STD_LOGIC_VECTOR(RESIZE(CO,B'length));
            B<=STD_LOGIC_VECTOR(RESIZE(COD,B'length));
            C<=STD_LOGIC_VECTOR(TO_SIGNED(2**(16+I'length/2-O'length/2),C'length)) when K=1 else (others=>'0'); -- we do rounding here
--D            C<=STD_LOGIC_VECTOR(TO_SIGNED(2**(14+I'length/2-O'length/2),C'length)) when K=1 else (others=>'0'); -- we do rounding here
            ALUMODE<="0000";
            INMODE<="10000";
            OPMODE<="0110101" when K=1 else "0010101";
            dspq:DSP48E1 generic map(ACASCREG => 1,                         -- Number of pipeline registers between A/ACIN input and ACOUT output,
                                                                            -- 0, 1, or 2
                                     ADREG => 1,                            -- Number of pipeline registers on pre-adder output, 0 or 1
                                     ALUMODEREG => 1,                       -- Number of pipeline registers on ALUMODE input, 0 or 1
                                     AREG => 2,                             -- Number of pipeline registers on the A input, 0, 1 or 2
                                     AUTORESET_PATDET => "NO_RESET",        -- NO_RESET, RESET_MATCH, RESET_NOT_MATCH
                                     A_INPUT => "DIRECT",                   -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
                                     BCASCREG => 1,                         -- Number of pipeline registers between B/BCIN input and BCOUT output,
                                                                            -- 0, 1, or 2
                                     BREG => 1,                             -- Number of pipeline registers on the B input, 0, 1 or 2
                                     B_INPUT => "DIRECT",                   -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
                                     CARRYINREG => 1,                       -- Number of pipeline registers for the CARRYIN input, 0 or 1
                                     CARRYINSELREG => 1,                    -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
                                     CREG => 1,                             -- Number of pipeline registers on the C input, 0 or 1
                                     DREG => 1,                             -- Number of pipeline registers on the D input, 0 or 1
                                     INMODEREG => 1,                        -- Number of pipeline registers on INMODE input, 0 or 1
                                     MASK => X"3fffffffffff",               -- 48-bit Mask value for pattern detect
                                     MREG => 1,                             -- Number of multiplier pipeline registers, 0 or 1
                                     OPMODEREG => 1,                        -- Number of pipeline registers on OPMODE input, 0 or 1
                                     PATTERN => X"000000000000",            -- 48-bit Pattern match for pattern detect
                                     PREG => 1,                             -- Number of pipeline registers on the P output, 0 or 1
                                     SEL_MASK => "MASK",                    -- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
                                     SEL_PATTERN => "PATTERN",              -- Select pattern value between the "PATTERN" value or the value on
                                                                            -- the "C" port
                                     USE_DPORT => FALSE,                    -- Select D port usage, TRUE or FALSE
                                     USE_MULT => "MULTIPLY",                -- Select multiplier usage, "MULTIPLY", "DYNAMIC", or "NONE" (no
                                                                            -- multiplier)
                                     USE_PATTERN_DETECT => "NO_PATDET",     -- Enable pattern detect, "PATDET", "NO_PATDET" 
                                     USE_SIMD => "ONE48")                   -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
                         port map(-- Cascade: 30-bit (each) Cascade
                                  ACIN => "000000000000000000000000000000", -- 30-bit A cascade data input
                                  BCIN => "000000000000000000",             -- 18-bit B cascade input
                                  CARRYCASCIN => '0',                       -- 1-bit cascade carry input
                                  MULTSIGNIN => '0',                        -- 1-bit multiplier sign input
                                  PCIN => PCIM(K-1),                        -- 48-bit P cascade input
                                  -- Control: 4-bit (each) Control
                                  ALUMODE => ALUMODE,                       -- 4-bit ALU control input
                                  CARRYINSEL => "000",                      -- 3-bit carry select input
                                  CEINMODE => '1',                          -- 1-bit active high clock enable input for INMODE registers
                                  CLK => CLK,                               -- 1-bit Clock input
                                  INMODE => INMODE,                         -- 5-bit INMODE control input
                                  OPMODE => OPMODE,                         -- 7-bit operation mode input
                                  RSTINMODE => '0',                         -- 1-bit reset input for INMODE pipeline registers
                                  -- Data: 30-bit (each) Data
                                  A => A,                                   -- 30-bit A data input
                                  B => B,                                   -- 18-bit B data input
                                  C => C,                                   -- 48-bit C data input
                                  CARRYIN => '0',                           -- 1-bit carry input signal
                                  D => "0000000000000000000000000",         -- 25-bit D data input
                                  -- Reset/Clock Enable: 1-bit (each) Reset/Clock Enable
                                  CEA1 => '1',                              -- 1-bit active high clock enable input for 1st stage A registers
                                  CEA2 => '1',                              -- 1-bit active high clock enable input for 2nd stage A registers
                                  CEAD => '1',                              -- 1-bit active high clock enable input for pre-adder output registers
                                  CEALUMODE => '1',                         -- 1-bit active high clock enable input for ALUMODE registers
                                  CEB1 => '1',                              -- 1-bit active high clock enable input for 1st stage B registers
                                  CEB2 => '1',                              -- 1-bit active high clock enable input for 2nd stage B registers
                                  CEC => '1',                               -- 1-bit active high clock enable input for C registers
                                  CECARRYIN => '1',                         -- 1-bit active high clock enable input for CARRYIN register
                                  CECTRL => '1',                            -- 1-bit active high clock enable input for OPMODE and carry registers
                                  CED => '1',                               -- 1-bit active high clock enable input for D registers
                                  CEM => '1',                               -- 1-bit active high clock enable input for multiplier registers
                                  CEP => '1',                               -- 1-bit active high clock enable input for P registers
                                  RSTA => '0',                              -- 1-bit reset input for A pipeline registers
                                  RSTALLCARRYIN => '0',                     -- 1-bit reset input for carry pipeline registers
                                  RSTALUMODE => '0',                        -- 1-bit reset input for ALUMODE pipeline registers
                                  RSTB => '0',                              -- 1-bit reset input for B pipeline registers
                                  RSTC => '0',                              -- 1-bit reset input for C pipeline registers
                                  RSTCTRL => '0',                           -- 1-bit reset input for OPMODE pipeline registers
                                  RSTD => '0',                              -- 1-bit reset input for D pipeline registers
                                  RSTM => '0',                              -- 1-bit reset input for multiplier registers
                                  RSTP => '0',                              -- 1-bit reset input for P pipeline registers
                                  -- Cascade: 30-bit (each) Cascade
                                  ACOUT => open,                            -- 30-bit A port cascade output
                                  BCOUT => open,                            -- 18-bit B port cascade output
                                  CARRYCASCOUT => open,                     -- 1-bit cascade carry output
                                  MULTSIGNOUT => open,                      -- 1-bit multiplier sign cascade output
                                  PCOUT => PCIM(K),                         -- 48-bit cascade output
                                  -- Control: 1-bit (each) Control
                                  OVERFLOW => open,                         -- 1-bit overflow in add/acc output
                                  PATTERNBDETECT => open,                   -- 1-bit active high pattern bar detect output
                                  PATTERNDETECT => open,                    -- 1-bit active high pattern detect output
                                  UNDERFLOW => open,                        -- 1-bit active high underflow in add/acc output
                                  -- Data: 4-bit (each) Data
                                  CARRYOUT => open,                         -- 4-bit carry output
                                  P => P);                                  -- 48-bit output
            PIM<=RESIZE(SIGNED(P),PIM'length);
          end generate;
       PC(K)<=TO_COMPLEX(PRE,PIM);
     end generate;
-- the --T change can lower the noise floor by about 10dB but must check for internal overflows  
  O<=RESIZE(SHIFT_RIGHT(PC(PC'high),17+I'length/2-O'length/2),O'length/2);
--D  O<=RESIZE(SHIFT_RIGHT(PC(PC'high),15+I'length/2-O'length/2),O'length/2);
--T  O<=RESIZE(SHIFT_RIGHT(PC(PC'high),15+I'length/2-O'length/2),O'length/2);

  bd:BDELAY generic map(SIZE=>4)
            port map(CLK=>CLK,
                     I=>V(V'high),
                     O=>VO);
end TEST;
