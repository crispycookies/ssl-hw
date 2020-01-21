--------------------------------------------------------------------------------
--
--   FileName:         wrapper.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 13.1 Build 162 SJ Full Version
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY hdc1000_wrapper IS
  PORT(
    CLOCK_50         : IN     STD_LOGIC; 	--system clock
    RESET_N   	     : IN     STD_LOGIC; 	--active low reset
    DRDY		     : IN		 STD_LOGIC;
	SCL				 : INOUT  STD_LOGIC;
	SDA				 : INOUT  STD_LOGIC;
	DRDY_logic		 : OUT	 STD_LOGIC;
	SCL_logic		 : OUT    STD_LOGIC;
	SDA_logic		 : OUT    STD_LOGIC;
	 
	avs_read_addr    : IN STD_LOGIC_VECTOR(3 downto 0);
	avs_read_enable  : IN STD_LOGIC;
	avs_read_data    : OUT STD_LOGIC_VECTOR(31 downto 0)
    );                   			
END hdc1000_wrapper;

ARCHITECTURE logic OF hdc1000_wrapper IS

	signal DRDY_ff1 : STD_ULOGIC;
	signal DRDY_ff2 : STD_ULOGIC;
    
BEGIN
	
	DRDY_logic <= DRDY;
	SCL_logic  <= SCL;
	SDA_logic  <= SDA;
	
	PROCESS(CLOCK_50, RESET_N)
	BEGIN
		IF(RESET_N = '0') THEN               
			DRDY_ff1 <= '0';
			DRDY_ff2 <= '0';
			
		ELSIF(CLOCK_50'EVENT AND CLOCK_50 = '1') THEN
			DRDY_ff1 <= DRDY;
			DRDY_ff2 <= DRDY_ff1;
		  
		END IF;
	END PROCESS;
	

 HDC1000C : entity work.hdc1000_controller(logic)
	port map (
	   clk       => CLOCK_50,                
	   reset_n   => RESET_N,                
	   sda       => SDA,                    
	   scl       => SCL,
	   drdy      => DRDY_ff2,
	   read_addr => avs_read_addr,   
	   read_enable => avs_read_enable,
	   read_data => avs_read_data 
    );          


  

END logic;
