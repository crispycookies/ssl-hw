-- altera vhdl_input_version vhdl_2008
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_implementation is
	port (
		avs_s0_address     			: in  std_logic_vector(7 downto 0)  := (others => '0');
		avs_s0_read        			: in  std_logic                     := '0';
		avs_s0_readdata    			: out std_logic_vector(31 downto 0);
		avs_s0_write       			: in  std_logic                     := '0';
		avs_s0_writedata   			: in  std_logic_vector(31 downto 0) := (others => '0');
		avs_s0_waitrequest 			: out std_logic;
		clk                			: in  std_logic                     := '0';
		reset              			: in  std_logic                     := '0';
		seven_segment      			: out std_logic_vector(41 downto 0)
	);
end entity seven_segment_implementation;

architecture rtl of seven_segment_implementation is

	signal bcd0 					: std_logic_vector(3 downto 0);
	signal bcd1 					: std_logic_vector(3 downto 0);
	signal bcd2 					: std_logic_vector(3 downto 0);
	signal bcd3 					: std_logic_vector(3 downto 0);
	signal bcd4 					: std_logic_vector(3 downto 0);
	signal bcd5 					: std_logic_vector(3 downto 0);
	signal pwm_reg 					: std_logic_vector(7 downto 0);
	signal pwm_output				: std_logic;
	signal seven_segment_buffer		: std_logic_vector(41 downto 0);
	signal enable_reg 				: std_logic_vector( 5 downto 0);

begin

	bcd_converter_inst0 : entity work.bcd_to_seven
	port map (
		bcd0,
		seven_segment_buffer(6+7*0 downto  7*0)
	);

	bcd_converter_inst1 : entity work.bcd_to_seven
	port map (
		bcd1,
		seven_segment_buffer(6+7*1 downto  7*1)
	);

	bcd_converter_inst2 : entity work.bcd_to_seven
	port map (
		bcd2,
		seven_segment_buffer(6+7*2 downto  7*2)
	);

	bcd_converter_inst3 : entity work.bcd_to_seven
	port map (
		bcd3,
		seven_segment_buffer(6+7*3 downto  7*3)
	);

	bcd_converter_inst4 : entity work.bcd_to_seven
	port map (
		bcd4,
		seven_segment_buffer(6+7*4 downto  7*4)
	);

	bcd_converter_inst5 : entity work.bcd_to_seven
	port map (
		bcd5,
		seven_segment_buffer(6+7*5 downto  7*5)
	);

	pwm_controller_inst : entity work.pwm_controller
	generic map (
		dataWidth => 8
	)
	port map (
		clk => clk,
		reset => reset,

		value => pwm_reg,
		output => pwm_output
	);

	process(clk, reset, avs_s0_address, avs_s0_writedata, avs_s0_write)
	begin
		if reset = '1' then

			bcd0 <= (others => '0');
			bcd1 <= (others => '0');
			bcd2 <= (others => '0');
			bcd3 <= (others => '0');
			bcd4 <= (others => '0');
			bcd5 <= (others => '0');
			enable_reg <= (others => '0');

		elsif rising_edge(clk) then

			-- Wait until something interesting happens on the bus
			if avs_s0_write = '1' then

				-- What should we do?
				case avs_s0_address(3 downto 0) is

					-- Write to the display
					when X"0" =>
						bcd0 <= avs_s0_writedata( 3 downto  0);
						bcd1 <= avs_s0_writedata( 7 downto  4);
						bcd2 <= avs_s0_writedata(11 downto  8);
						bcd3 <= avs_s0_writedata(15 downto 12);
						bcd4 <= avs_s0_writedata(19 downto 16);
						bcd5 <= avs_s0_writedata(23 downto 20);

					-- Change the PWM value (0 to 255)
					when X"1" =>
						pwm_reg <= avs_s0_writedata(7 downto 0);

					-- The enable_reg register
					when X"2" =>
						enable_reg <= avs_s0_writedata(5 downto 0);

					when others =>

				end case;

			end if;

		end if;

	end process;

	process(enable_reg, pwm_output, seven_segment_buffer)
	begin
		seven_segment <= (others => '1'); --- initialize everything to '1' before overwriting individual bits
		for i in 0 to 5 loop
			if pwm_output = '1' and enable_reg(i) = '1' then
				seven_segment(6+7*i downto 7*i) <= seven_segment_buffer(6+7*i downto 7*i);
				end if;
		end loop;
	end process;

	avs_s0_waitrequest <= '0';
	avs_s0_readdata <= (others => '0');

end architecture rtl;
