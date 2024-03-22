library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_mod_N is
    generic(
        N : positive := 16;
        DEPTH : positive := 4   
    );
    port(
        c_clock, c_enable, c_reset : IN std_logic;
        c_output : OUT std_logic_vector(DEPTH - 1 downto 0)
    );
end counter_mod_N;

architecture behavioral of counter_mod_N is

    signal counter : std_logic_vector(DEPTH - 1 downto 0) := (others => '0');

    begin
        process(c_clock, c_reset)
        begin
            if c_reset = '1' then
                counter <= (others => '0');
            elsif rising_edge(c_clock) AND c_enable = '1' then 
                counter <= std_logic_vector(unsigned(counter) + 1);

                if counter = "1111" then
                    counter <= (others => '0');
                end if;
            end if;
        end process;

        c_output <= counter;

end behavioral;