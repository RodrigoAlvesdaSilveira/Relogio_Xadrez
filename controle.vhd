library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity timer is
  Port (
    clock, start, reset, win, endGame: in std_logic;
	mode, resetPO: out std_logic);	
end timer;

architecture Behavioral of timer is
	type state is (reset, configura, inicia, fim);
begin


  process(clock)
    begin
		if(reset = '1')then 
			state <= reset;
		elsif(clock'event = '1' and clock = '1') then 
			case state is			
				when reset =>
			
					mode <= '0';
					resetPO<='1';
					state <= configura;
					
				when configura=>
					
					mode <='0';
					resetPO <= '0';
					if(start =1 )then
						state <= configura;
					else
						state <= inicia;
					end if;
					
				when inicia =>
				
				    mode <= '1';
				    resetPO <= '0';
			        if(win = '1' or endGame = '1') then 
			            state <= fim;
			        else
				        stae <= inicia;
				    end if;
				    
				 when fim => 
				    
				    mode <= '0';
				    resetPO <= '0';
				     
				 end case
			end if;
		            
  end process;  
  
end Behavioral;

