LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm_controller_e IS
    GENERIC(
        number_byte     : integer := 10;
        number_sens     : integer := 3;
        baudrate        : integer := 1250;
        one_second      : integer := 12000000/2;
        ms_delay        : integer := 60;
        Xmax            : integer := 10
    );
    PORT (clk_i     : in  std_logic; -- 12MHz
          rst_n_i   : in  std_logic; -- active low
          sens_1_i  : in  std_logic; -- sensor 1
          sens_2_i  : in  std_logic; -- sensor 2
          sens_3_i  : in  std_logic; -- sensor 3
          cl_i      : in  std_logic; -- clear, active high.
          
          sdi_o     : out std_logic; 
          sdv_o     : out std_logic;
          stx_o     : out std_logic;
         
          txd_o     : out std_logic; -- uart transmision line
          txtled_o  : out std_logic; -- txt led 
          ledG_o    : out std_logic; -- go led
          ledR_o    : out std_logic; -- no go led
          ledV_o    : out std_logic  -- 1 second led
     );
END fsm_controller_e;


