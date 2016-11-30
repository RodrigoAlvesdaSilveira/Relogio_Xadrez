library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity x_divisor is
  Port (
    div : in std_logic_vector(5 downto 0);
    clock : in std_logic;
    new_clock : out std_logic
  );
end x_divisor;

architecture Behavioral of x_divisor is

  signal contador : std_logic_vector(31 downto 0) := (others=>'0');
  signal internal_new_clock : std_logic := '0';

begin

  new_clock <= internal_new_clock;

  process(clock)
    begin
    if (clock'event and clock='1') then
      if(contador >= 2**to_integer(unsigned(div))) then
        internal_new_clock <= not internal_new_clock;
        contador <= x"00000000";
      else
        contador <= contador + 1;
      end if;
    end if;
  end process;

end Behavioral;

