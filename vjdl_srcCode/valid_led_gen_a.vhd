ARCHITECTURE valid_led_gen_a OF valid_led_gen_e IS
    SIGNAL counter_s : integer range one_second - 1 downto 0;
    SIGNAL led_s     : std_logic ;
BEGIN
    
  PROCESS(rst_n_i,clk_i)
    BEGIN
    IF(rst_n_i =  '0')then
        counter_s <= 0;
        led_s     <= '0';
    ELSIF(rising_edge(clk_i))THEN
        IF(counter_s >= one_second - 1)THEN
            counter_s <= 0;
            led_s <= not led_s;
        ELSE
            counter_s <= counter_s + 1;
        END IF;
    END IF;
  END PROCESS;
  
  led_o <= led_s;
   
END valid_led_gen_a;         