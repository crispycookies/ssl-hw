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

ENTITY apds9301_wrapper IS
  PORT(
    CLOCK_50         : IN     STD_LOGIC; 	--system clock
    RESET_N   	     : IN     STD_LOGIC; 	--active low reset
	SCL				 : INOUT  STD_LOGIC;
	SDA		 		 : INOUT  STD_LOGIC;
	SCL_logic		 : OUT    STD_LOGIC;
	SDA_logic		 : OUT    STD_LOGIC;
	
	avs_read_addr    : IN STD_LOGIC_VECTOR(3 downto 0);
	avs_read_enable  : IN STD_LOGIC;
	avs_read_data    : OUT STD_LOGIC_VECTOR(31 downto 0)
    );                   			
END apds9301_wrapper;

ARCHITECTURE logic OF apds9301_wrapper IS
    
BEGIN
	
	SCL_logic  <= SCL;
	SDA_logic  <= SDA;
	
 APDS9301 : entity work.apds9301_controller(logic)
	port map (
	   clk       => CLOCK_50,                
	   reset_n   => RESET_N,     
	   sda       => SDA,                    
	   scl       => SCL,
	   read_addr => avs_read_addr,   
	   read_enable => avs_read_enable,
	   read_data => avs_read_data 
    );          

END logic;
