

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity baud_rate_gen_tb is
end baud_rate_gen_tb;

architecture Behavioral of baud_rate_gen_tb is
COMPONENT baud9k6_e IS
    GENERIC(
        baudrate  : integer := 1250
    ); 
	PORT(clk_i    : in std_logic; -- 12MHz
	     rst_n_i  : in std_logic; -- active low
	     en_o     : out std_logic
    ); --  trigger
END COMPONENT;

CONSTANT baudrate : integer := 1250;
CONSTANT clk_period : time := 100ns;
SIGNAL  clk_i : std_logic := '0';
SIGNAL  rst_n_i : std_logic := '0';
SIGNAL  en_o   : std_logic := '0';

begin

  clock_process :process
   begin
		clk_i <= '0';
	wait for clk_period/2;
		clk_i <= '1';
	wait for clk_period/2;
  end process;
  reset_process :process
   begin  
		rst_n_i <= '0';
	wait for 1 us;
		rst_n_i <= '1';
	wait;
   end process;
   
   uut : baud9k6_e
   generic map(
    baudrate => baudrate
   )
   port map( 
    clk_i => clk_i,
    rst_n_i => rst_n_i,
    en_o => en_o
  );    
end Behavioral;
