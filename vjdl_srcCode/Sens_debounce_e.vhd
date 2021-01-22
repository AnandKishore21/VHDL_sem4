LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY sens_debounce_e IS
  GENERIC(
    ms_delay    : integer := 60
  );
  PORT (clk_i   : in  std_logic; 
        rst_n_i : in  std_logic; 
        p_b_i   : in  std_logic;
        sens_o  : out std_logic 
   );
END sens_debounce_e;

