

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sens_debounce_tb is
end sens_debounce_tb;

architecture Behavioral of sens_debounce_tb is
COMPONENT sens_debounce_e IS
  GENERIC(
    ms_delay    : integer := 60
  );
  PORT (clk_i   : in  std_logic; 
        rst_n_i : in  std_logic; 
        p_b_i   : in  std_logic;
        sens_o  : out std_logic 
   );
END COMPONENT;

CONSTANT ms_delay : integer := 60;
CONSTANT clk_period : time := 100ns;
SIGNAL  clk_i : std_logic := '0';
SIGNAL  rst_n_i : std_logic := '0';
SIGNAL  p_b_i_1   : std_logic := '0';
SIgnal sens_o_1  : std_logic := '0';
SIgnal sens_o_2  : std_logic := '0';
SIGNAL  p_b_i_2   : std_logic := '0';
SIgnal sens_o_3  : std_logic := '0';
SIGNAL  p_b_i_3   : std_logic := '0';
signal sensor_reg : std_logic_vector (2 downto 0) := "000";

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
   
   uut : sens_debounce_e
   generic map(
    ms_delay => ms_delay
   )
   port map( 
    clk_i => clk_i,
    rst_n_i => rst_n_i,
    p_b_i => p_b_i_1,
    sens_o => sens_o_1
  );   
  
     uut1 : sens_debounce_e
   generic map(
    ms_delay => ms_delay
   )
   port map( 
    clk_i => clk_i,
    rst_n_i => rst_n_i,
    p_b_i => p_b_i_2,
    sens_o => sens_o_2
  );    
     uut2 : sens_debounce_e
   generic map(
    ms_delay => ms_delay
   )
   port map( 
    clk_i => clk_i,
    rst_n_i => rst_n_i,
    p_b_i => p_b_i_3,
    sens_o => sens_o_3
  );
    p_b_i_1 <= sensor_reg(0);
    p_b_i_2 <= sensor_reg(1);
    p_b_i_3 <= sensor_reg(2);   
    
        sens_process : process
    begin
        loop
        for i in 0 to 30 loop
           sensor_reg <= "000";
           wait for 10 us;
           sensor_reg <= "100";
           wait for 10 us;
           sensor_reg <= "010";
           wait for 10 us;
           sensor_reg <= "001";
           wait for 10 us;        
        end loop;
        for i in 0 to 20 loop
           sensor_reg <= "000";
           wait for 10 us;
           sensor_reg <= "001";
           wait for 10 us;
           sensor_reg <= "010";
           wait for 10 us;
           sensor_reg <= "100";
           wait for 10 us;        
        end loop;
        end loop;
  end process;        
end Behavioral;
