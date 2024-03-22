library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_mod_16 is
    port(
        c_enable, c_clock, c_reset : IN STD_LOGIC;
        c_control : OUT STD_LOGIC;
        c_out : OUT STD_LOGIC_VECTOR(3 downto 0)
    );

end counter_mod_16;

architecture behavioral of counter_mod_16 is

    signal counter : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    begin
        process(c_clock, c_reset)
        begin
            if c_reset = '1' then
                counter <= (others => '0');
            elsif rising_edge(c_clock) and c_enable = '1' then
                if counter = "1111" then
                    counter <= (others => '0');
                    c_control <= '1';
                else
                    counter <= std_logic_vector(unsigned(counter) + 1);
                end if;
            end if;
        end process;

        c_out <= counter;

end behavioral;