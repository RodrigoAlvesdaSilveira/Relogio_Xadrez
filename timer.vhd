library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity timer is
  Port (
    clock : in std_logic;
		enable: in std_logic;
		mode: in std_logic;
		endGame : out std_logic;
		display1: out std_logic_vector(4 downto 0)
		display2: out std_logic_vector(4 downto 0)
  );
end timer;

architecture Behavioral of timer is
    
    signal counter1 : std_logic_vector(3 downto 0) := "0000";
    signal counter2 : std_logic_vector(3 downto 0) := "0110";
    
begin


  process(clock, input)
    begin

    if(reset = '1') then
			counter1 <= 0;
			counter2 <= 6;
			result <= 0;
    elsif (clock'event and clock='1' and enable = '1') then
			counter2 <= counter2-1 when counter1 = 0 else 6 when counter2 = 0 and counter1 = 0;
			counter1 <= 0 when counter2 = 0 else 9 when counter1 = 0 else counter1-1;
    end if;
    
  end process;  
	
		display1 <= counter1;
		display2 <= counter2;
        endGame  <= 1 when counter1 = 0 and counter2 = 0 else 0;
            		
end Behavioral;

