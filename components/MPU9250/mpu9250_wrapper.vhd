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

ENTITY mpu9250_wrapper IS
  PORT(
    CLOCK_50        : IN    STD_LOGIC; 	--system clock
    RESET_N   	    : IN    STD_LOGIC; 	--active low reset
    
	MPU_SCL_SCLK	: INOUT	STD_LOGIC;
	MPU_AD0_SDO		: IN	STD_LOGIC;
	MPU_SDA_SDI		: INOUT	STD_LOGIC;
	MPU_CS_n		: INOUT	STD_LOGIC;
	MPU_FSYNC		: OUT	STD_LOGIC;
	
	MPU_SPI_SCLK_Dbg: OUT	STD_LOGIC;
	MPU_SPI_SDO_Dbg	: OUT	STD_LOGIC;
	MPU_SPI_SDI_Dbg	: OUT	STD_LOGIC;
	MPU_SPI_nCS_Dbg	: OUT	STD_LOGIC;
	 
	avs_addr   		: IN 	STD_LOGIC_VECTOR(3 downto 0);
	avs_read_enable : IN 	STD_LOGIC;
	avs_read_data   : OUT 	STD_LOGIC_VECTOR(31 downto 0);
	avs_write_enable: IN 	STD_LOGIC;
	avs_write_data  : IN 	STD_LOGIC_VECTOR(31 downto 0);
	
	dRam_addr 		: IN 	STD_LOGIC_VECTOR(11 downto 0);
	dRam_read_en 	: IN 	STD_LOGIC;
	dRam_read_data 	: OUT 	STD_LOGIC_VECTOR(31 downto 0);
	
	irq	: OUT STD_LOGIC
    );                   			
END mpu9250_wrapper;

ARCHITECTURE logic OF mpu9250_wrapper IS
   
BEGIN

	MPU_SPI_SCLK_Dbg <= MPU_SCL_SCLK; 	
	MPU_SPI_SDO_Dbg  <= MPU_AD0_SDO;
	MPU_SPI_SDI_Dbg  <= MPU_SDA_SDI;
	MPU_SPI_nCS_Dbg  <= MPU_CS_n;
	
	MPU_FSYNC <= '0';
 
	
	MPU9250 : entity work.mpu9250_controller(logic)
		port map (
			clk       			=> CLOCK_50,                
			reset_n   			=> RESET_N,   
			miso 				=> MPU_AD0_SDO,
			mosi 				=> MPU_SDA_SDI,
			sclk 				=> MPU_SCL_SCLK,
			ss_n 				=> MPU_CS_n,
			addr				=> avs_addr,   
			read_enable 		=> avs_read_enable,
			read_data 			=> avs_read_data,
			write_enable 		=> avs_write_enable,
			write_data 			=> avs_write_data,
			dRam_addr 			=> dRam_addr,
			dRam_read_en		=> dRam_read_en,
			dRam_read_data 		=> dRam_read_data,
			irq					=> irq
    );   
	
END logic;
