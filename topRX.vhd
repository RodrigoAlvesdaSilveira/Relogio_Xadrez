library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity timer is
  Port (
        clock, start, reset, player1, player2, configplayer1, configplayer2: in std_logic;
	    a,b,c,d,e,f,g: out std_logic;
	    muxDisplay:out std_logic_vector(3 downto 0);
  );
end timer;

architecture Behavioral of timer is


    PC: entity controle port map(clock, start, reset, win, endGame,)
    
begin

            		
end Behavioral;

