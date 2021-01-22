ARCHITECTURE baud9k6_a OF baud9k6_e IS 
    SIGNAL count_s        : integer range baudrate - 1 downto 0;
    SIGNAL en_s           : std_logic := '0';
BEGIN

PROCESS(rst_n_i,clk_i)
BEGIN
 IF(rst_n_i = '0') THEN
    en_s    <= '0';
    count_s <=  0 ;
 ELSIF (rising_edge(clk_i))THEN 			
	IF(count_s >= baudrate - 1)THEN 
		en_s <= '1';
		count_s <= 0;
   	ELSE 
   		en_s <= '0';
		count_s <= count_s + 1;
    END IF;
 END IF;
END PROCESS;
 
en_o <= en_s; 

END baud9k6_a;