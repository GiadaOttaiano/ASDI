library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity count_mod_8 is
    port(
        c_enable, c_clock, c_reset : IN std_logic;
        c_out : OUT std_logic_vector(2 downto 0);
        c_max : OUT std_logic
    );
end count_mod_8;

architecture behavioral of count_mod_8 is
    
    signal counter : std_logic_vector(2 downto 0) := (others => '0');

    begin
        process(c_clock, c_reset)
            begin
                if c_reset = '1' then
                    cu_max <= '0';
                    counter <= (others => '0');
                elsif rising_edge(c_clock) AND c_enable = '1' then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    if counter = "111" then
                        c_max <= '1';
                        counter <= (others => '0');
                    end if;
                end if;
            end process;

        c_out <= counter;

end behavioral