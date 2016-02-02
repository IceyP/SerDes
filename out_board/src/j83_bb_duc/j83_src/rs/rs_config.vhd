---------------------------------------------------------------------------------------------------
--
-- Title       : rs_config
-- Design      : rs
-- Author      : yanghb
-- Company     : tsinghua
--
---------------------------------------------------------------------------------------------------
--
-- File        : rs_config.vhd
-- Generated   : Sat Jul 14 22:33:03 2007
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {rs_config} architecture {behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

package rs_config is  
	
	constant poly	: integer	:= 285;	  	-- GF(2^m)的生成多项式
	constant m		: integer	:= 8;		
	constant alfa	: integer	:= 2;		-- GF(2^m)上的本原元，一般不用改
	constant t		: integer	:= 8;		-- 最大纠错个数
	constant n		: integer	:= 204;		-- 码长	  （n = k + 2t )<= 2^m-1
	constant k		: integer	:= 188;		-- 信息位长	
	
	--------------------------------------------------------------------------
	-- Euclid模块的处理延时，用不同的architecture有不同的延时
	-- behave		: 2t	    （普通，时钟60MHz左右）
	-- behave_4   	: 2t*4 	    （布线速率高，150MHz左右）
	-- behave_m3	: 2t*(m+3)	 (速率170MHz左右，面积省300slice）
	-- Euclide模块的处理延时可能会影响译码器的吞吐量
	-- 当Euclid模块的延时 < 码长n时没有影响
	
	constant CONST_EUCLID_ITER_DELAY	: integer	:= m+3;
	constant CONST_EUCLID_DELAY			: integer	:= 2*t*CONST_EUCLID_ITER_DELAY;		  
	--
	---------------------------------------------------------------------------
	
	constant ones	: std_logic_vector(m-1 downto 0)	:= (others => '1');
	constant max_n	: integer							:= CONV_INTEGER(ones);
	constant dec_delay	: integer						:= n + CONST_EUCLID_DELAY + 5;
	constant CONST_DELAY_DEPTH	: integer				:= 512;			   		-- 大于dec_delay的最小2的幂次 
	constant CONST_DELAY_AWIDTH	: integer				:= 9;
	
	type symbol_array is array ( natural range<> ) of std_logic_vector(m-1 downto 0);

	function gfmult( a : std_logic_vector; b : std_logic_vector ) return std_logic_vector;
	function polygen(t : integer) return symbol_array;
	function exp(i : integer) return std_logic_vector;
	
end rs_config;

--}} End of automatically maintained section

package body rs_config is  	
	
	function gfmult( a : std_logic_vector; b : std_logic_vector ) return std_logic_vector is
		constant poly_vect	: std_logic_vector(m downto 0)	:= CONV_STD_LOGIC_VECTOR( poly, m+1 );
		subtype dtype is std_logic_vector(m-1 downto 0);
		variable r	: std_logic_vector(m-1 downto 0)	:= (others => '0');
		variable aa	: std_logic_vector(m-1 downto 0)	:= (others => '0');
	begin	  
		aa := a;
		m_loop	: for i in 0 to m-1 loop
			r := r xor ( dtype'(others => b(i)) and aa );
			aa := (aa(m-2 downto 0) & '0') xor (dtype'(others => aa(m-1)) and poly_vect(m-1 downto 0));
		end loop;
		return r;
	end;
	
	function polygen(t : integer) return symbol_array is
		variable g	: symbol_array(2*t-1 downto 0)	:= (others => (others => '0'));
		variable gg	: symbol_array(2*t-1 downto 0)	:= (others => (others => '0'));
		variable c	: std_logic_vector(m-1 downto 0)	:= (others => '0');
	begin
		g(0) := (0=>'1', others => '0'); 
		c := (0=>'1', others => '0');
		for i in 0 to 2*t-1 loop 
			gg(2*t-1 downto 1) := g(2*t-2 downto 0);
			gg(0) := (others => '0'); 
			for j in 0 to 2*t-1 loop
				g(j) := gfmult( g(j), c ) xor gg(j);	
			end loop;
			c := gfmult( c, CONV_STD_LOGIC_VECTOR( alfa, m ) );
		end loop; 
		return g;
	end;	
	
	function exp(i : integer) return std_logic_vector is
		variable r		: std_logic_vector(m-1 downto 0)	:= (others => '0');
		variable i_v	: std_logic_vector(m-1 downto 0)	:= CONV_STD_LOGIC_VECTOR(i,m);
		variable b		: std_logic_vector(m-1 downto 0)	:= (others => '0');
	begin
		r := (0=>'1', others => '0');
		b := CONV_STD_LOGIC_VECTOR( alfa, m );
		for j in 0 to m-1 loop
			if i_v(j) = '1' then
				r := gfmult( r, b );
			end if;
			b := gfmult( b, b );
		end loop;
		return r;
	end;

end rs_config;
