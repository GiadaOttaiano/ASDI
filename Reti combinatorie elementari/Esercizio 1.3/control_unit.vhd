library IEEE;
use IEEE.std_logic_1164.ALL;

entity control_unit is

    port(
        switch_in : in std_logic_vector(7 downto 0);
        buttons : in std_logic_vector(1 downto 0);
        switch_out : out std_logic_vector(15 downto 0)
    );

end control_unit;

architecture behavioral of control_unit is

    signal temp : std_logic_vector(15 downto 0) := (others => '0');

    begin
        process(switch_in, buttons)
            if buttons(0) = '1' then
                temp(7 downto 0) <= switch_in;
            elsif buttons(1) = '1' then
                temp(15 downto 8) <= switch_in;
            end if;
        end process;

    switch_out <= temp;

end behavioral;