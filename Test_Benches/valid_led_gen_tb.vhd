----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2021 09:28:07 PM
-- Design Name: 
-- Module Name: valid_led_gen_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity valid_led_gen_tb is
end valid_led_gen_tb;

architecture Behavioral of valid_led_gen_tb is
COMPONENT valid_led_gen_e IS
    GENERIC(
        one_second : integer := 12000000
    );
    PORT ( clk_i   : in  std_logic; -- 12MHz
           rst_n_i : in  std_logic; -- active low
           led_o   : out std_logic
     );
END COMPONENT;

CONSTANT one_second : integer := 100;
CONSTANT clk_period : time := 100ns;
SIGNAL  clk_i : std_logic := '0';
SIGNAL  rst_n_i : std_logic := '0';
SIGNAL  led_o   : std_logic := '0';

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
   
   uut : valid_led_gen_e
   generic map(
    one_second => one_second
   )
   port map( 
    clk_i => clk_i,
    rst_n_i => rst_n_i,
    led_o => led_o
  );    
end Behavioral;
