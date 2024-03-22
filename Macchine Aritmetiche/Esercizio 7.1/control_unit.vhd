library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CU is
    port(
        Q : IN std_logic_vector(1 downto 0);
        cu_clock, cu_start, cu_reset : IN std_logic;
        cu_count : IN std_logic_vector(2 downto 0);
        cu_loadAQ, cu_count_in, cu_shift, cu_loadM, cu_selAQ, cu_sub, cu_stop: OUT std_logic
    );
end CU;

architecture behavioral of CU is

    type state is (IDLE, FETCH, WAIT_F, SCAN, RSHIFT, INCREMENT, STOP);
    signal current_state, next_state : state;

    begin
        state_transition : process(cu_clock) --processo per effettuare il cambio di stato.
        begin
            if rising_edge(cu_clock) then
                if cu_reset = '1' then 
                    current_state <= IDLE;
                else 
                    current_state <= next_state;
                end if;
            end if;
        end process;

        main : process(current_state, cu_start, cu_count)
        begin
            cu_count_in <= '0';
            cu_sub <= '0';
            cu_selAQ <= '0';
            cu_loadAQ <= '0';  
            cu_loadM <= '0';   
            cu_stop <= '0';  
            cu_shift <= '0';

                case current_state is
                    when IDLE => 
                        if cu_start = '1' then
                            next_state <= FETCH;
                        else
                            next_state <= IDLE;
                        end if;
                    when FETCH => 
                        cu_loadM <= '1';
                        cu_loadAQ <= '1';

                        next_state <= WAIT_F;
                    when WAIT_F =>
                        next_state <= SCAN;
                    when SCAN => 
                        if(Q = "01") then  -- somma + shift.
                            cu_selAQ <= '1';
                            cu_loadAQ <= '1'; 
                            next_state <= RSHIFT;
                        elsif(Q = "10") then -- sottrazione + shift.
                            cu_sub <= '1';  
                            cu_selAQ <= '1';
                            cu_loadAQ <= '1'; 
                            next_state <= RSHIFT;
                        elsif (Q = "00" OR Q = "11") then -- shift.
                            next_state <= RSHIFT;
                        end if;
                    when RSHIFT =>
                        cu_shift <= '1';

                        if cu_count = "111" then
                            next_state <= STOP;
                        else
                            next_state <= INCREMENT;
                        end if;
                    when INCREMENT =>
                        cu_count_in <= '1';
                        next_state <= SCAN;
                    when STOP => 
                        cu_stop <= '1'; 
                        next_state <= IDLE;
                end case;
        end process;                          
end behavioral;