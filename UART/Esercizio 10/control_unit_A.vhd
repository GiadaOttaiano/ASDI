library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit_A is
    port(
        cuA_start, cuA_reset, cuA_receive, cuA_clock, cuA_max, cuA_stop : IN std_logic;
        cuA_TBE : IN std_logic;
        cuA_reset_count, cuA_WR, cuA_rom_rd, cuA_count_en, cuA_send : OUT std_logic
    );
end control_unit_A;

architecture behavioral of control_unit_A is

    type state is (IDLE, READ, SEND);
    signal current_state : state := IDLE;
    signal next_state : state := IDLE;

    begin
        state_transition : process(cuA_clock)
        begin
            if rising_edge(cuA_clock) then
                if cuA_reset = '1' then
                    current_state <= IDLE;
                else 
                    current_state <= next_state;
                end if;
            end if;
        end process;

        FSM : process(current_state, cuA_reset_count, cuA_start, cuA_receive, cuA_max)
            begin
                case current_state is
                    when IDLE =>
                        cuA_rom_rd <= '0';
                        cuA_count_en <= '0';
                        cuA_send <= '0';
                        cuA_reset_count <= '0';

                        if cuA_start = '1' then
                            cuA_WR <= '1';
                            next_state <= READ;
                        end if;
                    when READ =>
                        cuA_rom_rd <= '1';

                        if cuA_TBE = '1' then
                            cuA_WR <= '0';
                            cuA_send <= '1';
                            next_state <= SEND;
                        else 
                            next_state <= READ;
                        end if;
                    when SEND =>
                        cuA_rom_rd <= '0';
                        
                        if cuA_receive = '1' then
                            cuA_count_en <= '1';
                            if cuA_max ='1' then
                                cuA_stop <= '1';
                                cuA_reset_count <= '1';
                                next_state <= IDLE;
                            else 
                                next_state <= IDLE;
                            end if;
                        end if;
                end case;
            end process;

end behavioral;