library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_mod_8 is
    port(
        c_in, c_clock, c_reset : IN std_logic;
        c_out : out std_logic_vector(2 downto 0)
    );
end counter_mod_8;

architecture behavioral of counter_mod_8 is

    signal count : std_logic_vector(2 downto 0) := (others => '0');

    begin
        process(c_clock)
        begin  
            if rising_edge(c_clock) then
                if c_reset = '1' then
                    count <= (others => '0');
                else
                    if c_in = '1' then
                        count <= std_logic_vector(unsigned(count) + 1);
                    end if;
                end if;
            end if;
        end process;

        c_out <= count;

end behavioral;