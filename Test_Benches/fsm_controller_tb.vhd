----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2020 10:05:27 PM
-- Design Name: 
-- Module Name: fsm_controller_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_controller_tb is
end fsm_controller_tb;

architecture Behavioral of fsm_controller_tb is
component fsm_controller_e is
    GENERIC(
        number_byte     : integer := 10;
        number_sens     : integer := 3;
        baudrate        : integer := 1250;
        one_second      : integer := 12000000;
        ms_delay        : integer := 60;
        Xmax            : integer := 30
    );
    PORT (clk_i     : in  std_logic; -- 12MHz
          rst_n_i   : in  std_logic; -- active low
          sens_1_i  : in  std_logic; -- sensor 1
          sens_2_i  : in  std_logic; -- sensor 2
          sens_3_i  : in  std_logic; -- sensor 3
          cl_i      : in  std_logic; -- clear, active high.
          -- rs232 interface
          sdi_o     : out std_logic; 
          sdv_o     : out std_logic;
          stx_o     : out std_logic;
          -- UART Out
          txd_o     : out std_logic; -- uart transmision line
          txtled_o  : out std_logic; -- txt led 
          ledG_o    : out std_logic; -- go led
          ledR_o    : out std_logic; -- no go led
          ledV_o    : out std_logic  -- 1 second led
     );
end component;
    constant    number_byte     : integer := 10;
  constant      number_sens     : integer := 3;
   constant     baudrate        : integer := 1250;
  constant      one_second      : integer := 12000000;
  constant      ms_delay        : integer := 60;
  constant     Xmax            : integer := 30;
constant clk_period : time := 100ns;
signal rst_n_i : std_logic := '0';
signal clk_i : std_logic :=  '0';
signal sens_1_i : std_logic := '0';
signal sens_2_i : std_logic := '0';
signal sens_3_i : std_logic := '0';
signal cl_i : std_logic := '0';
signal sdi_o : std_logic := '0';
signal sdv_o : std_logic := '0';
signal stx_o : std_logic := '0';
signal txd_o : std_logic := '0';
signal txtled_o : std_logic := '0';
signal ledG_o : std_logic := '0';
signal ledR_o : std_logic := '0';
signal ledV_o : std_logic := '0';
signal sensor_reg : std_logic_vector (2 downto 0) := "000";

begin
    uut: fsm_controller_e
    generic map (
        number_byte     => number_byte,
        number_sens      => number_sens,
        baudrate         => baudrate,
        one_second       => one_second,
        ms_delay         => ms_delay,
        Xmax            => Xmax
    )
    Port map (clk_i => clk_i,
          rst_n_i     => rst_n_i,
          sens_1_i   => sens_1_i,
          sens_2_i   => sens_2_i,
          sens_3_i   => sens_3_i,
          cl_i     => cl_i,
          -- rs232 interface
          sdi_o   => sdi_o,  
          sdv_o   => sdv_o,
          stx_o   => stx_o,
          -- UART Out
          txd_o    => txd_o,
          txtled_o => txtled_o,
          ledG_o   => ledG_o,
          ledR_o   => ledR_o,
          ledV_o   => ledV_o
     );
     
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

  clear_process :process
    begin
	   cl_i <= '1';
	wait for 1.5 us;
	   cl_i <= '0';
	wait for 20 us;
	   cl_i  <= '1';
	wait for 200 us;
	   cl_i  <= '0';
	wait; 
    end process;
    
    sens_1_i <= sensor_reg(2);
    sens_2_i <= sensor_reg(1);
    sens_3_i <= sensor_reg(0);
    
    sens_process : process
    begin
        loop
        for i in 0 to 30 loop
           sensor_reg <= "000";
           wait for 10 us;
           wait for 1.3 ms;   
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
           wait for 1.3 ms;    
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
