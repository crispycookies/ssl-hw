--------------------------------------------------------------------------------
--
--   FileName:         hdc1000_controller.vhd
--   Dependencies:     none
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY hdc1000_controller IS
  PORT(
    clk       : IN     STD_LOGIC; 	--system clock
    reset_n   : IN     STD_LOGIC; 	--active low reset
    sda       : INOUT  STD_LOGIC;
    scl       : INOUT  STD_LOGIC;
    drdy      : IN     STD_LOGIC;
	
	read_addr : IN STD_LOGIC_VECTOR(3 downto 0);
	read_enable : IN STD_LOGIC;
	read_data : OUT STD_LOGIC_VECTOR(31 downto 0)
    );                   			
END hdc1000_controller;

ARCHITECTURE logic OF hdc1000_controller IS

	-- i2c inputs and outputs
    signal ena  : STD_ULOGIC; 
    signal addr : STD_ULOGIC_VECTOR(6 DOWNTO 0);
    signal rw   : STD_ULOGIC; 
    signal data_wr : STD_ULOGIC_VECTOR(7 DOWNTO 0);
    signal busy : STD_ULOGIC;
    signal data_rd : STD_ULOGIC_VECTOR(7 DOWNTO 0); 
	
	-- intern control sigs to handle communication
	signal drdy_prev : std_ulogic;
	signal busy_prev : std_ulogic;
	signal data : STD_ULOGIC_VECTOR(31 DOWNTO 0); 
	
	-- counter values for sampling freq
	signal counter : integer;
	constant counter_max : integer := 1000000;
	
	-- register with the actual result
	signal resReg : std_ulogic_vector(31 downto 0);
	signal internWrite : std_ulogic;
	
	-- state machine
	TYPE machine IS(startUp, init, measureStart, measureWait, measureRead, saveRes, waitNextMeasure);
    SIGNAL state : machine;
    
BEGIN

	-- -------------------------------------------
	-- inst of the i2c master
	-- -------------------------------------------
	I2CMaster : entity work.i2c_master(logic)
		generic map (
			input_clk => 50000000,
			bus_clk => 100000
		)
		port map (
			clk       => clk,                
			reset_n   => reset_n,                
		    ena       => ena,                    
			addr      => std_logic_vector(addr),
		    rw        => rw,                
		    data_wr   => std_logic_vector(data_wr),
		    busy      => busy,           
		    STD_ULOGIC_VECTOR(data_rd)   => data_rd, 
		    ack_error => open,                    
		    sda       => sda,                  
		    scl       => scl
		);         

		
	-- -------------------------------------------
	-- process to handle sensor communication
	-- -------------------------------------------
	PROCESS(clk, reset_n)
		variable busy_cnt : integer := 0;
	BEGIN
		IF(reset_n = '0') THEN                --reset asserted
			ena <= '0';
			addr <= (others => '0');
			rw <= '1';
			data_wr <= (others => '0');
			
			busy_prev <= '0';
			drdy_prev <= '0';
			data <= (others => '0');
			
			busy_cnt := 0;
			
			counter <= 0;
			
			resReg <= (others => '0');
			internWrite <= '0';

			state <= startUp;
        
		ELSIF(clk'EVENT AND clk = '1') THEN
			  
			counter <= counter + 1;
			
			case state is
			
				when startUp =>
					if(busy = '0') then
						state <= init;
					end if;
			
				when init => 
					busy_prev <= busy; 
			
					IF(busy_prev = '0' AND busy = '1') THEN  
						busy_cnt := busy_cnt + 1;                   
					END IF;
					CASE busy_cnt IS     
			  
					WHEN 0 =>                                  
					  ena <= '1';                            
					  addr <= "1000000";                   
					  rw <= '0';                          
					  data_wr <= x"02";  

					WHEN 1 =>                                 
					  data_wr <= x"30";
					  rw <= '0'; 
					  
					WHEN 2 => 
					  data_wr <= x"00";
					  rw <= '0'; 

					when 3 => 
						ena <= '0';
						if(busy = '0') then
							busy_cnt := 0;
							state <= measureStart;
						end if;
					  
					WHEN OTHERS => NULL;
					END CASE;	
					
				when measureStart => 
					ena <= '1';                            
					addr <= "1000000";                   
					rw <= '0';                          
					data_wr <= x"00";
					
					if(busy = '1') then
						ena <= '0';
						state <= measureWait;
					end if;
					
				when measureWait => 
					drdy_prev <= drdy;
					if(drdy_prev = '1' AND drdy = '0') then 
						state <= measureRead;
					end if;
					
				when measureRead =>
					busy_prev <= busy; 
			
					IF(busy_prev = '0' AND busy = '1') THEN  
						busy_cnt := busy_cnt + 1;                   
					END IF;
					CASE busy_cnt IS     
			  
					WHEN 0 =>                                  
					  ena <= '1';                            
					  addr <= "1000000";                   
					  rw <= '1';                          

					WHEN 1 =>                                 
					  rw <= '1'; 
					  IF(busy = '0') THEN                  
						data(31 DOWNTO 24) <= data_rd;         
					  END IF;
					  
					WHEN 2 => 
					  rw <= '1'; 
					  IF(busy = '0') THEN                  
						data(23 DOWNTO 16) <= data_rd; 
					  END IF;
					  
					WHEN 3 => 
					  rw <= '1'; 
					  IF(busy = '0') THEN                  
						data(15 DOWNTO 8) <= data_rd; 
					  END IF;
					  
					WHEN 4 => 
					  rw <= '1'; 
					  ena <= '0';
					  IF(busy = '0') THEN                  
						data(7 DOWNTO 0) <= data_rd; 
						busy_cnt := 0;
						state <= saveRes;
						internWrite <= '1';
					  END IF;
					  
					WHEN OTHERS => NULL;
					END CASE;
				
				when saveRes => 
					resReg <= data;
					state <= waitNextMeasure;
					
				when waitNextMeasure =>
					internWrite <= '0';
					if(counter >= counter_max) then
						counter <= 0;
						state <= measureStart;
					end if;
				
				when others => NULL;
			end case;

		END IF;
	END PROCESS;
	
	-- -------------------------------------------
	-- process to handle data read
	-- -------------------------------------------
	PROCESS(read_addr, read_enable, resReg, internWrite, data)
	BEGIN
		if(read_enable = '1') then
			if(internWrite = '0') then
				read_data <= std_logic_vector(resReg);
			else
				read_data <= std_logic_vector(data);
			end if;
		else  
			read_data <= (others => '0');
		end if;
	END PROCESS;
	
END logic;
