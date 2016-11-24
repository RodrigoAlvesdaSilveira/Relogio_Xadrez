library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity x_bcd7seg is
  port (
     d : in std_logic_vector(3 downto 0);
    sa : out std_logic;
    sb : out std_logic;
    sc : out std_logic;
    sd : out std_logic;
    se : out std_logic;
    sf : out std_logic;
    sg : out std_logic
  );
end x_bcd7seg;

architecture comportamento of x_bcd7seg is
begin

  sa <= '0' when d="0000" or d="0010" or d="0011" or d="0101" or d="0110" or d="0111" or d="1000" or d="1001" else '1';
  sb <= '0' when d="0000" or d="0001" or d="0010" or d="0011" or d="0100" or d="0111" or d="1000" or d="1001" else '1';
  sc <= '0' when d="0000" or d="0001" or d="0011" or d="0100" or d="0101" or d="0110" or d="0111" or d="1000" or d="1001" else '1';
  sd <= '0' when d="0000" or d="0010" or d="0011" or d="0101" or d="0110" or d="1000" or d="1001" else '1';
  se <= '0' when d="0000" or d="0010" or d="0110" or d="1000" else '1';
  sf <= '0' when d="0000" or d="0100" or d="0101" or d="0110" or d="1000" or d="1001" else '1';
  sg <= '0' when d="0010" or d="0011" or d="0100" or d="0101" or d="0110" or d="1000" or d="1001" else '1';

end comportamento;

--      a b c d e f g
-- 0000 1 1 1 1 1 1 0
-- 0001 0 1 1 0 0 0 0
-- 0010 1 1 0 1 1 0 1
-- 0011 1 1 1 1 0 0 1
-- 0100 0 1 1 0 0 1 1
-- 0101 1 0 1 1 0 1 1
-- 0110 1 0 1 1 1 1 1
-- 0111 1 1 1 0 0 0 0
-- 1000 1 1 1 1 1 1 1
-- 1001 1 1 1 1 0 1 1

