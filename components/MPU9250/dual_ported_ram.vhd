----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 14:38:09
-- Design Name: 
-- Module Name: dual_ported_ram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dual_ported_ram is
port(   clk: in std_logic; --clock

        wr_en_0 : in std_logic;   --write enable for port 0
        wr_en_1 : in std_logic;   --write enable for port 1
		
		rd_en_0 : in std_logic;   --write enable for port 0
        rd_en_1 : in std_logic;   --write enable for port 1
		
        data_in_0 : in std_logic_vector(31 downto 0);  --Input data to port 0.
        data_in_1 : in std_logic_vector(31 downto 0);  --Input data to port 0.
		
        addr_in_0 : in std_logic_vector(11 downto 0);    --address for port 0
        addr_in_1 : in std_logic_vector(11 downto 0);    --address for port 1
		
        data_out_0 : out std_logic_vector(31 downto 0);  --output data from port 0.
        data_out_1 : out std_logic_vector(31 downto 0)   --output data from port 1.
    );
end dual_ported_ram;

architecture Behavioral of dual_ported_ram is

    type ram_type is array(0 to 3071) of std_logic_vector(31 downto 0);
    shared variable ram : ram_type;

begin
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(wr_en_0 = '1') then
                ram(to_integer(unsigned(addr_in_0))) := data_in_0;
            end if;
			if(rd_en_0 = '1') then
				data_out_0 <= ram(to_integer(unsigned(addr_in_0)));
			end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(wr_en_1 = '1') then
                ram(to_integer(unsigned(addr_in_1))) := data_in_1;
            end if;
			if(rd_en_1 = '1') then
				data_out_1 <= ram(to_integer(unsigned(addr_in_1)));
			end if;
        end if;
    end process;


end Behavioral;
