library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit_B is
    port(
        cuB_start, cuB_reset, cuB_clock, cuB_send, cuB_max, cuB_stop : IN std_logic;
        cuB_TBE, cuB_RDA : IN std_logic;
        cuB_reset_count, cuB_RD, cuB_mem_wr, cuB_count_en, cuB_receive : OUT std_logic
    );
end control_unit_B;

architecture behavioral of control_unit_B is

    type state is (IDLE, WRITE, SEND);
    signal current_state : state := IDLE;
    signal next_state : state := IDLE;

    begin
        state_transition : process(cuB_clock)
        begin
            if rising_edge(cuB_clock) then
                if cuB_reset = '1' then
                    current_state <= IDLE;
                else 
                    current_state <= next_state;
                end if;
            end if;
        end process;

        FSM : process(current_state, cuB_reset_count, cuB_start, cuB_max)
            begin
                case current_state is
                    when IDLE =>
                        cuB_RD <= '0';
                        cuB_count_en <= '0';
                        cuB_mem_wr <= '0';
                        cuB_receive <= '0';

                        if cuB_start = '1' then
                            next_state <= WRITE;
                        else
                            next_state <= IDLE;
                        end if;
                    when WRITE =>
                        if cuB_send = '1' then
                            if cuB_RDA = '1' then
                                next_state <= SEND;
                            else
                                next_state <= WRITE;
                            end if;
                        else 
                            next_state <= WRITE;
                        end if;
                    when SEND =>
                        cuB_receive = '1';
                        cuB_RD <= '1';
                        cuB_count_en <= '1';
                        cuB_mem_wr <= '1';

                        if cuB_max = '1' then
                            cuB_stop <= '0';
                            next_state <= IDLE;
                        else 
                            next_state <= IDLE;
                        end if;
                end case;
            end process;

end behavioral;