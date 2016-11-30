library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity controleRelogioXadrez is
  port (
      reset : in std_logic;
      start : in std_logic;
      clock : in std_logic;
      
      modo : in std_logic; -- vem de um switch button quando tiver em 0 eh modo cfg se 1 eh modo contagem
      btnJogador1 : in std_logic;
      btnJogador2 : in std_logic;
      btnXequeMate : in std_logic;
      
      contarJogador1 : out std_logic;
      contarJogador2 : out std_logic;
      
      vitorioso : out std_logic_vector(1 downto 0);
	   endGame : in std_logic
  );
end controleRelogioXadrez;

architecture Behavioral of controleRelogioXadrez is
  type tstate is (espera, configura, desconta, fim);
  signal estado : tstate;
  signal vencedor : std_logic_vector(1 downto 0) := "00";
  signal vezJogador : std_logic;
begin

  process(clock, reset, start)
  begin
    if (reset='1') then
      estado <= espera;
    elsif (clock'event and clock='1') then
      case estado is
        when espera =>
          if start='1' then
			 
            estado <= configura;
            contarJogador1 <= '0';
            contarJogador2 <= '0';
            vitorioso <= "00";
				
          else
			 
            estado <= espera;
				contarJogador1 <= '0';
            contarJogador2 <= '0';
				
          end if;
			 
        when configura =>
		  
          if modo='0' and start = '1' then
            if btnJogador1='1' then
              contarJogador1 <= '1';
				else 
				  contarJogador1 <= '0';
            end if;
            if btnJogador2='1' then
              contarJogador2 <= '1';
			   else 
				  contarJogador2 <= '0';
            end if;
            estado <= configura;
				
          elsif modo='1' and start = '1' then
            estado <= desconta;
          end if;
			 
        when desconta =>

          if btnXequeMate='1' then
            estado <= fim;
				if (vezJogador='1') then
					vencedor <= "10";
				else
					vencedor <= "01";
				end if;
          elsif (btnJogador1='1' and btnJogador2='0') then
            contarJogador1 <= '1';
            contarJogador2 <= '0';
				vezJogador <= '0';
          elsif (btnJogador1='0' and btnJogador2='1') then
            contarJogador1 <= '0';
            contarJogador2 <= '1';
				vezJogador <= '1';
          end if;

		  if (endGame='1') then
				if (vezJogador='1') then
					vencedor <= "10";
				else
					vencedor <= "01";
				end if;
				estado <= fim;
		  end if;

        when fim =>
          vitorioso <= vencedor;
			 contarJogador1 <= '0';
			 contarJogador2 <= '0';
          -- reiniciar no reset
        when others => 
          estado <= espera;
        end case;
      end if;
  end process;

end Behavioral;
