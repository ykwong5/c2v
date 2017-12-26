constant	node_t_myChar0_lsb:		integer := 0;
constant	node_t_myChar0_msb:		integer := 7;
constant	node_t_myChar1_lsb:		integer := 8;
constant	node_t_myChar1_msb:		integer := 15;
constant	node_t_myInt_lsb:		integer := 0;
constant	node_t_myInt_msb:		integer := 31;
constant	node_t_next_lsb:		integer := 16;
constant	node_t_next_msb:		integer := 27;
constant	node_t_myChar0_offset:	integer := 0;
constant	node_t_myChar1_offset:	integer := 0;
constant	node_t_myInt_offset:	integer :=1;
constant	node_t_next_offset:		integer := 0;
constant	node_t_member_addr_lsb:	integer := 0;
constant	node_t_member_addr_msb:	integer := 0;
constant	node_t_depth_addr_lsb:	integer := 1;
constant	node_t_depth_addr_msb:	integer := 11;
constant	NULL_pointer:			std_logic_vector(11 downto 0) := (others => '0');

signal r_head0_we_1P:		std_logic;
signal r_head0_wraddr_1P:	std_logic_vector(11 downto 0);
signal r_head0_wrdata_1P:	std_logic_vector(31 downto 0);
signal r_head0_rdaddr_1P:	std_logic_vector(11 downto 0);
signal w_head0_we_1P:		std_logic_vector(7 downto 0);
signal w_head0_wraddr_1P:	std_logic_vector(15 downto 0);
signal w_head0_wrdata_1P:	std_logic_vector(35 downto 0);
signal w_head0_rdaddr_1P:	std_logic_vector(15 downto 0)
signal w_head0_rddata_3P:	std_logic_vector(35 downto 0);
signal r_head1_we_1P:		std_logic;
signal r_head1_wraddr_1P:	std_logic_vector(11 downto 0);
signal r_head1_wrdata_1P:	std_logic_vector(31 downto 0);
signal r_head1_rdaddr_1P:	std_logic_vector(11 downto 0);
signal w_head1_we_1P:		std_logic_vector(7 downto 0);
signal w_head1_wraddr_1P:	std_logic_vector(15 downto 0);
signal w_head1_wrdata_1P:	std_logic_vector(35 downto 0);
signal w_head1_rdaddr_1P:	std_logic_vector(15 downto 0)
signal w_head1_rddata_3P:	std_logic_vector(35 downto 0);

begin

node_t: for i in 0 to 3 generate
	inst_head0_RAMB36E1: RAMB36E1
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

		if (r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) /= 3) then
			r_head0_we_1P <= '1';
			r_head0_wraddr_1P(node_t_member_lsb) <= r_head0_wraddr_1P(node_t_member_lsb)+1;
			
			-- Node 2 Member 1
			if (r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 2 and r_head0_wraddr_1P(node_t_member_lsb) = node_t_myInt_offset) then
				r_head0_we_1P <= '0';
				r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) <= r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head0_wraddr_1P(node_t_member_lsb) <= '0';
			-- Node 2 Member 0
			elsif (r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 2 and r_head0_wraddr_1P(node_t_member_lsb) = node_t_myChar0_offset) then
				r_head0_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb) <= 5;
			-- Node 1 Member 1
			elsif (r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 1 and r_head0_wraddr_1P(node_t_member_lsb) = node_t_myInt_offset) then
				r_head0_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb) <= x"3";
				r_head0_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb) <= x"4";
				r_head0_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= NULL_pointer;
				
				r_head0_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head0_wrdata_1P(node_t_next_lsb) <= '0';
			-- Node 1 Member 0
			elsif (r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 1 and r_head0_wraddr_1P(node_t_member_lsb) = node_t_myChar0_offset) then
				r_head0_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb) <= 2;
			-- NULL, initial case at last
			else
				r_head0_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb) <= x"0";
				r_head0_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb) <= x"1";
				r_head0_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+2;
				
				r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) <= r_head0_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head0_wraddr_1P(node_t_member_lsb) <= '0';
			end if;
		end if;
		
		if (r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) /= 3) then
			r_head1_we_1P <= '1';
			r_head1_wraddr_1P(node_t_member_lsb) <= r_head1_wraddr_1P(node_t_member_lsb)+1;
			
			-- Node 2 Member 1
			if (r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 2 and r_head1_wraddr_1P(node_t_member_lsb) = node_t_myInt_offset) then
				r_head1_we_1P <= '0';
				r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) <= r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head1_wraddr_1P(node_t_member_lsb) <= '0';
			-- Node 2 Member 0
			elsif (r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 2 and r_head1_wraddr_1P(node_t_member_lsb) = node_t_myChar0_offset) then
				r_head1_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb) <= 5;
			-- Node 1 Member 1
			elsif (r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 1 and r_head1_wraddr_1P(node_t_member_lsb) = node_t_myInt_offset) then
				r_head1_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb) <= x"3";
				r_head1_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb) <= x"4";
				r_head1_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= NULL_pointer;
				
				r_head1_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head1_wrdata_1P(node_t_next_lsb) <= '0';
			-- Node 1 Member 0
			elsif (r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) = 1 and r_head1_wraddr_1P(node_t_member_lsb) = node_t_myChar0_offset) then
				r_head1_wrdata_1P(node_t_myInt_msb downto node_t_myInt_lsb) <= 2;
			-- NULL, initial case at last
			else
				r_head1_wrdata_1P(node_t_myChar0_msb downto node_t_myChar0_lsb) <= x"0";
				r_head1_wrdata_1P(node_t_myChar1_msb downto node_t_myChar1_lsb) <= x"1";
				r_head1_wrdata_1P(node_t_next_msb downto node_t_next_lsb+node_t_member_msb+1) <= r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+2;
				
				r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb) <= r_head1_wraddr_1P(node_t_depth_msb downto node_t_depth_lsb)+1;
				r_head1_wraddr_1P(node_t_member_lsb) <= '0';
			end if;
		end if;
	end if;
end process;

w_head0_we_1P(7 downto 1)		<= (others => '0');
w_head0_we_1P(0)				<= r_head0_we_1P;
w_head0_wraddr_1P(15)			<= '1';
w_head0_wraddr_1P(14 downto 3)	<= r_head0_wraddr_1P;
w_head0_wraddr_1P(2 downto 0)	<= (others => '1');
w_head0_wrdata_1P(35 downto 32)	<= (others => '0');
w_head0_wrdata_1P(31 downto 0)	<= r_head0_wrdata_1P;
w_head0_rdaddr_1P(15)			<= '1';
w_head0_rdaddr_1P(14 downto 3)	<= r_head0_rdaddr_1P;
w_head0_rdaddr_1P(2 downto 0)	<= (others => '1');

w_head1_we_1P(7 downto 1)		<= (others => '0');
w_head1_we_1P(0)				<= r_head1_we_1P;
w_head1_wraddr_1P(15)			<= '1';
w_head1_wraddr_1P(14 downto 3)	<= r_head1_wraddr_1P;
w_head1_wraddr_1P(2 downto 0)	<= (others => '1');
w_head1_wrdata_1P(35 downto 32) <= (others => '0');
w_head1_wrdata_1P(31 downto 0)	<= r_head1_wrdata_1P;
w_head1_rdaddr_1P(15)			<= '1';
w_head1_rdaddr_1P(14 downto 3)	<= r_head1_rdaddr_1P;
w_head1_rdaddr_1P(2 downto 0)	<= (others => '1');

end RTL;
