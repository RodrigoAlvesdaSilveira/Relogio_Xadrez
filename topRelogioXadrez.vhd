library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity topRelogioXadrez is
  port (
      reset : in std_logic; -- switch button
      start : in std_logic; -- switch button
      clock : in std_logic; -- clk ~ 50MHz

      modo : in std_logic; -- vem de um switch button quando tiver em 0 eh modo cfg se 1 eh modo contagem
      btnJogador1 : in std_logic; -- push button
      btnJogador2 : in std_logic; -- push button
      btnXequeMate : in std_logic; -- push button

      sa, sb, sc, sd, se, sf, sg : out std_logic; -- 7seg
      disp1_uni_en, disp1_dez_en, disp2_uni_en, disp2_dez_en : out std_logic; -- 7seg, os displays sao todos multiplexados catodo comum
      vitorioso : out std_logic_vector(1 downto 0) -- 01b -> jogador 1 ; 10b -> jogador 2
  );
end topRelogioXadrez;

architecture Behavioral of topRelogioXadrez is
  signal tempoJogador1 : std_logic_vector(7 downto 0) := (others=>'0');
  signal tempoJogador2 : std_logic_vector(7 downto 0) := (others=>'0');
  signal escritaDisplay : std_logic_vector(1 downto 0) := (others=>'0');
  signal clock_interno : std_logic;
  signal contarJogador1, contarJogador2, endGame : std_logic;

begin

  divisor: entity work.x_divisor
    port map(
      div=> "010000", -- mudar depois para "011001", --25d
      clock=>clock,
      new_clock=>clock_interno
    );
	 
  controle: entity work.controleRelogioXadrez 
    port map(
      reset=>reset,
      start=>start,
      clock=>clock,
      modo=>modo,
      btnJogador1=>btnJogador1,
      btnJogador2=>btnJogador2,
		contarJogador1=>contarJogador1,
		contarJogador2=>contarJogador2,
      btnXequeMate=>btnXequeMate,
	   endGame=>endGame,
      vitorioso=>vitorioso
    );

  operativo: entity work.operativoRelogioXadrez 
    port map(
	 clock=>clock,
	 reset=>reset,
      selEscritaDisplay=>escritaDisplay,
	  contarJogador1=>contarJogador1,
	  contarJogador2=>contarJogador2,
      sa=>sa,
      sb=>sb,
      sc=>sc, 
      sd=>sd,
      se=>se,
      sf=>sf,
      sg=>sg,
	  endGame=>endGame
    );

  -- LOGICA PARA MOSTRAGEM (JA QUE DISPLAYS SAO MULTIPLEX)
  -- verificar frequencia (talvez deve ser necessario usar uma nova instancia do divisor para gerar um clock reduzido)
  
  process(clock_interno)
  begin
    if (clock_interno'event and clock_interno='1') then
      case escritaDisplay is
        when "00" =>
          disp1_uni_en <= '0';
          disp1_dez_en <= '1';
          disp2_uni_en <= '1';
          disp2_dez_en <= '1';
        when "01" =>
          disp1_uni_en <= '1';
          disp1_dez_en <= '0';
          disp2_uni_en <= '1';
          disp2_dez_en <= '1';
        when "10" =>
          disp1_uni_en <= '1';
          disp1_dez_en <= '1';
          disp2_uni_en <= '0';
          disp2_dez_en <= '1';
        when "11" =>
          disp1_uni_en <= '1';
          disp1_dez_en <= '1';
          disp2_uni_en <= '1';
          disp2_dez_en <= '0';
        when others => 
          disp1_uni_en <= '1';
          disp1_dez_en <= '1';
          disp2_uni_en <= '1';
          disp2_dez_en <= '1';
      end case;
      escritaDisplay <= escritaDisplay + 1;
    end if;
  end process;

end Behavioral;
