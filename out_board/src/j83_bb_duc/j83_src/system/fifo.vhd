Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fifo is
	generic(
		DEPTH		: natural;
		AWIDTH		: natural;
		DWIDTH		: natural;
		RAM_TYPE	: string	  			-- "BLOCK_RAM" or "DIS_RAM"
		);
	port(
		reset	: in std_logic;
		clk		: in std_logic;
		clr		: in std_logic;
		we		: in std_logic;
		din		: in std_logic_vector(DWIDTH - 1 downto 0);
		rd		: in std_logic;
		dout	: out std_logic_vector(DWIDTH - 1 downto 0); 
		empty	: out std_logic;
		full	: out std_logic;
		dn		: out std_logic_vector(AWIDTH -1 downto 0)		-- data number
		);
end fifo;

architecture behave of fifo is
	
	component blockdram
		generic( 
			depth:	integer;
			Dwidth: integer;
			Awidth:	integer
			);
		port(
			addra: IN std_logic_VECTOR(Awidth-1 downto 0);
			clka: IN std_logic;
			addrb: IN std_logic_VECTOR(Awidth-1 downto 0);
			clkb: IN std_logic;
			dia: IN std_logic_VECTOR(Dwidth-1 downto 0);
			wea: IN std_logic;
			dob: OUT std_logic_VECTOR(Dwidth-1 downto 0)	:= (others => '0')
			);
	end component;
	
	component disdram
		generic( 
			depth:	integer;
			Dwidth: integer;
			Awidth:	integer
			);
		port(
			A: IN std_logic_VECTOR(Awidth-1 downto 0);
			CLK: IN std_logic;
			D: IN std_logic_VECTOR(Dwidth-1 downto 0);
			WE: IN std_logic;
			DPRA: IN std_logic_VECTOR(Awidth-1 downto 0);
			DPO: OUT std_logic_VECTOR(Dwidth-1 downto 0);
			QDPO: OUT std_logic_VECTOR(Dwidth-1 downto 0)
			);
	end component;
	
	signal wp		: std_logic_vector(AWIDTH - 1 downto 0)	:= (others => '0');
	signal rp		: std_logic_vector(AWIDTH - 1 downto 0)	:= (others => '0');
	signal ram_we	: std_logic	:= '0';
	signal empty_flag	: std_logic	:= '1';
	signal full_flag	: std_logic	:= '0';
	
begin
	
	use_block_ram	: if RAM_TYPE = "BLOCK_RAM" generate
		ram		: blockdram
		generic map( 
			depth	=> DEPTH,
			Dwidth	=> DWIDTH,
			Awidth	=> AWIDTH
			)
		port map(
			addra	=> wp,
			clka	=> clk,
			addrb	=> rp,
			clkb	=> clk,
			dia		=> din,
			wea		=> ram_we,
			dob		=> dout
			);
	end generate use_block_ram;
	
	use_dis_ram		: if RAM_TYPE = "DIS_RAM" generate
		ram	: disdram
		generic map( 
			depth	=> DEPTH,
			Dwidth	=> DWIDTH,
			Awidth	=> AWIDTH
			)
		port map(
			A		=> wp,
			CLK		=> clk,
			D		=> din,
			WE		=> ram_we,
			DPRA	=> rp,
			DPO		=> open,
			QDPO	=> dout
			);
	end generate use_dis_ram;
	
	WritePointorCtrl	: process(reset,clk)
	begin
		if reset = '1' then
			wp <= (others => '0');
		elsif rising_edge(clk) then
			if clr = '1' then
				wp <= (others => '0');
			elsif full_flag = '0' and we = '1' then
				wp <= wp + 1;
			end if;
		end if;
	end process;
	
	ram_we <= we when full_flag = '0' else '0';
	
	ReadPointorCtrl		: process(reset,clk)
	begin
		if reset = '1' then
			rp <= (others => '0');
		elsif rising_edge(clk) then
			if clr = '1' then
				rp <= (others => '0');
			elsif empty_flag = '0' and rd = '1' then
				rp <= rp + 1;
			end if;
		end if;
	end process;
	
	GetEmptyFlag	: process(reset,clk)
	begin
		if reset = '1' then
			empty_flag <= '1';
		elsif rising_edge(clk) then
			if clr = '1' then
				empty_flag <= '1';
			elsif (wp = rp) and (we = '1') then
				empty_flag <= '0';
			elsif (wp = rp + 1) and (rd = '1'and we = '0') then
				empty_flag <= '1';
			end if;
		end if;
	end process;
	empty <= empty_flag;
	
	GetFullFlag		: process(reset,clk)
	begin
		if reset = '1' then
			full_flag <= '0';
		elsif rising_edge(clk) then
			if clr = '1' then
				full_flag <= '0';
			elsif (wp = rp - 1) and (we = '1' and rd = '0') then
				full_flag <= '1';
			elsif (wp = rp) and (rd = '1') then
				full_flag <= '0';
			end if;
		end if;
	end process;
	full <= full_flag;
	
	dn <= wp - rp;
	
end behave;
