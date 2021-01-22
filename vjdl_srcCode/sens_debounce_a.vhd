ARCHITECTURE sens_debounce_a OF sens_debounce_e IS
    SIGNAL counter_s : integer range ms_delay downto 0;
    SIGNAl sens_s           : std_logic;
    TYPE state_type_t IS (idle, wait_time, hold_time);
    SIGNAL state_st : state_type_t;
BEGIN

PROCESS(clk_i, rst_n_i) 
BEGIN
    IF(rst_n_i = '0')THEN
        state_st  <= idle;           
        counter_s <= 0;
        sens_s    <= '0';  
    ELSIF(rising_edge(clk_i))THEN
        CASE state_st IS
            WHEN idle =>    
                IF(p_b_i = '1')THEN
                    state_st <= wait_time;
                ELSE 
                    state_st <= idle;
                END IF;
                sens_s  <= '0';
            WHEN wait_time =>
                IF(counter_s = ms_delay - 1)THEN
                    counter_s <= 0;
                    IF(p_b_i = '1')THEN
                        sens_s   <= '1';
                        state_st <= hold_time; 
                    END IF;
                ELSE
                    counter_s <= counter_s + 1;
                END IF;
           WHEN hold_time =>
                IF(counter_s = ms_delay - 1)THEN 
                    counter_s <= 0;
                    IF(p_b_i = '0')THEN
                        state_st <= idle;
                    END IF;
                ELSE
                    counter_s <= counter_s + 1;
                END IF;                    
          END CASE;       
    END IF;
 END PROCESS;
  
  sens_o <= sens_s;

END sens_debounce_a;
