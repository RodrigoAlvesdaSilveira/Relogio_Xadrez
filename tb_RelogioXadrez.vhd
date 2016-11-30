LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_RelogioXadrez IS
END tb_RelogioXadrez;
 
ARCHITECTURE behavior OF tb_RelogioXadrez IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT topRelogioXadrez
    PORT(
         reset : IN  std_logic;
         start : IN  std_logic;
         clock : IN  std_logic;
         modo : IN  std_logic;
         btnJogador1 : IN  std_logic;
         btnJogador2 : IN  std_logic;
         btnXequeMate : IN  std_logic;
         sa : OUT  std_logic;
         sb : OUT  std_logic;
         sc : OUT  std_logic;
         sd : OUT  std_logic;
         se : OUT  std_logic;
         sf : OUT  std_logic;
         sg : OUT  std_logic;
         disp1_uni_en : OUT  std_logic;
         disp1_dez_en : OUT  std_logic;
         disp2_uni_en : OUT  std_logic;
         disp2_dez_en : OUT  std_logic;
         vitorioso : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal clock : std_logic := '0';
   signal modo : std_logic := '0';
   signal btnJogador1 : std_logic := '0';
   signal btnJogador2 : std_logic := '0';
   signal btnXequeMate : std_logic := '0';

 	--Outputs
   signal sa : std_logic;
   signal sb : std_logic;
   signal sc : std_logic;
   signal sd : std_logic;
   signal se : std_logic;
   signal sf : std_logic;
   signal sg : std_logic;
   signal disp1_uni_en : std_logic;
   signal disp1_dez_en : std_logic;
   signal disp2_uni_en : std_logic;
   signal disp2_dez_en : std_logic;
   signal vitorioso : std_logic_vector(1 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: topRelogioXadrez PORT MAP (
          reset => reset,
          start => start,
          clock => clock,
          modo => modo,
          btnJogador1 => btnJogador1,
          btnJogador2 => btnJogador2,
          btnXequeMate => btnXequeMate,
          sa => sa,
          sb => sb,
          sc => sc,
          sd => sd,
          se => se,
          sf => sf,
          sg => sg,
          disp1_uni_en => disp1_uni_en,
          disp1_dez_en => disp1_dez_en,
          disp2_uni_en => disp2_uni_en,
          disp2_dez_en => disp2_dez_en,
          vitorioso => vitorioso
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for 5 ns;
		clock <= '1';
		wait for 5 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

       reset <= '0';
       start <= '1';
       modo <= '1';
		 
       btnJogador1 <= '1';
       btnJogador2 <= '0';
		 
		 btnXequeMate <='0';

      wait for 500 ns;
		
		 btnJogador1 <= '0';
       btnJogador2 <= '1';
		 
		 btnXequeMate <='0';

      wait for 500 ns;
		
		
		btnJogador1 <= '1';
      btnJogador2 <= '0';
		
		btnXequeMate <='1';
		
		wait for 1000 ns;
		
		reset <= '1', '0' after 10 ns;
		btnXequeMate <='0';
		btnJogador1 <= '1';
      btnJogador2 <= '0';
		
		start <= '0', '1' after 10 ns; 
		
		wait for 1000 ns;
		
		-- btnXequeMate <='1';
		
      wait;
		
   end process;

END;
