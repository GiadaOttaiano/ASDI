library IEEE;
use IEEE.std_logic_1164.all;

entity register_8 is
    port(
        reg_input : IN std_logic_vector(7 downto 0);
        reg_clock, reg_reset, reg_load : IN std_logic;
        reg_output : OUT std_logic_vector(7 downto 0)
    );
end register_8;

architecture behavioral of register_8 is

    signal temp : std_logic_vector(7 downto 0);

    begin
        process(reg_clock)
        begin
            if rising_edge(reg_clock) then
                if reg_reset = '1' then
                    temp <= (others => '0');
                else
                    if reg_load = '1' then
                        temp <= reg_input;
                    end if;
                end if;
            end if;
    end process;

    reg_output <= temp;

end behavioral;