library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity control_unit is

    port(
        cu_start, cu_clock, cu_stop, cu_control : IN STD_LOGIC;
        cu_read, cu_write, cu_enable, cu_reset : OUT STD_LOGIC
    );

end control_unit;

architecture behavioral of control_unit is

    type state is (IDLE, RUNNING, STOPPED);
    signal current_state : state := IDLE;
    signal next_state : state := IDLE;

    begin
        process(cu_clock)
        begin
            if rising_edge(cu_clock) then
                current_state <= next_state;

                case current_state is
                    when IDLE =>
                        if cu_start = '1' then
                            next_state <= RUNNING;
                        else
                            next_state <= IDLE;
                        end if;                   
                    when RUNNING =>
                        if cu_stop = '1' or cu_control = '1' then
                            next_state <= STOPPED;
                        else 
                            cu_enable <= '1';
                            cu_read <= '1';
                            cu_write <= '1';
                        end if;               
                    when STOPPED =>
                        next_state <= IDLE;
                        cu_reset <= '1';
                        cu_enable <= '0';
                        cu_read <= '0';
                        cu_write <= '0';
                    when OTHERS =>
                        NULL;
                end case;
            end if;
        end process;
end behavioral;