library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity x_timer is
  Port (
   clock : in std_logic;
	enable: in std_logic;
	reset: in std_logic;
	endGame : out std_logic;
	display1: out std_logic_vector(3 downto 0);
	display2: out std_logic_vector(3 downto 0)
  );
end x_timer;

architecture Behavioral of x_timer is
    
    signal counter1 : std_logic_vector(3 downto 0) := "0000";
    signal counter2 : std_logic_vector(3 downto 0) := "0110";
    
begin

  process(clock, reset)
    begin

		 if(reset = '1') then
			counter1 <= x"0";
			counter2 <= x"6";
		 elsif (clock'event and clock='1' and enable = '1') then
			
			if(counter1 = 0 and counter2 = 0) then 
				counter1 <= x"0";
				counter2 <= x"6";
			elsif counter1 = 0 then 
				counter1 <= x"9";
				counter2 <= counter2-1;
				else 
					counter1 <= counter1-1;
			end if;
		end if;
  end process;  

	display1 <= counter1;
	display2 <= counter2;
	
	endGame  <= '1' when counter1 = 0 and counter2 = 0 else '0';

end Behavioral;

