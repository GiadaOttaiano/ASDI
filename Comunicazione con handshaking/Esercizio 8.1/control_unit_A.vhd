library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cuA is
    port(
        cuA_start : IN std_logic;
        cuA_clock, cuA_reset : IN std_logic;

        -- CONTATORE
        cuA_stop_count : IN std_logic_vector(3 downto 0);
        cuA_count_enable : OUT std_logic;

        -- MEM
        cuA_read_mem : OUT std_logic;

        -- HANDSHAKE
        ACK : IN std_logic;
        DATA_READY : OUT std_logic
    );
end cuA;

architecture behavioral of cuA is

    type state is (IDLE, READ, WAIT_ACK, WAIT_OP, INCREMENT);
    signal current_state : state := IDLE;
    signal next_state : state;

    begin
        state_transition : process(cuA_clock)
            begin
                if(rising_edge(cuA_clock)) then
                    if(cuA_reset = '1') then
                        current_state <= IDLE;
                    else 
                        current_state <= next_state;
                    end if;
                end if;
            end process;

        fsm_A : process(current_state, cuA_start, ACK, cuA_stop_count)
            begin
                case current_state is
                    when IDLE => 
                        cuA_count_enable <= '0';
                        cuA_read_mem <= '0';
                        DATA_READY <= '0';

                        if cuA_start = '1' then
                            next_state <= READ;
                        else 
                            next_state <= IDLE;
                        end if;
                    when READ =>
                        cuA_count_enable <= '0';
                        cuA_read_mem <= '1';
                        DATA_READY <= '1';

                        next_state <= WAIT_ACK;
                    when WAIT_ACK =>
                        cuA_read_mem <= '0';

                        if ACK = '1' then
                            DATA_READY <= '0';
                            next_state <= WAIT_OP;
                        else
                            next_state <= WAIT_ACK;
                        end if;
                    when WAIT_OP =>
                        if ACK = '0' then
                            next_state <= INCREMENT;
                        else
                            next_state <= WAIT_OP;
                        end if;
                    when INCREMENT =>
                        cuA_count_enable <= '1';

                        if cuA_stop_count = "1111" then
                            next_state <= IDLE;
                        else
                            next_state <= READ;
                        end if;
                end case;
            end process;
end behavioral;