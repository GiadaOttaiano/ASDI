library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is

    port(
        cu_start, cu_clock, cu_stop, cu_control : IN STD_LOGIC;
        cu_read, cu_write, cu_enable, cu_reset : OUT STD_LOGIC
    );

end control_unit;

architecture behavioral of control_unit is

    type state is (IDLE, READING, RUNNING, WRITING, STOPPED);
    signal current_state : state := IDLE;
    signal next_state : state := IDLE;

    begin
        state_transition : process(cu_clock)
        begin
            if rising_edge(cu_clock) then
                current_state <= next_state;
            end if;
        end process;

        automa : process(state, cu_start, cu_stop, cu_control)
            begin
                case current_state is
                    when IDLE =>
                        cu_reset <= '0';

                        if cu_start = '1' then
                            next_state <= READING;
                            cu_read = '1';
                        else
                            next_state <= IDLE;
                        end if; 
                        
                    when READING =>
                        next_state <= RUNNING;
                        cu_read = '0';

                    when RUNNING =>
                        next_state <= WRITING;
                        cu_write <= '1';

                    when WRITING =>
                        next_state <= STOPPED;
                        cu_write <= '0';
                        cu_enable <= '1';
                
                    when STOPPED =>
                        cu_enable <= '0';

                        if cu_stop = '1' OR cu_control = '1' then
                            next_state <= IDLE;
                            cu_reset <= '1';
                        else
                            next_state <= READ;
                            cu_read <= '1';
                        end if;
                end case;
            end if;
        end process;
end behavioral;