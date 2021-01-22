LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY baud9k6_e IS
    GENERIC(
        baudrate  : integer := 1250
    ); 
	PORT(clk_i    : in std_logic; -- 12MHz
	     rst_n_i  : in std_logic; -- active low
	     en_o     : out std_logic
    ); -- baudrate trigger
END baud9k6_e;







