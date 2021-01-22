LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY valid_led_gen_e IS
    GENERIC(
        one_second : integer := 12000000/2
    );
    PORT ( clk_i   : in  std_logic; -- 12MHz
           rst_n_i : in  std_logic; -- active low
           led_o   : out std_logic
     );
END valid_led_gen_e;


