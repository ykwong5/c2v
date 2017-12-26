constant	node_t_myChar0_lsb:	integer := 0;
constant	node_t_myChar0_msb:	integer := 7;
constant	node_t_myChar1_lsb:	integer := 8;
constant	node_t_myChar1_msb:	integer := 15;
constant	node_t_myInt_lsb:	integer := 16;
constant	node_t_myInt_msb:	integer := 47;
constant	node_t_next_lsb:	integer := 48;
constant	node_t_next_msb:	integer := 58;
constant	NULL_pointer:		std_logic_vector(10 downto 0) := (others => '0');

signal		r_head0_we_1P:		std_logic;
signal		r_head0_wraddr_1P:	std_logic_vector(10 downto 0);
signal		r_head0_wrdata_1P:	std_logic_vector(node_t_next_msb downto 0);
signal		r_head0_rdaddr_1P:	std_logic_vector(10 downto 0);
signal		w_head0_we_1P:		std_logic_vector(3 downto 0);
signal		w_head0_wraddr_1P:	std_logic_vector(13 downto 0);
signal		w_head0_wrdata_1P:	std_logic_vector(62 downto 0);
signal		w_head0_rdaddr_1P:	std_logic_vector(13 dwotno 0)
signal		w_head0_rddata_3P:	std_logic_vector(62 downto 0);

signal		r_head1_we_1P:		std_logic;
signal		r_head1_wraddr_1P:	std_logic_vector(10 downto 0);
signal		r_head1_wrdata_1P:	std_logic_vector(node_t_next_msb downto 0);
signal		r_head1_rdaddr_1P:	std_logic_vector(10 downto 0);
signal		w_head1_we_1P:		std_logic_vector(3 downto 0);
signal		w_head1_wraddr_1P:	std_logic_vector(13 downto 0);
signal		w_head1_wrdata_1P:	std_logic_vector(62 downto 0);
signal		w_head1_rdaddr_1P:	std_logic_vector(13 dwotno 0)
signal		w_head1_rddata_3P:	std_logic_vector(62 downto 0);

begin

node_t: for i in 0 to 6 generate
	inst_head0_RAMB18E1: RAMB18E1
	generic map
	(
		-- Only generics required to be overwritten are mapped
		DOA_REG			=> '1',
		DOB_REG			=> '1',
		RAM_MODE		=> "SDP",
		READ_WIDTH_A	=> 9,
		READ_WIDTH_B	=> 0,
		WRITE_WIDTH_A	=> 0,
		WRITE_WIDTH_B	=> 9
	)
	port map
	(
		DOADO			=> w_head0_rddata_3P(i*9+7 downto i*9+0),
		DOPADOP			=> w_head0_rddata_3P(i*9+8),
		ADDRARDADDR		=> w_head0_rdaddr,
		CLKARDCLK		=> i_rd_clk,
		ENARDEN			=> '1',
		REGCEAREGCE		=> '1',
		RSTRAMARSTRAM	=> i_rd_arst,
		RSTREGARSTREG	=> i_rd_arst,
		WEA				=> "00",
		DIADI			=> w_head0_wrdata_1P(i*9+7 downto i*9+0),
		DIPADIP			=> w_head0_wrdata_1P(i*9+8),
		ADDRBWRADDR		=> w_head0_wraddr_1P,
		CLKBWRCLK		=> i_wr_clk,
		ENBWREN			=> '1',
		RSTRAMB			=> i_wr_arst,
		RSTREGB			=> i_wr_arst,
		WEBWE			=> w_head0_we_1P,
		DIBDI			=> w_head0_wrdata_1P(i*9+7 downto i*9+0),
		DIPBDIP			=> w_head0_wrdata_1P(i*9+8)
	);
	
	inst_head1_RAMB18E1: RAMB18E1
	generic map
	(
		-- Only generics required to be overwritten are mapped
		DOA_REG			=> '1',
		DOB_REG			=> '1',
		RAM_MODE		=> "SDP",
		READ_WIDTH_A	=> 9,
		READ_WIDTH_B	=> 0,
		WRITE_WIDTH_A	=> 0,
		WRITE_WIDTH_B	=> 9
	)
	port map
	(
		DOADO			=> w_head1_rddata_3P(i*9+7 downto i*9+0),
		DOPADOP			=> w_head1_rddata_3P(i*9+8),
		ADDRARDADDR		=> w_head1_rdaddr,
		CLKARDCLK		=> i_rd_clk,
		ENARDEN			=> '1',
		REGCEAREGCE		=> '1',
		RSTRAMARSTRAM	=> i_rd_arst,
		RSTREGARSTREG	=> i_rd_arst,
		WEA				=> "00",
		DIADI			=> w_head1_wrdata_1P(i*9+7 downto i*9+0),
		DIPADIP			=> w_head1_wrdata_1P(i*9+8),
		ADDRBWRADDR		=> w_head1_wraddr_1P,
		CLKBWRCLK		=> i_wr_clk,
		ENBWREN			=> '1',
		RSTRAMB			=> i_wr_arst,
		RSTREGB			=> i_wr_arst,
		WEBWE			=> w_head1_we_1P,
		DIBDI			=> w_head1_wrdata_1P(i*9+7 downto i*9+0),
		DIPBDIP			=> w_head1_wrdata_1P(i*9+8)
	);
end generate node_t;

process(i_wr_arst, i_wr_clk)
begin
	if (i_wr_arst = '1') then
		r_head0_we_1P		<= '0';
		r_head0_wraddr_1P	<= (others => '0');
		r_head0_wrdata_1P	<= (others => '0');
		r_head1_we_1P		<= '0';
		r_head1_wraddr_1P	<= (others => '0');
		r_head1_wrdata_1P	<= (others => '0');
	elsif (rising_edge(i_wr_clk)) then
		r_head0_we_1P	<= '0';
		r_head1_we_1P	<= '0';
		
		if (r_head0_wraddr_1P /= 2) then
			r_head0_we_1P	<= '1';
			r_head0_wraddr_1P	<= r_head0_wraddr_1P+1;
			
			if (r_head0_wraddr_1P = 1) then
				r_head0_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb)	<= x"3";
				r_head0_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb)	<= x"4";
				r_head0_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb)		<= 5;
				r_head0_wrdata_1P(node_t_next_msb downto node_t_next_lsb)		<= NULL_pointer;
			else -- Initial case at last
				r_head0_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb)	<= x"0";
				r_head0_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb)	<= x"1";
				r_head0_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb)		<= 2;
				r_head0_wrdata_1P(node_t_next_msb downto node_t_next_lsb)		<= r_head0_wraddr_1P+1;
			end if;
		end if;
		
		if (r_head1_wraddr_1P /= 2) then
			r_head1_we_1P	<= '1';
			r_head1_wraddr_1P	<= r_head0_wraddr_1P+1;
			
			if (r_head1_wraddr_1P = 1) then
				r_head1_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb)	<= x"9";
				r_head1_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb)	<= x"A";
				r_head1_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb)		<= 11;
				r_head1_wrdata_1P(node_t_next_msb downto node_t_next_lsb)		<= NULL_pointer;
			else -- Initial case at last
				r_head1_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb)	<= x"6";
				r_head1_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb)	<= x"7";
				r_head1_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb)		<= 8;
				r_head1_wrdata_1P(node_t_next_msb downto node_t_next_lsb)		<= r_head0_wraddr_1P+1;
			end if;
		end if;
	end if;
end process;

w_head0_we_1P(3 downto 2)										<= (others => '0');
w_head0_we_1P(1 downto 0)										<= r_head0_we_1P & r_head0_we_1P;
w_head0_wraddr_1P(13 downto 3)									<= r_head0_wraddr_1P;
w_head0_wraddr_1P(2 downto 0)									<= (others => '1');
w_head0_wrdata_1P(62 downto node_t_next_msb+1)					<= (others => '0');
w_head0_wrdata_1P(node_t_next_msb downto node_t_myChar0_lsb)	<= r_head0_wrdata_1P;
w_head0_rdaddr_1P(13 downto 3)									<= r_head0_rdaddr_1P;
w_head0_rdaddr_1P(2 downto 0)									<= (others => '1');

w_head1_we_1P(3 downto 2)										<= (others => '0');
w_head1_we_1P(1 downto 0)										<= r_head1_we_1P & r_head1_we_1P;
w_head1_wraddr_1P(13 downto 3)									<= r_head1_wraddr_1P;
w_head1_wraddr_1P(2 downto 0)									<= (others => '1');
w_head1_wrdata_1P(62 downto next_msb+1)							<= (others => '0');
w_head1_wrdata_1P(node_t_next_msb downto node_t_myChar0_lsb)	<= r_head1_wrdata_1P;
w_head1_rdaddr_1P(13 downto 3)									<= r_head1_rdaddr_1P;
w_head1_rdaddr_1P(2 downto 0)									<= (others => '1');

end RTL;
