library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity operativoRelogioXadrez is
  port (
	clock: in std_logic;
	reset: in std_logic;
     selEscritaDisplay : in std_logic_vector(1 downto 0);
	  contarJogador1 : in std_logic;
	  contarJogador2 : in std_logic;
      sa, sb, sc, sd, se, sf, sg : out std_logic;
	  endGame : out std_logic
  );
end operativoRelogioXadrez;

architecture Behavioral of operativoRelogioXadrez is
  signal sa1,sb1,sc1,sd1,se1,sf1,sg1 : std_logic;
  signal sa2,sb2,sc2,sd2,se2,sf2,sg2 : std_logic;
  signal sa3,sb3,sc3,sd3,se3,sf3,sg3 : std_logic;
  signal sa4,sb4,sc4,sd4,se4,sf4,sg4 : std_logic;
  signal clock_interno : std_logic;
  signal d1Jogador1, d2Jogador1, d1Jogador2, d2Jogador2 : std_logic_vector(3 downto 0);
  signal endGame1 : std_logic;
  signal endGame2 : std_logic;
begin

  -- ira trabalhar com clock reduzido ? 50MHz ~~> 1Hz ?
  -- transferir contador para unidade operativa e setar o clock reduzido para somente o módulo contador,
  -- ao invés da máquina trabalhar nesta frequencia?
  divisor: entity work.x_divisor
    port map(
      div=> "000001", -- mudar depois para "011001", --25d
      clock=>clock,
      new_clock=>clock_interno
    );

  contador1: entity work.x_timer port map(clock=>clock_interno, display1=>d1Jogador1, display2=>d2Jogador1, enable=>contarJogador1, endGame=>endGame1, reset=>reset);
  contador2: entity work.x_timer port map(clock=>clock_interno, display1=>d1Jogador2, display2=>d2Jogador2, enable=>contarJogador2, endGame=>endGame2, reset=>reset);

  endGame <= '1' when endGame1='1' or endGame2='1' else '0';
  
  bcd7seg1_uni: entity work.x_bcd7seg port map(d=>d1Jogador1, sa=>sa1, sb=>sb1, sc=>sc1, sd=>sd1, se=>se1, sf=>sf1, sg=>sg1);
  bcd7seg1_dez: entity work.x_bcd7seg port map(d=>d2Jogador1, sa=>sa2, sb=>sb2, sc=>sc2, sd=>sd2, se=>se2, sf=>sf2, sg=>sg2);
  bcd7seg2_uni: entity work.x_bcd7seg port map(d=>d1Jogador2, sa=>sa3, sb=>sb3, sc=>sc3, sd=>sd3, se=>se3, sf=>sf3, sg=>sg3);
  bcd7seg2_dez: entity work.x_bcd7seg port map(d=>d2Jogador2, sa=>sa4, sb=>sb4, sc=>sc4, sd=>sd4, se=>se4, sf=>sf4, sg=>sg4);

  -- Qual disp vai escrever nos barramento de segmento ?
  process (selEscritaDisplay)
  begin
	  case selEscritaDisplay is
		 when "01" =>
			sa<=sa1;sb<=sb1;sc<=sc1;sd<=sd1;se<=se1;sf<=sf1;sg<=sg1;
		 when "10" =>
			sa<=sa2;sb<=sb2;sc<=sc2;sd<=sd2;se<=se2;sf<=sf2;sg<=sg2;
		 when "11" =>
			sa<=sa3;sb<=sb3;sc<=sc3;sd<=sd3;se<=se3;sf<=sf3;sg<=sg3;
		 when "00" =>
			sa<=sa4;sb<=sb4;sc<=sc4;sd<=sd4;se<=se4;sf<=sf4;sg<=sg4;
		 when others =>
			sa<=sa1;sb<=sb1;sc<=sc1;sd<=sd1;se<=se1;sf<=sf1;sg<=sg1;
	  end case;
  end process;

end Behavioral;
