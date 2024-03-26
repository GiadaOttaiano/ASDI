library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cuB is
    port(
        cuB_start : IN std_logic;
        cuB_clock, cuB_reset : IN std_logic;

        -- CONTATORE
        cuB_stop_count : IN std_logic_vector(3 downto 0);
        cuB_count_enable : OUT std_logic;

        -- ROM + MEM
        cuB_read_mem, cuB_write_mem : OUT std_logic;

        -- HANDSHAKE
        ACK : OUT std_logic;
        DATA_READY : IN std_logic;

        -- SOMMA
        cuB_sum : OUT std_logic
    );
end cuB;

architecture behavioral of cuB is
    type state is (IDLE, WAIT_DATA, SEND_ACK, OPERATION, WAIT_END, INCREMENT);
    signal current_state : state := IDLE;
    signal next_state : state;

    begin
        state_transition : process(cuB_clock)
            begin
                if(rising_edge(cuB_clock)) then
                    if(cuB_reset = '1') then
                        current_state <= IDLE;
                    else 
                        current_state <= next_state;
                    end if;
                end if;
            end process;

        fsm_B : process(current_state, cuB_start, DATA_READY, cuB_stop_count)
            begin
                case current_state
                    when IDLE =>
                        cuB_count_enable <= '0';
                        cuB_read_mem <= '0';
                        cuB_write_mem <= '0';
                        cuB_sum <= '0';
                        ACK <= '0';

                        if cuB_start = '1' then
                            next_state <= WAIT_DATA;
                        else 
                            next_state <= IDLE;
                        end if;
                    when WAIT_DATA =>
                        cuB_count_enable <= '0';
                        cuB_read_mem <= '1';
                
                        if DATA_READY = '1' then
                            next_state <= SEND_ACK;
                        else
                            next_state <= WAIT_DATA;
                        end if;    
                    when SEND_ACK => 
                        ACK <= '1';
                        cuB_sum <= '1';

                        next_state <= OPERATION;
                    when OPERATION => 
                        cuB_write_mem <= '1';

                        next_state <= WAIT_END;
                    when WAIT_END => 
                        if DATA_READY = '1' then
                            ACK <= '0';
                            cuB_sum <= '0';
                            cuB_read_mem <= '0';
                            next_state <= WAIT_END;
                        else
                            next_state <= INCREMENT;
                        end if;
                    when INCREMENT => 
                        cuB_count_enable <= '1';
                        cuB_write_mem <= '0';

                        if cuB_stop_count = "1111" then
                            next_state <= IDLE;
                        else
                            next_state <= WAIT_DATA;
                        end if;
                    end case;
                end process;
end behavioral;